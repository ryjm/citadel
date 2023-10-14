/-  *citadel
/+  *citadel, default-agent, verb, dbug, pp=pprint,
    auto=language-server-complete, shoe, sole
::
|%
+$  card  card:shoe
::  * state
::
+$  versioned-state
  $%  state-0
      state-1
  ==
::
+$  state-0
  $:  %0
      audience=(set target)                         ::  active targets
      width=@ud                                     ::  display width
      eny=@uvJ                                      ::  entropy
  ==
+$  state-1
  $:  %1
      width=@ud                                     ::  display width
      eny=@uvJ                                      ::  entropy
      arena=?(%contract %gall)
  ==
::
::  * commands
+$  target  [in-group=? =ship =path]
::
+$  command
  $%
      [%help ~]                                     ::  print usage info
      [%desk desk (unit desk) (unit desk)]          ::  create a new desk
      [%update-kelvin (set desk) waft:clay]          ::  create a new desk
      [%colony desk]
      [%colonies ~]
      [%mode ~]
      [%toggle ~]
      [%settings ~]
  ==
::
::  * agent
--
=|  state-1
=*  state  -
::
%-  agent:dbug
%+  verb  |
^-  agent:gall
%-  (agent:shoe command)
^-  (shoe:shoe command)
=<
  |_  =bowl:gall
  +*  this       .
      citadel-core  +>
      cc         ~(. citadel-core(eny eny.bowl) bowl)
      def        ~(. (default-agent this %|) bowl)
      des        ~(. (default:shoe this command) bowl)
  ::
  ++  on-init
    ^-  (quip card _this)
    =^  cards  state  (prep:cc ~)
    [cards this]
  ::
  ++  on-save  !>(state)
  ::
  ++  on-load
    |=  old-state=vase
    ^-  (quip card _this)
    =/  maybe-old  (mule |.(!<(versioned-state old-state)))
    =/  old=versioned-state
      ?:  ?=(%| -.maybe-old)  *state-1  p.maybe-old
    =^  cards  state
    ?-  -.old
      %0  (prep:cc ~)
      %1  (prep:cc `old)
    ==
    [cards this]
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    =^  cards  state
      ?+  mark        (on-poke:def mark vase)
        %noun         (poke-noun:cc !<(* vase))
      ==
    [cards this]
  ::
  ++  on-watch  on-watch:def
  ++  on-leave  on-leave:def
  ++  on-peek   on-peek:def
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    =^  cards  state
      ?-    -.sign
        %poke-ack   [- state]:(on-agent:def wire sign)
        %watch-ack  [- state]:(on-agent:def wire sign)
      ::
          %kick
        :_  state
        ?+  wire  ~
          [%citadel ~]  ~[connect:cc]
        ==
      ::
          %fact
        ?+  p.cage.sign  ~|([%citadel-cli-bad-sub-mark wire p.cage.sign] !!)
            %citadel-delta
          ~|([%citadel-cli-bad-sub-mark wire p.cage.sign] !!)
        ==
      ==
    [cards this]
  ::
  ++  on-arvo  on-arvo:def
  ::
  ++  on-fail   on-fail:def
  ++  command-parser
    |=  =sole-id:sole
    parser:sh:cc
  ::
  ++  tab-list
    |=  =sole-id:sole
    =/  tuck
      |=  [term=cord detail=tank]
      [(cat 3 ';' term) detail]
    ;:  weld
      ~[['--common--' leaf+"common commands"]]
      %+  turn  comm:tab-list:sh:cc  tuck
      ?:  ?=(%contract arena)
      ::  ~[['--contract--' leaf+"contract commands"]]
        %+  turn  gall:tab-list:sh:cc  tuck
      ::  ~[['--gall--' leaf+"gall commands"]]
      %+  turn  gall:tab-list:sh:cc  tuck
    ==
  ::
  ++  on-command
    |=  [=sole-id:sole =command]
    =^  cards  state
      (work:sh:cc command)
    [cards this]
  ::
  ++  on-connect
    |=  =sole-id:sole
    ^-  (quip card _this)
    [[prompt:sh-out:cc ~] this]
  ::
  ++  can-connect     can-connect:des
  ++  on-disconnect   on-disconnect:des
  --
::
::  * helpers
=|  cards=(list card)
|_  =bowl:gall
::  ** misc
::  +this: self
::
++  this  .
::  +prep: setup & state adapter
::
++  prep
  |=  old=(unit versioned-state)
  ^-  (quip card _state)
  ?~  old
    =^  cards  state
      :-  ~[connect]
      %_  state
        width     80
      ==
    [cards state]
  [~ state(width 80)]
::
++  emit
  |=  car=card
  this(cards [car cards])
::  +emil: emit a list of cards
::
++  emil
  |=  rac=(list card)
  |-  ^+  this
  ?~  rac
    this
  =.  cards  [i.rac cards]
  $(rac t.rac)
::  +abet: finalize transaction
::
++  abet
  ^-  (quip card _state)
  [(flop cards) state]
::  +connect: connect to citadel
::
++  connect
  ^-  card
  [%pass /citadel %agent [our-self %citadel] %watch /citadel-primary]
::
++  our-self  our.bowl
::  +poke-noun: debug helpers
::
++  poke-noun
  |=  a=*
  ^-  (quip card _state)
  ?:  ?=(%connect a)
    abet:(emit connect)
  [~ state]
::  ** sh
::  +sh: handle user input
::
++  sh
  |%
  ::  +parser: command parser
  ::
  ::    parses the command line buffer.
  ::    produces commands which can be executed by +work.
  ::
  ++  parser
    |^
      %+  stag  |
      =-  ;~(pfix mic -)
      ;~  pose
        ;~(plug (tag %help) (easy ~))
        ;~(plug (tag %toggle) (easy ~))
        ;~(plug (tag %mode) (easy ~))
        ?:  =(%gall arena)
          gull
        gull
      ==
::  *** gall
    ++  gull
      ;~  pose
        ;~(plug (tag %help) (easy ~))
        ::  ;desk new-desk from-desk diagram
        ;~  plug  (tag %desk)
          spade
          dusk
          dusk
        ==
        ::  ;update-kelvin [deska deskb ~] [%zuse 418]
        ;~(plug (tag %update-kelvin) ;~(pfix ace ;~(pose dall spads)) ;~(pfix ace wuft))
        ;~(plug (tag %colony) spade)
        ;~(plug (tag %colonies) (easy ~))
        ;~(plug (tag %settings) (easy ~))
      ==
    ::
    ++  dall  (cold *(set desk) (jest '%all'))
    ++  wuft
      %+  cook  waft:clay
      ;~(plug ;~(pfix cen sym) ;~(pfix ace dem))
    ++  dusk  ;~(pose (cold ~ spado) (punt spade))
    ++  spado  ;~(pfix ace sig)
    ++  spade  ;~(pfix ace sym)
    ++  proj  ;~(pfix ace ;~(pfix cen sym))
    ++  spads
      %+  cook  ~(gas in *(set desk))
      (most ;~(plug com (star ace)) sym)
    ++  tag   |*(a=@tas (cold a (jest a)))
    ++  bool
      ;~  pose
        (cold %| (jest '%.y'))
        (cold %& (jest '%.n'))
      ==
  --
::  *** tab-list
  ::  +tab-list: static list of autocomplete entries
  ::
  ++  tab-list
    |%
    ++  comm
      ^-  (list [@t tank])
      :~
        [%help leaf+";help"]
        [%settings leaf+";settings"]
        [%toggle leaf+";toggle"]
        [%mode leaf+";mode"]
      ==
    ++  gall
      ^-  (list [@t tank])
      :~
      [%desk leaf+";desk [desk-name] [from (optional)] [diagram (optional)]"]
      [%update-kelvin leaf+";update-kelvin deska, deskb %zuse 418"]
      [%colony leaf+";colony [desk]"]
      [%colonies leaf+";colonies"]
      [%settings leaf+";settings"]
      ==
    --
::  ***  work
  ::  +work: run user command
  ::
  ++  work
    |=  job=command
    ^-  (quip card _state)
    =/  cmd  (print:sh-out "args: {<+.job>}")
    |^  ?-  -.job
          %help      abet:help
          %toggle    abet:toggle
          %desk      abet:(emit:(new-desk +.job) cmd)
          %colonies  abet:show-colonies
          %colony    abet:(show-colony +.job)
          %update-kelvin  abet:(emit:(update-kelvin +.job) cmd)
          %settings  abet:show-settings
          %mode  abet:help
        ==
    ::  +act: build action card
    ::
    ++  act
      |=  [what=term app=term =cage]
      ^-  card
      :*  %pass
          /cli-command/[what]
          %agent
          [our-self app]
          %poke
          cage
      ==
    ::  +show-settings: print enabled flags, timezone and width settings
    ::
    ++  show-settings
      ^+  this
      (emit (print:sh-out "width: {(scow %ud width)}"))
    ::
    ++  show-colonies
      ^+  this
      =/  colonies=(map desk outpost)
        (scry-for (map desk outpost) %citadel /colonies)
      %-  emil
      :~  (prant:sh-out ~[(vase-to-tank:pp !>(colonies))])
          (note:sh-out "end of colonies")
      ==
    ::
    ++  show-colony
      |=  =desk
      ^+  this
      =/  colony=(unit outpost)
        (scry-for (unit outpost) %citadel /colony/[desk])
      %-  emil
      :~  (prant:sh-out ~[(vase-to-tank:pp !>(colony))])
          (note:sh-out "end of colony")
      ==
    ::
    ++  new-desk
      |=  [title=@tas from=(unit @tas) gram=(unit @tas)]
      ^+  this
      ?^  gram  (new-estate from title (^gram title u.gram ~))
      %-  emil
      :~  (print:sh-out "creating desk: {(scow %tas title)}")
          ::
          %^  act  %desk  %citadel
          :-  %citadel-action
          !>  ^-  action
          [%desk ?~(from %base u.from) title]
      ==
      ::
      ++  new-estate
        |=  [from=(unit @tas) title=@tas style=gram]
        ^+  this
        %-  emil
        :~  (print:sh-out "diagram: {(scow %tas +<:style)}")
        %^  act  %diagram  %citadel
        :-  %citadel-action
        !>  ^-  action
        [%diagram from style title]
        ==
      ::
      ++  update-kelvin
        |=  [deks=(set desk) kelvin=*]
        ^+  this
        =+  .^  =dais:clay  %cb
        /(scot %p our.bowl)/base/(scot %da now.bowl)/kelvin
        ==
        =/  res  (mule |.((vale.dais kelvin)))
        ?:  ?=(%| -.res)
          ~|(%citadel-mark-fail (mean leaf+"citadel: failed to validate kelvin" p.res))
        =/  kelv=vase  +.res
        =*  byk  byk.bowl
        =+  .^(all=(set desk) %cd /(scot %p our.bowl)//(scot %da now.bowl))
        =.  all  (~(del in all) %base)
        =.  all  (~(del in all) %home)
        =.  all  (~(del in all) %kids)
        =/  desks  ?:  =(0 ~(wyt in deks))  all
          %-  ~(int in deks)  all
        ~&  >  update-kelvin+desks
        %-  emil
        %+  turn  ~(tap in desks)
        |=  =desk
        =/  =path  (en-beam byk(q desk) /sys/kelvin)
        :*  %pass  /file  %arvo  %c
            %info  (foal:space:userlib path kelvin+kelv)
        ==
    ::  +help: print (link to) usage instructions
    ::
    ++  help
      ^+  this
      %-  emit
      =-  (print-more:sh-out -)
      :~
        ">> {<arena>} mode ({<`@tas`(end [3 1] arena)>})"
        ">> see https://github.com/ryjm/citadel"
      ==
    ::  +toggle: switch arenas
    ::
    ++  toggle
      =.  arena  ?:(?=(%gall arena) %contract %gall)
      %-  emit
      prompt:sh-out
    --
  --
::
::  +sh-out: output to the cli
::
++  sh-out
  |%
  ::  +effect: console effect card
  ::
  ++  effect
    |=  effect=sole-effect:sole
    ^-  card
    [%shoe ~ %sole effect]
  ::  +print: puts some text into the cli as-is
  ::
  ++  prant
    |=  tal=(list tank)
    ^-  card
    (effect %tan tal)
  ::
  ++  print
    |=  txt=tape
    ^-  card
    (effect %txt ">> {txt}")
  ::  +print-more: puts lines of text into the cli
  ::
  ++  print-more
    |=  txs=(list tape)
    ^-  card
    %+  effect  %mor
    (turn txs |=(t=tape [%txt t]))
  ::  +note: prints left-padded ---| txt
  ::
  ++  note
    |=  txt=tape
    ^-  card
    =+  lis=(simple-wrap txt (sub width 16))
    %-  print-more
    =+  ?:((gth (lent lis) 0) (snag 0 lis) "")
    :-  (runt [14 '-'] '|' ' ' -)
    %+  turn  (slag 1 lis)
    |=(a=tape (runt [14 ' '] '|' ' ' a))
  ::  +prompt: update prompt to display current audience
  ::
  ++  prompt
    ^-  card
    %+  effect  %pro
    :+  &  %citadel-line
    ^-  tape
    " ({<`@tas`(end [3 1] arena)>})> "
  ::
  --
::
++  simple-wrap
  |=  [txt=tape wid=@ud]
  ^-  (list tape)
  ?~  txt  ~
  =/  [end=@ud nex=?]
    ?:  (lte (lent txt) wid)  [(lent txt) &]
    =+  ace=(find " " (flop (scag +(wid) `tape`txt)))
    ?~  ace  [wid |]
    [(sub wid u.ace) &]
  :-  (tufa (scag end `(list @)`txt))
  $(txt (slag ?:(nex +(end) end) `tape`txt))
::
++  scry-for
  |*  [=mold app=term =path]
  .^  mold
    %gx
    (scot %p our.bowl)
    app
    (scot %da now.bowl)
    (snoc `^path`path %noun)
  ==
--
