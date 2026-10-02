// jj_file: src_j/compiler/backend/coldtail_transaction_v1.j
// ColdTailTransaction v1. Seals only immutable planning intent. Result fields
// written by apply stages are excluded explicitly; module publication remains
// the rollback authority if commit fails.
fn jj_cttxn_mix(h:i64,v:i64)->i64{
  var x:i64=h^v;x=x^(x>>>29);x=x*0x100000001b3;x=x^(x>>>31);return x;
}
fn jj_cttxn_digest(workspace:*i64,words:i64,loop_count:i64)->i64{
  if workspace==0{return 0;}if words<8778{return 0;}if loop_count<0{return 0;}if loop_count>16{return 0;}
  var plan:*i64=workspace;if plan[0]!=0x4a4a42504c414e31{return 0;}if plan[1]!=1{return 0;}var blocks:i64=plan[2];if blocks<=0{return 0;}if blocks>509{return 0;}
  var h:i64=0x435454584e563031;var i:i64=0;while i<8{h=jj_cttxn_mix(h,plan[i]);i=i+1;}
  i=0;while i<blocks*8{h=jj_cttxn_mix(h,plan[16+i]);i=i+1;}
  var loops:*i64=((workspace as i64)+8322*8) as *i64;var accs:*i64=((workspace as i64)+8482*8) as *i64;var temps:*i64=((workspace as i64)+8610*8) as *i64;var address:*i64=((workspace as i64)+8738*8) as *i64;var invariant:*i64=((workspace as i64)+8754*8) as *i64;
  h=jj_cttxn_mix(h,loop_count);i=0;while i<loop_count*10{h=jj_cttxn_mix(h,loops[i]);i=i+1;}
  var li:i64=0;while li<loop_count{var a:i64=li*8;var j:i64=0;while j<7{h=jj_cttxn_mix(h,accs[a+j]);j=j+1;}j=0;while j<8{h=jj_cttxn_mix(h,temps[a+j]);j=j+1;}li=li+1;}
  i=0;while i<7{h=jj_cttxn_mix(h,address[i]);i=i+1;}i=9;while i<12{h=jj_cttxn_mix(h,address[i]);i=i+1;}
  i=0;while i<10{h=jj_cttxn_mix(h,invariant[i]);i=i+1;}if h==0{h=1;}return h;
}
fn jj_cttxn_seal(r:*i64)->i64{if r==0{return 0;}return 0x435454584e534531^(r as i64)^r[0]^r[1]^r[2]^r[3]^r[4]^r[5]^r[6];}
fn jj_cttxn_prepare(workspace:*i64,words:i64,loop_count:i64)->i64{
  if workspace==0{return 0;}if words<8778{return 0;}var d:i64=jj_cttxn_digest(workspace,words,loop_count);if d==0{return 0;}var r:*i64=((workspace as i64)+8770*8) as *i64;r[0]=0x435454584e503031;r[1]=workspace as i64;r[2]=words;r[3]=loop_count;r[4]=d;r[5]=1;r[6]=0x6933383650524550;r[7]=jj_cttxn_seal(r);return 1;
}
fn jj_cttxn_commit(workspace:*i64,words:i64,loop_count:i64)->i64{
  if workspace==0{return 0;}if words<8778{return 0;}var r:*i64=((workspace as i64)+8770*8) as *i64;if r[0]!=0x435454584e503031{return 0;}if r[1]!=(workspace as i64){return 0;}if r[2]!=words{return 0;}if r[3]!=loop_count{return 0;}if r[5]!=1{return 0;}if r[6]!=0x6933383650524550{return 0;}if r[7]!=jj_cttxn_seal(r){return 0;}var d:i64=jj_cttxn_digest(workspace,words,loop_count);if d==0{return 0;}if d!=r[4]{return 0;}r[5]=2;r[6]=0x69333836434f4d4d;r[7]=jj_cttxn_seal(r);return 1;
}
fn jj_cttxn_validate_committed(workspace:*i64,words:i64,loop_count:i64)->i64{
  if workspace==0{return 0;}if words<8778{return 0;}var r:*i64=((workspace as i64)+8770*8) as *i64;if r[0]!=0x435454584e503031{return 0;}if r[1]!=(workspace as i64){return 0;}if r[2]!=words{return 0;}if r[3]!=loop_count{return 0;}if r[5]!=2{return 0;}if r[6]!=0x69333836434f4d4d{return 0;}if r[7]!=jj_cttxn_seal(r){return 0;}return 1;
}

fn jj_cttxn_i386_resource_contract(out:*i64,cap:i64)->i64{
  if out==0{return 0;}if cap<16{return 0;}out[0]=1;out[1]=32;out[2]=3;out[3]=8778;out[4]=4096;out[5]=130;out[6]=4096;out[7]=160;out[8]=128;out[9]=128;out[10]=16;out[11]=16;out[12]=8;out[13]=0;out[14]=2;out[15]=1;return 1;
}
