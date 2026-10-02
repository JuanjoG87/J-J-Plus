// Capacity-indexed Core IR (CIR). Linear v1 and Function/CFG v2 retain their
// semantic versions while storage is supplied by an address-bound view.
// R734 extends the bounded lifetime declarations across forward acyclic CFGs.
// 35 object, 36 address offset, 37 lifetime end. Cross-block object/address
// operands are legal only when their defining block dominates the use block.
fn jj_cir_binary_supported(op:i64)->i64{
  if op==9{return 1;}if op==10{return 1;}if op==11{return 1;}
  if op==16{return 1;}if op==17{return 1;}if op==18{return 1;}return 0;
}
fn jj_cir_memory_supported(op:i64)->i64{if op==32{return 1;}if op==33{return 1;}if op==34{return 1;}return 0;}
fn jj_cir_object_kind(word:i64)->i64{return word&255;}
fn jj_cir_object_flags(word:i64)->i64{return (word>>>8)&31;}
fn jj_cir_object_storage(word:i64)->i64{return (word>>>16)&0x7fffffff;}
fn jj_cir_object_word_valid(word:i64)->i64{
 if word<=0{return 0;}if (word>>>47)!=0{return 0;}var kind:i64=jj_cir_object_kind(word);var flags:i64=jj_cir_object_flags(word);var storage:i64=jj_cir_object_storage(word);if kind<1{return 0;}if kind>4{return 0;}if storage<=0{return 0;}if kind==1{if flags!=24{return 0;}}if kind==2{if flags!=24{return 0;}}if kind==3{if flags!=2{return 0;}}if kind==4{if flags!=2{return 0;}}return 1;
}
fn jj_cir_object_word(kind:i64,storage:i64)->i64{
 if kind<1{return 0;}if kind>4{return 0;}if storage<=0{return 0;}if storage>0x7fffffff{return 0;}var flags:i64=2;if kind==1{flags=24;}if kind==2{flags=24;}var word:i64=kind|(flags<<8)|(storage<<16);if jj_cir_object_word_valid(word)==0{return 0;}return word;
}
fn jj_cir_function_node_inputs_valid(op:i64,a:i64,b:i64,dst:i64,argc:i64)->i64{
 if op==1{if a<0{return 0;}if a>=argc{return 0;}if b!=0{return 0;}return 1;}if op==2{if a!=0{return 0;}return 1;}
 if op==3{if a<=0{return 0;}if a>=dst{return 0;}if b<=0{return 0;}if b>0x7fffffff{return 0;}return 1;}
 if op==32{if a<=0{return 0;}if a>=dst{return 0;}if b!=0{return 0;}return 1;}if op==33{if a<=0{return 0;}if b<=0{return 0;}if a>=dst{return 0;}if b>=dst{return 0;}return 1;}
 if op==34{if a<1{return 0;}if a>3{return 0;}if b!=0{return 0;}return 1;}
 if op==35{if jj_cir_object_word_valid(a)==0{return 0;}if b<=0{return 0;}if b>0x7fffffff{return 0;}return 1;}
 if op==36{if a<=0{return 0;}if a>=dst{return 0;}if b<0{return 0;}if b>0x7fffffff{return 0;}return 1;}
 if op==37{if a<=0{return 0;}if a>=dst{return 0;}if b!=0{return 0;}return 1;}
 if jj_cir_binary_supported(op)==0{return 0;}if a<=0{return 0;}if b<=0{return 0;}if a>=dst{return 0;}if b>=dst{return 0;}return 1;
}
fn jj_cir_function_value_node(cir:*i64,node_base:i64,node:i64)->i64{if cir==0{return 0;}if node<=0{return 0;}var op:i64=cir[node_base+(node-1)*4];if op==33{return 0;}if op==34{return 0;}if op==37{return 0;}return 1;}
fn jj_cir_function_node_block_raw(cir:*i64,node:i64)->i64{if cir==0{return 0;}if node<=0{return 0;}if node>cir[3]{return 0;}var block:i64=1;while block<=cir[2]{var bb:i64=12+(block-1)*6;var first:i64=cir[bb];var count:i64=cir[bb+1];if node>=first{if node<first+count{return block;}}block=block+1;}return 0;}
fn jj_cir_function_successor_raw(cir:*i64,block:i64,index:i64)->i64{if cir==0{return 0;}if block<=0{return 0;}if block>cir[2]{return 0;}if index<0{return 0;}if index>1{return 0;}var bb:i64=12+(block-1)*6;var term:i64=cir[bb+2];if term==2{if index!=0{return 0;}return cir[bb+4]+1;}if term==3{if index==0{return cir[bb+4]+1;}return cir[bb+5]+1;}return 0;}
fn jj_cir_bitset_words(blocks:i64)->i64{if blocks<=0{return 0;}return (blocks+63)/64;}
fn jj_cir_bitset_zero(bits:*i64,words:i64)->i64{if bits==0{return 0;}if words<=0{return 0;}if words>64{return 0;}var i:i64=0;while i<words{bits[i]=0;i=i+1;}return 1;}
fn jj_cir_bitset_has(bits:*i64,block:i64)->i64{if bits==0{return 0;}if block<=0{return 0;}var z:i64=block-1;var word:i64=z>>>6;var bit:i64=z&63;if word<0{return 0;}if word>=64{return 0;}if (bits[word]&(1<<bit))!=0{return 1;}return 0;}
fn jj_cir_bitset_add(bits:*i64,block:i64)->i64{if bits==0{return 0;}if block<=0{return 0;}var z:i64=block-1;var word:i64=z>>>6;var bit:i64=z&63;if word<0{return 0;}if word>=64{return 0;}var mask:i64=1<<bit;if (bits[word]&mask)!=0{return 0;}bits[word]=bits[word]|mask;return 1;}
fn jj_cir_function_block_reaches_raw(cir:*i64,from:i64,to:i64)->i64{
 if cir==0{return 0;}if from<=0{return 0;}if to<=0{return 0;}if from>cir[2]{return 0;}if to>cir[2]{return 0;}var words:i64=jj_cir_bitset_words(cir[2]);if words<=0{return 0;}if words>64{return 0;}var seen:[64]i64;if jj_cir_bitset_zero(seen as *i64,words)==0{return 0;}if jj_cir_bitset_add(seen as *i64,from)==0{return 0;}var pass:i64=0;var changed:i64=1;while changed!=0{if pass>=cir[2]{return 0;}changed=0;var block:i64=1;while block<=cir[2]{if jj_cir_bitset_has(seen as *i64,block)!=0{var si:i64=0;while si<2{var target:i64=jj_cir_function_successor_raw(cir,block,si);if target>0{if jj_cir_bitset_add(seen as *i64,target)!=0{changed=1;}}si=si+1;}}block=block+1;}pass=pass+1;}return jj_cir_bitset_has(seen as *i64,to);
}
fn jj_cir_function_block_reaches_avoiding_raw(cir:*i64,from:i64,to:i64,avoid:i64)->i64{
 if cir==0{return 0;}if from<=0{return 0;}if to<=0{return 0;}if avoid<=0{return 0;}if from>cir[2]{return 0;}if to>cir[2]{return 0;}if avoid>cir[2]{return 0;}if from==avoid{return 0;}if to==avoid{return 0;}var words:i64=jj_cir_bitset_words(cir[2]);if words<=0{return 0;}if words>64{return 0;}var seen:[64]i64;if jj_cir_bitset_zero(seen as *i64,words)==0{return 0;}if jj_cir_bitset_add(seen as *i64,from)==0{return 0;}var pass:i64=0;var changed:i64=1;while changed!=0{if pass>=cir[2]{return 0;}changed=0;var block:i64=1;while block<=cir[2]{if block!=avoid{if jj_cir_bitset_has(seen as *i64,block)!=0{var si:i64=0;while si<2{var target:i64=jj_cir_function_successor_raw(cir,block,si);if target>0{if target!=avoid{if jj_cir_bitset_add(seen as *i64,target)!=0{changed=1;}}}si=si+1;}}}block=block+1;}pass=pass+1;}return jj_cir_bitset_has(seen as *i64,to);
}
fn jj_cir_function_block_dominates_raw(cir:*i64,dom:i64,use_block:i64)->i64{
 if cir==0{return 0;}if dom<=0{return 0;}if use_block<=0{return 0;}if dom>cir[2]{return 0;}if use_block>cir[2]{return 0;}if dom==use_block{return 1;}if jj_cir_function_block_reaches_raw(cir,1,use_block)==0{return 0;}if dom==1{return 1;}if jj_cir_function_block_reaches_avoiding_raw(cir,1,use_block,dom)!=0{return 0;}return 1;
}
fn jj_cir_function_node_dominates_raw(cir:*i64,def_node:i64,use_node:i64)->i64{if cir==0{return 0;}if def_node<=0{return 0;}if use_node<=0{return 0;}if def_node>=use_node{return 0;}var db:i64=jj_cir_function_node_block_raw(cir,def_node);var ub:i64=jj_cir_function_node_block_raw(cir,use_node);if db==0{return 0;}if ub==0{return 0;}if db==ub{return 1;}return jj_cir_function_block_dominates_raw(cir,db,ub);}
fn jj_cir_function_operand_visible_at(cir:*i64,node_base:i64,first_value:i64,value:i64,operand:i64,use_block:i64)->i64{
 if cir==0{return 0;}if use_block<=0{return 0;}if use_block>cir[2]{return 0;}if operand<=0{return 0;}if operand<first_value{if jj_cir_function_value_node(cir,node_base,operand)==0{return 0;}var def_block:i64=jj_cir_function_node_block_raw(cir,operand);if def_block==0{return 0;}return jj_cir_function_block_dominates_raw(cir,def_block,use_block);}if operand>=value{return 0;}return jj_cir_function_value_node(cir,node_base,operand);
}
fn jj_cir_function_operand_visible(cir:*i64,node_base:i64,first_value:i64,value:i64,operand:i64)->i64{
 var use_block:i64=cir[10];if use_block==0{use_block=jj_cir_function_node_block_raw(cir,value);}if use_block==0{return 0;}return jj_cir_function_operand_visible_at(cir,node_base,first_value,value,operand,use_block);
}
fn jj_cir_function_operands_visible(cir:*i64,first_value:i64,dst:i64,op:i64,a:i64,b:i64)->i64{
 var node_base:i64=cir[11];if op==3{return jj_cir_function_operand_visible(cir,node_base,first_value,dst,a);}
 if op==32{return jj_cir_function_operand_visible(cir,node_base,first_value,dst,a);}
 if op==33{if jj_cir_function_operand_visible(cir,node_base,first_value,dst,a)==0{return 0;}return jj_cir_function_operand_visible(cir,node_base,first_value,dst,b);}
 if op==36{return jj_cir_function_operand_visible(cir,node_base,first_value,dst,a);}
 if op==37{return jj_cir_function_operand_visible(cir,node_base,first_value,dst,a);}
 if jj_cir_binary_supported(op)!=0{if jj_cir_function_operand_visible(cir,node_base,first_value,dst,a)==0{return 0;}return jj_cir_function_operand_visible(cir,node_base,first_value,dst,b);}return 1;
}

