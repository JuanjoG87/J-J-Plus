// jj_file: src_j/compiler/backend/branch_probability_fact.j
// R763 sealed branch-probability facts. No source-layout guessing is admitted.
// Record (8 qwords): magic, version, evidence kind, true count, false count,
// class (0 unknown, 1 balanced, 2 true-likely, 3 false-likely), confidence, seal.
fn jj_bpf_class_for_counts(t:i64,f:i64)->i64{
 if t<0{return 0-1;}if f<0{return 0-1;}var total:i64=t+f;if total<=0{return 0;}if total<32{return 0;}
 if t*8>=total*7{return 2;}if f*8>=total*7{return 3;}return 1;
}
fn jj_bpf_seal(r:*i64)->i64{if r==0{return 0;}var h:i64=0x4a4a425046414354;var i:i64=0;while i<7{h=((h<<9)|(h>>>55))^r[i]^(i*0x9e37);i=i+1;}if h==0{h=1;}return h;}
fn jj_branch_probability_valid(r:*i64)->i64{
 if r==0{return 0;}if r[0]!=0x4a4a425046414354{return 0;}if r[1]!=1{return 0;}if r[2]<0{return 0;}if r[2]>1{return 0;}if r[3]<0{return 0;}if r[4]<0{return 0;}if r[5]<0{return 0;}if r[5]>3{return 0;}if r[6]<0{return 0;}if r[6]>255{return 0;}
 if r[2]==0{if r[3]!=0{return 0;}if r[4]!=0{return 0;}if r[5]!=0{return 0;}if r[6]!=0{return 0;}}
 else{var total:i64=r[3]+r[4];if total<=0{return 0;}if r[5]!=jj_bpf_class_for_counts(r[3],r[4]){return 0;}var conf:i64=total;if conf>255{conf=255;}if r[6]!=conf{return 0;}}
 if r[7]!=jj_bpf_seal(r){return 0;}return 1;
}
fn jj_branch_probability_unknown(r:*i64,slots:i64)->i64{if r==0{return 0;}if slots!=8{return 0;}r[0]=0x4a4a425046414354;r[1]=1;r[2]=0;r[3]=0;r[4]=0;r[5]=0;r[6]=0;r[7]=jj_bpf_seal(r);return r[7]!=0;}
// packed: low 32 bits true count, high 32 bits false count.
fn jj_branch_probability_measured(r:*i64,packed:i64)->i64{if r==0{return 0;}var t:i64=packed&0xffffffff;var f:i64=(packed>>>32)&0xffffffff;var total:i64=t+f;if total<=0{return 0;}r[0]=0x4a4a425046414354;r[1]=1;r[2]=1;r[3]=t;r[4]=f;r[5]=jj_bpf_class_for_counts(t,f);r[6]=total;if r[6]>255{r[6]=255;}r[7]=jj_bpf_seal(r);return jj_branch_probability_valid(r);}
// Cost flags preserve R762 layout: bit24 predictable, bits28..29 direction.
// Direction 1 means true-likely, 2 false-likely, 3 measured-balanced.
fn jj_branch_probability_cost_bits(r:*i64)->i64{if jj_branch_probability_valid(r)==0{return 0;}if r[5]==2{return (1<<24)|(1<<28);}if r[5]==3{return (1<<24)|(2<<28);}if r[5]==1{return 3<<28;}return 0;}
fn jj_branch_probability_resource_contract(out:*i64,slots:i64)->i64{if out==0{return 0;}if slots!=8{return 0;}out[0]=8;out[1]=2;out[2]=0;out[3]=0;out[4]=0;out[5]=0;out[6]=1;out[7]=(out as i64)^0x4a4a425046524553;return 1;}
