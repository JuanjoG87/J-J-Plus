// jj_file: src_j/compiler/backend/loop_value_liveout.j
// loop live-out plan LoopValuePlan v2. Promotes one scalar live-out value per already
// validated loop value plan natural loop to caller-saved R11. The value is initialized
// before the loop, updated exactly once per iteration, and committed through
// a cold-tail stub on the sole loop exit. Unsupported shapes are ignored.
extern fn jj_vm_rd16(p0:*i8)->i64;
extern fn jj_vm_rd32(p0:*i8)->i64;
extern fn jj_n_bc_len(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_n_offset_for_pc(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_coldtail_s32(p0:i64)->i64;
extern fn jj_coldtail_map_index(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_reo_wr32(p0:*i8,p1:i64)->i64;
extern fn jj_reo_nop(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_loop_value_overlap(p0:i64,p1:i64,p2:i64)->i64;

fn jj_loop_liveout_store_at(code:*i8,at:i64,limit:i64,slot:i64)->i64{
  if code==0{return 0-1;}if at<0{return 0-1;}if slot<0{return 0-1;}if slot>32767{return 0-1;}var d:i64=0;while d<=3{var p:i64=at+d;if p+7<=limit{if code[p]==0x48{if ((code[p+1])&255)==0x89{if ((code[p+2])&255)==0x85{if jj_coldtail_s32(jj_vm_rd32(code+p+3))==0-((slot+1)*8){var q:i64=0;while q<d{if code[at+q]!=0x58{if ((code[at+q])&255)!=0x90{return 0-1;}}q=q+1;}return p;}}}}}d=d+1;}return 0-1;
}
fn jj_loop_liveout_store_ok(code:*i8,at:i64,limit:i64,slot:i64)->i64{if jj_loop_liveout_store_at(code,at,limit,slot)<0{return 0;}return 1;}
fn jj_loop_liveout_load_ok(code:*i8,at:i64,limit:i64,slot:i64)->i64{
  if code==0{return 0;}if at<0{return 0;}if slot<0{return 0;}if slot>32767{return 0;}var disp:i64=0-((slot+1)*8);
  if at+6<=limit{if ((code[at])&255)==0xff{if ((code[at+1])&255)==0xb5{if jj_coldtail_s32(jj_vm_rd32(code+at+2))==disp{return 1;}}}}
  if at+7>limit{return 0;}if code[at]!=0x48{return 0;}if ((code[at+1])&255)!=0x8b{return 0;}if jj_coldtail_s32(jj_vm_rd32(code+at+3))!=disp{return 0;}
  var m:i64=(code[at+2])&255;if m==0x85{return 2;}if m==0x8d{return 3;}if m==0x95{return 4;}if m==0xb5{return 5;}if m==0xbd{return 6;}return 0;
}
fn jj_loop_liveout_marker4(p:*i8,kind:i64)->i64{if p==0{return 0;}if kind!=0x5b{if kind!=0x5c{return 0;}}p[0]=0x0f;p[1]=0x1f;p[2]=0x40;p[3]=kind;return 1;}
fn jj_loop_liveout_patch_store(code:*i8,at:i64,limit:i64,slot:i64,marker:i64)->i64{
  var p:i64=jj_loop_liveout_store_at(code,at,limit,slot);if p<0{return 0;}code[p]=0x49;code[p+1]=0x89;code[p+2]=0xc3;code[p+3]=0x0f;code[p+4]=0x1f;code[p+5]=0x40;code[p+6]=marker;return 1;
}
fn jj_loop_liveout_patch_load(code:*i8,at:i64,limit:i64,slot:i64)->i64{
  var kind:i64=jj_loop_liveout_load_ok(code,at,limit,slot);if kind==0{return 0;}
  if kind==1{code[at]=0x41;code[at+1]=0x53;code[at+2]=0x0f;code[at+3]=0x1f;code[at+4]=0x40;code[at+5]=0x60;return 1;}
  code[at]=0x4c;code[at+1]=0x89;if kind==2{code[at+2]=0xd8;}if kind==3{code[at+2]=0xd9;}if kind==4{code[at+2]=0xda;}if kind==5{code[at+2]=0xde;}if kind==6{code[at+2]=0xdf;}code[at+3]=0x0f;code[at+4]=0x1f;code[at+5]=0x40;code[at+6]=0x61;return 1;
}
fn jj_loop_liveout_array_overlap(program:*i8,start:i64,end:i64,slot:i64)->i64{
  var pc:i64=start;while pc<end{var op:i64=program[pc];if op==4{var base:i64=jj_vm_rd16(program+pc+1);var count:i64=jj_vm_rd16(program+pc+3);if jj_loop_value_overlap(slot,base,count)!=0{return 1;}}var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 1;}pc=pc+n;}if pc!=end{return 1;}return 0;
}
fn jj_loop_liveout_live_out(program:*i8,exit_pc:i64,end:i64,slot:i64)->i64{
  var pc:i64=exit_pc;while pc<end{var op:i64=program[pc];if op==2{if jj_vm_rd16(program+pc+1)==slot{return 1;}}if op==3{if jj_vm_rd16(program+pc+1)==slot{return 0;}}if op==4{var base:i64=jj_vm_rd16(program+pc+1);var count:i64=jj_vm_rd16(program+pc+3);if jj_loop_value_overlap(slot,base,count)!=0{return 0;}}var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0;}pc=pc+n;}return 0;
}
fn jj_loop_liveout_init_pc(program:*i8,start:i64,header:i64,slot:i64)->i64{
  var pc:i64=start;var init:i64=0-1;var used_after:i64=0;while pc<header{var op:i64=program[pc];if op==3{if jj_vm_rd16(program+pc+1)==slot{init=pc;used_after=0;}}else{if op==2{if jj_vm_rd16(program+pc+1)==slot{if init>=0{used_after=1;}}}else{if op==4{var base:i64=jj_vm_rd16(program+pc+1);var count:i64=jj_vm_rd16(program+pc+3);if jj_loop_value_overlap(slot,base,count)!=0{return 0-1;}}}}var n:i64=jj_n_bc_len(program,pc,header);if n<=0{return 0-1;}pc=pc+n;}if pc!=header{return 0-1;}if init<0{return 0-1;}if used_after!=0{return 0-1;}return init;
}
fn jj_loop_liveout_candidate(ctx:*i64,loop_index:i64,record:*i64)->i64{
  if ctx==0{return 0;}if record==0{return 0;}var code:*i8=ctx[0] as *i8;var old_size:i64=ctx[1];var program:*i8=ctx[2] as *i8;var start:i64=ctx[3];var end:i64=ctx[4];var argc:i64=ctx[5];var loops:*i64=ctx[7] as *i64;if code==0{return 0;}if program==0{return 0;}if loops==0{return 0;}var la:i64=loop_index*10;var header:i64=loops[la];var exit_pc:i64=loops[la+1];var induction:i64=loops[la+4];if header<start{return 0;}if exit_pc<=header{return 0;}if exit_pc>end{return 0;}
  var slots:[64]i64;var loads:[64]i64;var stores:[64]i64;var count:i64=0;var pc:i64=header;while pc<exit_pc{var op:i64=program[pc];if op==2{var s:i64=jj_vm_rd16(program+pc+1);if s!=induction{var at:i64=0-1;var i:i64=0;while i<count{if slots[i]==s{at=i;}i=i+1;}if at<0{if count>=64{return 0;}at=count;slots[count]=s;loads[count]=0;stores[count]=0;count=count+1;}loads[at]=loads[at]+1;}}
    if op==3{var s2:i64=jj_vm_rd16(program+pc+1);if s2!=induction{var at2:i64=0-1;var j:i64=0;while j<count{if slots[j]==s2{at2=j;}j=j+1;}if at2<0{if count>=64{return 0;}at2=count;slots[count]=s2;loads[count]=0;stores[count]=0;count=count+1;}stores[at2]=stores[at2]+1;}}
    var n:i64=jj_n_bc_len(program,pc,exit_pc);if n<=0{return 0;}pc=pc+n;}if pc!=exit_pc{return 0;}
  var chosen:i64=0-1;var chosen_init:i64=0-1;var chosen_loads:i64=0;var i2:i64=0;while i2<count{var s3:i64=slots[i2];if stores[i2]==1{if loads[i2]>0{if loads[i2]<=255{if jj_loop_liveout_array_overlap(program,start,end,s3)==0{if jj_loop_liveout_live_out(program,exit_pc,end,s3)!=0{var init:i64=jj_loop_liveout_init_pc(program,start,header,s3);if init>=0{if chosen<0{chosen=s3;chosen_init=init;chosen_loads=loads[i2];}else{if s3<chosen{chosen=s3;chosen_init=init;chosen_loads=loads[i2];}}}}}}}}i2=i2+1;}if chosen<0{return 0;}
  var init_old:i64=jj_n_offset_for_pc(program,start,end,argc,chosen_init);if init_old<0{return 0;}if jj_loop_liveout_store_ok(code,init_old,old_size,chosen)==0{return 0;}
  pc=header;while pc<exit_pc{var op2:i64=program[pc];if op2==2{if jj_vm_rd16(program+pc+1)==chosen{var lo:i64=jj_n_offset_for_pc(program,start,end,argc,pc);if lo<0{return 0;}if jj_loop_liveout_load_ok(code,lo,old_size,chosen)==0{return 0;}}}if op2==3{if jj_vm_rd16(program+pc+1)==chosen{var so:i64=jj_n_offset_for_pc(program,start,end,argc,pc);if so<0{return 0;}if jj_loop_liveout_store_ok(code,so,old_size,chosen)==0{return 0;}}}var nx:i64=jj_n_bc_len(program,pc,exit_pc);if nx<=0{return 0;}pc=pc+nx;}
  record[0]=1;record[1]=chosen;record[2]=chosen_init;record[3]=chosen_loads;record[4]=1;record[5]=init_old;record[6]=exit_pc;record[7]=0;return 1;
}
fn jj_loop_liveout_plan_accumulators(ctx:*i64)->i64{
  if ctx==0{return 0-1;}var count:i64=ctx[8];var accs:*i64=ctx[9] as *i64;if accs==0{return 0-1;}if count<0{return 0-1;}if count>16{return 0-1;}var i:i64=0;var enabled:i64=0;while i<count{var a:i64=i*8;var z:i64=0;while z<8{accs[a+z]=0;z=z+1;}if jj_loop_liveout_candidate(ctx,i,accs+a)!=0{enabled=enabled+1;}i=i+1;}return enabled;
}
fn jj_loop_liveout_apply_accumulators(ctx:*i64)->i64{
  if ctx==0{return 0;}var code:*i8=ctx[0] as *i8;var old_size:i64=ctx[1];var program:*i8=ctx[2] as *i8;var start:i64=ctx[3];var end:i64=ctx[4];var argc:i64=ctx[5];var loops:*i64=ctx[7] as *i64;var count:i64=ctx[8];var accs:*i64=ctx[9] as *i64;if code==0{return 0;}if program==0{return 0;}if loops==0{return 0;}if accs==0{return 0;}var i:i64=0;while i<count{var aa:i64=i*8;if accs[aa]!=0{var la:i64=i*10;var header:i64=loops[la];var exit_pc:i64=loops[la+1];var h:i64=loops[la+6];var slot:i64=accs[aa+1];var kind:i64=0;if code[h+34]==0x58{kind=0x5b;}else{if code[h+34]==0x59{kind=0x5c;}else{return 0;}}
    // Preserve the original initialization store. Encode the promoted slot in
    // a direct R11 frame load inside the old 35-byte header geometry.
    code[h+23]=0x4c;code[h+24]=0x8b;code[h+25]=0x9d;if jj_reo_wr32(code+h+26,0-((slot+1)*8))==0{return 0;}code[h+30]=0x90;if jj_loop_liveout_marker4(code+h+31,kind)==0{return 0;}
    var pc:i64=header;while pc<exit_pc{var op:i64=program[pc];if op==2{if jj_vm_rd16(program+pc+1)==slot{var lo:i64=jj_n_offset_for_pc(program,start,end,argc,pc);if lo<0{return 0;}if jj_loop_liveout_patch_load(code,lo,old_size,slot)==0{return 0;}}}if op==3{if jj_vm_rd16(program+pc+1)==slot{var so:i64=jj_n_offset_for_pc(program,start,end,argc,pc);if so<0{return 0;}if jj_loop_liveout_patch_store(code,so,old_size,slot,0x5f)==0{return 0;}}}var nx:i64=jj_n_bc_len(program,pc,exit_pc);if nx<=0{return 0;}pc=pc+nx;}if pc!=exit_pc{return 0;}}i=i+1;}return 1;
}

fn jj_loop_liveout_write_stub(code:*i8,at:i64,limit:i64,slot:i64,target:i64)->i64{
  if code==0{return 0;}if at<0{return 0;}if at+12>limit{return 0;}if slot<0{return 0;}if slot>32767{return 0;}code[at]=0x4c;code[at+1]=0x89;code[at+2]=0x9d;if jj_reo_wr32(code+at+3,0-((slot+1)*8))==0{return 0;}code[at+7]=0xe9;if jj_reo_wr32(code+at+8,target-(at+12))==0{return 0;}return 1;
}
fn jj_loop_liveout_append_stubs(ctx:*i64,map:*i64,used:i64)->i64{
  if ctx==0{return 0;}if map==0{return 0;}var code:*i8=ctx[0] as *i8;var old_size:i64=ctx[1];var program:*i8=ctx[2] as *i8;var start:i64=ctx[3];var end:i64=ctx[4];var argc:i64=ctx[5];var loops:*i64=ctx[7] as *i64;var count:i64=ctx[8];var accs:*i64=ctx[9] as *i64;var index:*i64=map[0] as *i64;var index_count:i64=map[1];if code==0{return 0;}if program==0{return 0;}if loops==0{return 0;}if accs==0{return 0;}if index==0{return 0;}var out:i64=used;var i:i64=0;while i<count{var aa:i64=i*8;if accs[aa]!=0{var la:i64=i*10;var header_old:i64=loops[la+6];var backedge_old:i64=loops[la+8];var exit_pc:i64=accs[aa+6];var header_new:i64=jj_coldtail_map_index(index,index_count,old_size,header_old,1);var backedge_new:i64=jj_coldtail_map_index(index,index_count,old_size,backedge_old,1);var exit_old:i64=jj_n_offset_for_pc(program,start,end,argc,exit_pc);if header_new<0{return 0;}if backedge_new<0{return 0;}if exit_old<0{return 0;}var exit_new:i64=jj_coldtail_map_index(index,index_count,old_size,exit_old,1);if exit_new<0{return 0;}if code[header_new+24]!=0x0f{return 0;}if code[header_new+33]!=0x5b{if code[header_new+33]!=0x5c{return 0;}}if jj_loop_liveout_write_stub(code,out,old_size,accs[aa+1],exit_new)==0{return 0;}if jj_reo_wr32(code+header_new+26,out-(header_new+30))==0{return 0;}if ((code[backedge_new])&255)!=0xe9{return 0;}if jj_reo_wr32(code+backedge_new+1,(header_new+14)-(backedge_new+5))==0{return 0;}accs[aa+7]=out;out=out+12;}i=i+1;}if out>old_size{return 0;}if jj_reo_nop(code,out,old_size)==0{return 0;}return out;
}
fn jj_loop_liveout_update_receipt(ctx:*i64)->i64{
  if ctx==0{return 0;}
  var lp:*i64=ctx[7] as *i64;
  var n:i64=ctx[8];
  var ac:*i64=ctx[9] as *i64;
  var rr:*i64=ctx[10] as *i64;
  var fid:i64=ctx[11];
  if lp==0{return 0;}
  if ac==0{return 0;}
  if rr==0{return 0;}
  if fid<0{return 0;}
  var pk:i64=rr[fid];
  var rc:i64=(pk>>>16)&65535;
  var fp:i64=(pk>>>32)&65535;
  var nd:i64=(pk>>>48)&65535;
  var i:i64=0;
  while i<n{
    var a:i64=i*8;
    if ac[a]!=0{
      if rc>=65535{return 0;}
      if nd>65533{return 0;}
      var tk:i64=(0x62+lp[i*10+4]*3+ac[a+1]*5+ac[a+3]*7)&65535;
      rc=rc+1;
      fp=(fp*257+tk)&65535;
      nd=nd+2;
    }
    i=i+1;
  }
  rr[fid]=(pk&65535)|(rc<<16)|(fp<<32)|(nd<<48);
  return 1;
}
