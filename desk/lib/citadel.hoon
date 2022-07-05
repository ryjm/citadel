/-  citadel
=,  clay
|%
::    +fose
::
++  fose
  |=  [=desk init=outpost:citadel rest=(list path)]
  ^-  outpost:citadel
  ~!  desk
  %+  ~(jab by init)  desk  (cury welp rest)
::    +fuse
::
++  fuse
  |=  [init=outpost:citadel rest=outpost:citadel]
  ^-  outpost:citadel
  %-  (~(uno by init) rest)  |=([=desk a=(list path) b=(list path)] (welp a b))
:: +foundation - bare minimum
::
++  foundation
  ^-  outpost:citadel
  %-  my
  :~  :-  %base
  :~  /mar/noun/hoon
      /mar/hoon/hoon
      /mar/txt/hoon
      /mar/kelvin/hoon
      /sys/kelvin
  ==  ==
::  +soil - fertilized
::
++  soil
  ^-  outpost:citadel
  %-  my
  :~  :-  %garden
  :~  /mar/docket-0/hoon
      /lib/docket/hoon
      /sur/docket/hoon
  ==  ==
::  +pillar - agent and garden desiderata
::
++  pillar
  ^-  outpost:citadel
  %+  fuse  soil
  %+  fuse  press
  %^  fose  %base  foundation
  :~  /lib/verb/hoon
      /lib/dbug/hoon
      /lib/shoe/hoon
      /lib/agentio/hoon
      /lib/default-agent/hoon
      /lib/skeleton/hoon
      /mar/bill/hoon
      /mar/mime/hoon
      /sur/verb/hoon
  ==
::  +cellar - threads
::
++  cellar
  ^-  outpost:citadel
  %^  fose  %base  foundation
  :~  /sur/spider/hoon
      /lib/strandio/hoon
      /lib/strand/hoon
  ==
::  +seals - scroll marks
::
++  seals
  ^-  outpost:citadel
  %-  my
  :~  :-  %docs
  :~  /mar/udon/hoon
      /mar/clue/hoon
      /lib/cram/hoon
      /sur/docs/hoon
  ==  ==
::  +press - pretty printing
::
++  press

  ^-  outpost:citadel
  %-  my
  :~  :-  %base
  :~  /sur/plum/hoon
      /sur/xray/hoon
      /lib/plume/hoon
      /lib/xray/hoon
      /lib/pprint/hoon
  ==  ==
::
::    partial diagrams
::
::  +cutlery - metadata
::
++  cutlery
  ^-  atelier:citadel
  :~  /dia/bas/desk/docket-0
      /dia/bas/desk/bill
  ==
::  +scrolls - ~pocwet/docs materials
::
++  scrolls
  ^-  atelier:citadel
  :~  /dia/docs/doc/dev/agent-1/udon
      /dia/docs/doc/dev/agent-2/udon
      /dia/docs/doc/dev/basic/udon
      /dia/docs/doc/usr/changelog/udon
      /dia/docs/doc/usr/overview/udon
      /dia/docs/doc/clue
  ==
::  +mansion - all requisites
::
++  mansion  ^-  grounds:citadel  [pillar cutlery]
::
::    complete diagrams
::
::  +butlers - agent examples
::
++  butlers
  ^-  grounds:citadel
  %^  build-estate  &  ~
  :~  /dia/ent/app/ent/hoon
  ==
::  +valet - cli examples
::
++  valet
  ^-  grounds:citadel
  %^  build-estate  &  ~
  :~  /dia/cli/app/cli/hoon
  ==
::  +crier - hello world examples
::
++  crier
  ^-  grounds:citadel
  %^  build-estate  &  ~
  :~  /dia/hel/app/hel/hoon
  ==
