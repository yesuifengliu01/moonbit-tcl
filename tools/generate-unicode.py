"""Generate compact BMP property and simple-case tables from official UCD 16."""
from pathlib import Path
import hashlib,json
root=Path(__file__).resolve().parents[1]
folder=root/'vendor/ucd-16.0.0'
data=(folder/'UnicodeData.txt').read_bytes()
assert hashlib.sha256(data).hexdigest()=='ff58e5823bd095166564a006e47d111130813dcf8bf234ef79fa51a870edb48f'
classes=['alnum','alpha','ascii','control','digit','graph','lower','print','punct','space','upper','wordchar','xdigit']
categories=['Cn']*65536
mapping={}
start=None
for line in data.decode('utf-8').splitlines():
 f=line.split(';');cp=int(f[0],16)
 if cp>65535:continue
 if f[1].endswith(', First>'):start=cp;continue
 if f[1].endswith(', Last>'):
  for i in range(start,cp+1):categories[i]=f[2]
  start=None;continue
 categories[cp]=f[2]
 lower=int(f[13],16) if f[13] else cp
 upper=int(f[12],16) if f[12] else cp
 title=int(f[14],16) if f[14] else upper
 if (lower,upper,title)!=(cp,cp,cp):mapping[cp]=(lower,upper,title)
def mask(cp):
 cat=categories[cp];alpha=cat.startswith('L');digit=cat=='Nd';graph=cat[0] in 'LMNPS';space=cat[0]=='Z' or cp in [9,10,11,12,13,0x85,0x180e,0x200b,0x2060,0xfeff]
 bits=[alpha or digit,alpha,cp<128,cat in ['Cc','Cf'],digit,graph,cat=='Ll',graph or cat[0]=='Z',cat[0]=='P',space,cat=='Lu',alpha or digit or cat=='Pc',chr(cp) in '0123456789abcdefABCDEF']
 return sum((1<<i) for i,value in enumerate(bits) if value)
ranges=[];start=0;current=mask(0)
for cp in range(1,65537):
 value=mask(cp) if cp<65536 else -1
 if value!=current:
  if current:ranges.append((start,cp-1,current))
  start=cp;current=value
lines=['// Generated from UnicodeData.txt 16.0.0; see vendor/ucd-16.0.0/LICENSE.txt.','// Do not edit: run python tools/generate-unicode.py.','///|','let unicode_properties : Array[(Int, Int, Int)] = [']
lines += ['  ('+', '.join(map(str,row))+'),' for row in ranges]
lines += [']','///|','let unicode_cases : Array[(Int, Int, Int, Int)] = [']
lines += ['  ('+', '.join(map(str,(cp,*row)))+'),' for cp,row in sorted(mapping.items())]
lines += [']','']
(root/'unicode_data.mbt').write_text('\n'.join(lines),encoding='utf-8',newline='\n')
print('Generated',len(ranges),'property ranges and',len(mapping),'simple case entries')
