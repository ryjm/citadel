/+  smart=zig-sys-smart, zink=zink-zink, merk
|%
++  big  (bi:merk id:smart grain:smart)  ::  merkle engine for granary
++  pig  (bi:merk id:smart @ud)          ::                for populace
::
+$  granary   (merk:merk id:smart grain:smart)
+$  populace  (merk:merk id:smart @ud)
+$  land      (pair granary populace)
::
+$  basket     (set [hash=@ux =egg:smart])   ::  transaction "mempool"
+$  carton     (list [hash=@ux =egg:smart])  ::  basket that's been prioritized
::
+$  diff  granary  ::  state transitions for one batch
+$  state-transition
  $:  =land
      processed=(list [id:smart egg:smart])
      hits=(list (list hints:zink))
      =diff
      crows=(list crow:smart)
      burns=granary
  ==
--