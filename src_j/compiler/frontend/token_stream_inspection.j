// on-demand inspection companion; excluded from resident selfhost closures.
extern fn jj_token_stream_valid(p0:*i64)->i64;
extern fn jj_token_cursor_seal(p0:*i64)->i64;
extern fn jj_token_cursor_publish(p0:*i64)->i64;
extern fn jj_token_cursor_valid(p0:*i64)->i64;
extern fn jj_c_is_symbol(p0:*i64,p1:i64)->i64;
extern fn jj_c_next(p0:*i64)->i64;

fn jj_token_cursor_bind(core:*i64,stream:*i64)->i64{if core==0{return 0;}if jj_token_stream_valid(stream)==0{return 0;}core[48]=stream as i64;core[49]=0;core[50]=stream[5];core[51]=jj_token_cursor_seal(core);return jj_token_cursor_publish(core);}
fn jj_c_is_ident(core:*i64,hash:i64,count:i64)->i64{if jj_token_cursor_valid(core)==0{return 0;}if core[3]!=1{return 0;}if core[5]!=count{return 0;}if core[6]!=hash{return 0;}return 1;}
fn jj_c_need_symbol(core:*i64,symbol:i64)->i64{if jj_c_is_symbol(core,symbol)==0{return 0;}return jj_c_next(core);}
