// target-neutral dominator storage over four caller-provided 256-word lanes.
fn jj_lg_zero(p:*i64,n:i64)->i64{if p==0{return 0;}var i:i64=0;while i<n{p[i]=0;i=i+1;}return 1;}
fn jj_lg_dom_get(d:*i64,node:i64,w:i64)->i64{var p:*i64=d[w] as *i64;return p[node];}
fn jj_lg_dom_set(d:*i64,node:i64,w:i64,v:i64)->i64{var p:*i64=d[w] as *i64;p[node]=v;return 1;}
fn jj_lg_dom_has(d:*i64,node:i64,x:i64)->i64{return jj_lg_dom_get(d,node,x>>>6)&(1<<(x&63));}
fn jj_lg_edge(a:*i64,b:*i64,from:i64,to:i64)->i64{if a[from]==to{return 1;}if b[from]==to{return 1;}return 0;}
fn jj_lg_prepare(ctx:*i64,r:*i64,d:*i64)->i64{
 if ctx==0{return 0;}if r==0{return 0;}if d==0{return 0;}var plan:*i64=ctx[0] as *i64;var n:i64=ctx[1];var locals:i64=ctx[2];var reach:*i64=ctx[6] as *i64;var a:*i64=ctx[7] as *i64;var b:*i64=ctx[8] as *i64;if plan==0{return 0;}if reach==0{return 0;}if a==0{return 0;}if b==0{return 0;}if d[0]==0{return 0;}if d[1]==0{return 0;}if d[2]==0{return 0;}if d[3]==0{return 0;}if n<1{return 0;}if n>256{return 0;}if locals<0{return 0;}if plan[0]!=0x4a4a42504c414e31{return 0;}if plan[1]!=1{return 0;}if plan[2]!=n{return 0;}jj_lg_zero(r,16);var i:i64=0;var edges:i64=0;while i<n{if reach[i]!=0{if reach[i]!=1{return 0;}r[3]=r[3]+1;}if a[i]<0{if a[i]!=0-1{return 0;}}else{if a[i]>=n{return 0;}edges=edges+1;}if b[i]<0{if b[i]!=0-1{return 0;}}else{if b[i]>=n{return 0;}edges=edges+1;}i=i+1;}if reach[0]==0{return 0;}if edges!=plan[3]{return 0;}r[2]=n;r[4]=edges;return 1;
}
