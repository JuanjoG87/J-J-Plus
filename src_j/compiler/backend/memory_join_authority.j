// R721 conservative join for bounded memory facts. Each record is
// [kind, object_id, version, escaped]. Divergent or missing facts are dropped.
fn jj_mem_join_valid(s:*i64,n:i64)->i64{if s==0{return 0;}if n<1{return 0;}if n>129{return 0;}var count:i64=s[0];if count<0{return 0;}if count>(n-1)/4{return 0;}var i:i64=0;while i<count{var at:i64=1+i*4;if s[at]<1{return 0;}if s[at]>3{return 0;}if s[at+1]<0{return 0;}if s[at+2]<1{return 0;}if s[at+3]<0{return 0;}if s[at+3]>1{return 0;}i=i+1;}return 1;}
fn jj_mem_join_find(s:*i64,n:i64,kind:i64,obj:i64)->i64{if jj_mem_join_valid(s,n)==0{return 0-1;}var i:i64=0;while i<s[0]{var at:i64=1+i*4;if s[at]==kind{if s[at+1]==obj{return i;}}i=i+1;}return 0-1;}
fn jj_mem_join_two(a:*i64,an:i64,b:*i64,bn:i64,out:*i64,on:i64)->i64{
 if jj_mem_join_valid(a,an)==0{return 0;}if jj_mem_join_valid(b,bn)==0{return 0;}if out==0{return 0;}if on<1{return 0;}
 var cap:i64=(on-1)/4;var i:i64=0;while i<on{out[i]=0;i=i+1;}var used:i64=0;i=0;
 while i<a[0]{var aa:i64=1+i*4;var j:i64=jj_mem_join_find(b,bn,a[aa],a[aa+1]);if j>=0{var bb:i64=1+j*4;if a[aa+2]==b[bb+2]{if a[aa+3]==b[bb+3]{if used>=cap{return 0;}var oo:i64=1+used*4;out[oo]=a[aa];out[oo+1]=a[aa+1];out[oo+2]=a[aa+2];out[oo+3]=a[aa+3];used=used+1;}}}i=i+1;}
 out[0]=used;return 1;
}
fn jj_mem_join_forwardable(s:*i64,n:i64,kind:i64,obj:i64,version:i64)->i64{var i:i64=jj_mem_join_find(s,n,kind,obj);if i<0{return 0;}var at:i64=1+i*4;if s[at+2]!=version{return 0;}if s[at+3]!=0{return 0;}return 1;}
fn jj_mem_join_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<8{return 0;}out[0]=129;out[1]=32;out[2]=4;out[3]=0;out[4]=0;out[5]=0;out[6]=0;out[7]=0;return 1;}
