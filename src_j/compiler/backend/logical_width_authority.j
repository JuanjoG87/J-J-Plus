// Host-independent logical-width authority. Target pointer/usize width is not
// reused as file/source/object offset width. Large logical domains are consumed
// through bounded segments and retain stable integer IDs instead of pointers.
extern fn jj_target_profile_validate(p0:*i64,p1:i64)->i64;
fn jj_logical_domain_bits(profile:*i64,slots:i64,domain:i64)->i64{
 if jj_target_profile_validate(profile,slots)==0{return 0;}if domain==1{return 32;}if domain==2{return 32;}if domain==3{return 64;}if domain==4{return 64;}if domain==5{return profile[4];}if domain==6{return profile[4];}if domain==7{return profile[26];}if domain==8{return profile[27];}if domain==9{return profile[28];}if domain==10{return profile[29];}if domain==11{return profile[29];}return 0;
}
fn jj_logical_domain_signed(domain:i64)->i64{if domain==2{return 1;}if domain==4{return 1;}if domain==6{return 1;}if domain>=1{if domain<=11{return 0;}}return 0-1;}
fn jj_logical_domain_storage_bytes(profile:*i64,slots:i64,domain:i64)->i64{var bits:i64=jj_logical_domain_bits(profile,slots,domain);if bits<=0{return 0;}return (bits+7)/8;}
fn jj_logical_segment_seal(segment:*i64,slots:i64)->i64{if segment==0{return 0;}if slots!=6{return 0;}var h:i64=0x4a4a4c4f47534547;var i:i64=0;while i<5{h=((h<<11)|(h>>>53))^segment[i]^(i*0x9e3779b1);i=i+1;}return h;}
fn jj_logical_segment(total:i64,cursor:i64,preferred:i64,segment:*i64,slots:i64)->i64{
 if segment==0{return 0;}if slots!=6{return 0;}var i:i64=0;while i<6{segment[i]=0;i=i+1;}if total<0{return 0;}if cursor<0{return 0;}if cursor>total{return 0;}if preferred<=0{return 0;}if preferred>0x7fffffff{return 0;}var remaining:i64=total-cursor;var bytes:i64=remaining;if bytes>preferred{bytes=preferred;}segment[0]=cursor;segment[1]=bytes;segment[2]=cursor+bytes;segment[3]=total;if segment[2]==total{segment[4]=1;}segment[5]=jj_logical_segment_seal(segment,slots);if segment[5]==0{return 0;}return 1;
}
fn jj_logical_segment_validate(segment:*i64,slots:i64)->i64{if segment==0{return 0;}if slots!=6{return 0;}if segment[0]<0{return 0;}if segment[1]<0{return 0;}if segment[1]>0x7fffffff{return 0;}if segment[2]<segment[0]{return 0;}if segment[2]-segment[0]!=segment[1]{return 0;}if segment[3]<segment[2]{return 0;}if segment[4]<0{return 0;}if segment[4]>1{return 0;}if segment[4]==1{if segment[2]!=segment[3]{return 0;}}else{if segment[2]>=segment[3]{return 0;}}if segment[5]==0{return 0;}if segment[5]!=jj_logical_segment_seal(segment,slots){return 0;}return 1;}
fn jj_logical_window_delta(profile:*i64,profile_slots:i64,segment:*i64,segment_slots:i64,logical_offset:i64)->i64{
 if jj_target_profile_validate(profile,profile_slots)==0{return 0-1;}if jj_logical_segment_validate(segment,segment_slots)==0{return 0-1;}if logical_offset<segment[0]{return 0-1;}if logical_offset>=segment[2]{return 0-1;}var delta:i64=logical_offset-segment[0];if profile[4]==32{if delta>0xffffffff{return 0-1;}}return delta;
}
fn jj_logical_width_resource_contract(out:*i64,slots:i64)->i64{if out==0{return 0;}if slots!=8{return 0;}out[0]=48;out[1]=48;out[2]=48;out[3]=1;out[4]=0;out[5]=1;out[6]=1;out[7]=(out as i64)^0x4a4a4c4f47524331;return 1;}
