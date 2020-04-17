CharacterWinBG:
	movem.l a6,-(a7)
	moveq #0,d1
	move.b (charid,a1),d1
	lea.l CharWinPalettes,a5
	lsl.w #6,d1
	adda.w d1,a5
	lea.l $4000c0,a6

	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	move.l (a5)+,(a6)+
	movem.l (a7)+,a6
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;WinQuote 4000c0
;CharaSel 4000e0

CharWinPalettes:
;Ray Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$1d98,$3edd,$3edd;pig fucking pink
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$1431,$8fa9,$6fbb

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$1213,$3edd,$3edd;pig shit
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$1111,$1322,$1431

;Feilin Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0675,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0aa0,$0888,$6a88

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0d48,$3edd,$3edd;Pink
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$080d,$0e59,$0f6a

;Ryoko Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0040,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0a40,$2050,$0070

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$2222,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0a00,$7333,$0555

;Matlok Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$2252,$3edd,$3edd;punk green
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0422,$0242,$2222

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$4522,$3edd,$3edd;punk red
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0242,$0422,$4222

;Samchay Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0a72,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0710,$0674,$0666

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0666,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0a31,$0674,$0a72

;Lee Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0111,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$7246,$7333,$7444

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$086a,$3edd,$3edd;violet
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0a00,$097b,$6a8c

;Mizo Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$7ccc,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0c00,$0ddd,$7ddd

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$7888,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0a00,$7999,$0aaa

;Jean Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0880,$3edd,$3edd;"Yellow is the new red"
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0444,$4990,$0bb0

	dc.w $0000,$3edd,$3edd,$3edd,$099d,$099d,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0c00,$0bbd,$0ddd

;Mars Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0015,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0760,$0016,$0017

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0add,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0e00,$0ddd,$7111

;Yungmie
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$1445,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0026,$4655,$0777

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0994,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$00a4,$0aa7,$0aaa

;Zazie Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0542,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0042,$0653,$0764

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0651,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$0222,$0852,$0a53

;Clown Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0b50,$3edd,$3edd;orange
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$4aa0,$0c60,$0d70

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0518,$3edd,$3edd;purple
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$4aa0,$0629,$773a

;Karnov Done
	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0600,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$6aa0,$4700,$0900

	dc.w $0000,$3edd,$3edd,$3edd,$3edd,$0900,$3edd,$3edd
	dc.w $3edd,$3edd,$3edd,$3edd,$3edd,$6aa0,$4a00,$0c00
