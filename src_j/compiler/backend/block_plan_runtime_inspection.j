// on-demand inspection companion; excluded from resident selfhost closures.
extern fn jj_coldtail_map_old(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;

fn jj_coldtail_map_source(code:*i8,old_size:i64,old_offset:i64)->i64{return jj_coldtail_map_old(code,old_size,old_offset,0);}
