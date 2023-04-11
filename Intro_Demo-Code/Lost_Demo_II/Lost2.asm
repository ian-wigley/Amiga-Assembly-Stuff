;APS00000000000000000000000000000000000000000000000000000000000000000000000000000000
;
;    ***********************************;
;    *          Lost Demo II           *;
;    ***********************************;
;    *         Written in 1988.        *;
;    ***********************************;

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
    
rast:
    cmp.b #$ff,$00dff006
    bne rast
    bsr scroll
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

;    lea.l screen,a1
    lea.l image+$960,a1
    lea.l bplOneHigh,a3     ; Get a pointer to the $e0 address
    lea.l bplOneLow,a2      ; Get a pointer to the $e2 address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

    lea.l screen,a1
    lea.l image+$1dd8,a1 ;$1dd8,a1
    lea.l bplTwoHigh,a3     ; Get a pointer to the $e4 address
    lea.l bplTwoLow,a2      ; Get a pointer to the $e6 address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($e4 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($e6 address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

    lea.l screen,a1
    lea.l image+$3250,a1 ;19a4,a1 ;$1dd8,a1
    lea.l bplThreeHigh,a3   ; Get a pointer to the $e8 address
    lea.l bplThreeLow,a2    ; Get a pointer to the $ea address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($e8 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($ea address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

;    lea.l image+$19a4,a1
;    lea.l bplFourHigh,a3    ; Get a pointer to the $ec address
;    lea.l bplFourLow,a2     ; Get a pointer to the $ee address
;    move.l a1,d1            ; Copy pointer address into d1
;    move.w d1,(a2)          ; Copy the lower word into a2 ($ec address)
;    move.w (a2),d2          ; Copy the data from the pointer into d3
;    swap d1                 ; Flip d1
;    move.w d1,(a3)          ; Copy the lower word into a2 ($ee address)
;    move.w (a3),d3          ; Copy the data from the pointer into d3

;    lea.l image+$a000,a1
;    lea.l bplFiveHigh,a3    ; Get a pointer to the $f0 address
;    lea.l bplFiveLow,a2     ; Get a pointer to the $f2 address
;    move.l a1,d1            ; Copy pointer address into d1
;    move.w d1,(a2)          ; Copy the lower word into a2 ($f0 address)
;    move.w (a2),d2          ; Copy the data from the pointer into d3
;    swap d1                 ; Flip d1
;    move.w d1,(a3)          ; Copy the lower word into a2 ($f2 address)
;    move.w (a3),d3          ; Copy the data from the pointer into d3

;    lea.l screen,a1
;    lea.l chrBitPlaneOneHigh,a3    ; Get a pointer to the $f0 address
;    lea.l chrBitPlaneOneLow,a2     ; Get a pointer to the $f2 address
;    move.l a1,d1            ; Copy pointer address into d1
;    move.w d1,(a2)          ; Copy the lower word into a2 ($f0 address)
;    move.w (a2),d2          ; Copy the data from the pointer into d3
;    swap d1                 ; Flip d1
;    move.w d1,(a3)          ; Copy the lower word into a2 ($f2 address)
;    move.w (a3),d3          ; Copy the data from the pointer into d3
    rts

; Copper List ($000680CE)
copper:
    dc.w $0106,$0000,$01fc,$0000 ; AGA compatible
    dc.w $0096,$0020
	
    dc.w $1001,$ff00
    dc.w $0100,$0000
    dc.w $0180,$000f
    dc.w $2201,$ff00
    dc.w $0180,$000f
    dc.w $2301,$ff00
    dc.w $0180,$000e
    dc.w $2401,$ff00
    dc.w $0180,$000d
    dc.w $2501,$ff00
    dc.w $0180,$000c
    dc.w $2601,$ff00
    dc.w $0180,$000b
    dc.w $2701,$ff00
    dc.w $0180,$000a
    dc.w $2801,$ff00
    dc.w $0180,$0009
    dc.w $2901,$ff00
    dc.w $0180,$0008
    dc.w $2a01,$ff00
    dc.w $0180,$0007
    dc.w $2b01,$ff00
    dc.w $0180,$0006
    dc.w $2c01,$ff00
    dc.w $0180,$0005
    dc.w $2d01,$ff00
    dc.w $0180,$0004
    dc.w $2e01,$ff00
    dc.w $0180,$0003
    dc.w $2f01,$ff00
    dc.w $0180,$0002
    dc.w $3001,$fffe
    dc.w $0180,$0001
    dc.w $3101,$fffe
    dc.w $0180,$0000
    
;    dc.w $00e0
;    dc.w $0006
;    dc.w $00e2
;    dc.w $0000
    
;    dc.w $0182,$0fff
;	dc.w $0184,$0fff
;    dc.w $018a,$0fff
;    dc.w $018c,$0fff
;    dc.w $018e,$0fff
;    dc.w $01fe,$0000
	
;    dc.w $008e,$20a0
;    dc.w $0090,$40f0
;    dc.w $0092,$0030
;    dc.w $0094,$00e8
;    dc.w $0108,$0024
;    dc.w $010a,$0024
	
    dc.w $0100,$3000 ; Logo has only 3 bitplanes
    dc.w $0102,$0000

	
;    dc.w $008e,$2c81
;    dc.w $0090,$2cc1
	
    dc.w $0092,$0038
;	dc.w $0092,$0030 ; A500 value
;    dc.w $0094,$00a0 ;d0
    dc.w $0094,$00d0
; 	dc.w $0094,$00e8 ; A500 value
	
    dc.w $0108,$0028
;	dc.w $0108,$0024 ; A500 value
    dc.w $010a,$0028
;    dc.w $010a,$0024 ; A500 value 
    
	
;	dc.w $00e0
;    dc.w $0000;6
;	
;    dc.w $00e2
;    dc.w $0000;bfb0

    dc.w $00e0
bplOneHigh:
    dc.w $0000
    dc.w $00e2
bplOneLow:
    dc.w $0000
    dc.w $00e4
bplTwoHigh:
    dc.w $0000;4
    dc.w $00e6
bplTwoLow:
    dc.w $0000;68f6
    dc.w $00e8
bplThreeHigh:
    dc.w $0000;4
    dc.w $00ea
bplThreeLow:	
    dc.w $0000;7d6e

    dc.w $00ec
bplFourHigh:	
    dc.w $0000;4
    dc.w $00ee
bplFourLow:
    dc.w $0000;91e6
    dc.w $00f0
bplFiveHigh:
    dc.w $0000
    dc.w $00f2
bplFiveLow:
    dc.w $0000
;;    dc.w $00ee
;;    dc.w $91e6

    dc.w $008e,$2702 ;$20a0
    dc.w $0090,$49c0 ;$40f0
	
    dc.w $0180,$0000
    dc.w $0182,$0000;666
    dc.w $0184,$0fff
	
	dc.w $0186,$0777
    ;dc.w $0186,$0444;fff
;    dc.w $0188,$0777;fff
	dc.w $0188,$0444;fff
    dc.w $018a,$0999;fff
	
    dc.w $018c,$999;0666
	
    dc.w $018e,$fff;0666
    dc.w $0190,$fff;0444
    dc.w $0194,$fff;0777
    dc.w $0198,$fff;0999




;    dc.w $4201,$ff00
;    
;;    dc.w $00e2
;;    dc.w $bfb5
;    
;;    dc.w $0182,$0fff
;    dc.w $5001,$ff00
;    
;;    dc.w $00e2
;;    dc.w $bfba
;    
    dc.w $5301,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$00ff
    dc.w $5401,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$00ee
;    dc.w $5501,$ff00
    dc.w $5501,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$00dd
    dc.w $5601,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$00cc
    dc.w $5701,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$00bb
    dc.w $5801,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$00aa
    dc.w $5901,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$0099
    dc.w $5a01,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$0088
    dc.w $5b01,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$0077
    dc.w $5c01,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$0066
    dc.w $5d01,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$0055
    dc.w $5e01,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$0044
    dc.w $5f01,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$0033
    dc.w $6001,$ff00
;    
;;    dc.w $00e2
;;    dc.w $c050
    
    dc.w $0184,$0022
    dc.w $6101,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$0011
    dc.w $6201,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$0000
    dc.w $6301,$ff00
;    dc.w $01fe,$0000
    dc.w $0184,$00ee
    dc.w $6401,$ff00
    dc.w $6401,$ff00
    
;    dc.w $00e2
;    dc.w $bf8a
    
    dc.w $0184,$0000
    dc.w $6501,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0000
    dc.w $6601,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0000
    dc.w $0182,$0fff
    dc.w $6e01,$ff00
    
;    dc.w $00e2
;    dc.w $c01c
    
    dc.w $0180,$0000
    dc.w $7601,$ff00
    dc.w $0100,$0000
    dc.w $0180,$0100
    dc.w $7701,$ff00
    dc.w $0180,$0400
    dc.w $7801,$ff00
    dc.w $0180,$0600
    dc.w $7901,$ff00
    dc.w $0180,$0800
    dc.w $7a01,$ff00
    dc.w $0180,$0a00
    dc.w $7b01,$ff00
    dc.w $0180,$0c00
    dc.w $7c01,$ff00
    dc.w $0180,$0e00
    dc.w $7d01,$ff00
    dc.w $0180,$0f00
    dc.w $7e01,$ff00
    dc.w $0180,$0e00
    dc.w $7f01,$ff00
    dc.w $0180,$0c00
    dc.w $8001,$ff00
    dc.w $0180,$0a00
    dc.w $8101,$ff00
    dc.w $0180,$0800
    dc.w $8201,$ff00
    dc.w $0180,$0600
    dc.w $8301,$ff00
    dc.w $0180,$0400
    dc.w $8401,$ff00
    dc.w $0180,$0200
    dc.w $8501,$ff00
    dc.w $0180,$0100
    dc.w $8f01,$ff00
    dc.w $0180,$0000
    dc.w $aa01,$ff00
	
    dc.w $008e,$0089
    dc.w $0090,$00c2
;
;    dc.w $008e,$2702 ;$20a0
;    dc.w $0090,$49c0 ;$40f0
    dc.w $0092,$0030
    dc.w $0094,$00d8

    dc.w $ab01,$ff00
    dc.w $0100,$1000
 

; ## Scroll bitplanes ##
 
    dc.w $00e0
    dc.w $0007
    dc.w $00e2
    dc.w $0000
    dc.w $00e4
    dc.w $0007
    dc.w $00e6
    dc.w $0370
    dc.w $00e8
    dc.w $0007
    dc.w $00ea
    dc.w $06e0
    
    dc.w $0182,$0fff
    dc.w $0188,$0a71
    dc.w $018a,$0d93
    dc.w $018c,$0fc5
    dc.w $0108,$0000
    dc.w $010a,$0000
    dc.w $ad01,$ff00
    dc.w $0182,$0111
    dc.w $ae01,$ff00
    dc.w $0182,$0333
    dc.w $af01,$ff00
    dc.w $0182,$0555
    dc.w $b001,$ff00
    dc.w $0182,$0777
    dc.w $b101,$ff00
    dc.w $0182,$0999
    dc.w $b201,$ff00
    dc.w $0182,$0bbb
    dc.w $b301,$ff00
    dc.w $0182,$0ddd
    dc.w $b401,$ff00
    dc.w $0182,$0fff
    dc.w $b601,$ff00
    dc.w $0182,$0ddd
    dc.w $b701,$ff00
    dc.w $0182,$0bbb
    dc.w $b801,$ff00
    dc.w $0182,$0999
    dc.w $b901,$ff00
    dc.w $0182,$0777
    dc.w $ba01,$ff00
    dc.w $0182,$0555
    dc.w $bb01,$ff00
    dc.w $0182,$0333
    dc.w $bc01,$ff00
    dc.w $0182,$0111
    dc.w $bf01,$ff00
	
    dc.w $0100,$0000
	
    dc.w $c001,$ff00
    dc.w $0180,$0006
	
;	dc.w $00e0
;    dc.w $0007
;	dc.w $00e4
;    dc.w $0007
;	dc.w $00e8
;    dc.w $0007
	
	dc.w $c201,$ff00
	
;    dc.w $00e2
;    dc.w $0318
;    dc.w $00e6
;    dc.w $0688
;    dc.w $00ea
;	dc.w $09f8

	dc.w $0100,$3000
    dc.w $c301,$ff00
	
    dc.w $00e2
    dc.w $02c0
    dc.w $00e6
    dc.w $0630
	dc.w $00ea
	dc.w $09a0
	
    dc.w $0100,$3000
    dc.w $c401,$ff00
	
;    dc.w $00e2
;    dc.w $0268
;	dc.w $00e6
;	dc.w $05d8
;    dc.w $00ea
;	dc.w $0948

	dc.w $0100,$3000
    dc.w $c501,$ff00
	
;    dc.w $00e2
;    dc.w $0210
;	dc.w $00e6
;    dc.w $0580
;    dc.w $00ea
;	dc.w $08f0
	
	dc.w $0100,$3000
    dc.w $c601,$ff00
	
;    dc.w $00e2
;    dc.w $01b8
;	dc.w $00e6
;    dc.w $0528
;	dc.w $00ea
;    dc.w $0898
	
	dc.w $0100,$3000
    dc.w $c701,$ff00
	
;    dc.w $00e2
;    dc.w $0160
;    dc.w $00e6
;    dc.w $04d0
;    dc.w $00ea
;	dc.w $0840
	
    dc.w $0100,$3000
    dc.w $c801,$ff00
	
;    dc.w $00e2
;    dc.w $0108
;	dc.w $00e6
;    dc.w $0478
;	dc.w $00ea
;	dc.w $07e8
	
    dc.w $0100,$3000
    dc.w $c901,$ff00
	
;    dc.w $00e2
;    dc.w $00b0
;	dc.w $00e6
;	dc.w $0420
;	dc.w $00ea
;    dc.w $0790
	
    dc.w $0100,$3000
	dc.w $ca01,$ff00
	
;	dc.w $00e2
;    dc.w $0058
;	dc.w $00e6
;    dc.w $03c8
;	dc.w $00ea
;    dc.w $0738
	
	dc.w $0100,$3000
    dc.w $cb01,$ff00
	
;    dc.w $00e2
;    dc.w $0000
;	dc.w $00e6
;    dc.w $0370
;	dc.w $00ea
;    dc.w $06e0

    dc.w $0100,$3000
    dc.w $cc01,$ff00
    dc.w $0100,$0000
    dc.w $cd01,$ff00
    dc.w $0180,$0000
    dc.w $e001,$ff00
    dc.w $0100,$0000
    dc.w $e101,$ff00

; ### TODO Fix below ###	
;    dc.w $0100,$1000
;    dc.w $008e,$0080
;    dc.w $0090,$00a0
;    dc.w $0092,$0040
;    dc.w $0094,$00f0
;    dc.w $0108,$0000
;    dc.w $0108,$0000
;    dc.w $010a,$0000
	
;    dc.w $00e0
;    dc.w $0006
;	dc.w $00e2
;    dc.w $d258
	
    dc.w $e201,$ff00
    dc.w $0180,$0110
    dc.w $0182,$0111
    dc.w $e301,$ff00
    dc.w $0180,$0220
    dc.w $0182,$0333
    dc.w $e401,$ff00
    dc.w $0180,$0330
    dc.w $0182,$0555
    dc.w $e501,$ff00
    dc.w $0180,$0440
    dc.w $0182,$0777
    dc.w $e601,$ff00
    dc.w $0180,$0550
    dc.w $0182,$0fff
    dc.w $e701,$ff00
    dc.w $0180,$0660
    dc.w $e801,$ff00
    dc.w $0180,$0770
    dc.w $e901,$ff00
    dc.w $0180,$0880
    dc.w $ea01,$ff00
    dc.w $0180,$0990
    dc.w $eb01,$ff00
    dc.w $0180,$0aa0
    dc.w $ec01,$ff00
    dc.w $0180,$0bb0
    dc.w $ed01,$ff00
    dc.w $0180,$0cc0
    dc.w $ee01,$ff00
    dc.w $0180,$0dd0
    dc.w $ef01,$ff00
    dc.w $0180,$0ee0
    dc.w $f001,$f001
    dc.w $ff00,$ff00
    dc.w $0180,$0ff0
    dc.w $0102,$0011
    dc.w $f101,$ff00
    dc.w $0180,$0ee0
    dc.w $f201,$f201
    dc.w $ff00,$ff00
    dc.w $0180,$0dd0
    dc.w $f301,$ff00
    dc.w $0180,$0cc0
    dc.w $f401,$ff00
    dc.w $0180,$0bb0
    dc.w $f501,$ff00
    dc.w $0180,$0aa0
    dc.w $f601,$ff00
    dc.w $0180,$0990
    dc.w $f701,$ff00
    dc.w $0180,$0880
    dc.w $f801,$ff00
    dc.w $0180,$0770
    dc.w $f901,$ff00
    dc.w $0180,$0660
    dc.w $fa01,$ff00
    dc.w $0180,$0550
    dc.w $fb01,$ff00
    dc.w $0180,$0440
    dc.w $0182,$0777
    dc.w $fc01,$ff00
    dc.w $0180,$0330
    dc.w $0182,$0555
    dc.w $fd01,$ff00
    dc.w $0180,$0220
    dc.w $0182,$0333
    dc.w $fe01,$ff00
    dc.w $0180,$0111
    dc.w $0182,$0111
    dc.w $0100,$0000
    dc.w $ff01,$ff00
    dc.w $0180,$0000
    dc.w $ffe1,$ffee
;    dc.w $01fe,$0000
    dc.w $0011,$ffee
    dc.w $2001,$ff00
    dc.w $0180,$0002
    dc.w $2201,$ff00
    dc.w $0180,$0003
    dc.w $2301,$ff00
    dc.w $0180,$0004
    dc.w $2401,$ff00
    dc.w $0180,$0005
    dc.w $2501,$ff00
    dc.w $0180,$0006
    dc.w $2601,$ff00
    dc.w $0180,$0007
    dc.w $2701,$ff00
    dc.w $0180,$0008
    dc.w $2801,$ff00
    dc.w $0180,$0009
    dc.w $2a01,$ff00
    dc.w $0180,$000a
    dc.w $2b01,$ff00
    dc.w $0180,$000b
    dc.w $2c01,$ff00
    dc.w $0180,$000c
    dc.w $2d01,$ff00
    dc.w $0180,$000d
    dc.w $2e01,$ff00
    dc.w $0180,$000e
    dc.w $2f01,$ff00
    dc.w $0180,$000f
    dc.w $4001,$ff00
    dc.w $0180,$0000
    dc.w $ffff,$fffe
; End of Copper List








;;    dc.w $0096,$0020
;;    dc.w $0100,$5000
;;    dc.w $0102,$0000
;;    dc.w $0092,$0034
;;    dc.w $0094,$00cc
;;    dc.w $0108,$0000
;;    dc.w $010a,$0000
;    dc.w $00e0
;bplOneHigh:
;    dc.w $0000
;    dc.w $00e2
;bplOneLow:
;    dc.w $0000
;    dc.w $00e4
;bplTwoHigh:
;    dc.w $0000
;    dc.w $00e6
;bplTwoLow:
;    dc.w $0000
;    dc.w $00e8
;bplThreeHigh:
;    dc.w $0000
;    dc.w $00ea
;bplThreeLow:
;    dc.w $0000
;    dc.w $00ec
;bplFourHigh:
;    dc.w $0000
;    dc.w $00ee
;bplFourLow:
;    dc.w $0000
;    dc.w $00f0
;bplFiveHigh:
;    dc.w $0000
;    dc.w $00f2
;bplFiveLow:
;    dc.w $0000
;;    dc.w $008e,$2702
;;    dc.w $0090,$49c0
;;    dc.w $0180,$0000
;;    dc.w $0182,$0222
;;    dc.w $0184,$0555
;;    dc.w $0186,$0777
;;    dc.w $0188,$0999
;;    dc.w $018a,$0ccc
;;    dc.w $018c,$0faa
;;    dc.w $018e,$0e66
;;    dc.w $0190,$0310
;;    dc.w $0192,$0420
;;    dc.w $0194,$0620
;;    dc.w $0196,$0731
;;    dc.w $0198,$0941
;;    dc.w $019a,$0a52
;;    dc.w $019c,$0b64
;;    dc.w $019e,$0b86
;;    dc.w $01a0,$0c98
;;    dc.w $01a2,$0dba
;;    dc.w $01a4,$0edc
;;    dc.w $01a6,$0fff
;;    dc.w $01a8,$0040
;;    dc.w $01aa,$0111
;;    dc.w $01ac,$0bbf
;;    dc.w $01ae,$09bf
;;    dc.w $01b0,$0200
;;    dc.w $01b2,$0b8f
;;    dc.w $01b4,$068f
;;    dc.w $01b6,$0300
;;    dc.w $01b8,$0700
;;    dc.w $01ba,$0eef
;;    dc.w $01bc,$0d80
;;    dc.w $01be,$0fe0
;;    dc.w $ffe1,$fffe
;;    dc.w $01fe,$0000
;;    dc.w $0011,$fffe
;;    dc.w $0801,$fffe
;;    dc.w $0100,$0000
;;    dc.w $0901,$fffe
;;    dc.w $008e,$2840
;;    dc.w $0090,$49e0
;;    dc.w $0092,$0020
;;    dc.w $0094,$01e0
;;    dc.w $0108,$0024
;;    dc.w $010a,$0024
;;    dc.w $0a01,$fffe
    dc.w $0180
barOne:
    dc.w $0eee
;    dc.w $0b01,$fffe
;    dc.w $0180,$0000
;    dc.w $0c01,$fffe
;    dc.w $0100,$1000
;    dc.w $0182,$0111
    dc.w $00e0
chrBitPlaneOneHigh:
    dc.w $0007
    dc.w $00e2
chrBitPlaneOneLow:
    dc.w $0000
;    dc.w $0d01,$ff00
;    dc.w $0182,$0222
;    dc.w $0e01,$fffe
;    dc.w $0180,$0000
;    dc.w $0182,$0333
;    dc.w $0f01,$ff00
;    dc.w $0180,$0000
;    dc.w $0182,$0444
;    dc.w $1001,$fffe
;    dc.w $0180,$0100
;    dc.w $0182,$0555
;    dc.w $1101,$ff00
;    dc.w $0180,$0200
;    dc.w $0182,$0666
;    dc.w $1201,$ff00
;    dc.w $0180,$0300
;    dc.w $0182,$0777
;    dc.w $1301,$ff00
;    dc.w $0180,$0400
;    dc.w $0182,$0888
;    dc.w $1401,$ff00
;    dc.w $0180,$0500
;    dc.w $0182,$0999
;    dc.w $1501,$ff00
;    dc.w $0180,$0600
;    dc.w $0182,$0aaa
;    dc.w $1601,$ff00
;    dc.w $0180,$0700
;    dc.w $0182,$0bbb
;    dc.w $1701,$ff00
;    dc.w $0180,$0800
;    dc.w $0182,$0ccc
;    dc.w $1801,$ff00
;    dc.w $0180,$0900
;    dc.w $0182,$0ddd
;    dc.w $1901,$ff00
;    dc.w $0180,$0a00
;    dc.w $0182,$0eee
;    dc.w $1a01,$ff00
;    dc.w $0180,$0b00
;    dc.w $0182,$0fff
;    dc.w $1b01,$ff00
;    dc.w $0180,$0a00
;    dc.w $0182,$0eee
;    dc.w $1c01,$ff00
;    dc.w $0180,$0900
;    dc.w $0182,$0ddd
;    dc.w $1d01,$ff00
;    dc.w $0180,$0800
;    dc.w $0182,$0ccc
;    dc.w $1e01,$ff00
;    dc.w $0180,$0700
;    dc.w $0182,$0bbb
;    dc.w $1f01,$ff00
;    dc.w $0180,$0600
;    dc.w $0182,$0aaa
;    dc.w $2001,$ff00
;    dc.w $0180,$0500
;    dc.w $0182,$0999
;    dc.w $2101,$ff00
;    dc.w $0180,$0400
;    dc.w $0182,$0888
;    dc.w $2201,$ff00
;    dc.w $0180,$0300
;    dc.w $0182,$0777
;    dc.w $2301,$ff00
;    dc.w $0180,$0200
;    dc.w $0182,$0666
;    dc.w $2401,$ff00
;    dc.w $0180,$0100
;    dc.w $0182,$0555
;    dc.w $2501,$ff00
;    dc.w $0180,$0000
;    dc.w $0182,$0444
;    dc.w $2601,$ff00
;    dc.w $0180,$0000
;    dc.w $0182,$0333
;    dc.w $2701,$ff00
;    dc.w $0180,$0000
;    dc.w $0182,$0222
;    dc.w $2801,$ff00
;    dc.w $0182,$0111
;    dc.w $0180,$0000
;    dc.w $2901,$ff00
;    dc.w $0180,$0000
;    dc.w $0100,$0000
;    dc.w $2a01,$ff00
    dc.w $0180
barTwo:
    dc.w $0eee
;    dc.w $2b01,$ff00
;    dc.w $2b01,$ff00
;    dc.w $0180,$0000
;    dc.w $ffff,$fffe
; End of Copper List

start_muzak:
    move.l  #data,muzakoffset   ;** get offset

init0:  move.l  muzakoffset,a0  ;** get highest used pattern
    add.l   #472,a0
    move.l  #$80,d0
    clr.l   d1
init1:  move.l  d1,d2
    subq.w  #1,d0
init2:  move.b  (a0)+,d1
    cmp.b   d2,d1
    bgt.s   init1
    dbf d0,init2
    addq.b  #1,d2

init3:  move.l  muzakoffset,a0      ;** calc samplepointers
    lea pointers,a1
    mulu    #1024,d2
    add.l   #600,d2
    add.l   a0,d2
    move.l  #15-1,d0
init4:  move.l  d2,(a1)+
    clr.l   d1
    move.w  42(a0),d1
    lsl.l   #1,d1
    add.l   d1,d2
    add.l   #30,a0
    dbf d0,init4

init5:  move.w  #$0,$dff0a8     ;** clear used values
    move.w  #$0,$dff0b8
    move.w  #$0,$dff0c8
    move.w  #$0,$dff0d8
    clr.w   timpos
    clr.l   trkpos
    clr.l   patpos

init6:  move.l  muzakoffset,a0      ;** initialize timer irq
    move.b  470(a0),numpat+1    ;number of patterns
    move.l  #240,d0
    sub.b   471(a0),d0
    mulu    #122,d0
    move.b  #$0,$bfde00
    move.b  d0,$bfd400
    lsr.w   #8,d0
    move.b  d0,$bfd500
    move.b  #$81,$bfdd00
    move.b  #$11,$bfde00
    move.l  $78,lev6save
    move.l  #lev6interrupt,$78
    rts

stop_muzak:
    move.b  #$1,$bfdd00     ;** restore timer & dma
    move.l  lev6save,$78
    move.w  #$0,$dff0a8
    move.w  #$0,$dff0b8
    move.w  #$0,$dff0c8
    move.w  #$0,$dff0d8
    move.w  #$f,$dff096
    rts

lev6interrupt:
    movem.l d0/d1,-(sp)     ;** jump
    bsr replay_muzak
    move.b  $bfdd00,d0
    move.w  #$2000,$dff09c
    movem.l (sp)+,d0/d1
    rte

replay_muzak:
    movem.l d0-d7/a0-a6,-(a7)
    addq.w  #1,timpos
speed:  cmp.w   #6,timpos
    beq replaystep

chaneleffects:              ;** seek effects
    lea datach0,a6
    tst.b   3(a6)
    beq.s   ceff1
    lea $dff0a0,a5
    bsr.s   ceff5
ceff1:  lea datach1,a6
    tst.b   3(a6)
    beq.s   ceff2
    lea $dff0b0,a5
    bsr.s   ceff5
    
ceff2:  lea datach2,a6
    tst.b   3(a6)
    beq.s   ceff3
    lea $dff0c0,a5
    bsr.s   ceff5
ceff3:  lea datach3,a6
    tst.b   3(a6)
    beq.s   ceff4
    lea $dff0d0,a5
    bsr.s   ceff5
ceff4:  movem.l (a7)+,d0-d7/a0-a6
    rts

ceff5:  move.b  2(a6),d0        ;room for some more
    and.b   #$0f,d0         ;implementations below
    tst.b   d0
    beq.s   arpreggiato
    cmp.b   #1,d0
    beq pitchup
    cmp.b   #2,d0
    beq pitchdown
    cmp.b   #12,d0
    beq setvol
    cmp.b   #14,d0
    beq setfilt
    cmp.b   #15,d0
    beq setspeed
    rts

arpreggiato:                ;** spread by time
    cmp.w   #1,timpos
    beq.s   arp1
    cmp.w   #2,timpos
    beq.s   arp2
    cmp.w   #3,timpos
    beq.s   arp3
    cmp.w   #4,timpos
    beq.s   arp1
    cmp.w   #5,timpos
    beq.s   arp2
    rts

arp1:   clr.l   d0          ;** get higher note-values
    move.b  3(a6),d0        ;   or play original
    lsr.b   #4,d0
    bra.s   arp4
arp2:   clr.l   d0
    move.b  3(a6),d0
    and.b   #$0f,d0
    bra.s   arp4
arp3:   move.w  16(a6),d2
    bra.s   arp6
arp4:   lsl.w   #1,d0
    clr.l   d1
    move.w  16(a6),d1
    lea notetable,a0
arp5:   move.w  (a0,d0.w),d2
    cmp.w   (a0),d1
    beq.s   arp6
    addq.l  #2,a0
    bra.s   arp5
arp6:   move.w  d2,6(a5)
    rts

pitchdown:
    bsr newrou
    clr.l   d0
    move.b  3(a6),d0
    and.b   #$0f,d0
    add.w   d0,(a4)
    cmp.w   #$358,(a4)
    bmi.s   ok1
    move.w  #$358,(a4)
ok1:    move.w  (a4),6(a5)
    rts

pitchup:bsr newrou
    clr.l   d0
    move.b  3(a6),d0
    and.b   #$0f,d0
    sub.w   d0,(a4)
    cmp.w   #$71,(a4)
    bpl.s   ok2
    move.w  #$71,(a4)
ok2:    move.w  (a4),6(a5)
    rts

setvol: move.b  3(a6),8(a5)
    rts

setfilt:move.b  3(a6),d0
    and.b   #$01,d0
    asl.b   #$01,d0
    and.b   #$fd,$bfe001
    or.b    d0,$bfe001
    rts

setspeed:
    clr.l   d0
    move.b  3(a6),d0
    and.b   #$0f,d0
    move.w  d0,speed+2
    rts

newrou: cmp.l   #datach0,a6
    bne.s   next1
    lea voi1,a4
    rts
next1:  cmp.l   #datach1,a6
    bne.s   next2
    lea voi2,a4
    rts
next2:  cmp.l   #datach2,a6
    bne.s   next3
    lea voi3,a4
    rts
next3:  lea voi4,a4
    rts

replaystep:             ;** work next pattern-step
    clr.w   timpos
    move.l  muzakoffset,a0
    move.l  a0,a3
    add.l   #12,a3          ;ptr to soundprefs
    move.l  a0,a2
    add.l   #472,a2         ;ptr to pattern-table
    add.l   #600,a0         ;ptr to first pattern
    clr.l   d1
    move.l  trkpos,d0       ;get ptr to current pattern
    move.b  (a2,d0),d1
    mulu    #1024,d1
    add.l   patpos,d1       ;get ptr to current step
    clr.w   enbits
    lea $dff0a0,a5      ;chanel 0
    lea datach0,a6
    bsr chanelhandler

    lea $dff0b0,a5      ;chanel 1
    lea datach1,a6
    bsr chanelhandler

    lea $dff0c0,a5      ;chanel 2
    lea datach2,a6
    bsr chanelhandler

    lea $dff0d0,a5          ;chanel 3
    lea datach3,a6
    bsr chanelhandler

    move.l  #400,d0         ;** wait a while and set len
rep1:   dbf d0,rep1         ;   of oneshot to 1 word
    move.l  #$8000,d0
    or.w    enbits,d0
    move.w  d0,$dff096
    cmp.w   #1,datach0+14
    bne.s   rep2
    clr.w   datach0+14
    move.w  #1,$dff0a4
    
rep2:   cmp.w   #1,datach1+14
    bne.s   rep3
    clr.w   datach1+14
    move.w  #1,$dff0b4
    
rep3:   cmp.w   #1,datach2+14
    bne.s   rep4
    clr.w   datach2+14
    move.w  #1,$dff0c4
    
rep4:   cmp.w   #1,datach3+14
    bne.s   rep5
    clr.w   datach3+14
    move.w  #1,$dff0d4

rep5:   add.l   #16,patpos      ;next step
    cmp.l   #64*16,patpos       ;pattern finished ?
    bne rep6
    clr.l   patpos
    addq.l  #1,trkpos       ;next pattern in table
    clr.l   d0
    move.w  numpat,d0
    cmp.l   trkpos,d0       ;song finished ?
    bne rep6
    clr.l   trkpos
rep6:   movem.l (a7)+,d0-d7/a0-a6
    rts

chanelhandler:
    move.l  (a0,d1.l),(a6)      ;get period & action-word
    addq.l  #4,d1           ;point to next chanel
    clr.l   d2
    move.b  2(a6),d2        ;get nibble for soundnumber
conti:  lsr.b   #4,d2
    beq.s   chan2           ;no soundchange !
    move.l  d2,d4           ;** calc ptr to sample
    lsl.l   #2,d2
    mulu    #30,d4
    lea pointers-4,a1
    move.l  (a1,d2.l),4(a6)     ;store sample-address
    move.w  (a3,d4.l),8(a6)     ;store sample-len in words
    move.w  2(a3,d4.l),18(a6)   ;store sample-volume

    move.l  d0,-(a7)
    move.b  2(a6),d0
    and.b   #$0f,d0
    cmp.b   #$0c,d0
    bne.s   ok3
    move.b  3(a6),8(a5)
    bra.s   ok4
ok3:    move.w  2(a3,d4.l),8(a5)    ;change chanel-volume
ok4:    move.l  (a7)+,d0

    clr.l   d3
    move.w  4(a3,d4),d3         ;** calc repeatstart
    add.l   4(a6),d3
    move.l  d3,10(a6)           ;store repeatstart
    move.w  6(a3,d4),14(a6)     ;store repeatlength
    cmp.w   #1,14(a6)
    beq.s   chan2               ;no sustainsound !
    move.l  10(a6),4(a6)        ;repstart  = sndstart
    move.w  6(a3,d4),8(a6)      ;replength = sndlength
chan2:  cmp.w   #0,(a6)
    beq.s   chan4               ;no new note set !
    move.w  22(a6),$dff096      ;clear dma
    cmp.w   #0,14(a6)
    bne.s   chan3               ;no oneshot-sample
    move.w  #1,14(a6)           ;allow resume (later)
chan3:  bsr newrou
    move.w  (a6),(a4)
    move.w  (a6),16(a6)     ;save note for effect
    move.l  4(a6),0(a5)     ;set samplestart
    move.w  8(a6),4(a5)     ;set samplelength
    move.w  (a6),6(a5)      ;set period
    move.w  22(a6),d0
    or.w    d0,enbits       ;store dma-bit
    move.w  18(a6),20(a6)       ;volume trigger
chan4:  rts

datach0:    dc.w    0,0,0,0,0,0,0,0,0,0,0,1
datach1:    dc.w    0,0,0,0,0,0,0,0,0,0,0,2
datach2:    dc.w    0,0,0,0,0,0,0,0,0,0,0,4
datach3:    dc.w    0,0,0,0,0,0,0,0,0,0,0,8
voi1:       dc.w    0
voi2:       dc.w    0
voi3:       dc.w    0
voi4:       dc.w    0
pointers:   dc.l    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
notetable:  dc.w    856,808,762,720,678,640,604,570
            dc.w    538,508,480,453,428,404,381,360
            dc.w    339,320,302,285,269,254,240,226  
            dc.w    214,202,190,180,170,160,151,143
            dc.w    135,127,120,113,000
muzakoffset:dc.l    0
lev6save:   dc.l    0
trkpos:     dc.l    0
patpos:     dc.l    0
numpat:     dc.w    0
enbits:     dc.w    0
timpos:     dc.w    0

switch:		dc.b	0, 0

;scroll:	
;;    movem.l $7fe00,a0-a6/d0-d7
;    movem.l d0-d6/a0-a6,-(a7)
; 	btst	#$0,switch
;	beq	roll
;	rts
;roll:
;	lea	$dff000,a0
;	move.w	#$c9f0,$40(a0);c9f0
;	move.w	#$0000,$42(a0)
;	move.w	#$ffff,$44(a0)
;	move.w	#$ffff,$46(a0)
;	move.l 	#$00070002,$50(a0)
;	move.l 	#$00070000,$54(a0)
;	move.w 	#$1026,$58(a0);1026
;	move.w	#$0000,$64(a0)
;	move.w	#$0000,$66(a0)
;bmx:	
;    btst #$e,$02(a0)
;	bne	bmx
;
;;	move.w	#$c9f0,$40(a0);c9f0
;;	move.w	#$0000,$42(a0)
;;	move.w	#$ffff,$44(a0)
;;	move.w	#$ffff,$46(a0)
;;	move.l	#$00070370,$50(a0)
;;	move.l	#$0007036e,$54(a0)
;;	move.w	#$0658,$58(a0)
;;	move.w	#$0000,$64(a0)
;;	move.w	#$0000,$66(a0)
;;bx:	
;;    btst #$0006,$02(a0)
;;	bne	bx
;;
;;	move.w	#$c9f0,$40(a0)
;;	move.w	#$0000,$42(a0)
;;	move.w	#$ffff,$44(a0)
;;	move.w	#$ffff,$46(a0)
;;	move.l	#$000706e0,$50(a0)
;;	move.l	#$000706de,$54(a0)
;;	move.w	#$0658,$58(a0)
;;	move.w	#$0000,$64(a0)
;;	move.w	#$0000,$66(a0)
;;
;;by:	
;;    btst #$0006,$02(a0)
;;	bne	by
;
;	sub.b 	#1,bufleft
;	bne 	scrlend
;	move.b 	#5,bufleft
;	move.l 	textadr,a1
;	lea 	wachrs,a2	;Address of Chars
;	lea 	ekschr,a3
;	lea 	$7002e,a4	;Address of Screen
;	clr.l 	d0
;	clr.l 	d1
;	move.b	(a1)+,d1
;	cmp.b	#$2f,(a1)
;	bne	fksloop
;	bsr	sod
;fksloop:
;    cmp.b #$23,(a1)
;	bne	gksloop
;	bsr	sod1
;gksloop:
;    cmp.b #$24,(a1)
;	bne	eksloop
;	bsr	sod2
;eksloop:
;    cmp.b (a3)+,d1
;	beq found
;	addq #1,d0
;	tst.b (a3)
;	bne eksloop
;	bra notf
;found:
;    add.b #123,d0
;	move.b d0,d1
;notf:	
;    sub.b #97,d1
;	muls #80,d1
;	add.l d1,a2
;	move.w #19,d0
;scrloop:
;    move.l 3520(a2),$370(a4)
;	move.l 7040(a2),$6e0(a4)
;	move.l (a2)+,(a4)
;	lea 84(a4),a4
;	dbf d0,scrloop
;	tst.b (a1)
;	bne	qq
;	lea text,a1
;qq:	
;    move.l 	a1,textadr
;scrlend:
;;    movem.l $7fe00,a0-a6/d0-d7
;    movem.l (a7)+,d0-d6/a0-a6
;	rts

; Blitter Scroll ($00068392)
scroll:
    movem.l d0-d6/a0-a6,-(a7)
rollon:
    lea $dff000,a0
    move.l #$70000,$50(a0)
    move.l #$6fffe,$54(a0)
    clr.l $64(a0)
    move.l #$ffffffff,$44(a0)
    move.w #$c9f0,$40(a0)
    clr.w $42(a0)
    move.w #$0cd7,$58(a0)
bw:
    btst #$0006,$02(a0)
    bne bw

    sub.b #1,bufleft
    bne scrlend
    move.b #8,bufleft
    clr.l d0
    clr.l d1
    lea wachrs,a2
    lea ekschr,a3
    lea $70030,a4
    move.l textadr,a1
    move.b (a1)+,d1
    cmpi.b #$23,(a1)
    bne eksloop
eksloop:
    cmp.b (a3)+,d1
    beq found
    addq #1,d0
    tst.b (a3)
    bne eksloop
    bra notf
found:
    add.b #123,d0
    move.b d0,d1
notf:
    sub.b #97,d1
    muls #112,d1
    add.l d1,a2
    move.w #29,d0
scrloop:
    move.l (a2)+,(a4)
    add.l #84,a4
    dbf d0,scrloop
    tst.b (a1)
    bne qq
    lea text,a1
qq:
    move.l a1,textadr
scrlend:
    movem.l (a7)+,d0-d6/a0-a6
    rts


;000316F0 0839 0000 0003 16ee      BTST.B #$0000,$000316ee [01]
;000316F8 6700 0004                BEQ.W #$0004 == $000316fe (F)
;000316FC 4e75                     RTS
;000316FE 48e7 fffe                MOVEM.L D0-D7/A0-A6,-(A7)
;00031702 41f9 00df f000           LEA.L $00dff000,A0
;00031708 217c 0007 0000 0050      MOVE.L #$00070000,(A0,$0050) == $00000050 [00fc07f8]
;00031710 217c 0006 fffe 0054      MOVE.L #$0006fffe,(A0,$0054) == $00000054 [00fc07f8]
;00031718 42a8 0064                CLR.L (A0,$0064) == $00000064 [00fc0c52]
;0003171C 217c ffff ffff 0044      MOVE.L #$ffffffff,(A0,$0044) == $00000044 [00fc07f8]
;00031724 317c c9f0 0040           MOVE.W #$c9f0,(A0,$0040) == $00000040 [00fc]
;0003172A 4268 0042                CLR.W (A0,$0042) == $00000042 [07f8]
;0003172E 317c 1026 0058           MOVE.W #$1026,(A0,$0058) == $00000058 [00fc]
;00031734 0828 0006 0002           BTST.B #$0006,(A0,$0002) == $00000002 [00]
;0003173A 6600 fff8                BNE.W #$fff8 == $00031734 (T)
;0003173E 0439 0001 0003 17ff      SUB.B #$01,$000317ff [05]
;00031746 6600 009a                BNE.W #$009a == $000317e2 (T)
;0003174A 13fc 0005 0003 17ff      MOVE.B #$05,$000317ff [05]
;00031752 2279 0003 17e8           MOVEA.L $000317e8 [00031b3b],A1
;00031758 45f9 0004 1000           LEA.L $00041000,A2
;0003175E 47f9 0003 17ec           LEA.L $000317ec,A3
;00031764 49f9 0007 002a           LEA.L $0007002a,A4
;0003176A 4280                     CLR.L D0
;0003176C 4281                     CLR.L D1
;0003176E 1219                     MOVE.B (A1)+ [08],D1
;00031770 0c11 002f                CMP.B #$2f,(A1) [08]
;00031774 6600 0006                BNE.W #$0006 == $0003177c (T)
;00031778 6100 00ba                BSR.W #$00ba == $00031834
;0003177C 0c11 0023                CMP.B #$23,(A1) [08]
;00031780 6600 0006                BNE.W #$0006 == $00031788 (T)
;00031784 6100 00b8                BSR.W #$00b8 == $0003183e
;00031788 0c11 0024                CMP.B #$24,(A1) [08]
;0003178C 6600 0006                BNE.W #$0006 == $00031794 (T)
;00031790 6100 00b6                BSR.W #$00b6 == $00031848
;00031794 b21b                     CMP.B (A3)+ [00],D1
;00031796 6700 000e                BEQ.W #$000e == $000317a6 (F)
;0003179A 5240                     ADD.W #$01,D0
;0003179C 4a13                     TST.B (A3) [00]
;0003179E 6600 fff4                BNE.W #$fff4 == $00031794 (T)
;000317A2 6000 0008                BT .W #$0008 == $000317ac (T)
;000317A6 0600 007b                ADD.B #$7b,D0
;000317AA 1200                     MOVE.B D0,D1
;000317AC 0401 0061                SUB.B #$61,D1
;000317B0 c3fc 0050                MULS.W #$0050,D1
;000317B4 d5c1                     ADDA.L D1,A2
;000317B6 303c 0013                MOVE.W #$0013,D0
;000317BA 296a 0dc0 0370           MOVE.L (A2,$0dc0) == $00032064 [652e2e2e],(A4,$0370) == $00000370 [00000000]
;000317C0 296a 1b80 06e0           MOVE.L (A2,$1b80) == $00032e24 [06300000],(A4,$06e0) == $000006e0 [1f2c0000]
;000317C6 289a                     MOVE.L (A2)+ [00006501],(A4) [00000000]
;000317C8 49ec 002c                LEA.L (A4,$002c) == $0000002c,A4
;000317CC 51c8 ffec                DBF .W D0,#$ffec == $000317ba (F)
;000317D0 4a11                     TST.B (A1) [08]
;000317D2 6600 0008                BNE.W #$0008 == $000317dc (T)
;000317D6 43f9 0003 1b1a           LEA.L $00031b1a,A1
;000317DC 23c9 0003 17e8           MOVE.L A1,$000317e8 [00031b3b]
;000317E2 4cdf 7fff                MOVEM.L (A7)+,D0-D7/A0-A6
;000317E6 4e75                     RTS



sod:	move.b	#$01,switch
	rts
sod1:	move.b	#$01,boing
	rts
sod2:	move.b	#$00,boing
	rts

boing:	dc.b 0, 0

textadr:
    dc.l    text
ekschr:
    dc.b    "0123456789?!^:,.'()-/ ",0

text:
    dc.b    "      press left mouse button or escape to exit    "
    dc.b    "      text restarts  ................              "
    dc.b    "                                                   ",0,0
bufleft:
    dc.b 1,0
	
    blk.l 40960,0

wachrs:
    ;incbin "Dev:Intro_Demo-Code/Lost_Demo_II/chr.bitmap.raw"
    incbin "Dev:Intro_Demo-Code/Lost_Demo_II/chr.raw"
data:
;    incbin "Dev:Intro_Demo-Code/Lost_Demo_II/mod.twice2"

image:
    incbin "Dev:Intro_Demo-Code/Lost_Demo_II/logo.raw"

screen:
     blk.l 20480,0
