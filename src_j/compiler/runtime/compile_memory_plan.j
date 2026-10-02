// Versioned caller-owned compile memory plan.
// Layout: magic, object base/capacity, 12 logical arena words, address-bound seal.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_core_index_bind(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_runtime_elastic_reserve(p0:i64)->i64;
extern fn jj_raw_elastic_buffer()->i64;
extern fn jj_runtime_elastic_capacity()->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_n_object_arena_validate(plan:*i64,capacity:i64)->i64{
  if plan==0{return 0;}if capacity<=0{return 0;}
  if plan[0]<262144{return 0;}if plan[1]<=plan[0]{return 0;}if plan[2]<=262144{return 0;}if plan[3]<=plan[1]{return 0;}if plan[4]<=0{return 0;}if plan[5]<=plan[3]{return 0;}if plan[6]<=0{return 0;}if plan[7]<=plan[5]{return 0;}if plan[8]<=0{return 0;}if plan[9]!=capacity{return 0;}if plan[10]!=0{return 0;}if plan[11]!=capacity{return 0;}
  if ((plan[1]-plan[0])&7)!=0{return 0;}if plan[1]-plan[0]<4096{return 0;}
  if plan[1]>capacity-plan[2]{return 0;}if plan[1]+plan[2]!=plan[3]{return 0;}
  if plan[3]>capacity-plan[4]{return 0;}if plan[3]+plan[4]!=plan[5]{return 0;}
  if plan[5]>capacity-plan[6]{return 0;}if plan[5]+plan[6]!=plan[7]{return 0;}
  if plan[7]>capacity-plan[8]{return 0;}if plan[7]+plan[8]!=capacity{return 0;}
  return 1;
}

fn jj_n_object_arena_plan(capacity:i64,plan:*i64)->i64{
  if plan==0{return 0;}if capacity<1048576{return 0;}
  var line_capacity:i64=32768;var abbrev_capacity:i64=4096;var info_capacity:i64=16384;var code_capacity:i64=(capacity*3)/8;code_capacity=code_capacity&0xffffffffffff0000;if code_capacity<=262144{return 0;}
  var reserved:i64=line_capacity+abbrev_capacity+info_capacity+code_capacity;if reserved<=0{return 0;}if capacity<=reserved{return 0;}
  var info_offset:i64=capacity-info_capacity;var abbrev_offset:i64=info_offset-abbrev_capacity;var line_offset:i64=abbrev_offset-line_capacity;var code_offset:i64=line_offset-code_capacity;
  if code_offset<393216{return 0;}var index_capacity:i64=(code_offset/8)&0xfffffffffffffff8;if index_capacity<32768{return 0;}var output_capacity:i64=code_offset-index_capacity;if output_capacity<262144{return 0;}
  plan[0]=output_capacity;plan[1]=code_offset;plan[2]=code_capacity;plan[3]=line_offset;plan[4]=line_capacity;plan[5]=abbrev_offset;plan[6]=abbrev_capacity;plan[7]=info_offset;plan[8]=info_capacity;plan[9]=capacity;plan[10]=0;plan[11]=capacity;
  return jj_n_object_arena_validate(plan,capacity);
}


fn jj_compile_memory_plan_clear(state:*i64)->i64{if state==0{return 0;}var i:i64=0;while i<16{state[i]=0;i=i+1;}return 1;}
fn jj_compile_memory_plan_seal(state:*i64)->i64{var seal:i64=(state as i64)^0x4a4a434d504c4e31;var i:i64=0;while i<15{seal=seal^state[i];i=i+1;}return seal;}
fn jj_compile_memory_plan_valid(state:*i64)->i64{
  if state==0{return 0;}if state[0]!=0x4a4a434d504c3031{return 0;}if state[1]==0{return 0;}if state[2]<1048576{return 0;}var state_base:i64=state as i64;var state_end:i64=state_base+128;var object_end:i64=state[1]+state[2];if state_end<=state_base{return 0;}if object_end<=state[1]{return 0;}if state_end>state[1]{if object_end>state_base{return 0;}}var plan:*i64=((state as i64)+24) as *i64;if jj_n_object_arena_validate(plan,state[2])==0{return 0;}if state[15]!=jj_compile_memory_plan_seal(state){return 0;}return 1;
}
fn jj_compile_memory_plan_bind(state:*i64,object:*i8,capacity:i64)->i64{
  if state==0{return 0;}if object==0{return 0;}if capacity<1048576{return 0;}var state_base:i64=state as i64;var state_end:i64=state_base+128;var object_base:i64=object as i64;var object_end:i64=object_base+capacity;if state_end<=state_base{return 0;}if object_end<=object_base{return 0;}if state_end>object_base{if object_end>state_base{return 0;}}if jj_compile_memory_plan_clear(state)==0{return 0;}var plan:*i64=((state as i64)+24) as *i64;if jj_n_object_arena_plan(capacity,plan)==0{return 0;}state[0]=0x4a4a434d504c3031;state[1]=object_base;state[2]=capacity;state[15]=jj_compile_memory_plan_seal(state);if jj_compile_memory_plan_valid(state)==0{jj_compile_memory_plan_clear(state);return 0;}return 1;
}

