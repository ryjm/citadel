/+  smart=zig-sys-smart, mill=zig-mill
:: dia definitions
::
|%
::  * types
::  ** cards
+$  card  card:agent:gall
+$  cards  (list card)
::  ** state
+$  state-0  [%0 colonies=(map desk outpost)]
::
+$  state-1
   $:  %1
       colonies=(map desk outpost)
       projects=(map desk (set deed))
       tests=(jar desk @t)
       ::  metadata=(map desk metadata)
   ==
+$  versioned-state
  $%  state-0
      state-1
  ==
+$  in-state
  $%  [%project project=(set deed)]
      [%projects projects=(map desk (set deed))]
      [%colonies colonies=(map desk outpost)]
      [%tests tests=(jar desk @t)]
  ==
::
+$  grounds  [=outpost =atelier]
::  +atelier - diagram paths
::
+$  atelier  (list path)
::  +outpost - dependency paths
::
+$  outpost  (map desk (list path))
::
::  ** diagrams
+$  gram
  $:  nom=term
  $=  temp
  $%  [%ent ~]    ::  agent
      ::[%rud =pages]               ::  agent with frontend
      [%gen =engine]              ::  generator
      [%ted =imps]                ::  thread
      [%cli =cmds]                ::  agent with cli
      [%hel ~]                    ::  hello world
      [%prt ~]                    ::  printers
      [%doc ~]                    ::  docs
      [%hrd ~]                    ::  herd
  ==  ==
+$  app  [desk=term title=@t]
::  *** customizable
::  TODO customizable diagrams
::
+$  pokes  (unit @t)
+$  pages  (unit @t)
+$  engine  (unit @t)
+$  imps  (unit @t)
+$  cmds  (unit @t)
::

::  * saving and running
+$  survey
    $:  arena=?(%contract %gall)
        deeds=(list deed)
        charter=@t
        project=desk
    ==
::
::  ** locations
+$  scroll  [text=(unit @t) project=(unit desk) =path]
+$  deed  [dir=?(%lib %sur %ted %mar) =scroll]
::
::  * actions
+$  action
  $%
    ::  desks
    [%desk from=desk name=@tas]
    [%diagram furm=(unit desk) =gram name=@tas]
    ::  projects
    [%save =survey]
    [%delete project=desk]
  ==
::
--
