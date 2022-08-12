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
        %save-test
      %+  frond  %save-test
      %-  pairs
      :~  ['project' s+project.act]
          ['test' s+test.act]
          ['overwrite' b+overwrite.act]
      ==
        %delete-grain
      %+  frond  %delete-grain
      %-  pairs
      :~  ['project' s+project.act]
          ['grain-id' s+(scot %ux grain-id.act)]
      ==
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
      ::
        %mill
      %+  frond  %mill
      %-  pairs
        :~  ['arena' s+arena.survey.act]
            ['deeds' a+(turn deeds.survey.act |=(g=^deed (deed g)))]
            ['charter' s+charter.survey.act]
            ['bran' (en-vase !>(bran.act))]
            ['interface' (en-vase !>(interface.act))]
            ['types' (en-vase !>(types.act))]
        ==
      ::
        %save-grain
      %+  frond  %save-grain
      %-  pairs
        :~  ['meal' s+meal.act]
            ['project' s+project.act]
            ['grain' (en-vase !>(grain.act))]
        ==
    ::
      %test
      %+  frond  %test
      %-  pairs
        :~  ['survey' (survey survey.act)]
            ['contract-id' ?~(contract-id.act ~ s+(scot %ux u.contract-id.act))]
            ['grains' ~]
            :-  'yolks'
            =;  yolker
              a+(turn yolks.act yolker)
            |*  y=yolk:smart
            =-  ~&  >  [y - (render-hoon (ream (crip "{<yolks.act>}")))]  -
            s+(crip "{<q.y>}")
        ==
      ::
        %save
      %+  frond  %save
      %-  pairs
        :~  ['arena' s+arena.survey.act]
            ['deeds' a+(turn deeds.survey.act |=(d=^deed (deed d)))]
            ['charter' s+charter.survey.act]
        ==
      ::
        %desk
      %+  frond  %desk
      %-  pairs
        :~  ['from' s+from.act]
            ['name' s+name.act]
        ==
      ::
        %diagram
      %+  frond  %diagram
      %-  pairs
        :~  ['furm' ?~(furm.act ~ s+u.furm.act)]
            ['gram' (gram gram.act)]
            ['name' s+name.act]
        ==
    ==
    |%
    ++  survey
      |=  s=^survey
      %-  pairs
        :~  ['arena' s+arena.s]
            ['deeds' a+(turn deeds.s |=(d=^deed (deed d)))]
            ['charter' s+charter.s]
            ['project' s+project.s]
        ==
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
      mill+mill
      save-grain+save-grain
      delete+(su sym)
      delete-grain+delete-grain
      save-test+(ot ~[project+(se %tas) test+so override+bo])
      test+test
    ==
    |%
    ++  save-grain
      %-  ot
      :~  meal+(cu |=(t=@ ;;(?(%rice %wheat) t)) (su sym))
          project+(se %tas)
          grain+grain
      ==
    ++  delete-grain
      %-  ot
      :~  project+(se %tas)
          grain-id+(se %ux)
      ==
    ++  grain
      ^-  $-(json grain:smart)
      ::=-  (at ~[(cu |*(* %&) bo) -])
      =;  ric
        |=(jon=json [%& (ric jon)])
      ^-  $-(json rice:smart)
      =-  (ot ~[['.y' -]])
      |=  jon=json
      (rice jon)
   ++  wheat
      ^-  $-(json wheat:smart)
      |=  jon=json
      *wheat:smart
    ++  rice
      ^-  $-(json rice:smart)
      %-  ot
      :~
        salt+ni
        label+so
        data+grain-data
        id+(se %ux)
        lord+(se %ux)
        holder+(se %ux)
        town-id+(se %ux)
      ==
    ++  yolk
      ^-  $-(json yolk:smart)
      =;  yolker
        (cu yolker so)
      |=  y=@t
      %-  road  |.
      ;;(yolk:smart q:(slap !>(~) (ream y)))
    ++  test
      %-  ot
      :~  survey+survey
          contract-id+(mu (se %ux))
          =-  :-  %grains  -
          %+  corl  (bond =>(_smart |.(*(list grain:smart))))
            (ar:dejs-soft:format (corl some grain))
          =-  :-  %yolks  -
          %+  corl  (bond =>(_smart |.(*(list yolk:smart))))
            (ar:dejs-soft:format (corl some yolk))
      ==
    ++  run
      %-  ot
      :~  survey+survey
          bran+(at [ni ni ni ni ~])
          interface+lumps
          types+lumps
      ==
    ++  mill
      %-  ot
      :~  survey+survey
          bran+(at [ni ni ni ni ~])
          interface+lumps
          types+lumps
      ==
    ++  lumps
      |=  jon=json
      *lumps:smart
    ::
    ++  grain-data
      |=  jon=json
      `*`jon

    ++  survey
      ^-  $-(json ^survey)
      %-  ot
      :~  arena+(cu |=(t=@ ;;(?(%contract %gall) t)) (su sym))
          deeds+(ar deed)
          charter+so
          project+(se %tas)
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
