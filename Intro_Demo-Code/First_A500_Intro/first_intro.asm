;APS00000000000000000000000000000000000000000000000000000000000000000000000000000000
;
;
;    ***********************************;
;    *         First A500 Intro        *;
;    ***********************************;
;    *         Written in 1988.        *;
;    ***********************************;
;
;** NOTE! **;
; load tlb_logo with RI into        $34000
; load lost_logo! with RI into      $37000
; load knight-hi_chrs with RI into  $70000
; load sentinel_zax with RI into    $40000
; load obliterator_zax with RI into $50000

; $48000 - $4f000 logo
; $5a000 - $5d000 vertical scroll image

    section text,code_c

start:
    move.l 4.w,a6           ; Get base of exec lib
    lea gfxlib(pc),a1       ; Adress of gfxlib string to a1
    jsr -408(a6)            ; Call OpenLibrary()
    move.l d0,gfxbase       ; Save base of graphics.library
    bsr configureBitPlanes
    move.l #copper,$dff080  ; Set new copperlist
;    bsr start_muzak
;    bsr stop_muzak
    bsr.l sentinel

rast:
    cmp.b #$ff,$00dff006
    bne rast
    bsr scroller
    bsr colrol

;    bsr fader
;    bsr replay_muzak

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
    move.l 38(a1),$dff080   ; Restore old copperlist
    jsr -414(a6)            ; Call CloseLibrary()
    moveq #0,d0             ; Over..
    rts                     ; and out!

; Stuff
; *****

gfxlib:     dc.b    "graphics.library",0,0
gfxbase:    dc.l    0

configureBitPlanes:

    lea.l lostLogo+20,a1
    lea.l logoBplOneHigh,a3   ; Get a pointer to the $e0 address
    lea.l logoBplOneLow,a2    ; Get a pointer to the $e2 address
    move.l a1,d1              ; Copy pointer address into d1
    move.w d1,(a2)            ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2            ; Copy the data from the pointer into d3
    swap d1                   ; Flip d1
    move.w d1,(a3)            ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3            ; Copy the data from the pointer into d3

    lea.l lostLogo+60,a1
    lea.l logoBplTwoHigh,a3   ; Get a pointer to the $e0 address
    lea.l logoBplTwoLow,a2    ; Get a pointer to the $e2 address
    move.l a1,d1              ; Copy pointer address into d1
    move.w d1,(a2)            ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2            ; Copy the data from the pointer into d3
    swap d1                   ; Flip d1
    move.w d1,(a3)            ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3            ; Copy the data from the pointer into d3

    lea.l lostLogo+100,a1
    lea.l logoBplThreeHigh,a3 ; Get a pointer to the $e0 address
    lea.l logoBplThreeLow,a2  ; Get a pointer to the $e2 address
    move.l a1,d1              ; Copy pointer address into d1
    move.w d1,(a2)            ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2            ; Copy the data from the pointer into d3
    swap d1                   ; Flip d1
    move.w d1,(a3)            ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3            ; Copy the data from the pointer into d3

;    lea.l lostLogo+120,a1
;    lea.l logoBplFourHigh,a3 ; Get a pointer to the $e0 address
;    lea.l logoBplFourLow,a2  ; Get a pointer to the $e2 address
;    move.l a1,d1             ; Copy pointer address into d1
;    move.w d1,(a2)           ; Copy the lower word into a2 ($e2 address)
;    move.w (a2),d2           ; Copy the data from the pointer into d3
;    swap d1                  ; Flip d1
;    move.w d1,(a3)           ; Copy the lower word into a2 ($e0 address)
;    move.w (a3),d3           ; Copy the data from the pointer into d3


;    lea.l screen,a1
;    lea.l image+$1dd8,a1 ;$1dd8,a1
;    lea.l bplTwoHigh,a3     ; Get a pointer to the $e4 address
;    lea.l bplTwoLow,a2      ; Get a pointer to the $e6 address
;    move.l a1,d1            ; Copy pointer address into d1
;    move.w d1,(a2)          ; Copy the lower word into a2 ($e4 address)
;    move.w (a2),d2          ; Copy the data from the pointer into d3
;    swap d1                 ; Flip d1
;    move.w d1,(a3)          ; Copy the lower word into a2 ($e6 address)
;    move.w (a3),d3          ; Copy the data from the pointer into d3
;
;    lea.l screen,a1
;    lea.l image+$3250,a1 ;19a4,a1 ;$1dd8,a1
;    lea.l bplThreeHigh,a3   ; Get a pointer to the $e8 address
;    lea.l bplThreeLow,a2    ; Get a pointer to the $ea address
;    move.l a1,d1            ; Copy pointer address into d1
;    move.w d1,(a2)          ; Copy the lower word into a2 ($e8 address)
;    move.w (a2),d2          ; Copy the data from the pointer into d3
;    swap d1                 ; Flip d1
;    move.w d1,(a3)          ; Copy the lower word into a2 ($ea address)
;    move.w (a3),d3          ; Copy the data from the pointer into d3
;
;;    lea.l image+$19a4,a1
;;    lea.l bplFourHigh,a3    ; Get a pointer to the $ec address
;;    lea.l bplFourLow,a2     ; Get a pointer to the $ee address
;;    move.l a1,d1            ; Copy pointer address into d1
;;    move.w d1,(a2)          ; Copy the lower word into a2 ($ec address)
;;    move.w (a2),d2          ; Copy the data from the pointer into d3
;;    swap d1                 ; Flip d1
;;    move.w d1,(a3)          ; Copy the lower word into a2 ($ee address)
;;    move.w (a3),d3          ; Copy the data from the pointer into d3
;
;;    lea.l image+$a000,a1
;;    lea.l bplFiveHigh,a3    ; Get a pointer to the $f0 address
;;    lea.l bplFiveLow,a2     ; Get a pointer to the $f2 address
;;    move.l a1,d1            ; Copy pointer address into d1
;;    move.w d1,(a2)          ; Copy the lower word into a2 ($f0 address)
;;    move.w (a2),d2          ; Copy the data from the pointer into d3
;;    swap d1                 ; Flip d1
;;    move.w d1,(a3)          ; Copy the lower word into a2 ($f2 address)
;;    move.w (a3),d3          ; Copy the data from the pointer into d3
;
;;    lea.l screen,a1
;;    lea.l chrBitPlaneOneHigh,a3    ; Get a pointer to the $f0 address
;;    lea.l chrBitPlaneOneLow,a2     ; Get a pointer to the $f2 address
;;    move.l a1,d1            ; Copy pointer address into d1
;;    move.w d1,(a2)          ; Copy the lower word into a2 ($f0 address)
;;    move.w (a2),d2          ; Copy the data from the pointer into d3
;;    swap d1                 ; Flip d1
;;    move.w d1,(a3)          ; Copy the lower word into a2 ($f2 address)
;;    move.w (a3),d3          ; Copy the data from the pointer into d3
    rts

