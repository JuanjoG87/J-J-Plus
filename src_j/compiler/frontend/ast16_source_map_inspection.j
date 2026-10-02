// on-demand inspection companion; excluded from resident selfhost closures.
extern fn jj_ast16_add_node(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;

fn jj_ast16_span_length(spans:*i64,span_id:i64)->i64{if spans==0{return 0;}if span_id<0{return 0;}return (spans[span_id]>>>32)&0xffffffff;}
fn jj_ast16_add_statement(core:*i64,kind:i64,type_id:i64,bytecode_start:i64,bytecode_length:i64,span_word:i64)->i64{return jj_ast16_add_node(core,kind,type_id,bytecode_start,bytecode_length,span_word);}
