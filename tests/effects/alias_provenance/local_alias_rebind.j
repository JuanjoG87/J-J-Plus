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
  var alias:*i64 = data;
  alias = data;
  return leaf(alias);
}
fn j_main(argc:i64,argv:*i64)->i64{return 0;}
