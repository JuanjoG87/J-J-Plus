// Capacity-indexed AST16 authority and source/bytecode/machine map storage.
// Core State retains only the parent workspace base, its byte capacity and
// logical offsets. Nodes, spans and maps are always derived transiently.
// Node word0: kind[7:0] | flags[15:8] | type_id[31:16] | payload_a[63:32].
// Node word1: payload_b[31:0] | span_id[63:32].
// SourceSpan: start[31:0] | length[63:32].
// Map word0: function_id[31:0] | bytecode_pc[63:32].
// Map word1: node_id[31:0] | machine_offset[63:32].

extern fn jj_c_hash_bytes(p0: *i8, p1: i64, p2: i64) -> i64;
extern fn jj_c_wr64(p0: *i8, p1: i64) -> i64;
extern fn jj_core_index_record(p0:*i64,p1:i64,p2:i64)->i64;

fn jj_ast16_valid(core:*i64)->i64{
  if core==0{return 0;}if core[22]==0{return 0;}if core[23]<=0{return 0;}if core[28]<=0{return 0;}if core[29]<=0{return 0;}if core[33]<0{return 0;}if core[34]<=0{return 0;}if core[46]<=0{return 0;}if core[47]<=core[46]{return 0;}
  if core[46]!=core[28]*16{return 0;}if core[47]!=core[46]+core[28]*8{return 0;}if core[194]!=core[47]+core[29]*16{return 0;}if core[195]!=core[28]*8{return 0;}if core[194]>core[34]-core[195]{return 0;}if core[194]+core[195]!=core[34]{return 0;}if core[33]>core[23]-core[34]{return 0;}
  var seal:i64=(core as i64)^core[22]^core[23]^core[28]^core[29]^core[33]^core[34]^core[46]^core[47]^core[194]^core[195]^0x4a4a415354313633;if core[24]!=seal{return 0;}return 1;
}

fn jj_ast16_init(core:*i64,workspace:*i8,workspace_bytes:i64,ast_offset:i64,node_capacity:i64,map_capacity:i64)->i64{
  if core==0{return 0;}if workspace==0{return 0;}if workspace_bytes<=0{return 0;}if ast_offset<0{return 0;}if node_capacity<=0{return 0;}if map_capacity<=0{return 0;}if node_capacity>0x0fffffff{return 0;}if map_capacity>0x0fffffff{return 0;}
  var node_bytes:i64=node_capacity*16;var span_bytes:i64=node_capacity*8;var map_bytes:i64=map_capacity*16;var relation_bytes:i64=node_capacity*8;if node_bytes<=0{return 0;}if span_bytes<=0{return 0;}if map_bytes<=0{return 0;}if relation_bytes<=0{return 0;}var ast_bytes:i64=node_bytes+span_bytes+map_bytes+relation_bytes;if ast_bytes<=0{return 0;}if ast_offset>workspace_bytes-ast_bytes{return 0;}
  core[22]=workspace as i64;core[23]=workspace_bytes;core[25]=0;core[26]=0;core[27]=0;core[28]=node_capacity;core[29]=map_capacity;core[33]=ast_offset;core[34]=ast_bytes;core[46]=node_bytes;core[47]=node_bytes+span_bytes;core[194]=node_bytes+span_bytes+map_bytes;core[195]=relation_bytes;core[11]=0;
  core[24]=(core as i64)^core[22]^core[23]^core[28]^core[29]^core[33]^core[34]^core[46]^core[47]^core[194]^core[195]^0x4a4a415354313633;return jj_ast16_valid(core);
}

fn jj_ast16_node_count(core:*i64)->i64{if jj_ast16_valid(core)==0{return 0;}return core[25];}
fn jj_ast16_span_count(core:*i64)->i64{if jj_ast16_valid(core)==0{return 0;}return core[26];}
fn jj_ast16_map_count(core:*i64)->i64{if jj_ast16_valid(core)==0{return 0;}return core[27];}
fn jj_ast16_nodes(core:*i64)->i64{if jj_ast16_valid(core)==0{return 0;}return core[22]+core[33];}
fn jj_ast16_spans(core:*i64)->i64{if jj_ast16_valid(core)==0{return 0;}return core[22]+core[33]+core[46];}
fn jj_ast16_maps(core:*i64)->i64{if jj_ast16_valid(core)==0{return 0;}return core[22]+core[33]+core[47];}
fn jj_ast16_relations(core:*i64)->i64{if jj_ast16_valid(core)==0{return 0;}return core[22]+core[33]+core[194];}

