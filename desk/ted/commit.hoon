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
  ;<  now=@da  bind:m  get-time:sio
  ;<  herdfile=cage  bind:m
    (read-file:sio [[our dev da+now] /desk/herd])
  =/  =herd
    !<(herd q.herdfile)
  ~&  herd
  (pure:m !>(~))
--
