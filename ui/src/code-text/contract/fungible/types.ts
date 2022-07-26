export const initialTypes =
`::  [UQ| DAO]
::  zigs.hoon v0.9
::
/+  *zig-sys-smart
|%
++  sur
  |%
  +$  token-metadata
    ::  will be automatically inserted into town state
    ::  at instantiation, along with this contract
    ::  hardcoded values included to match token standard
    $:  name=@t
        symbol=@t
        decimals=@ud
        supply=@ud
        cap=~
        mintable=%.n
        minters=~
        deployer=address  ::  will be 0x0
        salt=@            ::  'zigs'
    ==
  ::
  +$  account
    $:  balance=@ud
        allowances=(map address @ud)
        metadata=id
    ==
  ::
  +$  action
    $%  $:  %give
            budget=@ud
            to=address
            amount=@ud
            from-account=[%grain =id]
            to-account=(unit [%grain =id])
        ==
    ::
        $:  %take
            to=address
            amount=@ud
            from-account=[%grain =id]
            to-account=(unit [%grain =id])
        ==
    ::
        $:  %set-allowance
            who=address
            amount=@ud  ::  (to revoke, call with amount=0)
            account=[%grain =id]
        ==
    ==
  --
::
++  lib
  |%
  ++  enjs
    =,  enjs:format
    |%
    ++  account
      |^
      |=  =account:sur
      ^-  json
      %-  pairs
      :~  [%balance (numb balance.account)]
          [%allowances (allowances allowances.account)]
          [%metadata [%s (scot %ux metadata.account)]]
      ==
      ::
      ++  allowances
        |=  a=(map address @ud)
        ^-  json
        %-  pairs
        %+  turn  ~(tap by a)
        |=  [=address allowance=@ud]
        [(scot %ux address) (numb allowance)]
      --
    ::
    ++  token-metadata
      |^
      |=  md=token-metadata:sur
      ^-  json
      %-  pairs
      :~  [%name %s name.md]
          [%symbol %s symbol.md]
          [%decimals (numb decimals.md)]
          [%supply (numb supply.md)]
          [%cap ~]
          [%mintable %b mintable.md]
          [%minters (set-id minters.md)]
          [%deployer %s (scot %ux deployer.md)]
          [%salt (numb salt.md)]
      ==
      ::
      ++  set-id
        |=  set-id=(set id)
        ^-  json
        :-  %a
        %+  turn  ~(tap in set-id)
        |=  i=id
        [%s (scot %ux i)]
      --
    ::
    ++  action
      |=  a=action:sur
      ^-  json
      %+  frond  -.a
      ?-    -.a
      ::
          %give
        %-  pairs
        :~  [%budget (numb budget.a)]
            [%to %s (scot %ux to.a)]
            [%amount (numb amount.a)]
            [%from-account %s (scot %ux id.from-account.a)]
            [%to-account ?~(to-account.a ~ [%s (scot %ux id.u.to-account.a)])]
        ==
      ::
          %take
        %-  pairs
        :~  [%to %s (scot %ux to.a)]
            [%amount (numb amount.a)]
            [%from-account %s (scot %ux id.from-account.a)]
            [%to-account ?~(to-account.a ~ [%s (scot %ux id.u.to-account.a)])]
        ==
      ::
          %set-allowance
        %-  pairs
        :~  [%who %s (scot %ux who.a)]
            [%amount (numb amount.a)]
            [%account %s (scot %ux id.account.a)]
        ==
      ==
    --
  --
--
`
