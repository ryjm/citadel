::  * imports
/-  *citadel, docket, *treaty, zink
/+  mill=zig-mill, smart=zig-sys-smart, default-agent, dbug, agentio,
    *citadel, server, verb, etch, merk
/*  smart-lib-noun  %noun  /lib/zig/compiled/smart-lib/noun
/*  zink-cax-noun   %noun  /lib/zig/compiled/hash-cache/noun
/*  triv-contract   %noun  /lib/zig/compiled/trivial/noun
/*  scry-contract   %noun  /lib/zig/compiled/trivial-scry/noun
/*  zigs-contract   %noun  /lib/zig/compiled/zigs/noun
!:
::  * types
|%

::  ** state
::
 +$  state-0  [%0 colonies=(map desk outpost)]
::
 +$  state-1
   $:  %1
       colonies=(map desk outpost)
       projects=(map desk (set deed))
   ==
 +$  versioned-state
  $%  state-0
      state-1
  ==
::
::  **  project types
::
+$  mode  ?(%view %edit)
--
::

::  * agent
::
%+  verb  |
%-  agent:dbug
=|  state-1
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
::
::  ** aliases
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    io    ~(. agentio bowl)
    do    ~(. +> bowl)
    ch    ch:do
    cg    cg:do
    cc    cc:do
::
::  ** on-peek
++  on-peek
  |=  =path
  |^  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%x %colony * ~]
    ``noun+!>((~(get by colonies) i.t.t.path))
      [%x %colonies ~]
    ``noun+!>(colonies)
      [%x %projects ~]
    ``noun+!>(projects)
      [%x %projects-json ~]
    ``json+!>((en-vase:etch !>(projects.state)))
      [%x %project * ~]
    ``noun+!>((~(get by projects) i.t.t.path))
  ==
  --
::  ** on-init
++  on-init
  ^-  (quip card _this)
  :_  this
  :~
    [%pass /eyre %arvo %e %connect [~ /citadel/types] dap.bowl]
    [%pass /eyre %arvo %e %connect [~ /citadel] dap.bowl]
  ==
::  ** on-save
++  on-save   !>(state)
::  ** on-load
++  on-load
  |=  ole=vase
    ^-  (quip card _this)
    ~&  >  [dap.bowl %load-citadel]
    =/  maybe-old  (mule |.(!<(versioned-state ole)))
    =/  old=versioned-state
      ?:  ?=(%| -.maybe-old)  !<(versioned-state ole)  +.maybe-old
    =/  new=state-1
    ?-  -.old
      %0  [%1 colonies.old *(map desk (set deed))]
      %1  old
    ==
    :: TODO install docs elsewhere
    :: =^  cards  state  lore:do
    =/  bindings
      :~
        [%pass /eyre %arvo %e %connect [~ /citadel/types] dap.bowl]
        [%pass /eyre %arvo %e %connect [~ /citadel] dap.bowl]
        [%pass /citadel/types %agent [our.bowl dap.bowl] %watch /citadel/types]
      ==
    [bindings this(state new)]
::  ** on-poke
++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    =^  cards  state
      ?+    mark  (on-poke:def mark vase)
          %citadel-action
        =+  !<(poke=action vase)
        (on-action:do poke)
          %citadel-action
        =+  !<(poke=action vase)
        (on-action:do poke)
          %handle-http-request
        =+  !<([eyre-id=@ta =inbound-request:eyre] vase)
        :_  state
        %+  give-simple-payload:app:server  eyre-id
        %+  require-authorization:app:server  inbound-request
        on-http-request:do
      ==
    [cards this]
::  ** on-leave
++  on-leave  on-leave:def
::  ** on-arvo
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  =^  cards  state
    ?+  wire  (on-arvo:def wire sign-arvo)
      [%eyre ~]             [~ state]
    ==
  [cards this]
::  ** on-watch
++  on-watch
    |=  =path
    ^-  (quip card _this)
    =^  cards  state
      ?+  path  (on-watch:def path)
        [%http-response *]  [~ state]
        [%citadel %types *]  [~ state]
        [%citadel-primary *]  (peer-citadel-primary:do t.path)
      ==
    [cards this]
::  ** on-agent
++  on-agent
    |=  [=wire =sign:agent:gall]
    |^  ^-  (quip card _this)
    ?+    -.sign  (on-agent:def wire sign)
        %kick  `this
        %fact
      ?+    wire  (on-agent:def wire sign)
         [%citadel %types ~]
           ~&  >>  %citadel-wire
           ~&  >>  [%citadel-type !<(json q.cage.sign)]
           `this
        ==
      ==
   --
::  ** on-fail
++  on-fail   on-fail:def
--
::  * helper cores
|_  =bowl:gall
::  ** io
++  io    ~(. agentio bowl)
::  ** passing
++  pass  pass:io
::  ** docket
++  cg
  |%
::  *** docket-install
  ++  docket-install
    |=([her=ship there=desk] docket-install+!>([her there]))
::  *** ally-update
  ++  ally-update      |=(=update:ally ally-update-0+!>(update))
  --
::  ** docket
++  ch
  |_  =desk
  ++  pass  |=(=wire ~(. ^pass [%citadel desk wire]))
  ++  ally-update
    |=  [=ship]
    (poke-our:(pass /treaty-update) %treaty (ally-update:cg [%add ship]))
  ++  install
    |=  [=ship remote=^desk]
    (poke-our:(pass /docket-install) %docket (docket-install:cg ship remote))
  --
::  ** contract
++  zh
  |_  [code=@t mesk=(unit [desk path])]
::  *** make-wheat
++  make-wheat
  |=  [=bran:smart interface=lumps:smart types=lumps:smart]
  ^-  [cards wheat:smart]
  =/  =desk  ?^  mesk  -:(need mesk)  %citadel
  =/  pax=path  ?^  mesk  +:(need mesk)  /contracts/scratch/hoon
  =/  bek  byk.bowl
  =/  exists=?  .^(? %cu (en-beam bek(q desk) pax))
  ~&    >>
    ?:  exists  "contract {<pax>} exists in clay, will overwrite"
  "writing contract to {<pax>}"
  =/  contract-text  code
  =/  [raw=(list [face=term =path]) contract-hoon=hoon]
    (parse-pile (trip contract-text))
  =/  =cards  (~(hite play bowl desk) pax contract-text)
  :: ~!  smart-lib-noun
  :: =/  smart-lib=vase  ;;(vase (cue q.q.smart-lib-noun))
  =/  smart-txt  .^(@t %cx /(scot %p our.bowl)/zig/(scot %da now.bowl)/lib/zig/sys/smart/hoon)
  =/  hoon-txt  .^(@t %cx /(scot %p our.bowl)/zig/(scot %da now.bowl)/lib/zig/sys/hoon/hoon)
  =/  hoe  (slap !>(~) (ream hoon-txt))
  =/  smart-lib=vase  (slap hoe (ream smart-txt))
  ::
  =/  braw=(list hoon)
    %+  turn  raw
    |=  [face=term =path]
    =/  pax=^path  (en-beam bek(q desk) path)
    %-  road  |.
    ~_  leaf/"{pax}: build failed"
    `hoon`[%ktts face (reck pax)]
  =/  full=hoon  [%clsg braw]
  =/  full-nock=*  q:(~(mint ut p.smart-lib) %noun full)
  =/  payload=vase  (slap smart-lib full)
  =/  cont  (~(mint ut p:(slop smart-lib payload)) %noun contract-hoon)
  :-  cards
  [`[bat=q.cont pay=full-nock] interface types bran]
++  cid  `@ux`'citadel-contract'
++  tid  0x0
::  *** test contract
++  test-contract
  |=  =wheat:smart
  =/  =yolk:smart
  [%give [holder-2:zigs 69 [%grain holder-1:zigs]] `[%grain holder-2:zigs]]
  =/  =shell:smart
    [caller-1 ~ id.p:wheat:zigs 1 1.000.000 town-id 1]
  =/  egg  [fake-sig shell yolk]
  =/  res
    %+  ~(mill mil miller town-id 1)
       fake-land
    egg
  res
::  *** fake data
::  **** mill
++  big  (bi:merk id:smart grain:smart)  ::  merkle engine for granary
++  pig  (bi:merk id:smart @ud)          ::                for populace
++  init-now  *@da
++  town-id    0x0
++  set-fee    7
++  fake-sig   [0 0 0]
++  mil
  %~  mill  mill
  :+    ;;(vase (cue q.q.smart-lib-noun))
    ;;((map * @) (cue q.q.zink-cax-noun))
  %.y
+$  mill-result
  [fee=@ud =land:mill burned=granary:mill =errorcode:smart hits=(list hints:zink) =crow:smart]
::  ***** callers
++  miller    ^-  caller:smart  [0x1512.3341 1 0x1.1512.3341]
++  caller-1  ^-  caller:smart  [0xbeef 1 0x1.beef]
++  caller-2  ^-  caller:smart  [0xdead 1 0x1.dead]
++  caller-3  ^-  caller:smart  [0xcafe 1 0x1.cafe]
::  **** scry wheat
++  scry-wheat
  ^-  grain:smart
  =/  cont  ;;([bat=* pay=*] (cue q.q.scry-contract))
  =/  interface=lumps:smart  ~
  =/  types=lumps:smart  ~
  :*  %|
      `cont
      interface
      types
      0xdada.dada  ::  id
      0xdada.dada  ::  lord
      0xdada.dada  ::  holder
      town-id
  ==

::  **** granary
++  fake-granary
  ^-  granary:mill
  %+  gas:big  *(merk:merk id:smart grain:smart)
  :~  [id.p:scry-wheat scry-wheat]
      ::  [id.p:wheat:zigs wheat:zigs]
      [id.p:beef-account:zigs beef-account:zigs]
      [id.p:dead-account:zigs dead-account:zigs]
      [id.p:miller-account:zigs miller-account:zigs]
  ==
::  **** populace
++  fake-populace
  ^-  populace:mill
  %+  gas:pig  *(merk:merk id:smart @ud)
  ~[[holder-1:zigs 0] [holder-2:zigs 0] [holder-3:zigs 0]]
::  **** land
++  fake-land
  ^-  land:mill
  [fake-granary fake-populace] 

::  *** fake zigs
++  zigs
  |_  =grain:smart
::  **** grains
++  holder-1  0xbeef
++  holder-2  0xdead
++  holder-3  0xcafe
++  miller-account
  ^-  grain:smart
  :*  %&
      `@`'zigs'
      %account
      [1.000.000 ~ `@ux`'zigs-metadata']
      0x1.1512.3341
      zigs-wheat-id:smart
      0x1512.3341
      town-id
  ==
++  beef-account
  ^-  grain:smart
  :*  %&
      `@`'zigs'
      %account
      [300.000.000 ~ `@ux`'zigs-metadata']
      0x1.beef
      zigs-wheat-id:smart
      holder-1
      town-id
  ==
++  dead-account
  ^-  grain:smart
  :*  %&
      `@`'zigs'
      %account
      [200.000 ~ `@ux`'zigs-metadata']
      0x1.dead
      zigs-wheat-id:smart
      holder-2
      town-id
  ==
++  cafe-account
  ^-  grain:smart
  :*  %&
      `@`'zigs'
      %account
      [100.000 ~ `@ux`'zigs-metadata']
      0x1.cafe
      zigs-wheat-id:smart
      holder-3
      town-id
  ==
++  wheat
  ^-  grain:smart
  =/  cont  ;;([bat=* pay=*] (cue q.q.zigs-contract))
  =/  interface=lumps:smart  ~
  =/  types=lumps:smart  ~
  :*  %|
      `cont
      interface
      types
      zigs-wheat-id:smart  ::  id
      zigs-wheat-id:smart  ::  lord
      zigs-wheat-id:smart  ::  holder
      town-id
  ==
--

::  *** parsers
+$  small-pile
  $:  raw=(list [face=term =path])
      =hoon
  ==
++  parse-pile
  |=  tex=tape
  ^-  small-pile
  =/  [=hair res=(unit [=small-pile =nail])]  (pile-rule [1 1] tex)
  ?^  res  small-pile.u.res
  %-  mean  %-  flop
  =/  lyn  p.hair
  =/  col  q.hair
  :~  leaf+"syntax error at [{<lyn>} {<col>}]"
      leaf+(runt [(dec col) '-'] "^")
      leaf+(trip (snag (dec lyn) (to-wain:format (crip tex))))
  ==
++  pile-rule
  %-  full
  %+  ifix  [gay gay]
  ;~  plug
    %+  rune  tis
    ;~(plug sym ;~(pfix gap stap))
  ::
    %+  stag  %tssg
    (most gap tall:vast)
  ==
++  pant
  |*  fel=^rule
  ;~(pose fel (easy ~))
++  mast
  |*  [bus=^rule fel=^rule]
  ;~(sfix (more bus fel) bus)
++  rune
  |*  [bus=^rule fel=^rule]
  %-  pant
  %+  mast  gap
  ;~(pfix fas bus gap fel)
--

::  ** mold responses
++  cc
  |%
  ++  peer-types  !!
  --
::  ** project
++  pc
  |%
::  *** clay work
  ++  work
  |_  [bowl:gall =mode =beam]
::  *** utilities
  ++  arch  ~+  .^(^arch %cy rend)
  ++  tree  ~+  .^((list path) %ct rend)
  ++  cass  ~+  .^(cass:clay %cw rend)
  ++  last  ~+  ud:.^(cass:clay %cw rend(r.beam da+now))
  ++  rend  ~+  (en-beam beam)
  ::
  ++  have  ?=(^ [fil:arch])
  ++  peak  ?=(~ s.beam)
  ::
::  **** file tree
  ++  free
    %+  turn  (sort ~(tap in ~(key by dir:arch)) aor)
    |=  k=@ta
    ^-  [dir=? path]
    =+  naf=(snoc s.beam k)
    =+  arf=arch(s.beam naf)
    ?^  fil.arf              [| /[k]]
    ?.  ?=([^ ~ ~] dir.arf)  [& /[k]]
    =+  dep=$(s.beam naf, k p.n.dir.arf)
    [-.dep k +.dep]
  ::
::  **** paths
  ++  sput  ~+  (spud dap mode spot)
  ++  spot  ~+
    ^-  path
    =+  ?:(=(da+now r.beam) rend(r.beam tas+%now) rend)
    ?.  =(p.beam our)  -
    [%our (slag 1 -)]
::
::  **** file viewing
  ++  show  ~+
    ^-  (unit mime)
    ~|  %shouldnt-have-shown
    ?.  ?=(^ [fil:arch])  ~
    =/  =mark  (rear s.beam)
    ?:  =(%mime mark)  `.^(mime %cx rend)
    =;  =tube:clay
      `!<(mime (tube .^(vase %cr rend)))
    .^(tube:clay %cc rend(r.beam da+now, s.beam /[mark]/mime))
  ::
  ::
  ++  down
    |=  request:http
    ^-  simple-payload:http
    ?.  ?=(%'GET' method)  deny
    =+  m=show
    ?~  m  miss
    :_  `q.u.m
    [200 ['content-type'^(en-mite:mimes:html p.u.m)]~]
  ::

  ++  deny  [[405 ~] `(as-octs:mimes:html 'method not allow')]
  ++  miss  [[404 ~] `(as-octs:mimes:html 'file not found')]
  ++  wack  [[400 ~] `(as-octs:mimes:html 'invalid request')]
  ::
  --  --
::  * handlers
::  ** on-action
++  on-action
  |=  =action
  ^-  (quip card _state)
  ?-    -.action
      %desk  (on-desk action)
      %diagram  (on-diagram action)
      %run  (on-run action)
      %save  (on-save action)
      %delete  (on-delete action)
  ==
::  ** on-http-request
++  on-http-request
  |=  =inbound-request:eyre
  ^-  simple-payload:http
  =+  request-line=(parse-request-line:server url.request.inbound-request)
  ?+    request-line  not-found:gen:server
      [[[~ %json] [%citadel %types ~]] ~]
    %-  json-response:gen:server
    *json
    [[[~ %json] [%citadel %projects ~]] ~]
    %-  json-response:gen:server
    =-  ~&  >  [%here -]  -
    %-  en-vase:etch  !>(projects.state)
  ==
::  ** on-desk
++  on-desk
  |=  =action
  ^-  (quip card _state)
  ~!  action
  ?>  ?=(%desk -.action)
  =/  =desk  name.action
  =/  bek  byk.bowl
  =+  %-  my
    :~  :-  from.action
      .^((list path) ct+(en-beam bek(q from.action) /))
    ==
  ~&  >  [%from-files -]
  :_  state(colonies (~(put by colonies.state) desk -))
  :~
    :^  %pass  /citadel/desk/[desk]  %arvo
    (~(scop play [bowl desk]) from.action [- ~])
  ==
::  ** on-diagram
++  on-diagram
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%diagram -.action)
  =/  desk  name.action
  =/  [=outpost =card]  (make-diagram gram.action desk furm.action)
  :: TODO specify dependency desk in outpost
  :_  state(colonies (~(put by colonies) desk outpost), projects (~(put by projects) desk ~))
  [card ~]
::  ** on-save
++  on-save
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%save -.action)
  =/  dummy-json=json  .^(json cx+(en-beam byk.bowl /dummy/json))
  =/  dummy-card=card
    [%give %fact ~[/citadel/types] %json !>(dummy-json)]
  =/  cards  (~(gite play [bowl q.byk.bowl]) deeds.survey.action)
  =/  deeds=(list deed)  deeds.survey.action
  =|  updated=(map desk (set deed))
  |-
  ?~  deeds
    :_  state
    (flop [dummy-card cards])
  =/  project  (fall project.scroll.i.deeds q.byk.bowl)
  =/  dats=(unit (set deed))  (~(get by projects.state) project)
  =/  stad=(set deed)  (biff dats same)
  =/  desks  .^((set ^desk) %cd (en-beam byk.bowl /))
  =/  [sdac=^cards =_state]
    ?:  (~(has in desks) project)  `state
    (on-action [%diagram `%citadel [project [%doc ~]] project])
  =/  updated=(map desk (set deed))
    %+  ~(put by projects)  project
    (~(put in stad) i.deeds)
  %=    $
      cards  (weld cards sdac)
      deeds  t.deeds
      projects  updated
  ==
::
::  *** TODO polish project tracking
::  add the saved deeds to the corresponding project(s) in the `project` map. should
::  it update any desk files that are not in the project state yet? needs to account
::  for dependencies?
::  ** on-delete
++  on-delete
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%delete -.action)
  `state(projects (~(del by projects) project.action))
::  ** on-run
++  on-run
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%run -.action)
  ~&  >>  action
  ?-    -.survey.action
      %contract
    =/  [=cards =wheat:smart]
      %^    ~(make-wheat zh charter.survey.action ~)
          bran.action
        interface.action
      types.action
    [cards state]
      %gall
    !!
  ==
::  * utils
++  make-diagram
  |=  [=gram =desk from=(unit desk)]
  ^-  [outpost card]
  =*  bek  byk.bowl
  =/  diagrams  .^((list path) ct+(en-beam bek /dia/[+<.gram]))
  =|  from-files=(list path)
  =?  q.bek  ?=(^ from)  u.from
  =?  from-files  ?=(^ from)  .^((list path) ct+(en-beam bek /))
  ~&  >>  from-files
  ~&  >>  q.bek
  =/  =grounds
    ?-  +<.gram
      %ent  butlers
      ::  %rud  frontage TODO frontend app
      %gen  turbines
      %doc  library
      %ted  circuitry
      %cli  valet
      %hel  crier
      %prt  [(fuse press foundation) ~]
    ==
  ~&  >>  grounds
  =/  merged=^grounds
    %=  grounds
      outpost  (fuse (my [q.bek from-files]~) outpost:grounds)
      atelier  (weld atelier:grounds diagrams)
    ==
  :-  outpost:merged
  :^  %pass  /citadel/desk/diagram  %arvo
  (~(scop play [bowl desk]) %citadel merged)
::
++  lore
  ^-  (quip card _state)
  =*  cha  ~(. ch q.byk.bowl)
  =/  charges
    .^  charge-update:docket
        %gx
        (scry:io %docket /charges/noun)
    ==
  ?>  ?=(%initial -.charges)
  :_  state
  ?.  %-  ~(has by initial.charges)  %docs
    ~&  >>  "installing ~pocwet/docs"
    :~
      (ally-update:cha ~pocwet)
      (install:cha ~pocwet %docs)
    ==
  ~&  >>  "docs installed"
  ~
++  peer-citadel-primary
  |=  wir=wire
  ^-  (quip card _state)
  ?.  =(our.bowl src.bowl)
    :_  state
    [%give %kick ~ ~]~
  [~ state]
--
