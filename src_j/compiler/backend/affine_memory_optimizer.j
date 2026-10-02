// R738 bounded affine memory optimizer: base[index +/- offset] u64 load.
extern fn jj_rc_affine_get(p0:*i64,p1:i64)->i64;
extern fn jj_reo_nop(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_reo_nop_match(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_vm_rd16(p0:*i8)->i64;
extern fn jj_vm_rd64(p0:*i8)->i64;
fn jj_amo_rd32(p:*i8)->i64{return (p[0]&255)|((p[1]&255)<<8)|((p[2]&255)<<16)|((p[3]&255)<<24);}
fn jj_amo_wr32(p:*i8,v:i64)->i64{p[0]=v;p[1]=v>>>8;p[2]=v>>>16;p[3]=v>>>24;return 1;}
fn jj_amo_s32(v:i64)->i64{var x:i64=v&0xffffffff;if x>=0x80000000{return x-0x100000000;}return x;}
fn jj_amo_sign32(v:i64)->i64{if jj_amo_s32(v)==v{return 1;}return 0;}
fn jj_amo_slot(d:i64)->i64{var x:i64=jj_amo_s32(d);if x>=0{return 0-1;}if (0-x)%8!=0{return 0-1;}var s:i64=(0-x)/8-1;if s<0{return 0-1;}if s>32767{return 0-1;}return s;}
fn jj_amo_marker(p:*i8,at:i64,v:i64)->i64{p[at]=0x0f;p[at+1]=0x1f;p[at+2]=0x44;p[at+3]=0;p[at+4]=v;return 1;}
fn jj_amo_history(h:*i64,end:i64,c:*i64)->i64{
 if h==0{return 0;}if c==0{return 0;}var offop:i64=jj_rc_affine_get(h,20);var adj:i64=jj_rc_affine_get(h,24);if jj_rc_affine_get(h,12)!=2{return 0;}if jj_rc_affine_get(h,16)!=2{return 0;}if offop!=1{if offop!=2{return 0;}}if adj!=9{if adj!=10{return 0;}}if jj_rc_affine_get(h,28)!=1{return 0;}if jj_rc_affine_get(h,32)!=11{return 0;}if jj_rc_affine_get(h,36)!=9{return 0;}if jj_rc_affine_get(h,40)!=6{return 0;}var i:i64=3;while i<11{if jj_rc_affine_get(h,i*4+3)!=0{return 0;}i=i+1;}
 var b:i64=jj_rc_affine_get(h,14);var a1:i64=jj_rc_affine_get(h,18);var a2:i64=jj_rc_affine_get(h,22);var a3:i64=jj_rc_affine_get(h,26);var a4:i64=jj_rc_affine_get(h,30);var a5:i64=jj_rc_affine_get(h,34);var a6:i64=jj_rc_affine_get(h,38);var a7:i64=jj_rc_affine_get(h,42);if b<0{return 0;}if a1!=b+6{return 0;}if a2!=a1+6{return 0;}var n:i64=6;if offop==1{n=11;}if a3!=a2+n{return 0;}if a4!=a3+6{return 0;}if a5!=a4+11{return 0;}if a6!=a5+7{return 0;}if a7!=a6+6{return 0;}if end!=a7+6{return 0;}c[0]=b;c[1]=a1;c[2]=a7;c[3]=offop;c[4]=adj;return 1;
}
fn jj_amo_semantic(program:*i8,h:*i64,c:*i64)->i64{
 if program==0{return 0;}if h==0{return 0;}if c==0{return 0;}var bpc:i64=jj_rc_affine_get(h,13);var ipc:i64=jj_rc_affine_get(h,17);var opc:i64=jj_rc_affine_get(h,21);var spc:i64=jj_rc_affine_get(h,29);if bpc<0{return 0;}if ipc<0{return 0;}if opc<0{return 0;}if spc<0{return 0;}if program[bpc]!=2{return 0;}if program[ipc]!=2{return 0;}if program[spc]!=1{return 0;}if jj_vm_rd64(program+spc+1)!=8{return 0;}var base:i64=jj_vm_rd16(program+bpc+1);var index:i64=jj_vm_rd16(program+ipc+1);if base==index{return 0;}var off:i64=0;if c[3]==1{if program[opc]!=1{return 0;}off=jj_vm_rd64(program+opc+1);if jj_amo_sign32(off)==0{return 0;}}else{if program[opc]!=2{return 0;}off=jj_vm_rd16(program+opc+1);if off==base{return 0;}if off==index{return 0;}}c[5]=base;c[6]=index;c[7]=off;return 1;
}
fn jj_amo_machine(code:*i8,c:*i64)->i64{
 if code==0{return 0;}if c==0{return 0;}var b:i64=c[0];var i:i64=c[1];var l:i64=c[2];if (code[b]&255)!=0xff{return 0;}if (code[b+1]&255)!=0xb5{return 0;}if jj_amo_slot(jj_amo_rd32(code+b+2))!=c[5]{return 0;}if code[i]!=0x48{return 0;}if (code[i+1]&255)!=0x8b{return 0;}if (code[i+2]&255)!=0x85{return 0;}if jj_amo_slot(jj_amo_rd32(code+i+3))!=c[6]{return 0;}
 if c[3]==1{if code[i+7]!=0x48{return 0;}if (code[i+8]&255)!=0x81{return 0;}var m:i64=0xc0;if c[4]==10{m=0xe8;}if (code[i+9]&255)!=m{return 0;}if jj_amo_s32(jj_amo_rd32(code+i+10))!=c[7]{return 0;}if code[i+14]!=0x50{return 0;}if jj_reo_nop_match(code,i+15,i+23)==0{return 0;}if code[i+23]!=0x58{return 0;}if code[i+24]!=0x48{return 0;}if (code[i+25]&255)!=0xc1{return 0;}if (code[i+26]&255)!=0xe0{return 0;}if code[i+27]!=3{return 0;}if code[i+28]!=0x50{return 0;}if jj_reo_nop_match(code,i+29,i+41)==0{return 0;}if code[i+41]!=0x59{return 0;}if code[i+42]!=0x58{return 0;}if code[i+43]!=0x48{return 0;}if code[i+44]!=0x01{return 0;}if (code[i+45]&255)!=0xc8{return 0;}if jj_reo_nop_match(code,i+46,l+1)==0{return 0;}}
 else{if code[i+7]!=0x48{return 0;}if (code[i+8]&255)!=0x8b{return 0;}if (code[i+9]&255)!=0x8d{return 0;}if jj_amo_slot(jj_amo_rd32(code+i+10))!=c[7]{return 0;}if code[i+14]!=0x48{return 0;}var a:i64=0x01;if c[4]==10{a=0x29;}if (code[i+15]&255)!=a{return 0;}if (code[i+16]&255)!=0xc8{return 0;}if code[i+17]!=0x50{return 0;}if code[i+18]!=0x58{return 0;}if code[i+19]!=0x48{return 0;}if (code[i+20]&255)!=0xc1{return 0;}if (code[i+21]&255)!=0xe0{return 0;}if code[i+22]!=3{return 0;}if code[i+23]!=0x50{return 0;}if jj_reo_nop_match(code,i+24,i+36)==0{return 0;}if code[i+36]!=0x59{return 0;}if code[i+37]!=0x58{return 0;}if code[i+38]!=0x48{return 0;}if code[i+39]!=0x01{return 0;}if (code[i+40]&255)!=0xc8{return 0;}if jj_reo_nop_match(code,i+41,l+1)==0{return 0;}}
 if code[l+1]!=0x48{return 0;}if (code[l+2]&255)!=0x8b{return 0;}if code[l+3]!=0{return 0;}if code[l+4]!=0x50{return 0;}if code[l+5]!=0x90{return 0;}return 1;
}
fn jj_amo_emit_prefix(code:*i8,c:*i64)->i64{var at:i64=c[0];code[at]=0x48;code[at+1]=0x8b;code[at+2]=0x85;jj_amo_wr32(code+at+3,0-((c[5]+1)*8));at=at+7;code[at]=0x48;code[at+1]=0x8b;code[at+2]=0x8d;jj_amo_wr32(code+at+3,0-((c[6]+1)*8));return at+7;}
fn jj_amo_emit_adjust(code:*i8,at:i64,c:*i64)->i64{
 if c[3]==1{code[at]=0x48;code[at+1]=0x81;if c[4]==9{code[at+2]=0xc1;}else{code[at+2]=0xe9;}jj_amo_wr32(code+at+3,c[7]);return at+7;}code[at]=0x48;code[at+1]=0x8b;code[at+2]=0x95;jj_amo_wr32(code+at+3,0-((c[7]+1)*8));at=at+7;code[at]=0x48;if c[4]==9{code[at+1]=0x01;}else{code[at+1]=0x29;}code[at+2]=0xd1;return at+3;
}
fn jj_amo_emit(code:*i8,end:i64,c:*i64)->i64{
 if code==0{return 0;}if c==0{return 0;}var at:i64=jj_amo_emit_prefix(code,c);if at<=0{return 0;}at=jj_amo_emit_adjust(code,at,c);if at<=0{return 0;}code[at]=0x48;code[at+1]=0x8b;code[at+2]=0x04;code[at+3]=0xc8;at=at+4;code[at]=0x50;at=at+1;if end-at<7{return 0;}var skip:i64=end-at-2;if skip<5{return 0;}if skip>127{return 0;}code[at]=0xeb;code[at+1]=skip;at=at+2;if jj_reo_nop(code,at,end-5)==0{return 0;}return jj_amo_marker(code,end-5,0x66+c[3]);
}
fn jj_amo_try_load64(code:*i8,end:i64,program:*i8,h:*i64)->i64{if code==0{return 0-1;}if program==0{return 0-1;}if h==0{return 0-1;}var c:[8]i64;if jj_amo_history(h,end,c as *i64)==0{return 0;}if jj_amo_semantic(program,h,c as *i64)==0{return 0;}if jj_amo_machine(code,c as *i64)==0{return 0;}if jj_amo_emit(code,end,c as *i64)==0{return 0-1;}return 1;}
