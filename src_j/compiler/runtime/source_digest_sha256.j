fn jj_sha_rotr32(value: i64, amount: i64) -> i64 {
  var x: i64 = value & 0xffffffff;
  return ((x >>> amount) | ((x << (32 - amount)) & 0xffffffff)) & 0xffffffff;
}

fn jj_sha_hex_nibble(value: i64) -> i64 {
  if value >= 48 { if value <= 57 { return value - 48; } }
  if value >= 97 { if value <= 102 { return value - 87; } }
  return 0xffffffffffffffff;
}

fn jj_sha_expected_word(text: *i8, offset: i64) -> i64 {
  if text == 0 { return 0xffffffffffffffff; }
  var value: i64 = 0;
  var i: i64 = 0;
  while i < 8 {
    var n: i64 = jj_sha_hex_nibble(text[offset + i]);
    if n == 0xffffffffffffffff { return n; }
    value = ((value << 4) | n) & 0xffffffff;
    i = i + 1;
  }
  return value;
}

fn jj_sha_stream_seal(state: *i64) -> i64 {
  if state == 0 { return 0; }
  var value: i64 = 0x5348413235365331 ^ (state as i64);
  var i: i64 = 0;
  while i < 21 {
    value = value ^ state[i];
    value = ((value << 7) | (value >>> 57)) ^ (0x9e3779b97f4a7c15 + i);
    i = i + 1;
  }
  value = value ^ state[22] ^ state[23];
  return value;
}

fn jj_sha_stream_valid(state: *i64) -> i64 {
  if state == 0 { return 0; }
  if state[0] != 0x4a4a534841323536 { return 0; }
  if state[1] != (state as i64) { return 0; }
  if state[10] < 0 { return 0; }
  if state[10] > state[22] { return 0; }
  if state[11] < 0 { return 0; }
  if state[11] > 63 { return 0; }
  if state[20] != 1 { return 0; }
  if state[22] != 1073741824 { return 0; }
  if state[23] != 1 { return 0; }
  if state[21] != jj_sha_stream_seal(state) { return 0; }
  return 1;
}

fn jj_sha_fill_constants(k: *i64) -> i64 {
  if k == 0 { return 0; }
  k[0]=0x428a2f98;k[1]=0x71374491;k[2]=0xb5c0fbcf;k[3]=0xe9b5dba5;
  k[4]=0x3956c25b;k[5]=0x59f111f1;k[6]=0x923f82a4;k[7]=0xab1c5ed5;
  k[8]=0xd807aa98;k[9]=0x12835b01;k[10]=0x243185be;k[11]=0x550c7dc3;
  k[12]=0x72be5d74;k[13]=0x80deb1fe;k[14]=0x9bdc06a7;k[15]=0xc19bf174;
  k[16]=0xe49b69c1;k[17]=0xefbe4786;k[18]=0x0fc19dc6;k[19]=0x240ca1cc;
  k[20]=0x2de92c6f;k[21]=0x4a7484aa;k[22]=0x5cb0a9dc;k[23]=0x76f988da;
  k[24]=0x983e5152;k[25]=0xa831c66d;k[26]=0xb00327c8;k[27]=0xbf597fc7;
  k[28]=0xc6e00bf3;k[29]=0xd5a79147;k[30]=0x06ca6351;k[31]=0x14292967;
  k[32]=0x27b70a85;k[33]=0x2e1b2138;k[34]=0x4d2c6dfc;k[35]=0x53380d13;
  k[36]=0x650a7354;k[37]=0x766a0abb;k[38]=0x81c2c92e;k[39]=0x92722c85;
  k[40]=0xa2bfe8a1;k[41]=0xa81a664b;k[42]=0xc24b8b70;k[43]=0xc76c51a3;
  k[44]=0xd192e819;k[45]=0xd6990624;k[46]=0xf40e3585;k[47]=0x106aa070;
  k[48]=0x19a4c116;k[49]=0x1e376c08;k[50]=0x2748774c;k[51]=0x34b0bcb5;
  k[52]=0x391c0cb3;k[53]=0x4ed8aa4a;k[54]=0x5b9cca4f;k[55]=0x682e6ff3;
  k[56]=0x748f82ee;k[57]=0x78a5636f;k[58]=0x84c87814;k[59]=0x8cc70208;
  k[60]=0x90befffa;k[61]=0xa4506ceb;k[62]=0xbef9a3f7;k[63]=0xc67178f2;
  return 1;
}

