;APS00000000000000000000000000000000000000000000000000000000000000000000000000000000
;
;    ***********************************;
;    *          Hawkeye Intro
;    ***********************************;
;    *         Written in 1988.        *;
;    ***********************************;

    section flashtro,code_c

start: 
    move.l 4.w,a6           ; Get base of exec lib
    lea gfxlib(pc),a1       ; Adress of gfxlib string to a1
    jsr -408(a6)            ; Call OpenLibrary()
    move.l d0,gfxbase       ; Save base of graphics.library
    bsr configureBitPlanes
    move.l #copper,$dff080  ; Set new copperlist

rast:
    cmp.b #$ff,$00dff006
    bne rast
    bsr scroll
    bsr fader

mouse:
    btst #6,$bfe001         ; Left mouse clicked ?
    bne.b rast              ; No, continue loop!
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
    dc.w $0100,$5000
    dc.w $0102,$0000
    dc.w $0092,$0034
    dc.w $0094,$00cc
    dc.w $0108,$0000
    dc.w $010a,$0000

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

    dc.w $008e,$2702
    dc.w $0090,$49c0

    dc.w $0180,$0000
    dc.w $0182,$0222
    dc.w $0184,$0555

    dc.w $0186,$0777
    dc.w $0188,$0999
    dc.w $018a,$0ccc
    dc.w $018c,$0faa
    dc.w $018e,$0e66
    dc.w $0190,$0310
    dc.w $0192,$0420
    dc.w $0194,$0620
    dc.w $0196,$0731
    dc.w $0198,$0941
    dc.w $019a,$0a52
    dc.w $019c,$0b64
    dc.w $019e,$0b86
    dc.w $01a0,$0c98
    dc.w $01a2,$0dba
    dc.w $01a4,$0edc
    dc.w $01a6,$0fff
    dc.w $01a8,$0040
    dc.w $01aa,$0111
    dc.w $01ac,$0bbf
    dc.w $01ae,$09bf
    dc.w $01b0,$0200
    dc.w $01b2,$0b8f
    dc.w $01b4,$068f
    dc.w $01b6,$0300
    dc.w $01b8,$0700
    dc.w $01ba,$0eef
    dc.w $01bc,$0d80
    dc.w $01be,$0fe0

    dc.w $ffe1,$fffe

    dc.w $01fe,$0000
    dc.w $0011,$fffe
    dc.w $0801,$fffe
    dc.w $0100,$0000
    dc.w $0901,$fffe

    dc.w $008e,$2840
    dc.w $0090,$49e0
    dc.w $0092,$0020
    dc.w $0094,$01e0

    dc.w $0108,$0024
    dc.w $010a,$0024
    
    dc.w $0a01,$fffe

    dc.w $0180
barOne: 
    dc.w $0eee

    dc.w $0b01,$fffe
    dc.w $0180,$0000
    dc.w $0c01,$fffe

    dc.w $0100
    dc.w $1000
    dc.w $0182
    dc.w $0111

    dc.w $00e0
chrBitPlaneOneHigh:
    dc.w $0007
    dc.w $00e2
