// Multitarget selfhost admission authority. Capability publication is explicit
// and fail-closed: a relocatable-object backend is not a selfhost backend.
fn jj_target_backend_capabilities(kind:i64)->i64{
 // bit 0 source selection; 1 typed frontend; 2 sealed CIR; 3 relocatable ELF;
 // 4 general multi-function codegen; 5 calls/relocations; 6 executable image;
 // 7 native host runtime; 8 self-build driver; 9 native fixed point.
 if kind==5{return 0x3ff;}
 if kind==6{return 0x04f;}
 if kind==7{return 0x04f;}
 if kind==8{return 0x07f;}
 if kind==9{return 0x04f;}
 if kind==10{return 0x007;}
 return 0;
}
fn jj_target_selfhost_required_mask()->i64{return 0x3ff;}
fn jj_target_executable_seed_ready(kind:i64)->i64{var c:i64=jj_target_backend_capabilities(kind);if (c&0x40)!=0{return 1;}return 0;}
fn jj_target_compiler_runtime_ready(kind:i64)->i64{var c:i64=jj_target_backend_capabilities(kind);if (c&0x80)!=0{return 1;}return 0;}
fn jj_target_selfhost_ready(kind:i64)->i64{var c:i64=jj_target_backend_capabilities(kind);if c==jj_target_selfhost_required_mask(){return 1;}return 0;}
fn jj_target_elf_class(kind:i64)->i64{if kind==5{return 2;}if kind==6{return 2;}if kind==7{return 1;}if kind==8{return 1;}if kind==9{return 2;}if kind==10{return 1;}return 0;}
fn jj_target_elf_machine(kind:i64)->i64{if kind==5{return 62;}if kind==6{return 183;}if kind==7{return 40;}if kind==8{return 3;}if kind==9{return 243;}if kind==10{return 243;}return 0;}
fn jj_target_i64_return_parts(kind:i64)->i64{if kind==5{return 1;}if kind==6{return 1;}if kind==7{return 2;}if kind==8{return 2;}if kind==9{return 1;}if kind==10{return 2;}return 0;}
fn jj_target_runtime_syscall_abi(kind:i64)->i64{if kind==5{return 1;}if kind==6{return 2;}if kind==7{return 3;}if kind==8{return 4;}if kind==9{return 5;}if kind==10{return 6;}return 0;}
fn jj_target_selfhost_authority_seal(kind:i64)->i64{var c:i64=jj_target_backend_capabilities(kind);var e:i64=jj_target_elf_class(kind);var m:i64=jj_target_elf_machine(kind);var p:i64=jj_target_i64_return_parts(kind);var s:i64=jj_target_runtime_syscall_abi(kind);if c==0{return 0;}if e==0{return 0;}if m==0{return 0;}if p==0{return 0;}if s==0{return 0;}return kind^(c<<8)^(e<<20)^(m<<24)^(p<<40)^(s<<48)^0x4a4a534841555448;}
