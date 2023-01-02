cop:	dc.w	$0106,$0000,$01fc,$0000		; AGA compatible
		dc.w	$0120,$0000,$0122,$0000		; Clear spriteptrs
		dc.w	$0124,$0000,$0126,$0000
		dc.w	$0128,$0000,$012a,$0000
		dc.w	$012c,$0000,$012e,$0000
		dc.w	$0130,$0000,$0132,$0000
		dc.w	$0134,$0000,$0136,$0000
		dc.w	$0138,$0000,$013a,$0000
		dc.w	$013c,$0000,$013e,$0000
		dc.w	$0100,$0200			; 0 Bitplanes
;		dc.w	$0180,$0000			; Color00 = black
;		dc.w	$0182,$0fff			; Color01 = white
;		dc.w	$700f,$fffe			; Wait VPos $70
;		dc.w	$0180,$0f00			; Color00 = red
;		dc.w	$d00f,$fffe			; Wait VPos $d0
;		dc.w	$0180,$0ff0			; Color00 = yellow

	    dc.w	$0180,$0000
	    dc.w	$0182,$0fd4
	    dc.w	$0184,$0fc3
	    dc.w	$0186,$0da2 
	    dc.w	$0188,$0c81  
	    dc.w	$018a,$0a60
	    dc.w	$018c,$0941 
	    dc.w	$018e,$0830 
	    dc.w	$0190,$079f
	    dc.w	$0192,$0348
	    dc.w	$0194,$0337
	    dc.w	$0196,$0225
	    dc.w	$0198,$0114
	    dc.w	$019a,$0003
	    dc.w	$019c,$0fff
	    dc.w	$019e,$0fff
	    dc.w	$01a0,$0f00	
	    dc.w	$01a2,$0800
	    dc.w	$01a4,$0700
	    dc.w	$01a6,$0600	
	    dc.w	$01a8,$0500
	    dc.w	$01aa,$0300 
	    dc.w	$01ac,$0fff
	    dc.w	$01ae,$0fff
	    dc.w	$01b0,$05b5
	    dc.w	$01b2,$0252
	    dc.w	$01b4,$0241
	    dc.w	$01b6,$0131
	    dc.w	$01b8,$0120
	    dc.w	$01ba,$0010
	    dc.w	$01bc,$0fff
	    dc.w	$01be,$0fff
	
raz:	dc.w	$3001,$fffe
	dc.w	$0100,$5000
	dc.w	$4001,$fffe
	dc.w	$0108
ian:	dc.w	$0000
	dc.w	$010a
ian2:	dc.w	$0000
	dc.w	$4101,$fffe
	dc.w	$0108
ian1:	dc.w	$0000
	dc.w	$010a
ian3:	dc.w	$0000
	dc.w	$4201,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4301,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4401,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4501,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4601,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4701,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4801,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4901,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4a01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4b01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4c01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4d01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4e01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$4f01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5001,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5101,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5201,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5301,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5401,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5501,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5601,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5701,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5801,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5901,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5a01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5c01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5d01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5e01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$5f01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6001,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6101,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6201,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6301,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6401,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6501,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6601,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6701,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6801,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6901,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6a01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6b01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6c01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6d01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6e01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$6f01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7001,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7101,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7201,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7301,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7401,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7501,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7601,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7701,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7801,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7901,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7a01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7b01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7c01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000	
	dc.w	$7d01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7e01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$7f01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8001,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8101,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8201,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8301,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8401,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8501,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8601,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8701,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8801,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8901,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8a01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8b01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8c01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8d01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8e01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$8f01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9001,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9101,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9201,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9301,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9401,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9501,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9601,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9701,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9801,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9a01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9b01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9c01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9d01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9e01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$9f01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$a001,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$a101,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$a201,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$a301,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$a401,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$a501,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$a601,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$a701,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$a801,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$a901,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$aa01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$ab01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$ac01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$ad01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$ac01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$ad01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$ae01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$af01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$b001,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$b101,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000	
	dc.w	$b201,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$b301,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$b401,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$b501,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$b601,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000	
	dc.w	$b701,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$b801,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$b901,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$ba01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$bb01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$bc01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$bd01,$fffe
	dc.w	$0108,$0000
	dc.w	$010a,$0000
	dc.w	$be01,$fffe
	dc.w	$0108
clunk:	
	dc.w	$0000
	dc.w	$010a
clund:	
	dc.w	$0000
	dc.w	$bf01,$fffe
	dc.w	$0108
ianend:	
	dc.w	$0000
	dc.w	$010a
