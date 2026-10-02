// Shared non-x86 express object writer for ARM and bounded RV64IM seeds.
// It emits real ELF relocatable objects from sealed architecture-neutral CIR.
extern fn jj_sink_write8_at(p0: *i8, p1: i64, p2: i64, p3: i64) -> i64;
extern fn jj_sink_write16_at(p0: *i8, p1: i64, p2: i64, p3: i64) -> i64;
extern fn jj_sink_write32_at(p0: *i8, p1: i64, p2: i64, p3: i64) -> i64;
extern fn jj_sink_write64_at(p0: *i8, p1: i64, p2: i64, p3: i64) -> i64;
extern fn jj_target_manifest_kind(p0: *i8, p1: i64) -> i64;
extern fn jj_target_return_value(p0: *i8, p1: i64, p2: i64) -> i64;
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_view_valid(p0:*i64)->i64;
extern fn jj_cir_view_bind(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_cir_expression_kind(p0:*i64,p1:i64)->i64;
extern fn jj_cir_operation_count(p0:*i64,p1:i64)->i64;
extern fn jj_cir_operation_opcode(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_operation_immediate(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_immediate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_build_constant(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_function_kind(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_true_immediate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_false_immediate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_direct_load_kind(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_direct_load_offset(p0:*i64,p1:i64)->i64;
extern fn jj_target_profile_build(p0:i64,p1:*i64,p2:i64)->i64;
extern fn jj_target_allocator_build(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_target_allocator_validate_for(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_target_emit_i386_cir(p0:*i8,p1:i64,p2:*i64)->i64;


fn jj_target_cir_overlap(out:*i8,count:i64,cir:*i64,slots:i64)->i64{
  if out==0{return 1;}if cir==0{return 1;}if count<=0{return 1;}if slots<=0{return 1;}
  if slots>0x0fffffffffffffff{return 1;}var cir_bytes:i64=slots*8;
  var ob:i64=out as i64;var cb:i64=cir as i64;if ob<0{return 1;}if cb<0{return 1;}
  if ob>0x7fffffffffffffff-count{return 1;}if cb>0x7fffffffffffffff-cir_bytes{return 1;}
  var oe:i64=ob+count;var ce:i64=cb+cir_bytes;if ob<ce{if cb<oe{return 1;}}return 0;
}

fn jj_target_zero(out: *i8, capacity: i64, count: i64) -> i64 {
  if out==0{return 0;}if count < 0 { return 0; }if count > capacity { return 0; }
  var i: i64 = 0; while i < count { out[i] = 0; i = i + 1; }
  return 1;
}

fn jj_target_write_names(out: *i8, capacity: i64, strtab: i64, shstr: i64) -> i64 {
  var symbol: [10]i64;
  symbol[0]=0;symbol[1]=106;symbol[2]=106;symbol[3]=95;symbol[4]=112;symbol[5]=114;symbol[6]=111;symbol[7]=98;symbol[8]=101;symbol[9]=0;
  var i: i64 = 0; while i < 10 { if jj_sink_write8_at(out,capacity,strtab+i,symbol[i])==0{return 0;}i=i+1; }
  var names: [33]i64;
  names[0]=0;names[1]=46;names[2]=116;names[3]=101;names[4]=120;names[5]=116;names[6]=0;
  names[7]=46;names[8]=115;names[9]=121;names[10]=109;names[11]=116;names[12]=97;names[13]=98;names[14]=0;
  names[15]=46;names[16]=115;names[17]=116;names[18]=114;names[19]=116;names[20]=97;names[21]=98;names[22]=0;
  names[23]=46;names[24]=115;names[25]=104;names[26]=115;names[27]=116;names[28]=114;names[29]=116;names[30]=97;names[31]=98;names[32]=0;
  i=0;while i<33{if jj_sink_write8_at(out,capacity,shstr+i,names[i])==0{return 0;}i=i+1;}return 1;
}

fn jj_aarch64_binary_word(op:i64)->i64{
  if op==9{return 0x8b010000;}if op==10{return 0xcb010000;}if op==11{return 0x9b017c00;}
  if op==16{return 0x8a010000;}if op==17{return 0xaa010000;}if op==18{return 0xca010000;}
  return 0;
}



fn jj_a64_mov_reg(destination:i64,source:i64)->i64{return 0xaa0003e0|((source&31)<<16)|(destination&31);}
fn jj_a64_movz(destination:i64,value:i64)->i64{return 0xd2800000|((value&0xffff)<<5)|(destination&31);}
fn jj_a64_movk(destination:i64,value:i64,half:i64)->i64{return 0xf2800000|((half&3)<<21)|((value&0xffff)<<5)|(destination&31);}
fn jj_a64_put(out:*i8,capacity:i64,at:i64,word:i64)->i64{if jj_sink_write32_at(out,capacity,at,word)==0{return 0;}return at+4;}
fn jj_a64_binary(op:i64,destination:i64,left:i64,right:i64)->i64{
  var base:i64=0;if op==9{base=0x8b000000;}else{if op==10{base=0xcb000000;}else{if op==11{base=0x9b007c00;}
  else{if op==16{base=0x8a000000;}else{if op==17{base=0xaa000000;}else{if op==18{base=0xca000000;}else{return 0;}}}}}}
  return base|((right&31)<<16)|((left&31)<<5)|(destination&31);
}
fn jj_a64_spill_access_count(slot:i64)->i64{if slot<0{return 0;}if slot<=4095{return 1;}if slot>0x1fffff{return 0;}return 2;}
fn jj_a64_spill_word(load:i64,reg:i64,base:i64,slot:i64)->i64{var word:i64=0xf9000000;if load!=0{word=0xf9400000;}return word|((slot&0xfff)<<10)|((base&31)<<5)|(reg&31);}
fn jj_a64_stack_adjust_count(frame:i64)->i64{if frame<0{return 0;}if frame==0{return 0;}if (frame&15)!=0{return 0;}return (frame+4079)/4080;}
fn jj_a64_plan_clear(plan:*i64,slots:i64)->i64{if plan==0{return 0;}if slots<=0{return 0;}var i:i64=0;while i<slots{plan[i]=0;i=i+1;}return 1;}
fn jj_a64_emit_spill(out:*i8,capacity:i64,at:i64,load:i64,reg:i64,slot:i64)->i64{
 var access:i64=jj_a64_spill_access_count(slot);if access==0{return 0;}var need:i64=access*4;if out==0{return 0;}if capacity<need{return 0;}if at<0{return 0;}if at>capacity-need{return 0;}
 if slot<=4095{return jj_a64_put(out,capacity,at,jj_a64_spill_word(load,reg,31,slot));}
 var bytes:i64=slot*8;var pages:i64=bytes>>>12;var low:i64=(bytes&0xfff)>>>3;if pages<=0{return 0;}if pages>4095{return 0;}
 at=jj_a64_put(out,capacity,at,0x914003eb|((pages&0xfff)<<10));if at==0{return 0;}return jj_a64_put(out,capacity,at,jj_a64_spill_word(load,reg,11,low));
}
fn jj_a64_emit_stack_adjust(out:*i8,capacity:i64,at:i64,frame:i64,restore:i64)->i64{
 if frame<=0{return at;}var chunks:i64=jj_a64_stack_adjust_count(frame);if chunks==0{return 0;}var need:i64=chunks*4;if out==0{return 0;}if capacity<need{return 0;}if at<0{return 0;}if at>capacity-need{return 0;}
 var remaining:i64=frame;var base:i64=0xd10003ff;if restore!=0{base=0x910003ff;}
 while remaining>0{var chunk:i64=remaining;if chunk>4080{chunk=4080;}if chunk<=0{return 0;}if (chunk&15)!=0{return 0;}at=jj_a64_put(out,capacity,at,base|((chunk&0xfff)<<10));if at==0{return 0;}remaining=remaining-chunk;}return at;
}
fn jj_a64_plan_kind(plan:*i64,value:i64)->i64{return plan[12+(value-1)*5+1];}
fn jj_a64_plan_index(plan:*i64,value:i64)->i64{return plan[12+(value-1)*5+2];}
fn jj_a64_linear_instruction_count(cir:*i64,plan:*i64)->i64{
  if cir==0{return 0;}if plan==0{return 0;}var count:i64=cir[2];var total:i64=0;var adjust:i64=jj_a64_stack_adjust_count(plan[5]);if plan[5]>0{if adjust<=0{return 0;}total=total+adjust;}
  var value:i64=1;while value<=count{var base:i64=8+(value-1)*4;var op:i64=cir[base];var kind:i64=jj_a64_plan_kind(plan,value);var access:i64=0;
    if op==1{if kind==1{if jj_a64_plan_index(plan,value)!=0{total=total+1;}}else{access=jj_a64_spill_access_count(jj_a64_plan_index(plan,value));if access==0{return 0;}total=total+access;}}
    else{if op==2{total=total+4;if kind==2{access=jj_a64_spill_access_count(jj_a64_plan_index(plan,value));if access==0{return 0;}total=total+access;}}
    else{var left:i64=cir[base+2];var right:i64=cir[base+3];if jj_a64_plan_kind(plan,left)==2{access=jj_a64_spill_access_count(jj_a64_plan_index(plan,left));if access==0{return 0;}total=total+access;}if jj_a64_plan_kind(plan,right)==2{access=jj_a64_spill_access_count(jj_a64_plan_index(plan,right));if access==0{return 0;}total=total+access;}
      total=total+1;if kind==2{access=jj_a64_spill_access_count(jj_a64_plan_index(plan,value));if access==0{return 0;}total=total+access;}}}value=value+1;}
  var result:i64=cir[6];if jj_a64_plan_kind(plan,result)==1{if jj_a64_plan_index(plan,result)!=0{total=total+1;}}else{var result_access:i64=jj_a64_spill_access_count(jj_a64_plan_index(plan,result));if result_access==0{return 0;}total=total+result_access;}
  if plan[5]>0{total=total+adjust;}return total+1;
}
fn jj_a64_emit_constant(out:*i8,capacity:i64,at:i64,destination:i64,value:i64)->i64{
 at=jj_a64_put(out,capacity,at,jj_a64_movz(destination,value));if at==0{return 0;}
 at=jj_a64_put(out,capacity,at,jj_a64_movk(destination,value>>>16,1));if at==0{return 0;}
 at=jj_a64_put(out,capacity,at,jj_a64_movk(destination,value>>>32,2));if at==0{return 0;}
 return jj_a64_put(out,capacity,at,jj_a64_movk(destination,value>>>48,3));
}
fn jj_a64_linear_conservative_total(count:i64,plan_bytes:i64)->i64{
 if count<=0{return 0;}if count>(0x7fffffffffffffff-64)/7{return 0;}var max_frame:i64=count*8;if max_frame>0x7fffffffffffffff-15{return 0;}max_frame=((max_frame+15)/16)*16;var adjust:i64=jj_a64_stack_adjust_count(max_frame);if adjust<=0{return 0;}var instructions:i64=count*7+adjust*2+3;if instructions>(0x7fffffffffffffff-4)/4{return 0;}var code_size:i64=instructions*4;var symtab:i64=(64+code_size+7)&0xfffffffffffffff8;var shoff:i64=(symtab+48+10+40)&0xfffffffffffffff8;var total:i64=shoff+320;if total<=0{return 0;}if total>0x7fffffffffffffff-plan_bytes-7{return 0;}return total+plan_bytes+7;
}
fn jj_target_emit_aarch64_linear(out:*i8,capacity:i64,cir:*i64,cir_slots:i64)->i64{
  if out==0{return 0;}if cir==0{return 0;}var count:i64=cir[2];if count<=0{return 0;}if count>(0x7fffffffffffffff-12)/5{return 0;}var plan_slots:i64=12+count*5;var plan_bytes:i64=plan_slots*8;var conservative:i64=jj_a64_linear_conservative_total(count,plan_bytes);if conservative==0{return 0;}if capacity<conservative{return 0;}if jj_target_cir_overlap(out,capacity,cir,cir_slots)!=0{return 0;}
  var scratch_at:i64=(capacity-plan_bytes)&0xfffffffffffffff8;if scratch_at<=64{return 0;}var plan:*i64=((out as i64)+scratch_at) as *i64;var profile:[32]i64;if jj_target_profile_build(6,profile as *i64,32)==0{return 0;}
  if jj_target_allocator_build(cir,cir_slots,profile as *i64,32,plan,plan_slots)==0{return 0;}if jj_target_allocator_validate_for(cir,cir_slots,profile as *i64,32,plan,plan_slots)==0{jj_a64_plan_clear(plan,plan_slots);return 0;}
  var instructions:i64=jj_a64_linear_instruction_count(cir,plan);if instructions<=0{jj_a64_plan_clear(plan,plan_slots);return 0;}var code_size:i64=instructions*4;
  var symtab:i64=96;if code_size>32{symtab=(64+code_size+7)&0xfffffffffffffff8;}var strtab:i64=symtab+48;var shstr:i64=strtab+10;var shoff:i64=(shstr+40)&0xfffffffffffffff8;
  var total:i64=shoff+320;if total>scratch_at{jj_a64_plan_clear(plan,plan_slots);return 0;}if jj_target_zero(out,capacity,total)==0{jj_a64_plan_clear(plan,plan_slots);return 0;}
  out[0]=0x7f;out[1]=69;out[2]=76;out[3]=70;out[4]=2;out[5]=1;out[6]=1;
  jj_sink_write16_at(out,capacity,16,1);jj_sink_write16_at(out,capacity,18,183);jj_sink_write32_at(out,capacity,20,1);
  jj_sink_write64_at(out,capacity,40,shoff);jj_sink_write16_at(out,capacity,52,64);jj_sink_write16_at(out,capacity,58,64);jj_sink_write16_at(out,capacity,60,5);jj_sink_write16_at(out,capacity,62,4);
  var at:i64=64;var frame:i64=plan[5];if frame>0{at=jj_a64_emit_stack_adjust(out,capacity,at,frame,0);if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}}
  var value:i64=1;while value<=cir[2]{var base:i64=8+(value-1)*4;var op:i64=cir[base];var kind:i64=jj_a64_plan_kind(plan,value);var index:i64=jj_a64_plan_index(plan,value);
    if op==1{if kind==1{if index!=0{at=jj_a64_put(out,capacity,at,jj_a64_mov_reg(index,0));if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}}}
      else{at=jj_a64_emit_spill(out,capacity,at,0,0,index);if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}}}
    else{if op==2{var target:i64=index;if kind==2{target=9;}at=jj_a64_emit_constant(out,capacity,at,target,cir[base+3]);if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}
        if kind==2{at=jj_a64_emit_spill(out,capacity,at,0,target,index);if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}}}
    else{var left_value:i64=cir[base+2];var right_value:i64=cir[base+3];var left:i64=jj_a64_plan_index(plan,left_value);var right:i64=jj_a64_plan_index(plan,right_value);
      if jj_a64_plan_kind(plan,left_value)==2{left=9;at=jj_a64_emit_spill(out,capacity,at,1,left,jj_a64_plan_index(plan,left_value));if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}}
      if jj_a64_plan_kind(plan,right_value)==2{right=10;at=jj_a64_emit_spill(out,capacity,at,1,right,jj_a64_plan_index(plan,right_value));if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}}
      var destination:i64=index;if kind==2{destination=9;}var word:i64=jj_a64_binary(op,destination,left,right);if word==0{jj_a64_plan_clear(plan,plan_slots);return 0;}at=jj_a64_put(out,capacity,at,word);if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}
      if kind==2{at=jj_a64_emit_spill(out,capacity,at,0,destination,index);if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}}}}value=value+1;}
  var result:i64=cir[6];var result_index:i64=jj_a64_plan_index(plan,result);if jj_a64_plan_kind(plan,result)==1{if result_index!=0{at=jj_a64_put(out,capacity,at,jj_a64_mov_reg(0,result_index));if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}}}
  else{at=jj_a64_emit_spill(out,capacity,at,1,0,result_index);if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}}
  if frame>0{at=jj_a64_emit_stack_adjust(out,capacity,at,frame,1);if at==0{jj_a64_plan_clear(plan,plan_slots);return 0;}}at=jj_a64_put(out,capacity,at,0xd65f03c0);if at!=64+code_size{jj_a64_plan_clear(plan,plan_slots);return 0;}
  jj_sink_write32_at(out,capacity,symtab+24,1);out[symtab+28]=0x12;jj_sink_write16_at(out,capacity,symtab+30,1);jj_sink_write64_at(out,capacity,symtab+40,code_size);
  if jj_target_write_names(out,capacity,strtab,shstr)==0{jj_a64_plan_clear(plan,plan_slots);return 0;}var sec:i64=shoff+64;jj_sink_write32_at(out,capacity,sec,1);jj_sink_write32_at(out,capacity,sec+4,1);jj_sink_write64_at(out,capacity,sec+8,6);jj_sink_write64_at(out,capacity,sec+24,64);jj_sink_write64_at(out,capacity,sec+32,code_size);jj_sink_write64_at(out,capacity,sec+48,4);
  sec=sec+64;jj_sink_write32_at(out,capacity,sec,7);jj_sink_write32_at(out,capacity,sec+4,2);jj_sink_write64_at(out,capacity,sec+24,symtab);jj_sink_write64_at(out,capacity,sec+32,48);jj_sink_write32_at(out,capacity,sec+40,3);jj_sink_write32_at(out,capacity,sec+44,1);jj_sink_write64_at(out,capacity,sec+48,8);jj_sink_write64_at(out,capacity,sec+56,24);
  sec=sec+64;jj_sink_write32_at(out,capacity,sec,15);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write64_at(out,capacity,sec+24,strtab);jj_sink_write64_at(out,capacity,sec+32,10);jj_sink_write64_at(out,capacity,sec+48,1);
  sec=sec+64;jj_sink_write32_at(out,capacity,sec,23);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write64_at(out,capacity,sec+24,shstr);jj_sink_write64_at(out,capacity,sec+32,33);jj_sink_write64_at(out,capacity,sec+48,1);jj_a64_plan_clear(plan,plan_slots);return total;
}

