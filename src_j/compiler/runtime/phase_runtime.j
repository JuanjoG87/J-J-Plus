// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_arch_seccomp_audit()->i64;
extern fn jj_runtime_failure_emit(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_compile_failure_pending()->i64;
extern fn jj_arch_execve_syscall()->i64;
extern fn jj_arch_execveat_syscall()->i64;
extern fn jj_arch_prctl_syscall()->i64;
extern fn jj_arch_seccomp_syscall()->i64;
extern fn jj_fs_read_cap(p0: *i64, p1: *i64, p2: *i8, p3: *i8, p4: i64) -> i64;
extern fn jj_fs_unlink_cap(p0: *i64, p1: *i8) -> i64;
extern fn jj_fs_write_cap(p0: *i64, p1: *i64, p2: *i8, p3: *i8, p4: i64) -> i64;
extern fn jj_path_component_valid(p0: *i8, p1: i64) -> i64;
extern fn jj_raw_fs_cap_storage() -> i64;
extern fn jj_raw_memory_cap_storage() -> i64;
extern fn jj_runtime_finalize_cap(p0: *i64) -> i64;
extern fn jj_runtime_fs_cap() -> i64;
extern fn jj_runtime_memory_cap() -> i64;
extern fn jj_runtime_parse_cap(p0: *i64) -> i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_phase_paths_equal(a: *i8, b: *i8) -> i64 {
  if a == 0 { return 0; }
  if b == 0 { return 0; }
  var i: i64 = 0;
  while i <= 4096 {
    if a[i] != b[i] { return 0; }
    if a[i] == 0 { return 1; }
    i = i + 1;
  }
  return 0;
}

fn jj_phase_o_suffix(path: *i8) -> i64 {
  if path == 0 { return 0; }
  var length: i64 = 0;
  while path[length] != 0 { length = length + 1; if length > 4096 { return 0; } }
  if length < 3 { return 0; }
  if path[length - 2] != 46 { return 0; }
  if path[length - 1] != 111 { return 0; }
  return 1;
}

fn jj_phase_relative_path(path: *i8) -> i64 {
  if path == 0 { return 0; }
  if path[0] == 0 { return 0; }
  if path[0] == 47 { return 0; }
  var total: i64 = 0;
  while path[total] != 0 { total = total + 1; if total > 4096 { return 0; } }
  if total == 0 { return 0; }
  if path[total - 1] == 47 { return 0; }
  var start: i64 = 0;
  var i: i64 = 0;
  while i <= total {
    if i == total { if jj_path_component_valid(path + start, i - start) == 0 { return 0; } }
    else { if path[i] == 47 { if jj_path_component_valid(path + start, i - start) == 0 { return 0; } start = i + 1; } }
    i = i + 1;
  }
  return 1;
}

fn jj_phase_build_paths(memory: *i64, output: *i8) -> i64 {
  if memory == 0 { return 0; }
  if output == 0 { return 0; }
  if jj_phase_relative_path(output) == 0 { return 0; }
  memory[15] = 1;
  return 1;
}

fn jj_phase_begin(fs: *i64, memory: *i64, source: *i8, output: *i8, argc: i64) -> i64 {
  if fs == 0 { return 114; }
  if memory == 0 { return 114; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return 114; }
  if memory != (jj_raw_memory_cap_storage() as *i64) { return 114; }
  if fs[0] != 0x4a4a465343415033 { return 114; }
  if memory[0] != 0x4a4a4d454d434134 { return 114; }
  if (fs[1] & 7) != 7 { return 114; }
  if (memory[1] & 7) != 7 { return 114; }
  if argc < 3 { return 2; }
  if source == 0 { return 2; }
  if output == 0 { return 2; }
  if jj_phase_relative_path(source) == 0 { return 2; }
  if jj_phase_relative_path(output) == 0 { return 2; }
  if jj_phase_paths_equal(source, output) == 1 { return 2; }
  if jj_phase_o_suffix(output) == 0 { return 2; }
  var stale_status: i64 = jj_fs_unlink_cap(fs, output);
  if stale_status != 0 { return stale_status; }
  memory[4] = 0;
  memory[7] = 0;
  memory[8] = source as i64;
  memory[9] = output as i64;
  memory[10] = 0;
  memory[11] = 0;
  memory[12] = 0;
  memory[15] = 0;
  if jj_phase_build_paths(memory, output) != 1 { return 2; }
  memory[10] = 1;
  return 0;
}

fn jj_phase_read(fs: *i64, memory: *i64) -> i64 {
  if fs == 0 { return 114; }
  if memory == 0 { return 114; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return 114; }
  if memory != (jj_raw_memory_cap_storage() as *i64) { return 114; }
  if fs[0] != 0x4a4a465343415033 { return 114; }
  if memory[0] != 0x4a4a4d454d434134 { return 114; }
  if (fs[1] & 1) != 1 { return 114; }
  if (memory[1] & 1) != 1 { return 114; }
  if memory[10] != 1 { return 113; }
  var status: i64 = jj_fs_read_cap(fs, memory, memory[8] as *i8, memory[2] as *i8, memory[3]);
  if status != 0 { return status; }
  if memory[4] == 0 { return 113; }
  if memory[4] > memory[3] { return 113; }
  memory[10] = 2;
  return 0;
}

fn jj_phase_parse(memory: *i64) -> i64 {
  if memory == 0 { return 114; }
  if memory != (jj_raw_memory_cap_storage() as *i64) { return 114; }
  if memory[0] != 0x4a4a4d454d434134 { return 114; }
  if (memory[1] & 2) != 2 { return 114; }
  if memory[10] != 2 { return 113; }
  var status: i64 = jj_runtime_parse_cap(memory);
  if status != 0 { return status; }
  memory[10] = 3;
  return 0;
}

fn jj_phase_write(fs: *i64, memory: *i64) -> i64 {
  if fs == 0 { return 114; }
  if memory == 0 { return 114; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return 114; }
  if memory != (jj_raw_memory_cap_storage() as *i64) { return 114; }
  if fs[0] != 0x4a4a465343415033 { return 114; }
  if memory[0] != 0x4a4a4d454d434134 { return 114; }
  if (fs[1] & 2) != 2 { return 114; }
  if (memory[1] & 4) != 4 { return 114; }
  if memory[10] != 3 { return 113; }
  var status: i64 = jj_runtime_finalize_cap(memory);
  if status != 0 { return status; }
  if memory[7] == 0 { return 113; }
  if memory[7] > memory[6] { return 113; }
  status = jj_fs_write_cap(fs, memory, memory[9] as *i8, memory[5] as *i8, memory[7]);
  if status != 0 { return status; }
  if memory[15] != 3 { return 112; }
  memory[10] = 4;
  return 0;
}

fn jj_phase_seccomp_insn(program:*i8,index:i64,code:i64,jt:i64,jf:i64,k:i64)->i64{
  if program==0{return 0;}if index<0{return 0;}if index>=11{return 0;}var p:*i8=program+index*8;p[0]=code&255;p[1]=(code>>>8)&255;p[2]=jt&255;p[3]=jf&255;p[4]=k&255;p[5]=(k>>>8)&255;p[6]=(k>>>16)&255;p[7]=(k>>>24)&255;return 1;
}

fn jj_phase_no_exec_sandbox()->i64{
  var raw:[11]i64;var prog:[2]i64;var p:*i8=raw as *i8;var i:i64=0;while i<88{p[i]=0;i=i+1;}prog[0]=0;prog[1]=0;
  if jj_phase_seccomp_insn(p,0,0x20,0,0,4)==0{return 0;}
  if jj_phase_seccomp_insn(p,1,0x15,1,0,jj_arch_seccomp_audit())==0{return 0;}
  if jj_phase_seccomp_insn(p,2,0x06,0,0,0x00050001)==0{return 0;}
  if jj_phase_seccomp_insn(p,3,0x20,0,0,0)==0{return 0;}
  if jj_phase_seccomp_insn(p,4,0x45,0,1,0x40000000)==0{return 0;}
  if jj_phase_seccomp_insn(p,5,0x06,0,0,0x00050001)==0{return 0;}
  if jj_phase_seccomp_insn(p,6,0x15,0,1,jj_arch_execve_syscall())==0{return 0;}
  if jj_phase_seccomp_insn(p,7,0x06,0,0,0x00050001)==0{return 0;}
  if jj_phase_seccomp_insn(p,8,0x15,0,1,jj_arch_execveat_syscall())==0{return 0;}
  if jj_phase_seccomp_insn(p,9,0x06,0,0,0x00050001)==0{return 0;}
  if jj_phase_seccomp_insn(p,10,0x06,0,0,0x7fff0000)==0{return 0;}
  prog[0]=11;prog[1]=p as i64;
  if jj_unsafe_abi_syscall4(jj_arch_prctl_syscall(),38,1,0,0)!=0{return 0;}
  if jj_unsafe_abi_syscall3(jj_arch_seccomp_syscall(),1,0,(prog as *i64)as i64)!=0{return 0;}
  return 1;
}

fn jj_stage3_wrapper_entry(source: *i8, output: *i8, argc: i64) -> i64 {
  if jj_phase_no_exec_sandbox()==0{jj_runtime_failure_emit(source,117,(71105<<16)|0);return 117;}
  var fs: *i64 = jj_runtime_fs_cap() as *i64;
  var memory: *i64 = jj_runtime_memory_cap() as *i64;
  var status: i64 = jj_phase_begin(fs, memory, source, output, argc);
  if status != 0 { jj_runtime_failure_emit(source,status,(71101<<16)|1);return status; }
  status = jj_phase_read(fs, memory);
  if status != 0 { jj_runtime_failure_emit(source,status,(71102<<16)|2);return status; }
  status = jj_phase_parse(memory);
  if status != 0 { if jj_compile_failure_pending()==0{jj_runtime_failure_emit(source,status,(71103<<16)|3);}return status; }
  status=jj_phase_write(fs, memory);
  if status!=0{jj_runtime_failure_emit(source,status,(71104<<16)|4);}return status;
}
