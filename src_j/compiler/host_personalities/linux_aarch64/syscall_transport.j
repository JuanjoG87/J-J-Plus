// Linux AArch64 host personality. Syscall numbers and raw layouts follow asm-generic.
fn jj_host_linux_aarch64_sys_result_is_error(value:i64)->i64{if (value&0xfffffffffffff000)==0xfffffffffffff000{return 1;}return 0;}
fn jj_sys_is_error(value:i64)->i64{return jj_host_linux_aarch64_sys_result_is_error(value);}
fn jj_arch_syscall3(number:i64,a:i64,b:i64,c:i64)->i64{return jj_unsafe_abi_syscall3(number,a,b,c);}
fn jj_arch_syscall4(number:i64,a:i64,b:i64,c:i64,d:i64)->i64{return jj_unsafe_abi_syscall4(number,a,b,c,d);}
fn jj_arch_syscall5(number:i64,a:i64,b:i64,c:i64,d:i64,e:i64)->i64{return jj_unsafe_abi_syscall5(number,a,b,c,d,e);}
fn jj_arch_seccomp_audit()->i64{return 0xc00000b7;}
fn jj_arch_execve_syscall()->i64{return 221;}
fn jj_arch_execveat_syscall()->i64{return 281;}
fn jj_arch_prctl_syscall()->i64{return 167;}
fn jj_arch_seccomp_syscall()->i64{return 277;}
extern fn jj_aarch64_stat_normalize(p0:*i8,p1:*i8)->i64;
fn jj_sys_brk(address:i64)->i64{return jj_arch_syscall3(214,address,0,0);}
fn jj_raw_read(fd:i64,buffer:*i8,length:i64)->i64{return jj_arch_syscall3(63,fd,buffer as i64,length);}
fn jj_raw_write(fd:i64,buffer:*i8,length:i64)->i64{return jj_arch_syscall3(64,fd,buffer as i64,length);}
fn jj_raw_close(fd:i64)->i64{return jj_arch_syscall3(57,fd,0,0);}
fn jj_raw_fstat(fd:i64,buffer:*i8)->i64{if buffer==0{return 0-14;}var words:[16]i64;var raw:*i8=words as *i8;var i:i64=0;while i<128{raw[i]=0;i=i+1;}var status:i64=jj_arch_syscall3(80,fd,raw as i64,0);if status!=0{return status;}if jj_aarch64_stat_normalize(raw,buffer)==0{return 0-14;}return 0;}
fn jj_raw_fsync(fd:i64)->i64{return jj_arch_syscall3(82,fd,0,0);}
fn jj_raw_fchmod(fd:i64,mode:i64)->i64{return jj_arch_syscall3(52,fd,mode,0);}
fn jj_raw_getpid()->i64{return jj_arch_syscall3(172,0,0,0);}
fn jj_raw_getdents64(fd:i64,buffer:*i8,length:i64)->i64{return jj_arch_syscall3(61,fd,buffer as i64,length);}
fn jj_raw_fork()->i64{return jj_arch_syscall5(220,17,0,0,0,0);}
fn jj_raw_execve(path:*i8,argv:*i64,envp:*i64)->i64{return jj_arch_syscall3(221,path as i64,argv as i64,envp as i64);}
fn jj_raw_wait4(pid:i64,status:*i64,options:i64,rusage:*i8)->i64{return jj_arch_syscall4(260,pid,status as i64,options,rusage as i64);}
fn jj_raw_kill(pid:i64,signal:i64)->i64{return jj_arch_syscall3(129,pid,signal,0);}
fn jj_raw_mkdir(path:*i8,mode:i64)->i64{return jj_arch_syscall3(34,0xffffffffffffff9c,path as i64,mode);}
fn jj_arch_exit(status:i64)->i64{return jj_arch_syscall3(93,status,0,0);}
fn jj_raw_openat(dirfd:i64,path:*i8,flags:i64,mode:i64)->i64{return jj_arch_syscall4(56,dirfd,path as i64,flags,mode);}
fn jj_raw_renameat(old_dirfd:i64,old_path:*i8,new_dirfd:i64,new_path:*i8)->i64{return jj_arch_syscall4(38,old_dirfd,old_path as i64,new_dirfd,new_path as i64);}
fn jj_raw_renameat2(old_dirfd:i64,old_path:*i8,new_dirfd:i64,new_path:*i8,flags:i64)->i64{return jj_arch_syscall5(276,old_dirfd,old_path as i64,new_dirfd,new_path as i64,flags);}
fn jj_raw_fsetxattr(fd:i64,name:*i8,value:*i8,size:i64,flags:i64)->i64{return jj_arch_syscall5(7,fd,name as i64,value as i64,size,flags);}
fn jj_raw_fgetxattr(fd:i64,name:*i8,value:*i8,size:i64)->i64{return jj_arch_syscall4(10,fd,name as i64,value as i64,size);}
fn jj_raw_flistxattr(fd:i64,list:*i8,size:i64)->i64{return jj_arch_syscall3(13,fd,list as i64,size);}
fn jj_raw_fremovexattr(fd:i64,name:*i8)->i64{return jj_arch_syscall3(16,fd,name as i64,0);}
fn jj_raw_unlinkat(dirfd:i64,path:*i8)->i64{return jj_arch_syscall3(35,dirfd,path as i64,0);}
fn jj_raw_unlinkat_flags(dirfd:i64,path:*i8,flags:i64)->i64{return jj_arch_syscall3(35,dirfd,path as i64,flags);}
fn jj_raw_mkdirat(dirfd:i64,path:*i8,mode:i64)->i64{return jj_arch_syscall3(34,dirfd,path as i64,mode);}
fn jj_raw_fstatat_nofollow(dirfd:i64,path:*i8,buffer:*i8)->i64{if buffer==0{return 0-14;}var words:[16]i64;var raw:*i8=words as *i8;var i:i64=0;while i<128{raw[i]=0;i=i+1;}var status:i64=jj_arch_syscall4(79,dirfd,path as i64,raw as i64,256);if status!=0{return status;}if jj_aarch64_stat_normalize(raw,buffer)==0{return 0-14;}return 0;}
fn jj_aarch64_open_root_flags()->i64{return 573440;}
fn jj_aarch64_open_read_flags()->i64{return 559104;}
fn jj_aarch64_open_write_flags()->i64{return 557761;}
fn jj_raw_open_root()->i64{var dot:[2]i64;dot[0]=46;dot[1]=0;return jj_raw_openat(0xffffffffffffff9c,dot as *i8,jj_aarch64_open_root_flags(),0);}
fn jj_raw_openat_dir(dirfd:i64,path:*i8)->i64{return jj_raw_openat(dirfd,path,jj_aarch64_open_root_flags(),0);}
fn jj_raw_openat_ro(dirfd:i64,path:*i8)->i64{return jj_raw_openat(dirfd,path,jj_aarch64_open_read_flags(),0);}
fn jj_raw_openat_wo(dirfd:i64,path:*i8,mode:i64)->i64{return jj_raw_openat(dirfd,path,jj_aarch64_open_write_flags(),mode);}
fn seed_open_create(a:i64,b:i64,c:i64)->i64{return jj_arch_syscall3(56,0xffffffffffffff9c,a,b);}
fn seed_write_fd(a:i64,b:i64,c:i64)->i64{return jj_arch_syscall3(64,a,b,c);}
fn jj_host_aarch64_rd32(p:*i8)->i64{if p==0{return 0;}return (p[0]&255)|((p[1]&255)<<8)|((p[2]&255)<<16)|((p[3]&255)<<24);}
fn jj_sys_host_total_memory_bytes()->i64{var info:[16]i64;var raw:*i8=info as *i8;var i:i64=0;while i<128{raw[i]=0;i=i+1;}if jj_arch_syscall3(179,raw as i64,0,0)!=0{return 0;}var total:i64=info[4];var unit:i64=jj_host_aarch64_rd32(raw+104);if total<=0{return 0;}if unit<=0{unit=1;}if total>0x3fffffffffffffff/unit{return 0;}return total*unit;}
fn jj_sys_host_logical_cpus()->i64{var mask:[16]i64;var raw:*i8=mask as *i8;var i:i64=0;while i<128{raw[i]=0;i=i+1;}var bytes:i64=jj_arch_syscall3(123,0,128,raw as i64);if jj_sys_is_error(bytes)!=0{return 1;}if bytes<=0{return 1;}if bytes>128{bytes=128;}var count:i64=0;i=0;while i<bytes{var v:i64=raw[i]&255;var bit:i64=0;while bit<8{count=count+(v&1);v=v>>>1;bit=bit+1;}i=i+1;}if count<=0{return 1;}return count;}
