:: dia definitions
::
|%
::  +grounds - dependencies and workshops
::
+$  grounds  [=outpost =atelier]
::  +atelier - diagram paths
::
+$  atelier  (list path)
::  +outpost - dependency paths
::
+$  outpost  (map desk (list path))
::
+$  gram
  $:  nom=term
  $%  [%ent pokes=(list @tas)]    ::  agent
      ::[%rud =pages]               ::  agent with frontend
      [%gen =engine]              ::  generator
      [%ted =imps]                ::  thread
      [%cli =cmds]                ::  agent with cli
      [%hel ~]                    ::  hello world
      [%prt ~]                    ::  printers
  ==  ==
::  TODO customizable diagrams
::
+$  pokes  (unit @t)
+$  pages  (unit @t)
+$  engine  (unit @t)
+$  imps  (unit @t)
+$  cmds  (unit @t)
::
+$  app  [desk=term title=@t]
+$  action
  $%
    [%desk from=desk name=@tas]
    [%diagram furm=(unit desk) =gram name=@tas]
  ==
--
