/+  *zig-sys-smart
|%
+$  action
  $%  $:  %deploy
          mutable=?
          cont=[bat=* pay=*]
          interface=(map @tas lump)
          types=(map @tas lump)
          owns=(list [salt=@ label=@tas data=*])
      ==
      ::
      $:  %upgrade
          to-upgrade=[%grain =id]
          new-nok=[bat=* pay=*]
      ==
  ==
--