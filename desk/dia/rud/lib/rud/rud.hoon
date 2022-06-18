|%
    ::  our enemies, as stored in app state
    ::
    +$  enemies  (list @t)
    ::  a user action made to modify the $enemies
    ::
    +$  action
      $%  [%add enemy=@t]
          [%del index=@ud]
      ==
    --
