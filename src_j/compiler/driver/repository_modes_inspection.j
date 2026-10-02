// on-demand inspection companion; excluded from resident selfhost closures.
extern fn jj_parallel_valid(p0:*i64)->i64;
extern fn jj_parallel_op_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_vta_seal(p0:*i64,p1:i64)->i64;
extern fn jj_cirx_available_valid(p0:*i64)->i64;
extern fn jj_cirx_raw_op_word(p0:*i64,p1:i64,p2:i64)->i64;

fn jj_parallel_op_phase(core:*i64,index:i64)->i64{if jj_parallel_valid(core)==0{return 0;}return (jj_parallel_op_word(core,index,0)>>>32)&255;}
fn jj_parallel_op_placement(core:*i64,index:i64)->i64{if jj_parallel_valid(core)==0{return 0;}return jj_parallel_op_word(core,index,0)&0xffffffff;}
fn jj_parallel_op_temp(core:*i64,index:i64)->i64{if jj_parallel_valid(core)==0{return 0;}return jj_parallel_op_word(core,index,1)&0xffffffff;}
fn jj_parallel_op_payload(core:*i64,index:i64)->i64{if jj_parallel_valid(core)==0{return 0;}return (jj_parallel_op_word(core,index,1)>>>32)&0xffffffff;}
fn jj_vta_temp_kind(plan:*i64,plan_slots:i64,temp:i64)->i64{if plan==0{return 0;}if temp<=0{return 0;}if temp>plan[2]{return 0;}if plan[7]!=jj_vta_seal(plan,plan_slots){return 0;}return plan[8+(temp-1)*4+1];}
fn jj_vta_temp_index(plan:*i64,plan_slots:i64,temp:i64)->i64{if plan==0{return 0-1;}if temp<=0{return 0-1;}if temp>plan[2]{return 0-1;}if plan[7]!=jj_vta_seal(plan,plan_slots){return 0-1;}return plan[8+(temp-1)*4+2];}
fn jj_cirx_view_op_word(core:*i64,index:i64,word:i64)->i64{if jj_cirx_available_valid(core)==0{return 0;}return jj_cirx_raw_op_word(core,index,word);}
