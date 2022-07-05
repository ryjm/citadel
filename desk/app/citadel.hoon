/-  *citadel, docket, *treaty
/+  *zig-mill, smart=zig-sys-smart, default-agent, dbug, agentio, *citadel
/*  smart-lib-noun  %noun  /lib/zig/compiled/smart-lib/noun
!:
|%
+$  card  card:agent:gall
+$  cards  (list card)
::  colonies - dependencies for desk
::
+$  state-0  [%0 colonies=(map desk outpost)]
::
--
::
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    io    ~(. agentio bowl)
    do    ~(. +> bowl)
    ch    ch:do
    cg    cg:do
++  on-peek
  |=  =path
  |^  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%x %colony * ~]
    ``noun+!>((~(get by colonies) i.t.t.path))
      [%x %colonies ~]
    ``noun+!>(colonies)
  ==
  --
++  on-init   on-init:def
++  on-save   !>(state)
++  on-load
  |=  ole=vase
    ^-  (quip card _this)
    ~&  >  [dap.bowl %load-citadel]
    ~&  >  "installing ~pocwet/docs"
    =/  maybe-old  (mule |.(!<(state-0 ole)))
    =/  old=state-0
      ?:  ?=(%| -.maybe-old)  [%0 *(map desk outpost)]  +.maybe-old
    =^  cards  state  lore:do
    [cards this(state old)]
++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    =^  cards  state
      ?+    mark  (on-poke:def mark vase)
          %citadel-action
        =+  !<(poke=action vase)
        (on-action:do poke)
          %citadel-poke-action
        =+  !<(poke=poke-action vase)
        (on-poke-action:do poke)
      ==
    [cards this]
++  on-watch
    |=  =path
    ^-  (quip card _this)
    =^  cards  state
      ?+  path  (on-watch:def path)
        [%citadel-primary *]   (peer-citadel-primary:do t.path)
      ==
    [cards this]
++  on-leave  on-leave:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
|_  =bowl:gall
++  io    ~(. agentio bowl)
++  pass  pass:io
++  cg
  |%
  ++  docket-install
    |=([her=ship there=desk] docket-install+!>([her there]))
  ++  ally-update      |=(=update:ally ally-update-0+!>(update))
  --
++  ch
  |_  =desk
  ++  pass  |=(=wire ~(. ^pass [%citadel desk wire]))
  ++  ally-update
    |=  [=ship]
    (poke-our:(pass /treaty-update) %treaty (ally-update:cg [%add ship]))
  ++  install
    |=  [=ship remote=^desk]
    (poke-our:(pass /docket-install) %docket (docket-install:cg ship remote))
  --
++  zh
  |_  [code=@t mesk=(unit [desk path])]
  ++  make-wheat
    ^-  [cards wheat:smart]
    ~&  >>  "in make-wheat"
    =/  =desk  ?^  mesk  -:(need mesk)  %citadel
    =/  pax=path  ?^  mesk  +:(need mesk)  /contracts/scratch/hoon
    =/  bek  byk.bowl
    =/  exists=?  .^(? %cu (en-beam bek(q desk) pax))
    ~&    >>
      ?:  exists  "contract {<pax>} exists in clay, will overwrite"
    "writing contract to {<pax>}"
    =/  contract-text  code
    =/  [raw=(list [face=term =path]) contract-hoon=hoon]
      (parse-pile (trip contract-text))
    ~&  >>  "made raw: {<(lent raw)>}"
    =/  =cards
      (~(cite play [bowl desk]) desk pax [%hoon [[%atom %t ~] code]])
    ~&  >>  "made cards: {<(lent cards)>}"
    :: ~!  smart-lib-noun  
    :: =/  smart-lib=vase  ;;(vase (cue q.q.smart-lib-noun))
    =/  smart-txt  .^(@t %cx /(scot %p our.bowl)/zig/(scot %da now.bowl)/lib/zig/sys/smart/hoon)
    =/  hoon-txt  .^(@t %cx /(scot %p our.bowl)/zig/(scot %da now.bowl)/lib/zig/sys/hoon/hoon)
    =/  hoe  (slap !>(~) (ream hoon-txt))
    =/  smart-lib=vase  (slap hoe (ream smart-txt))
    ~&  >>  "made smart-lib: {<-:smart-lib>}"
    ::
    =/  braw=(list hoon)
      ::  compose libraries flatly against uHoon subject
      %+  turn  raw
      |=  [face=term =path]
      =/  pax=^path  (en-beam bek(q desk) path)
      ~&  >>  "pax: {<pax>} face: {<face>}"
      %-  road  |.
      ~_  leaf/"{pax}: build failed"
      `hoon`[%ktts face (reck pax)]
    ~&  >>  "made braw"
    ~&  >>  "made braw (hoon): {<(lent braw)>}"
    =/  full=hoon  [%clsg braw]
    =/  full-nock=*  q:(~(mint ut p.smart-lib) %noun full)
    ~&  >>  "made full-nock"
    =/  payload=vase  (slap smart-lib full)
    =/  cont  (~(mint ut p:(slop smart-lib payload)) %noun contract-hoon)
    =/  perfect  .*([q.smart-lib q.payload] q.cont)
    =/  dor  [-:!>(*contract:smart) perfect]
    :-  cards
    [`[bat=q.cont pay=full-nock] ~]
  ++  cid  `@ux`'citadel-contract'
  ++  tid  0
  ++  make-grain
    |=  =wheat:smart
    ^-  grain:smart
    :*  cid               ::  id
        cid               ::  lord
        cid               ::  holdqers
        tid              ::  town-id
        :-    %|         ::  germ
          wheat
    ==
  ++  test-contract
    |=  =wheat:smart
    =/  yok=yolk:smart
    [[0xbeef 1 0x1.beef] `[%init ~] ~ ~]
    =/  shel=shell:smart
      [[0xbeef 1 0x1.beef] [0 0 0] ~ cid 1 1 0 0]
    =/  egg  [shel yok]
    =/  res
      %+  ~(mill mill [0xdead 1 0x1.dead] 0 1 %family)
        ~(fake-town zigs (make-grain wheat))
      `egg:smart`egg
    res
  ++  zigs
    |_  =grain:smart
    ++  beef-zigs-grain  ::  ~zod
      ^-  grain:smart
      :*  0x1.beef
          zigs-wheat-id:smart
          ::  associated seed: 0xbeef
          0xbeef
          0
          [%& `@`'zigs' [300.000 ~ `@ux`'zigs-metadata']]
      ==
    ++  dead-zigs-grain  ::  ~bus
      ^-  grain:smart
      :*  0x1.dead
          zigs-wheat-id:smart
          ::  associated seed: 0xdead
          0xdead
          0
          [%& `@`'zigs' [200.000 ~ `@ux`'zigs-metadata']]
      ==
    ++  cafe-zigs-grain  ::  ~nec
      ^-  grain:smart
      :*  0x1.cafe
          zigs-wheat-id:smart
          0xcafe
          0
          [%& `@`'zigs' [100.000 ~ `@ux`'zigs-metadata']]
      ==
    ++  fake-granary
      ^-  granary:smart
      =/  grains=(list:smart (pair:smart id:smart grain:smart))
        :~  [cid grain]
            [0x1.beef beef-zigs-grain]
            [0x1.dead dead-zigs-grain]
            [0x1.cafe cafe-zigs-grain]
        ==
      (~(gas by:smart *(map:smart id:smart grain:smart)) grains)
    ++  fake-populace
      ^-  populace:smart
      %-  %~  gas  by:smart  *(map:smart id:smart @ud)
      ~[[0xbeef 0] [0xdead 0] [0xcafe 0]]
    ++  fake-town
      ^-  town:smart
      [fake-granary fake-populace]
    --
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
++  on-action
  |=  =action
  ^-  (quip card _state)
  ?-    -.action
      %desk  (on-desk action)
      %diagram  (on-diagram action)
  ==
::
++  on-poke-action
  |=  =poke-action
  ^-  (quip card _state)
  ?-    -.poke-action
      %run  (on-run poke-action)
  ==
::
++  on-desk
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%desk -.action)
  =/  desk  name.action
  =/  bek  byk.bowl
  =+  %-  my
    :~  :-  from.action
      .^((list path) ct+(en-beam bek(q from.action) /))
    ==
  ~&  >  [%from-files -]
  :_  state(colonies (~(put by colonies.state) desk -))
  :~
    :^  %pass  /citadel/desk/[desk]  %arvo
    (~(scop play [bowl desk]) from.action [- ~])
  ==
::
++  on-diagram
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%diagram -.action)
  =/  desk  name.action
  =/  [=outpost =card]  (make-diagram gram.action desk furm.action)
  :: TODO specify dependency desk in outpost
  :_  state(colonies (~(put by colonies) desk outpost))
  [card ~]
::
++  on-run
  |=  =poke-action
  ^-  (quip card _state)
  ?>  ?=(%run -.poke-action)
  ~&  >>  poke-action
  ?-    arena.poke-action
      %contract
    ~&  >>  "in contract"
    ~&  >>  "making wheat"
    =/  [=cards =wheat:smart]  ~(make-wheat zh code.survey.poke-action ~)
    ~&  >>  "made wheat: {<wheat>}"
    [cards state]
      %gall
    ~&  >>  "in gall"
    =/  zest  ~(test-contract zh code.survey.poke-action ~)
    =/  [=cards =wheat:smart]  ~(make-wheat zh code.survey.poke-action ~)
    ~&  >>  "made wheat: {<owns.wheat>}"
    =/  res
      %-  road  |.
        ~_  leaf/"on-run: build failed"
        (zest wheat)
    ~&  >>  "zested"
    ::~&  >  "zesting results: {<res>}"
    [cards state]
  ==
::
++  make-diagram
  |=  [=gram =desk from=(unit desk)]
  ^-  [outpost card]
  =*  bek  byk.bowl
  =/  diagrams  .^((list path) ct+(en-beam bek /dia/[+<.gram]))
  =|  from-files=(list path)
  =?  q.bek  ?=(^ from)  u.from
  =?  from-files  ?=(^ from)  .^((list path) ct+(en-beam bek /))
  ~&  >>  from-files
  ~&  >>  q.bek
  =/  =grounds
    ?-  +<.gram
      %ent  butlers
      ::  %rud  frontage TODO frontend app
      %gen  turbines
      %doc  library
      %ted  circuitry
      %cli  valet
      %hel  crier
      %prt  [(fuse press foundation) ~]
    ==
  ~&  >>  grounds
  =/  merged=^grounds
    %=  grounds
      outpost  (fuse (my [q.bek from-files]~) outpost:grounds)
      atelier  (weld atelier:grounds diagrams)
    ==
  :-  outpost:merged
  :^  %pass  /citadel/desk/diagram  %arvo
  (~(scop play [bowl desk]) %citadel merged)
::
++  lore
  ^-  (quip card _state)
  =*  cha  ~(. ch q.byk.bowl)
  =/  charges
    .^  charge-update:docket
        %gx
        (scry:io %docket /charges/noun)
    ==
  ?>  ?=(%initial -.charges)
  :_  state
  ?.  %-  ~(has by initial.charges)  %docs
    ~&  >>  "installing ~pocwet/docs"
    :~
      (ally-update:cha ~pocwet)
      (install:cha ~pocwet %docs)
    ==
  ~&  >>  "docs installed"
  ~
::
++  peer-citadel-primary
  |=  wir=wire
  ^-  (quip card _state)
  ?.  =(our.bowl src.bowl)
    :_  state
    [%give %kick ~ ~]~
  [~ state]
--
::
