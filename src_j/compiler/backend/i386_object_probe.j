// IA-32/i386 narrow CIR object emitter. This is a real ELF32 relocatable
// backend seed, not a selfhost claim. It consumes the same sealed CIR subset
// used by AArch64 and ARM32 and preserves i64 as EDX:EAX.
extern fn jj_sink_write8_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_sink_write16_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_sink_write32_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_view_valid(p0:*i64)->i64;
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_expression_kind(p0:*i64,p1:i64)->i64;
extern fn jj_cir_operation_count(p0:*i64,p1:i64)->i64;
extern fn jj_cir_operation_opcode(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_operation_immediate(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_immediate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_kind(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_true_immediate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_false_immediate(p0:*i64,p1:i64)->i64;
extern fn jj_target_cir_overlap(p0:*i8,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_target_zero(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_target_write_names(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;

fn jj_i386_put8(out:*i8,capacity:i64,at:i64,value:i64)->i64{
 if jj_sink_write8_at(out,capacity,at,value)==0{return 0;}return at+1;
}
fn jj_i386_put32(out:*i8,capacity:i64,at:i64,value:i64)->i64{
 if jj_sink_write32_at(out,capacity,at,value)==0{return 0;}return at+4;
}
fn jj_i386_emit_mov_imm(out:*i8,capacity:i64,at:i64,opcode:i64,value:i64)->i64{
 at=jj_i386_put8(out,capacity,at,opcode);if at==0{return 0;}return jj_i386_put32(out,capacity,at,value&0xffffffff);
}
fn jj_i386_emit_constant(out:*i8,capacity:i64,at:i64,value:i64)->i64{
 at=jj_i386_emit_mov_imm(out,capacity,at,0xb8,value);if at==0{return 0;}
 return jj_i386_emit_mov_imm(out,capacity,at,0xba,value>>>32);
}
fn jj_i386_emit_load_argument(out:*i8,capacity:i64,at:i64,offset:i64)->i64{
 at=jj_i386_put8(out,capacity,at,0x8b);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0x44);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0x24);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,offset);if at==0{return 0;}
 at=jj_i386_put8(out,capacity,at,0x8b);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0x54);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0x24);if at==0{return 0;}return jj_i386_put8(out,capacity,at,offset+4);
}
fn jj_i386_emit_pair_op(out:*i8,capacity:i64,at:i64,op:i64)->i64{
 var lo0:i64=0;var lo1:i64=0;var hi0:i64=0;var hi1:i64=0;
 if op==9{lo0=0x01;lo1=0xd8;hi0=0x11;hi1=0xca;}
 else{if op==10{lo0=0x29;lo1=0xd8;hi0=0x19;hi1=0xca;}
 else{if op==16{lo0=0x21;lo1=0xd8;hi0=0x21;hi1=0xca;}
 else{if op==17{lo0=0x09;lo1=0xd8;hi0=0x09;hi1=0xca;}
 else{if op==18{lo0=0x31;lo1=0xd8;hi0=0x31;hi1=0xca;}
 else{return 0;}}}}}
 at=jj_i386_put8(out,capacity,at,lo0);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,lo1);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,hi0);if at==0{return 0;}return jj_i386_put8(out,capacity,at,hi1);
}
fn jj_i386_emit_mul(out:*i8,capacity:i64,at:i64)->i64{
 // ESI=old low, EDI=old high, EBX=rhs low, ECX=rhs high.
 at=jj_i386_put8(out,capacity,at,0x89);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xc6);if at==0{return 0;}
 at=jj_i386_put8(out,capacity,at,0x89);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xd7);if at==0{return 0;}
 at=jj_i386_put8(out,capacity,at,0xf7);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xe3);if at==0{return 0;}
 at=jj_i386_put8(out,capacity,at,0x0f);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xaf);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xfb);if at==0{return 0;}
 at=jj_i386_put8(out,capacity,at,0x01);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xfa);if at==0{return 0;}
 at=jj_i386_put8(out,capacity,at,0x0f);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xaf);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xf1);if at==0{return 0;}
 at=jj_i386_put8(out,capacity,at,0x01);if at==0{return 0;}return jj_i386_put8(out,capacity,at,0xf2);
}
fn jj_i386_operation_size(op:i64)->i64{if op==11{return 16;}if op==9{return 4;}if op==10{return 4;}if op==16{return 4;}if op==17{return 4;}if op==18{return 4;}return 0;}
fn jj_i386_emit_operation(out:*i8,capacity:i64,at:i64,op:i64)->i64{if op==11{return jj_i386_emit_mul(out,capacity,at);}return jj_i386_emit_pair_op(out,capacity,at,op);}

