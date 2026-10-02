// R736 loop-aware memory invariance admission. It does not rewrite CIR.
extern fn jj_cir_loop_receipt_valid(p0:*i64)->i64;
extern fn jj_cir_loop_natural_member(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_cir_loop_preheader(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_function_has_backedge(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_provenance_valid(p0:*i64)->i64;
extern fn jj_cir_provenance_access_kind(p0:*i64,p1:i64)->i64;
extern fn jj_cir_provenance_access_block(p0:*i64,p1:i64)->i64;
extern fn jj_cir_provenance_access_location(p0:*i64,p1:i64)->*i64;
extern fn jj_alias_location_query(p0:*i64,p1:*i64)->i64;
extern fn jj_alias_location_speculatable(p0:*i64)->i64;
fn jj_cir_loop_memory_admit(receipt:*i64,provenance:*i64,load_record:i64,header:i64,latch:i64)->i64{
 if jj_cir_loop_receipt_valid(receipt)==0{return 0;}if jj_cir_provenance_valid(provenance)==0{return 0;}if receipt[2]!=provenance[2]{return 0;}if receipt[3]!=provenance[3]{return 0;}var cir:*i64=receipt[2] as *i64;if jj_cir_function_has_backedge(cir,receipt[3],latch,header)==0{return 0;}if jj_cir_loop_preheader(cir,receipt[3],header,latch)<=0{return 0;}if load_record<=0{return 0;}if load_record>provenance[7]{return 0;}if jj_cir_provenance_access_kind(provenance,load_record)!=1{return 0;}var load_block:i64=jj_cir_provenance_access_block(provenance,load_record);if jj_cir_loop_natural_member(cir,receipt[3],header,latch,load_block)==0{return 0;}var location:*i64=jj_cir_provenance_access_location(provenance,load_record);if location==0{return 0;}if jj_alias_location_speculatable(location)==0{return 0;}var id:i64=1;while id<=provenance[7]{if id!=load_record{var block:i64=jj_cir_provenance_access_block(provenance,id);if jj_cir_loop_natural_member(cir,receipt[3],header,latch,block)!=0{var kind:i64=jj_cir_provenance_access_kind(provenance,id);if kind==2{var write:*i64=jj_cir_provenance_access_location(provenance,id);if write==0{return 0;}if jj_alias_location_query(location,write)!=1{return 0;}}else{if kind==3{return 0;}if kind==4{return 0;}}}}id=id+1;}return 1;
}
fn jj_cir_loop_memory_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<8{return 0;}out[0]=1;out[1]=1;out[2]=1;out[3]=1;out[4]=0;out[5]=0;out[6]=0;out[7]=0;return 1;}