; Copper List ($000680CE)
copper:
    dc.w    $0106,$0000
    dc.w    $01fc,$0000 ; AGA compatible
    dc.w    $0096,$0020

;    dc.w    $3201,$ff00
;    dc.w    $0180,$0000
;    dc.w    $0182,$0eca ;golden browns from here!
;    dc.w    $0184,$0ba0
;    dc.w    $0186,$0a42
;    dc.w    $0188,$0a52
;    dc.w    $018a,$0a61
;    dc.w    $018c,$0a71
;    dc.w    $018e,$0b91
;    dc.w    $0190,$0ba0
;    dc.w    $0192,$0644
;    dc.w    $0194,$0754
;    dc.w    $0196,$0855
;    dc.w    $0198,$0966
;    dc.w    $019a,$0a76
;    dc.w    $019c,$0b87
;    dc.w    $019e,$0c87
;    dc.w    $01a0,$0c98
;    dc.w    $01a2,$0da9
;    dc.w    $01a4,$0eb9
;    dc.w    $01a6,$0fca
;
;    dc.w    $01a8,$000f ;blues from here
;    dc.w    $01aa,$012f
;    dc.w    $01ac,$033f
;    dc.w    $01ae,$044f
;    dc.w    $01b0,$066f
;    dc.w    $01b2,$077f
;    dc.w    $01b4,$088f
;    dc.w    $01b6,$0aaf
;    dc.w    $01b8,$0ccf
;    dc.w    $01ba,$0eef
;    dc.w    $01bc,$0fff ;blues end here

    dc.w    $3b01,$ff00
    dc.w    $0180,$0000

    dc.w    $0100,$4000
    dc.w    $0102,$0000
    dc.w    $0092,$0034
    dc.w    $0094,$00cc
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

    dc.w    $3c01,$ff00
    dc.w    $0180,$0000

;    dc.w    $3d01,$ff00
;    dc.w    $0180,$0111
;    dc.w    $3e01,$ff00
;    dc.w    $0180,$0333
;    dc.w    $3f01,$ff00
;    dc.w    $0180,$0555
;    dc.w    $4001,$ff00
;    dc.w    $0180,$0777
;    dc.w    $4101,$ff00
;    dc.w    $0180,$0555
;    dc.w    $4201,$ff00
;    dc.w    $0180,$0333
;    dc.w    $4301,$ff00
;    dc.w    $0180,$0111
;    dc.w    $4401,$ff00
;    dc.w    $0180,$0000
;
;    dc.w    $4c01,$ff00
;    dc.w    $0180,$0111
;    dc.w    $4d01,$ff00
;    dc.w    $0180,$0333
;    dc.w    $4e01,$ff00
;    dc.w    $0180,$0555
;    dc.w    $4f01,$ff00
;    dc.w    $0180,$0777
;
;    dc.w    $5001,$ff00
;    dc.w    $0180,$0555
;    dc.w    $5101,$ff00
;    dc.w    $0180,$0333
;    dc.w    $5201,$ff00
;    dc.w    $0180,$0111
;    dc.w    $0102,$0000
;    dc.w    $5301,$ff00
;    dc.w    $0180,$0000
;    dc.w    $0102,$0000
    dc.w    $5401,$ff00
    dc.w    $0180,$0000

    dc.w    $0102
tlb:
    dc.w    $0000

    dc.w    $5501,$ff00
    dc.w    $0180,$0000
    dc.w    $5601,$ff00
;    dc.w    $0100,$0000
;    dc.w    $0102,$0000

    dc.w    $9601,$ff00 ; raster colour effect !

    dc.w    $0100,$0000

;    dc.w    $0180,$0211
;    dc.w    $9701,$ff00
;    dc.w    $0180,$0311
;    dc.w    $9801,$ff00
;    dc.w    $0180,$0422
;    dc.w    $9901,$ff00
;    dc.w    $0180,$0533
;    dc.w    $9a01,$ff00
;    dc.w    $0180,$0644
;    dc.w    $9b01,$ff00
;    dc.w    $0180,$0755
;    dc.w    $9c01,$ff00
;    dc.w    $0180,$0866
;    dc.w    $9d01,$ff00
;    dc.w    $0180,$0977
;    dc.w    $9e01,$ff00
;    dc.w    $0180,$0a88
;    dc.w    $9f01,$ff00
;    dc.w    $0180,$0977
;    dc.w    $a001,$ff00
;    dc.w    $0180,$0866
;    dc.w    $a101,$ff00
;    dc.w    $0180,$0755
;    dc.w    $a201,$ff00
;    dc.w    $0180,$0644
;    dc.w    $a301,$ff00
;    dc.w    $0180,$0533
;    dc.w    $a401,$ff00
;    dc.w    $0180,$0422
;    dc.w    $a501,$ff00
;    dc.w    $0180,$0311
;    dc.w    $a601,$ff00
;    dc.w    $0180,$0211
;    dc.w    $a701,$ff00
;    dc.w    $0180,$0000
;    dc.w    $a801,$ff00
;    dc.w    $0180,$0000
;
;    dc.w    $0182,$0fff
;    dc.w    $0184,$0ebb
;    dc.w    $0186,$0c88
;    dc.w    $0188,$0b66
;    dc.w    $018a,$0a33
;    dc.w    $018c,$0811
;    dc.w    $018e,$0700
;    dc.w    $0190,$0922
;    dc.w    $0192,$0a44
;    dc.w    $0194,$0c77
;    dc.w    $0196,$0dbb
;    dc.w    $0198,$0fee
;    dc.w    $019a,$00c0
;    dc.w    $019c,$0fe5
;    dc.w    $019e,$0c80
;    dc.w    $01a0,$0f00
;    dc.w    $01a2,$0f40
;    dc.w    $01a4,$0f80
;    dc.w    $01a6,$0fd0
;    dc.w    $01a8,$0df0
;    dc.w    $01aa,$09f0
;    dc.w    $01ac,$04f0
;    dc.w    $01ae,$00f0
;    dc.w    $01b0,$00f4
;    dc.w    $01b2,$00f7
;    dc.w    $01b4,$00fb
;    dc.w    $01b6,$00ee
;    dc.w    $01b8,$00be
;    dc.w    $01ba,$007e
;    dc.w    $01bc,$004e
;    dc.w    $01be,$000e
;
;    dc.w    $a901,$ff00
    dc.w    $0102
