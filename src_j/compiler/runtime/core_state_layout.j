









fn jj_core_sink_init(core: *i64, output: *i8, capacity: i64, position: i64) -> i64 {
  if core == 0 { return 0; }
  if output == 0 { return 0; }
  if capacity <= 0 { return 0; }
  if position < 0 { return 0; }
  if position > capacity { return 0; }
  core[7] = output as i64;
  core[8] = capacity;
  core[9] = position;
  return 1;
}

fn jj_express_sink_output(state: *i64) -> i64 {
  if state == 0 { return 0; }
  return state[0];
}

fn jj_express_sink_capacity(state: *i64) -> i64 {
  if state == 0 { return 0; }
  return state[1];
}

fn jj_express_sink_cursor(state: *i64) -> i64 {
  if state == 0 { return 0; }
  return (state as i64) + 16;
}

fn jj_express_sink_position(state: *i64) -> i64 {
  if state == 0 { return 0; }
  return state[2];
}

fn jj_express_sink_init(state: *i64, output: *i8, capacity: i64) -> i64 {
  if state == 0 { return 0; }
  if output == 0 { return 0; }
  if capacity <= 0 { return 0; }
  state[0] = output as i64;
  state[1] = capacity;
  state[2] = 0;
  return 1;
}

// Typed Core State accessors. These isolate the resident compiler from raw
// layout arithmetic while the historical arena is retired incrementally.




fn jj_core_function_count(core: *i64) -> i64 {
  if core == 0 { return 0; }
  return core[10];
}

fn jj_core_external_count(core: *i64) -> i64 {
  if core == 0 { return 0; }
  return core[20];
}

fn jj_core_index_valid(core:*i64)->i64{
  if core==0{return 0;}if core[35]==0{return 0;}if core[36]<=0{return 0;}if core[37]<0{return 0;}
  if core[37]>core[36]/8{return 0;}var seal:i64=(core as i64)^core[35]^core[36]^0x4a4a494e44583232;
  if core[38]!=seal{return 0;}return 1;
}

fn jj_core_index_version(core:*i64)->i64{
  if jj_core_index_valid(core)==0{return 0;}return 2;
}

fn jj_core_index_record(core:*i64,kind:i64,ordinal:i64)->i64{
  if jj_core_index_valid(core)==0{return 0;}if kind<1{return 0;}if kind>17{return 0;}if ordinal<0{return 0;}
  // Slots 201..499 are a bounded ephemeral function directory. The exact
  // linear authority remains as fallback, so the directory adds no ceiling.
  if kind==1{if core[199]==0x4a4a464e44495231{if ordinal<core[200]{if ordinal<299{var cached:i64=core[201+ordinal];if cached!=0{return cached;}}}}}
  var records:*i64=core[35] as *i64;var seen:i64=0;var i:i64=0;while i<core[37]{var at:i64=i*8;if records[at]==kind{if seen==ordinal{return (records as i64)+at*8;}seen=seen+1;}i=i+1;}return 0;
}

fn jj_core_index_bind(core:*i64,base:*i64,words:i64)->i64{
  if core==0{return 0;}if base==0{return 0;}if words<64{return 0;}core[35]=base as i64;core[36]=words;core[37]=0;core[39]=words;core[38]=(core as i64)^(base as i64)^words^0x4a4a494e44583232;core[199]=0x4a4a464e44495231;core[200]=0;var i:i64=201;while i<500{core[i]=0;i=i+1;}return jj_core_index_valid(core);
}

fn jj_core_index_find_name(core:*i64,kind:i64,start:i64,count:i64)->i64{
  if jj_core_index_valid(core)==0{return 0;}if kind<1{return 0;}if kind>17{return 0;}if start<0{return 0;}if count<=0{return 0;}var source:*i8=core[0] as *i8;if source==0{return 0;}var records:*i64=core[35] as *i64;var ordinal:i64=0;var i:i64=0;
  while i<core[37]{var at:i64=i*8;if records[at]==kind{if records[at+2]==count{var candidate:i64=records[at+1];var equal:i64=1;if source[start]!=source[candidate]{equal=0;}else{if count>1{if source[start+count-1]!=source[candidate+count-1]{equal=0;}}}var j:i64=1;while j<count-1{if equal==0{j=count;}else{if source[start+j]!=source[candidate+j]{equal=0;j=count;}else{j=j+1;}}}if equal!=0{return ordinal+1;}}ordinal=ordinal+1;}i=i+1;}return 0;
}

