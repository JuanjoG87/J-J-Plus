fn raw_read(data:*i64)->i64 {
  return data[0];
}

fn wrapper(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return raw_read(data);
}

fn j_main(argc:i64, argv:*i64)->i64 {
  return 0;
}
