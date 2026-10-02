// Syntactic AST publication v4. The parser publishes a self-contained,
// address-bound syntax authority: lossless leaves plus compact AST events.
// No scanner token-stream pointer crosses this boundary.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_syntax_node_store_valid(p0:*i64)->i64;
extern fn jj_syntax_node_store_count(p0:*i64)->i64;
extern fn jj_syntax_node_store_leaf_count(p0:*i64)->i64;
extern fn jj_syntax_node_store_leaf_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_syntax_node_store_source_base(p0:*i64)->i64;
extern fn jj_syntax_node_store_source_length(p0:*i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_ast_publication_clear(state:*i64)->i64{if state==0{return 0;}var i:i64=0;while i<12{state[i]=0;i=i+1;}return 1;}
fn jj_ast_publication_seal(state:*i64)->i64{var seal:i64=(state as i64)^0x4a4a415354505534;var i:i64=0;while i<11{seal=seal^state[i];i=i+1;}return seal;}
fn jj_ast_publication_valid(state:*i64)->i64{if state==0{return 0;}if state[0]!=0x4a4a415354303034{return 0;}if state[1]==0{return 0;}var syntax:*i64=state[1] as *i64;if jj_syntax_node_store_valid(syntax)==0{return 0;}if state[2]!=jj_syntax_node_store_source_base(syntax){return 0;}if state[3]!=jj_syntax_node_store_source_length(syntax){return 0;}if state[2]==0{return 0;}if state[3]<=0{return 0;}if state[4]<=0{return 0;}if state[5]<=0{return 0;}if state[5]>512{return 0;}if state[6]<0{return 0;}if state[7]<0{return 0;}if state[8]!=jj_syntax_node_store_count(syntax){return 0;}if state[8]<=0{return 0;}if state[9]!=jj_syntax_node_store_leaf_count(syntax){return 0;}if state[9]<=1{return 0;}if state[10]!=4{return 0;}var last:i64=jj_syntax_node_store_leaf_word(syntax,state[9]-1,0);if (last&255)!=0{return 0;}if state[11]!=jj_ast_publication_seal(state){return 0;}return 1;}
fn jj_ast_publication_bind(state:*i64,syntax:*i64,declarations:i64,max_depth:i64,terminators:i64,brace_pairs:i64)->i64{if state==0{return 0;}if jj_ast_publication_clear(state)==0{return 0;}if syntax==0{return 0;}if jj_syntax_node_store_valid(syntax)==0{return 0;}if declarations<=0{return 0;}if max_depth<=0{return 0;}if max_depth>512{return 0;}if terminators<0{return 0;}if brace_pairs<0{return 0;}var nodes:i64=jj_syntax_node_store_count(syntax);var leaves:i64=jj_syntax_node_store_leaf_count(syntax);if nodes<=0{return 0;}if leaves<=1{return 0;}state[0]=0x4a4a415354303034;state[1]=syntax as i64;state[2]=jj_syntax_node_store_source_base(syntax);state[3]=jj_syntax_node_store_source_length(syntax);state[4]=declarations;state[5]=max_depth;state[6]=terminators;state[7]=brace_pairs;state[8]=nodes;state[9]=leaves;state[10]=4;state[11]=jj_ast_publication_seal(state);if jj_ast_publication_valid(state)==0{jj_ast_publication_clear(state);return 0;}return 1;}
fn jj_ast_publication_syntax_store(state:*i64)->i64{if jj_ast_publication_valid(state)==0{return 0;}return state[1];}
fn jj_ast_publication_source_base(state:*i64)->i64{if jj_ast_publication_valid(state)==0{return 0;}return state[2];}
fn jj_ast_publication_source_length(state:*i64)->i64{if jj_ast_publication_valid(state)==0{return 0;}return state[3];}
fn jj_ast_publication_declaration_count(state:*i64)->i64{if jj_ast_publication_valid(state)==0{return 0;}return state[4];}
fn jj_ast_publication_node_count(state:*i64)->i64{if jj_ast_publication_valid(state)==0{return 0;}return state[8];}