fn jj_ast16_node_word(core:*i64,index:i64,word:i64)->i64{
  if jj_ast16_valid(core)==0{return 0;}if index<0{return 0;}if index>=core[28]{return 0;}if word<0{return 0;}if word>1{return 0;}var base:*i64=(core[22]+core[33]) as *i64;return base[index*2+word];
}
fn jj_ast16_node_store(core:*i64,index:i64,word:i64,value:i64)->i64{
  if jj_ast16_valid(core)==0{return 0;}if index<0{return 0;}if index>=core[28]{return 0;}if word<0{return 0;}if word>1{return 0;}var base:*i64=(core[22]+core[33]) as *i64;base[index*2+word]=value;return 1;
}
fn jj_ast16_map_word(core:*i64,index:i64,word:i64)->i64{
  if jj_ast16_valid(core)==0{return 0;}if index<0{return 0;}if index>=core[29]{return 0;}if word<0{return 0;}if word>1{return 0;}var base:*i64=(core[22]+core[33]+core[47]) as *i64;return base[index*2+word];
}
fn jj_ast16_map_store(core:*i64,index:i64,word:i64,value:i64)->i64{
  if jj_ast16_valid(core)==0{return 0;}if index<0{return 0;}if index>=core[29]{return 0;}if word<0{return 0;}if word>1{return 0;}var base:*i64=(core[22]+core[33]+core[47]) as *i64;base[index*2+word]=value;return 1;
}

fn jj_ast16_add_node(core:*i64,kind:i64,type_id:i64,payload_a:i64,payload_b:i64,span_word:i64)->i64{
  if jj_ast16_valid(core)==0{return 0;}if kind<0{return 0;}if kind>255{return 0;}if type_id<0{return 0;}if type_id>65535{return 0;}if payload_a<0{return 0;}if payload_a>0xffffffff{return 0;}if payload_b<0{return 0;}if payload_b>0xffffffff{return 0;}
  var count:i64=core[25];var span_count:i64=core[26];if count>=core[28]{core[193]=1002;return 0;}if span_count>=core[28]{core[193]=1002;return 0;}var spans:*i64=(core[22]+core[33]+core[46]) as *i64;
  var header:i64=kind|(type_id<<16);if jj_ast16_node_store(core,count,0,header|(payload_a<<32))==0{return 0;}if jj_ast16_node_store(core,count,1,payload_b|(span_count<<32))==0{return 0;}spans[span_count]=span_word;core[25]=count+1;core[26]=span_count+1;return count+1;
}
fn jj_ast16_add_map(core:*i64,function_id:i64,bytecode_pc:i64,node_ref:i64)->i64{
  if jj_ast16_valid(core)==0{return 0;}if function_id<0{return 0;}if function_id>0xffffffff{return 0;}if bytecode_pc<0{return 0;}if bytecode_pc>0xffffffff{return 0;}if node_ref<=0{return 0;}var count:i64=core[27];if count>=core[29]{core[193]=1002;return 0;}
  if jj_ast16_map_store(core,count,0,function_id|(bytecode_pc<<32))==0{return 0;}if jj_ast16_map_store(core,count,1,node_ref-1)==0{return 0;}core[27]=count+1;return 1;
}
fn jj_ast16_add_function_map(core:*i64,function_id:i64,bytecode_pc:i64,node_ref:i64)->i64{return jj_ast16_add_map(core,function_id,bytecode_pc,node_ref);}
fn jj_ast16_span_start(spans:*i64,span_id:i64)->i64{if spans==0{return 0;}if span_id<0{return 0;}return spans[span_id]&0xffffffff;}
fn jj_ast16_rd64(p:*i8)->i64{if p==0{return 0;}var value:i64=0;var i:i64=0;while i<8{value=value|((p[i]&255)<<(i*8));i=i+1;}return value;}

