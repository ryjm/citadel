/+  default-agent, dbug
|%
+$  state
  $%  $:  %0
          counter=@
      ==
  ==
::
--
::
=|  =state
%-  agent:dbug
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
::
++  on-init   on-init:def
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ~&  >  'hello world'
  =/  updated=^state  !<(^state old)
  `this(state updated(counter +(counter:updated)))
::
++  on-poke   on-poke:def
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
