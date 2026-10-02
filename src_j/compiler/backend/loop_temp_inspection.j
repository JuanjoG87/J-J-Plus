// on-demand inspection companion; excluded from resident selfhost closures.
extern fn jj_loop_liveout_store_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_loop_liveout_load_ok(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;

fn jj_loop_temp_patch_store(code:*i8,at:i64,limit:i64,slot:i64)->i64{
  var p:i64=jj_loop_liveout_store_at(code,at,limit,slot);if p<0{return 0;}code[p]=0x49;code[p+1]=0x89;code[p+2]=0xc0;code[p+3]=0x0f;code[p+4]=0x1f;code[p+5]=0x40;code[p+6]=0x63;return 1;
}
fn jj_loop_temp_patch_load(code:*i8,at:i64,limit:i64,slot:i64)->i64{
  var kind:i64=jj_loop_liveout_load_ok(code,at,limit,slot);if kind==0{return 0;}if kind==1{code[at]=0x41;code[at+1]=0x50;code[at+2]=0x0f;code[at+3]=0x1f;code[at+4]=0x40;code[at+5]=0x64;return 1;}
  code[at]=0x4c;code[at+1]=0x89;if kind==2{code[at+2]=0xc0;}if kind==3{code[at+2]=0xc1;}if kind==4{code[at+2]=0xc2;}if kind==5{code[at+2]=0xc6;}if kind==6{code[at+2]=0xc7;}code[at+3]=0x0f;code[at+4]=0x1f;code[at+5]=0x40;code[at+6]=0x65;return 1;
}
