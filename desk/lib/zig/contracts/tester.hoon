::  /+  *zig-sys-smart
|_  =cart
++  write
  |=  [%look my-account=id]
  ^-  chick
  |^
  =/  mine=(unit grain)  (scry my-account)
  ?~  mine
    ~>  %slog.[0 leaf/"grain not found"]
    [%& ~ ~ ~ ~]
  ~>  %slog.[0 leaf/"grain located"]
  =/  info  (husk my-mold u.mine `me.cart ``@ux`123.456.789)
  =/  changed=(merk id grain)
    %+  gas:big  *(merk id grain)
    :~  [id.info [%& info(bal.data 69.420)]]
    ==
  =/  events
    :~  [%found [%n (scot %ud bal.data.info)]]
        [%hash [%n (scot %ux id.info)]]
    ==
  [%& changed ~ ~ events]
  ::
  +$  my-mold  [bal=@ud m=(map id @ud) meta=@ux]
  --
++  read
  |_  =path
  ++  json
    ~
  ++  noun
    ~
  --
--
