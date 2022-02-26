/-  citadel
=,  clay
|%
++  fose
  |=  [=desk init=outpost:citadel rest=(list path)]
  ^-  outpost:citadel
  ~!  desk
  %+  ~(jab by init)  desk  (cury welp rest)
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
  ==  ==
::  +pillar - agent and garden desiderata
::
++  pillar
  ^-  outpost:citadel
  %+  fuse  soil
  %^  fose  %base  foundation
  :~  /lib/verb/hoon
      /lib/dbug/hoon
      /lib/shoe/hoon
      /lib/agentio/hoon
      /lib/default-agent/hoon
      /lib/skeleton/hoon
      /mar/bill/hoon
      /mar/mime/hoon
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
::  +seal - scroll marks
::
++  seals
  ^-  outpost:citadel
  %-  my
  :~  :-  %docs
  :~  /mar/udon/hoon
      /mar/clue/hoon
  ==  ==
::    partial diagrams
::
::  +cutlery - metadata
::
++  cutlery
  ^-  atelier:citadel
  :~  /dia/bas/docket-0/hoon
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
::
::  +mansion - all requisites
::
++  mansion  ^-  grounds:citadel  [pillar cutlery]
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
::
++  build-estate
  |=  [lor=? mout=(unit outpost:citadel) =atelier:citadel]
  ^-  grounds:citadel
  =+  ?~  mout  outpost:mansion
    (fuse outpost:mansion u.mout)
  :-  ?:  lor  (fuse seals -)
    -
  (welp atelier:mansion atelier)
::
++  play
  |%
    ::    +scop: init desk from files in another desk.
    ::
    ::  grounds - user and dependency files to seed the desk with.
    ::            must exist in the given desk.
    ::
    ::  TODO simulate symlinks somehow?
    ::
    ++  scop
      |=  $:  bek=beak
              from=desk
              =desk
              =grounds:citadel
          ==
      =/  desks  .^((set ^desk) %cd (en-beam bek(q from) /))
      ?:  (~(has in desks) desk)
        ~|  [%already-exists desk]
        !!
      ::
      %^  new-desk:cloy  desk  ~
      |^
      =/  all=(map ^desk (list path))
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
      =+  .^(=dome:clay %cv (en-beam bek(q des) /))
      ::
      (turn files (cury (cury mage dome) des))
      ::  +mage - page from clay. %dia paths in %citadel
      ::          have the form /dia/<name>/...
      ::
      ++  mage
        |=  [=dome:clay d=^desk =path]
        ::  TODO should be the desk containing this file
        :-  ?:  &(?=([%dia @ *] path) =(from %citadel))
          t.t.path
        path
        ^-  page:clay
        =;  =cage  [p q.q]:cage
        ~|  [%missing-source-file [from q.bek] path]
        (need (~(get an:cloy ank.dome) path))
      --
    --
  --
