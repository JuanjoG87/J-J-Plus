fn jj_ct_zero(p:*i8,n:i64)->i64{if p==0{return 0;}var i:i64=0;while i<n{p[i]=0;i=i+1;}return 1;}
fn jj_ct_marker_write(p:*i8,at:i64,v:i64)->i64{p[at]=0x0f;p[at+1]=0x1f;p[at+2]=0x44;p[at+3]=0;p[at+4]=v;return 1;}
fn jj_ct_pad3(p:*i8)->i64{p[0]=0x0f;p[1]=0x1f;p[2]=0;return 1;}
fn jj_ct_pad8(p:*i8)->i64{p[0]=0x0f;p[1]=0x1f;p[2]=0x84;p[3]=0;var i:i64=4;while i<8{p[i]=0;i=i+1;}return 1;}
fn jj_ct_pad10(p:*i8)->i64{p[0]=0x66;p[1]=0x0f;p[2]=0x1f;p[3]=0x84;var i:i64=4;while i<9{p[i]=0;i=i+1;}p[9]=0x90;return 1;}
fn jj_coldtail_pad(p:*i8,n:i64)->i64{if p==0{return 0;}if n==3{if p[0]==0x0f{if p[1]==0x1f{if p[2]==0{return 1;}}}}if n==8{if p[0]==0x0f{if p[1]==0x1f{if (p[2]&255)==0x84{if p[3]==0{var i:i64=4;while i<8{if p[i]!=0{return 0;}i=i+1;}return 1;}}}}}if n==10{if p[0]==0x66{if p[1]==0x0f{if p[2]==0x1f{if (p[3]&255)==0x84{var j:i64=4;while j<9{if p[j]!=0{return 0;}j=j+1;}if (p[9]&255)==0x90{return 1;}}}}}}return 0;}
fn jj_coldtail_marker(p:*i8,at:i64,value:i64)->i64{if p==0{return 0;}if p[at]!=0x0f{return 0;}if p[at+1]!=0x1f{return 0;}if p[at+2]!=0x44{return 0;}if p[at+3]!=0{return 0;}return p[at+4]==value;}
fn jj_coldtail_mto_disp8(v:i64)->i64{var d:i64=v&255;if d>=128{d=d-256;}if d>=0{return 0;}if (0-d)%8!=0{return 0;}return 1;}
extern fn jj_gco(p0:*i8,p1:i64)->i64;
extern fn jj_gcn(p0:*i8,p1:i64)->i64;
fn jj_ct_kind(v:i64)->i64{if v==0{return 0;}var a:i64=v&255;var o:i64=(v>>>8)&255;if a!=o{return 0-1;}return a;}
fn j_main(argc:i64,argv:*i64)->i64{if argc!=1{return 1;}var w:[16]i64;var p:*i8=w as *i8;
 if jj_ct_zero(p,128)==0{return 2;}p[0]=0x58;p[1]=0x50;jj_ct_pad10(p+2);jj_ct_marker_write(p,12,0x51);if jj_ct_kind(jj_gco(p,17))!=11{return 3;}if jj_ct_kind(jj_gco(p,16))!=0{return 4;}p[17]=1;if jj_ct_kind(jj_gco(p,128))!=11{return 5;}p[13]=0x1e;if jj_ct_kind(jj_gco(p,17))!=0{return 6;}
 jj_ct_zero(p,128);p[0]=0x58;p[1]=0x31;p[2]=0xc0;p[3]=0x50;jj_ct_pad8(p+4);jj_ct_marker_write(p,12,0x52);if jj_ct_kind(jj_gco(p,17))!=12{return 7;}p[4]=0x90;if jj_ct_kind(jj_gco(p,17))!=0{return 8;}
 jj_ct_zero(p,128);p[0]=0x58;p[1]=0x48;p[2]=0x89;p[3]=0x45;p[4]=0xf8;p[5]=0x50;jj_ct_marker_write(p,6,0x60);jj_ct_pad3(p+11);if jj_ct_kind(jj_gco(p,14))!=16{return 9;}p[4]=8;if jj_ct_kind(jj_gco(p,14))!=0{return 10;}
 jj_ct_zero(p,128);p[0]=0x58;p[1]=0x50;jj_ct_marker_write(p,2,0x51);if jj_ct_kind(jj_gcn(p,7))!=11{return 11;}if jj_ct_kind(jj_gcn(p,6))!=0{return 12;}
 jj_ct_zero(p,128);p[0]=0x58;p[1]=0x31;p[2]=0xc0;p[3]=0x50;jj_ct_marker_write(p,4,0x52);if jj_ct_kind(jj_gcn(p,9))!=12{return 13;}
 jj_ct_zero(p,128);p[0]=0x58;p[1]=0x48;p[2]=0x89;p[3]=0x45;p[4]=0xf8;p[5]=0x50;jj_ct_marker_write(p,6,0x60);if jj_ct_kind(jj_gcn(p,11))!=16{return 14;}p[11]=1;if jj_ct_kind(jj_gcn(p,128))!=16{return 15;}
 return 0;}
