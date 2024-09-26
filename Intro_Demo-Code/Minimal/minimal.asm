
    section text,code_c

start:
    move.l 4.w,a6           ; Get base of exec lib
    lea gfxlib(pc),a1       ; Address of gfxlib string to a1
    jsr -408(a6)            ; Call OpenLibrary()
    move.l d0,gfxbase       ; Save base of graphics.library
    bsr configureBitPlanes
    move.l #copper,$dff080  ; Set new copper list
    
rast:
    cmp.b #$ff,$00dff006
    bne rast
    
    move.b $bfec01,d0       ; Check if the escape Key
    eor.b #$ff,d0           ; has been pressed
    ror.b #1,d0
    cmp.b #$45,d0           ; No, continue
    beq.s exit
    btst #6,$bfe001         ; Left mouse clicked ?
    bne.b rast              ; No, continue loop!
exit:
;    bsr stop_muzak
    move.l gfxbase(pc),a1   ; Base of graphics.library to a1
    move.l 38(a1),$dff080   ; Restore old copper list
    jsr -414(a6)            ; Call CloseLibrary()
    moveq #0,d0             ; Over..
    rts                     ; and out!

; Stuff
; *****

gfxlib:     dc.b    "graphics.library",0,0
gfxbase:    dc.l    0,0,0

configureBitPlanes:

    lea.l lostLogo+0,a1 ; +30720 +20400 +10200 +0
    lea.l logoBplOneHigh,a3 ; Get a pointer to the $e0 address
    lea.l logoBplOneLow,a2  ; Get a pointer to the $e2 address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

    lea.l lostLogo+10240,a1        ;10200,a1
    lea.l logoBplTwoHigh,a3 ; Get a pointer to the $e0 address
    lea.l logoBplTwoLow,a2  ; Get a pointer to the $e2 address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

    lea.l lostLogo+20480,a1 ;20400,a1
    lea.l logoBplThreeHigh,a3 ; Get a pointer to the $e0 address
    lea.l logoBplThreeLow,a2  ; Get a pointer to the $e2 address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

    lea.l lostLogo+30720,a1
    lea.l logoBplFourHigh,a3 ; Get a pointer to the $e0 address
    lea.l logoBplFourLow,a2  ; Get a pointer to the $e2 address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

    lea.l lostLogo+40960,a1
    lea.l logoBplFiveHigh,a3 ; Get a pointer to the $e0 address
    lea.l logoBplFiveLow,a2  ; Get a pointer to the $e2 address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

    rts

; Copper List ($000680CE)
copper:
    dc.w    $0106,$0000
    dc.w    $01fc,$0000 ; AGA compatible
    dc.w    $0096,$0020
  
    dc.w    $008e,$2c41
    dc.w    $0090,$2cc1
	
    dc.w    $0092,$0038 ;34  ; ddfstrt
    dc.w    $0094,$00d0;  cc ; ddfstp
   
    dc.w    $0100,$5200
    dc.w    $0102,$0000
    dc.w    $0108,$0000
    dc.w    $010a,$0000

    dc.w    $00e0
logoBplOneHigh:
    dc.w    $0000
    dc.w    $00e2
logoBplOneLow:
    dc.w    $0000

    dc.w    $00e4
logoBplTwoHigh:
    dc.w    $0000
    dc.w    $00e6
logoBplTwoLow:
    dc.w    $0000

    dc.w    $00e8
logoBplThreeHigh:
    dc.w    $0000
    dc.w    $00ea
logoBplThreeLow:
    dc.w    $0000

    dc.w    $00ec
logoBplFourHigh:
    dc.w    $0000
    dc.w    $00ee
logoBplFourLow:
    dc.w   $0000

    dc.w    $00f0
logoBplFiveHigh:
    dc.w    $0000
    dc.w    $00f2
logoBplFiveLow:
    dc.w   $0000

;    dc.w    $0180,$0000
    dc.w    $0182,$0104
    dc.w    $0184,$0105
    dc.w    $0186,$0116
    dc.w    $0188,$0217
    dc.w    $018a,$0228
    dc.w    $018c,$0338
    dc.w    $019e,$0349
    dc.w    $0190,$045a
    dc.w    $0192,$066b
    dc.w    $0194,$078c
    dc.w    $0196,$089d
    dc.w    $0198,$08ac
    dc.w    $019a,$0cdf
    dc.w    $019c,$0fff
    dc.w    $019e,$0000
    dc.w    $01a0,$0000


    dc.w    $5e01,$ff00
    dc.w    $0180,$0fff

    dc.w    $5f01,$ff00
    dc.w    $0180,$0000

    dc.w    $ac01,$ff00
    dc.w    $0180,$0002
    dc.w    $bc01,$ff00
;    dc.w    $0180,$0000
    dc.w    $ffff,$fffe

lostLogo:
    incbin "Dev:Intro_Demo-Code/First_A500_Demo/Lostboys_logo(320x256x16cols).raw"
