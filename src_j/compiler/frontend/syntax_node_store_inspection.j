// on-demand inspection companion; excluded from resident selfhost closures.
extern fn jj_syntax_node_store_valid(p0:*i64)->i64;

fn jj_syntax_node_store_word(state:*i64,index:i64,word:i64)->i64{if jj_syntax_node_store_valid(state)==0{return 0;}if index<0{return 0;}if index>=state[7]{return 0;}if word<0{return 0;}if word>1{return 0;}var records:*i64=state[3] as *i64;return records[index*2+word];}
