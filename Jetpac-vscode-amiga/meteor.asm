  Section    ChipRAM,Data_c

;          <- - - - 16 bits - - - - ->
;          ___________________________  __
;      |  |                           |   |    Each group of words
;         |      VSTART, HSTART       |   |    defines one vertical
;      |  |---------------------------|   |    usage of a sprite.
;         |    VSTOP, control bits    |   |--- Each one contains the
;      |  |___________________________|   |    starting location and
;                                         |    physical appearance
;      |   ___________________________  - | -  of this sprite image.

metOne:
  dc.w       $608c,$6c00
  dc.w       $0810,$0000       ; Data_1
  dc.w       $1e80,$0000
  dc.w       $2fa4,$0000
  dc.w       $43da,$0000
  dc.w       $b9e4,$0000
  dc.w       $c7f7,$0000
  dc.w       $9fc9,$0000
  dc.w       $c7e4,$0000
  dc.w       $718a,$0000
  dc.w       $3740,$0000
  dc.w       $1f40,$0000
  dc.w       $0000,$0000
  dc.w       $0000,$0000
  dc.w       $0000,$0000
  dc.w       $0000,$0000
  dc.w       $0000,$0000

;  dc.w       $0000,$0480
;  dc.w       $0000,$0FC0
;  dc.w       $0000,$1B60
;  dc.w       $0000,$1B60
;  dc.w       $0000,$3FD0
;  dc.w       $0000,$7A48
;  dc.w       $0000,$7FE8
;  dc.w       $0000,$7FFC
;  dc.w       $0000,$7FF8
;  dc.w       $0000,$3FF0
;  dc.w       $0000,$17A0
;  dc.w       $0000,$0840
;  dc.w       $0000,$0000

meteorOneX:
  dc.b       0
  dc.b       0

meteor_y:
  dc.b       0
  dc.b       0

metTwo:
  dc.w       $506c,$6000
  dc.w       $0248,$0000       ; Data_2
  dc.w       $2958,$0000
  dc.w       $57d6,$0000
  dc.w       $fffa,$0000
  dc.w       $7ffc,$0000
  dc.w       $f99f,$0000
  dc.w       $366c,$0000
  dc.w       $766f,$0000
  dc.w       $f99e,$0000
  dc.w       $7ffc,$0000
  dc.w       $bfb2,$0000
  dc.w       $2ff0,$0000
  dc.w       $1768,$0000
  dc.w       $2250,$0000
  dc.w       $0000,$0000
  dc.w       $0000,$0000

meteorTwoX:
  dc.b       0
  dc.b       0

; metThree:
;   dc.w       $505c,$5c00
;   dc.w       $0000,$0400
;   dc.w       $0000,$1550
;   dc.w       $0000,$7ff0
;   dc.w       $0000,$7ff8
;   dc.w       $0000,$3ff8
;   dc.w       $0000,$fb78
;   dc.w       $0000,$3df0
;   dc.w       $0000,$fdf0
;   dc.w       $0000,$7b78
;   dc.w       $0000,$3ff8
;   dc.w       $0000,$5ff8
;   dc.w       $0000,$1ff0
;   dc.w       $0000,$1fe0
;   dc.w       $0000,$1d90
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000

; meteorThreeX:
;   dc.b       0
;   dc.b       0

; metFour:
;   dc.w       $508c,$5c00
;   dc.w       $0300,$0000
;   dc.w       $0680,$0000
;   dc.w       $0780,$0000
;   dc.w       $0780,$0000
;   dc.w       $0480,$0000
;   dc.w       $7ff8,$0000
;   dc.w       $54ec,$0000
;   dc.w       $74fc,$0000
;   dc.w       $7ff8,$0000
;   dc.w       $2ec0,$0000
;   dc.w       $0780,$0000
;   dc.w       $0480,$0000
;   dc.w       $0780,$0000
;   dc.w       $0380,$0000
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000

; meteorFourX:
;   dc.b       0
;   dc.b       0

; metFive:
;   dc.w       $508c,$5c00
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000
;   dc.w       $1c00,$0000
;   dc.w       $3f80,$0000
;   dc.w       $63e0,$0000
;   dc.w       $fff8,$0000
;   dc.w       $ff80,$0000
;   dc.w       $cd80,$0000
;   dc.w       $fff8,$0000
;   dc.w       $63f8,$0000
;   dc.w       $3f80,$0000
;   dc.w       $1c00,$0000
;   dc.w       $1000,$0000
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000

; meteorFiveX:
;   dc.b       0
;   dc.b       0

; metSix:
;   dc.w       $608c,$6c00
;   dc.w       $0000,$0480
;   dc.w       $0000,$0FC0
;   dc.w       $0000,$1B60
;   dc.w       $0000,$1B60
;   dc.w       $0000,$3FD0
;   dc.w       $0000,$7A48
;   dc.w       $0000,$7FE8
;   dc.w       $0000,$7FFC
;   dc.w       $0000,$7FF8
;   dc.w       $0000,$3FF0
;   dc.w       $0000,$17A0
;   dc.w       $0000,$0840
;   dc.w       $0000,$0000

; meteorSixX:
;   dc.b       0
;   dc.b       0

; metSeven:
;   dc.w       $508c,$5c00
;   dc.w       $0000,$0000
;   dc.w       $1c00,$1c00
;   dc.w       $4fc0,$4fc0
;   dc.w       $7fb0,$7fb0
;   dc.w       $4700,$4700
;   dc.w       $1fc0,$1fc0
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000

; meteorSevenX:
;   dc.b       0
;   dc.b       0

; metEight:
;   dc.w       $508c,$5c00
;   dc.w       $0000,$0200
;   dc.w       $0000,$0f80
;   dc.w       $0000,$1fc0
;   dc.w       $0000,$7ff0
;   dc.w       $0000,$fff8
;   dc.w       $0000,$7ff0
;   dc.w       $0000,$3fe0
;   dc.w       $0000,$0000

; meteorEightX:
;   dc.b       0
;   dc.b       0

; ;	CNOP 0,4
; ;	CNOP 0,4