scroll_val:
    dc.w    $00ff
;
;    dc.w    $0180,$0f44
;    dc.w    $aa01,$ff00
;    dc.w    $0180,$0555
;    dc.w    $ab01,$ff00
;    dc.w    $0180,$0666
;    dc.w    $ac01,$ff00
;    dc.w    $0180,$0777
;    dc.w    $ad01,$ff00
;    dc.w    $0180,$0888
;    dc.w    $ae01,$ff00
;    dc.w    $0180,$0999
;    dc.w    $af01,$ff00
;    dc.w    $0180,$0aaa
;    dc.w    $b001,$ff00
;    dc.w    $0180,$0ccc
;    dc.w    $b101,$ff00
;    dc.w    $0180,$0ddd
;    dc.w    $b201,$ff00
;    dc.w    $0180,$0eee
;    dc.w    $b301,$ff00
;
;    dc.w    $0100,$1000
;
;;   dc.w    $0092,$0036
;;   dc.w    $0094,$0000
;
;;  ; Logo bit planes
;;    dc.w    $00e0
;;logoBplOneHigh:
;;  dc.w    $0000
;;    dc.w    $00e2
;;logoBplOneLow:
;;  dc.w    $0000
;
;;    dc.w    $00e4,$0004
;;    dc.w    $00e6,$1930
;;
;;    dc.w    $00e8,$0004
;;    dc.w    $00ea,$2c90
;;
;;    dc.w    $00ec,$0004
;;    dc.w    $00ee,$39a0
;
;    dc.w    $0180,$070d
;    dc.w    $b401,$ff00
;    dc.w    $0180,$060c
;    dc.w    $b501,$ff00
;    dc.w    $0180,$050b
;    dc.w    $b601,$ff00
;    dc.w    $0180,$040a
;    dc.w    $b701,$ff00
;    dc.w    $0180,$020a
;    dc.w    $b801,$ff00
;    dc.w    $0180,$0007
;    dc.w    $b901,$ff00
;    dc.w    $0180,$0005
;    dc.w    $ba01,$ff00
;    dc.w    $0180,$0003
;    dc.w    $bb01,$ff00
;    dc.w    $0180,$0002
;    dc.w    $bc01,$ff00
;    dc.w    $0180,$0000
;    dc.w    $bd01,$ff00
;    dc.w    $0180,$0000
;    dc.w    $be01,$ff00
;
;    dc.w    $0180,$0000
;    dc.w    $bf01,$ff00
;    dc.w    $0180,$0000
;    dc.w    $c001,$ff00
;    dc.w    $0180,$0444
;    dc.w    $c101,$ff00
;    dc.w    $0180,$0555
;    dc.w    $c201,$ff00
;    dc.w    $0180,$0666
;    dc.w    $c301,$ff00
;    dc.w    $0180,$0777
;    dc.w    $c401,$ff00
;    dc.w    $0180,$0888
;    dc.w    $c501,$ff00
;    dc.w    $0180,$0999
;    dc.w    $c601,$ff00
;    dc.w    $0180,$0aaa
;    dc.w    $c701,$ff00
;    dc.w    $0180,$0bbb
;    dc.w    $c801,$ff00
;    dc.w    $0180,$0ccc
;    dc.w    $c901,$ff00
;    dc.w    $0180,$0ddd
;    dc.w    $ca01,$ff00
;    dc.w    $0180,$0eee
;    dc.w    $cb01,$ff00
;    dc.w    $0180,$070d
;
;    dc.w    $0100,$0000
;
;    dc.w    $cc01,$ff00
;    dc.w    $0180,$060c
;    dc.w    $cd01,$ff00
;    dc.w    $0180,$050b
;    dc.w    $d001,$ff00
;    dc.w    $0180,$040a
;    dc.w    $d101,$ff00
;    dc.w    $0180,$020a
;    dc.w    $d201,$ff00
;    dc.w    $0180,$0007
;    dc.w    $d301,$ff00
;    dc.w    $0180,$0005
;    dc.w    $d401,$ff00
;    dc.w    $0180,$0003
;    dc.w    $d501,$ff00
;    dc.w    $0180,$0002
;    dc.w    $d601,$ff00
;    dc.w    $0180,$0000
;    dc.w    $d701,$ff00
;    dc.w    $0180,$0000
;
;    dc.w    $d801,$ff00
;    dc.w    $0180,$0000
;    dc.w    $0100,$0000
;    dc.w    $da01,$ff00
;    dc.w    $0180,$0211
;    dc.w    $db01,$ff00
;    dc.w    $0180,$0311
;    dc.w    $dc01,$ff00
;    dc.w    $0180,$0422
;    dc.w    $dd01,$ff00
;    dc.w    $0180,$0533
;    dc.w    $de01,$ff00
;    dc.w    $0180,$0644
;    dc.w    $df01,$ff00
;    dc.w    $0180,$0755
;    dc.w    $e001,$ff00
;    dc.w    $0180,$0866
;    dc.w    $e101,$ff00
;    dc.w    $0180,$0977
;    dc.w    $e201,$ff00
;    dc.w    $0180,$0a88
;    dc.w    $e301,$ff00
;    dc.w    $0180,$0977
;    dc.w    $e401,$ff00
;    dc.w    $0180,$0866
;    dc.w    $e501,$ff00
;    dc.w    $0180,$0755
;    dc.w    $e601,$ff00
;    dc.w    $0180,$0644
;    dc.w    $e701,$ff00
;    dc.w    $0180,$0533
;    dc.w    $e801,$ff00
;    dc.w    $0180,$0422
;    dc.w    $e901,$ff00
;    dc.w    $0180,$0311
;    dc.w    $ea01,$ff00
;    dc.w    $0180,$0211
;    dc.w    $eb01,$ff00
;    dc.w    $0180,$0000
;
;ian:
;    dc.w    $f501,$ff00
;    dc.w    $0180,$0131
;    dc.w    $f601,$ff00
;    dc.w    $0180,$0242
;    dc.w    $f701,$ff00
;    dc.w    $0180,$0353
;    dc.w    $f801,$ff00
;    dc.w    $0180,$0464
;    dc.w    $f901,$ff00
;    dc.w    $0180,$0353
;    dc.w    $fa01,$ff00
;    dc.w    $0180,$0242
;
;ian1:
;    dc.w    $fb01,$ff00
;    dc.w    $0180,$0131
;    dc.w    $fc01,$fffe
;    dc.w    $0180,$0000
;    dc.w    $0001,$ff00
;    dc.w    $0100,$4000
;
;;** Vertical SCROLL BIT-PLANE POINTERS **
;
;    dc.w    $00e0,$0003
;    dc.w    $00e2,$7e50 ;7f18;7e58
;
;    dc.w    $00e4,$0003
;    dc.w    $00e6,$84e0
;
;    dc.w    $00e8,$0003
;    dc.w    $00ea,$8bc0
;
;    dc.w    $00ec,$0003
;    dc.w    $00ee,$9250
;
;    dc.w    $00f0,$0003
;    dc.w    $00f2,$9250
;
;    dc.w    $0182,$0eca
;    dc.w    $0184,$0004
;    dc.w    $0186,$0105
;    dc.w    $0188,$0205
;    dc.w    $018a,$0316
;    dc.w    $018c,$0417
;    dc.w    $018e,$0517
;    dc.w    $0190,$0547
;    dc.w    $0192,$0548
;    dc.w    $0194,$0459
;    dc.w    $0196,$076a
;    dc.w    $0198,$089d
;
;    dc.w    $ff01,$ff00
;    dc.w    $ffe1,$ffee ;tell copper 255+
;    dc.w    $01fe,$0000
;    dc.w    $0011,$ffee
;
;    dc.w    $2001,$ff00
;    dc.w    $0180,$0000
;    dc.w    $2101,$ff00
;    dc.w    $0180,$0111
;    dc.w    $0100,$0000
;    dc.w    $2201,$ff00
;    dc.w    $0180,$0222
;    dc.w    $2301,$ff00
;    dc.w    $0180,$0333
;    dc.w    $2401,$ff00
;    dc.w    $0180,$0444
;    dc.w    $2501,$ff00
;    dc.w    $0180,$0555
;    dc.w    $2601,$ff00
;    dc.w    $0180,$0666
;    dc.w    $2701,$ff00
;    dc.w    $0180,$0777
;    dc.w    $2801,$ff00
;    dc.w    $0180,$0888
;    dc.w    $2901,$ff00
;    dc.w    $0180,$0999
;    dc.w    $2a01,$ff00
;    dc.w    $0180,$0aaa
;    dc.w    $2b01,$ff00
;    dc.w    $0180,$0000
    dc.w    $ffff,$fffe
