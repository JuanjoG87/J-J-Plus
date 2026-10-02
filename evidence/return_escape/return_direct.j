fn bad(data:*i64)->*i64
capability data;
reads none;
writes none;
{
  return data;
}