fn jj_cir_slots_valid(slots:i64)->i64{
  if slots<12{return 0;}if slots>65536{return 0;}return 1;
}

fn jj_cir_view_valid(view:*i64)->i64{
  if view==0{return 0;}if view[0]==0{return 0;}if jj_cir_slots_valid(view[1])==0{return 0;}
  if (view[0]&7)!=0{return 0;}if view[3]!=0{return 0;}
  var seal:i64=(view as i64)^view[0]^view[1]^0x4a4a434952564945;
  if view[2]!=seal{return 0;}return 1;
}

fn jj_cir_view_bind(view:*i64,cir:*i64,slots:i64)->i64{
  if view==0{return 0;}if cir==0{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}
  if ((cir as i64)&7)!=0{return 0;}view[0]=cir as i64;view[1]=slots;view[3]=0;
  view[2]=(view as i64)^view[0]^view[1]^0x4a4a434952564945;return jj_cir_view_valid(view);
}

fn jj_cir_function_block_capacity(slots:i64)->i64{
  if slots<64{return 0;}var blocks:i64=(slots-12)/16;if blocks<4{blocks=4;}
  while blocks>0{var node_base:i64=12+blocks*6;if node_base+4<=slots{return blocks;}blocks=blocks-1;}return 0;
}

fn jj_cir_function_node_base(slots:i64)->i64{
  var blocks:i64=jj_cir_function_block_capacity(slots);if blocks==0{return 0;}return 12+blocks*6;
}