; End of Copper List


;execbase=4
;   move.l  execbase,a6
;   jsr -132(a6)
;   bsr     setup
;   bra     start
;   rts
;
;setup: move.l  #copperlist,$dff080
;   move.w  #$000f,$dff096
;   move.w  #$0,d0
;   jsr $50000
;   jsr $40000
;   rts
;
;copperlist:
;   dc.w    $0096,$0020 ; dma enable
;   dc.w    $0001,$ff00
;   dc.w    $0100,$0000
;   dc.w    $0184,$0000
;   dc.w    $2f01,$ff00
;   dc.w    $0100,$5000
;;bitplane pointer $e0-$f6
;   dc.w    $00e0,$0003
;   dc.w    $00e2,$48f3
;   dc.w    $00e4,$0003
;   dc.w    $00e6,$4eba
;   dc.w    $00e8,$0003
;   dc.w    $00ea,$54aa
;   dc.w    $00ec,$0003
;   dc.w    $00ee,$5a9a
;   dc.w    $00f0,$0003
;   dc.w    $00f2,$608a
;
;   dc.w    $008e,$2940 ;display window start
;   dc.w    $0090,$40c0 ;display window stop
;
;   dc.w    $0092,$0040 ;40 (40 col) 36 (80 col)
;   dc.w    $0094,$0fff
;
;   dc.w    $3201,$ff00
;   dc.w    $0180,$0000
;   dc.w    $0182,$0eca ;golden browns from here!
;   dc.w    $0184,$0ba0
;   dc.w    $0186,$0a42
;   dc.w    $0188,$0a52
;   dc.w    $018a,$0a61
;   dc.w    $018c,$0a71
;   dc.w    $018e,$0b91
;   dc.w    $0190,$0ba0
;   dc.w    $0192,$0644
;   dc.w    $0194,$0754
;   dc.w    $0196,$0855
;   dc.w    $0198,$0966
;   dc.w    $019a,$0a76
;   dc.w    $019c,$0b87
;   dc.w    $019e,$0c87
;   dc.w    $01a0,$0c98
;   dc.w    $01a2,$0da9
;   dc.w    $01a4,$0eb9
;   dc.w    $01a6,$0fca
;
;   dc.w    $01a8,$000f ;blues from here
;   dc.w    $01aa,$012f
;   dc.w    $01ac,$033f
;   dc.w    $01ae,$044f
;   dc.w    $01b0,$066f
;   dc.w    $01b2,$077f
;   dc.w    $01b4,$088f
;   dc.w    $01b6,$0aaf
;   dc.w    $01b8,$0ccf
;   dc.w    $01ba,$0eef
;   dc.w    $01bc,$0fff ;blues end here
;   dc.w    $01be,$0000
;
;   dc.w    $3601,$ff00
;   dc.w    $0180,$0000
;   dc.w    $0102,$0000
;   dc.w    $3701,$ff00
;   dc.w    $0180,$0000
;   dc.w    $0102,$0000
;   dc.w    $3801,$ff00
;   dc.w    $0180,$0000
;   dc.w    $0102,$0000
;   dc.w    $3901,$ff00
;   dc.w    $0180,$0000
;   dc.w    $0102,$0000
;   dc.w    $3a01,$ff00
;   dc.w    $0180,$0000
;   dc.w    $0102,$0000
;   dc.w    $3b01,$ff00
;   dc.w    $0180,$0000
;   dc.w    $0102,$0000
;   dc.w    $3c01,$ff00
;   dc.w    $0180,$0000
;   dc.w    $0102,$0000
;   dc.w    $3d01,$ff00
;   dc.w    $0180,$0111
;   dc.w    $0102
;   dc.w    $0000
;   dc.w    $3e01,$ff00
;   dc.w    $0180,$0333
;   dc.w    $0102
;   dc.w    $0000
;   dc.w    $3f01,$ff00
;   dc.w    $0180,$0555
;   dc.w    $0102,$0000
;   dc.w    $4001,$ff00
;   dc.w    $0180,$0777
;   dc.w    $0102
;   dc.w    $0000
;   dc.w    $4101,$ff00
;   dc.w    $0180,$0555
;   dc.w    $0102,$0000
;   dc.w    $4201,$ff00
;   dc.w    $0180,$0333
;   dc.w    $4301,$ff00
;   dc.w    $0180,$0111
;   dc.w    $4401,$ff00
;   dc.w    $0180,$0000
;
;   dc.w    $4c01,$ff00
;   dc.w    $0180,$0111
;   dc.w    $4d01,$ff00
;   dc.w    $0180,$0333
;   dc.w    $4e01,$ff00
;   dc.w    $0180,$0555
;   dc.w    $4f01,$ff00
;   dc.w    $0180,$0777
;
;   dc.w    $5001,$ff00
;   dc.w    $0180,$0555
;   dc.w    $5101,$ff00
;   dc.w    $0180,$0333
;   dc.w    $5201,$ff00
;   dc.w    $0180,$0111
;   dc.w    $0102,$0000
;   dc.w    $5301,$ff00
;   dc.w    $0180,$0000
;   dc.w    $0102,$0000
;   dc.w    $5401,$ff00
;   dc.w    $0180,$0000
;   dc.w    $0102
;tlb:   dc.w    $0000
;   dc.w    $5501,$ff00
;   dc.w    $0180,$0000
;   dc.w    $5601,$ff00
;   dc.w    $0100,$0000
;   dc.w    $0102,$0000
;
;   dc.w    $9601,$ff00 ; raster colour effect !
;   dc.w    $0180,$0211
;   dc.w    $9701,$ff00
;   dc.w    $0180,$0311
;   dc.w    $9801,$ff00
;   dc.w    $0180,$0422
;   dc.w    $9901,$ff00
;   dc.w    $0180,$0533
;   dc.w    $9a01,$ff00
;   dc.w    $0180,$0644
;   dc.w    $9b01,$ff00
;   dc.w    $0180,$0755
;   dc.w    $9c01,$ff00
;   dc.w    $0180,$0866
;   dc.w    $9d01,$ff00
;   dc.w    $0180,$0977
;   dc.w    $9e01,$ff00
;   dc.w    $0180,$0a88
;   dc.w    $9f01,$ff00
;   dc.w    $0180,$0977
;   dc.w    $a001,$ff00
;   dc.w    $0180,$0866
;   dc.w    $a101,$ff00
;   dc.w    $0180,$0755
;   dc.w    $a201,$ff00
;   dc.w    $0180,$0644
;   dc.w    $a301,$ff00
;   dc.w    $0180,$0533
;   dc.w    $a401,$ff00
;   dc.w    $0180,$0422
;   dc.w    $a501,$ff00
;   dc.w    $0180,$0311
;   dc.w    $a601,$ff00
;   dc.w    $0180,$0211
;   dc.w    $a701,$ff00
;   dc.w    $0180,$0000
;   dc.w    $a801,$ff00
;   dc.w    $0180,$0000
;
;   dc.w    $0182,$0fff
;   dc.w    $0184,$0ebb
;   dc.w    $0186,$0c88
;   dc.w    $0188,$0b66
;   dc.w    $018a,$0a33
;   dc.w    $018c,$0811
;   dc.w    $018e,$0700
;   dc.w    $0190,$0922
;   dc.w    $0192,$0a44
;   dc.w    $0194,$0c77
;   dc.w    $0196,$0dbb
;   dc.w    $0198,$0fee
;   dc.w    $019a,$00c0
;   dc.w    $019c,$0fe5
;   dc.w    $019e,$0c80
;   dc.w    $01a0,$0f00
;   dc.w    $01a2,$0f40
;   dc.w    $01a4,$0f80
;   dc.w    $01a6,$0fd0
;   dc.w    $01a8,$0df0
;   dc.w    $01aa,$09f0
;   dc.w    $01ac,$04f0
;   dc.w    $01ae,$00f0
;   dc.w    $01b0,$00f4
;   dc.w    $01b2,$00f7
;   dc.w    $01b4,$00fb
;   dc.w    $01b6,$00ee
;   dc.w    $01b8,$00be
;   dc.w    $01ba,$007e
;   dc.w    $01bc,$004e
;   dc.w    $01be,$000e
;   dc.w    $a901,$ff00
;
;
;   dc.w    $0180,$0444
;   dc.w    $aa01,$ff00
;   dc.w    $0180,$0555
;   dc.w    $ab01,$ff00
;   dc.w    $0180,$0666
;   dc.w    $ac01,$ff00
;   dc.w    $0180,$0777
;   dc.w    $ad01,$ff00
;   dc.w    $0180,$0888
;   dc.w    $ae01,$ff00
;   dc.w    $0180,$0999
;   dc.w    $af01,$ff00
;   dc.w    $0180,$0aaa
;   dc.w    $b001,$ff00
;   dc.w    $0180,$0ccc
;   dc.w    $b101,$ff00
;   dc.w    $0180,$0ddd
;   dc.w    $b201,$ff00
;   dc.w    $0180,$0eee
;   dc.w    $b301,$ff00
;
;   dc.w    $0100,$3000
;
;;  dc.w    $0092,$0036
;;  dc.w    $0094,$0000
;
;   dc.w    $00e0,$0004
;   dc.w    $00e2,$05d0
;   dc.w    $00e4,$0004
;   dc.w    $00e6,$1930
;   dc.w    $00e8,$0004
;   dc.w    $00ea,$2c90
;   dc.w    $00ec,$0004
;   dc.w    $00ee,$39a0
;
;   dc.w    $0180,$070d
;   dc.w    $b401,$ff00
;   dc.w    $0180,$060c
;   dc.w    $b501,$ff00
;   dc.w    $0180,$050b
;   dc.w    $b601,$ff00
;   dc.w    $0180,$040a
;   dc.w    $b701,$ff00
;   dc.w    $0180,$020a
;   dc.w    $b801,$ff00
;   dc.w    $0180,$0007
;   dc.w    $b901,$ff00
;   dc.w    $0180,$0005
;   dc.w    $ba01,$ff00
;   dc.w    $0180,$0003
;   dc.w    $bb01,$ff00
;   dc.w    $0180,$0002
;   dc.w    $bc01,$ff00
;   dc.w    $0180,$0000
;   dc.w    $bd01,$ff00
;   dc.w    $0180,$0000
;   dc.w    $be01,$ff00
;
;
;   dc.w    $0180,$0000
;   dc.w    $bf01,$ff00
;   dc.w    $0180,$0000
;   dc.w    $c001,$ff00
;   dc.w    $0180,$0444
;   dc.w    $c101,$ff00
;   dc.w    $0180,$0555
;   dc.w    $c201,$ff00
;   dc.w    $0180,$0666
;   dc.w    $c301,$ff00
;   dc.w    $0180,$0777
;   dc.w    $c401,$ff00
;   dc.w    $0180,$0888
;   dc.w    $c501,$ff00
;   dc.w    $0180,$0999
;   dc.w    $c601,$ff00
;   dc.w    $0180,$0aaa
;   dc.w    $c701,$ff00
;   dc.w    $0180,$0bbb
;   dc.w    $c801,$ff00
;   dc.w    $0180,$0ccc
;   dc.w    $c901,$ff00
;   dc.w    $0180,$0ddd
;   dc.w    $ca01,$ff00
;   dc.w    $0180,$0eee
;   dc.w    $cb01,$ff00
;   dc.w    $0180,$070d
;
;   dc.w    $0100,$0000
;
;   dc.w    $cc01,$ff00
;   dc.w    $0180,$060c
;   dc.w    $cd01,$ff00
;   dc.w    $0180,$050b
;   dc.w    $d001,$ff00
;   dc.w    $0180,$040a
;   dc.w    $d101,$ff00
;   dc.w    $0180,$020a
;   dc.w    $d201,$ff00
;   dc.w    $0180,$0007
;   dc.w    $d301,$ff00
;   dc.w    $0180,$0005
;   dc.w    $d401,$ff00
;   dc.w    $0180,$0003
;   dc.w    $d501,$ff00
;   dc.w    $0180,$0002
;   dc.w    $d601,$ff00
;   dc.w    $0180,$0000
;   dc.w    $d701,$ff00
;   dc.w    $0180,$0000
;;** SCROLL BIT-PLANE POINTERS **
;   dc.w    $d801,$ff00
;   dc.w    $0180,$0000
;   dc.w    $0100,$0000
;   dc.w    $da01,$ff00
;   dc.w    $0180,$0211
;   dc.w    $db01,$ff00
;   dc.w    $0180,$0311
;   dc.w    $dc01,$ff00
;   dc.w    $0180,$0422
;   dc.w    $dd01,$ff00
;   dc.w    $0180,$0533
;   dc.w    $de01,$ff00
;   dc.w    $0180,$0644
;   dc.w    $df01,$ff00
;   dc.w    $0180,$0755
;   dc.w    $e001,$ff00
;   dc.w    $0180,$0866
;   dc.w    $e101,$ff00
;   dc.w    $0180,$0977
;   dc.w    $e201,$ff00
;   dc.w    $0180,$0a88
;   dc.w    $e301,$ff00
;   dc.w    $0180,$0977
;   dc.w    $e401,$ff00
;   dc.w    $0180,$0866
;   dc.w    $e501,$ff00
;   dc.w    $0180,$0755
;   dc.w    $e601,$ff00
;   dc.w    $0180,$0644
;   dc.w    $e701,$ff00
;   dc.w    $0180,$0533
;   dc.w    $e801,$ff00
;   dc.w    $0180,$0422
;   dc.w    $e901,$ff00
;   dc.w    $0180,$0311
;   dc.w    $ea01,$ff00
;   dc.w    $0180,$0211
;   dc.w    $eb01,$ff00
;   dc.w    $0180,$0000
;
;ian:   dc.w    $f501,$ff00
;;  dc.w    $0180,$0131
;;  dc.w    $f601,$ff00
;;  dc.w    $0180,$0242
;;  dc.w    $f701,$ff00
;;  dc.w    $0180,$0353
;;  dc.w    $f801,$ff00
;;  dc.w    $0180,$0464
;;  dc.w    $f901,$ff00
;;  dc.w    $0180,$0353
;;  dc.w    $fa01,$ff00
;;  dc.w    $0180,$0242
;ian1:  dc.w    $fb01,$ff00
;;  dc.w    $0180,$0131
;;  dc.w    $fc01,$fffe
;;  dc.w    $0180,$0000
;   dc.w    $0001,$ff00
;   dc.w    $0100,$4000
;
;   dc.w    $00e0,$0003
;   dc.w    $00e2,$7e50 ;7f18;7e58
;
;   dc.w    $00e4,$0003
;   dc.w    $00e6,$84e0
;
;   dc.w    $00e8,$0003
;   dc.w    $00ea,$8bc0
;
;   dc.w    $00ec,$0003
;   dc.w    $00ee,$9250
;
;   dc.w    $00f0,$0003
;   dc.w    $00f2,$9250
;
;   dc.w    $0182,$0eca
;   dc.w    $0184,$0004
;   dc.w    $0186,$0105
;   dc.w    $0188,$0205
;   dc.w    $018a,$0316
;   dc.w    $018c,$0417
;   dc.w    $018e,$0517
;   dc.w    $0190,$0547
;   dc.w    $0192,$0548
;   dc.w    $0194,$0459
;   dc.w    $0196,$076a
;   dc.w    $0198,$089d
;
;   dc.w    $ff01,$ff00
;   dc.w    $ffe1,$ffee ;tell copper 255+
;   dc.w    $01fe,$0000
;   dc.w    $0011,$ffee
;
;   dc.w    $2001,$ff00
;   dc.w    $0180,$0000
;   dc.w    $2101,$ff00
;   dc.w    $0180,$0111
;   dc.w    $0100,$0000
;   dc.w    $2201,$ff00
;   dc.w    $0180,$0222
;   dc.w    $2301,$ff00
;   dc.w    $0180,$0333
;   dc.w    $2401,$ff00
;   dc.w    $0180,$0444
;   dc.w    $2501,$ff00
;   dc.w    $0180,$0555
;   dc.w    $2601,$ff00
;   dc.w    $0180,$0666
;   dc.w    $2701,$ff00
;   dc.w    $0180,$0777
;   dc.w    $2801,$ff00
;   dc.w    $0180,$0888
;   dc.w    $2901,$ff00
;   dc.w    $0180,$0999
;   dc.w    $2a01,$ff00
;   dc.w    $0180,$0aaa
;   dc.w    $2b01,$ff00
;   dc.w    $0180,$0000
;   dc.w    $ffff,$fffe

