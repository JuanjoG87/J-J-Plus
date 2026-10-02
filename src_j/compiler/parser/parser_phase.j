// Parser phase v6: lossless syntax authority plus compact expressive AST events.
// Failure receipts publish an exact token span without heap, arrays or source rescans.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_token_stream_valid(p0:*i64)->i64;
extern fn jj_token_stream_count(p0:*i64)->i64;
extern fn jj_token_stream_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_syntax_node_store_bind(p0:*i64,p1:*i64)->i64;
extern fn jj_syntax_node_store_append(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_syntax_node_store_count(p0:*i64)->i64;
extern fn jj_syntax_node_store_valid(p0:*i64)->i64;
extern fn jj_ast_publication_clear(p0:*i64)->i64;
extern fn jj_ast_publication_bind(p0:*i64,p1:*i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_ast_publication_valid(p0:*i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_parser_phase_clear(state:*i64)->i64{return jj_ast_publication_clear(state);}
fn jj_parser_phase_valid(state:*i64)->i64{return jj_ast_publication_valid(state);}
fn jj_parser_failure_seal(state:*i64)->i64{return (state as i64)^state[0]^state[1]^state[2]^state[3]^state[4]^0x4a4a505246534531;}
fn jj_parser_phase_reject(state:*i64,token_stream:*i64,packed_reason:i64)->i64{
  if state==0{return 0;}if jj_parser_phase_clear(state)==0{return 0;}var code:i64=(packed_reason>>>32)&0xffffffff;var index:i64=packed_reason&0xffffffff;var start:i64=0;var length:i64=0;
  if jj_token_stream_valid(token_stream)!=0{var count:i64=jj_token_stream_count(token_stream);if count>0{if index>=count{index=count-1;}var token:i64=jj_token_stream_word(token_stream,index,0);start=(token>>>8)&0xffffffff;length=(token>>>40)&0xffffff;}}
  state[0]=0x4a4a505246414931;state[1]=code;state[2]=index;state[3]=start;state[4]=length;state[11]=jj_parser_failure_seal(state);return 0;
}
fn jj_parser_phase_failure_export(state:*i64,core:*i64)->i64{
  if state==0{return 0;}if core==0{return 0;}if state[0]!=0x4a4a505246414931{return 0;}if state[11]!=jj_parser_failure_seal(state){return 0;}if state[1]<1101{return 0;}if state[1]>1107{return 0;}core[4]=state[3];core[5]=state[4];return state[1];
}
fn jj_parser_phase_execute(state:*i64,token_stream:*i64,syntax_store:*i64)->i64{
  if state==0{return 0;}if syntax_store==0{return 0;}if jj_parser_phase_clear(state)==0{return 0;}if token_stream==0{return 0;}if jj_token_stream_valid(token_stream)==0{return 0;}if jj_syntax_node_store_bind(syntax_store,token_stream)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32));}
  var count:i64=jj_token_stream_count(token_stream);if count<=1{return jj_parser_phase_reject(state,token_stream,(1101<<32));}var paren:i64=0;var brace:i64=0;var bracket:i64=0;var max_depth:i64=0;var declarations:i64=0;var terminators:i64=0;var brace_pairs:i64=0;var previous_kind:i64=0;var previous_value:i64=0;var index:i64=0;
  while index<count{
    var packed:i64=jj_token_stream_word(token_stream,index,0);var value:i64=jj_token_stream_word(token_stream,index,1);var kind:i64=packed&255;if index==count-1{if kind!=0{return jj_parser_phase_reject(state,token_stream,(1101<<32)|index);}}else{if kind==0{return jj_parser_phase_reject(state,token_stream,(1101<<32)|index);}}
    if kind==1{if paren==0{if brace==0{if bracket==0{if value==0x9bb67100c6643a03{declarations=declarations+1;if jj_syntax_node_store_append(syntax_store,1,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}else{if value==0x06230eb8054ccaa5{declarations=declarations+1;if jj_syntax_node_store_append(syntax_store,2,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}else{if value==0x14da8f5ec8315a0a{declarations=declarations+1;if jj_syntax_node_store_append(syntax_store,3,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}}}}}}}
    if kind==1{if value==0x844d13516982c088{if jj_syntax_node_store_append(syntax_store,9,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}else{if value==0x7488c53f48adf9a1{if jj_syntax_node_store_append(syntax_store,10,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}else{if value==0x9bc77700c672b768{if jj_syntax_node_store_append(syntax_store,11,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}else{if value==0x6160ced97abcf88a{if jj_syntax_node_store_append(syntax_store,12,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}else{if value==0x0e187c656c484194{if jj_syntax_node_store_append(syntax_store,13,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}else{if value==0x387b55bfd9138ed6{if jj_syntax_node_store_append(syntax_store,14,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}}}}}}
      if index+1<count{var next_packed:i64=jj_token_stream_word(token_stream,index+1,0);var next_value:i64=jj_token_stream_word(token_stream,index+1,1);if (next_packed&255)==3{if next_value==40{if previous_kind!=1{if previous_value!=0x9bb67100c6643a03{if previous_value!=0x06230eb8054ccaa5{if jj_syntax_node_store_append(syntax_store,16,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}}}}}}
    }
    if kind==3{if value==58{if paren>0{if jj_syntax_node_store_append(syntax_store,7,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}}else{if value==15917{if jj_syntax_node_store_append(syntax_store,8,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}else{if value==91{if jj_syntax_node_store_append(syntax_store,15,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}}}
      if value==40{paren=paren+1;}else{if value==41{if paren<=0{return jj_parser_phase_reject(state,token_stream,(1102<<32)|index);}paren=paren-1;}else{if value==123{brace=brace+1;if jj_syntax_node_store_append(syntax_store,4,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}else{if value==125{if brace<=0{return jj_parser_phase_reject(state,token_stream,(1102<<32)|index);}brace=brace-1;brace_pairs=brace_pairs+1;if jj_syntax_node_store_append(syntax_store,5,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}else{if value==91{bracket=bracket+1;}else{if value==93{if bracket<=0{return jj_parser_phase_reject(state,token_stream,(1102<<32)|index);}bracket=bracket-1;}else{if value==59{terminators=terminators+1;if jj_syntax_node_store_append(syntax_store,6,index)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|index);}}}}}}}}}
    var depth:i64=paren+brace+bracket;if depth>max_depth{max_depth=depth;}if depth>512{return jj_parser_phase_reject(state,token_stream,(1104<<32)|index);}previous_kind=kind;previous_value=value;index=index+1;
  }
  if paren!=0{return jj_parser_phase_reject(state,token_stream,(1103<<32)|(count-1));}if brace!=0{return jj_parser_phase_reject(state,token_stream,(1103<<32)|(count-1));}if bracket!=0{return jj_parser_phase_reject(state,token_stream,(1103<<32)|(count-1));}if declarations<=0{return jj_parser_phase_reject(state,token_stream,(1105<<32)|(count-1));}if max_depth<=0{return jj_parser_phase_reject(state,token_stream,(1107<<32)|(count-1));}if jj_syntax_node_store_valid(syntax_store)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|(count-1));}if jj_syntax_node_store_count(syntax_store)<=0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|(count-1));}if jj_ast_publication_bind(state,syntax_store,declarations,max_depth,terminators,brace_pairs)==0{return jj_parser_phase_reject(state,token_stream,(1106<<32)|(count-1));}return 1;
}
