// reachable dominator fixed point using caller-provided lanes.
extern fn jj_lg_dom_get(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_lg_dom_set(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_lg_edge(p0:*i64,p1:*i64,p2:i64,p3:i64)->i64;
fn jj_lg_reach_word(ctx:*i64,w:i64)->i64{var n:i64=ctx[1];var reach:*i64=ctx[6] as *i64;var v:i64=0;var i:i64=w*64;var end:i64=i+64;if end>n{end=n;}while i<end{if reach[i]!=0{v=v|(1<<(i&63));}i=i+1;}return v;}
fn jj_lg_dom_init(ctx:*i64,d:*i64)->i64{var n:i64=ctx[1];var reach:*i64=ctx[6] as *i64;var w:i64=0;while w<4{var all:i64=jj_lg_reach_word(ctx,w);var i:i64=0;while i<n{var v:i64=0;if reach[i]!=0{if i==0{if w==0{v=1;}}else{v=all;}}jj_lg_dom_set(d,i,w,v);i=i+1;}w=w+1;}return 1;}
fn jj_lg_pred_count(ctx:*i64,node:i64)->i64{var n:i64=ctx[1];var reach:*i64=ctx[6] as *i64;var a:*i64=ctx[7] as *i64;var b:*i64=ctx[8] as *i64;var p:i64=0;var c:i64=0;while p<n{if reach[p]!=0{c=c+jj_lg_edge(a,b,p,node);}p=p+1;}return c;}
fn jj_lg_pred_word(ctx:*i64,d:*i64,node:i64,w:i64)->i64{var n:i64=ctx[1];var reach:*i64=ctx[6] as *i64;var a:*i64=ctx[7] as *i64;var b:*i64=ctx[8] as *i64;var v:i64=jj_lg_reach_word(ctx,w);var p:i64=0;while p<n{if reach[p]!=0{if jj_lg_edge(a,b,p,node)!=0{v=v&jj_lg_dom_get(d,p,w);}}p=p+1;}return v;}
fn jj_lg_dom_node(ctx:*i64,d:*i64,node:i64)->i64{if jj_lg_pred_count(ctx,node)==0{return 0-1;}var changed:i64=0;var w:i64=0;while w<4{var v:i64=jj_lg_pred_word(ctx,d,node,w);if w==(node>>>6){v=v|(1<<(node&63));}if jj_lg_dom_get(d,node,w)!=v{jj_lg_dom_set(d,node,w,v);changed=1;}w=w+1;}return changed;}
fn jj_lg_dom_pass(ctx:*i64,d:*i64)->i64{var n:i64=ctx[1];var reach:*i64=ctx[6] as *i64;var i:i64=1;var changed:i64=0;while i<n{if reach[i]!=0{var c:i64=jj_lg_dom_node(ctx,d,i);if c<0{return 0-1;}changed=changed|c;}i=i+1;}return changed;}
fn jj_loop_dominator_build(ctx:*i64,r:*i64,d:*i64)->i64{jj_lg_dom_init(ctx,d);var k:i64=0;var changed:i64=1;while changed!=0{if k>=512{return 0;}changed=jj_lg_dom_pass(ctx,d);if changed<0{return 0;}k=k+1;}r[12]=k;return 1;}
