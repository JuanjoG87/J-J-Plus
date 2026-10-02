// Typed node arena v1. AST16 owns compact typed node payloads; this companion
// arena owns one 64-bit hierarchy record per node: parent_id[31:0] and
// depth[47:32]. IDs are stable, one-based integer indices. Children are
// enumerated deterministically by increasing ID, never by interior pointers.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_ast16_relations(p0:*i64)->i64;
extern fn jj_ast16_valid(p0:*i64)->i64;
extern fn jj_ast16_node_count(p0:*i64)->i64;
extern fn jj_ast16_add_node(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_ast16_update_node(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_ast16_node_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_ast16_span_word(p0:*i64,p1:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_typed_node_arena_clear(core:*i64)->i64{if core==0{return 0;}var i:i64=52;while i<60{core[i]=0;i=i+1;}return 1;}
fn jj_typed_node_arena_draft(core:*i64)->i64{if core==0{return 0;}if core[52]!=0x4a4a544e44465231{return 0;}if core[53]==0{return 0;}if core[54]<=0{return 0;}if core[55]<0{return 0;}if core[55]>core[54]{return 0;}if core[59]!=1{return 0;}return 1;}
fn jj_typed_node_relation(core:*i64,node_ref:i64)->i64{if core==0{return 0;}if node_ref<=0{return 0;}if node_ref>core[55]{return 0;}var relations:*i64=core[53] as *i64;return relations[node_ref-1];}
fn jj_typed_node_parent_raw(core:*i64,node_ref:i64)->i64{return jj_typed_node_relation(core,node_ref)&0xffffffff;}
fn jj_typed_node_depth_raw(core:*i64,node_ref:i64)->i64{return (jj_typed_node_relation(core,node_ref)>>>32)&0xffff;}
fn jj_typed_node_arena_seal(core:*i64)->i64{
  if core==0{return 0;}var h:i64=(core as i64)^core[53]^core[54]^core[55]^core[56]^core[57]^0x4a4a544e53454131;var i:i64=0;var relations:*i64=core[53] as *i64;
  while i<core[55]{var r:i64=relations[i];var w0:i64=jj_ast16_node_word(core,i,0);var w1:i64=jj_ast16_node_word(core,i,1);var span_id:i64=(w1>>>32)&0xffffffff;var span:i64=jj_ast16_span_word(core,span_id);h=((h<<7)|(h>>>57))^r^w0^w1^span^(i*0x9e3779b1);i=i+1;}return h;
}
fn jj_typed_node_arena_begin(core:*i64,capacity:i64)->i64{
  if core==0{return 0;}if jj_ast16_valid(core)==0{return 0;}if jj_ast16_node_count(core)!=0{return 0;}if capacity<=0{return 0;}if capacity>core[28]{return 0;}if capacity>0xffffffff{return 0;}if jj_typed_node_arena_clear(core)==0{return 0;}var base:i64=jj_ast16_relations(core);if base==0{return 0;}var clear_i:i64=0;var relations:*i64=base as *i64;while clear_i<capacity{relations[clear_i]=0;clear_i=clear_i+1;}core[52]=0x4a4a544e44465231;core[53]=base;core[54]=capacity;core[55]=0;core[56]=0;core[57]=0;core[58]=0;core[59]=1;return jj_typed_node_arena_draft(core);
}
fn jj_typed_node_add(core:*i64,kind_type:i64,payload_a:i64,payload_b:i64,span_word:i64,parent_id:i64)->i64{
  if jj_typed_node_arena_draft(core)==0{return 0;}if kind_type<0{return 0;}if (kind_type>>>32)!=0{return 0;}var kind:i64=kind_type&255;var type_id:i64=(kind_type>>>16)&0xffff;if kind<=0{return 0;}var count:i64=core[55];if count>=core[54]{core[193]=1012;return 0;}var depth:i64=0;if count==0{if parent_id!=0{return 0;}}else{if parent_id<=0{return 0;}if parent_id>count{return 0;}depth=jj_typed_node_depth_raw(core,parent_id)+1;if depth>65535{return 0;}}
  var node_ref:i64=jj_ast16_add_node(core,kind,type_id,payload_a,payload_b,span_word);if node_ref!=count+1{return 0;}var relations:*i64=core[53] as *i64;relations[count]=(parent_id&0xffffffff)|(depth<<32);core[55]=count+1;if count==0{core[56]=node_ref;}if depth>core[57]{core[57]=depth;}return node_ref;
}
fn jj_typed_node_update(core:*i64,node_ref:i64,kind_type:i64,payload_a:i64,payload_b:i64,span_word:i64)->i64{if jj_typed_node_arena_draft(core)==0{return 0;}if node_ref<=0{return 0;}if node_ref>core[55]{return 0;}return jj_ast16_update_node(core,node_ref,kind_type,payload_a,payload_b,span_word);}
fn jj_typed_node_arena_finish(core:*i64)->i64{
  if jj_typed_node_arena_draft(core)==0{return 0;}if core[55]<=0{return 0;}if core[56]!=1{return 0;}if core[55]!=jj_ast16_node_count(core){return 0;}core[52]=0x4a4a544e46494e31;core[58]=jj_typed_node_arena_seal(core);if core[58]==0{return 0;}return 1;
}
fn jj_typed_node_arena_valid(core:*i64)->i64{
  if core==0{return 0;}if core[52]!=0x4a4a544e46494e31{return 0;}if core[53]==0{return 0;}if core[54]<=0{return 0;}if core[55]<=0{return 0;}if core[55]>core[54]{return 0;}if core[56]!=1{return 0;}if core[57]<0{return 0;}if core[59]!=1{return 0;}if jj_ast16_valid(core)==0{return 0;}if core[55]!=jj_ast16_node_count(core){return 0;}var relations:*i64=core[53] as *i64;var i:i64=0;var observed_max:i64=0;
  while i<core[55]{var node_ref:i64=i+1;var relation:i64=relations[i];var parent:i64=relation&0xffffffff;var depth:i64=(relation>>>32)&0xffff;if (relation>>>48)!=0{return 0;}if node_ref==1{if parent!=0{return 0;}if depth!=0{return 0;}}else{if parent<=0{return 0;}if parent>=node_ref{return 0;}var parent_depth:i64=(relations[parent-1]>>>32)&0xffff;if depth!=parent_depth+1{return 0;}}if depth>observed_max{observed_max=depth;}var kind:i64=jj_ast16_node_word(core,i,0)&255;if kind<=0{return 0;}i=i+1;}if observed_max!=core[57]{return 0;}if core[58]!=jj_typed_node_arena_seal(core){return 0;}return 1;
}
fn jj_typed_node_arena_view_ready(core:*i64)->i64{if core==0{return 0;}if core[52]!=0x4a4a544e46494e31{return 0;}if core[53]==0{return 0;}if core[54]<=0{return 0;}if core[55]<=0{return 0;}if core[55]>core[54]{return 0;}if core[56]!=1{return 0;}if core[57]<0{return 0;}if core[58]==0{return 0;}if core[59]!=1{return 0;}return 1;}

fn jj_typed_node_arena_release(core:*i64)->i64{
  if jj_typed_node_arena_valid(core)==0{return 0;}var capacity:i64=core[54];var relations:*i64=core[53] as *i64;if capacity<=0{return 0;}if core[53]!=jj_ast16_relations(core){return 0;}var i:i64=0;while i<capacity{relations[i]=0;i=i+1;}return jj_typed_node_arena_clear(core);
}
fn jj_typed_node_arena_version(core:*i64)->i64{if jj_typed_node_arena_view_ready(core)==0{return 0;}return 1;}
fn jj_typed_node_count(core:*i64)->i64{if jj_typed_node_arena_view_ready(core)==0{return 0;}return core[55];}
fn jj_typed_node_root(core:*i64)->i64{if jj_typed_node_arena_view_ready(core)==0{return 0;}return core[56];}
fn jj_typed_node_parent(core:*i64,node_ref:i64)->i64{if jj_typed_node_arena_view_ready(core)==0{return 0;}return jj_typed_node_parent_raw(core,node_ref);}
fn jj_typed_node_depth(core:*i64,node_ref:i64)->i64{if jj_typed_node_arena_view_ready(core)==0{return 0;}return jj_typed_node_depth_raw(core,node_ref);}
fn jj_typed_node_child_count(core:*i64,parent_id:i64)->i64{if jj_typed_node_arena_view_ready(core)==0{return 0;}if parent_id<=0{return 0;}if parent_id>core[55]{return 0;}var count:i64=0;var i:i64=parent_id;while i<core[55]{if jj_typed_node_parent_raw(core,i+1)==parent_id{count=count+1;}i=i+1;}return count;}
fn jj_typed_node_child_at(core:*i64,parent_id:i64,ordinal:i64)->i64{if jj_typed_node_arena_view_ready(core)==0{return 0;}if parent_id<=0{return 0;}if parent_id>core[55]{return 0;}if ordinal<0{return 0;}var seen:i64=0;var i:i64=parent_id;while i<core[55]{var node_ref:i64=i+1;if jj_typed_node_parent_raw(core,node_ref)==parent_id{if seen==ordinal{return node_ref;}seen=seen+1;}i=i+1;}return 0;}
