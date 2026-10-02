// Linux i386 host personality. Raw kernel stat64 records are normalized to
// the canonical 64-bit logical stat layout consumed by runtime_capabilities.
fn jj_host_linux_i386_sys_result_is_error(value:i64)->i64{if (value&0xfffffffffffff000)==0xfffffffffffff000{return 1;}return 0;}
fn jj_sys_is_error(value:i64)->i64{return jj_host_linux_i386_sys_result_is_error(value);}
fn jj_arch_syscall3(number:i64,a:i64,b:i64,c:i64)->i64{return jj_unsafe_abi_syscall3(number,a,b,c);}
fn jj_arch_syscall4(number:i64,a:i64,b:i64,c:i64,d:i64)->i64{return jj_unsafe_abi_syscall4(number,a,b,c,d);}
fn jj_arch_seccomp_audit()->i64{return 0x40000003;}
fn jj_arch_execve_syscall()->i64{return 11;}
fn jj_arch_execveat_syscall()->i64{return 358;}
fn jj_arch_prctl_syscall()->i64{return 172;}
fn jj_arch_seccomp_syscall()->i64{return 354;}
extern fn jj_i386_stat64_normalize(p0:*i8,p1:*i8)->i64;
fn jj_sys_brk(address:i64)->i64{return (jj_arch_syscall3(45,address,0,0) as u32) as i64;}
fn jj_raw_read(fd:i64,buffer:*i8,length:i64)->i64{return jj_arch_syscall3(3,fd,buffer as i64,length);}
fn jj_raw_write(fd:i64,buffer:*i8,length:i64)->i64{return jj_arch_syscall3(4,fd,buffer as i64,length);}
fn jj_raw_close(fd:i64)->i64{return jj_arch_syscall3(6,fd,0,0);}
fn jj_raw_fstat(fd:i64,buffer:*i8)->i64{if buffer==0{return 0-14;}var words:[16]i64;var raw:*i8=words as *i8;var i:i64=0;while i<128{raw[i]=0;i=i+1;}var status:i64=jj_arch_syscall3(197,fd,raw as i64,0);if status!=0{return status;}if jj_i386_stat64_normalize(raw,buffer)==0{return 0-14;}return 0;}
fn jj_raw_fsync(fd:i64)->i64{return jj_arch_syscall3(118,fd,0,0);}
fn jj_raw_fchmod(fd:i64,mode:i64)->i64{return jj_arch_syscall3(94,fd,mode,0);}
fn jj_raw_getpid()->i64{return jj_arch_syscall3(20,0,0,0);}
fn jj_raw_getdents64(fd:i64,buffer:*i8,length:i64)->i64{return jj_arch_syscall3(220,fd,buffer as i64,length);}
fn jj_raw_fork()->i64{return jj_arch_syscall3(2,0,0,0);}
fn jj_i386_exec_vector_pack(source:*i64,destination:*i8,limit:i64)->i64{
 if source==0{return 0;}if destination==0{return 0;}if limit<=0{return 0;}if limit>128{return 0;}var i:i64=0;while i<limit{var value:i64=source[i];if value==0{destination[i*4]=0;destination[i*4+1]=0;destination[i*4+2]=0;destination[i*4+3]=0;return i+1;}if (value>>>32)!=0{return 0;}destination[i*4]=value;destination[i*4+1]=value>>>8;destination[i*4+2]=value>>>16;destination[i*4+3]=value>>>24;i=i+1;}return 0;
}
fn jj_raw_execve(path:*i8,argv:*i64,envp:*i64)->i64{
 if path==0{return 0-14;}var argv_words:[64]i64;var envp_words:[64]i64;var argv_kernel:i64=0;var envp_kernel:i64=0;if argv!=0{if jj_i386_exec_vector_pack(argv,argv_words as *i8,128)==0{return 0-7;}argv_kernel=argv_words as i64;}if envp!=0{if jj_i386_exec_vector_pack(envp,envp_words as *i8,128)==0{return 0-7;}envp_kernel=envp_words as i64;}return jj_arch_syscall3(11,path as i64,argv_kernel,envp_kernel);
}
fn jj_raw_wait4(pid:i64,status:*i64,options:i64,rusage:*i8)->i64{return jj_arch_syscall4(114,pid,status as i64,options,rusage as i64);}
fn jj_raw_kill(pid:i64,signal:i64)->i64{return jj_arch_syscall3(37,pid,signal,0);}
fn jj_raw_mkdir(path:*i8,mode:i64)->i64{return jj_arch_syscall3(39,path as i64,mode,0);}
fn jj_arch_exit(status:i64)->i64{return jj_arch_syscall3(1,status,0,0);}
fn jj_raw_openat(dirfd:i64,path:*i8,flags:i64,mode:i64)->i64{return jj_arch_syscall4(295,dirfd,path as i64,flags,mode);}
fn jj_raw_renameat(old_dirfd:i64,old_path:*i8,new_dirfd:i64,new_path:*i8)->i64{return jj_arch_syscall4(302,old_dirfd,old_path as i64,new_dirfd,new_path as i64);}
fn jj_raw_unlinkat(dirfd:i64,path:*i8)->i64{return jj_arch_syscall3(301,dirfd,path as i64,0);}
fn jj_raw_unlinkat_flags(dirfd:i64,path:*i8,flags:i64)->i64{return jj_arch_syscall3(301,dirfd,path as i64,flags);}
fn jj_raw_mkdirat(dirfd:i64,path:*i8,mode:i64)->i64{return jj_arch_syscall3(296,dirfd,path as i64,mode);}
fn jj_raw_fstatat_nofollow(dirfd:i64,path:*i8,buffer:*i8)->i64{if buffer==0{return 0-14;}var words:[16]i64;var raw:*i8=words as *i8;var i:i64=0;while i<128{raw[i]=0;i=i+1;}var status:i64=jj_arch_syscall4(300,dirfd,path as i64,raw as i64,256);if status!=0{return status;}if jj_i386_stat64_normalize(raw,buffer)==0{return 0-14;}return 0;}
fn jj_raw_open_root()->i64{var dot:[2]i64;dot[0]=46;dot[1]=0;return jj_raw_openat(0xffffffffffffff9c,dot as *i8,720896,0);}
fn jj_raw_openat_dir(dirfd:i64,path:*i8)->i64{return jj_raw_openat(dirfd,path,720896,0);}
fn jj_raw_openat_ro(dirfd:i64,path:*i8)->i64{return jj_raw_openat(dirfd,path,657408,0);}
fn jj_raw_openat_wo(dirfd:i64,path:*i8,mode:i64)->i64{return jj_raw_openat(dirfd,path,656065,mode);}
fn seed_open_create(a:i64,b:i64,c:i64)->i64{return jj_arch_syscall3(5,a,b,c);}
fn seed_write_fd(a:i64,b:i64,c:i64)->i64{return jj_arch_syscall3(4,a,b,c);}

