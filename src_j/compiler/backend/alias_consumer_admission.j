// R729 alias-driven LICM admission. It admits only nonvolatile, nontrapping
// loads whose location is NoAlias with every loop write and is not modded by
// the summarized calls. No byte rewrite is performed here.
extern fn jj_alias_location_valid(p0:*i64)->i64;
extern fn jj_alias_location_query(p0:*i64,p1:*i64)->i64;
extern fn jj_alias_location_speculatable(p0:*i64)->i64;
extern fn jj_alias_call_may_mod(p0:*i64,p1:i64)->i64;
extern fn jj_alias_call_effect_valid(p0:i64)->i64;
fn jj_licm_alias_admit(candidate:*i64,load:*i64,writes:*i64,write_count:i64,stride:i64,call_effect:i64)->i64{
 if candidate==0{return 0;}if jj_alias_location_valid(load)==0{return 0;}if write_count<0{return 0;}if write_count>32{return 0;}if stride!=12{return 0;}if write_count>0{if writes==0{return 0;}}if jj_alias_call_effect_valid(call_effect)==0{return 0;}
 if candidate[0]!=1{return 0;}if candidate[1]!=0{return 0;}if candidate[2]!=0{return 0;}if candidate[3]!=1{return 0;}if candidate[4]!=0{return 0;}if candidate[5]!=1{return 0;}if jj_alias_location_speculatable(load)==0{return 0;}if jj_alias_call_may_mod(load,call_effect)!=0{return 0;}
 var i:i64=0;while i<write_count{var w:*i64=((writes as i64)+(i*stride*8)) as *i64;if jj_alias_location_valid(w)==0{return 0;}if jj_alias_location_query(load,w)!=1{return 0;}i=i+1;}return 1;
}

// R729 alias-driven forwarding admission. This separates correctness from the
// historical exact machine-pattern rewriter. A future CIR consumer may use the
// admission only when the store and load are MustAlias and every intervening
// clobber is NoAlias.
extern fn jj_alias_location_writable(p0:*i64)->i64;
fn jj_memory_forward_alias_admit(store:*i64,load:*i64,clobbers:*i64,count:i64,stride:i64,call_effect:i64)->i64{
 if jj_alias_location_valid(store)==0{return 0;}if jj_alias_location_valid(load)==0{return 0;}if count<0{return 0;}if count>32{return 0;}if stride!=12{return 0;}if count>0{if clobbers==0{return 0;}}if jj_alias_call_effect_valid(call_effect)==0{return 0;}if jj_alias_location_writable(store)==0{return 0;}if (load[6]&1)!=0{return 0;}if jj_alias_location_query(store,load)!=4{return 0;}if jj_alias_call_may_mod(load,call_effect)!=0{return 0;}
 var i:i64=0;while i<count{var c:*i64=((clobbers as i64)+(i*stride*8)) as *i64;if jj_alias_location_valid(c)==0{return 0;}if jj_alias_location_query(load,c)!=1{return 0;}i=i+1;}return 1;
}
