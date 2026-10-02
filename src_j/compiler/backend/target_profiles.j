fn jj_target_manifest_kind(s:*i8,n:i64)->i64{
 if s==0{return 0;}if n<31{return 0;}
 if s[0]!=74{return 0;}if s[1]!=74{return 0;}if s[2]!=84{return 0;}if s[3]!=65{return 0;}if s[4]!=82{return 0;}if s[5]!=71{return 0;}if s[6]!=69{return 0;}if s[7]!=84{return 0;}if s[8]!=49{return 0;}if s[9]!=10{return 0;}
 if s[10]!=116{return 0;}if s[11]!=97{return 0;}if s[12]!=114{return 0;}if s[13]!=103{return 0;}if s[14]!=101{return 0;}if s[15]!=116{return 0;}if s[16]!=61{return 0;}
 if s[17]==97{
  if s[18]==97{if s[19]!=114{return 0;}if s[20]!=99{return 0;}if s[21]!=104{return 0;}if s[22]!=54{return 0;}if s[23]!=52{return 0;}if s[24]!=10{return 0;}return 1;}
  if s[18]==114{if s[19]!=109{return 0;}if s[20]!=51{return 0;}if s[21]!=50{return 0;}if s[22]!=10{return 0;}return 2;}
  return 0;
 }
 if s[17]==105{if s[18]!=51{return 0;}if s[19]!=56{return 0;}if s[20]!=54{return 0;}if s[21]!=10{return 0;}return 3;}
 if s[17]==114{
  if s[18]!=105{return 0;}if s[19]!=115{return 0;}if s[20]!=99{return 0;}if s[21]!=118{return 0;}
  if s[22]==54{if s[23]!=52{return 0;}if s[24]!=10{return 0;}return 4;}
  if s[22]==51{if s[23]!=50{return 0;}if s[24]!=10{return 0;}return 5;}
 }
 return 0;
}
fn jj_target_return_value(s:*i8,n:i64,k:i64)->i64{if s==0{return 0-1;}var o:i64=0;if k==1{o=25;}else{if k==2{o=23;}else{if k==3{o=22;}else{if k==4{o=25;}else{if k==5{o=25;}else{return 0-1;}}}}}if n<o+8{return 0-1;}if s[o]!=114{return 0-1;}if s[o+1]!=101{return 0-1;}if s[o+2]!=116{return 0-1;}if s[o+3]!=117{return 0-1;}if s[o+4]!=114{return 0-1;}if s[o+5]!=110{return 0-1;}if s[o+6]!=61{return 0-1;}var p:i64=o+7;var v:i64=0;var d:i64=0;while p<n{var c:i64=s[p];if c==10{p=p+1;break;}if c<48{return 0-1;}if c>57{return 0-1;}v=v*10+c-48;d=d+1;if v>65535{return 0-1;}p=p+1;}if d==0{return 0-1;}if p!=n{return 0-1;}if k==2{if v>255{return 0-1;}}return v;}
fn jj_target_reserved_prefix_at(s:*i8,n:i64,start:i64)->i64{
 if s==0{return 0;}if start<0{return 0;}if n<start+6{return 0;}
 if s[start]!=47{return 0;}if s[start+1]!=47{return 0;}if s[start+2]!=32{return 0;}if s[start+3]!=106{return 0;}if s[start+4]!=106{return 0;}if s[start+5]!=95{return 0;}return 1;
}
fn jj_target_file_annotation_end_at(s:*i8,n:i64,start:i64)->i64{
 if s==0{return 0-1;}if start<0{return 0-1;}if n<start+16{return 0-1;}
 if s[start]!=47{return 0-1;}if s[start+1]!=47{return 0-1;}if s[start+2]!=32{return 0-1;}if s[start+3]!=106{return 0-1;}if s[start+4]!=106{return 0-1;}if s[start+5]!=95{return 0-1;}if s[start+6]!=102{return 0-1;}if s[start+7]!=105{return 0-1;}if s[start+8]!=108{return 0-1;}if s[start+9]!=101{return 0-1;}if s[start+10]!=58{return 0-1;}if s[start+11]!=32{return 0-1;}
 var i:i64=start+12;var segment:i64=i;while i<n{var c:i64=s[i];if c==10{var tail:i64=i-segment;if tail<3{return 0-1;}if s[i-2]!=46{return 0-1;}if s[i-1]!=106{return 0-1;}return i+1;}var valid:i64=0;if c>=48{if c<=57{valid=1;}}if c>=65{if c<=90{valid=1;}}if c>=97{if c<=122{valid=1;}}if c==95{valid=1;}if c==45{valid=1;}if c==46{valid=1;}if c==47{valid=1;}if valid==0{return 0-1;}if c==47{var length:i64=i-segment;if length<=0{return 0-1;}if length==1{if s[segment]==46{return 0-1;}}if length==2{if s[segment]==46{if s[segment+1]==46{return 0-1;}}}segment=i+1;}i=i+1;}return 0-1;
}
fn jj_target_file_annotation_valid(s:*i8,n:i64)->i64{
 if s==0{return 0;}if n<16{return 0;}
 if s[0]!=47{return 0;}if s[1]!=47{return 0;}if s[2]!=32{return 0;}if s[3]!=106{return 0;}if s[4]!=106{return 0;}if s[5]!=95{return 0;}if s[6]!=102{return 0;}if s[7]!=105{return 0;}if s[8]!=108{return 0;}if s[9]!=101{return 0;}if s[10]!=58{return 0;}if s[11]!=32{return 0;}
 var i:i64=12;var segment:i64=12;var line_end:i64=0-1;while i<n{var c:i64=s[i];if c==10{line_end=i;i=n;}else{var valid:i64=0;if c>=48{if c<=57{valid=1;}}if c>=65{if c<=90{valid=1;}}if c>=97{if c<=122{valid=1;}}if c==95{valid=1;}if c==45{valid=1;}if c==46{valid=1;}if c==47{valid=1;}if valid==0{return 0;}if c==47{var length:i64=i-segment;if length<=0{return 0;}if length==1{if s[segment]==46{return 0;}}if length==2{if s[segment]==46{if s[segment+1]==46{return 0;}}}segment=i+1;}i=i+1;}}
 if line_end<0{return 0;}var tail:i64=line_end-segment;if tail<3{return 0;}if tail==1{if s[segment]==46{return 0;}}if tail==2{if s[segment]==46{if s[segment+1]==46{return 0;}}}if s[line_end-2]!=46{return 0;}if s[line_end-1]!=106{return 0;}if line_end+6<=n{if jj_target_reserved_prefix_at(s,n,line_end+1)!=0{return 0;}}return 1;
}
fn jj_target_source_kind(s:*i8,n:i64)->i64{
 if s==0{return 0;}if n<=0{return 0;}
 if jj_target_reserved_prefix_at(s,n,0)==0{return 5;}
 if n>=11{if s[6]==102{if s[7]==105{if s[8]==108{if s[9]==101{if s[10]==58{if jj_target_file_annotation_valid(s,n)!=0{return 5;}return 0;}}}}}}
 if n<14{return 0;}if s[6]!=116{return 0;}if s[7]!=97{return 0;}if s[8]!=114{return 0;}if s[9]!=103{return 0;}if s[10]!=101{return 0;}if s[11]!=116{return 0;}if s[12]!=58{return 0;}if s[13]!=32{return 0;}
 if n>=22{if s[14]==97{if s[15]==97{if s[16]==114{if s[17]==99{if s[18]==104{if s[19]==54{if s[20]==52{if s[21]==10{return 6;}}}}}}}}}
 if n>=20{if s[14]==97{if s[15]==114{if s[16]==109{if s[17]==51{if s[18]==50{if s[19]==10{return 7;}}}}}}}
 if n>=21{if s[14]==120{if s[15]==56{if s[16]==54{if s[17]==95{if s[18]==54{if s[19]==52{if s[20]==10{if jj_target_reserved_prefix_at(s,n,21)!=0{return 0;}return 5;}}}}}}}}
 if n>=19{if s[14]==105{if s[15]==51{if s[16]==56{if s[17]==54{if s[18]==10{return 8;}}}}}}
 if n>=22{if s[14]==114{if s[15]==105{if s[16]==115{if s[17]==99{if s[18]==118{if s[19]==54{if s[20]==52{if s[21]==10{return 9;}}}if s[19]==51{if s[20]==50{if s[21]==10{return 10;}}}}}}}}}
 return 0;
}

