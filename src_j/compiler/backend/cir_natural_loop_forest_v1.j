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
extern fn jj_nlf1_verify_disjoint(s:*i64,vs:*i64,vr:*i64,d:*i64)->i64;
extern fn jj_nlf1_verify(s:*i64,vs:*i64,vr:*i64,d:*i64)->i64;
fn jj_nlf1_state_valid(s:*i64)->i64{if s==0{return 0;}if s[0]!=0x4a4a4e4c46535431{return 0;}if s[1]!=1{return 0;}if s[2]==0{return 0;}if s[4]==0{return 0;}if s[9]==0{return 0;}if s[11]==0{return 0;}if s[13]==0{return 0;}if s[15]==0{return 0;}if s[21]!=(s as i64){return 0;}if s[19]!=16{return 0;}if s[20]!=24{return 0;}if s[23]!=0{return 0;}if jj_cir_graph_v2_valid(s[2] as *i64,s[3])==0{return 0;}var g:*i64=s[2] as *i64;if g[2]!=s[4]{return 0;}if g[3]!=s[5]{return 0;}if g[12]!=s[6]{return 0;}if g[4]!=s[7]{return 0;}if jj_nlf1_loop_count_raw(g)!=s[8]{return 0;}if s[8]<=0{return 0;}if s[17]!=s[7]+1{return 0;}if s[18]!=jj_nlf1_matrix_need(s[8],s[7]){return 0;}if s[10]<s[8]*16{return 0;}if s[12]<s[18]{return 0;}if s[14]<s[18]{return 0;}if s[16]<s[17]{return 0;}var r:*i64=s[9] as *i64;var mem:*i64=s[11] as *i64;var lat:*i64=s[13] as *i64;var id:i64=1;while id<=s[8]{var rr:*i64=jj_nlf1_at(r,(id-1)*16);if rr[0]!=0x4a4a4e4c46524331{return 0;}if rr[1]!=id{return 0;}if rr[2]<=0{return 0;}if rr[2]>s[7]{return 0;}if jj_nlf1_loop_id_for_header(g,rr[2])!=id{return 0;}if rr[4]<=0{return 0;}if rr[5]<=0{return 0;}if rr[6]<=0{return 0;}if rr[12]!=1{return 0;}if rr[13]!=(rr as i64){return 0;}if rr[14]!=0{return 0;}if rr[15]!=jj_nlf1_record_seal(rr){return 0;}var mr:*i64=jj_nlf1_row(mem,s[17],id);var lr:*i64=jj_nlf1_row(lat,s[17],id);if mr[rr[2]]==0{return 0;}var b:i64=1;var mc:i64=0;var lc:i64=0;while b<=s[7]{if mr[b]!=0{mc=mc+1;if jj_nlf1_dominates(g,rr[2],b)==0{return 0;}}if lr[b]!=0{lc=lc+1;if mr[b]==0{return 0;}if jj_nlf1_edge_to(g,b,rr[2])==0{return 0;}}b=b+1;}if mc!=rr[5]{return 0;}if lc!=rr[6]{return 0;}id=id+1;}if s[22]!=jj_nlf1_state_seal(s){return 0;}return 1;}
fn jj_nlf1_loop_count(s:*i64)->i64{if jj_nlf1_state_valid(s)==0{return 0;}return s[8];}
fn jj_nlf1_header(s:*i64,id:i64)->i64{if jj_nlf1_state_valid(s)==0{return 0;}if id<=0{return 0;}if id>s[8]{return 0;}var r:*i64=s[9] as *i64;return r[(id-1)*16+2];}
fn jj_nlf1_parent(s:*i64,id:i64)->i64{if jj_nlf1_state_valid(s)==0{return 0;}if id<=0{return 0;}if id>s[8]{return 0;}var r:*i64=s[9] as *i64;return r[(id-1)*16+3];}
fn jj_nlf1_depth_value(s:*i64,id:i64)->i64{if jj_nlf1_state_valid(s)==0{return 0;}if id<=0{return 0;}if id>s[8]{return 0;}var r:*i64=s[9] as *i64;return r[(id-1)*16+4];}
fn jj_nlf1_member(s:*i64,id:i64,b:i64)->i64{if jj_nlf1_state_valid(s)==0{return 0;}if id<=0{return 0;}if id>s[8]{return 0;}if b<=0{return 0;}if b>s[7]{return 0;}var m:*i64=s[11] as *i64;return m[(id-1)*s[17]+b];}
fn jj_nlf1_latch(s:*i64,id:i64,b:i64)->i64{if jj_nlf1_state_valid(s)==0{return 0;}if id<=0{return 0;}if id>s[8]{return 0;}if b<=0{return 0;}if b>s[7]{return 0;}var m:*i64=s[13] as *i64;return m[(id-1)*s[17]+b];}
fn jj_nlf1_owner(s:*i64,b:i64)->i64{if jj_nlf1_state_valid(s)==0{return 0;}if b<=0{return 0;}if b>s[7]{return 0;}var o:*i64=s[15] as *i64;return o[b];}
fn jj_nlf1_record_field(s:*i64,id:i64,f:i64)->i64{if jj_nlf1_state_valid(s)==0{return 0-1;}if id<=0{return 0-1;}if id>s[8]{return 0-1;}if f<2{return 0-1;}if f>12{return 0-1;}var r:*i64=s[9] as *i64;return r[(id-1)*16+f];}
fn jj_nlf1_exit_target_at(s:*i64,id:i64,index:i64)->i64{if jj_nlf1_state_valid(s)==0{return 0;}if id<=0{return 0;}if id>s[8]{return 0;}if index<0{return 0;}var g:*i64=s[2] as *i64;var m:*i64=s[11] as *i64;var row:*i64=jj_nlf1_row(m,s[17],id);var seen:i64=0;var b:i64=1;while b<=s[7]{if row[b]!=0{var i:i64=0;while i<2{var t:i64=jj_nlf1_succ(g,b,i);if t>0{if row[t]==0{var earlier:i64=0;var x:i64=1;while x<b{if row[x]!=0{if jj_nlf1_edge_to(g,x,t)!=0{earlier=1;}}x=x+1;}if earlier==0{if seen==index{return t;}seen=seen+1;}}}i=i+1;}}b=b+1;}return 0;}
fn jj_nlf1_exit_dedicated(s:*i64,id:i64,target:i64)->i64{if jj_nlf1_state_valid(s)==0{return 0;}if target<=0{return 0;}if target>s[7]{return 0;}var g:*i64=s[2] as *i64;var m:*i64=s[11] as *i64;var row:*i64=jj_nlf1_row(m,s[17],id);if row[target]!=0{return 0;}var n:i64=jj_nlf1_pred_count(g,target);if n<=0{return 0;}var i:i64=0;while i<n{if row[jj_nlf1_pred_at(g,target,i)]==0{return 0;}i=i+1;}return 1;}
fn jj_nlf1_semantic_equal(a:*i64,b:*i64)->i64{if jj_nlf1_state_valid(a)==0{return 0;}if jj_nlf1_state_valid(b)==0{return 0;}var i:i64=0;while i<24{if i!=9{if i!=11{if i!=13{if i!=15{if i!=21{if i!=22{if a[i]!=b[i]{return 0;}}}}}}}i=i+1;}var ar:*i64=a[9] as *i64;var br:*i64=b[9] as *i64;i=0;while i<a[8]*16{if i%16!=13{if i%16!=15{if ar[i]!=br[i]{return 0;}}}i=i+1;}var am:*i64=a[11] as *i64;var bm:*i64=b[11] as *i64;var al:*i64=a[13] as *i64;var bl:*i64=b[13] as *i64;i=0;while i<a[18]{if am[i]!=bm[i]{return 0;}if al[i]!=bl[i]{return 0;}i=i+1;}var ao:*i64=a[15] as *i64;var bo:*i64=b[15] as *i64;i=0;while i<a[17]{if ao[i]!=bo[i]{return 0;}i=i+1;}return 1;}
fn jj_nlf1_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<24{return 0;}jj_nlf1_zero(out,24);out[0]=1;out[1]=24;out[2]=16;out[3]=16;out[4]=6;out[5]=1;out[6]=1;out[7]=1;out[8]=1;out[9]=1;out[10]=1;out[11]=1;out[12]=1;out[13]=1;out[14]=0;out[15]=0;out[16]=0;out[17]=0;out[18]=0;out[19]=0;out[20]=0;out[21]=0;out[22]=0;out[23]=1;return 1;}
