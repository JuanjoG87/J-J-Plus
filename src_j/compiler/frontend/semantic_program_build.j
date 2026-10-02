// Semantic program integration hub; validates inputs and orchestrates publication only.
// Integration-hub partition R764: concrete work lives in focused phases.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_ast_publication_valid(p0:*i64)->i64;
extern fn jj_ast_publication_syntax_store(p0:*i64)->i64;
extern fn jj_syntax_node_store_valid(p0:*i64)->i64;
extern fn jj_ast_publication_source_base(p0:*i64)->i64;
extern fn jj_ast_publication_source_length(p0:*i64)->i64;
extern fn jj_ast_publication_node_count(p0:*i64)->i64;
extern fn jj_ast_publication_declaration_count(p0:*i64)->i64;
extern fn jj_typed_node_arena_begin(p0:*i64,p1:i64)->i64;
extern fn jj_syntax_cursor_bind(p0:*i64,p1:*i64)->i64;
extern fn jj_operand_tree_begin(p0:*i64)->i64;
extern fn jj_semantic_cir_begin(p0:*i64)->i64;
extern fn jj_typed_node_add(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_c_parse_program(core: *i64, root_node: i64) -> i64;
extern fn jj_typed_node_arena_finish(p0:*i64)->i64;
extern fn jj_semantic_cir_finish(p0:*i64)->i64;
extern fn jj_operand_tree_finish(p0:*i64)->i64;
extern fn jj_semantic_cir_structure_finish(p0:*i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_program_semantic_build(ast_state:*i64,core:*i64)->i64{
  if ast_state==0{return 0;}if core==0{return 0;}if jj_ast_publication_valid(ast_state)==0{return 0;}var syntax:*i64=jj_ast_publication_syntax_store(ast_state) as *i64;if syntax==0{return 0;}if jj_syntax_node_store_valid(syntax)==0{return 0;}
  var syntax_base:i64=syntax as i64;var syntax_end:i64=syntax_base+96;var core_base:i64=core as i64;var core_end:i64=core_base+32768;if syntax_end<=syntax_base{return 0;}if core_end<=core_base{return 0;}if syntax_end>core_base{if core_end>syntax_base{return 0;}}
  if jj_ast_publication_source_base(ast_state)!=core[0]{return 0;}if jj_ast_publication_source_length(ast_state)!=core[1]{return 0;}
  var structural_nodes:i64=jj_ast_publication_node_count(ast_state);var declarations:i64=jj_ast_publication_declaration_count(ast_state);if structural_nodes<=0{return 0;}if declarations<=0{return 0;}var typed_capacity:i64=core[28];if typed_capacity<=0{return 0;}if jj_typed_node_arena_begin(core,typed_capacity)==0{return 0;}if jj_syntax_cursor_bind(core,syntax)==0{return 0;}if jj_operand_tree_begin(core)==0{return 0;}if jj_semantic_cir_begin(core)==0{return 0;}
  var source_span:i64=core[1]<<32;var root_node:i64=jj_typed_node_add(core,12,declarations,0,source_span,0);if root_node!=1{return 0;}
  var before:i64=core[15];if before!=1{return 0;}if jj_c_parse_program(core,root_node)==0{return 0;}var after:i64=core[15];if after<before{return 0;}if core[10]<=0{return 0;}if core[3]!=0{return 0;}
  if jj_typed_node_arena_finish(core)==0{return 0;}if jj_semantic_cir_finish(core)==0{return 0;}if jj_operand_tree_finish(core)==0{return 0;}if jj_semantic_cir_structure_finish(core)==0{return 0;}return 1;
}
