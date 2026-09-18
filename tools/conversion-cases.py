"""Original format/scan programs, with independent native expected results."""
import itertools,random,struct
cases=[]
def word(s):
    return '"'+''.join('\\'+c if c in '\\"$[]' else '\\n' if c=='\n' else '\\r' if c=='\r' else '\\u0000' if c=='\0' else c for c in str(s))+'"'
def add(name,source):cases.append({'name':name+'-'+str(len(cases)),'source':source})
def fmt(pattern,*args):add('format','format '+word(pattern)+' '+' '.join(word(s) for s in args))
ints=['0','1','-1','255','-255','32768','65535','2147483648','4294967295','4294967296','-4294967295','9223372036854775808','18446744073709551615','18446744073709551616','-18446744073709551616','0xabcdef','0b1011','077','09','1.5',' 12 ','\u200012']
for kind,size,value in itertools.product('diuoxXb',['','h','l','ll'],ints):fmt('%'+size+kind,value)
for kind,flags,value in itertools.product('duxobfgs',['+',' ','#','0','-','+#','-0','+0#'],['0','-12','12']):fmt('%'+flags+'10'+kind,value)
for kind,width,precision,value in itertools.product('dxfs',[0,8,-8],[0,1,4,-1],['0','12','-12']):fmt('%0*.*'+kind,width,precision,value)
reals=['0','-0.0','1','-1','0.1','0.5','1.25','1.35','2.5','3.5','2.675','9.9995','9.999999999999998','99.95','0.000099995','0.0000099995','1e20','1e-20','1e308','2.2250738585072014e-308','5e-324','1.7976931348623157e308','Inf','-Inf','NaN','+NaN','nan(123)','1e9999','0x10','09','1_2']
for kind,precision,value in itertools.product('feEgG',[0,1,2,6,15,17,30],reals):fmt('%.'+str(precision)+kind,value)
for kind,precision,value in itertools.product('feEgG',[0,1,6,17],['0','1.25','9.9995','0.00001']):fmt('%#.'+str(precision)+kind,value)
rng=random.Random(20260918)
for i in range(140):
    bits=rng.getrandbits(64)
    value=struct.unpack('>d',bits.to_bytes(8,'big'))[0]
    if not (-float('inf')<value<float('inf')):continue
    for kind in 'feg':fmt('%.'+str(rng.choice([0,1,6,16,17,22]))+kind,repr(value))
for precision in [80,324,1074,1200]:
    for value in ['0.1','5e-324','1.7976931348623157e308']:fmt('%.'+str(precision)+'f',value)
for value in ['', 'abc','中文','😀x','a\0b','e\u0301','\ud800']:
    if value=='\ud800':continue
    for pattern in ['%s','%5s','%-5s','%05s','%.0s','%.1s','%.2s','%5.1s']:
        fmt(pattern,value)
for value in ['-1','0','65','65535','65536','128512','2147483648','4294967295','4294967361','-4294967295']:
    for pattern in ['%c','%4c','%04c','%.0c','%llc']:fmt(pattern,value)
for pattern,args in [('%2$s:%1$04d',[7,'x']),('%1$*.*f',[8,2,1.25]),('%2$*s',['ignore',5,'x']),('%1$d %1$x',[255]),('%%:%1$d',[7]),('%d %2$d',[1,2]),('%1$d %d',[1,2]),('%0$d',[1]),('%01$d',[5]),('%3$s',[1,2]),('%*s',[-5,'x']),('%.*f',[-1,'1.25']),('%.*g',[-1,'1.25']),('%.*s',[-1,'abc']),('literal',[1,2]),('',[])]:fmt(pattern,*args)
for pattern in ['%','%q','%F','%a','%n','%p','%5%','%#%','%Ld','%hhx','%lll','%..f','%1$','%*2$d','%99999999999d']:
    fmt(pattern,1,2,3)
scan_values=['',' ','+','-','.','x','e','123abc','-123tail','09','077','0x','0xg','0xff','0b11','0o77','1e','1e+','1e-2','1.25X','Infinit','Infinity','-Inf','NaN','NaN(abc)',' 12 ','\u200012','1e9999']
scan_values += [str(sign*(2**bits+delta)) for bits in [31,32,63,64] for delta in [-1,0,1] for sign in [-1,1]]
def scan(value,pattern,variables=False):
    if variables:
        add('scan-vars','set a OLD;set b OLD;set r [scan '+word(value)+' '+word(pattern)+' a b];list $r $a $b')
    else:add('scan-inline','scan '+word(value)+' '+word(pattern))
