/+  default-agent, dbug
|%
+$  card  card:agent:gall
--
%-  agent:dbug
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
++  on-init
  ^-  (quip card _this)
  `this
++  on-save   on-save:def
++  on-load   on-load:def
++  on-poke
  ::  https://developers.urbit.org/reference/arvo/clay/tasks#next---await-next
  ::  TODO receive poke to start watching a desk
  ::  await next revision in clay for the desk.herd file in that desk
  ::  keep track of build desk for each dev desk in the state
  ::  TODO also await next revision of all other files
  ::  https://developers.urbit.org/reference/arvo/clay/scry#t---list-files
  ::  .^((list path) %ct /=some-desk-literal=/gen)
  ::  .^((list path) %ct /=[some-desk-value]=/gen)
  ::
  ::  https://developers.urbit.org/reference/arvo/clay/tasks#cancel-subscription
  ::  TODO receive poke to cancel subscription for a desk
  on-poke:def
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo
  ::  TODO when we see a change to desk.herd:
  ::  suspend build desk agents
  ::  do an %init merge from the dev desk
  ::  fuse all dependencies
  ::  revive build desk agents
  ::  TODO when we see a change to any other file:
  ::  merge dev desk into build desk
  on-arvo:def
++  on-fail   on-fail:def
--
