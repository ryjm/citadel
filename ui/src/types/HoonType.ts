export type HoonType = '@' // @	Empty aura	100	(displays as @ud)
  | '@da' // @da	Date (absolute)	~2022.2.8..16.48.20..b53a	Epoch calculated from 292 billion B.C.
  | '@p' // @p	Ship name	~zod	
  | '@rs' // @rs	Number with fractional part	.3.1415	Note the preceding . dot.
  | '@t' // @t	Text (“cord”)	'hello'	One of Urbit's several text types; only UTF-8 values are valid.
  | '@ub' // @ub	Binary value	0b1100.0101	
  | '@ud' // @ud	Decimal value	100.000	Note that German-style thousands separator is used, . dot.
  | '@ux' // @ux	Hexadecimal value	0x1f.3c4b
  | '?' // boolean
  | '%unit' // maybe
  | '%set' // set
  | '%map' // map
