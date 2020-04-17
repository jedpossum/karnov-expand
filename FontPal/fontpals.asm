p1palload:
	moveq #0,d0
	moveq #0,d2
	movem.l a3/a6,-(a7)
	move.b (charid,a0),d0
	lsl.w #8,d0
	move.b (palid,a0),d2
	lsl.w #5,d2
	add.w d0,d2
	lea fontpalette,a3
	adda.w d2,a3
	lea $400060,a6
	bra.b newpalwrite

p2palload:
	moveq #0,d0
	moveq #0,d2
	movem.l a3/a6,-(a7)
	move.b (charid,a0),d0
	lsl.w #8,d0
	move.b (palid,a0),d2
	lsl.w #5,d2
	add.w d0,d2
	lea fontpalette,a3
	adda.w d2,a3
	lea $400080,a6

newpalwrite:
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

randomfontpal:
	moveq #0,d0
	movem.l a3/a6,-(a7)
	lea fontpalette,a3
	move.b rngread,d0
	andi.w #$7f,d0
	lsl.w #5,d0
	adda.w d0,a3
	lea.l $400040,a6
	bra newpalwrite


fontpalette:
;Ray
	incbin "FontPal/font/classicfont1";Classic Blue
	incbin "FontPal/font/classicfont2";Classic Gray
	incbin "FontPal/font/rayfont3";Orange to Green Pale
	incbin "FontPal/font/rayfont4";Red to blue
;Green font
	dc.w $58ad,$4010,$0cff,$3bec,$0aea,$78d7,$57d4,$36b1
	dc.w $04b2,$60a1,$3090,$2080,$2172,$0070,$2161,$6152
	incbin "FontPal/font/notsf2font"
	incbin "FontPal/font/origpink"
	incbin "FontPal/font/whiteoutline"

;Feilin
	incbin "FontPal/font/classicfont3";Classic Gold
	incbin "FontPal/font/notsf2font"
	incbin "FontPal/font/purpletoblue"
	incbin "FontPal/font/rayfont3";Orange to Green Pale
	incbin "FontPal/font/classicfont1";Classic Blue
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"

;Ryoko
	incbin "FontPal/font/classicfont5";Classic Brown
	incbin "FontPal/font/ryokofont2";orange to green
	incbin "FontPal/font/classicfont6";Classic Green
	incbin "FontPal/font/ryokofont4";Gray Blue with Blue Outline
	incbin "FontPal/font/purpletoblue"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"

;Matlok
	incbin "FontPal/font/classicfont1";Classic Blue
	incbin "FontPal/font/grn2blue"
	incbin "FontPal/font/classicfont6";Classic Green
	incbin "FontPal/font/ryokofont2";orange to green
	incbin "FontPal/font/classicfont4";Classic Red
	incbin "FontPal/font/bipridefont"
	incbin "FontPal/font/whtblueredgrad"
	incbin "FontPal/font/whiteoutline"

;Samchay
	incbin "FontPal/font/w2grn"
	incbin "FontPal/font/origgrey"
	incbin "FontPal/font/eveningfont"
	incbin "FontPal/font/classicfont1";Classic Blue
	incbin "FontPal/font/purpletoblue"
	incbin "FontPal/font/classicfont5";Classic Brown
	incbin "FontPal/font/samfont6"
	incbin "FontPal/font/classicfont4";Classic Red

;Lee
	incbin "FontPal/font/purpletoblue"
	incbin "FontPal/font/origgrey"
	incbin "FontPal/font/classicfont3";Classic Gold
	incbin "FontPal/font/purewhite"
;Gold font
	dc.w $799b,$0000,$7ffc,$7ff9,$6ff6,$4ff5,$2fe4,$6ed2
	dc.w $6dc0,$2db0,$0ca0,$0b90,$5a80,$4971,$6862,$4863
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"

;Mizo
	incbin "FontPal/font/origgrey"
	incbin "FontPal/font/origcyan"
;Green font
	dc.w $58ad,$4010,$0cff,$3bec,$0aea,$78d7,$57d4,$36b1
	dc.w $04b2,$60a1,$3090,$2080,$2172,$0070,$2161,$6152
	incbin "FontPal/font/classicfont3";Classic Gold
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"