fn jj_target_output_kind(s:*i8,n:i64,k:i64)->i64{
 if s==0{return 0;}if n<=0{return 0;}if k<5{return 0;}if k>10{return 0;}
 var start:i64=0;if k==5{start=21;}else{if k==6{start=22;}else{if k==7{start=20;}else{if k==8{start=19;}else{if k==9{start=22;}else{if k==10{start=22;}else{return 0;}}}}}}
 if n<start{return 0;}var file_end:i64=jj_target_file_annotation_end_at(s,n,start);if file_end>=0{start=file_end;}if n<start{return 0;}if jj_target_reserved_prefix_at(s,n,start)==0{return 1;}if n<start+25{return 0;}
 var m:[25]i64;m[0]=47;m[1]=47;m[2]=32;m[3]=106;m[4]=106;m[5]=95;m[6]=111;m[7]=117;m[8]=116;m[9]=112;m[10]=117;m[11]=116;m[12]=58;m[13]=32;m[14]=101;m[15]=120;m[16]=101;m[17]=99;m[18]=117;m[19]=116;m[20]=97;m[21]=98;m[22]=108;m[23]=101;m[24]=10;
 var i:i64=0;while i<25{if s[start+i]!=m[i]{return 0;}i=i+1;}if k==5{return 0;}return 2;
}
fn jj_target_pointer_bits(k:i64)->i64{if k==5{return 64;}if k==6{return 64;}if k==7{return 32;}if k==8{return 32;}if k==9{return 64;}if k==10{return 32;}return 0;}
fn jj_target_stack_alignment(k:i64)->i64{if k==5{return 16;}if k==6{return 16;}if k==7{return 8;}if k==8{return 4;}if k==9{return 16;}if k==10{return 16;}return 0;}
fn jj_target_profile_version(k:i64)->i64{if k>=5{if k<=10{return 3;}}return 0;}
fn jj_target_value_bits(k:i64,t:i64)->i64{var w:i64=jj_target_pointer_bits(k);if w==0{return 0;}if t==252{return 8;}if t==254{return 32;}if t==255{return 64;}if t==5{return 64;}if t==8{return 32;}if t==2{return w;}if t==3{return w;}if t==6{return w;}if t==9{return w;}if t>=200{if t<=203{return w;}}return 0;}
fn jj_target_value_parts(k:i64,t:i64)->i64{var w:i64=jj_target_pointer_bits(k);var b:i64=jj_target_value_bits(k,t);if w==0{return 0;}if b==0{return 0;}return (b+w-1)/w;}
fn jj_target_signature_type(c:i64)->i64{if c==13{return 252;}if c==14{return 254;}if c==2{return 255;}if c==4{return 5;}if c==7{return 8;}if c==3{return 2;}if c==5{return 3;}if c==6{return 6;}if c==8{return 9;}if c>=9{if c<=12{return 200+c-9;}}return 0;}
fn jj_target_fast_location_count(k:i64)->i64{if k==5{return 4;}if k==6{return 7;}if k==9{return 8;}if k==10{return 8;}return 0;}
fn jj_target_parallel_group_limit(k:i64)->i64{if k==5{return 4096;}if k==6{return 4096;}if k==7{return 2048;}if k==9{return 4096;}if k==10{return 2048;}return 0;}
fn jj_target_profile_seal(k:i64)->i64{var v:i64=jj_target_profile_version(k);if v==0{return 0;}var p:i64=jj_target_pointer_bits(k);var a:i64=jj_target_stack_alignment(k);var f:i64=jj_target_fast_location_count(k);var op:i64=0;if k<=10{op=1;}var native:i64=0;var parts:i64=2;if p==64{native=1;parts=1;}var groups:i64=jj_target_parallel_group_limit(k);return k^(v<<8)^(p<<16)^(a<<24)^(f<<32)^(groups<<40)^(op<<56)^(native<<57)^(parts<<58)^0x4a4a5450524f4633;}
fn jj_target_physical_part_location(k:i64,l:i64,n:i64,t:i64,part:i64)->i64{if n<0{return 0-1;}var w:i64=jj_target_pointer_bits(k);if w==0{return 0-1;}var b:i64=jj_target_value_bits(k,t);if b==0{return 0-1;}var q:i64=(b+w-1)/w;if part<0{return 0-1;}if part>=q{return 0-1;}if l==1{var f:i64=jj_target_fast_location_count(k);if q>1{if n%q!=0{return 0-1;}}if n>f-q{return 0-1;}if k==5{return n+part+8;}if k==6{return n+part+9;}if k==9{return n+part+10;}if k==10{return n+part+10;}return 0-1;}if l==2{if n>0x0fffffff/8{return 0-1;}var x:i64=part*(w/8);if x>8-w/8{return 0-1;}return n*8+x;}return 0-1;}
fn jj_target_physical_location(k:i64,l:i64,n:i64,t:i64)->i64{var x:i64=jj_target_physical_part_location(k,l,n,t,0);if x<0{return x;}if jj_target_pointer_bits(k)==32{if t==5{return 0-1;}if t==255{return 0-1;}}return x;}
