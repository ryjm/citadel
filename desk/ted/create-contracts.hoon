/-  spider, *citadel
/+  strandio, smart=zig-sys-smart
::
=*  strand     strand:spider
=*  leave      leave:strandio
=*  take-fact  take-fact:strandio
=*  watch      watch:strandio
::
|^  ted
++  contracts  [%zigs %trivial %nft ~]
++  new-contract
  |=  [=bowl:spider name=@tas]
  =/  main=path  (en-beam byk.bowl /lib/zig)
  =/  grab
    |=  =path
    =+  (weld main path)
    ?.  .^(? %cu -)  'not found'
    .^(@t %cx -)
  =/  charter  (grab /contracts/[name]/hoon)
  =/  lib  (grab /contracts/lib/[name]/hoon)
  =-  [%save -]
  :*  %contract
      :~  [%lib [`lib `name /zig/contracts/lib/[name]/hoon]]
          [%lib [`charter `name /zig/contracts/[name]/hoon]]
      ==
      charter=charter
      project=name
  ==
++  millet
  |=  [=bowl:spider name=@tas]
  =/  main=path  (en-beam byk.bowl /lib/zig)
  =/  grab
    |=  =path
    =+  (weld main path)
    ?.  .^(? %cu -)  'not found'
    .^(@t %cx -)
  =/  charter  (grab /contracts/[name]/hoon)
  =-  [%mill -]
  :*  [%contract ~ charter=charter project=name]
      [`@ux`name `@ux`name `@ux`name 0x0]
      ~  ~
  ==

++  ted
  ^-  thread:spider
  |=  arg=vase
  =/  m  (strand ,vase)
  ^-  form:m
  =/  user-contracts=(unit (list @tas))
    !<  (unit (list @tas))  arg
  ;<  =bowl:spider  bind:m  get-bowl:strandio
  =/  create  (cury new-contract bowl)
  =/  create-mill  (cury millet bowl)
  =/  [mill-cards=(list action) create-cards=(list action)]
    =-  [(turn - create-mill) (turn - create)]
    (fall user-contracts contracts)
  =/  cards=(list action)  (weld create-cards mill-cards)
  |-  =*  loop  $
  ?~  cards  (pure:m *vase)
  ;<  ~  bind:m  (poke-our:strandio %citadel [%citadel-action !>(i.cards)])
  loop(cards t.cards)
--
