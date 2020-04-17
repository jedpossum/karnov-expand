portraitwrites:
	movem.l a3/a6,-(a7)
	moveq #0,d0
	moveq #0,d2
	move.b (charid,a1),d0
	lsl.w #1,d0
	cmpa.l #player2mem,a1
	beq.b portp2
	lea.l $401000,a6
	bra.b portpass

portp2:
	lea.l $401280,a6

portpass:
	lea.l portidramoffset,a3
	move.w (a3,d0),d0
	adda.w d0,a6

	move.b (charid,a1),d2
	move.w #%0000110110011001,d0
	btst d2,d0
	bne.b write2palettes

palette1line:
	moveq #0,d0
	lea.l portraitpointers,a3
	lsl.w #2,d2
	movea.l (a3,d2),a3
	move.b (palid,a1),d0
	lsl.w #5,d0
	adda.w d0,a3

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

write2palettes:
	moveq #0,d0
	lea.l portraitpointers,a3
	lsl.w #2,d2
	movea.l (a3,d2),a3
	move.b (palid,a1),d0
	lsl.w #6,d0
	adda.w d0,a3

	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
	move.l (a3)+,(a6)+
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
portidramoffset:
	dc.w $000,$040,$060,$080
	dc.w $0c0,$100,$120,$140
	dc.w $180,$200,$220,$1c0
	dc.w $260

portraitpointers:;7267e
	dc.l rayportpnt,feiportpnt,ryokoportpnt,matportpnt
	dc.l samportpnt,leeportpnt,mizportpnt,jeanportpnt
	dc.l marportpnt,yunportpnt,zazportpnt,clnportpnt
	dc.l karportpnt


;ray		40  2 +0
;feilin		20  1 +40
;ryoko		20  1 +60
;matlok		40  2 +80

;samchay	40  2 +c0
;lee		20  1 +100
;mizo		20  1 +120
;jean		40  2 +140

;mars		40  2 +180
;yungmie	20  1 +200
;zazie		40  2 +220
;clown		40  2 +1c0

;karnov		20  1 +260

;fedc ba98 7654 3210
;0000 1101 1001 1001


;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
rayportpnt:;40
	incbin "charpal/Ray/rayport0"
	incbin "charpal/Ray/rayport1"
	incbin "charpal/Ray/rayport2"
	incbin "charpal/Ray/rayport3"
	incbin "charpal/Ray/rayport4"
	incbin "charpal/Ray/rayport5"
	incbin "charpal/Ray/rayport0"
	incbin "charpal/Ray/rayport0"

feiportpnt:;20
	incbin "charpal/Feilin/feiport0"
	incbin "charpal/Feilin/feiport1"
	incbin "charpal/Feilin/feiport2"
	incbin "charpal/Feilin/feiport3"
	incbin "charpal/Feilin/feiport4"
	incbin "charpal/Feilin/feiport0"
	incbin "charpal/Feilin/feiport0"
	incbin "charpal/Feilin/feiport0"

ryokoportpnt:;20
	incbin "charpal/Ryoko/ryokoport0"
	incbin "charpal/Ryoko/ryokoport1"
	incbin "charpal/Ryoko/ryokoport2"
	incbin "charpal/Ryoko/ryokoport3"
	incbin "charpal/Ryoko/ryokoport4"
	incbin "charpal/Ryoko/ryokoport0"
	incbin "charpal/Ryoko/ryokoport0"
	incbin "charpal/Ryoko/ryokoport0"

matportpnt:;40
	incbin "charpal/Matlok/matport0"
	incbin "charpal/Matlok/matport1"
	incbin "charpal/Matlok/matport2"
	incbin "charpal/Matlok/matport3"
	incbin "charpal/Matlok/matport4"
	incbin "charpal/Matlok/matport5"
	incbin "charpal/Matlok/matport6"
	incbin "charpal/Matlok/matport7"

samportpnt:;40
	incbin "charpal/Samchay/samport0"
	incbin "charpal/Samchay/samport1"
	incbin "charpal/Samchay/samport2"
	incbin "charpal/Samchay/samport3"
	incbin "charpal/Samchay/samport4"
	incbin "charpal/Samchay/samport5"
	incbin "charpal/Samchay/samport6"
	incbin "charpal/Samchay/samport7"

leeportpnt:;20
	incbin "charpal/Lee/leeport0"
	incbin "charpal/Lee/leeport1"
	incbin "charpal/Lee/leeport2"
	incbin "charpal/Lee/leeport0"
	incbin "charpal/Lee/leeport4"
	incbin "charpal/Lee/leeport0"
	incbin "charpal/Lee/leeport0"
	incbin "charpal/Lee/leeport0"

mizportpnt:;20
	incbin "charpal/Mizo/mizoport0"
	incbin "charpal/Mizo/mizoport1"
	incbin "charpal/Mizo/mizoport2"
	incbin "charpal/Mizo/mizoport3"
	incbin "charpal/Mizo/mizoport0"
	incbin "charpal/Mizo/mizoport0"
	incbin "charpal/Mizo/mizoport0"
	incbin "charpal/Mizo/mizoport0"

jeanportpnt:;40
	incbin "charpal/Jean/jeanport0"
	incbin "charpal/Jean/jeanport1"
	incbin "charpal/Jean/jeanport2"
	incbin "charpal/Jean/jeanport3"
	incbin "charpal/Jean/jeanport0"
	incbin "charpal/Jean/jeanport0"
	incbin "charpal/Jean/jeanport0"
	incbin "charpal/Jean/jeanport0"

marportpnt:;40
	incbin "charpal/Mars/marsport0"
	incbin "charpal/Mars/marsport1"
	incbin "charpal/Mars/marsport2"
	incbin "charpal/Mars/marsport3"
	incbin "charpal/Mars/marsport4"
	incbin "charpal/Mars/marsport0"
	incbin "charpal/Mars/marsport0"
	incbin "charpal/Mars/marsport0"

yunportpnt:;20
	incbin "charpal/Yungmie/yungport0"
	incbin "charpal/Yungmie/yungport1"
	incbin "charpal/Yungmie/yungport2"
	incbin "charpal/Yungmie/yungport3"
	incbin "charpal/Yungmie/yungport4"
	incbin "charpal/Yungmie/yungport0"
	incbin "charpal/Yungmie/yungport0"
	incbin "charpal/Yungmie/yungport0"

zazportpnt:;40
	incbin "charpal/Zazie/zazport0"
	incbin "charpal/Zazie/zazport1"
	incbin "charpal/Zazie/zazport2"
	incbin "charpal/Zazie/zazport3"
	incbin "charpal/Zazie/zazport4"
	incbin "charpal/Zazie/zazport0"
	incbin "charpal/Zazie/zazport0"
	incbin "charpal/Zazie/zazport0"

clnportpnt:;40
	incbin "charpal/Clown/clownport0"
	incbin "charpal/Clown/clownport1"
	incbin "charpal/Clown/clownport2"
	incbin "charpal/Clown/clownport3"
	incbin "charpal/Clown/clownport0"
	incbin "charpal/Clown/clownport5"
	incbin "charpal/Clown/clownport0"
	incbin "charpal/Clown/clownport0"

karportpnt:;20
	incbin "charpal/Karnov/karnport0"
	incbin "charpal/Karnov/karnport1"
	incbin "charpal/Karnov/karnport2"
	incbin "charpal/Karnov/karnport0"
	incbin "charpal/Karnov/karnport0"
	incbin "charpal/Karnov/karnport0"
	incbin "charpal/Karnov/karnport0"
	incbin "charpal/Karnov/karnport7"
