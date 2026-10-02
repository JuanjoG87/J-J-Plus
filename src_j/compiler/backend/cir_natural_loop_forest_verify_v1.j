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
extern fn jj_nlf1_row(base:*i64,stride:i64,id:i64)->*i64;
extern fn jj_nlf1_seed_latches(g:*i64,h:i64,mem:*i64,lat:*i64,work:*i64)->i64;
extern fn jj_nlf1_close_members(g:*i64,h:i64,mem:*i64,work:*i64,sp0:i64)->i64;
extern fn jj_nlf1_succ_count(g:*i64,b:i64)->i64;
extern fn jj_nlf1_analyze(g:*i64,h:i64,mem:*i64,lat:*i64,r:*i64)->i64;
extern fn jj_nlf1_build_one(g:*i64,h:i64,r:*i64,mem:*i64,lat:*i64,work:*i64)->i64;
extern fn jj_nlf1_subset(a:*i64,b:*i64,blocks:i64)->i64;
extern fn jj_nlf1_equal_members(a:*i64,b:*i64,blocks:i64)->i64;
extern fn jj_nlf1_parent_for(mem:*i64,stride:i64,id:i64,loops:i64,blocks:i64,records:*i64)->i64;
extern fn jj_nlf1_depth(records:*i64,id:i64,loops:i64)->i64;
extern fn jj_nlf1_exit_distinct(g:*i64,mem:*i64,work:*i64)->i64;
extern fn jj_nlf1_exit_dedicated_count(g:*i64,mem:*i64,work:*i64)->i64;
extern fn jj_nlf1_finish_relations(s:*i64,r:*i64,mem:*i64,owner:*i64,work:*i64)->i64;
extern fn jj_nlf1_preflight(s:*i64,n:i64,r:*i64,rn:i64,g:*i64,d:*i64)->i64;
extern fn jj_nlf1_build(s:*i64,n:i64,r:*i64,rn:i64,g:*i64,d:*i64)->i64;
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
fn jj_nlf1_verify_disjoint(s:*i64,vs:*i64,vr:*i64,d:*i64)->i64{var sr:*i64=s[9] as *i64;var sm:*i64=s[11] as *i64;var sl:*i64=s[13] as *i64;var so:*i64=s[15] as *i64;var g:*i64=s[2] as *i64;var c:*i64=s[4] as *i64;if jj_nlf1_disjoint(vs,24,s,24)==0{return 0;}if jj_nlf1_disjoint(vr,s[10],s,24)==0{return 0;}if jj_nlf1_disjoint(vs,24,sr,s[10])==0{return 0;}if jj_nlf1_disjoint(vr,s[10],sr,s[10])==0{return 0;}if jj_nlf1_disjoint(vs,24,sm,s[12])==0{return 0;}if jj_nlf1_disjoint(vr,s[10],sm,s[12])==0{return 0;}if jj_nlf1_disjoint(vs,24,sl,s[14])==0{return 0;}if jj_nlf1_disjoint(vr,s[10],sl,s[14])==0{return 0;}if jj_nlf1_disjoint(vs,24,so,s[16])==0{return 0;}if jj_nlf1_disjoint(vr,s[10],so,s[16])==0{return 0;}if jj_nlf1_disjoint(d,16,s,24)==0{return 0;}if jj_nlf1_disjoint(d,16,sr,s[10])==0{return 0;}if jj_nlf1_disjoint(d,16,sm,s[12])==0{return 0;}if jj_nlf1_disjoint(d,16,sl,s[14])==0{return 0;}if jj_nlf1_disjoint(d,16,so,s[16])==0{return 0;}var i:i64=0;while i<6{var p:*i64=d[i*2] as *i64;var n:i64=d[i*2+1];if jj_nlf1_disjoint(p,n,s,24)==0{return 0;}if jj_nlf1_disjoint(p,n,sr,s[10])==0{return 0;}if jj_nlf1_disjoint(p,n,sm,s[12])==0{return 0;}if jj_nlf1_disjoint(p,n,sl,s[14])==0{return 0;}if jj_nlf1_disjoint(p,n,so,s[16])==0{return 0;}i=i+1;}if jj_nlf1_disjoint(vs,24,g,s[3])==0{return 0;}if jj_nlf1_disjoint(vr,s[10],g,s[3])==0{return 0;}if jj_nlf1_disjoint(vs,24,c,s[5])==0{return 0;}if jj_nlf1_disjoint(vr,s[10],c,s[5])==0{return 0;}return 1;}
fn jj_nlf1_verify(s:*i64,vs:*i64,vr:*i64,d:*i64)->i64{if jj_nlf1_state_valid(s)==0{return 0;}if vs==0{return 0;}if vr==0{return 0;}if jj_nlf1_desc_valid(d)==0{return 0;}if d[13]!=s[3]{return 0;}if jj_nlf1_verify_disjoint(s,vs,vr,d)==0{return 0;}if jj_nlf1_build(vs,24,vr,s[10],s[2] as *i64,d)==0{return 0;}return jj_nlf1_semantic_equal(s,vs);}