fn jj_target_emit_i386_cir(out:*i8,capacity:i64,view:*i64)->i64{
 if out==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];if jj_cir_validate(cir,slots)==0{return 0;}
 var cfg:i64=jj_cir_function_kind(cir,slots);var mode:i64=0;if cfg==1{mode=4;}else{mode=jj_cir_expression_kind(cir,slots);}if mode<1{return 0;}if mode>4{return 0;}
 var operations:i64=jj_cir_operation_count(cir,slots);var code_size:i64=0;
 if mode==1{code_size=11;}if mode==2{code_size=9;}if mode==4{code_size=34;}
 if mode==3{if operations<=0{return 0;}code_size=15;var si:i64=0;while si<operations{var os:i64=jj_i386_operation_size(jj_cir_operation_opcode(cir,slots,si));if os==0{return 0;}code_size=code_size+10+os;si=si+1;}}
 if code_size<=0{return 0;}var symtab:i64=(52+code_size+3)&0xfffffffffffffffc;var strtab:i64=symtab+32;var shstr:i64=strtab+10;var shoff:i64=(shstr+36)&0xfffffffffffffffc;var total:i64=shoff+200;
 if capacity<total{return 0;}if jj_target_cir_overlap(out,total,cir,slots)!=0{return 0;}if jj_target_zero(out,capacity,total)==0{return 0;}
 out[0]=0x7f;out[1]=69;out[2]=76;out[3]=70;out[4]=1;out[5]=1;out[6]=1;
 jj_sink_write16_at(out,capacity,16,1);jj_sink_write16_at(out,capacity,18,3);jj_sink_write32_at(out,capacity,20,1);jj_sink_write32_at(out,capacity,32,shoff);jj_sink_write16_at(out,capacity,40,52);jj_sink_write16_at(out,capacity,46,40);jj_sink_write16_at(out,capacity,48,5);jj_sink_write16_at(out,capacity,50,4);
 var at:i64=52;
 if mode==1{at=jj_i386_emit_constant(out,capacity,at,jj_cir_immediate(cir,slots));if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xc3);if at==0{return 0;}}
 if mode==2{at=jj_i386_emit_load_argument(out,capacity,at,4);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xc3);if at==0{return 0;}}
 if mode==3{
  at=jj_i386_put8(out,capacity,at,0x53);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0x56);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0x57);if at==0{return 0;}at=jj_i386_emit_load_argument(out,capacity,at,16);if at==0{return 0;}
  var oi:i64=0;while oi<operations{var imm:i64=jj_cir_operation_immediate(cir,slots,oi);at=jj_i386_emit_mov_imm(out,capacity,at,0xbb,imm);if at==0{return 0;}at=jj_i386_emit_mov_imm(out,capacity,at,0xb9,imm>>>32);if at==0{return 0;}at=jj_i386_emit_operation(out,capacity,at,jj_cir_operation_opcode(cir,slots,oi));if at==0{return 0;}oi=oi+1;}
  at=jj_i386_put8(out,capacity,at,0x5f);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0x5e);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0x5b);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xc3);if at==0{return 0;}
 }
 if mode==4{
  at=jj_i386_emit_load_argument(out,capacity,at,4);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0x09);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xd0);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0x74);if at==0{return 0;}at=jj_i386_put8(out,capacity,at,11);if at==0{return 0;}
  at=jj_i386_emit_constant(out,capacity,at,jj_cir_function_true_immediate(cir,slots));if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xc3);if at==0{return 0;}at=jj_i386_emit_constant(out,capacity,at,jj_cir_function_false_immediate(cir,slots));if at==0{return 0;}at=jj_i386_put8(out,capacity,at,0xc3);if at==0{return 0;}
 }
 if at!=52+code_size{return 0;}
 jj_sink_write32_at(out,capacity,symtab+16,1);jj_sink_write32_at(out,capacity,symtab+20,0);jj_sink_write32_at(out,capacity,symtab+24,code_size);out[symtab+28]=0x12;jj_sink_write16_at(out,capacity,symtab+30,1);
 if jj_target_write_names(out,capacity,strtab,shstr)==0{return 0;}
 var sec:i64=shoff+40;jj_sink_write32_at(out,capacity,sec,1);jj_sink_write32_at(out,capacity,sec+4,1);jj_sink_write32_at(out,capacity,sec+8,6);jj_sink_write32_at(out,capacity,sec+16,52);jj_sink_write32_at(out,capacity,sec+20,code_size);jj_sink_write32_at(out,capacity,sec+32,1);
 sec=sec+40;jj_sink_write32_at(out,capacity,sec,7);jj_sink_write32_at(out,capacity,sec+4,2);jj_sink_write32_at(out,capacity,sec+16,symtab);jj_sink_write32_at(out,capacity,sec+20,32);jj_sink_write32_at(out,capacity,sec+24,3);jj_sink_write32_at(out,capacity,sec+28,1);jj_sink_write32_at(out,capacity,sec+32,4);jj_sink_write32_at(out,capacity,sec+36,16);
 sec=sec+40;jj_sink_write32_at(out,capacity,sec,15);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write32_at(out,capacity,sec+16,strtab);jj_sink_write32_at(out,capacity,sec+20,10);jj_sink_write32_at(out,capacity,sec+32,1);
 sec=sec+40;jj_sink_write32_at(out,capacity,sec,23);jj_sink_write32_at(out,capacity,sec+4,3);jj_sink_write32_at(out,capacity,sec+16,shstr);jj_sink_write32_at(out,capacity,sec+20,33);jj_sink_write32_at(out,capacity,sec+32,1);return total;
}
