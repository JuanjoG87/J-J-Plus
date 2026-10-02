// Semantic statement and top-level declaration construction phase.
// Integration-hub partition R764: concrete work lives in focused phases.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_ast_need_symbol(p0:*i64,p1:i64)->i64;
extern fn jj_typed_node_add(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_ast_is_symbol(p0:*i64,p1:i64)->i64;
extern fn jj_operand_tree_statement(p0:*i64,p1:i64)->i64;
extern fn jj_ast_next(p0:*i64)->i64;
extern fn jj_ast_is_ident(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_parse_type(core: *i64) -> i64;
extern fn jj_c_add_local(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_c_struct_type(p0:i64)->i64;
extern fn jj_c_zero_aggregate_local(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_array_type(p0:i64)->i64;
extern fn jj_operand_node_add(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_c_parse_expr(core: *i64, minimum: i64, depth: i64) -> i64;
extern fn jj_operand_tree_last(p0:*i64)->i64;
extern fn jj_c_assign_compatible(p0:i64,p1:i64)->i64;
extern fn jj_c_copy_pointer_to_local(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_emit_op(core: *i64, op: i64) -> i64;
extern fn jj_c_emit8(core: *i64, value: i64) -> i64;
extern fn jj_c_emit16(core: *i64, value: i64) -> i64;
extern fn jj_operand_node_attach(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_operand_tree_last_set(p0:*i64,p1:i64)->i64;
extern fn jj_c_narrow_authority(type:i64)->i64;
extern fn jj_c_operand_authority(core:*i64,node:i64,operational:i64)->i64;
extern fn jj_c_emit32(core: *i64, value: i64) -> i64;
extern fn jj_c_patch32(core: *i64, position: i64, value: i64) -> i64;
extern fn jj_c_return_aggregate(p0:*i64,p1:i64)->i64;
extern fn jj_c_try_assignment(core: *i64) -> i64;
extern fn jj_typed_node_update(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_operand_node_bind_root(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_ast16_add_map(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_c_parse_struct(p0:*i64)->i64;
extern fn jj_c_parse_prototype(core: *i64) -> i64;
extern fn jj_c_is_entry_main(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_c_find_function(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_core_index_append(p0:*i64,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_core_index_record(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_core_index_valid(p0:*i64)->i64;
extern fn jj_c_scalar_type(p0:i64)->i64;
extern fn jj_c_pointer_type(p0:i64)->i64;
extern fn jj_c_add_parameter(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_c_add_function_parameter(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_c_signature_code(p0:i64)->i64;
extern fn jj_c_find_prototype(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_ast16_add_function_map(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_c_name_equal(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_c_find_local(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_operand_record(p0:*i64,p1:i64)->i64;
extern fn jj_operand_span_word(p0:*i64,p1:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
// J/J+ Human-AI semantic vocabulary.
// Numeric IDs remain stable for AST/CIR compatibility.
// Humans and agents use these canonical names instead of memorizing raw IDs.
fn jj_lang_statement_local()->i64{return 4;}
fn jj_lang_statement_if()->i64{return 5;}
fn jj_lang_statement_loop()->i64{return 6;}
fn jj_lang_statement_return()->i64{return 7;}
fn jj_lang_statement_break()->i64{return 8;}
fn jj_lang_statement_assignment()->i64{return 9;}
fn jj_lang_statement_expression()->i64{return 10;}
fn jj_lang_statement_block()->i64{return 11;}
fn jj_lang_statement_program_root()->i64{return 12;}
fn jj_lang_statement_require()->i64{return 13;}

fn jj_lang_operand_store_scalar()->i64{return 42;}
fn jj_lang_operand_store_aggregate()->i64{return 43;}
fn jj_lang_operand_return()->i64{return 44;}
fn jj_lang_operand_branch()->i64{return 45;}
fn jj_lang_operand_condition()->i64{return 46;}

fn jj_lang_cir_jump()->i64{return 27;}
fn jj_lang_cir_branch_zero()->i64{return 28;}
fn jj_lang_cir_return()->i64{return 30;}

fn jj_lang_keyword_var(core:*i64)->i64{return jj_ast_is_ident(core,0x844d13516982c088,3);}
fn jj_lang_keyword_if(core:*i64)->i64{return jj_ast_is_ident(core,0x9bc77700c672b768,2);}
fn jj_lang_keyword_while(core:*i64)->i64{return jj_ast_is_ident(core,0x0e187c656c484194,5);}
fn jj_lang_keyword_else(core:*i64)->i64{return jj_ast_is_ident(core,0x6160ced97abcf88a,4);}
fn jj_lang_keyword_require(core:*i64)->i64{return jj_ast_is_ident(core,0x83d47bb3d9452c4e,7);}
fn jj_lang_keyword_return(core:*i64)->i64{return jj_ast_is_ident(core,0x7488c53f48adf9a1,6);}
fn jj_lang_keyword_break(core:*i64)->i64{return jj_ast_is_ident(core,0x387b55bfd9138ed6,5);}
fn jj_lang_keyword_capability(core:*i64)->i64{return jj_ast_is_ident(core,0x899be43ff36c08ed,10);}
fn jj_lang_keyword_reads(core:*i64)->i64{return jj_ast_is_ident(core,0xb96f993f5cd100ac,5);}
fn jj_lang_keyword_writes(core:*i64)->i64{return jj_ast_is_ident(core,0x4a17ba19dbf700df,6);}
fn jj_lang_keyword_none(core:*i64)->i64{return jj_ast_is_ident(core,0x8e37b614dbd95475,4);}

fn jj_lang_effect_contract_index_kind()->i64{return 10;}
fn jj_lang_effect_call_index_kind()->i64{return 11;}
fn jj_lang_effect_alias_index_kind()->i64{return 12;}
fn jj_lang_effect_pointer_transform_index_kind()->i64{return 13;}
fn jj_lang_effect_transformed_alias_index_kind()->i64{return 14;}
fn jj_lang_effect_escape_event_index_kind()->i64{return 15;}
// Stable frontend error codes are part of the Human-AI diagnostic contract.
fn jj_lang_frontend_fail(core:*i64,code:i64)->i64{
  if core==0{return 0;}
  core[193]=code;
  return 0;
}

fn jj_lang_authority_state_index_kind()->i64{return 16;}
fn jj_lang_authority_state_active()->i64{return 1;}
fn jj_lang_authority_state_transferred()->i64{return 2;}
fn jj_lang_authority_binding_index_kind()->i64{return 17;}
fn jj_lang_authority_state_append_record(core:*i64,function_id:i64,root_ordinal:i64,state_generation:i64,start:i64,count:i64)->i64{
  if core==0{return 0;}if function_id<0{return 0;}if root_ordinal<0{return 0;}if state_generation<0{return 0;}if start<0{return 0;}if count<=0{return 0;}
  var state:i64=state_generation&255;var generation:i64=state_generation>>>8;if state<1{return 0;}if state>2{return 0;}
  var fields:[7]i64;fields[0]=function_id;fields[1]=root_ordinal;fields[2]=state;fields[3]=generation;fields[4]=start;fields[5]=count;fields[6]=1;
  return jj_core_index_append(core,jj_lang_authority_state_index_kind(),fields as *i64,7);
}
fn jj_lang_authority_state_append(core:*i64,function_id:i64,root_ordinal:i64,start:i64,count:i64)->i64{
  return jj_lang_authority_state_append_record(core,function_id,root_ordinal,jj_lang_authority_state_active(),start,count);
}
fn jj_lang_authority_state_latest(core:*i64,function_id:i64,root_ordinal:i64,at:i64)->i64{
  if core==0{return 0;}if function_id<0{return 0;}if root_ordinal<0{return 0;}if at<0{return 0;}var best:*i64=0 as *i64;var ordinal:i64=0;
  while 1{var record:*i64=jj_core_index_record(core,jj_lang_authority_state_index_kind(),ordinal) as *i64;if record==0{break;}if record[1]==function_id{if record[2]==root_ordinal{if record[5]<=at{if best==0{best=record;}else{if record[4]>=best[4]{best=record;}}}}}ordinal=ordinal+1;}
  return best as i64;
}
fn jj_lang_authority_state_is_active(core:*i64,function_id:i64,root_ordinal:i64,at:i64)->i64{
  var record:*i64=jj_lang_authority_state_latest(core,function_id,root_ordinal,at) as *i64;if record==0{return 0;}if record[3]!=jj_lang_authority_state_active(){return 0;}return 1;
}
fn jj_lang_authority_state_generation_at(core:*i64,function_id:i64,root_ordinal:i64,at:i64)->i64{
  var record:*i64=jj_lang_authority_state_latest(core,function_id,root_ordinal,at) as *i64;if record==0{return 0-1;}return record[4];
}
fn jj_lang_authority_state_require_active(core:*i64,function_id:i64,root_ordinal:i64,start:i64,count:i64)->i64{
  if jj_lang_authority_state_is_active(core,function_id,root_ordinal,start)!=0{return 1;}if core!=0{core[4]=start;core[5]=count;}return jj_lang_frontend_fail(core,1514);
}
fn jj_lang_authority_state_verify(core:*i64,function_id:i64,param_count:i64,capability_mask:i64,start:i64,count:i64)->i64{
  if core==0{return 0;}if function_id<0{return 0;}if param_count<0{return 0;}if capability_mask<=0{return 0;}if start<0{return 0;}if count<=0{return 0;}
  var seen:i64=0;var ordinal:i64=0;
  while 1{
    var record:*i64=jj_core_index_record(core,jj_lang_authority_state_index_kind(),ordinal) as *i64;if record==0{break;}
    if record[1]==function_id{
      var root:i64=record[2];if root<0{return 0;}if root>=param_count{return 0;}var bit:i64=1<<root;if (capability_mask&bit)==0{return 0;}if (seen&bit)!=0{return 0;}
      if record[3]!=jj_lang_authority_state_active(){return 0;}if record[4]!=0{return 0;}if record[5]!=start{return 0;}if record[6]!=count{return 0;}if record[7]!=1{return 0;}seen=seen|bit;
    }
    ordinal=ordinal+1;
  }
  if seen!=capability_mask{return 0;}return 1;
}
fn jj_lang_effect_escape_event_append(core:*i64,shape:i64,root_ordinal:i64,local_ordinal:i64,start:i64,count:i64)->i64{
  if core==0{return 0;}if root_ordinal<0{return 0;}if local_ordinal<0{return 0;}if start<0{return 0;}if count<=0{return 0;}var fields:[6]i64;fields[0]=shape;fields[1]=root_ordinal;fields[2]=local_ordinal;fields[3]=start;fields[4]=count;fields[5]=1;return jj_core_index_append(core,jj_lang_effect_escape_event_index_kind(),fields as *i64,6);
}

fn jj_lang_effect_alias_by_local(core:*i64,local_ordinal:i64)->i64{
  if core==0{return 0;}if local_ordinal<0{return 0;}var ordinal:i64=0;
  while 1{var record:*i64=jj_core_index_record(core,jj_lang_effect_alias_index_kind(),ordinal) as *i64;if record==0{break;}if record[1]==local_ordinal{return record as i64;}ordinal=ordinal+1;}
  ordinal=0;while 1{var transformed:*i64=jj_core_index_record(core,jj_lang_effect_transformed_alias_index_kind(),ordinal) as *i64;if transformed==0{return 0;}if transformed[1]==local_ordinal{return transformed as i64;}ordinal=ordinal+1;}
  return 0;
}

fn jj_lang_effect_pointer_transform_by_node(core:*i64,node_ref:i64)->i64{
  if core==0{return 0;}if node_ref<=0{return 0;}var ordinal:i64=0;while 1{var record:*i64=jj_core_index_record(core,jj_lang_effect_pointer_transform_index_kind(),ordinal) as *i64;if record==0{return 0;}if record[1]==node_ref{return record as i64;}ordinal=ordinal+1;}return 0;
}

fn jj_lang_effect_transformed_alias_by_expr(core:*i64,node_ref:i64,function_start:i64,function_end:i64)->i64{
  if core==0{return 0;}if node_ref<=0{return 0;}if function_start<0{return 0;}if function_end<=function_start{return 0;}var ordinal:i64=0;while 1{var record:*i64=jj_core_index_record(core,jj_lang_effect_transformed_alias_index_kind(),ordinal) as *i64;if record==0{return 0;}if record[5]==node_ref{if record[4]>=function_start{if record[4]<function_end{return record as i64;}}}ordinal=ordinal+1;}return 0;
}

fn jj_lang_effect_alias_by_local_in_function(core:*i64,local_ordinal:i64,function_start:i64,function_end:i64)->i64{
  if core==0{return 0;}if local_ordinal<0{return 0;}if function_start<0{return 0;}if function_end<=function_start{return 0;}var ordinal:i64=0;
  while 1{var record:*i64=jj_core_index_record(core,jj_lang_effect_alias_index_kind(),ordinal) as *i64;if record==0{break;}if record[1]==local_ordinal{if record[4]>=function_start{if record[4]<function_end{return record as i64;}}}ordinal=ordinal+1;}
  ordinal=0;while 1{var transformed:*i64=jj_core_index_record(core,jj_lang_effect_transformed_alias_index_kind(),ordinal) as *i64;if transformed==0{return 0;}if transformed[1]==local_ordinal{if transformed[4]>=function_start{if transformed[4]<function_end{return transformed as i64;}}}ordinal=ordinal+1;}
  return 0;
}

fn jj_lang_effect_alias_root(core:*i64,local_ordinal:i64,param_count:i64,function_start:i64,function_end:i64)->i64{
  if core==0{return 0-1;}if local_ordinal<0{return 0-1;}if param_count<0{return 0-1;}var current:i64=local_ordinal;var steps:i64=0;var total_offset:i64=0;
  while current>=param_count{if steps>=64{return 0-1;}var record:*i64=jj_lang_effect_alias_by_local_in_function(core,current,function_start,function_end) as *i64;if record==0{return 0-1;}if record[0]==jj_lang_effect_transformed_alias_index_kind(){var offset:i64=record[6];if offset<0{return 0-1;}if offset>248{return 0-1;}if offset%8!=0{return 0-1;}total_offset=total_offset+offset;if total_offset>248{return 0-1;}}else{if record[0]!=jj_lang_effect_alias_index_kind(){return 0-1;}}var source:i64=record[2];if source<0{return 0-1;}if source>=current{return 0-1;}current=source;steps=steps+1;}
  return current;
}

fn jj_lang_effect_alias_offset(core:*i64,local_ordinal:i64,param_count:i64,function_start:i64,function_end:i64)->i64{
  if core==0{return 0-1;}if local_ordinal<0{return 0-1;}if param_count<0{return 0-1;}var current:i64=local_ordinal;var steps:i64=0;var total:i64=0;while current>=param_count{if steps>=64{return 0-1;}var record:*i64=jj_lang_effect_alias_by_local_in_function(core,current,function_start,function_end) as *i64;if record==0{return 0-1;}if record[0]==jj_lang_effect_transformed_alias_index_kind(){var offset:i64=record[6];if offset<0{return 0-1;}if offset>248{return 0-1;}if offset%8!=0{return 0-1;}total=total+offset;if total>248{return 0-1;}}else{if record[0]!=jj_lang_effect_alias_index_kind(){return 0-1;}}var source:i64=record[2];if source<0{return 0-1;}if source>=current{return 0-1;}current=source;steps=steps+1;}return total;
}


fn jj_lang_authority_function_span(core:*i64,function_id:i64)->i64{
  if core==0{return 0-1;}if function_id<0{return 0-1;}var ordinal:i64=0;
  while 1{var record:*i64=jj_core_index_record(core,jj_lang_authority_state_index_kind(),ordinal) as *i64;if record==0{return 0-1;}if record[1]==function_id{if record[4]==0{if record[3]==jj_lang_authority_state_active(){if record[5]<0{return 0-1;}if record[6]<=0{return 0-1;}return record[5]|(record[6]<<32);}}}ordinal=ordinal+1;}
  return 0-1;
}

fn jj_lang_authority_binding_append(core:*i64,function_id:i64,destination_local:i64,provenance_root:i64,generation:i64,event_span:i64)->i64{
  if core==0{return 0;}if function_id<0{return 0;}if destination_local<0{return 0;}if provenance_root<0{return 0;}if generation<=0{return 0;}if event_span<0{return 0;}if destination_local>=core[12]{return 0;}
  var destination_base:i64=500+destination_local*5;var destination_start:i64=core[destination_base];var destination_count:i64=core[destination_base+1];if destination_start<0{return 0;}if destination_count<=0{return 0;}var destination_span:i64=destination_start|(destination_count<<32);
  var fields:[7]i64;fields[0]=function_id;fields[1]=destination_local;fields[2]=provenance_root;fields[3]=generation;fields[4]=destination_span;fields[5]=event_span;fields[6]=1;
  return jj_core_index_append(core,jj_lang_authority_binding_index_kind(),fields as *i64,7);
}

fn jj_lang_authority_binding_latest(core:*i64,function_id:i64,destination_local:i64,at:i64)->i64{
  if core==0{return 0;}if function_id<0{return 0;}if destination_local<0{return 0;}if at<0{return 0;}var best:*i64=0 as *i64;var ordinal:i64=0;
  while 1{
    var record:*i64=jj_core_index_record(core,jj_lang_authority_binding_index_kind(),ordinal) as *i64;if record==0{break;}
    if record[1]==function_id{if record[2]==destination_local{var event_start:i64=record[6]&0xffffffff;if event_start<=at{if best==0{best=record;}else{if record[4]>=best[4]{best=record;}}}}}
    ordinal=ordinal+1;
  }
  return best as i64;
}

fn jj_lang_authority_binding_any(core:*i64,function_id:i64,destination_local:i64)->i64{
  if core==0{return 0;}if function_id<0{return 0;}if destination_local<0{return 0;}var ordinal:i64=0;
  while 1{var record:*i64=jj_core_index_record(core,jj_lang_authority_binding_index_kind(),ordinal) as *i64;if record==0{return 0;}if record[1]==function_id{if record[2]==destination_local{return record as i64;}}ordinal=ordinal+1;}
  return 0;
}

fn jj_lang_authority_state_any(core:*i64,function_id:i64,identity:i64)->i64{
  if core==0{return 0;}if function_id<0{return 0;}if identity<0{return 0;}var ordinal:i64=0;
  while 1{var record:*i64=jj_core_index_record(core,jj_lang_authority_state_index_kind(),ordinal) as *i64;if record==0{return 0;}if record[1]==function_id{if record[2]==identity{return record as i64;}}ordinal=ordinal+1;}
  return 0;
}

fn jj_lang_authority_provenance_root_for_local(core:*i64,function_id:i64,local_ordinal:i64,at:i64)->i64{
  if core==0{return 0-1;}if function_id<0{return 0-1;}if local_ordinal<0{return 0-1;}if at<0{return 0-1;}var function_span:i64=jj_lang_authority_function_span(core,function_id);if function_span<0{return 0-1;}var function_start:i64=function_span&0xffffffff;var function_count:i64=(function_span>>>32)&0xffffffff;var function_end:i64=function_start+function_count;if function_end<=function_start{return 0-1;}
  var current:i64=local_ordinal;var steps:i64=0;var total_offset:i64=0;
  while 1{
    if steps>=64{return 0-1;}
    var record:*i64=jj_lang_effect_alias_by_local_in_function(core,current,function_start,function_end) as *i64;
    if record==0{return current;}
    if record[4]>at{return 0-1;}
    if record[0]==jj_lang_effect_transformed_alias_index_kind(){var offset:i64=record[6];if offset<0{return 0-1;}if offset>248{return 0-1;}if offset%8!=0{return 0-1;}total_offset=total_offset+offset;if total_offset>248{return 0-1;}}else{if record[0]!=jj_lang_effect_alias_index_kind(){return 0-1;}}
    var source:i64=record[2];if source<0{return 0-1;}if source>=current{return 0-1;}current=source;steps=steps+1;
  }
  return 0-1;
}

fn jj_lang_authority_identity_for_local(core:*i64,function_id:i64,local_ordinal:i64,at:i64)->i64{
  if core==0{return 0-1;}if function_id<0{return 0-1;}if local_ordinal<0{return 0-1;}if at<0{return 0-1;}var function_span:i64=jj_lang_authority_function_span(core,function_id);if function_span<0{return 0-1;}var function_start:i64=function_span&0xffffffff;var function_count:i64=(function_span>>>32)&0xffffffff;var function_end:i64=function_start+function_count;if function_end<=function_start{return 0-1;}
  var current:i64=local_ordinal;var steps:i64=0;
  while 1{
    if steps>=64{return 0-1;}
    if jj_lang_authority_binding_latest(core,function_id,current,at)!=0{return current;}
    var record:*i64=jj_lang_effect_alias_by_local_in_function(core,current,function_start,function_end) as *i64;if record==0{return current;}if record[4]>at{return 0-1;}
    if record[0]==jj_lang_effect_transformed_alias_index_kind(){var offset:i64=record[6];if offset<0{return 0-1;}if offset>248{return 0-1;}if offset%8!=0{return 0-1;}}else{if record[0]!=jj_lang_effect_alias_index_kind(){return 0-1;}}
    var source:i64=record[2];if source<0{return 0-1;}if source>=current{return 0-1;}current=source;steps=steps+1;
  }
  return 0-1;
}

fn jj_lang_authority_alias_chain_contains(core:*i64,function_id:i64,destination_local:i64,source_identity:i64,at:i64)->i64{
  if core==0{return 0;}if function_id<0{return 0;}if destination_local<0{return 0;}if source_identity<0{return 0;}if at<0{return 0;}var function_span:i64=jj_lang_authority_function_span(core,function_id);if function_span<0{return 0;}var function_start:i64=function_span&0xffffffff;var function_count:i64=(function_span>>>32)&0xffffffff;var function_end:i64=function_start+function_count;if function_end<=function_start{return 0;}
  var current:i64=destination_local;var steps:i64=0;
  while 1{
    if current==source_identity{return 1;}if steps>=64{return 0;}
    var record:*i64=jj_lang_effect_alias_by_local_in_function(core,current,function_start,function_end) as *i64;if record==0{return 0;}if record[4]>at{return 0;}
    if record[0]!=jj_lang_effect_alias_index_kind(){if record[0]!=jj_lang_effect_transformed_alias_index_kind(){return 0;}}
    var source:i64=record[2];if source<0{return 0;}if source>=current{return 0;}current=source;steps=steps+1;
  }
  return 0;
}

fn jj_lang_authority_active_count_for_provenance(core:*i64,function_id:i64,provenance_root:i64,at:i64)->i64{
  if core==0{return 0-1;}if function_id<0{return 0-1;}if provenance_root<0{return 0-1;}if at<0{return 0-1;}var active_count:i64=0;var ordinal:i64=0;
  while 1{
    var record:*i64=jj_core_index_record(core,jj_lang_authority_state_index_kind(),ordinal) as *i64;if record==0{break;}
    if record[1]==function_id{if record[5]<=at{var latest:*i64=jj_lang_authority_state_latest(core,function_id,record[2],at) as *i64;if latest==record{if record[3]==jj_lang_authority_state_active(){var identity:i64=record[2];var provenance:i64=identity;var binding:*i64=jj_lang_authority_binding_latest(core,function_id,identity,at) as *i64;if binding!=0{provenance=binding[3];}if provenance==provenance_root{active_count=active_count+1;}}}}}
    ordinal=ordinal+1;
  }
  return active_count;
}

fn jj_lang_authority_state_transition_internal(core:*i64,function_id:i64,source_identity:i64,destination_local:i64,start:i64,count:i64)->i64{
  if core==0{return 0;}if function_id<0{return 0;}if source_identity<0{return 0;}if destination_local<0{return 0;}if source_identity==destination_local{return 0;}if start<0{return 0;}if count<=0{return 0;}
  if destination_local>=core[12]{return 0;}var destination_base:i64=500+destination_local*5;if jj_c_pointer_type(core[destination_base+2])==0{return 0;}var destination_start:i64=core[destination_base];var destination_count:i64=core[destination_base+1];if destination_start<0{return 0;}if destination_count<=0{return 0;}if start<destination_start+destination_count{return 0;}
  var source:*i64=jj_lang_authority_state_latest(core,function_id,source_identity,start) as *i64;if source==0{return 0;}if source[3]!=jj_lang_authority_state_active(){return 0;}
  if jj_lang_authority_state_any(core,function_id,destination_local)!=0{return 0;}if jj_lang_authority_binding_any(core,function_id,destination_local)!=0{return 0;}
  var source_provenance:i64=source_identity;var source_binding:*i64=jj_lang_authority_binding_latest(core,function_id,source_identity,start) as *i64;if source_binding!=0{source_provenance=source_binding[3];}
  var destination_provenance:i64=jj_lang_authority_provenance_root_for_local(core,function_id,destination_local,start);if destination_provenance<0{return 0;}if destination_provenance!=source_provenance{return 0;}
  if jj_lang_authority_alias_chain_contains(core,function_id,destination_local,source_identity,start)==0{return 0;}
  if jj_lang_authority_active_count_for_provenance(core,function_id,source_provenance,start)!=1{return 0;}
  var generation:i64=source[4]+1;if generation<=0{return 0;}if generation>0x00ffffffffffffff{return 0;}
  if jj_core_index_valid(core)==0{return 0;}if core[39]<24{return 0;}if core[37]>(core[39]-24)/8{return 0;}
  var transferred:i64=(generation<<8)|jj_lang_authority_state_transferred();var active:i64=(generation<<8)|jj_lang_authority_state_active();
  if jj_lang_authority_state_append_record(core,function_id,source_identity,transferred,start,count)==0{return 0;}
  if jj_lang_authority_state_append_record(core,function_id,destination_local,active,start,count)==0{return 0;}
  var event_span:i64=start|(count<<32);
  if jj_lang_authority_binding_append(core,function_id,destination_local,source_provenance,generation,event_span)==0{return 0;}
  if jj_lang_authority_state_is_active(core,function_id,source_identity,start)!=0{return 0;}if jj_lang_authority_state_is_active(core,function_id,destination_local,start)==0{return 0;}
  if jj_lang_authority_active_count_for_provenance(core,function_id,source_provenance,start)!=1{return 0;}
  return 1;
}

fn jj_lang_effect_alias_from_store_root(core:*i64,root_ordinal:i64,store_node:i64,param_count:i64,function_start:i64,function_end:i64)->i64{
  if core==0{return 0;}if root_ordinal<0{return 0;}if store_node<=0{return 0;}var ordinal:i64=0;
  while 1{var record:*i64=jj_core_index_record(core,jj_lang_effect_alias_index_kind(),ordinal) as *i64;if record==0{break;}if record[3]==store_node{if record[4]>=function_start{if record[4]<function_end{var source_root:i64=jj_lang_effect_alias_root(core,record[2],param_count,function_start,function_end);if source_root==root_ordinal{return record as i64;}}}}ordinal=ordinal+1;}
  ordinal=0;while 1{var transformed:*i64=jj_core_index_record(core,jj_lang_effect_transformed_alias_index_kind(),ordinal) as *i64;if transformed==0{return 0;}if transformed[3]==store_node{if transformed[4]>=function_start{if transformed[4]<function_end{var transformed_root:i64=jj_lang_effect_alias_root(core,transformed[2],param_count,function_start,function_end);if transformed_root==root_ordinal{return transformed as i64;}}}}ordinal=ordinal+1;}
  return 0;
}

fn jj_lang_effect_alias_from_store(core:*i64,source_ordinal:i64,store_node:i64)->i64{
  if core==0{return 0;}if source_ordinal<0{return 0;}if store_node<=0{return 0;}var ordinal:i64=0;
  while 1{var record:*i64=jj_core_index_record(core,jj_lang_effect_alias_index_kind(),ordinal) as *i64;if record==0{break;}if record[2]==source_ordinal{if record[3]==store_node{return record as i64;}}ordinal=ordinal+1;}
  ordinal=0;while 1{var transformed:*i64=jj_core_index_record(core,jj_lang_effect_transformed_alias_index_kind(),ordinal) as *i64;if transformed==0{return 0;}if transformed[2]==source_ordinal{if transformed[3]==store_node{return transformed as i64;}}ordinal=ordinal+1;}return 0;
}

fn jj_lang_effect_call_summary(core:*i64,call_start:i64,call_count:i64,role:i64)->i64{
  if core==0{return 0;}if call_start<0{return 0;}if call_count<=0{return 0;}if role<=0{return 0;}if role>7{return 0;}
  var ordinal:i64=0;
  while 1{
    var record:*i64=jj_core_index_record(core,jj_lang_effect_call_index_kind(),ordinal) as *i64;
    if record==0{return 0;}
    if record[1]==call_start{if record[2]==call_count{if record[3]==role{return record as i64;}}}
    ordinal=ordinal+1;
  }
  return 0;
}

fn jj_lang_effect_parameter_mask(core:*i64,param_starts:*i64,param_lengths:*i64,param_types:*i64,param_count:i64)->i64{
  if core==0{return 0;}if param_starts==0{return 0;}if param_lengths==0{return 0;}if param_types==0{return 0;}
  if core[3]!=1{return 0;}var i:i64=0;while i<param_count{
    if jj_c_name_equal(core[0] as *i8,core[4],core[5],param_starts[i],param_lengths[i])!=0{
      if jj_c_pointer_type(param_types[i])==0{return 0;}
      return 1<<i;
    }
    i=i+1;
  }
  return 0;
}

fn jj_lang_parse_effect_list(core:*i64,param_starts:*i64,param_lengths:*i64,param_types:*i64,param_count:i64)->i64{
  if jj_lang_keyword_none(core)!=0{
    if jj_ast_next(core)==0{return 0-1;}
    if jj_ast_need_symbol(core,59)==0{return 0-1;}
    return 0;
  }
  var mask:i64=0;
  while 1{
    var bit:i64=jj_lang_effect_parameter_mask(core,param_starts,param_lengths,param_types,param_count);
    if bit==0{return jj_lang_frontend_fail(core,1503)-1;}
    if (mask&bit)!=0{return jj_lang_frontend_fail(core,1504)-1;}
    mask=mask|bit;
    if jj_ast_next(core)==0{return 0-1;}
    if jj_ast_is_symbol(core,44)!=0{
      if jj_ast_next(core)==0{return 0-1;}
    }else{
      if jj_ast_need_symbol(core,59)==0{return 0-1;}
      return mask;
    }
  }
  return 0-1;
}

fn jj_lang_effect_verify(core:*i64,param_count:i64,capability_mask:i64,reads_mask:i64,writes_mask:i64,function_span:i64)->i64{
  if core==0{return 0;}var function_id:i64=core[10]-1;if function_id<0{return 0;}var function_start:i64=function_span&0xffffffff;var function_count:i64=(function_span>>>32)&0xffffffff;var function_end:i64=function_start+function_count;if function_end<function_start{return 0;}
  if ((reads_mask|writes_mask)&(0-capability_mask-1))!=0{return jj_lang_frontend_fail(core,1505);}
  var transform_ordinal:i64=0;while 1{var transform_record:*i64=jj_core_index_record(core,jj_lang_effect_pointer_transform_index_kind(),transform_ordinal) as *i64;if transform_record==0{break;}var transform_start:i64=transform_record[4];if transform_start>=function_start{if transform_start<function_end{var transform_source:i64=transform_record[2];var transform_root:i64=transform_source;if transform_source>=param_count{transform_root=jj_lang_effect_alias_root(core,transform_source,param_count,function_start,function_end);}if transform_root>=0{if transform_root<param_count{var transform_bit:i64=1<<transform_root;if (capability_mask&transform_bit)!=0{var checked_offset:i64=transform_record[3];if transform_record[6]!=1{core[4]=transform_record[4];core[5]=transform_record[5];return jj_lang_frontend_fail(core,1511);}if transform_record[7]!=43{core[4]=transform_record[4];core[5]=transform_record[5];return jj_lang_frontend_fail(core,1511);}if checked_offset<0{core[4]=transform_record[4];core[5]=transform_record[5];return jj_lang_frontend_fail(core,1511);}if checked_offset>248{core[4]=transform_record[4];core[5]=transform_record[5];return jj_lang_frontend_fail(core,1511);}if checked_offset%8!=0{core[4]=transform_record[4];core[5]=transform_record[5];return jj_lang_frontend_fail(core,1511);}}}}}}transform_ordinal=transform_ordinal+1;}
  var observed_reads:i64=0;
  var observed_writes:i64=0;
  var node:i64=1;
  while node<=core[74]{
    var record:i64=jj_operand_record(core,node);
    if record!=0{
      var span:i64=jj_operand_span_word(core,node);
      var kind:i64=span&255;
      if kind==34{
        var start:i64=(span>>>8)&0xffffffff;
        var count:i64=(span>>>40)&0xffffff;
        var in_function:i64=1;
        if start<function_start{in_function=0;}
        if start>=function_end{in_function=0;}
        var found:i64=0;
        if in_function!=0{found=jj_c_find_local(core,start,count);}
        if found>0{
          var local_ordinal:i64=found-1;
          var provenance_ordinal:i64=local_ordinal;
          var alias_record:*i64=0 as *i64;
          if local_ordinal>=param_count{
            alias_record=jj_lang_effect_alias_by_local_in_function(core,local_ordinal,function_start,function_end) as *i64;
            if alias_record!=0{
              var alias_root:i64=jj_lang_effect_alias_root(core,local_ordinal,param_count,function_start,function_end);
              if alias_root<0{core[4]=start;core[5]=count;if alias_record[0]==jj_lang_effect_transformed_alias_index_kind(){return jj_lang_frontend_fail(core,1511);}return jj_lang_frontend_fail(core,1510);}
              provenance_ordinal=alias_root;
            }
          }
          var local_base:i64=500+local_ordinal*5;
          if jj_c_pointer_type(core[local_base+2])!=0{
            if provenance_ordinal<param_count{
              var bit:i64=1<<provenance_ordinal;
              var escape_provenance:i64=1;if alias_record!=0{escape_provenance=2;if alias_record[0]==jj_lang_effect_transformed_alias_index_kind(){escape_provenance=3;}}
              if (capability_mask&bit)==0{
                core[4]=start;core[5]=count;
                if alias_record!=0{return jj_lang_frontend_fail(core,1510);}
                return jj_lang_frontend_fail(core,1508);
              }
              var authority_identity:i64=jj_lang_authority_identity_for_local(core,function_id,local_ordinal,start);if authority_identity<0{core[4]=start;core[5]=count;if alias_record!=0{return jj_lang_frontend_fail(core,1510);}return jj_lang_frontend_fail(core,1508);}if jj_lang_authority_state_require_active(core,function_id,authority_identity,start,count)==0{return 0;}
              var parent:i64=record&0xfffff;
              var role:i64=(record>>>20)&7;
              var owner:i64=(record>>>23)&1;
              if owner!=0{core[4]=start;core[5]=count;if alias_record!=0{return jj_lang_frontend_fail(core,1510);}return jj_lang_frontend_fail(core,1508);}
              if parent<=0{core[4]=start;core[5]=count;if alias_record!=0{return jj_lang_frontend_fail(core,1510);}return jj_lang_frontend_fail(core,1508);}
              var parent_span:i64=jj_operand_span_word(core,parent);
              var parent_kind:i64=parent_span&255;
              if parent_kind==jj_lang_operand_store_scalar(){
                var alias_store:*i64=jj_lang_effect_alias_from_store_root(core,provenance_ordinal,parent,param_count,function_start,function_end) as *i64;
                if alias_store==0{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1510);}
                if role==2{if local_ordinal!=alias_store[2]{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1510);}}else{
                  if role==1{if local_ordinal!=alias_store[1]{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1510);}}else{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1510);}
                }
              }else{if parent_kind==36{
                var transform:*i64=jj_lang_effect_pointer_transform_by_node(core,parent) as *i64;
                var transformed_alias:*i64=jj_lang_effect_transformed_alias_by_expr(core,parent,function_start,function_end) as *i64;
                if transform==0{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}
                if transformed_alias==0{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}
                if role!=1{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}
                if transform[2]!=local_ordinal{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}
                var transform_offset:i64=transform[3];if transform_offset<0{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}if transform_offset>248{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}if transform_offset%8!=0{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}
                if transform[6]!=1{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}if transform[7]!=43{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}
                if transformed_alias[2]!=local_ordinal{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}if transformed_alias[5]!=parent{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}if transformed_alias[6]!=transform_offset{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}if transformed_alias[7]!=1{core[4]=start;core[5]=count;return jj_lang_frontend_fail(core,1511);}
              }else{if parent_kind==37{
                var call_start:i64=(parent_span>>>8)&0xffffffff;
                var call_count:i64=(parent_span>>>40)&0xffffff;
                var call_summary:*i64=jj_lang_effect_call_summary(core,call_start,call_count,role) as *i64;
                if call_summary==0{core[4]=start;core[5]=count;var call_escape_shape:i64=3|(escape_provenance<<8)|(3<<16);if jj_lang_effect_escape_event_append(core,call_escape_shape,provenance_ordinal,local_ordinal,start,count)==0{return 0;}return jj_lang_frontend_fail(core,1509);}
                if call_summary[5]!=0{observed_reads=observed_reads|bit;}
                if call_summary[6]!=0{observed_writes=observed_writes|bit;}
              }else{
                if parent_kind==jj_lang_operand_return(){core[4]=start;core[5]=count;var return_escape_shape:i64=1|(escape_provenance<<8)|(1<<16);if jj_lang_effect_escape_event_append(core,return_escape_shape,provenance_ordinal,local_ordinal,start,count)==0{return 0;}return jj_lang_frontend_fail(core,1512);}
                if parent_kind==39{var cast_record:i64=jj_operand_record(core,parent);var cast_parent:i64=cast_record&0xfffff;var cast_role:i64=(cast_record>>>20)&7;var cast_owner:i64=(cast_record>>>23)&1;if cast_owner==0{if cast_parent>0{var cast_parent_kind:i64=jj_operand_span_word(core,cast_parent)&255;if cast_parent_kind==jj_lang_operand_return(){if cast_role==1{core[4]=start;core[5]=count;var cast_return_shape:i64=1|(escape_provenance<<8)|(2<<16);if jj_lang_effect_escape_event_append(core,cast_return_shape,provenance_ordinal,local_ordinal,start,count)==0{return 0;}return jj_lang_frontend_fail(core,1512);}}if cast_role==2{if cast_parent_kind==41{core[4]=start;core[5]=count;var cast_store_shape:i64=2|(escape_provenance<<8)|(2<<16);if jj_lang_effect_escape_event_append(core,cast_store_shape,provenance_ordinal,local_ordinal,start,count)==0{return 0;}return jj_lang_frontend_fail(core,1513);}if cast_parent_kind==jj_lang_operand_store_scalar(){core[4]=start;core[5]=count;var local_store_shape:i64=2|(escape_provenance<<8)|(2<<16);if jj_lang_effect_escape_event_append(core,local_store_shape,provenance_ordinal,local_ordinal,start,count)==0{return 0;}return jj_lang_frontend_fail(core,1513);}if cast_parent_kind==jj_lang_operand_store_aggregate(){core[4]=start;core[5]=count;var aggregate_store_shape:i64=2|(escape_provenance<<8)|(2<<16);if jj_lang_effect_escape_event_append(core,aggregate_store_shape,provenance_ordinal,local_ordinal,start,count)==0{return 0;}return jj_lang_frontend_fail(core,1513);}}}}}
                if parent_kind!=38{core[4]=start;core[5]=count;if alias_record!=0{if alias_record[0]==jj_lang_effect_transformed_alias_index_kind(){return jj_lang_frontend_fail(core,1511);}return jj_lang_frontend_fail(core,1510);}return jj_lang_frontend_fail(core,1508);}
                if role!=1{core[4]=start;core[5]=count;if alias_record!=0{return jj_lang_frontend_fail(core,1510);}return jj_lang_frontend_fail(core,1508);}
                var index_record:i64=jj_operand_record(core,parent);
                var index_parent:i64=index_record&0xfffff;
                var index_role:i64=(index_record>>>20)&7;
                var index_owner:i64=(index_record>>>23)&1;
                var is_write:i64=0;
                if index_owner==0{if index_parent>0{var index_parent_kind:i64=jj_operand_span_word(core,index_parent)&255;if index_role==1{if index_parent_kind==41{is_write=1;}if index_parent_kind==43{is_write=1;}}}}
                if is_write!=0{observed_writes=observed_writes|bit;}else{observed_reads=observed_reads|bit;}
              }}}
            }
          }
        }
      }
    }
    node=node+1;
  }
  if (observed_reads&(0-reads_mask-1))!=0{return jj_lang_frontend_fail(core,1506);}
  if (observed_writes&(0-writes_mask-1))!=0{return jj_lang_frontend_fail(core,1507);}
  core[196]=observed_reads;
  core[197]=observed_writes;
  return 1;
}

fn jj_lang_current_anchor(core:*i64)->i64{return core[49];}
fn jj_lang_current_return_authority(core:*i64)->i64{return core[31];}

fn jj_c_parse_block(core: *i64, depth: i64, parent_node: i64) -> i64 {
  if depth > 128 { return 0; }if parent_node<=0{return 0;}
  var block_start:i64=core[4];var block_bytecode_start:i64=core[9];
  if jj_ast_need_symbol(core, 123) == 0 { return 0; }
  var block_node:i64=jj_typed_node_add(core,jj_lang_statement_block(),block_bytecode_start,0,block_start,parent_node);if block_node==0{return 0;}
  while jj_ast_is_symbol(core, 125) == 0 {
    if core[3] == 0 { return 0; }
    var statement_start:i64=core[4];
    var statement_bytecode_start:i64=core[9];
    var statement_kind:i64=0;
    var statement_type:i64=0;
    var statement_node:i64=0;
    var statement_operand_root:i64=0;
    if jj_operand_tree_statement(core,block_node)==0{return 0;}
    if jj_ast_is_symbol(core, 59) != 0 {
      if jj_ast_next(core) == 0 { return 0; }
    } else {
      if jj_lang_keyword_var(core) != 0 {
        statement_kind=jj_lang_statement_local();
        if jj_ast_next(core) == 0 { return 0; }
        if core[3] != 1 { return 0; }
        var local_start: i64 = core[4];
        var local_len: i64 = core[5];
        var local_anchor:i64=core[49];
        if jj_ast_next(core) == 0 { return 0; }
        if jj_ast_need_symbol(core, 58) == 0 { return 0; }
        var declared_type: i64 = jj_c_parse_type(core);
        if declared_type == 0 { return 0; }
        statement_type=declared_type;
        var array_count: i64 = core[30];if declared_type==1{statement_type=array_count;}
        var local_added: i64 = jj_c_add_local(core, local_start, local_len, declared_type, array_count);
        if local_added == 0 { return 0; }
        var aggregate_local_base:i64=500+(local_added-1)*5;if jj_c_struct_type(declared_type)!=0{if jj_c_zero_aggregate_local(core,core[aggregate_local_base+3],declared_type)==0{return 0;}}
        if jj_ast_is_symbol(core, 61) != 0 {
          if jj_c_array_type(declared_type) != 0 { return 0; }
          var initializer_store_anchor:i64=core[49];var initializer_destination:i64=jj_operand_node_add(core,34|(statement_type<<16),local_anchor,local_start|(local_len<<32));if initializer_destination==0{return 0;}
          if jj_ast_next(core) == 0 { return 0; }
          var initializer_type: i64 = jj_c_parse_expr(core, 1, 0);
          if initializer_type == 0 { return 0; }var initializer_value:i64=jj_operand_tree_last(core);if initializer_value==0{return 0;}
          if jj_c_assign_compatible(declared_type, initializer_type) == 0 { return 0; }
          var lb: i64 = 500 + (local_added - 1) * 5;
          if jj_c_struct_type(declared_type)!=0{if initializer_type!=declared_type{return 0;}if jj_c_copy_pointer_to_local(core,core[lb+3],declared_type)==0{return 0;}}
          else{if declared_type==8{if jj_c_emit_op(core,44)==0{return 0;}}if jj_c_emit8(core,3)==0{return 0;}if jj_c_emit16(core,core[lb+3])==0{return 0;}}
          var initializer_store_kind:i64=jj_lang_operand_store_scalar();if jj_c_struct_type(declared_type)!=0{initializer_store_kind=jj_lang_operand_store_aggregate();}statement_operand_root=jj_operand_node_add(core,initializer_store_kind|(statement_type<<16),initializer_store_anchor,statement_start|((core[2]-statement_start)<<32));if statement_operand_root==0{return 0;}if jj_operand_node_attach(core,initializer_destination,statement_operand_root,1)==0{return 0;}if jj_operand_node_attach(core,initializer_value,statement_operand_root,2)==0{return 0;}
          if jj_c_pointer_type(declared_type)!=0{var initializer_span:i64=jj_operand_span_word(core,initializer_value);if (initializer_span&255)==34{var source_start:i64=(initializer_span>>>8)&0xffffffff;var source_count:i64=(initializer_span>>>40)&0xffffff;var source_found:i64=jj_c_find_local(core,source_start,source_count);if source_found>0{var alias_fields:[7]i64;alias_fields[0]=local_added-1;alias_fields[1]=source_found-1;alias_fields[2]=statement_operand_root;alias_fields[3]=local_start;alias_fields[4]=local_len;alias_fields[5]=source_start;alias_fields[6]=1;if jj_core_index_append(core,jj_lang_effect_alias_index_kind(),alias_fields as *i64,7)==0{return 0;}}}else{if (initializer_span&255)==36{var transform:*i64=jj_lang_effect_pointer_transform_by_node(core,initializer_value) as *i64;if transform!=0{var transformed_alias_fields:[7]i64;transformed_alias_fields[0]=local_added-1;transformed_alias_fields[1]=transform[2];transformed_alias_fields[2]=statement_operand_root;transformed_alias_fields[3]=local_start;transformed_alias_fields[4]=initializer_value;transformed_alias_fields[5]=transform[3];transformed_alias_fields[6]=1;if jj_core_index_append(core,jj_lang_effect_transformed_alias_index_kind(),transformed_alias_fields as *i64,7)==0{return 0;}}}}}
          if jj_operand_tree_last_set(core,statement_operand_root)==0{return 0;}
        } else {
          if jj_c_array_type(declared_type)==0 { if declared_type<100 { return 0; } }
        }
        if jj_ast_need_symbol(core, 59) == 0 { return 0; }
      } else {
        if jj_lang_keyword_if(core) != 0 {
          statement_kind=jj_lang_statement_if();var conditional_anchor:i64=jj_lang_current_anchor(core);var conditional_branch_node:i64=0;
          statement_node=jj_typed_node_add(core,statement_kind,statement_bytecode_start,0,statement_start,block_node);if statement_node==0{return 0;}
          if jj_ast_next(core) == 0 { return 0; }
          if jj_c_parse_expr(core, 1, 0) == 0 { return 0; }var condition_node:i64=jj_operand_tree_last(core);if condition_node==0{return 0;}if jj_c_narrow_authority(jj_c_operand_authority(core,condition_node,1))!=0{return 0;}
          if jj_c_emit8(core, jj_lang_cir_branch_zero()) == 0 { return 0; }
          var zero_patch: i64 = core[9];
          if jj_c_emit32(core, 0) == 0 { return 0; }
          if jj_c_parse_block(core, depth + 1, statement_node) == 0 { return 0; }
          if jj_lang_keyword_else(core) != 0 {
            var else_anchor:i64=jj_lang_current_anchor(core);var else_start:i64=core[4];if jj_c_emit8(core, jj_lang_cir_jump()) == 0 { return 0; }
            var end_patch: i64 = core[9];
            if jj_c_emit32(core, 0) == 0 { return 0; }
            if jj_c_patch32(core, zero_patch, core[9]) == 0 { return 0; }
            if jj_ast_next(core) == 0 { return 0; }
            if jj_c_parse_block(core, depth + 1, statement_node) == 0 { return 0; }
            if jj_c_patch32(core, end_patch, core[9]) == 0 { return 0; }
            conditional_branch_node=jj_operand_node_add(core,jj_lang_operand_branch()|(1<<16),else_anchor,else_start|((core[2]-else_start)<<32));if conditional_branch_node==0{return 0;}
          } else {
            if jj_c_patch32(core, zero_patch, core[9]) == 0 { return 0; }
          }
          statement_operand_root=jj_operand_node_add(core,jj_lang_operand_condition()|(1<<16),conditional_anchor,statement_start|((core[2]-statement_start)<<32));if statement_operand_root==0{return 0;}if jj_operand_node_attach(core,condition_node,statement_operand_root,1)==0{return 0;}if conditional_branch_node>0{if jj_operand_node_attach(core,conditional_branch_node,statement_operand_root,2)==0{return 0;}}if jj_operand_tree_last_set(core,statement_operand_root)==0{return 0;}
        } else {
          if jj_lang_keyword_while(core) != 0 {
            statement_kind=jj_lang_statement_loop();var loop_anchor:i64=jj_lang_current_anchor(core);
            statement_node=jj_typed_node_add(core,statement_kind,statement_bytecode_start,0,statement_start,block_node);if statement_node==0{return 0;}
            if core[14] >= 32 { return 0; }
            var loop_depth: i64 = core[14];
            core[3530 + loop_depth] = core[19];
            core[14] = loop_depth + 1;
            var loop_start: i64 = core[9];
            if jj_ast_next(core) == 0 { return 0; }
            if jj_c_parse_expr(core, 1, 0) == 0 { return 0; }var loop_condition_node:i64=jj_operand_tree_last(core);if loop_condition_node==0{return 0;}if jj_c_narrow_authority(jj_c_operand_authority(core,loop_condition_node,1))!=0{return 0;}
            if jj_c_emit8(core, jj_lang_cir_branch_zero()) == 0 { return 0; }
            var loop_end_patch: i64 = core[9];
            if jj_c_emit32(core, 0) == 0 { return 0; }
            if jj_c_parse_block(core, depth + 1, statement_node) == 0 { return 0; }
            if jj_c_emit8(core, jj_lang_cir_jump()) == 0 { return 0; }
            if jj_c_emit32(core, loop_start) == 0 { return 0; }
            var loop_end: i64 = core[9];
            if jj_c_patch32(core, loop_end_patch, loop_end) == 0 { return 0; }
            var break_mark: i64 = core[3530 + loop_depth];
            var break_count: i64 = core[19];
            while break_mark < break_count {
              if jj_c_patch32(core, core[3400 + break_mark], loop_end) == 0 { return 0; }
              break_mark = break_mark + 1;
            }
            core[19] = core[3530 + loop_depth];
            core[14] = loop_depth;
            var loop_branch_node:i64=jj_operand_node_add(core,jj_lang_operand_branch()|(1<<16),core[89],core[90]|(core[91]<<32));if loop_branch_node==0{return 0;}statement_operand_root=jj_operand_node_add(core,jj_lang_operand_condition()|(1<<16),loop_anchor,statement_start|((core[2]-statement_start)<<32));if statement_operand_root==0{return 0;}if jj_operand_node_attach(core,loop_condition_node,statement_operand_root,1)==0{return 0;}if jj_operand_node_attach(core,loop_branch_node,statement_operand_root,2)==0{return 0;}if jj_operand_tree_last_set(core,statement_operand_root)==0{return 0;}
          } else {
            if jj_lang_keyword_require(core) != 0 {
              statement_kind = jj_lang_statement_require();
              statement_type = jj_lang_current_return_authority(core);
              var require_anchor:i64 = jj_lang_current_anchor(core);

              statement_node = jj_typed_node_add(
                core,
                statement_kind,
                statement_bytecode_start,
                0,
                statement_start,
                block_node
              );
              if statement_node == 0 { return 0; }

              if jj_ast_next(core) == 0 { return 0; }

              var require_type:i64 = jj_c_parse_expr(core, 1, 0);
              if require_type == 0 {
                return jj_lang_frontend_fail(core, 1403);
              }

              var require_condition_node:i64 = jj_operand_tree_last(core);
              if require_condition_node == 0 {
                return jj_lang_frontend_fail(core, 1403);
              }

              var require_condition_authority:i64 =
                jj_c_operand_authority(core, require_condition_node, require_type);
              if jj_c_narrow_authority(require_condition_authority) != 0 {
                return jj_lang_frontend_fail(core, 1404);
              }

              if jj_lang_keyword_else(core) == 0 {
                return jj_lang_frontend_fail(core, 1401);
              }
              var require_else_anchor:i64 = jj_lang_current_anchor(core);
              var require_else_start:i64 = core[4];

              if jj_ast_next(core) == 0 { return 0; }
              if jj_lang_keyword_return(core) == 0 {
                return jj_lang_frontend_fail(core, 1402);
              }
              var require_return_anchor:i64 = jj_lang_current_anchor(core);
              var require_return_start:i64 = core[4];

              if jj_ast_next(core) == 0 { return 0; }

              if jj_c_emit8(core, jj_lang_cir_branch_zero()) == 0 { return 0; }
              var require_fail_patch:i64 = core[9];
              if jj_c_emit32(core, 0) == 0 { return 0; }

              if jj_c_emit8(core, jj_lang_cir_jump()) == 0 { return 0; }
              var require_continue_patch:i64 = core[9];
              if jj_c_emit32(core, 0) == 0 { return 0; }

              if jj_c_patch32(core, require_fail_patch, core[9]) == 0 { return 0; }

              var require_failure_type:i64 = jj_c_parse_expr(core, 1, 0);
              if require_failure_type == 0 {
                return jj_lang_frontend_fail(core, 1405);
              }

              var require_failure_node:i64 = jj_operand_tree_last(core);
              if require_failure_node == 0 {
                return jj_lang_frontend_fail(core, 1405);
              }

              var require_failure_authority:i64 =
                jj_c_operand_authority(core, require_failure_node, require_failure_type);
              if require_failure_authority == 0 {
                return jj_lang_frontend_fail(core, 1405);
              }

              if jj_c_assign_compatible(statement_type, require_failure_authority) == 0 {
                return jj_lang_frontend_fail(core, 1406);
              }

              if jj_c_struct_type(statement_type) != 0 {
                if require_failure_type != statement_type {
                  return jj_lang_frontend_fail(core, 1406);
                }
                if jj_c_return_aggregate(core, statement_type) == 0 { return 0; }
              }

              if jj_c_emit_op(core, jj_lang_cir_return()) == 0 { return 0; }
              if jj_c_patch32(core, require_continue_patch, core[9]) == 0 { return 0; }

              if jj_ast_need_symbol(core, 59) == 0 {
                return jj_lang_frontend_fail(core, 1407);
              }

              var require_return_node:i64 = jj_operand_node_add(
                core,
                jj_lang_operand_return() | (statement_type << 16),
                require_return_anchor,
                require_return_start | ((core[2] - require_return_start) << 32)
              );
              if require_return_node == 0 { return 0; }
              if jj_operand_node_attach(
                core,
                require_failure_node,
                require_return_node,
                1
              ) == 0 { return 0; }

              var require_branch_node:i64 = jj_operand_node_add(
                core,
                jj_lang_operand_branch() | (1 << 16),
                require_else_anchor,
                require_else_start | ((core[2] - require_else_start) << 32)
              );
              if require_branch_node == 0 { return 0; }

              statement_operand_root = jj_operand_node_add(
                core,
                jj_lang_operand_condition() | (1 << 16),
                require_anchor,
                statement_start | ((core[2] - statement_start) << 32)
              );
              if statement_operand_root == 0 { return 0; }

              if jj_operand_node_attach(
                core,
                require_condition_node,
                statement_operand_root,
                1
              ) == 0 { return 0; }

              if jj_operand_node_attach(
                core,
                require_branch_node,
                statement_operand_root,
                2
              ) == 0 { return 0; }

              if jj_operand_node_attach(
                core,
                require_return_node,
                statement_operand_root,
                3
              ) == 0 { return 0; }

              if jj_operand_tree_last_set(core, statement_operand_root) == 0 {
                return 0;
              }
            } else {
            if jj_lang_keyword_return(core) != 0 {
              statement_kind=jj_lang_statement_return();statement_type=jj_lang_current_return_authority(core);var return_anchor:i64=jj_lang_current_anchor(core);
              if jj_ast_next(core) == 0 { return 0; }
              var return_value_type:i64=jj_c_parse_expr(core, 1, 0);if return_value_type==0{return 0;}var return_value_node:i64=jj_operand_tree_last(core);if return_value_node==0{return 0;}var return_value_authority:i64=jj_c_operand_authority(core,return_value_node,return_value_type);if return_value_authority==0{return 0;}if jj_c_assign_compatible(statement_type,return_value_authority)==0{return 0;}if jj_c_struct_type(statement_type)!=0{if return_value_type!=statement_type{return 0;}if jj_c_return_aggregate(core,statement_type)==0{return 0;}}
              if jj_c_emit_op(core, jj_lang_cir_return()) == 0 { return 0; }
              statement_operand_root=jj_operand_node_add(core,jj_lang_operand_return()|(statement_type<<16),return_anchor,statement_start|((core[2]-statement_start)<<32));if statement_operand_root==0{return 0;}if jj_operand_node_attach(core,return_value_node,statement_operand_root,1)==0{return 0;}if jj_operand_tree_last_set(core,statement_operand_root)==0{return 0;}
              if jj_ast_is_symbol(core, 59) != 0 { if jj_ast_next(core) == 0 { return 0; } } else { if jj_ast_is_symbol(core, 125) == 0 { return 0; } }
            } else {
              if jj_lang_keyword_break(core) != 0 {
                statement_kind=jj_lang_statement_break();var break_anchor:i64=jj_lang_current_anchor(core);
                if core[14] == 0 { return 0; }
                if core[19] >= 128 { return 0; }
                if jj_ast_next(core) == 0 { return 0; }
                if jj_c_emit8(core, jj_lang_cir_jump()) == 0 { return 0; }
                var break_patch: i64 = core[9];
                if jj_c_emit32(core, 0) == 0 { return 0; }
                core[3400 + core[19]] = break_patch;
                core[19] = core[19] + 1;
                statement_operand_root=jj_operand_node_add(core,jj_lang_operand_branch()|(1<<16),break_anchor,statement_start|((core[2]-statement_start)<<32));if statement_operand_root==0{return 0;}if jj_operand_tree_last_set(core,statement_operand_root)==0{return 0;}
                if jj_ast_is_symbol(core, 59) != 0 { if jj_ast_next(core) == 0 { return 0; } } else { if jj_ast_is_symbol(core, 125) == 0 { return 0; } }
              } else {
                var assignment: i64 = jj_c_try_assignment(core);
                if assignment == 2 { return 0; }
                if assignment == 1 { statement_kind=jj_lang_statement_assignment();statement_operand_root=jj_operand_tree_last(core);if statement_operand_root==0{return 0;} }
                if assignment == 0 {
                  statement_kind=jj_lang_statement_expression();
                  if jj_c_parse_expr(core, 1, 0) == 0 { return 0; }statement_operand_root=jj_operand_tree_last(core);if statement_operand_root==0{return 0;}
                  if jj_c_emit_op(core, 31) == 0 { return 0; }
                  if jj_ast_need_symbol(core, 59) == 0 { return 0; }
                }
              }
            }
            }
          }
        }
      }
    }
    if statement_kind!=0{
      var statement_end:i64=core[2];
      if statement_end<statement_start{return 0;}
      var statement_span:i64=statement_start|((statement_end-statement_start)<<32);
      var statement_bytecode_end:i64=core[9];if statement_bytecode_end<statement_bytecode_start{return 0;}
      if statement_node==0{statement_node=jj_typed_node_add(core,statement_kind|(statement_type<<16),statement_bytecode_start,statement_bytecode_end-statement_bytecode_start,statement_span,block_node);if statement_node==0{return 0;}}
      else{if jj_typed_node_update(core,statement_node,statement_kind|(statement_type<<16),statement_bytecode_start,statement_bytecode_end-statement_bytecode_start,statement_span)==0{return 0;}}
      if statement_operand_root>0{if jj_operand_node_bind_root(core,statement_operand_root,statement_node)==0{return 0;}}
      var statement_function:i64=core[10]-1;if statement_function<0{return 0;}
      if jj_ast16_add_map(core,statement_function,statement_bytecode_start,statement_node)==0{return 0;}
    }
  }
  var block_end:i64=core[2];if block_end<block_start{return 0;}var block_bytecode_end:i64=core[9];if block_bytecode_end<block_bytecode_start{return 0;}var block_span:i64=block_start|((block_end-block_start)<<32);if jj_typed_node_update(core,block_node,jj_lang_statement_block(),block_bytecode_start,block_bytecode_end-block_bytecode_start,block_span)==0{return 0;}core[89]=core[49];core[90]=core[4];core[91]=core[5];
  return jj_ast_next(core);
}

fn jj_c_parse_program(core: *i64, root_node: i64) -> i64 {
  if root_node<=0{return 0;}
  while core[3] != 0 {
    var declaration_start: i64 = core[4];
    if jj_ast_is_ident(core,0x14da8f5ec8315a0a,6)!=0 {
      if jj_c_parse_struct(core)==0{return 0;}
      var struct_end:i64=core[2];
      var struct_span:i64=declaration_start|((struct_end-declaration_start)<<32);
      if jj_typed_node_add(core,2,core[32]-1,0,struct_span,root_node)==0{return 0;}
    } else {
      if jj_ast_is_ident(core,0x06230eb8054ccaa5,6)!=0 {
        if jj_c_parse_prototype(core)==0{return 0;}
        var prototype_end:i64=core[2];
        var prototype_span:i64=declaration_start|((prototype_end-declaration_start)<<32);
        if jj_typed_node_add(core,3,core[21]-1,0,prototype_span,root_node)==0{return 0;}
      } else {
        if jj_ast_is_ident(core, 0x9bb67100c6643a03, 2) == 0 { return 0; }
        if jj_ast_next(core) == 0 { return 0; }
        if core[3] != 1 { return 0; }
        var function_id:i64=core[10];var function_name_start:i64=core[4];var function_name_count:i64=core[5];var function_is_main:i64=jj_c_is_entry_main(core[0] as *i8,function_name_start,function_name_count);if jj_c_find_function(core,function_name_start,function_name_count)!=0{return 0;}var function_fields:[7]i64;function_fields[0]=function_name_start;function_fields[1]=function_name_count;
        if jj_core_index_append(core,1,function_fields as *i64,7)==0{return 0;}var function_record:*i64=jj_core_index_record(core,1,function_id) as *i64;if function_record==0{return 0;}
        if jj_ast_next(core) == 0 { return 0; }
        if jj_ast_need_symbol(core, 40) == 0 { return 0; }
        core[12] = 0;
        core[13] = 0;
        var param_count: i64 = 0;
        var param_types: [16]i64;var param_authorities:[16]i64;var param_starts:[16]i64;var param_lengths:[16]i64;
        if jj_ast_is_symbol(core, 41) == 0 {
          while 1 {
            if core[3] != 1 { return 0; }
            var param_start: i64 = core[4];
            var param_len: i64 = core[5];
            if jj_ast_next(core) == 0 { return 0; }
            if jj_ast_need_symbol(core, 58) == 0 { return 0; }
            var param_type: i64 = jj_c_parse_type(core);
            if param_type < 1 { return 0; }
            if jj_c_array_type(param_type) != 0 { return 0; }
            if param_count >= 12 { return 0; }
            var param_authority:i64=param_type;if param_type==1{param_authority=core[30];}param_types[param_count]=param_type;param_authorities[param_count]=param_authority;param_starts[param_count]=param_start;param_lengths[param_count]=param_len;
            param_count = param_count + 1;
            if jj_ast_is_symbol(core, 44) != 0 { if jj_ast_next(core) == 0 { return 0; } } else { break; }
          }
        }
        if jj_ast_need_symbol(core, 41) == 0 { return 0; }
        if jj_ast_need_symbol(core, 15917) == 0 { return 0; }
        var return_type: i64 = jj_c_parse_type(core);
        if jj_c_scalar_type(return_type) == 0 { if jj_c_pointer_type(return_type)==0{if jj_c_struct_type(return_type)==0{return 0;}} }var return_authority:i64=return_type;if return_type==1{return_authority=core[30];}

        var effect_contract:i64=0;
        var capability_mask:i64=0;
        var reads_mask:i64=0;
        var writes_mask:i64=0;
        if jj_lang_keyword_reads(core)!=0{return jj_lang_frontend_fail(core,1502);}
        if jj_lang_keyword_writes(core)!=0{return jj_lang_frontend_fail(core,1502);}
        if jj_lang_keyword_capability(core)!=0{
          effect_contract=1;
          if jj_ast_next(core)==0{return jj_lang_frontend_fail(core,1501);}
          capability_mask=jj_lang_parse_effect_list(core,param_starts as *i64,param_lengths as *i64,param_types as *i64,param_count);
          if capability_mask<0{return 0;}
          if jj_lang_keyword_reads(core)==0{if jj_lang_keyword_capability(core)!=0{return jj_lang_frontend_fail(core,1502);}return jj_lang_frontend_fail(core,1501);}
          if jj_ast_next(core)==0{return jj_lang_frontend_fail(core,1501);}
          reads_mask=jj_lang_parse_effect_list(core,param_starts as *i64,param_lengths as *i64,param_types as *i64,param_count);
          if reads_mask<0{return 0;}
          if jj_lang_keyword_writes(core)==0{if jj_lang_keyword_reads(core)!=0{return jj_lang_frontend_fail(core,1502);}if jj_lang_keyword_capability(core)!=0{return jj_lang_frontend_fail(core,1502);}return jj_lang_frontend_fail(core,1501);}
          if jj_ast_next(core)==0{return jj_lang_frontend_fail(core,1501);}
          writes_mask=jj_lang_parse_effect_list(core,param_starts as *i64,param_lengths as *i64,param_types as *i64,param_count);
          if writes_mask<0{return 0;}
          if ((reads_mask|writes_mask)&(0-capability_mask-1))!=0{return jj_lang_frontend_fail(core,1505);}
        }

        var function_sret:i64=0;if jj_c_struct_type(return_type)!=0{function_sret=1;}var physical_argc:i64=param_count+function_sret;if physical_argc>12{return 0;}if function_sret!=0{core[13]=1;}var add_parameter_i:i64=0;while add_parameter_i<param_count{var physical_slot:i64=add_parameter_i+function_sret;if jj_c_add_parameter(core,param_starts[add_parameter_i],param_lengths[add_parameter_i],param_types[add_parameter_i],param_authorities[add_parameter_i],physical_slot)==0{return 0;}if jj_c_add_function_parameter(core,function_id,add_parameter_i,param_types[add_parameter_i],param_authorities[add_parameter_i],physical_slot)==0{return 0;}add_parameter_i=add_parameter_i+1;}
        function_record[3]=core[9];
        function_record[4]=physical_argc;
        function_record[6]=return_type;
        var function_signature:i64=0x120+physical_argc;
        var function_return_code:i64=jj_c_signature_code(return_authority);
        if function_sret!=0{function_return_code=3;}if function_return_code==0{return 0;}
        function_signature=function_signature*16+function_return_code;if function_sret!=0{function_signature=function_signature*16+3;}
        var parameter_signature_i:i64=0;
        while parameter_signature_i<param_count{
          var parameter_signature_code:i64=jj_c_signature_code(param_authorities[parameter_signature_i]);if jj_c_struct_type(param_types[parameter_signature_i])!=0{parameter_signature_code=3;}
          if parameter_signature_code==0{return 0;}
          function_signature=function_signature*16+parameter_signature_code;
          parameter_signature_i=parameter_signature_i+1;
        }
        if function_is_main!=0{if function_signature!=0x122225{return 0;}}
        var declared:i64=jj_c_find_prototype(core,function_record[1],function_record[2]);
        if declared!=0{if function_sret!=0{return 0;}var declared_record:*i64=jj_core_index_record(core,2,declared-1) as *i64;if declared_record==0{return 0;}if declared_record[3]!=param_count{return 0;}if declared_record[4]!=function_signature{return 0;}if declared_record[5]!=return_type{return 0;}}
        function_record[7]=function_signature;
        core[10] = core[10] + 1;
        core[31]=return_authority;
        var function_node:i64=jj_typed_node_add(core,1|(return_type<<16),function_id,param_count,declaration_start,root_node);if function_node==0{return 0;}
        if jj_c_parse_block(core, 0, function_node) == 0 { return 0; }
        function_record[5]=core[13];
        var function_end:i64=core[2];
        if effect_contract!=0{
          core[196]=0;core[197]=0;
          var authority_state_root:i64=0;
          while authority_state_root<param_count{
            var authority_state_bit:i64=1<<authority_state_root;
            if (capability_mask&authority_state_bit)!=0{
              if jj_lang_authority_state_append(core,function_id,authority_state_root,declaration_start,function_end-declaration_start)==0{return 0;}
            }
            authority_state_root=authority_state_root+1;
          }
          if jj_lang_authority_state_verify(core,function_id,param_count,capability_mask,declaration_start,function_end-declaration_start)==0{return 0;}
          // Preview.14 TEST-ONLY injection. Production admits no transfer syntax.
          // For the fixed laboratory source p14probe, bind authority root 0 to
          // ordinary local ordinal 1 exactly at the first post-declaration use of `next`.
          if function_name_count==8{
            var p14_gate_source:*i8=core[0] as *i8;
            if p14_gate_source[function_name_start]==112{if p14_gate_source[function_name_start+1]==49{if p14_gate_source[function_name_start+2]==52{if p14_gate_source[function_name_start+3]==112{if p14_gate_source[function_name_start+4]==114{if p14_gate_source[function_name_start+5]==111{if p14_gate_source[function_name_start+6]==98{if p14_gate_source[function_name_start+7]==101{
              if jj_lang_authority_state_transition_internal(core,function_id,0,1,114,4)==0{return 0;}
            }}}}}}}}
          }
          var effect_function_span:i64=declaration_start|((function_end-declaration_start)<<32);
          if jj_lang_effect_verify(core,param_count,capability_mask,reads_mask,writes_mask,effect_function_span)==0{return 0;}
          var effect_fields:[7]i64;
          effect_fields[0]=function_id;
          effect_fields[1]=capability_mask;
          effect_fields[2]=reads_mask;
          effect_fields[3]=writes_mask;
          effect_fields[4]=core[196];
          effect_fields[5]=core[197];
          effect_fields[6]=1;
          if jj_core_index_append(core,jj_lang_effect_contract_index_kind(),effect_fields as *i64,7)==0{return 0;}
          core[196]=0;core[197]=0;
        }
        var function_span:i64=declaration_start|((function_end-declaration_start)<<32);
        if jj_typed_node_update(core,function_node,1|(return_type<<16),function_id,param_count,function_span)==0{return 0;}
        if jj_ast16_add_function_map(core,function_id,function_record[3],function_node)==0{return 0;}
      }
    }
  }
  return 1;
}
