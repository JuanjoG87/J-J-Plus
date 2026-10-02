// x86 AST-to-machine map resolution phase.
// Integration-hub partition R764: concrete work lives in focused phases.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_ast16_spans(p0:*i64)->i64;
extern fn jj_ast16_map_word(p0: *i64, p1: i64, p2: i64) -> i64;
extern fn jj_vm_rd64(p: *i8) -> i64;
extern fn jj_n_function_extended(core:*i64,function_id:i64,program:*i8,start:i64,end:i64)->i64;
extern fn jj_xvl_prepare(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64,p5:*i64)->i64;
extern fn jj_xvl_layout_receipt(p0:*i64)->i64;
extern fn jj_block_plan_prepare(p0:*i8,p1:i64,p2:i64,p3:*i64,p4:*i64)->i64;
extern fn jj_n_function_live(program:*i8,plan:*i64,argc:i64,locals:i64,map:*i64,stats:*i64)->i64;
extern fn jj_xcfg_prepare(p0:*i8,p1:*i64,p2:*i64)->i64;
extern fn jj_xcfg_plan_receipt(p0:*i64)->i64;
extern fn jj_coldtail_index_build_explicit(p0:*i8,p1:*i64,p2:*i64)->i64;
extern fn jj_coldtail_index_build(p0:*i8,p1:i64,p2:*i64)->i64;
extern fn jj_ast16_node_word(p0: *i64, p1: i64, p2: i64) -> i64;
extern fn jj_xvl_offset_for_pc(p0:*i64,p1:i64)->i64;
extern fn jj_n_offset_for_pc_abi_ctx(ctx:*i64,target:i64)->i64;
extern fn jj_coldtail_map_index(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_ast16_map_store(p0: *i64, p1: i64, p2: i64, p3: i64) -> i64;
extern fn jj_debug_line_at(p0: *i8, p1: i64, p2: i64) -> i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_n_resolve_ast_maps(source:*i8,source_length:i64,core:*i64,program:*i8,program_size:i64,ctx:*i64)->i64{
  if source==0{return 0;}if core==0{return 0;}if program==0{return 0;}if ctx==0{return 0;}var offsets:*i64=ctx[0] as *i64;var sizes:*i64=ctx[1] as *i64;var code:*i8=ctx[2] as *i8;if offsets==0{return 0;}if sizes==0{return 0;}if code==0{return 0;}
  var spans:*i64=jj_ast16_spans(core) as *i64;if spans==0{return 0;}
  var node_count:i64=core[25];var map_count:i64=core[27];var function_count:i64=core[10];
  if map_count<function_count{return 0;}if map_count>core[29]{return 0;}
  var map_receipts:*i64=ctx[3] as *i64;var layout_receipts:*i64=ctx[4] as *i64;var function_workspace:*i64=ctx[5] as *i64;var function_workspace_words:i64=ctx[6];var xcfg_receipts:*i64=ctx[7] as *i64;if map_receipts==0{return 0;}if layout_receipts==0{return 0;}if xcfg_receipts==0{return 0;}if function_workspace==0{return 0;}if function_workspace_words<10594{return 0;}var i:i64=0;var coldtail_map_function:i64=0-1;var coldtail_map_entries:[4096]i64;var coldtail_map_count:i64=0;var map_extended:i64=0;var map_direct:i64=0;var map_cfg:i64=0;var map_xvl:*i64=((function_workspace as i64)+8778*8) as *i64;var map_offset_ctx:[6]i64;
  while i<map_count{
    var map0:i64=jj_ast16_map_word(core,i,0);var map1:i64=jj_ast16_map_word(core,i,1);var node_id:i64=map1&0xffffffff;
    if node_id>=node_count{return 0;}var function_id:i64=map0&0xffffffff;var bytecode_pc:i64=(map0>>>32)&0xffffffff;
    if function_id>=function_count{return 0;}
    var table_offset:i64=jj_vm_rd64(program+32);var body_end:i64=jj_vm_rd64(program+40);if table_offset<=48{return 0;}if table_offset>=program_size{return 0;}if body_end<=48{return 0;}if body_end>table_offset{return 0;}var table:*i8=program+table_offset;var entry:*i8=table+function_id*32;var start:i64=jj_vm_rd64(entry+8);var argc:i64=jj_vm_rd64(entry+16);var end:i64=body_end;
    if function_id+1<function_count{end=jj_vm_rd64(table+(function_id+1)*32+8);}
    if function_id!=coldtail_map_function{coldtail_map_function=function_id;map_extended=jj_n_function_extended(core,function_id,program,start,end);map_direct=0;map_cfg=0;if layout_receipts[function_id]!=0{var map_locals:i64=jj_vm_rd64(entry+24);if map_extended!=0{return 0;}if jj_xvl_prepare(program,start,end,argc,map_locals,map_xvl)==0{return 0;}if jj_xvl_layout_receipt(map_xvl)!=layout_receipts[function_id]{return 0;}map_direct=1;}map_offset_ctx[0]=core as i64;map_offset_ctx[1]=function_id;map_offset_ctx[2]=program as i64;map_offset_ctx[3]=start;map_offset_ctx[4]=end;map_offset_ctx[5]=map_extended;var reclaimed:i64=(map_receipts[function_id]>>>48)&65535;if map_direct!=0{coldtail_map_count=0;}else{if map_extended==0{if reclaimed!=0{if xcfg_receipts[function_id]!=0{var map_plan:*i64=function_workspace;var map_facts:*i64=((function_workspace as i64)+4096*8) as *i64;var map_status:i64=jj_block_plan_prepare(program,start,end,map_plan,map_facts);if map_status!=1{return 0;}var map_slots:*i64=((map_xvl as i64)+1024*8) as *i64;var map_stats:*i64=((map_xvl as i64)+1088*8) as *i64;var map_locals2:i64=jj_vm_rd64(entry+24);if jj_n_function_live(program,map_plan,argc,map_locals2,map_slots,map_stats)==0{return 0;}map_xvl[512]=start;map_xvl[513]=end;map_xvl[514]=argc;map_xvl[515]=map_locals2;map_xvl[516]=map_slots as i64;map_xvl[517]=map_stats[8];map_xvl[518]=sizes[function_id];map_cfg=jj_xcfg_prepare(program,map_plan,map_xvl);if map_cfg<=0{return 0;}if jj_xcfg_plan_receipt(map_xvl)!=xcfg_receipts[function_id]{return 0;}map_offset_ctx[0]=sizes[function_id];map_offset_ctx[1]=(coldtail_map_entries as *i64) as i64;coldtail_map_count=jj_coldtail_index_build_explicit(code+offsets[function_id],map_offset_ctx as *i64,map_xvl);map_offset_ctx[0]=core as i64;map_offset_ctx[1]=function_id;}else{coldtail_map_count=jj_coldtail_index_build(code+offsets[function_id],sizes[function_id],coldtail_map_entries as *i64);}if coldtail_map_count<0{return 0;}}else{coldtail_map_count=0;}}else{coldtail_map_count=0;}}}
    var kind:i64=jj_ast16_node_word(core,node_id,0)&255;var machine:i64=0;
    if kind==1{if bytecode_pc!=start{return 0;}machine=offsets[function_id];}
    else{var relative:i64=0;if map_direct!=0{relative=jj_xvl_offset_for_pc(map_xvl,bytecode_pc);}else{relative=jj_n_offset_for_pc_abi_ctx(map_offset_ctx as *i64,bytecode_pc);}if relative<0{return 0;}if map_direct!=0{machine=offsets[function_id]+relative;}else{if map_extended!=0{machine=offsets[function_id]+relative;}else{var compact_relative:i64=jj_coldtail_map_index(coldtail_map_entries as *i64,coldtail_map_count,sizes[function_id],relative,0);if compact_relative<0{return 0;}machine=offsets[function_id]+compact_relative;}}}
    if machine<0{return 0;}if machine>0xffffffff{return 0;}if jj_ast16_map_store(core,i,1,node_id|(machine<<32))==0{return 0;}i=i+1;
  }
  i=1;
  while i<map_count{
    var key0:i64=jj_ast16_map_word(core,i,0);var key1:i64=jj_ast16_map_word(core,i,1);var key_node:i64=key1&0xffffffff;var key_machine:i64=(key1>>>32)&0xffffffff;
    var key_span:i64=(jj_ast16_node_word(core,key_node,1)>>>32)&0xffffffff;if key_span>=node_count{return 0;}var key_source:i64=spans[key_span]&0xffffffff;var j:i64=i;
    while j>0{
      var previous0:i64=jj_ast16_map_word(core,j-1,0);var previous1:i64=jj_ast16_map_word(core,j-1,1);var previous_node:i64=previous1&0xffffffff;var previous_machine:i64=(previous1>>>32)&0xffffffff;
      var previous_span:i64=(jj_ast16_node_word(core,previous_node,1)>>>32)&0xffffffff;if previous_span>=node_count{return 0;}var previous_source:i64=spans[previous_span]&0xffffffff;
      var move:i64=0;if previous_machine>key_machine{move=1;}else{if previous_machine==key_machine{if previous_source>key_source{move=1;}else{if previous_source==key_source{if previous_node>key_node{move=1;}}}}}
      if move==0{break;}if jj_ast16_map_store(core,j,0,previous0)==0{return 0;}if jj_ast16_map_store(core,j,1,previous1)==0{return 0;}j=j-1;
    }
    if jj_ast16_map_store(core,j,0,key0)==0{return 0;}if jj_ast16_map_store(core,j,1,key1)==0{return 0;}i=i+1;
  }
  var write:i64=0;var previous_line:i64=0-1;i=0;
  while i<map_count{
    var compact0:i64=jj_ast16_map_word(core,i,0);var compact1:i64=jj_ast16_map_word(core,i,1);var compact_node:i64=compact1&0xffffffff;
    var compact_span:i64=(jj_ast16_node_word(core,compact_node,1)>>>32)&0xffffffff;if compact_span>=node_count{return 0;}
    var source_offset:i64=spans[compact_span]&0xffffffff;var line:i64=jj_debug_line_at(source,source_length,source_offset);if line<=0{return 0;}
    var compact_kind:i64=jj_ast16_node_word(core,compact_node,0)&255;var keep:i64=0;if compact_kind==1{keep=1;}else{if line!=previous_line{keep=1;}}
    if keep!=0{if jj_ast16_map_store(core,write,0,compact0)==0{return 0;}if jj_ast16_map_store(core,write,1,compact1)==0{return 0;}write=write+1;previous_line=line;}
    i=i+1;
  }
  if write<function_count{return 0;}core[27]=write;return 1;
}
