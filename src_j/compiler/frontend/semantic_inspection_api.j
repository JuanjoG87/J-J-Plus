// Contract-only semantic inspection surface. Excluded from Root/Profile B closures.
extern fn jj_semantic_phase_valid(p0:*i64)->i64;
extern fn jj_c_array_type(p0:i64)->i64;
extern fn jj_c_name_equal(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_c_struct_type(p0:i64)->i64;
extern fn jj_c_struct_pointer_type(p0:i64)->i64;
extern fn jj_c_struct_slots(p0:*i64,p1:i64)->i64;
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
fn jj_semantic_symbol_table_version(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_core_index_version(state[2] as *i64);}
fn jj_semantic_symbol_record_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}var core:*i64=state[2] as *i64;return core[37];}
fn jj_semantic_typed_arena_version(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_typed_node_arena_version(state[2] as *i64);}
fn jj_semantic_typed_node_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_typed_node_count(state[2] as *i64);}
fn jj_semantic_typed_root(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_typed_node_root(state[2] as *i64);}
fn jj_semantic_typed_parent(state:*i64,node_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_typed_node_parent(state[2] as *i64,node_ref);}
fn jj_semantic_typed_depth(state:*i64,node_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_typed_node_depth(state[2] as *i64,node_ref);}
fn jj_semantic_typed_child_count(state:*i64,parent_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_typed_node_child_count(state[2] as *i64,parent_ref);}
fn jj_semantic_typed_child_at(state:*i64,parent_ref:i64,ordinal:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_typed_node_child_at(state[2] as *i64,parent_ref,ordinal);}
fn jj_semantic_typed_node_kind(state:*i64,node_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_ast16_node_kind(state[2] as *i64,node_ref);}
fn jj_semantic_typed_node_type(state:*i64,node_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_ast16_node_type(state[2] as *i64,node_ref);}
fn jj_semantic_cir_stream_version(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_version(state[2] as *i64);}
fn jj_semantic_cir_stream_operation_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_operation_count(state[2] as *i64);}
fn jj_semantic_cir_stream_body_end(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_body_end(state[2] as *i64);}
fn jj_semantic_cir_structure_version_get(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_structure_version(state[2] as *i64);}
fn jj_semantic_cir_function_count_get(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_function_count(state[2] as *i64);}
fn jj_semantic_cir_block_count_get(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_block_count(state[2] as *i64);}
fn jj_semantic_cir_expression_count_get(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_expression_count(state[2] as *i64);}
fn jj_semantic_cir_memory_effect_count_get(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_memory_effect_count(state[2] as *i64);}
fn jj_semantic_cir_terminator_count_get(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_terminator_count(state[2] as *i64);}
fn jj_semantic_cir_branch_count_get(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_branch_count(state[2] as *i64);}
fn jj_semantic_cir_conditional_count_get(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_conditional_count(state[2] as *i64);}
fn jj_semantic_cir_return_count_get(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_semantic_cir_return_count(state[2] as *i64);}
fn jj_semantic_cir_extension_version(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cirx_version(state[2] as *i64);}
fn jj_semantic_cir_extension_offset(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cirx_offset(state[2] as *i64);}
fn jj_semantic_cir_extension_end(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cirx_end(state[2] as *i64);}
fn jj_semantic_cir_effective_block_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cirx_block_count(state[2] as *i64);}
fn jj_semantic_cir_split_block_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cirx_split_count(state[2] as *i64);}
fn jj_semantic_cir_parallel_copy_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cirx_copy_count(state[2] as *i64);}
fn jj_semantic_cir_parallel_operation_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cirx_op_count(state[2] as *i64);}
fn jj_semantic_cir_virtual_temp_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cirx_temp_count(state[2] as *i64);}
fn jj_semantic_operand_tree_version(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_operand_tree_version(state[2] as *i64);}
fn jj_semantic_operand_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_operand_tree_count(state[2] as *i64);}
fn jj_semantic_operand_root_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_operand_tree_root_count(state[2] as *i64);}
fn jj_semantic_operand_capacity(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_operand_tree_capacity(state[2] as *i64);}
fn jj_semantic_operand_kind(state:*i64,node_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_operand_tree_kind(state[2] as *i64,node_ref);}
fn jj_semantic_operand_type(state:*i64,node_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_operand_tree_type(state[2] as *i64,node_ref);}
fn jj_semantic_operand_parent(state:*i64,node_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_operand_tree_parent(state[2] as *i64,node_ref);}
fn jj_semantic_operand_role(state:*i64,node_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_operand_tree_role(state[2] as *i64,node_ref);}
fn jj_semantic_operand_owner(state:*i64,node_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_operand_tree_owner(state[2] as *i64,node_ref);}
fn jj_semantic_operand_span_start(state:*i64,node_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_operand_tree_span_start(state[2] as *i64,node_ref);}
fn jj_semantic_operand_span_count(state:*i64,node_ref:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_operand_tree_span_count(state[2] as *i64,node_ref);}