fn jj_cir_function_node_capacity(slots:i64)->i64{
  var base:i64=jj_cir_function_node_base(slots);if base==0{return 0;}return (slots-base)/4;
}

fn jj_cir_seal_compute(cir:*i64,slots:i64)->i64{
  if cir==0{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}var count:i64=cir[2];var used:i64=0;
  if cir[1]==1{if count<0{return 0;}if count>(slots-8)/4{return 0;}used=8+count*4;}
  else{if cir[1]==2{if slots<64{return 0;}used=slots;}else{return 0;}}
  var h:i64=0x4349525f5345414c;var i:i64=0;
  while i<used{if i!=7{h=((h<<5)|(h>>>59))^cir[i]^(i*0x9e37);}i=i+1;}return h;
}

fn jj_cir_abort(cir:*i64,slots:i64)->i64{
  if cir==0{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}var i:i64=0;while i<slots{cir[i]=0;i=i+1;}return 1;
}

fn jj_cir_build_fail(cir:*i64,slots:i64)->i64{
  if cir==0{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}jj_cir_abort(cir,slots);return 0;
}

fn jj_cir_begin(cir:*i64,slots:i64,argc:i64,return_type:i64)->i64{
  if cir==0{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if jj_cir_abort(cir,slots)==0{return 0;}
  if argc<0{return 0;}if argc>1{return 0;}if return_type!=1{return 0;}
  cir[0]=0x4a4a434952303031;cir[1]=1;cir[4]=argc;cir[5]=return_type;return 1;
}

fn jj_cir_add_node(cir:*i64,slots:i64,op:i64,a:i64,b:i64)->i64{
  if cir==0{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return jj_cir_build_fail(cir,slots);}
  if cir[1]!=1{return jj_cir_build_fail(cir,slots);}if cir[7]!=0{return jj_cir_build_fail(cir,slots);}var count:i64=cir[2];
  if count<0{return jj_cir_build_fail(cir,slots);}if count>=(slots-8)/4{return jj_cir_build_fail(cir,slots);}var dst:i64=count+1;var base:i64=8+count*4;
  cir[base]=op;cir[base+1]=dst;cir[base+2]=a;cir[base+3]=b;cir[2]=dst;cir[3]=dst;return dst;
}

fn jj_cir_add_argument(cir:*i64,slots:i64,arg_index:i64)->i64{
  if cir==0{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return jj_cir_build_fail(cir,slots);}
  if cir[1]!=1{return jj_cir_build_fail(cir,slots);}if cir[7]!=0{return jj_cir_build_fail(cir,slots);}
  if arg_index<0{return jj_cir_build_fail(cir,slots);}if arg_index>=cir[4]{return jj_cir_build_fail(cir,slots);}
  return jj_cir_add_node(cir,slots,1,arg_index,0);
}

fn jj_cir_add_constant(cir:*i64,slots:i64,value:i64)->i64{
  if cir==0{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}return jj_cir_add_node(cir,slots,2,0,value);
}

fn jj_cir_add_binary(cir:*i64,slots:i64,op:i64,lhs:i64,rhs:i64)->i64{
  if cir==0{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if jj_cir_binary_supported(op)==0{return jj_cir_build_fail(cir,slots);}
  if cir[0]!=0x4a4a434952303031{return jj_cir_build_fail(cir,slots);}if cir[1]!=1{return jj_cir_build_fail(cir,slots);}if cir[7]!=0{return jj_cir_build_fail(cir,slots);}
  if lhs<=0{return jj_cir_build_fail(cir,slots);}if rhs<=0{return jj_cir_build_fail(cir,slots);}
  if lhs>cir[3]{return jj_cir_build_fail(cir,slots);}if rhs>cir[3]{return jj_cir_build_fail(cir,slots);}
  return jj_cir_add_node(cir,slots,op,lhs,rhs);
}

fn jj_cir_function_begin(cir:*i64,slots:i64,argc:i64,return_type:i64)->i64{
  if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if jj_cir_abort(cir,slots)==0{return 0;}
  if argc<0{return 0;}if argc>1{return 0;}if return_type!=1{return 0;}
  var block_capacity:i64=jj_cir_function_block_capacity(slots);var node_base:i64=jj_cir_function_node_base(slots);var node_capacity:i64=jj_cir_function_node_capacity(slots);
  if block_capacity<4{return 0;}if node_base<=12{return 0;}if node_capacity<7{return 0;}
  cir[0]=0x4a4a434952303031;cir[1]=2;cir[4]=argc;cir[5]=return_type;
  cir[6]=0;cir[8]=block_capacity;cir[9]=node_capacity;cir[10]=0;cir[11]=node_base;return 1;
}

fn jj_cir_function_add_block(cir:*i64,slots:i64)->i64{
  if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return jj_cir_build_fail(cir,slots);}
  if cir[1]!=2{return jj_cir_build_fail(cir,slots);}if cir[7]!=0{return jj_cir_build_fail(cir,slots);}if cir[3]!=0{return jj_cir_build_fail(cir,slots);}
  if cir[8]!=jj_cir_function_block_capacity(slots){return jj_cir_build_fail(cir,slots);}if cir[11]!=jj_cir_function_node_base(slots){return jj_cir_build_fail(cir,slots);}
  var count:i64=cir[2];if count<0{return jj_cir_build_fail(cir,slots);}if count>=cir[8]{return jj_cir_build_fail(cir,slots);}
  var base:i64=12+count*6;var i:i64=0;while i<6{cir[base+i]=0;i=i+1;}cir[2]=count+1;return count+1;
}

fn jj_cir_function_add_node(cir:*i64,slots:i64,block:i64,op:i64,a:i64,b:i64)->i64{
  if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return jj_cir_build_fail(cir,slots);}
  if cir[1]!=2{return jj_cir_build_fail(cir,slots);}if cir[7]!=0{return jj_cir_build_fail(cir,slots);}
  if cir[8]!=jj_cir_function_block_capacity(slots){return jj_cir_build_fail(cir,slots);}if cir[9]!=jj_cir_function_node_capacity(slots){return jj_cir_build_fail(cir,slots);}if cir[11]!=jj_cir_function_node_base(slots){return jj_cir_build_fail(cir,slots);}
  if block<=0{return jj_cir_build_fail(cir,slots);}if block>cir[2]{return jj_cir_build_fail(cir,slots);}
  var current:i64=cir[10];if current==0{if block!=1{return jj_cir_build_fail(cir,slots);}cir[10]=1;current=1;}
  if block<current{return jj_cir_build_fail(cir,slots);}if block>current{if block!=current+1{return jj_cir_build_fail(cir,slots);}var previous:i64=12+(current-1)*6;if cir[previous+2]==0{return jj_cir_build_fail(cir,slots);}cir[10]=block;current=block;}
  var bb:i64=12+(block-1)*6;if cir[bb+2]!=0{return jj_cir_build_fail(cir,slots);}var count:i64=cir[3];
  if count<0{return jj_cir_build_fail(cir,slots);}if count>=cir[9]{return jj_cir_build_fail(cir,slots);}var dst:i64=count+1;
  if jj_cir_function_node_inputs_valid(op,a,b,dst,cir[4])==0{return jj_cir_build_fail(cir,slots);}
  var first_value:i64=cir[bb];if first_value==0{first_value=dst;}if jj_cir_function_operands_visible(cir,first_value,dst,op,a,b)==0{return jj_cir_build_fail(cir,slots);}
  var nb:i64=cir[11]+count*4;cir[nb]=op;cir[nb+1]=dst;cir[nb+2]=a;cir[nb+3]=b;
  if cir[bb]==0{cir[bb]=dst;}cir[bb+1]=cir[bb+1]+1;cir[3]=dst;return dst;
}


