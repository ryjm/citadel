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
  ;<  ~  bind:m
    (poke:sio [our %hood] [%kiln-commit !>([dev %.n])])
  (pure:m !>(~))
  ::  TODO kiln commit dev desk
  ::  then kiln fuse herd file entries
  ::  then kiln merge dev desk with %meld
  ::  https://github.com/urbit/urbit/blob/master/pkg/arvo/app/hood.hoon#L90
  ::  https://github.com/urbit/urbit/blob/master/pkg/arvo/lib/hood/kiln.hoon#L1060
  ::  https://github.com/urbit/urbit/blob/master/pkg/arvo/gen/hood/fuse/help.txt
--