fn jj_semantic_cfg_version(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_version(state[2] as *i64);}
fn jj_semantic_cfg_block_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_block_count(state[2] as *i64);}
fn jj_semantic_cfg_edge_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_edge_count(state[2] as *i64);}
fn jj_semantic_cfg_explicit_terminator_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_explicit_terminator_count(state[2] as *i64);}
fn jj_semantic_cfg_synthetic_branch_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_synthetic_branch_count(state[2] as *i64);}
fn jj_semantic_cfg_block_start(state:*i64,block_id:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_block_start(state[2] as *i64,block_id);}
fn jj_semantic_cfg_block_end(state:*i64,block_id:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_block_end(state[2] as *i64,block_id);}
fn jj_semantic_cfg_block_function(state:*i64,block_id:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0-1;}return jj_cfg_block_function(state[2] as *i64,block_id);}
fn jj_semantic_cfg_block_terminator_kind(state:*i64,block_id:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_block_terminator_kind(state[2] as *i64,block_id);}
fn jj_semantic_cfg_block_terminator_pc(state:*i64,block_id:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_block_terminator_pc(state[2] as *i64,block_id);}
fn jj_semantic_cfg_block_successor_count(state:*i64,block_id:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_block_successor_count(state[2] as *i64,block_id);}
fn jj_semantic_cfg_block_successor(state:*i64,block_id:i64,ordinal:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_block_successor(state[2] as *i64,block_id,ordinal);}
fn jj_semantic_cfg_block_terminator_operand(state:*i64,block_id:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_block_terminator_operand(state[2] as *i64,block_id);}
fn jj_semantic_cfg_block_predecessor_count(state:*i64,block_id:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_block_predecessor_count(state[2] as *i64,block_id);}
fn jj_semantic_cfg_block_reachable(state:*i64,block_id:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_block_reachable(state[2] as *i64,block_id);}
fn jj_semantic_cfg_unreachable_block_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cfg_unreachable_block_count(state[2] as *i64);}
fn jj_semantic_definition_version(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_def_version(state[2] as *i64);}
fn jj_semantic_definition_access_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_def_access_count(state[2] as *i64);}
fn jj_semantic_definition_store_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_def_store_count(state[2] as *i64);}
fn jj_semantic_definition_load_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_def_load_count(state[2] as *i64);}
fn jj_semantic_definition_mapped_store_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_def_mapped_store_count(state[2] as *i64);}
fn jj_semantic_join_version(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_view_version(state[2] as *i64);}
fn jj_semantic_join_argument_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_argument_count(state[2] as *i64);}
fn jj_semantic_join_incoming_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_incoming_count(state[2] as *i64);}
fn jj_semantic_join_block_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_block_count(state[2] as *i64);}
fn jj_semantic_join_argument_block(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_argument_block(state[2] as *i64,index);}
fn jj_semantic_join_argument_slot(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_argument_slot(state[2] as *i64,index);}
fn jj_semantic_join_argument_type(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_argument_type(state[2] as *i64,index);}
fn jj_semantic_join_argument_incoming_count(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_argument_incoming_count(state[2] as *i64,index);}
fn jj_semantic_join_argument_first_incoming(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_argument_first_incoming(state[2] as *i64,index);}
fn jj_semantic_join_argument_load_pc(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_argument_load_pc(state[2] as *i64,index);}
fn jj_semantic_join_incoming_predecessor(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_incoming_predecessor(state[2] as *i64,index);}
fn jj_semantic_join_incoming_value(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_join_incoming_value(state[2] as *i64,index);}
fn jj_semantic_edge_copy_version(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_edge_version(state[2] as *i64);}
fn jj_semantic_edge_copy_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_edge_copy_count(state[2] as *i64);}
fn jj_semantic_edge_split_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_edge_split_count(state[2] as *i64);}
fn jj_semantic_edge_effective_block_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_edge_effective_block_count(state[2] as *i64);}
fn jj_semantic_edge_copy_source(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_edge_copy_source(state[2] as *i64,index);}
fn jj_semantic_edge_copy_target(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_edge_copy_target(state[2] as *i64,index);}
fn jj_semantic_edge_copy_slot(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_edge_copy_slot(state[2] as *i64,index);}
fn jj_semantic_edge_copy_value(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_edge_copy_value(state[2] as *i64,index);}
fn jj_semantic_edge_copy_type(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_edge_copy_type(state[2] as *i64,index);}
fn jj_semantic_edge_copy_placement_kind(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_edge_copy_placement_kind(state[2] as *i64,index);}
fn jj_semantic_edge_copy_placement_block(state:*i64,index:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_edge_copy_placement_block(state[2] as *i64,index);}
fn jj_semantic_cir_verifier_version(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cir_verifier_version(state[2] as *i64);}
fn jj_semantic_cir_verifier_check_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}return jj_cir_verifier_check_count(state[2] as *i64);}

