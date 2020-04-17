charpalwrite:
	movem.l a3/a6,-(a7)

;weak point check
	move.b (charid,a1),d2
	move.w #%0001011010001010,d0
	btst d2,d0
	beq.w mainwrites


	moveq #0,d0
	moveq #0,d2
	move.b (charid,a1),d0
	move.b (palid,a1),d2
	lsl.w #2,d0
	cmpa.l #player2mem,a1
	beq.b p2weak
	lea.l weakpalramp1,a6
	bra.b weakpass

p2weak:
	lea.l weakpalramp2,a6

weakpass:
	movea.l (a6,d0),a6
	lea.l weakpointers,a3
	movea.l (a3,d0),a3
	lsl #5,d2
	adda.w d2,a3
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	bra.w mainwrites

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
weakpalramp1:;0010 0110 1000 1010
	dc.l $000000,$4009c0,$000000,$4009e0;1010
	dc.l $000000,$000000,$000000,$4009e0;1000
	dc.l $000000,$4009a0,$4009a0,$000000;0110
	dc.l $4009e0,$000000;0001

weakpalramp2:
	dc.l $000000,$400bc0,$000000,$400be0;1010
	dc.l $000000,$000000,$000000,$400be0;1000
	dc.l $000000,$400ba0,$400ba0,$000000;0110
	dc.l $400be0,$000000;0001

weakpointers:
	dc.l $0,feiweak,0,matlkokweak
	dc.l $0,0,0,jeanweak
	dc.l $0,yungweak,zazweak,0
	dc.l karnovweak,0

;==============================================================================
;Writing the Main Palette
mainwrites:
	moveq #0,d0
	moveq #0,d2
	move.b (charid,a1),d0
	move.b (palid,a1),d2
	lsl.w #2,d0
	cmpa.l #player2mem,a1
	beq.b p2palram
	lea.l player1palram,a6
	bra.b p1pass

p2palram:
	lea.l player2palram,a6

p1pass:
	movea.l (a6,d0),a6
	lsl #6,d0
	lsl #5,d2
	add.w d0,d2
	lea characterpalettes,a3
	adda.w d2,a3
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	movem.l (a7)+,a3/a6
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
player1palram:
	dc.l $400800,$400820,$400840,$400860
	dc.l $400880,$4008a0,$4008c0,$4008e0
	dc.l $400900,$400920,$400940,$400960
	dc.l $400980,$401bc0

player2palram:
	dc.l $400a00,$400a20,$400a40,$400a60
	dc.l $400a80,$400aa0,$400ac0,$400ae0
	dc.l $400b00,$400b20,$400b40,$400b60
	dc.l $400b80,$401bc0

characterpalettes:
	incbin "charpal/Ray/ray0"
	incbin "charpal/Ray/ray1"

	incbin "charpal/Ray/ray2";Jed
	incbin "charpal/Ray/ray3";Jed
	incbin "charpal/Ray/ray4";Hal
	incbin "charpal/Ray/ray5";Jed
	incbin "charpal/Ray/ray6";Hal
	incbin "charpal/Ray/ray7";Hal

;Feilin
	incbin "charpal/Feilin/feilin0"
	incbin "charpal/Feilin/feilin1"

	incbin "charpal/Feilin/feilin2";Jed FH1 Snes
	incbin "charpal/Feilin/feilin3";Jed FH1
	incbin "charpal/Feilin/feilin4";Jed
	incbin "charpal/Feilin/feilin5";Hal
	incbin "charpal/Feilin/feilin6";Hal
	incbin "charpal/Feilin/feilin7";Hal

;Ryoko
	incbin "charpal/Ryoko/ryoko0"
	incbin "charpal/Ryoko/ryoko1"

	incbin "charpal/Ryoko/ryoko2";Jed FH Mizo
	incbin "charpal/Ryoko/ryoko3";Jed FH Mizo
	incbin "charpal/Ryoko/ryoko4";Jed
	incbin "charpal/Ryoko/ryoko5";Hal
	incbin "charpal/Ryoko/ryoko6";Hal
	incbin "charpal/Ryoko/ryoko7";Hal

