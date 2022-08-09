|_  =cart
++  write
  |=  [%find my-account=id]
  ^-  chick
  =/  mine=(unit grain)  (scry my-account)
  ?~  mine
    ~>  %slog.[0 leaf/"grain not found"]
    [%& ~ ~ ~ ~]
  ~>  %slog.[0 leaf/"grain located"]
  [%& ~ ~ ~ [[%found-grain-id [%n (scot %ux id.p.u.mine)]] ~]]
++  read
  |_  =path
  ++  json
    ~
  ++  noun
    ~
  --
--
