fn read0(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return data[0];
}

fn wrapper(data:*i64)->i64
capability data;
reads none;
writes none;
{
  return read0(data);
}

fn j_main(argc:i64, argv:*i64)->i64 {
  wrapper(argv);
  return 0;
}