;start: btst    #$6,$bfe001
;   beq finish
;rast:  cmpi.b  #$ff,$dff006
;   bne     rast
;;  bsr colrol
;;  bsr     scroller
;   bsr key_press
;   bsr wiggle
;tel:   jsr $5010a
;   jmp     start
;
;wiggle:    movem.l $7fd00,d0-d7/a0-a6
;   bsr more
;   movem.l d0-d7/a0-a6,$7fd00
;   rts
;
;more:  move.w  (a0)+,tlb
;   cmpa.l  #end,a0
;   beq yes
;   rts
;yes:   lea numbers,a0
;   rts


colrol:
;    move.w  ian+8,ian1+8
;    move.w  ian+16,ian+8
;    move.w  ian+24,ian+16
;    move.w  ian+32,ian+24
;    move.w  ian+40,ian+32
;    move.w  ian+48,ian+40
;    move.w  ian1+8,ian+48
    rts

;key_press:
;   cmpi.b  #$5f,$bfec01
;   beq tune0
;   cmpi.b  #$5d,$bfec01
;   beq tune1
;   cmpi.b  #$5a,$bfec01
;   beq tune2
;   cmpi.b  #$58,$bfec01
;   beq tune3
;   cmpi.b  #$57,$bfec01
;   beq tune4
;   cmpi.b  #$55,$bfec01
;   beq tune5
;   cmpi.b  #$52,$bfec01
;   beq tune6
;   rts
;
;tune0: move.w  #$0,d0
;   bsr jack
;   rts
;tune1: move.w  #$1,d0
;   bsr     jack
;   rts
;tune2: move.w  #$2,d0
;   bsr jack
;   rts
;tune3: move.w  #$2,d0
;   bsr jack1
;   rts
;tune4: move.w  #$3,d0
;   bsr jack1
;   rts
;tune5: move.w  #$4,d0
;   bsr jack1
;   rts
;tune6: move.w  #$5,d0
;   bsr jack1
;   rts
;
;jack:  jsr $50000
;   move.b  #$1,$bfec01
;   move.l  #$5010a,tel+2
;   rts
;
;jack1: jsr $40000
;   move.b  #$1,$bfec01
;   move.l  #$40136,tel+2
;   rts
;
;finish:    move.l  #$22f8,$dff080
;   jsr $50000
;   jsr $40000
;   move.w  #$f,$dff096
;   move.w  #$c000,$dff09a
;   move.l  #$1,$bfe001
;   rts

