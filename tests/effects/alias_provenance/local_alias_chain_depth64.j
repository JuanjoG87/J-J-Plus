fn leaf(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return data[0];
}
fn wrapper(data:*i64)->i64
capability data;
reads data;
writes none;
{
  var a1:*i64 = data;
  var a2:*i64 = a1;
  var a3:*i64 = a2;
  var a4:*i64 = a3;
  var a5:*i64 = a4;
  var a6:*i64 = a5;
  var a7:*i64 = a6;
  var a8:*i64 = a7;
  var a9:*i64 = a8;
  var a10:*i64 = a9;
  var a11:*i64 = a10;
  var a12:*i64 = a11;
  var a13:*i64 = a12;
  var a14:*i64 = a13;
  var a15:*i64 = a14;
  var a16:*i64 = a15;
  var a17:*i64 = a16;
  var a18:*i64 = a17;
  var a19:*i64 = a18;
  var a20:*i64 = a19;
  var a21:*i64 = a20;
  var a22:*i64 = a21;
  var a23:*i64 = a22;
  var a24:*i64 = a23;
  var a25:*i64 = a24;
  var a26:*i64 = a25;
  var a27:*i64 = a26;
  var a28:*i64 = a27;
  var a29:*i64 = a28;
  var a30:*i64 = a29;
  var a31:*i64 = a30;
  var a32:*i64 = a31;
  var a33:*i64 = a32;
  var a34:*i64 = a33;
  var a35:*i64 = a34;
  var a36:*i64 = a35;
  var a37:*i64 = a36;
  var a38:*i64 = a37;
  var a39:*i64 = a38;
  var a40:*i64 = a39;
  var a41:*i64 = a40;
  var a42:*i64 = a41;
  var a43:*i64 = a42;
  var a44:*i64 = a43;
  var a45:*i64 = a44;
  var a46:*i64 = a45;
  var a47:*i64 = a46;
  var a48:*i64 = a47;
  var a49:*i64 = a48;
  var a50:*i64 = a49;
  var a51:*i64 = a50;
  var a52:*i64 = a51;
  var a53:*i64 = a52;
  var a54:*i64 = a53;
  var a55:*i64 = a54;
  var a56:*i64 = a55;
  var a57:*i64 = a56;
  var a58:*i64 = a57;
  var a59:*i64 = a58;
  var a60:*i64 = a59;
  var a61:*i64 = a60;
  var a62:*i64 = a61;
  var a63:*i64 = a62;
  var a64:*i64 = a63;
  return leaf(a64);
}
fn j_main(argc:i64,argv:*i64)->i64{wrapper(argv);return 0;}
