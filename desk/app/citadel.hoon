/-  *citadel, docket, *treaty
/+  default-agent, dbug, agentio, *citadel
=,  play
|%
+$  card  card:agent:gall
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
::
++  cg
  |%
  ++  docket-install
    |=([her=ship there=desk] docket-install+!>([her there]))
  ++  ally-update      |=(=update:ally ally-update-0+!>(update))
  --
::
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
::
::
++  on-action
  |=  =action
  ^-  (quip card _state)
  ?-    -.action
      %desk  (on-desk action)
      %diagram  (on-diagram action)
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
  :_  state(colonies (~(put by colonies.state) desk -))
  :~
    :^  %pass  /citadel/desk/[desk]  %arvo
    (scop byk.bowl from.action desk [- ~])
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
++  make-diagram
  |=  [=gram name=@tas from=(unit desk)]
  ^-  [outpost card]
  =*  bek  byk.bowl
  =/  diagrams  .^((list path) ct+(en-beam bek /dia/[+<.gram]))
  =|  from-files=(list path)
  =?  q.bek  ?=(^ from)  u.from
  =?  from-files  ?=(^ from)  .^((list path) ct+(en-beam bek /))
  =/  =grounds
    ?-  +<.gram
      %ent  butlers
      ::  %rud  frontage TODO frontend app
      %gen  turbines
      %ted  circuitry
      %cli  valet
      %hel  crier
      %prt  [(fuse press foundation) ~]
    ==
  =/  merged=^grounds
    %=  grounds
      outpost  (fuse (my [q.bek from-files]~) outpost:grounds)
      atelier  (weld atelier:grounds diagrams)
    ==
  :-  outpost:merged
  :^  %pass  /citadel/desk/diagram  %arvo
  (scop byk.bowl %citadel name merged)
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