fn jj_target_emit_aarch64_cir(out:*i8,capacity:i64,view:*i64)->i64{
  if out==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];
  if jj_cir_validate(cir,slots)==0{return 0;}var cfg_kind:i64=jj_cir_function_kind(cir,slots);var mode:i64=0;
  if cfg_kind==1{mode=4;}else{mode=jj_cir_expression_kind(cir,slots);}if cir[1]==1{if mode==0{return jj_target_emit_aarch64_linear(out,capacity,cir,slots);}}
  if mode<1{return 0;}if mode>4{return 0;}var operations:i64=jj_cir_operation_count(cir,slots);
  var code_size:i64=4;if mode==1{code_size=20;}if mode==4{code_size=44;}
  if mode==3{if operations<=0{return 0;}code_size=4+operations*20;}
  var symtab:i64=96;if code_size>32{symtab=(64+code_size+7)&0xfffffffffffffff8;}
  var strtab:i64=symtab+48;var shstr:i64=strtab+10;var shoff:i64=(shstr+40)&0xfffffffffffffff8;
  var total:i64=shoff+320;if capacity<total{return 0;}if jj_target_cir_overlap(out,total,cir,slots)!=0{return 0;}
  if jj_target_zero(out,capacity,total)==0{return 0;}
  out[0]=0x7f;out[1]=69;out[2]=76;out[3]=70;out[4]=2;out[5]=1;out[6]=1;
  jj_sink_write16_at(out,capacity,16,1);jj_sink_write16_at(out,capacity,18,183);jj_sink_write32_at(out,capacity,20,1);
  jj_sink_write64_at(out,capacity,40,shoff);jj_sink_write16_at(out,capacity,52,64);jj_sink_write16_at(out,capacity,58,64);jj_sink_write16_at(out,capacity,60,5);jj_sink_write16_at(out,capacity,62,4);
  var at:i64=64;if mode==1{at=jj_a64_emit_constant(out,capacity,at,0,jj_cir_immediate(cir,slots));if at==0{return 0;}}
  if mode==3{var oi:i64=0;while oi<operations{var immediate2:i64=jj_cir_operation_immediate(cir,slots,oi);
    at=jj_a64_emit_constant(out,capacity,at,1,immediate2);if at==0{return 0;}
    var word:i64=jj_aarch64_binary_word(jj_cir_operation_opcode(cir,slots,oi));if word==0{return 0;}
    at=jj_a64_put(out,capacity,at,word);if at==0{return 0;}oi=oi+1;}}
  if mode==4{var true_value:i64=jj_cir_function_true_immediate(cir,slots);var false_value:i64=jj_cir_function_false_immediate(cir,slots);
    var else_at:i64=at+24;var delta:i64=(else_at-at)/4;if delta<=0{return 0;}if delta>0x3ffff{return 0;}
    jj_sink_write32_at(out,capacity,at,0xb4000000|((delta&0x7ffff)<<5));at=at+4;
    at=jj_a64_emit_constant(out,capacity,at,0,true_value);if at==0{return 0;}
    jj_sink_write32_at(out,capacity,at,0xd65f03c0);at=at+4;
    at=jj_a64_emit_constant(out,capacity,at,0,false_value);if at==0{return 0;}}
  at=jj_a64_put(out,capacity,at,0xd65f03c0);if at==0{return 0;}if at!=64+code_size{return 0;}
  jj_sink_write32_at(out,capacity,symtab+24,1);out[symtab+28]=0x12;jj_sink_write16_at(out,capacity,symtab+30,1);jj_sink_write64_at(out,capacity,symtab+40,code_size);
  if jj_target_write_names(out,capacity,strtab,shstr)==0{return 0;}
  var sec:i64=shoff+64;jj_sink_write32_at(out,capacity,sec,1);jj_sink_write32_at(out,capacity,sec+4,1);jj_sink_write64_at(out,capacity,sec+8,6);jj_sink_write64_at(out,capacity,sec+24,64);jj_sink_write64_at(out,capacity,sec+32,code_size);jj_sink_write64_at(out,capacity,sec+48,4);
  sec=sec+64;jj_sink_write32_at(out,capacity,sec,7);jj_sink_write32_at(out,capacity,sec+4,2);jj_sink_write64_at(out,capacity,sec+24,symtab);jj_sink_write64_at(out,capacity,sec+32,48);jj_sink_write32_at(out,capacity,sec+40,3);jj_sink_write32_at(out,capacity,sec+44,1);jj_sink_write64_at(out,capacity,sec+48,8);jj_sink_write64_at(out,capacity,sec+56,24);
  sec=sec+64;jj_sink_write32_at(out,capacity,sec,15);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write64_at(out,capacity,sec+24,strtab);jj_sink_write64_at(out,capacity,sec+32,10);jj_sink_write64_at(out,capacity,sec+48,1);
  sec=sec+64;jj_sink_write32_at(out,capacity,sec,23);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write64_at(out,capacity,sec+24,shstr);jj_sink_write64_at(out,capacity,sec+32,33);jj_sink_write64_at(out,capacity,sec+48,1);return total;
}


