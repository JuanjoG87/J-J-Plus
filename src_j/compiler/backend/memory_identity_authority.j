// R720 bounded memory identity. Records are explicit and sealed; no pointer
// provenance or arbitrary alias claim is inferred from an address value.
fn jj_mem_identity_seal(r:*i64)->i64{
 if r==0{return 0;}return (r as i64)^r[0]^(r[1]<<7)^(r[2]<<13)^(r[3]<<19)^(r[4]<<29)^(r[5]<<37)^0x4a4a4d454d494431;
}
fn jj_mem_identity_bind(r:*i64,kind:i64,object_id:i64,offset:i64,width:i64,version:i64)->i64{
 if r==0{return 0;}if kind<1{return 0;}if kind>3{return 0;}if object_id<0{return 0;}if offset<0{return 0;}if width<=0{return 0;}if width>8{return 0;}if offset>0x7fffffff-width{return 0;}if version<0{return 0;}
 var flags:i64=0;if kind==3{flags=1;}r[0]=kind;r[1]=object_id;r[2]=offset;r[3]=width;r[4]=version;r[5]=flags;r[6]=jj_mem_identity_seal(r);if r[6]==0{return 0;}return 1;
}
fn jj_mem_identity_valid(r:*i64)->i64{if r==0{return 0;}if r[0]<1{return 0;}if r[0]>3{return 0;}if r[1]<0{return 0;}if r[2]<0{return 0;}if r[3]<=0{return 0;}if r[3]>8{return 0;}if r[2]>0x7fffffff-r[3]{return 0;}if r[4]<0{return 0;}if r[5]<0{return 0;}if r[5]>3{return 0;}if r[6]!=jj_mem_identity_seal(r){return 0;}return 1;}
fn jj_mem_identity_same_object(a:*i64,b:*i64)->i64{if jj_mem_identity_valid(a)==0{return 0;}if jj_mem_identity_valid(b)==0{return 0;}if a[0]!=b[0]{return 0;}if a[1]!=b[1]{return 0;}return 1;}
fn jj_mem_identity_same_range(a:*i64,b:*i64)->i64{if jj_mem_identity_same_object(a,b)==0{return 0;}if a[2]!=b[2]{return 0;}if a[3]!=b[3]{return 0;}return 1;}
fn jj_mem_identity_overlap(a:*i64,b:*i64)->i64{if jj_mem_identity_same_object(a,b)==0{return 0;}var ae:i64=a[2]+a[3];var be:i64=b[2]+b[3];if ae<=b[2]{return 0;}if be<=a[2]{return 0;}return 1;}
fn jj_mem_identity_disjoint(a:*i64,b:*i64)->i64{if jj_mem_identity_valid(a)==0{return 0;}if jj_mem_identity_valid(b)==0{return 0;}if a[0]==1{if b[0]==1{if a[1]!=b[1]{return 1;}}}if a[0]==2{if b[0]==2{if a[1]!=b[1]{return 1;}}}if jj_mem_identity_same_object(a,b)!=0{if jj_mem_identity_overlap(a,b)==0{return 1;}}return 0;}
fn jj_mem_identity_forwardable(store:*i64,load:*i64)->i64{if jj_mem_identity_same_range(store,load)==0{return 0;}if store[4]!=load[4]{return 0;}if (store[5]&1)!=0{return 0;}if (load[5]&1)!=0{return 0;}return 1;}
fn jj_mem_identity_local(r:*i64,slot:i64,width:i64,version:i64)->i64{if slot<0{return 0;}if slot>32767{return 0;}return jj_mem_identity_bind(r,1,slot,0,width,version);}
fn jj_mem_identity_external(r:*i64,parameter:i64,offset:i64,width:i64,version:i64)->i64{if parameter<0{return 0;}return jj_mem_identity_bind(r,3,parameter,offset,width,version);}
fn jj_mem_identity_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<8{return 0;}out[0]=7;out[1]=8;out[2]=3;out[3]=32768;out[4]=0;out[5]=0;out[6]=0;out[7]=0;return 1;}
