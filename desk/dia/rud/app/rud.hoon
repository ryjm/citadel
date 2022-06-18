/+  rudder, dbug, verb, default-agent
/-  *rudder
/~  pages  (page:rudder enemies action)  /app/rud/webui.hoon
::
|%
+$  state-0  [%0 enemies]
::
+$  eyre-id  @ta
+$  card  (wind note gift)
+$  gift  gift:agent:gall
+$  note  note:agent:gall
  :: $%  [%agent [ship %rud] task:agent:gall]
  ::     [%arvo %e %connect [~ %rud ~] term]
  :: ==
--
::
=|  state-0
=*  state  -
::
%-  agent:dbug
%+  verb  |
^-  agent:gall
::
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
::
++  on-init
  ^-  (quip card _this)
  =-  [- this]
  [%pass /eyre/connect %arvo %e %connect [~ /[dap.bowl]] dap.bowl]
::
++  on-save  !>(state)
::
++  on-load
  |=  ole=vase
  ^-  (quip card _this)
  =/  old=state-0  !<(state-0 ole)
  [~ this(state old)]
::
::::  this second example handles http requests using a fully custom rudder
::  setup. this should give a more thorough understanding of the functions
::  and flow that rudder uses.
::
++  on-poke
  ::  note that we do not include commentary that would be identical to
  ::  that in +on-poke-simple. please also see above if you missed it,
  ::  the following assumes some familiarity with the overall flow.
  ::
  |=  [=mark =vase]
  ^-  (quip card:agent:gall _this)
  ?>  =(%handle-http-request mark)
  =;  out=(quip card:agent:gall _enemies)
    [-.out this(enemies +.out)]
  %.  [bowl !<(order:rudder vase) enemies]
  ::  now the meat of the example: setting rudder up to handle requests
  ::  using custom callbacks.
  ::
  %:  (steer:rudder _enemies action)
    pages
  ::
    ::  the routing function takes a $trail as its only argument. this is
    ::  a destructured url, containing a :site path and optional file :ext.
    ::
    |=  =trail:rudder
    ::  a $place must be deduced from the :trail. this may fail, in which
    ::  case the fallback function gets called instead.
    ::  a $place is either a %page, with an authentication requirement flag
    ::  and a page name, or an %away, redirecting to a different path.
    ::
    ^-  (unit place:rudder)
    ::  because we are bound to /enemies, all requests coming into this app
    ::  are going to have that prefix in the :trail. we use the +decap helper
    ::  to get rid of that. if it fails, something's wrong, and we give up.
    ::
    ?~  site=(decap:rudder /enemies site.trail)  ~
    ::  we provide routes for a few pages:
    ::  /enemies          ->  the example page, requires login
    ::  /enemies/index    ->  redirects to /enemies
    ::  /enemies/hitlist  ->  some imaginary bounty listing, publicly viewable
    ::
    ?+  u.site  ~
      ~             `[%page & %page-example]
      [%index ~]    `[%away (snip site.trail)]
      [%hitlist ~]  `[%page | %hitlist]
    ==
  ::
    ::  the fallback function takes an $order as its only argument. this is
    ::  the full http request, as we extracted from the poke at the start of
    ::  this arm.
    ::
    |=  =order:rudder
    ::  it must produce effects and possibly-updated data. for convenience,
    ::  the effects here include an optional $reply, for which rudder will
    ::  handle the sending if it's included.
    ::
    ^-  [[(unit reply:rudder) (list card:agent:gall)] _enemies]
    ::  because we have access to the full request, and can produce any
    ::  effects we desire, all bets are off here. this might come in handy
    ::  when wanting to do such things as delayed responses, for example.
    ::  we could store the request id in the data and set a timer, or run
    ::  some asynchronous request, so that the app can formulate and send
    ::  a response later on.
    ::  for our example, we simply issue a custom 404 message.
    ::
    =;  msg=@t  [[`[%code 404 msg] ~] enemies]
    %+  rap  3
    :~  'as of '
        (scot %da (div now.bowl ~d1))
        ', '
        url.request.order
        ' is still mia...'
    ==
  ::
    |=  act=action
    ^-  $@(@t [brief:rudder (list card:agent:gall) _enemies])
    ?-  -.act
      %add  ``(snoc enemies enemy.act)
      %del  ``(oust [index.act 1] enemies)
    ==
  ==