// Human-AI effect contract inspection. Kind 10 is a backward-compatible
// extension of the semantic index v2 record space. Fields are:
// function, capability mask, declared reads, declared writes, observed reads,
// observed writes, contract version.
fn jj_semantic_effect_contract_count(state:*i64)->i64{
  if jj_semantic_phase_valid(state)==0{return 0;}var core:*i64=state[2] as *i64;var count:i64=0;
  while jj_core_index_record(core,10,count)!=0{count=count+1;}return count;
}
fn jj_semantic_effect_contract_field(state:*i64,index:i64,field:i64)->i64{
  if jj_semantic_phase_valid(state)==0{return 0-1;}if index<0{return 0-1;}if field<0{return 0-1;}if field>6{return 0-1;}
  var record:*i64=jj_core_index_record(state[2] as *i64,10,index) as *i64;if record==0{return 0-1;}return record[1+field];
}
fn jj_semantic_effect_function(state:*i64,index:i64)->i64{return jj_semantic_effect_contract_field(state,index,0);}
fn jj_semantic_effect_capability_mask(state:*i64,index:i64)->i64{return jj_semantic_effect_contract_field(state,index,1);}
fn jj_semantic_effect_declared_reads(state:*i64,index:i64)->i64{return jj_semantic_effect_contract_field(state,index,2);}
fn jj_semantic_effect_declared_writes(state:*i64,index:i64)->i64{return jj_semantic_effect_contract_field(state,index,3);}
fn jj_semantic_effect_observed_reads(state:*i64,index:i64)->i64{return jj_semantic_effect_contract_field(state,index,4);}
fn jj_semantic_effect_observed_writes(state:*i64,index:i64)->i64{return jj_semantic_effect_contract_field(state,index,5);}
fn jj_semantic_effect_contract_version(state:*i64,index:i64)->i64{return jj_semantic_effect_contract_field(state,index,6);}
// Interprocedural Human-AI effect call summaries. Kind 11 fields are:
// call source start/count, argument role, callee function, required read,
// required write, summary version.
fn jj_semantic_effect_call_count(state:*i64)->i64{
  if jj_semantic_phase_valid(state)==0{return 0;}var core:*i64=state[2] as *i64;var count:i64=0;
  while jj_core_index_record(core,11,count)!=0{count=count+1;}return count;
}
fn jj_semantic_effect_call_field(state:*i64,index:i64,field:i64)->i64{
  if jj_semantic_phase_valid(state)==0{return 0-1;}if index<0{return 0-1;}if field<0{return 0-1;}if field>6{return 0-1;}
  var record:*i64=jj_core_index_record(state[2] as *i64,11,index) as *i64;if record==0{return 0-1;}return record[1+field];
}
fn jj_semantic_effect_call_start(state:*i64,index:i64)->i64{return jj_semantic_effect_call_field(state,index,0);}
fn jj_semantic_effect_call_count_bytes(state:*i64,index:i64)->i64{return jj_semantic_effect_call_field(state,index,1);}
fn jj_semantic_effect_call_argument_role(state:*i64,index:i64)->i64{return jj_semantic_effect_call_field(state,index,2);}
fn jj_semantic_effect_call_callee(state:*i64,index:i64)->i64{return jj_semantic_effect_call_field(state,index,3);}
fn jj_semantic_effect_call_requires_read(state:*i64,index:i64)->i64{return jj_semantic_effect_call_field(state,index,4);}
fn jj_semantic_effect_call_requires_write(state:*i64,index:i64)->i64{return jj_semantic_effect_call_field(state,index,5);}
fn jj_semantic_effect_call_version(state:*i64,index:i64)->i64{return jj_semantic_effect_call_field(state,index,6);}


