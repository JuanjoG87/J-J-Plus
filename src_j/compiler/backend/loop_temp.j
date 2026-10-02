// jj_file: src_j/compiler/backend/loop_temp.j
// loop temporary plan LoopTempPlan v2. Promotes one initialized, repeatedly reused, dead-after-loop
// scalar temporary per already validated loop value plan loop to caller-saved R8.
// The first access in the body must be a dominating store before any internal
// branch. Calls, syscalls, escaping arrays and unsupported machine shapes keep
// the exact loop live-out plan fallback.
extern fn jj_vm_rd16(p0:*i8)->i64;
extern fn jj_vm_rd32(p0:*i8)->i64;
extern fn jj_n_bc_len(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_n_offset_for_pc(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_loop_liveout_store_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_loop_liveout_load_ok(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_loop_liveout_array_overlap(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_reo_nop(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_coldtail_map_index(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;

fn jj_loop_temp_s32(v:i64)->i64{if (v&0x80000000)!=0{return v|0xffffffff00000000;}return v&0xffffffff;}
fn jj_loop_temp_ref_kind(code:*i8,at:i64,limit:i64,slot:i64)->i64{
  if code==0{return 0;}if at<0{return 0;}var disp:i64=0-((slot+1)*8);
  if at+6<=limit{if ((code[at])&255)==0xff{var m0:i64=(code[at+1])&255;if (m0&7)==5{if jj_loop_temp_s32(jj_vm_rd32(code+at+2))==disp{if m0==0xb5{return 1;}return 0-1;}}}}
  if at+7<=limit{if code[at]==0x48{var op:i64=(code[at+1])&255;if op==0x8b{var m:i64=(code[at+2])&255;if (m&7)==5{if jj_loop_temp_s32(jj_vm_rd32(code+at+3))==disp{if m==0x85{return 2;}if m==0x8d{return 3;}if m==0x95{return 4;}if m==0xb5{return 5;}if m==0xbd{return 6;}return 0-1;}}}if op==0x89{var m2:i64=(code[at+2])&255;if (m2&7)==5{if jj_loop_temp_s32(jj_vm_rd32(code+at+3))==disp{if m2==0x85{return 7;}return 0-1;}}}if op==0x8d{var m3:i64=(code[at+2])&255;if (m3&7)==5{if jj_loop_temp_s32(jj_vm_rd32(code+at+3))==disp{return 0-1;}}}}}
  return 0;
}
fn jj_loop_temp_machine_refs(code:*i8,begin:i64,finish:i64,slot:i64,apply:i64,counts:*i64)->i64{
  if code==0{return 0;}if counts==0{return 0;}if begin<0{return 0;}if finish<=begin{return 0;}
  var loads:i64=0;var stores:i64=0;var at:i64=begin;
  while at<finish{var kind:i64=jj_loop_temp_ref_kind(code,at,finish,slot);if kind<0{return 0;}
    if kind==0{at=at+1;}else{
      if kind==7{stores=stores+1;if apply!=0{code[at]=0x49;code[at+1]=0x89;code[at+2]=0xc0;code[at+3]=0x0f;code[at+4]=0x1f;code[at+5]=0x40;code[at+6]=0x63;}at=at+7;}
      else{loads=loads+1;if apply!=0{
        if kind==1{code[at]=0x41;code[at+1]=0x50;code[at+2]=0x0f;code[at+3]=0x1f;code[at+4]=0x40;code[at+5]=0x64;at=at+6;}
        else{code[at]=0x4c;code[at+1]=0x89;if kind==2{code[at+2]=0xc0;}if kind==3{code[at+2]=0xc1;}if kind==4{code[at+2]=0xc2;}if kind==5{code[at+2]=0xc6;}if kind==6{code[at+2]=0xc7;}code[at+3]=0x0f;code[at+4]=0x1f;code[at+5]=0x40;code[at+6]=0x65;at=at+7;}
      }else{if kind==1{at=at+6;}else{at=at+7;}}}
    }
  }
  if stores<=0{return 0;}if loads<=0{return 0;}counts[0]=loads;counts[1]=stores;return 1;
}
fn jj_loop_temp_dead_after(program:*i8,pc:i64,end:i64,slot:i64)->i64{
  if program==0{return 0;}while pc<end{var op:i64=program[pc];if op==2{if jj_vm_rd16(program+pc+1)==slot{return 0;}}if op==4{var base:i64=jj_vm_rd16(program+pc+1);var count:i64=jj_vm_rd16(program+pc+3);if slot>=base{if slot<base+count{return 0;}}}var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0;}pc=pc+n;}if pc!=end{return 0;}return 1;
}
fn jj_loop_temp_body_start(program:*i8,header:i64,end:i64)->i64{
  if program==0{return 0-1;}var pc:i64=header;var i:i64=0;while i<4{if pc>=end{return 0-1;}var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0-1;}pc=pc+n;i=i+1;}return pc;
}
fn jj_loop_temp_first_store_dominates(program:*i8,body:i64,exit_pc:i64,slot:i64)->i64{
  if program==0{return 0;}var pc:i64=body;while pc<exit_pc{var op:i64=program[pc];if op==2{if jj_vm_rd16(program+pc+1)==slot{return 0;}}if op==3{if jj_vm_rd16(program+pc+1)==slot{return 1;}}if op==27{return 0;}if op==28{return 0;}var n:i64=jj_n_bc_len(program,pc,exit_pc);if n<=0{return 0;}pc=pc+n;}return 0;
}
fn jj_loop_temp_candidate(ctx:*i64,loop_index:i64,record:*i64)->i64{
  if ctx==0{return 0;}if record==0{return 0;}var code:*i8=ctx[0] as *i8;var old_size:i64=ctx[1];var program:*i8=ctx[2] as *i8;var start:i64=ctx[3];var end:i64=ctx[4];var argc:i64=ctx[5];var loops:*i64=ctx[7] as *i64;if code==0{return 0;}if program==0{return 0;}if loops==0{return 0;}var la:i64=loop_index*10;var header:i64=loops[la];var exit_pc:i64=loops[la+1];var induction:i64=loops[la+4];if header<start{return 0;}if exit_pc<=header{return 0;}if exit_pc>end{return 0;}var body:i64=jj_loop_temp_body_start(program,header,exit_pc);if body<0{return 0;}
  var slots:[64]i64;var loads:[64]i64;var stores:[64]i64;var count:i64=0;var pc:i64=body;while pc<exit_pc{var op:i64=program[pc];if op==2{var s:i64=jj_vm_rd16(program+pc+1);if s!=induction{var at:i64=0-1;var i:i64=0;while i<count{if slots[i]==s{at=i;}i=i+1;}if at<0{if count>=64{return 0;}at=count;slots[count]=s;loads[count]=0;stores[count]=0;count=count+1;}loads[at]=loads[at]+1;}}
    if op==3{var s2:i64=jj_vm_rd16(program+pc+1);if s2!=induction{var at2:i64=0-1;var j:i64=0;while j<count{if slots[j]==s2{at2=j;}j=j+1;}if at2<0{if count>=64{return 0;}at2=count;slots[count]=s2;loads[count]=0;stores[count]=0;count=count+1;}stores[at2]=stores[at2]+1;}}
    var n:i64=jj_n_bc_len(program,pc,exit_pc);if n<=0{return 0;}pc=pc+n;}if pc!=exit_pc{return 0;}
  var chosen:i64=0-1;var benefit:i64=0;var chosen_loads:i64=0;var chosen_stores:i64=0;var k:i64=0;while k<count{var s3:i64=slots[k];var b:i64=loads[k]+stores[k];if stores[k]>=3{if loads[k]>=2{if b<=255{if jj_loop_liveout_array_overlap(program,start,end,s3)==0{if jj_loop_temp_first_store_dominates(program,body,exit_pc,s3)!=0{if jj_loop_temp_dead_after(program,exit_pc,end,s3)!=0{if b>benefit{chosen=s3;benefit=b;chosen_loads=loads[k];chosen_stores=stores[k];}else{if b==benefit{if chosen<0{chosen=s3;chosen_loads=loads[k];chosen_stores=stores[k];}else{if s3<chosen{chosen=s3;chosen_loads=loads[k];chosen_stores=stores[k];}}}}}}}}}}k=k+1;}if chosen<0{return 0;}
  var body_old:i64=jj_n_offset_for_pc(program,start,end,argc,body);var exit_old:i64=jj_n_offset_for_pc(program,start,end,argc,exit_pc);if body_old<0{return 0;}if exit_old<=body_old{return 0;}if exit_old>old_size{return 0;}var mc:[2]i64;if jj_loop_temp_machine_refs(code,body_old,exit_old,chosen,0,mc as *i64)==0{return 0;}if mc[0]<=0{return 0;}if mc[1]<=0{return 0;}
  record[0]=1;record[1]=chosen;record[2]=mc[0];record[3]=mc[1];record[4]=benefit;record[5]=body_old;record[6]=exit_old;record[7]=(mc[0]&65535)|((mc[1]&65535)<<16);return 1;
}
fn jj_loop_temp_plan_temps(ctx:*i64)->i64{
  if ctx==0{return 0-1;}var count:i64=ctx[8];var temps:*i64=ctx[12] as *i64;if temps==0{return 0-1;}if count<0{return 0-1;}if count>16{return 0-1;}var i:i64=0;var enabled:i64=0;while i<count{var a:i64=i*8;var z:i64=0;while z<8{temps[a+z]=0;z=z+1;}if jj_loop_temp_candidate(ctx,i,temps+a)!=0{enabled=enabled+1;}i=i+1;}return enabled;
}
fn jj_loop_temp_apply_temps(ctx:*i64)->i64{
  if ctx==0{return 0;}var code:*i8=ctx[0] as *i8;var old_size:i64=ctx[1];var temps:*i64=ctx[12] as *i64;if code==0{return 0;}if temps==0{return 0;}var count:i64=ctx[8];var i:i64=0;while i<count{var a:i64=i*8;if temps[a]!=0{var slot:i64=temps[a+1];var mc:[2]i64;if jj_loop_temp_machine_refs(code,temps[a+5],temps[a+6],slot,1,mc as *i64)==0{return 0;}var packed:i64=temps[a+7];if mc[0]!=(packed&65535){return 0;}if mc[1]!=((packed>>>16)&65535){return 0;}}i=i+1;}return 1;
}
fn jj_loop_temp_wr16(p:*i8,v:i64)->i64{if p==0{return 0;}p[0]=v&255;p[1]=(v>>>8)&255;return 1;}
fn jj_loop_temp_wr32(p:*i8,v:i64)->i64{if p==0{return 0;}p[0]=v&255;p[1]=(v>>>8)&255;p[2]=(v>>>16)&255;p[3]=(v>>>24)&255;return 1;}
fn jj_loop_temp_append_proofs(ctx:*i64,map:*i64,used:i64)->i64{
  if ctx==0{return 0;}if map==0{return 0;}var code:*i8=ctx[0] as *i8;var capacity:i64=ctx[1];var temps:*i64=ctx[12] as *i64;var index:*i64=map[0] as *i64;var index_count:i64=map[1];var old_size:i64=map[2];if code==0{return 0;}if temps==0{return 0;}if index==0{return 0;}if used<=0{return 0;}if used>capacity{return 0;}var count:i64=ctx[8];var i:i64=0;while i<count{var a:i64=i*8;if temps[a]!=0{if used+25>capacity{return 0;}code[used]=0xe9;if jj_loop_temp_wr32(code+used+1,20)==0{return 0;}var write:i64=used+5;var body:i64=jj_coldtail_map_index(index,index_count,old_size,temps[a+5],1);var exit_at:i64=jj_coldtail_map_index(index,index_count,old_size,temps[a+6],1);if body<0{return 0;}if exit_at<=body{return 0;}code[write]=0x4a;code[write+1]=0x38;code[write+2]=0x50;code[write+3]=0x31;if jj_loop_temp_wr16(code+write+4,temps[a+1])==0{return 0;}if jj_loop_temp_wr16(code+write+6,temps[a+2])==0{return 0;}if jj_loop_temp_wr16(code+write+8,temps[a+3])==0{return 0;}if jj_loop_temp_wr16(code+write+10,i)==0{return 0;}if jj_loop_temp_wr32(code+write+12,body)==0{return 0;}if jj_loop_temp_wr32(code+write+16,exit_at)==0{return 0;}used=used+25;}i=i+1;}return used;
}
fn jj_loop_temp_update_receipt(ctx:*i64)->i64{
  if ctx==0{return 0;}var lp:*i64=ctx[7] as *i64;var n:i64=ctx[8];var tp:*i64=ctx[12] as *i64;var rr:*i64=ctx[10] as *i64;var fid:i64=ctx[11];if lp==0{return 0;}if tp==0{return 0;}if rr==0{return 0;}if fid<0{return 0;}var pk:i64=rr[fid];var rc:i64=(pk>>>16)&65535;var fp:i64=(pk>>>32)&65535;var nd:i64=(pk>>>48)&65535;var i:i64=0;while i<n{var a:i64=i*8;if tp[a]!=0{if rc>=65535{return 0;}if nd>65531{return 0;}var tk:i64=(0x73+lp[i*10+4]*3+tp[a+1]*5+tp[a+2]*7+tp[a+3]*11)&65535;rc=rc+1;fp=(fp*257+tk)&65535;nd=nd+4;}i=i+1;}rr[fid]=(pk&65535)|(rc<<16)|(fp<<32)|(nd<<48);return 1;
}

