// Capacity-derived target-parametric allocator for sealed CIR v1/v2.
// Logical i64 occupies one lane on 64-bit targets and an adjacent lane pair on
// 32-bit targets. Definition happens after operand consumption, so a location
// whose last use is the current node may be reused by that node's result.
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_profile_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_profile_align(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_target_profile_value_parts(p0:*i64,p1:i64,p2:i64)->i64;

fn jj_tra_slots_valid(slots:i64)->i64{
  if slots<17{return 0;}if slots>81922{return 0;}return 1;
}
fn jj_tra_capacity(slots:i64)->i64{
  if jj_tra_slots_valid(slots)==0{return 0;}return (slots-12)/5;
}
fn jj_tra_zero(plan:*i64,slots:i64)->i64{
  if plan==0{return 0;}if jj_tra_slots_valid(slots)==0{return 0;}
  var i:i64=0;while i<slots{plan[i]=0;i=i+1;}return 1;
}
fn jj_tra_nonoverlap(a:*i64,aslots:i64,b:*i64,bslots:i64)->i64{
  if a==0{return 0;}if b==0{return 0;}if aslots<=0{return 0;}if bslots<=0{return 0;}
  if aslots>81922{return 0;}if bslots>81922{return 0;}
  var aa:i64=a as i64;var ba:i64=b as i64;var an:i64=aslots*8;var bn:i64=bslots*8;
  if aa<=0{return 0;}if ba<=0{return 0;}
  if aa<ba{if ba-aa<an{return 0;}}else{if aa-ba<bn{return 0;}}return 1;
}
fn jj_tra_count(cir:*i64)->i64{
  if cir[1]==1{return cir[2];}if cir[1]==2{return cir[3];}return 0;
}
fn jj_tra_result(cir:*i64)->i64{
  if cir[1]==1{return cir[6];}if cir[1]==2{return 0;}return 0-1;
}
fn jj_tra_node_base(cir:*i64,value:i64)->i64{
  if value<=0{return 0;}
  if cir[1]==1{return 8+(value-1)*4;}
  if cir[1]==2{return cir[11]+(value-1)*4;}
  return 0;
}
fn jj_tra_terminator_last(cir:*i64,value:i64)->i64{
  if cir[1]!=2{return 0;}var blocks:i64=cir[2];var last:i64=0;var bi:i64=0;
  while bi<blocks{
    var bb:i64=12+bi*6;var term:i64=cir[bb+2];
    if term==1{if cir[bb+3]==value{last=cir[bb]+cir[bb+1];}}
    if term==3{if cir[bb+3]==value{last=cir[bb]+cir[bb+1];}}
    if term==4{if cir[bb+3]==value{last=cir[bb]+cir[bb+1];}}
    bi=bi+1;
  }
  return last;
}
fn jj_tra_last_use(cir:*i64,count:i64,value:i64)->i64{
  if value<=0{return 0;}if value>count{return 0;}var last:i64=value;var node:i64=value+1;
  while node<=count{
    var cb:i64=jj_tra_node_base(cir,node);if cb==0{return 0;}var op:i64=cir[cb];
    if op==3{if cir[cb+2]==value{last=node;}}
    else{if op!=1{if op!=2{if cir[cb+2]==value{last=node;}if cir[cb+3]==value{last=node;}}}}
    node=node+1;
  }
  if cir[1]==1{if cir[6]==value{last=count+1;}}
  else{var terminal:i64=jj_tra_terminator_last(cir,value);if terminal>last{last=terminal;}}
  return last;
}
fn jj_tra_crosses_call(cir:*i64,count:i64,value:i64,last:i64)->i64{
  if cir==0{return 0;}if cir[1]!=2{return 0;}if value<=0{return 0;}if last<=value{return 0;}var node:i64=value+1;
  while node<last{if node>count{return 0;}var cb:i64=jj_tra_node_base(cir,node);if cb==0{return 0;}if cir[cb]==3{return 1;}node=node+1;}return 0;
}
fn jj_tra_all_lanes(units:i64)->i64{
  if units<=0{return 0;}if units>32{return 0;}if units==32{return 0xffffffff;}return (1<<units)-1;
}
fn jj_tra_lane_allowed(mask:i64,first:i64,parts:i64)->i64{
  if first<0{return 0;}if parts<=0{return 0;}var p:i64=0;while p<parts{if (mask&(1<<(first+p)))==0{return 0;}p=p+1;}return 1;
}

fn jj_tra_seal(plan:*i64,slots:i64)->i64{
  if plan==0{return 0;}var cap:i64=jj_tra_capacity(slots);if cap<=0{return 0;}
  var count:i64=plan[1];if count<=0{return 0;}if count>cap{return 0;}
  var used:i64=12+count*5;var h:i64=0x4a4a545241534533;var i:i64=0;
  while i<used{if i!=11{h=((h<<7)|(h>>>57))^plan[i]^(i*0x9e37);}i=i+1;}return h;
}
fn jj_tra_fail(plan:*i64,slots:i64)->i64{jj_tra_zero(plan,slots);return 0;}
fn jj_tra_lane_busy(plan:*i64,value:i64,lane:i64)->i64{
  var previous:i64=1;while previous<value{
    var b:i64=12+(previous-1)*5;
    if plan[b+1]==1{if plan[b]>value{var first:i64=plan[b+2];var parts:i64=plan[b+3];if lane>=first{if lane<first+parts{return 1;}}}}
    previous=previous+1;
  }
  return 0;
}
fn jj_tra_find_lanes(plan:*i64,value:i64,units:i64,parts:i64,allowed:i64)->i64{
  if parts<=0{return 0-1;}if parts>units{return 0-1;}if allowed==0{return 0-1;}var first:i64=0;
  while first<=units-parts{
    var ok:i64=jj_tra_lane_allowed(allowed,first,parts);var p:i64=0;while p<parts{if jj_tra_lane_busy(plan,value,first+p)!=0{ok=0;}p=p+1;}
    if ok!=0{return first;}first=first+1;
  }
  return 0-1;
}
fn jj_tra_spill_busy(plan:*i64,value:i64,slot:i64)->i64{
  var previous:i64=1;while previous<value{
    var b:i64=12+(previous-1)*5;
    if plan[b+1]==2{if plan[b+2]==slot{if plan[b]>value{return 1;}}}
    previous=previous+1;
  }
  return 0;
}
fn jj_tra_find_spill(plan:*i64,value:i64,slots:i64)->i64{
  var slot:i64=0;while slot<slots{if jj_tra_spill_busy(plan,value,slot)==0{return slot;}slot=slot+1;}return slots;
}
fn jj_target_allocator_build(cir:*i64,cir_slots:i64,profile:*i64,profile_slots:i64,plan:*i64,plan_slots:i64)->i64{
  if cir==0{return 0;}if profile==0{return 0;}if plan==0{return 0;}
  var capacity:i64=jj_tra_capacity(plan_slots);if capacity<=0{return 0;}
  if jj_tra_nonoverlap(cir,cir_slots,profile,profile_slots)==0{return 0;}
  if jj_tra_nonoverlap(cir,cir_slots,plan,plan_slots)==0{return 0;}
  if jj_tra_nonoverlap(profile,profile_slots,plan,plan_slots)==0{return 0;}
  if jj_tra_zero(plan,plan_slots)==0{return 0;}
  if jj_cir_validate(cir,cir_slots)==0{return 0;}
  if jj_target_profile_validate(profile,profile_slots)==0{return 0;}
  var count:i64=jj_tra_count(cir);if count<=0{return 0;}if count>capacity{return 0;}
  var units:i64=profile[22];if units<=0{return 0;}if units>32{return 0;}
  var parts:i64=jj_target_profile_value_parts(profile,profile_slots,64);if parts<=0{return 0;}if parts>2{return 0;}
  plan[0]=0x4a4a545241504c32;plan[1]=count;plan[2]=profile[2];plan[3]=units;
  plan[6]=jj_tra_result(cir);if plan[6]<0{return jj_tra_fail(plan,plan_slots);}
  plan[7]=cir[7];plan[8]=profile[31];plan[9]=profile[16];
  var value:i64=1;while value<=count{
    var b:i64=12+(value-1)*5;plan[b]=jj_tra_last_use(cir,count,value);
    if plan[b]<value{return jj_tra_fail(plan,plan_slots);}if plan[b]>count+1{return jj_tra_fail(plan,plan_slots);}
    plan[b+3]=parts;plan[b+4]=64;value=value+1;
  }
  var spills:i64=0;var pairs:i64=0;value=1;
  while value<=count{
    var base:i64=12+(value-1)*5;var allowed:i64=jj_tra_all_lanes(units);if jj_tra_crosses_call(cir,count,value,plan[base])!=0{allowed=profile[24]&allowed;}var lane:i64=jj_tra_find_lanes(plan,value,units,parts,allowed);
    if lane>=0{plan[base+1]=1;plan[base+2]=lane;}
    else{var slot:i64=jj_tra_find_spill(plan,value,spills);plan[base+1]=2;plan[base+2]=slot;if slot==spills{spills=spills+1;}}
    if parts==2{pairs=pairs+1;}value=value+1;
  }
  plan[4]=spills;plan[5]=jj_target_profile_align(profile,profile_slots,spills*8);
  if plan[5]<0{return jj_tra_fail(plan,plan_slots);}plan[10]=pairs;plan[11]=jj_tra_seal(plan,plan_slots);
  if plan[11]==0{return jj_tra_fail(plan,plan_slots);}return 1;
}
fn jj_target_allocator_validate(plan:*i64,slots:i64)->i64{
  if plan==0{return 0;}var capacity:i64=jj_tra_capacity(slots);if capacity<=0{return 0;}
  if plan[0]!=0x4a4a545241504c32{return 0;}var count:i64=plan[1];if count<=0{return 0;}if count>capacity{return 0;}
  if plan[2]<5{return 0;}if plan[2]>10{return 0;}if plan[3]<=0{return 0;}if plan[3]>32{return 0;}
  if plan[4]<0{return 0;}if plan[4]>count{return 0;}if plan[5]<0{return 0;}
  if plan[6]<0{return 0;}if plan[6]>count{return 0;}if plan[7]==0{return 0;}if plan[8]==0{return 0;}
  if plan[9]<0{return 0;}if plan[9]>1{return 0;}if plan[10]<0{return 0;}if plan[11]!=jj_tra_seal(plan,slots){return 0;}
  var pairs:i64=0;var value:i64=1;
  while value<=count{
    var b:i64=12+(value-1)*5;var last:i64=plan[b];var kind:i64=plan[b+1];var index:i64=plan[b+2];var parts:i64=plan[b+3];
    if last<value{return 0;}if last>count+1{return 0;}if parts<1{return 0;}if parts>2{return 0;}if plan[b+4]!=64{return 0;}
    if parts==2{pairs=pairs+1;}
    if kind==1{if index<0{return 0;}if index>plan[3]-parts{return 0;}}
    else{if kind==2{if index<0{return 0;}if index>=plan[4]{return 0;}}
    else{return 0;}}
    value=value+1;
  }
  if pairs!=plan[10]{return 0;}
  var slot:i64=0;while slot<plan[4]{var seen:i64=0;value=1;while value<=count{var sb:i64=12+(value-1)*5;if plan[sb+1]==2{if plan[sb+2]==slot{seen=1;}}value=value+1;}if seen==0{return 0;}slot=slot+1;}
  var a:i64=1;while a<=count{
    var ab:i64=12+(a-1)*5;var bv:i64=a+1;while bv<=count{
      var bb:i64=12+(bv-1)*5;
      if bv<plan[ab]{
        if plan[ab+1]==1{if plan[bb+1]==1{var ae:i64=plan[ab+2]+plan[ab+3];var be:i64=plan[bb+2]+plan[bb+3];if plan[ab+2]<be{if plan[bb+2]<ae{return 0;}}}}
        if plan[ab+1]==2{if plan[bb+1]==2{if plan[ab+2]==plan[bb+2]{return 0;}}}
      }
      bv=bv+1;
    }
    a=a+1;
  }
  var i:i64=12+count*5;while i<slots{if plan[i]!=0{return 0;}i=i+1;}return 1;
}
fn jj_target_allocator_validate_for(cir:*i64,cir_slots:i64,profile:*i64,profile_slots:i64,plan:*i64,plan_slots:i64)->i64{
  if jj_target_allocator_validate(plan,plan_slots)==0{return 0;}
  if jj_cir_validate(cir,cir_slots)==0{return 0;}if jj_target_profile_validate(profile,profile_slots)==0{return 0;}
  var count:i64=jj_tra_count(cir);if plan[1]!=count{return 0;}if plan[2]!=profile[2]{return 0;}if plan[3]!=profile[22]{return 0;}
  if plan[6]!=jj_tra_result(cir){return 0;}if plan[7]!=cir[7]{return 0;}if plan[8]!=profile[31]{return 0;}if plan[9]!=profile[16]{return 0;}
  var parts:i64=jj_target_profile_value_parts(profile,profile_slots,64);if parts<=0{return 0;}
  var spills:i64=0;var pairs:i64=0;var value:i64=1;
  while value<=count{
    var b:i64=12+(value-1)*5;if plan[b]!=jj_tra_last_use(cir,count,value){return 0;}if plan[b+3]!=parts{return 0;}if plan[b+4]!=64{return 0;}
    var allowed:i64=jj_tra_all_lanes(profile[22]);if jj_tra_crosses_call(cir,count,value,plan[b])!=0{allowed=profile[24]&allowed;}var lane:i64=jj_tra_find_lanes(plan,value,profile[22],parts,allowed);
    if lane>=0{if plan[b+1]!=1{return 0;}if plan[b+2]!=lane{return 0;}}
    else{var slot:i64=jj_tra_find_spill(plan,value,spills);if plan[b+1]!=2{return 0;}if plan[b+2]!=slot{return 0;}if slot==spills{spills=spills+1;}}
    if parts==2{pairs=pairs+1;}value=value+1;
  }
  if plan[4]!=spills{return 0;}if plan[5]!=jj_target_profile_align(profile,profile_slots,spills*8){return 0;}if plan[10]!=pairs{return 0;}return 1;
}
fn jj_target_allocator_resource_contract(out:*i64,slots:i64)->i64{
  if out==0{return 0;}if slots!=8{return 0;}out[0]=136;out[1]=4096;out[2]=655376;out[3]=2;out[4]=1;out[5]=1;out[6]=1;out[7]=(out as i64)^0x4a4a545241524333;return 1;
}
fn jj_target_allocator_value_kind(plan:*i64,slots:i64,value:i64)->i64{
  if jj_target_allocator_validate(plan,slots)==0{return 0;}if value<=0{return 0;}if value>plan[1]{return 0;}return plan[12+(value-1)*5+1];
}
fn jj_target_allocator_value_index(plan:*i64,slots:i64,value:i64)->i64{
  if jj_target_allocator_validate(plan,slots)==0{return 0-1;}if value<=0{return 0-1;}if value>plan[1]{return 0-1;}return plan[12+(value-1)*5+2];
}
fn jj_target_allocator_spill_count(plan:*i64,slots:i64)->i64{if jj_target_allocator_validate(plan,slots)==0{return 0-1;}return plan[4];}
fn jj_target_allocator_frame_bytes(plan:*i64,slots:i64)->i64{if jj_target_allocator_validate(plan,slots)==0{return 0-1;}return plan[5];}
