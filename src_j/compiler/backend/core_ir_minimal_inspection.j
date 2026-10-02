// on-demand inspection companion; excluded from resident selfhost closures.
extern fn jj_cir_slots_valid(p0:i64)->i64;
extern fn jj_cir_build_fail(p0:*i64,p1:i64)->i64;

fn jj_cir_function_set_branch(cir:*i64,slots:i64,block:i64,target:i64)->i64{
  if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return jj_cir_build_fail(cir,slots);}
  if cir[1]!=2{return jj_cir_build_fail(cir,slots);}if cir[7]!=0{return jj_cir_build_fail(cir,slots);}
  if block<=0{return jj_cir_build_fail(cir,slots);}if block>cir[2]{return jj_cir_build_fail(cir,slots);}if target<=block{return jj_cir_build_fail(cir,slots);}if target>cir[2]{return jj_cir_build_fail(cir,slots);}
  var bb:i64=12+(block-1)*6;if cir[bb+1]<=0{return jj_cir_build_fail(cir,slots);}if cir[bb+2]!=0{return jj_cir_build_fail(cir,slots);}cir[bb+2]=2;cir[bb+4]=target-1;return 1;
}
