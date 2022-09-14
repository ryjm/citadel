::  * imports
/-  *citadel, docket, *treaty, zink
/+  mill=zig-mill, smart=zig-sys-smart, default-agent, dbug, agentio,
    *citadel, server, verb, etch, merk
::  * types
|%
::
::  ** project types
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
    ``citadel-projects+!>(state)
      [%x %tests @ ~]
    :^  ~  ~  %json
    !>  =-  a+(turn - (lead %s))
    (~(got by tests) i.t.t.path)
      [%x %project @ ~]
    ``noun+!>((~(get by projects) i.t.t.path))
    [%x %project %id @ ~]
    ``json+!>((en-vase:etch !>(`@ux`i.t.t.t.path)))
      [%x %factory ~]
    ``citadel-factory+!>(state)
      [%x %state @tas @ ~]
    :^  ~  ~  %citadel-state
    !>
    =-  (fall - *in-state)
    =-  (bind - (corl in-state (lead i.t.t.path)))
    ?+    i.t.t.path  ~
        %tests
      (some tests)
        %factory
      (some factory)
        %granary
      (~(get by factory) i.t.t.t.path)
        %project
      (~(get by projects) i.t.t.t.path)
        %projects
      (some projects)
        %colonies
      (some colonies)
    ==
      [%x %factory @ @ ~]
    ``noun+!>((get:big:uq (~(got by factory) i.t.t.path) (slav %ux i.t.t.t.path)))
      [%x %factory @ ~]
    :^  ~  ~  %noun
    !>  (~(get by factory) i.t.t.path)
      [%x %factory-json @ ~]
    :^  ~  ~  %json
    !>  =-  (en-vase:etch -)
    !>  (~(get by factory) i.t.t.path)
      [%x %factory-json @ @ ~]
    :^  ~  ~  %json
    !>  =-  (en-vase:etch -)
    !>  %+  get:big:uq
          (~(got by factory) i.t.t.path)
        (slav %ux i.t.t.t.path)
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
      %0
    :*  %1
        colonies.old
        *(map desk (set deed))
        *(map desk granary:mill)
        *(jar desk @t)
    ==
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
           `this
        ==
      ==
   --
::  ** on-fail
++  on-fail   on-fail:def
--
::  * cores
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
::  ** uqbar
::  uqbar contracts.

::  per-desk/contract module.
++  zh
  |_  code=@t
::  *** make-wheat
::  creates a wheat against the current contract. runs a full compilation using the
::  libraries in the %zig desk.
++  make-wheat
  |=  [=bran:smart interface=lumps:smart types=lumps:smart]
  ^-  [cards wheat:smart]
  =/  [cont=vase * * full-nock=*]  (compile:uq ~ `code our:bowl now:bowl)
  :-  ~
  [`[bat=q.cont pay=full-nock] interface types bran]
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
::  ** action router
++  on-action
  |=  =action
  ^-  (quip card _state)
  ?-    -.action
      ::  desks
      %desk  (on-desk action)
      %diagram  (on-diagram action)
      ::  projects
      %save  (on-save action)
      %delete  (on-delete action)
      ::  ::  uqbar
      ::  contract inspector
      %test  (on-test action)
      %save-test  (on-save-test action)
      %run  (on-run action)
      %mill  (on-mill action)
      ::  grain management
      %save-grain  (on-save-grain action)
      %delete-grain  (on-delete-grain action)
  ==
::  ** frontend
::  *** on-http-request
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
::  ** desks
::  *** on-desk
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
::  *** on-diagram
++  on-diagram
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%diagram -.action)
  =/  desk  name.action
  =/  [=outpost =card]  (make-diagram gram.action desk furm.action)
  :: TODO specify dependency desk in outpost
  :_  state(colonies (~(put by colonies) desk outpost), projects (~(put by projects) desk ~))
  [card ~]
::  ** projects
::  projects are defined by an associated set of deeds representing each project
::  component, scope, and associated datum.
::  *** on-save
::  save each datum in the deed set to clay, at the desk specified by the deed or
::  the survey (deed takes precedence).
++  on-save
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%save -.action)
  =/  desks  .^((set ^desk) %cd (en-beam byk.bowl /))
  =/  [sdac=^cards =_state]
    ?:  (~(has in desks) project.survey.action)  `state
    (on-action [%diagram `%citadel [project.survey.action [%doc ~]] project.survey.action])
  =/  dummy-exists=?  .^(? %cu (en-beam byk.bowl /dummy/json))
  =/  dummy-json=json  ?.  dummy-exists  *json
    .^(json cx+(en-beam byk.bowl /dummy/json))
  =/  dummy-card=card
    [%give %fact ~[/citadel/types] %json !>(dummy-json)]
  =/  cards  (~(gite play [bowl q.byk.bowl]) deeds.survey.action)
  =/  [new-cards=(list card) new-state=_state]
    ?.  &(?=(%contract arena.survey.action) !=('' charter.survey.action))
      [cards state]
    =/  contract-id=@ux  `@ux`project.survey.action
    =-  [(weld cards (head -)) (tail -)]
    %-  on-mill
    :*  %mill
        survey.action
        [contract-id contract-id contract-id town-id:uq]
        ~
        ~
    ==
  =.  state  new-state
  =.  cards  new-cards
  ::
  =/  deeds=(list deed)  deeds.survey.action
  |-
  ?~  deeds
    :_  state
    (flop [dummy-card (weld cards sdac)])
  =/  project  (fall project.scroll.i.deeds project.survey.action)
  =/  project-deeds
     =-  (biff - same)
     (~(get by projects.state) project)
  =/  all-deeds
    %+  ~(put by projects.state)  project
    (~(put in project-deeds) i.deeds)
  %=    $
      cards  (weld cards sdac)
      deeds  t.deeds
      projects.state  all-deeds
  ==
::  *** on-delete
::  delete project from citadel state. does not delete from clay.
++  on-delete
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%delete -.action)
  `state(projects (~(del by projects) project.action))
::  *** TODO return types on wire
::  ** contracts
::  *** inspector
::  contract interaction.
::  **** saving
::  saves test datum to state. mostly used by the frontend to validate form inputs.

++  on-save-test
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%save-test -.action)
  :-  ~
  %_    state
      tests
    ?:  overwrite.action  (~(put by tests) project.action ~[test.action])
    (~(add ja tests) project.action test.action)
  ==
::  **** testing
::  interacts with a contract defined in a project granary with a list of yolks.
++  on-test
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%test -.action)
  =/  resu=[cards=(list card) _state]  [~ state]
  =/  contract-id=@ux  (fall contract-id.action `@ux`project.survey.action)
  =?  resu  !=('' charter.survey.action)
    %-  on-mill
    :*  %mill
        survey.action
        [contract-id contract-id contract-id town-id:uq]
        ~
        ~
    ==
  =/  =shell:smart
    [caller-1:uq ~ contract-id 1 1.000.000 town-id:uq 0]
  =/  =granary:mill
    =-  ?~  -  fake-granary:uq  -
    (biff (~(get by factory) project.survey.action) same)
  =/  remaining=(list yolk:smart)  yolks.action
  =|  milled=(list mill-result:uq)
  |-  ^-  (quip card _state)
  ~&  >  remaining+remaining
  ?~  remaining
    =.  factory
      %+  ~(put by factory)  project.survey.action
      =-  (roll milled -)
      |:  [m=*mill-result:uq g=granary]
      (shovel:uq m g)
    [cards.resu state(factory factory)]
  %=  $
    milled  [(fondle-mill:uq i.remaining shell granary) milled]
    remaining  t.remaining
  ==
::  ***** TODO find better nomenclature
::  these aren't tests, more like probes.
::  ***** TODO persist results to granary
::  **** running
::  creates a wheat from an action containing the needed bran, interface,
::  and types. does not update citadel factory.
++  on-run
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%run -.action)
  ~&  >>  action
  ?-    -.survey.action
      %contract
    =/  [=cards =wheat:smart]
      %^    ~(make-wheat zh charter.survey.action)
          bran.action
        interface.action
      types.action
    [cards state]
      %gall
    !!
  ==
