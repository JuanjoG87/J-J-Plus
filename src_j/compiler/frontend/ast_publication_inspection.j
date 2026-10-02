// on-demand inspection companion; excluded from resident selfhost closures.
extern fn jj_ast_publication_valid(p0:*i64)->i64;

fn jj_ast_publication_leaf_count(state:*i64)->i64{if jj_ast_publication_valid(state)==0{return 0;}return state[9];}
