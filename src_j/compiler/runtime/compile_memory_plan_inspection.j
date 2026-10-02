// on-demand inspection companion; excluded from resident selfhost closures.
extern fn jj_compile_memory_plan_valid(p0:*i64)->i64;
extern fn jj_core_index_bind(p0:*i64,p1:*i64,p2:i64)->i64;

fn jj_compile_memory_plan_bind_index(state:*i64,core:*i64)->i64{
  if jj_compile_memory_plan_valid(state)==0{return 0;}if core==0{return 0;}var plan:*i64=((state as i64)+24) as *i64;var words:i64=(plan[1]-plan[0])/8;if words<64{return 0;}return jj_core_index_bind(core,(state[1]+plan[0]) as *i64,words);
}
