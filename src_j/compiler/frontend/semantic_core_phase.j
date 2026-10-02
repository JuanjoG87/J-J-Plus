// Semantic core publication v12: sealed typed tree, versioned symbols and semantic CIR authority.
// Final publication consumes only the versioned AST authority, never parser state.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_c_name_equal(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_c_struct_type(p0:i64)->i64;
extern fn jj_c_struct_pointer_type(p0:i64)->i64;
extern fn jj_c_struct_slots(p0:*i64,p1:i64)->i64;
extern fn jj_c_type_slots(p0:*i64,p1:i64)->i64;
extern fn jj_core_index_record(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_core_index_find_name(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_core_index_append(p0:*i64,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_core_function_count(p0:*i64)->i64;
extern fn jj_core_source_map_count(p0:*i64)->i64;
extern fn jj_ast_publication_valid(p0:*i64)->i64;
extern fn jj_program_semantic_build(p0:*i64,p1:*i64)->i64;
extern fn jj_program_lowering_execute(p0:*i64,p1:*i64)->i64;
extern fn jj_ast16_node_count(p0:*i64)->i64;
extern fn jj_ast16_span_count(p0:*i64)->i64;
extern fn jj_ast16_map_count(p0:*i64)->i64;
extern fn jj_core_index_valid(p0:*i64)->i64;
extern fn jj_core_index_version(p0:*i64)->i64;
extern fn jj_ast_publication_source_base(p0:*i64)->i64;
extern fn jj_ast_publication_source_length(p0:*i64)->i64;
extern fn jj_typed_node_arena_valid(p0:*i64)->i64;
extern fn jj_typed_node_arena_version(p0:*i64)->i64;
extern fn jj_typed_node_count(p0:*i64)->i64;
extern fn jj_typed_node_root(p0:*i64)->i64;
extern fn jj_typed_node_parent(p0:*i64,p1:i64)->i64;
extern fn jj_typed_node_depth(p0:*i64,p1:i64)->i64;
extern fn jj_typed_node_child_count(p0:*i64,p1:i64)->i64;
extern fn jj_typed_node_child_at(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_ast16_node_kind(p0:*i64,p1:i64)->i64;
extern fn jj_ast16_node_type(p0:*i64,p1:i64)->i64;
extern fn jj_semantic_cir_valid(p0:*i64)->i64;
extern fn jj_semantic_cir_version(p0:*i64)->i64;
extern fn jj_semantic_cir_body_end(p0:*i64)->i64;
extern fn jj_semantic_cir_operation_count(p0:*i64)->i64;
extern fn jj_semantic_cir_structure_valid(p0:*i64)->i64;
extern fn jj_semantic_cir_structure_version(p0:*i64)->i64;
extern fn jj_semantic_cir_function_count(p0:*i64)->i64;
extern fn jj_semantic_cir_block_count(p0:*i64)->i64;
extern fn jj_semantic_cir_expression_count(p0:*i64)->i64;
extern fn jj_semantic_cir_memory_effect_count(p0:*i64)->i64;
extern fn jj_semantic_cir_terminator_count(p0:*i64)->i64;
extern fn jj_semantic_cir_branch_count(p0:*i64)->i64;
extern fn jj_semantic_cir_conditional_count(p0:*i64)->i64;
extern fn jj_semantic_cir_return_count(p0:*i64)->i64;
extern fn jj_cirx_receipt_valid(p0:*i64)->i64;
extern fn jj_cirx_version(p0:*i64)->i64;
extern fn jj_cirx_offset(p0:*i64)->i64;
extern fn jj_cirx_end(p0:*i64)->i64;
extern fn jj_cirx_block_count(p0:*i64)->i64;
extern fn jj_cirx_split_count(p0:*i64)->i64;
extern fn jj_cirx_copy_count(p0:*i64)->i64;
extern fn jj_cirx_op_count(p0:*i64)->i64;
extern fn jj_cirx_temp_count(p0:*i64)->i64;
extern fn jj_operand_tree_valid(p0:*i64)->i64;
extern fn jj_operand_tree_version(p0:*i64)->i64;
extern fn jj_operand_tree_count(p0:*i64)->i64;
extern fn jj_operand_tree_root_count(p0:*i64)->i64;
extern fn jj_operand_tree_capacity(p0:*i64)->i64;
extern fn jj_operand_tree_kind(p0:*i64,p1:i64)->i64;
extern fn jj_operand_tree_type(p0:*i64,p1:i64)->i64;
extern fn jj_operand_tree_parent(p0:*i64,p1:i64)->i64;
extern fn jj_operand_tree_role(p0:*i64,p1:i64)->i64;
extern fn jj_operand_tree_owner(p0:*i64,p1:i64)->i64;
extern fn jj_operand_tree_span_start(p0:*i64,p1:i64)->i64;
extern fn jj_operand_tree_span_count(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_valid(p0:*i64)->i64;
extern fn jj_cfg_version(p0:*i64)->i64;
extern fn jj_cfg_block_count(p0:*i64)->i64;
extern fn jj_cfg_edge_count(p0:*i64)->i64;
extern fn jj_cfg_explicit_terminator_count(p0:*i64)->i64;
extern fn jj_cfg_synthetic_branch_count(p0:*i64)->i64;
extern fn jj_cfg_block_start(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_block_end(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_block_function(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_block_terminator_kind(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_block_terminator_pc(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_block_successor_count(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_block_successor(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cfg_block_terminator_operand(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_block_predecessor_count(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_block_reachable(p0:*i64,p1:i64)->i64;
extern fn jj_cfg_unreachable_block_count(p0:*i64)->i64;
extern fn jj_def_valid(p0:*i64)->i64;
extern fn jj_def_version(p0:*i64)->i64;
extern fn jj_def_access_count(p0:*i64)->i64;
extern fn jj_def_store_count(p0:*i64)->i64;
extern fn jj_def_load_count(p0:*i64)->i64;
extern fn jj_def_mapped_store_count(p0:*i64)->i64;
extern fn jj_join_view_ready(p0:*i64)->i64;
extern fn jj_join_view_version(p0:*i64)->i64;
extern fn jj_join_argument_count(p0:*i64)->i64;
extern fn jj_join_incoming_count(p0:*i64)->i64;
extern fn jj_join_block_count(p0:*i64)->i64;
extern fn jj_join_argument_block(p0:*i64,p1:i64)->i64;
extern fn jj_join_argument_slot(p0:*i64,p1:i64)->i64;
extern fn jj_join_argument_type(p0:*i64,p1:i64)->i64;
extern fn jj_join_argument_incoming_count(p0:*i64,p1:i64)->i64;
extern fn jj_join_argument_first_incoming(p0:*i64,p1:i64)->i64;
extern fn jj_join_argument_load_pc(p0:*i64,p1:i64)->i64;
extern fn jj_join_incoming_predecessor(p0:*i64,p1:i64)->i64;
extern fn jj_join_incoming_value(p0:*i64,p1:i64)->i64;
extern fn jj_edge_valid(p0:*i64)->i64;
extern fn jj_edge_version(p0:*i64)->i64;
extern fn jj_edge_copy_count(p0:*i64)->i64;
extern fn jj_edge_split_count(p0:*i64)->i64;
extern fn jj_edge_effective_block_count(p0:*i64)->i64;
extern fn jj_edge_copy_source(p0:*i64,p1:i64)->i64;
extern fn jj_edge_copy_target(p0:*i64,p1:i64)->i64;
extern fn jj_edge_copy_slot(p0:*i64,p1:i64)->i64;
extern fn jj_edge_copy_value(p0:*i64,p1:i64)->i64;
extern fn jj_edge_copy_type(p0:*i64,p1:i64)->i64;
extern fn jj_edge_copy_placement_kind(p0:*i64,p1:i64)->i64;
extern fn jj_edge_copy_placement_block(p0:*i64,p1:i64)->i64;
extern fn jj_cir_verifier_valid(p0:*i64)->i64;
extern fn jj_parallel_valid(p0:*i64)->i64;
extern fn jj_parallel_version(p0:*i64)->i64;
extern fn jj_cir_verifier_version(p0:*i64)->i64;
extern fn jj_cir_verifier_check_count(p0:*i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_c_array_type(type: i64) -> i64 { if type == 4 { return 1; } if type == 7 { return 1; } if type == 10 { return 1; } if type>=32{if type<=95{return 1;}} return 0; }

fn jj_c_find_local(core: *i64, start: i64, count: i64) -> i64 {
  var source: *i8 = core[0] as *i8; var i: i64 = 0;
  while i < core[12] { var base: i64 = 500 + i * 5; if jj_c_name_equal(source, start, count, core[base], core[base + 1]) != 0 { return i + 1; } i = i + 1; }
  return 0;
}

fn jj_c_add_local(core: *i64, start: i64, count: i64, type: i64, array_count: i64) -> i64 {
  if core[12] >= 512 { return 0; } if jj_c_find_local(core, start, count) != 0 { return 0; }
  var slots: i64 = 1; if jj_c_array_type(type) != 0 { slots = array_count; if slots == 0 { return 0; } } else { if jj_c_struct_type(type)!=0{slots=jj_c_type_slots(core,type);if slots==0{return 0;}} }
  if core[13] + slots > 32768 { return 0; }
  var base: i64 = 500 + core[12] * 5; core[base] = start; core[base + 1] = count; core[base + 2] = type; core[base + 3] = core[13]; core[base + 4] = array_count;
  core[12] = core[12] + 1; core[13] = core[13] + slots; if jj_c_struct_type(type)!=0{var storage:[2]i64;storage[0]=core[base+3];storage[1]=slots;if jj_core_index_append(core,8,storage as *i64,2)==0{return 0;}} return core[12];
}

fn jj_c_find_function(core: *i64, start: i64, count: i64) -> i64 { return jj_core_index_find_name(core,1,start,count); }

fn jj_c_scalar_type(type: i64) -> i64 { if type == 1 { return 1; } if type == 5 { return 1; } if type == 8 { return 1; } return 0; }

fn jj_c_pointer_type(type: i64) -> i64 { if type == 2 { return 1; } if type == 3 { return 1; } if type == 6 { return 1; } if type == 9 { return 1; } if jj_c_struct_pointer_type(type)!=0{return 1;} return 0; }

fn jj_c_signature_code(type: i64) -> i64 { if type == 252 { return 13; } if type == 254 { return 14; } if type == 255 { return 2; } if type == 1 { return 2; } if type == 5 { return 4; } if type == 8 { return 7; } if type == 2 { return 3; } if type == 3 { return 5; } if type == 4 { return 5; } if type == 6 { return 6; } if type == 7 { return 6; } if type == 9 { return 8; } if type == 10 { return 8; } if jj_c_struct_pointer_type(type)!=0{return 9+(type-200);} return 0; }

fn jj_c_common_numeric(a: i64, b: i64) -> i64 { if jj_c_scalar_type(a) == 0 { return 0; } if jj_c_scalar_type(b) == 0 { return 0; } if a == 5 { return 5; } if b == 5 { return 5; } if a==8{if b==8{return 8;}} return 1; }

fn jj_c_assign_compatible(target: i64, value: i64) -> i64 { if target>=252{if target!=253{if target<=255{if value==target{return 1;}if target==252{if value==253{return 1;}}if target==255{if value==1{return 1;}}return 0;}}} if jj_c_struct_type(target)!=0{if target==value{return 1;}return 0;}if target>=32{if target<=95{if target==value{return 1;}return 0;}} if jj_c_scalar_type(target) != 0 { return jj_c_scalar_type(value); } if jj_c_pointer_type(target) != 0 { if target == value { return 1; } if target == 3 { if value == 4 { return 1; } } if target == 6 { if value == 7 { return 1; } } if target==9{if value==10{return 1;}} } return 0; }

fn jj_c_find_prototype(core: *i64, start: i64, count: i64) -> i64 { return jj_core_index_find_name(core,2,start,count); }

fn jj_c_add_prototype(core: *i64, start: i64, count: i64, argc: i64, signature: i64, return_type: i64) -> i64 {
  if jj_c_find_prototype(core,start,count)!=0{return 0;}var fields:[7]i64;fields[0]=start;fields[1]=count;fields[2]=argc;fields[3]=signature;fields[4]=return_type;
  if jj_core_index_append(core,2,fields as *i64,5)==0{return 0;}core[21]=core[21]+1;return core[21];
}

fn jj_c_wr64(p:*i8,value:i64)->i64{
  if p==0{return 0;}var i:i64=0;while i<8{p[i]=value>>>(i*8);i=i+1;}return 1;
}
fn jj_semantic_phase_clear(state:*i64)->i64{if state==0{return 0;}var i:i64=0;while i<12{state[i]=0;i=i+1;}return 1;}
fn jj_semantic_phase_seal(state:*i64)->i64{var seal:i64=(state as i64)^0x4a4a53454d534539;var i:i64=0;while i<11{seal=seal^state[i];i=i+1;}return seal;}
fn jj_semantic_phase_valid(state:*i64)->i64{
  if state==0{return 0;}if state[0]!=0x4a4a53454d303039{return 0;}if state[1]==0{return 0;}if jj_ast_publication_valid(state[1] as *i64)==0{return 0;}if state[2]==0{return 0;}if state[3]==0{return 0;}if state[4]<65536{return 0;}if state[5]!=5{if state[5]!=6{if state[5]!=7{if state[5]!=8{if state[5]!=9{if state[5]!=10{return 0;}}}}}}if state[6]<=48{return 0;}if state[6]>state[4]{return 0;}if state[7]<=0{return 0;}if state[8]<0{return 0;}if state[9]<=0{return 0;}if state[10]<=0{return 0;}
  var core:*i64=state[2] as *i64;if core[7]!=state[3]{return 0;}if core[8]!=state[4]{return 0;}if core[9]!=state[6]{return 0;}if core[0]!=jj_ast_publication_source_base(state[1] as *i64){return 0;}if core[1]!=jj_ast_publication_source_length(state[1] as *i64){return 0;}if jj_core_index_valid(core)==0{return 0;}if jj_core_index_version(core)!=2{return 0;}if jj_typed_node_arena_valid(core)==0{return 0;}if jj_typed_node_arena_version(core)!=1{return 0;}if jj_semantic_cir_valid(core)==0{return 0;}if jj_semantic_cir_version(core)!=1{return 0;}if jj_semantic_cir_structure_valid(core)==0{return 0;}if jj_semantic_cir_structure_version(core)!=8{return 0;}if jj_cfg_valid(core)==0{return 0;}if jj_cfg_version(core)!=2{return 0;}if jj_def_valid(core)==0{return 0;}if jj_def_version(core)!=2{return 0;}if jj_join_view_ready(core)==0{return 0;}if jj_join_view_version(core)!=1{return 0;}if jj_edge_valid(core)==0{return 0;}if jj_parallel_valid(core)==0{return 0;}if jj_parallel_version(core)!=1{return 0;}if jj_cir_verifier_valid(core)==0{return 0;}if jj_cir_verifier_version(core)!=3{return 0;}if jj_operand_tree_valid(core)==0{return 0;}if jj_operand_tree_version(core)!=3{return 0;}if jj_typed_node_count(core)!=state[7]{return 0;}if jj_ast16_node_count(core)!=state[7]{return 0;}if jj_ast16_map_count(core)!=state[8]{return 0;}if jj_core_function_count(core)!=state[9]{return 0;}if jj_ast16_span_count(core)!=state[10]{return 0;}if jj_semantic_cir_body_end(core)>state[6]{return 0;}if core[176]!=0{if jj_cirx_receipt_valid(core)==0{return 0;}}var program_end:i64=state[3]+state[4];if program_end<=state[3]{return 0;}if state[11]!=jj_semantic_phase_seal(state){return 0;}return 1;
}
fn jj_semantic_phase_publish(state:*i64,ast_state:*i64,core:*i64,program:*i8,program_capacity:i64,target:i64)->i64{if state==0{return 0;}if ast_state==0{return 0;}if core==0{return 0;}if program==0{return 0;}state[0]=0x4a4a53454d303039;state[1]=ast_state as i64;state[2]=core as i64;state[3]=program as i64;state[4]=program_capacity;state[5]=target;state[6]=core[9];state[7]=jj_typed_node_count(core);state[8]=jj_ast16_map_count(core);state[9]=jj_core_function_count(core);state[10]=jj_ast16_span_count(core);state[11]=jj_semantic_phase_seal(state);return jj_semantic_phase_valid(state);}
fn jj_semantic_phase_execute(state:*i64,ast_state:*i64,core:*i64,context:*i64)->i64{
  if state==0{return 0;}if jj_semantic_phase_clear(state)==0{return 0;}if ast_state==0{return 0;}if core==0{return 0;}if context==0{return 0;}if jj_ast_publication_valid(ast_state)==0{return 0;}
  var program:*i8=context[0] as *i8;var program_capacity:i64=context[1];var target:i64=context[2];if program==0{return 0;}if program_capacity<65536{return 0;}if target!=5{if target!=6{if target!=7{if target!=8{if target!=9{if target!=10{return 0;}}}}}}
  var state_base:i64=state as i64;var state_end:i64=state_base+96;var ast_base:i64=ast_state as i64;var ast_end:i64=ast_base+96;var core_base:i64=core as i64;var core_end:i64=core_base+32768;var program_base:i64=program as i64;var program_end:i64=program_base+program_capacity;if state_end<=state_base{return 0;}if ast_end<=ast_base{return 0;}if core_end<=core_base{return 0;}if program_end<=program_base{return 0;}if state_end>ast_base{if ast_end>state_base{return 0;}}if state_end>core_base{if core_end>state_base{return 0;}}if state_end>program_base{if program_end>state_base{return 0;}}
  if core[7]!=program_base{return 0;}if core[8]!=program_capacity{return 0;}if jj_core_index_version(core)!=2{return 0;}var semantic_target:i64=core[18];if semantic_target!=target{return 0;}if target==8{core[18]=5;}var build_result:i64=jj_program_semantic_build(ast_state,core);core[18]=semantic_target;if build_result==0{return 0;}var effective_capacity:i64=core[8];if effective_capacity<65536{return 0;}if effective_capacity>=program_capacity{return 0;}if jj_semantic_phase_publish(state,ast_state,core,program,effective_capacity,target)==0{return 0;}var program_size:i64=jj_program_lowering_execute(state,core);if program_size<=48{jj_semantic_phase_clear(state);return 0;}if jj_semantic_phase_publish(state,ast_state,core,program,effective_capacity,target)==0{jj_semantic_phase_clear(state);return 0;}return program_size;
}
