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
  var shifted:*i64 = data + 1;
  return leaf(shifted);
}
fn j_main(argc:i64,argv:*i64)->i64{wrapper(argv);return 0;}
