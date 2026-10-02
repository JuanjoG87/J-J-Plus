fn bad(data:*i64)->i64
reads data;
capability data;
writes none;
{
  return 0;
}
