;
;    **************************;
;    *    MEGA DEMO PART 1    *;
;    **************************;
; Written sometime in the late 80's ...

	section	flashtro,code_c

	move.l 4.w,a6		; Get base of exec lib
	lea gfxlib(pc),a1	; Adress of gfxlib string to a1
	jsr -408(a6)		; Call OpenLibrary()
	move.l d0,gfxbase	; Save base of graphics.library
	move.l #cop,$dff080	; Set new copperlist
	bsr	start_muzak
	bsr	stop_muzak

rast:	
	cmpi.b	#$ff,$dff006
	bne	rast
	bsr	scroll
	bsr	uk
	bsr	fader
	bsr	puller
	bsr	puller1
	bsr	store
	bsr	replay_muzak
	bsr	bar1
	bsr	bar2
	bsr	bar3
	bsr	bar4
	bsr	vutest
mouse:	
	btst #6,$bfe001		    ; Left mouse clicked ?
	bne.b rast				; No, continue loop!
	
	bsr	stop_muzak
	move.l gfxbase(pc),a1	; Base of graphics.library to a1
	move.l 38(a1),$dff080	; Restore old copperlist
	jsr -414(a6)		    ; Call CloseLibrary()
	moveq #0,d0		        ; Over..
	rts			            ; and out!

; Stuff
; *****

gfxlib:		dc.b	"graphics.library",0,0
gfxbase:	dc.l	0


log1:	
    move.b	#$00,pit1
	move.w	#$d0,pass1
	move.b	#$01,clip1
	jmp	conti

log2:	
    move.b	#$00,pit1
	move.w	#$d0,pass2
	move.b	#$01,clip2
	jmp	conti

log3:	
    move.b	#$00,pit1
	move.w	#$d0,pass3
	move.b	#$01,clip3
	jmp	conti

log4:	
    move.b	#$00,pit1
	move.w	#$d0,pass4
	move.b	#$01,clip4
	jmp	conti

vutest:	
    cmpi.b	#$01,clip1
	beq	ohyeah1
crep1:	
    cmpi.b	#$01,clip2
	beq	ohyeah2
crep2:	
    cmpi.b	#$01,clip3
	beq	ohyeah3
crep3:	
    cmpi.b	#$01,clip4
	beq	ohyeah4
crep4:	
    rts	

ohyeah1:
    subi.w	#$02,pass1
	cmpi.w	#$50,pass1
	beq	tacky1
	jmp	crep1

ohyeah2:
    subi.w	#$02,pass2
	cmpi.w	#$50,pass2
	beq	tacky2
	jmp	crep2

ohyeah3:
    subi.w	#$02,pass3
	cmpi.w	#$50,pass3
	beq	tacky3
	jmp	crep3

ohyeah4:
    subi.w	#$02,pass4
	cmpi.w	#$50,pass4
	beq	tacky4
	jmp	crep4

tacky1:	
    move.b	#$00,clip1
	jmp	crep1
tacky2:	
    move.b	#$00,clip2
	jmp	crep2
tacky3:	
    move.b	#$00,clip3
	jmp	crep3
tacky4:	
    move.b	#$00,clip4
	jmp	crep3

bar1:	
	lea	pix1,a0
	lea	pix2,a1
	clr.l	d0
	move.w	tabel,d0
	move.w	tabel,d1
	add.w	pass1,d1
	lea	colp,a2
	lea	colx,a3
jolk0:	
    move.w	d0,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	(a2)+,(a0)+
	move.w	d1,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	(a3)+,(a0)+
	addi.w	#$0100,d0
	addi.w	#$0100,d1
	cmpa.l	a1,a0
	bne	jolk0
	move.w	d0,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	#$0000,(a0)+
	rts

uk:	
	btst	#$01,switch
	beq	no
	rts
no:	
	addq.b	#$1,time
	cmpi.b	#$a0,time
	beq	exit
	rts
exit:	
    clr.b	time
	move.b	#$00,switch
	rts

