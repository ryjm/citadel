/-  *citadel, docket
/+  default-agent, dbug, agentio, *citadel
=,  play
|%
+$  card  card:agent:gall
::  colonies - dependencies for desk
::
+$  state-0  [%0 colonies=(map desk [desk outpost])]
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
++  on-peek
  |=  =path
  |^  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%y %colonies * ~]
    ``noun+!>((~(get by colonies) i.t.t.path))
  ==
  --
++  on-init   on-init:def
++  on-save   !>(state)
++  on-load
  |=  old=vase
    ^-  (quip card _this)
    ~&  >  [dap.bowl %load-citadel]
    =+  !<(state-0 old)
    [~ this(state -)]
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
  =/  =outpost  foundation
  =/  desk  name.action
  ?>  ?=(%desk -.action)
  :_  state(colonies (~(put by colonies) desk [from.action outpost]))
  :~
    :^  %pass  /citadel/desk/[desk]  %arvo
    (scop byk.bowl from.action desk [outpost ~])
  ==
::
++  on-diagram
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%diagram -.action)
  =/  desk  name.action
  =/  [=outpost =card]  (make-diagram gram.action desk)
  :: TODO specify dependency desk in outpost
  :_  state(colonies (~(put by colonies) desk [%base outpost]))
  [card ~]
::
++  make-diagram
  |=  [=gram name=@tas]
  ^-  [outpost card]
  =+  .^(diagrams=(list path) ct+(en-beam byk.bowl /dia/[+<.gram]))
  =-  :-  outpost:-  :^  %pass  /citadel/desk/diagram  %arvo
  ::  TODO support filter for specified diagram in /dia
  (scop byk.bowl %citadel name -(atelier (weld atelier diagrams)))
  ?-  +<.gram
    %ent  butlers
    ::  %rud  frontage TODO frontend app
    %gen  turbines
    %ted  circuitry
    %cli  valet
    %hel  crier
  ==
::
++  peer-citadel-primary
  |=  wir=wire
  ^-  (quip card _state)
  ?.  =(our.bowl src.bowl)
    :_  state
    [%give %kick ~ ~]~
  [~ state]
--
