// jj_file: src_j/compiler/backend/loop_address.j
// loop address plan LoopAddressPlan v1. Conservatively fuses one loop value plan/loop live-out plan/loop temporary plan loop
// into a five-register resident set: R10 induction, R11 live-out, R8 hot
// temporary, R12 local-array base and R13 index. R12/R13 are preserved in
// the dead frame slots already proven for R8/R13 and restored on both the
// sole normal exit and the shared fail-closed tail. Unsupported geometry is
// an exact loop temporary plan fallback.
extern fn jj_vm_rd16(p0:*i8)->i64;
extern fn jj_vm_rd32(p0:*i8)->i64;
extern fn jj_n_bc_len(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_n_offset_for_pc(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_loop_liveout_array_overlap(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_loop_temp_body_start(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_loop_temp_first_store_dominates(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_loop_temp_dead_after(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_coldtail_map_index(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_reo_wr32(p0:*i8,p1:i64)->i64;
extern fn jj_reo_nop(p0:*i8,p1:i64,p2:i64)->i64;

fn jj_loop_address_s32(v:i64)->i64{if (v&0x80000000)!=0{return v|0xffffffff00000000;}return v&0xffffffff;}
fn jj_loop_address_disp(slot:i64)->i64{return 0-((slot+1)*8);}
fn jj_loop_address_wr16(p:*i8,v:i64)->i64{if p==0{return 0;}p[0]=v&255;p[1]=(v>>>8)&255;return 1;}
fn jj_loop_address_wr32(p:*i8,v:i64)->i64{if p==0{return 0;}p[0]=v&255;p[1]=(v>>>8)&255;p[2]=(v>>>16)&255;p[3]=(v>>>24)&255;return 1;}
fn jj_loop_address_array_at(code:*i8,at:i64,limit:i64,out:*i64)->i64{
  if code==0{return 0;}if out==0{return 0;}if at<0{return 0;}var stop:i64=at+96;if stop>limit{stop=limit;}var p:i64=at;
  while p+8<=stop{
    if code[p]==0x48{if ((code[p+1])&255)==0x8d{if ((code[p+2])&255)==0x84{if ((code[p+3])&255)==0xc5{out[0]=jj_loop_address_s32(jj_vm_rd32(code+p+4));out[1]=p;out[2]=1;return 1;}}}
      if ((code[p+1])&255)==0x89{if ((code[p+2])&255)==0x8c{if ((code[p+3])&255)==0xc5{out[0]=jj_loop_address_s32(jj_vm_rd32(code+p+4));out[1]=p;out[2]=2;return 1;}}}}
    p=p+1;
  }return 0;
}
fn jj_loop_address_ref_kind(code:*i8,at:i64,limit:i64,slot:i64)->i64{
  if code==0{return 0;}if at<0{return 0;}var d:i64=jj_loop_address_disp(slot);
  if at+6<=limit{if ((code[at])&255)==0xff{if ((code[at+1])&255)==0xb5{if jj_loop_address_s32(jj_vm_rd32(code+at+2))==d{return 1;}}}}
  if at+7<=limit{if code[at]==0x48{if ((code[at+1])&255)==0x8b{var m:i64=(code[at+2])&255;if jj_loop_address_s32(jj_vm_rd32(code+at+3))==d{if m==0x85{return 2;}if m==0x8d{return 3;}if m==0x95{return 4;}if m==0xb5{return 5;}if m==0xbd{return 6;}}}else{if ((code[at+1])&255)==0x89{if ((code[at+2])&255)==0x85{if jj_loop_address_s32(jj_vm_rd32(code+at+3))==d{return 7;}}}}}}
  return 0;
}
fn jj_loop_address_patch_refs(code:*i8,begin:i64,finish:i64,slot:i64,counts:*i64)->i64{
  if code==0{return 0;}if counts==0{return 0;}var loads:i64=0;var stores:i64=0;var at:i64=begin;
  while at<finish{var k:i64=jj_loop_address_ref_kind(code,at,finish,slot);if k==0{at=at+1;}else{if k==7{stores=stores+1;code[at]=0x49;code[at+1]=0x89;code[at+2]=0xc5;code[at+3]=0x0f;code[at+4]=0x1f;code[at+5]=0x40;code[at+6]=0x68;at=at+7;}else{loads=loads+1;if k==1{code[at]=0x41;code[at+1]=0x55;code[at+2]=0x0f;code[at+3]=0x1f;code[at+4]=0x40;code[at+5]=0x69;at=at+6;}else{code[at]=0x4c;code[at+1]=0x89;if k==2{code[at+2]=0xe8;}if k==3{code[at+2]=0xe9;}if k==4{code[at+2]=0xea;}if k==5{code[at+2]=0xee;}if k==6{code[at+2]=0xef;}code[at+3]=0x0f;code[at+4]=0x1f;code[at+5]=0x40;code[at+6]=0x6a;at=at+7;}}}}
  counts[0]=loads;counts[1]=stores;return 1;
}
fn jj_loop_address_patch_arrays(code:*i8,begin:i64,finish:i64,disp:i64)->i64{
  if code==0{return 0;}var count:i64=0;var at:i64=begin;
  while at+8<=finish{var hit:i64=0;if code[at]==0x48{if ((code[at+1])&255)==0x8d{if ((code[at+2])&255)==0x84{if ((code[at+3])&255)==0xc5{if jj_loop_address_s32(jj_vm_rd32(code+at+4))==disp{code[at]=0x49;code[at+1]=0x8d;code[at+2]=0x04;code[at+3]=0xc4;code[at+4]=0x0f;code[at+5]=0x1f;code[at+6]=0x40;code[at+7]=0x66;hit=1;}}}}
      if hit==0{if ((code[at+1])&255)==0x89{if ((code[at+2])&255)==0x8c{if ((code[at+3])&255)==0xc5{if jj_loop_address_s32(jj_vm_rd32(code+at+4))==disp{code[at]=0x49;code[at+1]=0x89;code[at+2]=0x0c;code[at+3]=0xc4;code[at+4]=0x0f;code[at+5]=0x1f;code[at+6]=0x40;code[at+7]=0x67;hit=1;}}}}}}
    if hit!=0{count=count+1;at=at+8;}else{at=at+1;}}
  return count;
}
fn jj_loop_address_plan(ctx:*i64)->i64{
  if ctx==0{return 0-1;}var plan:*i64=ctx[13] as *i64;if plan==0{return 0-1;}var z:i64=0;while z<16{plan[z]=0;z=z+1;}var code:*i8=ctx[0] as *i8;var old_size:i64=ctx[1];var program:*i8=ctx[2] as *i8;var start:i64=ctx[3];var end:i64=ctx[4];var argc:i64=ctx[5];var loops:*i64=ctx[7] as *i64;var nloops:i64=ctx[8];var accs:*i64=ctx[9] as *i64;var temps:*i64=ctx[12] as *i64;if code==0{return 0-1;}if program==0{return 0-1;}if loops==0{return 0-1;}if accs==0{return 0-1;}if temps==0{return 0-1;}
  var enabled:i64=0;var li:i64=0-1;var i:i64=0;while i<nloops{if accs[i*8]!=0{enabled=enabled+1;li=i;}i=i+1;}if enabled!=1{return 0;}var tenabled:i64=0;i=0;while i<nloops{if temps[i*8]!=0{tenabled=tenabled+1;}i=i+1;}if tenabled!=1{return 0;}if temps[li*8]==0{return 0;}
  var la:i64=li*10;var aa:i64=li*8;var header:i64=loops[la];var exit_pc:i64=loops[la+1];var induction:i64=loops[la+4];var acc:i64=accs[aa+1];var temp:i64=temps[aa+1];var body:i64=jj_loop_temp_body_start(program,header,exit_pc);if body<0{return 0;}
  var slots:[64]i64;var loads:[64]i64;var stores:[64]i64;var count:i64=0;var pc:i64=body;
  while pc<exit_pc{var op:i64=program[pc];if op==2{var s:i64=jj_vm_rd16(program+pc+1);if s!=induction{if s!=acc{if s!=temp{var at:i64=0-1;var k:i64=0;while k<count{if slots[k]==s{at=k;}k=k+1;}if at<0{if count>=64{return 0;}at=count;slots[count]=s;loads[count]=0;stores[count]=0;count=count+1;}loads[at]=loads[at]+1;}}}}
    if op==3{var s2:i64=jj_vm_rd16(program+pc+1);if s2!=induction{if s2!=acc{if s2!=temp{var at2:i64=0-1;var q:i64=0;while q<count{if slots[q]==s2{at2=q;}q=q+1;}if at2<0{if count>=64{return 0;}at2=count;slots[count]=s2;loads[count]=0;stores[count]=0;count=count+1;}stores[at2]=stores[at2]+1;}}}}
    var nx:i64=jj_n_bc_len(program,pc,exit_pc);if nx<=0{return 0;}pc=pc+nx;}if pc!=exit_pc{return 0;}
  var chosen:i64=0-1;var chosen_disp:i64=0;var chosen_refs:i64=0;var chosen_loads:i64=0;var ci:i64=0;
  while ci<count{var slot:i64=slots[ci];if stores[ci]==1{if loads[ci]>=2{if jj_loop_liveout_array_overlap(program,start,end,slot)==0{if jj_loop_temp_first_store_dominates(program,body,exit_pc,slot)!=0{if jj_loop_temp_dead_after(program,exit_pc,end,slot)!=0{
    var disps:[8]i64;var refs:[8]i64;var dc:i64=0;pc=body;while pc<exit_pc{if program[pc]==2{if jj_vm_rd16(program+pc+1)==slot{var mo:i64=jj_n_offset_for_pc(program,start,end,argc,pc);if mo<0{return 0;}var ar:[3]i64;if jj_loop_address_array_at(code,mo,old_size,ar as *i64)!=0{var di:i64=0-1;var dj:i64=0;while dj<dc{if disps[dj]==ar[0]{di=dj;}dj=dj+1;}if di<0{if dc<8{di=dc;disps[dc]=ar[0];refs[dc]=0;dc=dc+1;}}if di>=0{refs[di]=refs[di]+1;}}}}var nn:i64=jj_n_bc_len(program,pc,exit_pc);if nn<=0{return 0;}pc=pc+nn;}
    var best:i64=0;var bd:i64=0;var dci:i64=0;while dci<dc{if refs[dci]>best{best=refs[dci];bd=disps[dci];}dci=dci+1;}if best>=2{if best>chosen_refs{chosen=slot;chosen_disp=bd;chosen_refs=best;chosen_loads=loads[ci];}else{if best==chosen_refs{if chosen<0{chosen=slot;chosen_disp=bd;chosen_loads=loads[ci];}else{if slot<chosen{chosen=slot;chosen_disp=bd;chosen_loads=loads[ci];}}}}}
  }}}}}ci=ci+1;}if chosen<0{return 0;}
  var body_old:i64=jj_n_offset_for_pc(program,start,end,argc,body);var exit_old:i64=jj_n_offset_for_pc(program,start,end,argc,exit_pc);if body_old<0{return 0;}if exit_old<=body_old{return 0;}plan[0]=1;plan[1]=li;plan[2]=chosen;plan[3]=temp;plan[4]=acc;plan[5]=induction;plan[6]=chosen_disp;plan[7]=chosen_loads;plan[8]=chosen_refs;plan[9]=body_old;plan[10]=exit_old;plan[11]=loops[la+6];return 1;
}
fn jj_loop_address_emit_frame(code:*i8,at:i64,op:i64,modrm:i64,disp:i64)->i64{if code==0{return 0;}code[at]=0x4c;code[at+1]=op;code[at+2]=modrm;return jj_loop_address_wr32(code+at+3,disp);}
fn jj_loop_address_apply(ctx:*i64,map:*i64,used:i64)->i64{
  if ctx==0{return 0;}if map==0{return 0;}var plan:*i64=ctx[13] as *i64;if plan==0{return 0;}plan[15]=0;if plan[0]==0{return used;}var code:*i8=ctx[0] as *i8;var capacity:i64=ctx[1];var loops:*i64=ctx[7] as *i64;var accs:*i64=ctx[9] as *i64;var index:*i64=map[0] as *i64;var index_count:i64=map[1];var old_size:i64=map[2];if code==0{return 0;}if loops==0{return 0;}if accs==0{return 0;}if index==0{return 0;}var li:i64=plan[1];var la:i64=li*10;var aa:i64=li*8;var header:i64=jj_coldtail_map_index(index,index_count,old_size,plan[11],1);var body:i64=jj_coldtail_map_index(index,index_count,old_size,plan[9],1);var exit_at:i64=jj_coldtail_map_index(index,index_count,old_size,plan[10],1);var fail_at:i64=jj_coldtail_map_index(index,index_count,old_size,old_size-4,1);var setup:i64=accs[aa+7];if header<0{return 0;}if body<0{return 0;}if exit_at<=body{return 0;}if fail_at<0{return 0;}if setup<0{return 0;}if setup+134>capacity{return used;}var exit_stub:i64=setup+40;var fail_stub:i64=setup+66;var short_disp:i64=fail_stub-(fail_at+2);if short_disp<0-128{return used;}if short_disp>127{return used;}if code[header]!=0x4c{return 0;}if ((code[header+1])&255)!=0x8b{return 0;}if ((code[header+2])&255)!=0x95{return 0;}if code[header+7]!=0x4c{return 0;}if ((code[header+8])&255)!=0x8b{return 0;}if ((code[header+9])&255)!=0x9d{return 0;}if code[header+24]!=0x0f{return 0;}if ((code[header+25])&255)<0x80{return 0;}if ((code[header+25])&255)>0x8f{return 0;}if code[fail_at]!=0x31{return 0;}if ((code[fail_at+1])&255)!=0xc0{return 0;}if ((code[fail_at+2])&255)!=0xc9{return 0;}if ((code[fail_at+3])&255)!=0xc3{return 0;}
  if jj_loop_address_emit_frame(code,setup,0x89,0xa5,jj_loop_address_disp(plan[3]))==0{return 0;}if jj_loop_address_emit_frame(code,setup+7,0x89,0xad,jj_loop_address_disp(plan[2]))==0{return 0;}if jj_loop_address_emit_frame(code,setup+14,0x8b,0x95,jj_loop_address_disp(plan[5]))==0{return 0;}if jj_loop_address_emit_frame(code,setup+21,0x8b,0x9d,jj_loop_address_disp(plan[4]))==0{return 0;}if jj_loop_address_emit_frame(code,setup+28,0x8d,0xa5,plan[6])==0{return 0;}code[setup+35]=0xe9;if jj_reo_wr32(code+setup+36,(header+14)-(setup+40))==0{return 0;}
  if jj_loop_address_emit_frame(code,exit_stub,0x89,0x9d,jj_loop_address_disp(plan[4]))==0{return 0;}if jj_loop_address_emit_frame(code,exit_stub+7,0x8b,0xad,jj_loop_address_disp(plan[2]))==0{return 0;}if jj_loop_address_emit_frame(code,exit_stub+14,0x8b,0xa5,jj_loop_address_disp(plan[3]))==0{return 0;}code[exit_stub+21]=0xe9;if jj_reo_wr32(code+exit_stub+22,exit_at-(exit_stub+26))==0{return 0;}
  if jj_loop_address_emit_frame(code,fail_stub,0x8b,0xad,jj_loop_address_disp(plan[2]))==0{return 0;}if jj_loop_address_emit_frame(code,fail_stub+7,0x8b,0xa5,jj_loop_address_disp(plan[3]))==0{return 0;}code[fail_stub+14]=0x31;code[fail_stub+15]=0xc0;code[fail_stub+16]=0xc9;code[fail_stub+17]=0xc3;
  code[header]=0xe9;if jj_reo_wr32(code+header+1,setup-(header+5))==0{return 0;}if jj_reo_nop(code,header+5,header+14)==0{return 0;}if jj_reo_wr32(code+header+26,exit_stub-(header+30))==0{return 0;}code[fail_at]=0xeb;code[fail_at+1]=short_disp&255;code[fail_at+2]=0x90;code[fail_at+3]=0x90;
  var rc:[2]i64;if jj_loop_address_patch_refs(code,body,exit_at,plan[2],rc as *i64)==0{return 0;}if rc[0]<2{return 0;}if rc[1]!=1{return 0;}var arrays:i64=jj_loop_address_patch_arrays(code,body,exit_at,plan[6]);if arrays<2{return 0;}plan[7]=rc[0];plan[8]=arrays;plan[12]=setup;plan[13]=exit_stub;plan[14]=fail_stub;
  var proof:i64=setup+84;code[proof]=0xe9;if jj_loop_address_wr32(code+proof+1,20)==0{return 0;}var w:i64=proof+5;code[w]=0x4a;code[w+1]=0x44;code[w+2]=0x50;code[w+3]=0x31;if jj_loop_address_wr16(code+w+4,plan[2])==0{return 0;}if jj_loop_address_wr16(code+w+6,plan[3])==0{return 0;}if jj_loop_address_wr16(code+w+8,plan[4])==0{return 0;}if jj_loop_address_wr16(code+w+10,li)==0{return 0;}if jj_loop_address_wr32(code+w+12,plan[6])==0{return 0;}if jj_loop_address_wr16(code+w+16,plan[7])==0{return 0;}if jj_loop_address_wr16(code+w+18,plan[8])==0{return 0;}if jj_reo_nop(code,setup+109,capacity)==0{return 0;}plan[15]=1;return setup+109;
}
fn jj_loop_address_update_receipt(ctx:*i64)->i64{
  if ctx==0{return 0;}var plan:*i64=ctx[13] as *i64;var rr:*i64=ctx[10] as *i64;var fid:i64=ctx[11];if plan==0{return 0;}if rr==0{return 0;}if fid<0{return 0;}if plan[0]==0{return 1;}if plan[15]==0{return 1;}var pk:i64=rr[fid];var rc:i64=(pk>>>16)&65535;var fp:i64=(pk>>>32)&65535;var nd:i64=(pk>>>48)&65535;if rc>=65535{return 0;}if nd>65529{return 0;}var tk:i64=(0x82+plan[2]*3+plan[3]*5+plan[4]*7+plan[7]*11+plan[8]*13)&65535;rc=rc+1;fp=(fp*257+tk)&65535;nd=nd+6;rr[fid]=(pk&65535)|(rc<<16)|(fp<<32)|(nd<<48);return 1;
}
