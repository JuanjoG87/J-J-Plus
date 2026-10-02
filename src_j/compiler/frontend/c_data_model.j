// General aggregate data model R707. Logical layouts are byte based and live
// in the extensible core index instead of the historical fixed tail table.
// data model_EXTERN_PROTOTYPES_BEGIN
extern fn jj_c_emit16(p0: *i64, p1: i64) -> i64;
extern fn jj_c_emit8(p0: *i64, p1: i64) -> i64;
extern fn jj_ast_is_symbol(p0: *i64, p1: i64) -> i64;
extern fn jj_c_name_equal(p0: *i8, p1: i64, p2: i64, p3: i64, p4: i64) -> i64;
extern fn jj_ast_need_symbol(p0: *i64, p1: i64) -> i64;
extern fn jj_ast_next(p0: *i64) -> i64;
extern fn jj_c_parse_type(p0: *i64) -> i64;
extern fn jj_core_index_record(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_core_index_append(p0:*i64,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_c_emit_imm(p0:*i64,p1:i64)->i64;
extern fn jj_c_emit_op(p0:*i64,p1:i64)->i64;
extern fn jj_c_pointer_type(p0:i64)->i64;
extern fn jj_operand_node_add(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_operand_node_attach(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_c_parse_expr(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_scalar_type(p0:i64)->i64;
extern fn jj_c_array_type(p0:i64)->i64;
extern fn jj_c_struct_pointer_type(p0:i64)->i64;
extern fn jj_operand_tree_last(p0:*i64)->i64;
extern fn jj_c_operand_authority(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_narrow_authority(p0:i64)->i64;
extern fn jj_c_emit32(p0:*i64,p1:i64)->i64;
extern fn jj_c_assign_compatible(p0:i64,p1:i64)->i64;
extern fn jj_operand_tree_last_set(p0:*i64,p1:i64)->i64;
// data model_EXTERN_PROTOTYPES_END

fn jj_c_emit_string(core: *i64, start: i64, count: i64) -> i64 {
  if count < 0 { return 0; } if count > 4095 { return 0; }
  if jj_c_emit8(core,48)==0{return 0;} if jj_c_emit16(core,count)==0{return 0;}
  var source:*i8=core[0] as *i8;var i:i64=0;while i<count{if jj_c_emit8(core,source[start+i])==0{return 0;}i=i+1;}return 1;
}

fn jj_c_struct_type(type:i64)->i64{if type>=100{if type<=127{return 1;}}return 0;}
fn jj_c_struct_pointer_type(type:i64)->i64{if type>=200{if type<=227{return 1;}}return 0;}
fn jj_c_descriptor_array_type(type:i64)->i64{if type>=32{if type<=95{return 1;}}return 0;}

fn jj_c_align_up(value:i64,alignment:i64)->i64{
  if value<0{return 0-1;}if alignment<=0{return 0-1;}var rem:i64=value%alignment;if rem==0{return value;}var add:i64=alignment-rem;if value>0x7fffffffffffffff-add{return 0-1;}return value+add;
}

fn jj_c_array_record(core:*i64,type:i64)->i64{
  if jj_c_descriptor_array_type(type)==0{return 0;}var ordinal:i64=type-32;return jj_core_index_record(core,6,ordinal);
}

fn jj_c_struct_record(core:*i64,type:i64)->i64{
  if jj_c_struct_type(type)==0{return 0;}var ordinal:i64=type-100;if ordinal<0{return 0;}if ordinal>=core[32]{return 0;}return jj_core_index_record(core,4,ordinal);
}

fn jj_c_type_size_authority(core:*i64,type:i64,authority:i64)->i64{
  if type==1{if authority==252{return 1;}if authority==254{return 1;}return 8;}if type==5{return 8;}if type==8{return 4;}
  if type==2{return 8;}if type==3{return 8;}if type==6{return 8;}if type==9{return 8;}if jj_c_struct_pointer_type(type)!=0{return 8;}
  if jj_c_struct_type(type)!=0{var sr:*i64=jj_c_struct_record(core,type) as *i64;if sr==0{return 0;}return sr[4];}
  if jj_c_descriptor_array_type(type)!=0{var ar:*i64=jj_c_array_record(core,type) as *i64;if ar==0{return 0;}return ar[5];}
  return 0;
}

fn jj_c_type_alignment_authority(core:*i64,type:i64,authority:i64)->i64{
  if type==1{if authority==252{return 1;}if authority==254{return 1;}return 8;}if type==5{return 8;}if type==8{return 4;}
  if type==2{return 8;}if type==3{return 8;}if type==6{return 8;}if type==9{return 8;}if jj_c_struct_pointer_type(type)!=0{return 8;}
  if jj_c_struct_type(type)!=0{var sr:*i64=jj_c_struct_record(core,type) as *i64;if sr==0{return 0;}return sr[5];}
  if jj_c_descriptor_array_type(type)!=0{var ar:*i64=jj_c_array_record(core,type) as *i64;if ar==0{return 0;}return ar[6];}
  return 0;
}

fn jj_c_type_size_bytes(core:*i64,type:i64)->i64{return jj_c_type_size_authority(core,type,type);}
fn jj_c_type_alignment(core:*i64,type:i64)->i64{return jj_c_type_alignment_authority(core,type,type);}

fn jj_c_type_slots(core:*i64,type:i64)->i64{
  var size:i64=jj_c_type_size_bytes(core,type);if size<=0{return 0;}if size>262144{return 0;}return (size+7)/8;
}

fn jj_c_type_abi_class(core:*i64,type:i64)->i64{
  if jj_c_struct_type(type)==0{if jj_c_descriptor_array_type(type)==0{return 1;}}
  var size:i64=jj_c_type_size_bytes(core,type);if size<=0{return 0;}if size<=8{return 1;}if size<=16{return 5;}return 4;
}

fn jj_c_array_count(core:*i64,type:i64)->i64{var ar:*i64=jj_c_array_record(core,type) as *i64;if ar==0{return 0;}return ar[4];}
fn jj_c_array_element_type(core:*i64,type:i64)->i64{var ar:*i64=jj_c_array_record(core,type) as *i64;if ar==0{return 0;}return ar[2];}
fn jj_c_array_element_authority(core:*i64,type:i64)->i64{var ar:*i64=jj_c_array_record(core,type) as *i64;if ar==0{return 0;}return ar[3];}

fn jj_c_find_struct(core:*i64,start:i64,count:i64)->i64{
  var source:*i8=core[0] as *i8;var i:i64=0;while i<core[32]{var r:*i64=jj_core_index_record(core,4,i) as *i64;if r==0{return 0;}if jj_c_name_equal(source,start,count,r[1],r[2])!=0{return i+1;}i=i+1;}return 0;
}

fn jj_c_struct_size_bytes(core:*i64,type:i64)->i64{var r:*i64=jj_c_struct_record(core,type) as *i64;if r==0{return 0;}return r[4];}
fn jj_c_struct_alignment(core:*i64,type:i64)->i64{var r:*i64=jj_c_struct_record(core,type) as *i64;if r==0{return 0;}return r[5];}
fn jj_c_struct_slots(core:*i64,type:i64)->i64{var r:*i64=jj_c_struct_record(core,type) as *i64;if r==0{return 0;}return r[6];}
fn jj_c_struct_abi_class(core:*i64,type:i64)->i64{var r:*i64=jj_c_struct_record(core,type) as *i64;if r==0{return 0;}return r[7];}
fn jj_c_struct_field_count(core:*i64,type:i64)->i64{var r:*i64=jj_c_struct_record(core,type) as *i64;if r==0{return 0;}return r[3];}

fn jj_c_field_record(core:*i64,type:i64,field:i64)->i64{
  if jj_c_struct_type(type)==0{return 0;}if field<=0{return 0;}var owner:i64=type-100;var seen:i64=0;var i:i64=0;
  while 1{var r:*i64=jj_core_index_record(core,5,i) as *i64;if r==0{return 0;}if r[1]==owner{seen=seen+1;if seen==field{return (r as i64)+0;}}i=i+1;if i>4096{return 0;}}return 0;
}

fn jj_c_find_field(core:*i64,type:i64,start:i64,count:i64)->i64{
  if jj_c_struct_type(type)==0{return 0;}var owner:i64=type-100;var source:*i8=core[0] as *i8;var seen:i64=0;var i:i64=0;
  while 1{var r:*i64=jj_core_index_record(core,5,i) as *i64;if r==0{return 0;}if r[1]==owner{seen=seen+1;if jj_c_name_equal(source,start,count,r[2],r[3])!=0{return seen;}}i=i+1;if i>4096{return 0;}}return 0;
}

fn jj_c_field_type(core:*i64,type:i64,field:i64)->i64{var r:*i64=jj_c_field_record(core,type,field) as *i64;if r==0{return 0;}return r[4];}
fn jj_c_field_authority(core:*i64,type:i64,field:i64)->i64{var r:*i64=jj_c_field_record(core,type,field) as *i64;if r==0{return 0;}return r[5];}
fn jj_c_field_byte_offset(core:*i64,type:i64,field:i64)->i64{var r:*i64=jj_c_field_record(core,type,field) as *i64;if r==0{return 0-1;}return r[6];}
fn jj_c_field_slot_offset(core:*i64,type:i64,field:i64)->i64{var r:*i64=jj_c_field_record(core,type,field) as *i64;if r==0{return 0-1;}return r[7];}

fn jj_c_type_contains_struct(core:*i64,type:i64,needle:i64,depth:i64)->i64{
  if depth>32{return 1;}if type==needle{return 1;}if jj_c_descriptor_array_type(type)!=0{return jj_c_type_contains_struct(core,jj_c_array_element_type(core,type),needle,depth+1);}return 0;
}

fn jj_c_new_array_type(core:*i64,element_type:i64,element_authority:i64,count:i64)->i64{
  if count<=0{return 0;}if count>4096{return 0;}var ordinal:i64=0;while jj_core_index_record(core,6,ordinal)!=0{ordinal=ordinal+1;if ordinal>=64{return 0;}}
  var element_size:i64=jj_c_type_size_authority(core,element_type,element_authority);var alignment:i64=jj_c_type_alignment_authority(core,element_type,element_authority);if element_size<=0{return 0;}if alignment<=0{return 0;}if count>262144/element_size{return 0;}var size:i64=count*element_size;if size<=0{return 0;}if size>262144{return 0;}var slots:i64=(size+7)/8;var fields:[7]i64;fields[0]=32+ordinal;fields[1]=element_type;fields[2]=element_authority;fields[3]=count;fields[4]=size;fields[5]=alignment;fields[6]=slots;if jj_core_index_append(core,6,fields as *i64,7)==0{return 0;}return 32+ordinal;
}

fn jj_c_parse_field_type(core:*i64,depth:i64)->i64{
  if depth>16{return 0;}if jj_ast_is_symbol(core,91)!=0{
    if jj_ast_next(core)==0{return 0;}if core[3]!=2{return 0;}var count:i64=core[6];if count<=0{return 0;}if count>4096{return 0;}if jj_ast_next(core)==0{return 0;}if jj_ast_need_symbol(core,93)==0{return 0;}
    var element_type:i64=jj_c_parse_field_type(core,depth+1);if element_type==0{return 0;}var authority:i64=element_type;if element_type==1{authority=core[30];}return jj_c_new_array_type(core,element_type,authority,count);
  }
  return jj_c_parse_type(core);
}

fn jj_c_emit_offset(core:*i64,offset:i64)->i64{
  if offset<0{return 0;}if offset==0{return 1;}if jj_c_emit_imm(core,offset)==0{return 0;}return jj_c_emit_op(core,9);
}
fn jj_c_emit_load_authority(core:*i64,type:i64,authority:i64)->i64{
  if type==1{if authority==252{if jj_c_emit_op(core,5)==0{return 0;}return jj_c_emit_op(core,32);}if authority==254{return jj_c_emit_op(core,5);}return jj_c_emit_op(core,6);}if type==5{return jj_c_emit_op(core,6);}if type==8{return jj_c_emit_op(core,46);}
  if jj_c_pointer_type(type)!=0{return jj_c_emit_op(core,6);}return 0;
}
fn jj_c_emit_store_authority(core:*i64,type:i64,authority:i64)->i64{
  if type==1{if authority==252{return jj_c_emit_op(core,7);}if authority==254{return jj_c_emit_op(core,7);}return jj_c_emit_op(core,8);}if type==5{return jj_c_emit_op(core,8);}if type==8{if jj_c_emit_op(core,44)==0{return 0;}return jj_c_emit_op(core,47);}
  if jj_c_pointer_type(type)!=0{return jj_c_emit_op(core,8);}return 0;
}
fn jj_c_emit_load_type(core:*i64,type:i64)->i64{return jj_c_emit_load_authority(core,type,type);}
fn jj_c_emit_store_type(core:*i64,type:i64)->i64{return jj_c_emit_store_authority(core,type,type);}
fn jj_c_emit_local_aggregate_address(core:*i64,local_slot:i64,type:i64)->i64{
  var slots:i64=jj_c_type_slots(core,type);if slots<=0{return 0;}if jj_c_emit8(core,4)==0{return 0;}if jj_c_emit16(core,local_slot)==0{return 0;}if jj_c_emit16(core,slots)==0{return 0;}return 1;
}
fn jj_c_zero_aggregate_local(core:*i64,local_slot:i64,type:i64)->i64{
  var slots:i64=jj_c_type_slots(core,type);if slots<=0{return 0;}var i:i64=0;while i<slots{if jj_c_emit_imm(core,0)==0{return 0;}if jj_c_emit8(core,3)==0{return 0;}if jj_c_emit16(core,local_slot+i)==0{return 0;}i=i+1;}return 1;
}
fn jj_c_temp_slots(core:*i64,count:i64)->i64{
  if count<=0{return 0-1;}if core[13]>32768-count{return 0-1;}var first:i64=core[13];core[13]=core[13]+count;var fields:[2]i64;fields[0]=first;fields[1]=count;if jj_core_index_append(core,7,fields as *i64,2)==0{return 0-1;}return first;
}
fn jj_c_copy_pointer_to_local(core:*i64,destination_slot:i64,type:i64)->i64{
  var slots:i64=jj_c_type_slots(core,type);if slots<=0{return 0;}var temps:i64=jj_c_temp_slots(core,2);if temps<0{return 0;}if jj_c_emit8(core,3)==0{return 0;}if jj_c_emit16(core,temps+1)==0{return 0;}
  if jj_c_emit_local_aggregate_address(core,destination_slot,type)==0{return 0;}if jj_c_emit8(core,3)==0{return 0;}if jj_c_emit16(core,temps)==0{return 0;}
  var i:i64=0;while i<slots{if jj_c_emit8(core,2)==0{return 0;}if jj_c_emit16(core,temps)==0{return 0;}if jj_c_emit_offset(core,i*8)==0{return 0;}if jj_c_emit8(core,2)==0{return 0;}if jj_c_emit16(core,temps+1)==0{return 0;}if jj_c_emit_offset(core,i*8)==0{return 0;}if jj_c_emit_op(core,6)==0{return 0;}if jj_c_emit_op(core,8)==0{return 0;}i=i+1;}return 1;
}

fn jj_c_copy_pointer_to_pointer(core:*i64,type:i64)->i64{
  var slots:i64=jj_c_type_slots(core,type);if slots<=0{return 0;}var temps:i64=jj_c_temp_slots(core,2);if temps<0{return 0;}if jj_c_emit8(core,3)==0{return 0;}if jj_c_emit16(core,temps+1)==0{return 0;}if jj_c_emit8(core,3)==0{return 0;}if jj_c_emit16(core,temps)==0{return 0;}
  var i:i64=0;while i<slots{if jj_c_emit8(core,2)==0{return 0;}if jj_c_emit16(core,temps)==0{return 0;}if jj_c_emit_offset(core,i*8)==0{return 0;}if jj_c_emit8(core,2)==0{return 0;}if jj_c_emit16(core,temps+1)==0{return 0;}if jj_c_emit_offset(core,i*8)==0{return 0;}if jj_c_emit_op(core,6)==0{return 0;}if jj_c_emit_op(core,8)==0{return 0;}i=i+1;}return 1;
}

fn jj_c_return_aggregate(core:*i64,type:i64)->i64{
  if jj_c_struct_type(type)==0{return 0;}var source_slot:i64=jj_c_temp_slots(core,1);if source_slot<0{return 0;}if jj_c_emit8(core,3)==0{return 0;}if jj_c_emit16(core,source_slot)==0{return 0;}if jj_c_emit8(core,2)==0{return 0;}if jj_c_emit16(core,0)==0{return 0;}if jj_c_emit8(core,2)==0{return 0;}if jj_c_emit16(core,source_slot)==0{return 0;}if jj_c_copy_pointer_to_pointer(core,type)==0{return 0;}if jj_c_emit8(core,2)==0{return 0;}return jj_c_emit16(core,0);
}

fn jj_c_parse_index_chain(core:*i64,left_type:i64,left_bound:i64,left_node:i64,expression_start:i64,depth:i64)->i64{
  var load_final:i64=1;if left_bound<0{load_final=0;left_bound=0-left_bound-1;}var left_authority:i64=left_type;if core[192]!=0{left_authority=core[192];}
  while jj_ast_is_symbol(core, 91) != 0 {
    var base_node:i64=left_node;if base_node==0{return 0;}var index_start:i64=core[4];var index_anchor:i64=core[49];
    if jj_c_pointer_type(left_type)==0{if jj_c_array_type(left_type)==0{return 0;}}if jj_ast_next(core)==0{return 0;}var constant_index:i64=0;var constant_value:i64=0;if core[3]==2{constant_index=1;constant_value=core[6];}var index_type:i64=jj_c_parse_expr(core,1,depth+1);if jj_c_scalar_type(index_type)==0{return 0;}var index_node:i64=jj_operand_tree_last(core);if index_node==0{return 0;}if jj_c_narrow_authority(jj_c_operand_authority(core,index_node,index_type))!=0{return 0;}var index_end:i64=core[4]+core[5];if jj_ast_need_symbol(core,93)==0{return 0;}
    var element_type:i64=0;var element_authority:i64=0;var element_size:i64=0;var bound:i64=left_bound;
    if jj_c_descriptor_array_type(left_type)!=0{element_type=jj_c_array_element_type(core,left_type);element_authority=jj_c_array_element_authority(core,left_type);element_size=jj_c_type_size_authority(core,element_type,element_authority);if bound<=0{bound=jj_c_array_count(core,left_type);}}
    else{if left_type==2{element_type=1;element_size=1;}else{if left_type==3{element_type=1;element_size=8;}else{if left_type==4{element_type=1;element_size=8;}else{if left_type==6{element_type=5;element_size=8;}else{if left_type==7{element_type=5;element_size=8;}else{if left_type==9{element_type=8;element_size=4;}else{if left_type==10{element_type=8;element_size=4;}else{if jj_c_struct_pointer_type(left_type)!=0{element_type=100+(left_type-200);element_size=jj_c_type_size_bytes(core,element_type);}else{return 0;}}}}}}}}}
    if element_authority==0{element_authority=element_type;if element_type==1{if left_type==2{element_authority=254;}else{element_authority=255;}}}if element_type==0{return 0;}if element_size<=0{return 0;}if bound>0{if constant_index!=0{if constant_value<0{return 0;}if constant_value>=bound{return 0;}}if jj_c_emit8(core,45)==0{return 0;}if jj_c_emit32(core,bound)==0{return 0;}}if element_size!=1{if jj_c_emit_imm(core,element_size)==0{return 0;}if jj_c_emit_op(core,11)==0{return 0;}}if jj_c_emit_op(core,9)==0{return 0;}left_type=element_type;left_authority=element_authority;left_bound=0;
    if jj_c_descriptor_array_type(left_type)!=0{left_bound=jj_c_array_count(core,left_type);if left_bound<=0{return 0;}}else{if jj_c_struct_type(left_type)==0{if load_final!=0{if jj_c_emit_load_authority(core,left_type,left_authority)==0{return 0;}}}}
    if index_end<index_start{index_end=index_start;}left_node=jj_operand_node_add(core,38|(left_type<<16),index_anchor,expression_start|((index_end-expression_start)<<32));if left_node==0{return 0;}if jj_operand_node_attach(core,base_node,left_node,1)==0{return 0;}if jj_operand_node_attach(core,index_node,left_node,2)==0{return 0;}
  }
  core[16]=left_node;core[72]=left_bound;core[192]=left_authority;return left_type;
}

fn jj_c_local_aggregate_byref(core:*i64,local_slot:i64,local_type:i64)->i64{
  var i:i64=0;while i<core[12]{var base:i64=500+i*5;if core[base+2]==local_type{if core[base+3]==local_slot{if core[base+4]==0-1{return 1;}}}i=i+1;}return 0;
}

fn jj_c_parse_local_aggregate_value(core:*i64,local_type:i64,local_slot:i64,name_anchor:i64,name_start:i64,name_end:i64)->i64{
  var load_final:i64=1;if name_anchor<0{load_final=0;name_anchor=0-name_anchor-1;}
  if jj_c_local_aggregate_byref(core,local_slot,local_type)!=0{if jj_c_emit8(core,2)==0{return 0;}if jj_c_emit16(core,local_slot)==0{return 0;}}else{if jj_c_emit_local_aggregate_address(core,local_slot,local_type)==0{return 0;}}var left_type:i64=local_type;var left_authority:i64=local_type;var left_node:i64=jj_operand_node_add(core,34|(local_type<<16),name_anchor,name_start|((name_end-name_start)<<32));if left_node==0{return 0;}var left_bound:i64=0;
  while jj_ast_is_symbol(core,46)!=0{if jj_c_struct_type(left_type)==0{return 0;}var field_base_node:i64=left_node;if jj_ast_next(core)==0{return 0;}if core[3]!=1{return 0;}var field_anchor:i64=core[49];var field:i64=jj_c_find_field(core,left_type,core[4],core[5]);if field==0{return 0;}var field_end:i64=core[4]+core[5];var field_type:i64=jj_c_field_type(core,left_type,field);var field_authority:i64=jj_c_field_authority(core,left_type,field);var field_offset:i64=jj_c_field_byte_offset(core,left_type,field);if field_type==0{return 0;}if field_authority==0{return 0;}if field_offset<0{return 0;}if jj_c_emit_offset(core,field_offset)==0{return 0;}if jj_ast_next(core)==0{return 0;}left_type=field_type;left_authority=field_authority;left_node=jj_operand_node_add(core,40|(field_authority<<16),field_anchor,name_start|((field_end-name_start)<<32));if left_node==0{return 0;}if jj_operand_node_attach(core,field_base_node,left_node,1)==0{return 0;}if jj_ast_is_symbol(core,46)==0{if jj_c_descriptor_array_type(left_type)!=0{left_bound=jj_c_array_count(core,left_type);if left_bound<=0{return 0;}}else{if jj_c_struct_type(left_type)==0{if load_final!=0{if jj_c_emit_load_authority(core,left_type,left_authority)==0{return 0;}}}}break;}}
  core[16]=left_node;core[72]=left_bound;core[192]=left_authority;return left_type;
}

fn jj_c_prepare_aggregate_lvalue(core:*i64,local_type:i64,local_slot:i64,save_anchor:i64,save_start:i64,save_len:i64)->i64{
  var lvalue_type:i64=jj_c_parse_local_aggregate_value(core,local_type,local_slot,0-save_anchor-1,save_start,save_start+save_len);if lvalue_type==0{return 0;}var lvalue_node:i64=core[16];var lvalue_bound:i64=core[72];var lvalue_authority:i64=core[192];if lvalue_node==0{return 0;}
  if jj_ast_is_symbol(core,91)!=0{lvalue_type=jj_c_parse_index_chain(core,lvalue_type,0-lvalue_bound-1,lvalue_node,save_start,0);if lvalue_type==0{return 0;}lvalue_node=core[16];lvalue_authority=core[192];if lvalue_node==0{return 0;}}
  core[16]=lvalue_node;core[72]=lvalue_type;core[192]=lvalue_authority;return 1;
}

fn jj_c_commit_aggregate_assignment(core:*i64,lvalue_type:i64,lvalue_authority:i64,lvalue_node:i64,save_start:i64)->i64{
  if jj_ast_is_symbol(core,61)==0{return 2;}var store_anchor:i64=core[49];if jj_ast_next(core)==0{return 2;}var value_type:i64=jj_c_parse_expr(core,1,0);if value_type==0{return 2;}var value_node:i64=jj_operand_tree_last(core);if value_node==0{return 2;}var value_authority:i64=jj_c_operand_authority(core,value_node,value_type);if value_authority==0{return 2;}var target_authority:i64=lvalue_authority;if jj_c_assign_compatible(target_authority,value_authority)==0{return 2;}
  if jj_c_struct_type(lvalue_type)!=0{if value_type!=lvalue_type{return 2;}if jj_c_copy_pointer_to_pointer(core,lvalue_type)==0{return 2;}}else{if jj_c_descriptor_array_type(lvalue_type)!=0{if value_type!=lvalue_type{return 2;}if jj_c_copy_pointer_to_pointer(core,lvalue_type)==0{return 2;}}else{if jj_c_emit_store_authority(core,lvalue_type,lvalue_authority)==0{return 2;}}}
  var store_node:i64=jj_operand_node_add(core,43|(target_authority<<16),store_anchor,save_start|((core[2]-save_start)<<32));if store_node==0{return 2;}if jj_operand_node_attach(core,lvalue_node,store_node,1)==0{return 2;}if jj_operand_node_attach(core,value_node,store_node,2)==0{return 2;}if jj_operand_tree_last_set(core,store_node)==0{return 2;}if jj_ast_is_symbol(core,59)!=0{if jj_ast_next(core)==0{return 2;}}else{if jj_ast_is_symbol(core,125)==0{return 2;}}return 1;
}

fn jj_c_try_aggregate_assignment(core:*i64,local_type:i64,local_slot:i64,save_anchor:i64,save_start:i64,save_len:i64)->i64{
  if jj_c_prepare_aggregate_lvalue(core,local_type,local_slot,save_anchor,save_start,save_len)==0{return 2;}return jj_c_commit_aggregate_assignment(core,core[72],core[192],core[16],save_start);
}



fn jj_c_parse_struct(core:*i64)->i64{
  if core[32]>=28{return 0;}if jj_ast_next(core)==0{return 0;}if core[3]!=1{return 0;}
  var name_start:i64=core[4];var name_count:i64=core[5];if jj_c_find_struct(core,name_start,name_count)!=0{return 0;}
  var index:i64=core[32];var header_fields:[7]i64;header_fields[0]=name_start;header_fields[1]=name_count;header_fields[2]=0;header_fields[3]=0;header_fields[4]=1;header_fields[5]=0;header_fields[6]=0;
  if jj_core_index_append(core,4,header_fields as *i64,7)==0{return 0;}core[32]=index+1;var header:*i64=jj_core_index_record(core,4,index) as *i64;if header==0{return 0;}
  if jj_ast_next(core)==0{return 0;}if jj_ast_need_symbol(core,123)==0{return 0;}var size:i64=0;var max_alignment:i64=1;
  while jj_ast_is_symbol(core,125)==0{
    if core[3]!=1{return 0;}if header[3]>=32{return 0;}var field_start:i64=core[4];var field_count:i64=core[5];
    if jj_ast_next(core)==0{return 0;}if jj_ast_need_symbol(core,58)==0{return 0;}var field_type:i64=jj_c_parse_field_type(core,0);if field_type==0{return 0;}if jj_c_type_contains_struct(core,field_type,100+index,0)!=0{return 0;}
    if jj_c_find_field(core,100+index,field_start,field_count)!=0{return 0;}var field_authority:i64=field_type;if field_type==1{field_authority=core[30];}
    var field_size:i64=jj_c_type_size_authority(core,field_type,field_authority);var field_alignment:i64=jj_c_type_alignment_authority(core,field_type,field_authority);if field_size<=0{return 0;}if field_alignment<=0{return 0;}var offset:i64=jj_c_align_up(size,field_alignment);if offset<0{return 0;}if offset>262144-field_size{return 0;}size=offset+field_size;if field_alignment>max_alignment{max_alignment=field_alignment;}
    var field_fields:[7]i64;field_fields[0]=index;field_fields[1]=field_start;field_fields[2]=field_count;field_fields[3]=field_type;field_fields[4]=field_authority;field_fields[5]=offset;field_fields[6]=offset/8;if jj_core_index_append(core,5,field_fields as *i64,7)==0{return 0;}header[3]=header[3]+1;
    if jj_ast_need_symbol(core,59)==0{return 0;}
  }
  if header[3]==0{return 0;}var final_size:i64=jj_c_align_up(size,max_alignment);if final_size<=0{return 0;}if final_size>262144{return 0;}header[4]=final_size;header[5]=max_alignment;header[6]=(final_size+7)/8;if final_size<=8{header[7]=1;}else{if final_size<=16{header[7]=5;}else{header[7]=4;}}
  if jj_ast_next(core)==0{return 0;}if jj_ast_is_symbol(core,59)!=0{return jj_ast_next(core);}return 1;
}
