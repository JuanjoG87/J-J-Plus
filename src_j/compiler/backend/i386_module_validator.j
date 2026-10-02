// Independent fail-closed validator for J/J+ IA-32 semantic modules.
// It parses ELF32, sections, symbols and R_386_PC32 relocations and decodes
// every .text instruction against the Intel 80386-only subset emitted by OMEGA.
extern fn jj_c_hash_bytes(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_target_profile_build(p0:i64,p1:*i64,p2:i64)->i64;
fn jj_i386v_u8(p:*i8,o:i64)->i64{return p[o]&255;}
fn jj_i386v_u16(p:*i8,o:i64)->i64{return (p[o]&255)|((p[o+1]&255)<<8);}
fn jj_i386v_u32(p:*i8,o:i64)->i64{return (p[o]&255)|((p[o+1]&255)<<8)|((p[o+2]&255)<<16)|((p[o+3]&255)<<24);}
fn jj_i386v_u64(p:*i8,o:i64)->i64{var v:i64=0;var i:i64=0;while i<8{v=v|((p[o+i]&255)<<(i*8));i=i+1;}return v;}
fn jj_i386v_range(size:i64,o:i64,n:i64)->i64{if size<=0{return 0;}if o<0{return 0;}if n<0{return 0;}if o>size{return 0;}if n>size-o{return 0;}return 1;}
fn jj_i386v_module_digest(p:*i8,omega:i64,profile:i64,relocs:i64,defined:i64,external:i64)->i64{if p==0{return 0;}if omega<=64{return 0;}if relocs<0{return 0;}if defined<=0{return 0;}if external<0{return 0;}var h:i64=jj_c_hash_bytes(p,64,omega-64)^profile^0x4a4a49334d4f4431;h=((h<<11)|(h>>>53))^relocs;h=((h<<13)|(h>>>51))^defined;h=((h<<17)|(h>>>47))^external;if h==0{h=0x4a4a49334d4f4431;}return h;}
fn jj_i386v_zero(p:*i8,o:i64,n:i64)->i64{var i:i64=0;while i<n{if (p[o+i]&255)!=0{return 0;}i=i+1;}return 1;}
fn jj_i386v_text(p:*i8,o:i64,s:*i8)->i64{var i:i64=0;while s[i]!=0{if (p[o+i]&255)!=(s[i]&255){return 0;}i=i+1;}return 1;}
fn jj_i386v_sh(p:*i8,shoff:i64,index:i64,out:*i64)->i64{if p==0{return 0;}if out==0{return 0;}var at:i64=shoff+index*40;var i:i64=0;while i<10{out[i]=jj_i386v_u32(p,at+i*4);i=i+1;}return 1;}
fn jj_i386v_section_shape(p:*i8,size:i64,shoff:i64,index:i64,expect:*i64)->i64{
 var s:[10]i64;if jj_i386v_sh(p,shoff,index,s as *i64)==0{return 0;}var i:i64=0;while i<10{if expect[i]>=0{if s[i]!=expect[i]{return 0;}}i=i+1;}if index==0{return jj_i386v_zero(p,shoff,40);}if jj_i386v_range(size,s[4],s[5])==0{return 0;}if s[8]>1{if (s[8]&(s[8]-1))!=0{return 0;}if (s[4]&(s[8]-1))!=0{return 0;}}return 1;
}
fn jj_i386v_modrm2(op:i64,m:i64)->i64{
 if op==0x89{if m==0xc0{return 1;}if m==0xd2{return 1;}if m==0xe5{return 1;}if m==0xc6{return 1;}if m==0xd7{return 1;}if m==0xc3{return 1;}if m==0xd1{return 1;}if m==0xf0{return 1;}if m==0xfa{return 1;}if m==0xd8{return 1;}if m==0xca{return 1;}if m==0xdf{return 1;}if m==0xc2{return 1;}if m==0xd0{return 1;}if m==0x03{return 1;}if m==0x53{return 2;}if m==0x85{return 5;}if m==0x95{return 5;}return 0;}
 if op==0x8b{if m==0x00{return 1;}if m==0x50{return 2;}if m==0x85{return 5;}if m==0x95{return 5;}return 0;}
 if op==0x01{if m==0xd8{return 1;}if m==0xf0{return 1;}if m==0xfa{return 1;}if m==0xf2{return 1;}return 0;}
 if op==0x11{if m==0xca{return 1;}if m==0xfa{return 1;}return 0;}
 if op==0x29{if m==0xd8{return 1;}if m==0xf0{return 1;}return 0;}
 if op==0x19{if m==0xca{return 1;}if m==0xfa{return 1;}return 0;}
 if op==0x21{if m==0xd8{return 1;}if m==0xf0{return 1;}if m==0xca{return 1;}if m==0xfa{return 1;}return 0;}
 if op==0x09{if m==0xd8{return 1;}if m==0xf0{return 1;}if m==0xca{return 1;}if m==0xfa{return 1;}if m==0xd0{return 1;}return 0;}
 if op==0x31{if m==0xd8{return 1;}if m==0xf0{return 1;}if m==0xca{return 1;}if m==0xfa{return 1;}if m==0xd2{return 1;}if m==0xc0{return 1;}return 0;}
 if op==0x39{if m==0xca{return 1;}if m==0xfe{return 1;}return 0;}
 if op==0x20{if m==0xcb{return 1;}return 0;}if op==0x08{if m==0xd8{return 1;}return 0;}if op==0x85{if m==0xd2{return 1;}return 0;}if op==0x88{if m==0x03{return 1;}return 0;}return 0;
}
fn jj_i386v_literal_call(p:*i8,at:i64,end:i64)->i64{
 if p==0{return 0;}if at<0{return 0;}if at+5>end{return 0;}if (p[at]&255)!=0xe8{return 0;}var d:i64=jj_i386v_u32(p,at+1);if (d&0x80000000)!=0{return 0;}if d<=0{return 0;}var target:i64=at+5+d;if target<=at+5{return 0;}if target+5>end{return 0;}if (p[target-1]&255)!=0{return 0;}if (p[target]&255)!=0x58{return 0;}if (p[target+1]&255)!=0x31{return 0;}if (p[target+2]&255)!=0xd2{return 0;}var tail0:i64=p[target+3]&255;var tail1:i64=p[target+4]&255;if tail0==0x52{if tail1==0x50{return 5+d;}}if tail0==0x89{if tail1==0xc0{return 5+d;}}return 0;
}
fn jj_i386v_decode(p:*i8,at:i64,end:i64)->i64{
 if at<0{return 0;}if at>=end{return 0;}var op:i64=p[at]&255;
 if op==0xcd{if at+2>end{return 0;}if (p[at+1]&255)!=0x80{return 0;}return 2;}if op==0x50{return 1;}if op==0x51{return 1;}if op==0x52{return 1;}if op==0x53{return 1;}if op==0x55{return 1;}if op==0x56{return 1;}if op==0x57{return 1;}if op==0x58{return 1;}if op==0x59{return 1;}if op==0x5a{return 1;}if op==0x5b{return 1;}if op==0x5d{return 1;}if op==0x5e{return 1;}if op==0x5f{return 1;}if op==0x90{return 1;}if op==0x99{return 1;}if op==0xc3{return 1;}
 if op==0xb8{if at+5>end{return 0;}return 5;}if op==0xba{if at+5>end{return 0;}return 5;}if op==0x3d{if at+5>end{return 0;}return 5;}if op==0xe8{if at+5>end{return 0;}var literal_bytes:i64=jj_i386v_literal_call(p,at,end);if literal_bytes>0{return literal_bytes;}return 5;}if op==0xe9{if at+5>end{return 0;}return 5;}
 if op==0x81{if at+6>end{return 0;}var m:i64=p[at+1]&255;if m!=0xec{if m!=0xc4{return 0;}}return 6;}if op==0x83{if at+3>end{return 0;}var m2:i64=p[at+1]&255;if m2==0xd2{if (p[at+2]&255)!=0{return 0;}return 3;}if m2==0xc4{if (p[at+2]&255)!=8{return 0;}return 3;}if m2==0xe1{if (p[at+2]&255)!=0x3f{return 0;}return 3;}return 0;}
 if op==0xf6{if at+3>end{return 0;}if (p[at+1]&255)!=0xc1{return 0;}if (p[at+2]&255)!=0x20{return 0;}return 3;}if op==0xd3{if at+2>end{return 0;}var dm:i64=p[at+1]&255;if dm==0xe0{return 2;}if dm==0xe2{return 2;}if dm==0xe8{return 2;}if dm==0xea{return 2;}if dm==0xf8{return 2;}if dm==0xfa{return 2;}return 0;}
 if op==0x8d{if at+2>end{return 0;}var lm:i64=p[at+1]&255;if lm==0x65{if at+3>end{return 0;}if (p[at+2]&255)!=0xf4{return 0;}return 3;}if lm==0x85{if at+6>end{return 0;}return 6;}return 0;}
 if op==0xf7{if at+2>end{return 0;}var m3:i64=p[at+1]&255;if m3==0xe3{return 2;}if m3==0xd8{return 2;}if m3==0xda{return 2;}return 0;}
 if op==0x03{if at+2>end{return 0;}var m4:i64=p[at+1]&255;if m4==0x85{if at+6>end{return 0;}return 6;}if at+3>end{return 0;}if m4!=0x04{return 0;}if (p[at+2]&255)!=0x24{return 0;}return 3;}
 if op==0x13{if at+2>end{return 0;}var m5:i64=p[at+1]&255;if m5==0x95{if at+6>end{return 0;}return 6;}if at+4>end{return 0;}if m5!=0x54{return 0;}if (p[at+2]&255)!=0x24{return 0;}if (p[at+3]&255)!=4{return 0;}return 4;}
 if op==0x2b{if at+2>end{return 0;}var m6:i64=p[at+1]&255;if m6==0x85{if at+6>end{return 0;}return 6;}if at+3>end{return 0;}if m6!=0x04{return 0;}if (p[at+2]&255)!=0x24{return 0;}return 3;}
 if op==0x1b{if at+2>end{return 0;}var m7:i64=p[at+1]&255;if m7==0x95{if at+6>end{return 0;}return 6;}if at+4>end{return 0;}if m7!=0x54{return 0;}if (p[at+2]&255)!=0x24{return 0;}if (p[at+3]&255)!=4{return 0;}return 4;}
 if op==0x23{if at+2>end{return 0;}var m8:i64=p[at+1]&255;if m8==0x85{if at+6>end{return 0;}return 6;}if m8==0x95{if at+6>end{return 0;}return 6;}if at+3<=end{if m8==0x04{if (p[at+2]&255)==0x24{return 3;}}}if at+4>end{return 0;}if m8!=0x54{return 0;}if (p[at+2]&255)!=0x24{return 0;}if (p[at+3]&255)!=4{return 0;}return 4;}
 if op==0x0b{if at+2>end{return 0;}var m9:i64=p[at+1]&255;if m9==0x85{if at+6>end{return 0;}return 6;}if m9==0x95{if at+6>end{return 0;}return 6;}if at+3<=end{if m9==0x04{if (p[at+2]&255)==0x24{return 3;}}}if at+4>end{return 0;}if m9!=0x54{return 0;}if (p[at+2]&255)!=0x24{return 0;}if (p[at+3]&255)!=4{return 0;}return 4;}
 if op==0x33{if at+2>end{return 0;}var m10:i64=p[at+1]&255;if m10==0x85{if at+6>end{return 0;}return 6;}if m10==0x95{if at+6>end{return 0;}return 6;}if at+3<=end{if m10==0x04{if (p[at+2]&255)==0x24{return 3;}}}if at+4<=end{if m10==0x54{if (p[at+2]&255)==0x24{if (p[at+3]&255)==4{return 4;}}}}}
 var ml:i64=jj_i386v_modrm2(op,0);if op==0x89{ml=1;}else{if op==0x8b{ml=1;}else{if op==0x01{ml=1;}else{if op==0x11{ml=1;}else{if op==0x29{ml=1;}else{if op==0x19{ml=1;}else{if op==0x21{ml=1;}else{if op==0x09{ml=1;}else{if op==0x31{ml=1;}else{if op==0x33{ml=1;}else{if op==0x39{ml=1;}else{if op==0x20{ml=1;}else{if op==0x08{ml=1;}}}}}}}}}}}}}
 if op==0x85{ml=1;}else{if op==0x88{ml=1;}}if ml!=0{if at+2>end{return 0;}var n:i64=jj_i386v_modrm2(op,p[at+1]&255);if n==0{return 0;}if at+1+n>end{return 0;}return 1+n;}
 if op==0x0f{if at+2>end{return 0;}var op2:i64=p[at+1]&255;if op2==0x83{if at+6>end{return 0;}return 6;}if op2==0x84{if at+6>end{return 0;}return 6;}if op2==0x85{if at+6>end{return 0;}return 6;}if op2==0xa5{if at+3>end{return 0;}if (p[at+2]&255)!=0xc2{return 0;}return 3;}if op2==0xad{if at+3>end{return 0;}if (p[at+2]&255)!=0xd0{return 0;}return 3;}if op2==0xaf{if at+3>end{return 0;}var a:i64=p[at+2]&255;if a!=0xfb{if a!=0xf1{return 0;}}return 3;}if op2==0xb6{if at+3>end{return 0;}if (p[at+2]&255)!=0xc0{return 0;}return 3;}if op2==0xbe{if at+3>end{return 0;}var bm:i64=p[at+2]&255;if bm!=0xc0{if bm!=0x00{return 0;}}return 3;}if op2>=0x90{if op2<=0x9f{if at+3>end{return 0;}var sm:i64=p[at+2]&255;if sm!=0xc0{if sm!=0xc1{if sm!=0xc3{return 0;}}}return 3;}}return 0;}
 return 0;
}
fn jj_i386v_boundary(p:*i8,start:i64,end:i64,target:i64)->i64{if target<start{return 0;}if target>=end{return 0;}var at:i64=start;var steps:i64=0;while at<target{var n:i64=jj_i386v_decode(p,at,end);if n<=0{return 0;}at=at+n;steps=steps+1;if steps>1048576{return 0;}}if at!=target{return 0;}return 1;}
fn jj_i386v_function_code(p:*i8,text:i64,start:i64,bytes:i64)->i64{
 if bytes<=0{return 0;}var at:i64=text+start;var end:i64=at+bytes;if (p[at]&255)!=0x55{return 0;}var boundaries:i64=0;while at<end{var n:i64=jj_i386v_decode(p,at,end);if n<=0{return 0;}var op:i64=p[at]&255;if op==0xe9{var d:i64=jj_i386v_u32(p,at+1);if (d&0x80000000)!=0{d=d|0xffffffff00000000;}var t:i64=at+5+d;if jj_i386v_boundary(p,text+start,end,t)==0{return 0;}}if op==0x0f{var o2:i64=p[at+1]&255;if o2==0x83{var d0:i64=jj_i386v_u32(p,at+2);if (d0&0x80000000)!=0{d0=d0|0xffffffff00000000;}var t0:i64=at+6+d0;if jj_i386v_boundary(p,text+start,end,t0)==0{return 0;}}else{if o2==0x84{var d2:i64=jj_i386v_u32(p,at+2);if (d2&0x80000000)!=0{d2=d2|0xffffffff00000000;}var t2:i64=at+6+d2;if jj_i386v_boundary(p,text+start,end,t2)==0{return 0;}}else{if o2==0x85{var d3:i64=jj_i386v_u32(p,at+2);if (d3&0x80000000)!=0{d3=d3|0xffffffff00000000;}var t3:i64=at+6+d3;if jj_i386v_boundary(p,text+start,end,t3)==0{return 0;}}}}}at=at+n;boundaries=boundaries+1;if boundaries>1048576{return 0;}}
 if at!=end{return 0;}if (p[end-1]&255)!=0xc3{return 0;}return 1;
}
fn jj_i386v_name_equal(p:*i8,str:i64,str_size:i64,a:i64,b:i64)->i64{if a<=0{return 0;}if b<=0{return 0;}if a>=str_size{return 0;}if b>=str_size{return 0;}var i:i64=0;while a+i<str_size{if b+i>=str_size{return 0;}var av:i64=p[str+a+i]&255;var bv:i64=p[str+b+i]&255;if av!=bv{return 0;}if av==0{return 1;}i=i+1;}return 0;}
fn jj_i386v_symbols(p:*i8,r:*i64,defined:i64,external:i64)->i64{
 if p==0{return 0;}if r==0{return 0;}if defined<=0{return 0;}if external<0{return 0;}var text:i64=r[0];var text_size:i64=r[1];var sym:i64=r[2];var sym_size:i64=r[3];var str:i64=r[4];var str_size:i64=r[5];if sym_size<48{return 0;}if sym_size%16!=0{return 0;}var count:i64=sym_size/16;if count!=defined+external+2{return 0;}if jj_i386v_zero(p,sym,16)==0{return 0;}if jj_i386v_u32(p,sym+16)!=0{return 0;}if jj_i386v_u32(p,sym+20)!=0{return 0;}if jj_i386v_u32(p,sym+24)!=0{return 0;}if (p[sym+28]&255)!=3{return 0;}if (p[sym+29]&255)!=0{return 0;}if jj_i386v_u16(p,sym+30)!=1{return 0;}if (p[str]&255)!=0{return 0;}
 var expected:i64=0;var expected_name:i64=1;var i:i64=2;while i<count{var e:i64=sym+i*16;var no:i64=jj_i386v_u32(p,e);var value:i64=jj_i386v_u32(p,e+4);var bytes:i64=jj_i386v_u32(p,e+8);if no<=0{return 0;}if no>=str_size{return 0;}if no!=expected_name{return 0;}if (p[e+12]&255)!=0x12{return 0;}if (p[e+13]&255)!=0{return 0;}var q:i64=no;var chars:i64=0;while q<str_size{if (p[str+q]&255)==0{break;}chars=chars+1;q=q+1;}if q>=str_size{return 0;}if chars<=0{return 0;}expected_name=q+1;var earlier:i64=2;while earlier<i{var eno:i64=jj_i386v_u32(p,sym+earlier*16);if jj_i386v_name_equal(p,str,str_size,no,eno)!=0{return 0;}earlier=earlier+1;}if i<defined+2{if value!=expected{return 0;}if bytes<=0{return 0;}if bytes>text_size-value{return 0;}if jj_i386v_u16(p,e+14)!=1{return 0;}if jj_i386v_function_code(p,text,value,bytes)==0{return 0;}expected=expected+bytes;}else{if value!=0{return 0;}if bytes!=0{return 0;}if jj_i386v_u16(p,e+14)!=0{return 0;}}i=i+1;}if expected!=text_size{return 0;}if expected_name!=str_size{return 0;}return count;
}
fn jj_i386v_relocations(p:*i8,r:*i64,symbols:i64)->i64{
 if p==0{return 0-1;}if r==0{return 0-1;}var text:i64=r[0];var text_size:i64=r[1];var rel:i64=r[2];var rel_size:i64=r[3];if rel_size%8!=0{return 0;}var count:i64=rel_size/8;var i:i64=0;var previous:i64=0-1;while i<count{var e:i64=rel+i*8;var off:i64=jj_i386v_u32(p,e);if off<=previous{return 0;}previous=off;var info:i64=jj_i386v_u32(p,e+4);if off<=0{return 0;}if off>text_size-4{return 0;}if (p[text+off-1]&255)!=0xe8{return 0;}if jj_i386v_u32(p,text+off)!=0xfffffffc{return 0;}if (info&255)!=2{return 0;}var si:i64=info>>>8;if si<2{return 0;}if si>=symbols{return 0;}i=i+1;}return count;
}
fn jj_i386v_reloc_at(p:*i8,rel:i64,count:i64,off:i64)->i64{
 var i:i64=0;while i<count{var ro:i64=jj_i386v_u32(p,rel+i*8);if ro==off{return 1;}if ro>off{return 0;}i=i+1;}return 0;
}
fn jj_i386v_defined_start(p:*i8,sym:i64,defined:i64,target:i64)->i64{
 var i:i64=0;while i<defined{if jj_i386v_u32(p,sym+(i+2)*16+4)==target{return 1;}i=i+1;}return 0;
}
fn jj_i386v_calls(p:*i8,r:*i64,defined:i64,relocs:i64)->i64{
 if p==0{return 0;}if r==0{return 0;}if defined<=0{return 0;}if relocs<0{return 0;}
 var text:i64=r[0];var text_size:i64=r[1];var sym:i64=r[2];var rel:i64=r[3];var rel_count:i64=r[4];
 var unresolved:i64=0;var fi:i64=0;while fi<defined{
  var entry:i64=sym+(fi+2)*16;var start:i64=jj_i386v_u32(p,entry+4);var bytes:i64=jj_i386v_u32(p,entry+8);
  if start<0{return 0;}if bytes<=0{return 0;}if start>text_size-bytes{return 0;}var at:i64=text+start;var end:i64=at+bytes;
  while at<end{var n:i64=jj_i386v_decode(p,at,end);if n<=0{return 0;}if (p[at]&255)==0xe8{
    var off:i64=(at-text)+1;if jj_i386v_reloc_at(p,rel,rel_count,off)!=0{if jj_i386v_u32(p,at+1)!=0xfffffffc{return 0;}unresolved=unresolved+1;}
    else{var literal_bytes:i64=jj_i386v_literal_call(p,at,end);if literal_bytes<=0{var d:i64=jj_i386v_u32(p,at+1);if (d&0x80000000)!=0{d=d|0xffffffff00000000;}var target:i64=(at-text)+5+d;if target<0{return 0;}if target>=text_size{return 0;}if jj_i386v_defined_start(p,sym,defined,target)==0{return 0;}}}
   }at=at+n;
  }if at!=end{return 0;}fi=fi+1;
 }
 if unresolved!=relocs{return 0;}return 1;
}
fn jj_target_i386_module_validate(p:*i8,size:i64,expected_profile:i64,expected_digest:i64)->i64{
 if p==0{return 0;}if size<340{return 0;}if jj_i386v_u32(p,0)!=0x464c457f{return 0;}if (p[4]&255)!=1{return 0;}if (p[5]&255)!=1{return 0;}if (p[6]&255)!=1{return 0;}if jj_i386v_zero(p,7,9)==0{return 0;}if jj_i386v_u16(p,16)!=1{return 0;}if jj_i386v_u16(p,18)!=3{return 0;}if jj_i386v_u32(p,20)!=1{return 0;}if jj_i386v_u32(p,24)!=0{return 0;}if jj_i386v_u32(p,28)!=0{return 0;}var shoff:i64=jj_i386v_u32(p,32);if shoff<52{return 0;}if jj_i386v_u32(p,36)!=0{return 0;}if jj_i386v_u16(p,40)!=52{return 0;}if jj_i386v_u16(p,42)!=0{return 0;}if jj_i386v_u16(p,44)!=0{return 0;}if jj_i386v_u16(p,46)!=40{return 0;}if jj_i386v_u16(p,48)!=7{return 0;}if jj_i386v_u16(p,50)!=6{return 0;}if shoff+280!=size{return 0;}
 var z:[10]i64;var i:i64=0;while i<10{z[i]=0;i=i+1;}if jj_i386v_section_shape(p,size,shoff,0,z as *i64)==0{return 0;}var s1:[10]i64;var s2:[10]i64;var s3:[10]i64;var s4:[10]i64;var s5:[10]i64;var s6:[10]i64;jj_i386v_sh(p,shoff,1,s1 as *i64);jj_i386v_sh(p,shoff,2,s2 as *i64);jj_i386v_sh(p,shoff,3,s3 as *i64);jj_i386v_sh(p,shoff,4,s4 as *i64);jj_i386v_sh(p,shoff,5,s5 as *i64);jj_i386v_sh(p,shoff,6,s6 as *i64);
 if s1[0]!=1{return 0;}if s1[1]!=1{return 0;}if s1[2]!=6{return 0;}if s1[3]!=0{return 0;}if s1[4]!=64{return 0;}if s1[5]<=0{return 0;}if s1[6]!=0{return 0;}if s1[7]!=0{return 0;}if s1[8]!=16{return 0;}if s1[9]!=0{return 0;}
 if s2[0]!=7{return 0;}if s2[1]!=9{return 0;}if s2[2]!=0{return 0;}if s2[3]!=0{return 0;}if s2[5]%8!=0{return 0;}if s2[6]!=3{return 0;}if s2[7]!=1{return 0;}if s2[8]!=4{return 0;}if s2[9]!=8{return 0;}
 if s3[0]!=17{return 0;}if s3[1]!=2{return 0;}if s3[2]!=0{return 0;}if s3[3]!=0{return 0;}if s3[5]%16!=0{return 0;}if s3[6]!=4{return 0;}if s3[7]!=2{return 0;}if s3[8]!=4{return 0;}if s3[9]!=16{return 0;}
 if s4[0]!=25{return 0;}if s4[1]!=3{return 0;}if s4[2]!=0{return 0;}if s4[3]!=0{return 0;}if s4[5]<=1{return 0;}if s4[6]!=0{return 0;}if s4[7]!=0{return 0;}if s4[8]!=1{return 0;}if s4[9]!=0{return 0;}
 if s5[0]!=33{return 0;}if s5[1]!=1{return 0;}if s5[2]!=0{return 0;}if s5[3]!=0{return 0;}if s5[5]!=56{return 0;}if s5[6]!=0{return 0;}if s5[7]!=0{return 0;}if s5[8]!=8{return 0;}if s5[9]!=0{return 0;}
 if s6[0]!=40{return 0;}if s6[1]!=3{return 0;}if s6[2]!=0{return 0;}if s6[3]!=0{return 0;}if s6[5]!=50{return 0;}if s6[6]!=0{return 0;}if s6[7]!=0{return 0;}if s6[8]!=1{return 0;}if s6[9]!=0{return 0;}
 i=1;while i<7{var sx:[10]i64;jj_i386v_sh(p,shoff,i,sx as *i64);if jj_i386v_range(size,sx[4],sx[5])==0{return 0;}i=i+1;}if s2[4]!=((s1[4]+s1[5]+3)&0xfffffffffffffffc){return 0;}if s3[4]!=s2[4]+s2[5]{return 0;}if s4[4]!=s3[4]+s3[5]{return 0;}if s5[4]!=((s4[4]+s4[5]+7)&0xfffffffffffffff8){return 0;}if s6[4]!=s5[4]+56{return 0;}if shoff!=((s6[4]+50+3)&0xfffffffffffffffc){return 0;}
 if jj_i386v_zero(p,52,12)==0{return 0;}if jj_i386v_zero(p,s1[4]+s1[5],s2[4]-(s1[4]+s1[5]))==0{return 0;}if jj_i386v_zero(p,s4[4]+s4[5],s5[4]-(s4[4]+s4[5]))==0{return 0;}if jj_i386v_zero(p,s6[4]+50,shoff-(s6[4]+50))==0{return 0;}
 if jj_i386v_text(p,s6[4]+1,".text")==0{return 0;}if jj_i386v_text(p,s6[4]+7,".rel.text")==0{return 0;}if jj_i386v_text(p,s6[4]+17,".symtab")==0{return 0;}if jj_i386v_text(p,s6[4]+25,".strtab")==0{return 0;}if jj_i386v_text(p,s6[4]+33,".omega")==0{return 0;}if jj_i386v_text(p,s6[4]+40,".shstrtab")==0{return 0;}
 if (p[s6[4]]&255)!=0{return 0;}if (p[s6[4]+6]&255)!=0{return 0;}if (p[s6[4]+16]&255)!=0{return 0;}if (p[s6[4]+24]&255)!=0{return 0;}if (p[s6[4]+32]&255)!=0{return 0;}if (p[s6[4]+39]&255)!=0{return 0;}if (p[s6[4]+49]&255)!=0{return 0;}
 if jj_i386v_u32(p,s5[4])!=0x4f4d4547{return 0;}if jj_i386v_u32(p,s5[4]+4)!=0x41333836{return 0;}var profile:i64=jj_i386v_u64(p,s5[4]+8);var canonical_profile:[32]i64;if jj_target_profile_build(8,canonical_profile as *i64,32)==0{return 0;}if profile!=canonical_profile[31]{return 0;}var digest:i64=jj_i386v_u64(p,s5[4]+16);var text_hash:i64=jj_i386v_u64(p,s5[4]+24);var declared_relocs:i64=jj_i386v_u64(p,s5[4]+32);var defined:i64=jj_i386v_u64(p,s5[4]+40);var external:i64=jj_i386v_u64(p,s5[4]+48);if expected_profile!=0{if profile!=expected_profile{return 0;}}if expected_digest!=0{if digest!=expected_digest{return 0;}}if text_hash!=jj_c_hash_bytes(p,s1[4],s1[5]){return 0;}if defined<=0{return 0;}if external<0{return 0;}if digest!=jj_i386v_module_digest(p,s5[4],profile,declared_relocs,defined,external){return 0;}
 var sr:[6]i64;sr[0]=s1[4];sr[1]=s1[5];sr[2]=s3[4];sr[3]=s3[5];sr[4]=s4[4];sr[5]=s4[5];var symbols:i64=jj_i386v_symbols(p,sr as *i64,defined,external);if symbols<=0{return 0;}var rr:[4]i64;rr[0]=s1[4];rr[1]=s1[5];rr[2]=s2[4];rr[3]=s2[5];var relocs:i64=jj_i386v_relocations(p,rr as *i64,symbols);if relocs<0{return 0;}if declared_relocs!=relocs{return 0;}
 var cr:[5]i64;cr[0]=s1[4];cr[1]=s1[5];cr[2]=s3[4];cr[3]=s2[4];cr[4]=relocs;if jj_i386v_calls(p,cr as *i64,defined,relocs)==0{return 0;}return 1;
}
fn jj_i386_module_validator_resource_contract(out:*i64,slots:i64)->i64{if out==0{return 0;}if slots!=8{return 0;}out[0]=64;out[1]=64;out[2]=512;out[3]=3;out[4]=0;out[5]=1;out[6]=1;out[7]=(out as i64)^0x4a4a493338365641;return 1;}