;Matlok
	incbin "charpal/Matlok/matlok0"
	incbin "charpal/Matlok/matlok1"

	incbin "charpal/Matlok/matlok2"; Jed fh1
	incbin "charpal/Matlok/matlok3"; Jed fh1snes
	incbin "charpal/Matlok/matlok4"; Jed
	incbin "charpal/Matlok/matlok5"; Jed
	incbin "charpal/Matlok/matlok6"; Jed
	incbin "charpal/Matlok/matlok7"; Jed

;Samchay
	incbin "charpal/Samchay/samchay0"
	incbin "charpal/Samchay/samchay1"

	incbin "charpal/Samchay/samchay2";Jed FH1
	incbin "charpal/Samchay/samchay3";Jed
	incbin "charpal/Samchay/samchay4";Jed
	incbin "charpal/Samchay/samchay5";Jed Old Color Hack
	incbin "charpal/Samchay/samchay6";Jed
	incbin "charpal/Samchay/samchay7";Jed

;Lee
	incbin "charpal/Lee/lee0"
	incbin "charpal/Lee/lee1"

	incbin "charpal/Lee/lee2";Jed fh1
	incbin "charpal/Lee/lee3";Hal
	incbin "charpal/Lee/lee4";Hal
	incbin "charpal/Lee/lee5";Hal
	incbin "charpal/Lee/lee6";Hal
	incbin "charpal/Lee/lee7";Hal

;Mizo
	incbin "charpal/Mizo/mizo0";
	incbin "charpal/Mizo/mizo1";

	incbin "charpal/Mizo/mizo2";Jed fh1
	incbin "charpal/Mizo/mizo3";Jed fh mizo
	incbin "charpal/Mizo/mizo4";Hal
	incbin "charpal/Mizo/mizo5";Hal
	incbin "charpal/Mizo/mizo6";Hal
	incbin "charpal/Mizo/mizo7";Hal

;Jean
	incbin "charpal/Jean/jean0"
	incbin "charpal/Jean/jean1"

	incbin "charpal/Jean/jean2";Jed
	incbin "charpal/Jean/jean3";Jed
	incbin "charpal/Jean/jean4";Hal
	incbin "charpal/Jean/jean5";Hal
	incbin "charpal/Jean/jean6";Hal
	incbin "charpal/Jean/jean7";Hal

;Marstorius
	incbin "charpal/Mars/mars0"
	incbin "charpal/Mars/mars1"

	incbin "charpal/Mars/mars2";Jed
	incbin "charpal/Mars/mars3";Jed
	incbin "charpal/Mars/mars4";Jed
	incbin "charpal/Mars/mars5";Hal
	incbin "charpal/Mars/mars6";Hal
	incbin "charpal/Mars/mars7";Hal

;Yungmie
	incbin "charpal/Yungmie/yungmie0"
	incbin "charpal/Yungmie/yungmie1"

	incbin "charpal/Yungmie/yungmie2";Jed Fatal Fury Special
	incbin "charpal/Yungmie/yungmie3";Jed FH Mizo Snes
	incbin "charpal/Yungmie/yungmie4";Jed Suiko Enbu
	incbin "charpal/Yungmie/yungmie5";Hal
	incbin "charpal/Yungmie/yungmie6";Hal
	incbin "charpal/Yungmie/yungmie7";Hal

;Zazie
	incbin "charpal/Zazie/zazie0"
	incbin "charpal/Zazie/zazie1"

	incbin "charpal/Zazie/zazie2";Jed FH Mizo Snes
	incbin "charpal/Zazie/zazie3";Jed ST April Fools
	incbin "charpal/Zazie/zazie4";Jed
	incbin "charpal/Zazie/zazie5";Hal
	incbin "charpal/Zazie/zazie6";Hal
	incbin "charpal/Zazie/zazie7";Hal

