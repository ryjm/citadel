::  nft.hoon [UQ| DAO]
::
::  NFT standard. Provides abilities similar to ERC-721 tokens, also ability
::  to deploy and mint new sets of tokens.
::
::  /+  *zig-sys-smart
/=  nft  /lib/zig/contracts/lib/nft
=,  nft
|_  =cart
++  write
  |=  act=action:sur
  ^-  chick
  ?-    -.act
      %give
    =+  (need (scry grain-id.act))
    ?<  =(~ -)
    ::  caller must hold NFT, this contract must be lord
    =/  gift  (husk nft:sur - `me.cart `id.from.cart)
    ::  NFT must be transferrable
    ?>  transferrable.data.gift
    ::  change holder to reflect new ownership
    ::  clear allowances
    =:  holder.gift  to.act
        allowances.data.gift  ~
    ==
    (result [[%& gift] ~] ~ ~ ~)
  ::
      %take
    =+  (need (scry grain-id.act))
    ::  this contract must be lord
    =/  gift  (husk nft:sur - `me.cart ~)
    ::  caller must be in allowances set
    ?>  (~(has pn allowances.data.gift) id.from.cart)
    ::  NFT must be transferrable
    ?>  transferrable.data.gift
    ::  change holder to reflect new ownership
    ::  clear allowances
    =:  holder.gift  to.act
        allowances.data.gift  ~
    ==
    (result [[%& gift] ~] ~ ~ ~)
  ::
      %set-allowance
    ::  can set many allowances in single call
    =|  changed=(list grain)
    |-
    ?~  items.act
      ::  finished
      (result changed ~ ~ ~)
    ::  can optimize repeats here by storing these all in pmap at start
    =+  (need (scry grain.i.items.act))
    ::  must hold any NFT we set allowance for
    =/  nft  (husk nft:sur - `me.cart `id.from.cart)
    =.  allowances.data.nft
      ?:  allowed.i.items.act
        (~(put pn allowances.data.nft) who.i.items.act)
      (~(del pn allowances.data.nft) who.i.items.act)
    %=  $
      items.act  t.items.act
      changed    [[%& nft] changed]
    ==
  ::
      %mint
    =+  `grain`(need (scry token.act))
    =/  meta  (husk metadata:sur - `me.cart ~)
    ::  ensure NFT is mintable
    ?>  &(mintable.data.meta ?=(^ cap.data.meta))
    ::  ensure caller is in minter-set
    ?>  (~(has pn minters.data.meta) id.from.cart)
    ::  set id of next possible item in collection
    =/  next-item-id  +(supply.data.meta)
    ::  check if mint will surpass supply cap
    =/  new-supply  (add supply.data.meta (lent mints.act))
    ?>  (gte u.cap.data.meta new-supply)
    =.  supply.data.meta  new-supply
    ::  iterate through mints
    =|  issued=(list grain)
    |-
    ?~  mints.act
      ::  finished minting
      (result [[%& meta] ~] issued ~ ~)
    ::  create new grain for NFT
    ::  unique salt for each item in collection
    =*  m  i.mints.act
    =/  salt    (cat 3 salt.meta (scot %ud next-item-id))
    =/  new-id  (fry-rice me.cart to.m town-id.cart salt)
    ::  properties must match those in metadata spec!
    ?>  =(properties.data.meta ~(key py properties.m))
    =/  data    [next-item-id uri.m id.meta ~ properties.m transferrable.m]
    =/  =rice   [salt %nft data new-id me.cart to.m town-id.cart]
    %=  $
      mints.act     t.mints.act
      next-item-id  +(next-item-id)
      issued        [[%& rice] issued]
    ==
  ::
      %deploy
    ::  create new NFT collection with a metadata grain
    ::  and optional initial mint
    =/  =metadata:sur
      :*  name.act
          symbol.act
          properties.act
          (lent initial-distribution.act)
          cap.act
          ?~(minters.act %.y %.n)
          minters.act
          id.from.cart
          salt.act
      ==
    =/  =id    (fry-rice me.cart me.cart town-id.cart salt.act)
    =/  =rice  [salt.act %metadata metadata id me.cart me.cart town-id.cart]
    ?~  initial-distribution.act
      (result ~ [[%& rice] ~] ~ ~)
    ::  perform optional mint
    =/  next  [%mint id initial-distribution.act]
    %+  continuation
      [me.cart town-id.cart next]^~
    (result ~ [[%& rice] ~] ~ ~)
  ==
::
++  read
  |_  =path
  ++  json
    ^-  ^json
    ?+    path  !!
        [%nft @ ~]
      =+  (need (scry (slav %ux i.t.path)))
      =+  (husk nft:sur - ~ ~)
      (nft:enjs:lib data.-)
    ::
        [%metadata @ ~]
      =+  (need (scry (slav %ux i.t.path)))
      =+  (husk metadata:sur - ~ ~)
      (metadata:enjs:lib data.-)
    ==
  ::
  ++  noun
    ~
  --
--
