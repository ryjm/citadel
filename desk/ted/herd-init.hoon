/-  spider
/-  *citadel
/+  strandio
=,  strand=strand:spider
|^  ted
++  ted
  ^-  thread:spider
  |=  arg=vase
  =/  m  (strand ,vase)
  =/  arguments
    !<  (unit [@tas @tas])  arg
  =/  [dev=@tas build=@tas]  (need arguments)
  ;<  our=@p  bind:m  get-our:strandio
  =/  =action
    ::  create the dev desk based on the herd template
    [%diagram ~ [dev [%hrd ~]] dev]
  ;<  ~  bind:m
    %+  poke:strandio  [our %citadel]
    [%citadel-action !>(action)]
  ;<  ~  bind:m
    %+  poke:strandio  [our %hood]
    [%kiln-merge !>([build our %base [%ud 1] %auto])]
  (pure:m !>(~))
--
