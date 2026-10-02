// Bounded equivalence portfolio for pure linear CIR v1. This is deliberately
// not an unbounded e-graph: it applies a finite, auditable set of integer
// identities and constant folds, then leaves deduplication, DCE and pressure
// scheduling to the existing CIR scheduler. No memory, calls or control nodes
// are accepted by linear CIR v1.
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_cir_begin(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_add_argument(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_add_constant(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_add_binary(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_cir_finish(p0:*i64,p1:i64,p2:i64)->i64;

fn jj_cbe_bytes(slots:i64)->i64{if slots<=0{return 0;}if slots>0x0fffffffffffffff{return 0;}return slots*8;}
fn jj_cbe_nonoverlap(a:*i64,aslots:i64,b:*i64,bslots:i64)->i64{if a==0{return 0;}if b==0{return 0;}var an:i64=jj_cbe_bytes(aslots);var bn:i64=jj_cbe_bytes(bslots);if an==0{return 0;}if bn==0{return 0;}var aa:i64=a as i64;var ba:i64=b as i64;if aa<=0{return 0;}if ba<=0{return 0;}if aa<ba{if ba-aa<an{return 0;}}else{if aa-ba<bn{return 0;}}return 1;}
fn jj_cbe_zero(p:*i64,slots:i64)->i64{if p==0{return 0;}if slots<=0{return 0;}var i:i64=0;while i<slots{p[i]=0;i=i+1;}return 1;}
fn jj_cbe_node(cir:*i64,value:i64)->i64{if value<=0{return 0;}return 8+(value-1)*4;}
fn jj_cbe_find_argument(cir:*i64,arg_index:i64)->i64{var value:i64=1;while value<=cir[2]{var nb:i64=jj_cbe_node(cir,value);if cir[nb]==1{if cir[nb+2]==arg_index{return value;}}value=value+1;}return 0;}
fn jj_cbe_find_constant(cir:*i64,constant:i64)->i64{var value:i64=1;while value<=cir[2]{var nb:i64=jj_cbe_node(cir,value);if cir[nb]==2{if cir[nb+3]==constant{return value;}}value=value+1;}return 0;}
fn jj_cbe_commutative(op:i64)->i64{if op==9{return 1;}if op==11{return 1;}if op==16{return 1;}if op==17{return 1;}if op==18{return 1;}return 0;}
fn jj_cbe_find_binary(cir:*i64,op:i64,a:i64,b:i64)->i64{var ca:i64=a;var cb:i64=b;if jj_cbe_commutative(op)!=0{if ca>cb{var t:i64=ca;ca=cb;cb=t;}}var value:i64=1;while value<=cir[2]{var nb:i64=jj_cbe_node(cir,value);if cir[nb]==op{var ea:i64=cir[nb+2];var eb:i64=cir[nb+3];if jj_cbe_commutative(op)!=0{if ea>eb{var t2:i64=ea;ea=eb;eb=t2;}}if ea==ca{if eb==cb{return value;}}}value=value+1;}return 0;}
fn jj_cbe_emit_constant(out:*i64,out_slots:i64,value:i64)->i64{var found:i64=jj_cbe_find_constant(out,value);if found!=0{return found;}return jj_cir_add_constant(out,out_slots,value);}
fn jj_cbe_emit_binary(out:*i64,out_slots:i64,op:i64,a:i64,b:i64)->i64{var found:i64=jj_cbe_find_binary(out,op,a,b);if found!=0{return found;}return jj_cir_add_binary(out,out_slots,op,a,b);}
fn jj_cbe_fold(op:i64,x:i64,y:i64)->i64{if op==9{return x+y;}if op==10{return x-y;}if op==11{return x*y;}if op==16{return x&y;}if op==17{return x|y;}if op==18{return x^y;}return 0;}

// rule result: 0=emit binary, 1=lhs, 2=rhs, 3=zero, 4=minus-one,
// 5=constant fold. Context: op, mapped lhs/rhs, lhs/rhs constant flags/values.
fn jj_cbe_rule(c:*i64)->i64{if c==0{return 0;}var op:i64=c[0];var ma:i64=c[1];var mb:i64=c[2];var ca:i64=c[3];var cb:i64=c[4];var av:i64=c[5];var bv:i64=c[6];if ca!=0{if cb!=0{return 5;}}
 if op==9{if ca!=0{if av==0{return 2;}}if cb!=0{if bv==0{return 1;}}return 0;}
 if op==10{if cb!=0{if bv==0{return 1;}}if ma==mb{return 3;}return 0;}
 if op==11{if ca!=0{if av==0{return 3;}if av==1{return 2;}}if cb!=0{if bv==0{return 3;}if bv==1{return 1;}}return 0;}
 if op==16{if ca!=0{if av==0{return 3;}if av==0xffffffffffffffff{return 2;}}if cb!=0{if bv==0{return 3;}if bv==0xffffffffffffffff{return 1;}}if ma==mb{return 1;}return 0;}
 if op==17{if ca!=0{if av==0{return 2;}if av==0xffffffffffffffff{return 4;}}if cb!=0{if bv==0{return 1;}if bv==0xffffffffffffffff{return 4;}}if ma==mb{return 1;}return 0;}
 if op==18{if ca!=0{if av==0{return 2;}}if cb!=0{if bv==0{return 1;}}if ma==mb{return 3;}return 0;}
 return 0;}

fn jj_cbe_binary(input:*i64,value:i64,output:*i64,output_slots:i64,workspace:*i64,stride:i64)->i64{var nb:i64=jj_cbe_node(input,value);var op:i64=input[nb];var a:i64=input[nb+2];var b:i64=input[nb+3];if a<=0{return 0;}if b<=0{return 0;}if a>=value{return 0;}if b>=value{return 0;}var ma:i64=workspace[a];var mb:i64=workspace[b];if ma<=0{return 0;}if mb<=0{return 0;}var ca:i64=workspace[stride+a];var cb:i64=workspace[stride+b];var av:i64=workspace[stride*2+a];var bv:i64=workspace[stride*2+b];var context:[7]i64;context[0]=op;context[1]=ma;context[2]=mb;context[3]=ca;context[4]=cb;context[5]=av;context[6]=bv;var rule:i64=jj_cbe_rule(context as *i64);var next:i64=0;var known:i64=0;var cv:i64=0;
 if rule==1{next=ma;known=ca;cv=av;}else{if rule==2{next=mb;known=cb;cv=bv;}else{if rule==3{cv=0;next=jj_cbe_emit_constant(output,output_slots,cv);known=1;}else{if rule==4{cv=0xffffffffffffffff;next=jj_cbe_emit_constant(output,output_slots,cv);known=1;}else{if rule==5{cv=jj_cbe_fold(op,av,bv);next=jj_cbe_emit_constant(output,output_slots,cv);known=1;}else{next=jj_cbe_emit_binary(output,output_slots,op,ma,mb);}}}}}
 if next<=0{return 0;}workspace[value]=next;workspace[stride+value]=known;workspace[stride*2+value]=cv;return next;}

fn jj_cir_bounded_equivalence(input:*i64,input_slots:i64,output:*i64,output_slots:i64,workspace:*i64,workspace_slots:i64)->i64{if input==0{return 0;}if output==0{return 0;}if workspace==0{return 0;}if jj_cir_validate(input,input_slots)==0{return 0;}if input[1]!=1{return 0;}var count:i64=input[2];if count<=0{return 0;}if count>(0x7fffffffffffffff/3)-1{return 0;}var stride:i64=count+1;var need:i64=stride*3;if workspace_slots<need{return 0;}if jj_cbe_nonoverlap(input,input_slots,output,output_slots)==0{return 0;}if jj_cbe_nonoverlap(input,input_slots,workspace,workspace_slots)==0{return 0;}if jj_cbe_nonoverlap(output,output_slots,workspace,workspace_slots)==0{return 0;}if jj_cbe_zero(workspace,need)==0{return 0;}if jj_cir_begin(output,output_slots,input[4],input[5])==0{return 0;}var value:i64=1;
 while value<=count{var nb:i64=jj_cbe_node(input,value);var op:i64=input[nb];var next:i64=0;if op==1{next=jj_cbe_find_argument(output,input[nb+2]);if next==0{next=jj_cir_add_argument(output,output_slots,input[nb+2]);}workspace[value]=next;}else{if op==2{var cv:i64=input[nb+3];next=jj_cbe_emit_constant(output,output_slots,cv);workspace[value]=next;workspace[stride+value]=1;workspace[stride*2+value]=cv;}else{next=jj_cbe_binary(input,value,output,output_slots,workspace,stride);}}if next<=0{return 0;}value=value+1;}
 var result:i64=workspace[input[6]];if result<=0{return 0;}if jj_cir_finish(output,output_slots,result)==0{return 0;}if jj_cir_validate(output,output_slots)==0{return 0;}return 1;}
fn jj_cir_bounded_equivalence_resource_contract(out:*i64,slots:i64)->i64{if out==0{return 0;}if slots!=8{return 0;}out[0]=24;out[1]=3;out[2]=13;out[3]=0;out[4]=1;out[5]=1;out[6]=1;out[7]=(out as i64)^0x4a4a434245515631;return 1;}
