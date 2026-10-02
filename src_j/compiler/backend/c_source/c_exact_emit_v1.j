// R767 deterministic C11 exact emitter. It consumes only sealed CIR and a
// legality receipt; no source, tokens, AST, host paths, timestamps or heap.
extern fn jj_c_exact_v1_legality(p0:*i64,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_cir_expression_kind(p0:*i64,p1:i64)->i64;
extern fn jj_cir_immediate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_true_immediate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_function_false_immediate(p0:*i64,p1:i64)->i64;
fn jj_ce_put8(out:*i8,cap:i64,at:i64,v:i64)->i64{if out==0{return 0-1;}if at<0{return 0-1;}if at>=cap{return 0-1;}out[at]=v;return at+1;}
fn jj_ce_text(out:*i8,cap:i64,at:i64,s:*i8)->i64{if s==0{return 0-1;}var i:i64=0;while s[i]!=0{at=jj_ce_put8(out,cap,at,s[i]);if at<0{return 0-1;}i=i+1;}return at;}
fn jj_ce_hex_digit(v:i64)->i64{v=v&15;if v<10{return 48+v;}return 87+v;}
fn jj_ce_u64_hex(out:*i8,cap:i64,at:i64,v:i64)->i64{var shift:i64=60;while shift>=0{at=jj_ce_put8(out,cap,at,jj_ce_hex_digit(v>>>shift));if at<0{return 0-1;}shift=shift-4;}return at;}
fn jj_ce_i64(out:*i8,cap:i64,at:i64,v:i64)->i64{at=jj_ce_text(out,cap,at,"((int64_t)UINT64_C(0x");if at<0{return 0-1;}at=jj_ce_u64_hex(out,cap,at,v);if at<0{return 0-1;}return jj_ce_text(out,cap,at,"))");}
fn jj_c_exact_v1_emit(cir:*i64,slots:i64,out:*i8,cap:i64)->i64{
 if out==0{return 0;}if cap<64{return 0;}var r:[8]i64;if jj_c_exact_v1_legality(cir,slots,r as *i64,8)==0{return 0;}var kind:i64=r[2];var at:i64=0;
 at=jj_ce_text(out,cap,at,"#include <stdint.h>");if at<0{return 0;}at=jj_ce_put8(out,cap,at,10);if at<0{return 0;}at=jj_ce_text(out,cap,at,"#include <inttypes.h>");if at<0{return 0;}at=jj_ce_put8(out,cap,at,10);if at<0{return 0;}
 if kind==1{at=jj_ce_text(out,cap,at,"int64_t jj_entry(void){return ");if at<0{return 0;}at=jj_ce_i64(out,cap,at,jj_cir_immediate(cir,slots));if at<0{return 0;}at=jj_ce_text(out,cap,at,";}");if at<0{return 0;}at=jj_ce_put8(out,cap,at,10);}
 else{if kind==2{at=jj_ce_text(out,cap,at,"int64_t jj_entry(int64_t a0){return a0;}");if at<0{return 0;}at=jj_ce_put8(out,cap,at,10);}
 else{if kind==3{at=jj_ce_text(out,cap,at,"int64_t jj_entry(int64_t a0){if(a0!=0){return ");if at<0{return 0;}at=jj_ce_i64(out,cap,at,jj_cir_function_true_immediate(cir,slots));if at<0{return 0;}at=jj_ce_text(out,cap,at,";}return ");if at<0{return 0;}at=jj_ce_i64(out,cap,at,jj_cir_function_false_immediate(cir,slots));if at<0{return 0;}at=jj_ce_text(out,cap,at,";}");if at<0{return 0;}at=jj_ce_put8(out,cap,at,10);}else{return 0;}}}
 if at<=0{return 0;}if at>=cap{return 0;}out[at]=0;return at;
}
fn jj_c_exact_v1_emit_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<8{return 0;}out[0]=0;out[1]=0;out[2]=0;out[3]=0;out[4]=8;out[5]=0;out[6]=0;out[7]=1;return 1;}
