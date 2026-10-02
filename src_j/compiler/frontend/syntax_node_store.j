// Syntax node store v2. Scanner records are adopted in place as immutable
// 8-byte syntax leaves; compact 16-byte AST events occupy the disjoint prefix.
// The publication keeps no token-stream pointer or scanner state.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_token_stream_valid(p0:*i64)->i64;
extern fn jj_token_stream_count(p0:*i64)->i64;
extern fn jj_c_hash_bytes(p0:*i8,p1:i64,p2:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_syntax_node_store_clear(state:*i64)->i64{if state==0{return 0;}var i:i64=0;while i<12{state[i]=0;i=i+1;}return 1;}
fn jj_syntax_node_store_seal(state:*i64)->i64{var seal:i64=(state as i64)^0x4a4a53594e4f4432;var i:i64=0;while i<11{seal=seal^state[i];i=i+1;}return seal;}
fn jj_syntax_node_store_valid(state:*i64)->i64{
  if state==0{return 0;}if state[0]!=0x4a4a53594e303032{return 0;}if state[1]==0{return 0;}if state[2]<65536{return 0;}if state[3]!=state[1]+48{return 0;}if state[4]<=0{return 0;}if state[5]==0{return 0;}if state[6]<=1{return 0;}if state[7]<0{return 0;}if state[7]>state[4]{return 0;}if state[8]==0{return 0;}if state[9]<=0{return 0;}if state[9]>0xffffffff{return 0;}if state[10]!=state[6]*8{return 0;}var owner_end:i64=state[1]+state[2];var node_limit:i64=state[3]+state[4]*16;var node_end:i64=state[3]+state[7]*16;var leaf_end:i64=state[5]+state[10];var source_end:i64=state[8]+state[9];if owner_end<=state[1]{return 0;}if node_limit<state[3]{return 0;}if node_end<state[3]{return 0;}if node_limit>state[5]{return 0;}if node_end>state[5]{return 0;}if leaf_end!=owner_end{return 0;}if source_end<=state[8]{return 0;}if source_end>state[1]{if owner_end>state[8]{return 0;}}var leaves:*i64=state[5] as *i64;if (leaves[state[6]-1]&255)!=0{return 0;}if state[11]!=jj_syntax_node_store_seal(state){return 0;}return 1;
}
fn jj_syntax_node_store_bind(state:*i64,stream:*i64)->i64{
  if state==0{return 0;}if jj_syntax_node_store_clear(state)==0{return 0;}if stream==0{return 0;}if jj_token_stream_valid(stream)==0{return 0;}var free_bytes:i64=stream[9]-48;if free_bytes<16{return 0;}var capacity:i64=free_bytes/16;var leaves:i64=jj_token_stream_count(stream);if leaves<=1{return 0;}state[0]=0x4a4a53594e303032;state[1]=stream[7];state[2]=stream[8];state[3]=stream[7]+48;state[4]=capacity;state[5]=stream[3];state[6]=leaves;state[7]=0;state[8]=stream[1];state[9]=stream[2];state[10]=stream[6];state[11]=jj_syntax_node_store_seal(state);if jj_syntax_node_store_valid(state)==0{jj_syntax_node_store_clear(state);return 0;}return 1;
}
fn jj_syntax_node_store_append(state:*i64,kind:i64,token_id:i64)->i64{
  if jj_syntax_node_store_valid(state)==0{return 0;}if kind<=0{return 0;}if kind>255{return 0;}if token_id<0{return 0;}if token_id>=state[6]-1{return 0;}if state[7]>=state[4]{return 0;}var records:*i64=state[3] as *i64;var at:i64=state[7]*2;records[at]=kind;records[at+1]=token_id;state[7]=state[7]+1;state[11]=jj_syntax_node_store_seal(state);if jj_syntax_node_store_valid(state)==0{return 0;}return state[7];
}
fn jj_syntax_node_store_count(state:*i64)->i64{if jj_syntax_node_store_valid(state)==0{return 0;}return state[7];}
fn jj_syntax_node_store_leaf_count(state:*i64)->i64{if jj_syntax_node_store_valid(state)==0{return 0;}return state[6];}
fn jj_syntax_leaf_digit(c:i64,base:i64)->i64{if c>=48{if c<=57{return c-48;}}if base==16{if c>=65{if c<=70{return c-55;}}if c>=97{if c<=102{return c-87;}}}return 16;}
fn jj_syntax_leaf_value(state:*i64,packed:i64)->i64{var kind:i64=packed&255;var start:i64=(packed>>>8)&0xffffffff;var count:i64=(packed>>>40)&0xffffff;if start>state[9]-count{return 0;}var source:*i8=state[8] as *i8;if kind==0{return 0;}if kind==1{return jj_c_hash_bytes(source,start,count);}if kind==2{var at:i64=start;var end:i64=start+count;var base:i64=10;if count>=3{if source[at]==48{if source[at+1]==120{base=16;at=at+2;}}}var value:i64=0;while at<end{var digit:i64=jj_syntax_leaf_digit(source[at],base);if digit>=base{return 0;}value=value*base+digit;at=at+1;}return value;}if kind==3{if count<=0{return 0;}if count>3{return 0;}var symbol:i64=0;var i:i64=0;while i<count{symbol=symbol|(source[start+i]<<(i*8));i=i+1;}return symbol;}if kind==4{return 0;}return 0;}
fn jj_syntax_node_store_leaf_word(state:*i64,index:i64,word:i64)->i64{if jj_syntax_node_store_valid(state)==0{return 0;}if index<0{return 0;}if index>=state[6]{return 0;}if word<0{return 0;}if word>1{return 0;}var leaves:*i64=state[5] as *i64;var packed:i64=leaves[index];if word==0{return packed;}return jj_syntax_leaf_value(state,packed);}
fn jj_syntax_node_store_source_base(state:*i64)->i64{if jj_syntax_node_store_valid(state)==0{return 0;}return state[8];}
fn jj_syntax_node_store_source_length(state:*i64)->i64{if jj_syntax_node_store_valid(state)==0{return 0;}return state[9];}
fn jj_syntax_cursor_seal(core:*i64)->i64{return (core as i64)^core[48]^core[49]^core[50]^0x4a4a535943555232;}
fn jj_syntax_cursor_valid(core:*i64)->i64{if core==0{return 0;}if core[48]==0{return 0;}var syntax:*i64=core[48] as *i64;if jj_syntax_node_store_valid(syntax)==0{return 0;}if core[49]<0{return 0;}if core[49]>=core[50]{return 0;}if core[50]!=jj_syntax_node_store_leaf_count(syntax){return 0;}if core[51]!=jj_syntax_cursor_seal(core){return 0;}return 1;}
fn jj_syntax_cursor_publish(core:*i64)->i64{if jj_syntax_cursor_valid(core)==0{return 0;}var syntax:*i64=core[48] as *i64;var word0:i64=jj_syntax_node_store_leaf_word(syntax,core[49],0);var word1:i64=jj_syntax_node_store_leaf_word(syntax,core[49],1);var kind:i64=word0&255;var start:i64=(word0>>>8)&0xffffffff;var count:i64=(word0>>>40)&0xffffff;core[3]=kind;core[4]=start;core[5]=count;core[6]=word1;core[2]=start+count;core[15]=core[49]+1;return 1;}
fn jj_syntax_cursor_bind(core:*i64,syntax:*i64)->i64{if core==0{return 0;}if jj_syntax_node_store_valid(syntax)==0{return 0;}core[48]=syntax as i64;core[49]=0;core[50]=jj_syntax_node_store_leaf_count(syntax);core[51]=jj_syntax_cursor_seal(core);return jj_syntax_cursor_publish(core);}
fn jj_ast_next(core:*i64)->i64{if jj_syntax_cursor_valid(core)==0{return 0;}if core[49]>=core[50]-1{return 0;}core[49]=core[49]+1;core[51]=jj_syntax_cursor_seal(core);return jj_syntax_cursor_publish(core);}
fn jj_ast_is_ident(core:*i64,hash:i64,count:i64)->i64{if jj_syntax_cursor_valid(core)==0{return 0;}if core[3]!=1{return 0;}if core[5]!=count{return 0;}if core[6]!=hash{return 0;}return 1;}
fn jj_ast_is_symbol(core:*i64,symbol:i64)->i64{if jj_syntax_cursor_valid(core)==0{return 0;}if core[3]!=3{return 0;}if core[6]!=symbol{return 0;}return 1;}
fn jj_ast_need_symbol(core:*i64,symbol:i64)->i64{if jj_ast_is_symbol(core,symbol)==0{return 0;}return jj_ast_next(core);}
