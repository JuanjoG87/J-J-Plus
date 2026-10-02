// R732 automatic bounded MemorySSA builder from sealed CIR memory provenance.
extern fn jj_cir_function_validate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_backedge_count(p0:*i64,p1:i64)->i64;
extern fn jj_cir_provenance_valid(p0:*i64)->i64;
extern fn jj_cir_provenance_record_for_node(p0:*i64,p1:i64)->i64;
extern fn jj_cir_provenance_access_kind(p0:*i64,p1:i64)->i64;
extern fn jj_cir_provenance_access_block(p0:*i64,p1:i64)->i64;
extern fn jj_cir_provenance_access_effect(p0:*i64,p1:i64)->i64;
extern fn jj_cir_provenance_access_location(p0:*i64,p1:i64)->*i64;
extern fn jj_alias_location_query(p0:*i64,p1:*i64)->i64;
extern fn jj_alias_location_unknown(p0:*i64)->i64;
extern fn jj_mssa_init(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_mssa_add_mapped(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:*i64)->i64;
extern fn jj_mssa_finish(p0:*i64)->i64;
extern fn jj_mssa_valid(p0:*i64)->i64;
fn jj_mssa_builder_ranges_disjoint(a:*i64,an:i64,b:*i64,bn:i64)->i64{
 if a==0{return 0;}if b==0{return 0;}if an<=0{return 0;}if bn<=0{return 0;}if an>0x0fffffffffffffff{return 0;}if bn>0x0fffffffffffffff{return 0;}var ab:i64=a as i64;var bb:i64=b as i64;var asz:i64=an*8;var bsz:i64=bn*8;if ab>0x7fffffffffffffff-asz{return 0;}if bb>0x7fffffffffffffff-bsz{return 0;}var ae:i64=ab+asz;var be:i64=bb+bsz;if ae<=bb{return 1;}if be<=ab{return 1;}return 0;
}
fn jj_mssa_builder_abort(state:*i64,events:*i64,event_slots:i64)->i64{if state==0{return 0;}if events==0{return 0;}if event_slots<24{return 0;}var i:i64=0;while i<16{state[i]=0;i=i+1;}i=0;while i<event_slots{events[i]=0;i=i+1;}return 1;}
fn jj_mssa_builder_reaching(events:*i64,last:i64,location:*i64,limit:i64)->i64{
 if events==0{return 0;}if location==0{return 0;}var current:i64=last;var steps:i64=0;while current>0{if current>limit{return 0;}var e:*i64=((events as i64)+(current-1)*192) as *i64;if e[1]==3{var write:*i64=((e as i64)+96) as *i64;var q:i64=jj_alias_location_query(location,write);if q==4{return current;}if q!=1{return 0;}}current=e[3];steps=steps+1;if steps>limit{return 0;}}return 0;
}
fn jj_mssa_builder_location_equal(a:*i64,b:*i64)->i64{if a==0{return b==0;}if b==0{return 0;}var i:i64=0;while i<11{if a[i]!=b[i]{return 0;}i=i+1;}return 1;}
fn jj_mssa_builder_complete(state:*i64,provenance:*i64)->i64{
 if jj_mssa_valid(state)==0{return 0;}if jj_cir_provenance_valid(provenance)==0{return 0;}if state[2]!=provenance[2]{return 0;}if state[3]!=provenance[3]{return 0;}if state[7]!=state[8]+provenance[7]{return 0;}var record:i64=1;
 while record<=provenance[7]{var records_base:i64=provenance[4];var r:*i64=(records_base+(record-1)*192) as *i64;var wanted:i64=r[2];var pkind:i64=jj_cir_provenance_access_kind(provenance,record);var pblock:i64=jj_cir_provenance_access_block(provenance,record);var matches:i64=0;var matched:i64=0;var i:i64=1;while i<=state[7]{var candidate:*i64=(state[4]+(i-1)*192) as *i64;if candidate[8]==wanted{matches=matches+1;matched=i;}i=i+1;}if matches!=1{return 0;}var e:*i64=(state[4]+(matched-1)*192) as *i64;if e[2]!=pblock{return 0;}
  if pkind==1{if e[1]!=2{return 0;}if jj_mssa_builder_location_equal(((e as i64)+96) as *i64,jj_cir_provenance_access_location(provenance,record))==0{return 0;}}
  else{if pkind==2{if e[1]!=3{return 0;}if jj_mssa_builder_location_equal(((e as i64)+96) as *i64,jj_cir_provenance_access_location(provenance,record))==0{return 0;}}
  else{if pkind==3{if e[1]!=3{return 0;}var call_loc:*i64=((e as i64)+96) as *i64;if call_loc[2]!=5{return 0;}}
  else{if pkind==4{if e[1]!=3{return 0;}var fence_loc:*i64=((e as i64)+96) as *i64;if fence_loc[2]!=5{return 0;}}else{return 0;}}}}
  record=record+1;}return 1;
}
fn jj_mssa_build_from_cir(state:*i64,cir:*i64,cir_slots:i64,provenance:*i64,events:*i64,event_slots:i64)->i64{
 if state==0{return 0;}if cir==0{return 0;}if provenance==0{return 0;}if events==0{return 0;}if jj_cir_function_validate(cir,cir_slots)==0{return 0;}if jj_cir_function_backedge_count(cir,cir_slots)!=0{return 0;}if jj_cir_provenance_valid(provenance)==0{return 0;}if provenance[2]!=(cir as i64){return 0;}if provenance[3]!=cir_slots{return 0;}if event_slots<24{return 0;}if event_slots%24!=0{return 0;}if cir[2]+provenance[7]>event_slots/24{return 0;}
 if jj_mssa_builder_ranges_disjoint(state,16,provenance,16)==0{return 0;}if jj_mssa_builder_ranges_disjoint(state,16,provenance[4] as *i64,provenance[5])==0{return 0;}if jj_mssa_builder_ranges_disjoint(events,event_slots,provenance,16)==0{return 0;}if jj_mssa_builder_ranges_disjoint(events,event_slots,provenance[4] as *i64,provenance[5])==0{return 0;}
 if jj_mssa_init(state,16,cir,cir_slots,events,event_slots)==0{return 0;}var unknown:[12]i64;var descriptor:[2]i64;if jj_alias_location_unknown(unknown as *i64)==0{jj_mssa_builder_abort(state,events,event_slots);return 0;}var block:i64=1;
 while block<=cir[2]{var last:i64=0;descriptor[0]=0;descriptor[1]=0;if block==1{last=jj_mssa_add_mapped(state,1,block,0,0,descriptor as *i64);}else{last=jj_mssa_add_mapped(state,4,block,0,0,descriptor as *i64);}if last<=0{jj_mssa_builder_abort(state,events,event_slots);return 0;}var bb:i64=12+(block-1)*6;var node:i64=cir[bb];var end:i64=node+cir[bb+1];
  while node<end{var rid:i64=jj_cir_provenance_record_for_node(provenance,node);if rid!=0{if jj_cir_provenance_access_block(provenance,rid)!=block{jj_mssa_builder_abort(state,events,event_slots);return 0;}var kind:i64=jj_cir_provenance_access_kind(provenance,rid);var event:i64=0;
    if kind==1{var load_location:*i64=jj_cir_provenance_access_location(provenance,rid);if load_location==0{jj_mssa_builder_abort(state,events,event_slots);return 0;}var reaching:i64=jj_mssa_builder_reaching(events,last,load_location,state[7]);descriptor[0]=node;descriptor[1]=load_location as i64;event=jj_mssa_add_mapped(state,2,block,last,reaching,descriptor as *i64);}
    if kind==2{var store_location:*i64=jj_cir_provenance_access_location(provenance,rid);if store_location==0{jj_mssa_builder_abort(state,events,event_slots);return 0;}descriptor[0]=node;descriptor[1]=store_location as i64;event=jj_mssa_add_mapped(state,3,block,last,0,descriptor as *i64);}
    if kind==3{if jj_cir_provenance_access_effect(provenance,rid)!=7{jj_mssa_builder_abort(state,events,event_slots);return 0;}descriptor[0]=node;descriptor[1]=unknown as i64;event=jj_mssa_add_mapped(state,3,block,last,0,descriptor as *i64);}
    if kind==4{descriptor[0]=node;descriptor[1]=unknown as i64;event=jj_mssa_add_mapped(state,3,block,last,0,descriptor as *i64);}
    if event<=0{jj_mssa_builder_abort(state,events,event_slots);return 0;}last=event;}node=node+1;}block=block+1;}
 if jj_mssa_finish(state)==0{jj_mssa_builder_abort(state,events,event_slots);return 0;}if jj_mssa_builder_complete(state,provenance)==0{jj_mssa_builder_abort(state,events,event_slots);return 0;}return 1;
}
fn jj_mssa_semantic_equal(a:*i64,b:*i64)->i64{
 if jj_mssa_valid(a)==0{return 0;}if jj_mssa_valid(b)==0{return 0;}if a[2]!=b[2]{return 0;}if a[3]!=b[3]{return 0;}if a[7]!=b[7]{return 0;}if a[8]!=b[8]{return 0;}var i:i64=1;while i<=a[7]{var ea:*i64=(a[4]+(i-1)*192) as *i64;var eb:*i64=(b[4]+(i-1)*192) as *i64;var f:i64=1;while f<11{if ea[f]!=eb[f]{return 0;}f=f+1;}if ea[1]==2{if jj_mssa_builder_location_equal(((ea as i64)+96) as *i64,((eb as i64)+96) as *i64)==0{return 0;}}if ea[1]==3{if jj_mssa_builder_location_equal(((ea as i64)+96) as *i64,((eb as i64)+96) as *i64)==0{return 0;}}if ea[1]==4{var pi:i64=12;while pi<24{if ea[pi]!=eb[pi]{return 0;}pi=pi+1;}}i=i+1;}return 1;
}
fn jj_mssa_builder_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<12{return 0;}out[0]=1;out[1]=1;out[2]=1;out[3]=128;out[4]=32;out[5]=33;out[6]=3;out[7]=34;out[8]=7;out[9]=1;out[10]=1;out[11]=1;return 1;}
