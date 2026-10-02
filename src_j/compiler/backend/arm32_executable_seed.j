// Bounded ARM32 Linux executable-image seed. It wraps one verified
// no-argument CIR function; it is not a general linker or selfhost runtime.
extern fn jj_sink_write16_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_sink_write32_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_view_valid(p0:*i64)->i64;
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_cir_overlap(p0:*i8,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_target_zero(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_target_emit_arm32_cir(p0:*i8,p1:i64,p2:*i64)->i64;
extern fn jj_e32_rd16(p0:*i8)->i64;
extern fn jj_e32_rd32(p0:*i8)->i64;
extern fn jj_e32_copy(p0:*i8,p1:i64,p2:i64,p3:*i8,p4:i64)->i64;
extern fn jj_e32_object_text(p0:*i8,p1:i64,p2:i64,p3:*i64)->i64;
fn jj_arm32x_ident_valid(out:*i8,size:i64)->i64{
 if out==0{return 0;}if size<4116{return 0;}if out[0]!=0x7f{return 0;}if out[1]!=69{return 0;}if out[2]!=76{return 0;}if out[3]!=70{return 0;}if out[4]!=1{return 0;}if out[5]!=1{return 0;}
 if jj_e32_rd16(out+16)!=2{return 0;}if jj_e32_rd16(out+18)!=40{return 0;}if jj_e32_rd32(out+20)!=1{return 0;}if jj_e32_rd32(out+24)!=0x11000{return 0;}return 1;
}
fn jj_arm32x_header_valid(out:*i8)->i64{
 if jj_e32_rd32(out+28)!=52{return 0;}if jj_e32_rd32(out+32)!=0{return 0;}if jj_e32_rd32(out+36)!=0x05000000{return 0;}if jj_e32_rd16(out+40)!=52{return 0;}
 if jj_e32_rd16(out+42)!=32{return 0;}if jj_e32_rd16(out+44)!=1{return 0;}if jj_e32_rd16(out+46)!=40{return 0;}if jj_e32_rd16(out+48)!=0{return 0;}if jj_e32_rd16(out+50)!=0{return 0;}return 1;
}
fn jj_arm32x_segment_valid(out:*i8,size:i64)->i64{
 if jj_e32_rd32(out+52)!=1{return 0;}if jj_e32_rd32(out+56)!=0{return 0;}if jj_e32_rd32(out+60)!=0x10000{return 0;}if jj_e32_rd32(out+64)!=0x10000{return 0;}
 if jj_e32_rd32(out+68)!=size{return 0;}if jj_e32_rd32(out+72)!=size{return 0;}if jj_e32_rd32(out+76)!=5{return 0;}if jj_e32_rd32(out+80)!=0x1000{return 0;}return 1;
}
fn jj_arm32x_code_valid(out:*i8,size:i64)->i64{
 if jj_e32_rd32(out+4096)!=0xeb000001{return 0;}if jj_e32_rd32(out+4100)!=0xe3a07001{return 0;}if jj_e32_rd32(out+4104)!=0xef000000{return 0;}
 if jj_e32_rd32(out+4108)==0{return 0;}if jj_e32_rd32(out+size-4)!=0xe12fff1e{return 0;}return 1;
}
fn jj_target_arm32_executable_validate(out:*i8,size:i64)->i64{
 if jj_arm32x_ident_valid(out,size)==0{return 0;}if jj_arm32x_header_valid(out)==0{return 0;}if jj_arm32x_segment_valid(out,size)==0{return 0;}return jj_arm32x_code_valid(out,size);
}
fn jj_arm32x_emit_header(out:*i8,capacity:i64)->i64{
 out[0]=0x7f;out[1]=69;out[2]=76;out[3]=70;out[4]=1;out[5]=1;out[6]=1;
 if jj_sink_write16_at(out,capacity,16,2)==0{return 0;}if jj_sink_write16_at(out,capacity,18,40)==0{return 0;}if jj_sink_write32_at(out,capacity,20,1)==0{return 0;}
 if jj_sink_write32_at(out,capacity,24,0x11000)==0{return 0;}if jj_sink_write32_at(out,capacity,28,52)==0{return 0;}if jj_sink_write32_at(out,capacity,32,0)==0{return 0;}if jj_sink_write32_at(out,capacity,36,0x05000000)==0{return 0;}
 if jj_sink_write16_at(out,capacity,40,52)==0{return 0;}if jj_sink_write16_at(out,capacity,42,32)==0{return 0;}if jj_sink_write16_at(out,capacity,44,1)==0{return 0;}
 if jj_sink_write16_at(out,capacity,46,40)==0{return 0;}if jj_sink_write16_at(out,capacity,48,0)==0{return 0;}if jj_sink_write16_at(out,capacity,50,0)==0{return 0;}return 1;
}
fn jj_arm32x_emit_segment(out:*i8,capacity:i64,total:i64)->i64{
 if jj_sink_write32_at(out,capacity,52,1)==0{return 0;}if jj_sink_write32_at(out,capacity,56,0)==0{return 0;}if jj_sink_write32_at(out,capacity,60,0x10000)==0{return 0;}if jj_sink_write32_at(out,capacity,64,0x10000)==0{return 0;}
 if jj_sink_write32_at(out,capacity,68,total)==0{return 0;}if jj_sink_write32_at(out,capacity,72,total)==0{return 0;}if jj_sink_write32_at(out,capacity,76,5)==0{return 0;}if jj_sink_write32_at(out,capacity,80,0x1000)==0{return 0;}return 1;
}
fn jj_arm32x_emit_start(out:*i8,capacity:i64)->i64{
 if jj_sink_write32_at(out,capacity,4096,0xeb000001)==0{return 0;}if jj_sink_write32_at(out,capacity,4100,0xe3a07001)==0{return 0;}return jj_sink_write32_at(out,capacity,4104,0xef000000);
}
fn jj_target_emit_arm32_executable_cir(out:*i8,capacity:i64,view:*i64)->i64{
 if out==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];if jj_cir_validate(cir,slots)==0{return 0;}
 if cir[1]!=1{return 0;}if cir[4]!=0{return 0;}if cir[5]!=1{return 0;}var object_words:[1024]i64;var object:*i8=object_words as *i8;
 var object_size:i64=jj_target_emit_arm32_cir(object,8192,view);if object_size<=0{return 0;}var text_view:[4]i64;if jj_e32_object_text(object,object_size,40,text_view as *i64)==0{return 0;}
 var text_offset:i64=text_view[0];var text_size:i64=text_view[1];if text_view[2]!=(text_offset^text_size^object_size^0x0000002800000000^0x454c463332544558){return 0;}
 var total:i64=4108+text_size;if total<=4108{return 0;}if capacity<total{return 0;}if jj_target_cir_overlap(out,total,cir,slots)!=0{return 0;}if jj_target_zero(out,capacity,total)==0{return 0;}
 if jj_arm32x_emit_header(out,capacity)==0{return 0;}if jj_arm32x_emit_segment(out,capacity,total)==0{return 0;}if jj_arm32x_emit_start(out,capacity)==0{return 0;}
 if jj_e32_copy(out,capacity,4108,object+text_offset,text_size)==0{return 0;}if jj_target_arm32_executable_validate(out,total)==0{return 0;}return total;
}