::  +library - docs
::
++  library
  ^-  grounds:citadel
  %^  build-estate  &  `seals
  scrolls
::  +frontage - apps with agent and frontend
::
++  frontage
  ^-  grounds:citadel
  mansion
::  +circuitry - thread examples
::
++  circuitry
  ^-  grounds:citadel
    :-  foundation
    :~  /dia/ted/ted/hi/hoon
    ==
::  +turbines - generator examples
::
++  turbines
  ^-  grounds:citadel
  :-  foundation
  :~  /dia/gen/app/gen/hoon
  ==
::    +build-estate
::  raises the roof
++  build-estate
  |=  [lor=? mout=(unit outpost:citadel) =atelier:citadel]
  ^-  grounds:citadel
  =+  ?~  mout  outpost:mansion
    (fuse outpost:mansion u.mout)
  :-  ?:  lor  (fuse seals -)
    -
  (welp atelier:mansion atelier)
::
::  clay utilities
::
++  play
  |_  [=bowl:gall =desk]
    ::    +cite
    ::
    ::  write file to desk.
    ++  cite
      |=  [dusk=^desk =path data=cage]
      =-  [%pass /write/citadel %arvo %c %info -]~
      =/  fath=^path  (weld /(scot %p our.bowl)/[dusk]/(scot %da now.bowl) path)
      %+  foal:space:userlib
        fath
      data
    ::    +zuck
    ::
    ::  copies smart-lib from a ziggurat desk.
    ++  zuck
      |^  
      ~|  "citadel: missing smart-lib in {<desk>}"
      (cite %citadel /lib/zig/compiled/smart-lib/noun [%noun !>((need smar))])
      ::      
      ++  smar
        ^-  (unit *)
        %-  file:space:userlib
        /(scot %p our.bowl)/[desk]/(scot %da now.bowl)/lib/zig/compiled/smart-lib/noun
      --
    ::    +scop: init desk from files in another desk.
    ::
    ::  grounds - user and dependency files to seed the desk with.
    ::            must exist in the given desk.
    ::
    ::  TODO simulate symlinks somehow?
    ::
    ++  scop
      |=  $:  from=^desk
              =grounds:citadel
          ==
      =/  bek  byk.bowl
      =/  desks  .^((set ^desk) %cd (en-beam bek(q from) /))
      ?:  (~(has in desks) desk)
        ~|  [%already-exists desk]
        !!
      %^  new-desk:cloy  desk  ~
      |^
      =/  all=(map ^desk (list path))
        ?:  =(~ atelier.grounds)  outpost.grounds
        %+  ~(put by outpost.grounds)  %citadel  atelier.grounds
      %-  ~(gas by *(map path page:clay))
      =-  %+  roll  -
      |=  $:  [d=@tas l=(list [path page:clay])]
              out=(list [path page:clay])
          ==
      (weld out l)
      =-  ~(tap by -)
      %-  ~(urn by all)
      |=  [des=@tas files=(list path)]
      ^-  (list [path page:clay])
      =/  [=ship orig=^desk =case:clay]  bek
      =+  .^(=rang:clay %cx /(scot %p our.bowl)//(scot %da now.bowl)/rang)
      =+  .^(=dome:clay %cv (en-beam bek(q from) /))
      =/  =yaki
        %-  ~(got by hut.rang)
        %-  ~(got by hit.dome)
        let.dome
        ~&  >  %yaki
      =/  paths=(list [=path =lobe])
        %+  murn  files
        |=  =path
        ?.  %-  ~(has by q.yaki)  path  ~
          :-  ~
          :-  path
          %-  ~(got by q.yaki)  path
      (turn paths (cury mage rang))
      ::  +mage - page from clay. %dia paths in %citadel
      ::          have the form /dia/<name>/...
      ::
      ++  mage
        |=  [=rang:clay =path =lobe]
        ::  TODO should be the desk containing this file
        :-  ?:  &(?=([%dia @ *] path) =(from %citadel))
          t.t.path
        path
        ^-  page:clay
        ~|  [%missing-source-file [from q.bek] path]
        (~(got by lat.rang) lobe)
     --
    --
  --