// Human-AI capability alias provenance. Kind 12 fields are:
// alias local ordinal, source local/parameter ordinal, initializer store node,
// alias source start/count, origin source start, version.
fn jj_semantic_effect_alias_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}var core:*i64=state[2] as *i64;var count:i64=0;while jj_core_index_record(core,12,count)!=0{count=count+1;}return count;}
fn jj_semantic_effect_alias_field(state:*i64,index:i64,field:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0-1;}if index<0{return 0-1;}if field<0{return 0-1;}if field>6{return 0-1;}var record:*i64=jj_core_index_record(state[2] as *i64,12,index) as *i64;if record==0{return 0-1;}return record[1+field];}
fn jj_semantic_effect_alias_local(state:*i64,index:i64)->i64{return jj_semantic_effect_alias_field(state,index,0);}
fn jj_semantic_effect_alias_source(state:*i64,index:i64)->i64{return jj_semantic_effect_alias_field(state,index,1);}
fn jj_semantic_effect_alias_store_node(state:*i64,index:i64)->i64{return jj_semantic_effect_alias_field(state,index,2);}
fn jj_semantic_effect_alias_start(state:*i64,index:i64)->i64{return jj_semantic_effect_alias_field(state,index,3);}
fn jj_semantic_effect_alias_count_bytes(state:*i64,index:i64)->i64{return jj_semantic_effect_alias_field(state,index,4);}
fn jj_semantic_effect_alias_origin_start(state:*i64,index:i64)->i64{return jj_semantic_effect_alias_field(state,index,5);}
fn jj_semantic_effect_alias_version(state:*i64,index:i64)->i64{return jj_semantic_effect_alias_field(state,index,6);}

// Human-AI pointer transform summaries. Kind 13 fields are:
// expression node, source local/parameter ordinal, constant byte offset,
// expression source start/count, version, operator symbol.
fn jj_semantic_effect_transform_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}var core:*i64=state[2] as *i64;var count:i64=0;while jj_core_index_record(core,13,count)!=0{count=count+1;}return count;}
fn jj_semantic_effect_transform_field(state:*i64,index:i64,field:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0-1;}if index<0{return 0-1;}if field<0{return 0-1;}if field>6{return 0-1;}var record:*i64=jj_core_index_record(state[2] as *i64,13,index) as *i64;if record==0{return 0-1;}return record[1+field];}
fn jj_semantic_effect_transform_node(state:*i64,index:i64)->i64{return jj_semantic_effect_transform_field(state,index,0);}
fn jj_semantic_effect_transform_source(state:*i64,index:i64)->i64{return jj_semantic_effect_transform_field(state,index,1);}
fn jj_semantic_effect_transform_offset_bytes(state:*i64,index:i64)->i64{return jj_semantic_effect_transform_field(state,index,2);}
fn jj_semantic_effect_transform_start(state:*i64,index:i64)->i64{return jj_semantic_effect_transform_field(state,index,3);}
fn jj_semantic_effect_transform_count_bytes(state:*i64,index:i64)->i64{return jj_semantic_effect_transform_field(state,index,4);}
fn jj_semantic_effect_transform_version(state:*i64,index:i64)->i64{return jj_semantic_effect_transform_field(state,index,5);}
fn jj_semantic_effect_transform_operator(state:*i64,index:i64)->i64{return jj_semantic_effect_transform_field(state,index,6);}