fn jj_core_index_append(core:*i64,kind:i64,fields:*i64,count:i64)->i64{
  if jj_core_index_valid(core)==0{return 0;}if fields==0{return 0;}if kind<1{return 0;}if kind>17{return 0;}if count<0{return 0;}if count>7{return 0;}var used:i64=core[37];if used>0x1fffffff{core[193]=1010;return 0;}var at:i64=used*8;if at>core[39]-8{core[193]=1010;return 0;}var records:*i64=core[35] as *i64;records[at]=kind;var i:i64=0;while i<7{if i<count{records[at+1+i]=fields[i];}else{records[at+1+i]=0;}i=i+1;}core[37]=used+1;if kind==1{var function_ordinal:i64=core[200];if function_ordinal<299{core[201+function_ordinal]=(records as i64)+at*8;}core[200]=function_ordinal+1;}return used+1;
}

fn jj_core_index_scratch(core:*i64,words:i64)->i64{
  if jj_core_index_valid(core)==0{return 0;}if words<=0{return 0;}var tail:i64=core[39];if words>tail{core[193]=1011;return 0;}var next:i64=tail-words;if next<core[37]*8{core[193]=1011;return 0;}core[39]=next;var base:*i64=core[35] as *i64;var out:*i64=((base as i64)+next*8) as *i64;var i:i64=0;while i<words{out[i]=0;i=i+1;}return out as i64;
}

fn jj_core_function_field(core: *i64, function_id: i64, field: i64) -> i64 {
  if field<0{return 0-1;}if field>4{return 0-1;}var record:*i64=jj_core_index_record(core,1,function_id) as *i64;if record==0{return 0-1;}return record[1+field];
}

fn jj_core_function_return_type(core: *i64, function_id: i64) -> i64 {
  var record:*i64=jj_core_index_record(core,1,function_id) as *i64;if record==0{return 0;}return record[6];
}

fn jj_core_function_signature(core: *i64, function_id: i64) -> i64 {
  var record:*i64=jj_core_index_record(core,1,function_id) as *i64;if record==0{return 0;}return record[7];
}

fn jj_core_external_field(core:*i64,external_id:i64,field:i64)->i64{
  if field<0{return 0-1;}if field>2{return 0-1;}var record:*i64=jj_core_index_record(core,3,external_id) as *i64;if record==0{return 0-1;}return record[1+field];
}

fn jj_core_effect_alias_field(core:*i64,ordinal:i64,field:i64)->i64{
  if ordinal<0{return 0-1;}if field<0{return 0-1;}if field>6{return 0-1;}var record:*i64=jj_core_index_record(core,12,ordinal) as *i64;if record==0{return 0-1;}return record[1+field];
}

fn jj_core_effect_transform_field(core:*i64,ordinal:i64,field:i64)->i64{
  if ordinal<0{return 0-1;}if field<0{return 0-1;}if field>6{return 0-1;}var record:*i64=jj_core_index_record(core,13,ordinal) as *i64;if record==0{return 0-1;}return record[1+field];
}

fn jj_core_effect_transformed_alias_field(core:*i64,ordinal:i64,field:i64)->i64{
  if ordinal<0{return 0-1;}if field<0{return 0-1;}if field>6{return 0-1;}var record:*i64=jj_core_index_record(core,14,ordinal) as *i64;if record==0{return 0-1;}return record[1+field];
}

fn jj_core_source_bind(core:*i64,source:*i8,length:i64)->i64{
  if core==0{return 0;}if source==0{return 0;}if length<=0{return 0;}
  core[0]=source as i64;core[1]=length;core[2]=0;core[15]=0;return 1;
}

fn jj_core_target_set(core:*i64,kind:i64)->i64{
  if core==0{return 0;}if kind<5{return 0;}if kind>10{return 0;}
  core[18]=kind;return 1;
}

fn jj_core_target_kind(core:*i64)->i64{
  if core==0{return 0;}return core[18];
}

fn jj_core_source_map_count(core:*i64)->i64{
  if core==0{return 0;}return core[17];
}