;Clown
	incbin "charpal/Clown/clown0"
	incbin "charpal/Clown/clown1"

	incbin "charpal/Clown/clown2";Jed FH Mizo Snes
	incbin "charpal/Clown/clown3";Jed FH1 Snes
	incbin "charpal/Clown/clown4";Hal
	incbin "charpal/Clown/clown5";Jed
	incbin "charpal/Clown/clown6";Hal
	incbin "charpal/Clown/clown7";Hal

;Karnov
	incbin "charpal/Karnov/karnov0"
	incbin "charpal/Karnov/karnov1"

	incbin "charpal/Karnov/karnov2";Jed
	incbin "charpal/Karnov/karnov3";Hal
	incbin "charpal/Karnov/karnov4";Hal
	incbin "charpal/Karnov/karnov5";Hal
	incbin "charpal/Karnov/karnov6";Hal
	incbin "charpal/Karnov/karnov7";Jed Karnov NES

;Ox
	incbin "charpal/Ox/ox0"
	incbin "charpal/Ox/ox1";Jed
	incbin "charpal/Ox/ox0"
	incbin "charpal/Ox/ox1"
	incbin "charpal/Ox/ox0"
	incbin "charpal/Ox/ox1"
	incbin "charpal/Ox/ox0"
	incbin "charpal/Ox/ox1"

;Weak Points Palettes
feiweak:
	incbin "charpal/Feilin/feiweak0"
	incbin "charpal/Feilin/feiweak1"
	incbin "charpal/Feilin/feiweak2"
	incbin "charpal/Feilin/feiweak3"

	incbin "charpal/Feilin/feiweak4"
	incbin "charpal/Feilin/feiweak5"
	incbin "charpal/Feilin/feiweak6"
	incbin "charpal/Feilin/feiweak7"

matlkokweak:
	incbin "charpal/Matlok/matweak0"
	incbin "charpal/Matlok/matweak1"
	incbin "charpal/Matlok/matweak0"
	incbin "charpal/Matlok/matweak3"
	
	incbin "charpal/Matlok/matweak4"
	incbin "charpal/Matlok/matweak5"
	incbin "charpal/Matlok/matweak6"
	incbin "charpal/Matlok/matweak7"

jeanweak:
	incbin "charpal/Jean/jeanweak0"
	incbin "charpal/Jean/jeanweak1"
	incbin "charpal/Jean/jeanweak2"
	incbin "charpal/Jean/jeanweak3"
	
	incbin "charpal/Jean/jeanweak4"
	incbin "charpal/Jean/jeanweak5"
	incbin "charpal/Jean/jeanweak6"
	incbin "charpal/Jean/jeanweak0"

yungweak:
	incbin "charpal/Yungmie/yungweak0"
	incbin "charpal/Yungmie/yungweak1"
	incbin "charpal/Yungmie/yungweak2"
	incbin "charpal/Yungmie/yungweak3"

	incbin "charpal/Yungmie/yungweak4"
	incbin "charpal/Yungmie/yungweak5"
	incbin "charpal/Yungmie/yungweak6"
	incbin "charpal/Yungmie/yungweak7"

zazweak:
	incbin "charpal/Zazie/zazweak0"
	incbin "charpal/Zazie/zazweak1"
	incbin "charpal/Zazie/zazweak2"
	incbin "charpal/Zazie/zazweak3"

	incbin "charpal/Zazie/zazweak4"
	incbin "charpal/Zazie/zazweak5"
	incbin "charpal/Zazie/zazweak6"
	incbin "charpal/Zazie/zazweak7"

karnovweak:
	incbin "charpal/Karnov/karnweak0"
	incbin "charpal/Karnov/karnweak1"
	incbin "charpal/Karnov/karnweak2"
	incbin "charpal/Karnov/karnweak3"

	incbin "charpal/Karnov/karnweak4"
	incbin "charpal/Karnov/karnweak5"
	incbin "charpal/Karnov/karnweak6"
	incbin "charpal/Karnov/karnweak7"
