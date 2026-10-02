// Bounded AArch64 executable-image seed. This is not a general linker or a
// selfhost runtime. It wraps one verified no-argument CIR function in a static
// ELF64 image whose _start calls the function and exits through Linux syscall
// 93. The relocatable object remains the authority for function code.
extern fn jj_sink_write8_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_sink_write16_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_sink_write32_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_sink_write64_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_view_valid(p0:*i64)->i64;
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_cir_overlap(p0:*i8,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_target_zero(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_target_emit_aarch64_cir(p0:*i8,p1:i64,p2:*i64)->i64;

fn jj_a64x_rd16(p:*i8)->i64{if p==0{return 0;}return (p[0]&255)|((p[1]&255)<<8);}
fn jj_a64x_rd32(p:*i8)->i64{if p==0{return 0;}return (p[0]&255)|((p[1]&255)<<8)|((p[2]&255)<<16)|((p[3]&255)<<24);}
fn jj_a64x_rd64(p:*i8)->i64{if p==0{return 0;}var v:i64=0;var i:i64=0;while i<8{v=v|((p[i]&255)<<(i*8));i=i+1;}return v;}
fn jj_a64x_copy(dst:*i8,capacity:i64,at:i64,src:*i8,count:i64)->i64{
 if dst==0{return 0;}if src==0{return 0;}if at<0{return 0;}if count<=0{return 0;}if at>capacity-count{return 0;}
 var i:i64=0;while i<count{dst[at+i]=src[i];i=i+1;}return at+count;
}
fn jj_a64x_object_text(object:*i8,size:i64,view:*i64)->i64{
 if object==0{return 0;}if view==0{return 0;}if size<384{return 0;}
 if object[0]!=0x7f{return 0;}if object[1]!=69{return 0;}if object[2]!=76{return 0;}if object[3]!=70{return 0;}
 if object[4]!=2{return 0;}if object[5]!=1{return 0;}if jj_a64x_rd16(object+16)!=1{return 0;}if jj_a64x_rd16(object+18)!=183{return 0;}
 var shoff:i64=jj_a64x_rd64(object+40);var entsize:i64=jj_a64x_rd16(object+58);var sections:i64=jj_a64x_rd16(object+60);
 if entsize!=64{return 0;}if sections!=5{return 0;}if shoff<=0{return 0;}if shoff>size-sections*64{return 0;}
 var text:*i8=object+shoff+64;if jj_a64x_rd32(text+4)!=1{return 0;}if jj_a64x_rd64(text+8)!=6{return 0;}
 var offset:i64=jj_a64x_rd64(text+24);var count:i64=jj_a64x_rd64(text+32);if offset<64{return 0;}if count<=0{return 0;}if (count&3)!=0{return 0;}if offset>size-count{return 0;}
 view[0]=offset;view[1]=count;view[2]=offset^count^size^0x413634584f424a31;view[3]=0;return 1;
}
fn jj_target_aarch64_executable_validate(out:*i8,size:i64)->i64{
 if out==0{return 0;}if size<4112{return 0;}if out[0]!=0x7f{return 0;}if out[1]!=69{return 0;}if out[2]!=76{return 0;}if out[3]!=70{return 0;}
 if out[4]!=2{return 0;}if out[5]!=1{return 0;}if jj_a64x_rd16(out+16)!=2{return 0;}if jj_a64x_rd16(out+18)!=183{return 0;}if jj_a64x_rd32(out+20)!=1{return 0;}
 if jj_a64x_rd64(out+24)!=0x401000{return 0;}if jj_a64x_rd64(out+32)!=64{return 0;}if jj_a64x_rd64(out+40)!=0{return 0;}
 if jj_a64x_rd16(out+52)!=64{return 0;}if jj_a64x_rd16(out+54)!=56{return 0;}if jj_a64x_rd16(out+56)!=1{return 0;}if jj_a64x_rd16(out+60)!=0{return 0;}
 if jj_a64x_rd32(out+64)!=1{return 0;}if jj_a64x_rd32(out+68)!=5{return 0;}if jj_a64x_rd64(out+72)!=0{return 0;}if jj_a64x_rd64(out+80)!=0x400000{return 0;}
 if jj_a64x_rd64(out+96)!=size{return 0;}if jj_a64x_rd64(out+104)!=size{return 0;}if jj_a64x_rd64(out+112)!=0x1000{return 0;}
 if jj_a64x_rd32(out+4096)!=0x94000003{return 0;}if jj_a64x_rd32(out+4100)!=0xd2800ba8{return 0;}if jj_a64x_rd32(out+4104)!=0xd4000001{return 0;}
 if jj_a64x_rd32(out+4108)==0{return 0;}if jj_a64x_rd32(out+size-4)!=0xd65f03c0{return 0;}return 1;
}
fn jj_target_emit_aarch64_executable_cir(out:*i8,capacity:i64,view:*i64)->i64{
 if out==0{return 0;}if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var slots:i64=view[1];if jj_cir_validate(cir,slots)==0{return 0;}
 if cir[1]!=1{return 0;}if cir[4]!=0{return 0;}if cir[5]!=1{return 0;}
 var object_words:[1024]i64;var object:*i8=object_words as *i8;var object_size:i64=jj_target_emit_aarch64_cir(object,8192,view);if object_size<=0{return 0;}
 var text_view:[4]i64;if jj_a64x_object_text(object,object_size,text_view as *i64)==0{return 0;}var text_offset:i64=text_view[0];var text_size:i64=text_view[1];
 if text_view[2]!=(text_offset^text_size^object_size^0x413634584f424a31){return 0;}var code_offset:i64=4096;var total:i64=code_offset+12+text_size;
 if total<=code_offset{return 0;}if capacity<total{return 0;}if jj_target_cir_overlap(out,total,cir,slots)!=0{return 0;}if jj_target_zero(out,capacity,total)==0{return 0;}
 out[0]=0x7f;out[1]=69;out[2]=76;out[3]=70;out[4]=2;out[5]=1;out[6]=1;
 if jj_sink_write16_at(out,capacity,16,2)==0{return 0;}if jj_sink_write16_at(out,capacity,18,183)==0{return 0;}if jj_sink_write32_at(out,capacity,20,1)==0{return 0;}
 if jj_sink_write64_at(out,capacity,24,0x401000)==0{return 0;}if jj_sink_write64_at(out,capacity,32,64)==0{return 0;}if jj_sink_write64_at(out,capacity,40,0)==0{return 0;}
 if jj_sink_write32_at(out,capacity,48,0)==0{return 0;}if jj_sink_write16_at(out,capacity,52,64)==0{return 0;}if jj_sink_write16_at(out,capacity,54,56)==0{return 0;}if jj_sink_write16_at(out,capacity,56,1)==0{return 0;}
 if jj_sink_write16_at(out,capacity,58,64)==0{return 0;}if jj_sink_write16_at(out,capacity,60,0)==0{return 0;}if jj_sink_write16_at(out,capacity,62,0)==0{return 0;}
 if jj_sink_write32_at(out,capacity,64,1)==0{return 0;}if jj_sink_write32_at(out,capacity,68,5)==0{return 0;}if jj_sink_write64_at(out,capacity,72,0)==0{return 0;}
 if jj_sink_write64_at(out,capacity,80,0x400000)==0{return 0;}if jj_sink_write64_at(out,capacity,88,0x400000)==0{return 0;}if jj_sink_write64_at(out,capacity,96,total)==0{return 0;}
 if jj_sink_write64_at(out,capacity,104,total)==0{return 0;}if jj_sink_write64_at(out,capacity,112,0x1000)==0{return 0;}
 if jj_sink_write32_at(out,capacity,code_offset,0x94000003)==0{return 0;}if jj_sink_write32_at(out,capacity,code_offset+4,0xd2800ba8)==0{return 0;}if jj_sink_write32_at(out,capacity,code_offset+8,0xd4000001)==0{return 0;}
 if jj_a64x_copy(out,capacity,code_offset+12,object+text_offset,text_size)==0{return 0;}if jj_target_aarch64_executable_validate(out,total)==0{return 0;}return total;
}
