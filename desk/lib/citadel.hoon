::  * imports
/-  *citadel
::  * main
=,  clay
|%
::  ** desk composition
::    +fose

++  fose
  |=  [=desk init=outpost rest=(list path)]
  ^-  outpost
  ~!  desk
  %+  ~(jab by init)  desk  (cury welp rest)
::    +fuse

++  fuse
  |=  [init=outpost rest=outpost]
  ^-  outpost
  %-  (~(uno by init) rest)  |=([=desk a=(list path) b=(list path)] (welp a b))
::  +foundation - bare minimum

++  foundation
  ^-  outpost
  %-  my
  :~  :-  %base
  :~  /mar/noun/hoon
      /mar/hoon/hoon
      /mar/txt/hoon
      /mar/kelvin/hoon
      /sys/kelvin
  ==  ==
::  +soil - fertilized

++  soil
  ^-  outpost
  %-  my
  :~  :-  %garden
  :~  /mar/docket-0/hoon
      /lib/docket/hoon
      /sur/docket/hoon
  ==  ==
::  +pillar - agent and garden desiderata

++  pillar
  ^-  outpost
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

++  cellar
  ^-  outpost
  %^  fose  %base  foundation
  :~  /sur/spider/hoon
      /lib/strandio/hoon
      /lib/strand/hoon
  ==
::  +seals - scroll marks

++  seals
  ^-  outpost
  %-  my
  :~  :-  %docs
  :~  /mar/udon/hoon
      /mar/json/hoon
      /mar/clue/hoon
      /lib/cram/hoon
      /sur/docs/hoon
  ==  ==
::  +press - pretty printing

++  press

  ^-  outpost
  %-  my
  :~  :-  %base
  :~  /sur/plum/hoon
      /sur/xray/hoon
      /lib/plume/hoon
      /lib/xray/hoon
      /lib/pprint/hoon
  ==  ==

::    partial diagrams

::  +cutlery - metadata

++  cutlery
  ^-  atelier
  :~  /dia/bas/desk/docket-0
      /dia/bas/desk/bill
  ==
::  +scrolls - ~pocwet/docs materials

++  scrolls
  ^-  atelier
  :~  /dia/docs/doc/dev/agent-1/udon
      /dia/docs/doc/dev/agent-2/udon
      /dia/docs/doc/dev/basic/udon
      /dia/docs/doc/usr/changelog/udon
      /dia/docs/doc/usr/overview/udon
      /dia/docs/doc/clue
  ==
::  +mansion - all requisites

++  mansion  ^-  grounds  [pillar cutlery]

::    complete diagrams

::  +butlers - agent examples

++  butlers
  ^-  grounds
  %^  build-estate  &  ~
  :~  /dia/ent/app/ent/hoon
  ==
::  +valet - cli examples

++  valet
  ^-  grounds
  %^  build-estate  &  ~
  :~  /dia/cli/app/cli/hoon
  ==
::  +crier - hello world examples

++  crier
  ^-  grounds
  %^  build-estate  &  ~
  :~  /dia/hel/app/hel/hoon
  ==
::  +library - docs

++  library
  ^-  grounds
  %^  build-estate  &  `seals
  scrolls
::  +frontage - apps with agent and frontend

++  frontage
  ^-  grounds
  mansion
::  +circuitry - thread examples

++  circuitry
  ^-  grounds
    :-  foundation
    :~  /dia/ted/ted/hi/hoon
    ==
::  +turbines - generator examples

++  turbines
  ^-  grounds
  :-  foundation
  :~  /dia/gen/app/gen/hoon
  ==
::  +rancher - herd
++  rancher
  %^  build-estate  |  ~
  :~  /dia/hrd/desk/herd
      /dia/hrd/desk/bill
      /dia/hrd/mar/herd/hoon
      /dia/hrd/mar/mime/hoon
      /dia/hrd/mar/bill/hoon
      /dia/hrd/mar/kelvin/hoon
      /dia/hrd/sur/herd/hoon
      /dia/hrd/sys/kelvin
  ==
::    +build-estate
::  raises the roof
++  build-estate
  |=  [lor=? mout=(unit outpost) =atelier]
  ^-  grounds
  =+  ?~  mout  outpost:mansion
    (fuse outpost:mansion u.mout)
  :-  ?:  lor  (fuse seals -)
    -
  (welp atelier:mansion atelier)
::  *** file motion
++  play
  |_  [=bowl:gall =desk]
::  **** write
::  ****  cite
    ::    +cite
    ::
    ::  write file to desk.
    ++  cite
      |=  [=path data=cage]
      ^-  cards
      =*  bek  byk.bowl
      ~&  >>  "saving to {<desk>} at {<path>}"
      ~|  "failed write to {<desk>}"
      =-  [%pass /citadel/write %arvo %c %info -]~
      =/  fath=^path  (weld /(scot %p our.bowl)/[desk]/(scot %da now.bowl) path)
      ~&  >>  "saved to {<desk>} at {<path>}"
      (foal:space:userlib fath data)
::  ****  hite
    ::    +hite
    ::
    ::  write text as hoon to desk.
    ++  hite
      |=  [=path txt=@t]
      ^-  cards
      =/  =mark  (rear path)
      =/  =type  [%atom %t ~]
      =-  (cite path -)
      [mark [type ?:(=(%hoon mark) txt (need (de:json:html txt)))]]
::  ****  gite
    ::    +gite
    ::
    ::  write deeds
    ++  gite
      |=  deeds=(list deed)
      ^-  cards
      %-  zing
      %+  turn  deeds
      |=  =deed
      ^-  cards
      =,  scroll.deed
      ?<  =(~ text)
      =.  desk  ?.  =(~ project)  +.project  desk
      (hite (weld /(scot %tas -.deed) path) +.text)
    ::
::  *** from desk
    ::    +scop: init desk from files in another desk.
    ::
    ::  grounds - user and dependency files to seed the desk with.
    ::            must exist in the given desk.
    ::
    ::  TODO simulate symlinks somehow?
    ::
    ++  scop
      |=  $:  from=^desk
              =grounds
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
      =/  [=ship orig=^desk =case]  bek
      =+  .^(=rang:clay %cx /(scot %p our.bowl)//(scot %da now.bowl)/rang)
      =+  .^(dome=domo %cv (en-beam bek(q from) /))
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
