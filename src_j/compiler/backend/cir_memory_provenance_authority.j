// R731 sealed provenance authority for native CIR memory operations.
// State is 16 qwords. Records are 24 qwords and own a re-sealed location copy.
// Kinds: 1 load, 2 store, 3 call, 4 fence. Calls are conservatively effect=7 until ModRef exists.
extern fn jj_cir_function_validate(p0:*i64,p1:i64)->i64;
extern fn jj_alias_location_valid(p0:*i64)->i64;
extern fn jj_alias_location_bind(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_alias_location_set_domain(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
fn jj_cir_provenance_record_words()->i64{return 24;}
fn jj_cir_provenance_location_ptr(r:*i64)->*i64{if r==0{return 0 as *i64;}return ((r as i64)+96) as *i64;}
fn jj_cir_provenance_ranges_disjoint(a:*i64,an:i64,b:*i64,bn:i64)->i64{
 if a==0{return 0;}if b==0{return 0;}if an<=0{return 0;}if bn<=0{return 0;}if an>0x0fffffffffffffff{return 0;}if bn>0x0fffffffffffffff{return 0;}
 var ab:i64=a as i64;var bb:i64=b as i64;var asz:i64=an*8;var bsz:i64=bn*8;if ab>0x7fffffffffffffff-asz{return 0;}if bb>0x7fffffffffffffff-bsz{return 0;}
 var ae:i64=ab+asz;var be:i64=bb+bsz;if ae<=bb{return 1;}if be<=ab{return 1;}return 0;
}
fn jj_cir_provenance_copy_location(dst:*i64,src:*i64)->i64{
 if dst==0{return 0;}if jj_alias_location_valid(src)==0{return 0;}if jj_alias_location_bind(dst,src[2],src[3],src[4],src[5],src[6])==0{return 0;}
 if src[2]!=5{if jj_alias_location_set_domain(dst,src[7],src[8],src[9])==0{return 0;}}return jj_alias_location_valid(dst);
}
fn jj_cir_provenance_zero_record(r:*i64)->i64{if r==0{return 0;}var i:i64=0;while i<24{r[i]=0;i=i+1;}return 1;}
fn jj_cir_provenance_record_ptr(state:*i64,id:i64)->*i64{if state==0{return 0 as *i64;}if id<=0{return 0 as *i64;}if id>state[7]{return 0 as *i64;}return (state[4]+((id-1)*192)) as *i64;}
fn jj_cir_provenance_record_seal(r:*i64)->i64{
 if r==0{return 0;}var h:i64=(r as i64)^0x4a4a435052565331;var i:i64=0;while i<24{var v:i64=r[i];if i==11{v=0;}h=((h<<9)|(h>>>55))^v^((i+5)*0x45d9f3b);i=i+1;}if h==0{h=1;}return h;
}
fn jj_cir_provenance_record_valid(r:*i64)->i64{
 if r==0{return 0;}if r[0]!=0x4a4a435052563031{return 0;}if r[1]!=1{return 0;}if r[2]<=0{return 0;}if r[3]<1{return 0;}if r[3]>4{return 0;}if r[4]<=0{return 0;}if r[5]!=0{return 0;}if r[8]!=0{return 0;}if r[9]!=0{return 0;}if r[10]!=0{return 0;}
 if r[3]==1{if r[6]!=1{return 0;}if r[7]!=0{return 0;}if jj_alias_location_valid(jj_cir_provenance_location_ptr(r))==0{return 0;}if jj_cir_provenance_location_ptr(r)[5]<=0{return 0;}}
 if r[3]==2{if r[6]!=2{return 0;}if r[7]!=0{return 0;}if jj_alias_location_valid(jj_cir_provenance_location_ptr(r))==0{return 0;}if jj_cir_provenance_location_ptr(r)[5]<=0{return 0;}if (jj_cir_provenance_location_ptr(r)[6]&4)!=0{return 0;}}
 if r[3]==3{if r[6]!=7{return 0;}if r[7]!=0{return 0;}var z:i64=12;while z<24{if r[z]!=0{return 0;}z=z+1;}}
 if r[3]==4{if r[6]!=7{return 0;}if r[7]<1{return 0;}if r[7]>3{return 0;}var q:i64=12;while q<24{if r[q]!=0{return 0;}q=q+1;}}
 return r[11]==jj_cir_provenance_record_seal(r);
}
fn jj_cir_provenance_node_block(cir:*i64,node:i64)->i64{
 if cir==0{return 0;}if node<=0{return 0;}if node>cir[3]{return 0;}var block:i64=1;while block<=cir[2]{var b:i64=12+(block-1)*6;var first:i64=cir[b];var count:i64=cir[b+1];if node>=first{if node<first+count{return block;}}block=block+1;}return 0;
}
fn jj_cir_provenance_expected_kind(cir:*i64,node:i64)->i64{
 if cir==0{return 0;}if node<=0{return 0;}if node>cir[3]{return 0;}var nb:i64=cir[11]+(node-1)*4;var op:i64=cir[nb];if op==32{return 1;}if op==33{return 2;}if op==3{return 3;}if op==34{return 4;}return 0;
}
fn jj_cir_provenance_state_seal(state:*i64)->i64{
 if state==0{return 0;}var h:i64=(state as i64)^0x4a4a435052535431;var i:i64=0;while i<16{var v:i64=state[i];if i==11{v=0;}h=((h<<7)|(h>>>57))^v^((i+7)*0x9e3779b1);i=i+1;}var cir:*i64=state[2] as *i64;if cir!=0{h=h^cir[7];}i=1;while i<=state[7]{var r:*i64=(state[4]+((i-1)*192)) as *i64;h=((h<<11)|(h>>>53))^r[11]^i;i=i+1;}if h==0{h=1;}return h;
}
fn jj_cir_provenance_open_valid(state:*i64)->i64{
 if state==0{return 0;}if ((state as i64)&7)!=0{return 0;}if (state[2]&7)!=0{return 0;}if (state[4]&7)!=0{return 0;}if state[0]!=0x4a4a4350524f3031{return 0;}if state[1]!=1{return 0;}if state[2]==0{return 0;}if state[3]<64{return 0;}if state[4]==0{return 0;}if state[5]<24{return 0;}if state[5]%24!=0{return 0;}if state[6]!=state[5]/24{return 0;}if state[6]>128{return 0;}if state[7]<0{return 0;}if state[7]>state[6]{return 0;}if state[8]<0{return 0;}if state[8]>1{return 0;}if state[9]!=0{return 0;}if state[10]!=0{return 0;}var z:i64=12;while z<16{if state[z]!=0{return 0;}z=z+1;}
 var cir:*i64=state[2] as *i64;if jj_cir_function_validate(cir,state[3])==0{return 0;}if jj_cir_provenance_ranges_disjoint(state,16,cir,state[3])==0{return 0;}if jj_cir_provenance_ranges_disjoint(state,16,state[4] as *i64,state[5])==0{return 0;}if jj_cir_provenance_ranges_disjoint(cir,state[3],state[4] as *i64,state[5])==0{return 0;}
 var i:i64=1;var last_node:i64=0;while i<=state[7]{var r:*i64=jj_cir_provenance_record_ptr(state,i);if jj_cir_provenance_record_valid(r)==0{return 0;}if r[2]<=last_node{return 0;}last_node=r[2];i=i+1;}var tail:i64=state[7]*24;var rp:*i64=state[4] as *i64;while tail<state[5]{if rp[tail]!=0{return 0;}tail=tail+1;}return state[11]==jj_cir_provenance_state_seal(state);
}
fn jj_cir_provenance_complete(state:*i64)->i64{
 if jj_cir_provenance_open_valid(state)==0{return 0;}var cir:*i64=state[2] as *i64;var expected:i64=0;var record:i64=1;var node:i64=1;while node<=cir[3]{var kind:i64=jj_cir_provenance_expected_kind(cir,node);if kind!=0{expected=expected+1;if record>state[7]{return 0;}var r:*i64=jj_cir_provenance_record_ptr(state,record);if r[2]!=node{return 0;}if r[3]!=kind{return 0;}if r[4]!=jj_cir_provenance_node_block(cir,node){return 0;}if kind==4{var nb:i64=cir[11]+(node-1)*4;if r[7]!=cir[nb+2]{return 0;}}record=record+1;}node=node+1;}if expected!=state[7]{return 0;}return 1;
}
fn jj_cir_provenance_init(state:*i64,state_slots:i64,cir:*i64,cir_slots:i64,records:*i64,record_slots:i64)->i64{
 if state==0{return 0;}if state_slots!=16{return 0;}if cir==0{return 0;}if records==0{return 0;}if ((state as i64)&7)!=0{return 0;}if ((cir as i64)&7)!=0{return 0;}if ((records as i64)&7)!=0{return 0;}if record_slots<24{return 0;}if record_slots%24!=0{return 0;}if record_slots/24>128{return 0;}if jj_cir_function_validate(cir,cir_slots)==0{return 0;}if jj_cir_provenance_ranges_disjoint(state,state_slots,cir,cir_slots)==0{return 0;}if jj_cir_provenance_ranges_disjoint(state,state_slots,records,record_slots)==0{return 0;}if jj_cir_provenance_ranges_disjoint(cir,cir_slots,records,record_slots)==0{return 0;}
 var i:i64=0;while i<state_slots{state[i]=0;i=i+1;}i=0;while i<record_slots{records[i]=0;i=i+1;}state[0]=0x4a4a4350524f3031;state[1]=1;state[2]=cir as i64;state[3]=cir_slots;state[4]=records as i64;state[5]=record_slots;state[6]=record_slots/24;state[7]=0;state[8]=0;state[9]=0;state[10]=0;state[11]=jj_cir_provenance_state_seal(state);return jj_cir_provenance_open_valid(state);
}
fn jj_cir_provenance_add(state:*i64,node:i64,kind:i64,location:*i64,effect:i64,ordering:i64)->i64{
 if jj_cir_provenance_open_valid(state)==0{return 0;}if state[8]!=0{return 0;}if state[7]>=state[6]{return 0;}var cir:*i64=state[2] as *i64;if node<=0{return 0;}if node>cir[3]{return 0;}var expected:i64=jj_cir_provenance_expected_kind(cir,node);if expected==0{return 0;}if kind!=expected{return 0;}if state[7]>0{var prior:*i64=jj_cir_provenance_record_ptr(state,state[7]);if node<=prior[2]{return 0;}}
 if kind==1{if location==0{return 0;}if jj_alias_location_valid(location)==0{return 0;}if location[5]<=0{return 0;}if effect!=1{return 0;}if ordering!=0{return 0;}}
 if kind==2{if location==0{return 0;}if jj_alias_location_valid(location)==0{return 0;}if location[5]<=0{return 0;}if (location[6]&4)!=0{return 0;}if effect!=2{return 0;}if ordering!=0{return 0;}}
 if kind==3{if location!=0{return 0;}if effect!=7{return 0;}if ordering!=0{return 0;}}
 if kind==4{if location!=0{return 0;}if effect!=7{return 0;}var nb:i64=cir[11]+(node-1)*4;if ordering!=cir[nb+2]{return 0;}}
 var id:i64=state[7]+1;var r:*i64=(state[4]+((id-1)*192)) as *i64;if jj_cir_provenance_zero_record(r)==0{return 0;}r[0]=0x4a4a435052563031;r[1]=1;r[2]=node;r[3]=kind;r[4]=jj_cir_provenance_node_block(cir,node);r[5]=0;r[6]=effect;r[7]=ordering;
 if kind==1{if jj_cir_provenance_copy_location(jj_cir_provenance_location_ptr(r),location)==0{jj_cir_provenance_zero_record(r);return 0;}}if kind==2{if jj_cir_provenance_copy_location(jj_cir_provenance_location_ptr(r),location)==0{jj_cir_provenance_zero_record(r);return 0;}}
 r[11]=jj_cir_provenance_record_seal(r);if jj_cir_provenance_record_valid(r)==0{jj_cir_provenance_zero_record(r);return 0;}var prior_count:i64=state[7];state[7]=id;state[11]=jj_cir_provenance_state_seal(state);if jj_cir_provenance_open_valid(state)==0{state[7]=prior_count;jj_cir_provenance_zero_record(r);state[11]=jj_cir_provenance_state_seal(state);return 0;}return id;
}
fn jj_cir_provenance_finish(state:*i64)->i64{if jj_cir_provenance_open_valid(state)==0{return 0;}if state[8]!=0{return 0;}if jj_cir_provenance_complete(state)==0{return 0;}state[8]=1;state[11]=jj_cir_provenance_state_seal(state);return jj_cir_provenance_complete(state);}
fn jj_cir_provenance_valid(state:*i64)->i64{if jj_cir_provenance_open_valid(state)==0{return 0;}if state[8]!=1{return 0;}return jj_cir_provenance_complete(state);}
fn jj_cir_provenance_record_for_node(state:*i64,node:i64)->i64{if jj_cir_provenance_valid(state)==0{return 0;}var i:i64=1;while i<=state[7]{var r:*i64=jj_cir_provenance_record_ptr(state,i);if r[2]==node{return i;}if r[2]>node{return 0;}i=i+1;}return 0;}
fn jj_cir_provenance_access_node(state:*i64,id:i64)->i64{if jj_cir_provenance_valid(state)==0{return 0;}var r:*i64=jj_cir_provenance_record_ptr(state,id);if r==0{return 0;}return r[2];}
fn jj_cir_provenance_access_kind(state:*i64,id:i64)->i64{if jj_cir_provenance_valid(state)==0{return 0;}var r:*i64=jj_cir_provenance_record_ptr(state,id);if r==0{return 0;}return r[3];}
fn jj_cir_provenance_access_block(state:*i64,id:i64)->i64{if jj_cir_provenance_valid(state)==0{return 0;}var r:*i64=jj_cir_provenance_record_ptr(state,id);if r==0{return 0;}return r[4];}
fn jj_cir_provenance_access_effect(state:*i64,id:i64)->i64{if jj_cir_provenance_valid(state)==0{return 0;}var r:*i64=jj_cir_provenance_record_ptr(state,id);if r==0{return 0;}return r[6];}
fn jj_cir_provenance_access_ordering(state:*i64,id:i64)->i64{if jj_cir_provenance_valid(state)==0{return 0;}var r:*i64=jj_cir_provenance_record_ptr(state,id);if r==0{return 0;}return r[7];}
fn jj_cir_provenance_access_location(state:*i64,id:i64)->*i64{if jj_cir_provenance_valid(state)==0{return 0 as *i64;}var r:*i64=jj_cir_provenance_record_ptr(state,id);if r==0{return 0 as *i64;}if r[3]!=1{if r[3]!=2{return 0 as *i64;}}return jj_cir_provenance_location_ptr(r);}
fn jj_cir_provenance_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<12{return 0;}out[0]=16;out[1]=24;out[2]=128;out[3]=4;out[4]=32;out[5]=33;out[6]=3;out[7]=34;out[8]=7;out[9]=1;out[10]=2;out[11]=3;return 1;}