;Jean
;Green font
	dc.w $58ad,$4010,$0cff,$3bec,$0aea,$78d7,$57d4,$36b1
	dc.w $04b2,$60a1,$3090,$2080,$2172,$0070,$2161,$6152
	incbin "FontPal/font/origgrey"
	incbin "FontPal/font/origcyan"
	incbin "FontPal/font/origpink"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"

;Mars
	incbin "FontPal/font/wht2brwn"
	incbin "FontPal/font/classicfont3";Classic Gold
	incbin "FontPal/font/classicfont6";Classic Green
	incbin "FontPal/font/classicfont4";Classic Red
	incbin "FontPal/font/purpletoblue"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"

;Yungmie
	incbin "FontPal/font/origgrey"
	incbin "FontPal/font/origcyan"
	incbin "FontPal/font/notsf2font"
	incbin "FontPal/font/ryokofont2";orange to green
	incbin "FontPal/font/classicfont1";Classic Blue
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"

;Zazie
;Red Font
	dc.w $29ad,$0000,$0f93,$5f82,$6f61,$7e40,$7e30,$1e30
	dc.w $5d20,$1d20,$5c20,$1c20,$1b20,$5920,$7710,$5510
	incbin "FontPal/font/classicfont5";Classic Brown
	incbin "FontPal/font/origgrey"
	incbin "FontPal/font/origcyan"
	incbin "FontPal/font/notsf2font"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"

;Clown
	incbin "FontPal/font/classicfont1";Classic Blue
	incbin "FontPal/font/classicfont4";Classic Red
;Gold font
	dc.w $799b,$0000,$7ffc,$7ff9,$6ff6,$4ff5,$2fe4,$6ed2
	dc.w $6dc0,$2db0,$0ca0,$0b90,$5a80,$4971,$6862,$4863
;Green font
	dc.w $58ad,$4010,$0cff,$3bec,$0aea,$78d7,$57d4,$36b1
	dc.w $04b2,$60a1,$3090,$2080,$2172,$0070,$2161,$6152
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purpletoblue"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"

;Karnov
	incbin "FontPal/font/classicfont4";Classic Red
	incbin "FontPal/font/origgrey"
	incbin "FontPal/font/purpletoblue"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/purewhite"
	incbin "FontPal/font/classicfont1";Classic Blue

;Ox
	incbin "FontPal/font/classicfont1";Classic Blue
	incbin "FontPal/font/classicfont2";Classic Gray
	incbin "FontPal/font/classicfont3";Classic Gold
	incbin "FontPal/font/classicfont4";Classic Red
	incbin "FontPal/font/classicfont5";Classic Brown
	incbin "FontPal/font/classicfont6";Classic Green
	incbin "FontPal/font/whiteoutline"
	incbin "FontPal/font/purpletoblue"

;set1
;Gold font
	dc.w $799b,$0000,$7ffc,$7ff9,$6ff6,$4ff5,$2fe4,$6ed2
	dc.w $6dc0,$2db0,$0ca0,$0b90,$5a80,$4971,$6862,$4863

;Green font
	dc.w $58ad,$4010,$0cff,$3bec,$0aea,$78d7,$57d4,$36b1
	dc.w $04b2,$60a1,$3090,$2080,$2172,$0070,$2161,$6152

;Red Font
	dc.w $29ad,$0000,$0f93,$5f82,$6f61,$7e40,$7e30,$1e30
	dc.w $5d20,$1d20,$5c20,$1c20,$1b20,$5920,$7710,$5510
	incbin "FontPal/font/origgrey"
	incbin "FontPal/font/origcyan"
	incbin "FontPal/font/notsf2font"
	incbin "FontPal/font/rayfont3"
	incbin "FontPal/font/rayfont4"

;Set2
	incbin "FontPal/font/ryokofont2";orange to green
	incbin "FontPal/font/w2grn"
	incbin "FontPal/font/eveningfont"
	incbin "FontPal/font/samfont6"

	incbin "FontPal/font/bipridefont"
	incbin "FontPal/font/wht2brwn"
	incbin "FontPal/font/whiteoutline"
	incbin "FontPal/font/purewhite"
