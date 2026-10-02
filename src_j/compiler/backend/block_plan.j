// jj_file: src_j/compiler/backend/block_plan.j
// block plan bounded target-neutral basic-block plan. This is analysis authority for
// CFG-sensitive reactions; unsupported large functions fall back unchanged.
extern fn jj_n_bc_len(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_vm_rd32(p0:*i8)->i64;
extern fn jj_bp_semantic_classify(p0:*i64)->i64;

fn jj_bp_add_boundary(plan:*i64,count:i64,pc:i64)->i64{
  if plan==0{return 0-1;}if count<0{return 0-1;}if count>=510{return 0;}
  var i:i64=0;while i<count{if plan[16+i]==pc{return count;}i=i+1;}
  plan[16+count]=pc;return count+1;
}

fn jj_bp_sort_boundaries(plan:*i64,count:i64)->i64{
  if plan==0{return 0;}if count<2{return 1;}var i:i64=1;
  while i<count{var key:i64=plan[16+i];var j:i64=i;while j>0{if plan[16+j-1]<=key{break;}plan[16+j]=plan[16+j-1];j=j-1;}plan[16+j]=key;i=i+1;}return 1;
}

fn jj_bp_block_index(plan:*i64,pc:i64)->i64{
  if plan==0{return 0-1;}if plan[0]!=0x4a4a42504c414e31{return 0-1;}if plan[1]<1{return 0-1;}if plan[1]>2{return 0-1;}var count:i64=plan[2];var i:i64=0;
  while i<count{var b:i64=16+i*8;if plan[b]==pc{return i;}i=i+1;}return 0-1;
}

fn jj_bp_build(program:*i8,start:i64,end:i64,plan:*i64)->i64{
  if program==0{return 0-1;}if plan==0{return 0-1;}if start<0{return 0-1;}if end<=start{return 0-1;}
  plan[0]=0x4a4a42504c414e31;plan[1]=0;plan[2]=0;plan[3]=0;plan[4]=0;plan[5]=0;plan[6]=start;plan[7]=end;
  var boundaries:i64=0;boundaries=jj_bp_add_boundary(plan,boundaries,start);if boundaries<=0{return boundaries;}
  boundaries=jj_bp_add_boundary(plan,boundaries,end);if boundaries<=0{return boundaries;}
  var pc:i64=start;var op_count:i64=0;var event_overflow:i64=0;
  while pc<end{
    if op_count<2032{plan[2064+op_count]=pc;}else{event_overflow=1;}op_count=op_count+1;
    var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0-1;}var next:i64=pc+n;if next> end{return 0-1;}var op:i64=program[pc];
    if op==27{var target:i64=jj_vm_rd32(program+pc+1);if target<start{return 0-1;}if target>=end{return 0-1;}boundaries=jj_bp_add_boundary(plan,boundaries,target);if boundaries<=0{return boundaries;}if next<end{boundaries=jj_bp_add_boundary(plan,boundaries,next);if boundaries<=0{return boundaries;}}}
    else{if op==28{var ztarget:i64=jj_vm_rd32(program+pc+1);if ztarget<start{return 0-1;}if ztarget>=end{return 0-1;}boundaries=jj_bp_add_boundary(plan,boundaries,ztarget);if boundaries<=0{return boundaries;}if next<end{boundaries=jj_bp_add_boundary(plan,boundaries,next);if boundaries<=0{return boundaries;}}}
    else{if op==30{if next<end{boundaries=jj_bp_add_boundary(plan,boundaries,next);if boundaries<=0{return boundaries;}}}}}
    pc=next;
  }
  if pc!=end{return 0-1;}if jj_bp_sort_boundaries(plan,boundaries)==0{return 0-1;}if boundaries<2{return 0-1;}var block_count:i64=boundaries-1;if block_count>509{return 0;}if block_count>256{event_overflow=1;}
  var bi:i64=block_count;while bi>0{bi=bi-1;var src:i64=16+bi;var dst:i64=16+bi*8;plan[dst]=plan[src];plan[dst+1]=plan[src+1];plan[dst+2]=0-1;plan[dst+3]=0-1;plan[dst+4]=0-1;plan[dst+5]=0;plan[dst+6]=0;plan[dst+7]=0;}
  plan[1]=1;plan[2]=block_count;
  var walk_pc:i64=start;bi=0;while bi<block_count{var bb:i64=16+bi*8;var begin:i64=plan[bb];var bend:i64=plan[bb+1];if walk_pc!=begin{return 0-1;}var last:i64=0-1;while walk_pc<bend{last=walk_pc;var wn:i64=jj_n_bc_len(program,walk_pc,bend);if wn<=0{return 0-1;}walk_pc=walk_pc+wn;}if walk_pc!=bend{return 0-1;}if last<begin{return 0-1;}plan[bb+2]=last;var lop:i64=program[last];
    if lop==27{var t:i64=jj_vm_rd32(program+last+1);if jj_bp_block_index(plan,t)<0{return 0-1;}plan[bb+3]=t;plan[bb+6]=1;}
    else{if lop==28{var zt:i64=jj_vm_rd32(program+last+1);if jj_bp_block_index(plan,zt)<0{return 0-1;}plan[bb+3]=zt;if bend<end{if jj_bp_block_index(plan,bend)<0{return 0-1;}plan[bb+4]=bend;}plan[bb+6]=2;}
    else{if lop==30{plan[bb+6]=4;}else{if bend<end{if jj_bp_block_index(plan,bend)<0{return 0-1;}plan[bb+3]=bend;}}}}
    bi=bi+1;
  }
  var edges:i64=0;bi=0;while bi<block_count{var from:i64=16+bi*8;var s0:i64=plan[from+3];var s1:i64=plan[from+4];if s0>=0{var si:i64=jj_bp_block_index(plan,s0);if si<0{return 0-1;}plan[16+si*8+5]=plan[16+si*8+5]+1;var edge_kind:i64=plan[from+6]&7;if edge_kind==1{plan[16+si*8+7]=1;}else{if edge_kind==2{plan[16+si*8+7]=1;}}edges=edges+1;if s0<=plan[from]{plan[from+6]=plan[from+6]|16;plan[16+si*8+6]=plan[16+si*8+6]|8;plan[4]=plan[4]+1;}}if s1>=0{var sj:i64=jj_bp_block_index(plan,s1);if sj<0{return 0-1;}plan[16+sj*8+5]=plan[16+sj*8+5]+1;edges=edges+1;if s1<=plan[from]{plan[from+6]=plan[from+6]|16;plan[16+sj*8+6]=plan[16+sj*8+6]|8;plan[4]=plan[4]+1;}}bi=bi+1;}
  plan[1]=1;plan[2]=block_count;plan[3]=edges;plan[5]=op_count;if event_overflow!=0{plan[5]=0;plan[1]=2;return 2;}if jj_bp_semantic_classify(plan)==0{return 0-1;}return 1;
}

fn jj_bp_compare_terminator(plan:*i64,begin_pc:i64,branch_pc:i64,end_pc:i64,target_pc:i64)->i64{
  if plan==0{return 0;}if plan[1]!=1{return 0;}var i:i64=jj_bp_block_index(plan,begin_pc);if i<0{return 0;}var b:i64=16+i*8;
  if plan[b]!=begin_pc{return 0;}if plan[b+1]!=end_pc{return 0;}if plan[b+2]!=branch_pc{return 0;}if (plan[b+6]&2)==0{return 0;}if plan[b+3]!=target_pc{return 0;}if plan[b+4]!=end_pc{return 0;}return 1;
}

