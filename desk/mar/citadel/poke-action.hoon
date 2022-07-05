/-  *citadel
/+  *etch
=,  format
::
|_  act=poke-action
::
++  grow
  |%
  ++  tank  >act<
  ++  noun  act
  ++  json
    |=  act=poke-action
    ^-  ^json
    =,  enjs
    ?-    -.act
        %run
      %+  frond  'run'
      %-  pairs
      :~
        ['arena' s+`@t`arena.act]
        :-  'survey'
        %-  pairs
          :~  ['code' s+code.survey.act]
              ['test' s+test.survey.act]
          ==
      ==
    ==
  --
::
++  grab
  |%
  ++  noun  poke-action
  ++  json
    |=  jon=^json  ^-  poke-action
    =,  dejs-soft:format
    =-  ~!  -  -
    %-  need  %.  jon
    =<  %-  of  :~
      run+run
    ==
    |%
    ++  run
      %-  ot  :~
        arena+(cu |=(@ *arena) so)
        survey+(ot code+so test+so ~)
      ==
    --
  --
--
