// R722 bounded straight-line pure-body clone. Not connected to CFG lowering.
extern fn jj_unroll_admit(p0:*i64,p1:i64,p2:i64)->i64;
fn jj_unroll_clone2(src:*i64,n:i64,dst:*i64,cap:i64)->i64{if src==0{return 0;}if dst==0{return 0;}if n<1{return 0;}if n>12{return 0;}if cap<n*4{return 0;}var i:i64=0;while i<n{dst[i*2]=src[i*2];dst[i*2+1]=src[i*2+1];i=i+1;}i=0;while i<n{dst[(n+i)*2]=src[i*2];dst[(n+i)*2+1]=src[i*2+1]+1;i=i+1;}return n*2;}
fn jj_unroll_clone_admit(loop:*i64,target:i64,factor:i64,src:*i64,n:i64,dst:*i64)->i64{if jj_unroll_admit(loop,factor,target)==0{return 0;}if factor!=2{return 0;}return jj_unroll_clone2(src,n,dst,n*4);}
