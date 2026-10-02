// R724A LoopInvariantPlan v4. Hoists one private scalar local into R9 for one
// canonical loop. The withdrawn external-load kind is physically absent.
// Admission and application are fail-closed. General legality/work decides
// admission; the i386 profile is retained only as an adversarial pressure oracle.
extern fn jj_vm_rd16(p0:*i8)->i64;
extern fn jj_vm_rd32(p0:*i8)->i64;
extern fn jj_n_bc_len(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_n_offset_for_pc(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_loop_liveout_array_overlap(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_coldtail_map_index(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_transform_work_admit(p0:*i64,p1:*i64)->i64;
extern fn jj_licm_admit(p0:*i64,p1:*i64)->i64;

fn jj_loop_invariant_s32(v:i64)->i64{if (v&0x80000000)!=0{return v|0xffffffff00000000;}return v&0xffffffff;}
fn jj_loop_invariant_disp(slot:i64)->i64{return 0-((slot+1)*8);}
fn jj_loop_invariant_wr32(p:*i8,v:i64)->i64{p[0]=v&255;p[1]=(v>>>8)&255;p[2]=(v>>>16)&255;p[3]=(v>>>24)&255;return 1;}
fn jj_loop_invariant_nop(p:*i8,begin:i64,end:i64)->i64{var i:i64=begin;while i<end{p[i]=0x90;i=i+1;}return 1;}
fn jj_loop_invariant_ref_kind(code:*i8,at:i64,limit:i64,slot:i64)->i64{
 if code==0{return 0;}if at<0{return 0;}var d:i64=jj_loop_invariant_disp(slot);
 if at+6<=limit{if ((code[at])&255)==0xff{if ((code[at+1])&255)==0xb5{if jj_loop_invariant_s32(jj_vm_rd32(code+at+2))==d{return 1;}}}}
 if at+7<=limit{if code[at]==0x48{if ((code[at+1])&255)==0x8b{var m:i64=(code[at+2])&255;if jj_loop_invariant_s32(jj_vm_rd32(code+at+3))==d{if m==0x85{return 2;}if m==0x8d{return 3;}if m==0x95{return 4;}if m==0xb5{return 5;}if m==0xbd{return 6;}}}}}
 return 0;
}
fn jj_loop_invariant_patch_refs(code:*i8,begin:i64,finish:i64,slot:i64)->i64{
 if code==0{return 0;}if begin<0{return 0;}if finish<=begin{return 0;}var count:i64=0;var at:i64=begin;
 while at<finish{var k:i64=jj_loop_invariant_ref_kind(code,at,finish,slot);if k==0{at=at+1;}else{count=count+1;if k==1{code[at]=0x41;code[at+1]=0x51;jj_loop_invariant_nop(code,at+2,at+6);at=at+6;}else{code[at]=0x4c;code[at+1]=0x89;if k==2{code[at+2]=0xc8;}if k==3{code[at+2]=0xc9;}if k==4{code[at+2]=0xca;}if k==5{code[at+2]=0xce;}if k==6{code[at+2]=0xcf;}jj_loop_invariant_nop(code,at+3,at+7);at=at+7;}}}
 return count;
}
fn jj_loop_invariant_call(op:i64)->i64{if op==29{return 1;}if op==33{return 1;}if op==34{return 1;}if op==35{return 1;}if op==36{return 1;}if op==49{return 1;}return 0;}
fn jj_loop_invariant_slot_index(slots:*i64,count:i64,slot:i64)->i64{if slots==0{return 0-1;}var i:i64=0;while i<count{if slots[i]==slot{return i;}i=i+1;}return 0-1;}

fn jj_loop_invariant_slot_at(code:*i8,at:i64,limit:i64)->i64{
 if code==0{return 0-1;}if at<0{return 0-1;}var d:i64=0;var ok:i64=0;
 if at+6<=limit{if ((code[at])&255)==0xff{if ((code[at+1])&255)==0xb5{d=jj_loop_invariant_s32(jj_vm_rd32(code+at+2));ok=1;}}}
 if ok==0{if at+7<=limit{if code[at]==0x48{if ((code[at+1])&255)==0x8b{var m:i64=(code[at+2])&255;if m==0x85{d=jj_loop_invariant_s32(jj_vm_rd32(code+at+3));ok=1;}if m==0x8d{d=jj_loop_invariant_s32(jj_vm_rd32(code+at+3));ok=1;}if m==0x95{d=jj_loop_invariant_s32(jj_vm_rd32(code+at+3));ok=1;}if m==0xb5{d=jj_loop_invariant_s32(jj_vm_rd32(code+at+3));ok=1;}if m==0xbd{d=jj_loop_invariant_s32(jj_vm_rd32(code+at+3));ok=1;}}}}}
 if ok==0{return 0-1;}if d>=0{return 0-1;}var n:i64=0-d;if (n&7)!=0{return 0-1;}var slot:i64=(n>>>3)-1;if slot<0{return 0-1;}if slot>32767{return 0-1;}return slot;
}
fn jj_loop_invariant_count_refs(code:*i8,begin:i64,finish:i64,slot:i64)->i64{
 if code==0{return 0;}if begin<0{return 0;}if finish<=begin{return 0;}var count:i64=0;var at:i64=begin;
 while at<finish{var k:i64=jj_loop_invariant_ref_kind(code,at,finish,slot);if k==0{at=at+1;}else{count=count+1;if k==1{at=at+6;}else{at=at+7;}}}return count;
}
fn jj_loop_invariant_candidate(ctx:*i64,li:i64,out:*i64)->i64{
 if ctx==0{return 0;}if out==0{return 0;}var oi:i64=0;while oi<16{out[oi]=0;oi=oi+1;}var code:*i8=ctx[0] as *i8;var old_size:i64=ctx[1];var program:*i8=ctx[2] as *i8;var start:i64=ctx[3];var end:i64=ctx[4];var argc:i64=ctx[5];var loops:*i64=ctx[7] as *i64;var accs:*i64=ctx[9] as *i64;var temps:*i64=ctx[12] as *i64;var address:*i64=ctx[13] as *i64;
 if code==0{return 0;}if program==0{return 0;}if loops==0{return 0;}if accs==0{return 0;}if temps==0{return 0;}if address==0{return 0;}
 var aa:i64=li*8;var acc_slot:i64=0-1;var temp_slot:i64=0-1;if accs[aa]!=0{return 0;}if temps[aa]!=0{temp_slot=temps[aa+1];}
 var la:i64=li*10;var header:i64=loops[la];var exit_pc:i64=loops[la+1];var induction:i64=loops[la+4];var p0:i64=header;if program[p0]!=2{return 0;}var p1:i64=p0+jj_n_bc_len(program,p0,end);if p1<=p0{return 0;}if program[p1]!=2{return 0;}var bound:i64=jj_vm_rd16(program+p1+1);var p2:i64=p1+jj_n_bc_len(program,p1,end);if p2<=p1{return 0;}var p3:i64=p2+jj_n_bc_len(program,p2,end);if p3<=p2{return 0;}var body:i64=p3+jj_n_bc_len(program,p3,end);if body<=p3{return 0;}if body>=exit_pc{return 0;}
 var slots:[64]i64;var loads:[64]i64;var stores:[64]i64;var count:i64=0;var pc:i64=body;
 while pc<exit_pc{var op:i64=program[pc];if jj_loop_invariant_call(op)!=0{return 0;}if op==48{return 0;}if op==2{var s:i64=jj_vm_rd16(program+pc+1);if s!=induction{if s!=bound{if s!=acc_slot{if s!=temp_slot{var at:i64=jj_loop_invariant_slot_index(slots as *i64,count,s);if at<0{if count>=64{return 0;}at=count;slots[count]=s;loads[count]=0;stores[count]=0;count=count+1;}loads[at]=loads[at]+1;}}}}}if op==3{var s2:i64=jj_vm_rd16(program+pc+1);var at2:i64=jj_loop_invariant_slot_index(slots as *i64,count,s2);if at2<0{if count>=64{return 0;}at2=count;slots[count]=s2;loads[count]=0;stores[count]=0;count=count+1;}stores[at2]=stores[at2]+1;}var nx:i64=jj_n_bc_len(program,pc,exit_pc);if nx<=0{return 0;}pc=pc+nx;}if pc!=exit_pc{return 0;}
 var body_old:i64=jj_n_offset_for_pc(program,start,end,argc,body);var exit_old:i64=jj_n_offset_for_pc(program,start,end,argc,exit_pc);if body_old<0{return 0;}if exit_old<=body_old{return 0;}if exit_old>old_size{return 0;}if exit_old-body_old>600{return 0;}
 var best_slot:i64=0-1;var best_uses:i64=0;var machine:i64=0;var ci:i64=0;while ci<count{var slot:i64=slots[ci];if stores[ci]==0{if jj_loop_liveout_array_overlap(program,start,end,slot)==0{var refs:i64=jj_loop_invariant_count_refs(code,body_old,exit_old,slot);if refs>=3{if refs>machine{best_slot=slot;best_uses=loads[ci];machine=refs;}else{if refs==machine{if best_slot<0{best_slot=slot;best_uses=loads[ci];}else{if slot<best_slot{best_slot=slot;best_uses=loads[ci];}}}}}}}ci=ci+1;}
 if best_slot<0{var raw_slots:[64]i64;var raw_counts:[64]i64;var raw_n:i64=0;var ma:i64=body_old;while ma<exit_old{var rs:i64=jj_loop_invariant_slot_at(code,ma,exit_old);if rs<0{ma=ma+1;}else{var ri:i64=jj_loop_invariant_slot_index(raw_slots as *i64,raw_n,rs);if ri<0{if raw_n>=64{return 0;}ri=raw_n;raw_slots[raw_n]=rs;raw_counts[raw_n]=0;raw_n=raw_n+1;}raw_counts[ri]=raw_counts[ri]+1;if ma+6<=exit_old{if ((code[ma])&255)==0xff{ma=ma+6;}else{ma=ma+7;}}else{ma=ma+1;}}}var rj:i64=0;while rj<raw_n{var rs2:i64=raw_slots[rj];var si:i64=jj_loop_invariant_slot_index(slots as *i64,count,rs2);if si>=0{if rs2!=induction{if rs2!=bound{if rs2!=acc_slot{if rs2!=temp_slot{if stores[si]==0{if raw_counts[rj]>=3{if jj_loop_liveout_array_overlap(program,start,end,rs2)==0{if raw_counts[rj]>machine{best_slot=rs2;best_uses=loads[si];machine=raw_counts[rj];}}}}}}}}}rj=rj+1;}}
 if best_slot<0{return 0;}
 var before:[6]i64;var after:[6]i64;before[0]=machine+1;before[1]=3;before[2]=0;before[3]=machine;before[4]=35+machine*7;before[5]=0;after[0]=1;after[1]=3;after[2]=0;after[3]=0;after[4]=before[4];after[5]=0;var cand:[6]i64;var lp:[6]i64;cand[0]=1;cand[1]=0;cand[2]=0;cand[3]=1;cand[4]=best_slot;cand[5]=1;lp[0]=0;lp[1]=0;lp[2]=0;lp[3]=0;lp[4]=1;lp[5]=0;if jj_transform_work_admit(before as *i64,after as *i64)==0{return 0;}if jj_licm_admit(cand as *i64,lp as *i64)==0{return 0;}
 out[0]=1;out[1]=li;out[2]=best_slot;out[3]=bound;out[4]=machine;out[5]=body_old;out[6]=exit_old;out[7]=loops[la+6];out[8]=loops[la+8];out[9]=best_uses;return 1;
}
fn jj_loop_invariant_plan(ctx:*i64)->i64{
 if ctx==0{return 0-1;}var plan:*i64=ctx[14] as *i64;if plan==0{return 0-1;}var z:i64=0;while z<16{plan[z]=0;z=z+1;}var n:i64=ctx[8];if n<0{return 0-1;}var li:i64=0;var found:i64=0;while li<n{var one:[16]i64;var oz:i64=0;while oz<16{one[oz]=0;oz=oz+1;}if jj_loop_invariant_candidate(ctx,li,one as *i64)!=0{if one[0]!=1{return 0-1;}if found==0{var j:i64=0;while j<16{plan[j]=one[j];j=j+1;}found=1;}else{if one[9]>plan[9]{var k:i64=0;while k<16{plan[k]=one[k];k=k+1;}}else{if one[9]==plan[9]{if one[2]<plan[2]{var q:i64=0;while q<16{plan[q]=one[q];q=q+1;}}}}}}li=li+1;}if found!=0{if plan[0]!=1{return 0-1;}}return found;
}
fn jj_loop_invariant_apply(ctx:*i64,map:*i64,used:i64)->i64{
 if ctx==0{return 0;}if map==0{return 0;}var plan:*i64=ctx[14] as *i64;if plan==0{return 0;}if plan[0]==0{return used;}if plan[0]!=1{return 0;}var code:*i8=ctx[0] as *i8;var index:*i64=map[0] as *i64;var count:i64=map[1];var old_size:i64=map[2];if code==0{return 0;}if index==0{return 0;}if count<0{return 0;}if old_size<=0{return 0;}if plan[2]<0{return 0;}if plan[3]<0{return 0;}if plan[4]<3{return 0;}if plan[5]<0{return 0;}if plan[6]<=plan[5]{return 0;}if plan[6]>old_size{return 0;}if plan[7]<0{return 0;}if plan[8]<0{return 0;}var h:i64=jj_coldtail_map_index(index,count,old_size,plan[7],1);var b:i64=jj_coldtail_map_index(index,count,old_size,plan[8],1);var body:i64=jj_coldtail_map_index(index,count,old_size,plan[5],1);var exit_at:i64=jj_coldtail_map_index(index,count,old_size,plan[6],1);if h<0{return 0;}if b<0{return 0;}if body<0{return 0;}if exit_at<=body{return 0;}if h+31>old_size{return 0;}if b+5>old_size{return 0;}if exit_at>old_size{return 0;}if code[h]!=0x4c{return 0;}if ((code[h+1])&255)!=0x8b{return 0;}if ((code[h+2])&255)!=0x95{return 0;}if code[h+7]!=0x48{return 0;}if ((code[h+8])&255)!=0x8b{return 0;}if ((code[h+9])&255)!=0x8d{return 0;}if jj_loop_invariant_s32(jj_vm_rd32(code+h+10))!=jj_loop_invariant_disp(plan[3]){return 0;}if code[h+14]!=0x49{return 0;}if code[h+15]!=0x39{return 0;}if ((code[h+16])&255)!=0xca{return 0;}if code[h+17]!=0x0f{return 0;}var cond:i64=(code[h+18])&255;if cond<0x80{return 0;}if cond>0x8f{return 0;}var target:i64=h+23+jj_loop_invariant_s32(jj_vm_rd32(code+h+19));if target!=exit_at{return 0;}if ((code[b])&255)!=0xe9{return 0;}var refs:i64=jj_loop_invariant_count_refs(code,body,exit_at,plan[2]);if refs!=plan[4]{return 0;}var nd:i64=target-(h+27);var back_target:i64=h+14;var bd:i64=back_target-(b+5);
 code[h+7]=0x4c;code[h+8]=0x8b;code[h+9]=0x8d;jj_loop_invariant_wr32(code+h+10,jj_loop_invariant_disp(plan[2]));code[h+14]=0x4c;code[h+15]=0x3b;code[h+16]=0x95;jj_loop_invariant_wr32(code+h+17,jj_loop_invariant_disp(plan[3]));code[h+21]=0x0f;code[h+22]=cond;jj_loop_invariant_wr32(code+h+23,nd);code[h+27]=0x0f;code[h+28]=0x1f;code[h+29]=0x40;code[h+30]=0x6c;jj_loop_invariant_patch_refs(code,body,exit_at,plan[2]);jj_loop_invariant_wr32(code+b+1,bd);plan[10]=h;plan[11]=body;plan[12]=exit_at;plan[13]=b;return used;
}
fn jj_loop_invariant_update_receipt(ctx:*i64)->i64{if ctx==0{return 0;}var plan:*i64=ctx[14] as *i64;var rr:*i64=ctx[10] as *i64;var fid:i64=ctx[11];if plan==0{return 0;}if rr==0{return 0;}if fid<0{return 0;}if plan[0]==0{return 1;}if plan[0]!=1{return 0;}var pk:i64=rr[fid];var rc:i64=(pk>>>16)&65535;var fp:i64=(pk>>>32)&65535;var nd:i64=(pk>>>48)&65535;if rc>=65535{return 0;}if nd>65532{return 0;}var tk:i64=(0x91+plan[2]*3+plan[3]*5+plan[4]*7+plan[9]*11)&65535;rr[fid]=(pk&65535)|((rc+1)<<16)|(((fp*257+tk)&65535)<<32)|((nd+3)<<48);return 1;}
fn jj_loop_invariant_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<8{return 0;}out[0]=16;out[1]=64;out[2]=1;out[3]=3;out[4]=0;out[5]=0;out[6]=0;out[7]=0;return 1;}
