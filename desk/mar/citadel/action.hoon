/-  *citadel
/+  *etch
=,  format
::
|_  act=action
::
++  grow
  |%
  ++  tank  >act<
  ++  noun  act
  ++  json
    |=  act=action
    ^-  ^json
    =,  enjs
    =<
    ?-    -.act
        %delete
      (frond %delete s+project.act)
        %run
      %+  frond  %run
      %-  pairs
        :~  ['arena' s+arena.survey.act]
            ['deeds' a+(turn deeds.survey.act |=(g=^deed (deed g)))]
            ['charter' s+charter.survey.act]
            ['bran' (en-vase !>(bran.act))]
            ['interface' (en-vase !>(interface.act))]
            ['types' (en-vase !>(types.act))]
        ==
        %save
      %+  frond  %save
      %-  pairs
        :~  ['arena' s+arena.survey.act]
            ['deeds' a+(turn deeds.survey.act |=(d=^deed (deed d)))]
            ['charter' s+charter.survey.act]
        ==
        %desk
      %+  frond  %desk
      %-  pairs
        :~  ['from' s+from.act]
            ['name' s+name.act]
        ==
        %diagram
      %+  frond  %diagram
      %-  pairs
        :~  ['furm' ?~(furm.act ~ s+u.furm.act)]
            ['gram' (gram gram.act)]
            ['name' s+name.act]
        ==
    ==
    |%
    ++  gram
      |=  g=^gram
      %-  pairs
      :~  ['nom' s+nom.g]
          ['temp' [%s -.temp.g]]
      ==
    ::
    ++  deed
      |=  d=^deed
      %-  pairs
      :~  dir+s+dir.d
          scroll+(scroll scroll.d)
      ==
    ++  scroll
      |=  s=^scroll
      %-  pairs
      =/  text
        ?~(text.s ~ s+u.text.s)
      =/  project
        ?~(project.s ~ s+u.project.s)
      :~  text+text
          project+project
          path+(path path.s)
      ==
    --
  --
::
++  grab
  |%
  ++  noun  action
  ++  json
    |=  jon=^json  ^-  action
    =,  dejs:format
    =-  ~!  -  -
    %.  jon
    =<  %-  of  :~
      save+survey
      run+run
      delete+(su sym)
    ==
    |%
    ++  run
      %-  ot
      :~  survey+survey
          bran+(at [ni ni ni ni])
          interface+lumps
          types+lumps
      ==
    ++  lumps  ~
    ++  survey
      ^-  $-(json ^survey)
      %-  ot
      :~  arena+(cu |=(t=@ ;;(?(%contract %gall) t)) (su sym))
          deeds+(ar deed)
          charter+so
      ==
    ++  deed
      ^-  $-(json ^deed)
      %-  ot
      :~
        dir+(cu |=(t=@ ;;(?(%lib %sur %mar %ted) t)) (su sym))
        scroll+scroll
      ==
    ++  scroll
      ^-  $-(json ^scroll)
      %-  ot
      :~
        text+(mu so)
        project+(mu (se %tas))
        path+(su ;~(pfix fas ;~((glue fas) (more fas sym))))
      ==
    ::  ++  run
    ::    (ot survey+survey)
    ::  ::
    ::  ++  save
    ::    (ot survey+survey)
    --
  --
--
