/+  smart=zig-sys-smart
|%
::
::  pokes
::
+$  action
  $%  [%set-sources towns=(list [town-id=id:smart (list ship)])]
      [%add-source town-id=id:smart =ship]  ::  added to end of priority list
      [%remove-source town-id=id:smart =ship]
  ==
::
+$  write
  $%  [%submit =egg:smart]
      [%receipt egg-hash=@ux ship-sig=[p=@ux q=ship r=life] uqbar-sig=sig:smart]
  ==
::
::  updates
::
+$  write-result
  $%  [%sent ~]
      [%receipt egg-hash=@ux ship-sig=[p=@ux q=ship r=life] uqbar-sig=sig:smart]
      [%rejected =ship]
      [%executed result=errorcode:smart]
      [%nonce value=@ud]
  ==
--
