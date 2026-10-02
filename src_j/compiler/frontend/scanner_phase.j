// Scanner phase v2: source capability -> complete durable token stream.
// The scanner performs two bounded passes, publishes indexed records at the
// high end of the program capability and never stores interior pointers.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_c_hash_bytes(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_token_stream_clear(p0:*i64)->i64;
extern fn jj_token_stream_bind(p0:*i64,p1:*i8,p2:i64,p3:*i8,p4:i64,p5:i64)->i64;
extern fn jj_token_stream_store(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_token_stream_valid(p0:*i64)->i64;
extern fn jj_compile_frontend_context_valid(p0:*i64)->i64;
extern fn jj_compile_frontend_temporary_base(p0:*i64)->i64;
extern fn jj_compile_frontend_temporary_capacity(p0:*i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_c_space(c:i64)->i64{if c==32{return 1;}if c==9{return 1;}if c==10{return 1;}if c==13{return 1;}return 0;}
fn jj_c_alpha(c:i64)->i64{if c>=65{if c<=90{return 1;}}if c>=97{if c<=122{return 1;}}if c==95{return 1;}return 0;}
fn jj_c_digit(c:i64)->i64{if c>=48{if c<=57{return 1;}}return 0;}
fn jj_c_hex_value(c:i64)->i64{if c>=48{if c<=57{return c-48;}}if c>=65{if c<=70{return c-55;}}if c>=97{if c<=102{return c-87;}}return 16;}
fn jj_scanner_one(source:*i8,length:i64,position:i64,out:*i64)->i64{
  if source==0{return 0;}if length<=0{return 0;}if position<0{return 0;}if position>length{return 0;}if out==0{return 0;}var p:i64=position;
  while p<length{
    var c:i64=source[p];if c==0{return 0;}if c>=128{return 0;}if jj_c_space(c)!=0{p=p+1;}else{
      if c==47{if p+1<length{if source[p+1]==47{p=p+2;while p<length{if source[p]==10{break;}p=p+1;}}else{if source[p+1]==42{p=p+2;var closed:i64=0;while p+1<length{if source[p]==42{if source[p+1]==47{p=p+2;closed=1;break;}}p=p+1;}if closed==0{return 0;}}else{break;}}}else{break;}}else{break;}
    }
  }
  out[0]=p;out[1]=0;out[2]=p;out[3]=0;out[4]=0;if p>=length{return 1;}var first:i64=source[p];
  if jj_c_alpha(first)!=0{var q:i64=p+1;while q<length{var d:i64=source[q];if jj_c_alpha(d)==0{if jj_c_digit(d)==0{break;}}q=q+1;}out[0]=q;out[1]=1;out[2]=p;out[3]=q-p;out[4]=jj_c_hash_bytes(source,p,q-p);return 1;}
  if first==34{var qs_text:i64=p+1;while qs_text<length{var sc:i64=source[qs_text];if sc==34{out[0]=qs_text+1;out[1]=4;out[2]=p+1;out[3]=qs_text-p-1;out[4]=0;return 1;}if sc==0{return 0;}if sc==10{return 0;}if sc==13{return 0;}if sc==92{return 0;}if sc<32{return 0;}if sc>=128{return 0;}qs_text=qs_text+1;}return 0;}
  if jj_c_digit(first)!=0{var qn:i64=p;var base:i64=10;var value:i64=0;if first==48{if p+1<length{if source[p+1]==120{base=16;qn=p+2;if qn>=length{return 0;}}}}if base==10{qn=p;}var digits:i64=0;while qn<length{var digit:i64=16;if base==10{if jj_c_digit(source[qn])!=0{digit=source[qn]-48;}}else{digit=jj_c_hex_value(source[qn]);}if digit>=base{break;}if base==16{if digits>=16{return 0;}}else{if value>922337203685477580{return 0;}if value==922337203685477580{if digit>7{return 0;}}}value=value*base+digit;qn=qn+1;digits=digits+1;}if digits==0{return 0;}out[0]=qn;out[1]=2;out[2]=p;out[3]=qn-p;out[4]=value;return 1;}
  var symbol:i64=first;var qs:i64=p+1;if qs<length{var second:i64=source[qs];if first==45{if second==62{symbol=first|(second<<8);qs=qs+1;}}if first==61{if second==61{symbol=first|(second<<8);qs=qs+1;}}if first==33{if second==61{symbol=first|(second<<8);qs=qs+1;}}if first==60{if second==61{symbol=first|(second<<8);qs=qs+1;}else{if second==60{symbol=first|(second<<8);qs=qs+1;}}}if first==62{if second==61{symbol=first|(second<<8);qs=qs+1;}else{if second==62{symbol=first|(second<<8);qs=qs+1;if qs<length{if source[qs]==62{symbol=symbol|(source[qs]<<16);qs=qs+1;}}}}}}
  if first==35{return 0;}if first==39{return 0;}if first==96{return 0;}if first==92{return 0;}if first==36{return 0;}if first==64{return 0;}out[0]=qs;out[1]=3;out[2]=p;out[3]=qs-p;out[4]=symbol;return 1;
}
fn jj_scanner_reject(core:*i64,source:*i8,packed:i64)->i64{
  if core==0{return 0;}if source==0{return 0;}var position:i64=packed&0xffffffff;var length:i64=(packed>>>32)&0xffffffff;if position<0{position=0;}if position>length{position=length;}var seek:i64=position;while seek<length{var skipped:i64=source[seek];if jj_c_space(skipped)!=0{seek=seek+1;}else{if skipped==47{if seek+1<length{if source[seek+1]==47{seek=seek+2;while seek<length{if source[seek]==10{break;}seek=seek+1;}}else{break;}}else{break;}}else{break;}}}position=seek;var code:i64=1206;var token_length:i64=0;if position<length{var c:i64=source[position];token_length=1;if c==0{code=1205;}else{if c>=128{code=1203;}else{if c==34{code=1202;token_length=length-position;}else{if c==47{if position+1<length{if source[position+1]==42{code=1202;token_length=length-position;}}}if code==1206{if jj_c_digit(c)!=0{code=1204;}else{if c==35{code=1201;}else{if c==39{code=1201;}else{if c==96{code=1201;}else{if c==92{code=1201;}else{if c==36{code=1201;}else{if c==64{code=1201;}}}}}}}}}}}}core[4]=position;core[5]=token_length;core[193]=code;return 0;
}
fn jj_scanner_phase_valid(state:*i64)->i64{return jj_token_stream_valid(state);}
fn jj_scanner_phase_execute(state:*i64,core:*i64,source:*i8,source_length:i64,context:*i64)->i64{
  if state==0{return 0;}if jj_token_stream_clear(state)==0{return 0;}if core==0{return 0;}if source==0{return 0;}if source_length<=0{return 0;}if source_length>0xffffffff{return 0;}if jj_compile_frontend_context_valid(context)==0{return 0;}var temporary:*i8=jj_compile_frontend_temporary_base(context) as *i8;var temporary_capacity:i64=jj_compile_frontend_temporary_capacity(context);if temporary==0{return 0;}if temporary_capacity<65536{return 0;}if core[0]!=(source as i64){return 0;}if core[1]!=source_length{return 0;}var state_base:i64=state as i64;var state_end:i64=state_base+96;var source_base:i64=source as i64;var source_end:i64=source_base+source_length;var temporary_base:i64=temporary as i64;var temporary_end:i64=temporary_base+temporary_capacity;if state_end<=state_base{return 0;}if source_end<=source_base{return 0;}if temporary_end<=temporary_base{return 0;}if state_end>source_base{if source_end>state_base{return 0;}}if state_end>temporary_base{if temporary_end>state_base{return 0;}}if source_end>temporary_base{if temporary_end>source_base{return 0;}}
  var item:[5]i64;var p:i64=0;var count:i64=0;while 1{if jj_scanner_one(source,source_length,p,item as *i64)==0{return jj_scanner_reject(core,source,p|(source_length<<32));}if item[0]<p{return 0;}count=count+1;if count>source_length+1{return 0;}if item[1]==0{break;}if item[0]<=p{return 0;}p=item[0];}
  if jj_token_stream_bind(state,source,source_length,temporary,temporary_capacity,count)==0{return 0;}p=0;var index:i64=0;while index<count{if jj_scanner_one(source,source_length,p,item as *i64)==0{jj_token_stream_clear(state);return jj_scanner_reject(core,source,p|(source_length<<32));}if jj_token_stream_store(state,index,item[1],item[2],item[3],item[4])==0{jj_token_stream_clear(state);return 0;}p=item[0];index=index+1;}if jj_token_stream_valid(state)==0{jj_token_stream_clear(state);return 0;}return count;
}