// Bounded RISC-V RV64IM ELF writer. This is the first RISC-V material
// frontier: real little-endian ELF64 objects and executable seeds, no RVC,
// no atomics, no floating point and no claim of target selfhost.
fn jj_rv64_put(out:*i8,capacity:i64,at:i64,word:i64)->i64{if jj_sink_write32_at(out,capacity,at,word)==0{return 0;}return at+4;}
fn jj_rv64_addi(rd:i64,rs1:i64,imm:i64)->i64{return ((imm&0xfff)<<20)|((rs1&31)<<15)|((rd&31)<<7)|0x13;}
fn jj_rv64_slli(rd:i64,rs1:i64,shift:i64)->i64{if shift<0{return 0;}if shift>63{return 0;}return ((shift&0x3f)<<20)|((rs1&31)<<15)|(1<<12)|((rd&31)<<7)|0x13;}
fn jj_rv64_binary(op:i64,rd:i64,rs1:i64,rs2:i64)->i64{
 var base:i64=0;if op==9{base=0x00000033;}else{if op==10{base=0x40000033;}else{if op==11{base=0x02000033;}else{if op==16{base=0x00007033;}else{if op==17{base=0x00006033;}else{if op==18{base=0x00004033;}else{return 0;}}}}}}
 return base|((rs2&31)<<20)|((rs1&31)<<15)|((rd&31)<<7);
}
fn jj_rv64_beq(rs1:i64,rs2:i64,offset:i64)->i64{
 if offset<=0{return 0;}if (offset&1)!=0{return 0;}if offset>4094{return 0;}var u:i64=offset&0x1fff;
 return (((u>>>12)&1)<<31)|(((u>>>5)&0x3f)<<25)|((rs2&31)<<20)|((rs1&31)<<15)|(((u>>>1)&0x0f)<<8)|(((u>>>11)&1)<<7)|0x63;
}
fn jj_rv64_emit_constant(out:*i8,capacity:i64,at:i64,rd:i64,value:i64)->i64{
 // Six unsigned groups (9 + 5*11 bits) reconstruct every i64 exactly modulo 2^64.
 var top:i64=(value>>>55)&0x1ff;at=jj_rv64_put(out,capacity,at,jj_rv64_addi(rd,0,top));if at==0{return 0;}
 var shift:i64=44;while shift>=0{at=jj_rv64_put(out,capacity,at,jj_rv64_slli(rd,rd,11));if at==0{return 0;}var part:i64=(value>>>shift)&0x7ff;at=jj_rv64_put(out,capacity,at,jj_rv64_addi(rd,rd,part));if at==0{return 0;}shift=shift-11;}return at;
}
fn jj_target_emit_riscv64_cir(out:*i8,capacity:i64,view:*i64)->i64{
 if out==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];if jj_cir_validate(cir,slots)==0{return 0;}
 var cfg_kind:i64=jj_cir_function_kind(cir,slots);var mode:i64=0;if cfg_kind==1{mode=4;}else{mode=jj_cir_expression_kind(cir,slots);}if mode<1{return 0;}if mode>4{return 0;}
 var operations:i64=jj_cir_operation_count(cir,slots);var code_size:i64=4;if mode==1{code_size=48;}if mode==4{code_size=100;}if mode==3{if operations<=0{return 0;}if operations>(0x7fffffffffffffff-4)/48{return 0;}code_size=operations*48+4;}
 var symtab:i64=(64+code_size+7)&0xfffffffffffffff8;var strtab:i64=symtab+48;var shstr:i64=strtab+10;var shoff:i64=(shstr+40)&0xfffffffffffffff8;var total:i64=shoff+320;
 if capacity<total{return 0;}if jj_target_cir_overlap(out,total,cir,slots)!=0{return 0;}if jj_target_zero(out,capacity,total)==0{return 0;}
 out[0]=0x7f;out[1]=69;out[2]=76;out[3]=70;out[4]=2;out[5]=1;out[6]=1;
 if jj_sink_write16_at(out,capacity,16,1)==0{return 0;}if jj_sink_write16_at(out,capacity,18,243)==0{return 0;}if jj_sink_write32_at(out,capacity,20,1)==0{return 0;}
 if jj_sink_write64_at(out,capacity,40,shoff)==0{return 0;}if jj_sink_write32_at(out,capacity,48,0)==0{return 0;}if jj_sink_write16_at(out,capacity,52,64)==0{return 0;}if jj_sink_write16_at(out,capacity,58,64)==0{return 0;}if jj_sink_write16_at(out,capacity,60,5)==0{return 0;}if jj_sink_write16_at(out,capacity,62,4)==0{return 0;}
 var at:i64=64;if mode==1{at=jj_rv64_emit_constant(out,capacity,at,10,jj_cir_immediate(cir,slots));if at==0{return 0;}}
 if mode==3{var oi:i64=0;while oi<operations{at=jj_rv64_emit_constant(out,capacity,at,5,jj_cir_operation_immediate(cir,slots,oi));if at==0{return 0;}var word:i64=jj_rv64_binary(jj_cir_operation_opcode(cir,slots,oi),10,10,5);if word==0{return 0;}at=jj_rv64_put(out,capacity,at,word);if at==0{return 0;}oi=oi+1;}}
 if mode==4{var tv:i64=jj_cir_function_true_immediate(cir,slots);var fv:i64=jj_cir_function_false_immediate(cir,slots);var branch:i64=jj_rv64_beq(10,0,52);if branch==0{return 0;}at=jj_rv64_put(out,capacity,at,branch);if at==0{return 0;}at=jj_rv64_emit_constant(out,capacity,at,10,tv);if at==0{return 0;}at=jj_rv64_put(out,capacity,at,0x00008067);if at==0{return 0;}at=jj_rv64_emit_constant(out,capacity,at,10,fv);if at==0{return 0;}}
 at=jj_rv64_put(out,capacity,at,0x00008067);if at==0{return 0;}if at!=64+code_size{return 0;}
 if jj_sink_write32_at(out,capacity,symtab+24,1)==0{return 0;}out[symtab+28]=0x12;if jj_sink_write16_at(out,capacity,symtab+30,1)==0{return 0;}if jj_sink_write64_at(out,capacity,symtab+40,code_size)==0{return 0;}
 if jj_target_write_names(out,capacity,strtab,shstr)==0{return 0;}var sec:i64=shoff+64;
 jj_sink_write32_at(out,capacity,sec,1);jj_sink_write32_at(out,capacity,sec+4,1);jj_sink_write64_at(out,capacity,sec+8,6);jj_sink_write64_at(out,capacity,sec+24,64);jj_sink_write64_at(out,capacity,sec+32,code_size);jj_sink_write64_at(out,capacity,sec+48,4);
 sec=sec+64;jj_sink_write32_at(out,capacity,sec,7);jj_sink_write32_at(out,capacity,sec+4,2);jj_sink_write64_at(out,capacity,sec+24,symtab);jj_sink_write64_at(out,capacity,sec+32,48);jj_sink_write32_at(out,capacity,sec+40,3);jj_sink_write32_at(out,capacity,sec+44,1);jj_sink_write64_at(out,capacity,sec+48,8);jj_sink_write64_at(out,capacity,sec+56,24);
 sec=sec+64;jj_sink_write32_at(out,capacity,sec,15);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write64_at(out,capacity,sec+24,strtab);jj_sink_write64_at(out,capacity,sec+32,10);jj_sink_write64_at(out,capacity,sec+48,1);
 sec=sec+64;jj_sink_write32_at(out,capacity,sec,23);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write64_at(out,capacity,sec+24,shstr);jj_sink_write64_at(out,capacity,sec+32,33);jj_sink_write64_at(out,capacity,sec+48,1);return total;
}
fn jj_rv64_rd16(p:*i8)->i64{if p==0{return 0;}return (p[0]&255)|((p[1]&255)<<8);}
fn jj_rv64_rd32(p:*i8)->i64{if p==0{return 0;}return (p[0]&255)|((p[1]&255)<<8)|((p[2]&255)<<16)|((p[3]&255)<<24);}
fn jj_rv64_rd64(p:*i8)->i64{if p==0{return 0;}var v:i64=0;var i:i64=0;while i<8{v=v|((p[i]&255)<<(i*8));i=i+1;}return v;}
fn jj_rv64_copy(out:*i8,capacity:i64,at:i64,source:*i8,count:i64)->i64{if out==0{return 0;}if source==0{return 0;}if count<=0{return 0;}if at<0{return 0;}if at>capacity-count{return 0;}var i:i64=0;while i<count{out[at+i]=source[i];i=i+1;}return 1;}
fn jj_rv64_object_text(object:*i8,size:i64,view:*i64)->i64{
 if object==0{return 0;}if view==0{return 0;}if size<384{return 0;}if object[0]!=0x7f{return 0;}if object[1]!=69{return 0;}if object[2]!=76{return 0;}if object[3]!=70{return 0;}if object[4]!=2{return 0;}if object[5]!=1{return 0;}if jj_rv64_rd16(object+16)!=1{return 0;}if jj_rv64_rd16(object+18)!=243{return 0;}if jj_rv64_rd32(object+48)!=0{return 0;}
 var shoff:i64=jj_rv64_rd64(object+40);var entsize:i64=jj_rv64_rd16(object+58);var sections:i64=jj_rv64_rd16(object+60);if entsize!=64{return 0;}if sections!=5{return 0;}if shoff<=0{return 0;}if shoff>size-sections*64{return 0;}
 var text:*i8=object+shoff+64;if jj_rv64_rd32(text+4)!=1{return 0;}if jj_rv64_rd64(text+8)!=6{return 0;}var offset:i64=jj_rv64_rd64(text+24);var count:i64=jj_rv64_rd64(text+32);if offset<64{return 0;}if count<=0{return 0;}if (count&3)!=0{return 0;}if offset>size-count{return 0;}view[0]=offset;view[1]=count;view[2]=offset^count^size^0x525636344f424a31;view[3]=0;return 1;
}
fn jj_rv64_executable_seal(out:*i8,size:i64)->i64{if out==0{return 0;}if size<4116{return 0;}var h:i64=2166136261;var i:i64=4096;while i<size{h=((h^(out[i]&255))*16777619)&0xffffffff;i=i+1;}h=(h^(size&0xffffffff))&0xffffffff;if h==0{h=0x52563634;}return h;}
fn jj_target_riscv64_executable_validate(out:*i8,size:i64)->i64{
 if out==0{return 0;}if size<4116{return 0;}if out[0]!=0x7f{return 0;}if out[1]!=69{return 0;}if out[2]!=76{return 0;}if out[3]!=70{return 0;}if out[4]!=2{return 0;}if out[5]!=1{return 0;}if jj_rv64_rd16(out+16)!=2{return 0;}if jj_rv64_rd16(out+18)!=243{return 0;}if jj_rv64_rd32(out+20)!=1{return 0;}if jj_rv64_rd32(out+48)!=0{return 0;}
 if jj_rv64_rd64(out+24)!=0x101000{return 0;}if jj_rv64_rd64(out+32)!=64{return 0;}if jj_rv64_rd64(out+40)!=0{return 0;}if jj_rv64_rd16(out+52)!=64{return 0;}if jj_rv64_rd16(out+54)!=56{return 0;}if jj_rv64_rd16(out+56)!=1{return 0;}if jj_rv64_rd16(out+60)!=0{return 0;}
 if jj_rv64_rd32(out+64)!=1{return 0;}if jj_rv64_rd32(out+68)!=5{return 0;}if jj_rv64_rd64(out+72)!=0{return 0;}if jj_rv64_rd64(out+80)!=0x100000{return 0;}if jj_rv64_rd64(out+88)!=0x100000{return 0;}if jj_rv64_rd64(out+96)!=size{return 0;}if jj_rv64_rd64(out+104)!=size{return 0;}if jj_rv64_rd64(out+112)!=0x1000{return 0;}if jj_rv64_rd32(out+120)!=0x4a4a5256{return 0;}if jj_rv64_rd32(out+124)!=1{return 0;}if jj_rv64_rd32(out+128)!=jj_rv64_executable_seal(out,size){return 0;}if jj_rv64_rd32(out+132)!=(size&0xffffffff){return 0;}
 if jj_rv64_rd32(out+4096)!=0x00c000ef{return 0;}if jj_rv64_rd32(out+4100)!=0x05d00893{return 0;}if jj_rv64_rd32(out+4104)!=0x00000073{return 0;}if jj_rv64_rd32(out+4108)==0{return 0;}if jj_rv64_rd32(out+size-4)!=0x00008067{return 0;}return 1;
}
fn jj_target_emit_riscv64_executable_cir(out:*i8,capacity:i64,view:*i64)->i64{
 if out==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];if jj_cir_validate(cir,slots)==0{return 0;}if cir[1]!=1{return 0;}if cir[4]!=0{return 0;}if cir[5]!=1{return 0;}
 var words:[1024]i64;var object:*i8=words as *i8;var object_size:i64=jj_target_emit_riscv64_cir(object,8192,view);if object_size<=0{return 0;}var tv:[4]i64;if jj_rv64_object_text(object,object_size,tv as *i64)==0{return 0;}var text_offset:i64=tv[0];var text_size:i64=tv[1];if tv[2]!=(text_offset^text_size^object_size^0x525636344f424a31){return 0;}
 var total:i64=4108+text_size;if total<=4108{return 0;}if capacity<total{return 0;}if jj_target_cir_overlap(out,total,cir,slots)!=0{return 0;}if jj_target_zero(out,capacity,total)==0{return 0;}
 out[0]=0x7f;out[1]=69;out[2]=76;out[3]=70;out[4]=2;out[5]=1;out[6]=1;if jj_sink_write16_at(out,capacity,16,2)==0{return 0;}if jj_sink_write16_at(out,capacity,18,243)==0{return 0;}if jj_sink_write32_at(out,capacity,20,1)==0{return 0;}if jj_sink_write64_at(out,capacity,24,0x101000)==0{return 0;}if jj_sink_write64_at(out,capacity,32,64)==0{return 0;}if jj_sink_write64_at(out,capacity,40,0)==0{return 0;}if jj_sink_write32_at(out,capacity,48,0)==0{return 0;}if jj_sink_write16_at(out,capacity,52,64)==0{return 0;}if jj_sink_write16_at(out,capacity,54,56)==0{return 0;}if jj_sink_write16_at(out,capacity,56,1)==0{return 0;}if jj_sink_write16_at(out,capacity,58,64)==0{return 0;}if jj_sink_write16_at(out,capacity,60,0)==0{return 0;}if jj_sink_write16_at(out,capacity,62,0)==0{return 0;}
 if jj_sink_write32_at(out,capacity,64,1)==0{return 0;}if jj_sink_write32_at(out,capacity,68,5)==0{return 0;}if jj_sink_write64_at(out,capacity,72,0)==0{return 0;}if jj_sink_write64_at(out,capacity,80,0x100000)==0{return 0;}if jj_sink_write64_at(out,capacity,88,0x100000)==0{return 0;}if jj_sink_write64_at(out,capacity,96,total)==0{return 0;}if jj_sink_write64_at(out,capacity,104,total)==0{return 0;}if jj_sink_write64_at(out,capacity,112,0x1000)==0{return 0;}
 if jj_sink_write32_at(out,capacity,4096,0x00c000ef)==0{return 0;}if jj_sink_write32_at(out,capacity,4100,0x05d00893)==0{return 0;}if jj_sink_write32_at(out,capacity,4104,0x00000073)==0{return 0;}if jj_rv64_copy(out,capacity,4108,object+text_offset,text_size)==0{return 0;}var seal:i64=jj_rv64_executable_seal(out,total);if seal==0{return 0;}if jj_sink_write32_at(out,capacity,120,0x4a4a5256)==0{return 0;}if jj_sink_write32_at(out,capacity,124,1)==0{return 0;}if jj_sink_write32_at(out,capacity,128,seal)==0{return 0;}if jj_sink_write32_at(out,capacity,132,total)==0{return 0;}if jj_target_riscv64_executable_validate(out,total)==0{return 0;}return total;
}
fn jj_arm32_put(out:*i8,capacity:i64,at:i64,word:i64)->i64{if jj_sink_write32_at(out,capacity,at,word)==0{return 0;}return at+4;}
fn jj_arm32_movw(reg:i64,value:i64)->i64{return 0xe3000000|((value&0xf000)<<4)|((reg&15)<<12)|(value&0x0fff);}
fn jj_arm32_movt(reg:i64,value:i64)->i64{return 0xe3400000|((value&0xf000)<<4)|((reg&15)<<12)|(value&0x0fff);}
fn jj_arm32_emit_constant(out:*i8,capacity:i64,at:i64,low_register:i64,value:i64)->i64{
 var low:i64=value&0xffffffff;var high:i64=(value>>>32)&0xffffffff;
 at=jj_arm32_put(out,capacity,at,jj_arm32_movw(low_register,low));if at==0{return 0;}
 at=jj_arm32_put(out,capacity,at,jj_arm32_movt(low_register,low>>>16));if at==0{return 0;}
 at=jj_arm32_put(out,capacity,at,jj_arm32_movw(low_register+1,high));if at==0{return 0;}
 return jj_arm32_put(out,capacity,at,jj_arm32_movt(low_register+1,high>>>16));
}
fn jj_arm32_binary_size(op:i64)->i64{if op==11{return 20;}if op==9{return 8;}if op==10{return 8;}if op==16{return 8;}if op==17{return 8;}if op==18{return 8;}return 0;}
fn jj_arm32_emit_binary(out:*i8,capacity:i64,at:i64,op:i64)->i64{
 if op==9{at=jj_arm32_put(out,capacity,at,0xe0900002);if at==0{return 0;}return jj_arm32_put(out,capacity,at,0xe0a11003);}
 if op==10{at=jj_arm32_put(out,capacity,at,0xe0500002);if at==0{return 0;}return jj_arm32_put(out,capacity,at,0xe0c11003);}
 if op==16{at=jj_arm32_put(out,capacity,at,0xe0000002);if at==0{return 0;}return jj_arm32_put(out,capacity,at,0xe0011003);}
 if op==17{at=jj_arm32_put(out,capacity,at,0xe1800002);if at==0{return 0;}return jj_arm32_put(out,capacity,at,0xe1811003);}
 if op==18{at=jj_arm32_put(out,capacity,at,0xe0200002);if at==0{return 0;}return jj_arm32_put(out,capacity,at,0xe0211003);}
 if op==11{at=jj_arm32_put(out,capacity,at,0xe0854290);if at==0{return 0;}at=jj_arm32_put(out,capacity,at,0xe0255390);if at==0{return 0;}at=jj_arm32_put(out,capacity,at,0xe0255291);if at==0{return 0;}at=jj_arm32_put(out,capacity,at,0xe1a00004);if at==0{return 0;}return jj_arm32_put(out,capacity,at,0xe1a01005);}return 0;
}
fn jj_target_emit_arm32_cir(out:*i8,capacity:i64,view:*i64)->i64{
  if out==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];
  if jj_cir_validate(cir,slots)==0{return 0;}var cfg_kind:i64=jj_cir_function_kind(cir,slots);var mode:i64=0;if cfg_kind==1{mode=4;}else{if jj_cir_function_direct_load_kind(cir,slots)!=0{mode=5;}else{mode=jj_cir_expression_kind(cir,slots);}}
  if mode<1{return 0;}if mode>5{return 0;}var operations:i64=jj_cir_operation_count(cir,slots);var code_size:i64=4;
  if mode==1{code_size=20;}if mode==4{code_size=48;}if mode==5{code_size=8;}
  if mode==3{if operations<=0{return 0;}code_size=8;var si:i64=0;while si<operations{var bs:i64=jj_arm32_binary_size(jj_cir_operation_opcode(cir,slots,si));if bs==0{return 0;}code_size=code_size+16+bs;si=si+1;}}
  var symtab:i64=76;if code_size>24{symtab=84;}if code_size>32{symtab=(52+code_size+3)&0xfffffffffffffffc;}
  var strtab:i64=symtab+32;var shstr:i64=strtab+10;var shoff:i64=(shstr+36)&0xfffffffffffffffc;var total:i64=shoff+200;
  if capacity<total{return 0;}if jj_target_cir_overlap(out,total,cir,slots)!=0{return 0;}if jj_target_zero(out,capacity,total)==0{return 0;}
  out[0]=0x7f;out[1]=69;out[2]=76;out[3]=70;out[4]=1;out[5]=1;out[6]=1;
  jj_sink_write16_at(out,capacity,16,1);jj_sink_write16_at(out,capacity,18,40);jj_sink_write32_at(out,capacity,20,1);jj_sink_write32_at(out,capacity,32,shoff);jj_sink_write32_at(out,capacity,36,0x05000000);jj_sink_write16_at(out,capacity,40,52);jj_sink_write16_at(out,capacity,46,40);jj_sink_write16_at(out,capacity,48,5);jj_sink_write16_at(out,capacity,50,4);
  var at:i64=52;
  if mode==1{at=jj_arm32_emit_constant(out,capacity,at,0,jj_cir_immediate(cir,slots));if at==0{return 0;}at=jj_arm32_put(out,capacity,at,0xe12fff1e);if at==0{return 0;}}
  if mode==2{at=jj_arm32_put(out,capacity,at,0xe12fff1e);if at==0{return 0;}}
  if mode==3{at=jj_arm32_put(out,capacity,at,0xe92d4070);if at==0{return 0;}var oi:i64=0;while oi<operations{at=jj_arm32_emit_constant(out,capacity,at,2,jj_cir_operation_immediate(cir,slots,oi));if at==0{return 0;}at=jj_arm32_emit_binary(out,capacity,at,jj_cir_operation_opcode(cir,slots,oi));if at==0{return 0;}oi=oi+1;}at=jj_arm32_put(out,capacity,at,0xe8bd8070);if at==0{return 0;}}
  if mode==4{var true_value:i64=jj_cir_function_true_immediate(cir,slots);var false_value:i64=jj_cir_function_false_immediate(cir,slots);
    at=jj_arm32_put(out,capacity,at,0xe1902001);if at==0{return 0;}var branch_at:i64=at;var else_at:i64=branch_at+24;var delta:i64=(else_at-(branch_at+8))/4;if delta<0{return 0;}if delta>0x00ffffff{return 0;}
    at=jj_arm32_put(out,capacity,at,0x0a000000|(delta&0x00ffffff));if at==0{return 0;}at=jj_arm32_emit_constant(out,capacity,at,0,true_value);if at==0{return 0;}at=jj_arm32_put(out,capacity,at,0xe12fff1e);if at==0{return 0;}at=jj_arm32_emit_constant(out,capacity,at,0,false_value);if at==0{return 0;}at=jj_arm32_put(out,capacity,at,0xe12fff1e);if at==0{return 0;}}
  if mode==5{var direct_offset:i64=jj_cir_function_direct_load_offset(cir,slots);if direct_offset<0{return 0;}if direct_offset>248{return 0;}if (direct_offset&7)!=0{return 0;}var ldrd:i64=0xe1c000d0|((direct_offset&0xf0)<<4)|(direct_offset&15);at=jj_arm32_put(out,capacity,at,ldrd);if at==0{return 0;}at=jj_arm32_put(out,capacity,at,0xe12fff1e);if at==0{return 0;}}
  if at!=52+code_size{return 0;}
  jj_sink_write32_at(out,capacity,symtab+16,1);jj_sink_write32_at(out,capacity,symtab+20,0);jj_sink_write32_at(out,capacity,symtab+24,code_size);out[symtab+28]=0x12;jj_sink_write16_at(out,capacity,symtab+30,1);
  if jj_target_write_names(out,capacity,strtab,shstr)==0{return 0;}
  var sec:i64=shoff+40;jj_sink_write32_at(out,capacity,sec,1);jj_sink_write32_at(out,capacity,sec+4,1);jj_sink_write32_at(out,capacity,sec+8,6);jj_sink_write32_at(out,capacity,sec+16,52);jj_sink_write32_at(out,capacity,sec+20,code_size);jj_sink_write32_at(out,capacity,sec+32,4);
  sec=sec+40;jj_sink_write32_at(out,capacity,sec,7);jj_sink_write32_at(out,capacity,sec+4,2);jj_sink_write32_at(out,capacity,sec+16,symtab);jj_sink_write32_at(out,capacity,sec+20,32);jj_sink_write32_at(out,capacity,sec+24,3);jj_sink_write32_at(out,capacity,sec+28,1);jj_sink_write32_at(out,capacity,sec+32,4);jj_sink_write32_at(out,capacity,sec+36,16);
  sec=sec+40;jj_sink_write32_at(out,capacity,sec,15);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write32_at(out,capacity,sec+16,strtab);jj_sink_write32_at(out,capacity,sec+20,10);jj_sink_write32_at(out,capacity,sec+32,1);
  sec=sec+40;jj_sink_write32_at(out,capacity,sec,23);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write32_at(out,capacity,sec+16,shstr);jj_sink_write32_at(out,capacity,sec+20,33);jj_sink_write32_at(out,capacity,sec+32,1);return total;
}