fn jj_cir_function_add_call(cir:*i64,slots:i64,block:i64,argument:i64,target_id:i64,signature:i64)->i64{
  if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}
  if signature!=0x12177{return jj_cir_build_fail(cir,slots);}return jj_cir_function_add_node(cir,slots,block,3,argument,target_id);
}
fn jj_cir_function_add_load(cir:*i64,slots:i64,block:i64,address:i64)->i64{return jj_cir_function_add_node(cir,slots,block,32,address,0);}
fn jj_cir_function_add_store(cir:*i64,slots:i64,block:i64,address:i64,value:i64)->i64{return jj_cir_function_add_node(cir,slots,block,33,address,value);}
fn jj_cir_function_add_fence(cir:*i64,slots:i64,block:i64,ordering:i64)->i64{return jj_cir_function_add_node(cir,slots,block,34,ordering,0);}
fn jj_cir_function_add_object(cir:*i64,slots:i64,block:i64,kind:i64,storage:i64,size:i64)->i64{var word:i64=jj_cir_object_word(kind,storage);if word==0{return jj_cir_build_fail(cir,slots);}return jj_cir_function_add_node(cir,slots,block,35,word,size);}
fn jj_cir_function_add_address_offset(cir:*i64,slots:i64,block:i64,base:i64,offset:i64)->i64{return jj_cir_function_add_node(cir,slots,block,36,base,offset);}
fn jj_cir_function_add_lifetime_end(cir:*i64,slots:i64,block:i64,object_node:i64)->i64{return jj_cir_function_add_node(cir,slots,block,37,object_node,0);}

