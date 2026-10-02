// on-demand inspection companion; excluded from resident selfhost closures.

fn jj_bp_block_count(plan:*i64)->i64{if plan==0{return 0;}if plan[1]!=1{return 0;}return plan[2];}
fn jj_bp_loop_count(plan:*i64)->i64{if plan==0{return 0;}if plan[1]!=1{return 0;}return plan[4];}
