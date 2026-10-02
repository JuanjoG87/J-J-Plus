// Typed operand/effect tree v3. Node IDs are stable one-based lexical anchor IDs.
// Each operand reuses its consumed 8-byte syntax leaf for kind and full span.
// A compact 32-bit relation record lives temporarily at the high end of the
// caller-owned program capability and is released before backend lowering.
// Record: parent[19:0], role[22:20], owner[23], type[31:24].
// Span leaf: kind[7:0], source start[39:8], source length[63:40].
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_typed_node_arena_valid(p0:*i64)->i64;
extern fn jj_ast16_node_count(p0:*i64)->i64;
extern fn jj_ast16_node_kind(p0:*i64,p1:i64)->i64;
extern fn jj_ast16_node_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_ast16_span_word(p0:*i64,p1:i64)->i64;
extern fn jj_syntax_node_store_valid(p0:*i64)->i64;
extern fn jj_syntax_node_store_leaf_count(p0:*i64)->i64;
extern fn jj_lang_statement_local()->i64;
extern fn jj_lang_statement_if()->i64;
extern fn jj_lang_statement_loop()->i64;
extern fn jj_lang_statement_return()->i64;
extern fn jj_lang_statement_break()->i64;
extern fn jj_lang_statement_assignment()->i64;
extern fn jj_lang_statement_expression()->i64;
extern fn jj_lang_statement_block()->i64;
extern fn jj_lang_statement_program_root()->i64;
extern fn jj_lang_statement_require()->i64;
extern fn jj_lang_operand_store_scalar()->i64;
extern fn jj_lang_operand_store_aggregate()->i64;
extern fn jj_lang_operand_return()->i64;
extern fn jj_lang_operand_branch()->i64;
extern fn jj_lang_operand_condition()->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_operand_kind(kind:i64)->i64{if kind<32{return 0;}if kind>jj_lang_operand_condition(){return 0;}return 1;}
fn jj_operand_expression_kind(kind:i64)->i64{if kind<32{return 0;}if kind>40{return 0;}return 1;}
fn jj_operand_store_kind(kind:i64)->i64{if kind<41{return 0;}if kind>jj_lang_operand_store_aggregate(){return 0;}return 1;}
fn jj_operand_read32(base:*i8,index:i64)->i64{if base==0{return 0;}if index<0{return 0;}var at:i64=index*4;return (base[at]&255)|((base[at+1]&255)<<8)|((base[at+2]&255)<<16)|((base[at+3]&255)<<24);}
fn jj_operand_write32(base:*i8,index:i64,value:i64)->i64{if base==0{return 0;}if index<0{return 0;}var at:i64=index*4;base[at]=value&255;base[at+1]=(value>>>8)&255;base[at+2]=(value>>>16)&255;base[at+3]=(value>>>24)&255;return 1;}
fn jj_operand_tree_clear(core:*i64)->i64{if core==0{return 0;}var i:i64=73;while i<84{core[i]=0;i=i+1;}return 1;}
fn jj_operand_tree_state(core:*i64)->i64{if core==0{return 0;}if core[75]!=0x4a4a4f5044524633{if core[75]!=0x4a4a4f5046494e33{return 0;}}if core[73]==0{return 0;}if core[74]<=1{return 0;}if core[76]<0{return 0;}if core[77]<0{return 0;}if core[79]!=3{return 0;}if core[80]<0{return 0;}if core[81]<0{return 0;}if core[82]<65536{return 0;}if core[83]<=0{return 0;}var effective:i64=core[8];if core[92]==0x4a4a434647445231{effective=core[99];}else{if core[92]==0x4a4a434647464e31{effective=core[99];}else{if core[92]==0x4a4a434647445232{effective=core[99];}else{if core[92]==0x4a4a434647464e32{effective=core[99];}}}}if effective<core[8]{return 0;}if effective+core[83]!=core[82]{return 0;}if core[73]!=core[7]+effective{return 0;}return 1;}
fn jj_operand_tree_draft(core:*i64)->i64{if jj_operand_tree_state(core)==0{return 0;}if core[75]!=0x4a4a4f5044524633{return 0;}return 1;}
fn jj_operand_tree_begin(core:*i64)->i64{
  if core==0{return 0;}if core[48]==0{return 0;}var syntax:*i64=core[48] as *i64;if jj_syntax_node_store_valid(syntax)==0{return 0;}var capacity:i64=jj_syntax_node_store_leaf_count(syntax);if capacity<=1{return 0;}if capacity>0xfffff{return 0;}var bytes:i64=capacity*4;bytes=(bytes+7)&0xfffffffffffffff8;if bytes<=0{return 0;}var original:i64=core[8];if original<65536{return 0;}if bytes>original-65536{core[193]=1013;return 0;}var effective:i64=original-bytes;if core[9]>effective{core[193]=1013;return 0;}if jj_operand_tree_clear(core)==0{return 0;}var base:*i8=(core[7]+effective) as *i8;var i:i64=0;while i<bytes{base[i]=0;i=i+1;}core[8]=effective;core[73]=base as i64;core[74]=capacity;core[75]=0x4a4a4f5044524633;core[76]=0;core[77]=0;core[78]=0;core[79]=3;core[80]=0;core[81]=0;core[82]=original;core[83]=bytes;return jj_operand_tree_draft(core);
}
fn jj_operand_tree_statement(core:*i64,statement_ref:i64)->i64{if jj_operand_tree_draft(core)==0{return 0;}if statement_ref<=0{return 0;}if statement_ref>0xfffff{return 0;}core[80]=statement_ref;core[81]=0;return 1;}
fn jj_operand_tree_last_set(core:*i64,node_ref:i64)->i64{if jj_operand_tree_draft(core)==0{return 0;}if node_ref<0{return 0;}if node_ref>core[74]{return 0;}core[81]=node_ref;return 1;}
fn jj_operand_tree_last(core:*i64)->i64{if jj_operand_tree_draft(core)==0{return 0;}return core[81];}
fn jj_operand_record(core:*i64,node_ref:i64)->i64{if jj_operand_tree_state(core)==0{return 0;}if node_ref<=0{return 0;}if node_ref>core[74]{return 0;}return jj_operand_read32(core[73] as *i8,node_ref-1);}
fn jj_operand_span_word(core:*i64,node_ref:i64)->i64{if jj_operand_tree_state(core)==0{return 0;}if node_ref<=0{return 0;}if node_ref>core[74]{return 0;}var syntax:*i64=core[48] as *i64;if jj_syntax_node_store_valid(syntax)==0{return 0;}var leaves:*i64=syntax[5] as *i64;return leaves[node_ref-1];}
fn jj_operand_node_add(core:*i64,kind_type:i64,anchor_id:i64,span_word:i64)->i64{
  if jj_operand_tree_draft(core)==0{return 0;}var kind:i64=kind_type&255;var type_id:i64=(kind_type>>>16)&0xffff;if jj_operand_kind(kind)==0{return 0;}if type_id<=0{return 0;}if type_id>255{return 0;}if anchor_id<0{return 0;}if anchor_id>=core[74]-1{core[193]=1013;return 0;}var records:*i8=core[73] as *i8;if jj_operand_read32(records,anchor_id)!=0{return 0;}var start:i64=span_word&0xffffffff;var count:i64=(span_word>>>32)&0xffffffff;if count==0{if kind!=33{return 0;}}if count>0xffffff{return 0;}if start<0{return 0;}if start>core[1]-count{return 0;}var syntax:*i64=core[48] as *i64;if jj_syntax_node_store_valid(syntax)==0{return 0;}var leaves:*i64=syntax[5] as *i64;var node_ref:i64=anchor_id+1;if jj_operand_write32(records,anchor_id,type_id<<24)==0{return 0;}leaves[anchor_id]=kind|(start<<8)|(count<<40);core[76]=core[76]+1;core[81]=node_ref;return node_ref;
}
fn jj_operand_relation_set(core:*i64,node_ref:i64,parent:i64,role:i64,owner:i64)->i64{
  if jj_operand_tree_draft(core)==0{return 0;}if node_ref<=0{return 0;}if node_ref>core[74]{return 0;}if parent<=0{return 0;}if parent>0xfffff{return 0;}if role<0{return 0;}if role>7{return 0;}if owner<0{return 0;}if owner>1{return 0;}var records:*i8=core[73] as *i8;var record:i64=jj_operand_read32(records,node_ref-1);if (record>>>24)==0{return 0;}if (record&0xffffff)!=0{return 0;}return jj_operand_write32(records,node_ref-1,(record&0xff000000)|(parent&0xfffff)|(role<<20)|(owner<<23));
}
fn jj_operand_node_attach(core:*i64,child_ref:i64,parent_ref:i64,role:i64)->i64{if child_ref<=0{return 0;}if parent_ref<=0{return 0;}if child_ref==parent_ref{return 0;}if role<=0{return 0;}if role>7{return 0;}if (jj_operand_record(core,parent_ref)>>>24)==0{return 0;}return jj_operand_relation_set(core,child_ref,parent_ref,role,0);}
fn jj_operand_node_bind_root(core:*i64,child_ref:i64,statement_ref:i64)->i64{
  if statement_ref<=0{return 0;}
  if statement_ref>0xfffff{return 0;}
  var statement_kind:i64=jj_ast16_node_kind(core,statement_ref);
  if statement_kind<jj_lang_statement_local(){return 0;}
  if statement_kind>jj_lang_statement_require(){return 0;}
  if statement_kind==jj_lang_statement_block(){return 0;}
  if statement_kind==jj_lang_statement_program_root(){return 0;}
  if jj_operand_relation_set(core,child_ref,statement_ref,0,1)==0{return 0;}
  core[77]=core[77]+1;
  return 1;
}
fn jj_operand_span_start_raw(core:*i64,node_ref:i64)->i64{return (jj_operand_span_word(core,node_ref)>>>8)&0xffffffff;}
fn jj_operand_span_count_raw(core:*i64,node_ref:i64)->i64{return (jj_operand_span_word(core,node_ref)>>>40)&0xffffff;}
fn jj_operand_deferred_byte_cast(core:*i64,node_ref:i64)->i64{var record:i64=jj_operand_record(core,node_ref);if ((record>>>24)&255)!=253{return 0;}if (jj_operand_span_word(core,node_ref)&255)!=39{return 0;}if ((record>>>23)&1)!=0{return 0;}if ((record>>>20)&7)!=2{return 0;}var store:i64=record&0xfffff;if store<=0{return 0;}var store_kind:i64=jj_operand_span_word(core,store)&255;if store_kind==43{if ((jj_operand_record(core,store)>>>24)&255)==252{return 1;}return 0;}if store_kind!=41{return 0;}var indexed:i64=0;var i:i64=1;while i<=core[74]{var r:i64=jj_operand_record(core,i);if (r&0xfffff)==store{if ((r>>>23)&1)==0{if ((r>>>20)&7)==1{if (jj_operand_span_word(core,i)&255)!=38{return 0;}indexed=i;i=core[74];}}}i=i+1;}if indexed==0{return 0;}var address:i64=0;i=1;while i<=core[74]{var r2:i64=jj_operand_record(core,i);if (r2&0xfffff)==indexed{if ((r2>>>23)&1)==0{if ((r2>>>20)&7)==1{if (jj_operand_span_word(core,i)&255)!=34{return 0;}address=(r2>>>24)&255;i=core[74];}}}i=i+1;}if address==2{return 1;}return 0;}
fn jj_operand_tree_scan(core:*i64)->i64{
  if jj_operand_tree_state(core)==0{return 0;}if jj_typed_node_arena_valid(core)==0{return 0;}if core[48]==0{return 0;}var syntax:*i64=core[48] as *i64;if jj_syntax_node_store_valid(syntax)==0{return 0;}if core[74]!=jj_syntax_node_store_leaf_count(syntax){return 0;}var records:*i8=core[73] as *i8;var leaves:*i64=syntax[5] as *i64;var operands:i64=0;var roots:i64=0;var i:i64=0;
  while i<core[74]-1{var record:i64=jj_operand_read32(records,i);if record!=0{var kind:i64=leaves[i]&255;if jj_operand_kind(kind)==0{return 0;}var type_id:i64=(record>>>24)&255;if type_id<=0{return 0;}if type_id==253{if jj_operand_deferred_byte_cast(core,i+1)==0{return 0;}}var start:i64=(leaves[i]>>>8)&0xffffffff;var count:i64=(leaves[i]>>>40)&0xffffff;if count==0{if kind!=33{return 0;}}if start>core[1]-count{return 0;}var parent:i64=record&0xfffff;var role:i64=(record>>>20)&7;var owner:i64=(record>>>23)&1;if parent<=0{return 0;}operands=operands+1;if owner!=0{if role!=0{return 0;}if parent>jj_ast16_node_count(core){return 0;}var owner_kind:i64=jj_ast16_node_kind(core,parent);if owner_kind<jj_lang_statement_local(){return 0;}if owner_kind>jj_lang_statement_require(){return 0;}if owner_kind==jj_lang_statement_block(){return 0;}if owner_kind==jj_lang_statement_program_root(){return 0;}if owner_kind==jj_lang_statement_local(){if kind!=jj_lang_operand_store_scalar(){return 0;}}if owner_kind==jj_lang_statement_if(){if kind!=jj_lang_operand_condition(){return 0;}}if owner_kind==jj_lang_statement_loop(){if kind!=jj_lang_operand_condition(){return 0;}}if owner_kind==jj_lang_statement_return(){if kind!=jj_lang_operand_return(){return 0;}}if owner_kind==jj_lang_statement_break(){if kind!=jj_lang_operand_branch(){return 0;}}if owner_kind==jj_lang_statement_assignment(){if jj_operand_store_kind(kind)==0{return 0;}}if owner_kind==jj_lang_statement_expression(){if jj_operand_expression_kind(kind)==0{return 0;}}if owner_kind==jj_lang_statement_require(){if kind!=jj_lang_operand_condition(){return 0;}}var owner_w1:i64=jj_ast16_node_word(core,parent-1,1);var owner_span_id:i64=(owner_w1>>>32)&0xffffffff;var owner_span:i64=jj_ast16_span_word(core,owner_span_id);var owner_start:i64=owner_span&0xffffffff;var owner_count:i64=(owner_span>>>32)&0xffffffff;if owner_count<=0{return 0;}if owner_start>start{return 0;}if owner_start+owner_count<start+count{return 0;}roots=roots+1;}else{if role<=0{return 0;}if parent>core[74]{return 0;}var parent_record:i64=jj_operand_read32(records,parent-1);if (parent_record>>>24)==0{return 0;}var parent_span:i64=leaves[parent-1];var parent_kind:i64=parent_span&255;if jj_operand_kind(parent_kind)==0{return 0;}if parent_kind==35{if role!=1{return 0;}}else{if parent_kind==36{if role>2{return 0;}}else{if parent_kind==37{if role>7{return 0;}}else{if parent_kind==38{if role>2{return 0;}}else{if parent_kind==39{if role!=1{return 0;}}else{if parent_kind==40{if role!=1{return 0;}}else{if jj_operand_store_kind(parent_kind)!=0{if role>2{return 0;}}else{if parent_kind==jj_lang_operand_return(){if role!=1{return 0;}}else{if parent_kind==jj_lang_operand_condition(){if role==1{}else{if role==2{if kind!=jj_lang_operand_branch(){return 0;}}else{if role==3{if kind!=jj_lang_operand_return(){return 0;}if ((parent_record>>>23)&1)==0{return 0;}var contract_statement:i64=parent_record&0xfffff;if jj_ast16_node_kind(core,contract_statement)!=jj_lang_statement_require(){return 0;}}else{return 0;}}}}else{return 0;}}}}}}}}}var parent_start:i64=(parent_span>>>8)&0xffffffff;var parent_count:i64=(parent_span>>>40)&0xffffff;if parent_count<=0{return 0;}if parent_start>start{return 0;}if parent_start+parent_count<start+count{return 0;}if parent_start==start{if parent_count==count{if parent<=i+1{return 0;}}}}}i=i+1;}
  if operands<=0{return 0;}if roots<=0{return 0;}if operands!=core[76]{return 0;}if roots!=core[77]{return 0;}return operands;
}
fn jj_operand_tree_seal(core:*i64)->i64{if jj_operand_tree_state(core)==0{return 0;}var h:i64=(core as i64)^core[73]^core[74]^core[76]^core[77]^core[79]^core[82]^core[83]^0x4a4a4f5053454133;var records:*i8=core[73] as *i8;var syntax:*i64=core[48] as *i64;var leaves:*i64=syntax[5] as *i64;var i:i64=0;while i<core[74]-1{var record:i64=jj_operand_read32(records,i);if record!=0{h=((h<<9)|(h>>>55))^record^leaves[i]^((i+1)*0x9e3779b1);}i=i+1;}return h;}
fn jj_operand_tree_finish(core:*i64)->i64{if jj_operand_tree_draft(core)==0{return 0;}if jj_operand_tree_scan(core)<=0{return 0;}core[75]=0x4a4a4f5046494e33;core[78]=jj_operand_tree_seal(core);if core[78]==0{return 0;}return 1;}
// Full validation remains the rival/release authority. Published consumers use
// the constant-time view gate below; legal mutations require the draft magic.
fn jj_operand_tree_valid(core:*i64)->i64{if jj_operand_tree_state(core)==0{return 0;}if core[75]!=0x4a4a4f5046494e33{return 0;}if jj_operand_tree_scan(core)<=0{return 0;}if core[78]!=jj_operand_tree_seal(core){return 0;}return 1;}
fn jj_operand_tree_view_ready(core:*i64)->i64{if jj_operand_tree_state(core)==0{return 0;}if core[75]!=0x4a4a4f5046494e33{return 0;}if core[78]==0{return 0;}return 1;}
fn jj_operand_tree_release(core:*i64)->i64{if jj_operand_tree_valid(core)==0{return 0;}var base:*i8=core[73] as *i8;var bytes:i64=core[83];var original:i64=core[82];var i:i64=0;while i<bytes{base[i]=0;i=i+1;}core[8]=original;return jj_operand_tree_clear(core);}
fn jj_operand_tree_version(core:*i64)->i64{if jj_operand_tree_view_ready(core)==0{return 0;}return 3;}
fn jj_operand_tree_count(core:*i64)->i64{if jj_operand_tree_view_ready(core)==0{return 0;}return core[76];}
fn jj_operand_tree_root_count(core:*i64)->i64{if jj_operand_tree_view_ready(core)==0{return 0;}return core[77];}
fn jj_operand_tree_capacity(core:*i64)->i64{if jj_operand_tree_view_ready(core)==0{return 0;}return core[74];}
fn jj_operand_tree_kind_sealed(core:*i64,node_ref:i64)->i64{if jj_operand_tree_view_ready(core)==0{return 0;}if (jj_operand_record(core,node_ref)>>>24)==0{return 0;}return jj_operand_span_word(core,node_ref)&255;}
fn jj_operand_tree_kind(core:*i64,node_ref:i64)->i64{return jj_operand_tree_kind_sealed(core,node_ref);}
fn jj_operand_tree_type(core:*i64,node_ref:i64)->i64{if jj_operand_tree_view_ready(core)==0{return 0;}var type_id:i64=(jj_operand_record(core,node_ref)>>>24)&255;if type_id<=0{return 0;}return type_id;}
fn jj_operand_tree_parent(core:*i64,node_ref:i64)->i64{if jj_operand_tree_view_ready(core)==0{return 0;}return jj_operand_record(core,node_ref)&0xfffff;}
fn jj_operand_tree_role(core:*i64,node_ref:i64)->i64{if jj_operand_tree_view_ready(core)==0{return 0;}return (jj_operand_record(core,node_ref)>>>20)&7;}
fn jj_operand_tree_owner(core:*i64,node_ref:i64)->i64{if jj_operand_tree_view_ready(core)==0{return 0;}return (jj_operand_record(core,node_ref)>>>23)&1;}
fn jj_operand_tree_span_start(core:*i64,node_ref:i64)->i64{if jj_operand_tree_view_ready(core)==0{return 0;}if (jj_operand_record(core,node_ref)>>>24)==0{return 0;}return jj_operand_span_start_raw(core,node_ref);}
fn jj_operand_tree_span_count(core:*i64,node_ref:i64)->i64{if jj_operand_tree_view_ready(core)==0{return 0;}if (jj_operand_record(core,node_ref)>>>24)==0{return 0;}return jj_operand_span_count_raw(core,node_ref);}
