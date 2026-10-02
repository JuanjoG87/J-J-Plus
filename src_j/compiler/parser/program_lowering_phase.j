// Program lowering phase v9. This module accepts only the sealed semantic
// authority: typed parent-child nodes, symbol index and semantic CIR stream.
// It never receives scanner state, syntax leaves, parser state or frontend bytecode.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_semantic_phase_valid(p0:*i64)->i64;
extern fn jj_core_index_version(p0:*i64)->i64;
extern fn jj_typed_node_arena_valid(p0:*i64)->i64;
extern fn jj_semantic_cir_valid(p0:*i64)->i64;
extern fn jj_semantic_cir_version(p0:*i64)->i64;
extern fn jj_semantic_cir_body_end(p0:*i64)->i64;
extern fn jj_semantic_cir_structure_valid(p0:*i64)->i64;
extern fn jj_semantic_cir_structure_version(p0:*i64)->i64;
extern fn jj_operand_tree_valid(p0:*i64)->i64;
extern fn jj_operand_tree_version(p0:*i64)->i64;
extern fn jj_cfg_valid(p0:*i64)->i64;
extern fn jj_cfg_version(p0:*i64)->i64;
extern fn jj_join_view_ready(p0:*i64)->i64;
extern fn jj_join_view_version(p0:*i64)->i64;
extern fn jj_cir_verifier_valid(p0:*i64)->i64;
extern fn jj_parallel_valid(p0:*i64)->i64;
extern fn jj_parallel_version(p0:*i64)->i64;
extern fn jj_parallel_op_count(p0:*i64)->i64;
extern fn jj_parallel_copy_count(p0:*i64)->i64;
extern fn jj_cirx_materialize(p0:*i64)->i64;
extern fn jj_cirx_receipt_finish(p0:*i64)->i64;
extern fn jj_cirx_receipt_valid(p0:*i64)->i64;
extern fn jj_cirx_version(p0:*i64)->i64;
extern fn jj_cirx_offset(p0:*i64)->i64;
extern fn jj_cirx_end(p0:*i64)->i64;
extern fn jj_cirx_op_count(p0:*i64)->i64;
extern fn jj_ast16_materialize_function_table(p0:*i64,p1:*i8,p2:i64)->i64;
extern fn jj_core_function_count(p0:*i64)->i64;
extern fn jj_core_source_map_count(p0:*i64)->i64;
extern fn jj_c_wr64(p0:*i8,p1:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_program_lowering_execute(typed_state:*i64,core:*i64)->i64{
  if typed_state==0{return 0;}if core==0{return 0;}if jj_semantic_phase_valid(typed_state)==0{return 0;}if typed_state[2]!=core as i64{return 0;}if jj_core_index_version(core)!=2{return 0;}if jj_typed_node_arena_valid(core)==0{return 0;}if jj_semantic_cir_valid(core)==0{return 0;}if jj_semantic_cir_version(core)!=1{return 0;}if jj_semantic_cir_structure_valid(core)==0{return 0;}if jj_semantic_cir_structure_version(core)!=8{return 0;}if jj_cfg_valid(core)==0{return 0;}if jj_cfg_version(core)!=2{return 0;}if jj_join_view_ready(core)==0{return 0;}if jj_join_view_version(core)!=1{return 0;}if jj_cir_verifier_valid(core)==0{return 0;}if jj_parallel_valid(core)==0{return 0;}if jj_parallel_version(core)!=1{return 0;}if jj_parallel_op_count(core)!=jj_parallel_copy_count(core)*2{return 0;}if jj_operand_tree_valid(core)==0{return 0;}if jj_operand_tree_version(core)!=3{return 0;}var program:*i8=typed_state[3] as *i8;var capacity:i64=typed_state[4];if program==0{return 0;}if capacity<65536{return 0;}var body_end:i64=jj_semantic_cir_body_end(core);if body_end<=48{return 0;}if typed_state[6]!=body_end{return 0;}if core[9]!=body_end{return 0;}if jj_cirx_materialize(core)==0{return 0;}if jj_cirx_receipt_finish(core)==0{return 0;}if jj_cirx_receipt_valid(core)==0{return 0;}if jj_cirx_version(core)!=1{return 0;}if jj_cirx_offset(core)!=body_end{return 0;}if jj_cirx_end(core)!=core[9]{return 0;}if jj_cirx_op_count(core)!=jj_parallel_op_count(core){return 0;}core[44]=core[27];core[45]=core[25];if jj_ast16_materialize_function_table(core,program,capacity)==0{return 0;}var program_size:i64=core[9];if program_size>capacity{return 0;}if program_size<body_end{return 0;}core[40]=program_size;if jj_c_wr64(program,0x4a4a564d52353230)==0{return 0;}if jj_c_wr64(program+8,program_size)==0{return 0;}if jj_c_wr64(program+16,jj_core_function_count(core))==0{return 0;}if jj_c_wr64(program+24,jj_core_source_map_count(core))==0{return 0;}if jj_c_wr64(program+40,body_end)==0{return 0;}return program_size;
}
