// Semantic expression/type construction phase.
// Integration-hub partition R764: concrete work lives in focused phases.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_semantic_cir_emit8(p0:*i64,p1:i64)->i64;
extern fn jj_semantic_cir_emit16(p0:*i64,p1:i64)->i64;
extern fn jj_semantic_cir_emit32(p0:*i64,p1:i64)->i64;
extern fn jj_semantic_cir_emit64(p0:*i64,p1:i64)->i64;
extern fn jj_semantic_cir_patch32(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_operand_record(p0:*i64,p1:i64)->i64;
extern fn jj_operand_span_word(p0:*i64,p1:i64)->i64;
extern fn jj_ast_is_symbol(p0:*i64,p1:i64)->i64;
extern fn jj_ast_next(p0:*i64)->i64;
extern fn jj_ast_need_symbol(p0:*i64,p1:i64)->i64;
extern fn jj_ast_is_ident(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_find_struct(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_find_function(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_array_type(p0:i64)->i64;
extern fn jj_c_scalar_type(p0:i64)->i64;
extern fn jj_c_pointer_type(p0:i64)->i64;
extern fn jj_c_signature_code(p0:i64)->i64;
extern fn jj_c_add_prototype(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_operand_tree_last(p0:*i64)->i64;
extern fn jj_operand_node_add(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_operand_node_attach(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_c_emit_string(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_is_unsafe_abi_syscall3(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_c_is_unsafe_abi_syscall4(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_c_is_unsafe_abi_syscall5(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_c_is_unsafe_abi_call5_frame(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_c_is_i8_to_i64(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_c_is_i64_to_ptr(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_c_is_ptr_to_i64(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_core_index_record(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_struct_type(p0:i64)->i64;
extern fn jj_c_function_parameter_type(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_function_parameter_authority(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_type_slots(p0:*i64,p1:i64)->i64;
extern fn jj_c_temp_slots(p0:*i64,p1:i64)->i64;
extern fn jj_c_emit_local_aggregate_address(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_find_prototype(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_core_index_find_name(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_core_index_append(p0:*i64,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_c_find_local(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_parse_local_aggregate_value(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_c_parse_index_chain(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_c_common_numeric(p0:i64,p1:i64)->i64;
extern fn jj_operand_tree_last_set(p0:*i64,p1:i64)->i64;
extern fn jj_c_try_aggregate_assignment(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_c_assign_compatible(p0:i64,p1:i64)->i64;
extern fn jj_lang_effect_contract_index_kind()->i64;
extern fn jj_lang_effect_call_index_kind()->i64;
extern fn jj_lang_effect_pointer_transform_index_kind()->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_c_emit8(core: *i64, value: i64) -> i64 { return jj_semantic_cir_emit8(core,value); }
fn jj_c_emit16(core: *i64, value: i64) -> i64 { return jj_semantic_cir_emit16(core,value); }
fn jj_c_emit32(core: *i64, value: i64) -> i64 { return jj_semantic_cir_emit32(core,value); }
fn jj_c_emit64(core: *i64, value: i64) -> i64 { return jj_semantic_cir_emit64(core,value); }

fn jj_lang_effect_contract_for_function(core:*i64,function_id:i64)->i64{
  if core==0{return 0;}if function_id<0{return 0;}var ordinal:i64=0;
  while 1{
    var record:*i64=jj_core_index_record(core,jj_lang_effect_contract_index_kind(),ordinal) as *i64;
    if record==0{return 0;}
    if record[1]==function_id{return record as i64;}
    ordinal=ordinal+1;
  }
  return 0;
}

fn jj_lang_effect_record_internal_call(core:*i64,function_id:i64,call_start:i64,call_count:i64,argc:i64,argument_nodes:*i64)->i64{
  if core==0{return 0;}if function_id<0{return 0;}if call_start<0{return 0;}if call_count<=0{return 0;}if argc<0{return 0;}if argument_nodes==0{return 0;}
  if argc>7{return 1;}
  var contract:*i64=jj_lang_effect_contract_for_function(core,function_id) as *i64;
  if contract==0{return 1;}
  var i:i64=0;
  while i<argc{
    var expected_type:i64=jj_c_function_parameter_type(core,function_id,i);
    if expected_type==0{return 0;}
    if jj_c_pointer_type(expected_type)!=0{
      var bit:i64=1<<i;
      if (contract[2]&bit)!=0{
        var fields:[7]i64;
        fields[0]=call_start;
        fields[1]=call_count;
        fields[2]=i+1;
        fields[3]=function_id;
        if (contract[3]&bit)!=0{fields[4]=1;}else{fields[4]=0;}
        if (contract[4]&bit)!=0{fields[5]=1;}else{fields[5]=0;}
        fields[6]=1;
        if jj_core_index_append(core,jj_lang_effect_call_index_kind(),fields as *i64,7)==0{return 0;}
      }
    }
    i=i+1;
  }
  return 1;
}
fn jj_c_patch32(core: *i64, position: i64, value: i64) -> i64 { return jj_semantic_cir_patch32(core,position,value); }

fn jj_c_emit_op(core: *i64, op: i64) -> i64 { return jj_c_emit8(core, op); }

fn jj_c_emit_imm(core: *i64, value: i64) -> i64 { if jj_c_emit8(core, 1) == 0 { return 0; } return jj_c_emit64(core, value); }
fn jj_c_operand_authority(core:*i64,node:i64,operational:i64)->i64{if operational!=1{return operational;}var r:i64=jj_operand_record(core,node);if r==0{return 0;}return (r>>>24)&255;}
fn jj_c_narrow_authority(type:i64)->i64{if type>=252{if type<=254{return 1;}}return 0;}
fn jj_c_signature_return_authority(signature:i64,argc:i64,operational:i64)->i64{if operational!=1{return operational;}if argc<0{return 0;}if argc>12{return 0;}var c:i64=(signature>>>(argc*4))&15;if c==13{return 252;}if c==14{return 254;}if c==2{return 255;}return 0;}

fn jj_c_parse_type(core: *i64) -> i64 {
  core[30] = 0;
  if jj_ast_is_symbol(core, 91) != 0 {
    if jj_ast_next(core) == 0 { return 0; } if core[3] != 2 { return 0; } var count: i64 = core[6]; if count == 0 { return 0; } if count > 4096 { return 0; }
    if jj_ast_next(core) == 0 { return 0; } if jj_ast_need_symbol(core, 93) == 0 { return 0; }
    var array_type: i64 = 0;
    if jj_ast_is_ident(core, 0x2596925134065e24, 3) != 0 { array_type = 4; }
    else { if jj_ast_is_ident(core, 0x8e107e516f5a2bb8, 3) != 0 { array_type = 7; } else { if jj_ast_is_ident(core,0x8e066e516f51bc03,3)!=0{array_type=10;}else{return 0;} } }
    if jj_ast_next(core) == 0 { return 0; } core[30] = count; return array_type;
  }
  var pointer: i64 = 0; if jj_ast_is_symbol(core, 42) != 0 { pointer = 1; if jj_ast_next(core) == 0 { return 0; } }
  if jj_ast_is_ident(core, 0x9bc72500c6722c12, 2) != 0 { if jj_ast_next(core) == 0 { return 0; } if pointer != 0 { return 2; } core[30]=252;return 1; }
  if jj_ast_is_ident(core, 0x25a78a513414c3bf, 3) != 0 { if pointer != 0 { return 0; } if jj_ast_next(core) == 0 { return 0; } core[30]=254;return 1; }
  if jj_ast_is_ident(core, 0x2596925134065e24, 3) != 0 { if jj_ast_next(core) == 0 { return 0; } if pointer != 0 { return 3; } core[30]=255;return 1; }
  if jj_ast_is_ident(core, 0x8e107e516f5a2bb8, 3) != 0 { if jj_ast_next(core) == 0 { return 0; } if pointer != 0 { return 6; } return 5; }
  if jj_ast_is_ident(core,0x8e066e516f51bc03,3)!=0{if jj_ast_next(core)==0{return 0;}if pointer!=0{return 9;}return 8;}
  if core[3]==1{var st:i64=jj_c_find_struct(core,core[4],core[5]);if st!=0{if jj_ast_next(core)==0{return 0;}if pointer!=0{return 199+st;}return 99+st;}}
  return 0;
}

fn jj_c_precedence(symbol: i64) -> i64 {
  if symbol == 124 { return 1; } if symbol == 94 { return 2; } if symbol == 38 { return 3; }
  if symbol == 15677 { return 4; } if symbol == 15649 { return 4; }
  if symbol == 60 { return 5; } if symbol == 62 { return 5; } if symbol == 15676 { return 5; } if symbol == 15678 { return 5; }
  if symbol == 15420 { return 6; } if symbol == 15934 { return 6; } if symbol == 4079166 { return 6; }
  if symbol == 43 { return 7; } if symbol == 45 { return 7; }
  if symbol == 42 { return 8; } if symbol == 47 { return 8; } if symbol == 37 { return 8; }
  return 0;
}

fn jj_c_binary_opcode(symbol: i64) -> i64 {
  if symbol == 43 { return 9; } if symbol == 45 { return 10; } if symbol == 42 { return 11; } if symbol == 47 { return 12; } if symbol == 37 { return 13; }
  if symbol == 15420 { return 14; } if symbol == 15934 { return 15; } if symbol == 4079166 { return 37; } if symbol == 38 { return 16; } if symbol == 124 { return 17; } if symbol == 94 { return 18; }
  if symbol == 15677 { return 19; } if symbol == 15649 { return 20; } if symbol == 60 { return 21; } if symbol == 15676 { return 22; } if symbol == 62 { return 23; } if symbol == 15678 { return 24; }
  return 0;
}

fn jj_c_parse_prototype(core: *i64) -> i64 {
  if jj_ast_next(core)==0{return 0;}
  if jj_ast_is_ident(core,0x9bb67100c6643a03,2)==0{return 0;}
  if jj_ast_next(core)==0{return 0;}if core[3]!=1{return 0;}
  var name_start:i64=core[4];var name_count:i64=core[5];
  if jj_c_find_function(core,name_start,name_count)!=0{return 0;}
  if jj_ast_next(core)==0{return 0;}if jj_ast_need_symbol(core,40)==0{return 0;}
  var argc:i64=0;var types:[16]i64;
  if jj_ast_is_symbol(core,41)==0{
    while 1{
      if core[3]!=1{return 0;}
      if jj_ast_next(core)==0{return 0;}if jj_ast_need_symbol(core,58)==0{return 0;}
      var t:i64=jj_c_parse_type(core);if t==0{return 0;}if jj_c_array_type(t)!=0{return 0;}if argc>=12{return 0;}var ta:i64=t;if t==1{ta=core[30];}types[argc]=ta;argc=argc+1;
      if jj_ast_is_symbol(core,44)!=0{if jj_ast_next(core)==0{return 0;}}else{break;}
    }
  }
  if jj_ast_need_symbol(core,41)==0{return 0;}if jj_ast_need_symbol(core,15917)==0{return 0;}
  var return_type:i64=jj_c_parse_type(core);if jj_c_scalar_type(return_type)==0{if jj_c_pointer_type(return_type)==0{return 0;}}var return_authority:i64=return_type;if return_type==1{return_authority=core[30];}
  var signature:i64=0x120+argc;var return_code:i64=jj_c_signature_code(return_authority);if return_code==0{return 0;}signature=signature*16+return_code;var i:i64=0;while i<argc{var code:i64=jj_c_signature_code(types[i]);if code==0{return 0;}signature=signature*16+code;i=i+1;}
  if jj_ast_need_symbol(core,59)==0{return 0;}
  return jj_c_add_prototype(core,name_start,name_count,argc,signature,return_type);
}

fn jj_c_parse_expr(core: *i64, minimum: i64, depth: i64) -> i64 {
  if depth > 128 { return 0; }
  var left_type: i64 = 0; var left_bound:i64=0;var left_node:i64=0;var expression_start:i64=core[4];
  if jj_ast_is_symbol(core, 45) != 0 {
    var unary_start:i64=core[4];var unary_anchor:i64=core[49];if jj_ast_next(core) == 0 { return 0; } left_type = jj_c_parse_expr(core, 9, depth + 1); if left_type == 0 { return 0; }var unary_child:i64=jj_operand_tree_last(core);if unary_child==0{return 0;}if jj_c_narrow_authority(jj_c_operand_authority(core,unary_child,left_type))!=0{return 0;}var unary_pc:i64=core[9]; if jj_c_emit_op(core, 25) == 0 { return 0; } left_type = 1;var unary_end:i64=core[2];if unary_end<unary_start{unary_end=unary_start;}left_node=jj_operand_node_add(core,35|(left_type<<16),unary_anchor,unary_start|((unary_end-unary_start)<<32));if left_node==0{return 0;}if jj_operand_node_attach(core,unary_child,left_node,1)==0{return 0;}
  } else {
    if jj_ast_is_symbol(core, 33) != 0 {
      var not_start:i64=core[4];var not_anchor:i64=core[49];if jj_ast_next(core) == 0 { return 0; } left_type = jj_c_parse_expr(core, 9, depth + 1); if left_type == 0 { return 0; }var not_child:i64=jj_operand_tree_last(core);if not_child==0{return 0;}if jj_c_narrow_authority(jj_c_operand_authority(core,not_child,left_type))!=0{return 0;}var not_pc:i64=core[9];if jj_c_emit_op(core, 26) == 0 { return 0; } left_type = 1;var not_end:i64=core[2];if not_end<not_start{not_end=not_start;}left_node=jj_operand_node_add(core,35|(left_type<<16),not_anchor,not_start|((not_end-not_start)<<32));if left_node==0{return 0;}if jj_operand_node_attach(core,not_child,left_node,1)==0{return 0;}
    } else {
      if jj_ast_is_symbol(core, 43) != 0 {
        if jj_ast_next(core) == 0 { return 0; } left_type = jj_c_parse_expr(core, 9, depth + 1); if left_type == 0 { return 0; }left_node=jj_operand_tree_last(core);if left_node==0{return 0;}
      } else {
        if core[3] == 2 {
          var atom_start:i64=core[4];var atom_end:i64=core[4]+core[5];var atom_anchor:i64=core[49];var atom_pc:i64=core[9];if jj_c_emit_imm(core, core[6]) == 0 { return 0; } left_type = 1;left_node=jj_operand_node_add(core,32|(left_type<<16),atom_anchor,atom_start|((atom_end-atom_start)<<32));if left_node==0{return 0;}if jj_ast_next(core) == 0 { return 0; }
        } else {
          if core[3]==4{
            var string_start:i64=core[4];var string_end:i64=core[4]+core[5];var string_anchor:i64=core[49];var string_pc:i64=core[9];if jj_c_emit_string(core,core[4],core[5])==0{return 0;}left_type=2;left_node=jj_operand_node_add(core,33|(left_type<<16),string_anchor,string_start|((string_end-string_start)<<32));if left_node==0{return 0;}if jj_ast_next(core)==0{return 0;}
          }else{
            if jj_ast_is_symbol(core, 40) != 0 {
              if jj_ast_next(core) == 0 { return 0; } left_type = jj_c_parse_expr(core, 1, depth + 1); if left_type == 0 { return 0; }left_node=jj_operand_tree_last(core);if left_node==0{return 0;}if jj_ast_need_symbol(core, 41) == 0 { return 0; }
            } else {
              if core[3] != 1 { return 0; }
              var name_start: i64 = core[4]; var name_count: i64 = core[5]; var name_hash: i64 = core[6];var name_end:i64=name_start+name_count;var name_anchor:i64=core[49];
              if jj_ast_next(core) == 0 { return 0; }
              if jj_ast_is_symbol(core, 40) != 0 {
                var call_pc:i64=core[9];var call_authority:i64=0;if jj_ast_next(core) == 0 { return 0; } var argc: i64 = 0; var argument_types: [16]i64;var argument_nodes:[16]i64;
                if jj_ast_is_symbol(core, 41) == 0 {
                  while 1 { var argument_type: i64 = jj_c_parse_expr(core, 1, depth + 1); if argument_type == 0 { return 0; } if argc >= 12 { return 0; } argument_types[argc] = argument_type;argument_nodes[argc]=jj_operand_tree_last(core);if argument_nodes[argc]==0{return 0;} argc = argc + 1; if jj_ast_is_symbol(core, 44) != 0 { if jj_ast_next(core) == 0 { return 0; } } else { break; } }
                }
                var call_end:i64=core[4]+core[5];if jj_ast_need_symbol(core, 41) == 0 { return 0; }
                if jj_c_is_unsafe_abi_syscall3(core[0] as *i8, name_start, name_count) != 0 {
                  if argc != 4 { return 0; } var abi_i: i64 = 0; while abi_i < 4 { if argument_types[abi_i] != 1 { return 0; }var abi_t:i64=jj_c_operand_authority(core,argument_nodes[abi_i],argument_types[abi_i]);if abi_t!=1{if abi_t!=255{return 0;}} abi_i = abi_i + 1; } if jj_c_emit_op(core, 34) == 0 { return 0; } left_type = 1;
                } else { if jj_c_is_unsafe_abi_syscall4(core[0] as *i8, name_start, name_count) != 0 {
                  if argc != 5 { return 0; } var abi4_i: i64 = 0; while abi4_i < 5 { if argument_types[abi4_i] != 1 { return 0; }var abi4_t:i64=jj_c_operand_authority(core,argument_nodes[abi4_i],argument_types[abi4_i]);if abi4_t!=1{if abi4_t!=255{return 0;}} abi4_i = abi4_i + 1; } if jj_c_emit_op(core, 36) == 0 { return 0; } left_type = 1;
                } else { if jj_c_is_unsafe_abi_syscall5(core[0] as *i8, name_start, name_count) != 0 {
                  if argc != 6 { return 0; } var abi5_i: i64 = 0; while abi5_i < 6 { if argument_types[abi5_i] != 1 { return 0; }var abi5_t:i64=jj_c_operand_authority(core,argument_nodes[abi5_i],argument_types[abi5_i]);if abi5_t!=1{if abi5_t!=255{return 0;}} abi5_i = abi5_i + 1; } if jj_c_emit_op(core, 49) == 0 { return 0; } left_type = 1;
                } else { if jj_c_is_unsafe_abi_call5_frame(core[0] as *i8, name_start, name_count) != 0 {
                  if argc != 2 { return 0; } if argument_types[0] != 1 { return 0; }var frame_abi_type:i64=jj_c_operand_authority(core,argument_nodes[0],argument_types[0]);if frame_abi_type!=1{if frame_abi_type!=255{return 0;}} if argument_types[1] < 2 { return 0; } if argument_types[1] > 4 { return 0; } if jj_c_emit_op(core, 35) == 0 { return 0; } left_type = 1;call_authority=255;
                } else {
                  if jj_c_is_i8_to_i64(core[0] as *i8,name_start,name_count)!=0 { if argc != 1 { return 0; }var i8_source:i64=jj_c_operand_authority(core,argument_nodes[0],argument_types[0]);if i8_source!=252{return 0;} if jj_c_emit_op(core, 32) == 0 { return 0; } left_type = 1;call_authority=255; } else {
                    if jj_c_is_i64_to_ptr(core[0] as *i8,name_start,name_count)!=0 { if argc != 1 { return 0; }var i64_source:i64=jj_c_operand_authority(core,argument_nodes[0],argument_types[0]);if i64_source!=1{if i64_source!=255{return 0;}} left_type = 2;call_authority=2; } else {
                      if jj_c_is_ptr_to_i64(core[0] as *i8,name_start,name_count)!=0 { if argc != 1 { return 0; }if jj_c_pointer_type(argument_types[0])==0{return 0;} left_type = 1;call_authority=255; } else {
                        var found_function: i64 = jj_c_find_function(core, name_start, name_count);
                        if found_function != 0 { var function_id:i64=found_function-1;var function_record:*i64=jj_core_index_record(core,1,function_id) as *i64;if function_record==0{return 0;}var local_sret:i64=0;if jj_c_struct_type(function_record[6])!=0{local_sret=1;}var logical_argc:i64=function_record[4]-local_sret;if logical_argc!=argc{return 0;}if logical_argc<0{return 0;}var local_signature_i:i64=0;while local_signature_i<argc{var expected_type:i64=jj_c_function_parameter_type(core,function_id,local_signature_i);var expected_authority:i64=jj_c_function_parameter_authority(core,function_id,local_signature_i);if expected_type==0{return 0;}if expected_authority==0{return 0;}var actual_authority:i64=jj_c_operand_authority(core,argument_nodes[local_signature_i],argument_types[local_signature_i]);if actual_authority==0{return 0;}if jj_c_struct_type(expected_type)!=0{if argument_types[local_signature_i]!=expected_type{return 0;}if actual_authority!=expected_type{return 0;}}else{var expected_code:i64=jj_c_signature_code(expected_authority);var actual_code:i64=jj_c_signature_code(actual_authority);if expected_code==0{return 0;}if actual_code!=expected_code{return 0;}}local_signature_i=local_signature_i+1;}if local_sret!=0{var return_slots:i64=jj_c_type_slots(core,function_record[6]);if return_slots<=0{return 0;}var return_temp:i64=jj_c_temp_slots(core,return_slots);if return_temp<0{return 0;}if jj_c_emit_local_aggregate_address(core,return_temp,function_record[6])==0{return 0;}call_authority=function_record[6];}else{call_authority=jj_c_signature_return_authority(function_record[7],function_record[4],function_record[6]);if call_authority==0{return 0;}}if jj_lang_effect_record_internal_call(core,function_id,name_start,call_end-name_start,argc,argument_nodes as *i64)==0{return 0;}if jj_c_emit8(core,29)==0{return 0;}if jj_c_emit16(core,function_id)==0{return 0;}if jj_c_emit8(core,function_record[4])==0{return 0;}left_type=function_record[6]; }
                        else { if core[18]!=5{if core[18]!=6{return 0;}}var prototype:i64=jj_c_find_prototype(core,name_start,name_count);if prototype==0{core[193]=1001;return 0;}var prototype_record:*i64=jj_core_index_record(core,2,prototype-1) as *i64;if prototype_record==0{return 0;}if prototype_record[3]!=argc{return 0;}var signature:i64=0x120+argc;var external_return_code:i64=(prototype_record[4]>>>(argc*4))&15;if external_return_code==0{return 0;}signature=signature*16+external_return_code;var signature_i:i64=0;while signature_i<argc{var external_argument_type:i64=jj_c_operand_authority(core,argument_nodes[signature_i],argument_types[signature_i]);var signature_code:i64=jj_c_signature_code(external_argument_type);if signature_code==0{return 0;}signature=signature*16+signature_code;signature_i=signature_i+1;}if prototype_record[4]!=signature{return 0;}call_authority=jj_c_signature_return_authority(prototype_record[4],argc,prototype_record[5]);if call_authority==0{return 0;}var external:i64=jj_core_index_find_name(core,3,name_start,name_count);if external!=0{var external_record:*i64=jj_core_index_record(core,3,external-1) as *i64;if external_record==0{return 0;}if external_record[3]!=signature{return 0;}}else{var external_fields:[7]i64;external_fields[0]=name_start;external_fields[1]=name_count;external_fields[2]=signature;if jj_core_index_append(core,3,external_fields as *i64,3)==0{return 0;}core[20]=core[20]+1;external=core[20];}if jj_c_emit8(core,33)==0{return 0;}if jj_c_emit16(core,external-1)==0{return 0;}if jj_c_emit8(core,argc)==0{return 0;}left_type=prototype_record[5]; }
                      }
                    }
                  }
                } } } }
                if call_authority==0{call_authority=left_type;}if call_end<name_end{call_end=name_end;}left_node=jj_operand_node_add(core,37|(call_authority<<16),name_anchor,name_start|((call_end-name_start)<<32));if left_node==0{return 0;}var attach_i:i64=0;while attach_i<argc{var attach_role:i64=attach_i+1;if attach_role>7{attach_role=7;}if jj_operand_node_attach(core,argument_nodes[attach_i],left_node,attach_role)==0{return 0;}attach_i=attach_i+1;}
              } else {
                var found_local: i64 = jj_c_find_local(core, name_start, name_count); if found_local == 0 { return 0; } var local_base: i64 = 500 + (found_local - 1) * 5; var local_type: i64 = core[local_base + 2];name_hash=local_type;if local_type==1{name_hash=core[local_base+4];} var local_slot: i64 = core[local_base + 3];var local_pc:i64=core[9];
                if jj_c_struct_type(local_type)!=0{
                  left_type=jj_c_parse_local_aggregate_value(core,local_type,local_slot,name_anchor,name_start,name_end);if left_type==0{return 0;}left_node=core[16];left_bound=core[72];if left_node==0{return 0;}
                }else{if jj_c_array_type(local_type) != 0 { if jj_c_emit8(core, 4) == 0 { return 0; } if jj_c_emit16(core, local_slot) == 0 { return 0; } if jj_c_emit16(core, core[local_base + 4]) == 0 { return 0; } left_type = local_type;left_bound=core[local_base+4]; } else { if jj_c_emit8(core, 2) == 0 { return 0; } if jj_c_emit16(core, local_slot) == 0 { return 0; } left_type = local_type; }left_node=jj_operand_node_add(core,34|(name_hash<<16),name_anchor,name_start|((name_end-name_start)<<32));if left_node==0{return 0;}}
              }
            }
          }
        }
      }
    }
  }
  if jj_ast_is_symbol(core,91)!=0{left_type=jj_c_parse_index_chain(core,left_type,left_bound,left_node,expression_start,depth);if left_type==0{return 0;}left_node=core[16];left_bound=core[72];if left_node==0{return 0;}}
  while jj_ast_is_ident(core, 0x9bac5c00c65bc1cf, 2) != 0 {
    var cast_child:i64=left_node;if cast_child==0{return 0;}var cast_start:i64=core[4];var cast_anchor:i64=core[49];var cast_end:i64=(jj_operand_record(core,cast_child)>>>24)&255;if jj_ast_next(core) == 0 { return 0; } var cast_type: i64 = jj_c_parse_type(core); if cast_type == 0 { return 0; }var cast_pc:i64=cast_type;if cast_type==1{cast_pc=core[30];if cast_pc>=252{if cast_end>=252{if cast_end!=cast_pc{return 0;}}else{if cast_pc!=255{if cast_pc!=252{return 0;}cast_pc=253;}}}}if cast_type==8{if jj_c_emit_op(core,44)==0{return 0;}} left_type = cast_type;cast_end=core[2];if cast_end<cast_start{cast_end=cast_start;}left_node=jj_operand_node_add(core,39|(cast_pc<<16),cast_anchor,expression_start|((cast_end-expression_start)<<32));if left_node==0{return 0;}if jj_operand_node_attach(core,cast_child,left_node,1)==0{return 0;}left_bound=0;
  }
  while core[3] == 3 {
    var symbol: i64 = core[6];var binary_anchor:i64=core[49]; var precedence: i64 = jj_c_precedence(symbol); if precedence < minimum { break; } if precedence == 0 { break; }var binary_left:i64=left_node;if binary_left==0{return 0;}var binary_left_type:i64=left_type;
    if jj_ast_next(core) == 0 { return 0; }var binary_right_literal:i64=0;var binary_right_literal_value:i64=0;if core[3]==2{binary_right_literal=1;binary_right_literal_value=core[6];} var right_type: i64 = jj_c_parse_expr(core, precedence + 1, depth + 1); if right_type == 0 { return 0; }var binary_right:i64=jj_operand_tree_last(core);if binary_right==0{return 0;}var binary_left_authority:i64=jj_c_operand_authority(core,binary_left,left_type);var binary_right_authority:i64=jj_c_operand_authority(core,binary_right,right_type);if jj_c_narrow_authority(binary_left_authority)!=0{return 0;}if jj_c_narrow_authority(binary_right_authority)!=0{return 0;}
    var common_numeric: i64 = jj_c_common_numeric(left_type, right_type); var operation: i64 = jj_c_binary_opcode(symbol);
    if common_numeric == 5 {if symbol == 47 { operation = 38; }if symbol == 37 { operation = 39; }if symbol == 15934 { operation = 37; }if symbol == 60 { operation = 40; }if symbol == 15676 { operation = 41; }if symbol == 62 { operation = 42; }if symbol == 15678 { operation = 43; }}
    if common_numeric==8{if symbol==47{operation=38;}if symbol==37{operation=39;}if symbol==15934{operation=37;}if symbol==60{operation=40;}if symbol==15676{operation=41;}if symbol==62{operation=42;}if symbol==15678{operation=43;}}
    if operation == 0 { return 0; }var binary_pc:i64=core[9];if jj_c_emit_op(core, operation) == 0 { return 0; }
    if symbol == 15677 { left_type = 1; } else { if symbol == 15649 { left_type = 1; } else { if symbol == 60 { left_type = 1; } else { if symbol == 15676 { left_type = 1; } else { if symbol == 62 { left_type = 1; } else { if symbol == 15678 { left_type = 1; } else {
      if symbol == 43 { if jj_c_pointer_type(left_type) != 0 { if jj_c_scalar_type(right_type) == 0 { left_type = 1; } } else { if jj_c_pointer_type(right_type) != 0 { if jj_c_scalar_type(left_type) != 0 { left_type = right_type; } else { left_type = 1; } } else { left_type = common_numeric; } } }
      else { if symbol == 45 { if jj_c_pointer_type(left_type) != 0 { if jj_c_pointer_type(right_type) != 0 { left_type = 1; } else { if jj_c_scalar_type(right_type) == 0 { left_type = 1; } } } else { left_type = common_numeric; } } else { left_type = common_numeric; } }
      if left_type == 0 { left_type = 1; }
    } } } } } }
    if left_type==8{if symbol!=15677{if symbol!=15649{if symbol!=60{if symbol!=15676{if symbol!=62{if symbol!=15678{if jj_c_emit_op(core,44)==0{return 0;}}}}}}}}
    var binary_end:i64=core[2];if binary_end<expression_start{binary_end=expression_start;}left_node=jj_operand_node_add(core,36|(left_type<<16),binary_anchor,expression_start|((binary_end-expression_start)<<32));if left_node==0{return 0;}if jj_operand_node_attach(core,binary_left,left_node,1)==0{return 0;}if jj_operand_node_attach(core,binary_right,left_node,2)==0{return 0;}
    if symbol==43{if jj_c_pointer_type(binary_left_type)!=0{if jj_c_scalar_type(right_type)!=0{var transform_left_span:i64=jj_operand_span_word(core,binary_left);if (transform_left_span&255)==34{var transform_source_start:i64=(transform_left_span>>>8)&0xffffffff;var transform_source_count:i64=(transform_left_span>>>40)&0xffffff;var transform_source_found:i64=jj_c_find_local(core,transform_source_start,transform_source_count);if transform_source_found>0{var transform_value:i64=0-1;if binary_right_literal!=0{transform_value=binary_right_literal_value;}var transform_fields:[7]i64;transform_fields[0]=left_node;transform_fields[1]=transform_source_found-1;transform_fields[2]=transform_value;transform_fields[3]=expression_start;transform_fields[4]=binary_end-expression_start;transform_fields[5]=1;transform_fields[6]=43;if jj_core_index_append(core,jj_lang_effect_pointer_transform_index_kind(),transform_fields as *i64,7)==0{return 0;}}}}}}
    left_bound=0;
  }
  if left_node==0{return 0;}if jj_operand_tree_last_set(core,left_node)==0{return 0;}return left_type;
}

fn jj_c_emit_address(core: *i64, local_index: i64) -> i64 {
  var local_base: i64 = 500 + local_index * 5; var local_type: i64 = core[local_base + 2]; var local_slot: i64 = core[local_base + 3];
  if jj_c_array_type(local_type) != 0 { if jj_c_emit8(core, 4) == 0 { return 0; } if jj_c_emit16(core, local_slot) == 0 { return 0; } if jj_c_emit16(core, core[local_base + 4]) == 0 { return 0; } return local_type; }
  if local_type == 2 { if jj_c_emit8(core, 2) == 0 { return 0; } if jj_c_emit16(core, local_slot) == 0 { return 0; } return 2; }
  if local_type == 3 { if jj_c_emit8(core, 2) == 0 { return 0; } if jj_c_emit16(core, local_slot) == 0 { return 0; } return 3; }
  if local_type == 6 { if jj_c_emit8(core, 2) == 0 { return 0; } if jj_c_emit16(core, local_slot) == 0 { return 0; } return 6; }
  if local_type == 9 { if jj_c_emit8(core,2)==0{return 0;}if jj_c_emit16(core,local_slot)==0{return 0;}return 9;}
  return 0;
}

fn jj_c_try_assignment(core: *i64) -> i64 {
  if core[3] != 1 { return 0; }
  var save_pos: i64 = core[2]; var save_kind: i64 = core[3]; var save_start: i64 = core[4];var save_anchor:i64=core[49]; var save_len: i64 = core[5]; var save_value: i64 = core[6]; var save_emit: i64 = core[9];
  var found: i64 = jj_c_find_local(core, save_start, save_len); if found == 0 { return 0; } var local_index: i64 = found - 1; var local_base: i64 = 500 + local_index * 5; var local_type: i64 = core[local_base + 2];var local_authority_type:i64=local_type;if local_type==1{local_authority_type=core[local_base+4];} var local_slot: i64 = core[local_base + 3];
  if jj_ast_next(core) == 0 { return 2; }
  if jj_c_struct_type(local_type)!=0{return jj_c_try_aggregate_assignment(core,local_type,local_slot,save_anchor,save_start,save_len);}
  if jj_ast_is_symbol(core, 61) != 0 {
    if jj_c_array_type(local_type) != 0 { return 2; }var scalar_store_anchor:i64=core[49];var destination_node:i64=jj_operand_node_add(core,34|(local_authority_type<<16),save_anchor,save_start|(save_len<<32));if destination_node==0{return 2;}if jj_ast_next(core) == 0 { return 2; } var assigned_type: i64 = jj_c_parse_expr(core, 1, 0); if assigned_type == 0 { return 2; }var assigned_node:i64=jj_operand_tree_last(core);if assigned_node==0{return 2;} if jj_c_assign_compatible(local_type, assigned_type) == 0 { return 2; }if local_type==8{if jj_c_emit_op(core,44)==0{return 2;}}
    if jj_c_emit8(core, 3) == 0 { return 2; } if jj_c_emit16(core, local_slot) == 0 { return 2; }var scalar_store_node:i64=jj_operand_node_add(core,42|(local_authority_type<<16),scalar_store_anchor,save_start|((core[2]-save_start)<<32));if scalar_store_node==0{return 2;}if jj_operand_node_attach(core,destination_node,scalar_store_node,1)==0{return 2;}if jj_operand_node_attach(core,assigned_node,scalar_store_node,2)==0{return 2;}if jj_operand_tree_last_set(core,scalar_store_node)==0{return 2;} if jj_ast_is_symbol(core, 59) != 0 { if jj_ast_next(core) == 0 { return 2; } } else { if jj_ast_is_symbol(core, 125) == 0 { return 2; } } return 1;
  }
  if jj_ast_is_symbol(core, 91) != 0 {
    var assignment_index_anchor:i64=core[49];var address_pc:i64=core[9];var address_type: i64 = jj_c_emit_address(core, local_index); if address_type == 0 { return 2; }var address_node:i64=jj_operand_node_add(core,34|(address_type<<16),save_anchor,save_start|(save_len<<32));if address_node==0{return 2;} if jj_ast_next(core) == 0 { return 2; }
    var constant_index:i64=0;var constant_value:i64=0;if core[3]==2{constant_index=1;constant_value=core[6];}if jj_c_parse_expr(core, 1, 0) == 0 { return 2; }var index_node:i64=jj_operand_tree_last(core);if index_node==0{return 2;}if jj_c_narrow_authority(jj_c_operand_authority(core,index_node,1))!=0{return 2;} if jj_ast_need_symbol(core, 93) == 0 { return 2; }
    var index_pc:i64=core[9];if jj_c_array_type(address_type)!=0{var bound:i64=core[local_base+4];if constant_index!=0{if constant_value<0{return 2;}if constant_value>=bound{return 2;}}if jj_c_emit8(core,45)==0{return 2;}if jj_c_emit32(core,bound)==0{return 2;}}
    if address_type>=3{if address_type<=7{if address_type!=5{if jj_c_emit_imm(core,8)==0{return 2;}if jj_c_emit_op(core,11)==0{return 2;}}}}
    if address_type>=9{if address_type<=10{if jj_c_emit_imm(core,4)==0{return 2;}if jj_c_emit_op(core,11)==0{return 2;}}}
    if jj_c_emit_op(core, 9) == 0 { return 2; }var indexed_type:i64=1;if address_type==6{indexed_type=5;}if address_type==7{indexed_type=5;}if address_type==9{indexed_type=8;}if address_type==10{indexed_type=8;}var indexed_node:i64=jj_operand_node_add(core,38|(indexed_type<<16),assignment_index_anchor,save_start|((core[2]-save_start)<<32));if indexed_node==0{return 2;}if jj_operand_node_attach(core,address_node,indexed_node,1)==0{return 2;}if jj_operand_node_attach(core,index_node,indexed_node,2)==0{return 2;}
    var store_anchor:i64=core[49];if jj_ast_need_symbol(core, 61) == 0 { return 2; } var indexed_value_type: i64 = jj_c_parse_expr(core, 1, 0); if indexed_value_type == 0 { return 2; }var value_node:i64=jj_operand_tree_last(core);if value_node==0{return 2;}var store_pc:i64=core[9];
    if address_type == 2 { if jj_c_scalar_type(indexed_value_type) == 0 { return 2; } if jj_c_emit_op(core, 7) == 0 { return 2; } } else {if address_type==9{if jj_c_scalar_type(indexed_value_type)==0{return 2;}if jj_c_emit_op(core,44)==0{return 2;}if jj_c_emit_op(core,47)==0{return 2;}}else{if address_type==10{if jj_c_scalar_type(indexed_value_type)==0{return 2;}if jj_c_emit_op(core,44)==0{return 2;}if jj_c_emit_op(core,47)==0{return 2;}}else{ if jj_c_scalar_type(indexed_value_type) == 0 { return 2; } if jj_c_emit_op(core, 8) == 0 { return 2; } }}}
    var store_node:i64=jj_operand_node_add(core,41|(indexed_value_type<<16),store_anchor,save_start|((core[2]-save_start)<<32));if store_node==0{return 2;}if jj_operand_node_attach(core,indexed_node,store_node,1)==0{return 2;}if jj_operand_node_attach(core,value_node,store_node,2)==0{return 2;}if jj_operand_tree_last_set(core,store_node)==0{return 2;}
    if jj_ast_is_symbol(core, 59) != 0 { if jj_ast_next(core) == 0 { return 2; } } else { if jj_ast_is_symbol(core, 125) == 0 { return 2; } } return 1;
  }
  core[2] = save_pos; core[3] = save_kind; core[4] = save_start; core[5] = save_len; core[6] = save_value; core[9] = save_emit; return 0;
}
