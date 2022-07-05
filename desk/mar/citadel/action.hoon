/-  *citadel
/+  *etch
=,  format
::
|_  act=action
::
++  grow
  |%
  ++  tank  >act<
  ++  noun  wain
  --
::
++  grab
  |%
  ++  noun  action
  ::  ++  json
  ::    |=  jon=^json  ^-  action
  ::    =,  dejs-soft:format
  ::    %-  need  %.  jon
  ::    =<  %-  of  :~
  ::      run+run
  ::      diagram+diagram
  ::      desk+desk
  ::    ==
  ::    |%
  ::    ++  run
  ::      %-  ot  :~
  ::        arena+(su sym)
  ::        survey+(ot code+so test+so ~)
  ::      ==
  ::    ::  ++  diagram
  ::      ::  %-  ot  ~[furm+(un (su sym)) gram+(ot (su sym) ~) name+(su sym)]
  ::    ++  desk
  ::      %-  ot  ~[from+so name+(su sym)]
  ::    --
  ::  --
::  =,  dejs-soft
::      |%
::      ++  code
::        ^-  $-(^^json (unit hoon))
::        |=  jon=^^json

::      ++  test
::        ^-  $-(^^json (unit hoon))
--
