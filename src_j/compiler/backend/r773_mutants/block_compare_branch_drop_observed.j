// jj_file: src_j/compiler/backend/block_compare_branch.j
// block plan CFG-authorized compare+conditional-branch fusion for local/local values.
extern fn jj_rc_history_get(p0:*i64,p1:i64)->i64;
extern fn jj_vm_rd16(p0:*i8)->i64;
extern fn jj_vm_rd32(p0:*i8)->i64;
extern fn jj_vm_rd64(p0:*i8)->i64;
extern fn jj_reo_wr32(p0:*i8,p1:i64)->i64;
extern fn jj_reo_nop(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_bp_compare_terminator(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;

fn jj_bpcb_signed32(v:i64)->i64{if v>=0x80000000{return v-0x100000000;}return v;}
fn jj_bpcb_inverse_cc(op:i64)->i64{
  if op==19{return 0x85;}if op==20{return 0x84;}if op==21{return 0x8d;}if op==22{return 0x8f;}if op==23{return 0x8e;}if op==24{return 0x8c;}
  if op==40{return 0x83;}if op==41{return 0x87;}if op==42{return 0x86;}if op==43{return 0x82;}return 0;
}
fn jj_bpcb_emit(code:*i8,begin:i64,end:i64,d:*i64)->i64{
  if code==0{return 0;}if d==0{return 0;}var lhs:i64=d[0];var rhs:i64=d[1];var comparison:i64=d[2];var target_machine:i64=d[3];var entry_target:i64=d[4];if begin<0{return 0;}if end-begin!=35{return 0;}if lhs<0{return 0;}if rhs<0{return 0;}if lhs>32767{return 0;}if rhs>32767{return 0;}if entry_target<0{return 0;}if entry_target>1{return 0;}var cc:i64=jj_bpcb_inverse_cc(comparison);if cc==0{return 0;}if target_machine<0{return 0;}
  var at:i64=begin;code[at]=0x48;code[at+1]=0x8b;code[at+2]=0x85;if jj_reo_wr32(code+at+3,0-((lhs+1)*8))==0{return 0;}at=at+7;
  code[at]=0x48;code[at+1]=0x8b;code[at+2]=0x8d;if jj_reo_wr32(code+at+3,0-((rhs+1)*8))==0{return 0;}at=at+7;
  code[at]=0x48;code[at+1]=0x39;code[at+2]=0xc8;at=at+3;code[at]=0x0f;code[at+1]=cc;if jj_reo_wr32(code+at+2,target_machine-(at+6))==0{return 0;}at=at+6;
  if end-at<5{return 0;}if jj_reo_nop(code,at,end-5)==0{return 0;}code[end-5]=0x0f;code[end-4]=0x1f;code[end-3]=0x44;code[end-2]=0x00;if entry_target==0{code[end-1]=0x45;}else{code[end-1]=0x49;}return 1;
}
fn jj_bpcb_try_history(code:*i8,end:i64,program:*i8,h:*i64,receipts:*i64,plan:*i64)->i64{
  if code==0{return 0-1;}if program==0{return 0-1;}if h==0{return 0-1;}if receipts==0{return 0-1;}if plan==0{return 0-1;}
  if jj_rc_history_get(h,77)!=2{return 0;}if jj_rc_history_get(h,84)!=2{return 0;}var comparison:i64=jj_rc_history_get(h,91);if jj_bpcb_inverse_cc(comparison)==0{return 0;}if jj_rc_history_get(h,98)!=28{return 0;}
  var entry_target:i64=jj_rc_history_get(h,80);if entry_target<0{return 0-1;}if entry_target>1{return 0-1;}if jj_rc_history_get(h,87)!=0{return 0;}if jj_rc_history_get(h,94)!=0{return 0;}if jj_rc_history_get(h,101)!=0{return 0;}
  var lhs_pc:i64=jj_rc_history_get(h,78);var rhs_pc:i64=jj_rc_history_get(h,85);var branch_pc:i64=jj_rc_history_get(h,99);if lhs_pc<0{return 0-1;}if rhs_pc<0{return 0-1;}if branch_pc<0{return 0-1;}var target_pc:i64=jj_vm_rd32(program+branch_pc+1);
  var branch_end:i64=end;if branch_end<4{return 0-1;}var target_machine:i64=branch_end+jj_bpcb_signed32(jj_vm_rd32(code+branch_end-4));
  if jj_bp_compare_terminator(plan,lhs_pc,branch_pc,branch_pc+5,target_pc)==0{return 0;}var lhs:i64=jj_vm_rd16(program+lhs_pc+1);var rhs:i64=jj_vm_rd16(program+rhs_pc+1);if end-jj_rc_history_get(h,79)!=35{return 0;}
  var d:[5]i64;d[0]=lhs;d[1]=rhs;d[2]=comparison;d[3]=target_machine;d[4]=entry_target;if jj_bpcb_emit(code,jj_rc_history_get(h,79),end,d as *i64)==0{return 0;}
  var fgr:*i64=receipts[0] as *i64;var reo:*i64=receipts[1] as *i64;var reom:*i64=receipts[2] as *i64;if fgr==0{return 0-1;}if reo==0{return 0-1;}if reom==0{return 0-1;}fgr[0]=jj_rc_history_get(h,81);reo[0]=jj_rc_history_get(h,82);var packed:i64=jj_rc_history_get(h,83);var count:i64=(packed>>>16)&65535;var fp:i64=(packed>>>32)&65535;var ndr:i64=(packed>>>48)&65535;if count>=65535{return 0-1;}if ndr>65533{return 0-1;}var token:i64=(0x45+lhs*3+rhs*5+comparison*7+entry_target*11)&65535;reom[0]=(packed&65535)|((count+1)<<16)|(((fp*257+token)&65535)<<32)|((ndr+2)<<48);return 1;
}

// CFG-authorized scalar if-conversion. A strict diamond whose two arms only
// update the same local with a pure immediate ALU operation is expressed as
// two candidates plus CMOV before machine bytes are frozen. The surrounding
// legacy geometry is emitted first so offsets remain valid. The canonical 77-byte
// diamond carries an authenticated marker and cold-tail relayout removes its padding.
extern fn jj_n_e8(p0:*i64,p1:i64)->i64;
extern fn jj_n_e32(p0:*i64,p1:i64)->i64;
extern fn jj_n_e64(p0:*i64,p1:i64)->i64;
extern fn jj_n_offset_for_pc(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_express_sink_output(p0:*i64)->i64;
extern fn jj_express_sink_capacity(p0:*i64)->i64;
extern fn jj_express_sink_cursor(p0:*i64)->i64;
extern fn jj_bp_block_index(p0:*i64,p1:i64)->i64;
extern fn jj_target_ifc_choice(p0:i64,p1:i64)->i64;
extern fn jj_n_bc_len(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_coldtail_map_index(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_reo_nop_match(p0:*i8,p1:i64,p2:i64)->i64;

fn jj_ifc_pure_op(op:i64)->i64{
  if op==9{return 1;}if op==10{return 1;}if op==16{return 1;}if op==17{return 1;}if op==18{return 1;}return 0;
}
fn jj_ifc_fold(v:i64)->i64{return (v&65535)^((v>>>16)&65535)^((v>>>32)&65535)^((v>>>48)&65535);}
fn jj_ifc_token(true_op:i64,true_imm:i64,false_op:i64,false_imm:i64)->i64{return (0x91+true_op*3+false_op*5+jj_ifc_fold(true_imm)*7+jj_ifc_fold(false_imm)*11)&65535;}
fn jj_ifc_loop_hot(plan:*i64,pc:i64)->i64{if plan==0{return 0;}var bi:i64=jj_bp_block_index(plan,pc);if bi<0{return 0;}var flags:i64=plan[16+bi*8+6];if (flags&32)!=0{return 1;}return 0;}
fn jj_ifc_emit_op(state:*i64,op:i64,modrm:i64)->i64{
  if jj_ifc_pure_op(op)==0{return 0;}if jj_n_e8(state,0x48)==0{return 0;}
  if op==9{if jj_n_e8(state,0x01)==0{return 0;}}
  else{if op==10{if jj_n_e8(state,0x29)==0{return 0;}}
  else{if op==16{if jj_n_e8(state,0x21)==0{return 0;}}
  else{if op==17{if jj_n_e8(state,0x09)==0{return 0;}}
  else{if jj_n_e8(state,0x31)==0{return 0;}}}}}
  return jj_n_e8(state,modrm);
}
fn jj_ifc_cfg(plan:*i64,r:*i64)->i64{
  if plan==0{return 0;}if r==0{return 0;}if plan[0]!=0x4a4a42504c414e31{return 0;}if plan[1]!=1{return 0;}var branch_pc:i64=r[0];var true_pc:i64=r[1];var false_pc:i64=r[2];var true_jump:i64=r[3];var join_pc:i64=r[4];var false_last:i64=r[5];
  var count:i64=plan[2];if count<=0{return 0;}var condition:i64=0-1;var i:i64=0;
  while i<count{var b:i64=16+i*8;if plan[b+2]==branch_pc{condition=i;}i=i+1;}if condition<0{return 0;}
  var ci:i64=16+condition*8;if plan[ci+1]!=true_pc{return 0;}if plan[ci+3]!=false_pc{return 0;}if plan[ci+4]!=true_pc{return 0;}if (plan[ci+6]&2)==0{return 0;}
  var ti:i64=jj_bp_block_index(plan,true_pc);var fi:i64=jj_bp_block_index(plan,false_pc);var ji:i64=jj_bp_block_index(plan,join_pc);if ti<0{return 0;}if fi<0{return 0;}if ji<0{return 0;}
  var tb:i64=16+ti*8;var fb:i64=16+fi*8;var jb:i64=16+ji*8;
  if plan[tb+1]!=false_pc{return 0;}if plan[tb+2]!=true_jump{return 0;}if plan[tb+3]!=join_pc{return 0;}if plan[tb+4]>=0{return 0;}if plan[tb+5]!=1{return 0;}
  if plan[fb+1]!=join_pc{return 0;}if plan[fb+2]!=false_last{return 0;}if plan[fb+3]!=join_pc{return 0;}if plan[fb+4]>=0{return 0;}if plan[fb+5]!=1{return 0;}
  if plan[jb+5]!=2{return 0;}return 1;
}

// Return: 0 no legal diamond, -1 malformed/internal failure, >0 join bytecode PC.
// record: join, local slot, true op, true immediate, false op, false immediate.
fn jj_ifc_match(program:*i8,start:i64,end:i64,pc:i64,plan:*i64,record:*i64)->i64{
  if program==0{return 0-1;}if plan==0{return 0-1;}if record==0{return 0-1;}if pc<start{return 0-1;}if pc+5>end{return 0-1;}if program[pc]!=28{return 0;}
  var false_pc:i64=jj_vm_rd32(program+pc+1);var true_pc:i64=pc+5;if false_pc<=true_pc{return 0;}if false_pc>=end{return 0;}
  var p:i64=true_pc;if p+3>end{return 0;}if program[p]!=2{return 0;}var slot:i64=jj_vm_rd16(program+p+1);p=p+3;
  if p+9>end{return 0;}if program[p]!=1{return 0;}var true_imm:i64=jj_vm_rd64(program+p+1);p=p+9;
  if p>=end{return 0;}var true_op:i64=program[p];if jj_ifc_pure_op(true_op)==0{return 0;}p=p+1;
  if p+3>end{return 0;}if program[p]!=3{return 0;}if jj_vm_rd16(program+p+1)!=slot{return 0;}p=p+3;
  var true_jump:i64=p;if p+5>end{return 0;}if program[p]!=27{return 0;}var join_pc:i64=jj_vm_rd32(program+p+1);p=p+5;if p!=false_pc{return 0;}
  if p+3>end{return 0;}if program[p]!=2{return 0;}if jj_vm_rd16(program+p+1)!=slot{return 0;}p=p+3;
  if p+9>end{return 0;}if program[p]!=1{return 0;}var false_imm:i64=jj_vm_rd64(program+p+1);p=p+9;
  if p>=end{return 0;}var false_op:i64=program[p];if jj_ifc_pure_op(false_op)==0{return 0;}p=p+1;
  var false_last:i64=p;if p+3>end{return 0;}if program[p]!=3{return 0;}if jj_vm_rd16(program+p+1)!=slot{return 0;}p=p+3;
  if p!=join_pc{return 0;}if join_pc>=end{return 0;}var cfg:[6]i64;cfg[0]=pc;cfg[1]=true_pc;cfg[2]=false_pc;cfg[3]=true_jump;cfg[4]=join_pc;cfg[5]=false_last;if jj_ifc_cfg(plan,cfg as *i64)==0{return 0;}
  record[0]=join_pc;record[1]=slot;record[2]=true_op;record[3]=true_imm;record[4]=false_op;record[5]=false_imm;return join_pc;
}

fn jj_ifc_try_emit(state:*i64,program:*i8,start:i64,end:i64,pc:i64,context:*i64)->i64{
  if state==0{return 0-1;}if context==0{return 0-1;}context[2]=0-1;var plan:*i64=context[0] as *i64;var reom:*i64=context[1] as *i64;if plan==0{return 0-1;}if reom==0{return 0-1;}var record:[6]i64;var join_pc:i64=jj_ifc_match(program,start,end,pc,plan,record as *i64);if join_pc<=0{return join_pc;}var cost_facts:i64=1|(1<<8)|(2<<16)|(1<<26)|(1<<27);if jj_ifc_loop_hot(plan,pc)!=0{cost_facts=cost_facts|(1<<25);}if jj_target_ifc_choice(5,cost_facts)!=1{return 0;}var slot:i64=record[1];var true_op:i64=record[2];var true_imm:i64=record[3];var false_op:i64=record[4];var false_imm:i64=record[5];var receipt:i64=reom[0];var reaction_count:i64=(receipt>>>16)&65535;var fingerprint:i64=(receipt>>>32)&65535;var ndr:i64=(receipt>>>48)&65535;if reaction_count>=65535{return 0-1;}if ndr>=65535{return 0-1;}var token:i64=jj_ifc_token(true_op,true_imm,false_op,false_imm);
  var argc:i64=0;var current_off:i64=jj_n_offset_for_pc(program,start,end,argc,pc);var join_off:i64=jj_n_offset_for_pc(program,start,end,argc,join_pc);
  // Offset differences are independent of the prologue argc contribution.
  if current_off<0{return 0-1;}if join_off<=current_off{return 0-1;}var region:i64=join_off-current_off;if region<51{return 0;}
  var cursor:*i64=jj_express_sink_cursor(state) as *i64;var begin:i64=cursor[0];var limit:i64=begin+region;if limit<begin{return 0-1;}if limit>jj_express_sink_capacity(state){return 0-1;}
  if jj_n_e8(state,0x5a)==0{return 0-1;}
  if jj_n_e8(state,0x48)==0{return 0-1;}if jj_n_e8(state,0x8b)==0{return 0-1;}if jj_n_e8(state,0x85)==0{return 0-1;}if jj_n_e32(state,0-((slot+1)*8))==0{return 0-1;}
  if jj_n_e8(state,0x48)==0{return 0-1;}if jj_n_e8(state,0x89)==0{return 0-1;}if jj_n_e8(state,0xc1)==0{return 0-1;}
  if jj_n_e8(state,0x48)==0{return 0-1;}if jj_n_e8(state,0xbe)==0{return 0-1;}if jj_n_e64(state,true_imm)==0{return 0-1;}if jj_ifc_emit_op(state,true_op,0xf0)==0{return 0-1;}
  if jj_n_e8(state,0x48)==0{return 0-1;}if jj_n_e8(state,0xbe)==0{return 0-1;}if jj_n_e64(state,false_imm)==0{return 0-1;}if jj_ifc_emit_op(state,false_op,0xf1)==0{return 0-1;}
  if jj_n_e8(state,0x48)==0{return 0-1;}if jj_n_e8(state,0x85)==0{return 0-1;}if jj_n_e8(state,0xd2)==0{return 0-1;}
  if jj_n_e8(state,0x48)==0{return 0-1;}if jj_n_e8(state,0x0f)==0{return 0-1;}if jj_n_e8(state,0x44)==0{return 0-1;}if jj_n_e8(state,0xc1)==0{return 0-1;}
  if jj_n_e8(state,0x48)==0{return 0-1;}if jj_n_e8(state,0x89)==0{return 0-1;}if jj_n_e8(state,0x85)==0{return 0-1;}if jj_n_e32(state,0-((slot+1)*8))==0{return 0-1;}
  var at:i64=cursor[0];if at>limit{return 0-1;}var code:*i8=jj_express_sink_output(state) as *i8;if code==0{return 0-1;}if region==77{if at-begin!=51{return 0-1;}if jj_reo_nop(code,at,limit-5)==0{return 0-1;}code[limit-5]=0x0f;code[limit-4]=0x1f;code[limit-3]=0x44;code[limit-2]=0;code[limit-1]=0x4f;}else{if jj_reo_nop(code,at,limit)==0{return 0-1;}}cursor[0]=limit;context[2]=slot;reom[0]=(receipt&65535)|((reaction_count+1)<<16)|(((fingerprint*257+token)&65535)<<32)|((ndr+1)<<48);return join_pc;
}


// R773 direct Boolean authority for hot if-converted diamonds.
// Exact semantic shape: load local, const 1, AND, const 0, NE, IFC branch.
// After loop-temp publication the legacy machine region is 48 bytes and ends
// with the IFC condition pop. Preserve offsets, replace materialization with
// RDX=(R8&1), and leave authenticated long NOPs. No branch is introduced.
fn jj_ifc_bool_direct_old_shape(code:*i8,begin:i64,end:i64)->i64{
  if code==0{return 0;}if begin<0{return 0;}if end-begin!=48{return 0;}var p:*i8=code+begin;
  if p[0]!=0x4c{return 0;}if (p[1]&255)!=0x89{return 0;}if (p[2]&255)!=0xc0{return 0;}
  if p[3]!=0x0f{return 0;}if p[4]!=0x1f{return 0;}if p[5]!=0x40{return 0;}if p[6]!=0x65{return 0;}
  if p[7]!=0x48{return 0;}if (p[8]&255)!=0x81{return 0;}if (p[9]&255)!=0xe0{return 0;}if jj_vm_rd32(p+10)!=1{return 0;}
  if p[14]!=0x50{return 0;}if jj_reo_nop_match(p,15,23)==0{return 0;}if p[23]!=0x58{return 0;}
  if p[24]!=0x48{return 0;}if (p[25]&255)!=0x81{return 0;}if (p[26]&255)!=0xf8{return 0;}if jj_vm_rd32(p+27)!=0{return 0;}
  if p[31]!=0x0f{return 0;}if (p[32]&255)!=0x95{return 0;}if (p[33]&255)!=0xc0{return 0;}
  if p[34]!=0x48{return 0;}if p[35]!=0x0f{return 0;}if (p[36]&255)!=0xb6{return 0;}if (p[37]&255)!=0xc0{return 0;}
  if p[38]!=0x50{return 0;}if jj_reo_nop_match(p,39,47)==0{return 0;}if p[47]!=0x5a{return 0;}return 1;
}
fn jj_ifc_bool_direct_new_shape(code:*i8,begin:i64,end:i64)->i64{
  if code==0{return 0;}if begin<0{return 0;}if end-begin!=48{return 0;}var p:*i8=code+begin;
  if p[0]!=0x4c{return 0;}if (p[1]&255)!=0x89{return 0;}if (p[2]&255)!=0xc2{return 0;}
  if p[3]!=0x48{return 0;}if (p[4]&255)!=0x83{return 0;}if (p[5]&255)!=0xe2{return 0;}if p[6]!=1{return 0;}
  return jj_reo_nop_match(p,7,48);
}
fn jj_ifc_bool_direct_rewrite(code:*i8,begin:i64,end:i64)->i64{
  if jj_ifc_bool_direct_old_shape(code,begin,end)==0{return 0;}var p:*i8=code+begin;
  p[0]=0x4c;p[1]=0x89;p[2]=0xc2;p[3]=0x48;p[4]=0x83;p[5]=0xe2;p[6]=1;
  if jj_reo_nop(p,7,48)==0{return 0;}return jj_ifc_bool_direct_new_shape(code,begin,end);
}
fn jj_ifc_bool_direct_apply(code:*i8,program:*i8,ctx:*i64)->i64{
  if code==0{return 0-1;}if program==0{return 0-1;}if ctx==0{return 0-1;}var start:i64=ctx[0];var end:i64=ctx[1];var argc:i64=ctx[2];var plan:*i64=ctx[3] as *i64;var map:*i64=ctx[4] as *i64;var receipt:*i64=ctx[5] as *i64;if plan==0{return 0-1;}if map==0{return 0-1;}if receipt==0{return 0-1;}
  var index:*i64=map[0] as *i64;var index_count:i64=map[1];var old_size:i64=map[2];if index==0{return 0-1;}if index_count<0{return 0-1;}if old_size<=0{return 0-1;}
  var pc:i64=start;var authorized:i64=0;var observed:i64=0;while pc<end{var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0-1;}if program[pc]==28{
    var r:[6]i64;var join:i64=jj_ifc_match(program,start,end,pc,plan,r as *i64);if join<0{return 0-1;}if join>0{
      var old_branch:i64=jj_n_offset_for_pc(program,start,end,argc,pc);if old_branch<0{return 0-1;}var branch:i64=jj_coldtail_map_index(index,index_count,old_size,old_branch,1);if branch<0{return 0-1;}if branch>=47{
        var begin:i64=branch-47;if jj_ifc_bool_direct_old_shape(code,begin,branch+1)!=0{authorized=authorized+1;if jj_ifc_bool_direct_rewrite(code,begin,branch+1)==0{return 0-1;}if jj_ifc_bool_direct_new_shape(code,begin,branch+1)==0{return 0-1;}}
      }
    }
  }pc=pc+n;}if pc!=end{return 0-1;}if observed!=authorized{return 0-1;}
  if observed>0{var pk:i64=receipt[0];var rc:i64=(pk>>>16)&65535;var fp:i64=(pk>>>32)&65535;var nd:i64=(pk>>>48)&65535;if observed>65535-rc{return 0-1;}if observed>65535-nd{return 0-1;}var i:i64=0;while i<observed{fp=(fp*257+0xb7)&65535;i=i+1;}receipt[0]=(pk&65535)|((rc+observed)<<16)|(fp<<32)|((nd+observed)<<48);}return observed;
}
