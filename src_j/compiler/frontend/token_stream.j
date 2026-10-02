// Token stream v2. Each durable record is one word in temporary caller-owned
// scratch: kind[7:0] | source_start[39:8] | source_length[63:40].
// Hashes, integer values and symbols are derived through the source capability
// when the cursor publishes a token; parser code never reads source directly.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_c_hash_bytes(p0:*i8,p1:i64,p2:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_token_stream_clear(state:*i64)->i64{if state==0{return 0;}var i:i64=0;while i<12{state[i]=0;i=i+1;}return 1;}
fn jj_token_stream_seal(state:*i64)->i64{var seal:i64=(state as i64)^0x4a4a544b4e534532;var i:i64=0;while i<11{seal=seal^state[i];i=i+1;}return seal;}
fn jj_token_stream_valid(state:*i64)->i64{
  if state==0{return 0;}if state[0]!=0x4a4a544b4e303032{return 0;}if state[1]==0{return 0;}if state[2]<=0{return 0;}if state[2]>0xffffffff{return 0;}if state[3]==0{return 0;}if state[4]<=0{return 0;}if state[5]<=0{return 0;}if state[6]!=state[5]*8{return 0;}if state[7]==0{return 0;}if state[8]<65536{return 0;}if state[9]<48{return 0;}if state[10]!=2{return 0;}
  var source_end:i64=state[1]+state[2];var owner_end:i64=state[7]+state[8];var token_end:i64=state[3]+state[6];if source_end<=state[1]{return 0;}if owner_end<=state[7]{return 0;}if token_end<=state[3]{return 0;}if state[3]!=state[7]+state[9]{return 0;}if token_end!=owner_end{return 0;}if state[9]>state[8]-state[6]{return 0;}if source_end>state[7]{if owner_end>state[1]{return 0;}}if state[11]!=jj_token_stream_seal(state){return 0;}return 1;
}
fn jj_token_stream_bind(state:*i64,source:*i8,source_length:i64,owner:*i8,owner_capacity:i64,token_count:i64)->i64{
  if state==0{return 0;}if jj_token_stream_clear(state)==0{return 0;}if source==0{return 0;}if source_length<=0{return 0;}if source_length>0xffffffff{return 0;}if owner==0{return 0;}if owner_capacity<65536{return 0;}if token_count<=0{return 0;}if token_count>0x0fffffff{return 0;}var token_bytes:i64=token_count*8;if token_bytes<=0{return 0;}if token_bytes>owner_capacity-48{return 0;}var offset:i64=owner_capacity-token_bytes;if offset<48{return 0;}var source_base:i64=source as i64;var source_end:i64=source_base+source_length;var owner_base:i64=owner as i64;var owner_end:i64=owner_base+owner_capacity;if source_end<=source_base{return 0;}if owner_end<=owner_base{return 0;}if source_end>owner_base{if owner_end>source_base{return 0;}}
  state[0]=0x4a4a544b4e303032;state[1]=source_base;state[2]=source_length;state[3]=owner_base+offset;state[4]=token_count;state[5]=token_count;state[6]=token_bytes;state[7]=owner_base;state[8]=owner_capacity;state[9]=offset;state[10]=2;state[11]=jj_token_stream_seal(state);if jj_token_stream_valid(state)==0{jj_token_stream_clear(state);return 0;}return 1;
}
fn jj_token_digit(c:i64,base:i64)->i64{if c>=48{if c<=57{return c-48;}}if base==16{if c>=65{if c<=70{return c-55;}}if c>=97{if c<=102{return c-87;}}}return 16;}
fn jj_token_stream_value(state:*i64,kind:i64,start:i64,count:i64)->i64{
  if jj_token_stream_valid(state)==0{return 0;}if start<0{return 0;}if count<0{return 0;}if start>state[2]-count{return 0;}var source:*i8=state[1] as *i8;if kind==0{return 0;}if kind==1{return jj_c_hash_bytes(source,start,count);}if kind==2{var p:i64=start;var end:i64=start+count;var base:i64=10;if count>=3{if source[p]==48{if source[p+1]==120{base=16;p=p+2;}}}var value:i64=0;while p<end{var digit:i64=jj_token_digit(source[p],base);if digit>=base{return 0;}value=value*base+digit;p=p+1;}return value;}if kind==3{if count<=0{return 0;}if count>3{return 0;}var symbol:i64=0;var i:i64=0;while i<count{symbol=symbol|(source[start+i]<<(i*8));i=i+1;}return symbol;}if kind==4{return 0;}return 0;
}
fn jj_token_stream_store(state:*i64,index:i64,kind:i64,start:i64,count:i64,value:i64)->i64{
  if jj_token_stream_valid(state)==0{return 0;}if index<0{return 0;}if index>=state[5]{return 0;}if kind<0{return 0;}if kind>4{return 0;}if start<0{return 0;}if start>0xffffffff{return 0;}if count<0{return 0;}if count>0xffffff{return 0;}if start>state[2]-count{return 0;}if jj_token_stream_value(state,kind,start,count)!=value{return 0;}var records:*i64=state[3] as *i64;records[index]=kind|(start<<8)|(count<<40);return 1;
}
fn jj_token_stream_word(state:*i64,index:i64,word:i64)->i64{if jj_token_stream_valid(state)==0{return 0;}if index<0{return 0;}if index>=state[5]{return 0;}if word<0{return 0;}if word>1{return 0;}var records:*i64=state[3] as *i64;var packed:i64=records[index];if word==0{return packed;}var kind:i64=packed&255;var start:i64=(packed>>>8)&0xffffffff;var count:i64=(packed>>>40)&0xffffff;return jj_token_stream_value(state,kind,start,count);}
fn jj_token_stream_count(state:*i64)->i64{if jj_token_stream_valid(state)==0{return 0;}return state[5];}
fn jj_token_cursor_seal(core:*i64)->i64{return (core as i64)^core[48]^core[49]^core[50]^0x4a4a544b43555232;}
fn jj_token_cursor_valid(core:*i64)->i64{if core==0{return 0;}if core[48]==0{return 0;}var stream:*i64=core[48] as *i64;if jj_token_stream_valid(stream)==0{return 0;}if core[49]<0{return 0;}if core[49]>=core[50]{return 0;}if core[50]!=stream[5]{return 0;}if core[51]!=jj_token_cursor_seal(core){return 0;}return 1;}
fn jj_token_cursor_publish(core:*i64)->i64{
  if jj_token_cursor_valid(core)==0{return 0;}var stream:*i64=core[48] as *i64;var word0:i64=jj_token_stream_word(stream,core[49],0);var word1:i64=jj_token_stream_word(stream,core[49],1);var kind:i64=word0&255;var start:i64=(word0>>>8)&0xffffffff;var count:i64=(word0>>>40)&0xffffff;core[3]=kind;core[4]=start;core[5]=count;core[6]=word1;core[2]=start+count;core[15]=core[49]+1;return 1;
}
fn jj_c_next(core:*i64)->i64{if jj_token_cursor_valid(core)==0{return 0;}if core[49]>=core[50]-1{return 0;}core[49]=core[49]+1;core[51]=jj_token_cursor_seal(core);return jj_token_cursor_publish(core);}
fn jj_c_is_symbol(core:*i64,symbol:i64)->i64{if jj_token_cursor_valid(core)==0{return 0;}if core[3]!=3{return 0;}if core[6]!=symbol{return 0;}return 1;}
