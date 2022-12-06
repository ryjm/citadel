
/-  spider, *citadel
/+  *strandio, smart=zig-sys-smart, *citadel
::
=*  strand     strand:spider
=*  leave      leave:strandio
=*  take-fact  take-fact:strandio
=*  watch      watch:strandio
::
::  * import
::  imports the associated contract library
|^  import
++  import
  ^-  thread:spider
  |=  arg=vase
  =/  m  (strand ,vase)
  ^-  form:m
  =+  !<([~ contract=@tas] arg)
  =/  main=path  /lib/zig/contracts/lib/[contract]/hoon
  =/  tmp=path  /lib/zig/contracts/lib/tmp/[contract]/hoon
  ;<  =bowl:spider   bind:m  get-bowl
  =/  lib=tape  "/+  *zig-sys-smart"
  =/  old  .^(@t cx+(en-beam byk.bowl main))
  =/  new  (crip "{lib} {(trip old)}")
  ;<  ~  bind:m
    =-  (send-raw-card %pass / %arvo %c %info -)
    %+  foal:space:userlib
      ;:  weld
        /(scot %p our.bowl)/[q.byk.bowl]/(scot %da now.bowl)
        tmp
      ==
    [%hoon [[%atom %t ~] new]]
  ;<  ~  bind:m  (sleep ~s2)
  ;<  vax=(unit vase)  bind:m  (build-file [byk.bowl tmp])
  ?^  vax
    (pure:m u.vax)
  (strand-fail:strand %build-file >tmp< ~)
--
