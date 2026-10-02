// Shared source-lexeme rules. Scanner, parser and semantic phases consume this
// small boundary instead of importing one another for name or unsafe ABI tests.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_c_hash_bytes(source:*i8,start:i64,count:i64)->i64{
  if source==0{return 0;}if start<0{return 0;}if count<0{return 0;}var hash:i64=0x14650fb0739d0383;var i:i64=0;
  while i<count{hash=(hash^(source[start+i]&255))*0x100000001b3;i=i+1;}return hash;
}
fn jj_c_name_equal(source:*i8,a:i64,alen:i64,b:i64,blen:i64)->i64{
  if source==0{return 0;}if a<0{return 0;}if b<0{return 0;}if alen!=blen{return 0;}if alen<0{return 0;}var i:i64=0;
  while i<alen{if source[a+i]!=source[b+i]{return 0;}i=i+1;}return 1;
}
fn jj_c_match_ascii(source:*i8,at:i64,count:i64,expected:*i64,expected_count:i64)->i64{
  if source==0{return 0;}if expected==0{return 0;}if at<0{return 0;}if count!=expected_count{return 0;}var i:i64=0;
  while i<expected_count{if source[at+i]!=expected[i]{return 0;}i=i+1;}return 1;
}
fn jj_c_is_entry_main(source:*i8,at:i64,count:i64)->i64{
  var expected:[6]i64;expected[0]=106;expected[1]=95;expected[2]=109;expected[3]=97;expected[4]=105;expected[5]=110;
  return jj_c_match_ascii(source,at,count,expected as *i64,6);
}
fn jj_c_is_i8_to_i64(source:*i8,at:i64,count:i64)->i64{
  var expected:[12]i64;expected[0]=106;expected[1]=106;expected[2]=95;expected[3]=105;expected[4]=56;expected[5]=95;expected[6]=116;expected[7]=111;expected[8]=95;expected[9]=105;expected[10]=54;expected[11]=52;
  return jj_c_match_ascii(source,at,count,expected as *i64,12);
}
fn jj_c_is_i64_to_ptr(source:*i8,at:i64,count:i64)->i64{
  var expected:[13]i64;expected[0]=106;expected[1]=106;expected[2]=95;expected[3]=105;expected[4]=54;expected[5]=52;expected[6]=95;expected[7]=116;expected[8]=111;expected[9]=95;expected[10]=112;expected[11]=116;expected[12]=114;
  return jj_c_match_ascii(source,at,count,expected as *i64,13);
}
fn jj_c_is_ptr_to_i64(source:*i8,at:i64,count:i64)->i64{
  var expected:[13]i64;expected[0]=106;expected[1]=106;expected[2]=95;expected[3]=112;expected[4]=116;expected[5]=114;expected[6]=95;expected[7]=116;expected[8]=111;expected[9]=95;expected[10]=105;expected[11]=54;expected[12]=52;
  return jj_c_match_ascii(source,at,count,expected as *i64,13);
}
fn jj_c_is_unsafe_abi_syscall3(source:*i8,at:i64,count:i64)->i64{
  var expected:[22]i64;expected[0]=106;expected[1]=106;expected[2]=95;expected[3]=117;expected[4]=110;expected[5]=115;expected[6]=97;expected[7]=102;expected[8]=101;expected[9]=95;expected[10]=97;expected[11]=98;expected[12]=105;expected[13]=95;expected[14]=115;expected[15]=121;expected[16]=115;expected[17]=99;expected[18]=97;expected[19]=108;expected[20]=108;expected[21]=51;
  return jj_c_match_ascii(source,at,count,expected as *i64,22);
}
fn jj_c_is_unsafe_abi_syscall4(source:*i8,at:i64,count:i64)->i64{
  var expected:[22]i64;expected[0]=106;expected[1]=106;expected[2]=95;expected[3]=117;expected[4]=110;expected[5]=115;expected[6]=97;expected[7]=102;expected[8]=101;expected[9]=95;expected[10]=97;expected[11]=98;expected[12]=105;expected[13]=95;expected[14]=115;expected[15]=121;expected[16]=115;expected[17]=99;expected[18]=97;expected[19]=108;expected[20]=108;expected[21]=52;
  return jj_c_match_ascii(source,at,count,expected as *i64,22);
}
fn jj_c_is_unsafe_abi_syscall5(source:*i8,at:i64,count:i64)->i64{
  var expected:[22]i64;expected[0]=106;expected[1]=106;expected[2]=95;expected[3]=117;expected[4]=110;expected[5]=115;expected[6]=97;expected[7]=102;expected[8]=101;expected[9]=95;expected[10]=97;expected[11]=98;expected[12]=105;expected[13]=95;expected[14]=115;expected[15]=121;expected[16]=115;expected[17]=99;expected[18]=97;expected[19]=108;expected[20]=108;expected[21]=53;
  return jj_c_match_ascii(source,at,count,expected as *i64,22);
}
fn jj_c_is_unsafe_abi_call5_frame(source:*i8,at:i64,count:i64)->i64{
  var expected:[25]i64;expected[0]=106;expected[1]=106;expected[2]=95;expected[3]=117;expected[4]=110;expected[5]=115;expected[6]=97;expected[7]=102;expected[8]=101;expected[9]=95;expected[10]=97;expected[11]=98;expected[12]=105;expected[13]=95;expected[14]=99;expected[15]=97;expected[16]=108;expected[17]=108;expected[18]=53;expected[19]=95;expected[20]=102;expected[21]=114;expected[22]=97;expected[23]=109;expected[24]=101;
  return jj_c_match_ascii(source,at,count,expected as *i64,25);
}
