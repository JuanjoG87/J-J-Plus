// R713 internal x86-64 aggregate register ABI authority.
// Logical CIR values remain aggregate pointers. This module expands only the
// physical call boundary into INTEGER, INTEGER_PAIR or MEMORY transport.
extern fn jj_core_function_return_type(p0:*i64,p1:i64)->i64;
extern fn jj_core_function_field(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_struct_type(p0:i64)->i64;
extern fn jj_c_type_abi_class(p0:*i64,p1:i64)->i64;
extern fn jj_c_type_size_bytes(p0:*i64,p1:i64)->i64;
extern fn jj_c_function_parameter_type(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_function_parameter_abi_class(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_function_parameter_size_bytes(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_n_e8(p0:*i64,p1:i64)->i64;
extern fn jj_n_e32(p0:*i64,p1:i64)->i64;
extern fn jj_n_disp(p0:i64)->i64;
extern fn jj_n_emit_store_arg_slot(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_n_emit_pop_arg(p0:*i64,p1:i64)->i64;

fn jj_xagg_return_class(core:*i64,function_id:i64)->i64{
  if core==0{return 0;}var type:i64=jj_core_function_return_type(core,function_id);if jj_c_struct_type(type)==0{return 0;}return jj_c_type_abi_class(core,type);
}
fn jj_xagg_return_slots(core:*i64,function_id:i64)->i64{
  var type:i64=jj_core_function_return_type(core,function_id);if jj_c_struct_type(type)==0{return 0;}var bytes:i64=jj_c_type_size_bytes(core,type);if bytes<=0{return 0;}return (bytes+7)/8;
}
fn jj_xagg_has_aggregate_return(core:*i64,function_id:i64)->i64{if jj_xagg_return_class(core,function_id)!=0{return 1;}return 0;}
fn jj_xagg_source_argc(core:*i64,function_id:i64)->i64{
  var argc:i64=jj_core_function_field(core,function_id,3);if argc<0{return 0-1;}if jj_xagg_has_aggregate_return(core,function_id)!=0{argc=argc-1;}if argc<0{return 0-1;}return argc;
}
fn jj_xagg_param_class(core:*i64,function_id:i64,ordinal:i64)->i64{
  var type:i64=jj_c_function_parameter_type(core,function_id,ordinal);if type==0{return 0;}if jj_c_struct_type(type)==0{return 1;}return jj_c_function_parameter_abi_class(core,function_id,ordinal);
}
fn jj_xagg_param_slots(core:*i64,function_id:i64,ordinal:i64)->i64{
  var type:i64=jj_c_function_parameter_type(core,function_id,ordinal);if type==0{return 0;}if jj_c_struct_type(type)==0{return 1;}var bytes:i64=jj_c_function_parameter_size_bytes(core,function_id,ordinal);if bytes<=0{return 0;}return (bytes+7)/8;
}
fn jj_xagg_param_registers(core:*i64,function_id:i64,ordinal:i64)->i64{
  var class:i64=jj_xagg_param_class(core,function_id,ordinal);if class==1{return 1;}if class==5{return 2;}if class==4{return 1;}return 0;
}
fn jj_xagg_physical_argc(core:*i64,function_id:i64)->i64{
  var source_argc:i64=jj_xagg_source_argc(core,function_id);if source_argc<0{return 0-1;}var count:i64=0;var rc:i64=jj_xagg_return_class(core,function_id);if rc==4{count=1;}var i:i64=0;while i<source_argc{var add:i64=jj_xagg_param_registers(core,function_id,i);if add<=0{return 0-1;}if count>6-add{return 0-1;}count=count+add;i=i+1;}return count;
}
fn jj_xagg_signature_extended(core:*i64,function_id:i64)->i64{
  if jj_xagg_return_class(core,function_id)!=0{return 1;}var n:i64=jj_xagg_source_argc(core,function_id);if n<0{return 0;}var i:i64=0;while i<n{var type:i64=jj_c_function_parameter_type(core,function_id,i);if jj_c_struct_type(type)!=0{return 1;}i=i+1;}return 0;
}
fn jj_xagg_backing_slots(core:*i64,function_id:i64)->i64{
  var total:i64=0;var rc:i64=jj_xagg_return_class(core,function_id);if rc==1{total=total+1;}else{if rc==5{total=total+2;}}
  var n:i64=jj_xagg_source_argc(core,function_id);if n<0{return 0-1;}var i:i64=0;while i<n{var pc:i64=jj_xagg_param_class(core,function_id,i);if pc==1{var type:i64=jj_c_function_parameter_type(core,function_id,i);if jj_c_struct_type(type)!=0{total=total+1;}}else{if pc==5{total=total+2;}}i=i+1;}return total;
}
fn jj_xagg_emit_lea_slot(state:*i64,slot:i64)->i64{
  if slot<0{return 0;}if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x8d)==0{return 0;}if jj_n_e8(state,0x85)==0{return 0;}return jj_n_e32(state,jj_n_disp(slot));
}
fn jj_xagg_emit_store_rax_slot(state:*i64,slot:i64)->i64{
  if slot<0{return 0;}if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0x85)==0{return 0;}return jj_n_e32(state,jj_n_disp(slot));
}
fn jj_xagg_prologue_size(core:*i64,function_id:i64)->i64{
  if jj_xagg_physical_argc(core,function_id)<0{return 0;}var size:i64=11;var cursor:i64=jj_core_function_field(core,function_id,4);if cursor<0{return 0;}var rc:i64=jj_xagg_return_class(core,function_id);if rc==4{size=size+7;}else{if rc==1{size=size+14;cursor=cursor+1;}else{if rc==5{size=size+14;cursor=cursor+2;}}}
  var n:i64=jj_xagg_source_argc(core,function_id);var i:i64=0;while i<n{var class:i64=jj_xagg_param_class(core,function_id,i);if class==1{var type:i64=jj_c_function_parameter_type(core,function_id,i);if jj_c_struct_type(type)!=0{size=size+21;cursor=cursor+1;}else{size=size+7;}}else{if class==5{size=size+28;cursor=cursor+2;}else{if class==4{size=size+7;}else{return 0;}}}i=i+1;}return size;
}
fn jj_xagg_emit_prologue_args(state:*i64,core:*i64,function_id:i64,locals:i64)->i64{
  var physical:i64=jj_xagg_physical_argc(core,function_id);if physical<0{return 0;}if physical>6{return 0;}var cursor:i64=locals;var reg:i64=0;var rc:i64=jj_xagg_return_class(core,function_id);var has_return:i64=0;if rc!=0{has_return=1;}
  if rc==4{if jj_n_emit_store_arg_slot(state,0,0)==0{return 0;}reg=1;}else{if rc==1{if jj_xagg_emit_lea_slot(state,cursor)==0{return 0;}if jj_xagg_emit_store_rax_slot(state,0)==0{return 0;}cursor=cursor+1;}else{if rc==5{if jj_xagg_emit_lea_slot(state,cursor+1)==0{return 0;}if jj_xagg_emit_store_rax_slot(state,0)==0{return 0;}cursor=cursor+2;}}}
  var n:i64=jj_xagg_source_argc(core,function_id);var i:i64=0;while i<n{var logical_slot:i64=i+has_return;var class:i64=jj_xagg_param_class(core,function_id,i);var type:i64=jj_c_function_parameter_type(core,function_id,i);if class==1{if jj_c_struct_type(type)!=0{if jj_n_emit_store_arg_slot(state,reg,cursor)==0{return 0;}if jj_xagg_emit_lea_slot(state,cursor)==0{return 0;}if jj_xagg_emit_store_rax_slot(state,logical_slot)==0{return 0;}cursor=cursor+1;}else{if jj_n_emit_store_arg_slot(state,reg,logical_slot)==0{return 0;}}reg=reg+1;}else{if class==5{if jj_n_emit_store_arg_slot(state,reg,cursor+1)==0{return 0;}if jj_n_emit_store_arg_slot(state,reg+1,cursor)==0{return 0;}if jj_xagg_emit_lea_slot(state,cursor+1)==0{return 0;}if jj_xagg_emit_store_rax_slot(state,logical_slot)==0{return 0;}cursor=cursor+2;reg=reg+2;}else{if class==4{if jj_n_emit_store_arg_slot(state,reg,logical_slot)==0{return 0;}reg=reg+1;}else{return 0;}}}i=i+1;}if reg!=physical{return 0;}return 1;
}
fn jj_xagg_emit_pop_r11(state:*i64)->i64{if jj_n_e8(state,0x41)==0{return 0;}return jj_n_e8(state,0x5b);}
fn jj_xagg_emit_push_r11(state:*i64)->i64{if jj_n_e8(state,0x41)==0{return 0;}return jj_n_e8(state,0x53);}
fn jj_xagg_emit_load_arg_lane(state:*i64,index:i64,offset:i64)->i64{
  if index<0{return 0;}if index>5{return 0;}var regcode:i64=0;var rex:i64=0x49;if index==0{regcode=7;}else{if index==1{regcode=6;}else{if index==2{regcode=2;}else{if index==3{regcode=1;}else{if index==4{regcode=0;rex=0x4d;}else{regcode=1;rex=0x4d;}}}}}if jj_n_e8(state,rex)==0{return 0;}if jj_n_e8(state,0x8b)==0{return 0;}if offset==0{return jj_n_e8(state,(regcode<<3)|3);}if offset==8{if jj_n_e8(state,0x40|(regcode<<3)|3)==0{return 0;}return jj_n_e8(state,8);}return 0;
}
fn jj_xagg_emit_store_r11_slot(state:*i64,slot:i64)->i64{if jj_n_e8(state,0x4c)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0x9d)==0{return 0;}return jj_n_e32(state,jj_n_disp(slot));}
fn jj_xagg_emit_load_r11_slot(state:*i64,slot:i64)->i64{if jj_n_e8(state,0x4c)==0{return 0;}if jj_n_e8(state,0x8b)==0{return 0;}if jj_n_e8(state,0x9d)==0{return 0;}return jj_n_e32(state,jj_n_disp(slot));}
fn jj_xagg_pop_size_for_reg(index:i64)->i64{if index<0{return 0;}if index<4{return 1;}if index<6{return 2;}return 0;}
fn jj_xagg_load_lane_size(index:i64,offset:i64)->i64{if index<0{return 0;}if index>5{return 0;}if offset==0{return 3;}if offset==8{return 4;}return 0;}
fn jj_xagg_call_size(core:*i64,called:i64)->i64{
  var physical:i64=jj_xagg_physical_argc(core,called);if physical<0{return 0;}if physical>6{return 0;}var rc:i64=jj_xagg_return_class(core,called);var size:i64=23;var n:i64=jj_xagg_source_argc(core,called);if n<0{return 0;}if rc==1{size=size+2+7+7+3+2;}else{if rc==5{size=size+2+7+7+3+4+2;}else{if rc==4{size=size+jj_xagg_pop_size_for_reg(0)+1;}else{size=size+1;}}}
  var starts:[12]i64;var reg:i64=0;if rc==4{reg=1;}var i:i64=0;while i<n{starts[i]=reg;var add:i64=jj_xagg_param_registers(core,called,i);if add<=0{return 0;}reg=reg+add;i=i+1;}i=n;while i>0{i=i-1;var class:i64=jj_xagg_param_class(core,called,i);var type:i64=jj_c_function_parameter_type(core,called,i);if class==1{if jj_c_struct_type(type)!=0{size=size+2+jj_xagg_load_lane_size(starts[i],0);}else{size=size+jj_xagg_pop_size_for_reg(starts[i]);}}else{if class==5{size=size+2+jj_xagg_load_lane_size(starts[i],0)+jj_xagg_load_lane_size(starts[i]+1,8);}else{if class==4{size=size+jj_xagg_pop_size_for_reg(starts[i]);}else{return 0;}}}}return size;
}
fn jj_xagg_emit_call_args(state:*i64,core:*i64,called:i64)->i64{
  var rc:i64=jj_xagg_return_class(core,called);var n:i64=jj_xagg_source_argc(core,called);if n<0{return 0;}var starts:[12]i64;var reg:i64=0;if rc==4{reg=1;}var i:i64=0;while i<n{starts[i]=reg;var add:i64=jj_xagg_param_registers(core,called,i);if add<=0{return 0;}reg=reg+add;i=i+1;}if reg>6{return 0;}if rc==4{if jj_n_emit_pop_arg(state,0)==0{return 0;}}i=n;while i>0{i=i-1;var class:i64=jj_xagg_param_class(core,called,i);var type:i64=jj_c_function_parameter_type(core,called,i);if class==1{if jj_c_struct_type(type)!=0{if jj_xagg_emit_pop_r11(state)==0{return 0;}if jj_xagg_emit_load_arg_lane(state,starts[i],0)==0{return 0;}}else{if jj_n_emit_pop_arg(state,starts[i])==0{return 0;}}}else{if class==5{if jj_xagg_emit_pop_r11(state)==0{return 0;}if jj_xagg_emit_load_arg_lane(state,starts[i],0)==0{return 0;}if jj_xagg_emit_load_arg_lane(state,starts[i]+1,8)==0{return 0;}}else{if class==4{if jj_n_emit_pop_arg(state,starts[i])==0{return 0;}else{} }else{return 0;}}}}return 1;
}
fn jj_xagg_emit_direct_result_store(state:*i64,class:i64,dest_slot:i64)->i64{
  if jj_xagg_emit_load_r11_slot(state,dest_slot)==0{return 0;}if jj_n_e8(state,0x49)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0x03)==0{return 0;}if class==5{if jj_n_e8(state,0x49)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0x53)==0{return 0;}if jj_n_e8(state,8)==0{return 0;}}return jj_xagg_emit_push_r11(state);
}
fn jj_xagg_return_size(core:*i64,function_id:i64)->i64{var rc:i64=jj_xagg_return_class(core,function_id);if rc==1{return 7;}if rc==5{return 11;}return 3;}
fn jj_xagg_emit_return(state:*i64,core:*i64,function_id:i64)->i64{
  var rc:i64=jj_xagg_return_class(core,function_id);if rc==1{if jj_xagg_emit_pop_r11(state)==0{return 0;}if jj_n_e8(state,0x49)==0{return 0;}if jj_n_e8(state,0x8b)==0{return 0;}if jj_n_e8(state,0x03)==0{return 0;}if jj_n_e8(state,0xc9)==0{return 0;}return jj_n_e8(state,0xc3);}if rc==5{if jj_xagg_emit_pop_r11(state)==0{return 0;}if jj_n_e8(state,0x49)==0{return 0;}if jj_n_e8(state,0x8b)==0{return 0;}if jj_n_e8(state,0x03)==0{return 0;}if jj_n_e8(state,0x49)==0{return 0;}if jj_n_e8(state,0x8b)==0{return 0;}if jj_n_e8(state,0x53)==0{return 0;}if jj_n_e8(state,8)==0{return 0;}if jj_n_e8(state,0xc9)==0{return 0;}return jj_n_e8(state,0xc3);}if jj_n_e8(state,0x58)==0{return 0;}if jj_n_e8(state,0xc9)==0{return 0;}return jj_n_e8(state,0xc3);
}
fn jj_xagg_abi_receipt(core:*i64,function_id:i64,signature:i64)->i64{
  var physical:i64=jj_xagg_physical_argc(core,function_id);if physical<0{return 0;}if physical>6{return 0;}var h:i64=0x4a4a583641474731^signature^(physical<<8)^jj_xagg_return_class(core,function_id);var n:i64=jj_xagg_source_argc(core,function_id);if n<0{return 0;}var i:i64=0;while i<n{h=((h<<7)|(h>>>57))^jj_xagg_param_class(core,function_id,i)^(jj_xagg_param_slots(core,function_id,i)<<16)^(i<<24);i=i+1;}if h==0{return 1;}return h;
}