fn jj_cir_function_set_return(cir:*i64,slots:i64,block:i64,value:i64)->i64{
  if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return jj_cir_build_fail(cir,slots);}
  if cir[1]!=2{return jj_cir_build_fail(cir,slots);}if cir[7]!=0{return jj_cir_build_fail(cir,slots);}
  if block<=0{return jj_cir_build_fail(cir,slots);}if block>cir[2]{return jj_cir_build_fail(cir,slots);}if value<=0{return jj_cir_build_fail(cir,slots);}if value>cir[3]{return jj_cir_build_fail(cir,slots);}
  var bb:i64=12+(block-1)*6;if cir[bb+1]<=0{return jj_cir_build_fail(cir,slots);}if cir[bb+2]!=0{return jj_cir_build_fail(cir,slots);}var first_value:i64=cir[bb];if jj_cir_function_operand_visible_at(cir,cir[11],first_value,cir[3]+1,value,block)==0{return jj_cir_build_fail(cir,slots);}cir[bb+2]=1;cir[bb+3]=value;return 1;
}


fn jj_cir_function_set_call_return(cir:*i64,slots:i64,block:i64,argument:i64,target_id:i64,signature:i64)->i64{
  if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return jj_cir_build_fail(cir,slots);}
  if cir[1]!=2{return jj_cir_build_fail(cir,slots);}if cir[7]!=0{return jj_cir_build_fail(cir,slots);}
  if block<=0{return jj_cir_build_fail(cir,slots);}if block>cir[2]{return jj_cir_build_fail(cir,slots);}if argument<=0{return jj_cir_build_fail(cir,slots);}if argument>cir[3]{return jj_cir_build_fail(cir,slots);}
  if target_id<=0{return jj_cir_build_fail(cir,slots);}if target_id>0x7fffffff{return jj_cir_build_fail(cir,slots);}if signature<=0{return jj_cir_build_fail(cir,slots);}
  var bb:i64=12+(block-1)*6;if cir[bb+1]<=0{return jj_cir_build_fail(cir,slots);}if cir[bb+2]!=0{return jj_cir_build_fail(cir,slots);}var first_value:i64=cir[bb];if jj_cir_function_operand_visible_at(cir,cir[11],first_value,cir[3]+1,argument,block)==0{return jj_cir_build_fail(cir,slots);}
  cir[bb+2]=4;cir[bb+3]=argument;cir[bb+4]=target_id;cir[bb+5]=signature;return 1;
}

fn jj_cir_function_set_jump(cir:*i64,slots:i64,block:i64,target:i64)->i64{
  if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return jj_cir_build_fail(cir,slots);}
  if cir[1]!=2{return jj_cir_build_fail(cir,slots);}if cir[7]!=0{return jj_cir_build_fail(cir,slots);}if block<=0{return jj_cir_build_fail(cir,slots);}if block>cir[2]{return jj_cir_build_fail(cir,slots);}
  if target<=block{return jj_cir_build_fail(cir,slots);}if target>cir[2]{return jj_cir_build_fail(cir,slots);}var bb:i64=12+(block-1)*6;if cir[bb+1]<=0{return jj_cir_build_fail(cir,slots);}if cir[bb+2]!=0{return jj_cir_build_fail(cir,slots);}
  cir[bb+2]=2;cir[bb+3]=0;cir[bb+4]=target-1;cir[bb+5]=0;return 1;
}
fn jj_cir_function_set_backedge(cir:*i64,slots:i64,block:i64,target:i64)->i64{
 if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return jj_cir_build_fail(cir,slots);}if cir[1]!=2{return jj_cir_build_fail(cir,slots);}if cir[7]!=0{return jj_cir_build_fail(cir,slots);}if block<=1{return jj_cir_build_fail(cir,slots);}if block>cir[2]{return jj_cir_build_fail(cir,slots);}if target<=1{return jj_cir_build_fail(cir,slots);}if target>=block{return jj_cir_build_fail(cir,slots);}var bb:i64=12+(block-1)*6;if cir[bb+1]<=0{return jj_cir_build_fail(cir,slots);}if cir[bb+2]!=0{return jj_cir_build_fail(cir,slots);}cir[bb+2]=2;cir[bb+3]=0;cir[bb+4]=target-1;cir[bb+5]=0;cir[6]=1;return 1;
}

fn jj_cir_function_set_branch_zero(cir:*i64,slots:i64,block:i64,condition:i64,zero_target:i64,nonzero_target:i64)->i64{
  if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return jj_cir_build_fail(cir,slots);}
  if cir[1]!=2{return jj_cir_build_fail(cir,slots);}if cir[7]!=0{return jj_cir_build_fail(cir,slots);}
  if block<=0{return jj_cir_build_fail(cir,slots);}if block>cir[2]{return jj_cir_build_fail(cir,slots);}if condition<=0{return jj_cir_build_fail(cir,slots);}if condition>cir[3]{return jj_cir_build_fail(cir,slots);}
  if zero_target<=block{return jj_cir_build_fail(cir,slots);}if zero_target>cir[2]{return jj_cir_build_fail(cir,slots);}if nonzero_target<=block{return jj_cir_build_fail(cir,slots);}if nonzero_target>cir[2]{return jj_cir_build_fail(cir,slots);}if zero_target==nonzero_target{return jj_cir_build_fail(cir,slots);}
  var bb:i64=12+(block-1)*6;if cir[bb+1]<=0{return jj_cir_build_fail(cir,slots);}if cir[bb+2]!=0{return jj_cir_build_fail(cir,slots);}var first_value:i64=cir[bb];if jj_cir_function_operand_visible_at(cir,cir[11],first_value,cir[3]+1,condition,block)==0{return jj_cir_build_fail(cir,slots);}cir[bb+2]=3;cir[bb+3]=condition;cir[bb+4]=zero_target-1;cir[bb+5]=nonzero_target-1;return 1;
}

