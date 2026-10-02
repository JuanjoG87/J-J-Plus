// x86 bytecode sizing, offset and liveness planning phase.
// Integration-hub partition R764: concrete work lives in focused phases.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_xagg_signature_extended(p0:*i64,p1:i64)->i64;
extern fn jj_xagg_call_size(p0:*i64,p1:i64)->i64;
extern fn jj_xagg_return_class(p0:*i64,p1:i64)->i64;
extern fn jj_xagg_return_size(p0:*i64,p1:i64)->i64;
extern fn jj_xagg_prologue_size(p0:*i64,p1:i64)->i64;
extern fn jj_core_function_field(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_codeseg_emit(p0:*i64,p1:*i64,p2:i64,p3:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_c_align(value: i64, alignment: i64) -> i64 {
  var mask: i64 = alignment - 1; return (value + mask) & (0 - alignment);
}
fn jj_vm_rd16(p: *i8) -> i64 {
  var b0: i64 = p[0] & 255;
  var b1: i64 = p[1] & 255;
  return b0 | (b1 << 8);
}

fn jj_vm_rd32(p: *i8) -> i64 {
  var value: i64 = 0;
  var i: i64 = 0;
  while i < 4 {
    var byte_value: i64 = p[i] & 255;
    value = value | (byte_value << (i * 8));
    i = i + 1;
  }
  return value;
}

fn jj_vm_rd64(p: *i8) -> i64 {
  var value: i64 = 0;
  var i: i64 = 0;
  while i < 8 {
    var byte_value: i64 = p[i] & 255;
    value = value | (byte_value << (i * 8));
    i = i + 1;
  }
  return value;
}




fn jj_n_bc_len(program: *i8, pc: i64, total: i64) -> i64 {
  if pc >= total { return 0; }
  var op: i64 = program[pc];
  if op == 1 { if pc + 9 > total { return 0; } return 9; }
  if op >= 2 { if op <= 3 { if pc + 3 > total { return 0; } return 3; } }
  if op == 4 { if pc + 5 > total { return 0; } return 5; }
  if op == 27 { if pc + 5 > total { return 0; } return 5; }
  if op == 28 { if pc + 5 > total { return 0; } return 5; }
  if op == 29 { if pc + 4 > total { return 0; } return 4; }
  if op == 33 { if pc + 4 > total { return 0; } return 4; }
  if op == 34 { return 1; }
  if op == 35 { return 1; }
  if op == 36 { return 1; }
  if op == 37 { return 1; }
  if op >= 38 { if op <= 44 { return 1; } }
  if op==45{if pc+5>total{return 0;}return 5;}
  if op==46{return 1;}if op==47{return 1;}
  if op==48{if pc+3>total{return 0;}var string_length:i64=jj_vm_rd16(program+pc+1);if pc+3+string_length>total{return 0;}return 3+string_length;}
  if op==49{return 1;}
  if op >= 5 { if op <= 32 { return 1; } }
  return 0;
}
fn jj_n_relocation_count(program:*i8,start:i64,end:i64)->i64{
  if program==0{return 0-1;}if start<0{return 0-1;}if end<=start{return 0-1;}var pc:i64=start;var count:i64=0;
  while pc<end{var n:i64=jj_n_bc_len(program,pc,end);if n==0{return 0-1;}if program[pc]==33{if count>=0x0fffffff{return 0-1;}count=count+1;}pc=pc+n;}
  if pc!=end{return 0-1;}return count;
}
fn jj_n_arg_pop_size(argc: i64) -> i64 {
  var size: i64 = argc;
  if argc >= 5 { size = size + 1; }
  if argc >= 6 { size = size + 1; }
  return size;
}
fn jj_n_op_size(program: *i8, pc: i64, total: i64) -> i64 {
  if pc >= total { return 0; }
  var op: i64 = program[pc];
  if op == 1 { return 11; }
  if op == 2 { return 6; }
  if op == 3 { return 8; }
  if op == 4 { return 8; }
  if op == 5 { return 6; }
  if op == 6 { return 6; }
  if op == 7 { return 4; }
  if op == 8 { return 5; }
  if op == 9 { return 6; }
  if op == 10 { return 6; }
  if op == 11 { return 7; }
  if op == 12 { return 46; }
  if op == 13 { return 49; }
  if op == 14 { return 16; }
  if op == 15 { return 16; }
  if op >= 16 { if op <= 18 { return 6; } }
  if op >= 19 { if op <= 24 { return 13; } }
  if op == 25 { return 5; }
  if op == 26 { return 12; }
  if op == 27 { return 5; }
  if op == 28 { return 10; }
  if op == 29 { return jj_n_arg_pop_size(program[pc + 3]) + 24; }
  if op == 33 { return jj_n_arg_pop_size(program[pc + 3]) + 24; }
  if op == 34 { return jj_n_arg_pop_size(4) + 15; }
  if op == 35 { return 49; }
  if op == 36 { return jj_n_arg_pop_size(5) + 18; }
  if op == 37 { return 16; }
  if op == 38 { return 18; }
  if op == 39 { return 21; }
  if op >= 40 { if op <= 43 { return 13; } }
  if op==44{return 4;}if op==45{return 23;}if op==46{return 4;}if op==47{return 4;}if op==48{return 14+jj_vm_rd16(program+pc+1);}if op==49{return jj_n_arg_pop_size(6)+21;}
  if op == 30 { return 3; }
  if op == 31 { return 1; }
  if op == 32 { return 6; }
  return 0;
}
fn jj_n_function_size(program: *i8, start: i64, end: i64, argc: i64) -> i64 {
  var pc: i64 = start; var size: i64 = 11 + argc * 7;
  while pc < end { var n: i64 = jj_n_bc_len(program, pc, end); if n == 0 { return 0; } var s: i64 = jj_n_op_size(program, pc, end); if s == 0 { return 0; } size = size + s; pc = pc + n; }
  if pc != end { return 0; }
  return size + 4;
}
fn jj_n_offset_for_pc(program: *i8, start: i64, end: i64, argc: i64, target: i64) -> i64 {
  if target < start { return 0 - 1; } if target > end { return 0 - 1; }
  var pc: i64 = start; var size: i64 = 11 + argc * 7;
  while pc < target { var n: i64 = jj_n_bc_len(program, pc, end); if n == 0 { return 0 - 1; } var s: i64 = jj_n_op_size(program, pc, end); if s == 0 { return 0 - 1; } size = size + s; pc = pc + n; }
  if pc != target { return 0 - 1; }
  return size;
}
fn jj_n_call_uses_extended_abi(core:*i64,program:*i8,pc:i64)->i64{if core==0{return 0;}if program==0{return 0;}if (program[pc]&255)!=29{return 0;}var called:i64=jj_vm_rd16(program+pc+1);return jj_xagg_signature_extended(core,called);}
fn jj_n_function_extended(core:*i64,function_id:i64,program:*i8,start:i64,end:i64)->i64{if jj_xagg_signature_extended(core,function_id)!=0{return 1;}var pc:i64=start;while pc<end{var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0;}if jj_n_call_uses_extended_abi(core,program,pc)!=0{return 1;}pc=pc+n;}return 0;}
fn jj_n_op_size_abi(core:*i64,function_id:i64,program:*i8,pc:i64,total:i64)->i64{var op:i64=program[pc]&255;if op==29{var called:i64=jj_vm_rd16(program+pc+1);if jj_xagg_signature_extended(core,called)!=0{return jj_xagg_call_size(core,called);}}if op==30{if jj_xagg_return_class(core,function_id)!=0{return jj_xagg_return_size(core,function_id);}}return jj_n_op_size(program,pc,total);}
fn jj_n_function_size_abi(core:*i64,function_id:i64,program:*i8,start:i64,end:i64,argc:i64)->i64{var extended:i64=jj_n_function_extended(core,function_id,program,start,end);if extended==0{return jj_n_function_size(program,start,end,argc);}var pc:i64=start;var size:i64=jj_xagg_prologue_size(core,function_id);if size<=0{return 0;}while pc<end{var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0;}var add:i64=jj_n_op_size_abi(core,function_id,program,pc,end);if add<=0{return 0;}if size>0x7fffffff-add{return 0;}size=size+add;pc=pc+n;}if pc!=end{return 0;}return size+4;}
fn jj_n_offset_for_pc_abi_ctx(ctx:*i64,target:i64)->i64{if ctx==0{return 0-1;}var core:*i64=ctx[0] as *i64;var function_id:i64=ctx[1];var program:*i8=ctx[2] as *i8;var start:i64=ctx[3];var end:i64=ctx[4];var extended:i64=ctx[5];var argc:i64=jj_core_function_field(core,function_id,3);if extended==0{return jj_n_offset_for_pc(program,start,end,argc,target);}if target<start{return 0-1;}if target>end{return 0-1;}var pc:i64=start;var size:i64=jj_xagg_prologue_size(core,function_id);if size<=0{return 0-1;}while pc<target{var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0-1;}var add:i64=jj_n_op_size_abi(core,function_id,program,pc,end);if add<=0{return 0-1;}size=size+add;pc=pc+n;}if pc!=target{return 0-1;}return size;}
fn jj_n_offset_for_pc_abi(core:*i64,function_id:i64,program:*i8,start:i64,end:i64,target:i64)->i64{var ctx:[6]i64;ctx[0]=core as i64;ctx[1]=function_id;ctx[2]=program as i64;ctx[3]=start;ctx[4]=end;ctx[5]=jj_n_function_extended(core,function_id,program,start,end);return jj_n_offset_for_pc_abi_ctx(ctx as *i64,target);}
fn jj_n_plan_index(plan:*i64,pc:i64)->i64{if plan==0{return 0-1;}var n:i64=plan[2];var lo:i64=0;var hi:i64=n;while lo<hi{var mid:i64=(lo+hi)>>1;var at:i64=plan[16+mid*8];if at<pc{lo=mid+1;}else{hi=mid;}}if lo<n{if plan[16+lo*8]==pc{return lo;}}return 0-1;}
fn jj_n_function_live(program:*i8,plan:*i64,argc:i64,locals:i64,map:*i64,stats:*i64)->i64{
  if program==0{return 0;}if plan==0{return 0;}if map==0{return 0;}if stats==0{return 0;}var z:i64=0;while z<64{map[z]=z;z=z+1;}z=0;while z<12{stats[z]=0;z=z+1;}var start:i64=plan[6];var end:i64=plan[7];if start<0{return 0;}if end<=start{return 0;}if argc<0{return 0;}if argc>6{return 0;}if locals<argc{return 0;}if locals>32768{return 0;}var active:i64=argc;var refs:i64=0;var branches:i64=0;var calls:i64=0;var address:i64=0;var h:i64=start^(end<<1)^(argc<<9)^(locals<<17)^0x4a4a4c4956453033;var pc:i64=start;
  while pc<end{var n:i64=jj_n_bc_len(program,pc,end);if n==0{return 0;}var op:i64=program[pc];if op>=2{if op<=3{var slot:i64=jj_vm_rd16(program+pc+1);if slot>=locals{return 0;}if slot+1>active{active=slot+1;}h=h^(slot<<23)^(op<<31);refs=refs+1;}}if op==4{var sa:i64=jj_vm_rd16(program+pc+1);var ar:i64=jj_vm_rd16(program+pc+3);if ar==0{return 0;}if sa>=locals{return 0;}if sa>locals-ar{return 0;}if sa+ar>active{active=sa+ar;}h=h^(sa<<23)^(ar<<39);refs=refs+1;address=1;}if op>=27{if op<=28{var target:i64=jj_vm_rd32(program+pc+1);if target<start{return 0;}if target>=end{return 0;}h=h^(target<<13);branches=branches+1;}}if op==29{if program[pc+3]>6{return 0;}h=h^(program[pc+3]<<41);calls=calls+1;}if op==33{if program[pc+3]>6{return 0;}h=h^(program[pc+3]<<41);calls=calls+1;}if op>=34{if op<=36{calls=calls+1;}}if op==49{calls=calls+1;}h=((h<<7)|(h>>>57))^op^pc^n;pc=pc+n;}
  if pc!=end{return 0;}stats[0]=active;stats[1]=locals-active;stats[2]=refs;stats[3]=branches;stats[4]=calls;stats[5]=start;stats[6]=end;stats[8]=0;stats[9]=address;
  if locals<=64{if plan[1]==1{if plan[2]>0{if plan[2]<=256{if address==0{
    var use:[256]i64;var defs:[256]i64;var lin:[256]i64;var lout:[256]i64;var din:[256]i64;var dout:[256]i64;var succ0:[256]i64;var succ1:[256]i64;var meet:[256]i64;var predc:[256]i64;var reach:[256]i64;var obegin:[256]i64;var oend:[256]i64;var inter:[64]i64;var blocks:i64=plan[2];var bi:i64=0;while bi<blocks{use[bi]=0;defs[bi]=0;lin[bi]=0;lout[bi]=0;din[bi]=0;dout[bi]=0;succ0[bi]=0-1;succ1[bi]=0-1;meet[bi]=0;predc[bi]=0;reach[bi]=0;obegin[bi]=0;oend[bi]=0;bi=bi+1;}z=0;while z<64{inter[z]=0;z=z+1;}var all:i64=0xffffffffffffffff;if locals<64{all=(1<<locals)-1;}var args:i64=0;if argc>0{args=(1<<argc)-1;}
    var oi:i64=0;bi=0;while bi<blocks{var bb:i64=16+bi*8;var bp:i64=plan[bb];var bend:i64=plan[bb+1];while oi<plan[5]{if plan[2064+oi]>=bp{break;}oi=oi+1;}obegin[bi]=oi;var seen:i64=0;while oi<plan[5]{var opc:i64=plan[2064+oi];if opc>=bend{break;}var bn:i64=jj_n_bc_len(program,opc,bend);if bn==0{return 0;}var bo:i64=program[opc];if bo==2{var ls:i64=jj_vm_rd16(program+opc+1);var bit:i64=1<<ls;if (seen&bit)==0{use[bi]=use[bi]|bit;}}if bo==3{var ds:i64=jj_vm_rd16(program+opc+1);var db:i64=1<<ds;defs[bi]=defs[bi]|db;seen=seen|db;}oi=oi+1;}oend[bi]=oi;var s0:i64=plan[bb+3];var s1:i64=plan[bb+4];if s0>=0{succ0[bi]=jj_n_plan_index(plan,s0);if succ0[bi]<0{return 0;}}if s1>=0{succ1[bi]=jj_n_plan_index(plan,s1);if succ1[bi]<0{return 0;}}bi=bi+1;}if oi!=plan[5]{return 0;}
    reach[0]=1;var changed:i64=1;var reach_iterations:i64=0;while changed!=0{if reach_iterations>=256{return 0;}changed=0;bi=0;while bi<blocks{if reach[bi]!=0{var r0:i64=succ0[bi];var r1:i64=succ1[bi];if r0>=0{if reach[r0]==0{reach[r0]=1;changed=1;}}if r1>=0{if reach[r1]==0{reach[r1]=1;changed=1;}}}bi=bi+1;}reach_iterations=reach_iterations+1;}
    bi=0;while bi<blocks{if reach[bi]!=0{if bi==0{din[bi]=args;dout[bi]=args|defs[bi];}else{din[bi]=all;dout[bi]=all;}}else{din[bi]=0;dout[bi]=0;}bi=bi+1;}
    changed=1;var iterations:i64=0;while changed!=0{if iterations>=512{return 0;}bi=0;while bi<blocks{meet[bi]=all;predc[bi]=0;bi=bi+1;}bi=0;while bi<blocks{if reach[bi]!=0{var x0:i64=succ0[bi];var x1:i64=succ1[bi];if x0>=0{meet[x0]=meet[x0]&dout[bi];predc[x0]=predc[x0]+1;}if x1>=0{meet[x1]=meet[x1]&dout[bi];predc[x1]=predc[x1]+1;}}bi=bi+1;}changed=0;bi=0;while bi<blocks{var incoming:i64=0;if reach[bi]!=0{if bi==0{incoming=args;}else{if predc[bi]>0{incoming=meet[bi];}}}var outgoing:i64=incoming|defs[bi];if din[bi]!=incoming{din[bi]=incoming;changed=1;}if dout[bi]!=outgoing{dout[bi]=outgoing;changed=1;}bi=bi+1;}iterations=iterations+1;}
    bi=0;while bi<blocks{if reach[bi]!=0{if (use[bi]&((0-1)^din[bi]))!=0{stats[9]=stats[9]|2;return 0;}}bi=bi+1;}
    changed=1;var lit:i64=0;while changed!=0{if lit>=512{return 0;}changed=0;bi=blocks;while bi>0{bi=bi-1;var outgoing2:i64=0;var y0:i64=succ0[bi];var y1:i64=succ1[bi];if y0>=0{outgoing2=outgoing2|lin[y0];}if y1>=0{outgoing2=outgoing2|lin[y1];}var incoming2:i64=use[bi]|(outgoing2&((0-1)^defs[bi]));if lout[bi]!=outgoing2{lout[bi]=outgoing2;changed=1;}if lin[bi]!=incoming2{lin[bi]=incoming2;changed=1;}}lit=lit+1;}
    var fp:i64=0x4a4a4c4956454447;bi=0;while bi<blocks{fp=((fp<<7)|(fp>>>57))^use[bi]^defs[bi]^lin[bi]^lout[bi]^din[bi]^dout[bi]^succ0[bi]^(succ1[bi]<<8)^obegin[bi]^(oend[bi]<<16)^(reach[bi]<<24)^bi;bi=bi+1;}stats[10]=reach_iterations+iterations+lit;stats[11]=fp;
    if calls==0{if plan[4]<=1{
      bi=0;while bi<blocks{var live:i64=lout[bi];var ri:i64=oend[bi];while ri>obegin[bi]{ri=ri-1;var rp:i64=plan[2064+ri];var ro:i64=program[rp];if ro==2{live=live|(1<<jj_vm_rd16(program+rp+1));}if ro==3{var rs:i64=jj_vm_rd16(program+rp+1);var rb:i64=1<<rs;var peers:i64=live&((0-1)^rb);inter[rs]=inter[rs]|peers;var q:i64=0;while q<locals{var qb:i64=1<<q;if (peers&qb)!=0{inter[q]=inter[q]|rb;}q=q+1;}live=live&((0-1)^rb);}}if live!=lin[bi]{return 0;}bi=bi+1;}
      z=0;while z<64{map[z]=0-1;z=z+1;}var maxc:i64=0;z=0;while z<argc{map[z]=z;maxc=z+1;z=z+1;}var referenced:i64=args;bi=0;while bi<blocks{referenced=referenced|use[bi]|defs[bi];bi=bi+1;}z=argc;while z<locals{var zb:i64=1<<z;if (referenced&zb)==0{map[z]=0;}else{var used:i64=0;var n2:i64=0;while n2<z{var nb:i64=1<<n2;if (inter[z]&nb)!=0{var c2:i64=map[n2];if c2>=0{used=used|(1<<c2);}}n2=n2+1;}var color:i64=0;while color<64{if (used&(1<<color))==0{break;}color=color+1;}if color>=64{return 0;}map[z]=color;if color+1>maxc{maxc=color+1;}}z=z+1;}var old_frame:i64=jj_c_align((active+1)*8,16);var new_frame:i64=jj_c_align((maxc+1)*8,16);if new_frame<old_frame{stats[0]=maxc;stats[1]=locals-maxc;stats[8]=1;if plan[4]==0{stats[11]=stats[11]^referenced^maxc^0x4d554c5449424c4b;}else{stats[11]=stats[11]^referenced^maxc^0x4c4f4f50434f4c52;}}else{z=0;while z<64{map[z]=z;z=z+1;}stats[0]=active;stats[1]=locals-active;stats[8]=0;if plan[4]==0{stats[11]=stats[11]^referenced^active^0x4944454e54495459;}}
    }}
  }}}}}
  var seal:i64=h^(stats[0]<<3)^(stats[1]<<11)^(refs<<19)^(branches<<35)^(calls<<47)^stats[8]^(stats[9]<<5)^stats[10]^stats[11]^0x4a4a4c4956534543;z=0;while z<64{seal=((seal<<7)|(seal>>>57))^map[z]^z;z=z+1;}if seal==0{seal=1;}stats[7]=seal;return seal;
}
fn jj_n_e8(state:*i64,value:i64)->i64{if state==0{return 0;}if state[10]==0{return 0;}return jj_codeseg_emit(state[10] as *i64,(((state as i64)+16) as *i64),value,1);}
fn jj_n_e32(state:*i64,value:i64)->i64{if state==0{return 0;}if state[10]==0{return 0;}return jj_codeseg_emit(state[10] as *i64,(((state as i64)+16) as *i64),value,4);}
fn jj_n_e64(state:*i64,value:i64)->i64{if state==0{return 0;}if state[10]==0{return 0;}return jj_codeseg_emit(state[10] as *i64,(((state as i64)+16) as *i64),value,8);}
