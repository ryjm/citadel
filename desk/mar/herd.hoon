/-  hd=herd
|_  =herd:hd
++  grow
  |%
  ++  noun  herd
  ++  mime
    ^-  ^mime
    [/text/x-herd (as-octt:mimes:html (spit-herd herd))]
  ++  spit-herd
    |=  =herd:hd
    ^-  tape
    =/  lines=tape  (zing (turn herd spit-beef))
    ;:  weld
      ":~\0a"
      lines
      "=="
    ==
  ++  spit-beef
    |=  =beef:hd
    ^-  tape
    =/  [[=ship =desk =case] =path]  beef
    ;:  weld
      "  [["
      (trip (scot %p ship))  " "
      "%"  (trip desk)  " "
      (spit-case case)
      "] "
      (trip (spat path))
      "]\0a"
    ==
  ++  spit-case
    |=  =case
    ^-  tape
    ;:  weld
      "["
      "%"  (trip -.case)  " "
      (trip (scot -.case +.case))
      "]"
    ==
  --
++  grab
  |%
  ++  noun  herd:hd
  ++  mime
    |=  [=mite len=@ud tex=@]
    ^-  herd:hd
    !<(herd:hd (slap !>(~) (ream tex)))
  --
++  grad  %noun
--
