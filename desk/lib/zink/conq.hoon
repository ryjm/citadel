/+  *zink-zink, smart=zig-sys-smart
/*  triv-contract   %noun  /lib/zig/compiled/trivial/noun
/*  triv-txt        %hoon  /lib/zig/contracts/trivial/hoon
|%
::
++  hash
  |=  [n=* cax=cache]
  ^-  phash
  ?@  n
    ?:  (lte n 12)
      =/  ch  (~(get by cax) n)
      ?^  ch  u.ch
      (hash:pedersen n 0)
    (hash:pedersen n 0)
  ?^  ch=(~(get by cax) n)
    u.ch
  =/  hh  $(n -.n)
  =/  ht  $(n +.n)
  (hash:pedersen hh ht)
::
++  build-slapped
  |=  [hoonlib-txt=@t smartlib-txt=@t]
  ^-  vase
  =/  [raw=(list [face=term =path]) contract-hoon=hoon]  (parse-pile (trip triv-txt))
  =/  smart-lib=vase  (slap (slap !>(~) (ream hoonlib-txt)) (ream smartlib-txt))
  =/  libraries=hoon  [%clsg ~]
  =/  full-nock=*  q:(~(mint ut p.smart-lib) %noun libraries)
  =/  payload=vase  (slap smart-lib libraries)
  ::
  (slap (slop smart-lib payload) contract-hoon)
::
++  conq
  |=  [hoonlib-txt=@t smartlib-txt=@t cax=cache bud=@ud]
  ^-  (map * phash)
  |^
  =.  cax
    %-  ~(gas by cax)
    %+  turn  (gulf 0 12)
    |=  n=@
    ^-  [* phash]
    [n (hash n ~)]
  ~&  >>  %compiling-hoon
  ~&  >>  %compiling-smart
  =/  built-contract  (build-slapped hoonlib-txt smartlib-txt)
  ~&  >>  %hashing-arms
  =.  cax
    %^  cache-file  built-contract
      cax
    :~  ::  hoon
        'add'
        'biff'
        'egcd'
        'po'
        ::  smart
        'mimes:html'
        'aes:crypto'
        'pass:ames'
        'fu:number'
        't:pedersen'
        'pedersen'
        ::
        'merk'
        ::
        'ship'
        'id'
        'husk'
    ==
  ~&  >>  %core-hashing
  =/  [raw=(list [face=term =path]) contract-hoon=hoon]  (parse-pile (trip triv-txt))
  =/  smart-lib=vase  (slap (slap !>(~) (ream hoonlib-txt)) (ream smartlib-txt))
  =/  full=hoon  [%clsg ~]
  =/  full-nock=*  q:(~(mint ut p.smart-lib) %noun full)
  =/  payload=vase  (slap smart-lib full)
  =/  cont  (~(mint ut p:(slop smart-lib payload)) %noun contract-hoon)
  ::
  =/  gun  (~(mint ut p.cont) %noun (ream '~'))
  =/  =book  (zebra bud cax *granary-scry [q.cont q.gun] %.n)
  ~&  p.book
  cax.q.book
  ::
  ++  cache-file
    |=  [vax=vase cax=cache layers=(list @t)]
    ^-  cache
    |-
    ?~  layers
      cax
    =/  cor  (slap vax (ream (cat 3 '..' i.layers)))
    =/  min  (~(mint ut p.vax) %noun (ream (cat 3 '..' i.layers)))
    $(layers t.layers, cax (hash-arms cor cax))
  ::
  ++  hash-arms
    |=  [vax=vase cax=(map * phash)]
    ^-  (map * phash)
    =/  lis  (sloe p.vax)
    =/  len  (lent lis)
    =/  i  1
    |-
    ?~  lis  cax
    =*  t  i.lis
    ~&  >  %-  crip
           %-  zing
           :~  (trip t)
               (reap (sub 20 (met 3 t)) ' ')
               (trip (rap 3 (scot %ud i) '/' (scot %ud len) ~))
           ==
    =/  n  q:(slot (arm-axis vax t) vax)
    ~&  >>  "size: {<(met 3 (jam n))>}"
    $(lis t.lis, cax (~(put by cax) n (hash n cax)), i +(i))
  --
::  conq helpers
++  arm-axis
  |=  [vax=vase arm=term]
  ^-  @
  =/  r  (~(find ut p.vax) %read ~[arm])
  ?>  ?=(%& -.r)
  ?>  ?=(%| -.q.p.r)
  p.q.p.r
::
::  parser helpers
::
+$  small-pile
    $:  raw=(list [face=term =path])
        =hoon
    ==
++  parse-pile
  |=  tex=tape
  ^-  small-pile
  =/  [=hair res=(unit [=small-pile =nail])]  (pile-rule [1 1] tex)
  ?^  res  small-pile.u.res
  %-  mean  %-  flop
  =/  lyn  p.hair
  =/  col  q.hair
  :~  leaf+"syntax error at [{<lyn>} {<col>}]"
      leaf+(runt [(dec col) '-'] "^")
      leaf+(trip (snag (dec lyn) (to-wain:format (crip tex))))
  ==
++  pile-rule
  %-  full
  %+  ifix  [gay gay]
  ;~  plug
    %+  rune  tis
    ;~(plug sym ;~(pfix gap stap))
  ::
    %+  stag  %tssg
    (most gap tall:vast)
  ==
++  rune
  |*  [bus=rule fel=rule]
  %-  pant
  %+  mast  gap
  ;~(pfix fas bus gap fel)
++  pant
  |*  fel=rule
  ;~(pose fel (easy ~))
++  mast
  |*  [bus=rule fel=rule]
  ;~(sfix (more bus fel) bus)
--