fn jj_compile_memory_plan_bind_host(state:*i64,requested_capacity:i64)->i64{if state==0{return 0;}if requested_capacity<1048576{return 0;}if jj_runtime_elastic_reserve(requested_capacity)==0{return 0;}var elastic:i64=jj_raw_elastic_buffer();if elastic==0{return 0;}var capacity:i64=jj_runtime_elastic_capacity();if capacity<requested_capacity{return 0;}return jj_compile_memory_plan_bind(state,elastic as *i8,requested_capacity);}

// Frontend memory context: durable program capability plus temporary token
// capability borrowed from native scratch until frontend publication completes.
fn jj_compile_frontend_context_clear(state:*i64)->i64{if state==0{return 0;}var i:i64=0;while i<8{state[i]=0;i=i+1;}return 1;}
fn jj_compile_frontend_context_seal(state:*i64)->i64{return (state as i64)^state[0]^state[1]^state[2]^state[3]^state[4]^state[5]^state[6]^0x4a4a46574d454d31;}
fn jj_compile_frontend_context_valid(state:*i64)->i64{
  if state==0{return 0;}if state[0]!=0x4a4a46574d303031{return 0;}if state[1]==0{return 0;}if state[2]<65536{return 0;}if state[3]==0{return 0;}if state[4]<65536{return 0;}if state[5]!=1{return 0;}if state[6]!=0{return 0;}var state_base:i64=state as i64;var state_end:i64=state_base+64;var program_end:i64=state[1]+state[2];var temporary_end:i64=state[3]+state[4];if state_end<=state_base{return 0;}if program_end<=state[1]{return 0;}if temporary_end<=state[3]{return 0;}if program_end>state[3]{if temporary_end>state[1]{return 0;}}if state_end>state[1]{if program_end>state_base{return 0;}}if state_end>state[3]{if temporary_end>state_base{return 0;}}if state[7]!=jj_compile_frontend_context_seal(state){return 0;}return 1;
}
fn jj_compile_frontend_context_bind(state:*i64,program:*i8,program_capacity:i64,temporary:*i8,temporary_capacity:i64)->i64{
  if state==0{return 0;}if jj_compile_frontend_context_clear(state)==0{return 0;}if program==0{return 0;}if program_capacity<65536{return 0;}if temporary==0{return 0;}if temporary_capacity<65536{return 0;}var program_base:i64=program as i64;var program_end:i64=program_base+program_capacity;var temporary_base:i64=temporary as i64;var temporary_end:i64=temporary_base+temporary_capacity;if program_end<=program_base{return 0;}if temporary_end<=temporary_base{return 0;}if program_end>temporary_base{if temporary_end>program_base{return 0;}}state[0]=0x4a4a46574d303031;state[1]=program_base;state[2]=program_capacity;state[3]=temporary_base;state[4]=temporary_capacity;state[5]=1;state[6]=0;state[7]=jj_compile_frontend_context_seal(state);if jj_compile_frontend_context_valid(state)==0{jj_compile_frontend_context_clear(state);return 0;}return 1;
}
fn jj_compile_frontend_program_base(state:*i64)->i64{if jj_compile_frontend_context_valid(state)==0{return 0;}return state[1];}
fn jj_compile_frontend_program_capacity(state:*i64)->i64{if jj_compile_frontend_context_valid(state)==0{return 0;}return state[2];}
fn jj_compile_frontend_temporary_base(state:*i64)->i64{if jj_compile_frontend_context_valid(state)==0{return 0;}return state[3];}
fn jj_compile_frontend_temporary_capacity(state:*i64)->i64{if jj_compile_frontend_context_valid(state)==0{return 0;}return state[4];}
fn jj_compile_memory_plan_frontend(state:*i64,core:*i64,context:*i64,program:*i8,program_capacity:i64)->i64{
  if jj_compile_memory_plan_valid(state)==0{return 0;}if core==0{return 0;}if context==0{return 0;}var plan:*i64=((state as i64)+24) as *i64;var available:i64=plan[0]-262144;if available<0{return 0;}var borrowed:i64=0;if core[198]==1{borrowed=(available/8)&0xfffffffffffffff8;}else{if core[198]==2{borrowed=(available/4)&0xfffffffffffffff8;}else{if core[198]!=0{return 0;}}}if borrowed<0{return 0;}if borrowed>available{return 0;}var index_offset:i64=plan[0]-borrowed;if index_offset<262144{return 0;}var words:i64=(plan[1]-index_offset)/8;if words<64{return 0;}var temporary:*i8=(state[1]+plan[1]) as *i8;if jj_compile_frontend_context_bind(context,program,program_capacity,temporary,plan[2])==0{return 0;}if jj_core_index_bind(core,(state[1]+index_offset) as *i64,words)==0{jj_compile_frontend_context_clear(context);return 0;}return 1;
}
