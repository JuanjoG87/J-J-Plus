// jj_file: src_j/compiler/backend/range_facts.j
// block plan sparse, block-local unsigned range facts. Facts are fail-closed and
// cleared at control-flow entries, terminators and unknown memory effects.
extern fn jj_rc_history_get(p0:*i64,p1:i64)->i64;
extern fn jj_vm_rd16(p0:*i8)->i64;
extern fn jj_vm_rd64(p0:*i8)->i64;

fn jj_rf_init(f:*i64)->i64{if f==0{return 0;}f[0]=0x4a4a52464c4f4331;f[1]=0;var i:i64=0;while i<64{f[2+i*2]=0-1;f[3+i*2]=0;i=i+1;}return 1;}
fn jj_rf_clear(f:*i64)->i64{if f==0{return 0;}if f[0]!=0x4a4a52464c4f4331{return 0;}f[1]=f[1]+1;var i:i64=0;while i<64{f[2+i*2]=0-1;f[3+i*2]=0;i=i+1;}return 1;}
fn jj_rf_set(f:*i64,slot:i64,max_value:i64)->i64{if f==0{return 0;}if f[0]!=0x4a4a52464c4f4331{return 0;}if slot<0{return 0;}if slot>32767{return 0;}if max_value<0{return 0;}if max_value>0x7fffffff{return 0;}var i:i64=0;var free:i64=0-1;while i<64{if f[2+i*2]==slot{f[3+i*2]=max_value;return 1;}if f[2+i*2]<0{if free<0{free=i;}}i=i+1;}if free<0{return 0;}f[2+free*2]=slot;f[3+free*2]=max_value;return 1;}
fn jj_rf_kill(f:*i64,slot:i64)->i64{if f==0{return 0;}if f[0]!=0x4a4a52464c4f4331{return 0;}var i:i64=0;while i<64{if f[2+i*2]==slot{f[2+i*2]=0-1;f[3+i*2]=0;return 1;}i=i+1;}return 1;}
fn jj_rf_kill_span(f:*i64,base:i64,count:i64)->i64{if f==0{return 0;}if f[0]!=0x4a4a52464c4f4331{return 0;}if base<0{return 0;}if base>32767{return 0;}if count<=0{return 0;}if count>32768{return 0;}if base+count>32768{return 0;}var limit:i64=base+count;var i:i64=0;while i<64{var slot:i64=f[2+i*2];if slot>=base{if slot<limit{f[2+i*2]=0-1;f[3+i*2]=0;}}i=i+1;}return 1;}
fn jj_rf_get(f:*i64,slot:i64)->i64{if f==0{return 0-1;}if f[0]!=0x4a4a52464c4f4331{return 0-1;}var i:i64=0;while i<64{if f[2+i*2]==slot{return f[3+i*2];}i=i+1;}return 0-1;}
fn jj_rf_mask_valid(mask:i64)->i64{if mask<=0{return 0;}if mask>0x7fffffff{return 0;}if (mask&(mask+1))!=0{return 0;}return 1;}
fn jj_rf_update_store(program:*i8,h:*i64,f:*i64)->i64{
  if program==0{return 0;}if h==0{return 0;}if f==0{return 0;}if jj_rc_history_get(h,98)!=3{return 1;}var store_pc:i64=jj_rc_history_get(h,99);if store_pc<0{return 0;}var slot:i64=jj_vm_rd16(program+store_pc+1);if jj_rf_kill(f,slot)==0{return 0;}
  if jj_rc_history_get(h,84)!=1{return 1;}if jj_rc_history_get(h,91)!=16{return 1;}if jj_rc_history_get(h,87)!=0{return 1;}if jj_rc_history_get(h,94)!=0{return 1;}if jj_rc_history_get(h,101)!=0{return 1;}var mask_pc:i64=jj_rc_history_get(h,85);if mask_pc<0{return 0;}var mask:i64=jj_vm_rd64(program+mask_pc+1);if jj_rf_mask_valid(mask)==0{return 1;}return jj_rf_set(f,slot,mask);
}