bar2:	
	lea	pix3,a0
	lea	pix4,a1
	clr.l	d0
	move.w	tabek,d0
	move.w	tabek,d1
	add.w	pass2,d1
	lea	colp,a2
	lea	colx,a3
jolk1:	
	move.w	d0,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	(a2)+,(a0)+
	move.w	d1,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	(a3)+,(a0)+
	addi.w	#$0100,d0
	addi.w	#$0100,d1
	cmp.l	a1,a0
	bne	jolk1
	move.w	d0,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	#$0000,(a0)+
	rts

bar3:	
	lea	pix5,a0
	lea	pix6,a1
	clr.l	d0
	move.w	tabej,d0
	move.w	tabej,d1
	add.w	pass3,d1
	lea	colp,a2
	lea	colx,a3
jolk2:	
	move.w	d0,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	(a2)+,(a0)+
	move.w	d1,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	(a3)+,(a0)+
	addi.w	#$0100,d0
	addi.w	#$0100,d1
	cmp.l	a1,a0
	bne	jolk2
	move.w	d0,(a0)+	
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
;	move.w	#$0000,(a0)+
	rts

bar4:	
	lea	pix7,a0
	lea	pix8,a1
	clr.l	d0
	move.w	tabei,d0
	move.w	tabei,d1
	add.w	pass4,d1
	lea	colp,a2
	lea	colx,a3
jolk3:	
	move.w	d0,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	(a2)+,(a0)+
	move.w	d1,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	(a3)+,(a0)+
	addi.w	#$0100,d0
	addi.w	#$0100,d1
	cmpa.l	a1,a0
	bne	jolk3
	move.w	#$fffe,(a0)+
	move.w	#$0180,(a0)+
	move.w	#$0001,(a0)+
	move.w	#$ffff,(a0)+
	move.w	#$fffe,(a0)+
	rts

tabel:	dc.w	$0601
tabek:	dc.w	$1001
tabej:	dc.w	$1a01
tabei:	dc.w	$2401

pass1:	dc.w	$0050
pass2:	dc.w	$0050
pass3:	dc.w	$0050
pass4:	dc.w	$0050

colp:	dc.w	$0001,$0003,$0005,$0007,$0009
		dc.w	$0007,$0005,$0003,$0001,$0000
colx:	dc.w	$0110,$0330,$0550,$0770,$0990
		dc.w	$0770,$0550,$0330,$0110,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000

clip1:	dc.b	$00
clip2:	dc.b	$00
clip3:	dc.b	$00
clip4:	dc.b	$00
time:	dc.b	$00,$00
        	
even
; Todo => This doesnt do much !!
fader:	
	lea	tab,a0
	move.b	(a0),d0
log:	
	move.b	$2(a0),(a0)+
	cmpa.l	#endtab,a0
	bne	log
	move.b	(a0),raz
	move.b	d0,(a0)	
	rts

tab:	
    dc.b	$31,$31,$31,$32,$32,$32,$33,$33
	dc.b	$34,$34,$35,$35,$36,$36,$37,$37
	dc.b	$38,$38,$39,$39,$3a,$3a,$3b,$3b
	dc.b	$3c,$3c,$3d,$3d,$3e,$3e,$3f,$3f
	dc.b	$41,$41,$42,$42,$43,$43,$44,$44
	dc.b	$45,$45,$46,$46,$47,$47,$48,$48
	dc.b	$49,$49,$4a,$4a,$4a,$4a,$4b,$4b
	dc.b	$4b,$4b,$4c,$4c,$4c,$4c,$4c,$4c
	dc.b	$4b,$4b,$4b,$4b,$4a,$4a,$4a,$4a
	dc.b	$49,$49,$48,$48,$47,$47,$46,$46
	dc.b	$45,$45,$44,$44,$43,$43,$42,$42
	dc.b	$41,$41,$40,$40,$3f,$3f,$3e,$3e
	dc.b	$3d,$3d,$3c,$3c,$3b,$3b,$3a,$3a
	dc.b	$39,$39,$38,$38,$37,$37,$36,$36
	dc.b	$35,$35,$34,$34,$34,$34,$33,$33
	dc.b	$32,$32,$32,$32
