// Native extended bytecode operations, separated from frontend data semantics.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_n_e8(p0: *i64, p1: i64) -> i64;
extern fn jj_n_e32(p0: *i64, p1: i64) -> i64;
extern fn jj_vm_rd16(p0: *i8) -> i64;
extern fn jj_vm_rd32(p0: *i8) -> i64;
extern fn jj_express_sink_position(p0: *i64) -> i64;
extern fn jj_n_emit_pop_arg(p0:*i64,p1:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_n_emit_extended_op(state:*i64,program:*i8,pc:i64,fail_at:i64,op:i64)->i64{
  if op==44{if jj_n_e8(state,0x58)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0xc0)==0{return 0;}if jj_n_e8(state,0x50)==0{return 0;}return 1;}
  if op==45{var bound:i64=jj_vm_rd32(program+pc+1);if bound<=0{return 0;}if jj_n_e8(state,0x58)==0{return 0;}if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x85)==0{return 0;}if jj_n_e8(state,0xc0)==0{return 0;}if jj_n_e8(state,0x0f)==0{return 0;}if jj_n_e8(state,0x88)==0{return 0;}if jj_n_e32(state,fail_at-(jj_express_sink_position(state)+4))==0{return 0;}if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x3d)==0{return 0;}if jj_n_e32(state,bound)==0{return 0;}if jj_n_e8(state,0x0f)==0{return 0;}if jj_n_e8(state,0x83)==0{return 0;}if jj_n_e32(state,fail_at-(jj_express_sink_position(state)+4))==0{return 0;}if jj_n_e8(state,0x50)==0{return 0;}return 1;}
  if op==46{if jj_n_e8(state,0x58)==0{return 0;}if jj_n_e8(state,0x8b)==0{return 0;}if jj_n_e8(state,0x00)==0{return 0;}if jj_n_e8(state,0x50)==0{return 0;}return 1;}
  if op==47{if jj_n_e8(state,0x58)==0{return 0;}if jj_n_e8(state,0x59)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0x01)==0{return 0;}return 1;}
  if op==48{var text_length:i64=jj_vm_rd16(program+pc+1);if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x8d)==0{return 0;}if jj_n_e8(state,0x05)==0{return 0;}if jj_n_e32(state,5)==0{return 0;}if jj_n_e8(state,0xe9)==0{return 0;}if jj_n_e32(state,text_length+1)==0{return 0;}var text_i:i64=0;while text_i<text_length{if jj_n_e8(state,program[pc+3+text_i])==0{return 0;}text_i=text_i+1;}if jj_n_e8(state,0)==0{return 0;}if jj_n_e8(state,0x50)==0{return 0;}return 1;}
  if op==49{var k5:i64=6;while k5>0{k5=k5-1;if jj_n_emit_pop_arg(state,k5)==0{return 0;}}if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0xf8)==0{return 0;}if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0xf7)==0{return 0;}if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0xd6)==0{return 0;}if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0xca)==0{return 0;}if jj_n_e8(state,0x4d)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0xc2)==0{return 0;}if jj_n_e8(state,0x4d)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0xc8)==0{return 0;}if jj_n_e8(state,0x0f)==0{return 0;}if jj_n_e8(state,0x05)==0{return 0;}if jj_n_e8(state,0x50)==0{return 0;}return 1;}
  return 0;
}
