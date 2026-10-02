// x86 stack-lowering join policy v1.
// The current x86 backend lowers source variables to stable frame slots before
// target register allocation. Semantic edge copies are therefore already
// represented by predecessor stores into the destination slot; fabricating a
// virtual register assignment and a physical copy schedule here would be dead
// work. This receipt proves the frozen CIRX capture/commit pairing that permits
// that deferral. A future register-allocated backend must replace this policy
// with actual edge-copy emission rather than reusing this receipt.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_cirx_available_valid(p0:*i64)->i64;
extern fn jj_cirx_copy_count(p0:*i64)->i64;
extern fn jj_cirx_op_count(p0:*i64)->i64;
extern fn jj_cirx_temp_count(p0:*i64)->i64;
extern fn jj_cirx_raw_op_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_target_value_bits(p0:i64,p1:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_x86_stack_join_receipt(core:*i64,target_kind:i64)->i64{
  if core==0{return 0;}if target_kind!=5{return 0;}if jj_cirx_available_valid(core)==0{return 0;}
  var copies:i64=jj_cirx_copy_count(core);var ops:i64=jj_cirx_op_count(core);var temps:i64=jj_cirx_temp_count(core);
  if copies<0{return 0;}if ops!=copies*2{return 0;}if temps!=copies{return 0;}
  var h:i64=0x4a4a5853544b4a31^copies^ops^(temps<<32);var i:i64=0;
  while i<copies{
    var commit:i64=copies+i;var placement:i64=jj_cirx_raw_op_word(core,i,0);var ordinal:i64=jj_cirx_raw_op_word(core,i,2);var temp:i64=jj_cirx_raw_op_word(core,i,3);var source:i64=jj_cirx_raw_op_word(core,i,4);var type_id:i64=jj_cirx_raw_op_word(core,i,5);
    if placement<=0{return 0;}if jj_cirx_raw_op_word(core,i,1)!=1{return 0;}if temp!=i+1{return 0;}if source<=0{return 0;}if type_id<=0{return 0;}if jj_target_value_bits(target_kind,type_id)<=0{return 0;}
    if jj_cirx_raw_op_word(core,commit,0)!=placement{return 0;}if jj_cirx_raw_op_word(core,commit,1)!=2{return 0;}if jj_cirx_raw_op_word(core,commit,2)!=ordinal{return 0;}if jj_cirx_raw_op_word(core,commit,3)!=temp{return 0;}var destination:i64=jj_cirx_raw_op_word(core,commit,4);if destination<=0{return 0;}if jj_cirx_raw_op_word(core,commit,5)!=type_id{return 0;}
    h=((h<<7)|(h>>>57))^placement^(ordinal<<8)^(temp<<24)^source^(destination<<32)^type_id;i=i+1;
  }
  if h==0{return 1;}return h;
}
