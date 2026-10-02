// Differential pressure matrix and Pareto admission. IA-32 is the adversarial
// profile: it must improve strictly while x86-64, AArch64, ARM32, RV64 and
// RV32 may not regress in structural pressure, spill traffic or weighted cost.
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_profile_build(p0:i64,p1:*i64,p2:i64)->i64;
extern fn jj_target_allocator_build(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_target_allocator_resource_contract(p0:*i64,p1:i64)->i64;
extern fn jj_target_pressure_receipt_context_seal(p0:*i64)->i64;
extern fn jj_target_pressure_receipt_build(p0:*i64)->i64;
extern fn jj_target_pressure_receipt_validate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_pressure_schedule(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_cir_bounded_equivalence(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_stress_baseline_memory_bytes()->i64;
extern fn jj_stress_min_optimizer_working_set()->i64;
extern fn jj_host_resource_policy_build(p0:i64,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_host_resource_policy_validate(p0:*i64,p1:i64)->i64;

fn jj_pp_bytes(slots:i64)->i64{if slots<=0{return 0;}if slots>0x0fffffffffffffff{return 0;}return slots*8;}
fn jj_pp_nonoverlap(a:*i64,aslots:i64,b:*i64,bslots:i64)->i64{if a==0{return 0;}if b==0{return 0;}var an:i64=jj_pp_bytes(aslots);var bn:i64=jj_pp_bytes(bslots);if an==0{return 0;}if bn==0{return 0;}var aa:i64=a as i64;var ba:i64=b as i64;if aa<=0{return 0;}if ba<=0{return 0;}if aa<ba{if ba-aa<an{return 0;}}else{if aa-ba<bn{return 0;}}return 1;}
fn jj_pp_zero(out:*i64,slots:i64)->i64{if out==0{return 0;}if slots<=0{return 0;}var i:i64=0;while i<slots{out[i]=0;i=i+1;}return 1;}
fn jj_pp_equal(a:*i64,b:*i64,slots:i64)->i64{if a==0{return 0;}if b==0{return 0;}if slots<=0{return 0;}var i:i64=0;while i<slots{if a[i]!=b[i]{return 0;}i=i+1;}return 1;}
fn jj_pp_count(cir:*i64)->i64{if cir[1]==1{return cir[2];}if cir[1]==2{return cir[3];}return 0;}
fn jj_target_pressure_matrix_build(cir:*i64,cir_slots:i64,out:*i64,out_slots:i64,workspace:*i64,workspace_slots:i64)->i64{
  if cir==0{return 0;}if out==0{return 0;}if workspace==0{return 0;}if out_slots!=192{return 0;}if jj_cir_validate(cir,cir_slots)==0{return 0;}var count:i64=jj_pp_count(cir);if count<=0{return 0;}
  if count>(0x7fffffffffffffff-44)/5{return 0;}var plan_slots:i64=12+count*5;if plan_slots<17{plan_slots=17;}var need:i64=32+plan_slots;if workspace_slots<need{return 0;}
  if jj_pp_nonoverlap(cir,cir_slots,out,out_slots)==0{return 0;}if jj_pp_nonoverlap(cir,cir_slots,workspace,workspace_slots)==0{return 0;}if jj_pp_nonoverlap(out,out_slots,workspace,workspace_slots)==0{return 0;}
  if jj_pp_zero(out,out_slots)==0{return 0;}var profile:*i64=workspace;var plan:*i64=((workspace as i64)+32*8) as *i64;var kind:i64=5;
  while kind<=10{if jj_target_profile_build(kind,profile,32)==0{return 0;}if jj_target_allocator_build(cir,cir_slots,profile,32,plan,plan_slots)==0{return 0;}
    var rc:[9]i64;rc[0]=cir as i64;rc[1]=cir_slots;rc[2]=profile as i64;rc[3]=32;rc[4]=plan as i64;rc[5]=plan_slots;rc[6]=(out as i64)+(kind-5)*32*8;rc[7]=32;rc[8]=jj_target_pressure_receipt_context_seal(rc as *i64);if jj_target_pressure_receipt_build(rc as *i64)==0{return 0;}kind=kind+1;}return 1;
}
// A target-neutral transform may use the canonical non-oracle targets as a
// no-regression Pareto frontier. The IA-32/i386 receipt is still sealed and
// validated, but it is pressure evidence only: it cannot veto or be required
// to improve. Target-specific lowering remains free to optimize its own target.
fn jj_pressure_pareto_compare(before:*i64,before_slots:i64,after:*i64,after_slots:i64)->i64{
  if before==0{return 0;}if after==0{return 0;}if before_slots!=192{return 0;}if after_slots!=192{return 0;}if jj_pp_nonoverlap(before,before_slots,after,after_slots)==0{return 0;}var strict_primary:i64=0;var index:i64=0;
  while index<6{var b:*i64=((before as i64)+index*32*8) as *i64;var a:*i64=((after as i64)+index*32*8) as *i64;if jj_target_pressure_receipt_validate(b,32)==0{return 0;}if jj_target_pressure_receipt_validate(a,32)==0{return 0;}
    if b[2]!=5+index{return 0;}if a[2]!=b[2]{return 0;}
    if b[2]!=8{
      if a[5]>b[5]{return 0;}if a[8]>b[8]{return 0;}if a[9]>b[9]{return 0;}if a[11]>b[11]{return 0;}
      if a[12]>b[12]{return 0;}if a[13]>b[13]{return 0;}if a[14]>b[14]{return 0;}if a[15]>b[15]{return 0;}if a[16]>b[16]{return 0;}if a[17]>b[17]{return 0;}
      if a[18]>b[18]{return 0;}if a[19]>b[19]{return 0;}if a[20]>b[20]{return 0;}if a[22]>b[22]{return 0;}if a[23]>b[23]{return 0;}
      if a[5]<b[5]{strict_primary=1;}if a[8]<b[8]{strict_primary=1;}if a[9]<b[9]{strict_primary=1;}if a[11]<b[11]{strict_primary=1;}
      if a[12]<b[12]{strict_primary=1;}if a[13]<b[13]{strict_primary=1;}if a[14]<b[14]{strict_primary=1;}if a[15]<b[15]{strict_primary=1;}
      if a[16]<b[16]{strict_primary=1;}if a[17]<b[17]{strict_primary=1;}if a[18]<b[18]{strict_primary=1;}if a[19]<b[19]{strict_primary=1;}
      if a[20]<b[20]{strict_primary=1;}if a[22]<b[22]{strict_primary=1;}if a[23]<b[23]{strict_primary=1;}
    }
    index=index+1;}
  if strict_primary==0{return 0;}return 1;
}
fn jj_pressure_pareto_context_seal(context:*i64)->i64{if context==0{return 0;}var h:i64=(context as i64)^0x4a4a5050434f4e31;var i:i64=0;while i<8{h=((h<<9)|(h>>>55))^context[i]^(i*0x9e37);i=i+1;}if h==0{h=0x4a4a5050434f4e31;}return h;}
fn jj_pressure_pareto_for(context:*i64)->i64{
  if context==0{return 0;}if context[0]==0{return 0;}if context[1]<=0{return 0;}if context[2]==0{return 0;}if context[3]<=0{return 0;}if context[4]==0{return 0;}if context[5]==0{return 0;}if context[6]==0{return 0;}if context[7]<=0{return 0;}if context[8]!=jj_pressure_pareto_context_seal(context){return 0;}
  var before_cir:*i64=context[0] as *i64;var after_cir:*i64=context[2] as *i64;var before:*i64=context[4] as *i64;var after:*i64=context[5] as *i64;var workspace:*i64=context[6] as *i64;
  if jj_pp_nonoverlap(context,9,before_cir,context[1])==0{return 0;}if jj_pp_nonoverlap(context,9,after_cir,context[3])==0{return 0;}if jj_pp_nonoverlap(context,9,before,192)==0{return 0;}if jj_pp_nonoverlap(context,9,after,192)==0{return 0;}if jj_pp_nonoverlap(context,9,workspace,context[7])==0{return 0;}
  if jj_pp_nonoverlap(before_cir,context[1],after_cir,context[3])==0{return 0;}if jj_pp_nonoverlap(before_cir,context[1],before,192)==0{return 0;}if jj_pp_nonoverlap(before_cir,context[1],after,192)==0{return 0;}if jj_pp_nonoverlap(before_cir,context[1],workspace,context[7])==0{return 0;}
  if jj_pp_nonoverlap(after_cir,context[3],before,192)==0{return 0;}if jj_pp_nonoverlap(after_cir,context[3],after,192)==0{return 0;}if jj_pp_nonoverlap(after_cir,context[3],workspace,context[7])==0{return 0;}if jj_pp_nonoverlap(before,192,after,192)==0{return 0;}if jj_pp_nonoverlap(before,192,workspace,context[7])==0{return 0;}if jj_pp_nonoverlap(after,192,workspace,context[7])==0{return 0;}
  var bc:i64=jj_pp_count(before_cir);var ac:i64=jj_pp_count(after_cir);if bc<=0{return 0;}if ac<=0{return 0;}if bc>(0x7fffffffffffffff/5)-1{return 0;}var schedule_need:i64=(bc+1)*5;if context[3]>0x7fffffffffffffff-schedule_need{return 0;}var semantic_need:i64=context[3]+schedule_need;var max:i64=bc;if ac>max{max=ac;}if max>(0x7fffffffffffffff-44)/5{return 0;}var matrix_need:i64=44+max*5;var need:i64=semantic_need;if matrix_need>need{need=matrix_need;}if context[7]<need{return 0;}
  var shadow:*i64=workspace;var schedule_workspace:*i64=((workspace as i64)+context[3]*8) as *i64;if jj_cir_pressure_schedule(before_cir,context[1],shadow,context[3],schedule_workspace,schedule_need)==0{return 0;}if jj_pp_equal(shadow,after_cir,context[3])==0{return 0;}
  if jj_target_pressure_matrix_build(before_cir,context[1],before,192,workspace,context[7])==0{return 0;}if jj_target_pressure_matrix_build(after_cir,context[3],after,192,workspace,context[7])==0{return 0;}return jj_pressure_pareto_compare(before,192,after,192);
}
fn jj_cir_pressure_optimize_pareto(input:*i64,input_slots:i64,output:*i64,output_slots:i64,workspace:*i64,workspace_slots:i64)->i64{
  if input==0{return 0;}if output==0{return 0;}if workspace==0{return 0;}if jj_cir_validate(input,input_slots)==0{return 0;}if input[1]!=1{return 0;}var count:i64=input[2];if count<=0{return 0;}
  if count>(0x7fffffffffffffff-44)/5{return 0;}if count>(0x7fffffffffffffff/5)-1{return 0;}if count>(0x7fffffffffffffff/3)-1{return 0;}var stride:i64=count+1;var schedule_need:i64=stride*5;var algebraic_need:i64=stride*3;
  if output_slots>0x7fffffffffffffff-algebraic_need{return 0;}var bounded_need:i64=output_slots+algebraic_need;if bounded_need>0x7fffffffffffffff-schedule_need{return 0;}bounded_need=bounded_need+schedule_need;
  if output_slots>0x7fffffffffffffff-schedule_need{return 0;}var semantic_need:i64=output_slots+schedule_need;var matrix_need:i64=44+count*5;var need:i64=bounded_need;if semantic_need>need{need=semantic_need;}if matrix_need>need{need=matrix_need;}if workspace_slots<need{return 0;}
  if jj_pp_nonoverlap(input,input_slots,output,output_slots)==0{return 0;}if jj_pp_nonoverlap(input,input_slots,workspace,workspace_slots)==0{return 0;}if jj_pp_nonoverlap(output,output_slots,workspace,workspace_slots)==0{return 0;}
  var candidate:*i64=workspace;var algebraic_workspace:*i64=((workspace as i64)+output_slots*8) as *i64;var schedule_workspace:*i64=((algebraic_workspace as i64)+algebraic_need*8) as *i64;
  if jj_cir_bounded_equivalence(input,input_slots,candidate,output_slots,algebraic_workspace,algebraic_need)!=0{if jj_cir_pressure_schedule(candidate,output_slots,output,output_slots,schedule_workspace,schedule_need)!=0{if output[2]<count{var bounded_before:[192]i64;var bounded_after:[192]i64;if jj_target_pressure_matrix_build(input,input_slots,bounded_before as *i64,192,workspace,workspace_slots)!=0{if jj_target_pressure_matrix_build(output,output_slots,bounded_after as *i64,192,workspace,workspace_slots)!=0{if jj_pressure_pareto_compare(bounded_before as *i64,192,bounded_after as *i64,192)!=0{return 1;}}}}}}
  if jj_pp_zero(output,output_slots)==0{return 0;}if jj_cir_pressure_schedule(input,input_slots,output,output_slots,workspace,schedule_need)==0{jj_pp_zero(output,output_slots);return 0;}var before:[192]i64;var after:[192]i64;
  var pc:[9]i64;pc[0]=input as i64;pc[1]=input_slots;pc[2]=output as i64;pc[3]=output_slots;pc[4]=before as i64;pc[5]=after as i64;pc[6]=workspace as i64;pc[7]=workspace_slots;pc[8]=jj_pressure_pareto_context_seal(pc as *i64);if jj_pressure_pareto_for(pc as *i64)==0{jj_pp_zero(output,output_slots);return 0;}return 1;
}
fn jj_target_pressure_pareto_resource_contract(out:*i64,slots:i64)->i64{if out==0{return 0;}if slots!=8{return 0;}out[0]=1536;out[1]=jj_stress_baseline_memory_bytes();out[2]=1048576;out[3]=6;out[4]=1;out[5]=1;out[6]=0;out[7]=(out as i64)^0x4a4a505041524554;return 1;}
fn jj_ia32_stress_model_seal(model:*i64)->i64{if model==0{return 0;}var h:i64=0x4a4a493338535431;var i:i64=0;while i<15{h=((h<<7)|(h>>>57))^model[i]^(i*0x9e3779b1);i=i+1;}if h==0{h=0x4a4a493338535431;}return h;}
fn jj_ia32_stress_model_build(model:*i64,slots:i64)->i64{if model==0{return 0;}if slots!=16{return 0;}var baseline:i64=jj_stress_baseline_memory_bytes();var minimum:i64=jj_stress_min_optimizer_working_set();if baseline<=minimum{return 0;}var i:i64=0;while i<16{model[i]=0;i=i+1;}model[0]=0x4a4a493338535431;model[1]=2;model[2]=8;model[3]=baseline;model[4]=524288;model[5]=524288;model[6]=1048576;model[7]=3072;model[8]=minimum;model[9]=baseline-minimum;model[10]=655376;model[11]=16382;model[12]=4;model[13]=32;model[14]=7;model[15]=jj_ia32_stress_model_seal(model);return 1;}
fn jj_ia32_stress_model_validate(model:*i64,slots:i64)->i64{if model==0{return 0;}if slots!=16{return 0;}if model[0]!=0x4a4a493338535431{return 0;}if model[1]!=2{return 0;}if model[2]!=8{return 0;}if model[3]!=jj_stress_baseline_memory_bytes(){return 0;}if model[4]!=524288{return 0;}if model[5]!=524288{return 0;}if model[6]!=1048576{return 0;}if model[7]!=3072{return 0;}if model[8]!=model[4]+model[5]+model[6]+model[7]{return 0;}if model[8]!=jj_stress_min_optimizer_working_set(){return 0;}if model[9]!=model[3]-model[8]{return 0;}if model[10]!=655376{return 0;}if model[11]!=16382{return 0;}if model[12]!=4{return 0;}if model[13]!=32{return 0;}if model[14]!=7{return 0;}if model[15]!=jj_ia32_stress_model_seal(model){return 0;}return 1;}
fn jj_ia32_stress_model_contract(model:*i64,slots:i64)->i64{if jj_ia32_stress_model_build(model,slots)==0{return 0;}var profile:[32]i64;var pressure:[8]i64;var allocator:[8]i64;if jj_target_profile_build(8,profile as *i64,32)==0{return 0;}if profile[4]!=32{return 0;}if profile[6]!=32{return 0;}if profile[12]!=4{return 0;}if profile[16]!=0{return 0;}if profile[17]!=0{return 0;}if profile[18]!=32{return 0;}if profile[19]!=1{return 0;}if profile[22]!=4{return 0;}if profile[23]!=8{return 0;}if profile[24]!=7{return 0;}if jj_target_pressure_pareto_resource_contract(pressure as *i64,8)==0{return 0;}if pressure[0]!=1536{return 0;}if pressure[1]!=model[3]{return 0;}if pressure[2]!=1048576{return 0;}if pressure[3]!=6{return 0;}if pressure[4]!=1{return 0;}if pressure[5]!=1{return 0;}if pressure[6]!=0{return 0;}if jj_target_allocator_resource_contract(allocator as *i64,8)==0{return 0;}if allocator[2]!=model[10]{return 0;}var small:[20]i64;var large:[20]i64;if jj_host_resource_policy_build(4194304,1,small as *i64,20)==0{return 0;}if jj_host_resource_policy_build(34359738368,16,large as *i64,20)==0{return 0;}if jj_host_resource_policy_validate(small as *i64,20)==0{return 0;}if jj_host_resource_policy_validate(large as *i64,20)==0{return 0;}if small[2]>=model[3]{return 0;}if large[7]<=model[3]{return 0;}if large[8]<=small[8]{return 0;}return jj_ia32_stress_model_validate(model,slots);}