fn jj_ast16_materialize_function_table(core:*i64,program:*i8,program_capacity:i64)->i64{
  if jj_ast16_valid(core)==0{return 0;}if program==0{return 0;}if program_capacity<48{return 0;}var source:*i8=core[0] as *i8;if source==0{return 0;}
  var node_count:i64=core[25];var map_count:i64=core[27];var function_count:i64=core[10];if function_count<=0{return 0;}var table_offset:i64=core[9];if table_offset<48{return 0;}if function_count>0x07ffffff{return 0;}var table_bytes:i64=function_count*32;if table_offset>program_capacity-table_bytes{return 0;}
  // The high bit of the local-count word is a transient seen marker. Local
  // counts are bounded far below 2^63 and the marker is removed before publish.
  var function_id:i64=0;while function_id<function_count{var clear:*i8=program+table_offset+function_id*32;jj_c_wr64(clear,0);jj_c_wr64(clear+8,0);jj_c_wr64(clear+16,0);jj_c_wr64(clear+24,0);function_id=function_id+1;}
  var nodes:*i64=(core[22]+core[33]) as *i64;var maps:*i64=(core[22]+core[33]+core[47]) as *i64;var i:i64=0;
  while i<map_count{var map0:i64=maps[i*2];var map1:i64=maps[i*2+1];var node_id:i64=map1&0xffffffff;if node_id>=node_count{return 0;}var word0:i64=nodes[node_id*2];var word1:i64=nodes[node_id*2+1];if (word0&255)==1{var mapped_function:i64=map0&0xffffffff;if mapped_function<function_count{var entry:*i8=program+table_offset+mapped_function*32;if (jj_ast16_rd64(entry+24)>>>63)!=0{return 0;}var record:*i64=jj_core_index_record(core,1,mapped_function) as *i64;if record==0{return 0;}var bytecode_pc:i64=(map0>>>32)&0xffffffff;var payload_function:i64=(word0>>>32)&0xffffffff;var return_type:i64=(word0>>>16)&0xffff;var argc:i64=word1&0xffffffff;var name_start:i64=record[1];var name_count:i64=record[2];var function_pc:i64=record[3];var function_argc:i64=record[4];var locals:i64=record[5];if name_start<0{return 0;}if name_count<=0{return 0;}if locals<0{return 0;}if payload_function!=mapped_function{return 0;}if bytecode_pc!=function_pc{return 0;}var logical_argc:i64=function_argc;if return_type>=100{if return_type<=127{logical_argc=logical_argc-1;}}if logical_argc<0{return 0;}if argc!=logical_argc{return 0;}if return_type!=record[6]{return 0;}jj_c_wr64(entry,jj_c_hash_bytes(source,name_start,name_count));jj_c_wr64(entry+8,bytecode_pc);jj_c_wr64(entry+16,function_argc);jj_c_wr64(entry+24,locals|0x8000000000000000);}}i=i+1;}
  function_id=0;while function_id<function_count{var final_entry:*i8=program+table_offset+function_id*32;var marked:i64=jj_ast16_rd64(final_entry+24);if (marked>>>63)==0{return 0;}jj_c_wr64(final_entry+24,marked&0x7fffffffffffffff);function_id=function_id+1;}
  jj_c_wr64(program+32,table_offset);core[9]=table_offset+table_bytes;return 1;
}

// Typed-tree support. Node IDs remain one-based outside this module; the
// compact AST16 record remains 16 bytes and hierarchy is stored separately.
fn jj_ast16_span_word(core:*i64,index:i64)->i64{
  if jj_ast16_valid(core)==0{return 0;}if index<0{return 0;}if index>=core[26]{return 0;}var spans:*i64=(core[22]+core[33]+core[46]) as *i64;return spans[index];
}
fn jj_ast16_update_node(core:*i64,node_ref:i64,kind_type:i64,payload_a:i64,payload_b:i64,span_word:i64)->i64{
  if jj_ast16_valid(core)==0{return 0;}if node_ref<=0{return 0;}var index:i64=node_ref-1;if index>=core[25]{return 0;}if kind_type<0{return 0;}if (kind_type>>>32)!=0{return 0;}var kind:i64=kind_type&255;var type_id:i64=(kind_type>>>16)&0xffff;if kind<=0{return 0;}if payload_a<0{return 0;}if payload_a>0xffffffff{return 0;}if payload_b<0{return 0;}if payload_b>0xffffffff{return 0;}
  var old1:i64=jj_ast16_node_word(core,index,1);var span_id:i64=(old1>>>32)&0xffffffff;if span_id>=core[26]{return 0;}var spans:*i64=(core[22]+core[33]+core[46]) as *i64;var header:i64=kind|(type_id<<16);if jj_ast16_node_store(core,index,0,header|(payload_a<<32))==0{return 0;}if jj_ast16_node_store(core,index,1,payload_b|(span_id<<32))==0{return 0;}spans[span_id]=span_word;return 1;
}
fn jj_ast16_node_kind(core:*i64,node_ref:i64)->i64{if node_ref<=0{return 0;}return jj_ast16_node_word(core,node_ref-1,0)&255;}
fn jj_ast16_node_type(core:*i64,node_ref:i64)->i64{if node_ref<=0{return 0;}return (jj_ast16_node_word(core,node_ref-1,0)>>>16)&0xffff;}

