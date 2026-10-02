// R713 AArch64 aggregate ABI classification authority.
// Logical types are classified independently from physical transport.
extern fn jj_core_function_return_type(p0:*i64,p1:i64)->i64;
extern fn jj_core_function_field(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_struct_type(p0:i64)->i64;
extern fn jj_c_type_abi_class(p0:*i64,p1:i64)->i64;
extern fn jj_c_function_parameter_type(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_function_parameter_abi_class(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_function_parameter_size_bytes(p0:*i64,p1:i64,p2:i64)->i64;
fn jj_a64agg_return_class(core:*i64,function_id:i64)->i64{if core==0{return 0;}var type:i64=jj_core_function_return_type(core,function_id);if jj_c_struct_type(type)==0{return 0;}return jj_c_type_abi_class(core,type);}
fn jj_a64agg_has_return(core:*i64,function_id:i64)->i64{if jj_a64agg_return_class(core,function_id)!=0{return 1;}return 0;}
fn jj_a64agg_source_argc(core:*i64,function_id:i64)->i64{var n:i64=jj_core_function_field(core,function_id,3);if n<0{return 0-1;}if jj_a64agg_has_return(core,function_id)!=0{n=n-1;}if n<0{return 0-1;}return n;}
fn jj_a64agg_param_class(core:*i64,function_id:i64,ordinal:i64)->i64{var type:i64=jj_c_function_parameter_type(core,function_id,ordinal);if type==0{return 0;}if jj_c_struct_type(type)==0{return 1;}return jj_c_function_parameter_abi_class(core,function_id,ordinal);}
fn jj_a64agg_param_slots(core:*i64,function_id:i64,ordinal:i64)->i64{var type:i64=jj_c_function_parameter_type(core,function_id,ordinal);if type==0{return 0;}if jj_c_struct_type(type)==0{return 1;}var bytes:i64=jj_c_function_parameter_size_bytes(core,function_id,ordinal);if bytes<=0{return 0;}return (bytes+7)/8;}
fn jj_a64agg_param_registers(core:*i64,function_id:i64,ordinal:i64)->i64{var class:i64=jj_a64agg_param_class(core,function_id,ordinal);if class==1{return 1;}if class==5{return 2;}if class==4{return 1;}return 0;}
fn jj_a64agg_physical_argc(core:*i64,function_id:i64)->i64{var n:i64=jj_a64agg_source_argc(core,function_id);if n<0{return 0-1;}var total:i64=0;var i:i64=0;while i<n{var add:i64=jj_a64agg_param_registers(core,function_id,i);if add<=0{return 0-1;}if total>8-add{return 0-1;}total=total+add;i=i+1;}return total;}
fn jj_a64agg_signature_extended(core:*i64,function_id:i64)->i64{if jj_a64agg_has_return(core,function_id)!=0{return 1;}var n:i64=jj_a64agg_source_argc(core,function_id);if n<0{return 0;}var i:i64=0;while i<n{if jj_c_struct_type(jj_c_function_parameter_type(core,function_id,i))!=0{return 1;}i=i+1;}return 0;}
fn jj_a64s_function_sret(core:*i64,function_id:i64)->i64{if jj_a64agg_return_class(core,function_id)==4{return 1;}return 0;}
fn jj_a64agg_backing_slots(core:*i64,function_id:i64)->i64{var total:i64=0;var rc:i64=jj_a64agg_return_class(core,function_id);if rc==1{total=1;}else{if rc==5{total=2;}}var n:i64=jj_a64agg_source_argc(core,function_id);if n<0{return 0-1;}var i:i64=0;while i<n{var pc:i64=jj_a64agg_param_class(core,function_id,i);if pc==1{if jj_c_struct_type(jj_c_function_parameter_type(core,function_id,i))!=0{total=total+1;}}else{if pc==5{total=total+2;}}i=i+1;}return total;}
fn jj_a64agg_abi_receipt(core:*i64,function_id:i64,signature:i64)->i64{var physical:i64=jj_a64agg_physical_argc(core,function_id);if physical<0{return 0;}if physical>8{return 0;}var h:i64=0x4a4a413634414747^signature^(physical<<8)^jj_a64agg_return_class(core,function_id);var n:i64=jj_a64agg_source_argc(core,function_id);var i:i64=0;while i<n{h=((h<<7)|(h>>>57))^jj_a64agg_param_class(core,function_id,i)^(jj_a64agg_param_slots(core,function_id,i)<<16)^(i<<24);i=i+1;}if h==0{return 1;}return h;}
