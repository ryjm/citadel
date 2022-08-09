/-  *mill
/+  smart=zig-sys-smart, zink=zink-zink
|%
+$  sequencer  (pair address:smart ship)
::
+$  availability-method
  $%  [%full-publish ~]
      [%committee members=(map address:smart [ship (unit sig:smart)])]
  ==
::
+$  town  [=land =hall]
::
+$  hall
  $:  town-id=id:smart
      batch-num=@ud
      =sequencer
      mode=availability-method
      latest-diff-hash=@ux
      roots=(list @ux)
  ==
::  capitol: tracks sequencer and state roots / diffs for all towns
+$  capitol  (map id:smart hall:sequencer)
::
+$  batch  ::  state transition
  $:  town-id=id:smart
      num=@ud
      mode=availability-method
      state-diffs=(list diff)
      diff-hash=@ux
      new-root=@ux
      new-state=land
      peer-roots=(map id:smart @ux)  ::  roots for all other towns (must be up-to-date)
      =sig:smart                     ::  sequencer signs new state root
  ==
::
+$  town-action
  $%  ::  administration
      $:  %init
          rollup-host=ship
          =address:smart
          private-key=@ux
          town-id=id:smart
          starting-state=(unit land)
          mode=availability-method
      ==
      [%clear-state ~]
      ::  transactions
      [%receive-assets assets=granary]
      [%receive eggs=(set egg:smart)]
      ::  batching
      [%trigger-batch ~]
  ==
::
+$  rollup-update
  $%  capitol-update
      town-update
  ==
+$  capitol-update  [%new-capitol =capitol]
+$  town-update
  $%  [%new-peer-root town-id=id:smart root=@ux timestamp=@da]
      [%new-sequencer town-id=id:smart who=ship]
  ==
::
::  indexer must verify root is posted to rollup before verifying new state
+$  indexer-update  [%update eggs=(list [@ux egg:smart]) =town root=@ux]
--
