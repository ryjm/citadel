::  * imports
/-  *citadel, zink
/+  mill=zig-mill, smart=zig-sys-smart, merk
::  ** nouns
/*  smart-lib-noun  %noun  /lib/zig/compiled/smart-lib/noun
/*  zink-cax-noun   %noun  /lib/zig/compiled/hash-cache/noun
/*  triv-contract   %noun  /lib/zig/compiled/trivial/noun
/*  scry-contract   %noun  /lib/zig/compiled/trivial-scry/noun
/*  zigs-contract   %noun  /lib/zig/compiled/zigs/noun
::  * main
=,  clay
|%
::  * desk/diagram composition
::    +fose

++  fose
  |=  [=desk init=outpost rest=(list path)]
  ^-  outpost
  ~!  desk
  %+  ~(jab by init)  desk  (cury welp rest)
::    +fuse

++  fuse
  |=  [init=outpost rest=outpost]
  ^-  outpost
  %-  (~(uno by init) rest)  |=([=desk a=(list path) b=(list path)] (welp a b))
::  +foundation - bare minimum

++  foundation
  ^-  outpost
  %-  my
  :~  :-  %base
  :~  /mar/noun/hoon
      /mar/hoon/hoon
      /mar/txt/hoon
      /mar/kelvin/hoon
      /sys/kelvin
  ==  ==
::  +soil - fertilized

++  soil
  ^-  outpost
  %-  my
  :~  :-  %garden
  :~  /mar/docket-0/hoon
      /lib/docket/hoon
      /sur/docket/hoon
  ==  ==
::  +pillar - agent and garden desiderata

++  pillar
  ^-  outpost
  %+  fuse  soil
  %+  fuse  press
  %^  fose  %base  foundation
  :~  /lib/verb/hoon
      /lib/dbug/hoon
      /lib/shoe/hoon
      /lib/agentio/hoon
      /lib/default-agent/hoon
      /lib/skeleton/hoon
      /mar/bill/hoon
      /mar/mime/hoon
      /sur/verb/hoon
  ==
::  +cellar - threads

++  cellar
  ^-  outpost
  %^  fose  %base  foundation
  :~  /sur/spider/hoon
      /lib/strandio/hoon
      /lib/strand/hoon
  ==
::  +seals - scroll marks

++  seals
  ^-  outpost
  %-  my
  :~  :-  %docs
  :~  /mar/udon/hoon
      /mar/json/hoon
      /mar/clue/hoon
      /lib/cram/hoon
      /sur/docs/hoon
  ==  ==
::  +press - pretty printing

++  press

  ^-  outpost
  %-  my
  :~  :-  %base
  :~  /sur/plum/hoon
      /sur/xray/hoon
      /lib/plume/hoon
      /lib/xray/hoon
      /lib/pprint/hoon
  ==  ==

::    partial diagrams

::  +cutlery - metadata

++  cutlery
  ^-  atelier
  :~  /dia/bas/desk/docket-0
      /dia/bas/desk/bill
  ==
::  +scrolls - ~pocwet/docs materials

++  scrolls
  ^-  atelier
  :~  /dia/docs/doc/dev/agent-1/udon
      /dia/docs/doc/dev/agent-2/udon
      /dia/docs/doc/dev/basic/udon
      /dia/docs/doc/usr/changelog/udon
      /dia/docs/doc/usr/overview/udon
      /dia/docs/doc/clue
  ==
::  +mansion - all requisites

++  mansion  ^-  grounds  [pillar cutlery]

::    complete diagrams

::  +butlers - agent examples

++  butlers
  ^-  grounds
  %^  build-estate  &  ~
  :~  /dia/ent/app/ent/hoon
  ==
::  +valet - cli examples

++  valet
  ^-  grounds
  %^  build-estate  &  ~
  :~  /dia/cli/app/cli/hoon
  ==
::  +crier - hello world examples

++  crier
  ^-  grounds
  %^  build-estate  &  ~
  :~  /dia/hel/app/hel/hoon
  ==
::  +library - docs

++  library
  ^-  grounds
  %^  build-estate  &  `seals
  scrolls
::  +frontage - apps with agent and frontend

++  frontage
  ^-  grounds
  mansion
::  +circuitry - thread examples

++  circuitry
  ^-  grounds
    :-  foundation
    :~  /dia/ted/ted/hi/hoon
    ==
::  +turbines - generator examples

++  turbines
  ^-  grounds
  :-  foundation
  :~  /dia/gen/app/gen/hoon
  ==
::    +build-estate
::  raises the roof
++  build-estate
  |=  [lor=? mout=(unit outpost) =atelier]
  ^-  grounds
  =+  ?~  mout  outpost:mansion
    (fuse outpost:mansion u.mout)
  :-  ?:  lor  (fuse seals -)
    -
  (welp atelier:mansion atelier)
::  * uqbar
++  read-shut                                               ::  slam a door
    |=  [dor=vase arm=@tas dor-sam=vase arm-sam=vase arm-arm=?(%noun %json)]
    ^-  vase
    %+  slap
      (slop dor (slop dor-sam arm-sam))
    ^-  hoon
    :-  %cnsg
    :^    [arm-arm ~]
        [%cnsg [arm ~] [%$ 2] [%$ 6] ~]  ::  replace sample
      [%$ 7]
    ~
::  uqbar contracts.

::  per-desk/contract module.
++  uq
  |_  [code=@t mesk=(unit [desk path])]

::  ** utils
  ++  compile
    |=  [pax=path our=@p now=@da]
    =/  exists=?  .^(? %cu pax)
    ~&    >>
      ?:  exists  "contract {<path>} exists in clay"
    "no contract to {<path>}"
    ?>  exists
    =/  contract-text  .^(@t %cx pax)
    =/  [raw=(list [face=term =path]) contract-hoon=hoon]
      (parse-pile (trip contract-text))
    =/  smart-txt  .^(@t %cx /(scot %p our)/citadel/(scot %da now)/lib/zig/sys/smart/hoon)
    =/  hoon-txt  .^(@t %cx /(scot %p our)/citadel/(scot %da now)/lib/zig/sys/hoon/hoon)
    =/  hoe  (slap !>(~) (ream hoon-txt))
    =/  smart-lib=vase  (slap hoe (ream smart-txt))
    ::
    =/  braw=(list hoon)
      %+  turn  raw
      |=  [face=term =path]
      =/  pax=^path  (weld /(scot %p our)/citadel/(scot %da now) path)
      ~&  >>  building+pax
      %-  road  |.
      ~_  leaf/"{pax}: build failed"
      `hoon`[%ktts face (reck pax)]
    =/  full=hoon  [%clsg braw]
    q:(~(mint ut p.smart-lib) %noun full)
    ::  =/  payload  .*(full-nock pay.cont)
    ::  =/  battery  .*([full-nock payload] bat.cont)
    ::  =/  dor      [-:!>(*contract:smart) battery]
::  *** test mill
::  an example fake mill.
++  test-mill
  =/  =yolk:smart
  [%give [holder-2:zigs 69 [%grain holder-1:zigs]] `[%grain holder-2:zigs]]
  =/  =shell:smart
    [caller-1 ~ id.p:wheat:zigs 1 1.000.000 town-id 1]
  (fondle-mill yolk shell fake-granary)

::  *** fondle-mill
::  mills yolk and shell on fake-land.
++  fondle-mill
  |=  [=yolk:smart =shell:smart =granary:mill]
  =/  =egg:smart  [fake-sig shell yolk]
  =/  =land:mill  ;;(land:mill [granary fake-populace])
  %+  ~(mill mil miller town-id 1)
    land
  egg
::  ** fake data
::  *** mill
::  initializes a dummy mill for testing.
++  big  (bi:merk id:smart grain:smart)  ::  merkle engine for granary
++  pig  (bi:merk id:smart @ud)          ::                for populace
++  init-now  *@da
++  town-id    0x0
++  set-fee    7
++  fake-sig   [0 0 0]
++  mil
  %~  mill  mill
  :+    ;;(vase (cue q.q.smart-lib-noun))
    ;;((map * @) (cue q.q.zink-cax-noun))
  %.y
+$  mill-result
  [fee=@ud =land:mill burned=granary:mill =errorcode:smart hits=(list hints:zink) =crow:smart]
::  **** callers
::  fake callers used in +test-mill
++  miller    ^-  caller:smart  [0x1512.3341 1 0x1.1512.3341]
++  caller-1  ^-  caller:smart  [0xbeef 1 0x1.beef]
++  caller-2  ^-  caller:smart  [0xdead 1 0x1.dead]
++  caller-3  ^-  caller:smart  [0xcafe 1 0x1.cafe]
::  *** scry wheat
::  fake grain representing the compiled trivial-scry contract.
++  scry-wheat
  ^-  grain:smart
  =/  cont  ;;([bat=* pay=*] (cue q.q.scry-contract))
  =/  interface=lumps:smart  ~
  =/  types=lumps:smart  ~
  :*  %|
      `cont
      interface
      types
      0xdada.dada  ::  id
      0xdada.dada  ::  lord
      0xdada.dada  ::  holder
      town-id
  ==

::  *** granary
::  fake granary containing all the grains used by the dummy mill.
++  fake-granary
  ^-  granary:mill
  %+  gas:big  *(merk:merk id:smart grain:smart)
  :~  [id.p:scry-wheat scry-wheat]
      ::  [id.p:wheat:zigs wheat:zigs]
      [id.p:beef-account:zigs beef-account:zigs]
      [id.p:dead-account:zigs dead-account:zigs]
      [id.p:miller-account:zigs miller-account:zigs]
  ==
::  *** populace

++  fake-populace
  ^-  populace:mill
  %+  gas:pig  *(merk:merk id:smart @ud)
  ~[[holder-1:zigs 0] [holder-2:zigs 0] [holder-3:zigs 0]]
::  *** land

++  fake-land
  ^-  land:mill
  [fake-granary fake-populace] 

::  ** fake zigs
::  represents the %zig contract.
++  zigs
  |_  =grain:smart
::  *** grains
::  fake grains
++  holder-1  0xbeef
++  holder-2  0xdead
++  holder-3  0xcafe
++  miller-account
  ^-  grain:smart
  :*  %&
      `@`'zigs'
      %account
      [1.000.000 ~ `@ux`'zigs-metadata']
      0x1.1512.3341
      zigs-wheat-id:smart
      0x1512.3341
      town-id
  ==
++  beef-account
  ^-  grain:smart
  :*  %&
      `@`'zigs'
      %account
      [300.000.000 ~ `@ux`'zigs-metadata']
      0x1.beef
      zigs-wheat-id:smart
      holder-1
      town-id
  ==
++  dead-account
  ^-  grain:smart
  :*  %&
      `@`'zigs'
      %account
      [200.000 ~ `@ux`'zigs-metadata']
      0x1.dead
      zigs-wheat-id:smart
      holder-2
      town-id
  ==
++  cafe-account
  ^-  grain:smart
  :*  %&
      `@`'zigs'
      %account
      [100.000 ~ `@ux`'zigs-metadata']
      0x1.cafe
      zigs-wheat-id:smart
      holder-3
      town-id
  ==
++  wheat
  ^-  grain:smart
  =/  cont  ;;([bat=* pay=*] (cue q.q.zigs-contract))
  =/  interface=lumps:smart  ~
  =/  types=lumps:smart  ~
  :*  %|
      `cont
      interface
      types
      zigs-wheat-id:smart  ::  id
      zigs-wheat-id:smart  ::  lord
      zigs-wheat-id:smart  ::  holder
      town-id
  ==
--

::  ** parsers
::  contract-specific parsing.
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
++  pant
  |*  fel=^rule
  ;~(pose fel (easy ~))
++  mast
  |*  [bus=^rule fel=^rule]
  ;~(sfix (more bus fel) bus)
++  rune
  |*  [bus=^rule fel=^rule]
  %-  pant
  %+  mast  gap
  ;~(pfix fas bus gap fel)
--

::  * clay utils
::
::  clay utilities
::
::  ** file motion
++  play
  |_  [=bowl:gall =desk]
::  *** write
::  **** cite
    ::    +cite
    ::
    ::  write file to desk.
    ++  cite
      |=  [=path data=cage]
      ^-  cards
      =*  bek  byk.bowl
      ~&  >>  "saving to {<desk>} at {<path>}"
      ~|  "failed write to {<desk>}"
      =-  [%pass /citadel/write %arvo %c %info -]~
      =/  fath=^path  (weld /(scot %p our.bowl)/[desk]/(scot %da now.bowl) path)
      ~&  >>  "saved to {<desk>} at {<path>}"
      (foal:space:userlib fath data)
::  **** hite
    ::    +hite
    ::
    ::  write text as hoon to desk.
    ++  hite
      |=  [=path txt=@t]
      ^-  cards
      =/  =mark  (rear path)
      =/  =type  [%atom %t ~]
      =-  (cite path -)
      [mark [type ?:(=(%hoon mark) txt (need (de-json:html txt)))]]
::  **** gite
    ::    +gite
    ::
    ::  write deeds
    ++  gite
      |=  deeds=(list deed)
      ^-  cards
      %-  zing
      %+  turn  deeds
      |=  =deed
      ^-  cards
      =,  scroll.deed
      ?<  =(~ text)
      =.  desk  ?.  =(~ project)  +.project  desk
      (hite (weld /(scot %tas -.deed) path) +.text)
    ::
::  **** smart-lib copy
    ::    +zuck
    ::
    ::  copies smart-lib from a ziggurat desk.
    ++  zuck
      |=  dusk=^desk
      |^  ~|  "citadel: missing smart-lib in {<desk>}"
      (cite /lib/zig/compiled/smart-lib/noun [%noun !>((need smar))])
      ::      
      ++  smar
        ^-  (unit *)
        %-  file:space:userlib
        /(scot %p our.bowl)/[dusk]/(scot %da now.bowl)/lib/zig/compiled/smart-lib/noun
      --

::  ** from desk
    ::    +scop: init desk from files in another desk.
    ::
    ::  grounds - user and dependency files to seed the desk with.
    ::            must exist in the given desk.
    ::
    ::  TODO simulate symlinks somehow?
    ::
    ++  scop
      |=  $:  from=^desk
              =grounds
          ==
      =/  bek  byk.bowl
      =/  desks  .^((set ^desk) %cd (en-beam bek(q from) /))
      ?:  (~(has in desks) desk)
        ~|  [%already-exists desk]
        !!
      %^  new-desk:cloy  desk  ~
      |^
      =/  all=(map ^desk (list path))
        ?:  =(~ atelier.grounds)  outpost.grounds
        %+  ~(put by outpost.grounds)  %citadel  atelier.grounds
      %-  ~(gas by *(map path page:clay))
      =-  %+  roll  -
      |=  $:  [d=@tas l=(list [path page:clay])]
              out=(list [path page:clay])
          ==
      (weld out l)
      =-  ~(tap by -)
      %-  ~(urn by all)
      |=  [des=@tas files=(list path)]
      ^-  (list [path page:clay])
      =/  [=ship orig=^desk =case:clay]  bek
      =+  .^(=rang:clay %cx /(scot %p our.bowl)//(scot %da now.bowl)/rang)
      =+  .^(=dome:clay %cv (en-beam bek(q from) /))
      =/  =yaki
        %-  ~(got by hut.rang)
        %-  ~(got by hit.dome)
        let.dome
        ~&  >  %yaki
      =/  paths=(list [=path =lobe])
        %+  murn  files
        |=  =path
        ?.  %-  ~(has by q.yaki)  path  ~
          :-  ~
          :-  path
          %-  ~(got by q.yaki)  path
      (turn paths (cury mage rang))
      ::  +mage - page from clay. %dia paths in %citadel
      ::          have the form /dia/<name>/...
      ::
      ++  mage
        |=  [=rang:clay =path =lobe]
        ::  TODO should be the desk containing this file
        :-  ?:  &(?=([%dia @ *] path) =(from %citadel))
          t.t.path
        path
        ^-  page:clay
        ~|  [%missing-source-file [from q.bek] path]
        (~(got by lat.rang) lobe)
     --
    --


  --
