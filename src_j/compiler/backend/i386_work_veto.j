// R766 target-neutral transform admission plus i386 pressure observation.
// i386 is an adversarial cost oracle only. It may report pressure, but its
// answer is not a legality gate and is not consumed by canonical transforms.
fn jj_work_metrics_valid(values:*i64)->i64{
 if values==0{return 0;}var i:i64=0;while i<6{if values[i]<0{return 0;}i=i+1;}return 1;
}
// [nodes, peak_live, spills, stack_ops, code_bytes, calls]
// Admit target-independent work elimination. Register pressure and code size
// remain target decisions and therefore are not global vetoes here.
fn jj_transform_work_admit(before:*i64,after:*i64)->i64{
 if jj_work_metrics_valid(before)==0{return 0;}if jj_work_metrics_valid(after)==0{return 0;}
 var bw:i64=before[0]+before[2]*4+before[3]*2+before[5]*8;
 var aw:i64=after[0]+after[2]*4+after[3]*2+after[5]*8;
 if aw>=bw{return 0;}return 1;
}
// Strict 80386 pressure report retained as an oracle. A zero result means
// "pressured on i386", never "illegal for every target".
fn jj_i386_pressure_oracle(before:*i64,after:*i64)->i64{
 if jj_work_metrics_valid(before)==0{return 0;}if jj_work_metrics_valid(after)==0{return 0;}
 if after[0]>=before[0]{return 0;}if after[1]>before[1]{return 0;}if after[2]>before[2]{return 0;}
 if after[3]>before[3]{return 0;}if after[5]>before[5]{return 0;}
 var bw:i64=before[0]+before[2]*8+before[3]*3+before[5]*12;
 var aw:i64=after[0]+after[2]*8+after[3]*3+after[5]*12;
 if aw>=bw{return 0;}if after[4]>before[4]+8{return 0;}return 1;
}
// Historical diagnostic compatibility. No canonical transform may call this.
fn jj_i386_work_veto(before:*i64,after:*i64)->i64{return jj_i386_pressure_oracle(before,after);}
fn jj_i386_work_veto_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<8{return 0;}out[0]=6;out[1]=0;out[2]=0;out[3]=8;out[4]=0;out[5]=0;out[6]=1;out[7]=0;return 1;}
