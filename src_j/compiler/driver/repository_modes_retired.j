fn jj_m_magic(source: *i8, length: i64) -> i64 {
  if source == 0 { return 0; }
  if length < 9 { return 0; }
  if source[0] != 74 { return 0; }
  if source[1] != 74 { return 0; }
  if source[2] != 77 { return 0; }
  if source[3] != 79 { return 0; }
  if source[4] != 68 { return 0; }
  if source[5] != 69 { return 0; }
  if source[6] != 76 { return 0; }
  if source[7] != 49 { return 0; }
  if source[8] != 10 { return 0; }
  return 1;
}

fn jj_r_manifest(source: *i8, length: i64) -> i64 {
  if source == 0 { return 0; }
  if length < 8 { return 0; }
  if source[0] != 74 { return 0; }
  if source[1] != 74 { return 0; }
  if source[2] != 82 { return 0; }
  if source[3] != 69 { return 0; }
  if source[4] != 80 { return 0; }
  if source[5] != 79 { return 0; }
  if source[6] != 51 { return 0; }
  if source[7] != 10 { return 0; }
  return 1;
}

fn jj_repository_materialize_model(fs: *i64, memory: *i64) -> i64 {
  if fs == 0 { return 0; }
  if memory == 0 { return 0; }
  return 0;
}

fn jj_repository_verify_manifest(fs: *i64, memory: *i64) -> i64 {
  if fs == 0 { return 0; }
  if memory == 0 { return 0; }
  return 0;
}

