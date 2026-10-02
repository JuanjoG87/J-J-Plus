// Host resource authority. The 80386/8 MiB figure is a comparative stress
// baseline, never a deployment target and never a hard memory ceiling.
// The host personality reports real hardware capacity; this policy preserves
// a bounded reserve and exposes the remaining capacity for lazy, elastic use.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_sys_host_total_memory_bytes()->i64;
extern fn jj_sys_host_logical_cpus()->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_stress_baseline_memory_bytes()->i64{return 8388608;}
fn jj_stress_min_optimizer_working_set()->i64{return 2100224;}
fn jj_host_resource_policy_seal(policy:*i64)->i64{if policy==0{return 0;}var h:i64=0x4a4a4852504f4c31;var i:i64=0;while i<19{h=((h<<7)|(h>>>57))^policy[i]^(i*0x9e3779b1);i=i+1;}if h==0{h=0x4a4a4852504f4c31;}return h;}
fn jj_host_resource_policy_build(host_bytes:i64,logical_cpus:i64,policy:*i64,slots:i64)->i64{
 if policy==0{return 0;}if slots!=20{return 0;}if host_bytes<3148800{return 0;}if host_bytes>0x3fffffffffffffff{return 0;}if logical_cpus<=0{return 0;}if logical_cpus>65536{return 0;}
 var baseline:i64=jj_stress_baseline_memory_bytes();var minimum:i64=jj_stress_min_optimizer_working_set();var reserve:i64=host_bytes/8;if reserve<1048576{reserve=1048576;}if reserve>=host_bytes{return 0;}var managed:i64=host_bytes-reserve;if managed<minimum{return 0;}
 var workers:i64=managed/minimum;if workers<=0{workers=1;}if workers>logical_cpus{workers=logical_cpus;}var per_worker:i64=managed/workers;if per_worker<minimum{return 0;}var remainder:i64=managed-per_worker*workers;
 var q:i64=host_bytes/baseline;var r:i64=host_bytes%baseline;var scale_milli:i64=q*1000+(r*1000)/baseline;
 var i:i64=0;while i<20{policy[i]=0;i=i+1;}policy[0]=0x4a4a4852504f4c31;policy[1]=1;policy[2]=host_bytes;policy[3]=logical_cpus;policy[4]=baseline;policy[5]=minimum;policy[6]=reserve;policy[7]=managed;policy[8]=workers;policy[9]=per_worker;policy[10]=remainder;policy[11]=1048576;policy[12]=scale_milli;policy[13]=1;policy[14]=1;policy[15]=1;policy[16]=1;policy[17]=7;policy[18]=0;policy[19]=jj_host_resource_policy_seal(policy);return 1;
}
fn jj_host_resource_policy_validate(policy:*i64,slots:i64)->i64{if policy==0{return 0;}if slots!=20{return 0;}if policy[0]!=0x4a4a4852504f4c31{return 0;}if policy[1]!=1{return 0;}var expected:[20]i64;if jj_host_resource_policy_build(policy[2],policy[3],expected as *i64,20)==0{return 0;}var i:i64=0;while i<20{if policy[i]!=expected[i]{return 0;}i=i+1;}return 1;}
fn jj_host_resource_policy_current(policy:*i64,slots:i64)->i64{var host:i64=jj_sys_host_total_memory_bytes();var cpus:i64=jj_sys_host_logical_cpus();if host<=0{return 0;}if cpus<=0{return 0;}return jj_host_resource_policy_build(host,cpus,policy,slots);}