// Bounded AArch64 two-function object with one explicit R_AARCH64_CALL26.
// The independent contract validates the complete ELF image and applies the
// relocation; this writer remains transactional and contains no opaque plan.
fn jj_target_emit_aarch64_call_module(out:*i8,capacity:i64)->i64{
  var total:i64=640;if out==0{return 0;}if capacity<total{return 0;}
  if jj_target_zero(out,capacity,total)==0{return 0;}
  out[0]=0x7f;out[1]=69;out[2]=76;out[3]=70;out[4]=2;out[5]=1;out[6]=1;
  jj_sink_write16_at(out,capacity,16,1);jj_sink_write16_at(out,capacity,18,183);jj_sink_write32_at(out,capacity,20,1);
  jj_sink_write64_at(out,capacity,40,256);jj_sink_write16_at(out,capacity,52,64);jj_sink_write16_at(out,capacity,58,64);jj_sink_write16_at(out,capacity,60,6);jj_sink_write16_at(out,capacity,62,5);
  jj_sink_write32_at(out,capacity,64,0x94000000);jj_sink_write32_at(out,capacity,68,0xd65f03c0);jj_sink_write32_at(out,capacity,72,0xd2800540);jj_sink_write32_at(out,capacity,76,0xd65f03c0);
  jj_sink_write64_at(out,capacity,80,0);jj_sink_write64_at(out,capacity,88,0x000000020000011b);jj_sink_write64_at(out,capacity,96,0);
  jj_sink_write32_at(out,capacity,128,1);out[132]=0x12;jj_sink_write16_at(out,capacity,134,1);jj_sink_write64_at(out,capacity,136,0);jj_sink_write64_at(out,capacity,144,8);
  jj_sink_write32_at(out,capacity,152,15);out[156]=0x12;jj_sink_write16_at(out,capacity,158,1);jj_sink_write64_at(out,capacity,160,8);jj_sink_write64_at(out,capacity,168,8);
  var strings:[29]i64;strings[0]=0;strings[1]=106;strings[2]=106;strings[3]=95;strings[4]=97;strings[5]=54;strings[6]=52;strings[7]=95;strings[8]=99;strings[9]=97;strings[10]=108;strings[11]=108;strings[12]=101;strings[13]=114;strings[14]=0;strings[15]=106;strings[16]=106;strings[17]=95;strings[18]=97;strings[19]=54;strings[20]=52;strings[21]=95;strings[22]=99;strings[23]=97;strings[24]=108;strings[25]=108;strings[26]=101;strings[27]=101;strings[28]=0;
  var i:i64=0;while i<29{out[176+i]=strings[i] as i8;i=i+1;}
  var names:[44]i64;names[0]=0;names[1]=46;names[2]=116;names[3]=101;names[4]=120;names[5]=116;names[6]=0;names[7]=46;names[8]=114;names[9]=101;names[10]=108;names[11]=97;names[12]=46;names[13]=116;names[14]=101;names[15]=120;names[16]=116;names[17]=0;names[18]=46;names[19]=115;names[20]=121;names[21]=109;names[22]=116;names[23]=97;names[24]=98;names[25]=0;names[26]=46;names[27]=115;names[28]=116;names[29]=114;names[30]=116;names[31]=97;names[32]=98;names[33]=0;names[34]=46;names[35]=115;names[36]=104;names[37]=115;names[38]=116;names[39]=114;names[40]=116;names[41]=97;names[42]=98;names[43]=0;
  i=0;while i<44{out[205+i]=names[i] as i8;i=i+1;}
  var sec:i64=320;jj_sink_write32_at(out,capacity,sec,1);jj_sink_write32_at(out,capacity,sec+4,1);jj_sink_write64_at(out,capacity,sec+8,6);jj_sink_write64_at(out,capacity,sec+24,64);jj_sink_write64_at(out,capacity,sec+32,16);jj_sink_write64_at(out,capacity,sec+48,4);
  sec=384;jj_sink_write32_at(out,capacity,sec,7);jj_sink_write32_at(out,capacity,sec+4,4);jj_sink_write64_at(out,capacity,sec+24,80);jj_sink_write64_at(out,capacity,sec+32,24);jj_sink_write32_at(out,capacity,sec+40,3);jj_sink_write32_at(out,capacity,sec+44,1);jj_sink_write64_at(out,capacity,sec+48,8);jj_sink_write64_at(out,capacity,sec+56,24);
  sec=448;jj_sink_write32_at(out,capacity,sec,18);jj_sink_write32_at(out,capacity,sec+4,2);jj_sink_write64_at(out,capacity,sec+24,104);jj_sink_write64_at(out,capacity,sec+32,72);jj_sink_write32_at(out,capacity,sec+40,4);jj_sink_write32_at(out,capacity,sec+44,1);jj_sink_write64_at(out,capacity,sec+48,8);jj_sink_write64_at(out,capacity,sec+56,24);
  sec=512;jj_sink_write32_at(out,capacity,sec,26);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write64_at(out,capacity,sec+24,176);jj_sink_write64_at(out,capacity,sec+32,29);jj_sink_write64_at(out,capacity,sec+48,1);
  sec=576;jj_sink_write32_at(out,capacity,sec,34);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write64_at(out,capacity,sec+24,205);jj_sink_write64_at(out,capacity,sec+32,44);jj_sink_write64_at(out,capacity,sec+48,1);return total;
}

