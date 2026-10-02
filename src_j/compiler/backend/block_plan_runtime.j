// jj_file: src_j/compiler/backend/block_plan_runtime.j
// cold-tail relayout BlockPlan runtime. block plan analysis remains authoritative; cold-tail relayout adds a
// deterministic in-function relayout pass that removes only validated reaction padding.
// Function extents and inter-function offsets remain fixed; reclaimed bytes move to a cold tail.
extern fn jj_rc_history_get(p0:*i64,p1:i64)->i64;
extern fn jj_vm_rd16(p0:*i8)->i64;
extern fn jj_vm_rd32(p0:*i8)->i64;
extern fn jj_vm_rd64(p0:*i8)->i64;
extern fn jj_n_bc_len(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_bp_build(p0:*i8,p1:i64,p2:i64,p3:*i64)->i64;
extern fn jj_rf_init(p0:*i64)->i64;
extern fn jj_bpcb_try_history(p0:*i8,p1:i64,p2:*i8,p3:*i64,p4:*i64,p5:*i64)->i64;
extern fn jj_rba_try_history(p0:*i8,p1:i64,p2:*i8,p3:*i64,p4:*i64,p5:i64)->i64;
extern fn jj_rbas_try_history(p0:*i8,p1:i64,p2:*i8,p3:*i64,p4:*i64,p5:i64)->i64;
extern fn jj_rf_get(p0:*i64,p1:i64)->i64;
extern fn jj_rf_update_store(p0:*i8,p1:*i64,p2:*i64)->i64;
extern fn jj_rf_clear(p0:*i64)->i64;
extern fn jj_ifc_match(p0:*i8,p1:i64,p2:i64,p3:i64,p4:*i64,p5:*i64)->i64;
extern fn jj_gco(p0:*i8,p1:i64)->i64;
extern fn jj_gcn(p0:*i8,p1:i64)->i64;

extern fn jj_reo_wr32(p0:*i8,p1:i64)->i64;
extern fn jj_reo_nop(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_n_offset_for_pc(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_n_op_size(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_n_arg_pop_size(p0:i64)->i64;
extern fn jj_express_sink_output(p0:*i64)->i64;
extern fn jj_reo_code_hash(p0:*i8,p1:i64)->i64;
extern fn jj_loop_liveout_plan_accumulators(p0:*i64)->i64;
extern fn jj_loop_liveout_apply_accumulators(p0:*i64)->i64;
extern fn jj_loop_liveout_append_stubs(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_loop_liveout_update_receipt(p0:*i64)->i64;
extern fn jj_loop_temp_plan_temps(p0:*i64)->i64;
extern fn jj_loop_temp_apply_temps(p0:*i64)->i64;
extern fn jj_loop_temp_update_receipt(p0:*i64)->i64;
extern fn jj_loop_temp_append_proofs(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_loop_address_plan(p0:*i64)->i64;
extern fn jj_loop_address_apply(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_loop_address_update_receipt(p0:*i64)->i64;
extern fn jj_ifc_bool_direct_apply(p0:*i8,p1:*i8,p2:*i64)->i64;
extern fn jj_loop_invariant_plan(p0:*i64)->i64;
extern fn jj_loop_invariant_apply(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_loop_invariant_update_receipt(p0:*i64)->i64;
extern fn jj_cttxn_prepare(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cttxn_commit(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_xcfg_active(p0:*i64)->i64;
extern fn jj_xcfg_region_count(p0:*i64)->i64;
extern fn jj_xcfg_region(p0:*i64,p1:i64)->i64;
extern fn jj_xcfg_region_valid(p0:*i8,p1:*i64,p2:i64)->i64;
extern fn jj_xcfg_compact_region_valid(p0:*i8,p1:*i64,p2:i64)->i64;
extern fn jj_xcfg_region_pc(p0:*i64,p1:i64)->i64;
extern fn jj_xcfg_fail(p0:*i64,p1:i64,p2:i64)->i64;


fn jj_block_plan_prepare(program:*i8,start:i64,end:i64,plan:*i64,facts:*i64)->i64{
  if program==0{return 0-2;}if plan==0{return 0-2;}if facts==0{return 0-2;}var status:i64=jj_bp_build(program,start,end,plan);if status<0{return 0-2;}if jj_rf_init(facts)==0{return 0-2;}return status;
}
fn jj_block_plan_entry(facts:*i64,is_target:i64)->i64{if facts==0{return 0;}if is_target!=0{return jj_rf_clear(facts);}return 1;}

// ctx: receipts, plan, facts, fail_at, op, plan_status.
fn jj_block_plan_try(code:*i8,end:i64,program:*i8,h:*i64,ctx:*i64)->i64{
  if code==0{return 0-1;}if program==0{return 0-1;}if h==0{return 0-1;}if ctx==0{return 0-1;}
  var receipts:*i64=ctx[0] as *i64;var plan:*i64=ctx[1] as *i64;var facts:*i64=ctx[2] as *i64;var fail_at:i64=ctx[3];var op:i64=ctx[4];var plan_status:i64=ctx[5];if receipts==0{return 0-1;}if plan==0{return 0-1;}if facts==0{return 0-1;}
  if op==28{if plan_status==1{var bs:i64=jj_bpcb_try_history(code,end,program,h,receipts,plan);if bs<0{return 0-1;}if bs!=0{return 1;}}}
  if op==6{var range:i64=0-1;if jj_rc_history_get(h,64)>=0{var slot:i64=jj_vm_rd16(program+jj_rc_history_get(h,64)+1);range=jj_rf_get(facts,slot);}receipts[3]=range;var ls:i64=jj_rba_try_history(code,end,program,h,receipts,fail_at);if ls<0{return 0-1;}if ls!=0{return 1;}}
  else{if op==8{var range2:i64=0-1;if jj_rc_history_get(h,57)>=0{var slot2:i64=jj_vm_rd16(program+jj_rc_history_get(h,57)+1);range2=jj_rf_get(facts,slot2);}receipts[3]=range2;var ss:i64=jj_rbas_try_history(code,end,program,h,receipts,fail_at);if ss<0{return 0-1;}if ss!=0{return 1;}}}
  return 0;
}

fn jj_block_plan_facts_after(program:*i8,h:*i64,facts:*i64,op:i64)->i64{
  if program==0{return 0;}if h==0{return 0;}if facts==0{return 0;}
  if op==3{if jj_rf_update_store(program,h,facts)==0{return 0;}}
  if op==7{return jj_rf_clear(facts);}if op==8{return jj_rf_clear(facts);}if op==27{return jj_rf_clear(facts);}if op==28{return jj_rf_clear(facts);}if op==29{return jj_rf_clear(facts);}if op==33{return jj_rf_clear(facts);}if op==34{return jj_rf_clear(facts);}if op==35{return jj_rf_clear(facts);}if op==36{return jj_rf_clear(facts);}if op==49{return jj_rf_clear(facts);}if op==47{return jj_rf_clear(facts);}return 1;
}


// Compact geometry kinds: 1 compare, 2 checked load, 3 range load,
// 4 checked store, 5 range store, 10 canonical if-conversion. The if-conversion
// region is admitted only for the exact 77-byte legacy geometry and shrinks to 56.
fn jj_coldtail_s32(v:i64)->i64{if v>=0x80000000{return v-0x100000000;}return v;}
fn jj_coldtail_pad(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<0{return 0;}var at:i64=0;
  while n-at>=9{if p[at]!=0x66{return 0;}if p[at+1]!=0x0f{return 0;}if p[at+2]!=0x1f{return 0;}if ((p[at+3])&255)!=0x84{return 0;}var z:i64=4;while z<9{if p[at+z]!=0{return 0;}z=z+1;}at=at+9;}
  var r:i64=n-at;if r==0{return 1;}if r==1{if ((p[at])&255)==0x90{return 1;}}
  if r==2{if p[at]==0x66{if ((p[at+1])&255)==0x90{return 1;}}}
  if r==3{if p[at]==0x0f{if p[at+1]==0x1f{if p[at+2]==0{return 1;}}}}
  if r==4{if p[at]==0x0f{if p[at+1]==0x1f{if p[at+2]==0x40{if p[at+3]==0{return 1;}}}}}
  if r==5{if p[at]==0x0f{if p[at+1]==0x1f{if p[at+2]==0x44{if p[at+3]==0{if p[at+4]==0{return 1;}}}}}}
  if r==6{if p[at]==0x66{if p[at+1]==0x0f{if p[at+2]==0x1f{if p[at+3]==0x44{if p[at+4]==0{if p[at+5]==0{return 1;}}}}}}}
  if r==7{if p[at]==0x0f{if p[at+1]==0x1f{if ((p[at+2])&255)==0x80{var i:i64=3;while i<7{if p[at+i]!=0{return 0;}i=i+1;}return 1;}}}}
  if r==8{if p[at]==0x0f{if p[at+1]==0x1f{if ((p[at+2])&255)==0x84{var j:i64=3;while j<8{if p[at+j]!=0{return 0;}j=j+1;}return 1;}}}}return 0;
}
fn jj_coldtail_marker(p:*i8,at:i64,value:i64)->i64{if p[at]!=0x0f{return 0;}if p[at+1]!=0x1f{return 0;}if p[at+2]!=0x44{return 0;}if p[at+3]!=0{return 0;}if p[at+4]!=value{return 0;}return 1;}
fn jj_coldtail_old_compare(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<35{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x8b{return 0;}if ((p[9])&255)!=0x8d{return 0;}if p[14]!=0x48{return 0;}if p[15]!=0x39{return 0;}if ((p[16])&255)!=0xc8{return 0;}if p[17]!=0x0f{return 0;}if jj_coldtail_pad(p+23,7)==0{return 0;}if jj_coldtail_marker(p,30,0x45)!=0{return 1;}if jj_coldtail_marker(p,30,0x49)!=0{return 1;}return 0;
}
fn jj_coldtail_old_load_checked(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<67{return 0;}if jj_coldtail_marker(p,62,0x41)==0{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x85{return 0;}if ((p[9])&255)!=0xc0{return 0;}if p[10]!=0x0f{return 0;}if ((p[11])&255)!=0x88{return 0;}if p[16]!=0x48{return 0;}if p[17]!=0x3d{return 0;}if p[22]!=0x0f{return 0;}if ((p[23])&255)!=0x83{return 0;}if p[28]!=0x48{return 0;}if ((p[29])&255)!=0x8d{return 0;}if ((p[30])&255)!=0x84{return 0;}if ((p[31])&255)!=0xc5{return 0;}if p[36]!=0x48{return 0;}if ((p[37])&255)!=0x8b{return 0;}if p[38]!=0{return 0;}if p[39]!=0x50{return 0;}return jj_coldtail_pad(p+40,22);
}
fn jj_coldtail_old_load_range(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<67{return 0;}if jj_coldtail_marker(p,62,0x46)==0{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x8d{return 0;}if ((p[9])&255)!=0x84{return 0;}if ((p[10])&255)!=0xc5{return 0;}if p[15]!=0x48{return 0;}if ((p[16])&255)!=0x8b{return 0;}if p[17]!=0{return 0;}if p[18]!=0x50{return 0;}if ((p[19])&255)!=0xeb{return 0;}if p[20]!=46{return 0;}if jj_coldtail_pad(p+21,25)==0{return 0;}if p[46]!=0x0f{return 0;}if p[47]!=0x1f{return 0;}if ((p[48])&255)!=0x84{return 0;}if p[49]!=0{return 0;}if p[54]!=0x0f{return 0;}if p[55]!=0x1f{return 0;}if ((p[56])&255)!=0x84{return 0;}if p[57]!=0{return 0;}return 1;
}
fn jj_coldtail_old_store_checked(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<72{return 0;}var marker:i64=0;if jj_coldtail_marker(p,67,0x42)!=0{marker=1;}if jj_coldtail_marker(p,67,0x44)!=0{marker=1;}if marker==0{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x85{return 0;}if ((p[9])&255)!=0xc0{return 0;}if p[10]!=0x0f{return 0;}if ((p[11])&255)!=0x88{return 0;}if p[16]!=0x48{return 0;}if p[17]!=0x3d{return 0;}if p[22]!=0x0f{return 0;}if ((p[23])&255)!=0x83{return 0;}if p[28]!=0x48{return 0;}if ((p[29])&255)!=0x8b{return 0;}if ((p[30])&255)!=0x8d{return 0;}if p[35]!=0x48{return 0;}if ((p[36])&255)!=0x89{return 0;}if ((p[37])&255)!=0x8c{return 0;}if ((p[38])&255)!=0xc5{return 0;}return jj_coldtail_pad(p+43,24);
}
fn jj_loop_temp_old_store_checked_temp(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<72{return 0;}var marker:i64=0;if jj_coldtail_marker(p,67,0x42)!=0{marker=1;}if jj_coldtail_marker(p,67,0x44)!=0{marker=1;}if marker==0{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x85{return 0;}if ((p[9])&255)!=0xc0{return 0;}if p[10]!=0x0f{return 0;}if ((p[11])&255)!=0x88{return 0;}if p[16]!=0x48{return 0;}if p[17]!=0x3d{return 0;}if p[22]!=0x0f{return 0;}if ((p[23])&255)!=0x83{return 0;}if p[28]!=0x4c{return 0;}if ((p[29])&255)!=0x89{return 0;}if ((p[30])&255)!=0xc1{return 0;}if p[31]!=0x0f{return 0;}if p[32]!=0x1f{return 0;}if p[33]!=0x40{return 0;}if p[34]!=0x65{return 0;}if p[35]!=0x48{return 0;}if ((p[36])&255)!=0x89{return 0;}if ((p[37])&255)!=0x8c{return 0;}if ((p[38])&255)!=0xc5{return 0;}return jj_coldtail_pad(p+43,24);
}
fn jj_coldtail_old_store_range(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<72{return 0;}var marker:i64=0;if jj_coldtail_marker(p,67,0x47)!=0{marker=1;}if jj_coldtail_marker(p,67,0x48)!=0{marker=1;}if marker==0{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x8b{return 0;}if ((p[9])&255)!=0x8d{return 0;}if p[14]!=0x48{return 0;}if ((p[15])&255)!=0x89{return 0;}if ((p[16])&255)!=0x8c{return 0;}if ((p[17])&255)!=0xc5{return 0;}if ((p[22])&255)!=0xeb{return 0;}if p[23]!=48{return 0;}if jj_coldtail_pad(p+24,27)==0{return 0;}if p[51]!=0x0f{return 0;}if p[52]!=0x1f{return 0;}if ((p[53])&255)!=0x84{return 0;}if p[54]!=0{return 0;}if p[59]!=0x0f{return 0;}if p[60]!=0x1f{return 0;}if ((p[61])&255)!=0x84{return 0;}if p[62]!=0{return 0;}return 1;
}

// loop value plan LoopValuePlan v1. It promotes one canonical dead-after-loop induction
// local at a time to caller-saved R10. Unsupported CFG, aliasing, calls,
// escaping addresses or non-canonical latches retain cold-tail relayout byte geometry.
fn jj_loop_value_comp_valid(op:i64)->i64{if op>=19{if op<=24{return 1;}}if op>=40{if op<=43{return 1;}}return 0;}
fn jj_loop_value_overlap(slot:i64,base:i64,count:i64)->i64{if count<=0{return 0;}if slot<base{return 0;}if slot>=base+count{return 0;}return 1;}
fn jj_loop_value_marker8(p:*i8,slot:i64,uses:i64,kind:i64)->i64{if p==0{return 0;}if slot<0{return 0;}if slot>32767{return 0;}if uses<0{return 0;}if uses>255{return 0;}p[0]=0x0f;p[1]=0x1f;p[2]=0x84;p[3]=0;p[4]=slot&255;p[5]=(slot>>>8)&255;p[6]=uses;p[7]=kind;return 1;}
fn jj_loop_value_marker8_check(p:*i8,kind0:i64,kind1:i64)->i64{if p==0{return 0;}if p[0]!=0x0f{return 0;}if p[1]!=0x1f{return 0;}if ((p[2])&255)!=0x84{return 0;}if p[3]!=0{return 0;}var slot:i64=(p[4]&255)|((p[5]&255)<<8);if slot>32767{return 0;}if p[7]==kind0{return 1;}if p[7]==kind1{return 1;}return 0;}
fn jj_loop_value_load_kind(code:*i8,at:i64,limit:i64,slot:i64)->i64{
  if code==0{return 0;}if at<0{return 0;}if at+6>limit{return 0;}var disp:i64=0-((slot+1)*8);
  if ((code[at])&255)==0xff{if ((code[at+1])&255)==0xb5{if jj_coldtail_s32(jj_vm_rd32(code+at+2))==disp{return 1;}}}
  if at+7>limit{return 0;}if code[at]!=0x48{return 0;}if ((code[at+1])&255)!=0x8b{return 0;}if jj_coldtail_s32(jj_vm_rd32(code+at+3))!=disp{return 0;}
  if ((code[at+2])&255)==0x85{return 2;}if ((code[at+2])&255)==0x8d{return 3;}if ((code[at+2])&255)==0x95{return 4;}if ((code[at+2])&255)==0xb5{return 5;}if ((code[at+2])&255)==0xbd{return 6;}return 0;
}
fn jj_loop_value_patch_load(code:*i8,at:i64,limit:i64,slot:i64)->i64{
  var kind:i64=jj_loop_value_load_kind(code,at,limit,slot);if kind==0{return 0;}if kind==1{code[at]=0x41;code[at+1]=0x52;if jj_reo_nop(code,at+2,at+6)==0{return 0;}return 1;}
  code[at]=0x4c;code[at+1]=0x89;if kind==2{code[at+2]=0xd0;}if kind==3{code[at+2]=0xd1;}if kind==4{code[at+2]=0xd2;}if kind==5{code[at+2]=0xd6;}if kind==6{code[at+2]=0xd7;}if jj_reo_nop(code,at+3,at+7)==0{return 0;}return 1;
}
fn jj_loop_value_old_loop_header(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<35{return 0;}if p[0]!=0x4c{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x95{return 0;}var d:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if d>=0{return 0;}if (0-d)%8!=0{return 0;}var slot:i64=(0-d)/8-1;if slot<0{return 0;}if slot>32767{return 0;}
  if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x8b{return 0;}if ((p[9])&255)!=0x8d{return 0;}if p[14]!=0x49{return 0;}if p[15]!=0x39{return 0;}if ((p[16])&255)!=0xca{return 0;}if p[17]!=0x0f{return 0;}if jj_coldtail_pad(p+23,4)==0{return 0;}if jj_loop_value_marker8_check(p+27,0x58,0x59)==0{return 0;}if ((p[27+4]&255)|((p[27+5]&255)<<8))!=slot{return 0;}return 1;
}
fn jj_loop_value_old_loop_latch(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<31{return 0;}if p[0]!=0x49{return 0;}if ((p[1])&255)!=0x81{return 0;}if ((p[2])&255)!=0xc2{return 0;}if jj_vm_rd32(p+3)!=1{return 0;}if jj_coldtail_pad(p+7,16)==0{return 0;}return jj_loop_value_marker8_check(p+23,0x5a,0x5a);
}
fn jj_loop_value_new_loop_header(p:*i8,n:i64)->i64{if p==0{return 0;}if n<31{return 0;}if p[0]!=0x4c{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x95{return 0;}var d:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if d>=0{return 0;}if (0-d)%8!=0{return 0;}var slot:i64=(0-d)/8-1;if slot<0{return 0;}if slot>32767{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x8b{return 0;}if ((p[9])&255)!=0x8d{return 0;}if p[14]!=0x49{return 0;}if p[15]!=0x39{return 0;}if ((p[16])&255)!=0xca{return 0;}if p[17]!=0x0f{return 0;}if jj_loop_value_marker8_check(p+23,0x58,0x59)==0{return 0;}if ((p[27]&255)|((p[28]&255)<<8))!=slot{return 0;}return 1;}
fn jj_loop_value_new_loop_latch(p:*i8,n:i64)->i64{if p==0{return 0;}if n<15{return 0;}if p[0]!=0x49{return 0;}if ((p[1])&255)!=0x81{return 0;}if ((p[2])&255)!=0xc2{return 0;}if jj_vm_rd32(p+3)!=1{return 0;}return jj_loop_value_marker8_check(p+7,0x5a,0x5a);}
fn jj_loop_liveout_marker4_check(p:*i8)->i64{if p==0{return 0;}if p[0]!=0x0f{return 0;}if p[1]!=0x1f{return 0;}if p[2]!=0x40{return 0;}if p[3]==0x5b{return 1;}if p[3]==0x5c{return 1;}return 0;}
fn jj_loop_liveout_old_loop_header(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<35{return 0;}if p[0]!=0x4c{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x95{return 0;}var d:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if d>=0{return 0;}if (0-d)%8!=0{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x8b{return 0;}if ((p[9])&255)!=0x8d{return 0;}if p[14]!=0x49{return 0;}if p[15]!=0x39{return 0;}if ((p[16])&255)!=0xca{return 0;}if p[17]!=0x0f{return 0;}if p[23]!=0x4c{return 0;}if ((p[24])&255)!=0x8b{return 0;}if ((p[25])&255)!=0x9d{return 0;}var a:i64=jj_coldtail_s32(jj_vm_rd32(p+26));if a>=0{return 0;}if (0-a)%8!=0{return 0;}if ((p[30])&255)!=0x90{return 0;}return jj_loop_liveout_marker4_check(p+31);
}
fn jj_loop_liveout_new_loop_header(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<34{return 0;}if p[0]!=0x4c{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x95{return 0;}var d:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if d>=0{return 0;}if (0-d)%8!=0{return 0;}if p[7]!=0x4c{return 0;}if ((p[8])&255)!=0x8b{return 0;}if ((p[9])&255)!=0x9d{return 0;}var a:i64=jj_coldtail_s32(jj_vm_rd32(p+10));if a>=0{return 0;}if (0-a)%8!=0{return 0;}if p[14]!=0x48{return 0;}if ((p[15])&255)!=0x8b{return 0;}if ((p[16])&255)!=0x8d{return 0;}if p[21]!=0x49{return 0;}if p[22]!=0x39{return 0;}if ((p[23])&255)!=0xca{return 0;}if p[24]!=0x0f{return 0;}return jj_loop_liveout_marker4_check(p+30);
}
fn jj_loop_value_latch_original(p:*i8,n:i64,slot:i64)->i64{
  if p==0{return 0;}if n<31{return 0;}var disp:i64=0-((slot+1)*8);if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}if jj_coldtail_s32(jj_vm_rd32(p+3))!=disp{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x81{return 0;}if ((p[9])&255)!=0xc0{return 0;}if jj_vm_rd32(p+10)!=1{return 0;}if p[14]!=0x50{return 0;}if jj_coldtail_pad(p+15,8)==0{return 0;}if p[23]!=0x58{return 0;}if p[24]!=0x48{return 0;}if ((p[25])&255)!=0x89{return 0;}if ((p[26])&255)!=0x85{return 0;}if jj_coldtail_s32(jj_vm_rd32(p+27))!=disp{return 0;}return 1;
}
fn jj_loop_value_plan_one(program:*i8,plan:*i64,ctx:*i64,record:*i64)->i64{
  if program==0{return 0;}if plan==0{return 0;}if ctx==0{return 0;}if record==0{return 0;}var code:*i8=ctx[0] as *i8;var old_size:i64=ctx[1];var start:i64=ctx[2];var end:i64=ctx[3];var argc:i64=ctx[4];var bi:i64=ctx[5];if code==0{return 0;}var b:i64=16+bi*8;var header:i64=plan[b];var hbend:i64=plan[b+1];if (plan[b+6]&8)==0{return 0;}if plan[b+5]!=2{return 0;}
  var p0:i64=header;if program[p0]!=2{return 0;}var p1:i64=p0+jj_n_bc_len(program,p0,end);if p1<=p0{return 0;}if program[p1]!=2{return 0;}var p2:i64=p1+jj_n_bc_len(program,p1,end);if p2<=p1{return 0;}if jj_loop_value_comp_valid(program[p2])==0{return 0;}var p3:i64=p2+jj_n_bc_len(program,p2,end);if p3<=p2{return 0;}if program[p3]!=28{return 0;}var p4:i64=p3+jj_n_bc_len(program,p3,end);if p4!=hbend{return 0;}if plan[b+2]!=p3{return 0;}var exit_pc:i64=jj_vm_rd32(program+p3+1);if exit_pc<=header{return 0;}
  var slot:i64=jj_vm_rd16(program+p0+1);var bound_slot:i64=jj_vm_rd16(program+p1+1);if slot==bound_slot{return 0;}
  var blocks:i64=plan[2];var latch_b:i64=0-1;var li:i64=0;while li<blocks{var lb:i64=16+li*8;if plan[lb+3]==header{if (plan[lb+6]&16)!=0{if latch_b>=0{return 0;}latch_b=li;}}li=li+1;}if latch_b<0{return 0;}var lbase:i64=16+latch_b*8;var latch_begin:i64=plan[lbase];var latch_end:i64=plan[lbase+1];if latch_end!=exit_pc{return 0;}if program[plan[lbase+2]]!=27{return 0;}
  var q0:i64=0-1;var q1:i64=0-1;var q2:i64=0-1;var q3:i64=0-1;var q4:i64=0-1;var pc:i64=latch_begin;while pc<latch_end{q0=q1;q1=q2;q2=q3;q3=q4;q4=pc;var nn:i64=jj_n_bc_len(program,pc,latch_end);if nn<=0{return 0;}pc=pc+nn;}if pc!=latch_end{return 0;}if q0<0{return 0;}if program[q0]!=2{return 0;}if jj_vm_rd16(program+q0+1)!=slot{return 0;}if program[q1]!=1{return 0;}if jj_vm_rd64(program+q1+1)!=1{return 0;}if program[q2]!=9{return 0;}if program[q3]!=3{return 0;}if jj_vm_rd16(program+q3+1)!=slot{return 0;}if program[q4]!=27{return 0;}if jj_vm_rd32(program+q4+1)!=header{return 0;}
  pc=start;while pc<end{var op:i64=program[pc];if op==4{var base:i64=jj_vm_rd16(program+pc+1);var count:i64=jj_vm_rd16(program+pc+3);if jj_loop_value_overlap(slot,base,count)!=0{return 0;}}var nx:i64=pc+jj_n_bc_len(program,pc,end);if nx<=pc{return 0;}pc=nx;}
  pc=header;var uses:i64=0;while pc<exit_pc{var op2:i64=program[pc];if op2==29{return 0;}if op2>=33{if op2<=36{return 0;}}if op2==48{return 0;}if op2==2{if jj_vm_rd16(program+pc+1)==slot{if pc!=p0{if pc!=q0{uses=uses+1;}}}}if op2==3{if jj_vm_rd16(program+pc+1)==slot{if pc!=q3{return 0;}}}if op2==27{var jt:i64=jj_vm_rd32(program+pc+1);if pc==q4{if jt!=header{return 0;}}else{if jt<=header{return 0;}if jt>=exit_pc{return 0;}}}if op2==28{var zt:i64=jj_vm_rd32(program+pc+1);if pc==p3{if zt!=exit_pc{return 0;}}else{if zt<=header{return 0;}if zt>=exit_pc{return 0;}}}var nx2:i64=pc+jj_n_bc_len(program,pc,exit_pc);if nx2<=pc{return 0;}pc=nx2;}if pc!=exit_pc{return 0;}if uses>255{return 0;}
  pc=exit_pc;while pc<end{var op3:i64=program[pc];if op3==2{if jj_vm_rd16(program+pc+1)==slot{return 0;}}if op3==4{var ab:i64=jj_vm_rd16(program+pc+1);var ac:i64=jj_vm_rd16(program+pc+3);if jj_loop_value_overlap(slot,ab,ac)!=0{return 0;}}var nx3:i64=pc+jj_n_bc_len(program,pc,end);if nx3<=pc{return 0;}pc=nx3;}
  var header_old:i64=jj_n_offset_for_pc(program,start,end,argc,header);var latch_old:i64=jj_n_offset_for_pc(program,start,end,argc,q0);var backedge_old:i64=jj_n_offset_for_pc(program,start,end,argc,q4);if header_old<0{return 0;}if latch_old<0{return 0;}if backedge_old<0{return 0;}if header_old+35>old_size{return 0;}if latch_old+31>old_size{return 0;}if backedge_old+5>old_size{return 0;}if jj_coldtail_old_compare(code+header_old,old_size-header_old)==0{return 0;}if jj_loop_value_latch_original(code+latch_old,old_size-latch_old,slot)==0{return 0;}
  pc=header;while pc<exit_pc{if program[pc]==2{if jj_vm_rd16(program+pc+1)==slot{if pc!=p0{if pc!=q0{var mo:i64=jj_n_offset_for_pc(program,start,end,argc,pc);if mo<0{return 0;}if jj_loop_value_load_kind(code,mo,old_size,slot)==0{return 0;}}}}}pc=pc+jj_n_bc_len(program,pc,exit_pc);}
  record[0]=header;record[1]=exit_pc;record[2]=q0;record[3]=q4;record[4]=slot;record[5]=uses;record[6]=header_old;record[7]=latch_old;record[8]=backedge_old;record[9]=program[p3];return 1;
}
fn jj_loop_value_plan_loops(code:*i8,old_size:i64,program:*i8,ctx:*i64,loops:*i64)->i64{
  if code==0{return 0-1;}if program==0{return 0-1;}if ctx==0{return 0-1;}if loops==0{return 0-1;}var plan:*i64=ctx[3] as *i64;if plan==0{return 0-1;}if plan[1]!=1{return 0;}var count:i64=0;var blocks:i64=plan[2];var bi:i64=0;while bi<blocks{var one_ctx:[6]i64;one_ctx[0]=code as i64;one_ctx[1]=old_size;one_ctx[2]=ctx[0];one_ctx[3]=ctx[1];one_ctx[4]=ctx[2];one_ctx[5]=bi;var candidate:[10]i64;var ok:i64=jj_loop_value_plan_one(program,plan,one_ctx as *i64,candidate as *i64);if ok!=0{var overlap:i64=0;var i:i64=0;while i<count{var at:i64=i*10;if candidate[0]<loops[at+1]{if candidate[1]>loops[at]{overlap=1;}}i=i+1;}if overlap==0{if count>=16{return 0-1;}var j:i64=0;while j<10{loops[count*10+j]=candidate[j];j=j+1;}count=count+1;}}bi=bi+1;}return count;
}
fn jj_loop_value_apply_loops(code:*i8,old_size:i64,program:*i8,ctx:*i64,loops:*i64,count:i64)->i64{
  if code==0{return 0;}if program==0{return 0;}if ctx==0{return 0;}if loops==0{return 0;}var start:i64=ctx[0];var end:i64=ctx[1];var argc:i64=ctx[2];var i:i64=0;while i<count{var at:i64=i*10;var header:i64=loops[at];var exit_pc:i64=loops[at+1];var latch_pc:i64=loops[at+2];var slot:i64=loops[at+4];var uses:i64=loops[at+5];var h:i64=loops[at+6];var l:i64=loops[at+7];var entry:i64=0;if code[h+34]==0x49{entry=1;}else{if code[h+34]!=0x45{return 0;}}
    code[h]=0x4c;code[h+1]=0x8b;code[h+2]=0x95;if jj_reo_wr32(code+h+3,0-((slot+1)*8))==0{return 0;}code[h+14]=0x49;code[h+15]=0x39;code[h+16]=0xca;if jj_reo_nop(code,h+23,h+27)==0{return 0;}if jj_loop_value_marker8(code+h+27,slot,uses,0x58+entry)==0{return 0;}
    code[l]=0x49;code[l+1]=0x81;code[l+2]=0xc2;if jj_reo_wr32(code+l+3,1)==0{return 0;}if jj_reo_nop(code,l+7,l+23)==0{return 0;}if jj_loop_value_marker8(code+l+23,slot,uses,0x5a)==0{return 0;}
    var pc:i64=header;while pc<exit_pc{if program[pc]==2{if jj_vm_rd16(program+pc+1)==slot{if pc!=header{if pc!=latch_pc{var mo:i64=jj_n_offset_for_pc(program,start,end,argc,pc);if mo<0{return 0;}if jj_loop_value_patch_load(code,mo,old_size,slot)==0{return 0;}}}}}var nx:i64=pc+jj_n_bc_len(program,pc,exit_pc);if nx<=pc{return 0;}pc=nx;}i=i+1;}return 1;
}


fn jj_coldtail_affine_shape(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<51{return 0;}if p[0]!=0x48{return 0;}if (p[1]&255)!=0x8b{return 0;}if (p[2]&255)!=0x85{return 0;}var acc:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if acc>=0{return 0;}if (0-acc)%8!=0{return 0;}
  if p[7]!=0x48{return 0;}if (p[8]&255)!=0x69{return 0;}if (p[9]&255)!=0xc0{return 0;}if jj_vm_rd32(p+10)!=10{return 0;}
  if p[14]!=0x48{return 0;}if (p[15]&255)!=0x8b{return 0;}if (p[16]&255)!=0x8d{return 0;}var base:i64=jj_coldtail_s32(jj_vm_rd32(p+17));if base>=0{return 0;}if (0-base)%8!=0{return 0;}
  if p[21]!=0x48{return 0;}if (p[22]&255)!=0x8b{return 0;}if (p[23]&255)!=0x95{return 0;}var index:i64=jj_coldtail_s32(jj_vm_rd32(p+24));if index>=0{return 0;}if (0-index)%8!=0{return 0;}
  if acc==base{return 0;}if acc==index{return 0;}if base==index{return 0;}if p[28]!=0x0f{return 0;}if (p[29]&255)!=0xb6{return 0;}if p[30]!=0x0c{return 0;}if p[31]!=0x11{return 0;}
  if p[32]!=0x48{return 0;}if (p[33]&255)!=0x83{return 0;}if (p[34]&255)!=0xe9{return 0;}if p[35]!=48{return 0;}if p[36]!=0x48{return 0;}if p[37]!=0x01{return 0;}if (p[38]&255)!=0xc8{return 0;}
  if p[39]!=0x48{return 0;}if (p[40]&255)!=0x89{return 0;}if (p[41]&255)!=0x85{return 0;}if jj_coldtail_s32(jj_vm_rd32(p+42))!=acc{return 0;}return jj_coldtail_marker(p,46,0x53);
}
fn jj_coldtail_old_affine(p:*i8,n:i64)->i64{if n<79{return 0;}if jj_coldtail_affine_shape(p,n)==0{return 0;}return jj_coldtail_pad(p+51,28);}
fn jj_coldtail_new_affine(p:*i8,n:i64)->i64{return jj_coldtail_affine_shape(p,n);}
fn jj_coldtail_old_ifc(p:*i8,n:i64)->i64{if p==0{return 0;}if n<77{return 0;}if p[0]!=0x5a{return 0;}if p[37]!=0x48{return 0;}if ((p[38])&255)!=0x85{return 0;}if ((p[39])&255)!=0xd2{return 0;}if p[40]!=0x48{return 0;}if p[41]!=0x0f{return 0;}if p[42]!=0x44{return 0;}if ((p[43])&255)!=0xc1{return 0;}if jj_coldtail_marker(p,72,0x4f)==0{return 0;}return jj_coldtail_pad(p+51,21);}
fn jj_coldtail_new_ifc(p:*i8,n:i64)->i64{if p==0{return 0;}if n<56{return 0;}if p[0]!=0x5a{return 0;}if p[37]!=0x48{return 0;}if ((p[38])&255)!=0x85{return 0;}if ((p[39])&255)!=0xd2{return 0;}if p[40]!=0x48{return 0;}if p[41]!=0x0f{return 0;}if p[42]!=0x44{return 0;}if ((p[43])&255)!=0xc1{return 0;}return jj_coldtail_marker(p,51,0x4f);}
fn jj_coldtail_old_local_identity(p:*i8,n:i64)->i64{if p==0{return 0;}if n<23{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}var d:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if d>=0{return 0;}if (0-d)%8!=0{return 0;}if p[7]!=0x50{return 0;}if jj_coldtail_pad(p+8,10)==0{return 0;}return jj_coldtail_marker(p,18,0x51);}
fn jj_coldtail_old_local_zero(p:*i8,n:i64)->i64{if p==0{return 0;}if n<23{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}var d:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if d>=0{return 0;}if (0-d)%8!=0{return 0;}if p[7]!=0x31{return 0;}if ((p[8])&255)!=0xc0{return 0;}if p[9]!=0x50{return 0;}if jj_coldtail_pad(p+10,8)==0{return 0;}return jj_coldtail_marker(p,18,0x52);}

fn jj_coldtail_mto_disp8(v:i64)->i64{var d:i64=v&255;if d>=128{d=d-256;}if d>=0{return 0;}if (0-d)%8!=0{return 0;}return 1;}
fn jj_coldtail_old_mto_load_load(p:*i8,n:i64)->i64{if p==0{return 0;}if n<12{return 0;}if p[0]!=0x48{return 0;}if (p[1]&255)!=0x8b{return 0;}if (p[2]&255)!=0x45{return 0;}if jj_coldtail_mto_disp8(p[3])==0{return 0;}if p[4]!=0x50{return 0;}if p[5]!=0x50{return 0;}if jj_coldtail_marker(p,6,0x61)==0{return 0;}return jj_coldtail_pad(p+11,1);}
fn jj_coldtail_old_mto_store_store(p:*i8,n:i64)->i64{if p==0{return 0;}if n<16{return 0;}if p[0]!=0x58{return 0;}if p[1]!=0x58{return 0;}if p[2]!=0x48{return 0;}if (p[3]&255)!=0x89{return 0;}if (p[4]&255)!=0x45{return 0;}if jj_coldtail_mto_disp8(p[5])==0{return 0;}if jj_coldtail_marker(p,6,0x62)==0{return 0;}return jj_coldtail_pad(p+11,5);}
fn jj_coldtail_old_mto_roundtrip(p:*i8,n:i64)->i64{if p==0{return 0;}if n<14{return 0;}if p[0]!=0x90{return 0;}if jj_coldtail_marker(p,1,0x63)==0{return 0;}return jj_coldtail_pad(p+6,8);}
fn jj_coldtail_new_mto_load_load(p:*i8,n:i64)->i64{if p==0{return 0;}if n<11{return 0;}if p[0]!=0x48{return 0;}if (p[1]&255)!=0x8b{return 0;}if (p[2]&255)!=0x45{return 0;}if jj_coldtail_mto_disp8(p[3])==0{return 0;}if p[4]!=0x50{return 0;}if p[5]!=0x50{return 0;}return jj_coldtail_marker(p,6,0x61);}
fn jj_coldtail_new_mto_store_store(p:*i8,n:i64)->i64{if p==0{return 0;}if n<11{return 0;}if p[0]!=0x58{return 0;}if p[1]!=0x58{return 0;}if p[2]!=0x48{return 0;}if (p[3]&255)!=0x89{return 0;}if (p[4]&255)!=0x45{return 0;}if jj_coldtail_mto_disp8(p[5])==0{return 0;}return jj_coldtail_marker(p,6,0x62);}
fn jj_coldtail_new_mto_roundtrip(p:*i8,n:i64)->i64{if p==0{return 0;}if n<6{return 0;}if p[0]!=0x90{return 0;}return jj_coldtail_marker(p,1,0x63);}
fn jj_coldtail_old_mto_increment(p:*i8,n:i64)->i64{if p==0{return 0;}if n<31{return 0;}if p[0]!=0x48{return 0;}if (p[1]&255)!=0x83{return 0;}if (p[2]&255)!=0x45{return 0;}if jj_coldtail_mto_disp8(p[3])==0{return 0;}if p[4]<1{return 0;}if p[4]>127{return 0;}if jj_coldtail_marker(p,5,0x64)==0{return 0;}return jj_coldtail_pad(p+10,21);}
fn jj_coldtail_new_mto_increment(p:*i8,n:i64)->i64{if p==0{return 0;}if n<10{return 0;}if p[0]!=0x48{return 0;}if (p[1]&255)!=0x83{return 0;}if (p[2]&255)!=0x45{return 0;}if jj_coldtail_mto_disp8(p[3])==0{return 0;}if p[4]<1{return 0;}if p[4]>127{return 0;}return jj_coldtail_marker(p,5,0x64);}
fn jj_coldtail_old_mto_indexed_load64(p:*i8,n:i64)->i64{if p==0{return 0;}if n<42{return 0;}if p[0]!=0x48{return 0;}if (p[1]&255)!=0x8b{return 0;}if (p[2]&255)!=0x85{return 0;}var a:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if a>=0{return 0;}if (0-a)%8!=0{return 0;}if p[7]!=0x48{return 0;}if (p[8]&255)!=0x8b{return 0;}if (p[9]&255)!=0x8d{return 0;}var b:i64=jj_coldtail_s32(jj_vm_rd32(p+10));if b>=0{return 0;}if (0-b)%8!=0{return 0;}if p[14]!=0x48{return 0;}if (p[15]&255)!=0x8b{return 0;}if p[16]!=0x04{return 0;}if (p[17]&255)!=0xc8{return 0;}if p[18]!=0x50{return 0;}if jj_coldtail_marker(p,19,0x65)==0{return 0;}return jj_coldtail_pad(p+24,18);} 
fn jj_coldtail_new_mto_indexed_load64(p:*i8,n:i64)->i64{if p==0{return 0;}if n<24{return 0;}if p[0]!=0x48{return 0;}if (p[1]&255)!=0x8b{return 0;}if (p[2]&255)!=0x85{return 0;}var a:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if a>=0{return 0;}if (0-a)%8!=0{return 0;}if p[7]!=0x48{return 0;}if (p[8]&255)!=0x8b{return 0;}if (p[9]&255)!=0x8d{return 0;}var b:i64=jj_coldtail_s32(jj_vm_rd32(p+10));if b>=0{return 0;}if (0-b)%8!=0{return 0;}if p[14]!=0x48{return 0;}if (p[15]&255)!=0x8b{return 0;}if p[16]!=0x04{return 0;}if (p[17]&255)!=0xc8{return 0;}if p[18]!=0x50{return 0;}return jj_coldtail_marker(p,19,0x65);} 
fn jj_coldtail_old_kind(p:*i8,n:i64)->i64{if p==0{return 0;}var meta:i64=jj_gco(p,n);if meta!=0{var mk:i64=meta&255;if mk!=((meta>>>8)&255){return 0;}return mk;}if jj_coldtail_old_mto_indexed_load64(p,n)!=0{return 21;}if jj_coldtail_old_mto_increment(p,n)!=0{return 20;}if jj_coldtail_old_mto_load_load(p,n)!=0{return 17;}if jj_coldtail_old_mto_store_store(p,n)!=0{return 18;}if jj_coldtail_old_mto_roundtrip(p,n)!=0{return 19;}if jj_coldtail_old_affine(p,n)!=0{return 15;}if jj_coldtail_old_local_identity(p,n)!=0{return 13;}if jj_coldtail_old_local_zero(p,n)!=0{return 14;}if jj_coldtail_old_ifc(p,n)!=0{return 10;}if jj_loop_liveout_old_loop_header(p,n)!=0{return 8;}if jj_loop_value_old_loop_header(p,n)!=0{return 6;}if jj_loop_value_old_loop_latch(p,n)!=0{return 7;}if n<35{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if jj_coldtail_old_compare(p,n)!=0{return 1;}if jj_coldtail_old_load_checked(p,n)!=0{return 2;}if jj_coldtail_old_load_range(p,n)!=0{return 3;}if jj_coldtail_old_store_checked(p,n)!=0{return 4;}if jj_loop_temp_old_store_checked_temp(p,n)!=0{return 9;}if jj_coldtail_old_store_range(p,n)!=0{return 5;}return 0;}
fn jj_coldtail_new_compare(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<28{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}var ld:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if ld>=0{return 0;}if (0-ld)%8!=0{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x8b{return 0;}if ((p[9])&255)!=0x8d{return 0;}var rd:i64=jj_coldtail_s32(jj_vm_rd32(p+10));if rd>=0{return 0;}if (0-rd)%8!=0{return 0;}if p[14]!=0x48{return 0;}if p[15]!=0x39{return 0;}if ((p[16])&255)!=0xc8{return 0;}if p[17]!=0x0f{return 0;}var cc:i64=(p[18])&255;var valid:i64=0;if cc==0x85{valid=1;}if cc==0x84{valid=1;}if cc==0x8d{valid=1;}if cc==0x8f{valid=1;}if cc==0x8e{valid=1;}if cc==0x8c{valid=1;}if cc==0x83{valid=1;}if cc==0x87{valid=1;}if cc==0x86{valid=1;}if cc==0x82{valid=1;}if valid==0{return 0;}if jj_coldtail_marker(p,23,0x45)!=0{return 1;}if jj_coldtail_marker(p,23,0x49)!=0{return 1;}return 0;
}
fn jj_coldtail_new_load_checked(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<45{return 0;}if jj_coldtail_marker(p,40,0x41)==0{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}var id:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if id>=0{return 0;}if (0-id)%8!=0{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x85{return 0;}if ((p[9])&255)!=0xc0{return 0;}if p[10]!=0x0f{return 0;}if ((p[11])&255)!=0x88{return 0;}if p[16]!=0x48{return 0;}if p[17]!=0x3d{return 0;}var bound:i64=jj_vm_rd32(p+18);if bound<=0{return 0;}if bound>0x7fffffff{return 0;}if p[22]!=0x0f{return 0;}if ((p[23])&255)!=0x83{return 0;}if p[28]!=0x48{return 0;}if ((p[29])&255)!=0x8d{return 0;}if ((p[30])&255)!=0x84{return 0;}if ((p[31])&255)!=0xc5{return 0;}var ad:i64=jj_coldtail_s32(jj_vm_rd32(p+32));if ad>=0{return 0;}if (0-ad)%8!=0{return 0;}if p[36]!=0x48{return 0;}if ((p[37])&255)!=0x8b{return 0;}if p[38]!=0{return 0;}if p[39]!=0x50{return 0;}return 1;
}
fn jj_coldtail_new_load_range(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<42{return 0;}if jj_coldtail_marker(p,37,0x46)==0{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}var id:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if id>=0{return 0;}if (0-id)%8!=0{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x8d{return 0;}if ((p[9])&255)!=0x84{return 0;}if ((p[10])&255)!=0xc5{return 0;}var ad:i64=jj_coldtail_s32(jj_vm_rd32(p+11));if ad>=0{return 0;}if (0-ad)%8!=0{return 0;}if p[15]!=0x48{return 0;}if ((p[16])&255)!=0x8b{return 0;}if p[17]!=0{return 0;}if p[18]!=0x50{return 0;}if ((p[19])&255)!=0xeb{return 0;}if p[20]!=21{return 0;}if p[21]!=0x0f{return 0;}if p[22]!=0x1f{return 0;}if ((p[23])&255)!=0x84{return 0;}if p[24]!=0{return 0;}var maximum:i64=jj_vm_rd32(p+25);if p[29]!=0x0f{return 0;}if p[30]!=0x1f{return 0;}if ((p[31])&255)!=0x84{return 0;}if p[32]!=0{return 0;}var bound:i64=jj_vm_rd32(p+33);if bound<=0{return 0;}if maximum>=bound{return 0;}return 1;
}
fn jj_coldtail_new_store_checked(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<48{return 0;}var mark:i64=0;if jj_coldtail_marker(p,43,0x42)!=0{mark=1;}if jj_coldtail_marker(p,43,0x44)!=0{mark=1;}if mark==0{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}var id:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if id>=0{return 0;}if (0-id)%8!=0{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x85{return 0;}if ((p[9])&255)!=0xc0{return 0;}if p[10]!=0x0f{return 0;}if ((p[11])&255)!=0x88{return 0;}if p[16]!=0x48{return 0;}if p[17]!=0x3d{return 0;}var bound:i64=jj_vm_rd32(p+18);if bound<=0{return 0;}if p[22]!=0x0f{return 0;}if ((p[23])&255)!=0x83{return 0;}if p[28]!=0x48{return 0;}if ((p[29])&255)!=0x8b{return 0;}if ((p[30])&255)!=0x8d{return 0;}var vd:i64=jj_coldtail_s32(jj_vm_rd32(p+31));if vd>=0{return 0;}if (0-vd)%8!=0{return 0;}if p[35]!=0x48{return 0;}if ((p[36])&255)!=0x89{return 0;}if ((p[37])&255)!=0x8c{return 0;}if ((p[38])&255)!=0xc5{return 0;}var ad:i64=jj_coldtail_s32(jj_vm_rd32(p+39));if ad>=0{return 0;}if (0-ad)%8!=0{return 0;}return 1;
}
fn jj_loop_temp_new_store_checked_temp(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<48{return 0;}var mark:i64=0;if jj_coldtail_marker(p,43,0x42)!=0{mark=1;}if jj_coldtail_marker(p,43,0x44)!=0{mark=1;}if mark==0{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}var id:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if id>=0{return 0;}if (0-id)%8!=0{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x85{return 0;}if ((p[9])&255)!=0xc0{return 0;}if p[10]!=0x0f{return 0;}if ((p[11])&255)!=0x88{return 0;}if p[16]!=0x48{return 0;}if p[17]!=0x3d{return 0;}var bound:i64=jj_vm_rd32(p+18);if bound<=0{return 0;}if p[22]!=0x0f{return 0;}if ((p[23])&255)!=0x83{return 0;}if p[28]!=0x4c{return 0;}if ((p[29])&255)!=0x89{return 0;}if ((p[30])&255)!=0xc1{return 0;}if p[31]!=0x0f{return 0;}if p[32]!=0x1f{return 0;}if p[33]!=0x40{return 0;}if p[34]!=0x65{return 0;}if p[35]!=0x48{return 0;}if ((p[36])&255)!=0x89{return 0;}if ((p[37])&255)!=0x8c{return 0;}if ((p[38])&255)!=0xc5{return 0;}var ad:i64=jj_coldtail_s32(jj_vm_rd32(p+39));if ad>=0{return 0;}if (0-ad)%8!=0{return 0;}return 1;
}
fn jj_coldtail_new_store_range(p:*i8,n:i64)->i64{
  if p==0{return 0;}if n<45{return 0;}var mark:i64=0;if jj_coldtail_marker(p,40,0x47)!=0{mark=1;}if jj_coldtail_marker(p,40,0x48)!=0{mark=1;}if mark==0{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}var id:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if id>=0{return 0;}if (0-id)%8!=0{return 0;}if p[7]!=0x48{return 0;}if ((p[8])&255)!=0x8b{return 0;}if ((p[9])&255)!=0x8d{return 0;}var vd:i64=jj_coldtail_s32(jj_vm_rd32(p+10));if vd>=0{return 0;}if (0-vd)%8!=0{return 0;}if p[14]!=0x48{return 0;}if ((p[15])&255)!=0x89{return 0;}if ((p[16])&255)!=0x8c{return 0;}if ((p[17])&255)!=0xc5{return 0;}var ad:i64=jj_coldtail_s32(jj_vm_rd32(p+18));if ad>=0{return 0;}if (0-ad)%8!=0{return 0;}if ((p[22])&255)!=0xeb{return 0;}if p[23]!=21{return 0;}if p[24]!=0x0f{return 0;}if p[25]!=0x1f{return 0;}if ((p[26])&255)!=0x84{return 0;}if p[27]!=0{return 0;}var maximum:i64=jj_vm_rd32(p+28);if p[32]!=0x0f{return 0;}if p[33]!=0x1f{return 0;}if ((p[34])&255)!=0x84{return 0;}if p[35]!=0{return 0;}var bound:i64=jj_vm_rd32(p+36);if bound<=0{return 0;}if maximum>=bound{return 0;}return 1;
}
fn jj_coldtail_new_local_identity(p:*i8,n:i64)->i64{if p==0{return 0;}if n<13{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if ((p[2])&255)!=0x85{return 0;}var d:i64=jj_coldtail_s32(jj_vm_rd32(p+3));if d>=0{return 0;}if (0-d)%8!=0{return 0;}if p[7]!=0x50{return 0;}return jj_coldtail_marker(p,8,0x51);}
fn jj_coldtail_new_local_zero(p:*i8,n:i64)->i64{if p==0{return 0;}if n<8{return 0;}if p[0]!=0x31{return 0;}if ((p[1])&255)!=0xc0{return 0;}if p[2]!=0x50{return 0;}return jj_coldtail_marker(p,3,0x52);}
fn jj_coldtail_new_kind(p:*i8,n:i64)->i64{if p==0{return 0;}var meta:i64=jj_gcn(p,n);if meta!=0{var mk:i64=meta&255;if mk!=((meta>>>8)&255){return 0;}return mk;}if jj_coldtail_new_mto_indexed_load64(p,n)!=0{return 21;}if jj_coldtail_new_mto_increment(p,n)!=0{return 20;}if jj_coldtail_new_mto_load_load(p,n)!=0{return 17;}if jj_coldtail_new_mto_store_store(p,n)!=0{return 18;}if jj_coldtail_new_mto_roundtrip(p,n)!=0{return 19;}if jj_coldtail_new_affine(p,n)!=0{return 15;}if jj_coldtail_new_local_identity(p,n)!=0{return 13;}if jj_coldtail_new_local_zero(p,n)!=0{return 14;}if jj_coldtail_new_ifc(p,n)!=0{return 10;}if jj_loop_liveout_new_loop_header(p,n)!=0{return 8;}if jj_loop_value_new_loop_header(p,n)!=0{return 6;}if jj_loop_value_new_loop_latch(p,n)!=0{return 7;}if n<28{return 0;}if p[0]!=0x48{return 0;}if ((p[1])&255)!=0x8b{return 0;}if jj_coldtail_new_compare(p,n)!=0{return 1;}if jj_coldtail_new_load_checked(p,n)!=0{return 2;}if jj_coldtail_new_load_range(p,n)!=0{return 3;}if jj_coldtail_new_store_checked(p,n)!=0{return 4;}if jj_loop_temp_new_store_checked_temp(p,n)!=0{return 9;}if jj_coldtail_new_store_range(p,n)!=0{return 5;}return 0;}
fn jj_coldtail_old_len(kind:i64)->i64{if kind==1{return 35;}if kind==2{return 67;}if kind==3{return 67;}if kind==4{return 72;}if kind==5{return 72;}if kind==6{return 35;}if kind==7{return 31;}if kind==8{return 35;}if kind==9{return 72;}if kind==10{return 77;}if kind==11{return 17;}if kind==12{return 17;}if kind==13{return 23;}if kind==14{return 23;}if kind==15{return 79;}if kind==16{return 14;}if kind==17{return 12;}if kind==18{return 16;}if kind==19{return 14;}if kind==20{return 31;}if kind==21{return 42;}return 0;}
fn jj_coldtail_new_len(kind:i64)->i64{if kind==1{return 28;}if kind==2{return 45;}if kind==3{return 42;}if kind==4{return 48;}if kind==5{return 45;}if kind==6{return 31;}if kind==7{return 15;}if kind==8{return 34;}if kind==9{return 48;}if kind==10{return 56;}if kind==11{return 7;}if kind==12{return 9;}if kind==13{return 13;}if kind==14{return 8;}if kind==15{return 51;}if kind==16{return 11;}if kind==17{return 11;}if kind==18{return 11;}if kind==19{return 6;}if kind==20{return 10;}if kind==21{return 24;}return 0;}
fn jj_coldtail_map_old(code:*i8,old_size:i64,old_offset:i64,strict:i64)->i64{
  if code==0{return 0-1;}if old_size<=0{return 0-1;}if old_offset<0{return 0-1;}if old_offset>old_size{return 0-1;}var old:i64=0;var now:i64=0;
  while old<old_offset{var kind:i64=jj_coldtail_new_kind(code+now,old_size-old);if kind!=0{var ol:i64=jj_coldtail_old_len(kind);var nl:i64=jj_coldtail_new_len(kind);if old_offset<old+ol{if strict!=0{return 0-1;}return now;}old=old+ol;now=now+nl;}else{old=old+1;now=now+1;}}
  if old!=old_offset{return 0-1;}return now;
}
fn jj_coldtail_copy(out:*i8,at:i64,src:*i8,n:i64)->i64{if out==0{return 0;}if src==0{return 0;}if at<0{return 0;}if n<0{return 0;}var i:i64=0;while i<n{out[at+i]=src[i];i=i+1;}return at+n;}
fn jj_coldtail_compact_bytes(code:*i8,old_size:i64,cfg:*i64)->i64{
  if code==0{return 0;}if old_size<=0{return 0;}var dual:[35]i64;var read:i64=0;var write:i64=0;var count:i64=0;var ri:i64=0;var regions:i64=0;if jj_xcfg_active(cfg)!=0{regions=jj_xcfg_region_count(cfg);if regions<0{return 0;}}
  while read<old_size{var rp:i64=0;var ro:i64=old_size+1;if ri<regions{rp=jj_xcfg_region(cfg,ri);if rp==0{return 0;}ro=rp&0xffffffff;}var rol:i64=(rp>>>32)&255;var rnl:i64=(rp>>>40)&255;if ri<regions{if ro<read{return 0;}}if ro==read{if rol<=0{return 0;}if rnl<=0{return 0;}if rnl>=rol{return 0;}if read+rol>old_size{return 0;}if jj_xcfg_region_valid(code,cfg,ri)==0{return 0;}write=jj_coldtail_copy(code,write,code+read,rnl);if write<=0{return 0;}read=read+rol;ri=ri+1;count=count+1;}else{var kind:i64=jj_coldtail_old_kind(code+read,old_size-read);if kind==0{code[write]=code[read];write=write+1;read=read+1;}else{var region_old_len:i64=jj_coldtail_old_len(kind);if read+region_old_len>ro{return 0;}
    if kind==1{write=jj_coldtail_copy(code,write,code+read,23);if write<=0{return 0;}write=jj_coldtail_copy(code,write,code+read+30,5);if write<=0{return 0;}}
    if kind==2{write=jj_coldtail_copy(code,write,code+read,40);if write<=0{return 0;}write=jj_coldtail_copy(code,write,code+read+62,5);if write<=0{return 0;}}
    if kind==3{write=jj_coldtail_copy(code,write,code+read,21);if write<=0{return 0;}code[write-1]=21;write=jj_coldtail_copy(code,write,code+read+46,21);if write<=0{return 0;}}
    if kind==4{write=jj_coldtail_copy(code,write,code+read,43);if write<=0{return 0;}write=jj_coldtail_copy(code,write,code+read+67,5);if write<=0{return 0;}}
    if kind==9{write=jj_coldtail_copy(code,write,code+read,43);if write<=0{return 0;}write=jj_coldtail_copy(code,write,code+read+67,5);if write<=0{return 0;}}
    if kind==5{write=jj_coldtail_copy(code,write,code+read,24);if write<=0{return 0;}code[write-1]=21;write=jj_coldtail_copy(code,write,code+read+51,21);if write<=0{return 0;}}
    if kind==6{write=jj_coldtail_copy(code,write,code+read,23);if write<=0{return 0;}write=jj_coldtail_copy(code,write,code+read+27,8);if write<=0{return 0;}}
    if kind==7{write=jj_coldtail_copy(code,write,code+read,7);if write<=0{return 0;}write=jj_coldtail_copy(code,write,code+read+23,8);if write<=0{return 0;}}
    if kind==10{write=jj_coldtail_copy(code,write,code+read,51);if write<=0{return 0;}write=jj_coldtail_copy(code,write,code+read+72,5);if write<=0{return 0;}}
    if kind==11{write=jj_coldtail_copy(code,write,code+read,2);if write<=0{return 0;}write=jj_coldtail_copy(code,write,code+read+12,5);if write<=0{return 0;}}
    if kind==12{write=jj_coldtail_copy(code,write,code+read,4);if write<=0{return 0;}write=jj_coldtail_copy(code,write,code+read+12,5);if write<=0{return 0;}}
    if kind==13{write=jj_coldtail_copy(code,write,code+read,8);if write<=0{return 0;}write=jj_coldtail_copy(code,write,code+read+18,5);if write<=0{return 0;}}
    if kind==14{write=jj_coldtail_copy(code,write,code+read+7,3);if write<=0{return 0;}write=jj_coldtail_copy(code,write,code+read+18,5);if write<=0{return 0;}}
    if kind==15{write=jj_coldtail_copy(code,write,code+read,51);if write<=0{return 0;}}
    if kind==16{write=jj_coldtail_copy(code,write,code+read,11);if write<=0{return 0;}}
    if kind==17{write=jj_coldtail_copy(code,write,code+read,11);if write<=0{return 0;}}
    if kind==18{write=jj_coldtail_copy(code,write,code+read,11);if write<=0{return 0;}}
    if kind==19{write=jj_coldtail_copy(code,write,code+read,6);if write<=0{return 0;}}
    if kind==20{write=jj_coldtail_copy(code,write,code+read,10);if write<=0{return 0;}}
    if kind==21{write=jj_coldtail_copy(code,write,code+read,24);if write<=0{return 0;}}
    if kind==8{var di:i64=0;while di<35{dual[di]=code[read+di];di=di+1;}di=0;while di<7{code[write+di]=dual[di];di=di+1;}write=write+7;di=0;while di<7{code[write+di]=dual[23+di];di=di+1;}write=write+7;di=0;while di<16{code[write+di]=dual[7+di];di=di+1;}write=write+16;di=0;while di<4{code[write+di]=dual[31+di];di=di+1;}write=write+4;}
    read=read+jj_coldtail_old_len(kind);count=count+1;
  }}}if read!=old_size{return 0;}if ri!=regions{return 0;}if write>old_size{return 0;}if count==0{return old_size;}if jj_reo_nop(code,write,old_size)==0{return 0;}return write;
}
fn jj_coldtail_old_region_count(code:*i8,old_size:i64,limit:i64)->i64{
  if code==0{return 0-1;}if old_size<=0{return 0-1;}if limit<=0{return 0-1;}var read:i64=0;var count:i64=0;while read<old_size{var kind:i64=jj_coldtail_old_kind(code+read,old_size-read);if kind==0{read=read+1;}else{var length:i64=jj_coldtail_old_len(kind);if length<=0{return 0-1;}read=read+length;count=count+1;if count>=limit{return count;}}}if read!=old_size{return 0-1;}return count;
}
// Compact-region index for arbitrary AST/source-map order.
// Each entry stores old_start,new_start,old_length,new_length. The function
// body is scanned once per source function, then every map is O(region_count).
fn jj_coldtail_index_build(code:*i8,old_size:i64,index:*i64)->i64{
  if code==0{return 0-1;}if index==0{return 0-1;}if old_size<=0{return 0-1;}var old:i64=0;var now:i64=0;var count:i64=0;
  while old<old_size{var kind:i64=jj_coldtail_new_kind(code+now,old_size-old);if kind!=0{if count>=1024{return 0-1;}var ol:i64=jj_coldtail_old_len(kind);var nl:i64=jj_coldtail_new_len(kind);var at:i64=count*4;index[at]=old;index[at+1]=now;index[at+2]=ol;index[at+3]=nl;count=count+1;old=old+ol;now=now+nl;}else{old=old+1;now=now+1;}}
  if old!=old_size{return 0-1;}if now>old_size{return 0-1;}return count;
}
// io[0]=old size, io[1]=index pointer. Explicit regions are declared by the sealed CFG authority.
fn jj_coldtail_index_build_explicit(code:*i8,io:*i64,cfg:*i64)->i64{
  if code==0{return 0-1;}if io==0{return 0-1;}if jj_xcfg_active(cfg)==0{return 0-1;}var old_size:i64=io[0];var index:*i64=io[1] as *i64;if old_size<=0{return 0-1;}if index==0{return 0-1;}var old:i64=0;var now:i64=0;var count:i64=0;var ri:i64=0;var regions:i64=jj_xcfg_region_count(cfg);if regions<0{return 0-1;}
  while old<old_size{var rp:i64=0;var ro:i64=old_size+1;if ri<regions{rp=jj_xcfg_region(cfg,ri);if rp==0{return 0-1;}ro=rp&0xffffffff;}var rol:i64=(rp>>>32)&255;var rnl:i64=(rp>>>40)&255;if ro<old{return 0-1;}if ro==old{if count>=1024{return 0-1;}if rol<=0{return 0-1;}if rnl<=0{return 0-1;}if rnl>=rol{return 0-1;}if jj_xcfg_compact_region_valid(code+now,cfg,ri)==0{return 0-1;}var at:i64=count*4;index[at]=old;index[at+1]=now;index[at+2]=rol;index[at+3]=rnl;count=count+1;old=old+rol;now=now+rnl;ri=ri+1;}else{var kind:i64=jj_coldtail_new_kind(code+now,old_size-old);if kind!=0{var ol:i64=jj_coldtail_old_len(kind);var nl:i64=jj_coldtail_new_len(kind);if old+ol>ro{return 0-1;}if count>=1024{return 0-1;}var at2:i64=count*4;index[at2]=old;index[at2+1]=now;index[at2+2]=ol;index[at2+3]=nl;count=count+1;old=old+ol;now=now+nl;}else{old=old+1;now=now+1;}}}
  if old!=old_size{return 0-1;}if now>old_size{return 0-1;}if ri!=regions{return 0-1;}return count;
}

fn jj_coldtail_map_index(index:*i64,count:i64,old_size:i64,old_offset:i64,strict:i64)->i64{
  if index==0{return 0-1;}if count<0{return 0-1;}if count>1024{return 0-1;}if old_offset<0{return 0-1;}if old_offset>old_size{return 0-1;}var delta:i64=0;var i:i64=0;
  while i<count{var at:i64=i*4;var begin:i64=index[at];var now:i64=index[at+1];var ol:i64=index[at+2];var nl:i64=index[at+3];if ol<=0{return 0-1;}if nl<=0{return 0-1;}if nl>ol{return 0-1;}if old_offset<begin{return old_offset-delta;}if old_offset==begin{return now;}if old_offset<begin+ol{if strict!=0{return 0-1;}return now;}delta=delta+(ol-nl);i=i+1;}
  if old_offset<delta{return 0-1;}return old_offset-delta;
}

fn jj_coldtail_patch_one(code:*i8,map:*i64,new_site:i64,old_site:i64,length:i64)->i64{
  if code==0{return 0;}if map==0{return 0;}var index:*i64=map[0] as *i64;var index_count:i64=map[1];var old_size:i64=map[2];if index==0{return 0;}if new_site<0{return 0;}if old_site<0{return 0;}if length<5{return 0;}var old_disp:i64=jj_coldtail_s32(jj_vm_rd32(code+new_site+length-4));var old_target:i64=old_site+length+old_disp;if old_target<0{return 0;}if old_target>=old_size{return 0;}var new_target:i64=jj_coldtail_map_index(index,index_count,old_size,old_target,1);if new_target<0{return 0;}return jj_reo_wr32(code+new_site+length-4,new_target-(new_site+length));
}
fn jj_coldtail_cfg_region_exact(cfg:*i64,old:i64,lengths:i64)->i64{if jj_xcfg_active(cfg)==0{return 0;}var ol:i64=lengths&255;var nl:i64=(lengths>>>8)&255;var n:i64=jj_xcfg_region_count(cfg);if n<0{return 0;}var i:i64=0;while i<n{var p:i64=jj_xcfg_region(cfg,i);if p==0{return 0;}if (p&0xffffffff)==old{if ((p>>>32)&255)==ol{if ((p>>>40)&255)==nl{return 1;}}}i=i+1;}return 0;}
fn jj_coldtail_patch_compact(code:*i8,map_ctx:*i64,cfg:*i64)->i64{
  if code==0{return 0;}if map_ctx==0{return 0;}var index:*i64=map_ctx[0] as *i64;var index_count:i64=map_ctx[1];var old_size:i64=map_ctx[2];if index==0{return 0;}if index_count<0{return 0;}if index_count>1024{return 0;}var i:i64=0;while i<index_count{var at:i64=i*4;var old:i64=index[at];var now:i64=index[at+1];var ol:i64=index[at+2];var nl:i64=index[at+3];var kind:i64=0;if ol==35{if nl==28{kind=1;}else{if nl==31{kind=6;}else{if nl==34{kind=8;}}}}if ol==31{if nl==15{kind=7;}else{if nl==10{kind=20;}}}if ol==67{if nl==45{kind=2;}else{if nl==42{kind=3;}}}if ol==72{if nl==48{kind=4;}else{if nl==45{kind=5;}}}if ol==77{if nl==56{kind=10;}}if ol==17{if nl==7{kind=11;}else{if nl==9{kind=12;}}}if ol==23{if nl==13{kind=13;}else{if nl==8{kind=14;}}}if ol==79{if nl==51{kind=15;}}if ol==14{if nl==11{kind=16;}else{if nl==6{kind=19;}}}if ol==12{if nl==11{kind=17;}}if ol==16{if nl==11{kind=18;}}if ol==42{if nl==24{kind=21;}}if ol==8{if nl==1{kind=22;}}if ol==6{if nl==3{kind=23;}else{if nl==1{if jj_coldtail_cfg_region_exact(cfg,old,6|(1<<8))!=0{kind=25;}}}}if ol==3{if nl==2{kind=24;}}if kind==0{return 0;}if old<0{return 0;}if old>=old_size{return 0;}if now<0{return 0;}if now>=old_size{return 0;}
    if kind==1{if jj_coldtail_patch_one(code,map_ctx,now+17,old+17,6)==0{return 0;}}
    if kind==2{if jj_coldtail_patch_one(code,map_ctx,now+10,old+10,6)==0{return 0;}if jj_coldtail_patch_one(code,map_ctx,now+22,old+22,6)==0{return 0;}}
    if kind==4{if jj_coldtail_patch_one(code,map_ctx,now+10,old+10,6)==0{return 0;}if jj_coldtail_patch_one(code,map_ctx,now+22,old+22,6)==0{return 0;}}
    if kind==6{if jj_coldtail_patch_one(code,map_ctx,now+17,old+17,6)==0{return 0;}}
    if kind==8{if jj_coldtail_patch_one(code,map_ctx,now+24,old+17,6)==0{return 0;}}
    i=i+1;
  }return 1;
}
fn jj_coldtail_patch_jccs(code:*i8,map:*i64,new_begin:i64,old_begin:i64,new_span:i64)->i64{
  var i:i64=0;while i+6<=new_span{if code[new_begin+i]==0x0f{var cc:i64=(code[new_begin+i+1])&255;if cc>=0x80{if cc<=0x8f{if jj_coldtail_patch_one(code,map,new_begin+i,old_begin+i,6)==0{return 0;}i=i+6;}else{i=i+1;}}else{i=i+1;}}else{i=i+1;}}return 1;
}
fn jj_loop_value_patch_backedges(code:*i8,program:*i8,ctx:*i64,map_ctx:*i64,loops:*i64,count:i64)->i64{
  if code==0{return 0;}if program==0{return 0;}if ctx==0{return 0;}if map_ctx==0{return 0;}if loops==0{return 0;}var index:*i64=map_ctx[0] as *i64;var index_count:i64=map_ctx[1];var old_size:i64=map_ctx[2];if index==0{return 0;}var i:i64=0;while i<count{var at:i64=i*10;var header_old:i64=loops[at+6];var backedge_old:i64=loops[at+8];var header_new:i64=jj_coldtail_map_index(index,index_count,old_size,header_old,1);var backedge_new:i64=jj_coldtail_map_index(index,index_count,old_size,backedge_old,1);if header_new<0{return 0;}if backedge_new<0{return 0;}if ((code[backedge_new])&255)!=0xe9{return 0;}if jj_reo_wr32(code+backedge_new+1,(header_new+7)-(backedge_new+5))==0{return 0;}i=i+1;}return 1;
}
fn jj_coldtail_patch_program(code:*i8,program:*i8,ctx:*i64,map_ctx:*i64)->i64{
  if code==0{return 0;}if program==0{return 0;}if ctx==0{return 0;}if map_ctx==0{return 0;}var index:*i64=map_ctx[0] as *i64;var index_count:i64=map_ctx[1];var old_size:i64=map_ctx[2];if index==0{return 0;}var start:i64=ctx[0];var end:i64=ctx[1];var argc:i64=ctx[2];var function_base:i64=ctx[3];var offsets:*i64=ctx[4] as *i64;var plan:*i64=ctx[5] as *i64;var cfg:*i64=ctx[6] as *i64;if offsets==0{return 0;}if plan==0{return 0;}if jj_coldtail_patch_compact(code,map_ctx,cfg)==0{if jj_xcfg_active(cfg)!=0{jj_xcfg_fail(cfg,(76158<<32)|(start&0xffffffff),0);}return 0;}var pc:i64=start;var old_rel:i64=11+argc*7;var skip_until:i64=0-1;
  while pc<end{
    if skip_until>=0{if pc>=skip_until{skip_until=0-1;}}
    var n:i64=jj_n_bc_len(program,pc,end);if n<=0{if jj_xcfg_active(cfg)!=0{jj_xcfg_fail(cfg,(76150<<32)|(pc&0xffffffff),old_rel);}return 0;}var span:i64=jj_n_op_size(program,pc,end);if span<=0{if jj_xcfg_active(cfg)!=0{jj_xcfg_fail(cfg,(76151<<32)|(pc&0xffffffff),old_rel);}return 0;}var new_rel:i64=jj_coldtail_map_index(index,index_count,old_size,old_rel,1);if new_rel<0{if jj_xcfg_active(cfg)!=0{jj_xcfg_fail(cfg,(76152<<32)|(pc&0xffffffff),old_rel);return 0;}}var op:i64=program[pc];var suppressed:i64=0;if skip_until>=0{if pc<skip_until{suppressed=1;}}
    if suppressed==0{if op==28{var ifc_record:[6]i64;var ifc_join:i64=jj_ifc_match(program,start,end,pc,plan,ifc_record as *i64);if ifc_join<0{return 0;}if ifc_join>0{skip_until=ifc_join;suppressed=1;}}}
    if new_rel>=0{if suppressed==0{
      if op==27{if ((code[new_rel])&255)!=0xe9{if jj_xcfg_active(cfg)!=0{jj_xcfg_fail(cfg,(76153<<32)|(pc&0xffffffff),new_rel);}return 0;}if jj_coldtail_patch_one(code,map_ctx,new_rel,old_rel,5)==0{if jj_xcfg_active(cfg)!=0{jj_xcfg_fail(cfg,(76154<<32)|(pc&0xffffffff),new_rel);}return 0;}}
      if op==28{if jj_coldtail_patch_jccs(code,map_ctx,new_rel,old_rel,span)==0{if jj_xcfg_active(cfg)!=0{jj_xcfg_fail(cfg,(76155<<32)|(pc&0xffffffff),new_rel);}return 0;}}
      if op==29{var ac:i64=program[pc+3];var call_at:i64=new_rel+jj_n_arg_pop_size(ac)+11;if (code[call_at]&255)!=0xe8{return 0;}var called:i64=jj_vm_rd16(program+pc+1);var target:i64=offsets[called];if jj_reo_wr32(code+call_at+1,target-(function_base+call_at+5))==0{return 0;}}
      if op==12{if jj_coldtail_patch_jccs(code,map_ctx,new_rel,old_rel,span)==0{return 0;}}
      if op==13{if jj_coldtail_patch_jccs(code,map_ctx,new_rel,old_rel,span)==0{return 0;}}
      if op==14{if jj_coldtail_patch_jccs(code,map_ctx,new_rel,old_rel,span)==0{return 0;}}
      if op==15{if jj_coldtail_patch_jccs(code,map_ctx,new_rel,old_rel,span)==0{return 0;}}
      if op==37{if jj_coldtail_patch_jccs(code,map_ctx,new_rel,old_rel,span)==0{return 0;}}
      if op==38{if jj_coldtail_patch_jccs(code,map_ctx,new_rel,old_rel,span)==0{return 0;}}
      if op==39{if jj_coldtail_patch_jccs(code,map_ctx,new_rel,old_rel,span)==0{return 0;}}
      if op==45{if jj_coldtail_patch_jccs(code,map_ctx,new_rel,old_rel,span)==0{return 0;}}
    }}
    old_rel=old_rel+span;pc=pc+n;
  }if pc!=end{if jj_xcfg_active(cfg)!=0{jj_xcfg_fail(cfg,(76156<<32)|(pc&0xffffffff),old_rel);}return 0;}if old_rel!=old_size-4{if jj_xcfg_active(cfg)!=0{jj_xcfg_fail(cfg,(76157<<32)|(pc&0xffffffff),old_rel);}return 0;}return 1;
}
fn jj_coldtail_compact_function(code:*i8,old_size:i64,program:*i8,ctx:*i64)->i64{
  if code==0{return 0;}if program==0{return 0;}if ctx==0{return 0;}var start:i64=ctx[0];var end:i64=ctx[1];var argc:i64=ctx[2];var function_base:i64=ctx[3];var offsets:*i64=ctx[4] as *i64;var relocations:*i64=ctx[5] as *i64;var reloc_start:i64=ctx[6];var reloc_end:i64=ctx[7];var reom_receipt:*i64=ctx[9] as *i64;var workspace:*i64=ctx[11] as *i64;var workspace_words:i64=ctx[12];var plan_status:i64=ctx[13];if offsets==0{return 0;}if relocations==0{return 0;}if workspace==0{return 0;}if workspace_words<8778{return 0;}if plan_status<0{return 0;}if plan_status>2{return 0;}if old_size<=0{return 0;}
  if old_size>=12288{var old_regions:i64=jj_coldtail_old_region_count(code,old_size,1024);if old_regions<0{return 0;}if old_regions>=1024{ctx[8]=0;return old_size;}}
  var plan:*i64=workspace;var cfg:*i64=((workspace as i64)+8778*8) as *i64;var cfg_mode:i64=jj_xcfg_active(cfg);var loop_ctx:*i64=((workspace as i64)+4096*8) as *i64;var v2ctx:*i64=((loop_ctx as i64)+4*8) as *i64;var map:*i64=((v2ctx as i64)+15*8) as *i64;var patch_ctx:*i64=((map as i64)+3*8) as *i64;var index:*i64=((workspace as i64)+4226*8) as *i64;var loops:*i64=((workspace as i64)+8322*8) as *i64;var accs:*i64=((loops as i64)+160*8) as *i64;var temps:*i64=((accs as i64)+128*8) as *i64;var address_plan:*i64=((temps as i64)+128*8) as *i64;var invariant_plan:*i64=((address_plan as i64)+16*8) as *i64;if (invariant_plan as i64)+16*8!=(workspace as i64)+8770*8{return 0;}var azi:i64=0;while azi<16{address_plan[azi]=0;invariant_plan[azi]=0;azi=azi+1;}loop_ctx[0]=start;loop_ctx[1]=end;loop_ctx[2]=argc;loop_ctx[3]=plan as i64;v2ctx[0]=code as i64;v2ctx[1]=old_size;v2ctx[2]=program as i64;v2ctx[3]=start;v2ctx[4]=end;v2ctx[5]=argc;v2ctx[6]=plan as i64;v2ctx[7]=loops as i64;v2ctx[8]=0;v2ctx[9]=accs as i64;v2ctx[10]=reom_receipt as i64;v2ctx[11]=ctx[10];v2ctx[12]=temps as i64;v2ctx[13]=address_plan as i64;v2ctx[14]=invariant_plan as i64;var loop_count:i64=0;if plan_status==1{loop_count=jj_loop_value_plan_loops(code,old_size,program,loop_ctx,loops);if loop_count<0{return 0;}v2ctx[8]=loop_count;if loop_count>0{var acc_count:i64=jj_loop_liveout_plan_accumulators(v2ctx);if acc_count<0{return 0;}var temp_count:i64=jj_loop_temp_plan_temps(v2ctx);if temp_count<0{return 0;}var address_count:i64=jj_loop_address_plan(v2ctx);if address_count<0{return 0;}var invariant_count:i64=jj_loop_invariant_plan(v2ctx);if invariant_count<0{return 0;}if jj_cttxn_prepare(workspace,workspace_words,loop_count)==0{return 0;}if jj_loop_value_apply_loops(code,old_size,program,loop_ctx,loops,loop_count)==0{return 0;}if jj_loop_liveout_apply_accumulators(v2ctx)==0{return 0;}if jj_loop_temp_apply_temps(v2ctx)==0{return 0;}}}
  var used:i64=jj_coldtail_compact_bytes(code,old_size,cfg);if used<=0{if cfg_mode!=0{var cpc:i64=jj_xcfg_region_pc(cfg,0);jj_xcfg_fail(cfg,(76032<<32)|(cpc&0xffffffff),0);}return 0;}var index_count:i64=0;if cfg_mode!=0{map[0]=old_size;map[1]=index as i64;index_count=jj_coldtail_index_build_explicit(code,map,cfg);if index_count<0{var ipc:i64=jj_xcfg_region_pc(cfg,0);jj_xcfg_fail(cfg,(76033<<32)|(ipc&0xffffffff),0);return 0;}}else{index_count=jj_coldtail_index_build(code,old_size,index);if index_count<0{return 0;}}map[0]=index as i64;map[1]=index_count;map[2]=old_size;patch_ctx[0]=start;patch_ctx[1]=end;patch_ctx[2]=argc;patch_ctx[3]=function_base;patch_ctx[4]=offsets as i64;patch_ctx[5]=plan as i64;patch_ctx[6]=cfg as i64;if jj_coldtail_patch_program(code,program,patch_ctx,map)==0{if cfg_mode!=0{if cfg[21]==0{jj_xcfg_fail(cfg,(76034<<32)|(start&0xffffffff),0);}}return 0;}if loop_count>0{if jj_loop_value_patch_backedges(code,program,patch_ctx,map,loops,loop_count)==0{return 0;}var with_invariant:i64=jj_loop_invariant_apply(v2ctx,map,used);if with_invariant<=0{return 0;}used=with_invariant;var with_stubs:i64=jj_loop_liveout_append_stubs(v2ctx,map,used);if with_stubs<=0{return 0;}used=with_stubs;var with_address:i64=jj_loop_address_apply(v2ctx,map,used);if with_address<=0{return 0;}used=with_address;var with_proofs:i64=jj_loop_temp_append_proofs(v2ctx,map,used);if with_proofs<=0{return 0;}used=with_proofs;if jj_cttxn_commit(workspace,workspace_words,loop_count)==0{return 0;}}if jj_loop_liveout_update_receipt(v2ctx)==0{return 0;}if jj_loop_temp_update_receipt(v2ctx)==0{return 0;}if jj_loop_address_update_receipt(v2ctx)==0{return 0;}if jj_loop_invariant_update_receipt(v2ctx)==0{return 0;}var bool_ctx:[6]i64;bool_ctx[0]=start;bool_ctx[1]=end;bool_ctx[2]=argc;bool_ctx[3]=plan as i64;bool_ctx[4]=map as i64;bool_ctx[5]=(reom_receipt+ctx[10]) as i64;var bool_direct:i64=jj_ifc_bool_direct_apply(code,program,bool_ctx as *i64);if bool_direct<0{return 0;}var i:i64=reloc_start;while i<reloc_end{var old_abs:i64=relocations[i];if old_abs<function_base{if cfg_mode!=0{jj_xcfg_fail(cfg,(76035<<32)|(start&0xffffffff),old_abs-function_base);}return 0;}if old_abs>=function_base+old_size{if cfg_mode!=0{jj_xcfg_fail(cfg,(76035<<32)|(start&0xffffffff),old_abs-function_base);}return 0;}var mapped:i64=jj_coldtail_map_index(index,index_count,old_size,old_abs-function_base,1);if mapped<0{if cfg_mode!=0{jj_xcfg_fail(cfg,(76035<<32)|(start&0xffffffff),old_abs-function_base);}return 0;}relocations[i]=function_base+mapped;i=i+1;}ctx[8]=loop_count;return used;
}

fn jj_coldtail_finalize(state:*i64,offsets:*i64,function_id:i64,program:*i8,reloc_start:i64,plan_status:i64)->i64{
  if state==0{return 0;}if offsets==0{return 0;}if program==0{return 0;}if plan_status<0{return 0;}if plan_status>2{return 0;}var total:i64=jj_vm_rd64(program+8);var count:i64=jj_vm_rd64(program+16);var table_offset:i64=jj_vm_rd64(program+32);var body_end:i64=jj_vm_rd64(program+40);if table_offset<=48{return 0;}if table_offset>=total{return 0;}if body_end<=48{return 0;}if body_end>table_offset{return 0;}if function_id<0{return 0;}if function_id>=count{return 0;}var table:*i8=program+table_offset;var entry:*i8=table+function_id*32;var start:i64=jj_vm_rd64(entry+8);var argc:i64=jj_vm_rd64(entry+16);var end:i64=body_end;if function_id+1<count{end=jj_vm_rd64(table+(function_id+1)*32+8);}if start>=end{return 0;}var base:i64=offsets[function_id];var bytes:i64=state[2]-base;if bytes<=0{return 0;}var code:*i8=jj_express_sink_output(state) as *i8;var relocations:*i64=state[4] as *i64;var hashes:*i64=state[8] as *i64;var reom_receipts:*i64=state[9] as *i64;var workspace:*i64=state[13] as *i64;var workspace_words:i64=state[14];if code==0{return 0;}if relocations==0{return 0;}if hashes==0{return 0;}if reom_receipts==0{return 0;}if workspace==0{return 0;}if workspace_words<8778{return 0;}var ctx:[14]i64;ctx[0]=start;ctx[1]=end;ctx[2]=argc;ctx[3]=base;ctx[4]=offsets as i64;ctx[5]=relocations as i64;ctx[6]=reloc_start;ctx[7]=state[3];ctx[8]=0;ctx[9]=reom_receipts as i64;ctx[10]=function_id;ctx[11]=workspace as i64;ctx[12]=workspace_words;ctx[13]=plan_status;if reloc_start<0{return 0;}if reloc_start>state[3]{return 0;}var used:i64=jj_coldtail_compact_function(code+base,bytes,program,ctx as *i64);if used<=0{return 0;}var reclaimed:i64=bytes-used;if reclaimed<0{return 0;}if reclaimed>65535{return 0;}var fgr:*i64=state[6] as *i64;if fgr==0{return 0;}fgr[function_id]=(fgr[function_id]&0x0000ffffffffffff)|(reclaimed<<48);hashes[function_id]=jj_reo_code_hash(code+base,bytes);if hashes[function_id]==0{return 0;}return used;
}
