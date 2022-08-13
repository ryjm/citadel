::  /+  *zig-sys-smart
|%
++  sur
  |%
  +$  metadata
    $:  name=@t
        symbol=@t
        properties=(pset @tas)
        supply=@ud
        cap=(unit @ud)  ::  (~ if mintable is false)
        mintable=?      ::  automatically set to %.n if supply == cap
        minters=(pset address)
        deployer=id
        salt=@
    ==
  ::
  +$  nft  ::  a non-fungible token
    $:  id=@ud
        uri=@t
        metadata=id
        allowances=(pset address)
        properties=(pmap @tas @t)
        transferrable=?
    ==
  ::
  +$  nft-contents
    [uri=@t properties=(pmap @tas @t) transferrable=?]
  ::
  +$  action
    $%  $:  %give
            to=address
            grain-id=id
        ==
    ::
        $:  %take
            to=address
            grain-id=id
        ==
    ::
    ::  full-set flag gives taker permission to any item in account
        $:  %set-allowance
            items=(list [who=address grain=id allowed=?])
        ==
    ::
        $:  %mint
            token=id  ::  id of metadata
            mints=(list [to=address nft-contents])
        ==
    ::
        $:  %deploy
            name=@t
            symbol=@t
            salt=@
            properties=(pset @tas)
            cap=(unit @ud)         ::  if ~, no cap (fr fr)
            minters=(pset address)  ::  if ~, mintable becomes %.n, otherwise %.y
            initial-distribution=(list [to=address nft-contents])
    ==  ==
  --
::
++  lib
  |%
  ++  enjs
    =,  enjs:format
    |%
    ++  nft
      |=  =nft:sur
      ^-  json
      %-  pairs
      :~  ['id' (numb id.nft)]
          ['uri' [%s uri.nft]]
          ['metadata' [%s (scot %ux metadata.nft)]]
          ['allowances' (address-set allowances.nft)]
          ['properties' (properties properties.nft)]
          ['transferrable' [%b transferrable.nft]]
      ==
    ::
    ++  metadata
      |=  md=metadata:sur
      ^-  json
      %-  pairs
      :~  ['name' %s name.md]
          ['symbol' %s symbol.md]
          ['properties' (properties-set properties.md)]
          ['supply' (numb supply.md)]
          ['cap' ?~(cap.md ~ (numb u.cap.md))]
          ['mintable' %b mintable.md]
          ['minters' (address-set minters.md)]
          ['deployer' %s (scot %ux deployer.md)]
          ['salt' (numb salt.md)]
      ==
    ::
    ++  address-set
      |=  a=(set address)
      ^-  json
      :-  %a
      %+  turn  ~(tap pn a)
      |=(a=address [%s (scot %ux a)])
    ::
    ++  properties-set
      |=  p=(set @tas)
      ^-  json
      :-  %a
      %+  turn  ~(tap pn p)
      |=(prop=@tas [%s (scot %tas prop)])
    ::
    ++  properties
      |=  p=(map @tas @t)
      ^-  json
      %-  pairs
      %+  turn  ~(tap py p)
      |=([prop=@tas val=@t] [prop [%s val]])
    --
  --
--