scr_data1:
    dc.w 0,0,0,0

scr_data2:
    dc.w 0,0,0,0

scr_data3:
    dc.w 0,0,0,0

scroller:
    movem.l d0-d6/a0-a6,-(a7)
    ;movem.l    $7fe00,d0-d7/a0-a6
    bsr scroll
    bsr scroll
    ;movem.l    d0-d7/a0-a6,$7fe00
    movem.l (a7)+,d0-d6/a0-a6
    rts

scroll:
    subi.w   #$0011,scroll_val  ;000007d0 : 0479 0011 0003 06a8      subi.w   #$0011,$000306a8
    addi.w   #$0001,scr_data1   ;000007d8 : 0679 0001 0003 0bd8      addi.w   #$0001,$00030bd8
    cmpi.w   #$0010,scr_data1   ;000007e0 : 0c79 0010 0003 0bd8      cmpi.w   #$0010,$00030bd8
    beq      l1                 ;000007e8 : 6700 0004                beq      $000007ee
    rts                         ;000007ec : 4e75                     rts
l1:
    clr.w    scr_data1          ;000007ee : 4279 0003 0bd8           clr.w    $00030bd8
    move.w   #$00ff,scroll_val  ;000007f4 : 33fc 00ff 0003 06a8      move.w   #$00ff,$000306a8
    lea      $000627f8,a1       ; the scroll is drawn here;000007fc : 43f9 0006 27f8           lea      $000627f8,a1       ; the scroll is drawn here
    lea      $000627fa,a3       ;00000802 : 47f9 0006 27fa           lea      $000627fa,a3
    lea      $00066678,a4       ;00000808 : 49f9 0006 6678           lea      $00066678,a4
    lea      $0006667a,a5       ;0000080e : 4bf9 0006 667a           lea      $0006667a,a5
