// sealed graph receipt; SCC workspace is local to this authority, not to target emitters.
extern fn jj_lg_prepare(p0:*i64,p1:*i64,p2:*i64)->i64;
extern fn jj_loop_dominator_build(p0:*i64,p1:*i64,p2:*i64)->i64;
extern fn jj_loop_scc_build(p0:*i64,p1:*i64,p2:*i64,p3:*i64)->i64;
extern fn jj_lg_backedges(p0:*i64,p1:*i64,p2:*i64)->i64;
extern fn jj_lg_dom_has(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_lg_dom_get(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_lg_reach_exact(p0:*i64,p1:*i64,p2:*i64)->i64;
fn jj_lg_edge_audit(ctx:*i64,r:*i64,d:*i64,from:i64,to:i64)->i64{if to<0{return 1;}if to>=ctx[1]{return 0;}var semantic:i64=0;if jj_lg_dom_has(d,from,to)!=0{semantic=1;}if to<=from{r[9]=r[9]+1;if semantic==0{r[10]=r[10]+1;}}return 1;}
fn jj_lg_backward_audit(ctx:*i64,r:*i64,d:*i64)->i64{var n:i64=ctx[1];var reach:*i64=ctx[6] as *i64;var a:*i64=ctx[7] as *i64;var b:*i64=ctx[8] as *i64;var i:i64=0;while i<n{if reach[i]!=0{if jj_lg_edge_audit(ctx,r,d,i,a[i])==0{return 0;}if jj_lg_edge_audit(ctx,r,d,i,b[i])==0{return 0;}}i=i+1;}return 1;}
fn jj_lg_fingerprint(ctx:*i64,r:*i64,d:*i64,scc:*i64)->i64{var n:i64=ctx[1];var reach:*i64=ctx[6] as *i64;var a:*i64=ctx[7] as *i64;var b:*i64=ctx[8] as *i64;var h:i64=0x4a4a4c4752465032;var i:i64=0;while i<n{h=((h<<7)|(h>>>57))^i^(reach[i]<<8)^(a[i]<<16)^(b[i]<<24)^(scc[i]<<32)^jj_lg_dom_get(d,i,0)^jj_lg_dom_get(d,i,1)^jj_lg_dom_get(d,i,2)^jj_lg_dom_get(d,i,3);i=i+1;}if h==0{h=1;}r[13]=h;return h;}
fn jj_loop_graph_build_raw(ctx:*i64,r:*i64,d:*i64)->i64{if jj_lg_prepare(ctx,r,d)==0{return 0;}var scc:[256]i64;var fw:[256]i64;var rv:[256]i64;var q:[256]i64;var info:[4]i64;var ws:[5]i64;if jj_lg_reach_exact(ctx,fw as *i64,q as *i64)==0{return 0;}if jj_loop_dominator_build(ctx,r,d)==0{return 0;}ws[0]=(scc as *i64) as i64;ws[1]=(fw as *i64) as i64;ws[2]=(rv as *i64) as i64;ws[3]=(q as *i64) as i64;ws[4]=(info as *i64) as i64;if jj_loop_scc_build(ctx,r,d,ws as *i64)==0{return 0;}if jj_lg_backedges(ctx,r,d)==0{return 0;}if jj_lg_backward_audit(ctx,r,d)==0{return 0;}var h:i64=jj_lg_fingerprint(ctx,r,d,scc as *i64);r[0]=0x4a4a4c4752503033;r[1]=3;r[15]=16;var seal:i64=h^r[2]^(r[3]<<8)^(r[4]<<16)^(r[5]<<24)^(r[6]<<32)^(r[7]<<40)^(r[8]<<48)^r[9]^r[10]^r[12]^0x4256653647524133;if seal==0{seal=1;}r[14]=seal;return seal;}
