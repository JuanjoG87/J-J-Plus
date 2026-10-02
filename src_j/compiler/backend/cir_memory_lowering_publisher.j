// R733 lifetime-bound provenance publisher for straight-line native CIR.
// It derives every load/store location from sealed CIR object declarations.
extern fn jj_cir_lifetime_state_valid(p0:*i64)->i64;
extern fn jj_cir_lifetime_location(p0:*i64,p1:i64,p2:i64,p3:i64,p4:*i64)->i64;
extern fn jj_cir_provenance_init(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_cir_provenance_add(p0:*i64,p1:i64,p2:i64,p3:*i64,p4:i64,p5:i64)->i64;
extern fn jj_cir_provenance_finish(p0:*i64)->i64;
extern fn jj_cir_provenance_valid(p0:*i64)->i64;
fn jj_cir_lowering_ranges_disjoint(a:*i64,an:i64,b:*i64,bn:i64)->i64{
 if a==0{return 0;}if b==0{return 0;}if an<=0{return 0;}if bn<=0{return 0;}if an>0x0fffffffffffffff{return 0;}if bn>0x0fffffffffffffff{return 0;}var ab:i64=a as i64;var bb:i64=b as i64;var asz:i64=an*8;var bsz:i64=bn*8;if ab>0x7fffffffffffffff-asz{return 0;}if bb>0x7fffffffffffffff-bsz{return 0;}var ae:i64=ab+asz;var be:i64=bb+bsz;if ae<=bb{return 1;}if be<=ab{return 1;}return 0;
}
fn jj_cir_lowering_zero(p:*i64,n:i64)->i64{if p==0{return 0;}if n<=0{return 0;}var i:i64=0;while i<n{p[i]=0;i=i+1;}return 1;}
fn jj_cir_lowering_abort(state:*i64,records:*i64,record_slots:i64)->i64{if state==0{return 0;}if records==0{return 0;}if record_slots<=0{return 0;}jj_cir_lowering_zero(state,16);jj_cir_lowering_zero(records,record_slots);return 1;}
fn jj_cir_lowering_memory_count(cir:*i64)->i64{if cir==0{return 0;}var count:i64=0;var node:i64=1;while node<=cir[3]{var nb:i64=cir[11]+(node-1)*4;var op:i64=cir[nb];if op==32{count=count+1;}if op==33{count=count+1;}if op==3{count=count+1;}if op==34{count=count+1;}node=node+1;}return count;}
fn jj_cir_lowering_publish_provenance(lifetime:*i64,provenance:*i64,records:*i64,record_slots:i64,access_size:i64,mode:i64)->i64{
 if jj_cir_lifetime_state_valid(lifetime)==0{return 0;}if provenance==0{return 0;}if records==0{return 0;}if access_size<=0{return 0;}if access_size>0x7fffffff{return 0;}if mode!=1{return 0;}if record_slots<24{return 0;}if record_slots%24!=0{return 0;}var cir:*i64=lifetime[2] as *i64;var expected:i64=jj_cir_lowering_memory_count(cir);if expected<=0{return 0;}if expected>record_slots/24{return 0;}
 if jj_cir_lowering_ranges_disjoint(provenance,16,lifetime,16)==0{return 0;}if jj_cir_lowering_ranges_disjoint(provenance,16,lifetime[4] as *i64,lifetime[5])==0{return 0;}if jj_cir_lowering_ranges_disjoint(records,record_slots,lifetime,16)==0{return 0;}if jj_cir_lowering_ranges_disjoint(records,record_slots,lifetime[4] as *i64,lifetime[5])==0{return 0;}
 if jj_cir_provenance_init(provenance,16,cir,lifetime[3],records,record_slots)==0{return 0;}var node:i64=1;var published:i64=0;while node<=cir[3]{var nb:i64=cir[11]+(node-1)*4;var op:i64=cir[nb];var id:i64=0;if op==32{var load_location:[12]i64;if jj_cir_lifetime_location(lifetime,cir[nb+2],node,access_size,load_location as *i64)==0{jj_cir_lowering_abort(provenance,records,record_slots);return 0;}id=jj_cir_provenance_add(provenance,node,1,load_location as *i64,1,0);}
  if op==33{var store_location:[12]i64;if jj_cir_lifetime_location(lifetime,cir[nb+2],node,access_size,store_location as *i64)==0{jj_cir_lowering_abort(provenance,records,record_slots);return 0;}if (store_location[6]&4)!=0{jj_cir_lowering_abort(provenance,records,record_slots);return 0;}id=jj_cir_provenance_add(provenance,node,2,store_location as *i64,2,0);}
  if op==3{id=jj_cir_provenance_add(provenance,node,3,0 as *i64,7,0);}
  if op==34{id=jj_cir_provenance_add(provenance,node,4,0 as *i64,7,cir[nb+2]);}
  if op==32{if id<=0{jj_cir_lowering_abort(provenance,records,record_slots);return 0;}published=published+1;}
  if op==33{if id<=0{jj_cir_lowering_abort(provenance,records,record_slots);return 0;}published=published+1;}
  if op==3{if id<=0{jj_cir_lowering_abort(provenance,records,record_slots);return 0;}published=published+1;}
  if op==34{if id<=0{jj_cir_lowering_abort(provenance,records,record_slots);return 0;}published=published+1;}
  node=node+1;}
 if published!=expected{jj_cir_lowering_abort(provenance,records,record_slots);return 0;}if jj_cir_provenance_finish(provenance)==0{jj_cir_lowering_abort(provenance,records,record_slots);return 0;}if jj_cir_provenance_valid(provenance)==0{jj_cir_lowering_abort(provenance,records,record_slots);return 0;}if provenance[7]!=expected{jj_cir_lowering_abort(provenance,records,record_slots);return 0;}return 1;
}
fn jj_cir_lowering_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<12{return 0;}out[0]=1;out[1]=1;out[2]=1;out[3]=1;out[4]=1;out[5]=8;out[6]=35;out[7]=36;out[8]=37;out[9]=1;out[10]=1;out[11]=1;return 1;}
