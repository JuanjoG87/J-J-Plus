fn leaf(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return data[0];
}

fn middle(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return leaf(data);
}

fn outer(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return middle(data);
}

fn j_main(argc:i64, argv:*i64)->i64 {
  outer(argv);
  return 0;
}
