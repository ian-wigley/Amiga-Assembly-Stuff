
    INCLUDE "Dev:Intro_Demo-Code/Minimal/Include/BareMetal.i"

    section text,code_c

start:
    move.l 4.w,a6            ; Get base of exec lib
    lea gfxlib(pc),a1        ; Address of gfxlib string to a1
    jsr -408(a6)             ; Call OpenLibrary()
    move.l d0,gfxbase        ; Save base of graphics.library
    bsr configureBitPlanes

    lea     $dff000,a5         ; set the hardware registers base address to a5
    lea.l   copper,a0          ; set the copper list pointer in a0
    move.l  a0,COP1LC(a5)      ; Set the copper list pointer into COP1LC (copper list one hardware address), effectively move.w a0,$dff080
    move.w  #$8080,DMACON(a5)  ; enable bit 7 (copper DMA active) and 15 (DMA active), effectively move.w #$8080,$dff096
    move.w  #$8010,INTENA(a5)  ; enable copper interrupt

  rast:
    cmp.b #$ff,$00dff006
    bne rast

    move.b $bfec01,d0          ; Check if the escape Key
    eor.b #$ff,d0              ; has been pressed
    ror.b #1,d0
    cmp.b #$45,d0              ; No, continue
    beq.s exit
    btst #6,$bfe001            ; Left mouse clicked ?
    bne.b rast                 ; No, continue loop!
exit:
;    bsr stop_muzak
    move.l gfxbase(pc),a1   ; Base of graphics.library to a1
    move.l 38(a1),COP1LC(a5); Restore the copper list
    jsr -414(a6)            ; Call CloseLibrary()
    moveq #0,d0             ; Over..
    rts                     ; and out!

; Stuff
; *****

gfxlib:     dc.b    "graphics.library",0,0
gfxbase:    dc.l    0,0,0

configureBitPlanes:

    lea.l lostLogo+1520,a1
    lea.l logoBplOneHigh,a3   ; Get a pointer to the $e0 address
    lea.l logoBplOneLow,a2    ; Get a pointer to the $e2 address
    move.l a1,d1              ; Copy pointer address into d1
    move.w d1,(a2)            ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2            ; Copy the data from the pointer into d3
    swap d1                   ; Flip d1
    move.w d1,(a3)            ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3            ; Copy the data from the pointer into d3

    lea.l lostLogo+1520+10240,a1
    lea.l logoBplTwoHigh,a3   ; Get a pointer to the $e0 address
    lea.l logoBplTwoLow,a2    ; Get a pointer to the $e2 address
    move.l a1,d1              ; Copy pointer address into d1
    move.w d1,(a2)            ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2            ; Copy the data from the pointer into d3
    swap d1                   ; Flip d1
    move.w d1,(a3)            ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3            ; Copy the data from the pointer into d3

    lea.l lostLogo+1520+20480,a1
    lea.l logoBplThreeHigh,a3 ; Get a pointer to the $e0 address
    lea.l logoBplThreeLow,a2  ; Get a pointer to the $e2 address
    move.l a1,d1              ; Copy pointer address into d1
    move.w d1,(a2)            ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2            ; Copy the data from the pointer into d3
    swap d1                   ; Flip d1
    move.w d1,(a3)            ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3            ; Copy the data from the pointer into d3

    lea.l lostLogo+1520+30720,a1
    lea.l logoBplFourHigh,a3  ; Get a pointer to the $e0 address
    lea.l logoBplFourLow,a2   ; Get a pointer to the $e2 address
    move.l a1,d1              ; Copy pointer address into d1
    move.w d1,(a2)            ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2            ; Copy the data from the pointer into d3
    swap d1                   ; Flip d1
    move.w d1,(a3)            ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3            ; Copy the data from the pointer into d3

    lea.l lostLogo+1520+40960,a1
    lea.l logoBplFiveHigh,a3  ; Get a pointer to the $e0 address
    lea.l logoBplFiveLow,a2   ; Get a pointer to the $e2 address
    move.l a1,d1              ; Copy pointer address into d1
    move.w d1,(a2)            ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2            ; Copy the data from the pointer into d3
    swap d1                   ; Flip d1
    move.w d1,(a3)            ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3            ; Copy the data from the pointer into d3
    rts

copper:
    dc.w    FMODE,$0000 ; AGA compatible
    dc.w    DMACON,$0020

    dc.w    DIWSTRT,$2c41
    dc.w    DIWSTOP,$2cc1

    dc.w    DDFSTRT,$0038 ; 34
    dc.w    DDFSTOP,$00d0 ; cc

    dc.w    BPLCON0,$5200
    dc.w    BPLCON1,$0000
    dc.w    BPLCON3,$0000
    dc.w    BPL1MOD,$0000 ; 28
    dc.w    BPL2MOD,$0000 ; 28

    dc.w    BPL1PTH
