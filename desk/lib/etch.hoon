|%
+$  kind  ::  $type subset for printing
  $@  %noun
  $%  [%cell p=kind q=kind]
      [%atom p=@tas q=(unit @)]
      [%face p=@tas q=kind]
      [%fork p=(set type)]
      [%hold p=type q=hoon]
  ==
++  en-vase
  |=  [typ=type arg=*]
  ^-  json
  ?-    typ
      %void  !!
      %noun      (en-noun arg)
      [%atom *]  (en-dime p.typ ;;(@ arg))
      [%cell *]
    =/  hed=json  $(typ p.typ, arg -.arg)
    =/  tal=json  $(typ q.typ, arg +.arg)
    ::  unify objects (tuples with faces)
    ::
    ?:  ?&  !!?=([%o ^] hed)
            !!?=([%o ^] tal)
        ==
      [%o (~(uni by ?>(?=(%o -.hed) p.hed)) ?>(?=(%o -.tal) p.tal))]
    ::  unify arrays into a tuple
    ::
    ?:  ?=([%a *] tal)
      [%a hed p.tal]
    ::  simple cell
    ::
    [%a hed tal ~]
  ::
      [%core *]  !!
      [%face *]  [%o (malt `(list [@t json])`[;;(@t p.typ) $(typ q.typ)]~)]
      [%fork *]
    =/  tyz  (turn ~(tap in p.typ) peel)  ::  unwrap each fork
    =.  tyz                               ::  flatten fork of forks
      %-  zing
      %+  turn  tyz
      |=  tep=type
      ^-  (list type)
      ?:(?=(%fork -.tep) ~(tap in p.tep) [tep]~)
    ::~&  fork/(turn tyz kind)
    ::  unwrap single-case fork
    ::
    ?:  =(1 (lent tyz))
      $(typ (head tyz))
    ::  $?
    ::
    ?:  (levy tyz |=(t=type ?=(%atom -.t)))
      =/  aura
        =/  hid  (head tyz)
        ?>(?=([%atom @ *] hid) p.hid)
      ?>  (levy tyz |=(t=type ?>(?=([%atom * *] t) =(aura p.t))))
      (en-dime aura ;;(@ arg))
    ::  $%
    ::
    ?:  (levy tyz |=(t=type ?=([%cell [%atom * ^] *] t)))
      =/  aura
        =/  hid  (head tyz)
        ?>(?=([%cell [%atom @ ^] *] hid) p.p.hid)
      ::
      =/  val  ;;(@ -.arg)
      ?>  ((sane aura) val)
      =/  tag  ?:(?=(?(%t %ta %tas) aura) val (scot aura val))
      =/  tin=type
        |-  ^-  type
        ?~  tyz  !!
        ?>  ?=([%cell [%atom @ ^] *] i.tyz)
        =/  tug   u.q.p.i.tyz
        ?:  =(val tug)
          q.i.tyz
        $(tyz t.tyz)
      ::
      :-  %o
      %-  malt  ^-  (list [@t json])
      :~  [%tag s/tag]
          [%val $(typ tin, arg +.arg)]
      ==
    ::  non-$% fork of cells
    ::
    ?:  (levy tyz |=(t=type ?=([%cell *] t)))
      ~|  cell-fork/tyz
      !!
    ::  $@
    ::
    =/  [atoms=(list type) cells=(list type)]
      (skid tyz |=(t=type ?=(%atom -.t)))
    ?@  arg
      $(p.typ (sy atoms))
    $(p.typ (sy cells))
  ::
      [%hint *]  $(typ q.typ)
      [%hold *]  $(typ (~(play ut p.typ) q.typ))
  ==
::  +peel: recursively unwrap type (note: doesn't unwrap forks)
::
++  peel
  |=  typ=type
  ^-  type
  ?+  typ  typ
    %void      !!
    [%cell *]  [%cell $(typ p.typ) $(typ q.typ)]
    [%face *]  $(typ q.typ)
    [%hint *]  $(typ q.typ)
    [%hold *]  $(typ (~(play ut p.typ) q.typ))
  ==
::
++  en-noun
  |=  arg=*
  ^-  json
  ?@  arg
    (en-dime %$ arg)
  [%a ~[$(arg -.arg) $(arg +.arg)]]
::
++  en-dime
  |=  [aura=@tas dat=@]
  ^-  json
  ?+    aura  $(aura %ud)
      %c
    !!
  ::
      %da
    !!
  ::
      %dr
    !!
  ::
      %f  [%b ;;(? dat)]
      %n  ~
      %p  [%s (scot %p dat)]
      %q  [%s (scot %q dat)]
  ::
      ?(%rh %rq %rd %rs)
    !!
  ::
      %s
    !!
  ::
      ?(%t %ta %tas)  [%s dat]
      %ub
    !!
  ::
      %uc
    !!
  ::
      ?(%ud %ui)  [%n `@t`(rsh [3 2] (scot %ui dat))]
      %ux
    !!
  ::
      %uv
    !!
  ::
      %uw
    !!
  ::
  ==
--