::
++  on-agent
  ^-  (quip card _this)
  ?.  ?=([%hey ~] wire)  [~ this]
  =-  [~ this(receipts -)]
  ?+  -.sign  ~|([%unexpected-agent-sign wire -.sign] !!)
    %poke-ack  (~(put by receipts) src.bowl ?=(~ p.sign))
  ==
::
++  on-peek  on-peek:def
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+  sign-arvo  (on-arvo:def wire sign-arvo)
      [%eyre %bound *]
    ~?  !accepted.sign-arvo
      [dap.bowl 'eyre bind rejected!' binding.sign-arvo]
    [~ this]
  ==
::
++  on-leave  on-leave:def
++  on-fail   on-fail:def
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card:agent:gall _this)
  ?>  =(%handle-http-request mark)
  =;  out=(quip card:agent:gall _enemies)
    [-.out this(enemies +.out)]
  %.  [bowl !<(order:rudder vase) enemies]
  ::  now the meat of the example: setting rudder up to handle requests
  ::  using custom callbacks.
  ::
  %:  (steer:rudder _enemies action)
    pages
  ::
    ::  the routing function takes a $trail as its only argument. this is
    ::  a destructured url, containing a :site path and optional file :ext.
    ::
    |=  =trail:rudder
    ::  a $place must be deduced from the :trail. this may fail, in which
    ::  case the fallback function gets called instead.
    ::  a $place is either a %page, with an authentication requirement flag
    ::  and a page name, or an %away, redirecting to a different path.
    ::
    ^-  (unit place:rudder)
    ::  because we are bound to /enemies, all requests coming into this app
    ::  are going to have that prefix in the :trail. we use the +decap helper
    ::  to get rid of that. if it fails, something's wrong, and we give up.
    ::
    ?~  site=(decap:rudder /enemies site.trail)  ~
    ::  we provide routes for a few pages:
    ::  /enemies          ->  the example page, requires login
    ::  /enemies/index    ->  redirects to /enemies
    ::  /enemies/hitlist  ->  some imaginary bounty listing, publicly viewable
    ::
    ?+  u.site  ~
      ~             `[%page & %page-example]
      [%index ~]    `[%away (snip site.trail)]
      [%hitlist ~]  `[%page | %hitlist]
    ==
  ::
    ::  the fallback function takes an $order as its only argument. this is
    ::  the full http request, as we extracted from the poke at the start of
    ::  this arm.
    ::
    |=  =order:rudder
    ::  it must produce effects and possibly-updated data. for convenience,
    ::  the effects here include an optional $reply, for which rudder will
    ::  handle the sending if it's included.
    ::
    ^-  [[(unit reply:rudder) (list card:agent:gall)] _enemies]
    ::  because we have access to the full request, and can produce any
    ::  effects we desire, all bets are off here. this might come in handy
    ::  when wanting to do such things as delayed responses, for example.
    ::  we could store the request id in the data and set a timer, or run
    ::  some asynchronous request, so that the app can formulate and send
    ::  a response later on.
    ::  for our example, we simply issue a custom 404 message.
    ::
    =;  msg=@t  [[`[%code 404 msg] ~] enemies]
    %+  rap  3
    :~  'as of '
        (scot %da (div now.bowl ~d1))
        ', '
        url.request.order
        ' is still mia...'
    ==
  ::
    |=  act=action
    ^-  $@(@t [brief:rudder (list card:agent:gall) _enemies])
    ?-  -.act
      %add  ``(snoc enemies enemy.act)
      %del  ``(oust [index.act 1] enemies)
    ==
  ==
--
::
::  following seas to ye!
