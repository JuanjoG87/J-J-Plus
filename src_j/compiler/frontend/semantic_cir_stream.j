// Semantic CIR stream v1. The frontend publishes a sealed, byte-compatible
// instruction authority directly into the caller-owned program capability.
// The encoding remains compatible with the historical backend while its
// ownership, validation and patch lifecycle are explicit and versioned.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_sink_emit8(p0:*i8,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_sink_emit16(p0:*i8,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_sink_emit32(p0:*i8,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_sink_emit64(p0:*i8,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_sink_patch32(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_c_hash_bytes(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_typed_node_arena_valid(p0:*i64)->i64;
extern fn jj_typed_node_count(p0:*i64)->i64;
extern fn jj_ast16_node_kind(p0:*i64,p1:i64)->i64;
extern fn jj_ast16_node_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_operand_tree_valid(p0:*i64)->i64;
extern fn jj_operand_tree_count(p0:*i64)->i64;
extern fn jj_operand_tree_root_count(p0:*i64)->i64;
extern fn jj_operand_tree_capacity(p0:*i64)->i64;
extern fn jj_operand_tree_kind_sealed(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_finish(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_valid(p0:*i64)->i64;
extern fn jj_cfg_version(p0:*i64)->i64;
extern fn jj_cfg_block_count(p0:*i64)->i64;
extern fn jj_cfg_edge_count(p0:*i64)->i64;
extern fn jj_cfg_explicit_terminator_count(p0:*i64)->i64;
extern fn jj_cfg_synthetic_branch_count(p0:*i64)->i64;
extern fn jj_cfg_unreachable_block_count(p0:*i64)->i64;
extern fn jj_cfg_view_block_count(p0:*i64)->i64;
extern fn jj_cfg_view_explicit_terminator_count(p0:*i64)->i64;
extern fn jj_def_finish(p0:*i64)->i64;
extern fn jj_def_valid(p0:*i64)->i64;
extern fn jj_def_version(p0:*i64)->i64;
extern fn jj_def_access_count(p0:*i64)->i64;
extern fn jj_def_mapped_store_count(p0:*i64)->i64;
extern fn jj_join_finish(p0:*i64)->i64;
extern fn jj_join_valid(p0:*i64)->i64;
extern fn jj_join_view_ready(p0:*i64)->i64;
extern fn jj_join_view_version(p0:*i64)->i64;
extern fn jj_join_view_argument_count(p0:*i64)->i64;
extern fn jj_join_view_incoming_count(p0:*i64)->i64;
extern fn jj_join_view_block_count(p0:*i64)->i64;
extern fn jj_edge_finish(p0:*i64)->i64;
extern fn jj_edge_valid(p0:*i64)->i64;
extern fn jj_parallel_finish(p0:*i64)->i64;
extern fn jj_parallel_valid(p0:*i64)->i64;
extern fn jj_parallel_copy_count(p0:*i64)->i64;
extern fn jj_parallel_op_count(p0:*i64)->i64;
extern fn jj_parallel_split_count(p0:*i64)->i64;
extern fn jj_edge_copy_count(p0:*i64)->i64;
extern fn jj_edge_split_count(p0:*i64)->i64;
extern fn jj_cir_verifier_finish(p0:*i64)->i64;
extern fn jj_cir_verifier_valid(p0:*i64)->i64;
extern fn jj_cir_verifier_check_count(p0:*i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_semantic_cir_clear(core:*i64)->i64{if core==0{return 0;}var i:i64=60;while i<72{core[i]=0;i=i+1;}return 1;}
fn jj_semantic_cir_draft(core:*i64)->i64{if core==0{return 0;}if core[60]!=0x4a4a534344524631{return 0;}if core[61]!=48{return 0;}if core[62]<48{return 0;}if core[62]!=core[9]{return 0;}if core[63]<0{return 0;}if core[64]<0{return 0;}if core[66]!=1{return 0;}return 1;}
fn jj_semantic_cir_begin(core:*i64)->i64{if core==0{return 0;}if core[7]==0{return 0;}if core[8]<65536{return 0;}if core[9]!=48{return 0;}if jj_semantic_cir_clear(core)==0{return 0;}core[60]=0x4a4a534344524631;core[61]=48;core[62]=48;core[63]=0;core[64]=0;core[65]=0;core[66]=1;core[67]=0;return jj_semantic_cir_draft(core);}
fn jj_semantic_cir_emit8(core:*i64,value:i64)->i64{if jj_semantic_cir_draft(core)==0{return 0;}if jj_sink_emit8(core[7] as *i8,core[8],(((core as i64)+72) as *i64),value)==0{return 0;}core[62]=core[9];core[63]=core[63]+1;return 1;}
fn jj_semantic_cir_emit16(core:*i64,value:i64)->i64{if jj_semantic_cir_draft(core)==0{return 0;}if jj_sink_emit16(core[7] as *i8,core[8],(((core as i64)+72) as *i64),value)==0{return 0;}core[62]=core[9];core[63]=core[63]+1;return 1;}
fn jj_semantic_cir_emit32(core:*i64,value:i64)->i64{if jj_semantic_cir_draft(core)==0{return 0;}if jj_sink_emit32(core[7] as *i8,core[8],(((core as i64)+72) as *i64),value)==0{return 0;}core[62]=core[9];core[63]=core[63]+1;return 1;}
fn jj_semantic_cir_emit64(core:*i64,value:i64)->i64{if jj_semantic_cir_draft(core)==0{return 0;}if jj_sink_emit64(core[7] as *i8,core[8],(((core as i64)+72) as *i64),value)==0{return 0;}core[62]=core[9];core[63]=core[63]+1;return 1;}
fn jj_semantic_cir_patch32(core:*i64,position:i64,value:i64)->i64{if jj_semantic_cir_draft(core)==0{return 0;}if position<core[61]{return 0;}if position>core[62]-4{return 0;}if jj_sink_patch32(core[7] as *i8,core[8],core[62],position,value)==0{return 0;}core[64]=core[64]+1;return 1;}
fn jj_semantic_cir_rd16(p:*i8)->i64{return (p[0]&255)|((p[1]&255)<<8);}
fn jj_semantic_cir_rd32(p:*i8)->i64{return (p[0]&255)|((p[1]&255)<<8)|((p[2]&255)<<16)|((p[3]&255)<<24);}
fn jj_semantic_cir_length(program:*i8,pc:i64,end:i64)->i64{if program==0{return 0;}if pc<48{return 0;}if pc>=end{return 0;}var op:i64=program[pc];if op==1{if pc+9>end{return 0;}return 9;}if op>=2{if op<=3{if pc+3>end{return 0;}return 3;}}if op==4{if pc+5>end{return 0;}return 5;}if op==27{if pc+5>end{return 0;}return 5;}if op==28{if pc+5>end{return 0;}return 5;}if op==29{if pc+4>end{return 0;}return 4;}if op==33{if pc+4>end{return 0;}return 4;}if op>=34{if op<=44{return 1;}}if op==45{if pc+5>end{return 0;}return 5;}if op==46{return 1;}if op==47{return 1;}if op==48{if pc+3>end{return 0;}var n:i64=jj_semantic_cir_rd16(program+pc+1);if pc+3+n>end{return 0;}return 3+n;}if op==49{return 1;}if op>=5{if op<=32{return 1;}}return 0;}
fn jj_semantic_cir_scan(core:*i64)->i64{if core==0{return 0;}var program:*i8=core[7] as *i8;if program==0{return 0;}var pc:i64=core[61];var end:i64=core[62];var count:i64=0;while pc<end{var length:i64=jj_semantic_cir_length(program,pc,end);if length<=0{return 0;}var op:i64=program[pc];if op==27{var target:i64=jj_semantic_cir_rd32(program+pc+1);if target<core[61]{return 0;}if target>end{return 0;}}else{if op==28{var target2:i64=jj_semantic_cir_rd32(program+pc+1);if target2<core[61]{return 0;}if target2>end{return 0;}}}pc=pc+length;count=count+1;if count>0x0fffffff{return 0;}}if pc!=end{return 0;}return count;}
fn jj_semantic_cir_capacity(core:*i64)->i64{if core==0{return 0;}if core[92]==0x4a4a434647445231{return core[99];}if core[92]==0x4a4a434647464e31{return core[99];}if core[92]==0x4a4a434647445232{return core[99];}if core[92]==0x4a4a434647464e32{return core[99];}return core[8];}
fn jj_semantic_cir_seal(core:*i64)->i64{if core==0{return 0;}var program:*i8=core[7] as *i8;if program==0{return 0;}var capacity:i64=jj_semantic_cir_capacity(core);if capacity<65536{return 0;}var bytes:i64=core[62]-core[61];if bytes<=0{return 0;}var digest:i64=jj_c_hash_bytes(program,core[61],bytes);return (core as i64)^core[7]^capacity^core[61]^core[62]^core[63]^core[64]^core[65]^core[66]^digest^0x4a4a534343495231;}
fn jj_semantic_cir_finish(core:*i64)->i64{if jj_semantic_cir_draft(core)==0{return 0;}if core[62]<=core[61]{return 0;}var operations:i64=jj_semantic_cir_scan(core);if operations<=0{return 0;}core[65]=operations;core[60]=0x4a4a534346494e31;core[67]=jj_semantic_cir_seal(core);if core[67]==0{return 0;}return 1;}
fn jj_semantic_cir_valid(core:*i64)->i64{if core==0{return 0;}if core[60]!=0x4a4a534346494e31{return 0;}if core[7]==0{return 0;}var capacity:i64=jj_semantic_cir_capacity(core);if capacity<65536{return 0;}if core[61]!=48{return 0;}if core[62]<=48{return 0;}if core[62]>capacity{return 0;}if core[9]<core[62]{return 0;}if core[63]<=0{return 0;}if core[64]<0{return 0;}if core[65]<=0{return 0;}if core[66]!=1{return 0;}if jj_semantic_cir_scan(core)!=core[65]{return 0;}if core[67]!=jj_semantic_cir_seal(core){return 0;}return 1;}
fn jj_semantic_cir_view_ready(core:*i64)->i64{if core==0{return 0;}if core[60]!=0x4a4a534346494e31{return 0;}if core[7]==0{return 0;}if core[61]!=48{return 0;}if core[62]<=48{return 0;}if core[63]<=0{return 0;}if core[65]<=0{return 0;}if core[66]!=1{return 0;}if core[67]==0{return 0;}return 1;}

fn jj_semantic_cir_structure_seal(core:*i64)->i64{return (core as i64)^core[61]^core[62]^core[68]^core[69]^core[70]^core[77]^core[84]^core[85]^core[86]^core[87]^core[88]^jj_cfg_edge_count(core)^jj_cfg_synthetic_branch_count(core)^jj_cfg_unreachable_block_count(core)^jj_def_access_count(core)^jj_def_mapped_store_count(core)^jj_join_view_argument_count(core)^jj_join_view_incoming_count(core)^jj_join_view_block_count(core)^jj_edge_copy_count(core)^jj_edge_split_count(core)^jj_parallel_copy_count(core)^jj_parallel_op_count(core)^jj_parallel_split_count(core)^jj_cir_verifier_check_count(core)^0x4a4a434952535439;}
fn jj_semantic_cir_structure_finish(core:*i64)->i64{
  if jj_typed_node_arena_valid(core)==0{return 0;}if jj_operand_tree_valid(core)==0{return 0;}
  var node_count:i64=core[55];if node_count<=0{return 0;}var relations:*i64=core[53] as *i64;if relations==0{return 0;}var function_count:i64=0;var lexical_block_count:i64=0;var i:i64=1;
  while i<=node_count{var kind:i64=jj_ast16_node_kind(core,i);var parent:i64=relations[i-1]&0xffffffff;if kind==1{function_count=function_count+1;if parent!=1{return 0;}}if kind==11{lexical_block_count=lexical_block_count+1;if parent<=0{return 0;}}i=i+1;}
  var operand_count:i64=jj_operand_tree_count(core);var operand_roots:i64=jj_operand_tree_root_count(core);if function_count<=0{return 0;}if lexical_block_count<=0{return 0;}if operand_count<=0{return 0;}if operand_roots<=0{return 0;}var effects:i64=0;var terminators:i64=0;var branches:i64=0;var conditionals:i64=0;var returns:i64=0;var capacity:i64=jj_operand_tree_capacity(core);i=1;while i<=capacity{var operand_kind:i64=jj_operand_tree_kind_sealed(core,i);if operand_kind>=41{if operand_kind<=43{effects=effects+1;}else{if operand_kind==44{returns=returns+1;terminators=terminators+1;}else{if operand_kind==45{branches=branches+1;terminators=terminators+1;}else{if operand_kind==46{conditionals=conditionals+1;terminators=terminators+1;}}}}}i=i+1;}if terminators<=0{return 0;}if returns<=0{return 0;}if jj_cfg_finish(core,terminators)==0{return 0;}if jj_def_finish(core)==0{return 0;}if jj_def_valid(core)==0{return 0;}if jj_join_finish(core)==0{return 0;}if jj_join_valid(core)==0{return 0;}if jj_edge_finish(core)==0{return 0;}if jj_edge_valid(core)==0{return 0;}if jj_parallel_finish(core)==0{return 0;}if jj_parallel_valid(core)==0{return 0;}if jj_cir_verifier_finish(core)==0{return 0;}if jj_cir_verifier_valid(core)==0{return 0;}var cfg_blocks:i64=jj_cfg_view_block_count(core);if cfg_blocks<=0{return 0;}if jj_cfg_view_explicit_terminator_count(core)!=terminators{return 0;}core[68]=function_count;core[69]=cfg_blocks;core[70]=operand_count;core[84]=effects;core[85]=terminators;core[86]=branches;core[87]=conditionals;core[88]=returns;core[71]=jj_semantic_cir_structure_seal(core);if core[71]==0{return 0;}return 1;
}
fn jj_semantic_cir_structure_valid(core:*i64)->i64{if jj_semantic_cir_valid(core)==0{return 0;}if jj_operand_tree_valid(core)==0{return 0;}if jj_cfg_valid(core)==0{return 0;}if jj_cfg_version(core)!=2{return 0;}if jj_def_valid(core)==0{return 0;}if jj_def_version(core)!=2{return 0;}if jj_join_view_ready(core)==0{return 0;}if jj_join_view_version(core)!=1{return 0;}if jj_join_valid(core)==0{return 0;}if jj_edge_valid(core)==0{return 0;}if jj_parallel_valid(core)==0{return 0;}if jj_cir_verifier_valid(core)==0{return 0;}if core[68]<=0{return 0;}if core[69]<=0{return 0;}if core[69]!=jj_cfg_block_count(core){return 0;}if core[70]<=0{return 0;}if core[70]!=jj_operand_tree_count(core){return 0;}if core[84]<0{return 0;}if core[85]<=0{return 0;}if core[86]<0{return 0;}if core[87]<0{return 0;}if core[88]<=0{return 0;}if core[85]!=core[86]+core[87]+core[88]{return 0;}if core[85]!=jj_cfg_explicit_terminator_count(core){return 0;}if core[71]!=jj_semantic_cir_structure_seal(core){return 0;}return 1;}
fn jj_semantic_cir_structure_view_ready(core:*i64)->i64{if jj_semantic_cir_view_ready(core)==0{return 0;}if core[68]<=0{return 0;}if core[69]<=0{return 0;}if core[70]<=0{return 0;}if core[84]<0{return 0;}if core[85]<=0{return 0;}if core[86]<0{return 0;}if core[87]<0{return 0;}if core[88]<=0{return 0;}if core[71]==0{return 0;}return 1;}
fn jj_semantic_cir_structure_version(core:*i64)->i64{if jj_semantic_cir_structure_view_ready(core)==0{return 0;}return 8;}
fn jj_semantic_cir_function_count(core:*i64)->i64{if jj_semantic_cir_structure_view_ready(core)==0{return 0;}return core[68];}
fn jj_semantic_cir_block_count(core:*i64)->i64{if jj_semantic_cir_structure_view_ready(core)==0{return 0;}return core[69];}
fn jj_semantic_cir_expression_count(core:*i64)->i64{if jj_semantic_cir_structure_view_ready(core)==0{return 0;}return core[70];}
fn jj_semantic_cir_memory_effect_count(core:*i64)->i64{if jj_semantic_cir_structure_view_ready(core)==0{return 0;}return core[84];}
fn jj_semantic_cir_terminator_count(core:*i64)->i64{if jj_semantic_cir_structure_view_ready(core)==0{return 0;}return core[85];}
fn jj_semantic_cir_branch_count(core:*i64)->i64{if jj_semantic_cir_structure_view_ready(core)==0{return 0;}return core[86];}
fn jj_semantic_cir_conditional_count(core:*i64)->i64{if jj_semantic_cir_structure_view_ready(core)==0{return 0;}return core[87];}
fn jj_semantic_cir_return_count(core:*i64)->i64{if jj_semantic_cir_structure_view_ready(core)==0{return 0;}return core[88];}
fn jj_semantic_cir_version(core:*i64)->i64{if jj_semantic_cir_view_ready(core)==0{return 0;}return 1;}
fn jj_semantic_cir_body_end(core:*i64)->i64{if jj_semantic_cir_view_ready(core)==0{return 0;}return core[62];}
fn jj_semantic_cir_operation_count(core:*i64)->i64{if jj_semantic_cir_view_ready(core)==0{return 0;}return core[65];}
