::  /+  *zig-sys-smart
|%
++  sur
  |%
  +$  sig       [p=@ux q=ship r=@ud]
  +$  ziggurat  (map ship sig)
  +$  world     (map town-id=@ud council=(map ship [id sig]))
  ::
  +$  arguments
    $%  [%init =sig town=@ud]
        [%join =sig town=@ud]
        [%exit =sig town=@ud]
        [%become-validator sig]
        [%stop-validating sig]
    ==
  --
::
++  lib
  |%
  ++  enjs
    =,  enjs:format
    |%
    ++  ziggurat
      |=  =ziggurat:sur
      ^-  json
      %-  pairs
      %+  turn  ~(tap by ziggurat)
      |=  [signer=@p signature=sig:sur]
      [(scot %p signer) (sig signature)]
    ::
    ++  world
      |^
      |=  =world:sur
      ^-  json
      %-  pairs
      %+  turn  ~(tap by world)
      |=  [town-id=@ud cncl=(map @p [id sig:sur])]
      [(scot %ud town-id) (council cncl)]
      ::
      ++  council
        |=  council=(map @p [id sig:sur])
        ^-  json
        %-  pairs
        %+  turn  ~(tap by council)
        |=  [signer-ship=@p signer-id=id signature=sig:sur]
        :-  (scot %p signer-ship)
        %-  pairs
        :+  [%id %s (scot %ux signer-id)]
          [%sig (sig signature)]
        ~
      --
    ::
    ++  arguments
      |=  =arguments:sur
      ^-  json
      %+  frond  -.arguments
      ?-    -.arguments
          %init
        %-  pairs
        :+  [%sig (sig sig.arguments)]
          [%town (numb town.arguments)]
        ~
      ::
          %join
        %-  pairs
        :+  [%sig (sig sig.arguments)]
          [%town (numb town.arguments)]
        ~
      ::
          %exit
        %-  pairs
        :+  [%sig (sig sig.arguments)]
          [%town (numb town.arguments)]
        ~
      ::
          %become-validator
        (frond %sig (sig +.arguments))
      ::
          %stop-validating
        (frond %sig (sig +.arguments))
      ==
    ::
    ++  sig
      |=  =sig:sur
      ^-  json
      %-  pairs
      :^    [%p %s (scot %ux p.sig)]
          [%q %s (scot %p q.sig)]
        [%r (numb r.sig)]
      ~
    --
  --
--
