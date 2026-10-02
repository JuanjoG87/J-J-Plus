// jj_target: aarch64
fn effect_probe(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return data[0];
}