fn jj_sha_compress(state: *i64, block: *i8) -> i64 {
  if state == 0 { return 0; }
  if block == 0 { return 0; }
  var k: [64]i64;
  if jj_sha_fill_constants(k as *i64) == 0 { return 0; }
  var w: [64]i64;
  var i: i64 = 0;
  while i < 16 {
    var base: i64 = i * 4;
    w[i] = (((block[base] & 255) << 24) |
            ((block[base + 1] & 255) << 16) |
            ((block[base + 2] & 255) << 8) |
             (block[base + 3] & 255)) & 0xffffffff;
    i = i + 1;
  }
  while i < 64 {
    var x15: i64 = w[i - 15];
    var x2: i64 = w[i - 2];
    var s0: i64 = jj_sha_rotr32(x15,7) ^ jj_sha_rotr32(x15,18) ^ (x15 >>> 3);
    var s1: i64 = jj_sha_rotr32(x2,17) ^ jj_sha_rotr32(x2,19) ^ (x2 >>> 10);
    w[i] = (w[i - 16] + s0 + w[i - 7] + s1) & 0xffffffff;
    i = i + 1;
  }
  var a:i64=state[2];var b:i64=state[3];var c:i64=state[4];var d:i64=state[5];
  var e:i64=state[6];var f:i64=state[7];var g:i64=state[8];var q:i64=state[9];
  i = 0;
  while i < 64 {
    var s1e: i64 = jj_sha_rotr32(e,6) ^ jj_sha_rotr32(e,11) ^ jj_sha_rotr32(e,25);
    var ch: i64 = (e & f) ^ ((e ^ 0xffffffff) & g);
    var t1: i64 = (q + s1e + ch + k[i] + w[i]) & 0xffffffff;
    var s0a: i64 = jj_sha_rotr32(a,2) ^ jj_sha_rotr32(a,13) ^ jj_sha_rotr32(a,22);
    var maj: i64 = (a & b) ^ (a & c) ^ (b & c);
    var t2: i64 = (s0a + maj) & 0xffffffff;
    q=g;g=f;f=e;e=(d+t1)&0xffffffff;d=c;c=b;b=a;a=(t1+t2)&0xffffffff;
    i = i + 1;
  }
  state[2]=(state[2]+a)&0xffffffff;state[3]=(state[3]+b)&0xffffffff;
  state[4]=(state[4]+c)&0xffffffff;state[5]=(state[5]+d)&0xffffffff;
  state[6]=(state[6]+e)&0xffffffff;state[7]=(state[7]+f)&0xffffffff;
  state[8]=(state[8]+g)&0xffffffff;state[9]=(state[9]+q)&0xffffffff;
  return 1;
}

fn jj_sha256_stream_begin(state: *i64) -> i64 {
  if state == 0 { return 0; }
  var i: i64 = 0;
  while i < 24 { state[i] = 0; i = i + 1; }
  state[0]=0x4a4a534841323536;state[1]=state as i64;
  state[2]=0x6a09e667;state[3]=0xbb67ae85;state[4]=0x3c6ef372;state[5]=0xa54ff53a;
  state[6]=0x510e527f;state[7]=0x9b05688c;state[8]=0x1f83d9ab;state[9]=0x5be0cd19;
  state[10]=0;state[11]=0;state[20]=1;state[22]=1073741824;state[23]=1;
  state[21]=jj_sha_stream_seal(state);
  return 1;
}

fn jj_sha256_stream_update(state: *i64, source: *i8, length: i64) -> i64 {
  if jj_sha_stream_valid(state) == 0 { return 0; }
  if length < 0 { return 0; }
  if length > 0 { if source == 0 { return 0; } }
  if length > state[22] - state[10] { return 0; }
  var buffer: *i8 = (state as *i8) + 96;
  var at: i64 = 0;
  state[10] = state[10] + length;
  while state[11] > 0 {
    if at >= length { state[21]=jj_sha_stream_seal(state); return 1; }
    buffer[state[11]] = source[at];
    state[11] = state[11] + 1;
    at = at + 1;
    if state[11] == 64 {
      if jj_sha_compress(state, buffer) == 0 { return 0; }
      var clear: i64 = 0;while clear < 64 { buffer[clear]=0;clear=clear+1; }
      state[11] = 0;
    }
  }
  while at <= length - 64 {
    if jj_sha_compress(state, source + at) == 0 { return 0; }
    at = at + 64;
  }
  while at < length {
    buffer[state[11]] = source[at];
    state[11] = state[11] + 1;
    at = at + 1;
  }
  state[21]=jj_sha_stream_seal(state);
  return 1;
}

fn jj_sha256_stream_finish(state: *i64, output: *i8) -> i64 {
  if output == 0 { return 0; }
  if jj_sha_stream_valid(state) == 0 { return 0; }
  var buffer: *i8 = (state as *i8) + 96;
  var length: i64 = state[10];
  var used: i64 = state[11];
  buffer[used] = 128;used=used+1;
  if used > 56 {
    while used < 64 { buffer[used]=0;used=used+1; }
    if jj_sha_compress(state,buffer)==0{return 0;}
    used=0;while used<64{buffer[used]=0;used=used+1;}used=0;
  }
  while used < 56 { buffer[used]=0;used=used+1; }
  var bits: i64 = length * 8;
  var j: i64 = 0;
  while j < 8 { buffer[63-j]=(bits >>> (j*8))&255;j=j+1; }
  if jj_sha_compress(state,buffer)==0{return 0;}
  j=0;while j<8{output[j*4]=(state[2+j]>>>24)&255;output[j*4+1]=(state[2+j]>>>16)&255;output[j*4+2]=(state[2+j]>>>8)&255;output[j*4+3]=state[2+j]&255;j=j+1;}
  j=0;while j<24{state[j]=0;j=j+1;}
  return 1;
}

fn jj_sha256_digest(source: *i8, length: i64, output: *i8) -> i64 {
  if output == 0 { return 0; }
  if length < 0 { return 0; }
  if length > 0 { if source == 0 { return 0; } }
  var state: [24]i64;
  if jj_sha256_stream_begin(state as *i64)==0{return 0;}
  if jj_sha256_stream_update(state as *i64,source,length)==0{return 0;}
  return jj_sha256_stream_finish(state as *i64,output);
}

fn jj_sha256_match(source: *i8, length: i64, expected_hex: *i8) -> i64 {
  if expected_hex == 0 { return 0; }
  if length <= 0 { return 0; }
  var digest: [4]i64;
  if jj_sha256_digest(source,length,digest as *i8)==0{return 0;}
  var bytes:*i8=digest as *i8;
  var j: i64 = 0;
  while j < 8 {
    var word:i64=((bytes[j*4]&255)<<24)|((bytes[j*4+1]&255)<<16)|((bytes[j*4+2]&255)<<8)|(bytes[j*4+3]&255);
    if jj_sha_expected_word(expected_hex,j*8)!=word{return 0;}
    j=j+1;
  }
  return 1;
}
