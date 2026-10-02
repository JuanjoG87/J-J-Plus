// Target-neutral materialization plan for edge copies.
// Every placement group executes in two phases: capture every source operand into
// a unique virtual temporary, then commit those temporaries to destination slots.
// This is cycle-safe without selecting registers, stack slots or target opcodes.
// Virtual critical-edge blocks are published with explicit predecessor/successor.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_edge_valid(p0:*i64)->i64;
extern fn jj_edge_view_copy_count(p0:*i64)->i64;
extern fn jj_edge_view_split_count(p0:*i64)->i64;
extern fn jj_edge_view_effective_block_count(p0:*i64)->i64;
extern fn jj_edge_view_split_word(p0:*i64,p1:i64)->i64;
extern fn jj_edge_view_copy_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_edge_view_authority_seal(p0:*i64)->i64;
extern fn jj_cfg_view_block_count(p0:*i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_parallel_clear(core:*i64)->i64{if core==0{return 0;}var i:i64=160;while i<176{core[i]=0;i=i+1;}return 1;}
fn jj_parallel_empty(core:*i64)->i64{if core==0{return 0;}var i:i64=160;while i<176{if core[i]!=0{return 0;}i=i+1;}return 1;}
fn jj_parallel_state(core:*i64)->i64{if core==0{return 0;}if core[160]!=0x4a4a504344524631{if core[160]!=0x4a4a5043464e3131{return 0;}}if core[161]<=0{return 0;}if core[162]<0{return 0;}if core[163]<0{return 0;}if core[164]<0{return 0;}if core[165]<0{return 0;}if core[166]<65536{return 0;}if core[167]!=1{return 0;}if core[169]!=jj_edge_view_copy_count(core){return 0;}if core[170]!=jj_edge_view_split_count(core){return 0;}if core[171]!=jj_cfg_view_block_count(core){return 0;}if core[172]!=jj_edge_view_effective_block_count(core){return 0;}if core[163]!=core[162]*2{return 0;}if core[164]!=core[170]{return 0;}if core[165]!=core[164]*2+core[163]*2{return 0;}if core[165]>core[166]/8{return 0;}var bytes:i64=core[165]*8;if bytes<0{return 0;}if bytes!=core[166]-core[8]{return 0;}if core[161]!=core[7]+core[8]{return 0;}if core[9]>core[8]{return 0;}return 1;}
fn jj_parallel_draft(core:*i64)->i64{if jj_parallel_state(core)==0{return 0;}if core[160]!=0x4a4a504344524631{return 0;}return 1;}
fn jj_parallel_ready(core:*i64)->i64{if jj_parallel_state(core)==0{return 0;}if core[160]!=0x4a4a5043464e3131{return 0;}return 1;}
fn jj_parallel_split_word(core:*i64,index:i64,word:i64)->i64{if jj_parallel_state(core)==0{return 0;}if index<0{return 0;}if index>=core[164]{return 0;}if word<0{return 0;}if word>1{return 0;}var base:*i64=core[161] as *i64;return base[index*2+word];}
fn jj_parallel_op_word(core:*i64,index:i64,word:i64)->i64{if jj_parallel_state(core)==0{return 0;}if index<0{return 0;}if index>=core[163]{return 0;}if word<0{return 0;}if word>1{return 0;}var base:*i64=core[161] as *i64;return base[core[164]*2+index*2+word];}
fn jj_parallel_copy_placement(core:*i64,index:i64)->i64{return (jj_edge_view_copy_word(core,index,2)>>>32)&0xffffffff;}
fn jj_parallel_group_ordinal(core:*i64,index:i64)->i64{var placement:i64=jj_parallel_copy_placement(core,index);if placement<=0{return 0-1;}var ordinal:i64=0;var i:i64=0;while i<index{if jj_parallel_copy_placement(core,i)==placement{ordinal=ordinal+1;}i=i+1;}return ordinal;}
fn jj_parallel_fill(core:*i64)->i64{if jj_parallel_draft(core)==0{return 0;}var base:*i64=core[161] as *i64;var blocks:i64=core[171];var s:i64=0;while s<core[164]{var edge:i64=jj_edge_view_split_word(core,s);var source:i64=edge&0xffffffff;var target:i64=(edge>>>32)&0xffffffff;var virtual_block:i64=blocks+s+1;if source<=0{return 0;}if target<=0{return 0;}base[s*2]=(virtual_block&0xffffffff)|(source<<32);base[s*2+1]=(target&0xffffffff)|(1<<32);s=s+1;}var copies:i64=core[162];var c:i64=0;while c<copies{var c0:i64=jj_edge_view_copy_word(core,c,0);var c1:i64=jj_edge_view_copy_word(core,c,1);var c2:i64=jj_edge_view_copy_word(core,c,2);var source2:i64=c0&0xffffffff;var target2:i64=(c0>>>32)&0xffffffff;var slot:i64=c1&0xffffffff;var value:i64=(c1>>>32)&0xffffffff;var type_id:i64=c2&0xffff;var placement_kind:i64=(c2>>>16)&0xffff;var placement:i64=(c2>>>32)&0xffffffff;var ordinal:i64=jj_parallel_group_ordinal(core,c);if ordinal<0{return 0;}var temp_id:i64=c+1;var capture:i64=c;var commit:i64=copies+c;base[core[164]*2+capture*2]=(placement&0xffffffff)|(1<<32)|(ordinal<<40);base[core[164]*2+capture*2+1]=(temp_id&0xffffffff)|(value<<32);base[core[164]*2+commit*2]=(placement&0xffffffff)|(2<<32)|(ordinal<<40);base[core[164]*2+commit*2+1]=(temp_id&0xffffffff)|(slot<<32)|(type_id<<56);if source2<=0{return 0;}if target2<=0{return 0;}if placement_kind<1{return 0;}if placement_kind>2{return 0;}c=c+1;}return 1;}
fn jj_parallel_seal(core:*i64)->i64{if jj_parallel_state(core)==0{return 0;}var h:i64=(core as i64)^core[161]^core[162]^core[163]^core[164]^core[165]^core[166]^core[167]^core[169]^core[170]^core[171]^core[172]^jj_edge_view_authority_seal(core)^0x4a4a504353454131;var base:*i64=core[161] as *i64;var i:i64=0;while i<core[165]{h=((h<<7)|(h>>>57))^base[i]^((i+1)*0x9e3779b1);i=i+1;}return h;}
fn jj_parallel_fail(core:*i64,old:i64)->i64{if core!=0{if core[161]>0{if core[165]>0{var base:*i64=core[161] as *i64;var i:i64=0;while i<core[165]{base[i]=0;i=i+1;}}}core[8]=old;jj_parallel_clear(core);}return 0;}
fn jj_parallel_finish(core:*i64)->i64{if core==0{return 0;}if jj_parallel_empty(core)==0{return 0;}if jj_edge_valid(core)==0{return 0;}var copies:i64=jj_edge_view_copy_count(core);var splits:i64=jj_edge_view_split_count(core);if copies>0x3fffffff{return 0;}var ops:i64=copies*2;var words:i64=splits*2+ops*2;if words<0{return 0;}var old:i64=core[8];if old<65536{return 0;}if words>(old-65536)/8{return 0;}var bytes:i64=words*8;var effective:i64=old-bytes;if core[9]>effective{return 0;}var base:*i64=(core[7]+effective) as *i64;var i:i64=0;while i<words{base[i]=0;i=i+1;}core[8]=effective;core[160]=0x4a4a504344524631;core[161]=base as i64;core[162]=copies;core[163]=ops;core[164]=splits;core[165]=words;core[166]=old;core[167]=1;core[168]=0;core[169]=copies;core[170]=splits;core[171]=jj_cfg_view_block_count(core);core[172]=jj_edge_view_effective_block_count(core);core[173]=0;core[174]=0;core[175]=0;if jj_parallel_draft(core)==0{return jj_parallel_fail(core,old);}if jj_parallel_fill(core)==0{return jj_parallel_fail(core,old);}core[160]=0x4a4a5043464e3131;core[168]=jj_parallel_seal(core);if core[168]==0{return jj_parallel_fail(core,old);}return 1;}
fn jj_parallel_valid(core:*i64)->i64{if jj_parallel_ready(core)==0{return 0;}if core[168]!=jj_parallel_seal(core){return 0;}return 1;}
fn jj_parallel_release(core:*i64)->i64{if jj_parallel_valid(core)==0{return 0;}var base:*i64=core[161] as *i64;var words:i64=core[165];var old:i64=core[166];var i:i64=0;while i<words{base[i]=0;i=i+1;}core[8]=old;return jj_parallel_clear(core);}
fn jj_parallel_version(core:*i64)->i64{if jj_parallel_ready(core)==0{return 0;}return 1;}
fn jj_parallel_copy_count(core:*i64)->i64{if jj_parallel_ready(core)==0{return 0;}return core[162];}
fn jj_parallel_op_count(core:*i64)->i64{if jj_parallel_ready(core)==0{return 0;}return core[163];}
fn jj_parallel_split_count(core:*i64)->i64{if jj_parallel_ready(core)==0{return 0;}return core[164];}




fn jj_parallel_view_ready(core:*i64)->i64{return jj_parallel_ready(core);}
fn jj_parallel_view_version(core:*i64)->i64{if jj_parallel_ready(core)==0{return 0;}return core[167];}
fn jj_parallel_view_copy_count(core:*i64)->i64{if jj_parallel_ready(core)==0{return 0;}return core[162];}
fn jj_parallel_view_op_count(core:*i64)->i64{if jj_parallel_ready(core)==0{return 0;}return core[163];}
fn jj_parallel_view_split_count(core:*i64)->i64{if jj_parallel_ready(core)==0{return 0;}return core[164];}
fn jj_parallel_view_split_word(core:*i64,index:i64,word:i64)->i64{if jj_parallel_ready(core)==0{return 0;}return jj_parallel_split_word(core,index,word);}
fn jj_parallel_view_op_word(core:*i64,index:i64,word:i64)->i64{if jj_parallel_ready(core)==0{return 0;}return jj_parallel_op_word(core,index,word);}
fn jj_parallel_view_authority_seal(core:*i64)->i64{if jj_parallel_ready(core)==0{return 0;}return core[168];}
