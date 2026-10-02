fn leaf(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return data[0];
}
fn wrapper(data:*i64,offset:i64)->i64
capability data;
reads data;
writes none;
{
  var shifted:*i64 = data + offset;
  return leaf(shifted);
}
fn j_main(argc:i64,argv:*i64)->i64{wrapper(argv,8);return 0;}