endtab:	
    dc.b	$31,$00

puller:	
    lea	ian,a2
	lea	ian1,a3
duress:	
    move.w	(a3),(a2)
	adda.w	#$000c,a2
	adda.w	#$000c,a3
	cmp.l	#ianend,a3
	bne	duress
	move.w	(a3),ianend-$10
	rts

puller1:
	movem.l d0-d6/a0-a6,-(a7)
	lea	ian2,a5
	lea	ian3,a6
kuress:	
	move.w	(a6),(a5)
	adda.w	#$000c,a5
	adda.w	#$000c,a6
	cmp.l	#ianend1,a6
	bne	kuress
	move.w	(a6),ianend1-$10
	movem.l    (a7)+,d0-d6/a0-a6
	rts

store:	
	lea	up1,a4
	move.b	(a4),d4
durate:	
	move.b	$2(a4),(a4)+
	cmp.l	#up1end,a4
	bne	durate
	move.b	(a4),clunk+$1
	move.b	(a4),clund+$1
	move.b	d4,(a4)
	rts
	
up1:	
	dc.b	$50,$50,$50,$50
	dc.b	$a0,$a0,$a0,$50
	dc.b	$a0,$50,$a0,$50
	dc.b	$a0,$a0,$a0,$a0
	dc.b	$50,$50,$50,$50
	dc.b	$50,$50,$50,$60
	dc.b	$50,$50

    dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
up1end:	
	dc.b	0,0

	; Add the copperlist
	include    asm_code/copperlist.asm

start_muzak:
	move.l	#data,muzakoffset	;** get offset

init0:	
	move.l	muzakoffset,a0		;** get highest used pattern
	add.l	#472,a0
	move.l	#$80,d0
	clr.l	d1
init1:	
	move.l	d1,d2
	subq.w	#1,d0
init2:	
	move.b	(a0)+,d1
	cmp.b	d2,d1
	bgt.s	init1
	dbf	d0,init2
	addq.b	#1,d2
init3:	
	move.l	muzakoffset,a0		;** calc samplepointers
	lea	pointers,a1
	mulu	#1024,d2
	add.l	#600,d2
	add.l	a0,d2
	move.l	#15-1,d0
init4:	
	move.l	d2,(a1)+
	clr.l	d1
	move.w	42(a0),d1
	lsl.l	#1,d1
	add.l	d1,d2
	add.l	#30,a0
	dbf	d0,init4

init5:	
	move.w	#$0,$dff0a8		;** clear used values
	move.w	#$0,$dff0b8
	move.w	#$0,$dff0c8
	move.w	#$0,$dff0d8
	clr.w	timpos
	clr.l	trkpos
	clr.l	patpos

init6:	
	move.l	muzakoffset,a0		;** initialize timer irq
	move.b	470(a0),numpat+1	;number of patterns
	move.l	#240,d0
	sub.b	471(a0),d0
	mulu	#122,d0
	move.b	#$0,$bfde00
	move.b	d0,$bfd400
	lsr.w	#8,d0
	move.b	d0,$bfd500
	move.b	#$81,$bfdd00
	move.b	#$11,$bfde00
	move.l	$78,lev6save
	move.l	#lev6interrupt,$78
	rts

stop_muzak:
	move.b	#$1,$bfdd00		;** restore timer & dma
	move.l	lev6save,$78
	move.w	#$0,$dff0a8
	move.w	#$0,$dff0b8
	move.w	#$0,$dff0c8
	move.w	#$0,$dff0d8
	move.w	#$f,$dff096
	rts

lev6interrupt:
	movem.l	d0/d1,-(sp)		;** jump
	bsr	replay_muzak
	move.b	$bfdd00,d0
	move.w	#$2000,$dff09c
	movem.l	(sp)+,d0/d1
	rte

replay_muzak:
	movem.l	d0-d7/a0-a6,-(a7)
	addq.w	#1,timpos
speed:	
	cmp.w	#6,timpos
	beq	replaystep

chaneleffects:				;** seek effects
	lea	datach0,a6
	tst.b	3(a6)
	beq.s	ceff1
	lea	$dff0a0,a5
	bsr.s	ceff5
