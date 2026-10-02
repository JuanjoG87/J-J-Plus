// R767 C-exact legality. Pure J/J+ authority over the initial C11 personality.
// Supported CIR forms: constant i64, identity i64 argument, and strict
// one-argument zero/nonzero diamond returning two i64 immediates.
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_expression_kind(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_kind(p0:*i64,p1:i64)->i64;
fn jj_c_exact_v1_kind(cir:*i64,slots:i64)->i64{
 if cir==0{return 0;}if slots<12{return 0;}if jj_cir_validate(cir,slots)==0{return 0;}
 var k:i64=jj_cir_expression_kind(cir,slots);if k==1{return 1;}if k==2{return 2;}
 if jj_cir_function_kind(cir,slots)==1{return 3;}return 0;
}
fn jj_c_exact_v1_legality(cir:*i64,slots:i64,receipt:*i64,n:i64)->i64{
 if receipt==0{return 0;}if n<8{return 0;}var i:i64=0;while i<8{receipt[i]=0;i=i+1;}
 var kind:i64=jj_c_exact_v1_kind(cir,slots);if kind==0{return 0;}
 receipt[0]=0x4a4a434558563031;receipt[1]=1;receipt[2]=kind;receipt[3]=64;
 receipt[4]=0;receipt[5]=0;receipt[6]=0;receipt[7]=receipt[0]^receipt[1]^receipt[2]^receipt[3]^0x434c4547414c5631;
 return 1;
}
fn jj_c_exact_v1_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<8{return 0;}out[0]=0;out[1]=0;out[2]=0;out[3]=0;out[4]=8;out[5]=1;out[6]=3;out[7]=0;return 1;}
