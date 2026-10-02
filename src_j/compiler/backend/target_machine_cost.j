// jj_file: src_j/compiler/backend/target_machine_cost.j
// R763 target-parametric branch/select cost authority.
// Facts: bits 0..7 true-arm work, 8..15 false-arm work, 16..23 extra live values,
// bit24 predictable, bit25 loop-hot, bit26 pure arms, bit27 same destination,
// bits28..29 probability direction: 0 unknown, 1 true-likely, 2 false-likely,
// 3 measured-balanced. Choice: 0 branch, 1 x86-64 CMOV, 2 AArch64 CSEL.
fn jj_tmc_select_kind(target:i64)->i64{if target==5{return 1;}if target==6{return 2;}return 0;}
fn jj_tmc_register_budget(target:i64)->i64{if target==5{return 8;}if target==6{return 12;}if target==7{return 6;}if target==8{return 4;}if target==9{return 8;}if target==10{return 8;}return 0;}
fn jj_tmc_mispredict_cost(target:i64)->i64{if target==5{return 14;}if target==6{return 10;}if target==7{return 8;}if target==8{return 6;}if target==9{return 8;}if target==10{return 8;}return 0;}
fn jj_tmc_select_cost(target:i64)->i64{if target==5{return 2;}if target==6{return 1;}return 0;}
fn jj_tmc_fact(facts:i64,shift:i64)->i64{return (facts>>>shift)&255;}
fn jj_tmc_probability_valid(facts:i64)->i64{var predictable:i64=(facts>>>24)&1;var direction:i64=(facts>>>28)&3;if predictable!=0{if direction==1{return 1;}if direction==2{return 1;}return 0;}if direction==1{return 0;}if direction==2{return 0;}return 1;}
fn jj_tmc_valid(target:i64,facts:i64)->i64{if target<5{return 0;}if target>10{return 0;}var tw:i64=jj_tmc_fact(facts,0);var fw:i64=jj_tmc_fact(facts,8);var live:i64=jj_tmc_fact(facts,16);if tw<=0{return 0;}if fw<=0{return 0;}if tw>63{return 0;}if fw>63{return 0;}if live>63{return 0;}if jj_tmc_register_budget(target)<=0{return 0;}if jj_tmc_probability_valid(facts)==0{return 0;}return 1;}
fn jj_tmc_branch_path(facts:i64)->i64{var tw:i64=jj_tmc_fact(facts,0);var fw:i64=jj_tmc_fact(facts,8);var direction:i64=(facts>>>28)&3;if direction==1{return (tw*7+fw+4)/8;}if direction==2{return (tw+fw*7+4)/8;}return (tw+fw+1)/2;}
fn jj_target_branch_cost(target:i64,facts:i64)->i64{
 if jj_tmc_valid(target,facts)==0{return 0-1;}var tw:i64=jj_tmc_fact(facts,0);var fw:i64=jj_tmc_fact(facts,8);var predictable:i64=(facts>>>24)&1;var hot:i64=(facts>>>25)&1;var path:i64=jj_tmc_branch_path(facts);var runtime:i64=2+path;if predictable==0{runtime=runtime+jj_tmc_mispredict_cost(target);}else{runtime=runtime+(jj_tmc_mispredict_cost(target)+7)/8;}var frequency:i64=1;if hot!=0{frequency=16;}var size:i64=8+tw+fw;if predictable!=0{size=size-4;}return runtime*frequency+size;
}
fn jj_target_select_cost(target:i64,facts:i64)->i64{
 if jj_tmc_valid(target,facts)==0{return 0-1;}var kind:i64=jj_tmc_select_kind(target);if kind==0{return 0-1;}if ((facts>>>26)&1)==0{return 0-1;}if ((facts>>>27)&1)==0{return 0-1;}var tw:i64=jj_tmc_fact(facts,0);var fw:i64=jj_tmc_fact(facts,8);var live:i64=jj_tmc_fact(facts,16);var budget:i64=jj_tmc_register_budget(target);if live+2>budget{return 0-1;}var hot:i64=(facts>>>25)&1;var frequency:i64=1;if hot!=0{frequency=16;}var runtime:i64=1+tw+fw+jj_tmc_select_cost(target);var size:i64=4+tw+fw;var pressure:i64=live;if budget<=4{pressure=pressure*4;}return runtime*frequency+size+pressure;
}
fn jj_target_ifc_choice(target:i64,facts:i64)->i64{var branch:i64=jj_target_branch_cost(target,facts);if branch<0{return 0;}var select:i64=jj_target_select_cost(target,facts);if select<0{return 0;}if select>=branch{return 0;}return jj_tmc_select_kind(target);}
fn jj_target_machine_cost_resource_contract(out:*i64,slots:i64)->i64{if out==0{return 0;}if slots!=8{return 0;}out[0]=0;out[1]=2;out[2]=0;out[3]=0;out[4]=0;out[5]=0;out[6]=0;out[7]=(out as i64)^0x4a4a544d434f5354;return 1;}