fn jj_host_i386_rd32(p:*i8)->i64{if p==0{return 0;}return (p[0]&255)|((p[1]&255)<<8)|((p[2]&255)<<16)|((p[3]&255)<<24);}
fn jj_sys_host_total_memory_bytes()->i64{var info:[8]i64;var raw:*i8=info as *i8;var i:i64=0;while i<64{raw[i]=0;i=i+1;}if jj_arch_syscall3(116,raw as i64,0,0)!=0{return 0;}var total:i64=jj_host_i386_rd32(raw+16);var unit:i64=jj_host_i386_rd32(raw+52);if total<=0{return 0;}if unit<=0{unit=1;}if total>0x3fffffffffffffff/unit{return 0;}return total*unit;}
fn jj_sys_host_logical_cpus()->i64{var mask:[16]i64;var raw:*i8=mask as *i8;var i:i64=0;while i<128{raw[i]=0;i=i+1;}var bytes:i64=jj_arch_syscall3(242,0,128,raw as i64);if jj_sys_is_error(bytes)!=0{return 1;}if bytes<=0{return 1;}if bytes>128{bytes=128;}var count:i64=0;i=0;while i<bytes{var v:i64=raw[i]&255;var bit:i64=0;while bit<8{count=count+(v&1);v=v>>>1;bit=bit+1;}i=i+1;}if count<=0{return 1;}return count;}
