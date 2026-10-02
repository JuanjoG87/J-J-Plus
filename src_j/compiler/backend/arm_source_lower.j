// Source-to-CIR narrow lowering. ARM consumes a sealed, address-bound CIR view
// and never reparses source or reads raw Core State table offsets.
extern fn jj_core_external_count(p0:*i64)->i64;
extern fn jj_core_function_count(p0:*i64)->i64;
extern fn jj_core_function_field(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_core_function_return_type(p0:*i64,p1:i64)->i64;
extern fn jj_core_function_signature(p0:*i64,p1:i64)->i64;
extern fn jj_core_effect_alias_field(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_core_effect_transform_field(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_core_effect_transformed_alias_field(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_core_target_kind(p0:*i64)->i64;
extern fn jj_cir_view_valid(p0:*i64)->i64;
extern fn jj_cir_begin(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_add_argument(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_add_constant(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_add_binary(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_cir_finish(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_abort(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_begin(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_function_add_block(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_add_node(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_cir_function_add_load(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_function_add_address_offset(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_cir_function_set_return(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_function_set_branch_zero(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_cir_function_finish(p0:*i64,p1:i64)->i64;

fn jj_arm_rd16(p:*i8)->i64{if p==0{return 0;}return (p[0]&255)|((p[1]&255)<<8);}
fn jj_arm_rd32(p:*i8)->i64{if p==0{return 0;}return (p[0]&255)|((p[1]&255)<<8)|((p[2]&255)<<16)|((p[3]&255)<<24);}
fn jj_arm_rd64(p:*i8)->i64{if p==0{return 0;}var v:i64=0;var i:i64=0;while i<8{v=v|((p[i]&255)<<(i*8));i=i+1;}return v;}

fn jj_arm_name_is_probe(source:*i8,source_length:i64,start:i64,count:i64)->i64{
  if source==0{return 0;}if source_length<0{return 0;}if start<0{return 0;}if count!=8{return 0;}if source_length<count{return 0;}if start>source_length-count{return 0;}
  var n:[8]i64;n[0]=106;n[1]=106;n[2]=95;n[3]=112;n[4]=114;n[5]=111;n[6]=98;n[7]=101;
  var i:i64=0;while i<8{if source[start+i]!=n[i]{return 0;}i=i+1;}return 1;
}

fn jj_arm_binary_supported(op:i64)->i64{
  if op==9{return 1;}if op==10{return 1;}if op==11{return 1;}if op==16{return 1;}if op==17{return 1;}if op==18{return 1;}return 0;
}

fn jj_arm_ranges_overlap(a:*i8,alen:i64,b:*i8,blen:i64)->i64{
  if a==0{return 1;}if b==0{return 1;}if alen<=0{return 1;}if blen<=0{return 1;}var av:i64=a as i64;var bv:i64=b as i64;if av<0{return 1;}if bv<0{return 1;}
  if av>0x7fffffffffffffff-alen{return 1;}if bv>0x7fffffffffffffff-blen{return 1;}var ae:i64=av+alen;var be:i64=bv+blen;if av<be{if bv<ae{return 1;}}return 0;
}

fn jj_arm_cir_fail(view:*i64)->i64{
  if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;jj_cir_abort(cir,view[1]);return 0;
}

fn jj_arm_source_to_cfg_return_select(program:*i8,start:i64,program_size:i64,view:*i64)->i64{
  if program==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];if start<0{return 0;}if program_size<0{return 0;}
  if start>program_size{return 0;}var body_size:i64=program_size-start;if body_size!=28{if body_size!=33{if body_size!=43{return 0;}}}if program[start]!=2{return 0;}if jj_arm_rd16(program+start+1)!=0{return 0;}
  var true_value:i64=0;var false_value:i64=0;
  if body_size==43{if program[start+3]!=1{return 0;}if jj_arm_rd64(program+start+4)!=0{return 0;}var compare_op:i64=program[start+12];if compare_op!=19{if compare_op!=20{return 0;}}if program[start+13]!=28{return 0;}var compare_zero_target:i64=jj_arm_rd32(program+start+14);if program[start+18]!=27{return 0;}var compare_failure_at:i64=start+23;var compare_continue_at:i64=start+33;if compare_zero_target!=compare_failure_at{return 0;}if jj_arm_rd32(program+start+19)!=compare_continue_at{return 0;}if program[compare_failure_at]!=1{return 0;}var compare_failure_value:i64=jj_arm_rd64(program+compare_failure_at+1);if program[compare_failure_at+9]!=30{return 0;}if program[compare_continue_at]!=1{return 0;}var compare_continue_value:i64=jj_arm_rd64(program+compare_continue_at+1);if program[compare_continue_at+9]!=30{return 0;}if compare_op==20{true_value=compare_continue_value;false_value=compare_failure_value;}else{true_value=compare_failure_value;false_value=compare_continue_value;}}
  else{if program[start+3]!=28{return 0;}var zero_target:i64=jj_arm_rd32(program+start+4);if body_size==33{if program[start+8]==27{var failure_at:i64=start+13;var continue_at:i64=start+23;if zero_target!=failure_at{return 0;}if jj_arm_rd32(program+start+9)!=continue_at{return 0;}if program[failure_at]!=1{return 0;}false_value=jj_arm_rd64(program+failure_at+1);if program[failure_at+9]!=30{return 0;}if program[continue_at]!=1{return 0;}true_value=jj_arm_rd64(program+continue_at+1);if program[continue_at+9]!=30{return 0;}}else{var false_at33:i64=start+23;if zero_target!=false_at33{return 0;}if program[start+8]!=1{return 0;}true_value=jj_arm_rd64(program+start+9);if program[start+17]!=30{return 0;}if program[start+18]!=27{return 0;}if jj_arm_rd32(program+start+19)!=start+33{return 0;}if program[false_at33]!=1{return 0;}false_value=jj_arm_rd64(program+false_at33+1);if program[program_size-1]!=30{return 0;}}}
    else{var false_at28:i64=start+18;if zero_target!=false_at28{return 0;}if program[start+8]!=1{return 0;}true_value=jj_arm_rd64(program+start+9);if program[start+17]!=30{return 0;}if program[false_at28]!=1{return 0;}false_value=jj_arm_rd64(program+false_at28+1);if program[program_size-1]!=30{return 0;}}}
  if jj_cir_function_begin(cir,slots,1,1)==0{return 0;}var entry:i64=jj_cir_function_add_block(cir,slots);var nonzero:i64=jj_cir_function_add_block(cir,slots);var zero:i64=jj_cir_function_add_block(cir,slots);
  if entry!=1{return jj_arm_cir_fail(view);}if nonzero!=2{return jj_arm_cir_fail(view);}if zero!=3{return jj_arm_cir_fail(view);}var condition:i64=jj_cir_function_add_node(cir,slots,entry,1,0,0);if condition==0{return jj_arm_cir_fail(view);}
  if jj_cir_function_set_branch_zero(cir,slots,entry,condition,zero,nonzero)==0{return jj_arm_cir_fail(view);}var tv:i64=jj_cir_function_add_node(cir,slots,nonzero,2,0,true_value);if tv==0{return jj_arm_cir_fail(view);}if jj_cir_function_set_return(cir,slots,nonzero,tv)==0{return jj_arm_cir_fail(view);}
  var fv:i64=jj_cir_function_add_node(cir,slots,zero,2,0,false_value);if fv==0{return jj_arm_cir_fail(view);}if jj_cir_function_set_return(cir,slots,zero,fv)==0{return jj_arm_cir_fail(view);}return jj_cir_function_finish(cir,slots);
}

fn jj_arm_source_to_onearg_constant(program:*i8,start:i64,function_end:i64,view:*i64)->i64{
  if program==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];
  if start<0{return 0;}if function_end-start!=10{return 0;}if program[start]!=1{return 0;}if program[start+9]!=30{return 0;}
  if jj_cir_begin(cir,slots,1,1)==0{return 0;}var value:i64=jj_cir_add_constant(cir,slots,jj_arm_rd64(program+start+1));if value==0{return jj_arm_cir_fail(view);}
  return jj_cir_finish(cir,slots,value);
}

fn jj_arm_cir_onearg_load_i64_offset(view:*i64,offset:i64)->i64{
  if jj_cir_view_valid(view)==0{return 0;}if offset<0{return 0;}if offset>248{return 0;}if offset%8!=0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];
  if jj_cir_function_begin(cir,slots,1,1)==0{return 0;}var entry:i64=jj_cir_function_add_block(cir,slots);if entry!=1{return jj_arm_cir_fail(view);}
  var address:i64=jj_cir_function_add_node(cir,slots,entry,1,0,0);if address==0{return jj_arm_cir_fail(view);}
  if offset!=0{address=jj_cir_function_add_address_offset(cir,slots,entry,address,offset);if address==0{return jj_arm_cir_fail(view);}}
  var value:i64=jj_cir_function_add_load(cir,slots,entry,address);if value==0{return jj_arm_cir_fail(view);}
  if jj_cir_function_set_return(cir,slots,entry,value)==0{return jj_arm_cir_fail(view);}return jj_cir_function_finish(cir,slots);
}

fn jj_arm_source_to_onearg_direct_load_i64(program:*i8,start:i64,function_end:i64,view:*i64)->i64{
  if program==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];
  if start<0{return 0;}if function_end-start!=25{return 0;}
  // Canonical bytecode for arg[index] where arg:*i64: load arg, const index, const 8, mul, add, load64, return.
  if program[start]!=2{return 0;}if jj_arm_rd16(program+start+1)!=0{return 0;}
  if program[start+3]!=1{return 0;}var index:i64=jj_arm_rd64(program+start+4);if index<0{return 0-1601;}if index>31{return 0-1601;}
  if program[start+12]!=1{return 0;}if jj_arm_rd64(program+start+13)!=8{return 0;}
  if program[start+21]!=11{return 0;}if program[start+22]!=9{return 0;}if program[start+23]!=6{return 0;}if program[start+24]!=30{return 0;}
  return jj_arm_cir_onearg_load_i64_offset(view,index*8);
}

fn jj_arm_source_to_linear_noarg(program:*i8,start:i64,function_end:i64,view:*i64)->i64{
  if program==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];
  if start<0{return 0;}if function_end<=start{return 0;}if function_end-start<10{return 0;}if program[start]!=1{return 0;}
  if jj_cir_begin(cir,slots,0,1)==0{return 0;}var current:i64=jj_cir_add_constant(cir,slots,jj_arm_rd64(program+start+1));if current==0{return jj_arm_cir_fail(view);}
  var pc:i64=start+9;while pc<function_end{if program[pc]==30{if function_end-pc!=1{return jj_arm_cir_fail(view);}return jj_cir_finish(cir,slots,current);}
    if function_end-pc<10{return jj_arm_cir_fail(view);}if program[pc]!=1{return jj_arm_cir_fail(view);}var immediate:i64=jj_arm_rd64(program+pc+1);
    var iv:i64=jj_cir_add_constant(cir,slots,immediate);if iv==0{return jj_arm_cir_fail(view);}var op:i64=program[pc+9];if jj_arm_binary_supported(op)==0{return jj_arm_cir_fail(view);}
    current=jj_cir_add_binary(cir,slots,op,current,iv);if current==0{return jj_arm_cir_fail(view);}pc=pc+10;}return jj_arm_cir_fail(view);
}

fn jj_arm_source_to_two_function_passthrough_load(core:*i64,program:*i8,program_size:i64,view:*i64)->i64{
  if core==0{return 0;}if program==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}if program_size<=48{return 0;}
  if jj_core_function_count(core)!=2{return 0;}if jj_core_external_count(core)!=0{return 0;}
  if jj_core_function_return_type(core,0)!=1{return 0;}if jj_core_function_return_type(core,1)!=1{return 0;}
  var argc0:i64=jj_core_function_field(core,0,3);var argc1:i64=jj_core_function_field(core,1,3);
  var locals0:i64=jj_core_function_field(core,0,4);var locals1:i64=jj_core_function_field(core,1,4);
  if argc0!=1{return 0;}if argc1!=1{return 0;}if locals0!=1{return 0;}if locals1<1{return 0;}if locals1>65{return 0;}
  if jj_core_function_signature(core,0)!=74021{return 0;}if jj_core_function_signature(core,1)!=74021{return 0;}
  var start0:i64=jj_core_function_field(core,0,2);var start1:i64=jj_core_function_field(core,1,2);var body_end:i64=jj_arm_rd64(program+40);
  if start0<48{return 0;}if start1<=start0{return 0;}if body_end<=start1{return 0;}if body_end>program_size{return 0;}
  var alias_count:i64=locals1-1;var wrapper_size:i64=body_end-start1;
  if alias_count==1{if wrapper_size==24{
    if program[start1]!=2{return 0;}if jj_arm_rd16(program+start1+1)!=0{return 0;}
    var tp:i64=start1+3;if program[tp]!=1{return 0;}var transform_offset:i64=jj_arm_rd64(program+tp+1);tp=tp+9;if program[tp]!=9{return 0;}tp=tp+1;
    if program[tp]!=3{return 0;}if jj_arm_rd16(program+tp+1)!=1{return 0;}tp=tp+3;if program[tp]!=2{return 0;}if jj_arm_rd16(program+tp+1)!=1{return 0;}tp=tp+3;
    if program[tp]!=29{return 0;}if jj_arm_rd16(program+tp+1)!=0{return 0;}if program[tp+3]!=1{return 0;}if program[tp+4]!=30{return 0;}
    if jj_core_effect_transform_field(core,0,1)!=0{return 0;}if jj_core_effect_transform_field(core,0,2)!=transform_offset{return 0;}if jj_core_effect_transform_field(core,0,5)!=1{return 0;}if jj_core_effect_transform_field(core,0,6)!=43{return 0;}
    if jj_core_effect_transformed_alias_field(core,0,0)!=1{return 0;}if jj_core_effect_transformed_alias_field(core,0,1)!=0{return 0;}if jj_core_effect_transformed_alias_field(core,0,5)!=transform_offset{return 0;}if jj_core_effect_transformed_alias_field(core,0,6)!=1{return 0;}
    if jj_core_effect_transform_field(core,1,0)!=(0-1){return 0;}if jj_core_effect_transformed_alias_field(core,1,0)!=(0-1){return 0;}
    return jj_arm_cir_onearg_load_i64_offset(view,transform_offset);
  }}
  if wrapper_size!=8+alias_count*6{return 0;}
  if program[start1]!=2{return 0;}if jj_arm_rd16(program+start1+1)!=0{return 0;}
  var wp:i64=start1+3;var alias_ordinal:i64=1;
  while alias_ordinal<=alias_count{
    if program[wp]!=3{return 0;}if jj_arm_rd16(program+wp+1)!=alias_ordinal{return 0;}wp=wp+3;
    if program[wp]!=2{return 0;}if jj_arm_rd16(program+wp+1)!=alias_ordinal{return 0;}
    var alias_index:i64=alias_ordinal-1;if jj_core_effect_alias_field(core,alias_index,0)!=alias_ordinal{return 0;}if jj_core_effect_alias_field(core,alias_index,1)!=alias_index{return 0;}
    wp=wp+3;alias_ordinal=alias_ordinal+1;
  }
  if jj_core_effect_alias_field(core,alias_count,0)!=(0-1){return 0;}
  if program[wp]!=29{return 0;}if jj_arm_rd16(program+wp+1)!=0{return 0;}if program[wp+3]!=1{return 0;}if program[wp+4]!=30{return 0;}
  return jj_arm_source_to_onearg_direct_load_i64(program,start0,start1,view);
}

fn jj_arm_source_to_cir(source:*i8,source_length:i64,core:*i64,program:*i8,program_size:i64,view:*i64)->i64{
  if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];var cir_bytes:i64=slots*8;
  if source==0{return 0;}if core==0{return 0;}if program==0{return 0;}if source_length<=0{return 0;}if program_size<=0{return 0;}
  if jj_arm_ranges_overlap(cir as *i8,cir_bytes,source,source_length)!=0{return 0;}if jj_arm_ranges_overlap(cir as *i8,cir_bytes,core as *i8,32768)!=0{return 0;}if jj_arm_ranges_overlap(cir as *i8,cir_bytes,program,program_size)!=0{return 0;}
  if jj_cir_abort(cir,slots)==0{return 0;}var function_count:i64=jj_core_function_count(core);if jj_core_external_count(core)!=0{return 0;}
  if function_count==2{if jj_core_target_kind(core)!=7{return 0;}return jj_arm_source_to_two_function_passthrough_load(core,program,program_size,view);}
  if function_count!=1{return 0;}
  var name_start:i64=jj_core_function_field(core,0,0);var name_count:i64=jj_core_function_field(core,0,1);var start:i64=jj_core_function_field(core,0,2);
  var argc:i64=jj_core_function_field(core,0,3);var locals:i64=jj_core_function_field(core,0,4);if program_size<=48{return 0;}var table_offset:i64=jj_arm_rd64(program+32);var function_end:i64=jj_arm_rd64(program+40);
  if table_offset<=48{return 0;}if table_offset>=program_size{return 0;}if function_end<=48{return 0;}if function_end>table_offset{return 0;}if name_start<0{return 0;}if name_count<0{return 0;}if start<48{return 0;}if start>=function_end{return 0;}
  if jj_arm_name_is_probe(source,source_length,name_start,name_count)==0{return 0;}if jj_core_function_return_type(core,0)!=1{return 0;}if argc<0{return 0;}if argc>1{return 0;}if locals<argc{return 0;}
  if argc==1{
    if locals==1{if jj_arm_source_to_onearg_constant(program,start,function_end,view)!=0{return 1;}}
    var one_signature:i64=jj_core_function_signature(core,0);
    if one_signature!=74018{if one_signature!=74021{return 0;}}
    if locals==1{if one_signature==74021{var direct_load:i64=jj_arm_source_to_onearg_direct_load_i64(program,start,function_end,view);if direct_load==1{return 1;}if direct_load==0-1601{if jj_core_target_kind(core)==7{core[193]=1601;return 0;}}}}
    if locals==1{if one_signature==74018{if jj_arm_source_to_cfg_return_select(program,start,function_end,view)!=0{return 1;}}}
  }
  if argc==0{return jj_arm_source_to_linear_noarg(program,start,function_end,view);}
  if jj_cir_begin(cir,slots,argc,1)==0{return 0;}
  if locals!=1{return jj_arm_cir_fail(view);}if function_end-start<3{return jj_arm_cir_fail(view);}if program[start]!=2{return jj_arm_cir_fail(view);}if jj_arm_rd16(program+start+1)!=0{return jj_arm_cir_fail(view);}
  var current:i64=jj_cir_add_argument(cir,slots,0);if current==0{return jj_arm_cir_fail(view);}var pc:i64=start+3;
  while pc<function_end{if program[pc]==30{if function_end-pc!=1{return jj_arm_cir_fail(view);}return jj_cir_finish(cir,slots,current);}
    if function_end-pc<10{return jj_arm_cir_fail(view);}if program[pc]!=1{return jj_arm_cir_fail(view);}var immediate:i64=jj_arm_rd64(program+pc+1);
    var iv:i64=jj_cir_add_constant(cir,slots,immediate);if iv==0{return jj_arm_cir_fail(view);}var op:i64=program[pc+9];if jj_arm_binary_supported(op)==0{return jj_arm_cir_fail(view);}
    current=jj_cir_add_binary(cir,slots,op,current,iv);if current==0{return jj_arm_cir_fail(view);}pc=pc+10;}
  return jj_arm_cir_fail(view);
}
