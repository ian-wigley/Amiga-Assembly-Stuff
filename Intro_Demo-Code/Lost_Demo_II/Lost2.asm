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

    lea.l image,a1
    lea.l bplOneHigh,a3     ; Get a pointer to the $e0 address
    lea.l bplOneLow,a2      ; Get a pointer to the $e2 address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($e2 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($e0 address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

    lea.l image+$2800,a1
    lea.l bplTwoHigh,a3     ; Get a pointer to the $e4 address
    lea.l bplTwoLow,a2      ; Get a pointer to the $e6 address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($e4 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($e6 address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

    lea.l image+$5000,a1
    lea.l bplThreeHigh,a3   ; Get a pointer to the $e8 address
    lea.l bplThreeLow,a2    ; Get a pointer to the $ea address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($e8 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($ea address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

    lea.l image+$7800,a1
    lea.l bplFourHigh,a3    ; Get a pointer to the $ec address
    lea.l bplFourLow,a2     ; Get a pointer to the $ee address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($ec address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($ee address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

    lea.l image+$a000,a1
    lea.l bplFiveHigh,a3    ; Get a pointer to the $f0 address
    lea.l bplFiveLow,a2     ; Get a pointer to the $f2 address
    move.l a1,d1            ; Copy pointer address into d1
    move.w d1,(a2)          ; Copy the lower word into a2 ($f0 address)
    move.w (a2),d2          ; Copy the data from the pointer into d3
    swap d1                 ; Flip d1
    move.w d1,(a3)          ; Copy the lower word into a2 ($f2 address)
    move.w (a3),d3          ; Copy the data from the pointer into d3

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

colours:
    dc.l colourDataStart
count:
    dc.l 0,0

; Colour Bar fader ($0006806A)
fader:
    clr.l d0
    move.l count,d0
    move.l colours,a0
    move.w 0(a0,d0.l),barOne
    move.w 0(a0,d0.l),barTwo
    move.l count,d0
    cmp #$3c,d0
    beq end
    addq.l #2,d0
    move.l d0,count
    rts
end:
    move.l #0,count
    rts

; Colour data ($00068090)
colourDataStart:
    dc.w $0fff,$0fff
    dc.w $0eee,$0eee
    dc.w $0ddd,$0ddd
    dc.w $0ccc,$0ccc
    dc.w $0bbb,$0bbb
    dc.w $0aaa,$0aaa
    dc.w $0999,$0999
    dc.w $0888,$0888
    dc.w $0777,$0777
    dc.w $0666,$0666
    dc.w $0555,$0555
    dc.w $0444,$0444
    dc.w $0333,$0333
    dc.w $0222,$0222
    dc.w $0111,$0111
    dc.w $0000,$0000
    dc.w $0111,$0111
    dc.w $0222,$0222
    dc.w $0333,$0333
    dc.w $0444,$0444
    dc.w $0555,$0555
    dc.w $0666,$0666
    dc.w $0777,$0777
    dc.w $0888,$0888
    dc.w $0999,$0999
    dc.w $0aaa,$0aaa
    dc.w $0bbb,$0bbb
    dc.w $0ccc,$0ccc
    dc.w $0ddd,$0ddd
    dc.w $0eee,$0eee
    dc.w $0fff,$0fff

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
    dc.w $3001,$ff00
    dc.w $0180,$0001
    dc.w $3101,$ff00
    dc.w $0180,$0000
    
    dc.w $00e0
    dc.w $0006
    dc.w $00e2
    dc.w $0000
    
    dc.w $0182,$0fff
    dc.w $01fe,$0000
    dc.w $018a,$0000
    dc.w $018c,$0000
    dc.w $018e,$0000
    dc.w $008e,$20a0
    dc.w $0090,$40f0
    dc.w $0092,$0030
    dc.w $0094,$00e8
    dc.w $0108,$0024
    dc.w $010a,$0024
    dc.w $0100,$4000
    
    dc.w $00e0
    dc.w $0006
    dc.w $00e2
    dc.w $bfb0
    dc.w $00e4
    dc.w $0004
    dc.w $00e6
    dc.w $68f6
    dc.w $00e8
    dc.w $0004
    dc.w $00ea
    dc.w $0004
    dc.w $00ea
    dc.w $7d6e
    dc.w $00ec
    dc.w $0004
    dc.w $00ee
    dc.w $0004
    dc.w $00ee
    dc.w $91e6
    
    dc.w $018c,$0666
    dc.w $0190,$0444
    dc.w $0194,$0777
    dc.w $0198,$0999
    dc.w $4201,$ff00
    
    dc.w $00e2
    dc.w $bfb5
    
    dc.w $0182,$0fff
    dc.w $5001,$ff00
    
    dc.w $00e2
    dc.w $bfba
    
    dc.w $5301,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$00ff
    dc.w $5401,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$00ee
    dc.w $5501,$ff00
    dc.w $5501,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$00dd
    dc.w $5601,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$00cc
    dc.w $5701,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$00bb
    dc.w $5801,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$00aa
    dc.w $5901,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0099
    dc.w $5a01,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0088
    dc.w $5b01,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0077
    dc.w $5c01,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0066
    dc.w $5d01,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0055
    dc.w $5e01,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0044
    dc.w $5f01,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0033
    dc.w $6001,$ff00
    
    dc.w $00e2
    dc.w $c050
    
    dc.w $0184,$0022
    dc.w $6101,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0011
    dc.w $6201,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0000
    dc.w $6301,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$00ee
    dc.w $6401,$ff00
    dc.w $6401,$ff00
    
    dc.w $00e2
    dc.w $bf8a
    
    dc.w $0184,$0000
    dc.w $6501,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0000
    dc.w $6601,$ff00
    dc.w $01fe,$0000
    dc.w $0184,$0000
    dc.w $0182,$0fff
    dc.w $6e01,$ff00
    
    dc.w $00e2
    dc.w $c01c
    
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
    dc.w $0092,$0030
    dc.w $0094,$00d8
    dc.w $ab01,$ff00
    dc.w $0100,$3000
    
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
	
	dc.w $00e0
    dc.w $0007
	dc.w $00e4
    dc.w $0007
	dc.w $00e8
    dc.w $0007
	
	dc.w $c201,$ff00
	
    dc.w $00e2
    dc.w $0318
    dc.w $00e6
    dc.w $0688
    dc.w $00ea
	dc.w $09f8

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
	
    dc.w $00e2
    dc.w $0268
	dc.w $00e6
	dc.w $05d8
    dc.w $00ea
	dc.w $0948

	dc.w $0100,$3000
    dc.w $c501,$ff00
	
    dc.w $00e2
    dc.w $0210
	dc.w $00e6
    dc.w $0580
    dc.w $00ea
	dc.w $08f0
	
	dc.w $0100,$3000
    dc.w $c601,$ff00
	
    dc.w $00e2
    dc.w $01b8
	dc.w $00e6
    dc.w $0528
	dc.w $00ea
    dc.w $0898
	
	dc.w $0100,$3000
    dc.w $c701,$ff00
	
    dc.w $00e2
    dc.w $0160
    dc.w $00e6
    dc.w $04d0
    dc.w $00ea
	dc.w $0840
	
    dc.w $0100,$3000
    dc.w $c801,$ff00
	
    dc.w $00e2
    dc.w $0108
	dc.w $00e6
    dc.w $0478
	dc.w $00ea
	dc.w $07e8
	
    dc.w $0100,$3000
    dc.w $c901,$ff00
	
    dc.w $00e2
    dc.w $00b0
	dc.w $00e6
	dc.w $0420
	dc.w $00ea
    dc.w $0790
	
    dc.w $0100,$3000
	dc.w $ca01,$ff00
    
	dc.w $00e2
    dc.w $0058
	dc.w $00e6
    dc.w $03c8
	dc.w $00ea
    dc.w $0738
	
	dc.w $0100,$3000
    dc.w $cb01,$ff00
	
    dc.w $00e2
    dc.w $0000
	dc.w $00e6
    dc.w $0370
	dc.w $00ea
    dc.w $06e0

    dc.w $0100,$3000
    dc.w $cc01,$ff00
    dc.w $0100,$0000
    dc.w $cd01,$ff00
    dc.w $0180,$0000
    dc.w $e001,$ff00
    dc.w $0100,$0000
    dc.w $e101,$ff00
    dc.w $0100,$1000
    dc.w $008e,$0080
    dc.w $0090,$00a0
    dc.w $0092,$0040
    dc.w $0094,$00f0
    dc.w $0108,$0000
    dc.w $0108,$0000
    dc.w $010a,$0000
	
    dc.w $00e0
    dc.w $0006
	dc.w $00e2
    dc.w $d258
	
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
    dc.w $01fe,$0000
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








;    dc.w $0096,$0020
;    dc.w $0100,$5000
;    dc.w $0102,$0000
;    dc.w $0092,$0034
;    dc.w $0094,$00cc
;    dc.w $0108,$0000
;    dc.w $010a,$0000
    dc.w $00e0
bplOneHigh:
    dc.w $0000
    dc.w $00e2
bplOneLow:
    dc.w $0000
    dc.w $00e4
bplTwoHigh:
    dc.w $0000
    dc.w $00e6
bplTwoLow:
    dc.w $0000
    dc.w $00e8
bplThreeHigh:
    dc.w $0000
    dc.w $00ea
bplThreeLow:
    dc.w $0000
    dc.w $00ec
bplFourHigh:
    dc.w $0000
    dc.w $00ee
bplFourLow:
    dc.w $0000
    dc.w $00f0
bplFiveHigh:
    dc.w $0000
    dc.w $00f2
bplFiveLow:
    dc.w $0000
;    dc.w $008e,$2702
;    dc.w $0090,$49c0
;    dc.w $0180,$0000
;    dc.w $0182,$0222
;    dc.w $0184,$0555
;    dc.w $0186,$0777
;    dc.w $0188,$0999
;    dc.w $018a,$0ccc
;    dc.w $018c,$0faa
;    dc.w $018e,$0e66
;    dc.w $0190,$0310
;    dc.w $0192,$0420
;    dc.w $0194,$0620
;    dc.w $0196,$0731
;    dc.w $0198,$0941
;    dc.w $019a,$0a52
;    dc.w $019c,$0b64
;    dc.w $019e,$0b86
;    dc.w $01a0,$0c98
;    dc.w $01a2,$0dba
;    dc.w $01a4,$0edc
;    dc.w $01a6,$0fff
;    dc.w $01a8,$0040
;    dc.w $01aa,$0111
;    dc.w $01ac,$0bbf
;    dc.w $01ae,$09bf
;    dc.w $01b0,$0200
;    dc.w $01b2,$0b8f
;    dc.w $01b4,$068f
;    dc.w $01b6,$0300
;    dc.w $01b8,$0700
;    dc.w $01ba,$0eef
;    dc.w $01bc,$0d80
;    dc.w $01be,$0fe0
;    dc.w $ffe1,$fffe
;    dc.w $01fe,$0000
;    dc.w $0011,$fffe
;    dc.w $0801,$fffe
;    dc.w $0100,$0000
;    dc.w $0901,$fffe
;    dc.w $008e,$2840
;    dc.w $0090,$49e0
;    dc.w $0092,$0020
;    dc.w $0094,$01e0
;    dc.w $0108,$0024
;    dc.w $010a,$0024
;    dc.w $0a01,$fffe
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
    move.w  4(a3,d4),d3     ;** calc repeatstart
    add.l   4(a6),d3
    move.l  d3,10(a6)       ;store repeatstart
    move.w  6(a3,d4),14(a6)     ;store repeatlength
    cmp.w   #1,14(a6)
    beq.s   chan2           ;no sustainsound !
    move.l  10(a6),4(a6)        ;repstart  = sndstart
    move.w  6(a3,d4),8(a6)      ;replength = sndlength
chan2:  cmp.w   #0,(a6)
    beq.s   chan4           ;no new note set !
    move.w  22(a6),$dff096      ;clear dma
    cmp.w   #0,14(a6)
    bne.s   chan3           ;no oneshot-sample
    move.w  #1,14(a6)       ;allow resume (later)
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
muzakoffset:    dc.l    0
lev6save:   dc.l    0
trkpos:     dc.l    0
patpos:     dc.l    0
numpat:     dc.w    0
enbits:     dc.w    0
timpos:     dc.w    0

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

wachrs:
;    incbin "Dev:Intro_Demo-Code/Lost_Demo_II/wachr.raw"
    
data:
;    incbin "Dev:Intro_Demo-Code/Lost_Demo_II/mod.twice2"

image:
;    incbin "Dev:Intro_Demo-Code/Lost_Demo_II/hawk.raw"

screen:
     blk.l 20480,0