logoBplOneHigh:
    dc.w    $0000
    dc.w    BPL1PTL
logoBplOneLow:
    dc.w    $0000

    dc.w    BPL2PTH
logoBplTwoHigh:
    dc.w    $0000
    dc.w    BPL2PTL
logoBplTwoLow:
    dc.w    $0000

    dc.w    BPL3PTH
logoBplThreeHigh:
    dc.w    $0000
    dc.w    BPL3PTL
logoBplThreeLow:
    dc.w    $0000

    dc.w    BPL4PTH
logoBplFourHigh:
    dc.w    $0000
    dc.w    BPL4PTL
logoBplFourLow:
    dc.w   $0000

    dc.w    BPL5PTH
logoBplFiveHigh:
    dc.w    $0000
    dc.w    BPL5PTL
logoBplFiveLow:
    dc.w   $0000

;    dc.w    COLOR0,$0000
    dc.w    COLOR1,$0104
    dc.w    COLOR2,$0105
    dc.w    COLOR3,$0116
    dc.w    COLOR4,$0217
    dc.w    COLOR5,$0228
    dc.w    COLOR6,$0338
    dc.w    COLOR7,$0349
    dc.w    COLOR8,$045a
    dc.w    COLOR9,$066b
    dc.w    COLOR10,$078c
    dc.w    COLOR11,$089d
    dc.w    COLOR12,$08ac
    dc.w    COLOR13,$0cdf
    dc.w    COLOR14,$0fff
    dc.w    COLOR15,$0000
    dc.w    COLOR16,$0000

    dc.w    $3a01,$ff00
    dc.w    COLOR0,$0000
    dc.w    $3b01,$ff00
    dc.w    COLOR0,$0111
    dc.w    $3c01,$ff00
    dc.w    COLOR0,$0333
    dc.w    $3d01,$ff00
    dc.w    COLOR0,$0555
    dc.w    $3e01,$ff00
    dc.w    COLOR0,$0777
    dc.w    $3f01,$ff00
    dc.w    COLOR0,$0999
    dc.w    $4001,$ff00
    dc.w    COLOR0,$0bbb
    dc.w    $4101,$ff00
    dc.w    COLOR0,$0ddd
    dc.w    $4201,$ff00
    dc.w    COLOR0,$0fff
    dc.w    $4301,$ff00
    dc.w    COLOR0,$0ddd
    dc.w    $4401,$ff00
    dc.w    COLOR0,$0bbb
    dc.w    $4501,$ff00
    dc.w    COLOR0,$0999
    dc.w    $4601,$ff00
    dc.w    COLOR0,$0777
    dc.w    $4701,$ff00
    dc.w    COLOR0,$0555
    dc.w    $4801,$ff00
    dc.w    COLOR0,$0333
    dc.w    $4901,$ff00
    dc.w    COLOR0,$0111
    dc.w    $4a01,$ff00
    dc.w    COLOR0,$0000
	
    dc.w    $4c01,$ff00
    dc.w    COLOR0,$0111
    dc.w    $4d01,$ff00
    dc.w    COLOR0,$0333
    dc.w    $4e01,$ff00
    dc.w    COLOR0,$0555
    dc.w    $4f01,$ff00
    dc.w    COLOR0,$0777
    dc.w    $5001,$ff00
    dc.w    COLOR0,$0999
    dc.w    $5101,$ff00
    dc.w    COLOR0,$0bbb
    dc.w    $5201,$ff00
    dc.w    COLOR0,$0ddd
    dc.w    $5301,$ff00
    dc.w    COLOR0,$0fff
    dc.w    $5401,$ff00
    dc.w    COLOR0,$0ddd
    dc.w    $5501,$ff00
    dc.w    COLOR0,$0bbb
    dc.w    $5601,$ff00
    dc.w    COLOR0,$0999
    dc.w    $5701,$ff00
    dc.w    COLOR0,$0777
    dc.w    $5801,$ff00
    dc.w    COLOR0,$0555
    dc.w    $5901,$ff00
    dc.w    COLOR0,$0333
    dc.w    $5a01,$ff00
    dc.w    COLOR0,$0111
    dc.w    $5b01,$ff00
    dc.w    COLOR0,$0000	

    dc.w    $6e01,$ff00
    dc.w    COLOR0,$0fff

    dc.w    $6f01,$ff00
    dc.w    COLOR0,$0000

    dc.w    $ac01,$ff00
    dc.w    COLOR0,$0002
    dc.w    $bc01,$ff00
;    dc.w    COLOR0,$0000
    dc.w    $ffff,$fffe

lostLogo:
    incbin "Dev:Intro_Demo-Code/Minimal/Lostboys_logo(320x256x16cols).raw"
