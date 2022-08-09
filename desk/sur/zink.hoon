|%
+$  granary-scry
  $-  ^
  (unit [path=(list phash) product=*])
::
+$  child  *
+$  parent  *
+$  phash  @                     ::  Pedersen hash
+$  hash-req
  $%  [%cell head=phash tail=phash]
      [%atom val=@]
  ==
::
+$  cairo-hint
  $%  [%0 axis=@ leaf=phash path=(list phash)]
      [%1 res=phash]
      [%2 subf1=phash subf2=phash]
      ::  encodes to
      ::   [3 subf-hash atom 0] if atom
      ::   [3 subf-hash 0 cell-hash cell-hash] if cell
      ::
      $:  %3
          subf=phash
          $=  subf-res
          $%  [%atom @]
              [%cell head=phash tail=phash]
          ==
      ==
      [%4 subf=phash atom=@]
      [%5 subf1=phash subf2=phash]
      [%6 subf1=phash subf2=phash subf3=phash]
      [%7 subf1=phash subf2=phash]
      [%8 subf1=phash subf2=phash]
      [%9 axis=@ subf1=phash leaf=phash path=(list phash)]
      [%10 axis=@ subf1=phash subf2=phash oldleaf=phash path=(list phash)]
      [%12 grain-id=@ leaf=phash path=(list phash)]  ::  leaf should be hash of grain-id, path is through granary
      [%cons subf1=phash subf2=phash]
      ::[%jet core=phash sample=* jet=@t]
  ==
:: subject -> formula -> hint
::+$  hints  (mip phash phash cairo-hint)
+$  hints  (list cairo-hint)
::  map of a noun's merkle children. root -> [left right]
+$  merk-tree  (map phash [phash phash])
::  map from jet tag to gas cost
+$  jetmap  (map @tas @ud)
::  Axis map of jets in stdlib
++  jets
  ::  TODO: determine *real* costs
  ::  these are totally made up placeholders
  %-  ~(gas by *jetmap)
  :~  ::  math
      [%add 1]  [%dec 1]  [%div 1]
      [%dvr 1]  [%gte 1]  [%gth 1]
      [%lte 1]  [%lth 1]  [%max 1]
      [%min 1]  [%mod 1]  [%mul 1]
      [%sub 1]
      ::  bits
      [%bex 1]  [%can 1]  [%cat 1]
      [%cut 1]  [%end 1]  [%fil 1]
      [%lsh 1]  [%met 1]  [%rap 1]
      [%rep 1]  [%rev 1]  [%rip 1]
      [%rsh 1]  [%run 1]  [%rut 1]
      [%sew 1]  [%swp 1]  [%xeb 1]
      ::  list
      [%turn 5]
      ::  sha
      [%sham 1.000]
      [%shax 1.000]
      [%shay 1.000]
      ::  etc
      [%need 1]
      [%scot 5]
      [%pedersen-hash 10]
    ==
--
