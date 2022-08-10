/+  *zink-zink, smart=zig-sys-smart
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
  =/  hoonlib   (slap !>(~) (ream hoonlib-txt))
  ~&  >>  %compiling-smart
  =/  smartlib  (slap hoonlib (ream smartlib-txt))
  ~&  >>  %hashing-hoon-arms
  =.  cax
    %^  cache-file  hoonlib
      cax
    :~  'add'
        'biff'
        'egcd'
        'po'
    ==
  ~&  >>  %hashing-smart-arms
  =.  cax
    %^  cache-file  smartlib
      cax
    'fry-contract'^~
  ~&  >>  %core-hashing
  =/  con  (slop (slot 2 !>(*contract:smart)) (slop !>(*cart:smart) smartlib))
  ~&  (arm-axis con %dec)
  =/  gun  (~(mint ut p.con) %noun (ream '~'))
  =/  =book  (zebra bud cax [q.con q.gun])
  cax.q.book
  ::
  ++  cache-file
    |=  [vax=vase cax=cache layers=(list @t)]
    ^-  cache
    |-
    ?~  layers
      cax
    =/  cor  (slap vax (ream (cat 3 '..' i.layers)))
    ~&  >>  i.layers
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
    $(lis t.lis, cax (~(put by cax) n (hash n cax)), i +(i))
  ::
  ++  arm-axis
    |=  [vax=vase arm=term]
    ^-  @
    =/  r  (~(find ut p.vax) %read ~[arm])
    ?>  ?=(%& -.r)
    ?>  ?=(%| -.q.p.r)
    p.q.p.r
  --
--
