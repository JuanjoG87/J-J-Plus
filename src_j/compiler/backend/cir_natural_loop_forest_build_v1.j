// R748 split natural-loop forest authority; split for i386 pressure.
// R748 natural-loop forest v1. Natural loops are derived from dominance
// backedges rather than SCC identity, so nested loops remain distinct.
// All matrices and stacks are caller-owned. i386 is a cost oracle only.
extern fn jj_cir_graph_v2_valid(p0:*i64,p1:i64)->i64;
extern fn jj_cir_graph_v2_verify(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_nlf1_zero(p:*i64,n:i64)->i64;
extern fn jj_nlf1_at(p:*i64,o:i64)->*i64;
extern fn jj_nlf1_disjoint(a:*i64,an:i64,b:*i64,bn:i64)->i64;
extern fn jj_nlf1_grec(b:i64)->i64;
extern fn jj_nlf1_succ(g:*i64,b:i64,i:i64)->i64;
extern fn jj_nlf1_pred_count(g:*i64,b:i64)->i64;
extern fn jj_nlf1_pred_at(g:*i64,b:i64,i:i64)->i64;
extern fn jj_nlf1_dominates(g:*i64,a:i64,b:i64)->i64;
extern fn jj_nlf1_edge_to(g:*i64,from:i64,to:i64)->i64;
extern fn jj_nlf1_header_has_backedge(g:*i64,h:i64)->i64;
extern fn jj_nlf1_loop_count_raw(g:*i64)->i64;
extern fn jj_nlf1_matrix_need(loops:i64,blocks:i64)->i64;
extern fn jj_nlf1_record_seal(r:*i64)->i64;
extern fn jj_nlf1_state_seal(s:*i64)->i64;
extern fn jj_nlf1_desc_seal(d:*i64)->i64;
extern fn jj_nlf1_desc_valid(d:*i64)->i64;
extern fn jj_nlf1_pairwise(d:*i64,s:*i64,sn:i64,r:*i64,rn:i64,g:*i64)->i64;
extern fn jj_nlf1_loop_id_for_header(g:*i64,h:i64)->i64;
extern fn jj_nlf1_state_valid(s:*i64)->i64;
extern fn jj_nlf1_loop_count(s:*i64)->i64;
extern fn jj_nlf1_header(s:*i64,id:i64)->i64;
extern fn jj_nlf1_parent(s:*i64,id:i64)->i64;
extern fn jj_nlf1_depth_value(s:*i64,id:i64)->i64;
extern fn jj_nlf1_member(s:*i64,id:i64,b:i64)->i64;
extern fn jj_nlf1_latch(s:*i64,id:i64,b:i64)->i64;
extern fn jj_nlf1_owner(s:*i64,b:i64)->i64;
extern fn jj_nlf1_record_field(s:*i64,id:i64,f:i64)->i64;
extern fn jj_nlf1_exit_target_at(s:*i64,id:i64,index:i64)->i64;
extern fn jj_nlf1_exit_dedicated(s:*i64,id:i64,target:i64)->i64;
extern fn jj_nlf1_semantic_equal(a:*i64,b:*i64)->i64;
extern fn jj_nlf1_resource_contract(out:*i64,n:i64)->i64;
extern fn jj_nlf1_verify_disjoint(s:*i64,vs:*i64,vr:*i64,d:*i64)->i64;
extern fn jj_nlf1_verify(s:*i64,vs:*i64,vr:*i64,d:*i64)->i64;
fn jj_nlf1_row(base:*i64,stride:i64,id:i64)->*i64{return jj_nlf1_at(base,(id-1)*stride);}
fn jj_nlf1_seed_latches(g:*i64,h:i64,mem:*i64,lat:*i64,work:*i64)->i64{var sp:i64=0;mem[h]=1;var b:i64=1;while b<=g[4]{if jj_nlf1_edge_to(g,b,h)!=0{if jj_nlf1_dominates(g,h,b)!=0{lat[b]=1;if mem[b]==0{mem[b]=1;work[sp]=b;sp=sp+1;}}}b=b+1;}return sp;}
fn jj_nlf1_close_members(g:*i64,h:i64,mem:*i64,work:*i64,sp0:i64)->i64{var sp:i64=sp0;while sp>0{sp=sp-1;var x:i64=work[sp];var n:i64=jj_nlf1_pred_count(g,x);var i:i64=0;while i<n{var p:i64=jj_nlf1_pred_at(g,x,i);if p!=h{if mem[p]==0{if jj_nlf1_dominates(g,h,p)==0{return 0;}mem[p]=1;work[sp]=p;sp=sp+1;}}i=i+1;}}return 1;}
fn jj_nlf1_succ_count(g:*i64,b:i64)->i64{var n:i64=0;if jj_nlf1_succ(g,b,0)>0{n=n+1;}if jj_nlf1_succ(g,b,1)>0{n=n+1;}return n;}
fn jj_nlf1_analyze(g:*i64,h:i64,mem:*i64,lat:*i64,r:*i64)->i64{var b:i64=1;var members:i64=0;var latches:i64=0;var entries:i64=0;var exits:i64=0;var pre:i64=0;while b<=g[4]{if mem[b]!=0{members=members+1;if lat[b]!=0{latches=latches+1;}var i:i64=0;while i<2{var t:i64=jj_nlf1_succ(g,b,i);if t>0{if mem[t]==0{exits=exits+1;}}i=i+1;}}else{var j:i64=0;while j<2{if jj_nlf1_succ(g,b,j)==h{entries=entries+1;if pre==0{pre=b;}else{pre=0-1;}}j=j+1;}}b=b+1;}if members<=0{return 0;}if latches<=0{return 0;}var dedicated:i64=0;if entries==1{if pre>0{if jj_nlf1_succ_count(g,pre)==1{dedicated=pre;}}}r[5]=members;r[6]=latches;r[7]=entries;r[8]=exits;r[9]=dedicated;r[10]=0;r[11]=0;r[12]=0;r[13]=0;r[14]=0;return 1;}
fn jj_nlf1_build_one(g:*i64,h:i64,r:*i64,mem:*i64,lat:*i64,work:*i64)->i64{jj_nlf1_zero(mem,g[4]+1);jj_nlf1_zero(lat,g[4]+1);var sp:i64=jj_nlf1_seed_latches(g,h,mem,lat,work);if sp<=0{return 0;}if jj_nlf1_close_members(g,h,mem,work,sp)==0{return 0;}r[0]=0x4a4a4e4c46524331;r[2]=h;r[3]=0;r[4]=1;if jj_nlf1_analyze(g,h,mem,lat,r)==0{return 0;}r[12]=1;r[13]=r as i64;r[15]=jj_nlf1_record_seal(r);if r[15]==0{return 0;}return 1;}
fn jj_nlf1_subset(a:*i64,b:*i64,blocks:i64)->i64{var x:i64=1;while x<=blocks{if a[x]!=0{if b[x]==0{return 0;}}x=x+1;}return 1;}
fn jj_nlf1_equal_members(a:*i64,b:*i64,blocks:i64)->i64{var x:i64=1;while x<=blocks{if a[x]!=b[x]{return 0;}x=x+1;}return 1;}
fn jj_nlf1_parent_for(mem:*i64,stride:i64,id:i64,loops:i64,blocks:i64,records:*i64)->i64{var row:*i64=jj_nlf1_row(mem,stride,id);var best:i64=0;var bestn:i64=0x7fffffffffffffff;var j:i64=1;while j<=loops{if j!=id{var other:*i64=jj_nlf1_row(mem,stride,j);if jj_nlf1_subset(row,other,blocks)!=0{if jj_nlf1_equal_members(row,other,blocks)==0{var n:i64=records[(j-1)*16+5];if n<bestn{best=j;bestn=n;}}}}j=j+1;}return best;}
fn jj_nlf1_depth(records:*i64,id:i64,loops:i64)->i64{var d:i64=1;var p:i64=records[(id-1)*16+3];var n:i64=0;while p>0{if p>loops{return 0;}d=d+1;p=records[(p-1)*16+3];n=n+1;if n>loops{return 0;}}return d;}
fn jj_nlf1_exit_distinct(g:*i64,mem:*i64,work:*i64)->i64{jj_nlf1_zero(work,g[4]+1);var b:i64=1;var c:i64=0;while b<=g[4]{if mem[b]!=0{var i:i64=0;while i<2{var t:i64=jj_nlf1_succ(g,b,i);if t>0{if mem[t]==0{if work[t]==0{work[t]=1;c=c+1;}}}i=i+1;}}b=b+1;}return c;}
fn jj_nlf1_exit_dedicated_count(g:*i64,mem:*i64,work:*i64)->i64{jj_nlf1_zero(work,g[4]+1);var b:i64=1;while b<=g[4]{if mem[b]!=0{var i:i64=0;while i<2{var t:i64=jj_nlf1_succ(g,b,i);if t>0{if mem[t]==0{work[t]=1;}}i=i+1;}}b=b+1;}var t2:i64=1;var c:i64=0;while t2<=g[4]{if work[t2]!=0{var ok:i64=1;var n:i64=jj_nlf1_pred_count(g,t2);var j:i64=0;while j<n{if mem[jj_nlf1_pred_at(g,t2,j)]==0{ok=0;}j=j+1;}if ok!=0{c=c+1;}}t2=t2+1;}return c;}
fn jj_nlf1_finish_relations(s:*i64,r:*i64,mem:*i64,owner:*i64,work:*i64)->i64{var loops:i64=s[8];var blocks:i64=s[7];var stride:i64=blocks+1;var id:i64=1;while id<=loops{var p:i64=jj_nlf1_parent_for(mem,stride,id,loops,blocks,r);r[(id-1)*16+3]=p;id=id+1;}id=1;while id<=loops{var d:i64=jj_nlf1_depth(r,id,loops);if d<=0{return 0;}r[(id-1)*16+4]=d;var row:*i64=jj_nlf1_row(mem,stride,id);r[(id-1)*16+10]=jj_nlf1_exit_distinct(s[2] as *i64,row,work);r[(id-1)*16+11]=jj_nlf1_exit_dedicated_count(s[2] as *i64,row,work);r[(id-1)*16+15]=0;r[(id-1)*16+15]=jj_nlf1_record_seal(jj_nlf1_at(r,(id-1)*16));id=id+1;}jj_nlf1_zero(owner,blocks+1);var b:i64=1;while b<=blocks{var best:i64=0;var depth:i64=0;id=1;while id<=loops{var row2:*i64=jj_nlf1_row(mem,stride,id);if row2[b]!=0{var d2:i64=r[(id-1)*16+4];if d2>depth{depth=d2;best=id;}}id=id+1;}owner[b]=best;b=b+1;}return 1;}
fn jj_nlf1_preflight(s:*i64,n:i64,r:*i64,rn:i64,g:*i64,d:*i64)->i64{if s==0{return 0;}if n!=24{return 0;}if r==0{return 0;}if g==0{return 0;}if jj_nlf1_desc_valid(d)==0{return 0;}if d[13]<=0{return 0;}if jj_cir_graph_v2_valid(g,d[13])==0{return 0;}var loops:i64=jj_nlf1_loop_count_raw(g);if loops<=0{return 0;}var need:i64=jj_nlf1_matrix_need(loops,g[4]);if need<=0{return 0;}if loops>0x0fffffffffffffff/16{return 0;}if rn<loops*16{return 0;}if d[1]<need{return 0;}if d[3]<need{return 0;}if d[5]<g[4]+1{return 0;}if d[7]<(g[4]+1)*2{return 0;}if d[9]<g[6]{return 0;}if d[11]<g[14]{return 0;}if jj_nlf1_pairwise(d,s,n,r,rn,g)==0{return 0;}var cir:*i64=g[2] as *i64;if jj_nlf1_disjoint(s,n,cir,g[3])==0{return 0;}if jj_nlf1_disjoint(r,rn,cir,g[3])==0{return 0;}var i:i64=0;while i<6{var p:*i64=d[i*2] as *i64;var z:i64=d[i*2+1];if jj_nlf1_disjoint(p,z,cir,g[3])==0{return 0;}i=i+1;}return loops;}
fn jj_nlf1_build(s:*i64,n:i64,r:*i64,rn:i64,g:*i64,d:*i64)->i64{var loops:i64=jj_nlf1_preflight(s,n,r,rn,g,d);if loops<=0{return 0;}var rg:*i64=d[8] as *i64;var rw:*i64=d[10] as *i64;if jj_cir_graph_v2_verify(g,d[13],rg,d[9],rw,d[11])==0{return 0;}jj_nlf1_zero(rg,g[6]);jj_nlf1_zero(rw,g[14]);var mem:*i64=d[0] as *i64;var lat:*i64=d[2] as *i64;var owner:*i64=d[4] as *i64;var work:*i64=d[6] as *i64;var need:i64=jj_nlf1_matrix_need(loops,g[4]);jj_nlf1_zero(s,24);jj_nlf1_zero(r,loops*16);jj_nlf1_zero(mem,need);jj_nlf1_zero(lat,need);jj_nlf1_zero(owner,g[4]+1);jj_nlf1_zero(work,(g[4]+1)*2);s[0]=0x4a4a4e4c46535431;s[1]=1;s[2]=g as i64;s[3]=d[13];s[4]=g[2];s[5]=g[3];s[6]=g[12];s[7]=g[4];s[8]=loops;s[9]=r as i64;s[10]=rn;s[11]=mem as i64;s[12]=d[1];s[13]=lat as i64;s[14]=d[3];s[15]=owner as i64;s[16]=d[5];s[17]=g[4]+1;s[18]=need;s[19]=16;s[20]=24;s[21]=s as i64;s[23]=0;var stride:i64=g[4]+1;var h:i64=1;var id:i64=0;while h<=g[4]{if jj_nlf1_header_has_backedge(g,h)!=0{id=id+1;var rr:*i64=jj_nlf1_at(r,(id-1)*16);var mr:*i64=jj_nlf1_row(mem,stride,id);var lr:*i64=jj_nlf1_row(lat,stride,id);rr[1]=id;if jj_nlf1_build_one(g,h,rr,mr,lr,work)==0{jj_nlf1_zero(s,24);jj_nlf1_zero(r,loops*16);jj_nlf1_zero(mem,need);jj_nlf1_zero(lat,need);jj_nlf1_zero(owner,g[4]+1);return 0;}}h=h+1;}if id!=loops{return 0;}if jj_nlf1_finish_relations(s,r,mem,owner,work)==0{return 0;}s[22]=jj_nlf1_state_seal(s);if s[22]==0{return 0;}return 1;}