::  **** milling
::  given a text representation of a contract, updates the factory with the created wheat.
++  on-mill
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%mill -.action)
  ?-    -.survey.action
      %contract
    =,  survey.action
    =/  [=cards =wheat:smart]
      %^    ~(make-wheat zh charter)
          bran.action
        interface.action
      types.action
    =/  =granary:mill
      =-  ?~  -  fake-granary:uq  -
      (biff (~(get by factory) project) same)
    =.  factory
      %+  ~(put by factory)  project
      %+  gas:big:uq  granary
      ~[[id.wheat ;;(grain:smart [%| wheat])]]
    [cards state]
      %gall
    ~|("citadel: attempting to mill a %gall app" !!)
  ==
::  *** grains
::  grain management.
::  saving to granary.
++  on-save-grain
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%save-grain -.action)
  =/  project  project.action
  ?.  (~(has by projects) project)
  ~|  "citadel: attempting to save grain to unknown project {<project>}"
  !!
  ?-    meal.action
      %rice
    =/  id  =<(id ;;(rice:smart +.grain.action))
    =/  =granary:mill
      =-  ?~  -  fake-granary:uq  -
      (biff (~(get by factory) project) same)
    =.  factory
      %+  ~(put by factory)  project
      %+  gas:big:uq  granary
      ~[[id ;;(grain:smart grain.action)]]
    [~ state]
      %wheat
    ~|("citadel: saving wheat not supported yet" !!)
  ==
::  deleting from granary.
++  on-delete-grain
  |=  =action
  ^-  (quip card _state)
  ?>  ?=(%delete-grain -.action)
  =/  =granary:mill
   =-  ?~  -  fake-granary:uq  -
  (biff (~(get by factory) project.action) same)
  =/  purged=granary:mill  (del:big:uq granary grain-id.action)
  `state(factory (~(put by factory) project.action purged))
::  * gear
::  constructs the cards needed to create a desk from a diagram.
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
      %hrd  rancher
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
::  installs integrated apps
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