fn jj_cir_function_validate(cir:*i64,slots:i64)->i64{
  if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return 0;}if cir[1]!=2{return 0;}
  var block_capacity:i64=jj_cir_function_block_capacity(slots);var node_capacity:i64=jj_cir_function_node_capacity(slots);var node_base:i64=jj_cir_function_node_base(slots);
  if cir[8]!=block_capacity{return 0;}if cir[9]!=node_capacity{return 0;}if cir[11]!=node_base{return 0;}
  var blocks:i64=cir[2];var nodes:i64=cir[3];if blocks<=0{return 0;}if blocks>block_capacity{return 0;}if nodes<=0{return 0;}if nodes>node_capacity{return 0;}
  if cir[4]<0{return 0;}if cir[4]>1{return 0;}if cir[5]!=1{return 0;}if cir[6]<0{return 0;}if cir[6]>1{return 0;}if cir[10]!=0{return 0;}
  var expected:i64=1;var bi:i64=0;
  while bi<block_capacity{var bb:i64=12+bi*6;if bi<blocks{var first:i64=cir[bb];var count:i64=cir[bb+1];var term:i64=cir[bb+2];if count<=0{return 0;}if first!=expected{return 0;}expected=expected+count;
      if term==1{if cir[bb+3]<=0{return 0;}if cir[bb+3]>nodes{return 0;}if jj_cir_function_operand_visible_at(cir,node_base,first,first+count,cir[bb+3],bi+1)==0{return 0;}if cir[bb+4]!=0{return 0;}if cir[bb+5]!=0{return 0;}}
      else{if term==2{if cir[bb+3]!=0{return 0;}if cir[bb+4]<1{return 0;}if cir[bb+4]>=blocks{return 0;}if cir[bb+4]==bi{return 0;}if cir[bb+5]!=0{return 0;}}
      else{if term==3{if cir[bb+3]<=0{return 0;}if cir[bb+3]>nodes{return 0;}if jj_cir_function_operand_visible_at(cir,node_base,first,first+count,cir[bb+3],bi+1)==0{return 0;}if cir[bb+4]<1{return 0;}if cir[bb+4]>=blocks{return 0;}if cir[bb+5]<1{return 0;}if cir[bb+5]>=blocks{return 0;}if cir[bb+4]==bi{return 0;}if cir[bb+5]==bi{return 0;}if cir[bb+4]==cir[bb+5]{return 0;}}
      else{if term==4{if cir[bb+3]<=0{return 0;}if cir[bb+3]>nodes{return 0;}if jj_cir_function_operand_visible_at(cir,node_base,first,first+count,cir[bb+3],bi+1)==0{return 0;}if cir[bb+4]<=0{return 0;}if cir[bb+4]>0x7fffffff{return 0;}if cir[bb+5]<=0{return 0;}}
      else{return 0;}}}}}
    else{var zi:i64=0;while zi<6{if cir[bb+zi]!=0{return 0;}zi=zi+1;}}bi=bi+1;}
  if expected!=nodes+1{return 0;}var ni:i64=0;
  while ni<node_capacity{var nb:i64=node_base+ni*4;if ni<nodes{var op:i64=cir[nb];var dst:i64=cir[nb+1];var a:i64=cir[nb+2];var b:i64=cir[nb+3];if dst!=ni+1{return 0;}
      if jj_cir_function_node_inputs_valid(op,a,b,dst,cir[4])==0{return 0;}}
    else{var zj:i64=0;while zj<4{if cir[nb+zj]!=0{return 0;}zj=zj+1;}}ni=ni+1;}
  bi=0;while bi<blocks{var ob:i64=12+bi*6;var first_value:i64=cir[ob];var value_end:i64=first_value+cir[ob+1];var terminator:i64=cir[ob+2];
    var value:i64=first_value;while value<value_end{var vb:i64=node_base+(value-1)*4;var vop:i64=cir[vb];if vop==1{if bi!=0{return 0;}}
      if vop==3{if jj_cir_function_operand_visible(cir,node_base,first_value,value,cir[vb+2])==0{return 0;}}
      if vop==32{if jj_cir_function_operand_visible(cir,node_base,first_value,value,cir[vb+2])==0{return 0;}}
      if vop==33{if jj_cir_function_operand_visible(cir,node_base,first_value,value,cir[vb+2])==0{return 0;}if jj_cir_function_operand_visible(cir,node_base,first_value,value,cir[vb+3])==0{return 0;}}
      if vop==36{if jj_cir_function_operand_visible(cir,node_base,first_value,value,cir[vb+2])==0{return 0;}}
      if vop==37{if jj_cir_function_operand_visible(cir,node_base,first_value,value,cir[vb+2])==0{return 0;}var object_base:i64=node_base+(cir[vb+2]-1)*4;if cir[object_base]!=35{return 0;}}
      if jj_cir_binary_supported(vop)!=0{if jj_cir_function_operand_visible(cir,node_base,first_value,value,cir[vb+2])==0{return 0;}if jj_cir_function_operand_visible(cir,node_base,first_value,value,cir[vb+3])==0{return 0;}}value=value+1;}bi=bi+1;}
  var backedges:i64=0;bi=0;while bi<blocks{var fb:i64=12+bi*6;var ft:i64=cir[fb+2];var si:i64=0;while si<2{var target:i64=0;if ft==2{if si==0{target=cir[fb+4]+1;}}if ft==3{if si==0{target=cir[fb+4]+1;}else{target=cir[fb+5]+1;}}if target>0{if target<=bi+1{if ft!=2{return 0;}if si!=0{return 0;}backedges=backedges+1;if target<=1{return 0;}if jj_cir_function_block_dominates_raw(cir,target,bi+1)==0{return 0;}}}si=si+1;}bi=bi+1;}if cir[6]==0{if backedges!=0{return 0;}}else{if backedges<=0{return 0;}}
  bi=2;while bi<=blocks{if jj_cir_function_block_reaches_raw(cir,1,bi)==0{return 0;}bi=bi+1;}
  var seal:i64=cir[7];if seal==0{return 0;}if seal!=jj_cir_seal_compute(cir,slots){return 0;}return 1;
}

