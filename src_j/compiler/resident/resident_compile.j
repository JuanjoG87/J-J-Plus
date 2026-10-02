// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_core_sink_init(p0: *i64, p1: *i8, p2: i64, p3: i64) -> i64;
extern fn jj_program_workspace_bind_profile(p0:*i64,p1:*i8,p2:*i8,p3:*i8,p4:*i8,p5:*i64)->i64;
extern fn jj_program_workspace_view(p0:*i64,p1:*i64)->i64;
extern fn jj_core_index_scratch(p0:*i64,p1:i64)->i64;
extern fn jj_core_source_bind(p0:*i64,p1:*i8,p2:i64)->i64;
extern fn jj_core_target_kind(p0:*i64)->i64;
extern fn jj_ast16_init(p0:*i64,p1:*i8,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_arm_source_to_cir(p0: *i8, p1: i64, p2: *i64, p3: *i8, p4: i64, p5: *i64) -> i64;
extern fn jj_cir_view_bind(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_target_emit_arm_cir(p0:*i8,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_target_emit_i386_cir(p0:*i8,p1:i64,p2:*i64)->i64;
extern fn jj_target_backend_capabilities(p0:i64)->i64;
extern fn jj_target_output_kind(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_target_emit_aarch64_executable_cir(p0:*i8,p1:i64,p2:*i64)->i64;
extern fn jj_target_emit_arm32_executable_cir(p0:*i8,p1:i64,p2:*i64)->i64;
extern fn jj_target_emit_i386_executable_cir(p0:*i8,p1:i64,p2:*i64)->i64;
extern fn jj_target_emit_riscv64_executable_cir(p0:*i8,p1:i64,p2:*i64)->i64;
extern fn jj_target_profile_build(p0:i64,p1:*i64,p2:i64)->i64;
extern fn jj_target_emit_i386_semantic_module(p0:*i8,p1:i64,p2:*i64,p3:*i64,p4:i64)->i64;
extern fn jj_target_emit_aarch64_semantic_module(p0:*i8,p1:i64,p2:*i64,p3:*i64,p4:i64)->i64;
extern fn jj_frontend_phase_execute(p0:*i64,p1:*i64,p2:*i8,p3:i64,p4:*i64)->i64;
extern fn jj_frontend_phase_valid(p0:*i64)->i64;
extern fn jj_compile_memory_plan_bind(p0:*i64,p1:*i8,p2:i64)->i64;
extern fn jj_compile_memory_plan_frontend(p0:*i64,p1:*i64,p2:*i64,p3:*i8,p4:i64)->i64;
extern fn jj_x86_publish_execute(p0:*i64,p1:*i8,p2:*i64,p3:*i8,p4:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_compile_diagnostic_seal(report:*i64)->i64{return (report as i64)^report[0]^report[1]^report[2]^report[3]^report[4]^report[5]^report[6]^0x4a4a444941475332;}
fn jj_compile_diagnostic_valid(report:*i64)->i64{if report==0{return 0;}if report[0]!=0x4a4a444941473032{return 0;}if report[7]!=jj_compile_diagnostic_seal(report){return 0;}return 1;}
fn jj_compile_diagnostic_seed(report:*i64,code:i64,reason:i64)->i64{if report==0{return 0;}report[0]=0x4a4a444941473032;report[1]=code;report[2]=reason;report[3]=0;report[4]=0;report[5]=0;report[6]=0;report[7]=jj_compile_diagnostic_seal(report);return 1;}
fn jj_compile_frontend_reason(code:i64)->i64{
  if code==1101{return 6101;}
  if code==1102{return 6102;}
  if code==1103{return 6103;}
  if code==1104{return 6104;}
  if code==1105{return 6105;}
  if code==1106{return 6106;}
  if code==1107{return 6107;}
  if code==1201{return 6201;}
  if code==1202{return 6202;}
  if code==1203{return 6203;}
  if code==1204{return 6204;}
  if code==1205{return 6205;}
  if code==1206{return 6206;}
  if code==1401{return 6401;}
  if code==1402{return 6402;}
  if code==1403{return 6403;}
  if code==1404{return 6404;}
  if code==1405{return 6405;}
  if code==1406{return 6406;}
  if code==1407{return 6407;}
  if code==1501{return 6501;}
  if code==1502{return 6502;}
  if code==1503{return 6503;}
  if code==1504{return 6504;}
  if code==1505{return 6505;}
  if code==1506{return 6506;}
  if code==1507{return 6507;}
  if code==1508{return 6508;}
  if code==1509{return 6509;}
  if code==1510{return 6510;}
  if code==1511{return 6511;}
  if code==1512{return 6512;}
  if code==1513{return 6513;}
  if code==1514{return 6514;}
  return 6001;
}
fn jj_compile_diagnostic_frontend(report:*i64,code:i64,core:*i64)->i64{if report==0{return 0;}if core==0{return 0;}if jj_compile_diagnostic_seed(report,code,jj_compile_frontend_reason(code))==0{return 0;}var source_offset:i64=core[4];var token_length:i64=core[5];var source_length:i64=core[1];if source_offset<0{source_offset=0;}if token_length<0{token_length=0;}if source_length<0{source_length=0;}if source_length>0xffffffff{source_length=0xffffffff;}report[4]=source_offset;report[5]=token_length;report[6]=(source_length&0xffffffff)<<32;report[7]=jj_compile_diagnostic_seal(report);return 1;}
fn jj_compile_diagnostic_write(object:*i8,object_end:*i8,code:i64,attempts:i64,retry:*i64,source_length:i64)->i64{if object==0{return 0;}if object_end==0{return 0;}if retry==0{return 0;}if object_end-object<64{return 0;}var report:*i64=(object_end-64) as *i64;if jj_compile_diagnostic_valid(report)!=0{return 1;}if jj_compile_diagnostic_seed(report,code,0)==0{return 0;}report[6]=(attempts&255)|((retry[0]&255)<<8)|((retry[1]&255)<<16)|((retry[2]&255)<<24)|((source_length&0xffffffff)<<32);report[7]=jj_compile_diagnostic_seal(report);return 1;}

fn jj_resident_compile_attempt(source:*i8,source_end:*i8,workspace:*i8,workspace_end:*i8,request:*i64)->i64{
  if request==0{return 0;}var object:*i8=request[0] as *i8;var object_end:*i8=request[1] as *i8;var ast_eighths:i64=request[2];var index_profile:i64=request[3];
  if source==0{return 0;}if source_end==0{return 0;}if workspace==0{return 0;}if workspace_end==0{return 0;}if object==0{return 0;}if object_end==0{return 0;}
  if source_end<=source{return 0;}if workspace_end<=workspace{return 0;}if object_end<=object{return 0;}
  var object_region:[3]i64;object_region[0]=object as i64;object_region[1]=object_end-object;object_region[2]=ast_eighths;var workspace_state:[12]i64;var workspace_view:[8]i64;
  if jj_program_workspace_bind_profile(workspace_state as *i64,source,source_end,workspace,workspace_end,object_region as *i64)==0{return 0-1008;}if jj_program_workspace_view(workspace_state as *i64,workspace_view as *i64)==0{return 0;}
  var source_length:i64=workspace_view[0];var program:*i8=workspace_view[1] as *i8;var program_capacity:i64=workspace_view[2];var workspace_bytes:i64=workspace_view[3];var ast_offset:i64=workspace_view[4];var ast_bytes:i64=workspace_view[5];var ast_records:i64=workspace_view[6];var object_capacity:i64=workspace_view[7];
  if source_length<=0{return 0;}if program==0{return 0;}if program_capacity<65536{return 0;}if workspace_bytes<=0{return 0;}if ast_offset<program_capacity{return 0;}if ast_bytes<=0{return 0;}if ast_records<=4096{return 0;}if object_capacity<1048576{return 0;}
  var report:*i64=(object+object_capacity-64) as *i64;var clear_report:i64=0;while clear_report<8{report[clear_report]=0;clear_report=clear_report+1;}
  var memory_plan:[16]i64;if jj_compile_memory_plan_bind(memory_plan as *i64,object,object_capacity)==0{return 0;}
  var core:[4096]i64;var i:i64=0;while i<4096{core[i]=0;i=i+1;}core[198]=index_profile;
  if jj_ast16_init(core,program,workspace_bytes,ast_offset,ast_records,ast_records)==0{return 0;}
  var fm:[8]i64;if jj_compile_memory_plan_frontend(memory_plan as *i64,core,fm as *i64,program,program_capacity)==0{return 0;}
  i=0;while i<48{program[i]=0;i=i+1;}
  if jj_core_source_bind(core,source,source_length)==0{return 0;}if jj_core_sink_init(core,program,program_capacity,48)==0{return 0;}
  var fs:[12]i64;var fr:i64=jj_frontend_phase_execute(fs as *i64,core,source,source_length,fm as *i64);if fr<0{return fr;}if fr<=48{if core[193]!=0{jj_compile_diagnostic_frontend(report,core[193],core);return 0-core[193];}jj_compile_diagnostic_frontend(report,1006,core);return 0-1006;}if jj_frontend_phase_valid(fs as *i64)==0{return 0;}var program_size:i64=fs[6];if program_size!=fr{return 0;}
  if jj_target_backend_capabilities(jj_core_target_kind(core))==0{return 0;}
  if jj_core_target_kind(core) == 5 { var module_size:i64=jj_x86_publish_execute(memory_plan as *i64,source,core,program,program_size);if module_size==0{if core[193]!=0{if jj_compile_diagnostic_valid(report)==0{jj_compile_diagnostic_seed(report,core[193],6002);}return 0-core[193];}jj_compile_diagnostic_seed(report,1007,6002);return 0-1007;}report[0]=0x4a4a434150523031;report[1]=core[40];report[2]=core[45];report[3]=core[44];report[4]=core[41];report[5]=core[42];report[6]=core[43];report[7]=(report as i64)^report[0]^report[1]^report[2]^report[3]^report[4]^report[5]^report[6]^0x4a4a434150534541;return module_size; }
  var target_kind:i64=jj_core_target_kind(core);if target_kind==6{target_kind=6;}else{if target_kind==7{target_kind=7;}else{if target_kind==8{target_kind=8;}else{if target_kind==9{target_kind=9;}else{if target_kind==10{return 0-1007;}else{return 0;}}}}}
  var output_kind:i64=jj_target_output_kind(source,source_length,target_kind);if output_kind==0{return 0;}if target_kind==8{if output_kind==1{var i386_profile:[32]i64;if jj_target_profile_build(8,i386_profile as *i64,32)==0{return 0-1007;}var i386_size:i64=jj_target_emit_i386_semantic_module(object,object_capacity,core,i386_profile as *i64,32);if i386_size<=0{return 0-1007;}return i386_size;}}if target_kind==6{if output_kind==1{var a64_profile:[32]i64;if jj_target_profile_build(6,a64_profile as *i64,32)==0{return 0-1007;}var a64_module_size:i64=jj_target_emit_aarch64_semantic_module(object,object_capacity,core,a64_profile as *i64,32);if a64_module_size<=0{return 0-1007;}return a64_module_size;}}
  var cir_slots:i64=program_size+16;if cir_slots<64{cir_slots=64;}if cir_slots>65536{return 0-1007;}var arm_cir:*i64=jj_core_index_scratch(core,cir_slots) as *i64;if arm_cir==0{return 0-1007;}
  var arm_view:[4]i64;if jj_cir_view_bind(arm_view as *i64,arm_cir,cir_slots)==0{return 0-1007;}if jj_arm_source_to_cir(source,source_length,core,program,program_size,arm_view as *i64)==0{if core[193]==1601{jj_compile_diagnostic_seed(report,1601,6601);return 0-1601;}return 0-1007;}
  var arm_size:i64=0;if target_kind==8{if output_kind==2{arm_size=jj_target_emit_i386_executable_cir(object,object_capacity,arm_view as *i64);}else{arm_size=jj_target_emit_i386_cir(object,object_capacity,arm_view as *i64);}}else{if target_kind==6{if output_kind==2{arm_size=jj_target_emit_aarch64_executable_cir(object,object_capacity,arm_view as *i64);}else{arm_size=jj_target_emit_arm_cir(object,object_capacity,arm_view as *i64,target_kind);}}else{if target_kind==7{if output_kind==2{arm_size=jj_target_emit_arm32_executable_cir(object,object_capacity,arm_view as *i64);}else{arm_size=jj_target_emit_arm_cir(object,object_capacity,arm_view as *i64,target_kind);}}else{if target_kind==9{if output_kind==2{arm_size=jj_target_emit_riscv64_executable_cir(object,object_capacity,arm_view as *i64);}else{arm_size=jj_target_emit_arm_cir(object,object_capacity,arm_view as *i64,target_kind);}}else{return 0-1007;}}}}if arm_size<=0{return 0-1007;}return arm_size;
  return 0;
}

fn jj_compile_retry_next(code:i64,retry:*i64)->i64{
  if retry==0{return 0;}
  if code==1012{code=1002;}
  if code==1013{code=1003;}
  if code==1002{
    if retry[2]<0{return 0;}
    if retry[0]>=6{return 0;}
    retry[2]=1;
    retry[0]=retry[0]+1;
    return 1;
  }
  if code==1003{
    if retry[2]>0{return 0;}
    if retry[0]<=2{return 0;}
    retry[2]=0-1;
    retry[0]=retry[0]-1;
    return 1;
  }
  if code==1010{
    if retry[1]>=2{return 0;}
    retry[1]=retry[1]+1;
    return 1;
  }
  return 0;
}
fn jj_resident_compile(source:*i8,source_end:*i8,workspace:*i8,workspace_end:*i8,object:*i8,object_end:*i8)->i64{
  if source==0{return 0;}
  if source_end==0{return 0;}
  var source_length:i64=source_end-source;
  var request:[4]i64;
  request[0]=object as i64;
  request[1]=object_end as i64;
  var retry:[3]i64;
  retry[0]=4;
  retry[1]=0;
  retry[2]=0;
  var attempts:i64=0;
  var code:i64=1009;
  var result:i64=0;
  var active:i64=1;
  while active!=0{
    if attempts>=6{
      active=0;
    }else{
      attempts=attempts+1;
      request[2]=retry[0];
      request[3]=retry[1];
      result=jj_resident_compile_attempt(source,source_end,workspace,workspace_end,request as *i64);
      if result>2{return result;}
      code=0-result;
      if jj_compile_retry_next(code,retry as *i64)==0{
        active=0;
      }
    }
  }
  if code<=0{code=1009;}
  jj_compile_diagnostic_write(object,object_end,code,attempts,retry as *i64,source_length);
  return 2;
}
