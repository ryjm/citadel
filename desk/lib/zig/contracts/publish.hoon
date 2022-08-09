::  publish.hoon  [UQ| DAO]
::
::  Smart contract that processes deployment and upgrades
::  for other smart contracts. Automatically (?) inserted
::  on any town that wishes to allow contract production.
::
/+  *zig-sys-smart
/=  pub  /lib/zig/contracts/lib/publish
|_  =cart
++  write
  |=  act=action:pub
  ^-  chick
  ?-    -.act
      %deploy
    ::  0x0 denotes immutable contract
    =/  lord=id  ?.(mutable.act 0x0 me.cart)
    =+  our-id=(fry-wheat lord town-id.cart `cont.act)
    ::  generate grains out of new rice we spawn
    =/  produced=(map id grain)
      %-  ~(gas by *(map id grain))
      %+  turn  owns.act
      |=  ri=[s=@ l=@tas d=*]
      ^-  [id grain]
      =-  [- [%& s.ri l.ri d.ri - our-id our-id town-id.cart]]
      (fry-rice our-id our-id town-id.cart s.ri)
    ::
    =/  =grain
      :*  %|
          `cont.act
          interface.act
          types.act
          our-id
          lord
          id.from.cart
          town-id.cart
      ==
    [%& ~ (~(put by produced) our-id grain) ~ ~]
  ::
      %upgrade
    ::  caller must be holder
    ::  TODO replace with scry
    =/  contract  (~(got by grains.cart) id.to-upgrade.act)
    ?>  ?&  ?=(%| -.contract)
            =(holder.p.contract id.from.cart)
        ==
    =.  cont.p.contract  `new-nok.act
    (result [contract ~] ~ ~ ~)
  ==
::
++  read
  |_  =path
  ++  json
    ~
  ++  noun
    ~
  --
--
