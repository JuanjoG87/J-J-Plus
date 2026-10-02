// R732 fail-closed consumers for node-bound sealed CIR memory facts.
extern fn jj_mssa_valid(p0:*i64)->i64;
extern fn jj_mssa_access_kind(p0:*i64,p1:i64)->i64;
extern fn jj_mssa_access_block(p0:*i64,p1:i64)->i64;
extern fn jj_mssa_access_raw_prev(p0:*i64,p1:i64)->i64;
extern fn jj_mssa_access_optimized_def(p0:*i64,p1:i64)->i64;
extern fn jj_mssa_access_cir_node(p0:*i64,p1:i64)->i64;
extern fn jj_mssa_access_location(p0:*i64,p1:i64)->*i64;
extern fn jj_alias_location_query(p0:*i64,p1:*i64)->i64;
extern fn jj_alias_location_speculatable(p0:*i64)->i64;
fn jj_mssa_forward_admit(state:*i64,use_id:i64)->i64{
 if jj_mssa_valid(state)==0{return 0;}if jj_mssa_access_kind(state,use_id)!=2{return 0;}if jj_mssa_access_cir_node(state,use_id)<=0{return 0;}var defining:i64=jj_mssa_access_optimized_def(state,use_id);if defining<=0{return 0;}if jj_mssa_access_kind(state,defining)!=3{return 0;}if jj_mssa_access_cir_node(state,defining)<=0{return 0;}if jj_mssa_access_block(state,defining)!=jj_mssa_access_block(state,use_id){return 0;}
 var use_loc:*i64=jj_mssa_access_location(state,use_id);var def_loc:*i64=jj_mssa_access_location(state,defining);if use_loc==0{return 0;}if def_loc==0{return 0;}if use_loc[5]<=0{return 0;}if def_loc[5]<=0{return 0;}if (use_loc[6]&1)!=0{return 0;}if (def_loc[6]&1)!=0{return 0;}if jj_alias_location_query(use_loc,def_loc)!=4{return 0;}
 var current:i64=jj_mssa_access_raw_prev(state,use_id);var steps:i64=0;while current>0{if current==defining{return 1;}if jj_mssa_access_kind(state,current)==3{if jj_mssa_access_cir_node(state,current)<=0{return 0;}var clobber:*i64=jj_mssa_access_location(state,current);if clobber==0{return 0;}if jj_alias_location_query(use_loc,clobber)!=1{return 0;}}current=jj_mssa_access_raw_prev(state,current);steps=steps+1;if steps>state[7]{return 0;}}return 0;
}
fn jj_mssa_licm_admit(state:*i64,use_id:i64,first_block:i64,last_block:i64)->i64{
 if jj_mssa_valid(state)==0{return 0;}if jj_mssa_access_kind(state,use_id)!=2{return 0;}if jj_mssa_access_cir_node(state,use_id)<=0{return 0;}if first_block<=0{return 0;}if last_block<first_block{return 0;}if last_block>state[8]{return 0;}var block:i64=jj_mssa_access_block(state,use_id);if block<first_block{return 0;}if block>last_block{return 0;}var loc:*i64=jj_mssa_access_location(state,use_id);if loc==0{return 0;}if loc[5]<=0{return 0;}if jj_alias_location_speculatable(loc)==0{return 0;}
 var i:i64=1;while i<=state[7]{if jj_mssa_access_kind(state,i)==3{var b:i64=jj_mssa_access_block(state,i);if b>=first_block{if b<=last_block{if jj_mssa_access_cir_node(state,i)<=0{return 0;}var w:*i64=jj_mssa_access_location(state,i);if w==0{return 0;}if jj_alias_location_query(loc,w)!=1{return 0;}}}}i=i+1;}return 1;
}
fn jj_mssa_query_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<8{return 0;}out[0]=1;out[1]=1;out[2]=1;out[3]=1;out[4]=1;out[5]=0;out[6]=0;out[7]=0;return 1;}