// R758 failure-only provenance lookup. The packed result contains a real
// non-empty SourceSpan plus the bytecode origin and origin kind:
// 1 exact map, 2 nearest prior map, 3 function token fallback.
fn jj_ast16_source_provenance_for_pc(core:*i64,function_id:i64,bytecode_pc:i64)->i64{
  if jj_ast16_valid(core)==0{return 0;}if function_id<0{return 0;}if bytecode_pc<0{return 0;}var count:i64=core[27];var best_pc:i64=0-1;var best_span:i64=0;var function_pc:i64=0;var function_span:i64=0;var i:i64=0;while i<count{var m0:i64=jj_ast16_map_word(core,i,0);if (m0&0xffffffff)==function_id{var pc:i64=(m0>>>32)&0xffffffff;var m1:i64=jj_ast16_map_word(core,i,1);var node:i64=m1&0xffffffff;if node<core[25]{var word0:i64=jj_ast16_node_word(core,node,0);var word1:i64=jj_ast16_node_word(core,node,1);var span_id:i64=(word1>>>32)&0xffffffff;if span_id<core[26]{var span:i64=jj_ast16_span_word(core,span_id);var start:i64=span&0xffffffff;var length:i64=(span>>>32)&0xffffffff;if length>0{if start<core[1]{if (word0&255)==1{function_span=span;function_pc=pc;}if pc<=bytecode_pc{if pc>=best_pc{best_pc=pc;best_span=span;}}}}}}}i=i+1;}var selected:i64=best_span;var origin:i64=best_pc;var kind:i64=2;if best_span!=0{if best_pc==bytecode_pc{kind=1;}}else{selected=function_span;origin=function_pc;kind=3;}if selected==0{return 0;}var selected_start:i64=selected&0xffffffff;var selected_length:i64=(selected>>>32)&0xffffffff;if selected_start>0xfffff{return 0;}if selected_length>4095{selected_length=4095;}if origin<0{origin=0;}if origin>0xffffff{origin=0xffffff;}return (selected_start&0xfffff)|((selected_length&4095)<<20)|((origin&0xffffff)<<32)|((kind&15)<<56);
}
fn jj_ast16_source_span_for_pc(core:*i64,function_id:i64,bytecode_pc:i64)->i64{var p:i64=jj_ast16_source_provenance_for_pc(core,function_id,bytecode_pc);if p==0{return 0;}return (p&0xfffff)|(((p>>>20)&4095)<<32);}

// R759 failure-only source-node lookup for bounded transformation lineage.
// Returns a one-based AST node reference. Exact, nearest-prior and function
// fallback use the same selection policy as jj_ast16_source_provenance_for_pc.
fn jj_ast16_source_node_for_pc(core:*i64,function_id:i64,bytecode_pc:i64)->i64{
  if jj_ast16_valid(core)==0{return 0;}if function_id<0{return 0;}if bytecode_pc<0{return 0;}var count:i64=core[27];var best_pc:i64=0-1;var best_node:i64=0;var function_node:i64=0;var i:i64=0;
  while i<count{var m0:i64=jj_ast16_map_word(core,i,0);if (m0&0xffffffff)==function_id{var pc:i64=(m0>>>32)&0xffffffff;var m1:i64=jj_ast16_map_word(core,i,1);var node:i64=m1&0xffffffff;if node<core[25]{var word0:i64=jj_ast16_node_word(core,node,0);var word1:i64=jj_ast16_node_word(core,node,1);var span_id:i64=(word1>>>32)&0xffffffff;if span_id<core[26]{var span:i64=jj_ast16_span_word(core,span_id);var start:i64=span&0xffffffff;var length:i64=(span>>>32)&0xffffffff;if length>0{if start<core[1]{if (word0&255)==1{function_node=node+1;}if pc<=bytecode_pc{if pc>=best_pc{best_pc=pc;best_node=node+1;}}}}}}}i=i+1;}
  if best_node!=0{return best_node;}return function_node;
}
