/-  spider
/-  *herd
/+  strandio
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
  ;<  our=@p  bind:m  get-our:strandio
  ;<  ~  bind:m
    %+  poke:strandio  [our %hood]
    [%kiln-fuse !>([build ~])]
  ;<  ~  bind:m
    %+  poke:strandio  [our %hood]
    [%kiln-commit !>([dev %.n])]
  ;<  ~  bind:m  (sleep:strandio ~s1)
  ;<  now=@da  bind:m  get-time:strandio
  ;<  herdfile=cage  bind:m
    (read-file:strandio [[our dev da+now] /desk/herd])
  =/  =herd
    !<(herd q.herdfile)
  =/  fuse-herd=(list fuse-source)
    %+  turn  herd
    |=  =beef
    :*  ?+(who.beef who.beef %our our)
        des.beef
        ver.beef
    ==
  =/  fus=(list [fuse-source $?(%take-that)])
    ?~  fuse-herd  ~
    %-  zing
    :~  (turn fuse-herd |=(=fuse-source [fuse-source %take-that]))
        ~[[[our dev %trak] %take-that]]
    ==
  ;<  ~  bind:m
    %+  poke:strandio  [our %hood]
    [%kiln-fuse !>([build [%.y [our %base [%ud 1]] fus]])]
  (pure:m !>(~))
--