for kind,size,value in itertools.product('diuoxXbf',['','h','l','ll'],scan_values):scan(value,'%'+size+kind+'%n')
for kind,width,value in itertools.product('dixofbs',[0,1,2,3,6],['-12abc','0x123z','1.5e2x','a b','😀x']):
    scan(value,'%'+str(width)+kind+'%n%s')
for kind,value in itertools.product('difscn',scan_values[:28]+['中文','😀x']):scan(value,'%'+kind+'%n',True)
for pattern,value in itertools.product(['%[a-z]%n%s','%[^a-z]%n%s','%[z-a]%n%s','%[]-]%n%s','%[^]]%n%s','%[中😀]%n%s','%3s%n%s','%c%n%s',' %c%n','%n %s%n','%*s %s%n','%*d%d','%*d%n'],['','abc DEF','XYZ','-]abc','ab中','中文','😀x',' 12 34','\u2000x','a\0b']):scan(value,pattern)
for pattern in ['%','%q','%F','%p','%5%','%2$d %1$s','%d %2$d','%*d %2$d','%2$d %2$d','%3$d','%*d %1$d','%n %n','%0c','%1c','%hs','%lls','%Ls','%ln','%lln','%llf','%[]','%[^]','%[a','%0$d','%9999$d']:
    scan('12 34',pattern)
for source in [
 'set a old;set b old;scan {12 x} {%d%d} a b;list $a $b',
 'set a old;set b old;catch {scan {12 34} {%d%q} a b};list $a $b',
 'set a old;scan {12 34} {%d%d} a a;set a',
 'set a old;array set b {k kept};catch {scan {12 34} {%d%d} a b};list $a [array get b]',
 'set a old;proc parse {} {upvar #0 a out;scan 123 %d out};list [parse] $a',
 'array set a {};scan {12 34} {%d%d} a(中) a(x);list $a(中) $a(x)',
 'scan {12 34} {%2$d %1$d} a b;list $a $b',
 'scan 12 {%2$d} a b',
 'scan 12 %d a b',
 'set a old;scan 12 %*d a',
 'scan 12 {} a',
 'scan abc xyz',
 'scan {} abc',
 'scan {} {}',
 'scan abc abc',
 'set s [format {%04d|%.2f|%-6s} 23 1.375 中文];scan $s {%d|%f|%s} a b c;list $s $a $b $c',
]:add('conversion-state',source)


for pattern,value in itertools.product(['%*s','%.*s'],['4294967295','-4294967295']):fmt(pattern,value,'abc')

# Exercise every finite binary64 power of two and independent random inputs.
# Batches keep fresh reference interpreters inexpensive while comparing all text.
import math
values=[repr(math.ldexp(1.0,e)) for e in range(-1074,1024)]
values += [repr(-math.ldexp(1.0,e)) for e in range(-1074,1024,7)]
for i in range(500):
    value=struct.unpack('>d',rng.getrandbits(64).to_bytes(8,'big'))[0]
    if math.isfinite(value):values.append(repr(value))
for i in range(0,len(values),32):
    add('scan-float-text','list '+' '.join('[scan '+word(v)+' %f]' for v in values[i:i+32]))
for source in [
 'scan {12 34} {%2$d %1$d} a a;set a',
 'scan {NaN 7} {%*f%d%n}',
 'scan {NaN(abc) 7} {%*f%d%n}',
 'scan {NaN(z) 7} {%*f%s%n}',
 'scan {NaN} {%*f%d}',
 'scan {NaN} {%f%n}',
 'scan 18446744073709551616 %f v;list [format %.17g $v] [set v]',
]:add('conversion-state',source)

# These are retained reference differences, not passing native oracles. Both
# reference and local contracts are exact so changes cannot be silently ignored.
differences={
 'scan "😀x" "%1s%n%s"':{
  'id':'scan-raw-utf8-fragment',
  'reason':'Native eval keeps four-byte UTF-8 and width 1 cuts the first byte; this interpreter retains UTF-16 units and counts their canonical byte lengths.',
  'referenceResult':'\udcf0 1 \udc9f\udc98\udc80x',
  'localResult':'\ud83d 3 \ude00x',
 },
 'scan 18446744073709551616 %f v;list [format %.17g $v] [set v]':{
  'id':'scan-double-object-identity',
  'reason':'Native variables retain an exact double alongside non-roundtripping display text. Local scalar variables currently retain strings, so later format reparses that text.',
  'referenceResult':'1.8446744073709552e+19 1.844674407370955e+19',
  'localResult':'1.844674407370955e+19 1.844674407370955e+19',
 },
}
for case in cases:
    if case['source'] in differences:case['knownDifference']=differences[case['source']]
