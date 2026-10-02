// Pure CIR v1 pressure scheduler and dead-node remover. It changes only the
// topological order and stable SSA ids of effect-free integer nodes. Workspace
// capacity is supplied by the caller and derived from the input node count.
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_begin(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_add_argument(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_add_constant(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_add_binary(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_cir_finish(p0:*i64,p1:i64,p2:i64)->i64;

fn jj_cps_bytes(slots:i64)->i64{if slots<=0{return 0;}if slots>0x0fffffffffffffff{return 0;}return slots*8;}
fn jj_cps_nonoverlap(a:*i64,aslots:i64,b:*i64,bslots:i64)->i64{
  if a==0{return 0;}if b==0{return 0;}var an:i64=jj_cps_bytes(aslots);var bn:i64=jj_cps_bytes(bslots);if an==0{return 0;}if bn==0{return 0;}var aa:i64=a as i64;var ba:i64=b as i64;
  if aa<=0{return 0;}if ba<=0{return 0;}if aa<ba{if ba-aa<an{return 0;}}else{if aa-ba<bn{return 0;}}return 1;
}
fn jj_cps_zero(p:*i64,slots:i64)->i64{if p==0{return 0;}if slots<=0{return 0;}var i:i64=0;while i<slots{p[i]=0;i=i+1;}return 1;}
fn jj_cps_node(cir:*i64,value:i64)->i64{if value<=0{return 0;}return 8+(value-1)*4;}
fn jj_cps_commutative(op:i64)->i64{if op==9{return 1;}if op==11{return 1;}if op==16{return 1;}if op==17{return 1;}if op==18{return 1;}return 0;}
fn jj_cps_find_argument(cir:*i64,arg_index:i64)->i64{var value:i64=1;while value<=cir[2]{var nb:i64=jj_cps_node(cir,value);if cir[nb]==1{if cir[nb+2]==arg_index{return value;}}value=value+1;}return 0;}
fn jj_cps_find_constant(cir:*i64,constant:i64)->i64{var value:i64=1;while value<=cir[2]{var nb:i64=jj_cps_node(cir,value);if cir[nb]==2{if cir[nb+3]==constant{return value;}}value=value+1;}return 0;}
fn jj_cps_find_binary(cir:*i64,op:i64,a:i64,b:i64)->i64{var ca:i64=a;var cb:i64=b;if jj_cps_commutative(op)!=0{if ca>cb{var swap:i64=ca;ca=cb;cb=swap;}}var value:i64=1;while value<=cir[2]{var nb:i64=jj_cps_node(cir,value);if cir[nb]==op{var ea:i64=cir[nb+2];var eb:i64=cir[nb+3];if jj_cps_commutative(op)!=0{if ea>eb{var swap2:i64=ea;ea=eb;eb=swap2;}}if ea==ca{if eb==cb{return value;}}}value=value+1;}return 0;}
fn jj_cps_required(cir:*i64,count:i64,work:*i64,stride:i64)->i64{
  var result:i64=cir[6];if result<=0{return 0;}work[result]=1;var value:i64=count;
  while value>=1{if work[value]!=0{var nb:i64=jj_cps_node(cir,value);var op:i64=cir[nb];if op!=1{if op!=2{var a:i64=cir[nb+2];var b:i64=cir[nb+3];if a<=0{return 0;}if b<=0{return 0;}work[a]=1;work[b]=1;}}}value=value-1;}
  var total:i64=0;value=1;while value<=count{if work[value]!=0{total=total+1;}value=value+1;}return total;
}
fn jj_cps_uses(cir:*i64,count:i64,work:*i64,stride:i64)->i64{
  var required:i64=0;var uses_base:i64=stride*3;var value:i64=1;while value<=count{if work[value]!=0{required=required+1;var nb:i64=jj_cps_node(cir,value);var op:i64=cir[nb];if op!=1{if op!=2{var a:i64=cir[nb+2];var b:i64=cir[nb+3];work[uses_base+a]=work[uses_base+a]+1;work[uses_base+b]=work[uses_base+b]+1;}}}value=value+1;}
  work[uses_base+cir[6]]=work[uses_base+cir[6]]+1;return required;
}
fn jj_cps_unlock_scores(cir:*i64,count:i64,work:*i64,stride:i64)->i64{
  var scheduled:i64=stride;var mapped:i64=stride*2;var scores:i64=stride*4;var value:i64=1;while value<=count{work[scores+value]=0;value=value+1;}value=1;
  while value<=count{if work[value]!=0{if work[scheduled+value]==0{var nb:i64=jj_cps_node(cir,value);var op:i64=cir[nb];if op!=1{if op!=2{var a:i64=cir[nb+2];var b:i64=cir[nb+3];if a==b{if work[mapped+a]==0{work[scores+a]=work[scores+a]+1;}}else{if work[mapped+a]!=0{if work[mapped+b]==0{work[scores+b]=work[scores+b]+1;}}else{if work[mapped+b]!=0{work[scores+a]=work[scores+a]+1;}}}}}}}value=value+1;}return 1;
}
fn jj_cps_binary_candidate(cir:*i64,count:i64,work:*i64,stride:i64)->i64{
  var scheduled:i64=stride;var mapped:i64=stride*2;var uses:i64=stride*3;var scores:i64=stride*4;var best:i64=0;var best_release:i64=0-1;var best_unlock:i64=0-1;var value:i64=1;
  while value<=count{if work[value]!=0{if work[scheduled+value]==0{var nb:i64=jj_cps_node(cir,value);var op:i64=cir[nb];if op!=1{if op!=2{var a:i64=cir[nb+2];var b:i64=cir[nb+3];if work[mapped+a]!=0{if work[mapped+b]!=0{var release:i64=0;if work[uses+a]==1{release=release+1;}if work[uses+b]==1{release=release+1;}var unlock:i64=work[scores+value];if release>best_release{best=value;best_release=release;best_unlock=unlock;}else{if release==best_release{if unlock>best_unlock{best=value;best_unlock=unlock;}}}}}}}}}value=value+1;}
  return best;
}
fn jj_cps_source_candidate(cir:*i64,count:i64,work:*i64,stride:i64)->i64{
  var scheduled:i64=stride;var scores:i64=stride*4;var best:i64=0;var best_unlock:i64=0-1;var value:i64=1;
  while value<=count{if work[value]!=0{if work[scheduled+value]==0{var nb:i64=jj_cps_node(cir,value);var op:i64=cir[nb];if op==1{var score:i64=work[scores+value];if score>best_unlock{best=value;best_unlock=score;}}
      else{if op==2{var score2:i64=work[scores+value];if score2>best_unlock{best=value;best_unlock=score2;}}}}}value=value+1;}return best;
}
fn jj_cir_pressure_schedule(input:*i64,input_slots:i64,output:*i64,output_slots:i64,workspace:*i64,workspace_slots:i64)->i64{
  if input==0{return 0;}if output==0{return 0;}if workspace==0{return 0;}if jj_cir_validate(input,input_slots)==0{return 0;}if input[1]!=1{return 0;}var count:i64=input[2];if count<=0{return 0;}
  if count>(0x7fffffffffffffff/5)-1{return 0;}var stride:i64=count+1;var need:i64=stride*5;if need<=0{return 0;}if workspace_slots<need{return 0;}
  if jj_cps_nonoverlap(input,input_slots,output,output_slots)==0{return 0;}if jj_cps_nonoverlap(input,input_slots,workspace,workspace_slots)==0{return 0;}if jj_cps_nonoverlap(output,output_slots,workspace,workspace_slots)==0{return 0;}
  if jj_cps_zero(workspace,need)==0{return 0;}var required:i64=jj_cps_required(input,count,workspace,stride);if required<=0{return 0;}if required>(output_slots-8)/4{return 0;}if jj_cps_uses(input,count,workspace,stride)!=required{return 0;}
  if jj_cir_begin(output,output_slots,input[4],input[5])==0{return 0;}var scheduled:i64=stride;var mapped:i64=stride*2;var uses:i64=stride*3;var emitted:i64=0;
  while emitted<required{if jj_cps_unlock_scores(input,count,workspace,stride)==0{return 0;}var chosen:i64=jj_cps_binary_candidate(input,count,workspace,stride);if chosen==0{chosen=jj_cps_source_candidate(input,count,workspace,stride);}if chosen==0{return 0;}
    var nb:i64=jj_cps_node(input,chosen);var op:i64=input[nb];var next:i64=0;if op==1{next=jj_cps_find_argument(output,input[nb+2]);if next==0{next=jj_cir_add_argument(output,output_slots,input[nb+2]);}}
    else{if op==2{next=jj_cps_find_constant(output,input[nb+3]);if next==0{next=jj_cir_add_constant(output,output_slots,input[nb+3]);}}
    else{var a:i64=input[nb+2];var b:i64=input[nb+3];var ma:i64=workspace[mapped+a];var mb:i64=workspace[mapped+b];if ma==0{return 0;}if mb==0{return 0;}next=jj_cps_find_binary(output,op,ma,mb);if next==0{next=jj_cir_add_binary(output,output_slots,op,ma,mb);}workspace[uses+a]=workspace[uses+a]-1;workspace[uses+b]=workspace[uses+b]-1;if workspace[uses+a]<0{return 0;}if workspace[uses+b]<0{return 0;}}}
    if next==0{return 0;}workspace[mapped+chosen]=next;workspace[scheduled+chosen]=1;emitted=emitted+1;
  }
  var result:i64=workspace[mapped+input[6]];if result<=0{return 0;}if jj_cir_finish(output,output_slots,result)==0{return 0;}if jj_cir_validate(output,output_slots)==0{return 0;}return 1;
}
fn jj_cir_pressure_schedule_resource_contract(out:*i64,slots:i64)->i64{if out==0{return 0;}if slots!=8{return 0;}out[0]=40;out[1]=4096;out[2]=524288;out[3]=2;out[4]=1;out[5]=1;out[6]=1;out[7]=(out as i64)^0x4a4a435053524331;return 1;}
