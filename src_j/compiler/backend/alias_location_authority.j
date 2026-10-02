// R729 alias location authority v2, rival-hardened.
// Result lattice: 0 invalid, 1 NoAlias, 2 MayAlias, 3 PartialAlias, 4 MustAlias.
// Record: [magic,version,kind,object,offset,size,flags,address_space,scope,generation,reserved,seal].
// Kinds: 1 local, 2 private allocation, 3 parameter, 4 global, 5 unknown.
// Flags: volatile=1, escaped=2, readonly=4, unique=8, nontrapping=16.
fn jj_alias_location_seal(r:*i64)->i64{
 if r==0{return 0;}var h:i64=(r as i64)^0x4a4a414c4f435331;var i:i64=0;while i<12{var v:i64=r[i];if i==11{v=0;}h=((h<<7)|(h>>>57))^v^((i+1)*0x9e3779b1);i=i+1;}if h==0{h=1;}return h;
}
fn jj_alias_location_inputs(kind:i64,object_id:i64,offset:i64,size:i64,flags:i64)->i64{
 if kind<1{return 0;}if kind>5{return 0;}if object_id<0{return 0;}if offset<0{return 0;}if size<0{return 0;}if flags<0{return 0;}if (flags&0xffffffffffffffe0)!=0{return 0;}
 if offset>0x7fffffff{return 0;}if size>0x7fffffff{return 0;}if size>0{if offset>0x7fffffff-size{return 0;}}
 if kind==5{if object_id!=0{return 0;}if offset!=0{return 0;}if size!=0{return 0;}if flags!=2{return 0;}}
 return 1;
}
fn jj_alias_location_bind(r:*i64,kind:i64,object_id:i64,offset:i64,size:i64,flags:i64)->i64{
 if r==0{return 0;}if jj_alias_location_inputs(kind,object_id,offset,size,flags)==0{return 0;}
 r[0]=0x4a4a414c4f433031;r[1]=2;r[2]=kind;r[3]=object_id;r[4]=offset;r[5]=size;r[6]=flags;r[7]=0;r[8]=0;if kind==5{r[9]=0;}else{r[9]=1;}r[10]=0;r[11]=jj_alias_location_seal(r);return r[11]!=0;
}
fn jj_alias_location_valid(r:*i64)->i64{
 if r==0{return 0;}if r[0]!=0x4a4a414c4f433031{return 0;}if r[1]!=2{return 0;}if jj_alias_location_inputs(r[2],r[3],r[4],r[5],r[6])==0{return 0;}if r[7]<0{return 0;}if r[7]>255{return 0;}if r[8]<0{return 0;}if r[9]<0{return 0;}if r[10]!=0{return 0;}if r[2]!=5{if r[9]<1{return 0;}}else{if r[7]!=0{return 0;}if r[8]!=0{return 0;}if r[9]!=0{return 0;}}
 return r[11]==jj_alias_location_seal(r);
}
fn jj_alias_location_set_domain(r:*i64,address_space:i64,scope:i64,generation:i64)->i64{
 if jj_alias_location_valid(r)==0{return 0;}if r[2]==5{return 0;}if address_space<0{return 0;}if address_space>255{return 0;}if scope<0{return 0;}if generation<1{return 0;}
 r[7]=address_space;r[8]=scope;r[9]=generation;r[11]=jj_alias_location_seal(r);return r[11]!=0;
}
fn jj_alias_location_local(r:*i64,object_id:i64,offset:i64,size:i64,generation:i64)->i64{
 if generation<1{return 0;}if jj_alias_location_bind(r,1,object_id,offset,size,24)==0{return 0;}return jj_alias_location_set_domain(r,0,0,generation);
}
fn jj_alias_location_private(r:*i64,object_id:i64,offset:i64,size:i64,generation:i64)->i64{
 if generation<1{return 0;}if jj_alias_location_bind(r,2,object_id,offset,size,24)==0{return 0;}return jj_alias_location_set_domain(r,0,0,generation);
}
fn jj_alias_location_parameter(r:*i64,object_id:i64,offset:i64,size:i64,flags:i64)->i64{
 if (flags&8)!=0{return 0;}if jj_alias_location_bind(r,3,object_id,offset,size,flags)==0{return 0;}return 1;
}
fn jj_alias_location_global(r:*i64,object_id:i64,offset:i64,size:i64,flags:i64)->i64{
 if (flags&8)!=0{return 0;}if jj_alias_location_bind(r,4,object_id,offset,size,flags)==0{return 0;}return 1;
}
fn jj_alias_location_unknown(r:*i64)->i64{return jj_alias_location_bind(r,5,0,0,0,2);}
fn jj_alias_location_record_output_ok(out:*i64,base:*i64)->i64{
 if out==0{return 0;}if base==0{return 0;}if out==base{return 1;}var a:i64=out as i64;var b:i64=base as i64;if a>b{if a-b<96{return 0;}}else{if b-a<96{return 0;}}return 1;
}
fn jj_alias_location_derive(out:*i64,base:*i64,delta:i64,size:i64)->i64{
 if jj_alias_location_record_output_ok(out,base)==0{return 0;}if jj_alias_location_valid(base)==0{return 0;}if base[2]==5{return 0;}if size<0{return 0;}var offset:i64=base[4];if delta<0{if delta==0x8000000000000000{return 0;}var magnitude:i64=0-delta;if offset<magnitude{return 0;}offset=offset+delta;}else{if delta>0x7fffffff{return 0;}if offset>0x7fffffff-delta{return 0;}offset=offset+delta;}if size>0x7fffffff{return 0;}if size>0{if offset>0x7fffffff-size{return 0;}}
 var kind:i64=base[2];var object_id:i64=base[3];var flags:i64=base[6];var address_space:i64=base[7];var scope:i64=base[8];var generation:i64=base[9];if jj_alias_location_bind(out,kind,object_id,offset,size,flags)==0{return 0;}return jj_alias_location_set_domain(out,address_space,scope,generation);
}
fn jj_alias_location_escape(out:*i64,base:*i64)->i64{
 if jj_alias_location_record_output_ok(out,base)==0{return 0;}if jj_alias_location_valid(base)==0{return 0;}if base[2]==5{return 0;}var flags:i64=(base[6]|2)&0xfffffffffffffff7;var kind:i64=base[2];var object_id:i64=base[3];var offset:i64=base[4];var size:i64=base[5];var address_space:i64=base[7];var scope:i64=base[8];var generation:i64=base[9];if jj_alias_location_bind(out,kind,object_id,offset,size,flags)==0{return 0;}return jj_alias_location_set_domain(out,address_space,scope,generation);
}
fn jj_alias_location_same_object(a:*i64,b:*i64)->i64{
 if jj_alias_location_valid(a)==0{return 0;}if jj_alias_location_valid(b)==0{return 0;}if a[2]==5{return 0;}if b[2]==5{return 0;}if a[7]!=b[7]{return 0;}if a[8]!=b[8]{return 0;}if a[2]!=b[2]{return 0;}if a[3]!=b[3]{return 0;}return 1;
}
fn jj_alias_location_same_version(a:*i64,b:*i64)->i64{if jj_alias_location_same_object(a,b)==0{return 0;}if a[9]!=b[9]{return 0;}return 1;}
fn jj_alias_location_query(a:*i64,b:*i64)->i64{
 if jj_alias_location_valid(a)==0{return 0;}if jj_alias_location_valid(b)==0{return 0;}if a[2]==5{return 2;}if b[2]==5{return 2;}if a[7]!=b[7]{return 2;}
 if jj_alias_location_same_object(a,b)!=0{if jj_alias_location_same_version(a,b)==0{return 2;}if a[5]==0{return 2;}if b[5]==0{return 2;}if a[4]==b[4]{if a[5]==b[5]{return 4;}}var ae:i64=a[4]+a[5];var be:i64=b[4]+b[5];if ae<=b[4]{return 1;}if be<=a[4]{return 1;}return 3;}
 var au:i64=(a[6]&8)!=0;var bu:i64=(b[6]&8)!=0;var ae2:i64=(a[6]&2)!=0;var be2:i64=(b[6]&2)!=0;if au!=0{if ae2==0{return 1;}}if bu!=0{if be2==0{return 1;}}
 if a[8]==b[8]{if a[2]==1{if b[2]==1{return 1;}}if a[2]==2{if b[2]==2{return 1;}}if a[2]==4{if b[2]==4{return 1;}}}
 return 2;
}
fn jj_alias_location_speculatable(r:*i64)->i64{if jj_alias_location_valid(r)==0{return 0;}if r[5]<=0{return 0;}if (r[6]&1)!=0{return 0;}if (r[6]&16)==0{return 0;}return 1;}
fn jj_alias_location_writable(r:*i64)->i64{if jj_alias_location_valid(r)==0{return 0;}if (r[6]&1)!=0{return 0;}if (r[6]&4)!=0{return 0;}return 1;}
fn jj_alias_call_effect_valid(effect:i64)->i64{if effect<0{return 0;}if effect>7{return 0;}return 1;}
fn jj_alias_call_may_mod(r:*i64,effect:i64)->i64{
 if jj_alias_location_valid(r)==0{return 1;}if jj_alias_call_effect_valid(effect)==0{return 1;}if (effect&2)==0{return 0;}if (r[6]&4)!=0{return 0;}if (r[6]&8)!=0{if (r[6]&2)==0{return 0;}}return 1;
}
fn jj_alias_location_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<12{return 0;}out[0]=12;out[1]=5;out[2]=31;out[3]=4;out[4]=8;out[5]=255;out[6]=0x7fffffff;out[7]=1;out[8]=2;out[9]=3;out[10]=4;out[11]=2;return 1;}