ianend1:
	dc.w	$0000

	dc.w	$c001,$fffe
	dc.w	$0100,$0000
	dc.w	$c101,$fffe
	dc.w	$0180,$0fff
	dc.w	$c201,$fffe
	dc.w	$0180,$0000
	dc.w	$e401,$fffe
	dc.w	$008e,$0040
	dc.w	$0090,$00e0
	dc.w	$0092,$0020
	dc.w	$0094,$01e0
	dc.w	$0108,$0024
	dc.w	$010a,$0024
	dc.w	$0100,$1000
	dc.w	$00e0,$0007
	dc.w	$00e2,$0000
	dc.w	$0182,$0111
	dc.w	$0102,$0000
	dc.w	$e501,$fffe
	dc.w	$0182,$0222
	dc.w	$0102,$0011
	dc.w	$e601,$fffe
	dc.w	$0182,$0333
	dc.w	$0102,$0022
	dc.w	$e701,$fffe
	dc.w	$0182,$0444
	dc.w	$0102,$0033
	dc.w	$e801,$fffe
	dc.w	$0182,$0555
	dc.w	$0102,$0033
	dc.w	$0180,$0100
	dc.w	$e901,$fffe
	dc.w	$0182,$0666
	dc.w	$0102,$0044
	dc.w	$0180,$0200
	dc.w	$ea01,$fffe
	dc.w	$0182,$0777
	dc.w	$0102,$0044
	dc.w	$0180,$0300
	dc.w	$eb01,$fffe
	dc.w	$0182,$0888
	dc.w	$0102,$0055
	dc.w	$0180,$0400
	dc.w	$ec01,$fffe
	dc.w	$0182,$0999
	dc.w	$0102,$0055
	dc.w	$0180,$0500
	dc.w	$ed01,$fffe
	dc.w	$0182,$0aaa
	dc.w	$0102,$0066
	dc.w	$0180,$0600
	dc.w	$ee01,$fffe
	dc.w	$0182,$0bbb
	dc.w	$0102,$0066
	dc.w	$0180,$0700
	dc.w	$ef01,$fffe
	dc.w	$0182,$0ccc
	dc.w	$0102,$0066
	dc.w	$0180,$0800
	dc.w	$f001,$fffe
	dc.w	$0182,$0ddd
	dc.w	$0102,$0077
	dc.w	$0180,$0900
	dc.w	$f101,$fffe
	dc.w	$0182,$0eee
	dc.w	$0102,$0077
	dc.w	$0180,$0a00
	dc.w	$f201,$fffe
	dc.w	$0182,$0eee
	dc.w	$0102,$0077
	dc.w	$0180,$0b00
	dc.w	$f301,$fffe
	dc.w	$0182,$0ddd
	dc.w	$0102,$0077
	dc.w	$0180,$0a00
	dc.w	$f401,$fffe
	dc.w	$0182,$0ccc
	dc.w	$0102,$0077
	dc.w	$0180,$0900
	dc.w	$f501,$fffe
	dc.w	$0182,$0bbb
	dc.w	$0102,$0066
	dc.w	$0180,$0800
	dc.w	$f601,$fffe
	dc.w	$0182,$0aaa
	dc.w	$0102,$0066
	dc.w	$0180,$0700
	dc.w	$f701,$fffe
	dc.w	$0182,$0999
	dc.w	$0102,$0066
	dc.w	$0180,$0600
	dc.w	$f801,$fffe
	dc.w	$0182,$0888
	dc.w	$0102,$0055
	dc.w	$0180,$0500
	dc.w	$f901,$fffe
	dc.w	$0182,$0777
	dc.w	$0102,$0055
	dc.w	$0180,$0400
	dc.w	$fa01,$fffe
	dc.w	$0182,$0666
	dc.w	$0102,$0044
	dc.w	$0180,$0300
	dc.w	$fb01,$fffe
	dc.w	$0182,$0555
	dc.w	$0102,$0044
	dc.w	$0180,$0200
	dc.w	$fc01,$fffe
	dc.w	$0182,$0444
	dc.w	$0102,$0033
	dc.w	$0180,$0100
	dc.w	$fd01,$fffe
	dc.w	$0182,$0333
	dc.w	$0102,$0022
	dc.w	$0180,$0000
	dc.w	$fe01,$fffe
	dc.w	$0182,$0222
	dc.w	$0102,$0011
	dc.w	$ff01,$fffe
	dc.w	$0182,$0111
	dc.w	$0102,$0000
	dc.w	$ffe1,$fffe

	dc.w	$0101,$fffe
	dc.w	$0100,$0000
	dc.w	$0205,$fffe
	dc.w	$0180,$0000
	dc.w	$0305,$fffe
	dc.w	$0180,$0000
	dc.w	$0405,$fffe
	dc.w	$0180,$0000