ceff1:	
	lea	datach1,a6
	tst.b	3(a6)
	beq.s	ceff2
	lea	$dff0b0,a5
	bsr.s	ceff5
	
ceff2:	
	lea	datach2,a6
	tst.b	3(a6)
	beq.s	ceff3
	lea	$dff0c0,a5
	bsr.s	ceff5
ceff3:	
	lea	datach3,a6
	tst.b	3(a6)
	beq.s	ceff4
	lea	$dff0d0,a5
	bsr.s	ceff5
ceff4:	
	movem.l	(a7)+,d0-d7/a0-a6
	rts

ceff5:	
	move.b	2(a6),d0		;room for some more
	and.b	#$0f,d0			;implementations below
	tst.b	d0
	beq.s	arpreggiato
	cmp.b	#1,d0
	beq	pitchup
	cmp.b	#2,d0
	beq	pitchdown
	cmp.b	#12,d0
	beq	setvol
	cmp.b	#14,d0
	beq	setfilt
	cmp.b	#15,d0
	beq	setspeed
	rts

arpreggiato:				;** spread by time
	cmp.w	#1,timpos
	beq.s	arp1
	cmp.w	#2,timpos
	beq.s	arp2
	cmp.w	#3,timpos
	beq.s	arp3
	cmp.w	#4,timpos
	beq.s	arp1
	cmp.w	#5,timpos
	beq.s	arp2
	rts

arp1:	
	clr.l	d0				;** get higher note-values
	move.b	3(a6),d0		;   or play original
	lsr.b	#4,d0
	bra.s	arp4
arp2:	
	clr.l	d0
	move.b	3(a6),d0
	and.b	#$0f,d0
	bra.s	arp4
arp3:	
	move.w	16(a6),d2
	bra.s	arp6
arp4:	
	lsl.w	#1,d0
	clr.l	d1
	move.w	16(a6),d1
	lea	notetable,a0
arp5:	
	move.w	(a0,d0.w),d2
	cmp.w	(a0),d1
	beq.s	arp6
	addq.l	#2,a0
	bra.s	arp5
arp6:	
	move.w	d2,6(a5)
	rts

pitchdown:
	bsr	newrou
	clr.l	d0
	move.b	3(a6),d0
	and.b	#$0f,d0
	add.w	d0,(a4)
	cmp.w	#$358,(a4)
	bmi.s	ok1
	move.w	#$358,(a4)
ok1:	
	move.w	(a4),6(a5)
	rts

pitchup:bsr	newrou
	clr.l	d0
	move.b	3(a6),d0
	and.b	#$0f,d0
	sub.w	d0,(a4)
	cmp.w	#$71,(a4)
	bpl.s	ok2
	move.w	#$71,(a4)
ok2:	
	move.w	(a4),6(a5)
	rts

setvol:	
	move.b	3(a6),8(a5)
	rts

setfilt:
	move.b	3(a6),d0
	and.b	#$01,d0
	asl.b	#$01,d0
	and.b	#$fd,$bfe001
	or.b	d0,$bfe001
	rts

setspeed:
	clr.l	d0
	move.b	3(a6),d0
	and.b	#$0f,d0
	move.w	d0,speed+2
	rts

newrou:	
	cmp.l	#datach0,a6
	bne.s	next1
	lea	voi1,a4
	move.b	#$1,pit1
	rts
next1:	
	cmp.l	#datach1,a6
	bne.s	next2
	lea	voi2,a4
	move.b	#$2,pit1
	rts
next2:	
	cmp.l	#datach2,a6
	bne.s	next3
	lea	voi3,a4
	move.b	#$3,pit1
	rts
next3:	
	lea	voi4,a4
	move.b	#$4,pit1
	rts