chrBitPlaneOneLow:
    dc.w $0000

    dc.w $0d01,$ff00
    dc.w $0182,$0222
    dc.w $0e01,$fffe

    dc.w $0180,$0000
    dc.w $0182,$0333
    dc.w $0f01,$ff00
    dc.w $0180,$0000
    dc.w $0182,$0444
    dc.w $1001,$fffe

    dc.w $0180
    dc.w $0100
    dc.w $0182
    dc.w $0555
    dc.w $1101
    dc.w $ff00
    dc.w $0180
    dc.w $0200,$0182
    dc.w $0666,$1201
    dc.w $ff00
    dc.w $0180
    dc.w $0300
    dc.w $0182
    dc.w $0777,$1301            
    dc.w $ff00                  
    dc.w $0180                  
    dc.w $0400,$0182            
    dc.w $0888                  
    dc.w $1401                  
    dc.w $ff00                  
    dc.w $0180                  
    dc.w $0500                  
    dc.w $0182                  
    dc.w $0999                  
    dc.w $1501                  
    dc.w $ff00                  
    dc.w $0180                  
    dc.w $0600,$0182            
    dc.w $0aaa,$1601,$ff00,$0180
    dc.w $0700
    dc.w $0182
    dc.w $0bbb
    dc.w $1701
    dc.w $ff00
    dc.w $0180
    dc.w $0800,$0182      
    dc.w $0ccc            
    dc.w $1801            
    dc.w $ff00            
    dc.w $0180            
    dc.w $0900            
    dc.w $0182            
    dc.w $0ddd            
    dc.w $1901            
    dc.w $ff00            
    dc.w $0180            
    dc.w $0a00,$0182      
    dc.w $0eee,$1a01,$ff00
    dc.w $1a01            
    dc.w $ff00            
    dc.w $0180            
    dc.w $0b00            
    dc.w $0182            
    dc.w $0fff            
    dc.w $1b01            
    dc.w $ff00            
    dc.w $0180            
    dc.w $0a00,$0182      
    dc.w $0eee,$1c01,$ff00
    dc.w $1c01
    dc.w $ff00
    dc.w $0180
    dc.w $0900
    dc.w $0182
    dc.w $0ddd
    dc.w $1d01
    dc.w $ff00
    dc.w $0180
    dc.w $0800
    dc.w $0182
    dc.w $0ccc
    dc.w $1e01
    dc.w $ff00
    dc.w $0180
    dc.w $0700
    dc.w $0182
    dc.w $0bbb
    dc.w $1f01
    dc.w $ff00
    dc.w $0180
    dc.w $0600
    dc.w $0182,$0aaa
    dc.w $2001,$ff00
    dc.w $0180,$0500
    dc.w $0182
    dc.w $0999
    dc.w $2101
    dc.w $ff00
    dc.w $0180
    dc.w $0400,$0182
    dc.w $0888
    dc.w $2201
    dc.w $ff00
    dc.w $0180
    dc.w $0300
    dc.w $0182
    dc.w $0777,$2301
    dc.w $ff00
    dc.w $0180
    dc.w $0200,$0182
    dc.w $0666,$2401
    dc.w $ff00
    dc.w $0180
    dc.w $0100
    dc.w $0182
    dc.w $0555
    dc.w $2501
    dc.w $ff00
    dc.w $0180
    dc.w $0000,$0182
    dc.w $0444,$2601
    dc.w $ff00
    dc.w $0180
    dc.w $0000,$0182
    dc.w $0333,$2701
    dc.w $ff00
    dc.w $0180
    dc.w $0000,$0182
    dc.w $0222,$2801
    dc.w $ff00
    dc.w $0182
    dc.w $0111
    dc.w $0180
    dc.w $0000,$2901
    dc.w $ff00
    dc.w $0180
    dc.w $0000
    dc.w $0100
    dc.w $0000
    dc.w $2a01,$ff00

    dc.w $0180
barTwo:
    dc.w $0eee

    dc.w $2b01,$ff00
    dc.w $2b01,$ff00
    dc.w $0180,$0000
    dc.w $ffff,$fffe
; End of Copper List


; Blitter Scroll ($00068392)
scroll: 
    movem.l d0-d6/a0-a6,-(a7)
    btst #$00,switch
    beq rollon
    rts
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
    move.b #$1,switch
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
    dc.b    "      press left mouse button to exit          "
    dc.b    "      text restarts  ................          "
    dc.b    "                                               ",0

bufleft:
    dc.b 1
switch:
    dc.b 0,0

wachrs:
    incbin "Dev:Intro_Demo-Code/Hawkeye_intro/wachr.raw"
    
image:
    incbin "Dev:Intro_Demo-Code/Hawkeye_intro/hawk.raw"

screen:
     blk.l 20480,0
