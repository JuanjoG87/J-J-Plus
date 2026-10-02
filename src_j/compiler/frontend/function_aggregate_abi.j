// Internal aggregate ABI authority R707B. Logical aggregate parameter types
// remain nominal while their physical transport is one verified pointer slot.
extern fn jj_c_find_local(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_c_array_type(p0:i64)->i64;
extern fn jj_c_struct_type(p0:i64)->i64;
extern fn jj_core_index_record(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_core_index_append(p0:*i64,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_c_type_abi_class(p0:*i64,p1:i64)->i64;
extern fn jj_c_type_size_bytes(p0:*i64,p1:i64)->i64;

fn jj_c_add_parameter(core:*i64,start:i64,count:i64,type:i64,authority:i64,physical_slot:i64)->i64{
  if core[12]>=512{return 0;}if jj_c_find_local(core,start,count)!=0{return 0;}if physical_slot<0{return 0;}if physical_slot!=core[13]{return 0;}if jj_c_array_type(type)!=0{return 0;}
  var base:i64=500+core[12]*5;core[base]=start;core[base+1]=count;core[base+2]=type;core[base+3]=physical_slot;core[base+4]=authority;if jj_c_struct_type(type)!=0{core[base+4]=0-1;}
  core[12]=core[12]+1;core[13]=core[13]+1;return core[12];
}

fn jj_c_add_function_parameter(core:*i64,function_id:i64,ordinal:i64,type:i64,authority:i64,physical_slot:i64)->i64{
  if function_id<0{return 0;}if ordinal<0{return 0;}if ordinal>=12{return 0;}if type<=0{return 0;}if physical_slot<0{return 0;}var abi_class:i64=1;var size_bytes:i64=8;if jj_c_struct_type(type)!=0{abi_class=jj_c_type_abi_class(core,type);size_bytes=jj_c_type_size_bytes(core,type);if abi_class==0{return 0;}if size_bytes<=0{return 0;}}var fields:[7]i64;fields[0]=function_id;fields[1]=ordinal;fields[2]=type;fields[3]=authority;fields[4]=physical_slot;fields[5]=abi_class;fields[6]=size_bytes;return jj_core_index_append(core,9,fields as *i64,7);
}

fn jj_c_function_parameter_type(core:*i64,function_id:i64,ordinal:i64)->i64{
  if function_id<0{return 0;}if ordinal<0{return 0;}var i:i64=0;while i<4096{var r:*i64=jj_core_index_record(core,9,i) as *i64;if r==0{return 0;}if r[1]==function_id{if r[2]==ordinal{return r[3];}}i=i+1;}return 0;
}

fn jj_c_function_parameter_authority(core:*i64,function_id:i64,ordinal:i64)->i64{
  if function_id<0{return 0;}if ordinal<0{return 0;}var i:i64=0;while i<4096{var r:*i64=jj_core_index_record(core,9,i) as *i64;if r==0{return 0;}if r[1]==function_id{if r[2]==ordinal{return r[4];}}i=i+1;}return 0;
}
fn jj_c_function_parameter_abi_class(core:*i64,function_id:i64,ordinal:i64)->i64{
  if function_id<0{return 0;}if ordinal<0{return 0;}var i:i64=0;while i<4096{var r:*i64=jj_core_index_record(core,9,i) as *i64;if r==0{return 0;}if r[1]==function_id{if r[2]==ordinal{return r[6];}}i=i+1;}return 0;
}

fn jj_c_function_parameter_size_bytes(core:*i64,function_id:i64,ordinal:i64)->i64{
  if function_id<0{return 0;}if ordinal<0{return 0;}var i:i64=0;while i<4096{var r:*i64=jj_core_index_record(core,9,i) as *i64;if r==0{return 0;}if r[1]==function_id{if r[2]==ordinal{return r[7];}}i=i+1;}return 0;
}