fn jj_target_emit_arm_cir(out:*i8,capacity:i64,view:*i64,kind:i64)->i64{
  if kind==6{return jj_target_emit_aarch64_cir(out,capacity,view);}
  if kind==7{return jj_target_emit_arm32_cir(out,capacity,view);}if kind==9{return jj_target_emit_riscv64_cir(out,capacity,view);}return 0;
}

fn jj_target_emit_aarch64(out: *i8, capacity: i64, value: i64) -> i64 {
  var cir:[64]i64;var view:[4]i64;if jj_cir_build_constant(cir as *i64,64,value)==0{return 0;}
  if jj_cir_view_bind(view as *i64,cir as *i64,64)==0{return 0;}return jj_target_emit_aarch64_cir(out,capacity,view as *i64);
}

fn jj_target_emit_arm32(out: *i8, capacity: i64, value: i64) -> i64 {
  var cir:[64]i64;var view:[4]i64;if jj_cir_build_constant(cir as *i64,64,value)==0{return 0;}
  if jj_cir_view_bind(view as *i64,cir as *i64,64)==0{return 0;}return jj_target_emit_arm32_cir(out,capacity,view as *i64);
}

fn jj_target_emit_riscv64(out:*i8,capacity:i64,value:i64)->i64{var cir:[64]i64;var view:[4]i64;if jj_cir_build_constant(cir as *i64,64,value)==0{return 0;}if jj_cir_view_bind(view as *i64,cir as *i64,64)==0{return 0;}return jj_target_emit_riscv64_cir(out,capacity,view as *i64);}

fn jj_target_emit_object(source: *i8, length: i64, out: *i8, capacity: i64) -> i64 {
  var kind:i64=jj_target_manifest_kind(source,length);if kind==0{return 0;}
  var value:i64=jj_target_return_value(source,length,kind);if value<0{return 0;}
  if kind==1{return jj_target_emit_aarch64(out,capacity,value);}
  if kind==2{return jj_target_emit_arm32(out,capacity,value);}
  if kind==3{var cir:[64]i64;var view:[4]i64;if jj_cir_build_constant(cir as *i64,64,value)==0{return 0;}if jj_cir_view_bind(view as *i64,cir as *i64,64)==0{return 0;}return jj_target_emit_i386_cir(out,capacity,view as *i64);}
  if kind==4{return jj_target_emit_riscv64(out,capacity,value);}if kind==5{return 0;}
  return 0;
}
