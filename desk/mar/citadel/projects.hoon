/-  *citadel
/+  *citadel
/+  *etch
=,  format
::
|_  state=state-1
::
++  grad  %noun
++  grow
  |%
  ++  tank  >projects.state<
  ++  noun  projects.state
  ++  json
    ^-  ^json
    =,  enjs
    =,  state
    =<
    :-  %a
    %+  turn  ~(tap by projects)
    |=  [project=desk deeds=(set ^deed)]
    %+  frond  project
    a+(turn ~(tap in deeds) deed)
    |%
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
  ++  noun  state
  --
--
