export const initialTests =
`::  This is the tests file for your contract

::  Below are sample tests
::  Tests for fungible.hoon (token contract)
::  to test, make sure to add library import at top of contract
::  (remove again before compiling for deployment)
::
/+  *test, cont=zig-contracts-fungible, *zig-sys-smart
/=  fungible  /lib/zig/contracts/lib/fungible
=,  fungible
=>  ::  test data
    |%
    ++  metadata-1  ^-  grain
      :*  \`@ux\`'simple'
          \`@ux\`'fungible'
          \`@ux\`'holder'
          1  ::  town-id
          :+  %&  \`@\`'salt'
          :*  name='Simple Token'
              symbol='ST'
              decimals=0
              supply=100
              cap=~
              mintable=%.n
              minters=~
              deployer=0x0
              salt=\`@\`'salt'
      ==  ==
    ::
    ++  metadata-2  ^-  grain
      :*  \`@ux\`'simple'
          \`@ux\`'fungible'
          \`@ux\`'holder'
          1  ::  town-id
          :+  %&  \`@\`'salt'
          :*  name='Simple Token'
              symbol='ST'
              decimals=0
              supply=100
              cap=\`1.000
              mintable=%.y
              minters=(silt ~[0xbeef])
              deployer=0x0
              salt=\`@\`'salt'
      ==  ==
    ::
    ++  account-1  ^-  grain
      :*  0x1.beef
          \`@ux\`'fungible'
          0xbeef
          1
          [%& \`@\`'salt' [50 (malt ~[[0xdead 10]]) \`@ux\`'simple']]
      ==
    ++  owner-1  ^-  account
      [0xbeef 0 0x1234.5678]
    ::
    ++  account-2  ^-  grain
      :*  0x1.dead
          \`@ux\`'fungible'
          0xdead
          1
          [%& \`@\`'salt' [30 (malt ~[[0xbeef 10]]) \`@ux\`'simple']]
      ==
    ++  owner-2  ^-  account
      [0xdead 0 0x1234.5678]
    ::
    ++  account-3  ^-  grain
      :*  0x1.cafe
          \`@ux\`'fungible'
          0xcafe
          1
          [%& \`@\`'salt' [20 ~ \`@ux\`'simple']]
      ==
    ++  owner-3  ^-  account
      [0xcafe 0 0x1234.5678]
    ::
    ++  account-4  ^-  grain
      :*  0x1.face
          \`@ux\`'fungible'
          0xface
          1
          [%& \`@\`'diff' [20 ~ \`@ux\`'different!']]
      ==
    --
::  testing arms
|%
++  test-matches-type  ^-  tang
  =/  valid  (mule |.(;;(contract cont)))
  (expect-eq !>(%.y) !>(-.valid))
::
::  tests for %set-allowance
::
++  test-set-allowance  ^-  tang
  =/  =embryo
    :+  owner-1
      \`[%set-allowance 0xcafe 10]
    (malt ~[[id:account-1 account-1]])
  =/  =cart
    [\`@ux\`'fungible' 0 1 (malt ~[[id:account-3 account-3]])]
  =/  updated-1=grain
    :*  id:account-1
        \`@ux\`'fungible'
        0xbeef
        1
        [%& \`@\`'salt' [50 (silt ~[[0xdead 10] [0xcafe 10]]) \`@ux\`'simple']]
    ==
  =/  correct=chick
    [%& (malt ~[[id:updated-1 updated-1]]) ~ ~]
  =/  res=chick
    (~(write cont cart) embryo)
  (expect-eq !>(res) !>(correct))
--
`
