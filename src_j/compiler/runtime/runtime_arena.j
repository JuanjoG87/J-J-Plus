// Minimum deterministic runtime arena plus a lazily grown elastic tail.
// 8 MiB is not a ceiling: host capacity is queried through an explicit
// resource policy and additional memory is requested only on demand.
// The footer is probed only when all 16 bytes are known to remain inside
// the mapped 4 KiB subpage below the current program break.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_sys_brk(p0:i64)->i64;
extern fn jj_host_resource_policy_current(p0:*i64,p1:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_runtime_arena_core_bytes()->i64{return 8401352;}
fn jj_runtime_arena_min_span()->i64{return 8401368;}
fn jj_runtime_arena_footer_addressable(limit:i64)->i64{if limit<=16{return 0;}if (limit&4095)<16{return 0;}return 1;}
fn jj_runtime_arena_safe_limit(base:i64,span:i64)->i64{if base<=0{return 0;}if span<jj_runtime_arena_min_span(){return 0;}if base>0x7fffffffffffffff-span{return 0;}var limit:i64=base+span;var offset:i64=limit&4095;if offset<16{var adjust:i64=16-offset;if limit>0x7fffffffffffffff-adjust{return 0;}limit=limit+adjust;}return limit;}
fn jj_runtime_arena_footer_write(base:i64,limit:i64)->i64{if base<=0{return 0;}if limit<=base{return 0;}if jj_runtime_arena_footer_addressable(limit)==0{return 0;}var span:i64=limit-base;if span<jj_runtime_arena_min_span(){return 0;}var footer:*i64=(limit-16) as *i64;footer[0]=0x4a4a4152454e4231^base;footer[1]=0x4a4a4152454e5331^span;return 1;}
fn jj_runtime_arena_base()->i64{var current:i64=jj_sys_brk(0);if current<=jj_runtime_arena_min_span(){return 0;}if jj_runtime_arena_footer_addressable(current)==0{return 0;}var footer:*i64=(current-16) as *i64;var base:i64=footer[0]^0x4a4a4152454e4231;var span:i64=footer[1]^0x4a4a4152454e5331;if base<=0{return 0;}if span<jj_runtime_arena_min_span(){return 0;}if base>0x7fffffffffffffff-span{return 0;}if base+span!=current{return 0;}return base;}
fn jj_runtime_arena_span()->i64{var base:i64=jj_runtime_arena_base();if base==0{return 0;}var current:i64=jj_sys_brk(0);if current<=base{return 0;}return current-base;}
fn jj_runtime_arena_init()->i64{var existing:i64=jj_runtime_arena_base();if existing!=0{return 1;}var base:i64=jj_sys_brk(0);if base<=0{return 0;}var limit:i64=jj_runtime_arena_safe_limit(base,jj_runtime_arena_min_span());if limit==0{return 0;}var actual:i64=jj_sys_brk(limit);if actual!=limit{return 0;}if jj_runtime_arena_footer_write(base,limit)==0{return 0;}if jj_runtime_arena_base()!=base{return 0;}return 1;}
fn jj_runtime_arena_managed_limit()->i64{var policy:[20]i64;if jj_host_resource_policy_current(policy as *i64,20)==0{return 0;}return policy[7];}
fn jj_runtime_elastic_capacity()->i64{var span:i64=jj_runtime_arena_span();var minimum:i64=jj_runtime_arena_min_span();if span<minimum{return 0;}return span-minimum;}
fn jj_runtime_elastic_reserve(requested:i64)->i64{if requested<0{return 0;}if jj_runtime_arena_init()!=1{return 0;}var current_capacity:i64=jj_runtime_elastic_capacity();if requested<=current_capacity{return 1;}if requested>0x3ffffffffffff000{return 0;}var rounded:i64=(requested+4095)&0xfffffffffffff000;if rounded<requested{return 0;}var minimum:i64=jj_runtime_arena_min_span();var managed:i64=jj_runtime_arena_managed_limit();if managed<=minimum{return 0;}if rounded>managed-minimum{return 0;}var base:i64=jj_runtime_arena_base();if base==0{return 0;}var current:i64=jj_sys_brk(0);if current<=base{return 0;}if jj_runtime_arena_footer_addressable(current)==0{return 0;}if minimum>0x7fffffffffffffff-rounded{return 0;}var span:i64=minimum+rounded;var limit:i64=jj_runtime_arena_safe_limit(base,span);if limit==0{return 0;}var actual:i64=jj_sys_brk(limit);if actual!=limit{return 0;}var old_footer:*i64=(current-16) as *i64;old_footer[0]=0;old_footer[1]=0;if jj_runtime_arena_footer_write(base,limit)==0{return 0;}if jj_runtime_arena_base()!=base{return 0;}if jj_runtime_elastic_capacity()<requested{return 0;}return 1;}
fn jj_raw_source_buffer()->i64{if jj_runtime_arena_init()!=1{return 0;}return jj_runtime_arena_base();}
fn jj_raw_object_buffer()->i64{if jj_runtime_arena_init()!=1{return 0;}var base:i64=jj_runtime_arena_base();if base==0{return 0;}return base+1048576;}
fn jj_raw_final_output_buffer()->i64{if jj_runtime_arena_init()!=1{return 0;}var base:i64=jj_runtime_arena_base();if base==0{return 0;}return base+3145728;}
fn jj_raw_bundle_buffer()->i64{if jj_runtime_elastic_reserve(8388608)!=1{return 0;}var base:i64=jj_runtime_arena_base();if base==0{return 0;}return base+jj_runtime_arena_core_bytes();}
fn jj_raw_fs_cap_storage()->i64{if jj_runtime_arena_init()!=1{return 0;}var base:i64=jj_runtime_arena_base();if base==0{return 0;}return base+8388608;}
fn jj_raw_memory_cap_storage()->i64{if jj_runtime_arena_init()!=1{return 0;}var base:i64=jj_runtime_arena_base();if base==0{return 0;}return base+8388624;}
fn jj_raw_temp_path_storage()->i64{if jj_runtime_arena_init()!=1{return 0;}var base:i64=jj_runtime_arena_base();if base==0{return 0;}return base+8388800;}
fn jj_raw_dir_path_storage()->i64{if jj_runtime_arena_init()!=1{return 0;}var base:i64=jj_runtime_arena_base();if base==0{return 0;}return base+8396992;}
fn jj_raw_stat_storage()->i64{if jj_runtime_arena_init()!=1{return 0;}var base:i64=jj_runtime_arena_base();if base==0{return 0;}return base+8401088;}
fn jj_raw_elastic_buffer()->i64{if jj_runtime_arena_init()!=1{return 0;}var base:i64=jj_runtime_arena_base();if base==0{return 0;}return base+jj_runtime_arena_core_bytes();}