replaystep:					;** work next pattern-step
	clr.w	timpos
	move.l	muzakoffset,a0
	move.l	a0,a3
	add.l	#12,a3			;ptr to soundprefs
	move.l	a0,a2
	add.l	#472,a2			;ptr to pattern-table
	add.l	#600,a0			;ptr to first pattern
	clr.l	d1
	move.l	trkpos,d0		;get ptr to current pattern
	move.b	(a2,d0),d1
	mulu	#1024,d1
	add.l	patpos,d1	  	;get ptr to current step
	clr.w	enbits
	lea	$dff0a0,a5		  	;chanel 0
	lea	datach0,a6
	bsr	chanelhandler

	lea	$dff0b0,a5		  	;chanel 1
	lea	datach1,a6
	bsr	chanelhandler

	lea	$dff0c0,a5		  	;chanel 2
	lea	datach2,a6
	bsr	chanelhandler

	lea	$dff0d0,a5	      	;chanel 3
	lea	datach3,a6
	bsr	chanelhandler

	move.l	#400,d0		  	;** wait a while and set len
rep1:	
	dbf	d0,rep1			  	;of oneshot to 1 word
	move.l	#$8000,d0
	or.w	enbits,d0
	move.w	d0,$dff096
	cmp.w	#1,datach0+14
	bne.s	rep2
	clr.w	datach0+14
	move.w	#1,$dff0a4
	
rep2:	
	cmp.w	#1,datach1+14
	bne.s	rep3
	clr.w	datach1+14
	move.w	#1,$dff0b4
	
rep3:	
	cmp.w	#1,datach2+14
	bne.s	rep4
	clr.w	datach2+14
	move.w	#1,$dff0c4
	
rep4:	
	cmp.w	#1,datach3+14
	bne.s	rep5
	clr.w	datach3+14
	move.w	#1,$dff0d4

rep5:
	add.l	#16,patpos		;next step
	cmp.l	#64*16,patpos	;pattern finished ?
	bne	rep6
	clr.l	patpos
	addq.l	#1,trkpos		;next pattern in table
	clr.l	d0
	move.w	numpat,d0
	cmp.l	trkpos,d0		;song finished ?
	bne	rep6
	clr.l	trkpos
rep6:
	movem.l	(a7)+,d0-d7/a0-a6
	rts

chanelhandler:
	move.l	(a0,d1.l),(a6)	;get period & action-word
	addq.l	#4,d1			;point to next chanel
	clr.l	d2
	move.b	2(a6),d2		;get nibble for soundnumber

	cmpi.b	#$01,pit1       ;Stuff for colour bars ?
	beq	log1
	cmpi.b	#$02,pit1
	beq	log2
	cmpi.b	#$03,pit1
	beq	log3
	cmpi.b	#$04,pit1
	beq	log4	

conti:
	lsr.b	#4,d2
	beq.s	chan2			;no soundchange !
	move.l	d2,d4			;** calc ptr to sample
	lsl.l	#2,d2
	mulu	#30,d4
	lea	pointers-4,a1
	move.l	(a1,d2.l),4(a6)	 ;store sample-address
	move.w	(a3,d4.l),8(a6)	 ;store sample-len in words
	move.w	2(a3,d4.l),18(a6);store sample-volume

	move.l	d0,-(a7)
	move.b	2(a6),d0
	and.b	#$0f,d0
	cmp.b	#$0c,d0
	bne.s	ok3
	move.b	3(a6),8(a5)
	bra.s	ok4
ok3:
	move.w	2(a3,d4.l),8(a5);change chanel-volume
ok4:
	move.l	(a7)+,d0

	clr.l	d3
	move.w	4(a3,d4),d3		;** calc repeatstart
	add.l	4(a6),d3
	move.l	d3,10(a6)		;store repeatstart
	move.w	6(a3,d4),14(a6)	;store repeatlength
	cmp.w	#1,14(a6)
	beq.s	chan2			;no sustainsound !
	move.l	10(a6),4(a6)	;repstart  = sndstart
	move.w	6(a3,d4),8(a6)	;replength = sndlength
chan2:
	cmp.w	#0,(a6)
	beq.s	chan4			;no new note set !
	move.w	22(a6),$dff096	;clear dma
	cmp.w	#0,14(a6)
	bne.s	chan3			;no oneshot-sample
	move.w	#1,14(a6)		;allow resume (later)