// Human-AI transformed alias provenance. Kind 14 fields are:
// alias local ordinal, source local/parameter ordinal, initializer store node,
// alias source start, transform node, constant byte offset, version.
fn jj_semantic_effect_transformed_alias_count(state:*i64)->i64{if jj_semantic_phase_valid(state)==0{return 0;}var core:*i64=state[2] as *i64;var count:i64=0;while jj_core_index_record(core,14,count)!=0{count=count+1;}return count;}
fn jj_semantic_effect_transformed_alias_field(state:*i64,index:i64,field:i64)->i64{if jj_semantic_phase_valid(state)==0{return 0-1;}if index<0{return 0-1;}if field<0{return 0-1;}if field>6{return 0-1;}var record:*i64=jj_core_index_record(state[2] as *i64,14,index) as *i64;if record==0{return 0-1;}return record[1+field];}
fn jj_semantic_effect_transformed_alias_local(state:*i64,index:i64)->i64{return jj_semantic_effect_transformed_alias_field(state,index,0);}
fn jj_semantic_effect_transformed_alias_source(state:*i64,index:i64)->i64{return jj_semantic_effect_transformed_alias_field(state,index,1);}
fn jj_semantic_effect_transformed_alias_store_node(state:*i64,index:i64)->i64{return jj_semantic_effect_transformed_alias_field(state,index,2);}
fn jj_semantic_effect_transformed_alias_start(state:*i64,index:i64)->i64{return jj_semantic_effect_transformed_alias_field(state,index,3);}
fn jj_semantic_effect_transformed_alias_transform_node(state:*i64,index:i64)->i64{return jj_semantic_effect_transformed_alias_field(state,index,4);}
fn jj_semantic_effect_transformed_alias_offset_bytes(state:*i64,index:i64)->i64{return jj_semantic_effect_transformed_alias_field(state,index,5);}
fn jj_semantic_effect_transformed_alias_version(state:*i64,index:i64)->i64{return jj_semantic_effect_transformed_alias_field(state,index,6);}

// Preview.11 structured escape events. Kind 15 records are emitted before fail-closed
// return/storage/unverified-call escape diagnostics. Shape packs channel (bits 0..7),
// provenance kind (8..15) and transport kind (16..23). Fields are:
// shape, capability-root ordinal, local ordinal, source start, source count, version.
fn jj_semantic_effect_escape_event_count(state:*i64)->i64{
  if jj_semantic_phase_valid(state)==0{return 0;}var core:*i64=state[2] as *i64;var count:i64=0;while jj_core_index_record(core,15,count)!=0{count=count+1;}return count;
}
fn jj_semantic_effect_escape_event_field(state:*i64,index:i64,field:i64)->i64{
  if jj_semantic_phase_valid(state)==0{return 0-1;}if index<0{return 0-1;}if field<0{return 0-1;}if field>5{return 0-1;}var core:*i64=state[2] as *i64;var record:*i64=jj_core_index_record(core,15,index) as *i64;if record==0{return 0-1;}return record[field+1];
}

