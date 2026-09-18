"""Original array programs, expected results supplied by unmodified Tcl 8.6.15."""
import itertools
import random

cases = []


def q(s):
    return '"' + ''.join({'\\': '\\\\', '"': '\\"', '$': '\\$', '[': '\\[', ']': '\\]', '\n': '\\n', '\r': '\\r', '\t': '\\t', '\0': '\\x00'}.get(c, c) for c in s) + '"'


def listing(xs):
    return '[list ' + ' '.join(q(x) for x in xs) + ']'


def caught(s):
    return 'set code [catch ' + q(s) + ' r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]'


def add(name, source):
    cases.append(dict(name=name + '-' + str(len(cases)), source=source))


for size, prefix in itertools.product([0, 1, 3, 4, 10, 11, 12, 13, 47, 48, 49, 191, 192, 193, 767, 768, 769], ['', 'k', 'same']):
    setup = 'array set a {};for {set i 0} {$i<' + str(size) + '} {incr i} {set a(' + prefix + '$i) $i};'
    add('hash-order', setup + 'list [array names a] [array get a] [array statistics a]')
    add('hash-delete', setup + 'for {set i 0} {$i<' + str(size) + '} {incr i 2} {unset a(' + prefix + '$i)};list [array names a] [array statistics a]')
    add('cursor-order', setup + 'set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]')
for keys in [[], [''], ['a', 'i', 'q', 'y', 'aa', 'ai', 'aq', 'ay'], ['é', '中', '😀', '\0', 'a\0b', 'a'], ['𐀀', '\uffff', 'x'], ['a' * i for i in range(1, 40)], ['a b', 'a(b)', '$x', '{', '\\', '\n']]:
    for order in [keys, list(reversed(keys))]:
        setup = 'array set a {};foreach k ' + listing(order) + ' {set a($k) $k};'
        add('key-representations', setup + 'list [array names a] [array get a] [array statistics a]')
        add('key-cursor', setup + 'set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out')
        add('key-reinsert', setup + 'foreach k ' + listing(order[::2]) + ' {unset a($k);set a($k) newer};list [array names a] [array statistics a]')

for source in [
    'array set a {};set x [array startsearch a];set y [array startsearch a];array donesearch a $y;set z [array startsearch a];array donesearch a $x;array donesearch a $z;list $x $y $z [array startsearch a]',
    'array set a {x 1};set x [array startsearch a];set y [array startsearch a];list [array nextelement a $x] [array nextelement a $y] [array anymore a $x] [array anymore a $y]',
    'array set a {x 1};set s [array startsearch a];list [array anymore a $s] [array anymore a $s] [array nextelement a $s] [array anymore a $s] [array nextelement a $s] [array nextelement a $s]',
    'array set a {x 1};array set b {};list [array startsearch a] [array startsearch b]',
]:
    add('lifecycle', source)

mutations = ['set a(x) 2', 'array set a {x 3}', 'incr a(x)', 'append a(x) suffix', 'lappend a(x) extra', 'array set a {}', 'set a(y) 2', 'unset a(x)', 'unset -nocomplain a(no)', 'array unset a no*', 'array unset a x', 'array unset a *', 'unset a;array set a {x 2}', 'array unset a;array set a {x 2}', 'array get a', 'array names a', 'array statistics a']
for mutation, advance in itertools.product(mutations, ['', 'array anymore a $s;', 'array nextelement a $s;']):
    add('mutation', 'array set a {x 1};set s [array startsearch a];' + advance + mutation + ';set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]')
for key, command in itertools.product(['x', 'z'], ['upvar #0 a(KEY) b', 'upvar #0 a(KEY) b;set b 2', 'upvar #0 a(KEY) b;unset -nocomplain b', 'upvar #0 a(KEY) b;unset -nocomplain a(KEY)', 'proc p {} {upvar #0 a(KEY) b};p']):
    command = command.replace('KEY', key)
    add('alias-mutation', 'array set a {x 1};set s [array startsearch a];' + command + ';set c [catch {array anymore a $s} r];list $c $r [array names a] [array statistics a]')
for first, second in itertools.product(['a', '::a', 'b', '::b'], repeat=2):
    setup = 'array set a {x 1};upvar #0 a b;set s [array startsearch ' + first + '];'
    add('alias-spelling', setup + caught('array anymore ' + second + ' $s'))
for source in [
    'array set a {x 1};upvar #0 a b;array startsearch a;array anymore b s-1-b',
    'array set a {};upvar #0 a(x) b;list [array names a] [array size a] [array statistics a]',
    'array set a {x 1};upvar #0 a(x) b;unset b;list [array names a] [array statistics a]',
    'array set a {x 1};upvar #0 a(x) b;unset a;array set a {x 2};list [catch {set b} r] $r [catch {set b 3} r] $r $a(x)',
    'array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];set b 2;list [array anymore a $s] [array names a]',
    'array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];unset -nocomplain b;list [catch {array anymore a $s} r] $r',
    'array set a {x 1};proc p {} {upvar #0 a(z) b;return done};list [p] [array statistics a]',
    'array set a {x 1};proc p {} {upvar #0 a(z) b;error fail};list [catch {p}] [array statistics a]',
    'array set a {x 1};upvar #0 a(z) b;upvar #0 a(x) b;list $b [array statistics a]',
    'array set a {};proc p {} {upvar #0 a(x) b;upvar #0 a(x) c;set b 2};p;list [array names a] [array get a] [array statistics a]',
    'namespace eval n {array set a {x 1}};upvar #0 n::a b;set s [array startsearch b];namespace delete n;list [array exists b] [catch {array anymore b $s}]',
    'array set a {x 1};namespace eval n {upvar #0 a(z) b};namespace delete n;array statistics a',
    'proc p {} {array set a {x 1};namespace eval n {upvar 1 a b}};p;array exists n::b',
    'namespace eval n {variable a;array set a {x 1};proc p {} {variable a;set s [array startsearch a];list $s [array nextelement a $s]}};n::p',
]:
    add('alias-lifetime', source)