// Common CIR extension v1. The lowering path serializes target-neutral virtual
// blocks and parallel capture/commit operations physically between the linear
// bytecode body and the function table. The extension is deterministic, bounded
// by the existing program capability and independently rederived from the sealed
// CFG/edge/parallel authorities before it is accepted.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_semantic_cir_body_end(p0:*i64)->i64;
extern fn jj_semantic_cir_scan(p0:*i64)->i64;
extern fn jj_cfg_view_block_count(p0:*i64)->i64;
extern fn jj_edge_view_effective_block_count(p0:*i64)->i64;
extern fn jj_edge_view_split_count(p0:*i64)->i64;
extern fn jj_edge_view_copy_count(p0:*i64)->i64;
extern fn jj_parallel_view_ready(p0:*i64)->i64;
extern fn jj_parallel_view_version(p0:*i64)->i64;
extern fn jj_parallel_view_split_count(p0:*i64)->i64;
extern fn jj_parallel_view_op_count(p0:*i64)->i64;
extern fn jj_parallel_view_split_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_parallel_view_op_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_parallel_view_authority_seal(p0:*i64)->i64;
extern fn jj_edge_view_copy_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_verifier_valid(p0:*i64)->i64;
extern fn jj_cir_verifier_version(p0:*i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_cirx_clear(core:*i64)->i64{if core==0{return 0;}var i:i64=176;while i<192{core[i]=0;i=i+1;}return 1;}
fn jj_cirx_empty(core:*i64)->i64{if core==0{return 0;}var i:i64=176;while i<192{if core[i]!=0{return 0;}i=i+1;}return 1;}
fn jj_cirx_wr64(p:*i8,value:i64)->i64{if p==0{return 0;}var i:i64=0;while i<8{p[i]=value>>>(i*8);i=i+1;}return 1;}
fn jj_cirx_rd64(p:*i8)->i64{if p==0{return 0;}var value:i64=0;var i:i64=0;while i<8{value=value|((p[i]&255)<<(i*8));i=i+1;}return value;}
fn jj_cirx_word(core:*i64,index:i64)->i64{if core==0{return 0;}if index<0{return 0;}if index>=core[178]{return 0;}var program:*i8=core[7] as *i8;return jj_cirx_rd64(program+core[177]+index*8);}
fn jj_cirx_put(core:*i64,index:i64,value:i64)->i64{if core==0{return 0;}if index<0{return 0;}if index>=core[178]{return 0;}var program:*i8=core[7] as *i8;return jj_cirx_wr64(program+core[177]+index*8,value);}
fn jj_cirx_content_seal(core:*i64)->i64{if core==0{return 0;}if core[178]<12{return 0;}var h:i64=0x4a4a434958534531;var i:i64=0;while i<core[178]{var w:i64=jj_cirx_word(core,i);if i==11{w=0;}h=((h<<7)|(h>>>57))^w^((i+1)*0x9e3779b1);i=i+1;}return h;}
fn jj_cirx_authority_seal(core:*i64)->i64{if core==0{return 0;}return (core as i64)^core[177]^core[178]^core[179]^core[180]^core[181]^core[182]^core[183]^core[184]^core[185]^core[186]^jj_parallel_view_authority_seal(core)^jj_cirx_word(core,11)^0x4a4a434958415531;}
fn jj_cirx_state(core:*i64)->i64{if core==0{return 0;}if core[176]!=0x4a4a434958464e31{return 0;}if core[177]<48{return 0;}if core[178]<12{return 0;}if core[179]!=jj_semantic_cir_body_end(core){return 0;}if core[177]!=core[179]{return 0;}if core[180]<=0{return 0;}if core[181]<core[180]{return 0;}if core[182]<0{return 0;}if core[183]<0{return 0;}if core[184]!=core[183]*2{return 0;}if core[185]!=core[183]{return 0;}if core[186]!=1{return 0;}if core[178]!=12+core[182]*4+core[184]*6{return 0;}var bytes:i64=core[178]*8;if bytes<=0{return 0;}if core[177]>core[8]-bytes{return 0;}if core[9]<core[177]+bytes{return 0;}if jj_cirx_word(core,0)!=0x4a4a434952455831{return 0;}if jj_cirx_word(core,1)!=1{return 0;}if jj_cirx_word(core,2)!=core[178]{return 0;}if jj_cirx_word(core,3)!=core[179]{return 0;}if jj_cirx_word(core,4)!=core[180]{return 0;}if jj_cirx_word(core,5)!=core[181]{return 0;}if jj_cirx_word(core,6)!=core[182]{return 0;}if jj_cirx_word(core,7)!=core[183]{return 0;}if jj_cirx_word(core,8)!=core[184]{return 0;}if jj_cirx_word(core,9)!=core[185]{return 0;}if jj_cirx_word(core,10)!=6{return 0;}if jj_cirx_word(core,11)!=jj_cirx_content_seal(core){return 0;}if core[187]!=jj_cirx_authority_seal(core){return 0;}return 1;}
fn jj_cirx_fail(core:*i64,old:i64,bytes:i64)->i64{if core!=0{if core[7]!=0{if bytes>0{var p:*i8=(core[7]+old) as *i8;var i:i64=0;while i<bytes{p[i]=0;i=i+1;}}}core[9]=old;jj_cirx_clear(core);}return 0;}
fn jj_cirx_materialize(core:*i64)->i64{if core==0{return 0;}if jj_cirx_empty(core)==0{return 0;}if jj_parallel_view_ready(core)==0{return 0;}if jj_parallel_view_version(core)!=1{return 0;}if jj_cir_verifier_valid(core)==0{return 0;}if jj_cir_verifier_version(core)!=3{return 0;}var body:i64=jj_semantic_cir_body_end(core);if body<=48{return 0;}if core[9]!=body{return 0;}var blocks:i64=jj_cfg_view_block_count(core);var effective:i64=jj_edge_view_effective_block_count(core);var splits:i64=jj_parallel_view_split_count(core);var copies:i64=jj_edge_view_copy_count(core);var ops:i64=jj_parallel_view_op_count(core);if blocks<=0{return 0;}if effective<blocks{return 0;}if splits<0{return 0;}if copies<0{return 0;}if ops!=copies*2{return 0;}if splits>0x0fffffff{return 0;}if ops>0x0fffffff{return 0;}var words:i64=12+splits*4+ops*6;if words<12{return 0;}var bytes:i64=words*8;if bytes<=0{return 0;}if body>core[8]-bytes{return 0;}core[176]=0x4a4a434958464e31;core[177]=body;core[178]=words;core[179]=body;core[180]=blocks;core[181]=effective;core[182]=splits;core[183]=copies;core[184]=ops;core[185]=copies;core[186]=1;core[187]=0;core[188]=0;core[189]=0;core[190]=0;core[191]=0;var p:*i8=(core[7]+body) as *i8;var z:i64=0;while z<bytes{p[z]=0;z=z+1;}if jj_cirx_put(core,0,0x4a4a434952455831)==0{return jj_cirx_fail(core,body,bytes);}jj_cirx_put(core,1,1);jj_cirx_put(core,2,words);jj_cirx_put(core,3,body);jj_cirx_put(core,4,blocks);jj_cirx_put(core,5,effective);jj_cirx_put(core,6,splits);jj_cirx_put(core,7,copies);jj_cirx_put(core,8,ops);jj_cirx_put(core,9,copies);jj_cirx_put(core,10,6);var s:i64=0;while s<splits{var w0:i64=jj_parallel_view_split_word(core,s,0);var w1:i64=jj_parallel_view_split_word(core,s,1);var at:i64=12+s*4;jj_cirx_put(core,at,w0&0xffffffff);jj_cirx_put(core,at+1,(w0>>>32)&0xffffffff);jj_cirx_put(core,at+2,w1&0xffffffff);jj_cirx_put(core,at+3,(w1>>>32)&0xffffffff);s=s+1;}var o:i64=0;while o<ops{var op0:i64=jj_parallel_view_op_word(core,o,0);var op1:i64=jj_parallel_view_op_word(core,o,1);var copy_index:i64=o;if copy_index>=copies{copy_index=copy_index-copies;}if copy_index<0{return jj_cirx_fail(core,body,bytes);}if copy_index>=copies{return jj_cirx_fail(core,body,bytes);}var edge2:i64=jj_edge_view_copy_word(core,copy_index,2);var at2:i64=12+splits*4+o*6;jj_cirx_put(core,at2,op0&0xffffffff);jj_cirx_put(core,at2+1,(op0>>>32)&255);jj_cirx_put(core,at2+2,(op0>>>40)&0xffffff);jj_cirx_put(core,at2+3,op1&0xffffffff);jj_cirx_put(core,at2+4,(op1>>>32)&0xffffffff);jj_cirx_put(core,at2+5,edge2&0xffff);o=o+1;}jj_cirx_put(core,11,jj_cirx_content_seal(core));core[9]=body+bytes;core[187]=jj_cirx_authority_seal(core);if jj_cirx_state(core)==0{return jj_cirx_fail(core,body,bytes);}return 1;}
fn jj_cirx_rederive(core:*i64,checks:*i64)->i64{if checks==0{return 0;}if jj_cirx_state(core)==0{return 0;}if jj_parallel_view_ready(core)==0{return 0;}if jj_parallel_view_version(core)!=1{return 0;}if core[180]!=jj_cfg_view_block_count(core){return 0;}if core[181]!=jj_edge_view_effective_block_count(core){return 0;}if core[182]!=jj_parallel_view_split_count(core){return 0;}if core[183]!=jj_edge_view_copy_count(core){return 0;}if core[184]!=jj_parallel_view_op_count(core){return 0;}var s:i64=0;while s<core[182]{var w0:i64=jj_parallel_view_split_word(core,s,0);var w1:i64=jj_parallel_view_split_word(core,s,1);var at:i64=12+s*4;if jj_cirx_word(core,at)!=(w0&0xffffffff){return 0;}if jj_cirx_word(core,at+1)!=((w0>>>32)&0xffffffff){return 0;}if jj_cirx_word(core,at+2)!=(w1&0xffffffff){return 0;}if jj_cirx_word(core,at+3)!=((w1>>>32)&0xffffffff){return 0;}checks[0]=checks[0]+1;s=s+1;}var o:i64=0;while o<core[184]{var op0:i64=jj_parallel_view_op_word(core,o,0);var op1:i64=jj_parallel_view_op_word(core,o,1);var copy_index:i64=o;if copy_index>=core[183]{copy_index=copy_index-core[183];}if copy_index<0{return 0;}if copy_index>=core[183]{return 0;}var edge2:i64=jj_edge_view_copy_word(core,copy_index,2);var at2:i64=12+core[182]*4+o*6;if jj_cirx_word(core,at2)!=(op0&0xffffffff){return 0;}if jj_cirx_word(core,at2+1)!=((op0>>>32)&255){return 0;}if jj_cirx_word(core,at2+2)!=((op0>>>40)&0xffffff){return 0;}if jj_cirx_word(core,at2+3)!=(op1&0xffffffff){return 0;}if jj_cirx_word(core,at2+4)!=((op1>>>32)&0xffffffff){return 0;}if jj_cirx_word(core,at2+5)!=(edge2&0xffff){return 0;}checks[0]=checks[0]+1;o=o+1;}return 1;}
fn jj_cirx_body_digest(core:*i64)->i64{if core==0{return 0;}if core[7]==0{return 0;}if core[61]!=48{return 0;}if core[62]<=core[61]{return 0;}var p:*i8=core[7] as *i8;var h:i64=0x4a4a434958424431;var i:i64=core[61];while i<core[62]{h=((h<<7)|(h>>>57))^p[i]^((i-core[61]+1)*0x9e3779b1);i=i+1;}return h;}
fn jj_cirx_frozen_seal(core:*i64)->i64{if core==0{return 0;}return (core as i64)^core[7]^core[18]^core[60]^core[61]^core[62]^core[63]^core[64]^core[65]^core[66]^core[67]^core[176]^core[177]^core[178]^core[179]^core[180]^core[181]^core[182]^core[183]^core[184]^core[185]^core[186]^core[187]^core[188]^core[189]^core[190]^jj_cirx_body_digest(core)^jj_cirx_word(core,11)^0x4a4a434958465a31;}
fn jj_cirx_frozen_shape(core:*i64)->i64{if core==0{return 0;}if core[176]!=0x4a4a434958464e31{return 0;}if core[7]==0{return 0;}if core[177]<48{return 0;}if core[178]<12{return 0;}if core[60]!=0x4a4a534346494e31{return 0;}if core[61]!=48{return 0;}if core[62]!=core[179]{return 0;}if core[63]<=0{return 0;}if core[64]<0{return 0;}if core[65]<=0{return 0;}if core[66]!=1{return 0;}if jj_semantic_cir_scan(core)!=core[65]{return 0;}if jj_cirx_body_digest(core)==0{return 0;}if core[177]!=core[179]{return 0;}if core[180]<=0{return 0;}if core[181]<core[180]{return 0;}if core[182]<0{return 0;}if core[183]<0{return 0;}if core[184]!=core[183]*2{return 0;}if core[185]!=core[183]{return 0;}if core[186]!=1{return 0;}if core[181]!=core[180]+core[182]{return 0;}if core[178]!=12+core[182]*4+core[184]*6{return 0;}var bytes:i64=core[178]*8;if bytes<=0{return 0;}if core[177]>core[8]-bytes{return 0;}if core[9]<core[177]+bytes{return 0;}if jj_cirx_word(core,0)!=0x4a4a434952455831{return 0;}if jj_cirx_word(core,1)!=1{return 0;}if jj_cirx_word(core,2)!=core[178]{return 0;}if jj_cirx_word(core,3)!=core[179]{return 0;}if jj_cirx_word(core,4)!=core[180]{return 0;}if jj_cirx_word(core,5)!=core[181]{return 0;}if jj_cirx_word(core,6)!=core[182]{return 0;}if jj_cirx_word(core,7)!=core[183]{return 0;}if jj_cirx_word(core,8)!=core[184]{return 0;}if jj_cirx_word(core,9)!=core[185]{return 0;}if jj_cirx_word(core,10)!=6{return 0;}if jj_cirx_word(core,11)!=jj_cirx_content_seal(core){return 0;}var s:i64=0;while s<core[182]{var at:i64=12+s*4;var virtual_block:i64=jj_cirx_word(core,at);var predecessor:i64=jj_cirx_word(core,at+1);var successor:i64=jj_cirx_word(core,at+2);var successor_count:i64=jj_cirx_word(core,at+3);if virtual_block!=core[180]+s+1{return 0;}if predecessor<=0{return 0;}if predecessor>core[180]{return 0;}if successor<=0{return 0;}if successor>core[180]{return 0;}if successor_count!=1{return 0;}s=s+1;}var copies:i64=core[183];var i:i64=0;while i<copies{var capture:i64=12+core[182]*4+i*6;var commit:i64=12+core[182]*4+(copies+i)*6;var placement:i64=jj_cirx_word(core,capture);var phase:i64=jj_cirx_word(core,capture+1);var ordinal:i64=jj_cirx_word(core,capture+2);var temp:i64=jj_cirx_word(core,capture+3);var value:i64=jj_cirx_word(core,capture+4);var type_id:i64=jj_cirx_word(core,capture+5);if placement<=0{return 0;}if placement>core[181]{return 0;}if phase!=1{return 0;}if temp!=i+1{return 0;}if value<=0{return 0;}if type_id<=0{return 0;}var expected_ordinal:i64=0;var j:i64=0;while j<i{var previous:i64=12+core[182]*4+j*6;if jj_cirx_word(core,previous)==placement{expected_ordinal=expected_ordinal+1;}j=j+1;}if ordinal!=expected_ordinal{return 0;}if jj_cirx_word(core,commit)!=placement{return 0;}if jj_cirx_word(core,commit+1)!=2{return 0;}if jj_cirx_word(core,commit+2)!=ordinal{return 0;}if jj_cirx_word(core,commit+3)!=temp{return 0;}if jj_cirx_word(core,commit+4)<0{return 0;}if jj_cirx_word(core,commit+5)!=type_id{return 0;}i=i+1;}return 1;}
fn jj_cirx_frozen_valid(core:*i64)->i64{if jj_cirx_frozen_shape(core)==0{return 0;}if core[188]<=0{return 0;}if core[190]!=1{return 0;}var expected_checks:i64=core[182]+core[184];if expected_checks<=0{expected_checks=1;}if core[188]!=expected_checks{return 0;}if core[191]==0{return 0;}if core[191]!=jj_cirx_frozen_seal(core){return 0;}return 1;}
fn jj_cirx_receipt_seal(core:*i64)->i64{return (core as i64)^core[177]^core[178]^core[188]^jj_cirx_word(core,11)^jj_parallel_view_authority_seal(core)^0x4a4a434958525331;}
fn jj_cirx_receipt_finish(core:*i64)->i64{if core==0{return 0;}if core[188]!=0{return 0;}if core[189]!=0{return 0;}if core[190]!=0{return 0;}if core[191]!=0{return 0;}var checks:[1]i64;checks[0]=0;if jj_cirx_rederive(core,checks as *i64)==0{return 0;}if checks[0]<=0{if core[182]!=0{return 0;}if core[184]!=0{return 0;}checks[0]=1;}core[188]=checks[0];core[190]=1;core[189]=jj_cirx_receipt_seal(core);if core[189]==0{core[188]=0;core[190]=0;return 0;}core[191]=jj_cirx_frozen_seal(core);if core[191]==0{core[188]=0;core[189]=0;core[190]=0;return 0;}return 1;}
fn jj_cirx_receipt_valid(core:*i64)->i64{if jj_cirx_state(core)==0{return 0;}if core[188]<=0{return 0;}if core[190]!=1{return 0;}if core[189]!=jj_cirx_receipt_seal(core){return 0;}var checks:[1]i64;checks[0]=0;if jj_cirx_rederive(core,checks as *i64)==0{return 0;}if checks[0]<=0{checks[0]=1;}if checks[0]!=core[188]{return 0;}if core[191]==0{return 0;}if core[191]!=jj_cirx_frozen_seal(core){return 0;}return 1;}
fn jj_cirx_available_valid(core:*i64)->i64{if core==0{return 0;}if jj_parallel_view_ready(core)!=0{return jj_cirx_receipt_valid(core);}return jj_cirx_frozen_valid(core);}
fn jj_cirx_version(core:*i64)->i64{if jj_cirx_available_valid(core)==0{return 0;}return 1;}
fn jj_cirx_offset(core:*i64)->i64{if jj_cirx_available_valid(core)==0{return 0;}return core[177];}
fn jj_cirx_end(core:*i64)->i64{if jj_cirx_available_valid(core)==0{return 0;}return core[177]+core[178]*8;}
fn jj_cirx_block_count(core:*i64)->i64{if jj_cirx_available_valid(core)==0{return 0;}return core[181];}
fn jj_cirx_split_count(core:*i64)->i64{if jj_cirx_available_valid(core)==0{return 0;}return core[182];}
fn jj_cirx_copy_count(core:*i64)->i64{if jj_cirx_available_valid(core)==0{return 0;}return core[183];}
fn jj_cirx_op_count(core:*i64)->i64{if jj_cirx_available_valid(core)==0{return 0;}return core[184];}
fn jj_cirx_temp_count(core:*i64)->i64{if jj_cirx_available_valid(core)==0{return 0;}return core[185];}
fn jj_cirx_raw_op_word(core:*i64,index:i64,word:i64)->i64{if core==0{return 0;}if index<0{return 0;}if index>=core[184]{return 0;}if word<0{return 0;}if word>=6{return 0;}return jj_cirx_word(core,12+core[182]*4+index*6+word);}

