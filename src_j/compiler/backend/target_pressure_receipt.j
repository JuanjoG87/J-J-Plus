// Recomputable architecture-independent pressure receipt. It measures the same
// sealed CIR and allocation plan under any canonical TargetProfile without
// publishing physical opcodes or backend-private register names.
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_profile_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_allocator_validate_for(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;

fn jj_pr_slots_bytes(slots:i64)->i64{if slots<=0{return 0;}if slots>0x0fffffffffffffff{return 0;}return slots*8;}
fn jj_pr_nonoverlap(a:*i64,aslots:i64,b:*i64,bslots:i64)->i64{
  if a==0{return 0;}if b==0{return 0;}var an:i64=jj_pr_slots_bytes(aslots);var bn:i64=jj_pr_slots_bytes(bslots);if an==0{return 0;}if bn==0{return 0;}
  var aa:i64=a as i64;var ba:i64=b as i64;if aa<=0{return 0;}if ba<=0{return 0;}
  if aa<ba{if ba-aa<an{return 0;}}else{if aa-ba<bn{return 0;}}return 1;
}
fn jj_pr_zero(receipt:*i64,slots:i64)->i64{if receipt==0{return 0;}if slots!=32{return 0;}var i:i64=0;while i<32{receipt[i]=0;i=i+1;}return 1;}
fn jj_pr_count(cir:*i64)->i64{if cir[1]==1{return cir[2];}if cir[1]==2{return cir[3];}return 0;}
fn jj_pr_node(cir:*i64,value:i64)->i64{if value<=0{return 0;}if cir[1]==1{return 8+(value-1)*4;}if cir[1]==2{return cir[11]+(value-1)*4;}return 0;}
fn jj_pr_plan(cir:*i64,plan:*i64,value:i64)->i64{if value<=0{return 0;}if value>jj_pr_count(cir){return 0;}return 12+(value-1)*5;}
fn jj_pr_spilled(cir:*i64,plan:*i64,value:i64)->i64{var b:i64=jj_pr_plan(cir,plan,value);if b==0{return 0;}if plan[b+1]==2{return 1;}return 0;}
fn jj_pr_crosses_call(cir:*i64,plan:*i64,value:i64)->i64{
  if cir[1]!=2{return 0;}var b:i64=jj_pr_plan(cir,plan,value);if b==0{return 0;}var last:i64=plan[b];if last<=value{return 0;}var node:i64=value+1;
  while node<last{var nb:i64=jj_pr_node(cir,node);if nb==0{return 0;}if cir[nb]==3{return 1;}node=node+1;}return 0;
}
fn jj_pr_calls(cir:*i64)->i64{
  if cir[1]!=2{return 0;}var count:i64=cir[3];var calls:i64=0;var value:i64=1;while value<=count{var nb:i64=jj_pr_node(cir,value);if cir[nb]==3{calls=calls+1;}value=value+1;}
  var bi:i64=0;while bi<cir[2]{if cir[12+bi*6+2]==4{calls=calls+1;}bi=bi+1;}return calls;
}
fn jj_pr_branches(cir:*i64)->i64{
  if cir[1]!=2{return 0;}var branches:i64=0;var bi:i64=0;while bi<cir[2]{var term:i64=cir[12+bi*6+2];if term==2{branches=branches+1;}if term==3{branches=branches+1;}bi=bi+1;}return branches;
}
fn jj_pr_use_load(cir:*i64,plan:*i64,value:i64)->i64{if value<=0{return 0;}return jj_pr_spilled(cir,plan,value);}
fn jj_pr_loads(cir:*i64,plan:*i64)->i64{
  var count:i64=jj_pr_count(cir);var loads:i64=0;var value:i64=1;
  while value<=count{var nb:i64=jj_pr_node(cir,value);var op:i64=cir[nb];if op==3{loads=loads+jj_pr_use_load(cir,plan,cir[nb+2]);}
    else{if op!=1{if op!=2{loads=loads+jj_pr_use_load(cir,plan,cir[nb+2]);loads=loads+jj_pr_use_load(cir,plan,cir[nb+3]);}}}value=value+1;}
  if cir[1]==1{loads=loads+jj_pr_use_load(cir,plan,cir[6]);}
  else{var bi:i64=0;while bi<cir[2]{var bb:i64=12+bi*6;var term:i64=cir[bb+2];if term==1{loads=loads+jj_pr_use_load(cir,plan,cir[bb+3]);}if term==3{loads=loads+jj_pr_use_load(cir,plan,cir[bb+3]);}if term==4{loads=loads+jj_pr_use_load(cir,plan,cir[bb+3]);}bi=bi+1;}}
  return loads;
}
fn jj_pr_seal(receipt:*i64)->i64{if receipt==0{return 0;}var h:i64=0x4a4a505245535331;var i:i64=0;while i<31{h=((h<<7)|(h>>>57))^receipt[i]^(i*0x9e3779b1);i=i+1;}if h==0{h=0x4a4a505245535331;}return h;}
fn jj_pr_peak(cir:*i64,plan:*i64,out:*i64,slots:i64)->i64{
  if cir==0{return 0;}if plan==0{return 0;}if out==0{return 0;}if slots!=3{return 0;}out[0]=0;out[1]=0;out[2]=0;var count:i64=jj_pr_count(cir);var position:i64=1;
  while position<=count{var live_values:i64=0;var live_lanes:i64=0;var value:i64=1;while value<=position{var b:i64=jj_pr_plan(cir,plan,value);if plan[b]>position{live_values=live_values+1;live_lanes=live_lanes+plan[b+3];}value=value+1;}
    if live_lanes>out[1]{out[0]=live_values;out[1]=live_lanes;out[2]=position;}else{if live_lanes==out[1]{if live_values>out[0]{out[0]=live_values;out[2]=position;}}}position=position+1;}return 1;
}
fn jj_pr_assignments(cir:*i64,plan:*i64,out:*i64,slots:i64)->i64{
  if cir==0{return 0;}if plan==0{return 0;}if out==0{return 0;}if slots!=6{return 0;}var i:i64=0;while i<6{out[i]=0;i=i+1;}var count:i64=jj_pr_count(cir);var value:i64=1;
  while value<=count{var pb:i64=jj_pr_plan(cir,plan,value);if plan[pb+1]==1{out[0]=out[0]+1;if cir[jj_pr_node(cir,value)]==1{if plan[pb+2]!=0{out[5]=out[5]+1;}}}
    else{out[1]=out[1]+1;if plan[pb]>value{out[2]=out[2]+1;}}
    if jj_pr_crosses_call(cir,plan,value)!=0{out[3]=out[3]+1;if plan[pb+1]==2{out[4]=out[4]+1;}}value=value+1;}return 1;
}
fn jj_pr_fill_identity(receipt:*i64,cir:*i64,profile:*i64,plan:*i64)->i64{
  if receipt==0{return 0;}if cir==0{return 0;}if profile==0{return 0;}if plan==0{return 0;}receipt[0]=0x4a4a505245535331;receipt[1]=1;receipt[2]=profile[2];receipt[3]=profile[31];receipt[4]=cir[7];receipt[5]=jj_pr_count(cir);receipt[6]=profile[22];receipt[7]=plan[15];receipt[24]=cir[1];receipt[25]=profile[16];receipt[26]=profile[4];receipt[27]=profile[12];receipt[28]=plan[10];receipt[29]=plan[8];return 1;
}
fn jj_pr_fill_pressure(receipt:*i64,peak:*i64,assign:*i64,loads:i64,plan:*i64,profile:*i64)->i64{
  if receipt==0{return 0;}if peak==0{return 0;}if assign==0{return 0;}if plan==0{return 0;}if profile==0{return 0;}var excess:i64=0;if peak[1]>profile[22]{excess=peak[1]-profile[22];}
  receipt[8]=peak[0];receipt[9]=peak[1];receipt[10]=assign[0];receipt[11]=assign[1];receipt[12]=plan[4];receipt[13]=plan[5];receipt[14]=assign[3];receipt[15]=assign[4];receipt[18]=loads;receipt[19]=assign[2];receipt[20]=assign[5];receipt[21]=peak[2];receipt[22]=excess;return excess;
}
fn jj_pr_fill_events(receipt:*i64,cir:*i64,plan:*i64,excess:i64)->i64{
  if receipt==0{return 0;}if cir==0{return 0;}if plan==0{return 0;}if excess<0{return 0;}receipt[16]=jj_pr_calls(cir);receipt[17]=jj_pr_branches(cir);receipt[23]=receipt[11]*100+receipt[18]*16+receipt[19]*12+receipt[20]*2+(plan[5]/8)*4+excess*20;receipt[30]=0;receipt[31]=jj_pr_seal(receipt);if receipt[31]==0{return 0;}return 1;
}
fn jj_target_pressure_receipt_context_seal(context:*i64)->i64{
  if context==0{return 0;}var h:i64=(context as i64)^0x4a4a5052434f4e31;var i:i64=0;while i<8{h=((h<<9)|(h>>>55))^context[i]^(i*0x9e37);i=i+1;}if h==0{h=0x4a4a5052434f4e31;}return h;
}
fn jj_pr_context_valid(context:*i64)->i64{
  if context==0{return 0;}if context[0]==0{return 0;}if context[1]<=0{return 0;}if context[2]==0{return 0;}if context[3]!=32{return 0;}if context[4]==0{return 0;}if context[5]<17{return 0;}if context[6]==0{return 0;}if context[7]!=32{return 0;}if context[8]!=jj_target_pressure_receipt_context_seal(context){return 0;}return 1;
}
fn jj_target_pressure_receipt_build(context:*i64)->i64{
  if jj_pr_context_valid(context)==0{return 0;}var cir:*i64=context[0] as *i64;var cir_slots:i64=context[1];var profile:*i64=context[2] as *i64;var profile_slots:i64=context[3];var plan:*i64=context[4] as *i64;var plan_slots:i64=context[5];var receipt:*i64=context[6] as *i64;
  if jj_pr_nonoverlap(cir,cir_slots,profile,profile_slots)==0{return 0;}if jj_pr_nonoverlap(cir,cir_slots,plan,plan_slots)==0{return 0;}if jj_pr_nonoverlap(cir,cir_slots,receipt,32)==0{return 0;}
  if jj_pr_nonoverlap(profile,profile_slots,plan,plan_slots)==0{return 0;}if jj_pr_nonoverlap(profile,profile_slots,receipt,32)==0{return 0;}if jj_pr_nonoverlap(plan,plan_slots,receipt,32)==0{return 0;}
  if jj_pr_nonoverlap(context,9,cir,cir_slots)==0{return 0;}if jj_pr_nonoverlap(context,9,profile,profile_slots)==0{return 0;}if jj_pr_nonoverlap(context,9,plan,plan_slots)==0{return 0;}if jj_pr_nonoverlap(context,9,receipt,32)==0{return 0;}
  if jj_pr_zero(receipt,32)==0{return 0;}if jj_cir_validate(cir,cir_slots)==0{return 0;}if jj_target_profile_validate(profile,profile_slots)==0{return 0;}
  if jj_target_allocator_validate_for(cir,cir_slots,profile,profile_slots,plan,plan_slots)==0{return 0;}var peak:[3]i64;var assign:[6]i64;
  if jj_pr_peak(cir,plan,peak as *i64,3)==0{return 0;}if jj_pr_assignments(cir,plan,assign as *i64,6)==0{return 0;}var loads:i64=jj_pr_loads(cir,plan);
  if jj_pr_fill_identity(receipt,cir,profile,plan)==0{return 0;}var excess:i64=jj_pr_fill_pressure(receipt,peak as *i64,assign as *i64,loads,plan,profile);if excess<0{return 0;}
  if jj_pr_fill_events(receipt,cir,plan,excess)==0{jj_pr_zero(receipt,32);return 0;}return 1;
}
fn jj_target_pressure_receipt_validate(receipt:*i64,slots:i64)->i64{
  if receipt==0{return 0;}if slots!=32{return 0;}if receipt[0]!=0x4a4a505245535331{return 0;}if receipt[1]!=1{return 0;}if receipt[2]<5{return 0;}if receipt[2]>10{return 0;}
  if receipt[3]==0{return 0;}if receipt[4]==0{return 0;}if receipt[5]<=0{return 0;}if receipt[6]<=0{return 0;}if receipt[7]<=0{return 0;}if receipt[7]>2{return 0;}
  var i:i64=8;while i<=23{if receipt[i]<0{return 0;}i=i+1;}if receipt[24]<1{return 0;}if receipt[24]>2{return 0;}if receipt[25]<0{return 0;}if receipt[25]>1{return 0;}
  if receipt[26]!=32{if receipt[26]!=64{return 0;}}if receipt[27]<=0{return 0;}if receipt[28]<0{return 0;}if receipt[29]==0{return 0;}if receipt[30]!=0{return 0;}
  if receipt[10]+receipt[11]!=receipt[5]{return 0;}if receipt[12]>receipt[11]{return 0;}if receipt[15]>receipt[14]{return 0;}if receipt[22]>receipt[9]{return 0;}
  if receipt[31]!=jj_pr_seal(receipt){return 0;}return 1;
}
fn jj_target_pressure_receipt_validate_for(context:*i64)->i64{
  if jj_pr_context_valid(context)==0{return 0;}var receipt:*i64=context[6] as *i64;if jj_target_pressure_receipt_validate(receipt,32)==0{return 0;}var expected:[32]i64;var copy:[9]i64;var i:i64=0;while i<8{copy[i]=context[i];i=i+1;}copy[6]=expected as i64;copy[8]=jj_target_pressure_receipt_context_seal(copy as *i64);if jj_target_pressure_receipt_build(copy as *i64)==0{return 0;}
  i=0;while i<32{if receipt[i]!=expected[i]{return 0;}i=i+1;}return 1;
}
fn jj_target_pressure_receipt_resource_contract(out:*i64,slots:i64)->i64{if out==0{return 0;}if slots!=8{return 0;}out[0]=256;out[1]=256;out[2]=0;out[3]=2;out[4]=1;out[5]=1;out[6]=1;out[7]=(out as i64)^0x4a4a505245535243;return 1;}
