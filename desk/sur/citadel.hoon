/+  smart=zig-sys-smart
:: dia definitions
::
|%
::  * types
::  ** cards
+$  card  card:agent:gall
+$  cards  (list card)
::  * desk definitions
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
    [%desk from=desk name=@tas]
    [%diagram furm=(unit desk) =gram name=@tas]
    [%run =survey =bran:smart interface=lumps:smart types=lumps:smart]
    [%test =survey grains=(list grain:smart)]
    [%mill =survey =bran:smart interface=lumps:smart types=lumps:smart]
    [%save-grain meal=?(%rice %wheat) project=desk =grain:smart]
    [%save =survey]
    [%delete project=desk]
  ==
::
--