s1:
    move.w   (a3)+,(a1)+        ;00000814 : 32db                     move.w   (a3)+,(a1)+
    move.w   (a5)+,(a4)+        ;00000816 : 38dd                     move.w   (a5)+,(a4)+
    cmpa.l   #$00063222,a3      ;00000818 : b7fc 0006 3222           cmpa.l   #$00063222,a3
    beq      t1                 ;0000081e : 6700 0008                beq      $00000828
    jmp      s1                 ;00000822 : 4ef9 0003 0c48           jmp      $00030c48
t1:
    addi.w   #$0001,$00030bdc   ;00000828 : 0679 0001 0003 0bdc      addi.w   #$0001,$00030bdc
    cmpi.w   #$0002,$00030bdc   ;00000830 : 0c79 0002 0003 0bdc      cmpi.w   #$0002,$00030bdc
    beq      l2                 ;00000838 : 6700 0004                beq      $0000083e
    rts                         ;0000083c : 4e75                     rts
l2:
    clr.w    $00030bdc          ;0000083e : 4279 0003 0bdc           clr.w    $00030bdc
    lea      $00030da0,a6       ;00000844 : 4df9 0003 0da0           lea      $00030da0,a6
    lea      $00037008,a0       ;0000084a : 41f9 0003 7008           lea      $00037008,a0
    clr.l    d0                 ;00000850 : 4280                     clr.l    d0
    move.b   (a2)+,d0           ;00000852 : 101a                     move.b   (a2)+,d0
    cmpi.b   #$20,d0            ;00000854 : 0c00 0020                cmpi.b   #$20,d0
    beq      s3                 ;00000858 : 6700 001c                beq      $00000876
    cmpi.b   #$ff,d0            ;0000085c : 0c00 00ff                cmpi.b   #$ff,d0
    beq      l3                 ;00000860 : 6700 002c                beq      $0000088e
    subi.b   #$41,d0            ;00000864 : 0400 0041                subi.b   #$41,d0
    mulu     #$0002,d0          ;00000868 : c0fc 0002                mulu     #$0002,d0
    adda.w   d0,a0              ;0000086c : dcc0                     adda.w   d0,a0
    adda.w   (a6),a6            ;0000086e : d0d6                     adda.w   (a6),a6
s2:
    bsr      l4                 ;00000870 : 6100 0030                bsr      $000008a2
    rts                         ;00000874 : 4e75                     rts
; duplicate code ?
s3:
    lea      chars,a0           ;00000876 : 41f9 0003 9800           lea      $00039800,a0
    jmp      s2                 ;0000087c : 4ef9 0003 0ca4           jmp      $00030ca4
    lea      chars,a0           ;00000882 : 41f9 0003 9800           lea      $00039800,a0
    jmp      s2                 ;00000888 : 4ef9 0003 0ca4           jmp      $00030ca4
