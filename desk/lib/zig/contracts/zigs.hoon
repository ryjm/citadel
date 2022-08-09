::  [UQ| DAO]
::  zigs.hoon v0.9
::
::  Contract for 'zigs' (official name TBD) token, the gas-payment
::  token for the Uqbar network.
::  This token is unique from those defined by the token standard
::  because %give must include their gas budget, in order for
::  zig spends to be guaranteed not to underflow.
::
::  /+  *zig-sys-smart
/=  zigs  /lib/zig/contracts/lib/zigs
=,  zigs
|_  =cart
++  write
  |=  act=action:sur
  ^-  chick
  ?-    -.act
      %give
    =+  `grain`(need (scry from-account.act))
    =/  giver  (husk account:sur - `me.cart ~)
    ::  contract can initiate a %give, or holder of grain can.
    ?>  |(=(id.from.cart me.cart) =(id.from.cart holder.giver))
    ::  unlike other assertions, this is non-optional: we must confirm
    ::  that the giver's zigs balance is enough to cover the maximum
    ::  cost in the original transaction, which is provided in budget
    ::  argument via execution engine.
    ?>  (gte balance.data.giver (add amount.act budget.act))
    ?~  to-account.act
      ::  if no receiver account specified, generate new account for them
      =/  =id  (fry-rice me.cart to.act town-id.cart salt.giver)
      =/  =rice
        [salt.giver %account [0 ~ metadata.data.giver] id me.cart to.act town-id.cart]
      =/  next  [%give to.act amount.act id.giver `id.rice]
      (continuation [me.cart town-id.cart next]^~ (result ~ [%& rice]^~ ~ ~))
    ::  have a specified receiver account, grab it and add to balance
    =+  `grain`(need (scry u.to-account.act))
    =/  receiver  (husk account:sur - `me.cart `to.act)
    =:  balance.data.giver     (sub balance.data.giver amount.act)
        balance.data.receiver  (add balance.data.receiver amount.act)
    ==
    (result [[%& giver] [%& receiver] ~] ~ ~ ~)
  ::
      %take
    =+  (need (scry from-account.act))
    =/  giver  (husk account:sur - `me.cart ~)
    ::  no assertions required here for balance or allowance,
    ::  because subtract underflow will crash when we try to edit these.
    ?~  to-account.act
      ::  if no receiver account specified, generate new account for them
      =/  =id  (fry-rice me.cart to.act town-id.cart salt.giver)
      =/  =rice
        [salt.giver %account [0 ~ metadata.data.giver] id me.cart to.act town-id.cart]
      =/  next  [%take to.act amount.act id.giver `id.rice]
      (continuation [me.cart town-id.cart next]^~ (result ~ [%& rice]^~ ~ ~))
    ::  have a specified receiver account, grab it and add to balance
    =+  (need (scry u.to-account.act))
    =/  receiver  (husk account:sur - `me.cart `to.act)
    =:  balance.data.giver     (sub balance.data.giver amount.act)
        balance.data.receiver  (add balance.data.receiver amount.act)
    ::
          allowances.data.giver
      %+  ~(jab by allowances.data.giver)
        id.from.cart
      |=(old=@ud (sub old amount.act))
    ==
    (result [[%& giver] [%& receiver] ~] ~ ~ ~)
  ::
      %set-allowance
    ::  cannot set an allowance to ourselves
    ?>  !=(who.act id.from.cart)
    =+  (need (scry account.act))
    =/  account  (husk account:sur - `me.cart `id.from.cart)
    =.  allowances.data.account
      (~(put by allowances.data.account) who.act amount.act)
    (result [%& account]^~ ~ ~ ~)
  ==
::
++  read
  |_  =path
  ++  json
    ^-  ^json
    ?+    path  !!
        [%get-balance @ ~]
      =+  (need (scry (slav %ux i.t.path)))
      =+  (husk account:sur - ~ ~)
      `^json`[%n (scot %ud balance.data.-)]
    ==
  ::
  ++  noun
    ~
  --
--
