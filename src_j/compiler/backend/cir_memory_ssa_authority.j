// R731 sealed, bounded CIR memory Def/Use/Phi sidecar with native node identity.
// State is 16 qwords. Events are 24 qwords and own a re-sealed location copy.
extern fn jj_cir_function_validate(p0:*i64,p1:i64)->i64;
extern fn jj_alias_location_valid(p0:*i64)->i64;
extern fn jj_alias_location_bind(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_alias_location_set_domain(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_alias_location_query(p0:*i64,p1:*i64)->i64;
fn jj_mssa_event_words()->i64{return 24;}
fn jj_mssa_phi_input_capacity()->i64{return 12;}
fn jj_mssa_phi_input_raw(e:*i64,index:i64)->i64{if e==0{return 0;}if index<0{return 0;}if index>=e[5]{return 0;}if index==0{return e[6];}if index==1{return e[7];}if index>=jj_mssa_phi_input_capacity(){return 0;}return e[10+index];}
fn jj_mssa_location_ptr(e:*i64)->*i64{if e==0{return 0 as *i64;}return ((e as i64)+96) as *i64;}
fn jj_mssa_ranges_disjoint(a:*i64,an:i64,b:*i64,bn:i64)->i64{
 if a==0{return 0;}if b==0{return 0;}if an<=0{return 0;}if bn<=0{return 0;}if an>0x0fffffffffffffff{return 0;}if bn>0x0fffffffffffffff{return 0;}
 var ab:i64=a as i64;var bb:i64=b as i64;var asz:i64=an*8;var bsz:i64=bn*8;if ab>0x7fffffffffffffff-asz{return 0;}if bb>0x7fffffffffffffff-bsz{return 0;}
 var ae:i64=ab+asz;var be:i64=bb+bsz;if ae<=bb{return 1;}if be<=ab{return 1;}return 0;
}
fn jj_mssa_copy_location(dst:*i64,src:*i64)->i64{
 if dst==0{return 0;}if jj_alias_location_valid(src)==0{return 0;}if jj_alias_location_bind(dst,src[2],src[3],src[4],src[5],src[6])==0{return 0;}
 if src[2]!=5{if jj_alias_location_set_domain(dst,src[7],src[8],src[9])==0{return 0;}}return jj_alias_location_valid(dst);
}
fn jj_mssa_zero_event(e:*i64)->i64{if e==0{return 0;}var i:i64=0;while i<24{e[i]=0;i=i+1;}return 1;}
fn jj_mssa_event_ptr(state:*i64,id:i64)->*i64{if state==0{return 0 as *i64;}if id<=0{return 0 as *i64;}if id>state[7]{return 0 as *i64;}return (state[4]+((id-1)*192)) as *i64;}
fn jj_mssa_event_seal(e:*i64)->i64{
 if e==0{return 0;}var h:i64=(e as i64)^0x4a4a4d5353455631;var i:i64=0;while i<24{var v:i64=e[i];if i==11{v=0;}h=((h<<9)|(h>>>55))^v^((i+1)*0x45d9f3b);i=i+1;}if h==0{h=1;}return h;
}
fn jj_mssa_event_valid(e:*i64)->i64{
 if e==0{return 0;}if e[0]!=0x4a4a4d5353453031{return 0;}if e[1]<1{return 0;}if e[1]>4{return 0;}if e[2]<=0{return 0;}if e[3]<0{return 0;}if e[4]<0{return 0;}if e[5]<0{return 0;}if e[5]>jj_mssa_phi_input_capacity(){return 0;}if e[6]<0{return 0;}if e[7]<0{return 0;}if e[8]<0{return 0;}if e[9]!=0{return 0;}if e[10]!=0{return 0;}
 if e[1]==2{if e[5]!=0{return 0;}if e[6]!=0{return 0;}if e[7]!=0{return 0;}if jj_alias_location_valid(jj_mssa_location_ptr(e))==0{return 0;}}
 else{if e[1]==3{if e[5]!=0{return 0;}if e[6]!=0{return 0;}if e[7]!=0{return 0;}if jj_alias_location_valid(jj_mssa_location_ptr(e))==0{return 0;}}
 else{if e[1]==4{if e[5]<1{return 0;}if e[6]<=0{return 0;}if e[5]==1{if e[7]!=0{return 0;}}else{if e[7]<=0{return 0;}}var pi:i64=2;while pi<e[5]{if e[10+pi]<=0{return 0;}pi=pi+1;}while pi<jj_mssa_phi_input_capacity(){if e[10+pi]!=0{return 0;}pi=pi+1;}if e[22]!=0{return 0;}if e[23]!=0{return 0;}}
 else{if e[5]!=0{return 0;}if e[6]!=0{return 0;}if e[7]!=0{return 0;}var z:i64=12;while z<24{if e[z]!=0{return 0;}z=z+1;}}}}
 return e[11]==jj_mssa_event_seal(e);
}
fn jj_mssa_predecessor_count(cir:*i64,slots:i64,block:i64)->i64{
 if jj_cir_function_validate(cir,slots)==0{return 0;}if block<=1{return 0;}if block>cir[2]{return 0;}var count:i64=0;var from:i64=1;
 while from<block{var b:i64=12+(from-1)*6;var term:i64=cir[b+2];if term==2{if cir[b+4]==block-1{count=count+1;}}if term==3{if cir[b+4]==block-1{count=count+1;}if cir[b+5]==block-1{count=count+1;}}from=from+1;}return count;
}
fn jj_mssa_predecessor_at(cir:*i64,slots:i64,block:i64,index:i64)->i64{
 if jj_cir_function_validate(cir,slots)==0{return 0;}if block<=1{return 0;}if block>cir[2]{return 0;}if index<0{return 0;}var seen:i64=0;var from:i64=1;
 while from<block{var b:i64=12+(from-1)*6;var term:i64=cir[b+2];if term==2{if cir[b+4]==block-1{if seen==index{return from;}seen=seen+1;}}if term==3{if cir[b+4]==block-1{if seen==index{return from;}seen=seen+1;}if cir[b+5]==block-1{if seen==index{return from;}seen=seen+1;}}from=from+1;}return 0;
}
fn jj_mssa_state_seal(state:*i64)->i64{
 if state==0{return 0;}var h:i64=(state as i64)^0x4a4a4d5353535431;var i:i64=0;while i<16{var v:i64=state[i];if i==11{v=0;}h=((h<<7)|(h>>>57))^v^((i+3)*0x9e3779b1);i=i+1;}
 var cir:*i64=state[2] as *i64;if cir!=0{h=h^cir[7];}i=1;while i<=state[7]{var e:*i64=(state[4]+((i-1)*192)) as *i64;h=((h<<11)|(h>>>53))^e[11]^i;i=i+1;}if h==0{h=1;}return h;
}
fn jj_mssa_open_valid(state:*i64)->i64{
 if state==0{return 0;}if ((state as i64)&7)!=0{return 0;}if (state[2]&7)!=0{return 0;}if (state[4]&7)!=0{return 0;}if state[0]!=0x4a4a4d5353413031{return 0;}if state[1]!=1{return 0;}if state[2]==0{return 0;}if state[3]<64{return 0;}if state[4]==0{return 0;}if state[5]<24{return 0;}if state[5]%24!=0{return 0;}if state[6]!=state[5]/24{return 0;}if state[6]>128{return 0;}if state[7]<0{return 0;}if state[7]>state[6]{return 0;}if state[8]<=0{return 0;}if state[9]<0{return 0;}if state[9]>1{return 0;}if state[10]!=0{return 0;}var z:i64=12;while z<16{if state[z]!=0{return 0;}z=z+1;}
 var cir:*i64=state[2] as *i64;if jj_cir_function_validate(cir,state[3])==0{return 0;}if state[8]!=cir[2]{return 0;}if jj_mssa_ranges_disjoint(state,16,cir,state[3])==0{return 0;}if jj_mssa_ranges_disjoint(state,16,state[4] as *i64,state[5])==0{return 0;}if jj_mssa_ranges_disjoint(cir,state[3],state[4] as *i64,state[5])==0{return 0;}
 var i:i64=1;while i<=state[7]{if jj_mssa_event_valid(jj_mssa_event_ptr(state,i))==0{return 0;}i=i+1;}var tail:i64=state[7]*24;while tail<state[5]{var ep:*i64=state[4] as *i64;if ep[tail]!=0{return 0;}tail=tail+1;}return state[11]==jj_mssa_state_seal(state);
}
fn jj_mssa_last_event_in_block(state:*i64,block:i64,limit:i64)->i64{var last:i64=0;var i:i64=1;while i<=limit{var e:*i64=jj_mssa_event_ptr(state,i);if e[2]==block{last=i;}i=i+1;}return last;}
fn jj_mssa_event_defines(e:*i64)->i64{if jj_mssa_event_valid(e)==0{return 0;}if e[1]==1{return 1;}if e[1]==3{return 1;}if e[1]==4{return 1;}return 0;}
fn jj_mssa_last_def_in_block(state:*i64,block:i64,limit:i64)->i64{var last:i64=0;var i:i64=1;while i<=limit{var e:*i64=jj_mssa_event_ptr(state,i);if e[2]==block{if jj_mssa_event_defines(e)!=0{last=i;}}i=i+1;}return last;}
fn jj_mssa_on_raw_chain(state:*i64,start:i64,target:i64)->i64{if target<=0{return 0;}var current:i64=start;var steps:i64=0;while current>0{if current==target{return 1;}var e:*i64=jj_mssa_event_ptr(state,current);if e==0{return 0;}current=e[3];steps=steps+1;if steps>state[7]{return 0;}}return 0;}
fn jj_mssa_cir_node_block(cir:*i64,node:i64)->i64{if cir==0{return 0;}if node<=0{return 0;}if node>cir[3]{return 0;}var block:i64=1;while block<=cir[2]{var b:i64=12+(block-1)*6;var first:i64=cir[b];var count:i64=cir[b+1];if node>=first{if node<first+count{return block;}}block=block+1;}return 0;}
fn jj_mssa_cir_node_matches(cir:*i64,node:i64,kind:i64)->i64{if cir==0{return 0;}if node<=0{return 0;}if node>cir[3]{return 0;}var nb:i64=cir[11]+(node-1)*4;var op:i64=cir[nb];if kind==2{if op==32{return 1;}return 0;}if kind==3{if op==33{return 1;}if op==3{return 1;}if op==34{return 1;}return 0;}return 0;}
fn jj_mssa_structure_valid(state:*i64)->i64{
 if jj_mssa_open_valid(state)==0{return 0;}if state[7]<=0{return 0;}var cir:*i64=state[2] as *i64;var blocks:i64=state[8];var last_block:i64=0;var last_event:i64=0;var seen_blocks:i64=0;var last_cir_node:i64=0;var i:i64=1;
 while i<=state[7]{var e:*i64=jj_mssa_event_ptr(state,i);var block:i64=e[2];if e[8]!=0{if e[8]<=last_cir_node{return 0;}if jj_mssa_cir_node_block(cir,e[8])!=block{return 0;}if jj_mssa_cir_node_matches(cir,e[8],e[1])==0{return 0;}last_cir_node=e[8];}if block<1{return 0;}if block>blocks{return 0;}if block<last_block{return 0;}if block!=last_block{if block!=last_block+1{return 0;}last_block=block;seen_blocks=seen_blocks+1;last_event=0;if block==1{if e[1]!=1{return 0;}}else{if e[1]!=4{return 0;}}}
  if e[1]==1{if i!=1{return 0;}if block!=1{return 0;}if e[3]!=0{return 0;}if e[4]!=0{return 0;}if e[5]!=0{return 0;}if e[8]!=0{return 0;}}
  if e[1]==4{if e[3]!=0{return 0;}if e[4]!=0{return 0;}if e[8]!=0{return 0;}var pc:i64=jj_mssa_predecessor_count(cir,state[3],block);if pc<1{return 0;}if pc>jj_mssa_phi_input_capacity(){return 0;}if e[5]!=pc{return 0;}var pindex:i64=0;while pindex<pc{var pred:i64=jj_mssa_predecessor_at(cir,state[3],block,pindex);var pdef:i64=jj_mssa_last_def_in_block(state,pred,i-1);if pdef<=0{return 0;}if jj_mssa_phi_input_raw(e,pindex)!=pdef{return 0;}pindex=pindex+1;}}
  if e[1]==2{if e[8]<=0{return 0;}if jj_mssa_location_ptr(e)[5]<=0{return 0;}if e[3]!=last_event{return 0;}if e[3]<=0{return 0;}if e[4]!=0{if e[4]>=i{return 0;}var od:*i64=jj_mssa_event_ptr(state,e[4]);if jj_mssa_event_defines(od)==0{return 0;}if od[2]!=block{return 0;}if jj_mssa_on_raw_chain(state,e[3],e[4])==0{return 0;}var aq:i64=jj_alias_location_query(jj_mssa_location_ptr(e),jj_mssa_location_ptr(od));if aq!=4{return 0;}}if e[5]!=0{return 0;}if e[6]!=0{return 0;}if e[7]!=0{return 0;}}
  if e[1]==3{if e[8]<=0{return 0;}var dnb:i64=cir[11]+(e[8]-1)*4;var dop:i64=cir[dnb];if dop==33{if jj_mssa_location_ptr(e)[5]<=0{return 0;}if (jj_mssa_location_ptr(e)[6]&4)!=0{return 0;}}else{if dop==3{if jj_mssa_location_ptr(e)[2]!=5{return 0;}}else{if dop==34{if jj_mssa_location_ptr(e)[2]!=5{return 0;}}else{return 0;}}}if e[3]!=last_event{return 0;}if e[3]<=0{return 0;}if e[4]!=0{return 0;}if e[5]!=0{return 0;}if e[6]!=0{return 0;}if e[7]!=0{return 0;}}
  last_event=i;i=i+1;}
 if seen_blocks!=blocks{return 0;}return 1;
}
fn jj_mssa_init(state:*i64,state_slots:i64,cir:*i64,cir_slots:i64,events:*i64,event_slots:i64)->i64{
 if state==0{return 0;}if state_slots!=16{return 0;}if cir==0{return 0;}if events==0{return 0;}if ((state as i64)&7)!=0{return 0;}if ((cir as i64)&7)!=0{return 0;}if ((events as i64)&7)!=0{return 0;}if event_slots<24{return 0;}if event_slots%24!=0{return 0;}if event_slots/24>128{return 0;}if jj_cir_function_validate(cir,cir_slots)==0{return 0;}if jj_mssa_ranges_disjoint(state,state_slots,cir,cir_slots)==0{return 0;}if jj_mssa_ranges_disjoint(state,state_slots,events,event_slots)==0{return 0;}if jj_mssa_ranges_disjoint(cir,cir_slots,events,event_slots)==0{return 0;}
 var i:i64=0;while i<state_slots{state[i]=0;i=i+1;}i=0;while i<event_slots{events[i]=0;i=i+1;}state[0]=0x4a4a4d5353413031;state[1]=1;state[2]=cir as i64;state[3]=cir_slots;state[4]=events as i64;state[5]=event_slots;state[6]=event_slots/24;state[7]=0;state[8]=cir[2];state[9]=0;state[10]=0;state[11]=jj_mssa_state_seal(state);return jj_mssa_open_valid(state);
}
fn jj_mssa_add_mapped(state:*i64,kind:i64,block:i64,raw_prev:i64,optimized_def:i64,descriptor:*i64)->i64{
 if descriptor==0{return 0;}var cir_node:i64=descriptor[0];var location:*i64=descriptor[1] as *i64;if jj_mssa_open_valid(state)==0{return 0;}if state[9]!=0{return 0;}if kind<1{return 0;}if kind>4{return 0;}if block<1{return 0;}if block>state[8]{return 0;}if state[7]>=state[6]{return 0;}if cir_node<0{return 0;}var cir:*i64=state[2] as *i64;if kind==1{if cir_node!=0{return 0;}}if kind==4{if cir_node!=0{return 0;}}if kind==2{if cir_node<=0{return 0;}if jj_mssa_cir_node_block(cir,cir_node)!=block{return 0;}if jj_mssa_cir_node_matches(cir,cir_node,kind)==0{return 0;}}if kind==3{if cir_node<=0{return 0;}if jj_mssa_cir_node_block(cir,cir_node)!=block{return 0;}if jj_mssa_cir_node_matches(cir,cir_node,kind)==0{return 0;}}if cir_node!=0{var prior_node:i64=0;var scan:i64=state[7];while scan>0{var pe:*i64=jj_mssa_event_ptr(state,scan);if pe[8]!=0{prior_node=pe[8];scan=0;}else{scan=scan-1;}}if cir_node<=prior_node{return 0;}}var id:i64=state[7]+1;var global_last_block:i64=0;if state[7]>0{var ge:*i64=jj_mssa_event_ptr(state,state[7]);global_last_block=ge[2];}var last:i64=jj_mssa_last_event_in_block(state,block,state[7]);
 if kind==1{if id!=1{return 0;}if block!=1{return 0;}if raw_prev!=0{return 0;}if optimized_def!=0{return 0;}if location!=0{return 0;}}
 if kind==4{if block<=1{return 0;}if block!=global_last_block+1{return 0;}if last!=0{return 0;}if raw_prev!=0{return 0;}if optimized_def!=0{return 0;}if location!=0{return 0;}}
 if kind==2{if block!=global_last_block{return 0;}if last<=0{return 0;}if raw_prev!=last{return 0;}if optimized_def<0{return 0;}if location==0{return 0;}if jj_alias_location_valid(location)==0{return 0;}if location[5]<=0{return 0;}if optimized_def!=0{if optimized_def>=id{return 0;}var od:*i64=jj_mssa_event_ptr(state,optimized_def);if jj_mssa_event_defines(od)==0{return 0;}if od[2]!=block{return 0;}if jj_mssa_on_raw_chain(state,raw_prev,optimized_def)==0{return 0;}var aq:i64=jj_alias_location_query(location,jj_mssa_location_ptr(od));if aq!=4{return 0;}}}
 if kind==3{if block!=global_last_block{return 0;}if last<=0{return 0;}if raw_prev!=last{return 0;}if optimized_def!=0{return 0;}if location==0{return 0;}if jj_alias_location_valid(location)==0{return 0;}var knb:i64=cir[11]+(cir_node-1)*4;var kop:i64=cir[knb];if kop==33{if location[5]<=0{return 0;}if (location[6]&4)!=0{return 0;}}else{if kop==3{if location[2]!=5{return 0;}}else{if kop==34{if location[2]!=5{return 0;}}else{return 0;}}}}
 var pc:i64=0;var phi_inputs:[12]i64;var px:i64=0;while px<jj_mssa_phi_input_capacity(){phi_inputs[px]=0;px=px+1;}if kind==4{pc=jj_mssa_predecessor_count(cir,state[3],block);if pc<1{return 0;}if pc>jj_mssa_phi_input_capacity(){return 0;}px=0;while px<pc{var pred:i64=jj_mssa_predecessor_at(cir,state[3],block,px);var pdef:i64=jj_mssa_last_def_in_block(state,pred,state[7]);if pdef<=0{return 0;}phi_inputs[px]=pdef;px=px+1;}}
 var e:*i64=(state[4]+((id-1)*192)) as *i64;if jj_mssa_zero_event(e)==0{return 0;}e[0]=0x4a4a4d5353453031;e[1]=kind;e[2]=block;e[3]=raw_prev;e[4]=optimized_def;e[5]=pc;if pc>0{e[6]=phi_inputs[0];}if pc>1{e[7]=phi_inputs[1];}if pc>2{px=2;while px<pc{e[10+px]=phi_inputs[px];px=px+1;}}e[8]=cir_node;
 if kind==2{if jj_mssa_copy_location(jj_mssa_location_ptr(e),location)==0{jj_mssa_zero_event(e);return 0;}}if kind==3{if jj_mssa_copy_location(jj_mssa_location_ptr(e),location)==0{jj_mssa_zero_event(e);return 0;}}e[11]=jj_mssa_event_seal(e);if jj_mssa_event_valid(e)==0{jj_mssa_zero_event(e);return 0;}var prior_count:i64=state[7];state[7]=id;state[11]=jj_mssa_state_seal(state);if jj_mssa_open_valid(state)==0{state[7]=prior_count;jj_mssa_zero_event(e);state[11]=jj_mssa_state_seal(state);return 0;}return id;
}
fn jj_mssa_add(state:*i64,kind:i64,block:i64,raw_prev:i64,optimized_def:i64,location:*i64)->i64{var descriptor:[2]i64;descriptor[0]=0;descriptor[1]=location as i64;return jj_mssa_add_mapped(state,kind,block,raw_prev,optimized_def,descriptor as *i64);}
fn jj_mssa_finish(state:*i64)->i64{if jj_mssa_open_valid(state)==0{return 0;}if state[9]!=0{return 0;}if jj_mssa_structure_valid(state)==0{return 0;}state[9]=1;state[11]=jj_mssa_state_seal(state);return jj_mssa_structure_valid(state);}
fn jj_mssa_valid(state:*i64)->i64{if jj_mssa_open_valid(state)==0{return 0;}if state[9]!=1{return 0;}return jj_mssa_structure_valid(state);}
fn jj_mssa_access_kind(state:*i64,id:i64)->i64{if jj_mssa_valid(state)==0{return 0;}var e:*i64=jj_mssa_event_ptr(state,id);if e==0{return 0;}return e[1];}
fn jj_mssa_access_block(state:*i64,id:i64)->i64{if jj_mssa_valid(state)==0{return 0;}var e:*i64=jj_mssa_event_ptr(state,id);if e==0{return 0;}return e[2];}
fn jj_mssa_access_raw_prev(state:*i64,id:i64)->i64{if jj_mssa_valid(state)==0{return 0;}var e:*i64=jj_mssa_event_ptr(state,id);if e==0{return 0;}return e[3];}
fn jj_mssa_access_optimized_def(state:*i64,id:i64)->i64{if jj_mssa_valid(state)==0{return 0;}var e:*i64=jj_mssa_event_ptr(state,id);if e==0{return 0;}return e[4];}
fn jj_mssa_access_cir_node(state:*i64,id:i64)->i64{if jj_mssa_valid(state)==0{return 0;}var e:*i64=jj_mssa_event_ptr(state,id);if e==0{return 0;}return e[8];}
fn jj_mssa_access_location(state:*i64,id:i64)->*i64{if jj_mssa_valid(state)==0{return 0 as *i64;}var e:*i64=jj_mssa_event_ptr(state,id);if e==0{return 0 as *i64;}if e[1]!=2{if e[1]!=3{return 0 as *i64;}}return jj_mssa_location_ptr(e);}
fn jj_mssa_access_phi_count(state:*i64,id:i64)->i64{if jj_mssa_valid(state)==0{return 0;}var e:*i64=jj_mssa_event_ptr(state,id);if e==0{return 0;}if e[1]!=4{return 0;}return e[5];}
fn jj_mssa_access_phi_input(state:*i64,id:i64,index:i64)->i64{if jj_mssa_valid(state)==0{return 0;}var e:*i64=jj_mssa_event_ptr(state,id);if e==0{return 0;}if e[1]!=4{return 0;}return jj_mssa_phi_input_raw(e,index);}
fn jj_mssa_phi_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<8{return 0;}out[0]=12;out[1]=24;out[2]=2;out[3]=12;out[4]=21;out[5]=1;out[6]=1;out[7]=0;return 1;}
fn jj_mssa_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<12{return 0;}out[0]=16;out[1]=24;out[2]=128;out[3]=4;out[4]=2;out[5]=1;out[6]=2;out[7]=3;out[8]=4;out[9]=1;out[10]=1;out[11]=1;return 1;}
