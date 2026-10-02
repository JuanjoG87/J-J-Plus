fn jj_l_rd16(p: *i8) -> i64 { return (p[0]&255) | ((p[1]&255) << 8); }
fn jj_l_rd32(p: *i8) -> i64 { return (p[0]&255) | ((p[1]&255) << 8) | ((p[2]&255) << 16) | ((p[3]&255) << 24); }
fn jj_l_rd64(p: *i8) -> i64 { var v:i64=0;var i:i64=0;while i<8{v=v|((p[i]&255)<<(i*8));i=i+1;}return v; }
fn jj_l_wr16(p: *i8, v: i64) -> i64 { p[0]=v;p[1]=v>>8;return 1; }
fn jj_l_wr32(p: *i8, v: i64) -> i64 { var i:i64=0;while i<4{p[i]=v>>(i*8);i=i+1;}return 1; }
fn jj_l_wr64(p: *i8, v: i64) -> i64 { var i:i64=0;while i<8{p[i]=v>>(i*8);i=i+1;}return 1; }
fn jj_l_align(v:i64,a:i64)->i64{if a==0{return v;}var m:i64=a-1;return(v+m)&(0-a);}
fn jj_l_copy(d:*i8,s:*i8,n:i64)->i64{var i:i64=0;while i<n{d[i]=s[i];i=i+1;}return 1;}
fn jj_l_zero(d:*i8,n:i64)->i64{var i:i64=0;while i<n{d[i]=0;i=i+1;}return 1;}
fn jj_l_range(offset:i64,size:i64,limit:i64)->i64{if offset<0{return 0;}if size<0{return 0;}if limit<0{return 0;}if offset>limit{return 0;}if size>limit-offset{return 0;}return 1;}
fn jj_l_align_ok(value:i64,alignment:i64,limit:i64)->i64{if value<0{return 0;}if alignment<=0{return 0;}if alignment>4096{return 0;}if(alignment&(alignment-1))!=0{return 0;}if value>limit{return 0;}var mask:i64=alignment-1;if value>limit-mask{return 0;}return jj_l_align(value,alignment);}
fn jj_l_parse_bundle(source:*i8,length:i64,meta:*i64,meta_count:i64)->i64{
  if length<16{return 0;}
  if source[0]!=74{return 65;}if source[1]!=74{return 65;}if source[2]!=66{return 65;}if source[3]!=49{return 65;}
  if source[4]!=79{return 65;}if source[5]!=66{return 65;}if source[6]!=74{return 65;}if source[7]!=10{return 65;}
  var count:i64=jj_l_rd64(source+8);if count<=0{return 0;}if meta_count<=0{return 0;}if count>meta_count{return 0;}
  var pos:i64=16;var i:i64=0;
  while i<count{
    if jj_l_range(pos,8,length)==0{return 0;}
    var size:i64=jj_l_rd64(source+pos);pos=pos+8;if size<64{return 0;}
    if jj_l_range(pos,size,length)==0{return 0;}
    if source[pos]!=0x7f{return 0;}if source[pos+1]!=69{return 0;}if source[pos+2]!=76{return 0;}if source[pos+3]!=70{return 0;}
    meta[i*32]=pos;meta[i*32+1]=size;pos=pos+size;
    var aligned:i64=jj_l_align(pos,8);if aligned<pos{return 0;}if aligned>length{return 0;}
    while pos<aligned{if source[pos]!=0{return 0;}pos=pos+1;}
    i=i+1;
  }
  if pos!=length{return 0;}return count;
}
fn jj_l_name_kind(p:*i8,max:i64)->i64{
  if max>=6{if p[0]==46{if p[1]==116{if p[2]==101{if p[3]==120{if p[4]==116{if p[5]==0{return 1;}}}}}}}
  if max>=8{if p[0]==46{if p[1]==114{if p[2]==111{if p[3]==100{if p[4]==97{if p[5]==116{if p[6]==97{if p[7]==0{return 2;}}}}}}}}}
  if max>=6{if p[0]==46{if p[1]==100{if p[2]==97{if p[3]==116{if p[4]==97{if p[5]==0{return 3;}}}}}}}
  if max>=5{if p[0]==46{if p[1]==98{if p[2]==115{if p[3]==115{if p[4]==0{return 4;}}}}}}
  if max>=8{if p[0]==46{if p[1]==115{if p[2]==121{if p[3]==109{if p[4]==116{if p[5]==97{if p[6]==98{if p[7]==0{return 5;}}}}}}}}}
  if max>=8{if p[0]==46{if p[1]==115{if p[2]==116{if p[3]==114{if p[4]==116{if p[5]==97{if p[6]==98{if p[7]==0{return 6;}}}}}}}}}
  if max>=11{if p[0]==46{if p[1]==114{if p[2]==101{if p[3]==108{if p[4]==97{if p[5]==46{if p[6]==116{if p[7]==101{if p[8]==120{if p[9]==116{if p[10]==0{return 7;}}}}}}}}}}}}
  if max>=10{if p[0]==46{if p[1]==115{if p[2]==104{if p[3]==115{if p[4]==116{if p[5]==114{if p[6]==116{if p[7]==97{if p[8]==98{if p[9]==0{return 8;}}}}}}}}}}}
  if max>=7{if p[0]==95{if p[1]==115{if p[2]==116{if p[3]==97{if p[4]==114{if p[5]==116{if p[6]==0{return 9;}}}}}}}}
  return 0;
}
fn jj_l_cstring_ok(p:*i8,max:i64)->i64{
  if p==0{return 0;}if max<=0{return 0;}var i:i64=0;while i<max{if p[i]==0{return 1;}if i>=255{return 0;}i=i+1;}return 0;
}
fn jj_l_is_wrapper_entry(p:*i8,max:i64)->i64{
  if max<41{return 0;}var n:[40]i64;
  n[0]=106;n[1]=106;n[2]=95;n[3]=115;n[4]=116;n[5]=97;n[6]=103;n[7]=101;n[8]=51;n[9]=95;n[10]=119;n[11]=114;n[12]=97;n[13]=112;n[14]=112;n[15]=101;n[16]=114;n[17]=95;n[18]=101;n[19]=110;n[20]=116;n[21]=114;n[22]=121;n[23]=36;n[24]=48;n[25]=48;n[26]=48;n[27]=48;n[28]=48;n[29]=48;n[30]=48;n[31]=48;n[32]=48;n[33]=49;n[34]=50;n[35]=51;n[36]=50;n[37]=51;n[38]=51;n[39]=50;
  var i:i64=0;while i<40{if p[i]!=n[i]{return 0;}i=i+1;}if p[40]!=0{return 0;}return 1;
}
fn jj_l_is_app_entry(p:*i8,max:i64)->i64{
  if max<24{return 0;}var n:[23]i64;
  n[0]=106;n[1]=95;n[2]=109;n[3]=97;n[4]=105;n[5]=110;n[6]=36;n[7]=48;n[8]=48;n[9]=48;n[10]=48;n[11]=48;n[12]=48;n[13]=48;n[14]=48;n[15]=48;n[16]=48;n[17]=49;n[18]=50;n[19]=50;n[20]=50;n[21]=50;n[22]=53;
  var i:i64=0;while i<23{if p[i]!=n[i]{return 0;}i=i+1;}if p[23]!=0{return 0;}return 1;
}
fn jj_l_section_header(source:*i8,meta:*i64,obj:i64,index:i64)->i64{if obj<0{return 0;}if index<0{return 0;}var b:i64=obj*32;if index>=meta[b+3]{return 0;}return(source+meta[b]+meta[b+2]+index*meta[b+4])as i64;}
fn jj_l_parse_objects(source:*i8,meta:*i64,count:i64)->i64{
  var oi:i64=0;var total_symbols:i64=0;var total_relocations:i64=0;
  while oi<count{
    var b:i64=oi*32;var o:*i8=source+meta[b];var size:i64=meta[b+1];
    if size<64{return 0;}if jj_l_rd64(o)!=0x00010102464c457f{return 0;}
    if jj_l_rd16(o+16)!=1{return 0;}if jj_l_rd16(o+18)!=62{return 0;}if jj_l_rd32(o+20)!=1{return 0;}
    if jj_l_rd64(o+32)!=0{return 0;}if jj_l_rd16(o+52)!=64{return 0;}if jj_l_rd16(o+54)!=0{return 0;}if jj_l_rd16(o+56)!=0{return 0;}
    var shoff:i64=jj_l_rd64(o+40);var ents:i64=jj_l_rd16(o+58);var num:i64=jj_l_rd16(o+60);var shstr:i64=jj_l_rd16(o+62);
    if ents!=64{return 0;}if num<=1{return 0;}if num>128{return 0;}if shstr<=0{return 0;}if shstr>=num{return 0;}
    if jj_l_range(shoff,num*64,size)==0{return 0;}
    meta[b+2]=shoff;meta[b+3]=num;meta[b+4]=64;meta[b+5]=shstr;
    var nullsh:*i8=(jj_l_section_header(source,meta,oi,0))as *i8;if nullsh==0{return 0;}
    if jj_l_rd32(nullsh+4)!=0{return 0;}if jj_l_rd64(nullsh+24)!=0{return 0;}if jj_l_rd64(nullsh+32)!=0{return 0;}
    var shsp:*i8=(jj_l_section_header(source,meta,oi,shstr))as *i8;if shsp==0{return 0;}
    if jj_l_rd32(shsp+4)!=3{return 0;}if jj_l_rd64(shsp+8)!=0{return 0;}if jj_l_rd32(shsp+40)!=0{return 0;}if jj_l_rd32(shsp+44)!=0{return 0;}if jj_l_rd64(shsp+56)!=0{return 0;}
    var shstroff:i64=jj_l_rd64(shsp+24);var shstrsz:i64=jj_l_rd64(shsp+32);if shstrsz<=0{return 0;}
    if jj_l_range(shstroff,shstrsz,size)==0{return 0;}if o[shstroff+shstrsz-1]!=0{return 0;}
    var si:i64=1;
    while si<num{
      var sh:*i8=(jj_l_section_header(source,meta,oi,si))as *i8;var no:i64=jj_l_rd32(sh);
      if no<0{return 0;}if no>=shstrsz{return 0;}if jj_l_cstring_ok(o+shstroff+no,shstrsz-no)==0{return 0;}
      var kind:i64=jj_l_name_kind(o+shstroff+no,shstrsz-no);var typ:i64=jj_l_rd32(sh+4);var flags:i64=jj_l_rd64(sh+8);
      var off:i64=jj_l_rd64(sh+24);var sz:i64=jj_l_rd64(sh+32);var link:i64=jj_l_rd32(sh+40);var info:i64=jj_l_rd32(sh+44);var al:i64=jj_l_rd64(sh+48);var element:i64=jj_l_rd64(sh+56);
      if al==0{al=1;}if al>4096{return 0;}if(al&(al-1))!=0{return 0;}
      if typ==8{if kind!=4{return 0;}if off<0{return 0;}if off>size{return 0;}}else{if jj_l_range(off,sz,size)==0{return 0;}}
      if kind==1{
        if meta[b+6]!=0{return 0;}if typ!=1{return 0;}if flags!=6{return 0;}if link!=0{return 0;}if info!=0{return 0;}if element!=0{return 0;}if sz<=0{return 0;}
        meta[b+6]=si;meta[b+8]=sz;meta[b+9]=al;
      }else{if kind==2{
        if meta[b+10]!=0{return 0;}if typ!=1{return 0;}if flags!=2{return 0;}if link!=0{return 0;}if info!=0{return 0;}if element!=0{return 0;}
        meta[b+10]=si;meta[b+12]=sz;meta[b+13]=al;
      }else{if kind==3{
        if meta[b+14]!=0{return 0;}if typ!=1{return 0;}if flags!=3{return 0;}if link!=0{return 0;}if info!=0{return 0;}if element!=0{return 0;}
        meta[b+14]=si;meta[b+16]=sz;meta[b+17]=al;
      }else{if kind==4{
        if meta[b+18]!=0{return 0;}if typ!=8{return 0;}if flags!=3{return 0;}if link!=0{return 0;}if info!=0{return 0;}if element!=0{return 0;}
        meta[b+18]=si;meta[b+20]=sz;meta[b+21]=al;
      }else{if kind==5{
        if meta[b+22]!=0{return 0;}if typ!=2{return 0;}if flags!=0{return 0;}if element!=24{return 0;}if(sz%24)!=0{return 0;}
        meta[b+22]=si;meta[b+25]=sz/24;if meta[b+25]<=0{return 0;}if meta[b+25]>2048{return 0;}
        total_symbols=total_symbols+meta[b+25];if total_symbols>65536{return 0;}
      }else{if kind==6{
        if meta[b+23]!=0{return 0;}if typ!=3{return 0;}if flags!=0{return 0;}if link!=0{return 0;}if info!=0{return 0;}if element!=0{return 0;}if sz<=0{return 0;}
        meta[b+23]=si;
      }else{if kind==7{
        if meta[b+24]!=0{return 0;}if typ!=4{return 0;}if flags!=0{return 0;}if element!=24{return 0;}if(sz%24)!=0{return 0;}
        meta[b+24]=si;
      }else{if kind==8{if si!=shstr{return 0;}}}}}}}}}
      si=si+1;
    }
    if meta[b+6]==0{return 0;}if meta[b+22]==0{return 0;}if meta[b+23]==0{return 0;}
    var sy:*i8=(jj_l_section_header(source,meta,oi,meta[b+22]))as *i8;var linked:i64=jj_l_rd32(sy+40);var local_count:i64=jj_l_rd32(sy+44);
    if linked!=meta[b+23]{return 0;}if local_count<=0{return 0;}if local_count>meta[b+25]{return 0;}
    var st:*i8=(jj_l_section_header(source,meta,oi,meta[b+23]))as *i8;var stroff:i64=jj_l_rd64(st+24);var strsz:i64=jj_l_rd64(st+32);
    if strsz<=0{return 0;}if jj_l_range(stroff,strsz,size)==0{return 0;}if o[stroff+strsz-1]!=0{return 0;}
    var syoff:i64=jj_l_rd64(sy+24);var k:i64=0;
    while k<meta[b+25]{
      var sym:*i8=o+syoff+k*24;var name:i64=jj_l_rd32(sym);if name<0{return 0;}if name>=strsz{return 0;}if jj_l_cstring_ok(o+stroff+name,strsz-name)==0{return 0;}
      var bind:i64=(sym[4]&255)>>4;var stype:i64=sym[4]&15;if bind>2{return 0;}if stype>3{return 0;}
      if k<local_count{if bind!=0{return 0;}}else{if bind==0{return 0;}}
      var ndx:i64=jj_l_rd16(sym+6);if ndx!=0{if ndx!=0xfff1{if ndx!=meta[b+6]{if ndx!=meta[b+10]{if ndx!=meta[b+14]{if ndx!=meta[b+18]{return 0;}}}}}}
      if k==0{if name!=0{return 0;}if ndx!=0{return 0;}if jj_l_rd64(sym+8)!=0{return 0;}if jj_l_rd64(sym+16)!=0{return 0;}}else{if name==0{return 0;}if ndx==0{if bind==0{return 0;}}}
      if ndx!=0{if ndx!=0xfff1{var secsz:i64=0;if ndx==meta[b+6]{secsz=meta[b+8];}else{if ndx==meta[b+10]{secsz=meta[b+12];}else{if ndx==meta[b+14]{secsz=meta[b+16];}else{if ndx==meta[b+18]{secsz=meta[b+20];}}}}var value:i64=jj_l_rd64(sym+8);var symsz:i64=jj_l_rd64(sym+16);if value<0{return 0;}if symsz<0{return 0;}if value>secsz{return 0;}if symsz>secsz-value{return 0;}}}
      k=k+1;
    }
    if meta[b+24]!=0{
      var rr:*i8=(jj_l_section_header(source,meta,oi,meta[b+24]))as *i8;if jj_l_rd32(rr+40)!=meta[b+22]{return 0;}if jj_l_rd32(rr+44)!=meta[b+6]{return 0;}
      var rel_count:i64=jj_l_rd64(rr+32)/24;if rel_count>1024{return 0;}total_relocations=total_relocations+rel_count;if total_relocations>65536{return 0;}
    }
    oi=oi+1;
  }
  return 1;
}
fn jj_l_layout(meta:*i64,count:i64,lay:*i64,limit:i64)->i64{
  if limit<8192{return 0;}var cur:i64=4136;var i:i64=0;while i<count{var b:i64=i*32;cur=jj_l_align_ok(cur,meta[b+9],limit);if cur==0{return 0;}if meta[b+8]>limit-cur{return 0;}meta[b+7]=cur;cur=cur+meta[b+8];i=i+1;}lay[0]=4096;lay[1]=cur;cur=jj_l_align_ok(cur,4096,limit);if cur==0{return 0;}lay[2]=cur;i=0;while i<count{var b2:i64=i*32;if meta[b2+10]!=0{cur=jj_l_align_ok(cur,meta[b2+13],limit);if cur==0{return 0;}if meta[b2+12]>limit-cur{return 0;}meta[b2+11]=cur;cur=cur+meta[b2+12];}i=i+1;}lay[3]=cur;cur=jj_l_align_ok(cur,4096,limit);if cur==0{return 0;}lay[4]=cur;i=0;while i<count{var b3:i64=i*32;if meta[b3+14]!=0{cur=jj_l_align_ok(cur,meta[b3+17],limit);if cur==0{return 0;}if meta[b3+16]>limit-cur{return 0;}meta[b3+15]=cur;cur=cur+meta[b3+16];}i=i+1;}lay[5]=cur;var mem:i64=cur;i=0;while i<count{var b4:i64=i*32;if meta[b4+18]!=0{mem=jj_l_align_ok(mem,meta[b4+21],limit);if mem==0{return 0;}if meta[b4+20]>limit-mem{return 0;}meta[b4+19]=mem;mem=mem+meta[b4+20];}i=i+1;}lay[6]=mem;lay[7]=jj_l_align_ok(cur,4096,limit);if lay[7]==0{return 0;}return 1;
}
fn jj_l_section_out(meta:*i64,obj:i64,index:i64)->i64{var b:i64=obj*32;if index==meta[b+6]{return meta[b+7];}if index==meta[b+10]{return meta[b+11];}if index==meta[b+14]{return meta[b+15];}if index==meta[b+18]{return meta[b+19];}return 0;}
fn jj_l_section_size(meta:*i64,obj:i64,index:i64)->i64{
  if obj<0{return 0;}var b:i64=obj*32;if index==meta[b+6]{return meta[b+8];}if index==meta[b+10]{return meta[b+12];}if index==meta[b+14]{return meta[b+16];}if index==meta[b+18]{return meta[b+20];}return 0;
}
fn jj_l_name_equal(source:*i8,meta:*i64,oa:i64,na:i64,ob:i64,nb:i64)->i64{if oa<0{return 0;}if ob<0{return 0;}if na<0{return 0;}if nb<0{return 0;}var ba:i64=oa*32;var bb:i64=ob*32;var sha:*i8=(jj_l_section_header(source,meta,oa,meta[ba+23]))as *i8;var shb:*i8=(jj_l_section_header(source,meta,ob,meta[bb+23]))as *i8;var sa:i64=jj_l_rd64(sha+24);var sza:i64=jj_l_rd64(sha+32);var sb:i64=jj_l_rd64(shb+24);var szb:i64=jj_l_rd64(shb+32);if na>=sza{return 0;}if nb>=szb{return 0;}var pa:*i8=source+meta[ba]+sa+na;var pb:*i8=source+meta[bb]+sb+nb;var i:i64=0;while i<256{if i>=sza-na{return 0;}if i>=szb-nb{return 0;}if pa[i]!=pb[i]{return 0;}if pa[i]==0{return 1;}i=i+1;}return 0;}
fn jj_l_symbol_address(source:*i8,meta:*i64,count:i64,obj:i64,symidx:i64)->i64{
  if obj<0{return 0;}if obj>=count{return 0;}if symidx<0{return 0;}var b:i64=obj*32;if symidx>=meta[b+25]{return 0;}
  var sysh:*i8=(jj_l_section_header(source,meta,obj,meta[b+22]))as *i8;var syoff:i64=jj_l_rd64(sysh+24);var sym:*i8=source+meta[b]+syoff+symidx*24;
  var shndx:i64=jj_l_rd16(sym+6);var value:i64=jj_l_rd64(sym+8);var symsz:i64=jj_l_rd64(sym+16);
  if shndx!=0{
    if shndx==0xfff1{return value;}var secsz:i64=jj_l_section_size(meta,obj,shndx);if secsz==0{return 0;}if value<0{return 0;}if symsz<0{return 0;}if value>secsz{return 0;}if symsz>secsz-value{return 0;}
    var so:i64=jj_l_section_out(meta,obj,shndx);if so==0{return 0;}return so+value;
  }
  var name:i64=jj_l_rd32(sym);if name<=0{return 0;}var found:i64=0;var oi:i64=0;
  while oi<count{
    var bb:i64=oi*32;var ssh:*i8=(jj_l_section_header(source,meta,oi,meta[bb+22]))as *i8;var sso:i64=jj_l_rd64(ssh+24);var k:i64=1;
    while k<meta[bb+25]{
      var cand:*i8=source+meta[bb]+sso+k*24;var bind:i64=(cand[4]&255)>>4;var cs:i64=jj_l_rd16(cand+6);
      if bind!=0{if cs!=0{if jj_l_name_equal(source,meta,obj,name,oi,jj_l_rd32(cand))!=0{
        var ca:i64=0;if cs==0xfff1{ca=jj_l_rd64(cand+8);}else{var csz:i64=jj_l_section_size(meta,oi,cs);if csz==0{return 0;}var cv:i64=jj_l_rd64(cand+8);var cn:i64=jj_l_rd64(cand+16);if cv<0{return 0;}if cn<0{return 0;}if cv>csz{return 0;}if cn>csz-cv{return 0;}var co:i64=jj_l_section_out(meta,oi,cs);if co==0{return 0;}ca=co+cv;}
        if found!=0{return 0;}found=ca;
      }}}
      k=k+1;
    }
    oi=oi+1;
  }
  return found;
}
fn jj_l_copy_sections(source:*i8,meta:*i64,count:i64,out:*i8)->i64{var oi:i64=0;while oi<count{var b:i64=oi*32;var o:*i8=source+meta[b];var sh:*i8=(jj_l_section_header(source,meta,oi,meta[b+6]))as *i8;jj_l_copy(out+meta[b+7],o+jj_l_rd64(sh+24),meta[b+8]);if meta[b+10]!=0{sh=(jj_l_section_header(source,meta,oi,meta[b+10]))as *i8;jj_l_copy(out+meta[b+11],o+jj_l_rd64(sh+24),meta[b+12]);}if meta[b+14]!=0{sh=(jj_l_section_header(source,meta,oi,meta[b+14]))as *i8;jj_l_copy(out+meta[b+15],o+jj_l_rd64(sh+24),meta[b+16]);}oi=oi+1;}return 1;}
fn jj_l_apply_relocs(source:*i8,meta:*i64,count:i64,out:*i8)->i64{var oi:i64=0;while oi<count{var b:i64=oi*32;if meta[b+24]!=0{var rh:*i8=(jj_l_section_header(source,meta,oi,meta[b+24]))as *i8;var off:i64=jj_l_rd64(rh+24);var sz:i64=jj_l_rd64(rh+32);var target:i64=jj_l_rd32(rh+44);var to:i64=jj_l_section_out(meta,oi,target);if to==0{return 0;}var n:i64=sz/24;var ri:i64=0;while ri<n{var r:*i8=source+meta[b]+off+ri*24;var ro:i64=jj_l_rd64(r);var info:i64=jj_l_rd64(r+8);var typ:i64=info&0xffffffff;var si:i64=info>>32;if typ!=2{if typ!=4{return 0;}}var secsz:i64=0;if target==meta[b+6]{secsz=meta[b+8];}else{if target==meta[b+10]{secsz=meta[b+12];}else{if target==meta[b+14]{secsz=meta[b+16];}}}if jj_l_range(ro,4,secsz)==0{return 0;}var s:i64=jj_l_symbol_address(source,meta,count,oi,si);if s==0{return 0;}var p:i64=to+ro;var v:i64=s+jj_l_rd64(r+16)-p;var lo:i64=v&0xffffffff;var sx:i64=lo;if lo>=0x80000000{sx=lo|0xffffffff00000000;}if sx!=v{return 0;}jj_l_wr32(out+to+ro,lo);ri=ri+1;}}oi=oi+1;}return 1;}
fn jj_l_find_wrapper(source:*i8,meta:*i64,count:i64)->i64{
  var found:i64=0;var oi:i64=0;while oi<count{var b:i64=oi*32;var sh:*i8=(jj_l_section_header(source,meta,oi,meta[b+22]))as *i8;var off:i64=jj_l_rd64(sh+24);var strh:*i8=(jj_l_section_header(source,meta,oi,meta[b+23]))as *i8;var stro:i64=jj_l_rd64(strh+24);var strsz:i64=jj_l_rd64(strh+32);var k:i64=1;while k<meta[b+25]{var sym:*i8=source+meta[b]+off+k*24;var no:i64=jj_l_rd32(sym);if no>=0{if no<strsz{if jj_l_is_wrapper_entry(source+meta[b]+stro+no,strsz-no)!=0{var bind:i64=(sym[4]&255)>>4;var stype:i64=sym[4]&15;if bind==0{return 0;}if stype!=2{return 0;}var shndx:i64=jj_l_rd16(sym+6);if shndx!=meta[b+6]{return 0;}var value:i64=jj_l_rd64(sym+8);var symsz:i64=jj_l_rd64(sym+16);if value<0{return 0;}if symsz<=0{return 0;}if value>=meta[b+8]{return 0;}if symsz>meta[b+8]-value{return 0;}var address:i64=meta[b+7]+value;if found!=0{return 0;}found=address;}}}k=k+1;}oi=oi+1;}return found;
}
fn jj_l_find_app(source:*i8,meta:*i64,count:i64)->i64{
  var found:i64=0;var oi:i64=0;while oi<count{var b:i64=oi*32;var sh:*i8=(jj_l_section_header(source,meta,oi,meta[b+22]))as *i8;var off:i64=jj_l_rd64(sh+24);var strh:*i8=(jj_l_section_header(source,meta,oi,meta[b+23]))as *i8;var stro:i64=jj_l_rd64(strh+24);var strsz:i64=jj_l_rd64(strh+32);var k:i64=1;while k<meta[b+25]{var sym:*i8=source+meta[b]+off+k*24;var no:i64=jj_l_rd32(sym);if no>=0{if no<strsz{if jj_l_is_app_entry(source+meta[b]+stro+no,strsz-no)!=0{var bind:i64=(sym[4]&255)>>4;var stype:i64=sym[4]&15;if bind==0{return 0;}if stype!=2{return 0;}var shndx:i64=jj_l_rd16(sym+6);if shndx!=meta[b+6]{return 0;}var value:i64=jj_l_rd64(sym+8);var symsz:i64=jj_l_rd64(sym+16);if value<0{return 0;}if symsz<=0{return 0;}if value>=meta[b+8]{return 0;}if symsz>meta[b+8]-value{return 0;}var address:i64=meta[b+7]+value;if found!=0{return 0;}found=address;}}}k=k+1;}oi=oi+1;}return found;
}
fn jj_l_emit_start(out:*i8,entry:i64,mode:i64)->i64{var p:*i8=out+4096;if mode==1{var next:i64=0x1021;var rel:i64=entry-next;var lo:i64=rel&0xffffffff;var sx:i64=lo;if lo>=0x80000000{sx=lo|0xffffffff00000000;}if sx!=rel{return 0;}p[0]=0x48;p[1]=0x8b;p[2]=0x14;p[3]=0x24;p[4]=0x31;p[5]=0xff;p[6]=0x31;p[7]=0xf6;p[8]=0x48;p[9]=0x83;p[10]=0xfa;p[11]=2;p[12]=0x76;p[13]=10;p[14]=0x48;p[15]=0x8b;p[16]=0x7c;p[17]=0x24;p[18]=0x10;p[19]=0x48;p[20]=0x8b;p[21]=0x74;p[22]=0x24;p[23]=0x18;p[24]=0x48;p[25]=0x83;p[26]=0xe4;p[27]=0xf0;p[28]=0xe8;jj_l_wr32(p+29,lo);p[33]=0x89;p[34]=0xc7;p[35]=0x6a;p[36]=0x3c;p[37]=0x58;p[38]=0x0f;p[39]=0x05;return 1;}if mode==2{var app_next:i64=0x1012;var app_rel:i64=entry-app_next;var app_lo:i64=app_rel&0xffffffff;var app_sx:i64=app_lo;if app_lo>=0x80000000{app_sx=app_lo|0xffffffff00000000;}if app_sx!=app_rel{return 0;}p[0]=0x48;p[1]=0x8b;p[2]=0x3c;p[3]=0x24;p[4]=0x48;p[5]=0x8d;p[6]=0x74;p[7]=0x24;p[8]=0x08;p[9]=0x48;p[10]=0x83;p[11]=0xe4;p[12]=0xf0;p[13]=0xe8;jj_l_wr32(p+14,app_lo);p[18]=0x89;p[19]=0xc7;p[20]=0x6a;p[21]=0x3c;p[22]=0x58;p[23]=0x0f;p[24]=0x05;return 1;}return 0;}
fn jj_l_phdr(p:*i8,flags:i64,off:i64,files:i64,mem:i64)->i64{jj_l_wr32(p,1);jj_l_wr32(p+4,flags);jj_l_wr64(p+8,off);jj_l_wr64(p+16,off);jj_l_wr64(p+24,off);jj_l_wr64(p+32,files);jj_l_wr64(p+40,mem);jj_l_wr64(p+48,4096);return 1;}
fn jj_l_stack_phdr(p:*i8)->i64{jj_l_wr32(p,0x6474e551);jj_l_wr32(p+4,6);jj_l_wr64(p+48,16);return 1;}
fn jj_resident_link(source:*i8,source_end:*i8,object:*i8,object_end:*i8)->i64{
  if source==0{return 0;}if source_end==0{return 0;}if object==0{return 0;}if object_end==0{return 0;}if source_end<=source{return 0;}if object_end<=object{return 0;}
  var length:i64=source_end-source;var capacity:i64=object_end-object;if length<16{return 2;}if capacity<8192{return 0;}
  if source[0]!=74{return 2;}if source[1]!=74{return 2;}if source[2]!=66{return 2;}if source[3]!=49{return 2;}if source[4]!=79{return 2;}if source[5]!=66{return 2;}if source[6]!=74{return 2;}if source[7]!=10{return 2;}
  var announced:i64=jj_l_rd64(source+8);if announced<=0{return 0;}if announced>length/64{return 0;}if announced>capacity/256{return 0;}
  var meta_bytes:i64=announced*256;if meta_bytes<=0{return 0;}if meta_bytes>capacity-8192{return 0;}
  var output_capacity:i64=capacity-meta_bytes;output_capacity=output_capacity&0xfffffffffffffff8;if output_capacity<8192{return 0;}
  var meta:*i64=(object+output_capacity)as *i64;var lay:[8]i64;var i:i64=0;while i<announced*32{meta[i]=0;i=i+1;}i=0;while i<8{lay[i]=0;i=i+1;}
  var count:i64=jj_l_parse_bundle(source,length,meta,announced);if count==0{return 0;}if count!=announced{return 0;}
  if jj_l_parse_objects(source,meta,count)==0{return 0;}if jj_l_layout(meta,count,lay,output_capacity)==0{return 0;}if lay[7]>output_capacity{return 0;}
  jj_l_zero(object,lay[7]);if jj_l_copy_sections(source,meta,count,object)==0{return 0;}if jj_l_apply_relocs(source,meta,count,object)==0{return 0;}
  var wrapper:i64=jj_l_find_wrapper(source,meta,count);var app:i64=jj_l_find_app(source,meta,count);var entry:i64=0;var entry_mode:i64=0;
  if wrapper!=0{if app!=0{return 0;}entry=wrapper;entry_mode=1;}else{if app==0{return 0;}entry=app;entry_mode=2;}
  if jj_l_emit_start(object,entry,entry_mode)==0{return 0;}var elf_entry:i64=0x1000;
  object[0]=0x7f;object[1]=69;object[2]=76;object[3]=70;object[4]=2;object[5]=1;object[6]=1;
  jj_l_wr16(object+16,3);jj_l_wr16(object+18,62);jj_l_wr32(object+20,1);jj_l_wr64(object+24,elf_entry);jj_l_wr64(object+32,64);jj_l_wr16(object+52,64);jj_l_wr16(object+54,56);jj_l_wr16(object+56,5);
  jj_l_phdr(object+64,4,0,4096,4096);jj_l_phdr(object+120,5,lay[0],lay[1]-lay[0],lay[1]-lay[0]);jj_l_phdr(object+176,4,lay[2],lay[3]-lay[2],lay[3]-lay[2]);jj_l_phdr(object+232,6,lay[4],lay[5]-lay[4],lay[6]-lay[4]);jj_l_stack_phdr(object+288);return lay[7];
}
