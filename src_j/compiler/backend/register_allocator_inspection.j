// on-demand inspection companion; excluded from resident selfhost closures.
extern fn jj_ra_validate(p0:*i64,p1:i64)->i64;

fn jj_ra_value_kind(plan:*i64,value:i64)->i64{if jj_ra_validate(plan,64)==0{return 0;}if value<=0{return 0;}if value>plan[1]{return 0;}return plan[8+(value-1)*4+1];}
fn jj_ra_value_index(plan:*i64,value:i64)->i64{if jj_ra_validate(plan,64)==0{return 0-1;}if value<=0{return 0-1;}if value>plan[1]{return 0-1;}return plan[8+(value-1)*4+2];}
fn jj_ra_spill_count(plan:*i64)->i64{if jj_ra_validate(plan,64)==0{return 0-1;}return plan[3];}
fn jj_ra_frame_bytes(plan:*i64)->i64{if jj_ra_validate(plan,64)==0{return 0-1;}return plan[4];}