// Preview.13 authority-root state ledger. Kind 16 fields are:
// function id, authority-root ordinal, state (1=ACTIVE, 2=TRANSFERRED), generation,
// source/event start/count, version. Initial capability roots remain ACTIVE generation 0;
// internal transfer transitions can invalidate the source and activate a fresh destination root.
// No public transfer syntax is admitted in Preview.13.
fn jj_semantic_authority_state_count(state:*i64)->i64{
  if jj_semantic_phase_valid(state)==0{return 0;}var core:*i64=state[2] as *i64;var count:i64=0;while jj_core_index_record(core,16,count)!=0{count=count+1;}return count;
}
fn jj_semantic_authority_state_field(state:*i64,index:i64,field:i64)->i64{
  if jj_semantic_phase_valid(state)==0{return 0-1;}if index<0{return 0-1;}if field<0{return 0-1;}if field>6{return 0-1;}var core:*i64=state[2] as *i64;var record:*i64=jj_core_index_record(core,16,index) as *i64;if record==0{return 0-1;}return record[field+1];
}
fn jj_semantic_authority_state_function(state:*i64,index:i64)->i64{return jj_semantic_authority_state_field(state,index,0);}
fn jj_semantic_authority_state_root(state:*i64,index:i64)->i64{return jj_semantic_authority_state_field(state,index,1);}
fn jj_semantic_authority_state_value(state:*i64,index:i64)->i64{return jj_semantic_authority_state_field(state,index,2);}
fn jj_semantic_authority_state_generation(state:*i64,index:i64)->i64{return jj_semantic_authority_state_field(state,index,3);}
fn jj_semantic_authority_state_start(state:*i64,index:i64)->i64{return jj_semantic_authority_state_field(state,index,4);}
fn jj_semantic_authority_state_count_bytes(state:*i64,index:i64)->i64{return jj_semantic_authority_state_field(state,index,5);}
fn jj_semantic_authority_state_version(state:*i64,index:i64)->i64{return jj_semantic_authority_state_field(state,index,6);}

// Preview.14 destination-authority bindings. Kind 17 fields are:
// function id, destination local ordinal, original capability provenance root,
// transfer generation, destination declaration span, transfer event span, version.
// A binding does not create a new capability permission; it names the ordinary
// semantic local that owns the single ACTIVE authority lineage after handoff.
fn jj_semantic_authority_binding_count(state:*i64)->i64{
  if jj_semantic_phase_valid(state)==0{return 0;}var core:*i64=state[2] as *i64;var count:i64=0;while jj_core_index_record(core,17,count)!=0{count=count+1;}return count;
}
fn jj_semantic_authority_binding_field(state:*i64,index:i64,field:i64)->i64{
  if jj_semantic_phase_valid(state)==0{return 0-1;}if index<0{return 0-1;}if field<0{return 0-1;}if field>6{return 0-1;}var core:*i64=state[2] as *i64;var record:*i64=jj_core_index_record(core,17,index) as *i64;if record==0{return 0-1;}return record[field+1];
}
fn jj_semantic_authority_binding_function(state:*i64,index:i64)->i64{return jj_semantic_authority_binding_field(state,index,0);}
fn jj_semantic_authority_binding_destination_local(state:*i64,index:i64)->i64{return jj_semantic_authority_binding_field(state,index,1);}
fn jj_semantic_authority_binding_provenance_root(state:*i64,index:i64)->i64{return jj_semantic_authority_binding_field(state,index,2);}
fn jj_semantic_authority_binding_generation(state:*i64,index:i64)->i64{return jj_semantic_authority_binding_field(state,index,3);}
fn jj_semantic_authority_binding_destination_start(state:*i64,index:i64)->i64{var span:i64=jj_semantic_authority_binding_field(state,index,4);if span<0{return 0-1;}return span&0xffffffff;}
fn jj_semantic_authority_binding_destination_count(state:*i64,index:i64)->i64{var span:i64=jj_semantic_authority_binding_field(state,index,4);if span<0{return 0-1;}return (span>>>32)&0xffffffff;}
fn jj_semantic_authority_binding_event_start(state:*i64,index:i64)->i64{var span:i64=jj_semantic_authority_binding_field(state,index,5);if span<0{return 0-1;}return span&0xffffffff;}
fn jj_semantic_authority_binding_event_count(state:*i64,index:i64)->i64{var span:i64=jj_semantic_authority_binding_field(state,index,5);if span<0{return 0-1;}return (span>>>32)&0xffffffff;}
fn jj_semantic_authority_binding_version(state:*i64,index:i64)->i64{return jj_semantic_authority_binding_field(state,index,6);}