for token in ['', 's-', 's-0-a', 's-1-a', 's-01-a', 's-+1-a', 's- 1-a', 's-\t1-a', 's-0x1-a', 's--1-a', 's--4294967295-a', 's-4294967297-a', 's-18446744073709551617-a', 's-1-b', 'bogus', 's-1-a\0junk', 's-1-a-extra']:
    for command in ['anymore', 'nextelement', 'donesearch']:
        add('handle', 'array set a {x 1};array startsearch a;' + caught('array ' + command + ' a ' + q(token)))

commands = ['anymore', 'donesearch', 'exists', 'get', 'names', 'nextelement', 'set', 'size', 'startsearch', 'statistics', 'unset']
for op in commands:
    for length in range(0, len(op) + 1):
        for args in ['', ' a', ' a s-1-a', ' a s-1-a extra']:
            add('prefix-arity', 'array set a {x 1};array startsearch a;' + caught('array ' + q(op[:length]) + args))
for pre in ['', 'array set a {}', 'array set a {x 1}', 'set a scalar', 'array set a {};upvar #0 a(x) b']:
    for command in ['array', 'array bad', 'array startsearch a', 'array statistics a', 'array anymore a s-1-a', 'array nextelement a s-1-a', 'array donesearch a s-1-a', 'array set a {}', 'array set a {x 1}', 'array set a {x}', 'array set a ' + q('{'), 'array set a(x) {}', 'array set a(x) {y 1}', 'array set ::missing::a {}', 'array names a -bad x', 'array names a - x']:
        add('diagnostics', pre + ';' + caught(command))
for mode, pattern in itertools.product(['', '-exact', '-glob', '-regexp'], ['*', '', 'x*', 'x', '^x', '[', '.*', '😀', 'a\0b']):
    add('names-pattern', 'array set a ' + listing(['x', '1', 'x0', '2', '', '3', '😀', '4', 'a\0b', '5']) + ';' + caught('array names a ' + mode + ' ' + q(pattern)))
for command in ['get', 'unset']:
    for pattern in ['*', 'x*', 'x', '', '?', '[xy]', 'a\0b', '😀']:
        setup = 'array set a ' + listing(['x', '1', 'x0', '2', '', '3', '😀', '4', 'a\0b', '5']) + ';'
        add('pattern-' + command, setup + 'list [array ' + command + ' a ' + q(pattern) + '] [array get a] [array statistics a]')

for kind in ['literal', 'unicode', 'formatted']:
    key = q('𐀀') if kind == 'literal' else ('[string toupper ' + q('𐀀') + ']' if kind == 'unicode' else '[format %c 65536]')
    add('supplementary-representation', 'array set a {};set k ' + key + ';set a($k) 1;set a(x) 2;list [array names a] [array statistics a]')
for unit in ['\\ud800', '\\udfff']:
    add('isolated-unit', 'array set a {};set k "' + unit + '";set a($k) 1;list [array names a] [array statistics a]')

rng = random.Random(16016)
for sample in range(80):
    steps = ['array set a {};set events {};set s [array startsearch a]']
    for i in range(24):
        key = rng.choice(['a', 'b', 'c', '', 'k0', 'k1', 'k2', 'a b'])
        op = rng.randrange(7)
        if op == 0:
            command = 'set a(' + key + ') ' + str(rng.randrange(100)) if ' ' not in key else 'array set a ' + listing([key, str(rng.randrange(100))])
        elif op == 1:
            command = 'array unset a ' + q(key)
        elif op == 2:
            command = 'array set a ' + listing([key, str(rng.randrange(100))])
        elif op == 3:
            command = 'array anymore a $s'
        elif op == 4:
            command = 'array nextelement a $s'
        elif op == 5:
            command = 'set s [array startsearch a]'
        else:
            command = 'array donesearch a $s'
        steps.append('set c [catch ' + q(command) + ' r];lappend events [list $c $r]')
    steps.append('list $events [array names a] [array get a] [array statistics a]')
    add('state-trace', ';'.join(steps))

for size in [1, 11, 12, 13, 47, 48, 49]:
    setup = 'array set a {visible 1};'
    links = ';'.join('upvar #0 a(k' + str(i) + ') b' + str(i) for i in range(size))
    add('undefined-buckets', setup + links + ';list [array size a] [array names a] [array statistics a]')
    add('scope-cleanup', setup + 'proc p {} {' + links + ';return [array statistics ::a]};list [p] [array names a] [array statistics a]')
for mutation in ['set b 2', 'unset b', 'unset -nocomplain b', 'set a(z) 2', 'unset -nocomplain a(z)']:
    for advance in ['', 'array anymore a $s;', 'array nextelement a $s;']:
        setup = 'array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];'
        add('retained-cursor', setup + advance + 'catch {' + mutation + '};' + caught('list [array anymore a $s] [array nextelement a $s] [array anymore a $s]'))
for name in ['a b', 'a-b', '', '中', '::a', 'a\0b']:
    add('array-name', 'array set ' + q(name) + ' {x 1};set s [array startsearch ' + q(name) + '];list $s [array anymore ' + q(name) + ' $s] [array nextelement ' + q(name) + ' $s]')

add('deleted-array-alias-write','set a(x) 1;upvar #0 a(x) y;unset a;set y 7;set a(x)')
