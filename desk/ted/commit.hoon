/-  spider
/-  *herd
/+  sio=strandio
=,  strand=strand:spider
|^  ted
+$  fuse-source  [who=ship des=desk ver=$@(%trak case)]
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
  ;<  ~  bind:m  (sleep:sio ~s2)
  ;<  now=@da  bind:m  get-time:sio
  ;<  herdfile=cage  bind:m
    (read-file:sio [[our dev da+now] /desk/herd])
  =/  =herd
    !<(herd q.herdfile)
  =/  fuse-herd=(list fuse-source)
    %+  turn  herd
    |=  =beef
    :*  ?+(who.beef who.beef %our our)
        des.beef
        ver.beef
    ==
  =/  fus=(list [fuse-source $?(%mate %meet-this %init)])
    ?~  fuse-herd  ~
    %-  zing
    :~  (turn fuse-herd |=(=fuse-source [fuse-source %mate]))
        ~[[[our dev %trak] %meet-this]]
    ==
  ;<  ~  bind:m
    %:  poke:sio  [our %hood]
      [%kiln-fuse !>([dev [%.y [our %base [%ud 0]] fus]])]
    ==
  (pure:m !>(~))
--
