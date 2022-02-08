/+  default-agent, dbug
|%
+$  versioned-state
    $%  state-0
    ==
+$  state-0  [%0 counter=@]
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this     .
    def      ~(. (default-agent this %|) bowl)
::
++  on-init
  ^-  (quip card _this)
  ~&  >  'hello world'
  [~ this(state [%0 0])]
++  on-save  !>(state)
++  on-load
  |=  ole=vase
  ^-  (quip card _this)
  ~&  >  'hello again world'
  =/  old=state-0  !<(state-0 ole)
  [~ this(state [%0 +(counter.old)])]
++  on-poke   on-poke:def
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
