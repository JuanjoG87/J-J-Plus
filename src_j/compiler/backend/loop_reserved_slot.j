// exact reachability and fail-closed publication in the pre-existing reserved object slot.
extern fn jj_lg_walk(p0:*i64,p1:i64,p2:i64,p3:*i64,p4:*i64)->i64;
extern fn jj_loop_graph_build_raw(p0:*i64,p1:*i64,p2:*i64)->i64;
fn jj_lg_reach_exact(ctx:*i64,derived:*i64,q:*i64)->i64{if jj_lg_walk(ctx,0,2,derived,q)==0{return 0;}var reach:*i64=ctx[6] as *i64;var i:i64=0;while i<ctx[1]{if derived[i]!=reach[i]{return 0;}i=i+1;}return 1;}
fn jj_lg_clear_public(r:*i64,d:*i64)->i64{var i:i64=0;if r!=0{while i<16{r[i]=0;i=i+1;}}if d!=0{var w:i64=0;while w<4{var lane:*i64=d[w] as *i64;if lane!=0{i=0;while i<256{lane[i]=0;i=i+1;}}w=w+1;}}return 0;}
fn jj_loop_graph_build(ctx:*i64,r:*i64,d:*i64)->i64{if r==0{return 0;}if d==0{jj_lg_clear_public(r,d);return 0;}if d[0]==0{jj_lg_clear_public(r,d);return 0;}if d[1]==0{jj_lg_clear_public(r,d);return 0;}if d[2]==0{jj_lg_clear_public(r,d);return 0;}if d[3]==0{jj_lg_clear_public(r,d);return 0;}var seal:i64=jj_loop_graph_build_raw(ctx,r,d);if seal==0{return jj_lg_clear_public(r,d);}return seal;}