fn jj_cir_function_finish(cir:*i64,slots:i64)->i64{
  if cir==0{return 0;}if slots<64{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[1]!=2{return 0;}if cir[7]!=0{return 0;}
  var blocks:i64=cir[2];if blocks<=0{jj_cir_abort(cir,slots);return 0;}var bi:i64=0;while bi<blocks{if cir[12+bi*6+2]==0{jj_cir_abort(cir,slots);return 0;}bi=bi+1;}
  cir[10]=0;cir[7]=jj_cir_seal_compute(cir,slots);if cir[7]!=0{if jj_cir_function_validate(cir,slots)!=0{return 1;}}jj_cir_abort(cir,slots);return 0;
}

fn jj_cir_function_node_block(cir:*i64,slots:i64,node:i64)->i64{if jj_cir_function_validate(cir,slots)==0{return 0;}return jj_cir_function_node_block_raw(cir,node);}
fn jj_cir_function_block_reaches(cir:*i64,slots:i64,from:i64,to:i64)->i64{if jj_cir_function_validate(cir,slots)==0{return 0;}return jj_cir_function_block_reaches_raw(cir,from,to);}
fn jj_cir_function_block_dominates(cir:*i64,slots:i64,dom:i64,use:i64)->i64{if jj_cir_function_validate(cir,slots)==0{return 0;}return jj_cir_function_block_dominates_raw(cir,dom,use);}
fn jj_cir_function_node_dominates(cir:*i64,slots:i64,def_node:i64,use_node:i64)->i64{if jj_cir_function_validate(cir,slots)==0{return 0;}return jj_cir_function_node_dominates_raw(cir,def_node,use_node);}

fn jj_cir_function_backedge_count(cir:*i64,slots:i64)->i64{if jj_cir_function_validate(cir,slots)==0{return 0;}var count:i64=0;var block:i64=1;while block<=cir[2]{var bb:i64=12+(block-1)*6;var term:i64=cir[bb+2];if term==2{var target:i64=cir[bb+4]+1;if target<block{count=count+1;}}block=block+1;}return count;}
fn jj_cir_function_has_backedge(cir:*i64,slots:i64,from:i64,to:i64)->i64{if jj_cir_function_validate(cir,slots)==0{return 0;}if from<=1{return 0;}if from>cir[2]{return 0;}if to<=1{return 0;}if to>=from{return 0;}var bb:i64=12+(from-1)*6;if cir[bb+2]!=2{return 0;}if cir[bb+4]+1==to{return 1;}return 0;}
fn jj_cir_loop_cfg_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<12{return 0;}out[0]=64;out[1]=1;out[2]=1;out[3]=1;out[4]=1;out[5]=0;out[6]=1;out[7]=1;out[8]=0;out[9]=0;out[10]=0;out[11]=0;return 1;}
fn jj_cir_function_kind(cir:*i64,slots:i64)->i64{
  if jj_cir_function_validate(cir,slots)==0{return 0;}if cir[2]!=3{return 0;}if cir[3]!=3{return 0;}if cir[4]!=1{return 0;}
  var b0:i64=12;var b1:i64=18;var b2:i64=24;var nb:i64=cir[11];
  if cir[b0]!=1{return 0;}if cir[b0+1]!=1{return 0;}if cir[b0+2]!=3{return 0;}if cir[b0+3]!=1{return 0;}if cir[b0+4]!=2{return 0;}if cir[b0+5]!=1{return 0;}
  if cir[b1]!=2{return 0;}if cir[b1+1]!=1{return 0;}if cir[b1+2]!=1{return 0;}if cir[b1+3]!=2{return 0;}
  if cir[b2]!=3{return 0;}if cir[b2+1]!=1{return 0;}if cir[b2+2]!=1{return 0;}if cir[b2+3]!=3{return 0;}
  if cir[nb]!=1{return 0;}if cir[nb+1]!=1{return 0;}if cir[nb+2]!=0{return 0;}if cir[nb+3]!=0{return 0;}
  if cir[nb+4]!=2{return 0;}if cir[nb+5]!=2{return 0;}if cir[nb+6]!=0{return 0;}if cir[nb+8]!=2{return 0;}if cir[nb+9]!=3{return 0;}if cir[nb+10]!=0{return 0;}return 1;
}

fn jj_cir_function_true_immediate(cir:*i64,slots:i64)->i64{
  if jj_cir_function_kind(cir,slots)!=1{return 0;}return cir[cir[11]+7];
}

fn jj_cir_function_false_immediate(cir:*i64,slots:i64)->i64{
  if jj_cir_function_kind(cir,slots)!=1{return 0;}return cir[cir[11]+11];
}

