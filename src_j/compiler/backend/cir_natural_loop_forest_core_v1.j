// R748 split natural-loop forest authority; split for i386 pressure.
// R748 natural-loop forest v1. Natural loops are derived from dominance
// backedges rather than SCC identity, so nested loops remain distinct.
// All matrices and stacks are caller-owned. i386 is a cost oracle only.
extern fn jj_cir_graph_v2_valid(p0:*i64,p1:i64)->i64;
extern fn jj_cir_graph_v2_verify(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
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
extern fn jj_nlf1_verify_disjoint(s:*i64,vs:*i64,vr:*i64,d:*i64)->i64;
extern fn jj_nlf1_verify(s:*i64,vs:*i64,vr:*i64,d:*i64)->i64;
fn jj_nlf1_zero(p:*i64,n:i64)->i64{if p==0{return 0;}if n<0{return 0;}var i:i64=0;while i<n{p[i]=0;i=i+1;}return 1;}
fn jj_nlf1_at(p:*i64,o:i64)->*i64{return ((p as i64)+o*8) as *i64;}
fn jj_nlf1_disjoint(a:*i64,an:i64,b:*i64,bn:i64)->i64{if a==0{return 0;}if b==0{return 0;}if an<=0{return 0;}if bn<=0{return 0;}if an>0x0fffffffffffffff{return 0;}if bn>0x0fffffffffffffff{return 0;}var av:i64=a as i64;var bv:i64=b as i64;if av<0{return 0;}if bv<0{return 0;}var az:i64=an*8;var bz:i64=bn*8;if av>0x7fffffffffffffff-az{return 0;}if bv>0x7fffffffffffffff-bz{return 0;}var ae:i64=av+az;var be:i64=bv+bz;if ae<=bv{return 1;}if be<=av{return 1;}return 0;}
fn jj_nlf1_grec(b:i64)->i64{return 16+(b-1)*8;}
fn jj_nlf1_succ(g:*i64,b:i64,i:i64)->i64{return g[jj_nlf1_grec(b)+i];}
fn jj_nlf1_pred_count(g:*i64,b:i64)->i64{return g[jj_nlf1_grec(b)+3];}
fn jj_nlf1_pred_at(g:*i64,b:i64,i:i64)->i64{var r:i64=jj_nlf1_grec(b);return g[16+g[4]*8+g[r+2]+i];}
fn jj_nlf1_dominates(g:*i64,a:i64,b:i64)->i64{if a<=0{return 0;}if b<=0{return 0;}if a>g[4]{return 0;}if b>g[4]{return 0;}if a==b{return 1;}var x:i64=b;var n:i64=0;while n<g[4]{x=g[jj_nlf1_grec(x)+5];if x==a{return 1;}if x<=0{return 0;}if x==1{return 0;}n=n+1;}return 0;}
fn jj_nlf1_edge_to(g:*i64,from:i64,to:i64)->i64{if jj_nlf1_succ(g,from,0)==to{return 1;}if jj_nlf1_succ(g,from,1)==to{return 1;}return 0;}
fn jj_nlf1_header_has_backedge(g:*i64,h:i64)->i64{var b:i64=1;while b<=g[4]{if jj_nlf1_edge_to(g,b,h)!=0{if jj_nlf1_dominates(g,h,b)!=0{return 1;}}b=b+1;}return 0;}
fn jj_nlf1_loop_count_raw(g:*i64)->i64{var h:i64=1;var n:i64=0;while h<=g[4]{if jj_nlf1_header_has_backedge(g,h)!=0{n=n+1;}h=h+1;}return n;}
fn jj_nlf1_matrix_need(loops:i64,blocks:i64)->i64{if loops<=0{return 0;}if blocks<=0{return 0;}if blocks>=0x7fffffffffffffff{return 0;}var stride:i64=blocks+1;if loops>0x0fffffffffffffff/stride{return 0;}return loops*stride;}
fn jj_nlf1_record_seal(r:*i64)->i64{if r==0{return 0;}var h:i64=(r as i64)^0x4a4a4e4c46524331;var i:i64=0;while i<16{var v:i64=r[i];if i==15{v=0;}h=((h<<7)|(h>>>57))^v^((i+7)*0x9e37);i=i+1;}if h==0{h=1;}return h;}
fn jj_nlf1_state_seal(s:*i64)->i64{if s==0{return 0;}var h:i64=(s as i64)^0x4a4a4e4c46535431;var i:i64=0;while i<24{var v:i64=s[i];if i==22{v=0;}h=((h<<9)|(h>>>55))^v^((i+11)*0x45d9f3b);i=i+1;}if h==0{h=1;}return h;}
fn jj_nlf1_desc_seal(d:*i64)->i64{if d==0{return 0;}var h:i64=(d as i64)^0x4a4a4e4c46445331;var i:i64=0;while i<16{var v:i64=d[i];if i==15{v=0;}h=((h<<5)|(h>>>59))^v^((i+3)*0x27d4eb2d);i=i+1;}if h==0{h=1;}return h;}
fn jj_nlf1_desc_valid(d:*i64)->i64{if d==0{return 0;}if d[12]!=(d as i64){return 0;}if d[14]!=0{return 0;}if d[0]==0{return 0;}if d[2]==0{return 0;}if d[4]==0{return 0;}if d[6]==0{return 0;}if d[8]==0{return 0;}if d[10]==0{return 0;}if d[1]<=0{return 0;}if d[3]<=0{return 0;}if d[5]<=0{return 0;}if d[7]<=0{return 0;}if d[9]<=0{return 0;}if d[11]<=0{return 0;}if d[13]<=0{return 0;}if d[15]!=jj_nlf1_desc_seal(d){return 0;}return 1;}
fn jj_nlf1_pairwise(d:*i64,s:*i64,sn:i64,r:*i64,rn:i64,g:*i64)->i64{var gs:i64=d[13];var p0:*i64=d[0] as *i64;var p1:*i64=d[2] as *i64;var p2:*i64=d[4] as *i64;var p3:*i64=d[6] as *i64;var p4:*i64=d[8] as *i64;var p5:*i64=d[10] as *i64;var n0:i64=d[1];var n1:i64=d[3];var n2:i64=d[5];var n3:i64=d[7];var n4:i64=d[9];var n5:i64=d[11];if jj_nlf1_disjoint(s,sn,r,rn)==0{return 0;}if jj_nlf1_disjoint(s,sn,g,gs)==0{return 0;}if jj_nlf1_disjoint(r,rn,g,gs)==0{return 0;}if jj_nlf1_disjoint(d,16,s,sn)==0{return 0;}if jj_nlf1_disjoint(d,16,r,rn)==0{return 0;}if jj_nlf1_disjoint(d,16,g,gs)==0{return 0;}if jj_nlf1_disjoint(p0,n0,p1,n1)==0{return 0;}if jj_nlf1_disjoint(p0,n0,p2,n2)==0{return 0;}if jj_nlf1_disjoint(p0,n0,p3,n3)==0{return 0;}if jj_nlf1_disjoint(p0,n0,p4,n4)==0{return 0;}if jj_nlf1_disjoint(p0,n0,p5,n5)==0{return 0;}if jj_nlf1_disjoint(p1,n1,p2,n2)==0{return 0;}if jj_nlf1_disjoint(p1,n1,p3,n3)==0{return 0;}if jj_nlf1_disjoint(p1,n1,p4,n4)==0{return 0;}if jj_nlf1_disjoint(p1,n1,p5,n5)==0{return 0;}if jj_nlf1_disjoint(p2,n2,p3,n3)==0{return 0;}if jj_nlf1_disjoint(p2,n2,p4,n4)==0{return 0;}if jj_nlf1_disjoint(p2,n2,p5,n5)==0{return 0;}if jj_nlf1_disjoint(p3,n3,p4,n4)==0{return 0;}if jj_nlf1_disjoint(p3,n3,p5,n5)==0{return 0;}if jj_nlf1_disjoint(p4,n4,p5,n5)==0{return 0;}if jj_nlf1_disjoint(p0,n0,s,sn)==0{return 0;}if jj_nlf1_disjoint(p1,n1,s,sn)==0{return 0;}if jj_nlf1_disjoint(p2,n2,s,sn)==0{return 0;}if jj_nlf1_disjoint(p3,n3,s,sn)==0{return 0;}if jj_nlf1_disjoint(p4,n4,s,sn)==0{return 0;}if jj_nlf1_disjoint(p5,n5,s,sn)==0{return 0;}if jj_nlf1_disjoint(p0,n0,r,rn)==0{return 0;}if jj_nlf1_disjoint(p1,n1,r,rn)==0{return 0;}if jj_nlf1_disjoint(p2,n2,r,rn)==0{return 0;}if jj_nlf1_disjoint(p3,n3,r,rn)==0{return 0;}if jj_nlf1_disjoint(p4,n4,r,rn)==0{return 0;}if jj_nlf1_disjoint(p5,n5,r,rn)==0{return 0;}if jj_nlf1_disjoint(p0,n0,g,gs)==0{return 0;}if jj_nlf1_disjoint(p1,n1,g,gs)==0{return 0;}if jj_nlf1_disjoint(p2,n2,g,gs)==0{return 0;}if jj_nlf1_disjoint(p3,n3,g,gs)==0{return 0;}if jj_nlf1_disjoint(p4,n4,g,gs)==0{return 0;}if jj_nlf1_disjoint(p5,n5,g,gs)==0{return 0;}return 1;}
fn jj_nlf1_loop_id_for_header(g:*i64,h:i64)->i64{var x:i64=1;var id:i64=0;while x<=h{if jj_nlf1_header_has_backedge(g,x)!=0{id=id+1;}x=x+1;}return id;}
