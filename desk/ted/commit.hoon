/-  spider
/-  *herd
/+  sio=strandio
=,  strand=strand:spider
|^  ted
++  ted
  ^-  thread:spider
  |=  arg=vase
  =/  m  (strand ,vase)
  =/  arguments
    !<  (unit [@tas @tas])  arg
  =/  [dev=@tas build=@tas]  (need arguments)
  ;<  our=@p  bind:m  get-our:sio
  ;<  ~  bind:m
    (poke:sio [our %hood] [%kiln-commit !>([dev %.n])])
  ;<  ~  bind:m  (sleep:sio ~s1)
  ;<  now=@da  bind:m  get-time:sio
  ;<  herdfile=cage  bind:m
    (read-file:sio [[our dev da+now] /desk/herd])
  =/  =herd
    !<(herd q.herdfile)
  =/  herd-soba
    %+  turn  herd
    |=  =beef
    =/  start
      :~  (scot %p p.beef)
          q.beef
          (scot -.r.beef +.r.beef)
      ==
    =/  file
      (zing ~[start s.beef])
    [s.beef %ins %hoon .^(vase %cr file)]
  ;<  ~  bind:m
    %:  send-raw-card:sio
      [%pass /info %arvo %c %info build %& herd-soba]
    ==
  ;<  ~  bind:m
    %:  poke:sio  [our %hood]
      [%kiln-merge !>([build our dev [%da now] %take-that])]
    ==
  (pure:m !>(~))
--