// Bounded one-argument direct i64 load: ARG(0) -> [ADDRESS_OFFSET] -> LOAD -> RETURN.
// This is semantic CIR shape recognition, not a source-keyword special case.
fn jj_cir_function_direct_load_kind(cir:*i64,slots:i64)->i64{
  if jj_cir_function_validate(cir,slots)==0{return 0;}
  if cir[2]!=1{return 0;}if cir[4]!=1{return 0;}if cir[5]!=1{return 0;}
  var bb:i64=12;var nb:i64=cir[11];var nodes:i64=cir[3];
  if nodes!=2{if nodes!=3{return 0;}}if cir[bb]!=1{return 0;}if cir[bb+1]!=nodes{return 0;}if cir[bb+2]!=1{return 0;}if cir[bb+3]!=nodes{return 0;}
  if cir[nb]!=1{return 0;}if cir[nb+1]!=1{return 0;}if cir[nb+2]!=0{return 0;}if cir[nb+3]!=0{return 0;}
  if nodes==2{if cir[nb+4]!=32{return 0;}if cir[nb+5]!=2{return 0;}if cir[nb+6]!=1{return 0;}if cir[nb+7]!=0{return 0;}return 1;}
  if cir[nb+4]!=36{return 0;}if cir[nb+5]!=2{return 0;}if cir[nb+6]!=1{return 0;}var offset:i64=cir[nb+7];if offset<=0{return 0;}if offset>248{return 0;}if (offset&7)!=0{return 0;}
  if cir[nb+8]!=32{return 0;}if cir[nb+9]!=3{return 0;}if cir[nb+10]!=2{return 0;}if cir[nb+11]!=0{return 0;}return 1;
}
fn jj_cir_function_direct_load_offset(cir:*i64,slots:i64)->i64{
  if jj_cir_function_direct_load_kind(cir,slots)==0{return 0;}if cir[3]==2{return 0;}var nb:i64=cir[11];return cir[nb+7];
}

fn jj_cir_validate(cir:*i64,slots:i64)->i64{
  if cir==0{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}if cir[0]!=0x4a4a434952303031{return 0;}if cir[1]==2{return jj_cir_function_validate(cir,slots);}if cir[1]!=1{return 0;}
  var count:i64=cir[2];if count<=0{return 0;}if count>(slots-8)/4{return 0;}if cir[3]!=count{return 0;}if cir[4]<0{return 0;}if cir[4]>1{return 0;}if cir[5]!=1{return 0;}if cir[6]<=0{return 0;}if cir[6]>count{return 0;}
  var i:i64=0;while i<count{var base:i64=8+i*4;var op:i64=cir[base];var dst:i64=cir[base+1];var a:i64=cir[base+2];var b:i64=cir[base+3];if dst!=i+1{return 0;}
    if op==1{if a<0{return 0;}if a>=cir[4]{return 0;}if b!=0{return 0;}}
    else{if op==2{if a!=0{return 0;}}else{if jj_cir_binary_supported(op)==0{return 0;}if a<=0{return 0;}if b<=0{return 0;}if a>=dst{return 0;}if b>=dst{return 0;}}}i=i+1;}
  var used:i64=8+count*4;i=used;while i<slots{if cir[i]!=0{return 0;}i=i+1;}var seal:i64=cir[7];if seal==0{return 0;}if seal!=jj_cir_seal_compute(cir,slots){return 0;}return 1;
}

fn jj_cir_finish(cir:*i64,slots:i64,result:i64)->i64{
  if cir==0{return 0;}if jj_cir_slots_valid(slots)==0{return 0;}var invalid:i64=0;if result<=0{invalid=1;}if result>cir[3]{invalid=1;}if cir[7]!=0{invalid=1;}
  if invalid==0{cir[6]=result;cir[7]=jj_cir_seal_compute(cir,slots);if cir[7]!=0{if jj_cir_validate(cir,slots)!=0{return 1;}}}jj_cir_abort(cir,slots);return 0;
}

fn jj_cir_build_constant(cir:*i64,slots:i64,value:i64)->i64{
  if jj_cir_begin(cir,slots,0,1)==0{return 0;}var v:i64=jj_cir_add_constant(cir,slots,value);if v==0{jj_cir_abort(cir,slots);return 0;}return jj_cir_finish(cir,slots,v);
}

fn jj_cir_expression_kind(cir:*i64,slots:i64)->i64{
  if jj_cir_validate(cir,slots)==0{return 0;}if cir[1]!=1{return 0;}var count:i64=cir[2];
  if cir[4]==0{if count==1{if cir[8]==2{if cir[6]==1{return 1;}}}return 0;}
  if count==1{if cir[8]==1{if cir[10]==0{if cir[6]==1{return 2;}}}if cir[8]==2{if cir[6]==1{return 1;}}return 0;}if cir[8]!=1{return 0;}if (count&1)==0{return 0;}var previous:i64=1;var node:i64=1;
  while node<count{var cb:i64=8+node*4;var ob:i64=cb+4;if cir[cb]!=2{return 0;}if cir[cb+2]!=0{return 0;}if jj_cir_binary_supported(cir[ob])==0{return 0;}if cir[ob+2]!=previous{return 0;}if cir[ob+3]!=node+1{return 0;}previous=node+2;node=node+2;}
  if cir[6]!=previous{return 0;}return 3;
}

fn jj_cir_operation_count(cir:*i64,slots:i64)->i64{
  var kind:i64=jj_cir_expression_kind(cir,slots);if kind!=3{return 0;}return (cir[2]-1)/2;
}

fn jj_cir_operation_opcode(cir:*i64,slots:i64,index:i64)->i64{
  var count:i64=jj_cir_operation_count(cir,slots);if index<0{return 0;}if index>=count{return 0;}return cir[8+(2+index*2)*4];
}

fn jj_cir_operation_immediate(cir:*i64,slots:i64,index:i64)->i64{
  var count:i64=jj_cir_operation_count(cir,slots);if index<0{return 0;}if index>=count{return 0;}return cir[8+(1+index*2)*4+3];
}

fn jj_cir_immediate(cir:*i64,slots:i64)->i64{
  if jj_cir_expression_kind(cir,slots)==1{return cir[11];}return 0;
}
fn jj_cir_cfg_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<12{return 0;}out[0]=64;out[1]=1;out[2]=1;out[3]=1;out[4]=1;out[5]=1;out[6]=0;out[7]=0;out[8]=2;out[9]=3;out[10]=1;out[11]=1;return 1;}