pix1:	dc.w	$0501,$fffe
	dc.w	$0180,$0000
	dc.w	$0555,$fffe
	dc.w	$0180,$0000
;	dc.w	$0551,$fffe
;	dc.w	$0180,$0000

	dc.w	$0601,$fffe
	dc.w	$0180,$0000
	dc.w	$0655,$fffe
	dc.w	$0180,$0000
;	dc.w	$0651,$fffe
;	dc.w	$0180,$0000

	dc.w	$0701,$fffe
	dc.w	$0180,$0000
	dc.w	$0755,$fffe
	dc.w	$0180,$0000
;	dc.w	$0751,$fffe
;	dc.w	$0180,$0000

	dc.w	$0801,$fffe
	dc.w	$0180,$0000
	dc.w	$0855,$fffe
	dc.w	$0180,$0000
;	dc.w	$0851,$fffe
;	dc.w	$0180,$0000

	dc.w	$0901,$fffe
	dc.w	$0180,$0000
	dc.w	$0955,$fffe
	dc.w	$0180,$0000
;	dc.w	$0951,$fffe
;	dc.w	$0180,$0000

	dc.w	$0a01,$fffe
	dc.w	$0180,$0000
	dc.w	$0a55,$fffe
	dc.w	$0180,$0000
;	dc.w	$0a51,$fffe
;	dc.w	$0180,$0000

	dc.w	$0b01,$fffe
	dc.w	$0180,$0000
	dc.w	$0b55,$fffe
	dc.w	$0180,$0000
;	dc.w	$0b51,$fffe
;	dc.w	$0180,$0000

	dc.w	$0c01,$fffe
	dc.w	$0180,$0000
	dc.w	$0c55,$fffe
	dc.w	$0180,$0000
;	dc.w	$0c51,$fffe
;	dc.w	$0180,$0000

pix2:	dc.w	$0d01,$fffe
	dc.w	$0180,$0000
	dc.w	$0d55,$fffe
	dc.w	$0180,$0000
;	dc.w	$0d51,$fffe
;	dc.w	$0180,$0000

;	dc.w	$0e01,$fffe
;	dc.w	$0180,$0000
;	dc.w	$0e55,$fffe
;	dc.w	$0180,$0000
;	dc.w	$0e51,$fffe
;	dc.w	$0180,$0000

pix3:	dc.w	$0f01,$fffe
	dc.w	$0180,$0000
	dc.w	$0f55,$fffe
	dc.w	$0180,$0000
;	dc.w	$0f51,$fffe
;	dc.w	$0180,$0000

	dc.w	$1001,$fffe
	dc.w	$0180,$0000
	dc.w	$1055,$fffe
	dc.w	$0180,$0000
;	dc.w	$1051,$fffe
;	dc.w	$0180,$0000

	dc.w	$1101,$fffe
	dc.w	$0180,$0000
	dc.w	$1155,$fffe
	dc.w	$0180,$0000
;	dc.w	$1151,$fffe
;	dc.w	$0180,$0000

	dc.w	$1201,$fffe
	dc.w	$0180,$0000
	dc.w	$1255,$fffe
	dc.w	$0180,$0000
;	dc.w	$1251,$fffe
;	dc.w	$0180,$0000

	dc.w	$1301,$fffe
	dc.w	$0180,$0000
	dc.w	$1355,$fffe
	dc.w	$0180,$0000
;	dc.w	$1351,$fffe
;	dc.w	$0180,$0000

	dc.w	$1401,$fffe
	dc.w	$0180,$0000
	dc.w	$1455,$fffe
	dc.w	$0180,$0000
;	dc.w	$1451,$fffe
;	dc.w	$0180,$0000

	dc.w	$1501,$fffe
	dc.w	$0180,$0000
	dc.w	$1555,$fffe
	dc.w	$0180,$0000
;	dc.w	$1551,$fffe
;	dc.w	$0180,$0000

	dc.w	$1601,$fffe
	dc.w	$0180,$0000
	dc.w	$1655,$fffe
	dc.w	$0180,$0000
;	dc.w	$1651,$fffe
;	dc.w	$0180,$0000

pix4:	dc.w	$1701,$fffe
	dc.w	$0180,$0000
	dc.w	$1755,$fffe
	dc.w	$0180,$0000
;	dc.w	$1751,$fffe
;	dc.w	$0180,$0000

;	dc.w	$1801,$fffe
;	dc.w	$0180,$0000
;	dc.w	$1855,$fffe
;	dc.w	$0180,$0000
;	dc.w	$1851,$fffe
;	dc.w	$0180,$0000

