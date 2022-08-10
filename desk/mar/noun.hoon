::
::::  /hoon/noun/mar
  ::
/?    310
!:
::::  A minimal noun mark
|_  non=*
++  grow
  |%
  ++  noun  *
  ++  mime  ;;(^mime non)
  --
++  grab  |%
          ++  noun  *
          ++  mime  |=([p=mite q=octs] (* q.q))
          --
++  grad
  |%
  ++  form  %noun
  ++  diff  |=(* +<)
  ++  pact  |=(* +<)
  ++  join  |=([* *] *(unit *))
  ++  mash  |=([[ship desk *] [ship desk *]] `*`~|(%noun-mash !!))
  --
--