chan3:
	bsr	newrou
	move.w	(a6),(a4)
	move.w	(a6),16(a6)		;save note for effect
	move.l	4(a6),0(a5)		;set samplestart
	move.w	8(a6),4(a5)		;set samplelength
	move.w	(a6),6(a5)		;set period
	move.w	22(a6),d0
	or.w	d0,enbits		;store dma-bit
	move.w	18(a6),20(a6)	;volume trigger
chan4:
	rts

datach0:	dc.w	0,0,0,0,0,0,0,0,0,0,0,1
datach1:	dc.w	0,0,0,0,0,0,0,0,0,0,0,2
datach2:	dc.w	0,0,0,0,0,0,0,0,0,0,0,4
datach3:	dc.w	0,0,0,0,0,0,0,0,0,0,0,8
voi1:		dc.w	0
voi2:		dc.w	0
voi3:		dc.w	0
voi4:		dc.w	0
pointers:	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
notetable:	dc.w	856,808,762,720,678,640,604,570
			dc.w	538,508,480,453,428,404,381,360
			dc.w	339,320,302,285,269,254,240,226  
			dc.w	214,202,190,180,170,160,151,143
			dc.w	135,127,120,113,000
muzakoffset:dc.l	0
lev6save:	dc.l	0
trkpos:		dc.l	0
patpos:		dc.l	0
numpat:		dc.w	0
enbits:		dc.w	0
timpos:		dc.w	0

pit1:		dc.b	00
switch:		dc.b	00


***  Blitter Scroll  ***

scroll:
	movem.l d0-d6/a0-a6,-(a7)
	btst #$00,switch
	beq	rollon
	rts
rollon:	
	lea	$dff000,a0
;	move.l 	screen,$50(a0)
	move.l 	#$70000,$50(a0)
;	move.l 	screen-$2,$54(a0)
	move.l 	#$6fffe,$54(a0)
	clr.l 	$64(a0)
	move.l 	#$ffffffff,$44(a0)
	move.w 	#$c9f0,$40(a0)
	clr.w 	$42(a0)
	move.w 	#$0cd7,$58(a0);6d8 ;blitter window size!!
bw:	btst 	#$0006,$02(a0)
	bne 	bw

	sub.b 	#1,bufleft
	bne 	scrlend
	move.b	#8,bufleft ; (space between chrs!!)
	move.l 	textadr,a1
	lea 	wachrs,a2 ;$60000,a2   ;Address of Chars
	lea 	ekschr,a3
;	lea 	screen+$30,a4
	lea 	$70030,a4   ;Address of Screen
	clr.l 	d0
	clr.l 	d1
	move.b (a1)+,d1
	
	cmpi.b	#$23,(a1)
	bne	eksloop
	move.b	#$1,switch

eksloop:
    cmp.b 	(a3)+,d1
	beq 	found
	addq 	#1,d0
	tst.b 	(a3)
	bne 	eksloop
	bra 	notf
found:	
    add.b 	#123,d0;space plotter
	move.b 	d0,d1
notf:	
    sub.b 	#97,d1 
	muls 	#112,d1 
	add.l 	d1,a2
	move.w 	#29,d0
scrlloop:
	move.l 	(a2)+,(a4)
	add.l 	#84,a4 ;44 
	dbf 	d0,scrlloop
	tst.b 	(a1)
	bne 	qq
	lea 	text,a1
qq:	
	move.l 	a1,textadr
scrlend:
	movem.l    (a7)+,d0-d6/a0-a6
	rts

textadr:
	dc.l	text
bufleft:
	dc.b	1

ekschr:	
	dc.b 	"0123456789?!^:,.'()-/ ",0

text:
        dc.b 	"      small 68000 assembly test in 2023 !      "
		dc.b	"      press left mouse button to exit          "
		dc.b	"      text restarts  ................          "

logo:
	incbin "asm_code/lostboys1.logo"

wachrs:
    incbin "asm_code/wachr.raw"
	  
data:
	incbin "asm_code/mod.shades"
	
screen:
     blk.b      10240,0

