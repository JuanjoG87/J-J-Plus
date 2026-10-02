// Frontend coordinator v5: complete token stream -> AST publication -> semantic publication.
// Every phase owns an address-bound state and clears it on failure.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_target_source_kind(p0:*i8,p1:i64)->i64;
extern fn jj_core_target_set(p0:*i64,p1:i64)->i64;
extern fn jj_scanner_phase_execute(p0:*i64,p1:*i64,p2:*i8,p3:i64,p4:*i64)->i64;
extern fn jj_scanner_phase_valid(p0:*i64)->i64;
extern fn jj_parser_phase_execute(p0:*i64,p1:*i64,p2:*i64)->i64;
extern fn jj_parser_phase_valid(p0:*i64)->i64;
extern fn jj_parser_phase_failure_export(p0:*i64,p1:*i64)->i64;
extern fn jj_semantic_phase_execute(p0:*i64,p1:*i64,p2:*i64,p3:*i64)->i64;
extern fn jj_semantic_phase_valid(p0:*i64)->i64;
extern fn jj_compile_frontend_context_valid(p0:*i64)->i64;
extern fn jj_compile_frontend_program_base(p0:*i64)->i64;
extern fn jj_compile_frontend_program_capacity(p0:*i64)->i64;
extern fn jj_operand_tree_release(p0:*i64)->i64;
extern fn jj_cfg_release(p0:*i64)->i64;
extern fn jj_def_release(p0:*i64)->i64;
extern fn jj_join_release(p0:*i64)->i64;
extern fn jj_edge_release(p0:*i64)->i64;
extern fn jj_parallel_release(p0:*i64)->i64;
extern fn jj_cir_verifier_release(p0:*i64)->i64;
extern fn jj_typed_node_arena_release(p0:*i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_c_contains_target(core:*i64)->i64{if core==0{return 0;}return jj_target_source_kind(core[0] as *i8,core[1]);}
fn jj_frontend_phase_clear(state:*i64)->i64{if state==0{return 0;}var i:i64=0;while i<12{state[i]=0;i=i+1;}return 1;}
fn jj_frontend_phase_seal(state:*i64)->i64{return (state as i64)^state[0]^state[1]^state[2]^state[3]^state[4]^state[5]^state[6]^state[7]^state[8]^state[9]^state[10]^0x4a4a465250485333;}
fn jj_frontend_phase_valid(state:*i64)->i64{
  if state==0{return 0;}if state[0]!=0x4a4a465250483033{return 0;}if state[1]==0{return 0;}if state[2]<=0{return 0;}if state[3]==0{return 0;}if state[4]<65536{return 0;}var source_end:i64=state[1]+state[2];if source_end<=state[1]{return 0;}var program_end:i64=state[3]+state[4];if program_end<=state[3]{return 0;}if source_end>state[3]{if program_end>state[1]{return 0;}}if state[5]!=5{if state[5]!=6{if state[5]!=7{if state[5]!=8{if state[5]!=9{if state[5]!=10{return 0;}}}}}}if state[6]<=48{return 0;}if state[6]>state[4]{return 0;}if state[7]<=0{return 0;}if state[8]<0{return 0;}if state[9]<=0{return 0;}if state[10]<=0{return 0;}if state[11]!=jj_frontend_phase_seal(state){return 0;}return 1;
}
fn jj_frontend_phase_execute(state:*i64,core:*i64,source:*i8,source_length:i64,context:*i64)->i64{
  if state==0{return 0;}if core==0{return 0;}if source==0{return 0;}var state_base:i64=state as i64;var state_end:i64=state_base+96;var core_base:i64=core as i64;var core_end:i64=core_base+32768;var source_base:i64=source as i64;var source_end:i64=source_base;if state_end<=state_base{return 0;}if core_end<=core_base{return 0;}if source_length>0{source_end=source_base+source_length;if source_end<=source_base{return 0;}}if state_end>core_base{if core_end>state_base{return 0;}}if source_length>0{if state_end>source_base{if source_end>state_base{return 0;}}}if jj_frontend_phase_clear(state)==0{return 0;}if jj_compile_frontend_context_valid(context)==0{return 0;}var program_base:i64=jj_compile_frontend_program_base(context);var program_capacity:i64=jj_compile_frontend_program_capacity(context);var program:*i8=program_base as *i8;if program==0{return 0;}var program_end:i64=program_base+program_capacity;if program_end<=program_base{return 0;}if state_end>program_base{if program_end>state_base{return 0;}}
  if source_length<=0{return 0;}if source_length>0xffffffff{return 0;}if program_capacity<65536{return 0;}if source_end>program_base{if program_end>source_base{return 0;}}var target:i64=jj_c_contains_target(core);if target<1{core[193]=1004;return 0;}if jj_core_target_set(core,target)==0{core[193]=1004;return 0;}
  var token_stream:[12]i64;if jj_scanner_phase_execute(token_stream as *i64,core,source,source_length,context)==0{if core[193]==0{core[193]=1004;}if target==5{return 2;}return 0;}if jj_scanner_phase_valid(token_stream as *i64)==0{if core[193]==0{core[193]=1004;}return 0;}
  var syntax_store:[12]i64;var ast_state:[12]i64;if jj_parser_phase_execute(ast_state as *i64,token_stream as *i64,syntax_store as *i64)==0{var parser_code:i64=jj_parser_phase_failure_export(ast_state as *i64,core);if core[193]==0{if parser_code!=0{core[193]=parser_code;}else{core[193]=1005;}}if target==5{return 2;}return 0;}if jj_parser_phase_valid(ast_state as *i64)==0{if core[193]==0{core[193]=1005;}return 0;}
  var semantic_context:[3]i64;semantic_context[0]=program_base;semantic_context[1]=program_capacity;semantic_context[2]=target;var semantic_state:[12]i64;var result:i64=jj_semantic_phase_execute(semantic_state as *i64,ast_state as *i64,core,semantic_context as *i64);if result<=48{if core[193]==0{core[193]=1006;}return 0;}if jj_semantic_phase_valid(semantic_state as *i64)==0{if core[193]==0{core[193]=1006;}return 0;}
  var typed_nodes:i64=semantic_state[7];var source_maps:i64=semantic_state[8];var functions:i64=semantic_state[9];var spans:i64=semantic_state[10];if jj_cir_verifier_release(core)==0{return 0;}if jj_parallel_release(core)==0{return 0;}if jj_edge_release(core)==0{return 0;}if jj_join_release(core)==0{return 0;}if jj_def_release(core)==0{return 0;}if jj_cfg_release(core)==0{return 0;}if jj_operand_tree_release(core)==0{return 0;}if jj_typed_node_arena_release(core)==0{return 0;}
  state[0]=0x4a4a465250483033;state[1]=source_base;state[2]=source_length;state[3]=program_base;state[4]=program_capacity;state[5]=target;state[6]=result;state[7]=typed_nodes;state[8]=source_maps;state[9]=functions;state[10]=spans;state[11]=jj_frontend_phase_seal(state);if jj_frontend_phase_valid(state)==0{jj_frontend_phase_clear(state);return 0;}return result;
}