pix5:	dc.w	$1901,$fffe
	dc.w	$0180,$0000
	dc.w	$1955,$fffe
	dc.w	$0180,$0000
;	dc.w	$1951,$fffe
;	dc.w	$0180,$0000

	dc.w	$1a01,$fffe
	dc.w	$0180,$0000
	dc.w	$1a55,$fffe
	dc.w	$0180,$0000
;	dc.w	$1a51,$fffe
;	dc.w	$0180,$0000

	dc.w	$1b01,$fffe
	dc.w	$0180,$0000
	dc.w	$1b55,$fffe
	dc.w	$0180,$0000
;	dc.w	$1b51,$fffe
;	dc.w	$0180,$0000

	dc.w	$1c01,$fffe
	dc.w	$0180,$0000
	dc.w	$1c55,$fffe
	dc.w	$0180,$0000
;	dc.w	$1c51,$fffe
;	dc.w	$0180,$0000

	dc.w	$1d01,$fffe
	dc.w	$0180,$0000
	dc.w	$1d55,$fffe
	dc.w	$0180,$0000
;	dc.w	$1d51,$fffe
;	dc.w	$0180,$0000

	dc.w	$1e01,$ffee
	dc.w	$0180,$0000
	dc.w	$1e55,$fffe
	dc.w	$0180,$0000
;	dc.w	$1e51,$fffe
;	dc.w	$0180,$0000

	dc.w	$1f01,$fffe
	dc.w	$0180,$0000
	dc.w	$1f55,$fffe
	dc.w	$0180,$0000
;	dc.w	$1f51,$fffe
;	dc.w	$0180,$0000

	dc.w	$2001,$fffe
	dc.w	$0180,$0000
	dc.w	$2055,$fffe
	dc.w	$0180,$0000
;	dc.w	$2051,$fffe
;	dc.w	$0180,$0000

pix6:	dc.w	$2101,$fffe
	dc.w	$0180,$0000
	dc.w	$2155,$fffe
	dc.w	$0180,$0000
;	dc.w	$2151,$fffe
;	dc.w	$0180,$0000
	
;	dc.w	$2201,$fffe
;	dc.w	$0180,$0000
;	dc.w	$2255,$fffe
;	dc.w	$0180,$0000
;	dc.w	$2251,$fffe
;	dc.w	$0180,$0000

pix7:	dc.w	$2301,$fffe
	dc.w	$0180,$0000
	dc.w	$2355,$fffe
	dc.w	$0180,$0000
;	dc.w	$2351,$fffe
;	dc.w	$0180,$0000

	dc.w	$2401,$fffe
	dc.w	$0180,$0000
	dc.w	$2455,$fffe
	dc.w	$0180,$0000
;	dc.w	$2451,$fffe
;	dc.w	$0180,$0000

	dc.w	$2501,$fffe
	dc.w	$0180,$0000
	dc.w	$2555,$fffe
	dc.w	$0180,$0000
;	dc.w	$2551,$fffe
;	dc.w	$0180,$0000

	dc.w	$2601,$fffe
	dc.w	$0180,$0000
	dc.w	$2655,$fffe
	dc.w	$0180,$0000
;	dc.w	$2651,$fffe
;	dc.w	$0180,$0000

	dc.w	$2701,$fffe
	dc.w	$0180,$0000
	dc.w	$2755,$fffe
	dc.w	$0180,$0000
;	dc.w	$2751,$fffe
;	dc.w	$0180,$0000

	dc.w	$2801,$fffe
	dc.w	$0180,$0000
	dc.w	$2855,$fffe
	dc.w	$0180,$0000
;	dc.w	$2851,$fffe
;	dc.w	$0180,$0000

	dc.w	$2901,$fffe
	dc.w	$0180,$0000
	dc.w	$2955,$fffe
	dc.w	$0180,$0000
;	dc.w	$2951,$fffe
;	dc.w	$0180,$0000

	dc.w	$2a01,$fffe
	dc.w	$0180,$0000
	dc.w	$2a55,$fffe
	dc.w	$0180,$0000
;	dc.w	$2a51,$fffe
;	dc.w	$0180,$0000

pix8:	dc.w	$2b01,$fffe
	dc.w	$0180,$0000
	dc.w	$2b55,$fffe
	dc.w	$0180,$0000
;	dc.w	$2b51,$fffe
;	dc.w	$0180,$0000

	dc.w	$2c01,$fffe
	dc.w	$0180,$0000
	dc.w	$2c55,$fffe
	dc.w	$0180,$0000
	dc.w	$2c51,$fffe
	dc.w	$0180,$0000
	dc.w	$2d01,$fffe

	dc.w	$0180,$0000

	dc.w	$ffff,$fffe