l3:
    lea      chars,a0           ;0000088e : 41f9 0003 9800           lea      $00039800,a0
    lea      scrolltext,a2      ;00000894 : 45f9 0003 0de8           lea      $00030de8,a2
    jmp      s2                 ;0000089a : 4ef9 0003 0ca4           jmp      $00030ca4
    rts                         ;000008a0 : 4e75                     rts
l4:
    lea      $00062830,a1       ;000008a2 : 43f9 0006 2830           lea      $00062830,a1
s4:
    move.b   (a0)+,(a1)+        ;000008a8 : 12d8                     move.b   (a0)+,(a1)+
    addi.w   #$0001,scr_data3   ;000008aa : 0679 0001 0003 0be0      addi.w   #$0001,$00030be0
    cmpi.w   #$0004,scr_data3   ;000008b2 : 0c79 0004 0003 0be0      cmpi.w   #$0004,$00030be0
    beq      l5                 ;000008ba : 6700 0008                beq      $000008c4
    jmp      s4                 ;000008be : 4ef9 0003 0cdc           jmp      $00030cdc
l5:
    clr.w    scr_data3          ;000008c4 : 4279 0003 0be0           clr.w    $00030be0
    adda.w   #$0050,a4          ;000008ca : d0fc 0050                adda.w   #$0050,a4
    adda.w   #$0050,a4          ;000008ce : d2fc 0050                adda.w   #$0050,a4
    suba.w   #$0004,a4          ;000008d2 : 90fc 0004                suba.w   #$0004,a4
    suba.w   #$0004,a4          ;000008d6 : 92fc 0004                suba.w   #$0004,a4
    addi.w   #$0001,scr_data2   ;000008da : 0679 0001 0003 0bde      addi.w   #$0001,$00030bde
    cmpi.w   #$0020,scr_data2   ;000008e2 : 0c79 0020 0003 0bde      cmpi.w   #$0020,$00030bde
    beq      l6                 ;000008ea : 6700 0008                beq      $000008f4
    jmp      s4                 ;000008ee : 4ef9 0003 0cdc           jmp      $00030cdc
l6:
    clr.w    scr_data2          ;000008f4 : 4279 0003 0bde           clr.w    $00030bde
    clr.w    scr_data3          ;000008fa : 4279 0003 0be0           clr.w    $00030be0
    suba.w   #$0004,a4          ;00000900 : 90fc 0004                suba.w   #$0004,a4
    suba.w   #$09fc,a4          ;00000904 : 90fc 09fc                suba.w   #$09fc,a4
    adda.w   #$3e80,a4          ;00000908 : d0fc 3e80                adda.w   #$3e80,a4
    lea      $000666b0,a1       ;0000090c : 43f9 0006 66b0           lea      $000666b0,a1
s5:
    move.b   (a0)+,(a1)+        ;00000912 : 12d8                     move.b   (a0)+,(a1)+
    addi.w   #$0001,scr_data3   ;00000914 : 0679 0001 0003 0be0      addi.w   #$0001,$00030be0
    cmpi.w   #$0004,scr_data3   ;0000091c : 0c79 0004 0003 0be0      cmpi.w   #$0004,$00030be0
    beq      l7                 ;00000924 : 6700 0008                beq      $0000092e
    jmp      s5                 ;00000928 : 4ef9 0003 0d46           jmp      $00030d46
l7:
    clr.w    scr_data3          ;0000092e : 4279 0003 0be0           clr.w    $00030be0
    adda.w   #$0050,a4          ;00000934 : d0fc 0050                adda.w   #$0050,a4
    adda.w   #$0050,a4          ;00000938 : d2fc 0050                adda.w   #$0050,a4
    suba.w   #$0004,a4          ;0000093c : 90fc 0004                suba.w   #$0004,a4
    suba.w   #$0004,a4          ;00000940 : 92fc 0004                suba.w   #$0004,a4
    addi.w   #$0001,scr_data2   ;00000944 : 0679 0001 0003 0bde      addi.w   #$0001,$00030bde
    cmpi.w   #$0020,scr_data2   ;0000094c : 0c79 0020 0003 0bde      cmpi.w   #$0020,$00030bde
    beq      l8                 ;00000954 : 6700 0008                beq      $0000095e
    jmp      s5                 ;00000958 : 4ef9 0003 0d46           jmp      $00030d46
l8:
    clr.w    scr_data2          ;0000095e : 4279 0003 0bde           clr.w    $00030bde
    clr.w    scr_data3          ;00000964 : 4279 0003 0be0           clr.w    $00030be0
    rts                         ;0000096a : 4e75                     rts

;nos:
;   dc.b    $0,$4,$8,$c,$10,$14,$18,$1c
;   dc.b    $20,$24,$28,$2c,$30,$34,$38,$3c
;   dc.b    $40,$44,$48
;
;   dc.b    $0a,$50,$0a,$54,$0a,$58
;   dc.b    $0a,$5c,$0a,$60,$0a,$64
;   dc.b    $0a,$68,$0a,$6c
;   dc.b    $0a,$70,$0a,$74,$0a,$78
;   dc.b    $0a,$7c,$0a,$80,$0a,$84
;   dc.b    $0a,$88,$0a,$8c,$0a,$90
;   dc.b    $0a,$90,$0a,$90,$0a,$90
;   dc.b    $0a,$90,$0a,$90,$0a,$90
;   dc.b    $0a,$90,$0a,$90,$0a,$90

scrolltext:
   dc.b    ' hello '
   dc.b    $ff


numbers:
    dc.b    $11,$22,$33,$44,$55,$66,$77,$88
    dc.b    $77,$66,$55,$44,$33,$22,$11,$00
end:
    dc.b    $00,$00

    blk.l 40960,0

chars:
    incbin "Dev:Intro_Demo-Code/First_A500_Demo/bod_chrs"

;data:
;    incbin "Dev:Intro_Demo-Code/Lost_Demo_II/mod.twice2"

;tlb_logo
lostLogo:
    incbin "Dev:Intro_Demo-Code/First_A500_Demo/logo"

vert_scoll:
;lost_logo:
    incbin "Dev:Intro_Demo-Code/First_A500_Demo/vert_scroll"

    blk.l 4096,0

sentinel:
    incbin "Dev:Intro_Demo-Code/First_A500_Demo/sentinel_zax"

screen:
     blk.l 20480,0
