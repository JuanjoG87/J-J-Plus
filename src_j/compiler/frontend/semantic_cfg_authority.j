// Semantic CFG authority v2. Basic blocks are derived from the sealed semantic
// CIR stream, never from parser state or backend-specific machine details.
// Storage is a caller-owned temporary slice at the high end of the program capability.
// It is stacked after the operand relation slice and released before that slice.
// word0: start_pc[31:0] | end_pc[63:32]
// word1: function_id[23:0] | terminator_kind[31:24] | terminator_pc[63:32]
// word2: successor0[31:0] | successor1[63:32], one-based block IDs
// word3: terminator_operand_id[31:0] | predecessor_count[62:32] | reachable[63]
// word4: validation scratch, required to be zero outside O(B+E) graph rederivation.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_core_function_count(p0:*i64)->i64;
extern fn jj_core_function_field(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_semantic_cir_valid(p0:*i64)->i64;
extern fn jj_semantic_cir_length(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_semantic_cir_rd32(p0:*i8)->i64;
extern fn jj_typed_node_arena_valid(p0:*i64)->i64;
extern fn jj_ast16_node_kind(p0:*i64,p1:i64)->i64;
extern fn jj_ast16_node_word(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_operand_tree_valid(p0:*i64)->i64;
extern fn jj_operand_tree_capacity(p0:*i64)->i64;
extern fn jj_operand_tree_kind_sealed(p0:*i64,p1:i64)->i64;
extern fn jj_operand_record(p0:*i64,p1:i64)->i64;
extern fn jj_lang_statement_if()->i64;
extern fn jj_lang_statement_loop()->i64;
extern fn jj_lang_statement_return()->i64;
extern fn jj_lang_statement_break()->i64;
extern fn jj_lang_statement_require()->i64;
extern fn jj_lang_operand_return()->i64;
extern fn jj_lang_operand_branch()->i64;
extern fn jj_lang_operand_condition()->i64;
extern fn jj_lang_cir_jump()->i64;
extern fn jj_lang_cir_branch_zero()->i64;
extern fn jj_lang_cir_return()->i64;
// canonical interface_EXTERN_PROTOTYPES_END

fn jj_cfg_clear(core:*i64)->i64{if core==0{return 0;}var i:i64=92;while i<105{core[i]=0;i=i+1;}return 1;}
fn jj_cfg_empty(core:*i64)->i64{if core==0{return 0;}var i:i64=92;while i<105{if core[i]!=0{return 0;}i=i+1;}return 1;}
fn jj_cfg_state(core:*i64)->i64{
  if core==0{return 0;}if core[92]!=0x4a4a434647445232{if core[92]!=0x4a4a434647464e32{return 0;}}
  if core[7]<=0{return 0;}if core[93]<=0{return 0;}if core[94]<=0{return 0;}if core[94]>0x03ffffff{return 0;}if core[95]<=0{return 0;}if core[95]!=core[94]*5{return 0;}
  if core[96]<0{return 0;}if core[96]>core[94]*2{return 0;}if core[97]<0{return 0;}if core[97]>core[94]{return 0;}if core[98]<=0{return 0;}if core[98]>0x01000000{return 0;}
  if core[99]<65536{return 0;}if core[101]!=2{return 0;}if core[102]<0{return 0;}if core[102]>core[94]{return 0;}if core[103]<=0{return 0;}if core[103]>core[94]{return 0;}if core[104]<0{return 0;}if core[104]>core[94]{return 0;}
  if core[93]<core[7]{return 0;}var effective_capacity:i64=core[93]-core[7];var bytes:i64=core[95]*8;if bytes<=0{return 0;}if effective_capacity<65536{return 0;}if effective_capacity>core[99]{return 0;}if core[8]>effective_capacity{return 0;}if bytes>core[99]-effective_capacity{return 0;}if effective_capacity+bytes!=core[99]{return 0;}
  if core[9]<48{return 0;}if core[9]>core[8]{return 0;}if core[7]>0x7fffffffffffffff-effective_capacity{return 0;}if core[93]!=core[7]+effective_capacity{return 0;}return 1;
}
fn jj_cfg_draft(core:*i64)->i64{if jj_cfg_state(core)==0{return 0;}if core[92]!=0x4a4a434647445232{return 0;}return 1;}
fn jj_cfg_record(core:*i64,block_id:i64,word:i64)->i64{if jj_cfg_state(core)==0{return 0;}if block_id<=0{return 0;}if block_id>core[94]{return 0;}if word<0{return 0;}if word>4{return 0;}var base:*i64=core[93] as *i64;return base[(block_id-1)*5+word];}
fn jj_cfg_store(core:*i64,block_id:i64,word:i64,value:i64)->i64{if jj_cfg_draft(core)==0{return 0;}if block_id<=0{return 0;}if block_id>core[94]{return 0;}if word<0{return 0;}if word>4{return 0;}var base:*i64=core[93] as *i64;base[(block_id-1)*5+word]=value;return 1;}
fn jj_cfg_scratch_get(core:*i64,block_id:i64)->i64{if jj_cfg_state(core)==0{return 0;}if block_id<=0{return 0;}if block_id>core[94]{return 0;}var base:*i64=core[93] as *i64;return base[(block_id-1)*5+4];}
fn jj_cfg_scratch_set(core:*i64,block_id:i64,value:i64)->i64{if jj_cfg_state(core)==0{return 0;}if block_id<=0{return 0;}if block_id>core[94]{return 0;}var base:*i64=core[93] as *i64;base[(block_id-1)*5+4]=value;return 1;}
fn jj_cfg_scratch_clear(core:*i64)->i64{if jj_cfg_state(core)==0{return 0;}var base:*i64=core[93] as *i64;var i:i64=0;while i<core[94]{base[i*5+4]=0;i=i+1;}return 1;}
fn jj_cfg_scratch_zero(core:*i64)->i64{if jj_cfg_state(core)==0{return 0;}var base:*i64=core[93] as *i64;var i:i64=0;while i<core[94]{if base[i*5+4]!=0{return 0;}i=i+1;}return 1;}
fn jj_cfg_function_start(core:*i64,function_id:i64)->i64{return jj_core_function_field(core,function_id,2);}
fn jj_cfg_function_end(core:*i64,function_id:i64)->i64{var count:i64=jj_core_function_count(core);if function_id<0{return 0;}if function_id>=count{return 0;}if function_id+1<count{return jj_cfg_function_start(core,function_id+1);}return core[62];}

fn jj_cfg_candidate_count(core:*i64)->i64{
  if jj_semantic_cir_valid(core)==0{return 0;}var functions:i64=jj_core_function_count(core);if functions<=0{return 0;}if functions>0x01000000{return 0;}var program:*i8=core[7] as *i8;var total:i64=functions;var f:i64=0;
  while f<functions{var start:i64=jj_cfg_function_start(core,f);var end:i64=jj_cfg_function_end(core,f);if start<48{return 0;}if end<=start{return 0;}if end>core[62]{return 0;}var pc:i64=start;
    while pc<end{var length:i64=jj_semantic_cir_length(program,pc,end);if length<=0{return 0;}var next:i64=pc+length;var op:i64=program[pc];if op==jj_lang_cir_jump(){var target:i64=jj_semantic_cir_rd32(program+pc+1);if target<start{return 0;}if target>=end{return 0;}total=total+1;if next<end{total=total+1;}}
      else{if op==jj_lang_cir_branch_zero(){var target2:i64=jj_semantic_cir_rd32(program+pc+1);if target2<start{return 0;}if target2>=end{return 0;}total=total+1;if next<end{total=total+1;}}
      else{if op==jj_lang_cir_return(){if next<end{total=total+1;}}}}
      if total>0x03ffffff{return 0;}pc=next;
    }if pc!=end{return 0;}f=f+1;
  }return total;
}
fn jj_cfg_fill_candidates(core:*i64,values:*i64,capacity:i64)->i64{
  if values==0{return 0;}if capacity<=0{return 0;}var functions:i64=jj_core_function_count(core);var program:*i8=core[7] as *i8;var count:i64=0;var f:i64=0;
  while f<functions{var start:i64=jj_cfg_function_start(core,f);var end:i64=jj_cfg_function_end(core,f);if count>=capacity{return 0;}values[count]=start;count=count+1;var pc:i64=start;
    while pc<end{var length:i64=jj_semantic_cir_length(program,pc,end);if length<=0{return 0;}var next:i64=pc+length;var op:i64=program[pc];if op==jj_lang_cir_jump(){var target:i64=jj_semantic_cir_rd32(program+pc+1);if count>=capacity{return 0;}values[count]=target;count=count+1;if next<end{if count>=capacity{return 0;}values[count]=next;count=count+1;}}
      else{if op==jj_lang_cir_branch_zero(){var target2:i64=jj_semantic_cir_rd32(program+pc+1);if count>=capacity{return 0;}values[count]=target2;count=count+1;if next<end{if count>=capacity{return 0;}values[count]=next;count=count+1;}}
      else{if op==jj_lang_cir_return(){if next<end{if count>=capacity{return 0;}values[count]=next;count=count+1;}}}}
      pc=next;
    }f=f+1;
  }if count!=capacity{return 0;}return count;
}
fn jj_cfg_heap_down(values:*i64,count:i64,root:i64)->i64{if values==0{return 0;}if count<=0{return 0;}if root<0{return 0;}if root>=count{return 0;}var value:i64=values[root];var child:i64=root*2+1;while child<count{if child+1<count{if values[child]<values[child+1]{child=child+1;}}if value>=values[child]{break;}values[root]=values[child];root=child;child=root*2+1;}values[root]=value;return 1;}
fn jj_cfg_sort(values:*i64,count:i64)->i64{if values==0{return 0;}if count<=0{return 0;}var i:i64=count/2;while i>0{i=i-1;if jj_cfg_heap_down(values,count,i)==0{return 0;}}var end:i64=count;while end>1{end=end-1;var t:i64=values[0];values[0]=values[end];values[end]=t;if jj_cfg_heap_down(values,end,0)==0{return 0;}}return 1;}
fn jj_cfg_unique(values:*i64,count:i64)->i64{if values==0{return 0;}if count<=0{return 0;}var out:i64=1;var i:i64=1;while i<count{if values[i]!=values[out-1]{values[out]=values[i];out=out+1;}i=i+1;}return out;}
fn jj_cfg_block_start_raw(core:*i64,index:i64)->i64{var base:*i64=core[93] as *i64;return base[index*5]&0xffffffff;}
fn jj_cfg_find_block_raw(core:*i64,pc:i64)->i64{if jj_cfg_state(core)==0{return 0;}var lo:i64=0;var hi:i64=core[94];while lo<hi{var mid:i64=(lo+hi)/2;var value:i64=jj_cfg_block_start_raw(core,mid);if value<pc{lo=mid+1;}else{hi=mid;}}if lo<core[94]{if jj_cfg_block_start_raw(core,lo)==pc{return lo+1;}}return 0;}
fn jj_cfg_function_for_pc(core:*i64,pc:i64)->i64{var functions:i64=jj_core_function_count(core);if functions<=0{return 0-1;}var lo:i64=0;var hi:i64=functions;while lo<hi{var mid:i64=(lo+hi)/2;var start:i64=jj_cfg_function_start(core,mid);if start<=pc{lo=mid+1;}else{hi=mid;}}if lo==0{return 0-1;}var f:i64=lo-1;var end:i64=jj_cfg_function_end(core,f);if pc>=end{return 0-1;}return f;}
fn jj_cfg_terminator_pc(core:*i64,operand_id:i64)->i64{
  var kind:i64=jj_operand_tree_kind_sealed(core,operand_id);if kind<jj_lang_operand_return(){return 0;}if kind>jj_lang_operand_condition(){return 0;}var relation:i64=jj_operand_record(core,operand_id);if relation==0{return 0;}var parent:i64=relation&0xfffff;var owner:i64=(relation>>>23)&1;var statement:i64=0;
  if owner!=0{statement=parent;}else{if kind!=jj_lang_operand_branch(){if kind!=jj_lang_operand_return(){return 0;}}var parent_kind:i64=jj_operand_tree_kind_sealed(core,parent);if parent_kind!=jj_lang_operand_condition(){return 0;}var parent_relation:i64=jj_operand_record(core,parent);if ((parent_relation>>>23)&1)==0{return 0;}statement=parent_relation&0xfffff;}
  var statement_kind:i64=jj_ast16_node_kind(core,statement);if statement_kind<jj_lang_statement_if(){return 0;}if statement_kind>jj_lang_statement_break(){if statement_kind!=jj_lang_statement_require(){return 0;}}var w0:i64=jj_ast16_node_word(core,statement-1,0);var w1:i64=jj_ast16_node_word(core,statement-1,1);var start:i64=(w0>>>32)&0xffffffff;var length:i64=w1&0xffffffff;var end:i64=start+length;if length<=0{return 0;}if end<=start{return 0;}var program:*i8=core[7] as *i8;
  if kind==jj_lang_operand_return(){if statement_kind!=jj_lang_statement_return(){if statement_kind!=jj_lang_statement_require(){return 0;}}var pc_return:i64=end-1;if pc_return<start{return 0;}if program[pc_return]!=jj_lang_cir_return(){return 0;}return pc_return;}
  if kind==jj_lang_operand_branch(){if owner!=0{if statement_kind!=jj_lang_statement_break(){return 0;}var pc_break:i64=end-5;if pc_break<start{return 0;}if program[pc_break]!=jj_lang_cir_jump(){return 0;}return pc_break;}
    if statement_kind==jj_lang_statement_if(){var pc_if:i64=start;while pc_if<end{var size_if:i64=jj_semantic_cir_length(program,pc_if,end);if size_if<=0{return 0;}if program[pc_if]==jj_lang_cir_jump(){if jj_semantic_cir_rd32(program+pc_if+1)==end{return pc_if;}}pc_if=pc_if+size_if;}return 0;}
    if statement_kind==jj_lang_statement_require(){var pc_require_branch:i64=start;while pc_require_branch<end{var size_require_branch:i64=jj_semantic_cir_length(program,pc_require_branch,end);if size_require_branch<=0{return 0;}if program[pc_require_branch]==jj_lang_cir_jump(){if jj_semantic_cir_rd32(program+pc_require_branch+1)==end{return pc_require_branch;}}pc_require_branch=pc_require_branch+size_require_branch;}return 0;}
    if statement_kind==jj_lang_statement_loop(){var pc_loop:i64=start;var found:i64=0;while pc_loop<end{var size_loop:i64=jj_semantic_cir_length(program,pc_loop,end);if size_loop<=0{return 0;}if program[pc_loop]==jj_lang_cir_jump(){if jj_semantic_cir_rd32(program+pc_loop+1)==start{found=pc_loop;}}pc_loop=pc_loop+size_loop;}return found;}return 0;}
  if kind==jj_lang_operand_condition(){if statement_kind!=jj_lang_statement_if(){if statement_kind!=jj_lang_statement_loop(){if statement_kind!=jj_lang_statement_require(){return 0;}}}var pc_cond:i64=start;while pc_cond<end{var size_cond:i64=jj_semantic_cir_length(program,pc_cond,end);if size_cond<=0{return 0;}if program[pc_cond]==jj_lang_cir_branch_zero(){return pc_cond;}pc_cond=pc_cond+size_cond;}return 0;}
  return 0;
}
fn jj_cfg_block_for_pc(core:*i64,pc:i64)->i64{if jj_cfg_state(core)==0{return 0;}var lo:i64=0;var hi:i64=core[94];while lo<hi{var mid:i64=(lo+hi)/2;var start:i64=jj_cfg_block_start_raw(core,mid);if start<=pc{lo=mid+1;}else{hi=mid;}}if lo==0{return 0;}var id:i64=lo;var range:i64=jj_cfg_record(core,id,0);var start2:i64=range&0xffffffff;var end2:i64=(range>>>32)&0xffffffff;if pc<start2{return 0;}if pc>=end2{return 0;}return id;}

fn jj_cfg_build_records(core:*i64)->i64{
  if jj_cfg_draft(core)==0{return 0;}var program:*i8=core[7] as *i8;var blocks:i64=core[94];var edges:i64=0;var synthetic:i64=0;var i:i64=0;
  while i<blocks{var block_id:i64=i+1;var start:i64=jj_cfg_block_start_raw(core,i);var function_id:i64=jj_cfg_function_for_pc(core,start);if function_id<0{return 0;}if function_id>0xffffff{return 0;}var function_end:i64=jj_cfg_function_end(core,function_id);var end:i64=function_end;if i+1<blocks{var next_start:i64=jj_cfg_block_start_raw(core,i+1);if next_start<function_end{end=next_start;}}if end<=start{return 0;}var pc:i64=start;var last_pc:i64=0;var last_op:i64=0;
    while pc<end{var size:i64=jj_semantic_cir_length(program,pc,end);if size<=0{return 0;}last_pc=pc;last_op=program[pc];pc=pc+size;}if pc!=end{return 0;}var kind:i64=0;var succ0:i64=0;var succ1:i64=0;
    if last_op==jj_lang_cir_jump(){kind=2;var target:i64=jj_semantic_cir_rd32(program+last_pc+1);succ0=jj_cfg_find_block_raw(core,target);if succ0==0{return 0;}edges=edges+1;}
    else{if last_op==jj_lang_cir_branch_zero(){kind=3;var zero_target:i64=jj_semantic_cir_rd32(program+last_pc+1);succ0=jj_cfg_find_block_raw(core,zero_target);succ1=jj_cfg_find_block_raw(core,end);if succ0==0{return 0;}if succ1==0{return 0;}if succ0==succ1{return 0;}edges=edges+2;}
    else{if last_op==jj_lang_cir_return(){kind=1;}else{if end<function_end{kind=2;succ0=jj_cfg_find_block_raw(core,end);if succ0==0{return 0;}edges=edges+1;synthetic=synthetic+1;}else{return 0;}}}}
    if jj_cfg_store(core,block_id,0,(start&0xffffffff)|(end<<32))==0{return 0;}if jj_cfg_store(core,block_id,1,(function_id&0xffffff)|(kind<<24)|(last_pc<<32))==0{return 0;}if jj_cfg_store(core,block_id,2,(succ0&0xffffffff)|(succ1<<32))==0{return 0;}if jj_cfg_store(core,block_id,3,0)==0{return 0;}if jj_cfg_store(core,block_id,4,0)==0{return 0;}i=i+1;
  }
  core[96]=edges;core[102]=synthetic;return 1;
}
fn jj_cfg_bind_operands(core:*i64)->i64{
  if jj_cfg_draft(core)==0{return 0;}if jj_operand_tree_valid(core)==0{return 0;}var capacity:i64=jj_operand_tree_capacity(core);var mapped:i64=0;var i:i64=1;
  while i<=capacity{var kind:i64=jj_operand_tree_kind_sealed(core,i);if kind>=jj_lang_operand_return(){if kind<=jj_lang_operand_condition(){var pc:i64=jj_cfg_terminator_pc(core,i);if pc<=0{return 0;}var block:i64=jj_cfg_block_for_pc(core,pc);if block==0{return 0;}var w1:i64=jj_cfg_record(core,block,1);var block_kind:i64=(w1>>>24)&255;var term_pc:i64=(w1>>>32)&0xffffffff;if term_pc!=pc{return 0;}if kind==jj_lang_operand_return(){if block_kind!=1{return 0;}}else{if kind==jj_lang_operand_branch(){if block_kind!=2{return 0;}}else{if block_kind!=3{return 0;}}}var w3:i64=jj_cfg_record(core,block,3);if (w3&0xffffffff)!=0{return 0;}if jj_cfg_store(core,block,3,(w3&0xffffffff00000000)|(i&0xffffffff))==0{return 0;}mapped=mapped+1;}}i=i+1;
  }core[97]=mapped;if mapped!=core[103]{return 0;}return 1;
}
fn jj_cfg_mark_predecessors(core:*i64)->i64{
  if jj_cfg_draft(core)==0{return 0;}var blocks:i64=core[94];var i:i64=1;while i<=blocks{var edges:i64=jj_cfg_record(core,i,2);var s0:i64=edges&0xffffffff;var s1:i64=(edges>>>32)&0xffffffff;if s0>0{var w30:i64=jj_cfg_record(core,s0,3);var p0:i64=(w30>>>32)&0x7fffffff;if p0==0x7fffffff{return 0;}if jj_cfg_store(core,s0,3,(w30&0x80000000ffffffff)|((p0+1)<<32))==0{return 0;}}if s1>0{var w31:i64=jj_cfg_record(core,s1,3);var p1:i64=(w31>>>32)&0x7fffffff;if p1==0x7fffffff{return 0;}if jj_cfg_store(core,s1,3,(w31&0x80000000ffffffff)|((p1+1)<<32))==0{return 0;}}i=i+1;}return 1;
}
fn jj_cfg_mark_reachable(core:*i64)->i64{
  if jj_cfg_draft(core)==0{return 0;}if jj_cfg_scratch_zero(core)==0{return 0;}var blocks:i64=core[94];var functions:i64=core[98];var head:i64=0;var f:i64=0;
  while f<functions{var entry_pc:i64=jj_cfg_function_start(core,f);var entry:i64=jj_cfg_find_block_raw(core,entry_pc);if entry==0{jj_cfg_scratch_clear(core);return 0;}var scratch:i64=jj_cfg_scratch_get(core,entry);if (scratch&0x8000000000000000)==0{if jj_cfg_scratch_set(core,entry,(head<<32)|0x8000000000000000)==0{jj_cfg_scratch_clear(core);return 0;}head=entry;}f=f+1;}
  while head>0{var block:i64=head;var scratch2:i64=jj_cfg_scratch_get(core,block);head=(scratch2>>>32)&0x7fffffff;if jj_cfg_scratch_set(core,block,scratch2&0x80000000ffffffff)==0{jj_cfg_scratch_clear(core);return 0;}var w3:i64=jj_cfg_record(core,block,3);if jj_cfg_store(core,block,3,w3|0x8000000000000000)==0{jj_cfg_scratch_clear(core);return 0;}var edges:i64=jj_cfg_record(core,block,2);var s0:i64=edges&0xffffffff;var s1:i64=(edges>>>32)&0xffffffff;if s0>0{var sw0:i64=jj_cfg_scratch_get(core,s0);if (sw0&0x8000000000000000)==0{if jj_cfg_scratch_set(core,s0,(sw0&0x7fffffff)|(head<<32)|0x8000000000000000)==0{jj_cfg_scratch_clear(core);return 0;}head=s0;}}if s1>0{var sw1:i64=jj_cfg_scratch_get(core,s1);if (sw1&0x8000000000000000)==0{if jj_cfg_scratch_set(core,s1,(sw1&0x7fffffff)|(head<<32)|0x8000000000000000)==0{jj_cfg_scratch_clear(core);return 0;}head=s1;}}}
  var unreachable:i64=0;var i:i64=1;while i<=blocks{if (jj_cfg_record(core,i,3)&0x8000000000000000)==0{unreachable=unreachable+1;}i=i+1;}core[104]=unreachable;if jj_cfg_scratch_clear(core)==0{return 0;}return 1;
}

fn jj_cfg_verify_graph(core:*i64)->i64{
  if jj_cfg_state(core)==0{return 0;}if jj_cfg_scratch_zero(core)==0{return 0;}var blocks:i64=core[94];var i:i64=1;
  while i<=blocks{var edges:i64=jj_cfg_record(core,i,2);var s0:i64=edges&0xffffffff;var s1:i64=(edges>>>32)&0xffffffff;if s0>0{var a:i64=jj_cfg_scratch_get(core,s0);var pa:i64=a&0x7fffffff;if pa==0x7fffffff{jj_cfg_scratch_clear(core);return 0;}if jj_cfg_scratch_set(core,s0,(a&0xffffffff80000000)|(pa+1))==0{jj_cfg_scratch_clear(core);return 0;}}if s1>0{var b:i64=jj_cfg_scratch_get(core,s1);var pb:i64=b&0x7fffffff;if pb==0x7fffffff{jj_cfg_scratch_clear(core);return 0;}if jj_cfg_scratch_set(core,s1,(b&0xffffffff80000000)|(pb+1))==0{jj_cfg_scratch_clear(core);return 0;}}i=i+1;}
  var head:i64=0;var f:i64=0;while f<core[98]{var entry:i64=jj_cfg_find_block_raw(core,jj_cfg_function_start(core,f));if entry==0{jj_cfg_scratch_clear(core);return 0;}var e:i64=jj_cfg_scratch_get(core,entry);if (e&0x8000000000000000)==0{if jj_cfg_scratch_set(core,entry,(e&0x7fffffff)|(head<<32)|0x8000000000000000)==0{jj_cfg_scratch_clear(core);return 0;}head=entry;}f=f+1;}
  while head>0{var block:i64=head;var s:i64=jj_cfg_scratch_get(core,block);head=(s>>>32)&0x7fffffff;if jj_cfg_scratch_set(core,block,(s&0x7fffffff)|0x8000000000000000)==0{jj_cfg_scratch_clear(core);return 0;}var edge_word:i64=jj_cfg_record(core,block,2);var t0:i64=edge_word&0xffffffff;var t1:i64=(edge_word>>>32)&0xffffffff;if t0>0{var q0:i64=jj_cfg_scratch_get(core,t0);if (q0&0x8000000000000000)==0{if jj_cfg_scratch_set(core,t0,(q0&0x7fffffff)|(head<<32)|0x8000000000000000)==0{jj_cfg_scratch_clear(core);return 0;}head=t0;}}if t1>0{var q1:i64=jj_cfg_scratch_get(core,t1);if (q1&0x8000000000000000)==0{if jj_cfg_scratch_set(core,t1,(q1&0x7fffffff)|(head<<32)|0x8000000000000000)==0{jj_cfg_scratch_clear(core);return 0;}head=t1;}}}
  var unreachable:i64=0;i=1;while i<=blocks{var derived:i64=jj_cfg_scratch_get(core,i);var stored:i64=jj_cfg_record(core,i,3);var dp:i64=derived&0x7fffffff;var sp:i64=(stored>>>32)&0x7fffffff;if dp!=sp{jj_cfg_scratch_clear(core);return 0;}var dr:i64=derived&0x8000000000000000;var sr:i64=stored&0x8000000000000000;if dr!=sr{jj_cfg_scratch_clear(core);return 0;}if dr==0{unreachable=unreachable+1;}i=i+1;}if unreachable!=core[104]{jj_cfg_scratch_clear(core);return 0;}if jj_cfg_scratch_clear(core)==0{return 0;}return 1;
}
fn jj_cfg_seal(core:*i64)->i64{if jj_cfg_state(core)==0{return 0;}if jj_cfg_scratch_zero(core)==0{return 0;}var h:i64=(core as i64)^core[93]^core[94]^core[95]^core[96]^core[97]^core[98]^core[99]^core[101]^core[102]^core[103]^core[104]^0x4a4a434647534532;var base:*i64=core[93] as *i64;var i:i64=0;while i<core[95]{h=((h<<11)|(h>>>53))^base[i]^(i*0x9e3779b1);i=i+1;}return h;}
fn jj_cfg_fail(core:*i64,old_capacity:i64)->i64{if core==0{return 0;}var current:i64=core[8];if current>=0{if old_capacity>=current{var base:*i8=(core[7]+current) as *i8;var bytes:i64=old_capacity-current;var i:i64=0;while i<bytes{base[i]=0;i=i+1;}}}core[8]=old_capacity;jj_cfg_clear(core);return 0;}

fn jj_cfg_scan(core:*i64)->i64{
  if jj_cfg_state(core)==0{return 0;}if jj_cfg_scratch_zero(core)==0{return 0;}if jj_semantic_cir_valid(core)==0{return 0;}if jj_operand_tree_valid(core)==0{return 0;}var blocks:i64=core[94];var functions:i64=core[98];if functions!=jj_core_function_count(core){return 0;}var program:*i8=core[7] as *i8;var observed_edges:i64=0;var observed_explicit:i64=0;var observed_synthetic:i64=0;var observed_predecessors:i64=0;var observed_unreachable:i64=0;var previous_end:i64=0;var previous_function:i64=0-1;var i:i64=1;
  while i<=blocks{var range:i64=jj_cfg_record(core,i,0);var start:i64=range&0xffffffff;var end:i64=(range>>>32)&0xffffffff;if end<=start{return 0;}var w1:i64=jj_cfg_record(core,i,1);var function_id:i64=w1&0xffffff;var kind:i64=(w1>>>24)&255;var term_pc:i64=(w1>>>32)&0xffffffff;if function_id>=functions{return 0;}if jj_cfg_function_for_pc(core,start)!=function_id{return 0;}if previous_function<0{if function_id!=0{return 0;}if start!=jj_cfg_function_start(core,0){return 0;}}else{if function_id==previous_function{if start!=previous_end{return 0;}}else{if function_id!=previous_function+1{return 0;}if previous_end!=jj_cfg_function_end(core,previous_function){return 0;}if start!=jj_cfg_function_start(core,function_id){return 0;}}}if end>jj_cfg_function_end(core,function_id){return 0;}if term_pc<start{return 0;}if term_pc>=end{return 0;}var pc:i64=start;var last:i64=0;while pc<end{var size:i64=jj_semantic_cir_length(program,pc,end);if size<=0{return 0;}last=pc;pc=pc+size;}if pc!=end{return 0;}if last!=term_pc{return 0;}var edges:i64=jj_cfg_record(core,i,2);var s0:i64=edges&0xffffffff;var s1:i64=(edges>>>32)&0xffffffff;var w3:i64=jj_cfg_record(core,i,3);var operand:i64=w3&0xffffffff;if operand>0xfffff{return 0;}var predecessors:i64=(w3>>>32)&0x7fffffff;if predecessors>core[96]{return 0;}observed_predecessors=observed_predecessors+predecessors;if (w3&0x8000000000000000)==0{observed_unreachable=observed_unreachable+1;}
    if kind==1{if program[term_pc]!=jj_lang_cir_return(){return 0;}if s0!=0{return 0;}if s1!=0{return 0;}}
    else{if kind==2{if s0<=0{return 0;}if s0>blocks{return 0;}if s1!=0{return 0;}if (jj_cfg_record(core,s0,1)&0xffffff)!=function_id{return 0;}observed_edges=observed_edges+1;if program[term_pc]==jj_lang_cir_jump(){var target:i64=jj_semantic_cir_rd32(program+term_pc+1);if jj_cfg_block_start_raw(core,s0-1)!=target{return 0;}}else{if program[term_pc]==jj_lang_cir_branch_zero(){return 0;}if program[term_pc]==jj_lang_cir_return(){return 0;}if end>=jj_cfg_function_end(core,function_id){return 0;}if term_pc+jj_semantic_cir_length(program,term_pc,end)!=end{return 0;}if jj_cfg_block_start_raw(core,s0-1)!=end{return 0;}if operand!=0{return 0;}observed_synthetic=observed_synthetic+1;}}else{if kind==3{if program[term_pc]!=jj_lang_cir_branch_zero(){return 0;}if s0<=0{return 0;}if s0>blocks{return 0;}if s1<=0{return 0;}if s1>blocks{return 0;}if s0==s1{return 0;}if end>=jj_cfg_function_end(core,function_id){return 0;}if (jj_cfg_record(core,s0,1)&0xffffff)!=function_id{return 0;}if (jj_cfg_record(core,s1,1)&0xffffff)!=function_id{return 0;}var target2:i64=jj_semantic_cir_rd32(program+term_pc+1);if jj_cfg_block_start_raw(core,s0-1)!=target2{return 0;}if jj_cfg_block_start_raw(core,s1-1)!=end{return 0;}observed_edges=observed_edges+2;}else{return 0;}}}
    if operand!=0{var operand_kind:i64=jj_operand_tree_kind_sealed(core,operand);if kind==1{if operand_kind!=jj_lang_operand_return(){return 0;}}if kind==2{if operand_kind!=jj_lang_operand_branch(){return 0;}}if kind==3{if operand_kind!=jj_lang_operand_condition(){return 0;}}if jj_cfg_terminator_pc(core,operand)!=term_pc{return 0;}observed_explicit=observed_explicit+1;}
    previous_end=end;previous_function=function_id;i=i+1;
  }
  if previous_function!=functions-1{return 0;}if previous_end!=jj_cfg_function_end(core,previous_function){return 0;}if observed_edges!=core[96]{return 0;}if observed_predecessors!=observed_edges{return 0;}if observed_explicit!=core[97]{return 0;}if observed_synthetic!=core[102]{return 0;}if observed_explicit!=core[103]{return 0;}if observed_unreachable!=core[104]{return 0;}if jj_cfg_verify_graph(core)==0{return 0;}return blocks;
}
fn jj_cfg_finish(core:*i64,terminator_count:i64)->i64{
  if core==0{return 0;}if terminator_count<=0{return 0;}if jj_cfg_empty(core)==0{return 0;}if jj_semantic_cir_valid(core)==0{return 0;}if jj_typed_node_arena_valid(core)==0{return 0;}if jj_operand_tree_valid(core)==0{return 0;}var candidate_count:i64=jj_cfg_candidate_count(core);if candidate_count<=0{return 0;}if candidate_count>0x03ffffff{return 0;}var old_capacity:i64=core[8];var candidate_bytes:i64=candidate_count*8;if candidate_bytes<=0{return 0;}if old_capacity<65536{return 0;}if candidate_bytes>old_capacity-65536{return 0;}var candidate_capacity:i64=old_capacity-candidate_bytes;if core[9]>candidate_capacity{return 0;}var temp:*i64=(core[7]+candidate_capacity) as *i64;var zero_i:i64=0;while zero_i<candidate_count{temp[zero_i]=0;zero_i=zero_i+1;}core[8]=candidate_capacity;
  if jj_cfg_fill_candidates(core,temp,candidate_count)!=candidate_count{return jj_cfg_fail(core,old_capacity);}if jj_cfg_sort(temp,candidate_count)==0{return jj_cfg_fail(core,old_capacity);}var block_count:i64=jj_cfg_unique(temp,candidate_count);if block_count<=0{return jj_cfg_fail(core,old_capacity);}var top:*i64=(core[7]+old_capacity-block_count*8) as *i64;var move_i:i64=block_count;while move_i>0{move_i=move_i-1;top[move_i]=temp[move_i];}var final_words:i64=block_count*5;var final_bytes:i64=final_words*8;if final_bytes<=0{return jj_cfg_fail(core,old_capacity);}if final_bytes>old_capacity-65536{return jj_cfg_fail(core,old_capacity);}var final_capacity:i64=old_capacity-final_bytes;if core[9]>final_capacity{return jj_cfg_fail(core,old_capacity);}if final_capacity<core[8]{var extra_base:*i8=(core[7]+final_capacity) as *i8;var extra_bytes:i64=core[8]-final_capacity;var extra_i:i64=0;while extra_i<extra_bytes{extra_base[extra_i]=0;extra_i=extra_i+1;}core[8]=final_capacity;}var final_base:*i64=(core[7]+final_capacity) as *i64;var copy_i:i64=0;while copy_i<block_count{var boundary:i64=top[copy_i];final_base[copy_i*5]=boundary;final_base[copy_i*5+1]=0;final_base[copy_i*5+2]=0;final_base[copy_i*5+3]=0;final_base[copy_i*5+4]=0;copy_i=copy_i+1;}if final_capacity>core[8]{var low_bytes:i64=final_capacity-core[8];var low:*i8=(core[7]+core[8]) as *i8;var clear_i:i64=0;while clear_i<low_bytes{low[clear_i]=0;clear_i=clear_i+1;}core[8]=final_capacity;}core[92]=0x4a4a434647445232;core[93]=final_base as i64;core[94]=block_count;core[95]=final_words;core[96]=0;core[97]=0;core[98]=jj_core_function_count(core);core[99]=old_capacity;core[100]=0;core[101]=2;core[102]=0;core[103]=terminator_count;core[104]=0;
  if jj_cfg_draft(core)==0{return jj_cfg_fail(core,old_capacity);}if jj_cfg_build_records(core)==0{return jj_cfg_fail(core,old_capacity);}if jj_cfg_bind_operands(core)==0{return jj_cfg_fail(core,old_capacity);}if jj_cfg_mark_reachable(core)==0{return jj_cfg_fail(core,old_capacity);}if jj_cfg_mark_predecessors(core)==0{return jj_cfg_fail(core,old_capacity);}if jj_cfg_scan(core)!=block_count{return jj_cfg_fail(core,old_capacity);}core[92]=0x4a4a434647464e32;core[100]=jj_cfg_seal(core);if core[100]==0{return jj_cfg_fail(core,old_capacity);}return 1;
}
fn jj_cfg_valid(core:*i64)->i64{if jj_cfg_state(core)==0{return 0;}if core[92]!=0x4a4a434647464e32{return 0;}if jj_cfg_scan(core)!=core[94]{return 0;}if core[100]!=jj_cfg_seal(core){return 0;}return 1;}
fn jj_cfg_release(core:*i64)->i64{if jj_cfg_valid(core)==0{return 0;}var base:*i64=core[93] as *i64;var words:i64=core[95];var old_capacity:i64=core[99];var i:i64=0;while i<words{base[i]=0;i=i+1;}core[8]=old_capacity;return jj_cfg_clear(core);}
fn jj_cfg_version(core:*i64)->i64{if jj_cfg_valid(core)==0{return 0;}return 2;}
fn jj_cfg_block_count(core:*i64)->i64{if jj_cfg_valid(core)==0{return 0;}return core[94];}
fn jj_cfg_edge_count(core:*i64)->i64{if jj_cfg_valid(core)==0{return 0;}return core[96];}
fn jj_cfg_explicit_terminator_count(core:*i64)->i64{if jj_cfg_valid(core)==0{return 0;}return core[97];}
fn jj_cfg_synthetic_branch_count(core:*i64)->i64{if jj_cfg_valid(core)==0{return 0;}return core[102];}
fn jj_cfg_block_start(core:*i64,block_id:i64)->i64{if jj_cfg_valid(core)==0{return 0;}return jj_cfg_record(core,block_id,0)&0xffffffff;}
fn jj_cfg_block_end(core:*i64,block_id:i64)->i64{if jj_cfg_valid(core)==0{return 0;}return (jj_cfg_record(core,block_id,0)>>>32)&0xffffffff;}
fn jj_cfg_block_function(core:*i64,block_id:i64)->i64{if jj_cfg_valid(core)==0{return 0-1;}return jj_cfg_record(core,block_id,1)&0xffffff;}
fn jj_cfg_block_terminator_kind(core:*i64,block_id:i64)->i64{if jj_cfg_valid(core)==0{return 0;}return (jj_cfg_record(core,block_id,1)>>>24)&255;}
fn jj_cfg_block_terminator_pc(core:*i64,block_id:i64)->i64{if jj_cfg_valid(core)==0{return 0;}return (jj_cfg_record(core,block_id,1)>>>32)&0xffffffff;}
fn jj_cfg_block_successor_count(core:*i64,block_id:i64)->i64{if jj_cfg_valid(core)==0{return 0;}var kind:i64=(jj_cfg_record(core,block_id,1)>>>24)&255;if kind==1{return 0;}if kind==2{return 1;}if kind==3{return 2;}return 0;}
fn jj_cfg_block_successor(core:*i64,block_id:i64,ordinal:i64)->i64{if jj_cfg_valid(core)==0{return 0;}if ordinal<0{return 0;}if ordinal>1{return 0;}var edges:i64=jj_cfg_record(core,block_id,2);if ordinal==0{return edges&0xffffffff;}return (edges>>>32)&0xffffffff;}
fn jj_cfg_block_terminator_operand(core:*i64,block_id:i64)->i64{if jj_cfg_valid(core)==0{return 0;}return jj_cfg_record(core,block_id,3)&0xffffffff;}
fn jj_cfg_block_predecessor_count(core:*i64,block_id:i64)->i64{if jj_cfg_valid(core)==0{return 0;}return (jj_cfg_record(core,block_id,3)>>>32)&0x7fffffff;}
fn jj_cfg_block_reachable(core:*i64,block_id:i64)->i64{if jj_cfg_valid(core)==0{return 0;}if (jj_cfg_record(core,block_id,3)&0x8000000000000000)!=0{return 1;}return 0;}
fn jj_cfg_unreachable_block_count(core:*i64)->i64{if jj_cfg_valid(core)==0{return 0;}return core[104];}
// Raw published-view ABI for join construction and the independent verifier.
// These accessors validate only the sealed layout, bounds and version. They do
// not call jj_cfg_scan, jj_cfg_verify_graph or the producer validator.
fn jj_cfg_view_ready(core:*i64)->i64{if jj_cfg_state(core)==0{return 0;}if core[92]!=0x4a4a434647464e32{return 0;}return 1;}
fn jj_cfg_view_version(core:*i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return core[101];}
fn jj_cfg_view_block_count(core:*i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return core[94];}
fn jj_cfg_view_edge_count(core:*i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return core[96];}
fn jj_cfg_view_explicit_terminator_count(core:*i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return core[97];}
fn jj_cfg_view_function_count(core:*i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return core[98];}
fn jj_cfg_view_synthetic_branch_count(core:*i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return core[102];}
fn jj_cfg_view_unreachable_block_count(core:*i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return core[104];}
fn jj_cfg_view_block_start(core:*i64,block_id:i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return jj_cfg_record(core,block_id,0)&0xffffffff;}
fn jj_cfg_view_block_end(core:*i64,block_id:i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return (jj_cfg_record(core,block_id,0)>>>32)&0xffffffff;}
fn jj_cfg_view_block_function(core:*i64,block_id:i64)->i64{if jj_cfg_view_ready(core)==0{return 0-1;}return jj_cfg_record(core,block_id,1)&0xffffff;}
fn jj_cfg_view_block_terminator_kind(core:*i64,block_id:i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return (jj_cfg_record(core,block_id,1)>>>24)&255;}
fn jj_cfg_view_block_terminator_pc(core:*i64,block_id:i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return (jj_cfg_record(core,block_id,1)>>>32)&0xffffffff;}
fn jj_cfg_view_block_successor_count(core:*i64,block_id:i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}var kind:i64=(jj_cfg_record(core,block_id,1)>>>24)&255;if kind==1{return 0;}if kind==2{return 1;}if kind==3{return 2;}return 0;}
fn jj_cfg_view_block_successor(core:*i64,block_id:i64,ordinal:i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}if ordinal<0{return 0;}if ordinal>1{return 0;}var edges:i64=jj_cfg_record(core,block_id,2);if ordinal==0{return edges&0xffffffff;}return (edges>>>32)&0xffffffff;}
fn jj_cfg_view_block_terminator_operand(core:*i64,block_id:i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return jj_cfg_record(core,block_id,3)&0xffffffff;}
fn jj_cfg_view_block_predecessor_count(core:*i64,block_id:i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return (jj_cfg_record(core,block_id,3)>>>32)&0x7fffffff;}
fn jj_cfg_view_block_reachable(core:*i64,block_id:i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}if (jj_cfg_record(core,block_id,3)&0x8000000000000000)!=0{return 1;}return 0;}

fn jj_cfg_view_authority_seal(core:*i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return core[100];}
fn jj_cfg_view_scratch_zero(core:*i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return jj_cfg_scratch_zero(core);}
fn jj_cfg_view_scratch_get(core:*i64,block_id:i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return jj_cfg_scratch_get(core,block_id);}
fn jj_cfg_view_scratch_set(core:*i64,block_id:i64,value:i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return jj_cfg_scratch_set(core,block_id,value);}
fn jj_cfg_view_scratch_clear(core:*i64)->i64{if jj_cfg_view_ready(core)==0{return 0;}return jj_cfg_scratch_clear(core);}
