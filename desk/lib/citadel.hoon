/-  citadel
=,  clay
|%
:: +foundation - bare minimum
::
++  foundation
  ^-  outpost:citadel
  :~  /mar/noun/hoon
      /mar/hoon/hoon
      /mar/txt/hoon
      /mar/kelvin/hoon
      /sys/kelvin

  ==
::  +pillar - agent and garden desiderata
::
++  pillar
  ^-  outpost:citadel
  %+  weld  foundation
  ^-  outpost:citadel
  :~  /lib/verb/hoon
      /lib/dbug/hoon
      /lib/shoe/hoon
      /lib/default-agent/hoon
      /lib/skeleton/hoon
      /mar/bill/hoon
      /mar/mime/hoon
      /mar/docket-0/hoon
  ==
::  +cellar - threads
++  cellar
  ^-  outpost:citadel
  %+  weld  foundation
  ^-  outpost:citadel
  :~  /sur/spider/hoon
      /lib/strandio/hoon
      /lib/strand/hoon
  ==
::    partial diagrams
::
::  +cutlery - metadata
::
++  cutlery
  ^-  atelier:citadel
  :~  /dia/bas/docket-0/hoon
      /dia/bas/desk/bill
  ==
::  +mansion - all requisites
::
++  mansion  ^-  grounds:citadel  [pillar cutlery]
::    complete diagrams
::
::  +butlers - agent examples
::
++  butlers
  ^-  grounds:citadel
  %+  build-estate  ~
  :~  /dia/ent/app/ent/hoon
  ==


::  +valet - cli examples
::
++  valet
  ^-  grounds:citadel
  %+  build-estate  ~
  :~  /dia/cli/app/cli/hoon
  ==
::  +crier - hello world examples
::
++  crier
  ^-  grounds:citadel
  %+  build-estate  ~
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
    %+  build-estate  `cellar
    :~  /dia/ted/ted/hoon
    ==
::  +turbines - generator examples
::
++  turbines
  ^-  grounds:citadel
  %+  build-estate  ~
  :~  /dia/gen/app/gen/hoon
  ==
::
++  build-estate
  |=  [mout=(unit outpost:citadel) =atelier:citadel]
  ^-  grounds:citadel
  :-  ?~  mout  outpost:mansion
    (welp outpost:mansion u.mout)
  (welp atelier:mansion atelier)
::
++  play
  |%
    ::  +scop: init desk from files in another desk.
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
      =+  .^(=dome:clay %cv (en-beam bek /))
      ::
      %^  new-desk:cloy  desk
        ~
      %-  ~(gas by *(map path page:clay))
      |^  =/  sown  (turn atelier.grounds mage)
          (weld sown (turn outpost.grounds mage))
      ::  +mage: page from clay
      ::
      ++  mage
        |=  =path
        :-  ?:(?=([%dia @ *] path) t.t.path path)
        ^-  page:clay
        =;  =cage  [p q.q]:cage
        ~|  [%missing-source-file from path]
        (need (~(get an:cloy ank.dome) path))
        --
      --
    --
