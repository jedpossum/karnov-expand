;Fighters History Dynamite
;By Jed
;
	include "ng.constants.asm"
	include "memoryloc.asm"

VectorTable:
	dc.l	$0010F300, BiosStartup, BusError,   AddrsError;	$00
	dc.l	IllInstrct, BasicError, BasicError, BasicError;	$10
	dc.l	PrivViolat, TraceInstr, BasicError, BasicError;	$20
	dc.l	BasicError, BasicError, BasicError, PrepIntrpt;	$30
	dc.l	BasicError, BasicError, BasicError, BasicError;	$40
	dc.l	BasicError, BasicError, BasicError, BasicError;	$50
	dc.l	SpurIntrpt, loc_004944, loc_004a98, BasicError;	$60
	dc.l	BasicError, BasicError, BasicError, BasicError;	$70

;##############################################################################
loc_000080:
	nop
	lea.l $103a78,a1
	btst #0,(a1)
	bne.b loc_000096
	btst #1,(a1)
	beq.w loc_0000f4

loc_000096:
	moveq #4,d0
	lea.l $103a7c,a2

loc_00009e:
	btst d0,(a1)
	beq.b loc_0000ea
	move.w (a2)+,d3
	moveq #0,d3
	move.b (a2)+,d3
	lsl.l #5,d3
	lea.l palramaddr,a3
	lea.l $103a98,a4
	adda.l d3,a3
	adda.l d3,a4
	moveq #0,d1
	move.b (a2)+,d1

loc_0000be:
	move.l (a4)+,(a3)+
	move.l (a4)+,(a3)+
	move.l (a4)+,(a3)+
	move.l (a4)+,(a3)+
	move.l (a4)+,(a3)+
	move.l (a4)+,(a3)+
	move.l (a4)+,(a3)+
	move.l (a4)+,(a3)+
	dbra d1,loc_0000be
	move.b (2,a1),d1
	cmpi.b #$3e,d1
	bcs.b loc_0000ea
	bclr d0,(a1)
	cmpi.b #$f,(a1)
	bcc.b loc_0000ea
	move.l #0,(a1)

loc_0000ea:
	addq.w #1,d0
	cmpi.w #8,d0
	bmi.w loc_00009e

loc_0000f4:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0000f6:
	dc.w $ffac

loc_0000f8:
	rts

loc_0000fa:
	dc.w $ffff,$ffff,$ffff

;Neo Geo Header
loc_000100:
	dc.b 'NEO-GEO',00

NGH_NUMBER:
	dc.w $66			;NGH
	dc.l $100000		;PROM
	dc.l $100000		;Debug Dips
	dc.w $1000			;Dip Size
	dc.b $00			;Bootup
	dc.b $00			;BootGFXloc
	dc.l US_CONFIG		;JP_CONFIG
	dc.l US_CONFIG		;US_CONFIG
	dc.l US_CONFIG		;EU_CONFIG

	jmp USER
	jmp PLAYER_START
	jmp DEMO_END
	jmp COIN_SOUND

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00013a:
	dc.w $ffff,$ffff,$ffff,$ffff
	dc.w $ffff,$ffff,$ffff,$ffff
	dc.w $ffff,$ffff,$ffff,$ffff
	dc.w $ffff,$ffff,$ffff,$ffff
	dc.w $ffff,$ffff,$ffff,$ffff
	dc.w $ffff,$ffff,$ffff,$ffff
	dc.w $ffff,$ffff,$ffff,$ffff
	dc.w $ffff,$ffff,$ffff,$ffff
	dc.w $ffff,$ffff,$ffff,$ffff
	dc.w $0000

;==============================================================================
Unusedloc_000184:
	bclr d0,d6
	moveq #0,d3
	tst.w ($a14,a5)
	bne.w loc_0001ca
	movea.l ($a04,a5),a0
	move.w ($a08,a5),d7

loc_000198:
	move.b d0,REG_DIPSW
	move.w (a0),d1
	cmpi.b #$ff,d1
	beq.b loc_0001c0
	move.w (2,a0),d0
	cmp.b ($ace,a5),d0
	bne.b loc_0001c0
	move.w (4,a0),d0
	cmp.b ($acf,a5),d0
	bne.b loc_0001c0
	cmp.b ($ad0,a5),d1
	beq.b loc_0001c8

loc_0001c0:
	addq.l #8,a0
	dbra d7,loc_000198
	move.w d7,d3

loc_0001c8:
	rts

loc_0001ca:
	movea.l ($a04,a5),a0
	move.w ($a08,a5),d7

loc_0001d2:
	move.w (a0),d1
	lsr.w #8,d1
	cmpi.b #$ff,d1
	beq.b loc_0001f6
	move.w (a0),d0
	cmp.b ($ace,a5),d0
	bne.b loc_0001f6
	move.w (2,a0),d0
	lsr.w #8,d0
	cmp.b ($acf,a5),d0
	bne.b loc_0001f6
	cmp.b ($ad0,a5),d1
	beq.b loc_0001fe

loc_0001f6:
	addq.l #4,a0
	dbra d7,loc_0001d2
	move.w d7,d3

loc_0001fe:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
US_CONFIG:
	dc.b 'FHD/KRVRV EXPAND'
;	dc.b 'KARNOVEMBER 2019'
;	dc.b 'F. HISTORY      '
;	dc.b "KARNOV'S REVENGE"
	dc.w $ffff,$ffff
	dc.b $ff,$ff;Counters
	dc.b $02,$38,$02,$02,$04,$3D,$2D,$1D,$0D,$06

	dc.b 'CONTINUE    '
	dc.b 'INFINITE    '
	dc.b 'WITHOUT     '

	dc.b 'DIFFICULTY  '
	dc.b 'LEVEL 1     '
	dc.b 'LEVEL 2     '
	dc.b 'LEVEL 3     '
	dc.b 'LEVEL 4     '
	dc.b 'LEVEL 5     '
	dc.b 'LEVEL 6     '
	dc.b 'LEVEL 7     '
	dc.b 'LEVEL 8     '

	dc.b 'DEMO SOUND  '
	dc.b 'WITH        '
	dc.b 'WITHOUT     '

	dc.b 'HOW TO PLAY '
	dc.b 'WITH        '
	dc.b 'WITHOUT     '

	dc.b 'LVL/CRD DISP'
	dc.b 'ON /ON      '
	dc.b 'ON /OFF     '
	dc.b 'OFF/ON      '
	dc.b 'OFF/OFF     '

;Stages that won't come up for a bit
	dc.b '1ST STG SKIP'
	dc.b 'RAY         '
	dc.b 'FEILIN      '
	dc.b 'RYOKO       '
	dc.b 'MATLOK      '
	dc.b 'SAMCHAY     '
	dc.b 'LEE         '
	dc.b 'MIZOGUCHI   '
	dc.b 'JEAN        '
	dc.b 'MARSTORIUS  '
	dc.b 'YUNGMIE     '
	dc.b 'ZAZIE       '
	dc.b 'CLOWN       '
	dc.b 'KARNOV      '

	dc.b '2ND STG SKIP'
	dc.b 'RAY         '
	dc.b 'FEILIN      '
	dc.b 'RYOKO       '
	dc.b 'MATLOK      '
	dc.b 'SAMCHAY     '
	dc.b 'LEE         '
	dc.b 'MIZOGUCHI   '
	dc.b 'JEAN        '
	dc.b 'MARSTORIUS  '
	dc.b 'YUNGMIE     '
	dc.b 'ZAZIE       '
	dc.b 'CLOWN       '
	dc.b 'KARNOV      '

	dc.b '3RD STG SKIP'
	dc.b 'RAY         '
	dc.b 'FEILIN      '
	dc.b 'RYOKO       '
	dc.b 'MATLOK      '
	dc.b 'SAMCHAY     '
	dc.b 'LEE         '
	dc.b 'MIZOGUCHI   '
	dc.b 'JEAN        '
	dc.b 'MARSTORIUS  '
	dc.b 'YUNGMIE     '
	dc.b 'ZAZIE       '
	dc.b 'CLOWN       '
	dc.b 'KARNOV      '

	dc.b '4TH STG SKIP'
	dc.b 'RAY         '
	dc.b 'FEILIN      '
	dc.b 'RYOKO       '
	dc.b 'MATLOK      '
	dc.b 'SAMCHAY     '
	dc.b 'LEE         '
	dc.b 'MIZOGUCHI   '
	dc.b 'JEAN        '
	dc.b 'MARSTORIUS  '
	dc.b 'YUNGMIE     '
	dc.b 'ZAZIE       '
	dc.b 'CLOWN       '
	dc.b 'KARNOV      '

	dc.b 'EVENT MODE  '
	dc.b 'CASUALS     '
	dc.b '1 WIN       '
	dc.b '2 WINS      '
	dc.b '3 WINS      '
	dc.b '5 WINS      '
	dc.b '10 WINS     '
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

;##############################################################################
Unusedloc_000650:
	move.w d0,d3
	muls.w d2,d3
	asr.l #8,d3
	sub.w d3,d0
	move.w d1,d3
	muls.w d2,d3
	asr.l #8,d3
	sub.w d3,d1
	move.w d2,d3
	subq.w #1,d2
	lsl.w #4,d2
	subq.w #1,d3
	lsl.w #8,d3
	rts

;##############################################################################
loc_00066c:
	lsr.w #4,d2
	addi.w #$10,d2
	move.w d0,d7
	muls.w d2,d7
	asr.l #8,d7
	sub.w d7,d0
	lsr.w #8,d3
	addq.w #1,d3
	move.w d1,d7
	muls.w d3,d7
	asr.l #8,d7
	sub.w d7,d1
	rts

;==============================================================================
Unusedloc_000688:
	move.w (a6),d2
	andi.w #$1000,d2
	lsl.w #3,d2
	or.w (4,a6),d2
	lea.l $032020,a0
	tst.w d2
	bpl.b loc_0006a6
	andi.w #$7fff,d2
	add.w (-$20,a0),d2

loc_0006a6:
	add.w d2,d2
	add.w d2,d2
	movea.l (a0,d2.w),a0
	tst.w (a0)+
	bmi.b loc_0006c8
	move.w (a0)+,d2
	andi.w #$1f,d2
	add.w d2,d2
	add.w d2,d2
	adda.w d2,a0
	move.w (a0)+,d1
	move.w (a0)+,d0
	neg.w d1
	neg.w d0
	rts

loc_0006c8:
	addq.l #6,a0
	move.w (a0)+,d1
	move.w (a0)+,d0
	neg.w d1
	neg.w d0
	rts

;==============================================================================
Unusedloc_0006d4:
	move.w (a6),d2
	andi.w #$1000,d2
	lsl.w #3,d2
	or.w (4,a6),d2
	lea.l $032020,a0
	tst.w d2
	bpl.b loc_0006f2
	andi.w #$7fff,d2
	add.w (-$20,a0),d2

loc_0006f2:
	add.w d2,d2
	add.w d2,d2
	movea.l (a0,d2.w),a0
	tst.w (a0)+
	bmi.b loc_000710
	move.w (a0)+,d2
	andi.w #$1f,d2
	add.w d2,d2
	add.w d2,d2
	adda.w d2,a0
	sub.w (a0)+,d1
	sub.w (a0)+,d0
	rts

loc_000710:
	addq.l #6,a0
	sub.w (a0)+,d1
	sub.w (a0)+,d0
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

	include "Data/AiData.asm"


loc_003730:
	dc.l loc_003750
	dc.l SYS_RETURN
	dc.l loc_003762
	dc.l loc_003782

;##############################################################################
USER:
	moveq #0,d0
	move.b BIOS_USER_REQUEST,d0
	lsl.w #2,d0
	movea.l loc_003730(pc,d0.w),a0
	jmp (a0)

;##############################################################################
loc_003750:
	clr.w $100068
	jsr loc_0133f8
	jmp SYS_RETURN

;##############################################################################
loc_003762:
	jsr loc_0037a2(pc)
	nop
	move.w #1,mainmode
	clr.w $101004
	jsr loc_005b5c
	jmp loc_005ab0

;##############################################################################
loc_003782:
	jsr loc_0037a2(pc)
	nop
	move.w #0,mainmode
	clr.w $101004
	jsr loc_005b5c
	jmp loc_005ab0

;##############################################################################
loc_0037a2:
	addq.b #1,BIOS_MESS_BUSY
	bclr #7,BIOS_SYSTEM_MODE
	jsr loc_006954
	jsr loc_0038ce(pc)
	nop
	move.b #3,SOUNDREG
	jsr loc_003874(pc)
	nop
	subq.b #1,BIOS_MESS_BUSY
	bset #7,BIOS_SYSTEM_MODE
	move.w #8,$106930
	rts

;##############################################################################
PLAYER_START:
	cmpi.b #2,BIOS_USER_MODE
	beq.b loc_0037f8
	move.b $101000,d0
	andi.b #3,d0
	beq.b loc_003802

loc_0037f8:
	clr.b BIOS_START_FLAG
	bra.w loc_00385e

loc_003802:
	move.b BIOS_START_FLAG,d0
	tst.b BIOS_MVS_FLAG
	bne.b loc_003828
	btst #0,d0
	beq.b loc_00381c
	subq.b #1,$106b5e

loc_00381c:
	btst #1,d0
	beq.b loc_003828
	subq.b #1,$106b5f

loc_003828:
	or.b d0,$101000
	btst #0,d0
	beq.b loc_00383e
	lea.l player1mem,a0
	bsr.w loc_003a22

loc_00383e:
	btst #1,$101000
	beq.b loc_003852
	lea.l player2mem,a0
	bsr.w loc_003a22

loc_003852:
	bsr.w loc_00394a
	move.b #2,BIOS_USER_MODE

loc_00385e:
	rts

;##############################################################################
DEMO_END:
	rts

;##############################################################################
COIN_SOUND:
	tst.w $100068
	bne.b loc_003872
	move.w #2,$100068

loc_003872:
	rts

;##############################################################################
loc_003874:
	bset #3,$101001
	clr.w TIMERSTOP
	jsr FIX_CLEAR
	jsr LSP_1ST
	lea.l VRAMADDR,a0
	lea.l VRAMRW,a1
	moveq #0,d1
	moveq #$20,d0

loc_00389e:
	move.w d1,(a0)
	nop
	nop
	move.w d0,(a1)
	addq.w #1,d1
	cmpi.w #$40,d1
	bcs.b loc_00389e
	move.w #$8200,(a0)
	nop
	nop
	clr.w (a1)
	bclr #3,$101001
	move.w #7,IRQACK
	move.w #$2000,sr
	rts

;##############################################################################
loc_0038ce:
	jsr loc_00682e
	move.l #$101424,$101420
	move.l #$10101c,$10141c
	move.l #$10699e,$10692c
	lea.l player1mem,a0
	lea.l (playeroffset,a0),a1
	move.b #1,(a1)
	move.l #player2mem,($14,a0)
	move.l #player1mem,($14,a1)
	move.b #6,(2,a1)
	lea.l $1068ac,a0
	move.l #$1068ac,($10,a0)
	move.l #$1068ac,($14,a0)
	move.b #1,($19,a0)

;	move.w #$ffff,vsstagecounter
	move.b BIOS_GAMEDIP_06,prevstageholder
	move.b BIOS_GAMEDIP_07,prevstageholder+1
	move.b BIOS_GAMEDIP_08,prevstageholder+2
	move.b BIOS_GAMEDIP_09,prevstageholder+3

	jsr loc_006ef2
	move.w #$404,$106b5e
	rts

;##############################################################################
loc_00394a:
	moveq #0,d0
	andi.b #3,$101000
	bset #4,$101000
	move.b #$10,$101001
	bset #7,$101000
	move.b #$13,$106987
	move.w #8,$106930
	move.b d0,$103a78
	move.w #1,$10346c
	move.w d0,$101010
	move.w d0,$101018
	move.w d0,$101012
	move.l d0,$105c98
	move.b d0,$103a72
	move.b d0,$103a73
	move.w #3,mainmode
	move.w d0,$101004
	move.w d0,$106908
	move.b BIOS_GAMEDIP_02,GameDifficulty
	tst.b BIOS_MVS_FLAG
	bne.b loc_0039dc
	move.w #9,$106908

loc_0039dc:
	move.w d0,$10690a
	move.w d0,$10690e
	move.w d0,$106910
	lea.l $106914,a2
	move.l d0,(a2)+
	move.l d0,(a2)+
	move.l d0,(a2)+
	move.l d0,$106920
	move.l d0,$106924
	move.l d0,$106928
	move.b #$15,$1068c6
	jsr loc_00ded2
	jsr loc_006ef2
	rts

;##############################################################################
loc_003a22:
	moveq #7,d7
	moveq #0,d0
	moveq #0,d1
	moveq #0,d2
	moveq #0,d3
	lea.l (playeroffset,a0),a1

loc_003a30:
	movem.l d0-d3,-(a1)
	movem.l d0-d3,-(a1)
	movem.l d0-d3,-(a1)
	movem.l d0-d3,-(a1)
	dbra d7,loc_003a30
	cmpa.l #player1mem,a0
	beq.b loc_003a74
	move.b #1,BIOS_PLAYER2_MODE
	move.b #1,(a0)
	move.b #6,(2,a0)
	move.b #6,(1,a0)
	move.l #player1mem,($14,a0)
	jsr loc_006f0e
	bra.b loc_003a8a

loc_003a74:
	move.b #1,BIOS_PLAYER1_MODE
	move.l #player2mem,($14,a0)
	jsr loc_006ef8

loc_003a8a:
	move.b #1,(4,a0)
	move.b #$10,($b8,a0)
	move.b (a0),d1
	btst d1,$101000
	bne.b loc_003aa6
	bset #7,($b8,a0)

loc_003aa6:
	movea.l ($14,a0),a1
	move.b (a1),d1
	btst d1,$101000
	bne.b loc_003aba
	bset #7,($b8,a1)

loc_003aba:
	rts

;##############################################################################
loc_003abc:
	lea.l player1mem,a0
	bsr.w loc_003bb4
	lea.l player2mem,a0
	bsr.w loc_003bb4
	lea.l player1mem,a0
	lea.l (playeroffset,a0),a1
	move.w ($fe,a0),d0
	or.w ($fe,a1),d0
	beq.w loc_003bb2
	tst.w ($fe,a0)
	bne.b loc_003b2c
	movea.l a1,a0

loc_003aee:
	jsr loc_00c592
	tst.b ($147,a0)
	bne.b loc_003b0a
	bsr.w loc_003c62
	move.w #3,$10346c
	bra.w loc_003bb2

loc_003b0a:
	bsr.w loc_003c62
	move.w #1,$10346c
	btst #2,($146,a0)
	beq.w loc_003bb2
	move.w #2,$10346c
	bra.w loc_003bb2

loc_003b2c:
	tst.w ($fe,a1)
	beq.b loc_003aee
	move.b ($147,a0),d0
	or.b ($147,a1),d0
	bne.b loc_003b5e
	move.w #3,$10346c
	move.w ($fe,a0),($d0,a0)
	bclr #0,($bf,a0)
	move.w ($fe,a1),($d0,a1)
	bclr #0,($bf,a1)
	bra.b loc_003bb2

loc_003b5e:
	tst.b ($147,a0)
	bne.b loc_003b72

loc_003b64:
	bsr.w loc_003c62
	move.w #3,$10346c
	bra.b loc_003bb2

loc_003b72:
	tst.b ($147,a1)
	bne.b loc_003b7c
	movea.l a1,a0
	bra.b loc_003b64

loc_003b7c:
	move.w ($fe,a0),($d0,a0)
	bclr #0,($bf,a0)
	move.w ($fe,a1),($d0,a1)
	bclr #0,($bf,a1)
	move.w #1,$10346c
	move.b ($146,a0),d0
	or.b ($146,a1),d0
	btst #2,d0
	beq.b loc_003bb2
	move.w #2,$10346c

loc_003bb2:
	rts

;##############################################################################
loc_003bb4:
	clr.w ($fe,a0)
	btst #2,($bf,a0)
	bne.w loc_003c60
	btst #7,($bf,a0)
	beq.w loc_003c60
	move.w ($fc,a0),d4
	subi.w #$20,d4
	lsl.w #2,d4
	lea.l loc_0641c0,a1
	move.l (a1,d4.w),($11c,a0)
	cmpi.b #3,($145,a0)
	bne.b loc_003bfc
	bsr.w loc_003c9a
	moveq #0,d3
	cmpi.b #4,d2
	beq.b loc_003c1a
	bsr.w loc_003da2
	bra.b loc_003c1a

loc_003bfc:
	bsr.w loc_003c9a
	cmpi.b #4,d2
	beq.b loc_003c60
	bsr.w loc_003cca
	bsr.w loc_003da2
	bsr.w loc_003e2e
	bsr.w loc_003e56
	bsr.w loc_004074

loc_003c1a:
	bsr.w loc_003eda
	btst #2,($be,a0)
	beq.b loc_003c60
	tst.b ($147,a0)
	beq.b loc_003c60
	andi.b #$fc,($bc,a0)
	move.b #$20,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	movem.l d0-d3/a0,-(a7)
	move.l #$3e8,d0
	movea.l ($14,a0),a0
	jsr loc_0043a8
	movem.l (a7)+,d0-d3/a0

loc_003c60:
	rts

;##############################################################################
loc_003c62:
	move.w ($fe,a0),d0
	move.w d0,($d0,a0)
	bclr #0,($bf,a0)
	cmpi.w #$14,d0
	beq.b loc_003c82
	cmpi.w #9,d0
	bcs.b loc_003c90
	cmpi.w #$12,d0
	bcc.b loc_003c90

loc_003c82:
	lea.l loc_00b8f6,a1
	lsl.w #2,d0
	movea.l (a1,d0.w),a1
	jsr (a1)

loc_003c90:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_003c92:
	dc.w $00e0,$00d8,$00d4,$00dc

;##############################################################################
loc_003c9a:
	lea.l loc_003c92(pc),a1
	moveq #0,d2

loc_003ca0:
	move.w (a1)+,d3
	tst.w (a0,d3.w)
	bne.b loc_003cb2
	addq.w #1,d2
	cmpi.w #4,d2
	bcs.b loc_003ca0
	bra.b loc_003cc8

loc_003cb2:
	movem.w (a0,d3.w),d0-d1
	tst.w ($e4,a0)
	beq.b loc_003cc8
	movem.w ($e4,a0),d0-d1
	bset #$f,d2

loc_003cc8:
	rts

;##############################################################################
loc_003cca:
	moveq #0,d3
	tst.b ($14d,a0)
	bne.b loc_003d34
	btst #3,($bf,a0)
	bne.w loc_003da0
	cmpi.w #6,($d0,a0)
	bcc.w loc_003da0
	move.b ($30,a0),d4
	btst #0,d4
	bne.w loc_003da0
	move.b d4,d5
	andi.b #$c,d5
	beq.w loc_003da0
	cmpi.w #4,($100,a0)
	bcs.b loc_003d14
	move.b ($bd,a0),d6
	add.w d6,d6
	eor.b d4,d6
	btst #2,d6
	beq.w loc_003da0

loc_003d14:
	cmpi.b #1,($145,a0)
	beq.b loc_003d34
	btst #1,($30,a0)
	beq.b loc_003d2e
	cmpi.b #2,($145,a0)
	beq.b loc_003da0
	bra.b loc_003d34

loc_003d2e:
	tst.b ($145,a0)
	beq.b loc_003da0

loc_003d34:
	moveq #1,d3
	move.b #$19,($14d,a0)
	tst.b ($144,a0)
	beq.b loc_003d60
	move.b #$1a,($14d,a0)
	move.b #$16,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_003d76

loc_003d60:
	move.b #$15,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_003d76:
	move.w #5,($d0,a0)
	bset #0,($bf,a0)
	movem.w d0-d3,-(a7)
	clr.b ($122,a0)
	move.b #$f0,($123,a0)
	jsr loc_00c592
	jsr loc_00b7be
	movem.w (a7)+,d0-d3

loc_003da0:
	rts

;##############################################################################
loc_003da2:
	move.b ($146,a0),d4
	andi.b #$24,d4
	beq.b loc_003db4
	cmpi.b #$20,d4
	bne.w loc_003e1c

loc_003db4:
	movem.w d0-d3,-(a7)
	move.w d2,d4
	move.w d1,d2
	move.w d0,d1
	move.w d4,d5
	bclr #$f,d5
	cmpi.w #2,d5
	bne.b loc_003dce
	moveq #0,d5
	bra.b loc_003dd8

loc_003dce:
	tst.w d5
	bne.b loc_003dd6
	moveq #2,d5
	bra.b loc_003dd8

loc_003dd6:
	moveq #1,d5

loc_003dd8:
	tst.w d3
	beq.b loc_003df0
	btst #0,($146,a0)
	bne.b loc_003dea
	move.w d5,d0
	addq.w #1,d0
	bra.b loc_003e10

loc_003dea:
	move.w d5,d0
	addq.w #4,d0
	bra.b loc_003e10

loc_003df0:
	btst #$f,d4
	beq.b loc_003e02
	moveq #0,d0
	move.w #2,$101010
	bra.b loc_003e10

loc_003e02:
	move.w d5,d0
	addq.w #4,d0
	cmpi.b #1,($144,a0)
	bne.b loc_003e10
	addq.w #3,d0

loc_003e10:
	addq.w #1,d0
	jsr loc_00e1c0
	movem.w (a7)+,d0-d3

loc_003e1c:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_003e1e:
	dc.l $00050000
	dc.l $00080000
	dc.l $000b0000
	dc.l $00068000

;##############################################################################
loc_003e2e:
	move.l ($11c,a0),d5
	rol.l #2,d5
	andi.w #3,d5
	lsl.w #2,d5
	lea.l loc_003e1e(pc),a1
	move.l (a1,d5.w),d5
	movea.l ($14,a0),a1
	btst #0,($bd,a1)
	beq.b loc_003e50
	neg.l d5

loc_003e50:
	move.l d5,($10c,a0)
	rts

;##############################################################################
loc_003e56:
	cmpi.b #3,($145,a0)
	beq.w loc_003ed8
	move.b #$d,($14c,a0)
	btst #3,($bf,a0)
	beq.b loc_003e74
	move.w #9,d4
	bra.b loc_003ed4

loc_003e74:
	tst.w d3
	bne.w loc_003ed8
	btst #1,($146,a0)
	beq.b loc_003e88
	move.w #$11,d4
	bra.b loc_003ed4

loc_003e88:
	move.w d2,d5
	andi.w #$f,d5
	btst #2,($146,a0)
	beq.b loc_003ea8
	move.w #$10,d4
	btst #1,($30,a0)
	bne.b loc_003ed4
	move.w #$f,d4
	bra.b loc_003ed4

loc_003ea8:
	btst #1,($30,a0)
	bne.b loc_003ec8
	moveq #$b,d4
	tst.w d5
	bne.b loc_003ebc
	move.w #$c,d4
	bra.b loc_003ed4

loc_003ebc:
	cmpi.w #2,d5
	bne.b loc_003ed4
	move.w #$a,d4
	bra.b loc_003ed4

loc_003ec8:
	move.w #$d,d4
	tst.w d5
	beq.b loc_003ed4
	move.w #$e,d4

loc_003ed4:
	move.w d4,($fe,a0)

loc_003ed8:
	rts

;##############################################################################
loc_003eda:
	bsr.w loc_0040f2
	tst.w d3
	beq.b loc_003ef0
	btst #0,($146,a0)
	beq.w loc_004006
	bra.w loc_003f76

loc_003ef0:
	bsr.w loc_004008
	move.l ($11c,a0),d4
	move.w d4,d5
	lsr.w #8,d5
	andi.w #$7f,d5
	cmpi.b #3,($145,a0)
	beq.b loc_003f20
	tst.w d3
	bne.b loc_003f20
	btst #$f,d2
	beq.b loc_003f20
	btst #1,($bf,a0)
	bne.b loc_003f20
	move.w d5,d6
	lsr.w #1,d6
	add.w d6,d5

loc_003f20:
	move.b ($bc,a0),d6
	andi.b #3,d6
	move.b ($146,a0),d0
	andi.b #9,d0
	bne.b loc_003f4a
	addq.w #1,($114,a0)
	bset #0,($bc,a0)
	tst.b d6
	beq.b loc_003f5e
	lsr.b #1,d5
	move.b d5,d0
	lsr.b #1,d0
	add.b d0,d5
	bra.b loc_003f5e

loc_003f4a:
	bset #1,($bc,a0)
	btst #1,d6
	bne.b loc_003f5c
	addq.w #1,($114,a0)
	bra.b loc_003f5e

loc_003f5c:
	lsr.b #1,d5

loc_003f5e:
	bsr.w loc_004254
	cmpi.b #3,($145,a0)
	beq.b loc_003f76
	btst #0,($146,a0)
	bne.b loc_003f76
	bsr.w loc_00422e

loc_003f76:
	tst.w fighttimer
	beq.b loc_003f88
	sub.b d5,($147,a0)
	bcc.b loc_003f88
	clr.b ($147,a0)

loc_003f88:
	tst.b ($147,a0)
	bne.w loc_004006
	cmpi.b #3,($145,a0)
	bne.b loc_003fb0
	move.w #3,$10346c
	move.b #$30,($14c,a0)
	btst #0,($146,a0)
	bne.b loc_003fda
	bra.b loc_004006

loc_003fb0:
	move.b #$50,($14c,a0)
	move.w #$14,($fe,a0)
	move.b ($146,a0),d0
	btst #0,d0
	beq.b loc_004006
	cmpi.w #$160,($fc,a0)
	beq.b loc_003fda
	andi.b #$2c,d0
	beq.b loc_003fda
	cmpi.b #$20,d0
	bne.b loc_004006

loc_003fda:
	tst.w d3
	bne.b loc_004006
	move.w #$30,$101010
	movea.l ($14,a0),a1
	bset #7,($be,a1)
	movem.l d0-d3/a0,-(a7)
	movea.l a1,a0
	move.l #$1388,d0
	jsr loc_0043a8
	movem.l (a7)+,d0-d3/a0

loc_004006:
	rts

;##############################################################################
loc_004008:
	movem.l d0-d3/a0,-(a7)
	tst.w d3
	bne.b loc_004072
	move.l ($11c,a0),d3
	swap d3
	lsr.w #6,d3
	andi.w #$3f,d3
	lsl.w #2,d3
	lea.l loc_00a522,a1
	move.l (a1,d3.w),d0
	btst #1,($bc,a0)
	beq.b loc_00404a
	move.b ($146,a0),d3
	andi.b #9,d3
	beq.b loc_00404a
	lsr.w #1,d0
	divu.w #$32,d0
	andi.l #$ffff,d0
	mulu.w #$32,d0

loc_00404a:
	movea.l ($14,a0),a0
	jsr loc_0043a8
	movea.l ($14,a0),a1
	move.w ($fc,a1),d0
	subi.w #$20,d0
	sub.w ($d2,a0),d0
	move.l ($118,a0),d1
	bset d0,d1
	move.l d1,($118,a0)
	movem.l (a7)+,d0-d3/a0

loc_004072:
	rts

;##############################################################################
loc_004074:
	btst #1,($bf,a0)
	beq.b loc_0040c6
	tst.w d3
	bne.b loc_0040c6
	btst #$f,d2
	beq.b loc_0040c6
	move.b ($14b,a0),d4
	move.b #$ff,($14b,a0)
	cmpi.b #$ff,($14a,a0)
	bne.b loc_0040b2
	move.w #8,$101010
	bset #2,($be,a0)
	clr.b ($14a,a0)
	move.w #$14,($fe,a0)
	bra.b loc_0040c6

loc_0040b2:
	tst.b d4
	bne.b loc_0040b8
	moveq #$40,d4

loc_0040b8:
	add.b d4,($14a,a0)
	bcs.b loc_0040c0
	bne.b loc_0040c6

loc_0040c0:
	move.b #$ff,($14a,a0)

loc_0040c6:
	rts

;##############################################################################
loc_0040c8:
	cmpa.l #player1mem,a0
	bne.b loc_0040dc
	btst #6,$100000
	beq.b loc_0040dc
	moveq #0,d5

loc_0040dc:
	cmpa.l #player2mem,a0
	bne.b loc_0040f0
	btst #7,$100000
	beq.b loc_0040f0
	moveq #0,d5

loc_0040f0:
	rts

;##############################################################################
loc_0040f2:
	tst.w d3
	beq.b loc_004126
	btst #0,($146,a0)
	beq.w loc_00422c
	moveq #4,d5
	cmpi.b #$18,($143,a0)
	bcc.b loc_00410c
	moveq #3,d5

loc_00410c:
	move.b #9,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.w loc_00422c

loc_004126:
	cmpi.b #3,($145,a0)
	beq.w loc_00422c
	move.b ($146,a0),d4
	andi.b #$24,d4
	beq.b loc_004176
	cmpi.w #$160,($fc,a0)
	bne.b loc_00415c
	move.b #$1e,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.w loc_00422c

loc_00415c:
	move.b #$a,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.w loc_00422c

loc_004176:
	btst #0,($146,a0)
	beq.b loc_0041ba
	btst #6,($142,a0)
	bne.b loc_0041a0
	move.b #$12,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.w loc_00422c

loc_0041a0:
	move.b #$12,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.w loc_00422c

loc_0041ba:
	btst #6,($146,a0)
	beq.b loc_0041f8
	tst.b ($144,a0)
	bne.b loc_0041e0
	move.b #9,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_00422c

loc_0041e0:
	move.b #$a,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_00422c

loc_0041f8:
	tst.b ($144,a0)
	bne.b loc_004216
	move.b #$e,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_00422c

loc_004216:
	move.b #$d,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_00422c:
	rts

;##############################################################################
loc_00422e:
	cmpi.b #$18,($143,a0)
	bcc.b loc_00424a
	cmpi.b #$14,($143,a0)
	bcc.b loc_004242
	lsr.b #1,d5
	bra.b loc_00424a

loc_004242:
	lsr.b #1,d5
	move.b d5,d6
	lsr.b #1,d6
	add.b d6,d5

loc_00424a:
	cmpi.b #3,d5
	bcc.b loc_004252
	moveq #3,d5

loc_004252:
	rts

;##############################################################################
loc_004254:
	movem.l d0/a1,-(a7)
	move.b ($b8,a0),d0
	movea.l ($14,a0),a1
	or.b ($b8,a1),d0
	btst #7,d0
	bne.b loc_004280
	bra.b loc_004286
	btst #7,($b8,a0)
	bne.b loc_004286
	movea.l ($14,a0),a1
	btst #7,($b8,a1)
	beq.b loc_004286

loc_004280:
	move.w d5,d0
	lsr.w #2,d0
	add.w d0,d5

loc_004286:
	movem.l (a7)+,d0/a1
	rts

;##############################################################################
loc_00428c:
	jsr loc_004ac0
	tst.w $106986
	bne.w loc_00437e
	tst.b BIOS_MVS_FLAG
	beq.w loc_0042e8
;	tst.b BIOS_GAMEDIP_07;Level Display
	move.b BIOS_GAMEDIP_05,d0
	move.b #%0101,d2
	btst d0,d2
	beq.b loc_0042e8


	lea.l VRAMADDR,a0
	lea.l LEVELDISP(pc),a1
	nop
	move.w #$20,(4,a0)
	move.w #$2300,d2
	move.w #$721d,(a0)

loc_0042c8:
	move.b (a1)+,d2
	cmpi.b #$ff,d2
	beq.b loc_0042d6
	move.w d2,(2,a0)
	bra.b loc_0042c8

;Difficulty Display
loc_0042d6:
	move.b BIOS_GAMEDIP_02,d0
	andi.w #$f,d0
	addi.w #$2331,d0
	move.w d0,(2,a0)

loc_0042e8:
	move.b BIOS_MVS_FLAG,d6
	beq.b loc_0042fa
;	tst.b BIOS_GAMEDIP_05;Credit Display
	move.b BIOS_GAMEDIP_05,d0
	move.b #%0011,d1
	btst d0,d1
	beq.w loc_00437e

loc_0042fa:
	lea.l VRAMRW,a0
	move.w #$20,(2,a0)
	tst.b d6
	bne.b loc_004312
	lea.l $106b5e,a1
	bra.b loc_004326

loc_004312:
	lea.l BIOS_CREDIT1,a1
	tst.w BIOS_DEVMODE
	bne.b loc_004326
	lea.l credcount,a1

loc_004326:
	move.w #$300,d1
	move.w #$707d,(-2,a0)
	tst.b d6
	beq.b loc_00433e
	cmpi.b #1,BIOS_COUNTRY_CODE
	bne.b loc_004344

loc_00433e:
	bsr.w loc_00434a
	addq.l #1,a1

loc_004344:
	move.w #$739d,(-2,a0)

loc_00434a:
	lea.l CREDITSDISPLAYTEXT(pc),a2
	move.b (a1),d0
	cmpi.b #2,d0
	bcs.b loc_00435a
	lea.l ($10,a2),a2

loc_00435a:
	moveq #5,d7

loc_00435c:
	move.w (a2)+,d1
	move.w d1,(a0)
	dbra d7,loc_00435c
	move.w (a2)+,d1
	move.w d1,(a0)
	move.b d0,d2
	lsr.b #4,d2
	move.b d2,d1
	bsr.w loc_004374
	move.b d0,d1

loc_004374:
	andi.w #$f,d1
	addi.w #$2330,d1
	move.w d1,(a0)

loc_00437e:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
CREDITSDISPLAYTEXT:;Credit Display
	dc.w $2343,$2352,$2345,$2344,$2349,$2354,$00ff,$00ff;Credit
	dc.w $2300,$2301,$2302,$2303,$2304,$2305,$00ff,$00ff;Credits

LEVELDISP:;Difficulty Display
	dc.b "LEVEL-",$ff,$81

;##############################################################################
loc_0043a8:
	tst.w $106908
	beq.w loc_00442c
	move.b $101000,d1
	andi.b #3,d1
	bne.b loc_0043c2
	moveq #0,d0
	bra.b loc_0043cc

loc_0043c2:
	btst #7,($b8,a0)
	bne.w loc_00442c

loc_0043cc:
	add.l ($c,a0),d0
	cmpi.l #$98967f,d0
	bcs.b loc_0043de
	move.l #$98967f,d0

loc_0043de:
	move.l d0,($c,a0)
	move.l d0,d1
	bsr.w loc_0044ca
	move.l d2,d1
	cmpa.l #player1mem,a0
	bne.b loc_004402
	lea.l $106946,a2
	move.w #$237b,(a2)+
	move.w #$237c,(a2)+
	bra.b loc_004410

loc_004402:
	lea.l $106966,a2
	move.w #$237d,(a2)+
	move.w #$237e,(a2)+

loc_004410:
	lea.l ($20,a3),a3
	move.l d2,d1
	moveq #7,d7
	moveq #0,d6
	movem.w d3,-(a7)
	move.w #$2000,d3
	jsr loc_00442e(pc)
	nop
	movem.w (a7)+,d3

loc_00442c:
	rts

;==============================================================================
loc_00442e:
	moveq #0,d0

loc_004430:
	rol.l #4,d1
	move.w d1,d2
	andi.w #$f,d2
	beq.b loc_00443e
	moveq #1,d0
	bra.b loc_004456

loc_00443e:
	tst.w d7
	beq.b loc_004456
	tst.w d0
	bne.b loc_004456
	cmpi.w #1,d6
	beq.b loc_004460
	tst.w d6
	bne.b loc_004464
	lea.l (2,a2),a2
	bra.b loc_004464

loc_004456:
	addi.w #$330,d2
	add.w d3,d2
	move.w d2,(a2)+
	bra.b loc_004464

loc_004460:
	move.w #$ff,(a2)+

loc_004464:
	dbra d7,loc_004430
	rts

;##############################################################################
loc_00446a:
	moveq #0,d0

loc_00446c:
	rol.l #4,d1
	move.w d1,d2
	andi.w #$f,d2
	beq.b loc_00447a
	moveq #1,d0
	bra.b loc_00448e

loc_00447a:
	tst.w d7
	beq.b loc_00448e
	tst.w d0
	bne.b loc_00448e
	cmpi.w #1,d6
	beq.b loc_00449a
	tst.w d6
	bne.b loc_0044a4
	bra.b loc_0044a0

loc_00448e:
	addi.w #$330,d2
	add.w d3,d2
	move.w a3,(a2)+
	move.w d2,(a2)+
	bra.b loc_0044a0

loc_00449a:
	move.w a3,(a2)+
	move.w #$ff,(a2)+

loc_0044a0:
	lea.l ($20,a3),a3

loc_0044a4:
	dbra d7,loc_00446c
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0044aa:
	dc.l $00989680,$000f4240,$000186a0,$00002710
	dc.l $000003e8,$00000064,$0000000a,$00000001

;==============================================================================
loc_0044ca:
	cmpi.l #$98967f,d1
	bcs.b loc_0044d8
	move.l #$98967f,d1

loc_0044d8:
	moveq #0,d2
	moveq #7,d7
	lea.l loc_0044aa(pc),a1

loc_0044e0:
	lsl.l #4,d2

loc_0044e2:
	sub.l (a1),d1
	bcs.b loc_0044ea
	addq.w #1,d2
	bra.b loc_0044e2

loc_0044ea:
	add.l (a1)+,d1
	dbra d7,loc_0044e0
	rts

;==============================================================================
;Random number Generator
RandomNumberGen:
	move.l a0,-(a7)
	lea.l $100064,a0
	tst.l (a0)
	bne.b loc_004504
	move.l #$ffff0001,(a0)

loc_004504:
	move.w (a0),d0
	move.w d0,d1
	move.w d0,d2
	ror.w #4,d2
	add.w d2,d1
	andi.w #$f000,d1
	move.w d0,d2
	move.w d0,d3
	lsl.w #4,d3
	add.w d3,d2
	andi.w #$f00,d2
	or.w d2,d1
	move.w (2,a0),d0
	move.w d0,d2
	move.w d0,d3
	lsl.w #4,d2
	lsr.w #8,d3
	add.w d3,d2
	andi.w #$f0,d2
	or.w d2,d1
	move.w d0,d2
	move.w d0,d3
	lsr.w #4,d2
	lsr.w #8,d3
	add.w d3,d2
	andi.w #$f,d2
	or.w d2,d1
	add.w d1,(a0)
	sub.w (2,a0),d1
	move.w d1,(2,a0)
	move.w (a0),d0
	movea.l (a7)+,a0
	rts

;==============================================================================
loc_004554:
	movem.l d0-d4,-(a7)
	jsr RandomNumberGen(pc)
	andi.w #$ff,d0
	mulu.w d0,d7
	lsr.w #8,d7
	movem.l (a7)+,d0-d4
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;Frame count
loc_00456a:
	dc.b $30,$26,$1c,$1c

;==============================================================================
loc_00456e:
	lea.l fighttimer,a1
	tst.w (a1)
	beq.w loc_0045bc
	tst.b $103a72
	bne.b loc_0045bc
	btst #6,$101000
	bne.b loc_0045bc
	move.b $101000,d0
	andi.b #3,d0
	beq.b loc_0045bc
	subq.b #1,(1,a1)
	bcc.b loc_0045bc
;	lea.l loc_00456a(pc),a2;R
	move.w #1,d0

;R
;	tst.b BIOS_MVS_FLAG
;	beq.b loc_0045b4
;	move.b BIOS_GAMEDIP_06,d0

loc_0045b4:
	move.b #$26,(1,a1)
;	move.b (a2,d0.w),(1,a1)
	subq.b #1,(a1)

loc_0045bc:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;Character names
asciinames:
	dc.b "RAY             "
	dc.b "FEILIN          "
	dc.b "RYOKO           "
	dc.b "MATLOK          "
	dc.b "SAMCHAY         "
	dc.b "LEE             "
	dc.b "MIZOGUCHI       "
	dc.b "JEAN            "
	dc.b "MARSTORIUS      "
	dc.b "YUNGMIE         "
	dc.b "ZAZIE           "
	dc.b "CLOWN           "
	dc.b "KARNOV          "
	dc.b "OX              "
	dc.b "                "

;##############################################################################
loc_0046ae:
	movea.l $101420,a4
	moveq #0,d0
	move.b (1,a0),d0
;	cmpi.b #$d,d0
;	bne.b loc_0046cc
;	cmpi.b #2,$103a72
;	beq.b loc_0046cc
;	moveq #$e,d0
;
;loc_0046cc:
	lsl.w #4,d0
	lea.l asciinames(pc),a1
	adda.l d0,a1
	cmpa.l #player1mem,a0
	beq.b loc_0046e2
	lea.l $72c6.w,a2
	bra.b loc_0046fa

loc_0046e2:
	moveq #0,d0
	movea.l a1,a3

loc_0046e6:
	move.b (a3)+,d1
	cmpi.b #$20,d1
	beq.b loc_0046f2
	addq.w #1,d0
	bra.b loc_0046e6

loc_0046f2:
	lsl.w #5,d0
	lea.l $7246.w,a2
	suba.l d0,a2

loc_0046fa:
	move.w #$3300,d1
	cmpa.l #player1mem,a0 ;	move.b (palid,a0),d2;	andi.b #$f,d2
	beq.b loc_00470c;beq loc_00470c
	move.w #$4300,d1

loc_00470c:
	moveq #0,d0
	move.b (a1)+,d0
	cmpi.b #$20,d0
	beq.b loc_004722
	add.w d1,d0
	move.w a2,(a4)+
	move.w d0,(a4)+
	lea.l ($20,a2),a2
	bra.b loc_0046fa

loc_004722:
	move.l a4,$101420
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00472a:
	dc.w $e6c6,$e6c0,$e6ca,$e6c4
	dc.w $e6ce,$e6c8,$e6d2,$e6cc
	dc.w $e6d6,$e6e6,$e6c2

loc_004740:
	dc.w $e6c6,$e6d8,$e6da,$e6dc
	dc.w $e6de,$e6e0,$e6e2,$e6e4
	dc.w $e6d6,$e6c2,$e6e6

;##############################################################################
;Life Bar Render
loc_004756:
	lea.l loc_006fc8,a1
	movea.l $101420,a2
	moveq #0,d0
	move.b ($148,a0),d0
	move.b (a1,d0.w),d0
	cmpa.l #player1mem,a0
	bne.b loc_0047b0
	lea.l $7244.w,a3
	lea.l loc_00472a(pc),a4
	moveq #$f,d7

loc_00477e:
	cmpi.b #8,d0
	bcs.b loc_004788
	moveq #8,d1
	bra.b loc_00478a

loc_004788:
	move.b d0,d1

loc_00478a:
	sub.b d1,d0
	lea.l (-$20,a3),a3
	move.w a3,(a2)+
	andi.w #$ff,d1
	move.w d1,d2
	add.w d2,d2
	move.w (a4,d2.w),d2
	move.w d2,(a2)+
	lea.l (1,a3),a5
	move.w a5,(a2)+
	addq.w #1,d2
	move.w d2,(a2)+
	dbra d7,loc_00477e
	bra.b loc_0047ea

loc_0047b0:
	lea.l $72a4,a3
	lea.l loc_004740(pc),a4
	moveq #$f,d7

loc_0047ba
	cmpi.b #8,d0
	bcs.b loc_0047c4
	moveq #8,d1
	bra.b loc_0047c6

loc_0047c4:
	move.b d0,d1

loc_0047c6:
	sub.b d1,d0
	lea.l ($20,a3),a3
	move.w a3,(a2)+
	andi.w #$ff,d1
	move.w d1,d2
	add.w d2,d2
	move.w (a4,d2.w),d2
	move.w d2,(a2)+
	lea.l (1,a3),a5
	move.w a5,(a2)+
	addq.w #1,d2
	move.w d2,(a2)+
	dbra d7,loc_0047ba

loc_0047ea:
	move.w ($14,a4),d1
	bsr.w loc_0047fa
	move.l a2,$101420
	rts

;##############################################################################
loc_0047fa:
	move.w a3,(a2)+
	move.w d1,(a2)+
	lea.l (1,a3),a5
	move.w a5,(a2)+
	addq.w #1,d1
	move.w d1,(a2)+
	rts

;##############################################################################
loc_00480a:
	lea.l loc_006fc8,a1
	lea.l player1mem,a0
	bsr.w loc_00481e
	lea.l (playeroffset,a0),a0

loc_00481e:
	moveq #0,d0
	move.b ($147,a0),d0
	move.b (a1,d0.w),($143,a0)
	move.b ($148,a0),d0
	cmp.b ($147,a0),d0
	beq.b loc_004854
	subq.b #1,($148,a0)
	move.b ($148,a0),d0
	cmp.b ($147,a0),d0
	beq.b loc_004850
	btst #0,$10346b
	bne.b loc_004850
	subq.b #1,($148,a0)

loc_004850:
	bsr.w loc_004756

loc_004854:
	rts

;##############################################################################
loc_004856:
	moveq #0,d7
	move.b (7,a0),d7
	tst.w d7
	beq.w loc_0048de
	subq.w #1,d7
	movea.l $101420,a1
	cmpa.l #player1mem,a0
	bne.b loc_0048a6
	lea.l $7066.w,a2

loc_004876:
	movea.l a2,a3
	move.w a3,(a1)+
	move.w #$d6ba,(a1)+
	lea.l (1,a3),a3
	move.w a3,(a1)+
	move.w #$d6bb,(a1)+
	lea.l ($1f,a3),a3
	move.w a3,(a1)+
	move.w #$d6b8,(a1)+
	lea.l (1,a3),a3
	move.w a3,(a1)+
	move.w #$d6b9,(a1)+
	lea.l ($40,a2),a2
	dbra d7,loc_004876
	bra.b loc_0048d8

loc_0048a6:
	lea.l $7466.w,a2

loc_0048aa:
	movea.l a2,a3
	move.w a3,(a1)+
	move.w #$d6be,(a1)+
	lea.l (1,a3),a3
	move.w a3,(a1)+
	move.w #$d6bf,(a1)+
	lea.l ($1f,a3),a3
	move.w a3,(a1)+
	move.w #$d6bc,(a1)+
	lea.l (1,a3),a3
	move.w a3,(a1)+
	move.w #$d6bd,(a1)+
	lea.l (-$40,a2),a2
	dbra d7,loc_0048aa

loc_0048d8:
	move.l a1,$101420

loc_0048de:
	rts

;##############################################################################
loc_0048e0:
	movea.l $101420,a5
	moveq #7,d7

loc_0048e8:
	rol.l #4,d4
	move.w d4,d5
	andi.w #$f,d5
	addi.w #$330,d5
	cmpi.w #$33a,d5
	bcs.b loc_0048fc
	addq.w #7,d5

loc_0048fc:
	move.w a4,(a5)+
	addi.w #$2000,d5
	move.w d5,(a5)+
	lea.l ($20,a4),a4
	dbra d7,loc_0048e8
	move.l a5,$101420
	rts

;##############################################################################
loc_004914:
	moveq #0,d0
	lea.l player1mem,a0
	move.b BIOS_STATCHANGE,d1
	btst #7,($b8,a0)
	bne.b loc_004932
	btst #0,d1
	beq.b loc_004932
	moveq #1,d0

loc_004932:
	btst #7,($2b8,a0)
	bne.b loc_004942
	btst #2,d1
	beq.b loc_004942
	moveq #1,d0

loc_004942:
	rts

;##############################################################################
loc_004944:
	tst.b BIOS_SYSTEM_MODE
	bmi.w loc_00495a
	clr.w LSPCMODE
	jmp VBlankBios

loc_00495a:
	movem.l d0-d7/a0-a6,-(a7)
	lea.l $103570,a0
	move.l a0,usp
	btst #3,$101001
	beq.b loc_00497e
	move.w $106940,LSPCMODE
	bra.w loc_004a72

loc_00497e:
	tst.w $103466
	beq.w loc_004a72
	cmpi.w #3,mainmode
	bne.b loc_00499c
	cmpi.w #2,$106908
	beq.b loc_0049aa

loc_00499c:
	move.w $106940,LSPCMODE
	bra.w loc_004a44

loc_0049aa:
	moveq #$30,d0
	or.w $106940,d0
	move.w d0,LSPCMODE
	lea.l loc_007440,a0
	move.w stageid,d1
	lsl.w #2,d1
	moveq #0,d2
	move.w (2,a0,d1.w),d2
	move.w d2,d4
	lsr.w #4,d4
	neg.w d2
	addi.w #$100,d2
	add.w $103438,d2
	add.w $106928,d2
	move.w d2,d3
	neg.w d3
	lsl.w #7,d3
	or.w d4,d3
	move.w #$8201,VRAMADDR
	move.w d3,VRAMRW
	lsl.l #7,d2
	move.l d2,d3
	add.l d2,d2
	add.l d3,d2
	addi.l #$1400,d2
	move.w LSPCMODE,d5
	btst #3,d5
	beq.b loc_004a18
	addi.l #$3780,d2

loc_004a18:
	swap d2
	move.w d2,TIMERHIGH
	swap d2
	move.w d2,TIMERLOW
	andi.w #$ff08,d0
	ori.w #$90,d0
	move.w d0,LSPCMODE
	clr.w TIMERHIGH
	move.w #$17f,TIMERLOW

loc_004a44:
	jsr loc_0069be
	jsr loc_000080
	bsr.w loc_004af8
	jsr loc_009cc6
	jsr loc_006854
	jsr loc_00428c
	jsr loc_006948
	clr.w $103466

loc_004a72:
	jsr loc_00df2a
	jsr SYSTEM_IO
	jsr MESS_OUT
	move.b d0,REG_DIPSW
	move.w #4,IRQACK
	movem.l (a7)+,d0-d7/a0-a6
	rte

;##############################################################################
loc_004a98:
	move.w #2,IRQACK
	move.w #$8401,VRAMADDR
	move.l a6,$106942
	move.l usp,a6
	move.w (a6)+,VRAMRW
	move.l a6,usp
	movea.l $106942,a6
	rte

;##############################################################################
loc_004ac0:
	tst.w $106986
	bne.b loc_004af6
	lea.l $106946,a0
	lea.l VRAMADDR,a3
	move.w #$20,(4,a3)
	moveq #$f,d7
	move.w #$7043,(a3)

loc_004ae0:
	move.w (a0)+,(2,a3)
	dbra d7,loc_004ae0
	move.w #$72c3,(a3)
	moveq #$f,d7

loc_004aee:
	move.w (a0)+,(2,a3)
	dbra d7,loc_004aee

loc_004af6:
	rts

;##############################################################################
loc_004af8:
	lea.l $106986,a0
	move.b (a0),d0
	andi.b #3,d0
	beq.w loc_004b4a
	btst #0,(a0)
	beq.b loc_004b26
	move.w #$ff,d0
	bsr.w loc_004b4c
	subq.b #1,(1,a0)
	bcc.b loc_004b4a
	clr.b (1,a0)
	bclr #0,(a0)
	bra.b loc_004b4a

loc_004b26:
	btst #1,(a0)
	beq.w loc_004b4a
	moveq #0,d0
	bsr.w loc_004b4c
	addq.b #1,(1,a0)
	cmpi.b #$13,(1,a0)
	bcs.b loc_004b4a
	move.b #$12,(1,a0)
	bclr #1,(a0)

loc_004b4a:
	rts

;##############################################################################
loc_004b4c:
	lea.l VRAMADDR,a1
	moveq #0,d1
	move.b (1,a0),d1
	lsl.w #5,d1
	move.w d1,d2
	addi.w #$7022,d1
	move.w #1,(4,a1)
	moveq #$1b,d7
	move.w d1,(a1)

loc_004b6a:
	move.w d0,(2,a1)
	dbra d7,loc_004b6a
	neg.w d2
	addi.w #$74c2,d2
	move.w d2,(a1)
	moveq #$1b,d7

loc_004b7c:
	move.w d0,(2,a1)
	dbra d7,loc_004b7c
	rts

;##############################################################################
loc_004b86:
	bset #0,$101004
	bne.b loc_004bc4
	clr.w $101006
	jsr loc_006be6
	bset #3,$101001
	jsr FIX_CLEAR
	bclr #3,$101001
	lea.l $105cac,a0
	moveq #0,d0
	move.w #$17f,d7

loc_004bbe:
	move.l d0,(a0)+
	dbra d7,loc_004bbe

loc_004bc4:
	addq.w #1,$101006
	cmpi.w #$7c,$101006
	bcc.b loc_004bdc
	jsr loc_013504
	bra.b loc_004c00

loc_004bdc:
	clr.w $101004
	move.w #3,mainmode
	move.w #2,$106908
	clr.w $10690a
	bset #7,$101000

loc_004c00:
	rts

;##############################################################################
loc_004c02:
	moveq #0,d0
	lea.l $106914,a0
	move.l d0,(a0)+
	move.l d0,(a0)+
	move.l d0,(a0)+
	move.l d0,$106920
	move.l d0,$106924
	move.l d0,$106928
	move.w #1,$10346c
	lea.l $1064f0,a0
	moveq #$3f,d7

loc_004c32:
	move.l d0,(a0)+
	dbra d7,loc_004c32
	lea.l $1068c8,a0
	moveq #0,d0
	moveq #$b,d7

loc_004c42:
	move.l d0,(a0)+
	dbra d7,loc_004c42
	lea.l $105cac,a0
	moveq #0,d0
	move.w #$17f,d7

loc_004c54:
	move.l d0,(a0)+
	dbra d7,loc_004c54
	bclr #6,$101000
	bclr #5,$101001
	lea.l player1mem,a0
	bsr.w loc_004c78
	lea.l (playeroffset,a0),a0

loc_004c78:
	cmpa.l #player1mem,a0
	bne.b loc_004c96
	clr.b (a0)
	move.b #$40,($21,a0)
	move.l #$2300000,($c0,a0)
	move.b d0,($bd,a0)
	bra.b loc_004cae

loc_004c96:
	move.b #1,(a0)
	move.l #$2d00000,($c0,a0)
	move.b #1,($21,a0)
	move.b #1,($bd,a0)

loc_004cae:
	moveq #0,d0
	move.l d0,($c4,a0)
	cmpi.w #5,$10100c
	beq.b loc_004cca
	move.b #$ff,($147,a0)
	move.b #$ff,($148,a0)

loc_004cca:
	move.b d0,($bc,a0)
	move.b d0,($be,a0)
	move.w d0,($d0,a0)
	move.l d0,($d4,a0)
	move.l d0,($d8,a0)
	move.l d0,($dc,a0)
	move.l d0,($e0,a0)
	move.l d0,($e4,a0)
	move.l d0,($10c,a0)
	move.l d0,($110,a0)
	move.l d0,($114,a0)
	move.l d0,($118,a0)
	move.b d0,($149,a0)
	move.b d0,($14a,a0)
	move.b d0,($14b,a0)
	move.b d0,($14c,a0)
	move.b d0,($14d,a0)
	move.b d0,($14e,a0)
	move.b d0,($14f,a0)
	cmpi.w #5,$10100c
	bne.b loc_004d3c
	btst #7,($b8,a0)
	beq.b loc_004d3c
	move.b #$d,(1,a0)
	move.l #$1200000,($c4,a0)
	bset #3,($be,a0)

loc_004d3c:
	moveq #0,d1
	move.b (1,a0),d1
	mulu.w #$60,d1
	move.w d1,($d2,a0)
	move.b #2,($bf,a0)
	rts

;##############################################################################
loc_004d52:
	tst.b $103a72
	bne.w loc_004e1e
	lea.l player1mem,a0
	lea.l player2mem,a1
	btst #6,$101000
	bne.b loc_004db4
	tst.w fighttimer
	beq.b loc_004d86
	tst.b ($143,a0)
	beq.b loc_004d86
	tst.b ($143,a1)
	bne.b loc_004dc4

loc_004d86:
	bset #6,$101000
	bsr.w loc_0059e4
	bset #2,$101001
	bne.b loc_004db4
	move.b #2,$1068c6
	move.b #$a,$1068c7
	jsr loc_00e054
	nop

loc_004db4:
	move.b #4,$103a72
	clr.b $103a73
	bra.b loc_004e1e

loc_004dc4:
	btst #5,$101001
	bne.b loc_004e1e
	cmpi.w #$1e00,fighttimer
	bcs.b loc_004de8
	cmpi.b #$20,($143,a0)
	bcs.b loc_004de8
	cmpi.b #$20,($143,a1)
	bcc.b loc_004e1e

loc_004de8:
	bset #5,$101001
	cmpi.w #5,$10100c
	beq.b loc_004e1e
	move.w stageid,d0
	lea.l loc_00949a,a0
	move.b (a0,d0.w),d0
	move.b d0,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054

loc_004e1e:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_004e20:
	dc.l loc_004e48
	dc.l loc_004e60
	dc.l loc_004fd8
	dc.l loc_0050f2
	dc.l loc_005194
	dc.l loc_0052e4
	dc.l loc_005220
	dc.l loc_005668
	dc.l loc_005766
	dc.l loc_004e48

;##############################################################################
loc_004e48:
	rts

;##############################################################################
loc_004e4a:
	moveq #0,d0
	move.b $103a72,d0
	lsl.w #2,d0
	lea.l loc_004e20(pc),a0
	movea.l (a0,d0.w),a0
	jmp (a0)

;##############################################################################
loc_004e5e:
	rts

;##############################################################################
loc_004e60:
	cmpi.w #5,$10100c
	bne.b loc_004e70
	bsr.w loc_004ea0
	bra.b loc_004e9e

loc_004e70:
	addq.b #1,$103a73
	cmpi.b #8,$103a73
	bne.b loc_004e86
	jsr loc_006f24

loc_004e86:
	cmpi.b #$24,$103a73
	bcs.b loc_004e9e
	move.b #2,$103a72
	clr.b $103a73

loc_004e9e:
	rts

;##############################################################################
loc_004ea0:
	addq.w #1,$103a74
	lea.l player1mem,a0
	btst #7,($b8,a0)
	beq.b loc_004eb8
	lea.l (playeroffset,a0),a0

loc_004eb8:
	cmpi.w #$20,$103a74
	bne.b loc_004ed2
	move.w #7,($d0,a0)
	bclr #0,($bf,a0)
	bra.w loc_004fa4

loc_004ed2:
	cmpi.w #$a0,$103a74
	bne.b loc_004ef6
	move.b #$1b,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.w loc_004fa4

loc_004ef6:
	cmpi.w #$d0,$103a74
	bne.b loc_004f14
	movea.l ($14,a0),a1
	move.w #2,($d0,a1)
	bclr #0,($bf,a1)
	bra.w loc_004fa4

loc_004f14:
	cmpi.w #$118,$103a74
	bne.b loc_004f28
	moveq #4,d0
	moveq #$a,d1
	jsr loc_00cbde

loc_004f28:
	cmpi.w #$120,$103a74
	bne.b loc_004f5e
	move.w #0,($d0,a0)
	bclr #0,($bf,a0)
	bsr.w loc_004fa6
	movea.l ($14,a0),a0
	move.b #2,$103a72
	jsr loc_0046ae
	move.b #1,$103a72
	bra.b loc_004fa4

loc_004f5e:
	cmpi.w #$1a0,$103a74
	bne.b loc_004fa4
	move.b #2,$103a72
	clr.b $103a73
	lea.l player1mem,a0
	move.b #$ff,($147,a0)
	move.b #$ff,($148,a0)
	jsr loc_004756
	lea.l (playeroffset,a0),a0
	move.b #$ff,($147,a0)
	move.b #$ff,($148,a0)
	jsr loc_004756

loc_004fa4:
	rts

;##############################################################################
loc_004fa6:
	lea.l $105cac,a2
	moveq #$1f,d7

loc_004fae:
	cmpi.b #$3c,(a2)
	bne.b loc_004fb6
	clr.w (a2)

loc_004fb6:
	lea.l ($30,a2),a2
	dbra d7,loc_004fae
	rts

;##############################################################################
loc_004fc0:
	dc.w $0341,$2042
	dc.w $0341,$2043
	dc.w $0345,$2041
	dc.w $0345,$2041
	dc.w $0345,$2041
	dc.w $03cb,$2441

;##############################################################################
loc_004fd8:
	lea.l $103a72,a0
	addq.b #1,(1,a0)
	cmpi.b #1,(1,a0)
	bne.b loc_004ff4
	move.w #$f11,(2,a0)
	bra.w loc_0050f0

loc_004ff4:
	cmpi.b #$a,(1,a0)
	bcc.b loc_00500a
	cmpi.w #$fff,(2,a0)
	beq.b loc_00500a
	addi.w #$22,(2,a0)

loc_00500a:
	cmpi.b #$46,(1,a0)
	bcs.b loc_005020
	subi.w #$200,(2,a0)
	bcc.b loc_005020
	move.w #$ff,(2,a0)

loc_005020:
	cmpi.b #$50,(1,a0)
	bcc.w loc_0050e2
	move.b (1,a0),d1
	moveq #1,d7
	lea.l loc_004fc0(pc),a2
	move.w $10100c,d0
	lsl.w #2,d0
	lea.l (a2,d0.w),a2

loc_005040:
	move.b (a2),d0
	cmp.b d1,d0
	bne.b loc_005060
	move.b (1,a2),d2
	move.b d2,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_005068

loc_005060:
	lea.l (2,a2),a2
	dbra d7,loc_005040

loc_005068:
	movea.l $10692c,a1
	move.w $10100c,d0
	cmpi.w #2,d0
	bcc.b loc_00509c
	addi.w #$eb6,d0
	move.w d0,(a1)+
	move.w (2,a0),(a1)+
	move.w #$40,(a1)+
	move.w #$14,(a1)+
	move.w #$9c,(a1)+
	move.w #$198,(a1)+
	move.l a1,$10692c
	bra.b loc_0050f0

loc_00509c:
	cmpi.w #5,d0
	bcc.b loc_0050c2
	move.w #$eb9,(a1)+
	move.w (2,a0),(a1)+
	move.w #$68,(a1)+
	move.w #$14,(a1)+
	move.w #$9c,(a1)+
	move.w #$198,(a1)+
	move.l a1,$10692c
	bra.b loc_0050f0

loc_0050c2:
	move.w #$eba,(a1)+
	move.w (2,a0),(a1)+
	move.w #$70,(a1)+
	move.w #$14,(a1)+
	move.w #$98,(a1)+
	move.w #$198,(a1)+
	move.l a1,$10692c
	bra.b loc_0050f0

loc_0050e2:
	move.b #3,$103a72
	clr.b $103a73

loc_0050f0:
	rts

;##############################################################################
loc_0050f2:
	lea.l $103a72,a0
	addq.b #1,(1,a0)
	move.b (1,a0),d0
	cmpi.b #1,d0
	bne.b loc_005126
	move.w #$111,$103a74
	move.b #$46,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_005192

loc_005126:
	cmpi.b #$30,d0
	beq.b loc_005180
	cmpi.b #$10,d0
	bcc.b loc_005142
	cmpi.w #$fff,(2,a0)
	beq.b loc_00515a
	addi.w #$222,(2,a0)
	bra.b loc_00515a

loc_005142:
	cmpi.b #$26,d0
	bcs.b loc_00515a
	tst.w (2,a0)
	beq.b loc_00515a
	subi.w #$222,(2,a0)
	bcc.b loc_00515a
	clr.w (2,a0)

loc_00515a:
	movea.l $10692c,a1
	move.w #$ebf,(a1)+
	move.w (2,a0),(a1)+
	move.w #$50,(a1)+
	move.w #$10,(a1)+
	move.w #$9c,(a1)+
	move.w #$194,(a1)+
	move.l a1,$10692c
	bra.b loc_005192

loc_005180:
	clr.b $103a72
	clr.b $103a73
	jsr loc_0094b4

loc_005192:
	rts

;##############################################################################
loc_005194:
	lea.l $103a72,a0
	addq.b #1,(1,a0)
	cmpi.b #1,(1,a0)
	bne.b loc_0051bc
	tst.w fighttimer
	bne.b loc_005218
	clr.w $10346c
	move.w #$111,(2,a0)
	bra.b loc_00521e

loc_0051bc:
	cmpi.b #$a,(1,a0)
	bcc.b loc_0051d6
	cmpi.w #$fff,(2,a0)
	beq.b loc_0051f2
	move.w #$222,d0
	bsr.w loc_00537a
	bra.b loc_0051f2

loc_0051d6:
	cmpi.b #$a0,(1,a0)
	bcc.b loc_005218
	cmpi.b #$96,(1,a0)
	bcs.b loc_0051f2
	subi.w #$222,(2,a0)
	bcc.b loc_0051f2
	clr.w (2,a0)

loc_0051f2:
	movea.l $10692c,a1
	move.w #$ebc,(a1)+
	move.w (2,a0),(a1)+
	move.w #$40,(a1)+
	move.w #$14,(a1)+
	move.w #$9c,(a1)+
	move.w #$190,(a1)+
	move.l a1,$10692c
	bra.b loc_00521e

loc_005218:
	addq.b #1,(a0)
	clr.b (1,a0)

loc_00521e:
	rts

;##############################################################################
loc_005220:
	lea.l $103a72,a0
	addq.b #1,(1,a0)
	cmpi.b #1,(1,a0)
	bne.b loc_005268
	lea.l player1mem,a0
	lea.l (playeroffset,a0),a1
	move.b ($143,a0),d0
	move.b ($143,a1),d1
	cmp.b d0,d1
	beq.w loc_0052d6
	cmpi.b #$78,d0
	beq.b loc_00525a
	cmpi.b #$78,d1
	bne.w loc_0052d6
	movea.l a1,a0

loc_00525a:
	btst #7,($b8,a0)
	bne.w loc_0052d6
	bra.w loc_0052e2

loc_005268:
	lea.l $103a72,a0
	cmpi.b #$12,(1,a0)
	bne.b loc_00528e
	move.b #$4c,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_00529a

loc_00528e:
	bcc.b loc_00529a
	move.w #$111,d0
	bsr.w loc_00537a
	bra.b loc_0052b0

loc_00529a:
	cmpi.b #$50,(1,a0)
	bcs.b loc_0052b0
	move.w #$222,d0
	bsr.w loc_00538e
	tst.w (2,a0)
	beq.b loc_0052d6

loc_0052b0:
	movea.l $10692c,a1
	move.w #$ebd,(a1)+
	move.w (2,a0),(a1)+
	move.w #$4c,(a1)+
	move.w #$14,(a1)+
	move.w #$9c,(a1)+
	move.w #$194,(a1)+
	move.l a1,$10692c
	bra.b loc_0052e2

loc_0052d6:
	addq.b #1,$103a72
	clr.b $103a73

loc_0052e2:
	rts

;##############################################################################
loc_0052e4:
	lea.l $103a72,a0
	tst.b (1,a0)
	bne.b loc_00532a
	lea.l player1mem,a1
	lea.l player2mem,a2
	cmpi.w #$15,($d0,a1)
	bne.w loc_005378
	cmpi.w #$15,($d0,a2)
	bne.w loc_005378
	move.b #1,(1,a0)
	move.w #0,(2,a0)
	bsr.w loc_0053ac
	clr.w $10346c
	bra.w loc_005378

loc_00532a:
	lea.l $103a72,a0
	addq.b #1,(1,a0)
	lea.l $106738,a1
	cmpi.w #2,(a1)
	bcc.b loc_00534e
	bsr.w loc_0055a2
	tst.w d0
	bne.w loc_00536c
	bra.w loc_005378

loc_00534e:
	bne.b loc_00535e
	bsr.w loc_0054b8
	tst.w d0
	bne.w loc_00536c
	bra.w loc_005378

loc_00535e:
	bsr.w loc_00550c
	tst.w d0
	bne.w loc_00536c
	bra.w loc_005378

loc_00536c:
	addq.b #1,$103a72
	clr.b $103a73

loc_005378:
	rts

;##############################################################################
loc_00537a:
	add.w d0,(2,a0)
	cmpi.w #$fff,(2,a0)
	bcs.b loc_00538c
	move.w #$fff,(2,a0)

loc_00538c:
	rts

;##############################################################################
loc_00538e:
	move.w (2,a0),d1
	move.w d1,d2
	andi.w #$f00,d1
	beq.b loc_0053aa
	andi.w #$ff,d2
	beq.b loc_0053aa
	sub.w d0,(2,a0)
	bcc.b loc_0053aa
	clr.w (2,a0)

loc_0053aa:
	rts

;##############################################################################
loc_0053ac:
	move.b ($143,a1),d0
	move.b ($143,a2),d1
	cmp.b d0,d1
	beq.b loc_0053c6
	bcs.b loc_0053c0
	addq.b #1,(7,a2)
	bra.b loc_0053f6

loc_0053c0:
	addq.b #1,(7,a1)
	bra.b loc_0053f6

loc_0053c6:
	cmpi.w #1,$10100c
	bne.b loc_0053ee
	move.b ($b8,a1),d3
	or.b ($b8,a2),d3
	btst #7,d3
	bne.b loc_0053ee
	cmpi.b #1,(7,a1)
	bne.b loc_0053ee
	cmpi.b #1,(7,a2)
	beq.b loc_0053f6

loc_0053ee:
	addq.b #1,(7,a1)
	addq.b #1,(7,a2)

loc_0053f6:
	lea.l player1mem,a0
	jsr loc_004856
	lea.l player2mem,a0
	jsr loc_004856
	move.b $1037b3,d0
	move.b $1039b3,d1
	cmp.b d0,d1
	bne.b loc_005462
	tst.b d0
	bne.b loc_005442
	move.w #3,$106738
	move.b #$4e,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_0054b6

loc_005442:
	move.w #2,$106738
	move.b #$4b,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_0054b6

loc_005462:
	bcs.b loc_00546c
	lea.l player2mem,a0
	bra.b loc_005472

loc_00546c:
	lea.l player1mem,a0

loc_005472:
	lea.l $1066ac,a2
	moveq #0,d2
	move.b (1,a0),d2
	btst #7,($b8,a0)
	beq.b loc_0054a8
	movea.l ($14,a0),a1
	move.b (1,a1),d2
	move.w d2,($8e,a2)
	clr.w ($8c,a2)
	cmpi.w #5,$10100c
	beq.b loc_0054b6
	move.b #1,(8,a1)
	bra.b loc_0054b6

loc_0054a8:
	move.w d2,($8e,a2)
	move.w #1,($8c,a2)
	move.l a0,($90,a2)

loc_0054b6:
	rts

;##############################################################################
loc_0054b8:
	cmpi.b #$13,(1,a0)
	bcc.b loc_0054ca
	move.w #$111,d0
	bsr.w loc_00537a
	bra.b loc_0054e4

loc_0054ca:
	cmpi.b #$86,(1,a0)
	bcs.b loc_0054e4
	move.w #$222,d0
	bsr.w loc_00538e
	tst.w (2,a0)
	bne.b loc_0054e4
	moveq #1,d0
	bra.b loc_00550a

loc_0054e4:
	movea.l $10692c,a3
	move.w #$ebb,(a3)+
	move.w (2,a0),(a3)+
	move.w #$2c,(a3)+
	move.w #$14,(a3)+
	move.w #$9e,(a3)+
	move.w #$194,(a3)+
	move.l a3,$10692c
	moveq #0,d0

loc_00550a:
	rts

;==============================================================================
loc_00550c:
	cmpi.b #$13,(1,a0)
	bcc.b loc_00551e
	move.w #$111,d0
	bsr.w loc_00537a
	bra.b loc_005538

loc_00551e:
	cmpi.b #$b6,(1,a0)
	bcs.b loc_005538
	move.w #$222,d0
	bsr.w loc_00538e
	tst.w (2,a0)
	bne.b loc_005538
	moveq #1,d0
	bra.b loc_00555e

loc_005538:
	movea.l $10692c,a3
	move.w #$ebe,(a3)+
	move.w (2,a0),(a3)+
	move.w #$40,(a3)+
	move.w #$30,(a3)+
	move.w #$a0,(a3)+
	move.w #$194,(a3)+
	move.l a3,$10692c
	moveq #0,d0

loc_00555e:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_005560:
	dc.w $0054,$0060,$0064,$0070
	dc.w $0064,$0070,$006c,$0080
	dc.w $0076,$0080,$0054,$0060
	dc.w $0076,$0080,$005c,$0068
	dc.w $0074,$0080,$0074,$0080
	dc.w $0064,$0070,$006c,$0078
	dc.w $0074,$0080

loc_005594:
	dc.w $2323,$232c,$3825,$3b28
	dc.w $4e3f,$292c,$2e2e

;##############################################################################
loc_0055a2:
	cmpi.b #2,(1,a0)
	bne.b loc_0055ca
	move.w (2,a1),d0
	addi.w #$4f,d0
	move.b d0,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.w loc_005664

loc_0055ca:
	cmpi.b #$12,(1,a0)
	bcc.b loc_0055da
	move.w #$222,d0
	bsr.w loc_00537a

loc_0055da:
	cmpi.b #$60,(1,a0)
	bcs.b loc_0055f0
	move.w #$222,d0
	bsr.w loc_00538e
	tst.w (2,a0)
	beq.b loc_005620

loc_0055f0:
	lea.l loc_005594(pc),a2
	move.w (2,a1),d0
	move.b (a2,d0.w),d0
	cmp.b (1,a0),d0
	bne.b loc_005624
	moveq #$47,d0
	tst.w (a1)
	bne.b loc_00560a
	moveq #$48,d0

loc_00560a:
	move.b d0,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_005624

loc_005620:
	moveq #1,d0
	bra.b loc_005666

loc_005624:
	movea.l $10692c,a3
	lea.l loc_005560(pc),a4
	move.w (2,a1),d0
	move.w d0,d1
	lsl.w #2,d1
	lea.l (a4,d1.w),a4
	addi.w #$1840,d0
	tst.w (a1)
	bne.b loc_00564a
	addi.w #$d,d0
	lea.l (2,a4),a4

loc_00564a:
	move.w d0,(a3)+
	move.w (2,a0),(a3)+
	move.w (a4),(a3)+
	move.w #$14,(a3)+
	move.w #$a0,(a3)+
	move.w #$194,(a3)+
	move.l a3,$10692c

loc_005664:
	moveq #0,d0

loc_005666:
	rts

;##############################################################################
loc_005668:
	lea.l $103a72,a0
	addq.b #1,(1,a0)
	cmpi.b #1,(1,a0)
	bne.b loc_005698
	move.w #$ff,(2,a0)
	lea.l $106738,a1
	cmpi.w #2,(a1)
	bcc.w loc_005758
	jsr loc_008758
	bra.w loc_005764

loc_005698:
	cmpi.b #$12,(1,a0)
	bcs.b loc_005710
	move.b $101000,d0
	andi.b #3,d0
	cmpi.b #3,d0
	beq.b loc_0056b8;Not Vs Mode
	jsr loc_006dba
	bra.b loc_0056ca

loc_0056b8:
	movea.l $10673c,a0
	jsr loc_00698c
	tst.w d0
	bne.b loc_0056d0
	bra.b loc_0056d8

loc_0056ca:
	btst #1,d0
	beq.b loc_0056d8

loc_0056d0:
	move.b #$c0,$103a73

loc_0056d8:
	lea.l $103a72,a0
	move.b #$70,d0
	tst.w $106738
	bne.b loc_0056ee
	move.b #$40,d0

loc_0056ee:
	cmp.b (1,a0),d0
	bcc.b loc_005764
	move.w (2,a0),d0
	andi.w #$f00,d0
	cmpi.w #$100,d0
	beq.b loc_005758
	subi.w #$200,(2,a0)
	bcc.b loc_00572c
	clr.w (2,a0)
	bra.b loc_00572c

loc_005710:
	cmpi.w #$fff,(2,a0)
	bcc.b loc_005764
	addi.w #$200,(2,a0)
	cmpi.w #$fff,(2,a0)
	bcs.b loc_00572c
	move.w #$fff,(2,a0)

loc_00572c:
	move.w #$8151,d0
	move.w (2,a0),d1
	movea.l $101420,a6
	moveq #$b,d7
	tst.w $106738
	bne.b loc_005746
	moveq #9,d7

loc_005746:
	move.w d0,(a6)+
	addq.w #1,d0
	move.w d1,(a6)+
	dbra d7,loc_005746
	move.l a6,$101420
	bra.b loc_005764

loc_005758:
	addq.b #1,$103a72
	clr.b $103a73

loc_005764:
	rts

;##############################################################################
loc_005766:
	jsr loc_00d654
	cmpi.w #$15,$106986
	bcs.w loc_005824
	cmpi.w #5,$10100c
	bne.b loc_0057a2
	move.w #$a,$106908
	clr.w $10690a
	move.b #9,$103a72
	jsr loc_006ef2
	bra.w loc_005824

loc_0057a2:
	cmpi.b #2,$103677
	bcc.b loc_0057c4
	cmpi.b #2,$103877
	bcc.b loc_0057c4
	clr.w $10690a
	addq.w #1,$10100c
	bra.b loc_005824

loc_0057c4:
	cmpi.w #$fff,$101018
	bne.b loc_005816
	lea.l player1mem,a0
	lea.l (playeroffset,a0),a1
	move.b ($b8,a0),d0
	or.b ($b8,a1),d0
	btst #7,d0
	beq.b loc_005816
	btst #7,($b8,a0)
	bne.b loc_0057f0
	movea.l a1,a0

loc_0057f0:
	cmpi.b #2,(7,a0)
	bcc.b loc_005816
	movea.l ($14,a0),a1
	move.b #6,(4,a1)
	clr.b ($b,a1)
	move.w #6,$106908
	clr.w $10690a
	bra.b loc_005824

loc_005816:
	move.w #3,$106908
	clr.w $10690a

loc_005824:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_005826:
	dc.b 'TIME',$FF

loc_00582b:
	dc.b ' DATA EAST',$FF

loc_005836:
	dc.b '1994 DATA EAST CORPORATION',$FF

loc_005851:
	dc.b 'TM',$FF

HackTitle:
	dc.b 'PALETTE EXPANSION',$ff

HackCredits
	dc.b 'Code and Palettes by MMJ',$fe
	dc.b 'Addtional Palettes by Hal',$ff
	even

;##############################################################################
loc_005854:
	bset #0,$101004
	bne.w loc_005932
	clr.w $101006
	jsr loc_006be6
	bset #3,$101001
	jsr FIX_CLEAR

	lea.l HackTitle(pc),a1
	move.w #$3000,d0
	lea.l $7075.w,a2
	jsr loc_006f88

	bclr #3,$101001
	movea.l $101420,a1

	lea.l HackCredits(pc),a2
	lea.l $7084.w,a3
	jsr loc_00dffc

	lea.l loc_005826(pc),a2
	lea.l $725a.w,a3
	jsr loc_00dffc

	lea.l loc_00582b(pc),a2
	lea.l $71f8.w,a3
	jsr loc_00dffc

	lea.l loc_005836(pc),a2
	lea.l $7119.w,a3
	jsr loc_00dffc

	lea.l loc_005851(pc),a2
	lea.l $7434.w,a3
	cmpi.b #2,BIOS_COUNTRY_CODE
	bcs.b loc_0058c8
	lea.l $7454.w,a3

loc_0058c8:
	jsr loc_00dffc
	move.w #$70f9,(a1)+
	move.w #$e38a,(a1)+

;Title Screen Palette
	move.l a1,$101420
	move.l #loc_013fc2,d0
	move.l #$401b00,d1
	move.w #$140,d2
	move.w #$4,d3
	cmpi.b #1,BIOS_COUNTRY_CODE
	bhi.b loc_00590e
	move.l #loc_013e82,d0
	move.l #$401b00,d1
	move.w #$140,d2
	move.w #4,d3

loc_00590e:
	move.l d0,$105ccc
	move.l d1,$105cd0
	move.w d2,$105cd4
	move.w d3,$105cd6
	move.b #$ff,$103a8c
	bra.w loc_0059e2

loc_005932:
	addq.w #1,$101006
	cmpi.w #$38,$101006
	bne.b loc_005958
	move.b #2,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054

loc_005958:
	cmpi.w #$50,$101006
	bcs.b loc_005968
	jsr loc_007ac8

loc_005968:
	movea.l $101420,a0
	move.b BIOS_SELECT_TIMER,d1
	move.b d1,d2
	move.w #$727b,(a0)+
	lsr.w #4,d2
	andi.w #$f,d2
	addi.w #$2330,d2
	move.w d2,(a0)+
	move.w #$729b,(a0)+
	andi.w #$f,d1
	addi.w #$2330,d1
	move.w d1,(a0)+
	move.l a0,$101420
	movea.l $10141c,a0
	cmpi.b #1,BIOS_COUNTRY_CODE
	bhi.b loc_0059d0
	move.l #$4000116d,(a0)+
	move.l #$00a00118,(a0)+
	move.l #$8000116e,(a0)+
	move.l #$00a00118,(a0)+
	move.l #$c000116f,(a0)+
	move.l #$00a00118,(a0)+
	bra.b loc_0059dc

loc_0059d0:
	move.l #$4000183c,(a0)+
	move.l #$00a0011a,(a0)+

loc_0059dc:
	move.l a0,$10141c

loc_0059e2:
	rts

;##############################################################################
loc_0059e4:
	cmpi.w #$fff,$101018
	bne.w loc_005a70
	move.b ($b8,a0),d2
	or.b ($b8,a1),d2
	btst #7,d2
	beq.w loc_005a70
	move.b (7,a0),d2
	move.b (7,a1),d3
	move.b ($143,a0),d4
	cmp.b ($143,a1),d4
	bne.b loc_005a18
	addq.b #1,d2
	addq.b #1,d3
	bra.b loc_005a20

loc_005a18:
	bcs.b loc_005a1e
	addq.b #1,d2
	bra.b loc_005a20

loc_005a1e:
	addq.b #1,d3

loc_005a20:
	cmpi.b #2,d2
	bcc.b loc_005a2c
	cmpi.b #2,d3
	bcs.b loc_005a70

loc_005a2c:
	btst #7,($b8,a0)
	bne.b loc_005a40
	cmpi.b #2,d2
	bcs.b loc_005a70
	cmp.b d2,d3
	beq.b loc_005a70
	bra.b loc_005a62

loc_005a40:
	btst #7,($b8,a1)
	bne.b loc_005a70
	cmpi.b #2,d3
	bcs.b loc_005a70
	cmp.b d2,d3
	beq.b loc_005a70
	jsr loc_006ef8
	bset #3,$101000
	bra.b loc_005a70

loc_005a62:
	jsr loc_006f0e
	bset #3,$101000

loc_005a70:
	rts

;##############################################################################
loc_005a72:
	jsr loc_00428c
	jsr loc_005ab0(pc)
	nop
	jmp SYS_RETURN

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_005a84:
	dc.l loc_005854;00
	dc.l loc_004b86;01 Attract Mode
	dc.l loc_009656;02 High Score
	dc.l loc_005d98;03 How to Play
	dc.l loc_009e94;04 OBJ Gen
	dc.l loc_01ca52;05 Hit Gen
	dc.l loc_01f468;06 Pattern
	dc.l loc_007f62;07 Message Test
	dc.l loc_009656;08 
	dc.l loc_005df8;09 Debug Menu/Sound Check
	dc.l loc_009e94;0a

;##############################################################################
loc_005ab0:
	tst.w $103466
	bne.w loc_005b4a
	tst.w $106930
	bne.w loc_005b32
	bclr #1,$105c98
	jsr loc_005c14(pc)
	nop
	btst #0,$105c98
	bne.w loc_005b32
	bclr #1,$105c98
	bne.w loc_005b32
	move.l #$101424,$101420
	move.l #$10699e,$10692c
	move.l #$10101c,$10141c
	jsr loc_0066a0
	move.w mainmode,d0
	lsl.w #2,d0
	lea.l loc_005a84(pc),a0
	movea.l (a0,d0.w),a0
	jsr (a0)
	jsr loc_00adea
	jsr loc_00af86
	addq.w #1,$10346a

loc_005b32:
	move.w #1,$103466
	cmpi.w #$ff,mainmode
	bne.b loc_005b4a
	jmp SYS_RETURN

loc_005b4a:
	jsr RandomNumberGen

loc_005b50:
	tst.w $103466
	bne.b loc_005b50
	bra.w loc_005ab0

;##############################################################################
loc_005b5c:
	rts

;##############################################################################
loc_005b5e:
	move.b $100000,d0
	andi.w #3,d0
	beq.b loc_005b72
	addq.w #3,d0
	move.w d0,mainmode

loc_005b72:
	move.b BIOS_STATCURNT,d0
	andi.b #5,d0
	cmpi.b #5,d0
	bne.b loc_005b8a
	move.w #9,mainmode

loc_005b8a:
	rts

;##############################################################################
loc_005b8c:
	lea.l $105c98,a1
	move.b BIOS_STATCHANGE,d0
	tst.b BIOS_PLAYER1_MODE
	bne.b loc_005bb4
	cmpi.w #3,mainmode
	bcc.w loc_005c02
	move.b BIOS_P1CHANGE,d0
	lsr.b #4,d0

loc_005bb4:
	cmpi.b #2,BIOS_PLAYER1_MODE
	beq.w loc_005c02
	btst #0,(a1)
	bne.b loc_005bda
	btst #0,d0
	beq.b loc_005c02
	bset #0,(a1)
	bset #3,$106941
	bra.b loc_005bf4

loc_005bda:
	btst #0,d0
	beq.b loc_005bee
	bclr #0,(a1)
	bclr #3,$106941
	bra.b loc_005c02

loc_005bee:
	btst #1,d0
	bne.b loc_005c02

loc_005bf4:
	bset #1,(a1)
	bset #3,$106941
	bra.b loc_005c06

loc_005c02:
	bclr #1,(a1)

loc_005c06:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_005c08:
	dc.b 'PAUSE',$ff

loc_005c0e:
	dc.b '     ',$ff
	even

;##############################################################################
loc_005c14:
	tst.b BIOS_MVS_FLAG
	bne.w loc_005d62
	cmpi.w #3,mainmode
	bne.w loc_005d62
	cmpi.w #2,$106908
	bne.w loc_005d62
	btst #6,$101000
	bne.w loc_005d62
	move.b $101000,d0
	andi.b #3,d0
	beq.w loc_005d62
	tst.w $106986
	bne.w loc_005d62
	lea.l $105c98,a1
	tst.b (2,a1)
	beq.b loc_005c6e
	subq.b #1,(2,a1)
	bra.w loc_005d62

loc_005c6e:
	lea.l player1mem,a2
	moveq #0,d0
	cmpi.b #1,(4,a2)
	bne.b loc_005c82
	ori.b #2,d0

loc_005c82:
	cmpi.b #1,($204,a2)
	bne.b loc_005c8e
	ori.b #8,d0

loc_005c8e:
	and.b BIOS_STATCHANGE,d0
	bne.b loc_005cbe
	btst #0,(a1)
	beq.w loc_005d62
	addq.b #1,(1,a1)
	cmpi.b #$40,(1,a1)
	bcs.b loc_005cb0
	clr.b (1,a1)
	bra.b loc_005cfa

loc_005cb0:
	cmpi.b #$28,(1,a1)
	beq.w loc_005d3e
	bra.w loc_005d62

loc_005cbe:
	btst #0,(a1)
	bne.b loc_005d16
	move.b #1,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	move.b #$10,(2,a1)
	bset #0,(a1)
	clr.b (1,a1)
	bset #3,$106941
	move.l $101420,$106934

loc_005cfa:
	lea.l loc_005c08(pc),a1
	move.w #$3000,d0
	lea.l $71e7.w,a2
	jsr loc_006f88
	bset #1,$105c98
	bra.b loc_005d62

loc_005d16:
	move.b #1,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	move.b #8,(2,a1)
	bclr #0,(a1)
	bclr #3,$106941

loc_005d3e:
	move.l $106934,$101420
	lea.l loc_005c0e(pc),a1
	move.w #$2000,d0
	lea.l $71e7.w,a2
	jsr loc_006f88
	bset #1,$105c98

loc_005d62:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_005d64:
	dc.l loc_005f56;00
	dc.l loc_00ccee;01
	dc.l loc_00933a;02
	dc.l loc_0083ba;03
	dc.l loc_007c2e;04
	dc.l loc_007dee;05
	dc.l loc_008164;06
	dc.l loc_0089de;07
	dc.l loc_008d52;08
	dc.l loc_009072;09
	dc.l loc_015368;0a
	dc.l loc_00e302;0b
	dc.l loc_00e3f2;0c

;##############################################################################
loc_005d98:
	cmpi.w #1,$10698a
	bne.b loc_005db4
	tst.w $106986
	bne.b loc_005dc2
	btst #6,$101000
	bne.b loc_005dc2

loc_005db4:
	jsr loc_00988c
	tst.w $10698a
	bne.b loc_005dd0

loc_005dc2:
	move.w $106908,d0
	lsl.w #2,d0
	movea.l loc_005d64(pc,d0.w),a0
	jsr (a0)

loc_005dd0:
	bsr.w loc_00649e
	jsr loc_007778
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_005ddc:
	dc.l loc_005e70
	dc.l loc_005e3a
	dc.l loc_005e30
	dc.l loc_005e26
	dc.l loc_005e1c
	dc.l loc_00dc92
	dc.l loc_005e48

;##############################################################################
loc_005df8:
	move.w $106908,d0
	lsl.w #2,d0
	movea.l loc_005ddc(pc,d0.w),a0
	jmp (a0)
	rts

;##############################################################################
loc_005e08:
	move.w #$a,mainmode
	bra.b loc_005e50

loc_005e12:
	move.w #2,mainmode
	bra.b loc_005e50

loc_005e1c:
	move.w #7,mainmode
	bra.b loc_005e50

loc_005e26:
	move.w #6,mainmode
	bra.b loc_005e50

loc_005e30:
	move.w #5,mainmode
	bra.b loc_005e50

loc_005e3a:
	move.w #4,mainmode
	jmp loc_009e94

loc_005e48:
	move.w #1,mainmode

loc_005e50:
	clr.w $101004
	clr.w $101006
	clr.w $106908
	clr.w $10690a
	clr.w $10690c
	rts

;##############################################################################
loc_005e70:
	lea.l player1mem,a0
	movea.l $101420,a1
	jsr loc_00e024
	bset #0,$10690c
	bne.b loc_005ec0
	bset #3,$101001
	jsr FIX_CLEAR
	bclr #3,$101001
	lea.l loc_0075e0,a2
	lea.l $71ac.w,a3
	jsr loc_00dffc
	clr.w $10690a
	move.w #$232a,d0
	bsr.w loc_005f2e

loc_005ec0:
	lea.l player1mem,a0
	btst #4,($b6,a0)
	beq.b loc_005ee6
	move.w $10690a,$106908
	addq.w #1,$106908
	clr.w $10690c
	bra.b loc_005f26

loc_005ee6:
	move.b ($b6,a0),d0
	andi.b #3,d0
	beq.b loc_005f26
	move.w #$f0ff,d0
	bsr.w loc_005f2e
	move.w $10690a,d0
	btst #0,($b6,a0)
	beq.b loc_005f0e
	subq.w #1,d0
	bcc.b loc_005f18
	moveq #5,d0
	bra.b loc_005f18

loc_005f0e:
	addq.w #1,d0
	cmpi.w #5,d0
	bls.b loc_005f18
	moveq #0,d0

loc_005f18:
	move.w d0,$10690a
	move.w #$232a,d0
	bsr.w loc_005f2e

loc_005f26:
	move.l a1,$101420
	rts

;##############################################################################
loc_005f2e:
	lea.l $718c.w,a3
	move.w $10690a,d1
	lea.l (a3,d1.w),a3
	move.w a3,(a1)+
	move.w d0,(a1)+
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_005f42:
 	dc.l loc_005f6a
 	dc.l loc_00911e
 	dc.l loc_00601e
 	dc.l loc_00604c
 	dc.l loc_0060ce

;##############################################################################
loc_005f56:
	lea.l $106908,a0
	moveq #0,d0
	move.b (2,a0),d0
	lsl.w #2,d0
	movea.l loc_005f42(pc,d0.w),a1
	jmp (a1)

;==============================================================================
loc_005f6a:
	move.b #1,(2,a0)
	tst.b BIOS_MVS_FLAG
	beq.b loc_005f82
	tst.b BIOS_GAMEDIP_04
	bne.w loc_0060e2

loc_005f82:
	jsr loc_006be6
	move.w #$800,d3
	jsr loc_00d976
	clr.w $10690c
	lea.l $1066ac,a0
	move.l loc_02e2dc,(a0)
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_005fb2
	move.l loc_02e5fc,(a0)

loc_005fb2:
	lea.l $7089.w,a2
	move.w a2,(6,a0)
	clr.w (8,a0)
	move.l #loc_00625a,($10,a0)
	clr.b ($14,a0)
	move.l #loc_0062c9,($18,a0)
	clr.b ($1c,a0)
	move.w #$1e0,$103424
	move.w #$fff0,$103428
	move.b $100067,d0
	andi.w #$7,d0
	move.b d0,$103671
;	move.b #0,$103671;Player 1 How to play
	andi.b #$f0,$103673
	move.b $100065,d0
	andi.w #$7,d0
	move.b d0,$103871
;	move.b #9,$103871;Player 2 how to play
	andi.b #$f0,$103873
	move.b #$50,$103890
	jsr loc_004c02
	move.w #$240,$103730
	move.w #$2b0,$103930
	rts

;==============================================================================
loc_00601e:
	lea.l player1mem,a1
	jsr loc_00b0b4
	jsr loc_009d4a
	bsr.w loc_006132
	btst #0,$106986
	bne.b loc_00604a
	move.b #3,$10690a
	bsr.w loc_0063d4

loc_00604a:
	rts

;==============================================================================
loc_00604c:
	lea.l player1mem,a1
	btst #0,$101000
	beq.b loc_006066
	btst #4,($b0,a1)
	bne.w loc_006088

loc_006066:
	btst #1,$101000
	beq.b loc_00607a
	btst #4,($2b0,a1)
	bne.w loc_006088

loc_00607a:
	bsr.w loc_0062fa
	cmpi.w #$640,$10690c
	bcs.b loc_006098

loc_006088:
	move.b #4,$10690a
	bset #1,$106986

loc_006098:
	jsr loc_015bae
	jsr loc_00b0b4
	jsr loc_015bdc
	jsr loc_003abc
	jsr loc_00e1fc
	jsr loc_00e250
	jsr loc_009d4a
	bsr.w loc_006132
	jsr loc_009304
	rts

;==============================================================================
loc_0060ce:
	jsr loc_009d4a
	bsr.w loc_006132
	btst #1,$106986
	bne.b loc_0060f0

loc_0060e2:
	move.w #7,$106908
	clr.w $10690a

loc_0060f0:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0060f2:
	dc.w $027b,$027a,$027c,$027b
	dc.w $027e,$027d,$027f,$027b
	dc.w $0278,$0277,$0279,$027b
	dc.w $027b,$027b,$027b,$027b

loc_006112:
	dc.w $0000,$0272,$0273,$0000
	dc.w $0275,$0274,$0276,$0000
	dc.w $0270,$026f,$0271,$0000
	dc.w $0000,$0000,$0000,$0000

;==============================================================================
loc_006132:
	movea.l $10141c,a0
	moveq #0,d0
	cmpi.b #3,$10690a
	bne.b loc_00614a
	move.b $1036a0,d0

loc_00614a:
	move.b d0,d1
	andi.w #$f,d1
	add.w d1,d1
	lea.l loc_0060f2(pc),a1
	moveq #0,d2
	move.w (a1,d1.w),d2
	bset #$1f,d2
	move.l d2,(a0)+
	move.l #$400128,(a0)+
	lea.l loc_006112(pc),a1
	moveq #0,d2
	move.w (a1,d1.w),d2
	beq.b loc_006184
	bset #$1f,d2
	bset #$1e,d2
	move.l d2,(a0)+
	move.l #$400158,(a0)+

loc_006184:
	move.b d0,d2
	move.l #$c0000265,d3
	move.l #$780128,d6
	moveq #3,d7

loc_006194:
	move.l d3,d4
	btst #4,d2
	beq.b loc_00619e
	addq.w #1,d4

loc_00619e:
	move.l d4,(a0)+
	move.l d6,(a0)+
	lsr.w #1,d2
	addq.w #2,d3
	addi.l #$300000,d6
	dbra d7,loc_006194
	move.l #$900140,d3
	move.b d0,d2
	andi.b #$30,d2
	beq.b loc_0061d4
	subi.w #$14,d3
	subi.l #$180000,d3
	btst #5,d2
	beq.b loc_0061d4
	addi.l #$300000,d3

loc_0061d4:
	move.l #$c000026d,(a0)+
	move.l d3,(a0)+
	move.l #$f00140,d3
	move.b d0,d2
	andi.b #$c0,d2
	beq.b loc_006200
	subi.w #$14,d3
	subi.l #$180000,d3
	btst #7,d2
	beq.b loc_006200
	addi.l #$300000,d3

loc_006200:
	move.l #$c000026e,(a0)+
	move.l d3,(a0)+
	move.l a0,$10141c
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_006210:
	dc.w $0001,$0050,$00d0,$0100,$01a0,$01e0
	dc.w $0230,$0260,$0310,$0340,$03c0,$03f0
	dc.w $0490,$04b0,$04c0,$0510,$0530,$0550
	dc.w $ffff

loc_006236:
	dc.w $0001,$0050,$00d0,$0100,$01a0,$01e0
	dc.w $0240,$0260,$0310,$0340,$03c0,$03f0
	dc.w $0490,$04b0,$04f0,$0520,$05c0,$ffff

loc_00625a:
	dc.b $90,$00,$00,$01,$10,$10,$02,$10
	dc.b $00,$04,$00,$00,$01,$10,$10,$02
	dc.b $10,$00,$04,$00,$00,$01,$10,$10
	dc.b $02,$10,$00,$c0,$00,$00,$01,$20
	dc.b $20,$20,$20,$00,$90,$00,$00,$01
	dc.b $40,$40,$02,$40,$00,$04,$00,$00
	dc.b $01,$40,$40,$02,$40,$00,$04,$00
	dc.b $00,$01,$40,$40,$02,$40,$00,$b0
	dc.b $00,$00,$01,$80,$80,$20,$80,$00
	dc.b $70,$00,$00,$60,$02,$00,$70,$00
	dc.b $00,$01,$01,$01,$20,$01,$00,$a0
	dc.b $00,$00,$22,$08,$00,$40,$00,$00
	dc.b $01,$24,$24,$20,$24,$24,$f0,$00
	dc.b $00,$f0,$00,$00,$f0,$00,$00
	
loc_0062c9:
	dc.b $80,$00,$00,$21,$00,$00,$c1,$00
	dc.b $00,$c1,$00,$00,$21,$00,$00,$b1
	dc.b $00,$00,$22,$00,$00,$60,$00,$00
	dc.b $01,$20,$20,$bd,$00,$00,$01,$82
	dc.b $82,$70,$00,$00,$40,$00,$00,$0a
	dc.b $08,$00,$f0,$00,$00,$f0,$00,$00
	dc.b $c0

;##############################################################################
;How to Play Text
loc_0062fa:
	addq.w #1,$10690c
	lea.l $1066ac,a0
	movea.l ($10,a0),a1
	move.b ($14,a0),d0
	lea.l player1mem,a2
	bsr.w loc_00647e
	move.l a1,($10,a0)
	move.b d0,($14,a0)
	movea.l ($18,a0),a1
	lea.l player2mem,a2
	move.b ($1c,a0),d0
	bsr.w loc_00647e
	move.l a1,($18,a0)
	move.b d0,($1c,a0)
	lea.l loc_006210(pc),a0
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_00634a
	lea.l loc_006236(pc),a0

loc_00634a:
	move.w (a0)+,d0
	cmp.w $10690c,d0
	bcs.b loc_00634a
	bne.b loc_006366
	clr.w $1066b4
	lea.l $7089.w,a2
	move.w a2,$1066b2

loc_006366:
	lea.l $1066ac,a0
	cmpi.w #2,(8,a0)
	beq.b loc_0063aa
	btst #0,$10690d
	beq.b loc_0063aa
	movea.l $101420,a6
	movea.l (a0),a1
	movea.w (6,a0),a2
	lea.l loc_0070c8,a5
	moveq #0,d0
	moveq #0,d4
	jsr loc_0081c2
	move.w d0,(8,a0)
	move.l a1,(a0)
	move.w a2,(6,a0)
	move.l a6,$101420

loc_0063aa:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0063ac:
	dc.w $8c8d,$8e8f,$9091,$9293
	dc.w $9495,$9697,$fe98,$999a
	dc.w $9b9c,$9dac,$adae,$afb0
	dc.w $b1fe,$b2b3,$b4b5,$b6b7
	dc.w $b8b9,$babb,$bcbd,$fff9

;##############################################################################
loc_0063d4:
	movea.l $101420,a6
	lea.l loc_0063ac(pc),a0
	lea.l $71c4.w,a1
	moveq #2,d7

loc_0063e4:
	movea.w a1,a2

loc_0063e6:
	moveq #0,d0
	move.b (a0)+,d0
	cmpi.b #$ff,d0
	beq.b loc_00640a
	cmpi.b #$fe,d0
	bne.b loc_0063fc
	lea.l (1,a1),a1
	bra.b loc_0063e4

loc_0063fc:
	addi.w #$b300,d0
	move.w a2,(a6)+
	move.w d0,(a6)+
	lea.l ($20,a2),a2
	bra.b loc_0063e6

loc_00640a:
	move.w #$7067,(a6)+
	move.w #$b3c0,(a6)+
	move.w #$7487,(a6)+
	move.w #$b3c1,(a6)+
	move.w #$706c,(a6)+
	move.w #$b3e4,(a6)+
	move.w #$748c,(a6)+
	move.w #$b3e5,(a6)+
	lea.l $7087.w,a3
	lea.l $708c.w,a4
	moveq #$1f,d7
	move.w #$b3c2,d0
	move.w #$b3e2,d1

loc_00643c:
	move.w a3,(a6)+
	move.w d0,(a6)+
	move.w a4,(a6)+
	move.w d1,(a6)+
	lea.l ($20,a3),a3
	lea.l ($20,a4),a4
	dbra d7,loc_00643c
	lea.l $7068.w,a3
	lea.l $7488.w,a4
	moveq #3,d7
	move.w #$b3c4,d0
	move.w #$b3c5,d1

loc_006462:
	move.w a3,(a6)+
	move.w d0,(a6)+
	move.w a4,(a6)+
	move.w d1,(a6)+
	lea.l (1,a3),a3
	lea.l (1,a4),a4
	dbra d7,loc_006462
	move.l a6,$101420
	rts

;##############################################################################
loc_00647e:
	addq.b #1,d0
	cmp.b (a1),d0
	bcs.b loc_00648a
	lea.l (3,a1),a1
	moveq #0,d0

loc_00648a:
	move.b (1,a1),($30,a2)
	move.b (2,a1),($b0,a2)
	move.b (2,a1),($b1,a2)
	rts

;##############################################################################
loc_00649e:
	btst #3,$101000
	bne.w loc_006506
	cmpi.w #8,mainmode
	beq.w loc_006506
	cmpi.w #5,$106908
	beq.w loc_006506
	tst.w $106986
	bne.w loc_006506
	cmpi.w #6,$106908
	beq.w loc_006506
	move.b BIOS_STATCURNT,d0
	andi.b #5,d0
	beq.w loc_006506
	btst #0,d0
	beq.b loc_0064f6
	lea.l player1mem,a0
	bsr.w loc_006508

loc_0064f6:
	btst #2,d0
	beq.b loc_006506
	lea.l player2mem,a0
	bsr.w loc_006508

loc_006506:
	rts

;##############################################################################
loc_006508:
	cmpi.b #1,(4,a0)
	bne.w loc_006546
	cmpi.w #3,$106908
	bne.w loc_006618
	move.b ($b8,a0),d1
	or.b ($2b8,a0),d1
	btst #7,d1
	bne.w loc_006618
	movea.l ($14,a0),a1
	cmpi.b #2,(7,a1)
	bcs.w loc_006618
	cmpi.b #2,(7,a0)
	bcc.w loc_006618

loc_006546:
	cmpi.b #3,(4,a0)
	beq.w loc_006618
	cmpi.b #4,(4,a0)
	beq.w loc_006618
	moveq #0,d1
	move.b (a0),d1
	tst.b BIOS_MVS_FLAG
	beq.b loc_00659e
	lea.l BIOS_CREDIT1_DEC,a1
	clr.b (a1)
	clr.b (1,a1)
	lea.l (a1,d1.w),a1
	move.b #1,(a1)
	movem.l d0/a0-a1,-(a7)
	jsr CREDIT_CHECK
	movem.l (a7)+,d0/a0-a1
	tst.b (a1)
	beq.w loc_006618
	movem.l d0/a0,-(a7)
	jsr CREDIT_DOWN
	movem.l (a7)+,d0/a0
	bra.b loc_0065d8

loc_00659e:
	lea.l $106b5e,a1
	tst.b (a1,d1.w)
	beq.w loc_006618
	lea.l BIOS_PLAYER1_MODE,a2
	tst.b (a2,d1.w)
	beq.b loc_0065d4
	cmpi.b #3,(a2,d1.w)
	beq.b loc_0065d4
	cmpi.w #3,mainmode
	bne.b loc_0065d8
	cmpi.w #4,$106908
	bne.b loc_0065d8

loc_0065d4:
	subq.b #1,(a1,d1.w)

loc_0065d8:
	moveq #0,d1
	move.b (a0),d1
	bset d1,$101000
	lea.l BIOS_PLAYER1_MODE,a1
	move.b #1,(a1,d1.w)
	cmpi.b #2,(4,a0)
	bne.b loc_00660e
	bset #2,($b8,a0)
	addq.b #1,(5,a0)
	cmpi.b #$63,(5,a0)
	bcs.b loc_00660e
	move.b #$62,(5,a0)

loc_00660e:
	move.b #4,(4,a0)
	clr.b ($b,a0)

loc_006618:
	rts

;##############################################################################
loc_00661a:
	lea.l loc_0077f8,a1
	move.b $10346b,d0
	andi.b #$3f,d0
	beq.b loc_006638
	cmpi.b #$28,d0
	bne.b loc_006640
	lea.l loc_007798,a1

loc_006638:
	moveq #0,d0
	jsr loc_007aa8

loc_006640:
	tst.w $10698a
	bne.b loc_00669e
	btst #6,$101000
	bne.b loc_00669e
	cmpi.w #3,mainmode
	bne.b loc_00667a
	cmpi.w #3,$106908
	bne.b loc_00667a
	lea.l player1mem,a1
	move.b ($bf,a1),d0
	or.b ($2bf,a1),d0
	btst #7,d0
	bne.b loc_00669e

loc_00667a:
	tst.w $106986
	bne.b loc_00669e
	move.b $103a72,d0
	beq.b loc_006690
	cmpi.b #2,d0
	bcs.b loc_00669e

loc_006690:
	move.w #1,$10698a
	clr.w $10698c

loc_00669e:
	rts

;##############################################################################
loc_0066a0:
	lea.l player1mem,a0
	lea.l BIOS_P1STATUS,a1
	bsr.w loc_0066cc
	bsr.w loc_00e024

	lea.l (playeroffset,a0),a0
	lea.l BIOS_P2STATUS,a1
	bsr.w loc_0066cc
	bsr.w loc_00e024

;	lea.l player3mem,a0
;	lea.l BIOS_P1STATUS,a1
;	bsr.w loc_0066cc
;	bsr.w loc_00e024

;	lea.l player4mem,a0
;	lea.l BIOS_P2STATUS,a1
;	bsr.w loc_0066cc
;	bsr.w loc_00e024

	bsr.w loc_006b6e
	rts

;##############################################################################
;INPUT CODE
loc_0066cc:
	lea.l ($af,a0),a2
	lea.l ($b0,a0),a3
	moveq #$7e,d7

loc_0066d6:
	move.b -(a2),-(a3)
	dbra d7,loc_0066d6

;Original Code
;	move.b (2,a1),d0
;	move.b (1,a1),d1
;	move.b (3,a1),($b0,a0)
;	move.b (3,a1),($b3,a0)
;	eor.b d0,d1
;	move.b d1,($b1,a0)
;	move.b (4,a1),($b2,a0)
;	rts

;Anotak's code correctly intogratted
;no more jsr
	move.b ($2,a1),d0
	move.b ($1,a1),d1

	tst.b (buttonset,a0)
	bne.b swapnormalbuttons;too many complaints to leave it as LP LK HP HK
	bra.b specialbuttons

swapnormalbuttons:
	move.b d0,d2
	move.b d1,d3
	andi.b #$9f,d0
	andi.b #$9f,d1
	asl.b #1,d2
	asl.b #1,d3
	asr.b #6,d2
	asr.b #6,d3
	ror.b #2,d2
	ror.b #2,d3
	andi.b #$60,d2
	andi.b #$60,d3
	add.b D2,d0
	add.b D3,d1

specialbuttons:
	move.b d0,($30,a0)
	tst.b (buttonset,a0)
	bne.b specbuttonswap;too many complaints to leave it as LP LK HP HK
	move.b ($3,a1),($b0,a0)
	bra.b buttonswapend

specbuttonswap:
	move.b ($3,a1),d2
	move.b d2,d3
	andi.b #$9f,d2
	asl.b #1,d3
	asr.b #6,d3
	ror.b #2,d3
	andi.b #$60,d3
	add.b d3,d2
	move.b d2,($b0,a0)

buttonswapend:
	eor.b d0,d1
	move.b d1,($b1,a0)
	move.b (4,a1),($b2,a0)
	rts

;##############################################################################
InitPaletteLoad:
	lea.l loc_065000,a0
	lea.l palramaddr,a1
	subq.w #1,$106930
	move.w $106930,d0
	ror.w #6,d0
	lea.l (a0,d0.w),a0
	lea.l (a1,d0.w),a1
	move.w #1,d7

loc_006728:
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	dbra d7,loc_006728
	rts

;##############################################################################
loc_00682e:
	move.w $100000,d6
	moveq #0,d0
	lea.l $101000,a0
	move.w #$e1f,d7

loc_006840:
	move.l d0,(a0)+
	move.l d0,(a0)+
	move.l d0,(a0)+
	move.l d0,(a0)+
	dbra d7,loc_006840
	move.w d6,$100000
	rts

;##############################################################################
loc_006854:
	bset #3,$101001
	lea.l VRAMADDR,a6
	lea.l $1062ac,a0
	move.w #$8221,d0
	move.w (a0)+,d6
	tst.w d6
	beq.b loc_006880
	subq.w #1,d6

loc_006874:
	move.w d0,(a6)
	addq.w #1,d0
	move.w (a0)+,(2,a6)
	dbra d6,loc_006874

loc_006880:
	lea.l $1063ce,a0
	move.w #$8421,d0
	move.w (a0)+,d6
	tst.w d6
	beq.b loc_00689e
	subq.w #1,d6

loc_006892:
	move.w d0,(a6)
	addq.w #1,d0
	move.w (a0)+,(2,a6)
	dbra d6,loc_006892

loc_00689e:
	lea.l $101424,a0
	movea.l $101420,a1
	lea.l VRAMADDR,a2

loc_0068b0:
	cmpa.l a1,a0
	bcc.b loc_0068bc
	move.w (a0)+,(a2)
	move.w (a0)+,(2,a2)
	bra.b loc_0068b0

loc_0068bc:
	bclr #3,$101001
	rts

;##############################################################################
loc_0068c6:
	tst.w d1
	bne.w loc_0068d8
	move.l #$1ffff,d0
	jmp loc_0068ec(pc)
	nop

loc_0068d8:
	lsl.l #8,d0
	divu.w d1,d0
	bvc.w loc_0068e6
	ori.l #$10000,d0

loc_0068e6:
	andi.l #$1ffff,d0

loc_0068ec:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0068ee:
	dc.w $e6ea,$e6e8,$e6ee,$e6ec
	dc.w $e6f2,$e6f0,$e6f6,$e6f4
	dc.w $e6fa,$e6f8,$e6fe,$e6fc
	dc.w $e6eb,$e6e9,$e6ef,$e6ed

;##############################################################################
;Timer Outline
loc_00690e:
	movea.l $101420,a0
	lea.l $7243.w,a1
	lea.l loc_0068ee(pc),a2
	bsr.w loc_006934
	bsr.w loc_006934
	bsr.w loc_006934
	bsr.w loc_006934
	move.l a0,$101420
	rts

;##############################################################################
loc_006934:
	moveq #3,d7

loc_006936:
	move.w a1,(a0)+
	move.w (a2)+,(a0)+
	lea.l ($20,a1),a1
	dbra d7,loc_006936
	lea.l (-$7f,a1),a1
	rts

;##############################################################################
loc_006948:
	bclr #7,$101000
	bne.b loc_006954
	rts

;##############################################################################
loc_006954:
	lea.l VRAMADDR,a0
	move.w #1,(4,a0)
	move.w #$7020,(a0)
	move.w #$4c0,d7
	moveq #0,d0

loc_00696a:
	move.w d0,(2,a0)
	dbra d7,loc_00696a
	rts

;##############################################################################
loc_006974:
	lea.l player1mem,a0
	bsr.w loc_00698c
	tst.w d0
	bne.b loc_00698a
	lea.l (playeroffset,a0),a0
	bsr.w loc_00698c

loc_00698a:
	rts

;##############################################################################
loc_00698c:
	btst #7,($b8,a0)
	bne.b loc_0069ba
	lea.l ($30,a0),a1
	move.b (a1)+,d0
	andi.b #$f0,d0
	beq.b loc_0069ba
	moveq #$10,d7

loc_0069a2:
	move.b (a1)+,d1
	andi.b #$f0,d1
	bne.b loc_0069ae
	moveq #0,d0
	bra.b loc_0069b6

loc_0069ae:
	cmp.b d1,d0
	beq.b loc_0069b6
	moveq #1,d0
	bra.b loc_0069bc

loc_0069b6:
	dbra d7,loc_0069a2

loc_0069ba:
	moveq #0,d0

loc_0069bc:
	rts

;##############################################################################
loc_0069be:
	bclr #6,$101001
	beq.b loc_006a1c
	lea.l loc_065000,a0
	lea.l palramaddr,a1
	move.w #$3f,d7

loc_0069d8:
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	dbra d7,loc_0069d8

loc_006a1c:
	tst.w $106930
	beq.b loc_006a28
	jmp InitPaletteLoad(pc)

loc_006a28:
	lea.l $106a5e,a0
	lea.l loc_065000,a1
	lea.l palramaddr,a2
	moveq #$1f,d7

;Palette Effect
loc_006a3c:
	move.w (2,a0),d1
	beq.b loc_006a62
	clr.w (2,a0)
	moveq #0,d2
	move.w (a0),d2
	lea.l (a1,d2.l),a3
	lea.l (a2,d1.w),a4
	move.l (a3)+,(a4)+
	move.l (a3)+,(a4)+
	move.l (a3)+,(a4)+
	move.l (a3)+,(a4)+
	move.l (a3)+,(a4)+
	move.l (a3)+,(a4)+
	move.l (a3)+,(a4)+
	move.l (a3)+,(a4)+

loc_006a62:
	lea.l (4,a0),a0
	dbra d7,loc_006a3c
	bclr #1,$101001
	bne.b loc_006ab2
	tst.w $101010
	beq.w loc_006b5e
	subq.w #1,$101010
	beq.b loc_006ab2
	cmpi.w #1,$101010
	beq.b loc_006a9a
	btst #0,$101011
	beq.b loc_006ab2

loc_006a9a:
	moveq #-1,d0
	lea.l $401c00,a1
	moveq #$3f,d7

loc_006aa4:
	move.l d0,(a1)+
	move.l d0,(a1)+
	move.l d0,(a1)+
	move.l d0,(a1)+
	dbra d7,loc_006aa4
	rts

;Load Stage Palette
loc_006ab2:
	moveq #0,d0
	move.w stageid,d0
	lsl.l #8,d0
	lsl.l #2,d0
	tst.b exstageflag
	bne.b exstgaddr
	lea.l loc_067000,a0;Stage Palettes
	bra.b Roundcheck

exstgaddr:
	lea.l EXstagepalettes,a0

Roundcheck:
	tst.w $10100c
	beq.b loc_006ad0
	lea.l ($3400,a0),a0

loc_006ad0:
	adda.l d0,a0
	lea.l $401c00,a1
	moveq #3,d7

loc_006ada:
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	dbra d7,loc_006ada

loc_006b5e:
	tst.b $103a8c
	beq.b loc_006b6c
	jsr loc_0138fc

loc_006b6c:
	rts

;##############################################################################
loc_006b6e:
	lea.l player1mem,a0
	move.b #$30,d0
	bsr.w loc_006bac
	move.b d1,($b4,a0)
	move.b #$c0,d0
	bsr.w loc_006bac
	move.b d1,($b5,a0)
	lea.l player2mem,a0
	move.b #$30,d0
	bsr.w loc_006bac
	move.b d1,($b4,a0)
	move.b #$c0,d0
	bsr.w loc_006bac
	move.b d1,($b5,a0)
	rts

;##############################################################################
loc_006bac:
	moveq #$3f,d7
	moveq #0,d1
	moveq #0,d2
	lea.l ($30,a0),a1

loc_006bb6:
	move.b (a1)+,d3
	and.b d0,d3
	beq.b loc_006bc6
	tst.w d2
	bne.b loc_006bcc
	addq.b #1,d1
	moveq #1,d2
	bra.b loc_006bcc

loc_006bc6:
	tst.w d2
	beq.b loc_006bcc
	moveq #0,d2

loc_006bcc:
	dbra d7,loc_006bb6
	tst.w fighttimer
	beq.b loc_006be2
	btst #6,$101000
	beq.b loc_006be4

loc_006be2:
	moveq #0,d1

loc_006be4:
	rts

;##############################################################################
loc_006be6:
	bset #3,$101001
	jsr LSP_1ST
	moveq #0,d0
	move.w d0,$1062ac
	move.w d0,$1063ce
	bclr #3,$101001
	rts

;##############################################################################
loc_006c0c:
	bset #3,$101001
	lea.l VRAMADDR,a6
	move.w #1,(4,a6)
	lea.l $80d1,a1
	move.w a1,(a6)
	moveq #$7f,d7
	move.w #$fff,d0

loc_006c2e:
	move.w d0,(2,a6)
	dbra d7,loc_006c2e
	bclr #3,$101001
	rts

;##############################################################################
;Round start
loc_006c40:
	jsr randomfontpal

	lea.l player1mem,a0
	moveq #0,d0
	jsr loc_0043a8
	jsr loc_004856
	jsr loc_004756
	jsr loc_0046ae
	jsr p1palload;font palette
	lea.l player2mem,a0
	moveq #0,d0
	jsr loc_0043a8
	jsr loc_004856
	jsr loc_004756
	jsr loc_0046ae
	jsr p2palload
	jsr loc_00690e(pc)
	jsr loc_006e74(pc)
	nop
	jsr loc_009ae0
	jsr loc_0097c8
	rts

;##############################################################################
loc_006c98:
	movea.l $101420,a1
	lea.l loc_006cb6(pc),a2
	nop
	lea.l $708b.w,a3
	jsr loc_00dffc
	move.l a1,$101420
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_006cb6:
	dc.b "FEDCBA9876543210"
	dc.b "0123456789ABCDEF"
	dc.b $ff,$7f

;##############################################################################
loc_006cd8:
	moveq #0,d2
	move.w $101012,d0
	lsl.w #4,d0
	lea.l loc_00763c,a1
	adda.w d0,a1
	move.w $101018,d1

loc_006cf0:
	move.b (a1)+,d2
	btst d2,d1
	bne.b loc_006cf0
	rts

;##############################################################################
loc_006cf8:
	btst #7,$103728
	bne.b loc_006d0e
	move.b $1036a0,d0
	andi.b #$f0,d0
	bne.b loc_006d24

loc_006d0e:
	btst #7,$103928
	bne.b loc_006d28
	move.b $1038a0,d0
	andi.b #$f0,d0
	beq.b loc_006d28

loc_006d24:
	moveq #1,d0
	bra.b loc_006d2a

loc_006d28:
	moveq #0,d0

loc_006d2a:
	rts

;##############################################################################
loc_006d2c:
	move.b $103728,d1
	or.b $103928,d1
	lea.l player1mem,a0
	moveq #0,d2
	bsr.w loc_006d4a
	lea.l (playeroffset,a0),a0
	moveq #1,d2

loc_006d4a:
	movea.l ($14,a0),a1
	cmpi.b #2,(7,a1)
	bne.b loc_006db8
	cmpi.b #4,(4,a0)
	beq.b loc_006d64
	bclr d2,$101000

loc_006d64:
	cmpi.b #2,(7,a0)
	beq.b loc_006db8
	btst #7,d1
	bne.b loc_006d80
	cmpi.b #$63,(6,a1)
	beq.b loc_006d88
	addq.b #1,(6,a1)
	bra.b loc_006d88

loc_006d80:
	btst #7,($b8,a0)
	beq.b loc_006db8

loc_006d88:
	moveq #0,d0
	move.b (1,a0),d0
	btst #7,($b8,a0)
	bne.b loc_006d9c
	cmpi.b #$c,d0
	beq.b loc_006db8

loc_006d9c:
	btst #7,d1
	bne.b loc_006daa
	tst.b BIOS_MVS_FLAG
	bra.b loc_006db8

loc_006daa:
	move.w $101018,d2
	bset d0,d2
	move.w d2,$101018

loc_006db8:
	rts

;##############################################################################
loc_006dba:
	lea.l player1mem,a1
	lea.l (playeroffset,a1),a2
	move.b ($b8,a1),d0
	or.b ($b8,a2),d0
	btst #7,d0
	bne.b loc_006e40
	moveq #0,d1
	move.b (7,a2),d2
	cmp.b (7,a1),d2
	bhi.b loc_006e0e
	movea.l a1,a0
	movem.l d1/a2,-(a7)
	bsr.w loc_00698c
	movem.l (a7)+,d1/a2
	tst.w d0
	beq.b loc_006df4
	ori.w #2,d1

loc_006df4:
	move.b ($30,a0),d2
	andi.b #$f0,d2
	beq.b loc_006e0e
	ori.w #1,d1
	btst #4,($b0,a0)
	beq.b loc_006e0e
	ori.w #4,d1

loc_006e0e:
	move.b (7,a1),d2
	cmp.b (7,a2),d2
	bhi.b loc_006e3c
	movea.l a2,a0
	movem.l d1/a2,-(a7)
	bsr.w loc_00698c
	movem.l (a7)+,d1/a2
	tst.w d0
	beq.b loc_006e2e
	ori.w #2,d1

loc_006e2e:
	move.b ($30,a0),d2
	andi.b #$f0,d2
	beq.b loc_006e3c
	ori.w #1,d1

loc_006e3c:
	move.w d1,d0
	bra.b loc_006e72

loc_006e40:
	btst #7,($b8,a1)
	beq.b loc_006e4a
	movea.l a2,a1

loc_006e4a:
	movea.l a1,a0
	bsr.w loc_00698c
	tst.w d0
	beq.b loc_006e58
	move.w #2,d0

loc_006e58:
	move.b ($30,a0),d1
	andi.b #$f0,d1
	beq.b loc_006e72
	ori.w #1,d0
	btst #4,($b0,a0)
	beq.b loc_006e72
	ori.w #4,d0

loc_006e72:
	rts

;##############################################################################
loc_006e74:
	lea.l player1mem,a0
	lea.l $10695c,a2
	bsr.w loc_006e8e
	lea.l (playeroffset,a0),a0
	lea.l $10697c,a2

loc_006e8e:
	btst #7,($b8,a0)
	bne.b loc_006eea
	moveq #0,d1
	move.b (6,a0),d1
	beq.b loc_006ea4
	move.w #$a3bf,(a2)+
	bra.b loc_006eae

loc_006ea4:
	move.b (5,a0),d1
	addq.w #1,d1
	move.w #$a39f,(a2)+

loc_006eae:
	move.w #$a39e,(a2)+
	jsr loc_0044ca
	move.w d2,d1
	andi.w #$0f00,d1
	beq.b loc_006ed0
	lsr.w #8,d1
	addi.w #$2330,d1
	move.w d1,(a2)+
	move.w d2,d1
	andi.w #$f0,d1
	bra.b loc_006ed8

loc_006ed0:
	move.w d2,d1
	andi.w #$f0,d1
	beq.b loc_006ee0

loc_006ed8:
	lsr.w #4,d1
	addi.w #$2330,d1
	move.w d1,(a2)+

loc_006ee0:
	andi.w #$f,d2
	addi.w #$2330,d2
	move.w d2,(a2)+

loc_006eea:
	rts

;##############################################################################
loc_006eec:
	tst.b (a0)
	beq.b loc_006ef8
	bra.b loc_006f0e

;##############################################################################
loc_006ef2:
	bsr.w loc_006ef8
	bra.b loc_006f0e

;##############################################################################
loc_006ef8:
	moveq #7,d7
	move.l #$00ff00ff,d0
	lea.l $106946,a1

loc_006f06:
	move.l d0,(a1)+
	dbra d7,loc_006f06
	rts

;##############################################################################
loc_006f0e:
	moveq #7,d7
	move.l #$00ff00ff,d0
	lea.l $106966,a1

loc_006f1c:
	move.l d0,(a1)+
	dbra d7,loc_006f1c
	rts

;##############################################################################
loc_006f24:
	lea.l VRAMADDR,a6
	bset #3,$101001
	move.w #1,(4,a6)
	move.w #$3ff,d7
	move.w #$5ac0,(a6)
	moveq #$3f,d0
	moveq #0,d1

loc_006f44:
	move.w d0,(2,a6)
	nop
	move.w d1,(2,a6)
	dbra d7,loc_006f44
	bclr #3,$101001
	rts

;##############################################################################
loc_006f5c:
	lea.l ($20,a2),a2
	move.w a2,(a6)+
	move.w d2,(a6)+
	lea.l (1,a2),a2
	addq.w #1,d2
	move.w a2,(a6)+
	move.w d2,(a6)+
	lea.l (-$21,a2),a2
	addq.w #1,d2
	move.w a2,(a6)+
	move.w d2,(a6)+
	lea.l (1,a2),a2
	addq.w #1,d2
	move.w a2,(a6)+
	move.w d2,(a6)+
	lea.l ($3f,a2),a2
	rts

;##############################################################################
loc_006f88:
	movea.l $101420,a6

loc_006f8e:
	moveq #0,d2
	move.b (a1)+,d2
	cmpi.w #$ff,d2
	beq.b loc_006fbe
	cmpi.w #$20,d2
	bne.b loc_006fa4
	move.w #$31c,d2
	bra.b loc_006fb8

loc_006fa4:
	cmpi.w #$41,d2
	bcc.b loc_006fb2
	lsl.w #2,d2
	addi.w #$340,d2
	bra.b loc_006fb8

loc_006fb2:
	lsl.w #2,d2
	addi.w #$324,d2

loc_006fb8:
	add.w d0,d2
	bsr.b loc_006f5c
	bra.b loc_006f8e

loc_006fbe:
	move.l a6,$101420
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_006fc6:
	dc.w $0010

loc_006fc8:
	dc.b $00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05,$05
	dc.b $06,$06,$06,$07,$07,$07,$08,$08,$08,$09,$09,$09,$0a,$0a,$0a,$0b
	dc.b $0b,$0b,$0c,$0c,$0c,$0d,$0d,$0d,$0e,$0e,$0e,$0f,$0f,$0f,$10,$10
	dc.b $10,$11,$11,$11,$12,$12,$12,$13,$13,$13,$14,$14,$14,$15,$15,$15
	dc.b $16,$16,$16,$17,$17,$17,$18,$18,$18,$19,$19,$19,$1a,$1a,$1b,$1b
	dc.b $1c,$1c,$1d,$1d,$1e,$1e,$1f,$1f,$20,$20,$21,$21,$22,$22,$23,$23
	dc.b $24,$24,$25,$25,$26,$26,$27,$27,$28,$28,$29,$29,$2a,$2a,$2b,$2b
	dc.b $2c,$2c,$2d,$2d,$2e,$2e,$2f,$2f,$30,$30,$31,$31,$32,$32,$33,$33
	dc.b $34,$34,$35,$35,$36,$36,$37,$37,$38,$38,$39,$39,$3a,$3a,$3b,$3b
	dc.b $3c,$3c,$3d,$3d,$3e,$3e,$3f,$3f,$40,$40,$41,$41,$42,$42,$43,$43

loc_007068:
	dc.b $44,$44,$45,$45

loc_00706c:
	dc.b $46,$46,$47,$47

loc_007070:
	dc.b $48,$48,$49,$49

loc_007074:
	dc.b $4a,$4a,$4b,$4b

loc_007078:
	dc.b $4c,$4c,$4d,$4d
	dc.b $4e,$4e,$4f,$4f,$50,$50,$51,$51,$52,$52,$53,$53
	dc.b $54,$54,$55,$55,$56,$56,$57,$57,$58,$58,$59,$59,$5a,$5a,$5b,$5b

loc_007098:;?
	dc.b $5c,$5c,$5d,$5d,$5e,$5e,$5f,$5f,$60,$60,$61,$61,$62,$62,$63,$63
	dc.b $64,$64,$65,$66,$66,$67,$68,$68,$69,$6a,$6a,$6b,$6c,$6c,$6d,$6e
	dc.b $6e,$6f,$70,$70,$71,$72,$72,$73,$74,$74,$75,$76,$76,$77,$78,$78

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0070c8:
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_007108:
	dc.b $00,$00,$05,$fc,$04,$c0,$04,$c4,$04,$c8,$04,$cc,$04,$d0,$04,$d4
	dc.b $04,$d8,$04,$dc,$04,$e0,$04,$e4,$25,$fb,$04,$ec,$25,$fa,$04,$f4
	dc.b $07,$00,$07,$04,$07,$08,$07,$0c,$07,$10,$07,$14,$07,$18,$07,$1c
	dc.b $07,$20,$07,$24,$04,$f8,$04,$fc,$05,$00,$05,$04,$05,$08,$05,$0c
	dc.b $00,$00,$07,$28,$07,$2c,$07,$30,$07,$34,$07,$38,$07,$3c,$07,$40
	dc.b $07,$44,$07,$48,$07,$4c,$07,$50,$07,$54,$07,$58,$07,$5c,$07,$60
	dc.b $07,$64,$07,$68,$07,$6c,$07,$70,$07,$74,$07,$78,$07,$7c,$07,$80
	dc.b $07,$84,$07,$88,$07,$8c,$05,$10,$05,$14,$05,$18,$05,$1c,$05,$20
	dc.b $00,$00,$04,$24,$04,$f8,$04,$30,$04,$34,$04,$38,$04,$3c,$04,$40
	dc.b $04,$44,$04,$48,$04,$4c,$04,$50,$04,$54,$04,$58,$04,$5c,$04,$60
	dc.b $04,$64,$04,$68,$04,$6c,$04,$70,$04,$74,$04,$78,$04,$7c,$04,$80
	dc.b $04,$84,$04,$88,$04,$8c,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_007208:
	dc.b $00,$00,$05,$fa,$03,$b9,$03,$ba,$03,$bc,$03,$bd,$06,$b0,$23,$a0
	dc.b $23,$a1,$23,$a2,$23,$a3,$23,$a4,$23,$a5,$23,$a6,$23,$a7,$23,$a8
	dc.b $00,$00,$06,$00,$06,$04,$06,$08,$06,$0c,$06,$10,$06,$14,$06,$18
	dc.b $06,$1c,$06,$20,$06,$24,$06,$28,$06,$2c,$06,$30,$06,$34,$06,$38
	dc.b $06,$3c,$06,$40,$06,$44,$06,$48,$06,$4c,$06,$50,$06,$54,$06,$58
	dc.b $06,$5c,$06,$60,$06,$64,$06,$68,$06,$6c,$06,$70,$06,$74,$06,$78
	dc.b $06,$7c,$06,$80,$06,$84,$06,$88,$06,$8c,$06,$90,$06,$94,$06,$98
	dc.b $06,$9c,$06,$a0,$06,$a4,$06,$a8,$06,$ac,$06,$b4,$15,$f9,$15,$f8
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$05,$f0,$23,$80
	dc.b $23,$81,$23,$82,$23,$83,$23,$84,$23,$85,$23,$86,$23,$87,$23,$88

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0072a8:
	dc.w $0000,$0540,$0544,$0548,$054c,$0550,$0554,$0558
	dc.w $055c,$0560,$0564,$0568,$056c,$0570,$0574,$0578
	dc.w $057c,$0580,$0584,$0588,$058c,$0590,$0594,$0598
	dc.w $059c,$05a0,$05a4,$05a8,$05ac,$05b0,$05b4,$05b8
	dc.w $05bc,$05c0,$05c4,$05c8,$05cc,$05d0,$05d4,$05d8
	dc.w $05dc,$05e0,$05e4,$05e8,$05ec,$05f4

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_007304:
	dc.w $0000,$0000

loc_007308:
	dc.w $0000,$4000,$0000,$e000,$0000,$0000
	dc.w $0001,$0000,$0001,$0000,$0000,$0000,$0000,$8000
	dc.w $0000,$9000,$0000,$a000,$0001,$0000,$0001,$0000
	dc.w $0000,$0000,$0000,$b000,$0000,$b000,$0000,$b000
	dc.w $0001,$0000,$0001,$0000,$0000,$0000,$0000,$b000
	dc.w $0000,$c000,$0001,$0000,$0001,$0000,$0000,$c000
	dc.w $0000,$c000,$0000,$0000,$0000,$8000,$0000,$b000
	dc.w $0001,$0000,$0000,$c000,$0000,$0000,$0000,$2000
	dc.w $0000,$b000,$0000,$c000,$0001,$0000,$0000,$c000
	dc.w $0000,$0000,$0000,$a000,$0000,$e000,$0000,$0000
	dc.w $0001,$0000,$0000,$c000,$0000,$0000,$0000,$b000
	dc.w $0000,$b000,$0000,$0000,$0001,$0000,$0001,$0000
	dc.w $0000,$0000,$0000,$4000,$0000,$5000,$0000,$b000
	dc.w $0001,$0000,$0001,$0000,$0001,$0000,$0000,$8000
	dc.w $0000,$b000,$0000,$e000,$0001,$0000,$0000,$c000
	dc.w $0000,$0000,$0000,$5000,$0000,$9000,$0000,$b000
	dc.w $0001,$0000,$0001,$0000,$0001,$0000,$0000,$b000
	dc.w $0000,$b000,$0000,$d000,$0001,$0000,$0001,$0000
	dc.w $0000,$0000,$0000,$1000,$0000,$6000,$0000,$b000
	dc.w $0001,$0000,$0000,$c000,$0000,$0000

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_007440:
	; spriteid?,Height
	dc.w $0ec0,$003f;Ray
	dc.w $0ec4,$003f;Feilin
	dc.w $0ec8,$003f;Ryoko
	dc.w $0ecc,$003f;Matlok
	dc.w $0ed0,$003f;Samchay
	dc.w $0ed4,$003f;Lee
	dc.w $0ed8,$003f;Mizo
	dc.w $0edc,$003f;Jean
	dc.w $0ee0,$003f;Mars
	dc.w $0ee4,$003f;Yungmie
	dc.w $0ee8,$003f;Zazie
	dc.w $0eec,$003f;Clown
	dc.w $0ef0,$003f;Karnov

loc_007474:
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $0000,$0000
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $0000,$0000
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $0260,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008
	dc.w $01e0,$0008

loc_007544:
	dc.w $3b04,$3b08
	dc.w $0000,$3b14
	dc.w $3b18,$3b1c
	dc.w $6024,$6028
	dc.w $3b2c,$3b34
	dc.w $3b38,$3b3c
	dc.w $3b44,$3b48
	dc.w $3b4c,$3b54
	dc.w $3b58,$3b5c
	dc.w $3b64,$3b68
	dc.w $0000,$3b74
	dc.w $3b78,$0000
	dc.w $3b84,$3b88
	dc.w $3b8c,$3b94
	dc.w $3b98,$3b9c
	dc.w $3ba4,$3ba8
	dc.w $3bac,$3bb4
	dc.w $3bb8,$3bbc
	dc.w $3bc4,$3bc8
	dc.w $3bcc

loc_007592:
	dc.w $3b04,$3b08
	dc.w $0000,$6014,$6018,$601c,$6024,$6028
	dc.w $602c,$6034,$6038,$603c,$3b44,$6048
	dc.w $604c,$6054,$6058,$605c,$6064,$6068
	dc.w $0000,$6074,$6078
	dc.w $0000,$3b84,$3b88,$3b8c,$6094,$6098,$609c,$3ba4
	dc.w $3ba8,$3bac,$60b4,$60b8,$60bc,$60c4,$60c8,$60cc

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0075e0:
	dc.b "OBJ. GEN.",$fe
	dc.b "HIT GEN.",$fe
	dc.b "PATTERN GEN.",$fe
	dc.b "MESSAGE CHECK",$fe
	dc.b "SOUND CHECK",$fe
	dc.b "GAME",$fe,$ff

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_007620:
	dc.w $0800,$0800
	dc.w $0800,$0800
	dc.w $0800,$0800
	dc.w $0800,$0800
	dc.w $0800,$0800
	dc.w $0800,$0800
	dc.w $0800,$0800

loc_00763c:
	dc.l $09000501,$07060302,$08040a0b,$0c000000
	dc.l $0a040108,$03000705,$0209060b,$0c000000
	dc.l $06070903,$0a080104,$0005020b,$0c000000
	dc.l $050a0204,$00010609,$0308070b,$0c000000

loc_00767c:
	dc.l $00000001,$00030005,$00070008,$000a000c
	dc.l $000e0010,$00110013,$00150017,$0018001a
	dc.l $001c001e,$00200021,$00230025,$00270028
	dc.l $002a002c,$002e0030,$00310033,$00350037
	dc.l $0038003a,$003c003e,$00400041,$00430045

loc_0076cc:
	dc.l $00470048,$004a004c,$004e0050,$00510053
	dc.l $00550057,$0058005a,$005c005e,$00600061
	dc.l $00630065,$00670068,$006a006c,$006e0070
	dc.l $00710073,$00750077,$0078007a,$007c007e

loc_00770c:
	dc.l $00800081,$00830085,$00870088,$008a008c
	dc.l $008e0090,$00910093,$00950097,$0098009a
	dc.l $009c009e,$00a000a1,$00a300a5,$00a700a8
	dc.l $00aa00ac,$00ae00b0,$00b100b3,$00b500b7
	dc.l $00b800ba,$00bc00be,$00c000c1,$00c300c5

loc_00775c:
	dc.l loc_00786c
	dc.l loc_00795c
	dc.l loc_00795e
	dc.l loc_007a4a
	dc.l loc_00661a
	dc.l loc_012f18
	dc.l loc_00792c

;##############################################################################
loc_007778:
	lea.l player1mem,a0
	bsr.w loc_007788
	lea.l player2mem,a0

loc_007788:
	moveq #0,d0
	move.b (4,a0),d0
	lsl.w #2,d0
	movea.l loc_00775c(pc,d0.w),a1
	jsr (a1)
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_007798:
	dc.b '                '

loc_0077a8:
	dc.b '  INSERT COIN   '

loc_0077b8:
	dc.b '   PUSH START   '

loc_0077c8:
	dc.b '   PUSH START   '

loc_0077d8:
	dc.b '   GAME OVER    '

loc_0077e8:
	dc.b '   CONTINUE     '

loc_0077f8:
	dc.b '    WAITING     '

loc_007808:
	dc.b '                '

loc_007818:
	dc.b '   ',$ff

loc_00781c:
	dc.b "    INSERT COIN    ",$ff

loc_007830:
	dc.b "    PUSH START     ",$ff

loc_007844:
	dc.b "    PUSH START     ",$ff

loc_007858:
	dc.b "    PUSH START     ",$ff

;##############################################################################
loc_00786c:
	btst #3,$101000
	bne.w loc_00792a
	move.b $101000,d0
	andi.b #3,d0
	bne.b loc_00789a
	cmpi.w #3,mainmode
	bne.b loc_00789a
	cmpi.w #2,$106908
	beq.w loc_00792a

loc_00789a:
	move.b $10346b,d0
	andi.b #$3f,d0
	beq.b loc_0078b2
	cmpi.b #$28,d0
	bne.b loc_00792a
	lea.l loc_007798(pc),a1
	bra.b loc_007924

loc_0078b2:
	cmpi.w #5,$106908
	beq.b loc_00792a
	cmpi.w #6,$106908
	beq.b loc_00792a
	moveq #0,d0
	move.b (a0),d0
	tst.b BIOS_MVS_FLAG
	bne.b loc_0078e4
	lea.l $106b5e,a1
	tst.b (a1,d0.w)
	bne.b loc_007916
	lea.l loc_0077d8(pc),a1
	bra.b loc_007924

loc_0078e4:
	cmpi.b #1,BIOS_COUNTRY_CODE
	beq.b loc_0078f0
	moveq #0,d0

loc_0078f0:
	lea.l BIOS_CREDIT1_DEC,a1
	move.b #1,(a1,d0.w)
	movem.l d0/a0-a1,-(a7)
	jsr CREDIT_CHECK
	movem.l (a7)+,d0/a0-a1
	tst.b (a1,d0.w)
	bne.b loc_007916
	lea.l loc_0077a8(pc),a1
	bra.b loc_007924

loc_007916:
	tst.b (a0)
	bne.b loc_007920
	lea.l loc_0077b8(pc),a1
	bra.b loc_007924

loc_007920:
	lea.l loc_0077c8(pc),a1

loc_007924:
	jsr loc_007aa8(pc)
	nop

loc_00792a:
	rts

;##############################################################################
loc_00792c:
	cmpi.w #3,mainmode
	bne.b loc_00795a
	cmpi.w #5,$10100c
	beq.b loc_00795a
	cmpi.w #4,$106908
	beq.b loc_00795a
	cmpi.w #6,$106908
	bcc.b loc_00795a
	move.b #5,(4,a0)

loc_00795a:
	rts

;##############################################################################
;Is this vs?
loc_00795c:
	rts


;------------------------------------------------------------------------------
wipecredit:
	move.b #6,$103674
	move.b #6,$103874
	clr.w $10368c
	clr.w $10368c

	clr.b $10367b
	clr.b $10387b

	clr.b $103676
	clr.b $103876

	clr.b $103840
	clr.b $103a40
	jsr loc_006ef8
	rts


;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
wincounts:
	dc.w $ffff,0001,0002,0003,0005,0010

;##############################################################################
loc_00795e:
	bset #0,($b,a0)
	bne.b loc_0079a6
	tst.b BIOS_MVS_FLAG
	bne.b CountineDipCheck
	lea.l $106b5e,a1
	moveq #0,d0
	move.b (a0),d0
	tst.b (a1,d0.w)
	beq.w loc_0079d8
	bra.b loc_00798c

;Countines and Event mode check
CountineDipCheck:;7a32
	move.b BIOS_GAMEDIP_10,d0
	tst.b d0
	beq.b CountineCheck
	ext.w d0
	lsl.w #1,d0
	move.w wincounts(pc,d0.w),d0
	cmp.b p1wins,d0
	ble.w wipecredit
	cmp.b p2wins,d0
	ble.w wipecredit

CountineCheck:
	tst.b BIOS_GAMEDIP_01
	bne.w loc_0079d8

loc_00798c:
	moveq #0,d0
	move.b (a0),d0
	lea.l BIOS_PLAYER1_MODE,a1
	move.b #2,(a1,d0.w)
	move.w #$980,($1c,a0)
	bsr.w loc_007a26

loc_0079a6:
	move.b ($1c,a0),d0
	beq.b loc_0079bc
	cmpi.b #8,d0
	bcc.b loc_0079bc
	move.b ($b3,a0),d0
	andi.b #$f0,d0
	bne.b loc_0079d2

loc_0079bc:
	subq.b #1,($1d,a0)
	bcs.b loc_0079d2
	cmpi.b #$20,($1d,a0)
	bne.w loc_007a48
	bsr.w loc_0078b2
	bra.b loc_007a48

loc_0079d2:
	tst.b ($1c,a0)
	bne.b loc_0079fc

;------------------------------------------------------------------------------
;NoCountine
loc_0079d8:;7a66
	clr.w ($1c,a0)
	move.b #6,(4,a0)
	clr.b ($b,a0)
	tst.b (a0)
	bne.b loc_0079f4
	jsr loc_006ef8
	bra.w loc_007a48

loc_0079f4:
	jsr loc_006f0e
	bra.b loc_007a48

;------------------------------------------------------------------------------
loc_0079fc:
	move.b #$60,($1d,a0)
	subq.b #1,($1c,a0)
	cmpi.w #4,$106908
	bne.b loc_007a26
	move.b #$f,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_007a26:
	lea.l loc_0077e8(pc),a1
	bsr.w loc_007aa8
	lea.l $10695e,a2
	tst.b (a0)
	beq.b loc_007a3c
	lea.l ($20,a2),a2

loc_007a3c:
	moveq #0,d0
	move.b ($1c,a0),d0
	addi.w #$2330,d0
	move.w d0,(a2)

loc_007a48:
	rts

;##############################################################################
loc_007a4a:
	bset #0,($b,a0)
	bne.b loc_007a74
	moveq #0,d0
	move.b (a0),d0
	lea.l BIOS_PLAYER1_MODE,a1
	move.b #3,(a1,d0.w)
	bclr #2,($b8,a0)
	lea.l loc_0077d8(pc),a1
	bsr.w loc_007aa8
	clr.w ($1c,a0)

loc_007a74:
	addq.w #1,($1c,a0)
	cmpi.w #$7c,($1c,a0)
	bcs.b loc_007aa6
	lea.l loc_007798(pc),a1
	bsr.w loc_007aa8
	moveq #0,d0
	move.b (a0),d0
	lea.l BIOS_PLAYER1_MODE,a1
	tst.b BIOS_MVS_FLAG
	beq.b loc_007a9e
	clr.b (a1,d0.w)

loc_007a9e:
	clr.b (4,a0)
	clr.b ($b,a0)

loc_007aa6:
	rts

;==============================================================================
loc_007aa8:
	lea.l $106946,a2
	tst.b (a0)
	beq.b loc_007ab6
	lea.l ($20,a2),a2

loc_007ab6:
	moveq #$f,d7

loc_007ab8:
	moveq #0,d0
	move.b (a1)+,d0
	addi.w #$2300,d0
	move.w d0,(a2)+
	dbra d7,loc_007ab8
	rts

;##############################################################################
loc_007ac8:
	tst.w $106986
	bne.w loc_007be4
	move.b $101000,d0
	andi.b #3,d0
	bne.w loc_007be4
	move.b $10346b,d0
	andi.b #$3f,d0
	beq.b loc_007afc
	cmpi.b #$28,d0
	bne.w loc_007be4

loc_007af4:
	lea.l loc_007808(pc),a2
	bra.w loc_007bb2

loc_007afc:
	tst.b BIOS_MVS_FLAG
	bne.b loc_007b40
	cmpi.w #3,mainmode
	bne.b loc_007b2e
	cmpi.w #4,$106908
	bne.b loc_007b2e
	lea.l $106b5e,a3
	tst.w (a3)
	beq.w loc_007be4
	tst.b (a3)
	beq.b loc_007b34
	tst.b (1,a3)
	beq.b loc_007b3a

loc_007b2e:
	lea.l loc_007858(pc),a2
	bra.b loc_007bb2

loc_007b34:
	lea.l loc_007844(pc),a2
	bra.b loc_007bb2

loc_007b3a:
	lea.l loc_007830(pc),a2
	bra.b loc_007bb2

loc_007b40:
	move.w #$101,BIOS_CREDIT1_DEC
	movem.l a0/a2,-(a7)
	jsr CREDIT_CHECK
	movem.l (a7)+,a0/a2
	tst.w BIOS_CREDIT1_DEC
	bne.b loc_007b64
	lea.l loc_00781c(pc),a2
	bra.b loc_007bb2

loc_007b64:
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_007b90
	cmpi.w #$101,BIOS_CREDIT1_DEC
	beq.b loc_007b8a
	tst.b BIOS_CREDIT1_DEC
	bne.b loc_007b84
	lea.l loc_007844(pc),a2
	bra.b loc_007bb2

loc_007b84:
	lea.l loc_007830(pc),a2
	bra.b loc_007bb2

loc_007b8a:
	lea.l loc_007858(pc),a2
	bra.b loc_007bb2

loc_007b90:
	cmpi.w #3,mainmode
	bne.b loc_007ba4
	cmpi.w #4,$106908
	beq.b loc_007b8a

loc_007ba4:
	cmpi.w #$101,BIOS_CREDIT1_DEC
	beq.b loc_007b8a
	lea.l loc_007830(pc),a2

loc_007bb2:
	movea.l $101420,a1
	lea.l $7177.w,a3
	cmpi.w #2,mainmode
	bcs.b loc_007bd8
	lea.l $716f.w,a3
	cmpi.w #4,$106908
	bne.b loc_007bd8
	lea.l $7175.w,a3

loc_007bd8:
	jsr loc_00dffc
	move.l a1,$101420

loc_007be4:
	rts

;##############################################################################
loc_007be6:
	dc.w $031c,$031c,$031c,$031c
	dc.w $031c,$031c,$031c,$031c
	dc.w $ffff

loc_007bf8:
	dc.w $031c,$031c,$031c,$031c
	dc.w $031c,$031c,$031c,$031c
	dc.w $031c,$031c,$031c,$031c
	dc.w $031c,$031c,$031c,$031c
	dc.w $031c,$ffff

loc_007c1c:
	dc.w $2430,$2460,$245c,$2474
	dc.w $2448,$245c,$2478,$2438
	dc.w $ffff

;##############################################################################
loc_007c2e:
	bset #0,$10690a
	beq.w loc_007dc8
	bset #1,$10690a
	bne.w loc_007cd4
	lea.l player1mem,a0
	moveq #0,d0
	cmpi.b #2,(4,a0)
	bne.b loc_007c58
	addq.w #1,d0

loc_007c58:
	cmpi.b #2,($204,a0)
	bne.b loc_007c62
	addq.w #1,d0

loc_007c62:
	tst.w d0
	beq.w loc_007d90
	clr.w $1066bc
	cmpi.w #2,d0
	bne.b loc_007c7c
	move.w #1,$1066bc

loc_007c7c:
	btst #7,($b8,a0)
	bne.b loc_007c88
	lea.l (playeroffset,a0),a0

loc_007c88:
	moveq #0,d0
	move.b (1,a0),d0
	addi.w #$aa,d0
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_007c9e
	addi.w #$c8,d0

loc_007c9e:
	lsl.w #2,d0
	lea.l loc_02e000,a1
	lea.l $1066ac,a2
	move.l (a1,d0.w),(a2)
	clr.w (4,a2)
	move.w #$7097,(6,a2)
	clr.w (8,a2)
	move.b #5,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054

loc_007cd4:
	lea.l player1mem,a0
	lea.l (playeroffset,a0),a1
	cmpi.b #2,(4,a0)
	bne.b loc_007cf8
	cmpi.b #2,(4,a1)
	bne.b loc_007cfa
	move.w ($1c,a0),d0
	cmp.w ($1c,a1),d0
	bcc.b loc_007cfa

loc_007cf8:
	movea.l a1,a0

loc_007cfa:
	move.w ($1c,a0),$10690c
	bsr.w loc_007dca
	tst.b $10690b
	bne.b loc_007d30
	jsr loc_00d632
	tst.w $106986
	bne.w loc_007dc8
	addq.b #1,$10690b
	lea.l loc_007c1c(pc),a1
	lea.l $71a8.w,a2
	bsr.w loc_007f14

loc_007d30:
	cmpi.b #1,$10690b
	bne.b loc_007d5c
	tst.w $1066bc
	bne.b loc_007d48
	jsr loc_0086e6

loc_007d48:
	bsr.w loc_007ac8
	tst.w $10690c
	bne.b loc_007dc8
	addq.b #1,$10690b
	bra.b loc_007dc8

loc_007d5c:
	lea.l loc_007be6(pc),a1
	lea.l $71a8.w,a2
	bsr.w loc_007f14
	lea.l loc_007bf8(pc),a1
	lea.l $7096.w,a2
	bsr.w loc_007f14
	lea.l loc_007bf8(pc),a1
	lea.l $7098.w,a2
	bsr.w loc_007f14
	lea.l loc_007bf8(pc),a1
	lea.l $709a.w,a2
	bsr.w loc_007f14
	bsr.w loc_007af4

loc_007d90:
	move.w #8,$106908
	clr.w $10690a
	bset #3,$101000
	lea.l player1mem,a0
	tst.b (4,a0)
	bne.b loc_007db8
	jsr loc_006ef8

loc_007db8:
	lea.l (playeroffset,a0),a0
	tst.b (4,a0)
	bne.b loc_007dc8
	jsr loc_006f0e

loc_007dc8:
	rts

;##############################################################################
loc_007dca:
	movea.l $10141c,a1
	move.l #$8000000,d0
	move.b ($1c,a0),d0
	addi.w #$1116,d0
	move.l d0,(a1)+
	move.l #$a00158,(a1)+
	move.l a1,$10141c
	rts

;##############################################################################
loc_007dee:
	tst.w $106986
	beq.b loc_007e00
	jsr loc_00d632
	bra.w loc_007f12

loc_007e00:
	bset #0,$10690a
	bne.b loc_007e7a
	bset #3,$101001
	jsr FIX_CLEAR
	bclr #3,$101001
	clr.w $10690c
	move.b #6,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054
	bclr #3,$101000
	lea.l player1mem,a0
	cmpi.b #6,(4,a0)
	bne.b loc_007e5e
	move.b #5,(4,a0)
	jsr loc_012f18

loc_007e5e:
	lea.l (playeroffset,a0),a0
	cmpi.b #6,(4,a0)
	bne.b loc_007e76
	move.b #5,(4,a0)
	jsr loc_012f18

loc_007e76:
	bra.w loc_007f12

loc_007e7a:
	cmpi.w #3,$10690c
	bcs.b loc_007ebc
	movea.l $10141c,a1
	move.l #$c00010fa,(a1)+
	move.l #$a00150,(a1)+
	move.l a1,$10141c
	move.b BIOS_STATCURNT,d0
	andi.b #5,d0
	beq.b loc_007ebc
	cmpi.b #5,$103674
	beq.b loc_007ebc
	cmpi.b #5,$103874
	bne.b loc_007eda

loc_007ebc:
	addq.w #1,$10690c
	cmpi.w #$f8,$10690c
	bcs.b loc_007f12
	move.b $103674,d0
	or.b $103874,d0
	bne.b loc_007f12

loc_007eda:
	move.w #8,mainmode
	clr.w $101004
	clr.w $106908
	clr.w $10690a
	clr.w $10690e
	clr.w $106910
	lea.l $106946,a0
	moveq #$1f,d7
	move.w #$2320,d0

loc_007f0c:
	move.w d0,(a0)+
	dbra d7,loc_007f0c

loc_007f12:
	rts

;##############################################################################
loc_007f14:
	movea.l $101420,a0

loc_007f1a:
	move.w (a1)+,d0
	cmpi.w #$ffff,d0
	beq.w loc_007f4c
	move.w a2,(a0)+
	move.w d0,(a0)+
	addq.w #1,d0
	lea.l (1,a2),a2
	move.w a2,(a0)+
	move.w d0,(a0)+
	addq.w #1,d0
	lea.l (-$21,a2),a2
	move.w a2,(a0)+
	move.w d0,(a0)+
	addq.w #1,d0
	lea.l (1,a2),a2
	move.w a2,(a0)+
	move.w d0,(a0)+
	lea.l ($5f,a2),a2
	bra.b loc_007f1a

loc_007f4c:
	move.l a0,$101420
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_007f54:
	dc.b 'MESSAGE NO.:',$ff,$16

;##############################################################################
loc_007f62:
	bset #0,$106910
	bne.b loc_007f82
	lea.l $1066ac,a0
	clr.w (4,a0)
	clr.w (8,a0)
	clr.w ($a,a0)
	bra.w loc_007fec

loc_007f82:
	btst #7,$103726
	beq.b loc_007fbe
	moveq #0,d0
	move.w #1,mainmode
	move.w d0,$101004
	move.w d0,$101006
	move.w d0,$106908
	move.w d0,$10690a
	move.w d0,$10690e
	move.w d0,$106910
	bra.w loc_0080a8

loc_007fbe:
	move.b $103726,d0
	move.w d0,d1
	andi.w #$a,d1
	beq.b loc_007fd4
	addq.w #1,$1066b4
	bra.b loc_007fec

loc_007fd4:
	move.w d0,d1
	andi.w #5,d1
	beq.w loc_008064
	subq.w #1,$1066b4
	bcc.b loc_007fec
	clr.w $1066b4

loc_007fec:
	lea.l loc_02e000,a1
	move.w $1066b4,d0
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_008004
	addi.w #$c8,d0

loc_008004:
	lsl.w #2,d0
	movea.l (a1,d0.w),a1
	move.l a1,$1066ac

loc_008010:
	bset #3,$101001
	jsr FIX_CLEAR
	bclr #3,$101001
	movea.l $101420,a1
	lea.l loc_007f54(pc),a2
	lea.l $7124.w,a3
	jsr loc_00dffc
	move.l a1,$101420
	lea.l $7086.w,a1
	lea.l $1066ac,a0
	move.w a1,(6,a0)
	clr.w ($a,a0)
	move.w #6,($c,a0)
	bsr.w loc_008132
	bsr.w loc_0080aa
	bra.w loc_0080a8

loc_008064:
	move.w $1066b6,d0
	move.w #$ff,d1
	cmpi.w #1,d0
	beq.b loc_00807a
	cmpi.w #3,d0
	bne.b loc_008094

loc_00807a:
	btst #4,$103726
	bne.b loc_00808a
	move.w #$230b,d1
	bra.b loc_008094

loc_00808a:
	clr.w $1066b6
	bra.w loc_008010

loc_008094:
	lea.l $7324.w,a3
	movea.l $101420,a6
	move.w a3,(a6)+
	move.w d1,(a6)+
	move.l a6,$101420

loc_0080a8:
	rts

;##############################################################################
loc_0080aa:
	lea.l loc_0070c8,a5
	lea.l $1066ac,a0
	movea.l (a0),a1
	movea.w (6,a0),a2
	movea.l $101420,a6

loc_0080c2:
	moveq #0,d0
	moveq #0,d4
	jsr loc_0081c2(pc)
	nop
	tst.w d0
	beq.b loc_0080c2
	cmpi.w #3,d0
	beq.b loc_0080e8
	cmpi.w #4,d0
	beq.b loc_0080c2
	cmpi.w #2,d0
	beq.b loc_0080ee
	cmpi.w #1,d0
	bne.b loc_0080ee

loc_0080e8:
	cmpa.w #$7098,a2
	bcs.b loc_0080c2

loc_0080ee:
	move.l a6,$101420
	move.w d0,($a,a0)
	move.l a1,(a0)
	move.w a2,(6,a0)
	rts

;##############################################################################
loc_008100:
	move.w #$ff,d0
	lea.l $7097.w,a1
	moveq #0,d7

loc_00810a:
	movea.l a1,a2
	move.w #$1f,d6

loc_008110:
	move.w a2,(a6)+
	move.w d0,(a6)+
	lea.l ($20,a2),a2
	dbra d6,loc_008110
	lea.l (1,a1),a1
	addq.w #1,d7
	cmpi.w #2,d7
	bne.b loc_00812a
	addq.w #1,d7

loc_00812a:
	cmpi.w #5,d7
	bcs.b loc_00810a
	rts

;##############################################################################
loc_008132:
	moveq #0,d1
	move.w $1066b4,d1
	bsr.w loc_0044ca
	lea.l $72a4.w,a3
	move.l d2,d1
	swap d1
	lsl.l #4,d1
	moveq #2,d7
	moveq #1,d6
	move.w #$2000,d3
	movea.l $101420,a2
	jsr loc_00446a
	move.l a2,$101420
	rts

;##############################################################################
loc_008164:
	bset #0,$101004
	bne.b loc_008194
	clr.w $101006
	jsr loc_006be6
	lea.l $105cac,a0
	moveq #0,d0
	move.w #$17f,d7

loc_008186:
	move.l d0,(a0)+
	dbra d7,loc_008186
	move.b #9,$103a72

loc_008194:
	jsr loc_014674
	bra.b loc_0081c0

;##############################################################################
loc_00819c:
	clr.w $101004
	move.w #3,mainmode
	move.w #2,$106908
	clr.w $10690a
	bset #7,$101000

loc_0081c0:
	rts

;##############################################################################
;Winquote and Intro Text Render
loc_0081c2:
	tst.w d0
	bne.w loc_00831c
	tst.b BIOS_COUNTRY_CODE
	bne.w loc_00831c
	move.w (a1)+,d2
	move.w d2,d3
	andi.w #$fff,d2
	andi.w #$f000,d3
	cmpi.w #$fff,d2
	bne.b loc_0081ea
	moveq #2,d0
	bra.w loc_0082e2

loc_0081ea:
	cmpi.w #$ffe,d2
	bne.b loc_008202
	move.w a2,d0
	andi.w #$1f,d0
	addi.w #$7083,d0
	movea.w d0,a2
	moveq #1,d0
	bra.w loc_0082e2

loc_008202:
	cmpi.w #$ffa,d2
	bne.b loc_00820e
	lea.l ($20,a2),a2
	bra.b loc_0081c2

loc_00820e:
	cmpi.w #$ffb,d2
	bne.b loc_00821a
	bsr.w loc_0082e4
	bra.b loc_0081c2

loc_00821a:
	cmpi.w #$ff9,d2
	bne.b loc_008226
	moveq #3,d0
	bra.w loc_0082e2

loc_008226:
	cmpi.w #$ffd,d2
	bne.b loc_008238
	moveq #4,d0
	move.w (a1)+,d1
	andi.w #$ff,d1
	bra.w loc_0082e2

loc_008238:
	cmpi.w #$389,d2
	bne.b loc_008250
	or.w d3,d2
	lea.l ($20,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	lea.l ($40,a2),a2
	bra.w loc_0082e0

loc_008250:
	cmpi.w #$3a9,d2
	bne.b loc_008268
	or.w d3,d2
	lea.l (1,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	lea.l ($20,a2),a2
	bra.w loc_0082e0

loc_008268:
	cmpi.w #$20,d2
	bne.b loc_008274
	bsr.w loc_0082e4
	bra.b loc_0082e0

loc_008274:
	cmpi.w #$120,d2
	bcc.b loc_0082b2
	add.w d2,d2
	move.w (a5,d2.w),d2
	btst #$c,d2
	beq.b loc_008298
	andi.w #$fff,d2
	or.w d3,d2
	lea.l ($1f,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	bra.w loc_0081c2

loc_008298:
	btst #$d,d2
	beq.b loc_0082b2
	andi.w #$fff,d2
	or.w d3,d2
	lea.l (1,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	lea.l ($20,a2),a2
	bra.b loc_0082e0

loc_0082b2:
	andi.w #$fff,d2
	or.w d3,d2
	lea.l ($20,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	addq.w #1,d2
	lea.l ($21,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	addq.w #1,d2
	lea.l (a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	addq.w #1,d2
	lea.l (1,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	lea.l ($40,a2),a2

loc_0082e0:
	moveq #0,d0

loc_0082e2:
	rts

loc_0082e4:
	move.w #$ff,d2
	lea.l (-1,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	lea.l ($1f,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	lea.l ($20,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	lea.l ($21,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	lea.l (a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	lea.l (1,a2),a3
	move.w a3,(a6)+
	move.w d2,(a6)+
	lea.l ($40,a2),a2
	rts

loc_00831c:
	clr.w $106698

loc_008322:
	moveq #0,d2
	move.b (a1)+,d2
	cmpi.w #$ff,d2
	bne.b loc_008332
	moveq #2,d0
	bra.w loc_0083b8

loc_008332:
	cmpi.w #$fe,d2
	bne.b loc_00834a
	move.w a2,d0
	andi.w #$1f,d0
	addi.w #$7082,d0
	movea.w d0,a2
	moveq #1,d0
	bra.w loc_0083b8

loc_00834a:
	cmpi.w #$fd,d2
	bne.b loc_008358
	moveq #4,d0
	move.b (a1)+,d1
	bra.w loc_0083b8

loc_008358:
	cmpi.w #$f9,d2
	bne.b loc_008364
	moveq #3,d0
	bra.w loc_0083b8

loc_008364:
	cmpi.w #$fb,d2
	bne.b loc_008370
	lea.l ($20,a2),a2
	bra.b loc_008322

loc_008370:
	cmpi.w #$f7,d2
	bne.b loc_008380
	moveq #0,d2
	move.b (a1)+,d2
	lsl.w #8,d2
	move.b (a1)+,d2
	bra.b loc_00839c

loc_008380:
	cmpi.w #$f6,d2
	bne.b loc_00838c
	move.b (a1)+,d4
	lsl.w #8,d4
	bra.b loc_008322

loc_00838c:
	tst.w d4
	beq.b loc_008398
	add.w d4,d2
	addi.w #$300,d2
	bra.b loc_00839c

loc_008398:
	addi.w #$2300,d2

loc_00839c:
	move.w a2,(a6)+
	move.w d2,(a6)+
	lea.l ($20,a2),a2
	addq.w #1,$106698
	cmpi.w #2,$106698
	bcs.w loc_008322
	moveq #0,d0

loc_0083b8:
	rts

;##############################################################################
loc_0083ba:
	bset #0,$10690a
	bne.w loc_008446
	clr.b $103a72
	jsr loc_006be6
	move.w #$600,d3
	jsr loc_00d976
	lea.l VRAMADDR,a4
	jsr loc_00d3b0
	move.w #$ec08,($152,a1)
	move.w #$ec08,($352,a1)
	move.b #4,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054
	clr.w $10690c
	bsr.w loc_008666
	lea.l player1mem,a0
	cmpi.b #1,(4,a0)
	bne.b loc_00842e
	lea.l loc_007798,a1
	jsr loc_007aa8

loc_00842e:
	lea.l (playeroffset,a0),a0
	cmpi.b #1,(4,a0)
	bne.b loc_008446
	lea.l loc_007798,a1
	jsr loc_007aa8

loc_008446:
	addq.w #1,$10690c
	tst.b $10690b
	bne.b loc_008468
	cmpi.w #4,$10690c
	bcs.w loc_0084ee
	addq.b #1,$10690b
	bra.b loc_00846c

loc_008468:
	bsr.w loc_0085da

loc_00846c:
	cmpi.b #1,$10690b
	bne.b loc_008494
	jsr loc_00d632
	tst.w $106986
	bne.w loc_0084ee
	addq.b #1,$10690b
	bclr #6,$101000

loc_008494:
	cmpi.b #2,$10690b
	bne.b loc_0084be
	bsr.w loc_0086e6
	jsr loc_006dba
	btst #1,d0
	bne.b loc_0084b8
	cmpi.w #$118,$10690c
	bcs.b loc_0084ee

loc_0084b8:
	addq.b #1,$10690b

loc_0084be:
	lea.l player1mem,a0
	cmpi.b #4,(4,a0)
	beq.b loc_0084ee
	cmpi.b #4,($204,a0)
	beq.b loc_0084ee
	jsr loc_00d654
	cmpi.w #$15,$106986
	bcs.b loc_0084ee
	jsr loc_006d2c
	bsr.w loc_0084f0

loc_0084ee:
	rts

;##############################################################################
loc_0084f0:
	lea.l player1mem,a0
	lea.l (playeroffset,a0),a1
	lea.l BIOS_PLAYER1_MODE,a2
	move.b ($b8,a0),d0
	or.b ($b8,a1),d0
	btst #7,d0
	bne.b loc_008578
	btst #0,$101000
	bne.b loc_00852c
	move.b #2,(4,a0)
	clr.b ($b,a0)
	bset #7,($b8,a0)
	move.b #2,(a2)

loc_00852c:
	btst #1,$101000
	bne.b loc_00854c
	move.b #2,(4,a1)
	clr.b ($b,a1)
	bset #7,($b8,a1)
	move.b #2,(1,a2)

loc_00854c:
	move.b $101000,d0
	andi.b #3,d0
	bne.w loc_0085be

loc_00855a:
	move.w #4,$106908
	clr.w $10690a
	clr.w $10690e
	clr.w $106910
	bra.w loc_0085d8

loc_008578:
	btst #7,($b8,a0)
	bne.b loc_00859a
	btst #0,$101000
	bne.b loc_0085be
	move.b #2,(4,a0)
	clr.b ($b,a0)
	move.b #2,(a2)
	bra.b loc_00855a

loc_00859a:
	btst #7,($b8,a1)
	bne.b loc_0085be
	btst #1,$101000
	bne.b loc_0085be
	move.b #2,(4,a1)
	clr.b ($b,a1)
	move.b #2,(1,a2)
	bra.b loc_00855a

loc_0085be:
	move.w #1,$106908
	clr.w $10690a
	clr.w $10690e
	clr.w $106910

loc_0085d8:
	rts

;##############################################################################
loc_0085da:
	movea.l $101420,a6
	lea.l player1mem,a1
	lea.l $1040.w,a2
	moveq #0,d3
	bsr.w loc_00862e
	lea.l (playeroffset,a1),a1
	lea.l $11c0.w,a2
	move.w #1,d3
	bsr.w loc_00862e
	lea.l player1mem,a1
	move.w #$8441,(a6)+
	move.w ($150,a1),(a6)+
	move.w #$8447,(a6)+
	move.w ($350,a1),(a6)+
	move.w #$8241,(a6)+
	move.w ($152,a1),(a6)+
	move.w #$8247,(a6)+
	move.w ($352,a1),(a6)+
	move.l a6,$101420
	rts

;##############################################################################
;WinQuote Portraits
loc_00862e:
	moveq #0,d6
	cmpa.l #player2mem,a1
	bne.b p1winquote
	move.w #$1400,d6
;	move.b (3,a1),d6
;	andi.w #3,d6;There is only 2 paletet but it's expecting 4
;	mulu.w #$1400,d6

p1winquote:
	move.w #$10e0,d0
	movea.l ($14,a1),a3
	cmpi.b #2,(7,a3)
	bcs.b loc_008660
	cmpi.b #2,(7,a1)
	bcs.b loc_00865c
	btst #7,($b8,a1)
	bne.b loc_008660

loc_00865c:
	move.w #$10ed,d0
	bsr.w loc_00d760
	rts

loc_008660:
	jsr CharacterWinBG
	bsr.w loc_00d760
	rts

;##############################################################################
loc_008666:
	lea.l $1066ac,a0
	clr.w (4,a0)
	lea.l $7097.w,a1
	move.w a1,(6,a0)
	lea.l player1mem,a2
	lea.l (playeroffset,a2),a3
	move.b (7,a2),d0
	cmp.b (7,a3),d0
	bne.b loc_0086ac
	move.b ($b8,a2),d0
	or.b ($b8,a3),d0
	btst #7,d0
	beq.b loc_0086a4
	btst #7,($b8,a2)
	bne.b loc_0086b4
	bra.b loc_0086ae

loc_0086a4:
	move.w #2,(8,a0)
	bra.b loc_0086e4

loc_0086ac:
	bcc.b loc_0086b4

loc_0086ae:
	movea.l a2,a4
	movea.l a3,a2
	movea.l a4,a3

loc_0086b4:
	moveq #0,d0
	move.b (1,a2),d0
	mulu.w #$d,d0
	moveq #0,d1
	move.b (1,a3),d1
	add.w d1,d0
	addq.w #1,d0
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_0086d4
	addi.w #$c8,d0

loc_0086d4:
	lsl.w #2,d0
	lea.l loc_02e000,a2
	move.l (a2,d0.w),(a0)
	clr.w (8,a0)

loc_0086e4:
	rts

;##############################################################################
loc_0086e6:
	lea.l $1066ac,a0
	cmpi.w #2,(8,a0)
	beq.b loc_008756
	jsr loc_006dba
	lea.l $1066ac,a0
	addq.w #1,(4,a0)
	cmpi.w #3,(4,a0)
	bcs.b loc_008756
	clr.w (4,a0)
	movea.l $101420,a6
	movea.l (a0),a1
	movea.w (6,a0),a2
	lea.l loc_0070c8,a5
	tst.w d0
	bne.b loc_008736
	moveq #0,d0
	moveq #0,d4
	jsr loc_0081c2
	move.w d0,(8,a0)
	bra.b loc_00874a

loc_008736:
	moveq #0,d0
	moveq #0,d4
	jsr loc_0081c2
	move.w d0,(8,a0)
	cmpi.w #2,d0
	bne.b loc_008736

loc_00874a:
	move.l a1,(a0)
	move.w a2,(6,a0)
	move.l a6,$101420

loc_008756:
	rts

;##############################################################################
loc_008758:
	movea.l $10673c,a0
	tst.w $106738
	beq.b loc_00876c
	bsr.w loc_008796
	move.l d0,d1

loc_00876c:
	movem.l d0/a0,-(a7)
	tst.w $106738
	beq.b loc_00877e
	jsr loc_0044ca

loc_00877e:
	bsr.w loc_008856
	movem.l (a7)+,d0/a0
	tst.w $106738
	beq.b loc_008794
	jsr loc_0043a8

loc_008794:
	rts

;##############################################################################
loc_008796:
	moveq #0,d0
	cmpi.w #5,$10100c
	bcs.b loc_0087a8
	addi.l #$c350,d0

loc_0087a8:
	moveq #0,d1
	move.b fighttimer,d1
	mulu.w #$64,d1
	add.l d1,d0
	moveq #0,d1
	move.b ($143,a0),d1
	cmpi.b #$78,d1
	bne.b loc_0087c8
	move.w #$4e20,d1
	bra.b loc_0087cc

loc_0087c8:
	mulu.w #$64,d1

loc_0087cc:
	add.l d1,d0
	cmpi.w #1,$10100c
	bne.b loc_0087de
	addi.l #$7d0,d0

loc_0087de:
	btst #1,($bf,a0)
	beq.b loc_0087ec
	addi.l #$3e8,d0

loc_0087ec:
	move.l ($118,a0),d1
	moveq #0,d2
	moveq #$1f,d7

loc_0087f4:
	btst d7,d1
	beq.b loc_0087fa
	addq.w #1,d2

loc_0087fa:
	dbra d7,loc_0087f4
	mulu.w #$64,d2
	add.l d2,d0
	move.w ($110,a0),d2
	bne.b loc_00880e
	moveq #0,d1
	bra.b loc_008830

loc_00880e:
	moveq #0,d1
	move.w ($114,a0),d1
	cmp.w d1,d2
	bne.b loc_00881e
	move.w #$4e20,d1
	bra.b loc_008830

loc_00881e:
	lsl.l #8,d1
	divu.w d2,d1
	mulu.w #$2710,d1
	lsr.l #8,d1
	divu.w #$32,d1
	mulu.w #$32,d1

loc_008830:
	add.l d1,d0
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_008834:
	dc.w $bae0,$bade,$badc,$bada,$bad8,$bad6,$bad4

loc_008842:
	dc.w $ba9a,$ba98,$ba96,$bae0,$bade,$badc,$bada
	dc.w $bad8,$bad6,$bad4

;##############################################################################
loc_008856:
	movea.l $101420,a6
	movea.w #$5440,a0
	movea.w #$8151,a1
	movea.w #$8351,a2
	movea.w #$8551,a3
	lea.l loc_008834(pc),a4
	tst.w $106738
	bne.b loc_008884
	lea.l loc_008842(pc),a4
	moveq #9,d7
	move.w #$1500,d1
	bra.b loc_00888a

loc_008884:
	moveq #6,d7
	move.w #$1100,d1

loc_00888a:
	cmpi.w #6,d7
	bne.b loc_00889c
	tst.w $106738
	bne.b loc_00889c
	move.w #$1d00,d1

loc_00889c:
	move.w (a4)+,d0
	move.w a0,(a6)+
	lea.l (1,a0),a0
	move.w d0,(a6)+
	move.w a0,(a6)+
	lea.l (1,a0),a0
	move.w d1,(a6)+
	move.w a0,(a6)+
	lea.l (1,a0),a0
	addq.w #1,d0
	move.w d0,(a6)+
	move.w a0,(a6)+
	move.w d1,(a6)+
	lea.l ($3d,a0),a0
	dbra d7,loc_00888a
	tst.w $106738
	beq.w loc_008922
	lsl.l #8,d2
	lsl.l #4,d2
	moveq #4,d7
	move.w #$1500,d6
	moveq #0,d4

loc_0088da:
	move.l d2,d3
	rol.l #4,d2
	move.w d2,d3
	andi.w #$f,d3
	beq.b loc_0088e8
	moveq #1,d4

loc_0088e8:
	add.w d3,d3
	addi.w #$ba82,d3
	cmpi.w #$ba82,d3
	bne.b loc_0088fc
	tst.w d4
	bne.b loc_0088fc
	move.w #$3e,d3

loc_0088fc:
	move.w a0,(a6)+
	lea.l (1,a0),a0
	move.w d3,(a6)+
	move.w a0,(a6)+
	lea.l (1,a0),a0
	move.w d6,(a6)+
	move.w a0,(a6)+
	lea.l (1,a0),a0
	addq.w #1,d3
	move.w d3,(a6)+
	move.w a0,(a6)+
	move.w d6,(a6)+
	lea.l ($3d,a0),a0
	dbra d7,loc_0088da

loc_008922:
	move.w #$ff,d0
	moveq #$b,d7

loc_008928
	move.w a1,(a6)+
	lea.l (1,a1),a1
	move.w d0,(a6)+
	dbra d7,loc_008928
	move.w #$d402,d0
	move.w a2,(a6)+
	lea.l (1,a2),a2
	move.w d0,(a6)+
	bset #6,d0
	moveq #$a,d7
	tst.w $106738
	bne.b loc_008950
	moveq #8,d7

loc_008950:
	move.w a2,(a6)+
	lea.l (1,a2),a2
	move.w d0,(a6)+
	dbra d7,loc_008950
	move.w a3,(a6)+
	tst.w $106738
	beq.b loc_00896c
	move.w #$2000,(a6)+
	bra.b loc_008970

loc_00896c:
	move.w #$2b00,(a6)+

loc_008970:
	move.l a6,$101420
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_008978:
	dc.b 'MEMORY CARD LOAD',$ff

loc_008989:
	dc.b 'YES',$ff

loc_00898d:
	dc.b 'NO',$ff

loc_008990:
	dc.b 'DATA LOAD OK',$ff

loc_00899d:
	dc.b 'MEMORY CARD SAVE',$ff

loc_0089ae:
	dc.b 'DATA SAVE OK',$ff

loc_0089bb:
	dc.b 'LEVEL SELECT',$ff

loc_0089c8:
	dc.b 'EASY',$ff

loc_0089cd:
	dc.b 'NORMAL',$ff

loc_0089d4:
	dc.b 'HARD',$ff

loc_0089d9:
	dc.b 'MVS',$ff,$F6

;##############################################################################
loc_0089de:
	tst.w $10690a
	bne.w loc_008adc
	clr.w $106c3a
	move.b #1,BIOS_CARD_COMMAND
	move.w NGH_NUMBER.w,BIOS_CARD_FCB
	jsr CARD
	cmpi.b #$80,BIOS_CARD_ANSWER
	beq.w loc_008b70
	btst #0,BIOS_CARD_SUB2
	beq.w loc_008b70
	tst.b BIOS_CARD_ANSWER
	beq.b loc_008a3c
	move.b #0,BIOS_MESS_BUSY
	jsr CARD_ERROR
	tst.b BIOS_CARD_ANSWER
	bne.w loc_008b70

loc_008a3c:
	move.b #2,BIOS_CARD_COMMAND
	move.w NGH_NUMBER.w,BIOS_CARD_FCB
	clr.b BIOS_CARD_SUB
	move.l #$106b60,BIOS_CARD_START
	move.w #$1a,BIOS_CARD_SIZE
	bsr.w loc_008fd8
	jsr CARD
	tst.b BIOS_CARD_ANSWER
	bne.w loc_008b70
	lea.l $106b74,a0
	move.w (a0),d0
	move.w (2,a0),d1
	move.w d0,d2
	add.w d1,d2
	not.w d2
	cmp.w (4,a0),d2
	bne.w loc_008b70
	bset #3,$101000
	lea.l $1066ac,a0
	clr.w (a0)
	clr.w (2,a0)
	clr.w (4,a0)
	move.w #$a00,($a,a0)
	clr.w ($c,a0)
	jsr loc_006be6
	move.w #$800,d3
	jsr loc_00d976
	jsr loc_006ef2
	bset #0,$106986
	addq.w #1,$10690a
	bra.w loc_008bd4

loc_008adc:
	cmpi.w #1,$10690a
	bne.b loc_008b2e
	btst #0,$106986
	bne.w loc_008bd4
	lea.l loc_008978(pc),a1
	lea.l $708a.w,a2
	move.w #$3000,d0
	jsr loc_006f88
	lea.l loc_008989(pc),a1
	lea.l $724d.w,a2
	move.w #$4000,d0
	jsr loc_006f88
	lea.l $898d(pc),a1
	lea.l $7250.w,a2
	move.w #$4000,d0
	jsr loc_006f88
	addq.w #1,$10690a

loc_008b2e:
	cmpi.w #2,$10690a
	bne.w loc_008b70
	lea.l $1066ac,a0
	tst.w ($c,a0)
	bne.b loc_008b50
	bsr.w loc_008bd6
	bsr.w loc_008bf8
	bra.b loc_008b5c

loc_008b50:
	cmpi.w #$40,($c,a0)
	bcc.b loc_008b62
	addq.w #1,($c,a0)

loc_008b5c:
	bsr.w loc_008ce4
	bra.b loc_008bd4

loc_008b62:
	bset #1,$106986
	addq.w #1,$10690a

loc_008b70:
	btst #1,$106986
	bne.b loc_008bd4
	move.w #$15,$106986
	bclr #3,$101000
	move.w #1,$106908
	clr.w $10690a
	move.b #0,$103671
	clr.b $103673
	move.b #6,$103871
	clr.b $103873
	tst.w $101018
	bne.b loc_008bd4
	tst.w $101012
	bne.b loc_008bd4
	move.w #4,d7
	jsr loc_004554
	move.w d7,$101012

loc_008bd4:
	rts

;##############################################################################
loc_008bd6:
	tst.w ($c,a0)
	bne.b loc_008bf6
	tst.w ($a,a0)
	beq.b loc_008bf6
	subq.b #1,($b,a0)
	bcc.b loc_008bf6
	move.b #$3e,($b,a0)
	subq.b #1,($a,a0)
	bsr.w loc_008ffe

loc_008bf6:
	rts

;##############################################################################
loc_008bf8:
	lea.l player1mem,a1
	bsr.w loc_008c0e
	tst.w ($c,a0)
	bne.w loc_008cba
	lea.l (playeroffset,a1),a1

loc_008c0e:
	btst #7,($b8,a1)
	bne.w loc_008cba
	tst.w ($a,a0)
	beq.b loc_008c26
	cmpi.b #$10,($b0,a1)
	bne.b loc_008c6c

loc_008c26:
	move.w #1,($c,a0)
	tst.w (a0)
	beq.b loc_008c3a
	move.w #$fff,($c,a0)
	bra.w loc_008cba

loc_008c3a:
	move.w $106b74,$101012
	move.w $106b76,$101018
	lea.l loc_008990(pc),a1
	move.w #1,$106c3a
	lea.l $7114.w,a2
	move.w #$3000,d0
	jsr loc_006f88
	bra.w loc_008cba

loc_008c6c:
	cmpi.b #1,($b0,a1)
	bne.b loc_008c94
	tst.w (a0)
	beq.w loc_008cba
	subq.w #1,(a0)
	move.b #$c,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_008cba

loc_008c94:
	cmpi.b #2,($b0,a1)
	bne.b loc_008cba
	cmpi.w #1,(a0)
	bcc.b loc_008cba
	addq.w #1,(a0)
	move.b #$c,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_008cba:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_008cbc:
	dc.w $0080,$0188,$0080,$0170

loc_008cc4:
	dc.w $0074,$01a1,$0074,$0181
	dc.w $0074,$0161,$0074,$0141

loc_008cd4:
	dc.w $1201,$1202,$1203,$1204
	dc.w $1203,$1202,$1201,$ffff

;##############################################################################
loc_008ce4:
	lea.l $1066ac,a0
	lea.l loc_008cd4(pc),a1
	addq.w #1,(4,a0)
	cmpi.w #3,(4,a0)
	bcs.b loc_008d02
	clr.w (4,a0)
	addq.w #2,(2,a0)

loc_008d02:
	move.w (2,a0),d0
	move.w (a1,d0.w),d1
	cmpi.w #$ffff,d1
	bne.b loc_008d16
	clr.w (2,a0)
	move.w (a1),d1

loc_008d16:
	tst.w ($c,a0)
	beq.b loc_008d20
	move.w #$1201,d1

loc_008d20:
	swap d1
	move.w #$8000,d1
	swap d1
	movea.l $10141c,a6
	move.l d1,(a6)+
	move.w (a0),d0
	lsl.w #2,d0
	lea.l loc_008cbc(pc),a2
	cmpi.w #9,$106908
	bne.b loc_008d46
	lea.l loc_008cc4(pc),a2

loc_008d46:
	move.l (a2,d0.w),(a6)+
	move.l a6,$10141c
	rts

;##############################################################################
loc_008d52:
	tst.w $106986
	beq.b loc_008d64
	jsr loc_00d632
	bra.w loc_008e30

loc_008d64:
	bset #0,$10690a
	bne.w loc_008dfa
	move.b #1,BIOS_CARD_COMMAND
	move.w NGH_NUMBER.w,BIOS_CARD_FCB
	jsr CARD
	cmpi.b #$80,BIOS_CARD_ANSWER
	beq.w loc_008e22
	lea.l $1066ac,a0
	move.w #1,(a0)
	clr.w (2,a0)
	clr.w (4,a0)
	move.w #$a00,($a,a0)
	clr.w ($c,a0)
	bset #3,$101001
	jsr FIX_CLEAR
	bclr #3,$101001
	lea.l loc_00899d(pc),a1
	lea.l $708a.w,a2
	move.w #$3000,d0
	jsr loc_006f88
	lea.l loc_008989(pc),a1
	lea.l $724d.w,a2
	move.w #$4000,d0
	jsr loc_006f88
	lea.l loc_00898d(pc),a1
	lea.l $7250.w,a2
	move.w #$4000,d0
	jsr loc_006f88

loc_008dfa:
	lea.l $1066ac,a0
	tst.w ($c,a0)
	bne.b loc_008e10
	bsr.w loc_008bd6
	bsr.w loc_008e32
	bra.b loc_008e1c

loc_008e10:
	cmpi.w #$40,($c,a0)
	bcc.b loc_008e22
	addq.w #1,($c,a0)

loc_008e1c:
	bsr.w loc_008ce4
	bra.b loc_008e30

loc_008e22:
	move.w #5,$106908
	clr.w $10690a

loc_008e30:
	rts

;##############################################################################
loc_008e32:
	lea.l player1mem,a1
	bsr.w loc_008e48
	tst.w ($c,a0)
	bne.w loc_008ec8
	lea.l (playeroffset,a1),a1

loc_008e48:
	btst #7,($b8,a1)
	bne.w loc_008ec8
	tst.w ($a,a0)
	beq.b loc_008e60
	cmpi.b #$10,($b0,a1)
	bne.b loc_008e7a

loc_008e60:
	move.w #1,($c,a0)
	tst.w (a0)
	beq.b loc_008e72
	move.w #$fff,($c,a0)
	bra.b loc_008ec8

loc_008e72:
	bsr.w loc_008eca
	bra.w loc_008ec8

loc_008e7a:
	cmpi.b #1,($b0,a1)
	bne.b loc_008ea2
	tst.w (a0)
	beq.w loc_008ec8
	subq.w #1,(a0)
	move.b #$c,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_008ec8

loc_008ea2:
	cmpi.b #2,($b0,a1)
	bne.b loc_008ec8
	cmpi.w #1,(a0)
	bcc.b loc_008ec8
	addq.w #1,(a0)
	move.b #$c,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_008ec8:
	rts

;##############################################################################
loc_008eca:
	bsr.w loc_008f66
	jsr CARD
	move.b BIOS_CARD_ANSWER,d0
	bne.b loc_008ef2

loc_008edc:
	lea.l loc_0089ae(pc),a1
	lea.l $7114.w,a2
	move.w #$3000,d0
	jsr loc_006f88
	bra.w loc_008f64

loc_008ef2:
	cmpi.b #$84,d0
	beq.b loc_008f28
	jsr CARD_ERROR
	tst.b BIOS_CARD_ANSWER
	bne.b loc_008f64

loc_008f06:
	bsr.w loc_008f66
	jsr CARD
	tst.b BIOS_CARD_ANSWER
	beq.b loc_008edc
	jsr CARD_ERROR
	tst.b BIOS_CARD_ANSWER
	beq.b loc_008edc
	bra.b loc_008f64

loc_008f28:
	move.b #4,BIOS_CARD_COMMAND
	move.w NGH_NUMBER.w,BIOS_CARD_FCB
	clr.b BIOS_CARD_SUB
	jsr CARD
	tst.b BIOS_CARD_ANSWER
	beq.b loc_008f06
	cmpi.b #$82,BIOS_CARD_ANSWER
	beq.b loc_008f06
	jsr CARD_ERROR
	tst.b BIOS_CARD_ANSWER
	beq.b loc_008f06

loc_008f64:
	rts

;##############################################################################
loc_008f66:
	move.b #3,BIOS_CARD_COMMAND
	move.w NGH_NUMBER.w,BIOS_CARD_FCB
	clr.b BIOS_CARD_SUB
	move.l #$106b60,BIOS_CARD_START
	move.w #$1a,BIOS_CARD_SIZE
	move.w $101012,d0
	move.w $101018,d1
	move.w d1,d2
	add.w d0,d2
	not.w d2
	movem.w d0-d2,$106b74
	bsr.w loc_008fd8
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_008fae:
	dc.b "FIGHTER'S HISTORY   ",$ff

loc_008fc3:
	dc.b "KARNOV'S REVENGE   ",$ff,$52

;##############################################################################
loc_008fd8:
	lea.l loc_008fae(pc),a1
	cmpi.b #2,BIOS_COUNTRY_CODE
	bcs.b loc_008fea
	lea.l loc_008fc3(pc),a1

loc_008fea:
	lea.l $106b60,a2

loc_008ff0:
	move.b (a1)+,d0
	cmpi.b #$ff,d0
	beq.b loc_008ffc
	move.b d0,(a2)+
	bra.b loc_008ff0

loc_008ffc:
	rts

;##############################################################################
loc_008ffe:
	movea.l $101420,a6
	lea.l $7237.w,a2
	cmpi.w #9,$106908
	bne.b loc_009016
	lea.l $7239.w,a2

loc_009016:
	move.w a2,(a6)+
	move.w #$2354,(a6)+
	lea.l ($20,a2),a2
	move.w a2,(a6)+
	move.w #$2349,(a6)+
	lea.l ($20,a2),a2
	move.w a2,(a6)+
	move.w #$234d,(a6)+
	lea.l ($20,a2),a2
	move.w a2,(a6)+
	move.w #$2345,(a6)+
	lea.l ($20,a2),a2
	move.w a2,(a6)+
	move.w #$233a,(a6)+
	lea.l ($20,a2),a2
	move.w a2,(a6)+
	moveq #0,d0
	move.b ($a,a0),d0
	addi.w #$2330,d0
	move.w d0,(a6)+
	move.l a6,$101420
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00905e:
	dc.l loc_009086
	dc.l loc_00911e
	dc.l loc_00913a
	dc.l loc_009182
	dc.l loc_0091ea

;##############################################################################
loc_009072:
	lea.l $106908,a0
	moveq #0,d0
	move.b (2,a0),d0
	lsl.w #2,d0
	movea.l loc_00905e(pc,d0.w),a1
	jmp (a1)

;##############################################################################
loc_009086:
	move.b #1,(2,a0)
	jsr loc_006be6
	move.w #$800,d3
	jsr loc_00d976
	lea.l $1066ac,a0
	move.w #1,(a0)
	clr.w (2,a0)
	clr.w (4,a0)
	move.w #$a00,($a,a0)
	clr.w ($c,a0)
	bsr.w loc_0090be
	rts


;##############################################################################
loc_0090be:
	lea.l player1mem,a1
	move.b ($b8,a1),d0
	bclr #3,d0
	btst #7,d0
	bne.b loc_0090d6
	bset #3,d0

loc_0090d6:
	move.b d0,($b8,a1)
	move.b ($2b8,a1),d0
	bclr #3,d0
	btst #7,d0
	bne.b loc_0090ec
	bset #3,d0

loc_0090ec:
	move.b d0,($2b8,a1)
	rts

;##############################################################################
loc_0090f2:
	moveq #0,d0
	lea.l player1mem,a1
	btst #3,($b8,a1)
	beq.b loc_00910a
	cmpi.b #$10,($b0,a1)
	beq.b loc_00911a

loc_00910a:
	btst #3,($2b8,a1)
	beq.b loc_00911c
	cmpi.b #$10,($2b0,a1)
	bne.b loc_00911c

loc_00911a:
	moveq #1,d0

loc_00911c:
	rts

;##############################################################################
loc_00911e:
	addq.b #1,(3,a0)
	cmpi.b #2,(3,a0)
	bcs.b loc_009138
	move.b #2,(2,a0)
	bset #0,$106986

loc_009138:
	rts

;##############################################################################
loc_00913a:
	btst #0,$106986
	bne.w loc_009180
	move.b #3,(2,a0)
	lea.l loc_0089bb(pc),a1
	lea.l $7124.w,a2
	move.w #$3000,d0
	jsr loc_006f88
	lea.l loc_009208(pc),a0
	nop
	move.w #$4000,d0
	moveq #3,d7

loc_00916a:
	movea.l (a0)+,a2
	movea.l (a0)+,a1
	movem.l d7/a0,-(a7)
	jsr loc_006f88
	movem.l (a7)+,d7/a0
	dbra d7,loc_00916a

loc_009180:
	rts

;##############################################################################
loc_009182:
	lea.l $1066ac,a0
	tst.w ($c,a0)
	bne.b loc_009198
	bsr.w loc_008bd6
	bsr.w loc_00922c
	bra.b loc_0091e0

loc_009198:
	lea.l player1mem,a1
	btst #3,($b8,a1)
	beq.b loc_0091ae
	cmpi.b #$10,($b0,a1)
	beq.b loc_0091d0

loc_0091ae:
	lea.l (playeroffset,a1),a1
	btst #3,($b8,a1)
	beq.b loc_0091c2
	cmpi.b #$10,($b0,a1)
	beq.b loc_0091d0

loc_0091c2:
	cmpi.w #$40,($c,a0)
	bcc.b loc_0091d0
	addq.w #1,($c,a0)
	bra.b loc_0091e0

loc_0091d0:
	move.b #4,$10690a
	bset #1,$106986

loc_0091e0:
	bsr.w loc_008ce4
	bsr.w loc_009304
	rts

;##############################################################################
loc_0091ea:
	bsr.w loc_008ce4
	btst #1,$106986
	bne.b loc_009206
	move.w #0,$106908
	clr.w $10690a

loc_009206:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_009208:
	dc.l $0000720a,$000089c8
	dc.l $0000720e,$000089cd
	dc.l $00007212,$000089d4
	dc.l $00007216,$000089d9

loc_009228:
	dc.b $00,$03,$06,$04

;##############################################################################
loc_00922c:
	lea.l player1mem,a1
	bsr.w loc_009242
	tst.w ($c,a0)
	bne.w loc_0092da
	lea.l (playeroffset,a1),a1

loc_009242:
	btst #3,($b8,a1)
	beq.w loc_0092da
	tst.w ($a,a0)
	beq.b loc_00925a
	cmpi.b #$10,($b0,a1)
	bne.b loc_00928a

loc_00925a:
	move.w #1,($c,a0)
	move.w (a0),d0
	lea.l loc_009228(pc),a2
	move.b (a2,d0.w),GameDifficulty
	lea.l loc_009208(pc),a2
	lsl.w #3,d0
	movea.l (4,a2,d0.w),a1
	movea.l (a2,d0.w),a2
	move.w #$2000,d0
	jsr loc_006f88
	bra.w loc_0092da

loc_00928a:
	cmpi.b #1,($b0,a1)
	bne.b loc_0092b2
	subq.w #1,(a0)
	bcc.b loc_00929a
	move.w #3,(a0)

loc_00929a:
	move.b #$c,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_0092da

loc_0092b2:
	cmpi.b #2,($b0,a1)
	bne.b loc_0092da
	addq.w #1,(a0)
	move.b #$c,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	cmpi.w #4,(a0)
	bcs.b loc_0092da
	clr.w (a0)

loc_0092da:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0092dc:
	dc.b 'PUSH A BUTTON START',$ff

loc_0092f0:
	dc.b '                   ',$ff

;##############################################################################
loc_009304:
	move.b $10346b,d0
	andi.b #$3f,d0
	beq.b loc_00931e
	cmpi.b #$28,d0
	bne.w loc_009338
	lea.l loc_0092f0(pc),a2
	bra.b loc_009322

loc_00931e:
	lea.l loc_0092dc(pc),a2

loc_009322:
	movea.l $101420,a1
	lea.l $715b.w,a3
	jsr loc_00dffc
	move.l a1,$101420
 
loc_009338:
	rts

;##############################################################################
loc_00933a:
	bset #0,$10690a
	bne.b loc_009350
	clr.w $10690c
	jsr loc_0094e8(pc)
	nop

loc_009350:
	addq.w #1,$10690c
	cmpi.w #$2dc,$10690c
	bcs.b loc_009374
	move.b $101000,d0
	andi.b #3,d0
	bne.b loc_009374
	bsr.w loc_009612
	bra.w loc_009498

loc_009374:
	cmpi.w #$1a,$10690c
	bne.b loc_009382
	bsr.w loc_006c40

loc_009382:
	jsr loc_00456e
	jsr loc_004e4a
	move.b $1037bc,d0
	or.b $1039bc,d0
	bne.b loc_0093d0
	bclr #7,$101001
	addq.w #1,$10100e
	move.w $10100e,d0
	cmp.w $10346c,d0
	bcc.b loc_0093ca
	bset #7,$101001
	jsr loc_00c5aa
	bra.w loc_009418

loc_0093ca:
	clr.w $10100e

loc_0093d0:
	jsr loc_015bae
	jsr loc_00b0b4
	jsr loc_00a9c4
	jsr loc_00aa8c
	jsr loc_00a7aa
	jsr loc_00cc0c
	jsr loc_00a83e
	jsr loc_00ab58
	jsr loc_00ac9a
	jsr loc_009b68
	jsr loc_015bdc
	jsr loc_003abc

loc_009418:
	jsr loc_00480a
	cmpi.w #7,$10690c
	bcs.b loc_009434
	jsr loc_00d632
	jsr loc_007ac8

loc_009434:
	jsr loc_009d4a
	jsr loc_00ed68
	cmpi.b #7,$103a72
	beq.b loc_009450
	jsr loc_017c04

loc_009450:
	jsr loc_00e1fc
	jsr loc_00e250
	jsr loc_009c06
	jsr loc_004d52
	move.w stageid,d0
	lea.l loc_007620,a0
	add.w d0,d0
	move.w (a0,d0.w),d0
	cmpi.w #2,$10346c
	bcs.b loc_009492
	add.w d0,d0
	cmpi.w #3,$10346c
	bcs.b loc_009492
	add.w d0,d0

loc_009492:
	move.w d0,$106940

loc_009498:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00949a:
	dc.b $17,$18,$19,$1a,$1b,$1c,$1d,$1e,$1f,$20,$21,$22,$23

loc_0094a7:
	dc.b $0a,$0b,$0c,$0d,$0e,$0f,$10,$11,$12,$13,$14,$15,$16

;##############################################################################
loc_0094b4:
	move.w stageid,d0
	move.b loc_0094a7(pc,d0.w),d0
	cmpi.w #5,$10100c
	bne.b loc_0094ca
	moveq #9,d0

loc_0094ca:
	move.b d0,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054
	bclr #2,$101001
	rts

;##############################################################################
loc_0094e8:
	btst #0,$101000
	bne.b loc_0094fa
	bset #7,$103728

loc_0094fa:
	btst #1,$101000
	bne.b loc_00950c
	bset #7,$103928

loc_00950c:
	bsr.w loc_00976a
	cmpi.w #5,$10100c
	bne.b loc_009540
	lea.l player1mem,a0
	lea.l (playeroffset,a0),a1
	move.b #0,(7,a0)
	move.b #0,(7,a1)
	move.w #8,$106930
	move.w #0,stageid

loc_009540:
	jsr loc_004c02
	bset #1,$101001
	move.b $101000,d0
	andi.b #3,d0
	bne.b loc_00958c
	move.w #$15,$106986
	bset #7,$101000
	move.w #$b,d7
	jsr loc_004554
	move.w d7,stageid
	clr.w $10100c
	clr.b $103677
	clr.b $103877

loc_00958c:
	move.w $106940,LSPCMODE
	jsr loc_006be6;
	jsr loc_00aac0;Stage Render
	jsr loc_006c0c;
	jsr loc_00a96c;Ground Render
	jsr loc_00e88e;
	move.w #$6320,fighttimer
	move.b #1,$103a72
	clr.b $103a73
	clr.w $103a74
	rts

;##############################################################################
loc_0095d2:
;exstage write
	move.b rngread,d0
	andi.b #1,d0
	move.b d0,exstageflag
	jsr RandomNumberGen

	move.b $101000,d0
	andi.b #3,d0
	cmpi.b #3,d0
	bne.b notvsmode

;random stage code
RandomStageStart:
	jsr RandomNumberGen
	moveq #0,d0
	moveq #0,d1
	lea.l prevstageholder,a0
	move.b rngread,d0
	move.w prevstagevalue,d1
	andi.b #$1f,d0
	move.b Randomstagetable(pc,d0),d0
	cmpi.w #4,d1
	bne.b stagecheck
	moveq #0,d1
	clr.w prevstagevalue

stagecheck:
	cmp.b (a0),d0
	beq.b RandomStageStart
	cmp.b (1,a0),d0
	beq.b RandomStageStart
	cmp.b (2,a0),d0
	beq.b RandomStageStart
	cmp.b (3,a0),d0
	beq.b RandomStageStart;if this happens wtf

	move.b d0,(a0,d1)
	ext.w d0
	move.w d0,stageid
	addq #1,prevstagevalue

	bra.b loc_009610

;Original Code
;	addq.w #1,vsstagecounter
;	cmpi.w #$d,vsstagecounter
;	bcs.b loc_0095f8
;	clr.w vsstagecounter

;loc_0095f8:
;	move.w vsstagecounter,stageid
;	bra.b loc_009610

notvsmode:
	jsr loc_006cd8
	move.w d2,stageid

loc_009610:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
Randomstagetable:
	dc.b $00,$00,$01,$01,$02,$02,$03,$03
	dc.b $04,$04,$05,$05,$06,$06,$07,$07
	dc.b $08,$08,$09,$09,$0a,$0a,$0b,$0b
	dc.b $0c,$0c
	dc.b $0c,$0b,$06,$04,$09,$0a


;##############################################################################
loc_009612:
	move.w #2,mainmode
	clr.w $101004
	clr.w $106908
	clr.w $10690a
	clr.w $10690e
	clr.w $106910
	move.w #1,$10346c
	move.b #$15,$1068c6
	jsr loc_00ded2
	jsr loc_006ef2
	rts

;##############################################################################
loc_009656:
	bset #0,$101004
	bne.b loc_0096ae
	jsr loc_006ef2
	clr.w $101006
	jsr loc_006be6
	bset #3,$101001
	jsr FIX_CLEAR
	bclr #3,$101001
	move.w #$900,d3
	jsr loc_00d976
	jsr loc_0131a4
	move.b #7,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054

loc_0096ae:
	cmpi.w #8,mainmode
	bne.b loc_0096c4
	move.b BIOS_STATCURNT,d0
	andi.b #5,d0
	bne.b loc_00971a

loc_0096c4:
	addq.w #1,$101006
	cmpi.w #$f8,$101006
	bcc.b loc_00971a
	movea.l $10141c,a0
	lea.l scoreboard,a1
	move.l #$f001b0,d1
	moveq #4,d7

loc_0096e8:
	move.l #$80000e2a,d0
	add.w (8,a1),d0
	move.l d0,(a0)+
	move.l d1,(a0)+
	subi.w #$20,d1
	adda.w #$10,a1
	dbra d7,loc_0096e8
	move.l a0,$10141c
	cmpi.w #8,mainmode
	beq.b loc_009768
	jsr loc_007ac8
	bra.b loc_009768

loc_00971a:
	move.w mainmode,d0
	move.w #$ff,mainmode
	clr.w $101004
	clr.w $106908
	clr.w $10690a
	clr.w $10690e
	clr.w $106910
	cmpi.w #8,d0
	bne.b loc_009768
	clr.b BIOS_PLAYER1_MODE
	clr.b BIOS_PLAYER2_MODE
	move.b #1,BIOS_USER_MODE
	move.w #$ff,mainmode

loc_009768:
	rts

;##############################################################################
loc_00976a:
	move.b $101000,d0
	andi.b #3,d0
	bne.b loc_0097b4
	clr.w $10100c
	lea.l player1mem,a0
	move.w #$d,d7
	jsr loc_004554
	move.b d7,(1,a0)
	move.w #$d,d7
	jsr loc_004554
	move.b d7,($201,a0)
	cmp.b (1,a0),d7
	bne.b loc_0097b4
	clr.b (3,a0)
	move.b #1,($203,a0)
	jsr loc_00d5f4

loc_0097b4:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0097b6:
	dc.w $c790,$c7ac,$c7c8,$c7e4,$ffff

loc_0097c0:
	dc.w $5fa0,$5fbc,$5fd8,$ffff

;##############################################################################
loc_0097c8:
	move.b $101000,d0
	andi.b #3,d0
	bne.b loc_009802
	movea.l $101420,a0
	lea.l loc_0097b6(pc),a1
	lea.l $7315.w,a2
	cmpi.b #1,BIOS_COUNTRY_CODE
	bls.b loc_0097f4
	lea.l loc_0097c0(pc),a1
	lea.l $7316.w,a2

loc_0097f4:
	move.w (a1)+,d0
	cmpi.w #$ffff,d0
	beq.b loc_009802
	bsr.w loc_00980a
	bra.b loc_0097f4

loc_009802:
	move.l a0,$101420
	rts

;##############################################################################
loc_00980a:
	moveq #6,d7
	movea.l a2,a3

loc_00980e
	move.w a3,(a0)+
	move.w d0,(a0)+
	addq.w #1,d0
	lea.l (1,a3),a3
	move.w a3,(a0)+
	move.w d0,(a0)+
	addq.w #1,d0
	lea.l (-$21,a3),a3
	move.w a3,(a0)+
	move.w d0,(a0)+
	addq.w #1,d0
	lea.l (1,a3),a3
	move.w a3,(a0)+
	move.w d0,(a0)+
	lea.l ($5f,a3),a3
	addq.w #1,d0
	dbra d7,loc_00980e
	lea.l (2,a2),a2
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_009840:
;HERE COMES A 
; CHALLENGER 
	dc.w $2444,$2438,$246c,$2438,$031c
	dc.w $2430,$2460,$2458,$2438,$2470,$031c
	dc.w $2428,$031c,$fffe

	dc.w $031c
	dc.w $2430,$2444,$2428,$2454,$2454,$2438,$245c,$2440,$2438,$246c
	dc.w $031c,$ffff

OldChallenge:
;GET READY FOR
; A NEW RIVAL
	dc.w $2440,$2438,$2474,$031c
	dc.w $246c,$2438,$2428,$2434,$2488,$031c
	dc.w $243c,$2460,$246c
	dc.w $fffe

	dc.w $031c,$2428,$031c
	dc.w $245c,$2438,$2480,$031c
	dc.w $246c,$2448,$247c,$2428,$2454
	dc.w $ffff

KarnovemberMess:
; KARNOVEMBER 
;  IS  HERE   
;	dc.w $031c
;	dc.w $3450,$3428,$346c,$345c,$3460,$347c,$3438,$3458,$342c,$3438,$346c
;	dc.w $031c
;	dc.w $fffe
;	dc.w $031c,$031c
;	dc.w $3448,$3470,$031c,$031c
;	dc.w $2444,$2438,$246c,$2438,$031c,$031c
;	dc.w $ffff

loc_009876:
	dc.l loc_00988a
	dc.l loc_0098a0
	dc.l loc_00997a
	dc.l loc_0099cc
	dc.l loc_0099e2

;##############################################################################
loc_00988a:
	rts

;##############################################################################
loc_00988c:
	lea.l $10698a,a0
	move.w $10698a,d0
	lsl.w #2,d0
	movea.l loc_009876(pc,d0.w),a2
	jmp (a2)

;##############################################################################
loc_0098a0:
	move.w $106908,d0
	beq.b loc_009902
	cmpi.w #9,d0
	beq.b loc_009902
	cmpi.w #1,d0
	bne.b loc_009910
	btst #4,$101000
	beq.b loc_009910
	lea.l player1mem,a0
	cmpi.b #4,(4,a0)
	bne.b loc_0098d8
	lea.l (playeroffset,a0),a0
	cmpi.b #4,(4,a0)
	beq.b loc_0098e6

loc_0098d8:
	move.b ($b8,a0),d0
	movea.l ($14,a0),a0
	btst #1,d0
	bne.b loc_009910

loc_0098e6:
	move.b #$99,$106732
	bsr.w loc_009a86
	jsr loc_00d412
	clr.w $10698a
	bra.w loc_009978

loc_009902:
	bsr.w loc_009a86
	clr.w $10698a
	bra.w loc_009978

loc_009910:
	cmpi.w #3,$106908
	bne.b loc_00992e
	lea.l player1mem,a0
	move.b ($b8,a0),d0
	or.b ($2b8,a0),d0
	btst #7,d0
	bne.b loc_009938

loc_00992e:
	cmpi.w #4,$106908
	bne.b loc_009944

loc_009938:
	move.w #4,$10698a
	bra.w loc_009978

loc_009944:
	lea.l $10698a,a0
	move.b #$31,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054

;	cmpi.b #$11,BIOS_MONTH
;	beq.b NovemberMessage

	move.b rngread,d0
	andi.b #1,d0
	beq Challengemsg2

	move.l #loc_009840,(4,a0)
	move.w #$70ee,(8,a0)
	move.w #$fffe,(2,a0)
	move.w #2,(a0)
	bra.b loc_009978

NovemberMessage:
	move.l #KarnovemberMess,(4,a0)
	move.w #$70ee,(8,a0)
	move.w #$fffe,(2,a0)
	move.w #2,(a0)
	bra.b loc_009978

Challengemsg2:
	move.l #OldChallenge,(4,a0)
	move.w #$70ee,(8,a0)
	move.w #$fffe,(2,a0)
	move.w #2,(a0)

loc_009978:
	rts

;##############################################################################
loc_00997a:
	addq.w #1,(2,a0)
	cmpi.w #5,(2,a0)
	bcs.b loc_0099ca
	clr.w (2,a0)
	movea.w (8,a0),a2
	movea.l (4,a0),a1
	move.w (a1)+,d2
	cmpi.w #$ffff,d2
	bne.b loc_0099a4
	move.w #3,(a0)
	clr.w (2,a0)
	bra.b loc_0099ca

loc_0099a4:
	cmpi.w #$fffe,d2
	bne.b loc_0099b0
	movea.w #$70f1,a2
	bra.b loc_0099c2

loc_0099b0:
	movea.l $101420,a6
	jsr loc_006f5c
	move.l a6,$101420

loc_0099c2:
	move.w a2,(8,a0)
	move.l a1,(4,a0)

loc_0099ca:
	rts

;##############################################################################
loc_0099cc:
	addq.w #1,(2,a0)
	cmpi.w #$40,(2,a0)
	bcs.b loc_0099e0
	move.w #4,(a0)
	clr.w (2,a0)

loc_0099e0:
	rts

;##############################################################################
loc_0099e2:
	jsr loc_00d654
	cmpi.w #$16,$106986
	bcs.w loc_009a84
	cmpi.w #3,$106908
	beq.b loc_009a00
	bra.b loc_009a56

loc_009a00:
	jsr loc_006d2c
	btst #0,$101000
	bne.b loc_009a2e
	lea.l player1mem,a0
	btst #7,($b8,a0)
	bne.b loc_009a2e
	move.b #2,(4,a0)
	clr.b ($b,a0)
	bset #7,($b8,a0)

loc_009a2e:
	btst #1,$101000
	bne.b loc_009a56
	lea.l player2mem,a0
	btst #7,($b8,a0)
	bne.b loc_009a56
	move.b #2,(4,a0)
	clr.b ($b,a0)
	bset #7,($b8,a0)

loc_009a56:
	move.w #1,$106908
	clr.w $10690a
	clr.w $10690e
	clr.w $106910
	bset #4,$101000
	clr.w $10698a
	jsr loc_009a86(pc)
	nop

loc_009a84:
	rts

;##############################################################################
loc_009a86:
	lea.l player1mem,a0
	bsr.w loc_009a9a
	lea.l (playeroffset,a0),a0
	bsr.w loc_009a9a
	rts

;##############################################################################
loc_009a9a:
	cmpi.b #4,(4,a0)
	bne.b loc_009ade
	jsr loc_006eec
	move.b (a0),d0
	bset d0,$101000
	clr.b (3,a0)
	move.b #1,(4,a0)

	tst.b BIOS_GAMEDIP_10
	bne.b ifevent
	clr.b (6,a0)

ifevent:
	move.b (2,a0),(1,a0)
	andi.b #$7d,($b8,a0)
	btst #2,($b8,a0)
	bne.b loc_009ade
	clr.b (5,a0)
	clr.b (8,a0)
	clr.l ($c,a0)

loc_009ade:
	rts

;##############################################################################
loc_009ae0:
	movea.l $101420,a0
	move.w #$5ec0,d0
	move.w #$817b,d1
	move.w #$837b,d2
	move.w #$857b,d3
	move.w d0,(a0)+
	move.w #$b616,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	move.w #$e00,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	move.w #$b617,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	move.w #$e00,(a0)+
	move.w d1,(a0)+
	move.w #$fff,(a0)+
	move.w d2,(a0)+
	move.w #$f182,(a0)+
	move.w d3,(a0)+
	move.w #$4800,(a0)+
	addi.w #$3d,d0
	addq.w #1,d1
	addq.w #1,d2
	addq.w #1,d3
	move.w d0,(a0)+
	move.w #$b616,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	move.w #$e00,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	move.w #$b617,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	move.w #$e00,(a0)+
	move.w d1,(a0)+
	move.w #$fff,(a0)+
	move.w d2,(a0)+
	move.w #$f182,(a0)+
	move.w d3,(a0)+
	move.w #$5000,(a0)+
	move.l a0,$101420
	rts

;##############################################################################
loc_009b68:
	moveq #0,d1
	move.b fighttimer,d1
	cmpi.b #$64,d1
	bcs.b loc_009b7a
	move.b #$63,d1

loc_009b7a:
	jsr loc_0044ca
	move.w d2,d6
	movea.l $101420,a0
	move.w #$5ec0,d0
	move.w #$b604,d2
	move.w #$e00,d3
	btst #6,$101000
	bne.b loc_009bb6
	cmpi.b #$16,d6
	bcc.b loc_009bb6
	tst.b d6
	beq.b loc_009bb6
	btst #2,$10346b
	beq.b loc_009bb6
	move.w #$100,d3

loc_009bb6:
	move.w d0,(a0)+
	move.w d6,d1
	lsr.w #4,d1
	andi.w #$f,d1
	add.w d1,d1
	add.w d2,d1
	move.w d1,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	move.w d3,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	addq.w #1,d1
	move.w d1,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	move.w d3,(a0)+
	addi.w #$3d,d0
	move.w d0,(a0)+
	andi.w #$f,d6
	add.w d6,d6
	add.w d2,d6
	move.w d6,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	move.w d3,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	addq.w #1,d6
	move.w d6,(a0)+
	addq.w #1,d0
	move.w d0,(a0)+
	move.w d3,(a0)+
	move.l a0,$101420
	rts

;##############################################################################
loc_009c06:
	lea.l player1mem,a0
	btst #0,$10346b
	bne.b loc_009c1a
	lea.l (playeroffset,a0),a0

loc_009c1a:
	lea.l loc_037000+$10,a1
	lea.l $ca.w,a4
	lea.l loc_090020,a6
	movea.l $101420,a5
	bsr.w loc_009c54

loc_009c34:
	cmpa.w #$d0,a4
	bcc.b loc_009c4c
	movea.l a4,a3
	adda.l #$8201,a3
	move.w a3,(a5)+
	clr.w (a5)+
	lea.l (1,a4),a4
	bra.b loc_009c34

loc_009c4c:
	move.l a5,$101420
	rts

;##############################################################################
loc_009c54:
	cmpi.b #$d,(1,a0)
	bne.b loc_009c70
	cmpi.b #1,$103a72
	bne.b loc_009c70
	cmpi.w #$100,($c4,a0)
	bcc.w loc_009cc4

loc_009c70:
	move.w ($c0,a0),d0
	move.w ($20,a0),d1
	andi.w #$ff,d1
	swap d1
	move.w ($22,a0),d2
	mulu.w #$30,d2
	lea.l (a1,d2.l),a1
	moveq #0,d2
	move.b (2,a1),d2
	move.b (3,a1),d3
	ext.w d3
	addi.w #$130,d2
	move.w d2,d1
	btst #$10,d1
	beq.b loc_009ca4
	neg.w d3

loc_009ca4:
	add.w d3,d0
	sub.w $103424,d0
	swap d0
	move.w #$120,d0
	sub.w $103428,d0
	sub.w $106928,d0
	jsr loc_00ad16

loc_009cc4:
	rts

;##############################################################################
loc_009cc6:
	bset #3,$101001
	lea.l VRAMADDR,a6
	btst #0,$10669a
	bne.b loc_009cec
	lea.l $0082d1,a0
	lea.l $008311,a1
	bra.b loc_009cf8

loc_009cec:
	lea.l $82d1,a1
	lea.l $8311,a0

loc_009cf8:
	moveq #$f,d7
	lea.l $1065f0,a2
	move.w #1,(4,a6)
	move.w a0,(a6)
	nop

loc_009d0a:
	move.w (a2)+,(2,a6)
	move.w (a2)+,(2,a6)
	move.w (a2)+,(2,a6)
	move.w (a2)+,(2,a6)
	dbra d7,loc_009d0a
	moveq #$f,d7
	move.w a1,(a6)
	moveq #0,d0

loc_009d24:
	move.w d0,(2,a6)
	nop
	move.w d0,(2,a6)
	nop
	move.w d0,(2,a6)
	nop
	move.w d0,(2,a6)
	nop
	dbra d7,loc_009d24
	bclr #3,$101001
	rts

;##############################################################################
loc_009d4a:
	movea.l $10141c,a1
	lea.l $103424,a2
	lea.l loc_037000+$10,a3
	lea.l player1mem,a0
	bsr.w loc_009daa
	lea.l player2mem,a0
	bsr.w loc_009daa
	move.l a1,$10141c
	rts

;##############################################################################
loc_009d78:
	movea.l $10141c,a1
	btst #4,$1036a0
	beq.b loc_009da2
	move.l #$c000000a,(a1)+
	move.w $103730,d0
	sub.w $103424,d0
	swap d0
	move.w #$180,d0
	move.l d0,(a1)+

loc_009da2:
	move.l a1,$10141c
	rts

;##############################################################################
loc_009daa:
	move.w (a2),d7
	tst.b ($14c,a0)
	beq.b loc_009ddc
	btst #3,($bf,a0)
	bne.b loc_009ddc
	cmpi.b #3,($145,a0)
	beq.b loc_009ddc
	move.w $10346a,d0
	andi.w #1,d0
	nop
	btst #0,($bd,a0)
	beq.b loc_009dda
	sub.w d0,d7
	bra.b loc_009ddc

loc_009dda:
	add.w d0,d7

loc_009ddc:
	move.b ($21,a0),d0
	lsl.w #8,d0
	move.w ($22,a0),d1
	mulu.w #$30,d1
	lea.l (a3,d1.l),a4
	move.w d0,d1
	ori.w #$1400,d1
	or.b ($20,a0),d1
	move.w d1,(a1)+
	move.w (a4),(a1)+
	move.w ($c0,a0),d2
	sub.w d7,d2
	move.w d2,(a1)+
	move.w ($c4,a0),d2
	addi.w #$120,d2
	sub.w (4,a2),d2
	sub.w $106928,d2
	move.w d2,(a1)+
	btst #1,($bf,a0)
	beq.b loc_009e92
	move.w ($2c,a4),d2
	tst.w d2
	beq.b loc_009e92
	move.w d0,d1
	cmpi.b #$ff,($14a,a0)
	bne.b loc_009e54
	btst #6,$101000
	bne.b loc_009e54
	btst #1,$10346b
	bne.b loc_009e54
	andi.w #$ff00,d1
	ori.w #1,d1
	ori.w #$1c00,d1
	bra.b loc_009e5c

loc_009e54:
	ori.w #$1c00,d1
	or.b ($20,a0),d1

loc_009e5c:
	move.w d1,(a1)+
	move.w d2,(a1)+
	move.b ($2e,a4),d2
	ext.w d2
	btst #8,d1
	beq.b loc_009e6e
	neg.w d2

loc_009e6e:
	add.w ($c0,a0),d2
	sub.w d7,d2
	move.w d2,(a1)+
	move.b ($2f,a4),d2
	ext.w d2
	neg.w d2
	add.w ($c4,a0),d2
	addi.w #$120,d2
	sub.w (4,a2),d2
	sub.w $106928,d2
	move.w d2,(a1)+

loc_009e92:
	rts

;##############################################################################
;Obj Gen control
loc_009e94:
	jmp $24000

;##############################################################################
;Movement and attack editor
loc_009e9a:
	jsr loc_00e024
	movea.l $101420,a5
	bset #0,$1066ae
	bne.b loc_009ede
	clr.w $1066b2
	bsr.w loc_00a364
	bsr.w loc_009fb6
	bsr.w loc_00a044
	bsr.w loc_00a082
	bsr.w loc_00a742
	clr.w $1066b0
	clr.w $1066b8
	move.w #$3000,d6
	bsr.w loc_00a6a0

loc_009ede:
	bsr.w loc_00a0e8
	btst #7,($b6,a0)
	beq.b loc_009ef6
	bsr.w loc_00a706
	bclr #0,$101001

loc_009ef6:
	move.l a5,$101420
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_009efe:
	dc.b "CHR. NO.",$fe,$fe

loc_009f08:
	dc.b "WALK F.   .",$fe
	dc.b "WALK B.   .",$fe
	dc.b "JUMP DH   .",$fe
	dc.b "JUMP DV   .",$fe
	dc.b "JUMP G.   .",$fe
	dc.b "BACK DH   .",$fe
	dc.b "BACK DV   .",$fe
	dc.b "BACK G.   .",$fe,$fe

loc_009f69:
	dc.b "WAZA NO.",$fe,$fe
	dc.b "  HI/LO",$fe
	dc.b "  KIND",$fe
	dc.b "  HP",$fe
	dc.b "  SOUND",$fe
	dc.b "  SCORE",$fe
	dc.b "  SHAKE",$fe
	dc.b "  SLIDE",$fe,$fe

loc_009fa8:
	dc.b "$64000-$64C3F",$ff

;##############################################################################
loc_009fb6:
	move.w #$2000,d6
	bset #3,$101001
	lea.l VRAMADDR,a6
	lea.l loc_009efe(pc),a1
	lea.l $72c7.w,a2

loc_009fd0:
	movea.l a2,a3
	move.w a3,(a6)
	move.w #$20,(4,a6)

loc_009fda:
	moveq #0,d0
	move.b (a1)+,d0
	cmpi.w #$fe,d0
	bne.b loc_009fea
	lea.l (1,a2),a2
	bra.b loc_009fd0

loc_009fea:
	cmpi.w #$ff,d0
	beq.b loc_009ffa
	addi.w #$2300,d0
	move.w d0,(2,a6)
	bra.b loc_009fda

loc_009ffa:
	bclr #3,$101001
	rts

;##############################################################################
loc_00a004:
	move.l d0,d1
	lsl.l #8,d1
	rol.l #4,d1
	bsr.w loc_00a026
	rol.l #4,d1
	bsr.w loc_00a026
	lea.l ($20,a1),a1
	rol.l #4,d1
	bsr.w loc_00a026
	rol.l #4,d1
	bsr.w loc_00a026
	rts

;##############################################################################
loc_00a026:
	move.w d1,d2
	andi.w #$f,d2
	addi.w #$330,d2
	cmpi.w #$33a,d2
	bcs.b loc_00a038
	addq.w #7,d2

loc_00a038:
	move.w a1,(a5)+
	add.w d6,d2
	move.w d2,(a5)+
	lea.l ($20,a1),a1
	rts

;##############################################################################
;Name Render
loc_00a044:
	lea.l $73e7.w,a1
	moveq #0,d1
	move.b $103671,d1
	bsr.b loc_00a026
	moveq #0,d1
	move.b $103671,d1
	lsl.w #4,d1
	lea.l asciinames,a2
	lea.l (a2,d1.w),a2
	moveq #9,d7
	lea.l $72e8.w,a1

loc_00a06c:
	move.w a1,(a5)+
	moveq #0,d1
	move.b (a2)+,d1
	addi.w #$4300,d1
	move.w d1,(a5)+
	lea.l ($20,a1),a1
	dbra d7,loc_00a06c
	rts

;##############################################################################
loc_00a082:
	lea.l $73f2.w,a1
	move.w $1066b2,d1
	lsr.w #4,d1
	bsr.b loc_00a026
	move.w $1066b2,d1
	bsr.b loc_00a026
	move.w $1066b2,d2
	lsl.w #4,d2
	lea.l loc_01da2e,a2
	lea.l (a2,d2.w),a2
	moveq #$f,d7
	lea.l $72f3.w,a1

loc_00a0b0:
	move.w a1,(a5)+
	moveq #0,d1
	move.b (a2)+,d1
	addi.w #$4300,d1
	move.w d1,(a5)+
	lea.l ($20,a1),a1
	dbra d7,loc_00a0b0
	rts

;##############################################################################
loc_00a0c6:
	move.w $1066b0,d1
	subq.w #1,d1
	move.w d1,d2
	lsl.w #2,d1
	lea.l $1066bc,a2
	move.l (a2,d1.w),d0
	lea.l $73c9.w,a1
	adda.w d2,a1
	bsr.w loc_00a004
	rts

;##############################################################################
loc_00a0e8:
	move.b ($b6,a0),d0
	move.b d0,d1
	moveq #3,d7
	moveq #0,d2

loc_00a0f2:
	lsr.b #1,d1
	bcc.b loc_00a0f8
	addq.w #1,d2

loc_00a0f8:
	dbra d7,loc_00a0f2
	cmpi.w #2,d2
	bcc.w loc_00a2e8
	move.b d0,d1
	andi.b #3,d1
	beq.w loc_00a172
	movem.w d0-d1,-(a7)
	move.w #$2000,d6
	move.w $1066b8,d2
	move.w #$ffff,$1066b8
	movem.w d2,-(a7)
	bsr.w loc_00a6a0
	movem.w (a7)+,d2
	move.w d2,$1066b8
	movem.w (a7)+,d0-d1
	btst #0,d1
	beq.b loc_00a156
	subq.w #1,$1066b0
	bcc.w loc_00a2dc
	move.w #$11,$1066b0
	bra.w loc_00a2dc

loc_00a156:
	addq.w #1,$1066b0
	cmpi.w #$11,$1066b0
	bls.w loc_00a2dc
	clr.w $1066b0
	bra.w loc_00a2dc

loc_00a172:
	tst.w $1066b0
	bne.w loc_00a1c8
	btst #3,d0
	beq.b loc_00a19e
	addq.b #1,$103671
	cmpi.b #$d,$103671
	bls.w loc_00a1b8
	clr.b $103671
	bra.w loc_00a1b8

loc_00a19e:
	btst #2,d0
	beq.w loc_00a2e8
	subq.b #1,$103671
	bcc.w loc_00a1b8
	move.b #$d,$103671

loc_00a1b8:
	bsr.w loc_00a364
	bsr.w loc_00a742
	bsr.w loc_00a78a
	bra.w loc_00a2dc

loc_00a1c8:
	cmpi.w #9,$1066b0
	bne.b loc_00a210
	move.w $1066b2,d1
	btst #3,d0
	beq.b loc_00a1ea
	addq.w #1,d1
	cmpi.w #$30,d1
	bcs.b loc_00a1fa
	clr.w d1
	bra.b loc_00a1fa

loc_00a1ea:
	btst #2,d0
	beq.w loc_00a2e8
	subq.w #1,d1
	bcc.b loc_00a1fa
	move.w #$2f,d1

loc_00a1fa:
	move.w d1,$1066b2
	bsr.w loc_00a364
	move.w #$2000,d6
	bsr.w loc_00a742
	bra.w loc_00a2dc

loc_00a210:
	bcc.b loc_00a290
	move.b d0,d1
	andi.b #$3c,d1
	beq.w loc_00a2e8
	move.w $1066b0,d1
	subq.w #1,d1
	lsl.w #2,d1
	lea.l $1066bc,a1
	btst #4,d0
	beq.b loc_00a246
	addi.l #$10000,(a1,d1.w)
	andi.l #$ffff00,(a1,d1.w)
	bra.w loc_00a2dc

loc_00a246:
	btst #5,d0
	beq.b loc_00a260
	subi.l #$10000,(a1,d1.w)
	andi.l #$ffff00,(a1,d1.w)
	bra.w loc_00a2dc

loc_00a260:
	btst #3,d0
	beq.b loc_00a278
	addi.l #$100,(a1,d1.w)
	andi.l #$ffff00,(a1,d1.w)
	bra.b loc_00a2dc

loc_00a278:
	btst #2,d0
	beq.b loc_00a2e8
	subi.l #$100,(a1,d1.w)
	andi.l #$ffff00,(a1,d1.w)
	bra.b loc_00a2dc

loc_00a290:
	cmpi.w #$11,$1066b0
	bne.b loc_00a2d8
	btst #4,d0
	beq.b loc_00a2e8
	bsr.w loc_00a380
	move.w #$2000,d6
	bsr.w loc_00a6a0
	addq.w #1,$1066b2
	cmpi.w #$30,$1066b2
	bcs.b loc_00a2c2
	clr.w $1066b2

loc_00a2c2:
	bsr.w loc_00a364
	move.w #$3000,d6
	bsr.w loc_00a742
	move.w #9,$1066b0
	bra.b loc_00a2dc

loc_00a2d8:
	bsr.w loc_00a306

loc_00a2dc:
	move.w #$3000,d6
	bsr.w loc_00a6a0
	bra.w loc_00a2e8

loc_00a2e8:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00a2ea:
	dc.l loc_00a3cc
	dc.l loc_00a40a
	dc.l loc_00a486
	dc.l loc_00a4c8
	dc.l loc_00a4f6
	dc.l loc_00a61c
	dc.l loc_00a65e

;##############################################################################
loc_00a306:
	move.w $1066b0,d1
	subi.w #$a,d1
	lsl.w #2,d1
	lea.l loc_00a2ea(pc),a1
	movea.l (a1,d1.w),a1
	move.l $1066b4,d1
	jsr (a1)
	move.l d1,$1066b4
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00a32a:
	dc.l loc_00a3de
	dc.l loc_00a448
	dc.l loc_00a4aa
	dc.l loc_00a4dc
	dc.l loc_00a5da
	dc.l loc_00a646
	dc.l loc_00a688

;##############################################################################
loc_00a346:
	move.w $1066b0,d2
	subi.w #$a,d2
	lsl.w #2,d2
	lea.l loc_00a32a(pc),a1
	movea.l (a1,d2.w),a1
	move.l $1066b4,d1
	jsr (a1)
	rts

;##############################################################################
loc_00a364:
	bsr.w loc_00a39c
	lea.l $1066ac,a4
	move.l (a2),(8,a4)
	moveq #7,d7
	lea.l ($10,a4),a4

loc_00a378:
	move.l (a3)+,(a4)+
	dbra d7,loc_00a378
	rts

;##############################################################################
loc_00a380:
	bsr.w loc_00a39c
	lea.l $1066ac,a4
	move.l (8,a4),(a2)
	moveq #7,d7
	lea.l ($10,a4),a4

loc_00a394:
	move.l (a4)+,(a3)+
	dbra d7,loc_00a394
	rts

;##############################################################################
loc_00a39c:
	moveq #0,d1
	move.b $103671,d1
	move.w d1,d3
	mulu.w #$c0,d1
	move.w $1066b2,d2
	lsl.w #2,d2
	add.w d2,d1
	lea.l loc_0641c0,a2
	lea.l (a2,d1.w),a2
	lsl.w #5,d3
	lea.l loc_064000,a3
	lea.l (a3,d3.w),a3
	rts

;##############################################################################
loc_00a3cc:
	move.b d0,d2
	andi.b #$c,d2
	beq.b loc_00a3d8
	bchg #$f,d1

loc_00a3d8:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00a3da:
	dc.b "LO"

loc_00a3dc:
	dc.b "HI"

;##############################################################################
loc_00a3de:
	lea.l $7434.w,a1
	lea.l loc_00a3da(pc),a2
	btst #$f,d1
	beq.b loc_00a3f0
	lea.l loc_00a3dc(pc),a2

loc_00a3f0:
	moveq #1,d7

loc_00a3f2:
	moveq #0,d2
	move.b (a2)+,d2
	addi.w #$300,d2
	add.w d6,d2
	move.w a1,(a5)+
	move.w d2,(a5)+
	lea.l ($20,a1),a1
	dbra d7,loc_00a3f2
	rts

;##############################################################################
loc_00a40a:
	move.w $1066b8,d2
	btst #2,d0
	beq.b loc_00a422
	addq.w #1,d2
	cmpi.w #5,d2
	bls.b loc_00a42e
	moveq #0,d2
	bra.b loc_00a42e

loc_00a422:
	btst #3,d0
	beq.b loc_00a434
	subq.w #1,d2
	bcc.b loc_00a42e
	moveq #5,d2

loc_00a42e:
	move.w d2,$1066b8

loc_00a434:
	btst #4,d0
	beq.b loc_00a440
	addi.w #$10,d2
	bchg d2,d1

loc_00a440:
	rts

;##############################################################################
loc_00a442:
	not.w (a2)
	subq.w #1,a3
	addq.w #2,(a3)

;##############################################################################
loc_00a448:
	lea.l $73b5.w,a1
	moveq #5,d7
	moveq #$15,d3
	lea.l loc_00a442(pc),a2

loc_00a454:
	moveq #0,d2
	move.b (a2)+,d2
	btst d3,d1
	bne.b loc_00a460
	move.b #$2d,d2

loc_00a460:
	move.w a1,(a5)+
	addi.w #$300,d2
	cmp.w $1066b8,d7
	bne.b loc_00a474
	addi.w #$3000,d2
	bra.b loc_00a478

loc_00a474:
	addi.w #$2000,d2

loc_00a478:
	move.w d2,(a5)+
	lea.l ($20,a1),a1
	subq.w #1,d3
	dbra d7,loc_00a454
	rts

;##############################################################################
loc_00a486:
	move.w d1,d2
	andi.w #$80ff,d1
	lsr.w #8,d2
	btst #3,d0
	beq.b loc_00a498
	addq.w #1,d2
	bra.b loc_00a4a0

loc_00a498:
	btst #2,d0
	beq.b loc_00a4a0
	subq.w #1,d2

loc_00a4a0:
	andi.w #$7f,d2
	lsl.w #8,d2
	or.w d2,d1
	rts

;##############################################################################
loc_00a4aa:
	lea.l $7436.w,a1
	movem.l d1,-(a7)
	andi.w #$7f00,d1
	rol.w #4,d1
	bsr.w loc_00a026
	rol.w #4,d1
	bsr.w loc_00a026
	movem.l (a7)+,d1
	rts

;##############################################################################
loc_00a4c8:
	btst #3,d0
	beq.b loc_00a4d2
	addq.b #1,d1
	bra.b loc_00a4da

loc_00a4d2:
	btst #2,d0
	beq.b loc_00a4da
	subq.b #1,d1

loc_00a4da:
	rts

;##############################################################################
loc_00a4dc:
	lea.l $7437.w,a1
	movem.l d1,-(a7)
	ror.l #4,d1
	bsr.w loc_00a026
	rol.l #4,d1
	bsr.w loc_00a026
	movem.l (a7)+,d1
	rts

;##############################################################################
loc_00a4f6:
	move.l d1,d2
	andi.l #$f03fffff,d1
	swap d2
	lsr.w #6,d2
	btst #3,d0
	beq.b loc_00a50c
	addq.w #1,d2
	bra.b loc_00a514

loc_00a50c:
	btst #2,d0
	beq.b loc_00a514
	subq.w #1,d2

loc_00a514:
	andi.l #$3f,d2
	lsl.w #6,d2
	swap d2
	or.l d2,d1
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00a522:
	dc.l $00000000,$00000032
	dc.l $00000064,$00000096
	dc.l $000000c8,$000000fa
	dc.l $0000012c,$0000015e
	dc.l $00000190,$000001c2
	dc.l $000001f4,$00000226
	dc.l $00000258,$0000028a
	dc.l $000002bc,$000002ee
	dc.l $00000320,$00000352
	dc.l $00000384,$000003b6
	dc.l $000003e8,$0000044c
	dc.l $000004b0,$00000514
	dc.l $00000578,$000005dc
	dc.l $00000640,$000006a4
	dc.l $00000708,$0000076c
	dc.l $000007d0,$000009c4
	dc.l $00000bb8,$00000dac
	dc.l $00000fa0,$00001194
	dc.l $00001388,$0000157c
	dc.l $00001770,$00001964
	dc.l $00001b58,$00001d4c
	dc.l $00001f40,$00002134
	dc.l $00002328,$0000251c

;##############################################################################
loc_00a5da:
	movem.l d1,-(a7)
	swap d1
	lsr.w #6,d1
	andi.w #$3f,d1
	lsl.w #2,d1
	lea.l loc_00a522(pc),a1
	move.l (a1,d1.w),d1
	jsr loc_0044ca
	movea.l a5,a2
	lea.l $73f8.w,a3
	moveq #3,d7
	move.l d2,d1
	swap d1
	movem.w d6,-(a7)
	move.w d6,d3
	moveq #1,d6
	jsr loc_00446a
	movem.w (a7)+,d6
	movea.l a2,a5
	movem.l (a7)+,d1
	rts

;##############################################################################
loc_00a61c:
	move.l d1,d2
	bclr #$1c,d1
	bclr #$1d,d1
	rol.l #4,d2
	btst #3,d0
	beq.b loc_00a632
	addq.w #1,d2
	bra.b loc_00a63a

loc_00a632:
	btst #2,d0
	beq.b loc_00a63a
	subq.w #1,d2

loc_00a63a:
	andi.l #3,d2
	ror.l #4,d2
	or.l d2,d1
	rts

;##############################################################################
loc_00a646:
	lea.l $7459.w,a1
	movem.l d1,-(a7)
	rol.l #4,d1
	andi.w #3,d1
	bsr.w loc_00a026
	movem.l (a7)+,d1
	rts

;##############################################################################
loc_00a65e:
	move.l d1,d2
	bclr #$1e,d1
	bclr #$1f,d1
	rol.l #2,d2
	btst #3,d0
	beq.b loc_00a674
	addq.w #1,d2
	bra.b loc_00a67c

loc_00a674
	btst #2,d0
	beq.b loc_00a67c
	subq.w #1,d2

loc_00a67c:
	andi.l #3,d2
	ror.l #2,d2
	or.l d2,d1
	rts

;##############################################################################
loc_00a688:
	lea.l $745a.w,a1
	movem.l d1,-(a7)
	rol.l #2,d1
	andi.w #3,d1
	bsr.w loc_00a026
	movem.l (a7)+,d1
	rts

;##############################################################################
loc_00a6a0:
	tst.w $1066b0
	bne.b loc_00a6ae
	bsr.w loc_00a044
	bra.b loc_00a6da

loc_00a6ae:
	cmpi.w #9,$1066b0
	bne.b loc_00a6be
	bsr.w loc_00a082
	bra.b loc_00a6da

loc_00a6be:
	bcc.b loc_00a6c6
	bsr.w loc_00a0c6
	bra.b loc_00a6da

loc_00a6c6:
	cmpi.w #$11,$1066b0
	bcc.b loc_00a6d6
	bsr.w loc_00a346
	bra.b loc_00a6da

loc_00a6d6:
	bsr.w loc_00a6e2

loc_00a6da:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00a6dc:
	dc.b 'WRITE',$ff

;##############################################################################
loc_00a6e2:
	lea.l $72db.w,a2
	lea.l loc_00a6dc(pc),a3

loc_00a6ea:
	moveq #0,d2
	move.b (a3)+,d2
	cmpi.b #$ff,d2
	beq.b loc_00a704
	addi.w #$300,d2
	add.w d6,d2
	move.w a2,(a5)+
	move.w d2,(a5)+
	lea.l ($20,a2),a2
	bra.b loc_00a6ea

loc_00a704:
	rts

;##############################################################################
loc_00a706:
	bset #3,$101001
	lea.l VRAMADDR,a6
	lea.l $72c7.w,a1
	move.w #$ff,d0
	moveq #$f,d7

loc_00a71e:
	moveq #$15,d6
	move.w #1,(4,a6)
	move.w a1,(a6)

loc_00a728:
	move.w d0,(2,a6)
	dbra d6,loc_00a728
	lea.l ($20,a1),a1
	dbra d7,loc_00a71e
	bclr #3,$101001
	rts

;##############################################################################
loc_00a742:
	move.w $1066b0,d2
	move.w $1066b8,d3
	movem.w d2-d3,-(a7)
	clr.w $1066b0
	move.w #$ffff,$1066b8
	move.w #$2000,d6

loc_00a764:
	bsr.w loc_00a6a0
	addq.w #1,$1066b0
	cmpi.w #$11,$1066b0
	bls.b loc_00a764
	movem.w (a7)+,d2-d3
	move.w d2,$1066b0
	move.w d3,$1066b8
	rts

;##############################################################################
loc_00a78a:
	lea.l player1mem,a2
	moveq #0,d2
	move.b (1,a2),d2
	mulu.w #$60,d2
	move.w d2,($d2,a2)
	clr.w ($d0,a2)
	bclr #0,($bf,a2)
	rts

;##############################################################################
loc_00a7aa:
	lea.l loc_007308,a0
	move.w stageid,d0
	lsl.w #3,d0
	move.w d0,d1
	add.w d0,d0
	add.w d1,d0
	lea.l (a0,d0.w),a0
	movea.l a0,a2
	lea.l $103424,a1
	move.l (8,a1),d1
	bsr.w loc_00a7da
	move.l ($c,a1),d1
	lea.l (4,a1),a1

loc_00a7da:
	moveq #0,d6
	tst.l d1
	bne.b loc_00a7e8
	moveq #0,d2
	moveq #0,d3
	moveq #0,d4
	bra.b loc_00a810

loc_00a7e8:
	bpl.b loc_00a7ee
	neg.l d1
	moveq #1,d6

loc_00a7ee:
	movem.l (a2)+,d2-d4
	swap d1
	lsr.l #8,d2
	lsr.l #8,d3
	lsr.l #8,d4
	mulu.w d1,d2
	mulu.w d1,d3
	mulu.w d1,d4
	lsl.l #8,d2
	lsl.l #8,d3
	lsl.l #8,d4
	tst.w d6
	beq.b loc_00a810
	neg.l d2
	neg.l d3
	neg.l d4

loc_00a810:
	move.l d2,($18,a1)
	move.l d3,($28,a1)
	move.l d4,($38,a1)
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00a81e:
	dc.l $30000
	dc.l $30000
	dc.l $30000
	dc.l $30000
	dc.l $30000
	dc.l $30000
	dc.l $30000
	dc.l $40000

;##############################################################################
loc_00a83e:
	lea.l $103424,a0
	move.l (a0),d0
	add.l (8,a0),d0
	move.l d0,(a0)
	move.l (4,a0),d1
	add.l ($c,a0),d1
	move.l d1,(4,a0)
	move.w (8,a0),$10693c
	cmpi.w #4,stageid
	bne.b loc_00a88c
	move.l ($10,a0),d0
	subi.l #$1000000,d0
	addi.l #$1000,d0
	andi.l #$ffffff,d0
	addi.l #$1000000,d0
	move.l d0,($10,a0)
	bra.b loc_00a898

loc_00a88c:
	move.l ($10,a0),d0
	add.l ($18,a0),d0
	move.l d0,($10,a0)

loc_00a898:
	move.l ($14,a0),d0
	add.l ($1c,a0),d0
	move.l d0,($14,a0)
	move.l ($20,a0),d0
	add.l ($28,a0),d0
	move.l d0,($20,a0)
	move.l ($24,a0),d0
	add.l ($2c,a0),d0
	move.l d0,($24,a0)
	cmpi.w #2,stageid
	bne.w loc_00a952
	tst.w $10100c
	beq.w loc_00a952
	move.l ($30,a0),d0
	add.l ($28,a0),d0
	lea.l $10669c,a2
	move.b (a2),d1
	move.w LSPCMODE,d3
	move.b d3,(a2)
	andi.b #7,(a2)
	cmp.b (a2),d1
	beq.b loc_00a8f6
	clr.b (1,a2)

loc_00a8f6:
	addq.b #1,(1,a2)
	cmpi.b #4,(1,a2)
	bne.b loc_00a91e
	lea.l loc_00a81e(pc),a1
	andi.w #7,d1
	lsl.w #2,d1
	move.l (a1,d1.w),d2
	btst #7,$101001
	beq.b loc_00a91c
	asr.l #1,d2

loc_00a91c:
	sub.l d2,d0

loc_00a91e:
	move.l d0,($30,a0)
	cmpi.l #$1400000,d0
	bcc.b loc_00a932
	addi.l #$1400000,d0
	bra.b loc_00a940

loc_00a932:
	cmpi.l #$2800000,d0
	bls.b loc_00a940
	subi.l #$1400000,d0

loc_00a940:
	move.l d0,($30,a0)
	move.l ($34,a0),d0
	add.l ($3c,a0),d0
	move.l d0,($34,a0)
	bra.b loc_00a96a

loc_00a952:
	move.l ($30,a0),d0
	add.l ($38,a0),d0
	move.l d0,($30,a0)
	move.l ($34,a0),d0
	add.l ($3c,a0),d0
	move.l d0,($34,a0)

loc_00a96a:
	rts

;##############################################################################
loc_00a96c:
	bset #3,$101001
	lea.l VRAMADDR,a6
	lea.l $8201,a0
	lea.l loc_007440,a1
	move.w stageid,d0
	lsl.w #2,d0
	move.w (2,a1,d0.w),d0
	move.w d0,d1
	lsr.w #4,d1
	addi.w #$f7,d0
	lsl.w #7,d0
	or.w d1,d0
	move.w a0,(a6)
	move.w d0,(2,a6)
	moveq #$1e,d7
	lea.l (1,a0),a0
	moveq #$40,d0

loc_00a9ac:
	move.w a0,(a6)
	move.w d0,(2,a6)
	lea.l (1,a0),a0
	dbra d7,loc_00a9ac
	bclr #3,$101001
	rts

;##############################################################################
loc_00a9c4:
	bset #3,$101001
	move.w $103424,d0
	subi.w #$180,d0
	bpl.b loc_00a9da
	moveq #0,d0

loc_00a9da:
	lsr.w #4,d0
	cmpi.w #$10,d0
	bcs.b loc_00a9e4
	moveq #$10,d0

loc_00a9e4:
	move.w d0,$10693e
	move.w stageid,d1
	lsl.w #2,d1
	lea.l loc_007440,a2
	move.w (a2,d1.w),d2
	move.w (2,a2,d1.w),d1
	lsl.w #2,d2
	lea.l loc_090020,a1
	movea.l (a1,d2.w),a1
	lea.l (2,a1),a1

loc_00aa10:
	tst.w d0
	beq.b loc_00aa26
	move.w (a1)+,d2
	andi.w #$3f,d2
	lsl.w #2,d2
	addq.w #4,d2
	lea.l (a1,d2.w),a1
	subq.w #1,d0
	bra.b loc_00aa10

loc_00aa26:
	lea.l VRAMADDR,a6
	move.w #$8201,(a6)
	nop
	move.w (2,a6),d5
	move.w d5,d4
	andi.w #$ffe0,d4
	move.w #$8201,(a6)
	nop
	move.w d4,(2,a6)
	lea.l $40.w,a0
	move.w #1,(4,a6)
	moveq #$1f,d7

loc_00aa52:
	move.w a0,(a6)
	move.w (a1)+,d6
	andi.w #$3f,d6
	subq.w #1,d6

loc_00aa5c:
	movem.w (a1)+,d0-d1
	move.w d0,(2,a6)
	move.w d1,(2,a6)
	dbra d6,loc_00aa5c
	lea.l (4,a1),a1
	lea.l ($40,a0),a0
	dbra d7,loc_00aa52
	move.w #$8201,(a6)
	nop
	move.w d5,(2,a6)
	bclr #3,$101001
	rts

;##############################################################################
loc_00aa8c:
	lea.l $103424,a0
	move.l (a0),d0
	move.l d0,d1
	add.l (8,a0),d0
	move.l #$1400000,d4
	move.l #$2800000,d5
	cmp.l d4,d0
	bcc.b loc_00aab2
	sub.l d1,d4
	move.l d4,(8,a0)
	bra.b loc_00aabe

loc_00aab2:
	cmp.l d5,d0
	bls.w loc_00aabe
	sub.l d1,d5
	move.l d5,(8,a0)

loc_00aabe:
	rts

;##############################################################################
;BG1 Layer 1
loc_00aac0:
	move.w stageid,d0
	mulu.w #6,d0
	lea.l loc_007544,a0
	tst.w $10100c
	beq.b loc_00aade
	lea.l loc_007592,a0

loc_00aade:
	lea.l (a0,d0.w),a0
	lea.l $840.w,a5
	lea.l VRAMADDR,a6
	bsr.w loc_00ab02
	bsr.w loc_00ab02
	bsr.w loc_00ab02
	bsr.w loc_00ac26
	bsr.w loc_00ab58
	rts

;##############################################################################
loc_00ab02:
	bset #3,$101001
	move.w (a0)+,d0
	tst.w d0
	beq.b loc_00ab4e
	move.w #1,(4,a6)
	lea.l loc_090020,a1
	movea.l (a1,d0.w),a1
	move.w (a1)+,d7
	andi.w #$ff,d7
	subq.w #1,d7

loc_00ab28:
	move.w a5,(a6)
	move.w (a1)+,d0
	andi.w #$3f,d0
	subq.w #1,d0

loc_00ab32:
	movem.w (a1)+,d1-d2
	move.w d1,(2,a6)
	move.w d2,(2,a6)
	dbra d0,loc_00ab32
	lea.l (4,a1),a1
	lea.l ($40,a5),a5
	dbra d7,loc_00ab28

loc_00ab4e:
	bclr #3,$101001
	rts

;##############################################################################
loc_00ab58:
	move.w stageid,d0
	mulu.w #6,d0
	lea.l loc_007544,a0
	tst.w $10100c
	beq.b loc_00ab76
	lea.l loc_007592,a0

loc_00ab76:
	lea.l (a0,d0.w),a0
	lea.l $103434,a1
	lea.l $1062ac,a2
	lea.l $1063ce,a3
	clr.w (a2)
	clr.w (a3)
	moveq #2,d6
	bsr.w loc_00aba0
	bsr.w loc_00aba0
	bsr.w loc_00aba0
	rts

;##############################################################################
loc_00aba0:
	lea.l loc_090020,a4
	move.w (a0)+,d0
	tst.w d0
	beq.b loc_00ac20
	movea.l (a4,d0.w),a4
	move.w (a1),d0
	move.w (4,a1),d1
	add.w $106928,d1
	move.w (a4)+,d7
	andi.w #$ff,d7
	add.w d7,(a2)
	add.w d7,(a3)
	subq.w #1,d7

loc_00abc8:
	move.w (a4)+,d2
	andi.w #$3f,d2
	move.w d2,d3
	lsl.w #2,d3
	lea.l (a4,d3.w),a4
	move.w (2,a4),d3
	addi.w #$280,d3
	sub.w d0,d3
	cmpi.w #$fff0,d3
	bcc.b loc_00abec
	cmpi.w #$140,d3
	bcc.b loc_00ac0e

loc_00abec:
	andi.w #$1ff,d3
	lsl.w #7,d3
	move.w d3,(a3,d6.w)
	move.w (a4),d4
	not.w d4
	sub.w d1,d4
	addi.w #$100,d4
	andi.w #$1ff,d4
	lsl.w #7,d4
	or.w d2,d4
	move.w d4,(a2,d6.w)
	bra.b loc_00ac16

loc_00ac0e:
	clr.w (a2,d6.w)
	clr.w (a3,d6.w)

loc_00ac16:
	addq.w #2,d6
	lea.l (4,a4),a4
	dbra d7,loc_00abc8

loc_00ac20:
	lea.l ($10,a1),a1
	rts

;##############################################################################
loc_00ac26:
	lea.l loc_007474,a0
	move.w stageid,d0
	lsl.w #4,d0
	adda.w d0,a0
	moveq #3,d7
	moveq #0,d6
	lea.l $103424,a1

loc_00ac40:
	move.w (a0)+,(a1)+
	move.w d6,(a1)+
	move.w (a0)+,(a1)+
	move.w d6,(a1)+
	move.l d6,(a1)+
	move.l d6,(a1)+
	dbra d7,loc_00ac40
	move.w #$c000,d0
	move.w #$7f,d7
	lea.l $103470,a0

loc_00ac5e:
	move.w d0,(a0)+
	dbra d7,loc_00ac5e
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00ac66:
	dc.l loc_0076cc
	dc.l loc_0076cc
	dc.l loc_0076cc
	dc.l loc_0076cc
	dc.l loc_0076cc
	dc.l loc_0076cc
	dc.l loc_0076cc
	dc.l loc_0076cc
	dc.l loc_0076cc
	dc.l loc_0076cc
	dc.l loc_0076cc
	dc.l loc_0076cc
	dc.l loc_0076cc

;##############################################################################
loc_00ac9a:
	move.w $10693c,d6
	neg.w d6

loc_00aca2:
	lea.l $103470,a0
	move.w stageid,d7
	lsl.w #2,d7
	movea.l loc_00ac66(pc,d7.w),a1
	moveq #$1b,d7
	tst.w d6
	beq.b loc_00ace4
	bpl.b loc_00acd0

loc_00acbc:
	movem.w (a1)+,d0-d3
	sub.w d0,(a0)+
	sub.w d1,(a0)+
	sub.w d2,(a0)+
	sub.w d3,(a0)+
	dbra d7,loc_00acbc
	addq.w #1,d6
	bra.b loc_00aca2

loc_00acd0:
	movem.w (a1)+,d0-d3
	add.w d0,(a0)+
	add.w d1,(a0)+
	add.w d2,(a0)+
	add.w d3,(a0)+
	dbra d7,loc_00acd0
	subq.w #1,d6
	bra.b loc_00aca2

loc_00ace4:
	move.w $10693e,d5
	subq.w #6,d5
	lsl.w #4,d5
	lsl.w #7,d5
	lea.l $103470,a0
	lea.l $103570,a1
	move.w #$1f,d7

loc_00ad00:
	movem.w (a0)+,d0-d3
	movem.w d0-d3,(a1)
	add.w d5,(a1)+
	add.w d5,(a1)+
	add.w d5,(a1)+
	add.w d5,(a1)+
	dbra d7,loc_00ad00
	rts

;##############################################################################
loc_00ad16:
	lsl.w #2,d1
	movea.l (a6,d1.w),a3
	swap d1
	move.w (a3)+,d7
	andi.w #$ff,d7
	beq.w loc_00adc0
	move.w d7,$10346e
	subq.w #1,d7
	move.w a4,d2
	lsl.w #6,d2
	addi.w #$40,d2
	movea.w d2,a1

loc_00ad3a:
	movea.w a1,a2
	move.l (a3)+,d2
	move.l d2,d3
	swap d3
	andi.w #$3f,d3
	move.w d3,d6
	subq.w #1,d6
	movea.w d6,a0
	move.w (a3)+,d4
	move.w d1,d5
	eor.b d5,d4
	andi.b #1,d4
	andi.w #$ff00,d5
	beq.b loc_00ad62
	andi.w #$ff,d4
	or.w d5,d4

loc_00ad62:
	move.w a0,d6

loc_00ad64:
	move.w a2,(a5)+
	lea.l (1,a2),a2
	move.w d2,(a5)+
	addq.w #1,d2
	move.w a2,(a5)+
	lea.l (1,a2),a2
	move.w d4,(a5)+
	dbra d6,loc_00ad64
	move.w d0,d2
	move.w (a3)+,d5
	neg.w d5
	add.w d5,d2
	lsl.w #7,d2
	or.w d3,d2
	move.w #$8201,d5
	lea.l (a4,d5.w),a2
	move.w a2,(a5)+
	move.w d2,(a5)+
	move.l d0,d2
	swap d2
	move.w (a3)+,d5
	btst #0,d1
	beq.b loc_00ada4
	addi.w #$10,d5
	neg.w d5

loc_00ada4:
	add.w d5,d2
	lsl.w #7,d2
	move.w #$8401,d5
	lea.l (a4,d5.w),a2
	move.w a2,(a5)+
	move.w d2,(a5)+
	lea.l ($40,a1),a1
	lea.l (1,a4),a4
	dbra d7,loc_00ad3a

loc_00adc0:
	rts

;##############################################################################
loc_00adc2:
	move.w $10346e,d1
	cmp.w d0,d1
	bcc.b loc_00ade8
	move.w d1,d2
	sub.w d1,d0
	subq.w #1,d0
	lea.l $8201,a0
	adda.w a4,a0
	moveq #0,d2

loc_00addc:
	move.w a0,(a5)+
	move.w d2,(a5)+
	lea.l (1,a0),a0
	dbra d0,loc_00addc

loc_00ade8:
	rts

;##############################################################################
loc_00adea:
	bset #3,$101001
	move.w $10698a,d0
	beq.b loc_00ae0e
	cmpi.w #1,d0
	bne.w loc_00af7c
	btst #6,$101000
	beq.w loc_00af7c

loc_00ae0e:
	lea.l $10101c,a0
	movea.l $10141c,a1
	cmpa.l #$101024,a1
	beq.b loc_00ae6c
	cmpa.l a0,a1
	bne.b loc_00ae30
	lea.l $1065f0,a1
	bra.w loc_00af60

loc_00ae30:
	lea.l (-8,a1),a1

loc_00ae34:
	moveq #0,d2
	movea.l a0,a3

loc_00ae38:
	move.w (a3),d4
	move.w (8,a3),d5
	cmp.w d4,d5
	bcc.b loc_00ae58
	movem.l (a3),d6-d7
	move.l (8,a3),(a3)
	move.l ($c,a3),(4,a3)
	movem.l d6-d7,(8,a3)
	moveq #1,d2

loc_00ae58:
	lea.l (8,a3),a3
	cmpa.l a1,a3
	bcs.b loc_00ae38
	tst.w d2
	beq.b loc_00ae6c
	lea.l (-8,a1),a1
	cmpa.l a1,a0
	bcs.b loc_00ae34

loc_00ae6c:
	lea.l VRAMADDR,a6
	lea.l $10101c,a0
	lea.l $1065f0,a1
	btst #0,$10669a
	beq.b loc_00ae94
	lea.l $3440.w,a2
	lea.l $84d1,a3
	bra.b loc_00ae9e

loc_00ae94:
	lea.l $4440.w,a2
	lea.l $8511,a3

loc_00ae9e:
	movea.l $10141c,a4
	cmpa.l a4,a0
	bcc.w loc_00af60
	move.w (2,a0),d0
	lea.l loc_090020,a4
	lsl.w #2,d0
	movea.l (a4,d0.w),a4
	move.w (a4)+,d7
	andi.w #$ff,d7
	subq.w #1,d7
	move.w (a0),d0

loc_00aec4:
	move.w (a4)+,d6
	andi.w #$1f,d6
	move.w d6,(a1)
	subq.w #1,d6
	movem.w (a4)+,d1-d2
	btst #8,d0
	beq.b loc_00aedc
	bchg #0,d2

loc_00aedc:
	move.w d0,d3
	andi.w #$ff,d3
	beq.b loc_00af08
	cmpi.w #1,d3
	beq.b loc_00af00
	cmpi.w #$8000,d2
	bcc.b loc_00af08
	cmpi.w #$4000,d2
	bcs.b loc_00af08
	lsl.w #8,d3
	subi.w #$4000,d2
	add.w d3,d2
	bra.b loc_00af08

loc_00af00:
	andi.w #$ff,d2
	lsl.w #8,d3
	or.w d3,d2

loc_00af08:
	move.w #1,(4,a6)
	move.w a2,(a6)
 
loc_00af10:
	move.w d1,(2,a6)
	addq.w #1,d1
	btst #1,d2
	beq.b loc_00af1e
	subq.w #2,d1

loc_00af1e:
	move.w d2,(2,a6)
	dbra d6,loc_00af10
	lea.l ($40,a2),a2
	movem.w (a4)+,d3-d4
	btst #8,d0
	beq.b loc_00af3a
	addi.w #$10,d4
	neg.w d4

loc_00af3a:
	add.w (4,a0),d4
	move.w a3,(a6)
	lea.l (1,a3),a3
	lsl.w #7,d4
	move.w d4,(2,a6)
	neg.w d3
	add.w (6,a0),d3
	lsl.w #7,d3
	or.w d3,(a1)+
	dbra d7,loc_00aec4
	lea.l (8,a0),a0
	bra.w loc_00ae9e

loc_00af60:
	move.l a1,d0
	move.l #$106670,d7
	sub.l d0,d7
	lsr.w #1,d7
	subq.w #1,d7
	moveq #0,d0

loc_00af70:
	move.w d0,(a1)+
	dbra d7,loc_00af70
	addq.b #1,$10669a

loc_00af7c:
	bclr #3,$101001
	rts

;##############################################################################
loc_00af86:
	movea.l $10692c,a0
	move.w #$ffff,(a0)
	lea.l $5ac0.w,a1
	lea.l $816b,a2
	lea.l $836b,a3
	lea.l $856b,a4
	lea.l $10699e,a5
	movea.l $101420,a6

loc_00afb2:
	moveq #0,d0
	move.w (a5),d0
	cmpi.w #$ffff,d0
	beq.w loc_00b056
	lea.l loc_090020,a0
	lsl.l #2,d0
	movea.l (a0,d0.l),a0
	move.w (a0)+,d7
	andi.w #$ff,d7
	movem.w d7,-(a7)
	subq.w #2,d7
	bsr.w loc_00b072
	move.w a2,(a6)+
	lea.l (1,a2),a2
	move.w (2,a5),d1
	move.w d1,(a6)+
	move.w d1,d2
	lsr.w #8,d2
	andi.w #$1ff,d0
	mulu.w d0,d2
	lsr.w #4,d2
	neg.w d2
	add.w (8,a5),d2
	move.w a4,(a6)+
	lsl.w #7,d2
	move.w d2,(a6)+
	andi.w #$ff,d1
	mulu.w (6,a5),d1
	lsr.w #8,d1
	add.w ($a,a5),d1
	move.w a3,(a6)+
	lea.l (1,a3),a3
	lsl.w #7,d1
	or.w d4,d1
	move.w d1,(a6)+
	bset #6,d1
	lea.l (4,a0),a0

loc_00b020:
	movem.w d1,-(a7)
	bsr.w loc_00b072
	lea.l (4,a0),a0
	movem.w (a7)+,d1
	move.w a3,(a6)+
	lea.l (1,a3),a3
	move.w d1,(a6)+
	move.w a2,(a6)+
	move.w (2,a5),(a6)+
	lea.l (1,a2),a2
	dbra d7,loc_00b020
	movem.w (a7)+,d7
	lea.l (a4,d7.w),a4
	lea.l ($c,a5),a5
	bra.w loc_00afb2

loc_00b056:
	move.w #$8000,d0
	move.w a3,d1

loc_00b05c:
	cmpi.w #$837b,d1
	bcc.b loc_00b06a
	move.w d1,(a6)+
	move.w d0,(a6)+
	addq.w #1,d1
	bra.b loc_00b05c

loc_00b06a:
	move.l a6,$101420
	rts

;##############################################################################
loc_00b072:
	move.w (a0)+,d6
	move.w d6,d4
	andi.w #$1f,d6
	move.w d6,d5
	subi.w #$20,d5
	neg.w d5
	subq.w #1,d6
	move.w (a0)+,d3
	move.w (4,a5),d0
	move.w d0,d1
	rol.w #2,d1
	andi.w #3,d1
	move.w (a0)+,d2
	eor.w d1,d2

loc_00b096:
	move.w a1,(a6)+
	move.w d3,(a6)+
	addq.w #1,d3
	lea.l (1,a1),a1
	move.w a1,(a6)+
	move.w d2,(a6)+
	lea.l (1,a1),a1
	dbra d6,loc_00b096
	add.w d5,d5
	lea.l (a1,d5.w),a1
	rts

;##############################################################################
loc_00b0b4:
	lea.l player1mem,a0
	btst #7,($b8,a0)
	beq.b loc_00b0c8
	lea.l player2mem,a0

loc_00b0c8:
	bsr.w loc_00b140
	lea.l player2mem,a0
	btst #7,$103728
	beq.b loc_00b0e2
	lea.l player1mem,a0

loc_00b0e2:
	bsr.w loc_00b140
	jsr loc_00cace
	jsr loc_00c75a
	jsr loc_00c5c8
	jsr loc_00c6b2
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00b100:
	dc.l $00000000,$00000002,$0000fffe,$00000000
	dc.l $fffe0000,$fffe0002,$fffefffe,$00000000
	dc.l $00020000,$00020002,$0002fffe,$00000000
	dc.l $00000000,$00000000,$00000000,$00000000

;##############################################################################
loc_00b140:
	jsr loc_00ca5a
	jsr loc_00c43e
	tst.b ($14b,a0)
	beq.b loc_00b162
	move.w $10346a,d0
	andi.w #3,d0
	bne.b loc_00b162
	subq.b #1,($14b,a0)

loc_00b162:
	tst.b ($14e,a0)
	beq.b loc_00b16c
	subq.b #1,($14e,a0)

loc_00b16c:
	tst.b ($14c,a0)
	beq.b loc_00b176
	subq.b #1,($14c,a0)

loc_00b176:
	tst.b ($14d,a0)
	beq.b loc_00b188
	subq.b #1,($14d,a0)
	bne.b loc_00b188
	move.b #8,($14e,a0)

loc_00b188:
	movea.l ($14,a0),a1
	tst.b ($14c,a1)
	beq.b loc_00b1aa
	btst #2,($146,a1)
	beq.w loc_00b1fa
	btst #6,$101000
	bne.w loc_00b1fa
	bra.b loc_00b1b2

loc_00b1aa:
	tst.b ($14c,a0)
	bne.w loc_00b1fa

loc_00b1b2:
	btst #3,($bf,a0)
	bne.b loc_00b1c4
	moveq #0,d0
	move.l d0,($c8,a0)
	move.l d0,($cc,a0)

loc_00b1c4:
	move.w ($d0,a0),d0
	lea.l loc_00b8f6,a1
	lsl.w #2,d0
	movea.l (a1,d0.w),a1
	jsr (a1)
	tst.w ($d0,a0)
	bne.b loc_00b1e2
	andi.b #$fc,($bc,a0)

loc_00b1e2:
	jsr loc_00c90e
	move.l ($c8,a0),d0
	add.l d0,($c0,a0)
	move.l ($cc,a0),d0
	add.l d0,($c4,a0)
	bra.b loc_00b200

loc_00b1fa:
	jsr loc_00c9c0

loc_00b200:
	rts

;##############################################################################
loc_00b202:
	lea.l loc_05a000,a1
	move.w ($120,a0),d0
	add.w d0,d0
	adda.w (a1,d0.w),a1
	moveq #0,d0
	move.b ($122,a0),d0
	cmpi.b #$ff,d0
	bne.b loc_00b22a
	clr.b ($122,a0)
	move.b #1,($123,a0)
	bra.b loc_00b25a

loc_00b22a:
	addq.b #1,($123,a0)
	move.b ($123,a0),d1
	cmp.b (2,a1,d0.w),d1
	bcs.b loc_00b26a
	move.b (3,a1,d0.w),d1
	move.b d1,d2
	andi.w #$f0,d2
	beq.b loc_00b250
	lsr.w #4,d2
	subq.w #1,d2
	lsl.w #2,d2
	move.b d2,($122,a0)
	bra.b loc_00b25a

loc_00b250:
	btst #0,d1
	bne.b loc_00b26e
	addq.b #4,($122,a0)

loc_00b25a:
	moveq #0,d1
	move.b ($122,a0),d1
	move.w (a1,d1.w),($22,a0)
	clr.b ($123,a0)

loc_00b26a:
	moveq #0,d0
	bra.b loc_00b270

loc_00b26e:
	moveq #1,d0

loc_00b270:
	rts

;##############################################################################
loc_00b272:
	bsr.w loc_00b840
	cmpi.w #4,($d0,a0)
	beq.w loc_00b2c0
	btst #0,$101001
	beq.b loc_00b294
	cmpa.l #player1mem,a0
	beq.b loc_00b294
	rts

loc_00b294:
	bset #0,($bf,a0)
	bne.b loc_00b2b4

loc_00b29c:
	bclr #4,($be,a0)
	bne.b loc_00b2aa
	clr.b ($124,a0)
	bra.b loc_00b2b0

loc_00b2aa:
	move.b #4,($124,a0)

loc_00b2b0:
	clr.b ($125,a0)

loc_00b2b4:
	moveq #0,d0
	move.b ($124,a0),d0
	movea.l loc_00b2c2(pc,d0.w),a1
	jmp (a1)

loc_00b2c0:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00b2c2:
	dc.l loc_00b2d2
	dc.l loc_00b33c
	dc.l loc_00b3a0
	dc.l loc_00b43c

;##############################################################################
loc_00b2d2:
	bset #0,($125,a0)
	bne.b loc_00b2e6
	move.w ($d2,a0),($120,a0)
	move.b #$ff,($122,a0)

loc_00b2e6:
	tst.b $103a72
	bne.b loc_00b31a
	tst.w $106908
	bne.b loc_00b300
	cmpi.b #3,$10690a
	bne.b loc_00b31a

loc_00b300:
	btst #1,($30,a0)
	beq.b loc_00b31a
	move.b #8,($124,a0)
	clr.b ($125,a0)
	clr.b ($122,a0)
	jmp loc_00b2b4(pc)

loc_00b31a:
	move.b ($bd,a0),d0
	move.b ($21,a0),d1
	eor.w d1,d0
	btst #0,d0
	bne.b loc_00b32e
	jmp loc_00b202(pc)

loc_00b32e:
	move.b #$c,($124,a0)
	clr.b ($125,a0)
	jmp loc_00b2b4(pc)

;##############################################################################
loc_00b33c:
	bset #0,($125,a0)
	bne.b loc_00b354
	move.w ($d2,a0),($120,a0)
	addq.w #1,($120,a0)
	move.b #$ff,($122,a0)

loc_00b354:
	tst.b $103a72
	bne.b loc_00b364
	btst #1,($30,a0)
	bne.b loc_00b37e

loc_00b364:
	move.b #8,($124,a0)
	clr.b ($125,a0)
	move.b #4,($122,a0)
	move.b #$f0,($123,a0)
	jmp loc_00b2b4(pc)

loc_00b37e:
	move.b ($bd,a0),d0
	move.b ($21,a0),d1
	eor.w d1,d0
	btst #0,d0
	bne.b loc_00b392
	jmp loc_00b202(pc)

loc_00b392:
	move.b #$c,($124,a0)
	clr.b ($125,a0)
	jmp loc_00b2b4(pc)

;##############################################################################
loc_00b3a0:
	bset #0,($125,a0)
	bne.b loc_00b3d0
	move.w ($d2,a0),($120,a0)
	addq.w #2,($120,a0)
	tst.b ($122,a0)
	bne.b loc_00b3c2
	move.b #$ff,($122,a0)
	jmp loc_00b202(pc)

loc_00b3c2:
	move.b #$f0,($123,a0)
	clr.b ($122,a0)
	jmp loc_00b202(pc)

loc_00b3d0:
	lea.l loc_05a000,a1
	move.w ($120,a0),d0
	add.w d0,d0
	adda.w (a1,d0.w),a1
	moveq #0,d0
	move.b ($122,a0),d0
	move.b (2,a1,d0.w),d0
	move.b ($123,a0),d1
	addq.b #1,d1
	cmp.b d0,d1
	bcs.w loc_00b202
	move.b ($122,a0),d0
	tst.b $103a72
	bne.b loc_00b420
	btst #1,($30,a0)
	beq.b loc_00b420
	cmpi.b #4,d0
	bne.w loc_00b202
	move.b #4,($124,a0)
	clr.b ($125,a0)
	jmp loc_00b2b4(pc)

loc_00b420:
	cmpi.b #4,d0
	bne.b loc_00b430
	move.b #$ff,($122,a0)
	jmp loc_00b202(pc)

loc_00b430:
	clr.b ($124,a0)
	clr.b ($125,a0)
	jmp loc_00b2b4(pc)

;##############################################################################
loc_00b43c:
	bset #0,($125,a0)
	bne.b loc_00b44a
	move.b #$ff,($122,a0)

loc_00b44a:
	moveq #5,d0
	tst.b $103a72
	bne.b loc_00b45e
	btst #1,($30,a0)
	beq.b loc_00b45e
	moveq #6,d0

loc_00b45e:
	add.w ($d2,a0),d0
	move.w d0,($120,a0)
	jsr loc_00b202(pc)
	tst.w d0
	beq.b loc_00b49c
	bclr #0,($21,a0)
	btst #0,($bd,a0)
	beq.b loc_00b482
	bset #0,($21,a0)

loc_00b482:
	tst.b $103a72
	bne.b loc_00b498
	btst #1,($30,a0)
	beq.b loc_00b498
	bset #4,($be,a0)

loc_00b498:
	bra.w loc_00b29c

loc_00b49c:
	rts

;##############################################################################
loc_00b49e:
	bset #0,($bf,a0)
	bne.b loc_00b4e8
	move.b ($bd,a0),d1
	move.b d1,($130,a0)
	move.b ($30,a0),d2
	move.b d2,($131,a0)
	lsl.w #2,d1
	eor.w d1,d2
	move.w #3,($120,a0)
	move.b #$ff,($122,a0)
	btst #2,d2
	beq.b loc_00b4d2
	move.w #4,($120,a0)

loc_00b4d2:
	bsr.w loc_00b840
	cmpi.w #4,($d0,a0)
	beq.w loc_00b55c
	move.w ($d2,a0),d0
	add.w d0,($120,a0)

loc_00b4e8:
	move.b ($130,a0),d2
	move.b ($bd,a0),d3
	eor.w d2,d3
	btst #0,d3
	bne.w loc_00b5da
	move.b ($30,a0),d1
	tst.b $103a72
	beq.b loc_00b508
	moveq #0,d1

loc_00b508:
	move.b ($131,a0),d2
	andi.w #$c,d1
	andi.w #$c,d2
	cmp.w d1,d2
	bne.w loc_00b5da
	jsr loc_00c592
	move.b ($30,a0),d0
	lsr.w #2,d0
	move.b ($bd,a0),d1
	eor.w d1,d0
	lea.l loc_064000,a1
	moveq #0,d2
	move.b (1,a0),d2
	lsl.w #5,d2
	btst #0,d0
	bne.b loc_00b546
	move.l (a1,d2.w),d3
	bra.b loc_00b54c

loc_00b546:
	move.l (4,a1,d2.w),d3
	neg.l d3

loc_00b54c:
	btst #0,d1
	beq.b loc_00b554
	neg.l d3

loc_00b554:
	move.l d3,($c8,a0)
	jmp loc_00b202(pc)

loc_00b55c:
	rts

;##############################################################################
loc_00b55e:
	bset #0,($bf,a0)
	bne.b loc_00b584
	move.w ($d2,a0),d0
	addi.w #9,d0
	move.w d0,($120,a0)
	move.b #$ff,($122,a0)
	bclr #0,($128,a0)
	jsr loc_00c592
 
loc_00b584:
	jsr loc_00b69c(pc)
	nop
	jsr loc_00b202(pc)
	tst.w d0
	beq.b loc_00b59c
	btst #3,($bf,a0)
	beq.w loc_00b5da
 
loc_00b59c:
	btst #0,($128,a0)
	beq.b loc_00b5b0
	move.b ($30,a0),d1
	andi.w #$f,d1
	bne.w loc_00b5da

loc_00b5b0:
	tst.b ($123,a0)
	bne.b loc_00b5d8
	cmpi.b #4,($122,a0)
	bne.b loc_00b5d8
	lea.l loc_064000,a1
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #5,d0
	move.l ($c,a1,d0.w),($cc,a0)
	bset #3,($bf,a0)

loc_00b5d8:
	rts

loc_00b5da:
	clr.w ($d0,a0)
	bclr #0,($bf,a0)
	btst #1,($30,a0)
	beq.b loc_00b5f2
	bset #4,($be,a0)

loc_00b5f2:
	rts

;##############################################################################
loc_00b5f4:
	bset #0,($bf,a0)
	bne.b loc_00b632
	move.b ($30,a0),d0
	move.b d0,($129,a0)
	move.b ($bd,a0),d1
	lsr.w #3,d0
	eor.w d1,d0
	moveq #$b,d2
	btst #0,d0
	beq.b loc_00b616
	moveq #$a,d2

loc_00b616:
	move.w ($d2,a0),d3
	add.w d2,d3
	move.w d3,($120,a0)
	move.b #$ff,($122,a0)
	bclr #0,($128,a0)
	jsr loc_00c592

loc_00b632:
	jsr loc_00b69c(pc)
	nop
	jsr loc_00b202(pc)
	tst.w d0
	beq.b loc_00b648
	btst #3,($bf,a0)
	beq.b loc_00b5da

loc_00b648:
	btst #0,($128,a0)
	beq.b loc_00b65a
	move.b ($30,a0),d0
	andi.w #$f,d0
	bne.b loc_00b5da

loc_00b65a:
	tst.b ($123,a0)
	bne.b loc_00b69a
	cmpi.b #4,($122,a0)
	bne.b loc_00b69a
	lea.l loc_064000,a1
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #5,d0
	move.l ($c,a1,d0.w),($cc,a0)
	move.l (8,a1,d0.w),($c8,a0)
	bset #3,($bf,a0)
	btst #2,($129,a0)
	beq.b loc_00b694
	neg.l ($c8,a0)

loc_00b694:
	bset #3,($bf,a0)

loc_00b69a:
	rts

;##############################################################################
loc_00b69c:
	btst #3,($bf,a0)
	beq.b loc_00b6f8
	lea.l loc_064000,a1
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #5,d0
	move.l ($10,a1,d0.w),d0
	neg.l d0
	add.l d0,($cc,a0)
	move.l ($cc,a0),d1
	add.l ($c4,a0),d1
	bpl.w loc_00b6f8
	clr.l ($c4,a0)
	clr.l ($cc,a0)
	bclr #3,($bf,a0)
	move.b #6,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	move.b #$fe,($123,a0)
	bset #0,($128,a0)

loc_00b6f8:
	rts

;##############################################################################
loc_00b6fa:
	tst.b ($14d,a0)
	bne.b loc_00b70e
	bsr.w loc_00b840
	cmpi.w #4,($d0,a0)
	beq.w loc_00b7e4

loc_00b70e:
	bset #0,($bf,a0)
	bne.b loc_00b72a
	move.b #$ff,($122,a0)
	clr.b ($128,a0)
	jsr loc_00c592
	bra.w loc_00b7ae

loc_00b72a:
	jsr loc_00c592
	tst.l ($10c,a0)
	bne.b loc_00b74a
	movea.l ($14,a0),a1
	cmpi.w #$20,($d0,a1)
	bcc.b loc_00b74a
	btst #4,($bf,a0)
	beq.b loc_00b770

loc_00b74a:
	tst.b ($14d,a0)
	bne.b loc_00b7ae
	move.b ($30,a0),d0
	btst #0,d0
	bne.b loc_00b770
	move.b d0,d1
	andi.w #$c,d1
	beq.b loc_00b770
	lsr.w #2,d1
	move.b ($bd,a0),d2
	eor.w d1,d2
	andi.w #1,d2
	bne.b loc_00b7ae

loc_00b770:
	move.w ($d2,a0),d3
	addq.w #7,d3
	btst #1,($30,a0)
	beq.b loc_00b780
	addq.w #1,d3

loc_00b780:
	lea.l loc_05a000,a1
	add.w d3,d3
	adda.w (a1,d3.w),a1
	moveq #0,d0
	move.b ($122,a0),d0
	move.b (2,a1,d0.w),d0
	move.b ($123,a0),d1
	addq.b #1,d1
	cmp.b d0,d1
	bcs.b loc_00b7ae
	tst.b ($122,a0)
	beq.w loc_00b5da
	move.b #$ff,($122,a0)

loc_00b7ae:
	tst.b ($128,a0)
	beq.b loc_00b7be
	clr.b ($122,a0)
	move.b #$f0,($123,a0)
 
loc_00b7be:
	move.w ($d2,a0),d3
	addq.w #7,d3
	btst #1,($30,a0)
	beq.b loc_00b7ce
	addq.w #1,d3

loc_00b7ce:
	move.w d3,($120,a0)
	clr.b ($128,a0)
	jsr loc_00b202(pc)
	tst.w d0
	beq.b loc_00b7e4
	bset #0,($128,a0)

loc_00b7e4:
	rts

;##############################################################################
loc_00b7e6:
	lea.l loc_064000,a1
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #5,d0
	move.l ($1c,a1,d0.w),d0
	neg.l d0
	add.l d0,($cc,a0)
	move.l ($cc,a0),d1
	add.l ($c4,a0),d1
	bpl.w loc_00b82e
	clr.l ($c4,a0)
	clr.l ($cc,a0)
	bclr #3,($bf,a0)
	move.b #6,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_00b82e:
	jsr loc_00b202(pc)
	btst #3,($bf,a0)
	bne.b loc_00b83e
	jmp loc_00b5da(pc)

loc_00b83e:
	rts

;##############################################################################
loc_00b840:
	tst.b $103a72
	bne.w loc_00b8f4
	move.b ($30,a0),d0
	cmpi.b #4,d0
	bne.b loc_00b860
	btst #0,($bd,a0)
	beq.b loc_00b872
	bra.w loc_00b8f4

loc_00b860:
	cmpi.b #8,d0
	bne.w loc_00b8f4
	btst #0,($bd,a0)
	beq.w loc_00b8f4

loc_00b872:
	lea.l ($31,a0),a1
	lea.l ($60,a0),a2
	moveq #0,d0

loc_00b87c:
	tst.b (a1)+
	bne.b loc_00b886
	addq.w #1,d0
	cmpa.l a2,a1
	bcs.b loc_00b87c

loc_00b886:
	tst.w d0
	beq.b loc_00b8f4
	cmpi.w #6,d0
	bcc.b loc_00b8f4
	move.b (-1,a1),d0
	cmp.b ($30,a0),d0
	bne.b loc_00b8f4
	jsr loc_00c592
	move.w #4,($d0,a0)
	bset #3,($bf,a0)
	move.w ($d2,a0),($120,a0)
	addi.w #$21,($120,a0)
	move.b #$ff,($122,a0)
	bclr #0,($128,a0)
	jsr loc_00c592
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #5,d0
	lea.l loc_064000,a1
	move.l ($14,a1,d0.w),($c8,a0)
	move.l ($18,a1,d0.w),($cc,a0)
	btst #2,($30,a0)
	beq.b loc_00b8f0
	neg.l ($c8,a0)

loc_00b8f0:
	jsr loc_00b69c(pc)

loc_00b8f4:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00b8f6:
	dc.l loc_00b272,loc_00b49e,loc_00b55e
	dc.l loc_00b5f4,loc_00b7e6,loc_00b6fa

loc_00b90e:
	dc.l loc_01136e,loc_011844,loc_010fba
	dc.l loc_0110e8,loc_010f8c,loc_010f90
	dc.l loc_010f94,loc_010f98,loc_010fa2
	dc.l loc_010fac,loc_010fb0,loc_01119c
	dc.l loc_01aa92,loc_0117a4,loc_0114aa
	dc.l loc_011828,loc_0112ca

loc_00b952:
	dc.l loc_00b272,loc_00b272,loc_00b272
	dc.l loc_00b272,loc_00b272,loc_00b272
	dc.l loc_00b272,loc_00b272,loc_00b272

loc_00b976:
	dc.l loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434

loc_00b9a6:
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01ac10,loc_01ac10,loc_01a982,loc_01a49a
	dc.l loc_01a49a,loc_01a5b8,loc_01a5b8,loc_01a5b8
	dc.l loc_01a5b8,loc_01a49a,loc_01a49a,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01ac10,loc_01a5b8,loc_01a982,loc_01a5b8
	dc.l loc_01a5b8,loc_01a982,loc_019434,loc_01a5b8
	dc.l loc_01a5b8,loc_01a49a,loc_01a5b8,loc_01a49a
	dc.l loc_01a5b8,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01b0f6,loc_01b0f6,loc_01b0f6,loc_01a5b8
	dc.l loc_01ac10,loc_01b236,loc_01ac10,loc_01ac10
	dc.l loc_01ac10,loc_01ac10,loc_01ac10,loc_01ac10
	dc.l loc_01ac10,loc_01ac10,loc_01ac10,loc_01a5b8
	dc.l loc_01a5b8,loc_019434,loc_01ac10,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_01a5b8,loc_019434,loc_019434
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01ac10,loc_01a982,loc_01a5b8,loc_01a5b8
	dc.l loc_01a5b8,loc_01a5b8,loc_01a5b8,loc_01a5b8
	dc.l loc_019318,loc_01a5b8,loc_019318,loc_01a5b8
	dc.l loc_01a5b8,loc_01c95e,loc_01a5b8,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01ac10,loc_01b236,loc_01ac10,loc_01ac10
	dc.l loc_01b236,loc_01ac10,loc_01a982,loc_01a5b8
	dc.l loc_01a5b8,loc_01a5b8,loc_01a5b8,loc_01a49a
	dc.l loc_01a49a,loc_01a49a,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318

loc_00bd86:
	dc.l loc_01ac10,loc_01a5b8
	dc.l loc_01a5b8,loc_019434
	dc.l loc_01a5b8,loc_01a5b8
	dc.l loc_01a982,loc_019434
	dc.l loc_01a49a,loc_01a49a

loc_00bdae:
	dc.l loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019318,loc_019318,loc_019318,loc_019318

loc_00be36:
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01ac10,loc_01ac10,loc_01a982,loc_01a49a
	dc.l loc_01a49a,loc_01a5b8,loc_01a5b8,loc_01a5b8
	dc.l loc_01a5b8,loc_01a5b8,loc_01a5b8,loc_01a5b8
	dc.l loc_01a982,loc_01a49a,loc_01a5b8,loc_01ac10
	dc.l loc_01ac10,loc_01ac10,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01ac10,loc_01ac10,loc_01a982,loc_01c95e
	dc.l loc_01c95e,loc_01a5b8,loc_01a5b8,loc_01a49a
	dc.l loc_01a49a,loc_01a5b8,loc_01a5b8,loc_01a5b8
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01b1e2,loc_01b1e2,loc_01a5b8,loc_01a49a
	dc.l loc_01a49a,loc_01a5b8,loc_01a5b8,loc_01a5b8
	dc.l loc_01a5b8,loc_019318,loc_019318,loc_01a5b8
	dc.l loc_01a5b8,loc_01a5b8,loc_01a5b8,loc_01ac10
	dc.l loc_01ac10,loc_01a49a,loc_01ac10,loc_01a5b8
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01ac10,loc_01a982,loc_01a5b8,loc_01a5b8
	dc.l loc_01c95e,loc_019434,loc_01a5b8,loc_019318
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01ac10,loc_01c95e,loc_01c95e,loc_01a49a
	dc.l loc_01a49a,loc_01a49a,loc_01a49a,loc_01a5b8
	dc.l loc_01a5b8,loc_01a5b8,loc_01a5b8,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01ac10,loc_01b236,loc_01ac10,loc_01a982
	dc.l loc_01a5b8,loc_01a5b8,loc_01a5b8,loc_01a5b8
	dc.l loc_01a5b8,loc_01a5b8,loc_01a814,loc_01a5b8
	dc.l loc_01a814,loc_01a5b8,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_01a49a
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01ac10,loc_01a982,loc_01a982,loc_01a982
	dc.l loc_01a982,loc_01a982,loc_01a49a,loc_019434
	dc.l loc_019434,loc_019434,loc_019318,loc_01a5b8
	dc.l loc_019318,loc_01a5b8,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_01a49a
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_019318,loc_019318,loc_019318,loc_019318
	dc.l loc_01ac10,loc_01a49a,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434
	dc.l loc_019434,loc_019434,loc_019434,loc_019434

loc_00c3f6:
	dc.b $00,$02,$00,$00,$01,$03,$00,$00
	dc.b $01,$03,$00,$00,$00,$00,$00,$00

;Player Specials Programing
loc_00c406:
	dc.l loc_016292,loc_0162a0,loc_0162ae
	dc.l loc_0162bc,loc_0162ca,loc_0162d8
	dc.l loc_0162e6,loc_0162f4,loc_016302
	dc.l loc_016310,loc_01631e,loc_01632c
	dc.l loc_01633a,loc_016348

;##############################################################################
loc_00c43e:
	cmpi.b #5,$103a72
	beq.b loc_00c452
	tst.b $103a72
	bne.w loc_00c590

loc_00c452:
	tst.w $106908
	bne.w loc_00c46c
	cmpi.b #3,$10690a
	beq.w loc_00c47a
	bra.w loc_00c590

loc_00c46c:
	btst #7,$b8(a0)
	beq.b loc_00c47a
	jsr loc_0183fe

loc_00c47a:
	btst #0,$101001
	beq.b loc_00c48e
	cmpa.l #player1mem,a0
	bne.w loc_00c590

loc_00c48e:
	tst.w ($d0,a0)
	bne.b loc_00c49a
	bclr #2,($bf,a0)

loc_00c49a:
	btst #6,$101000
	beq.b loc_00c4ee
	cmpi.w #6,($d0,a0)
	bcc.w loc_00c590
	btst #3,($bf,a0)
	bne.w loc_00c590
	bclr #0,($bf,a0)
	movea.l ($14,a0),a1
	move.b ($143,a0),d0
	move.b ($143,a1),d1
	cmp.b d0,d1
	bcc.b loc_00c4e4
	move.w #7,($d0,a0)
	bset #6,($21,a0)
	bclr #6,($21,a1)
	bra.w loc_00c590

loc_00c4e4:
	move.w #8,($d0,a0)
	bra.w loc_00c590

loc_00c4ee:
	move.w ($d0,a0),d0
	tst.w d0
	bne.b loc_00c4fc
	bclr #2,($bf,a0)

loc_00c4fc:
	move.b ($b1,a0),d1
	cmpi.w #4,($d0,a0)
	beq.w loc_00c590
	move.b d1,d2
	andi.w #$f0,d2
	beq.b loc_00c528
	lea.l loc_00c406(pc),a1
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #2,d0
	movea.l (a1,d0.w),a1
	jsr (a1)
	bra.w loc_00c590

loc_00c528:
	move.b ($30,a0),d1
	cmpi.w #5,($d0,a0)
	beq.b loc_00c590
	cmpi.w #2,($d0,a0)
	bcc.b loc_00c590
	move.b d1,d2
	andi.b #$c,d2
	beq.b loc_00c572
	move.b ($bd,a0),d2
	move.b d1,d3
	lsr.w #2,d3
	eor.w d2,d3
	btst #0,d3
	beq.b loc_00c572
	movea.l ($14,a0),a1
	cmpi.w #$20,($d0,a1)
	bcc.b loc_00c568
	btst #6,($bf,a0)
	beq.b loc_00c572

loc_00c568:
	btst #0,d1
	bne.b loc_00c572
	moveq #5,d2
	bra.b loc_00c57e

loc_00c572:
	andi.w #$f,d1
	lea.l loc_00c3f6(pc),a1
	move.b (a1,d1.w),d2

loc_00c57e:
	move.w ($d0,a0),d4
	move.w d2,($d0,a0)
	cmp.w d2,d4
	beq.b loc_00c590
	bclr #0,($bf,a0)

loc_00c590:
	rts

;##############################################################################
loc_00c592:
	move.b ($bd,a0),d4
	move.b ($21,a0),d5
	bclr #0,d5
	andi.w #1,d4
	or.w d4,d5
	move.b d5,($21,a0)
	rts

;##############################################################################
loc_00c5aa:
	lea.l player1mem,a0
	bsr.w loc_00c5b8
	lea.l (playeroffset,a0),a0

loc_00c5b8:
	btst #7,($b8,a0)
	beq.b loc_00c5c6
	jsr loc_0183fe

loc_00c5c6:
	rts

;##############################################################################
loc_00c5c8:
	lea.l player1mem,a0
	lea.l player2mem,a1
	bclr #6,($bf,a0)
	move.w ($d0,a1),d0
	cmpi.w #$30,d0
	bcs.b loc_00c5ea
	bset #6,($bf,a0)

loc_00c5ea:
	bclr #6,($bf,a1)
	move.w ($d0,a0),d0
	cmpi.w #$30,d0
	bcs.b loc_00c600
	bset #6,($bf,a1)

loc_00c600:
	move.l ($c0,a0),d0
	move.l ($c0,a1),d1
	move.l d0,d2
	move.l d1,d3
	sub.l d1,d0
	bpl.b loc_00c620
	neg.l d0
	bclr #1,($bd,a0)
	bset #1,($bd,a1)
	bra.b loc_00c62c

loc_00c620:
	bset #1,($bd,a0)
	bclr #1,($bd,a1)

loc_00c62c:
	move.l d0,($100,a0)
	move.l d0,($100,a1)
	cmpi.l #$80000,d0
	bcs.b loc_00c6b0
	cmp.l d2,d3
	bcc.b loc_00c646
	moveq #1,d4
	moveq #0,d5
	bra.b loc_00c64a

loc_00c646:
	moveq #0,d4
	moveq #1,d5

loc_00c64a:
	move.l ($c0,a0),d6
	sub.l $103424,d6
	cmpi.l #$100000,d6
	bne.b loc_00c664
	btst #0,d4
	beq.b loc_00c672
	bra.b loc_00c67c

loc_00c664:
	cmpi.l #$1300000,d6
	bne.b loc_00c672
	btst #0,d4
	beq.b loc_00c67c

loc_00c672:
	bclr #0,($bd,a0)
	or.b d4,($bd,a0)

loc_00c67c:
	move.l ($c0,a1),d7
	sub.l $103424,d7
	cmpi.l #$100000,d7
	bne.w loc_00c698
	btst #0,d5
	bne.b loc_00c6b0
	bra.b loc_00c6a6

loc_00c698:
	cmpi.l #$1300000,d7
	bne.b loc_00c6a6
	btst #0,d5
	beq.b loc_00c6b0

loc_00c6a6:
	bclr #0,($bd,a1)
	or.b d5,($bd,a1)

loc_00c6b0:
	rts

;##############################################################################
loc_00c6b2:
	lea.l player1mem,a0
	lea.l player2mem,a1
	move.l ($18,a0),d0
	move.l ($18,a1),d1
	cmp.l d1,d0
	bls.b loc_00c6d0
	move.l d0,d2
	move.l d1,d0
	move.l d2,d1

loc_00c6d0:
	subi.l #$580000,d0
	bmi.b loc_00c6da
	moveq #0,d0

loc_00c6da:
	subi.l #$e80000,d1
	bpl.b loc_00c6e4
	moveq #0,d1

loc_00c6e4:
	move.l d0,d2
	or.l d1,d2
	beq.b loc_00c6fc
	move.l d0,d2
	add.l d1,d2
	beq.b loc_00c6fc
	move.l d0,d3
	neg.l d3
	add.l d3,d1
	lsr.l #1,d1
	sub.l d3,d1
	move.l d1,d2

loc_00c6fc:
	clr.w d2
	tst.l d2
	bmi.b loc_00c714
	cmpi.l #$50000,d2
	bls.b loc_00c722
	move.l #$50000,d2
	bra.w loc_00c722

loc_00c714:
	cmpi.l #$fffb0000,d2
	bge.b loc_00c722
	move.l #$fffb0000,d2

loc_00c722:
	move.l d2,$10342c
	rts

;##############################################################################
loc_00c72a:
	move.w ($c4,a0),d0
	move.w ($c4,a1),d1
	cmp.w d1,d0
	bcc.b loc_00c738
	move.w d1,d0

loc_00c738:
	subi.w #$20,d0
	bpl.b loc_00c742
	moveq #0,d0
	bra.b loc_00c752

loc_00c742:
	asr.w #2,d0
	move.w $103428,d1
	subq.w #8,d1
	sub.w $103428,d0

loc_00c752:
	move.w d0,$103430
	rts

;##############################################################################
loc_00c75a:
	clr.w $106698
	lea.l player1mem,a0
	lea.l (playeroffset,a0),a1
	move.b ($bd,a0),d0
	move.b ($bd,a1),d1
	or.b d0,d1
	btst #6,d1
	bne.w loc_00c90c
	move.b ($14c,a0),d0
	move.b ($14c,a1),d1
	or.b d0,d1
	bne.w loc_00c90c

loc_00c78a:
	lea.l player1mem,a0
	lea.l (playeroffset,a0),a1
	move.l ($c0,a0),d0
	move.l ($c0,a1),d1
	lea.l loc_037000+$10,a6
	move.w ($22,a0),d2
	mulu.w #$30,d2
	lea.l (a6,d2.l),a2
	move.w ($22,a1),d3
	mulu.w #$30,d3
	lea.l (a6,d3.l),a3
	moveq #0,d2
	move.b (4,a2),d2
	ext.w d2
	swap d2
	btst #0,($21,a0)
	beq.b loc_00c7ce
	neg.l d2

loc_00c7ce:
	add.l d2,d0
	moveq #0,d3
	move.b (4,a3),d3
	ext.w d3
	swap d3
	btst #0,($21,a1)
	beq.b loc_00c7e4
	neg.l d3

loc_00c7e4:
	add.l d3,d1
	move.l d0,d4
	sub.l d1,d4
	bpl.b loc_00c7ee
	neg.l d4

loc_00c7ee:
	moveq #0,d5
	move.b (6,a2),d5
	add.b (6,a3),d5
	ext.w d5
	swap d5
	sub.l d5,d4
	bcc.w loc_00c90c
	neg.l d4
	move.l d4,d7
	move.l ($c4,a0),d0
	move.l ($c4,a1),d1
	moveq #0,d2
	move.b (5,a2),d2
	ext.w d2
	neg.w d2
	swap d2
	add.l d2,d0
	moveq #0,d3
	move.b (5,a3),d3
	ext.w d3
	neg.w d3
	swap d3
	add.l d3,d1
	move.l d0,d4
	sub.l d1,d4
	bpl.b loc_00c832
	neg.l d4

loc_00c832:
	moveq #0,d5
	move.b (7,a2),d5
	moveq #0,d6
	add.b (7,a3),d6
	add.w d6,d5
	swap d5
	cmp.l d5,d4
	bcc.w loc_00c90c
	move.l ($18,a0),d0
	move.l ($18,a1),d1
	moveq #0,d2
	moveq #0,d3
	cmpi.l #$100000,d0
	bne.b loc_00c85e
	addq.w #1,d2

loc_00c85e:
	cmpi.l #$1300000,d0
	bne.b loc_00c868
	addq.w #1,d2

loc_00c868:
	cmpi.l #$100000,d1
	bne.b loc_00c872
	addq.w #1,d3

loc_00c872:
	cmpi.l #$1300000,d1
	bne.b loc_00c87c
	addq.w #1,d3

loc_00c87c:
	add.w d2,d3
	bne.b loc_00c8ca
	lsr.l #1,d7
	cmpi.l #$30000,d7
	bcs.b loc_00c890
	move.l #$30000,d7

loc_00c890:
	cmp.l d1,d0
	bcs.b loc_00c89a
	movea.l a0,a5
	movea.l a1,a0
	movea.l a5,a1

loc_00c89a:
	sub.l d7,($c0,a0)
	add.l d7,($c0,a1)
	lea.l player1mem,a0
	bsr.w loc_00c9c0
	lea.l player2mem,a0
	bsr.w loc_00c9c0
	addq.w #1,$106698
	cmpi.w #2,$106698
	bcc.b loc_00c90c
	bra.w loc_00c78a

loc_00c8ca:
	cmpi.w #1,d3
	beq.b loc_00c8da
	btst #3,($bf,a0)
	bne.b loc_00c8ec
	bra.b loc_00c8e0

loc_00c8da:
	cmpi.w #1,d2
	bne.b loc_00c8ec

loc_00c8e0:
	movea.l a0,a5
	movea.l a1,a0
	movea.l a5,a1
	move.l d0,d3
	move.l d1,d0
	move.l d3,d1

loc_00c8ec:
	cmpi.l #$60000,d7
	bcs.b loc_00c8fa
	move.l #$60000,d7

loc_00c8fa:
	move.l ($c0,a0),d3
	cmpi.l #$2800000,d3
	bcs.b loc_00c908
	neg.l d7

loc_00c908:
	add.l d7,($c0,a0)

loc_00c90c:
	rts

;##############################################################################
loc_00c90e:
	move.l ($c0,a0),d0
	sub.l $103424,d0
	move.l d0,d3
	move.w ($22,a0),d1
	mulu.w #$30,d1
	lea.l loc_037000+$10,a1
	lea.l (a1,d1.l),a1
	moveq #0,d2
	move.b (4,a1),d2
	ext.w d2
	btst #0,($21,a0)
	beq.b loc_00c93e
	neg.w d2

loc_00c93e:
	swap d2
	add.l d2,d0
	move.l d0,d4
	add.l ($c8,a0),d0
	moveq #0,d2
	move.b (6,a1),d2
	swap d2
	cmpi.l #$a00000,d0
	bgt.b loc_00c97a
	sub.l d2,d0
	move.l d0,($18,a0)
	cmpi.l #$100000,d0
	bgt.b loc_00c9be
	move.l #$100000,d5
	move.l d5,($18,a0)
	sub.l d2,d3
	sub.l d3,d5
	move.l d5,($c8,a0)
	bra.b loc_00c99a

loc_00c97a:
	add.l d2,d0
	move.l d0,($18,a0)
	cmpi.l #$1300000,d0
	bcs.b loc_00c9be
	move.l #$1300000,d5
	move.l d5,($18,a0)
	add.l d2,d3
	sub.l d3,d5
	move.l d5,($c8,a0)

loc_00c99a:
	movea.l ($14,a0),a1
	btst #7,($bd,a0)
	beq.b loc_00c9aa
	add.l d5,($c0,a1)

loc_00c9aa:
	btst #3,($bf,a0)
	beq.b loc_00c9be
	move.l ($c8,a0),d0
	add.l d0,($c0,a0)
	clr.l ($c8,a0)

loc_00c9be:
	rts

;##############################################################################
loc_00c9c0:
	move.l ($c0,a0),d0
	sub.l $103424,d0
	move.l d0,d3
	move.w ($22,a0),d1
	mulu.w #$30,d1
	lea.l loc_037000+$10,a1
	lea.l (a1,d1.l),a1
	moveq #0,d2
	move.b (4,a1),d2
	ext.w d2
	btst #0,($21,a0)
	beq.b loc_00c9f0
	neg.w d2

loc_00c9f0:
	swap d2
	add.l d2,d0
	move.l d0,d4
	moveq #0,d2
	move.b (6,a1),d2
	swap d2
	cmpi.l #$a00000,d0
	bgt.b loc_00ca28
	sub.l d2,d0
	move.l d0,($18,a0)
	cmpi.l #$100000,d0
	bgt.b loc_00ca58
	move.l #$100000,d5
	move.l d5,($18,a0)
	sub.l d2,d3
	sub.l d3,d5
	add.l d5,($c0,a0)
	bra.b loc_00ca48

loc_00ca28:
	add.l d2,d0
	move.l d0,($18,a0)
	cmpi.l #$1300000,d0
	bcs.b loc_00ca58
	move.l #$1300000,d5
	move.l d5,($18,a0)
	add.l d2,d3
	sub.l d3,d5
	add.l d5,($c0,a0)

loc_00ca48:
	movea.l ($14,a0),a1
	btst #7,($bd,a0)
	beq.b loc_00ca58
	add.l d5,($c0,a1)

loc_00ca58:
	rts

;##############################################################################
loc_00ca5a:
	lea.l $1064f0,a1
	moveq #3,d7
	moveq #0,d2
	cmpa.l #player1mem,a0
	beq.b loc_00ca70
	bset #2,d2

loc_00ca70:
	btst #0,(1,a1)
	bne.b loc_00ca86

loc_00ca78:
	lea.l ($40,a1),a1
	dbra d7,loc_00ca70
	clr.l ($104,a0)
	bra.b loc_00cacc

loc_00ca86:
	move.b (1,a1),d3
	eor.w d2,d3
	btst #2,d3
	beq.b loc_00ca78
	move.l ($18,a1),d2
	move.l d2,($108,a0)
	move.l ($10,a1),d3
	move.l ($c0,a0),d4
	sub.l d3,d4
	bpl.b loc_00cab4
	neg.l d4
	move.l d4,($104,a0)
	tst.w ($18,a1)
	bpl.b loc_00cabe
	bra.b loc_00cac6

loc_00cab4:
	move.l d4,($104,a0)
	tst.w ($18,a1)
	bpl.b loc_00cac6

loc_00cabe:
	cmpi.l #$300000,d4
	bcc.b loc_00ca78

loc_00cac6:
	ori.b #$50,($bf,a0)

loc_00cacc:
	rts

;##############################################################################
loc_00cace:
	lea.l player1mem,a0
	lea.l (playeroffset,a0),a1
	btst #3,($bf,a0)
	beq.b loc_00cae4
	clr.l ($10c,a0)

loc_00cae4:
	btst #3,($bf,a1)
	beq.b loc_00caf0
	clr.l ($10c,a1)

loc_00caf0:
	move.b ($14c,a0),d0
	or.b ($14c,a1),d0
	bne.w loc_00cbb8
	move.l ($18,a0),d0
	move.l ($18,a1),d1
	add.l ($10c,a0),d0
	add.l ($10c,a1),d1
	cmpi.l #$100000,d0
	bcs.b loc_00cb52
	cmpi.l #$100000,d1
	bcs.b loc_00cb4a
	cmpi.l #$1300000,d0
	bhi.b loc_00cb8a
	cmpi.l #$1300000,d1
	bhi.b loc_00cb82
	move.l ($10c,a0),d0
	add.l d0,($c0,a0)
	move.l ($10c,a1),d0
	add.l d0,($c0,a1)
	bsr.w loc_00cbba
	movea.l a1,a0
	bsr.w loc_00cbba
	bra.w loc_00cbb8

loc_00cb4a:
	movea.l a1,a0
	lea.l player1mem,a1

loc_00cb52:
	move.l ($18,a0),d0
	subi.l #$100000,d0
	move.l d0,d1
	neg.l d0
	add.l d0,($c0,a0)
	btst #2,($146,a0)
	bne.b loc_00cb76
	move.l ($10c,a0),d0
	neg.l d0
	add.l d0,($c0,a1)

loc_00cb76:
	bsr.w loc_00cbba
	movea.l a1,a0
	bsr.w loc_00cbba
	bra.b loc_00cbb8

loc_00cb82:
	movea.l a1,a0
	lea.l player1mem,a1

loc_00cb8a:
	move.l ($18,a0),d0
	subi.l #$1300000,d0
	neg.l d0
	move.l d0,d1
	add.l d0,($c0,a0)
	btst #2,($146,a0)
	bne.b loc_00cbae
	move.l ($10c,a0),d0
	neg.l d0
	add.l d0,($c0,a1)

loc_00cbae:
	bsr.w loc_00cbba
	movea.l a1,a0
	bsr.w loc_00cbba

loc_00cbb8:
	rts

;##############################################################################
loc_00cbba:
	move.l ($10c,a0),d0
	tst.l d0
	beq.b loc_00cbdc
	bpl.b loc_00cbce
	addi.l #$8000,d0
	bpl.b loc_00cbd6
	bra.b loc_00cbd8

loc_00cbce:
	subi.l #$8000,d0
	bpl.b loc_00cbd8

loc_00cbd6:
	moveq #0,d0

loc_00cbd8:
	move.l d0,($10c,a0)

loc_00cbdc:
	rts

;##############################################################################
loc_00cbde:
	movem.l a1,-(a7)
	tst.w $106920
	bne.b loc_00cc06
	tst.w $106928
	bne.b loc_00cc06
	swap d0
	clr.w d0
	lea.l $106914,a1
	move.l d0,(a1)
	move.l d0,(4,a1)
	move.w d1,(8,a1)

loc_00cc06:
	movem.l (a7)+,a1
	rts

;##############################################################################
loc_00cc0c:
	lea.l $106914,a0
	tst.l (4,a0)
	beq.b loc_00cc58
	lea.l $106920,a1
	move.l (a0),d0
	add.l d0,(a1)
	beq.b loc_00cc34
	move.l (4,a0),d1
	tst.l (a1)
	bpl.b loc_00cc30
	add.l d1,(a0)
	bra.b loc_00cc58

loc_00cc30:
	sub.l d1,(a0)
	bra.b loc_00cc58

loc_00cc34:
	tst.l (a0)
	bmi.b loc_00cc58
	tst.w (8,a0)
	beq.b loc_00cc44
	subq.w #1,(8,a0)
	bra.b loc_00cc58

loc_00cc44:
	subi.l #$10000,(4,a0)
	bcs.b loc_00cc54
	move.l (4,a0),(a0)
	bra.b loc_00cc58

loc_00cc54:
	clr.l (4,a0)

loc_00cc58:
	lea.l player1mem,a1
	lea.l player2mem,a2
	move.b ($bd,a1),d0
	or.b ($bd,a2),d0
	btst #7,d0
	bne.b loc_00cc86
	move.w ($c4,a1),d0
	move.w ($c4,a2),d1
	cmp.w d1,d0
	bgt.b loc_00cc80
	move.w d1,d0

loc_00cc80:
	cmpi.w #$20,d0
	bcc.b loc_00cc8a

loc_00cc86:
	moveq #0,d0
	bra.b loc_00cc9a

loc_00cc8a:
	subi.w #$20,d0
	lsr.w #2,d0
	cmpi.w #$e,d0
	bcs.b loc_00cc9a
	move.w #$e,d0

loc_00cc9a:
	move.w $106924,d1
	cmp.w d1,d0
	beq.b loc_00ccbe
	sub.w d1,d0
	bpl.b loc_00ccb4
	cmpi.w #$fffe,d0
	bge.b loc_00ccbc
	move.w #$fffe,d0
	bra.b loc_00ccbc

loc_00ccb4:
	cmpi.w #2,d0
	bls.b loc_00ccbc
	moveq #2,d0

loc_00ccbc:
	add.w d1,d0

loc_00ccbe:
	move.w d0,$106924
	add.w $106920,d0
	move.w d0,$106928
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00ccd2:
	dc.l loc_00cd30
	dc.l loc_00ce1e
	dc.l loc_00cf1c
	dc.l loc_00cf80
	dc.l loc_00d026
	dc.l loc_00d084
	dc.l loc_00d138

;##############################################################################
loc_00ccee:
	move.w $10690e,d0
	lsl.w #2,d0
	movea.l loc_00ccd2(pc,d0.w),a0
	jmp (a0)

;##############################################################################
loc_00ccfc:
	dc.w $1800,$ac00,$2800,$ac00,$3800,$ac00,$5800,$ac00
	dc.w $6800,$ac00,$7800,$ac00,$1800,$9c00,$2800,$9c00
	dc.w $3800,$9c00,$4800,$9c00,$5800,$9c00,$6800,$9c00
	dc.w $7800,$9c00

;##############################################################################
loc_00cd30:
	bset #0,$106910
	bne.b loc_00cd76
	jsr loc_006be6
	bsr.w loc_00dc3a
	move.w #$700,d3
	jsr loc_00d976(pc)
	nop
	bsr.w loc_00d232
	bsr.w loc_00d2ba
	move.b #3,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054
	clr.w $106912
	bra.w loc_00ce1c

loc_00cd76:
	tst.w $106986
	beq.b loc_00cdb2
	bsr.w loc_00d632
	cmpi.w #$10,$106986
	bne.b loc_00cdb2
	btst #4,$101000
	beq.b loc_00cdb2
	movea.l $101420,a1
	lea.l loc_00d2b4(pc),a2
	nop
	lea.l $7255.w,a3
	jsr loc_00dffc
	move.l a1,$101420

loc_00cdb2:
	addq.w #1,$106912
	lea.l player1mem,a1
	bsr.w loc_00d4aa
	lea.l player2mem,a1
	bsr.w loc_00d4aa

	bsr.w loc_00d8bc
	bsr.w loc_00d8ee
	move.w $106732,d1
	bsr.w loc_00d914
	bsr.w loc_00d80a
	bsr.w loc_00d6ae
	bsr.w loc_00db66
	move.b $103728,d0
	and.b $103928,d0
	btst #1,d0
	beq.b loc_00ce1c
	bsr.w loc_00dc4c
	tst.w $106986
	bne.w loc_00ce1c
	bsr.w loc_00d5f4
	move.w #1,$10690e
	clr.w $106910

loc_00ce1c:
	rts

;##############################################################################
loc_00ce1e:
	bset #0,$106910
	bne.b loc_00ce4c
	btst #4,$101001
	beq.w loc_00cf04
	move.b $101000,d0
	andi.b #3,d0
	cmpi.b #3,d0
	beq.w loc_00cf04;if vs mode
	clr.w $106912

loc_00ce4c:
	addq.w #1,$106912
	jsr loc_006cf8
	tst.w d0
	beq.b loc_00ce62
	addq.w #1,$106912

loc_00ce62:
	jsr loc_006974
	tst.w d0
	bne.w loc_00d128
	cmpi.w #$48,$106912
	bcs.w loc_00cf12
	jsr loc_006cf8
	move.w d0,d2
	lea.l player1mem,a1
	btst #0,$101000
	bne.b loc_00ceb8
	moveq #0,d0
	move.b (1,a1),d0
	addi.w #$200,($150,a1)
	cmpi.w #$c00,($150,a1)
	bge.b loc_00ceec
	tst.w d2
	beq.b loc_00ceb8
	addi.w #$200,($150,a1)
	cmpi.w #$c00,($150,a1)
	bge.b loc_00ceec

loc_00ceb8:
	btst #1,$101000
	bne.b loc_00cf12
	move.b ($201,a1),d0
	subi.w #$200,($350,a1)
	cmpi.w #$6400,($350,a1)
	bls.b loc_00ceec
	tst.w d2
	beq.w loc_00cf12
	subi.w #$200,($350,a1)
	cmpi.w #$6400,($350,a1)
	bls.b loc_00ceec
	bra.w loc_00cf12

loc_00ceec:
	addi.b #$4f,d0
	move.b d0,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_00cf04:
	move.w #2,$10690e
	clr.w $106910

loc_00cf12:
	bsr.w loc_00d80a
	bsr.w loc_00d6ae
	rts

;##############################################################################
loc_00cf1c:
	bset #0,$106910
	bne.b loc_00cf2c
	clr.w $106912

loc_00cf2c:
	addq.w #1,$106912
	jsr loc_006cf8
	tst.w d0
	beq.b loc_00cf42
	addq.w #1,$106912

loc_00cf42:
	jsr loc_006974
	tst.w d0
	bne.w loc_00d128
	bsr.w loc_00d80a
	move.w #$40,d0
	btst #4,$101000
	bne.b loc_00cf64
	move.w #$a0,d0

loc_00cf64:
	cmp.w $106912,d0
	bcc.b loc_00cf7e
	move.w #3,$10690e
	clr.w $106910
	bsr.w loc_00da2e

loc_00cf7e:
	rts

;##############################################################################
loc_00cf80:
	bset #0,$106910
	bne.b loc_00cfd2
	clr.w $106912
	move.w #$ff,$106736
	lea.l $1066b0,a0
	lea.l loc_00d1b2(pc),a1
	nop
	moveq #$c,d7

loc_00cfa6:
	move.w (a1)+,(6,a0)
	move.w (a1)+,(8,a0)
	lea.l ($a,a0),a0
	dbra d7,loc_00cfa6
	clr.l $10673e
	move.b #$17,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_00cfd2:
	addq.w #1,$106912
	jsr loc_006974
	tst.w d0
	bne.w loc_00d128
	bsr.w loc_00dbe8
	bsr.w loc_00d1e6
	jsr loc_006cf8
	tst.w d0
	beq.b loc_00d004
	bsr.w loc_00dbe8
	bsr.w loc_00d1e6
	addq.w #1,$106912

loc_00d004:
	bsr.w loc_00d6ae
	bsr.w loc_00dc0c
	cmpi.w #$30,$106912
	bcs.b loc_00d024
	move.w #4,$10690e
	clr.w $106910

loc_00d024:
	rts

;##############################################################################
loc_00d026:
	bset #0,$106910
	bne.b loc_00d032
	nop

loc_00d032:
	jsr loc_006974
	tst.w d0
	bne.w loc_00d128
	bsr.w loc_00d6ae
	subi.w #$100,$1037c2
	subi.w #$100,$1039c2
	jsr loc_006cf8
	beq.b loc_00d06a
	subi.w #$100,$1037c2
	subi.w #$100,$1039c2

loc_00d06a:
	cmpi.w #$e800,$1037c2
	bhi.b loc_00d082
	move.w #5,$10690e
	clr.w $106910

loc_00d082:
	rts

;##############################################################################
loc_00d084:
	bset #0,$106910
	bne.b loc_00d0b0
	clr.w $106912
	bsr.w loc_00da68
	move.w #$4c00,$106738
	move.w #$b600,$10673a
	move.w #$110,$10673c

loc_00d0b0:
	addq.w #1,$106912
	jsr loc_006974
	tst.w d0
	bne.w loc_00d128
	jsr loc_006cf8
	tst.w d0
	beq.b loc_00d0d2
	addq.w #1,$106912

loc_00d0d2:
	bsr.w loc_00d6ae
	lea.l player1mem,a0
	bsr.w loc_00d9fa
	cmpi.w #$30,$106912
	bcs.b loc_00d106
	bne.b loc_00d102
	move.b #$44,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_00d102:
	bsr.w loc_00daee

loc_00d106:
	cmpi.w #$60,$106912
	bcs.b loc_00d11e
	bne.b loc_00d114
	nop

loc_00d114:
	lea.l player2mem,a0
	bsr.w loc_00d9fa

loc_00d11e:
	cmpi.w #$d0,$106912
	bcs.b loc_00d136

loc_00d128:
	move.w #6,$10690e
	clr.w $106910

loc_00d136:
	rts

;##############################################################################
loc_00d138:
	bset #0,$106910
	bne.b loc_00d15a
	nop
	move.b #1,$1068c6
	move.b #$a,$1068c7
	jsr loc_00e054
 
loc_00d15a:
	bsr.w loc_00d6ae
	bsr.w loc_00d654
	cmpi.w #$15,$106986
	bcs.b loc_00d1b0
	move.w #2,$106908
	bclr #4,$101000
	bclr #4,$101001
	clr.w $10690a
	clr.w $10690e
	clr.w $106910
	clr.w $10100c
	nop
	clr.b $103677
	clr.b $103877
	jsr loc_0095d2

loc_00d1b0:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00d1b2:
	dc.w $fb00,$0200,$fc00,$0200
	dc.w $fe00,$0200,$0200,$0200
	dc.w $0400,$0200,$0500,$0200
	dc.w $fb00,$0100,$fc00,$0100
	dc.w $fe00,$0100,$0000,$0100
	dc.w $0200,$0100,$0400,$0100
	dc.w $0500,$0100

;##############################################################################
loc_00d1e6:
	cmpi.w #$a,$106912
	bcs.b loc_00d230
	lea.l $1066b0,a0
	moveq #$c,d7

loc_00d1f8:
	move.w (2,a0),d1
	cmpi.w #$b000,d1
	bcs.b loc_00d208
	cmpi.w #$f000,d1
	bcs.b loc_00d210

loc_00d208:
	add.w (6,a0),d1
	move.w d1,(2,a0)

loc_00d210:
	cmpi.w #$4000,(4,a0)
	bcs.b loc_00d228
	move.w (8,a0),d2
	subi.w #$20,d2
	move.w d2,(8,a0)
	add.w d2,(4,a0)

loc_00d228:
	lea.l ($a,a0),a0
	dbra d7,loc_00d1f8

loc_00d230:
	rts

;##############################################################################
loc_00d232:
	moveq #0,d0
	lea.l player1mem,a0
	btst #0,$101000
	bne.b loc_00d24a
	bclr #1,($b8,a0)

loc_00d24a:
	cmpi.b #1,($4,a0)
	bne.b loc_00d258
	jsr loc_006ef8

loc_00d258:
	lea.l player2mem,a0
	btst #1,$101000
	bne.b loc_00d26e
	bclr #1,($b8,a0)

loc_00d26e:
	cmpi.b #1,(4,a0)
	bne.b loc_00d27c
	jsr loc_006f0e

loc_00d27c:
	lea.l player1mem,a0
	btst #0,$101000
	bne.b loc_00d298
	jsr loc_006cd8
	move.b d2,(1,a0)
	bra.b loc_00d2b2

loc_00d298:
	lea.l player2mem,a0
	btst #1,$101000
	bne.b loc_00d2b2
	jsr loc_006cd8
	move.b d2,(1,a0)

loc_00d2b2:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00d2b4:
	dc.b 'TIME',$ff,$0a

;##############################################################################
loc_00d2ba:
	lea.l VRAMADDR,a4
	bsr.w loc_00d3b0
	bset #3,$101001
	jsr loc_006f24
	move.w #2,(4,a4)
	move.w #$824e,(a4)
	moveq #$c,d7
	move.w #$40,d0

loc_00d2e2:
	move.w d0,(2,a4)
	dbra d7,loc_00d2e2
	moveq #0,d7
	lea.l loc_090020,a1
	lea.l $1340.w,a3
	lea.l VRAMADDR,a6
	move.w #1,(4,a6)

loc_00d302:
	move.w d7,d0
	addi.w #$e2a,d0
	bsr.w loc_00d5bc
	addq.w #1,d7
	cmpi.w #$d,d7
	bcs.b loc_00d302
	bclr #3,$101001
	lea.l player1mem,a1
	move.b (1,a1),d0
	cmp.b ($201,a1),d0
	bne.b loc_00d360
	btst #0,$101000
	bne.b loc_00d346
	move.b ($203,a1),d0
	addq.b #1,d0
	andi.b #1,d0
	move.b d0,(3,a1)
	bra.b loc_00d37e

loc_00d346:
	btst #1,$101000
	bne.b loc_00d37e
	move.b (3,a1),d0
	addq.b #1,d0
	andi.b #1,d0
	move.b d0,($203,a1)
	bra.b loc_00d37e

loc_00d360:
	btst #0,$101000
	bne.b loc_00d370
	clr.b (3,a1)
	bra.b loc_00d37e

loc_00d370:
	btst #1,$101000
	bne.b loc_00d37e
	clr.b ($203,a1)

loc_00d37e:
	lea.l loc_00ccfc(pc),a1
	lea.l $1066b0,a2
	moveq #0,d0
	moveq #$c,d7

loc_00d38c:
	move.w d0,(a2)+
	movem.w (a1)+,d1-d2
	move.w d1,(a2)+
	move.w d2,(a2)+
	move.l d0,(a2)+
	dbra d7,loc_00d38c
	lea.l $1066ac,a0
	move.b #$99,($86,a0)
	move.b #$10,($87,a0)
	rts

;##############################################################################
loc_00d3b0:
	bset #3,$101001
	lea.l $8242,a2
	moveq #0,d7

loc_00d3c0:
	cmpi.w #5,d7
	beq.b loc_00d3ce
	move.w a2,(a4)
	move.w #$40,(2,a4)

loc_00d3ce:
	lea.l (1,a2),a2
	addq.w #1,d7
	cmpi.w #$b,d7
	bcs.b loc_00d3c0
	bclr #3,$101001
	bsr.w loc_00d412
	btst #4,$101001
	beq.b loc_00d410
	btst #0,$101000
	bne.b loc_00d400
	move.w #$d000,($150,a1)

loc_00d400:
	btst #1,$101000
	bne.b loc_00d410
	move.w #$a000,($350,a1)

loc_00d410:
	rts

;##############################################################################
loc_00d412:
	lea.l player1mem,a1
	move.w #$c00,($150,a1)
	move.w #$6400,($350,a1)
	move.w #$f408,($152,a1)
	move.w #$f408,($352,a1)
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00d432:
	dc.b $00,$00,$04,$00,$06,$07,$05,$00
	dc.b $02,$01,$03,$00,$00,$00,$00,$00

loc_00d442:
	dc.b $06,$07,$01,$07,$06,$0c,$05,$0c
	dc.b $07,$08,$02,$08,$07,$06,$00,$06
	dc.b $08,$09,$03,$09,$08,$07,$01,$07
	dc.b $0a,$0b,$04,$0b,$0a,$09,$02,$09
	dc.b $0b,$0c,$05,$0c,$0b,$0a,$03,$0a
	dc.b $0c,$06,$00,$06,$0c,$0b,$04,$0b
	dc.b $00,$01,$07,$01,$00,$05,$0c,$05
	dc.b $01,$02,$08,$02,$01,$00,$06,$00
	dc.b $02,$09,$09,$09,$02,$01,$07,$01
	dc.b $09,$03,$0a,$03,$09,$02,$08,$02
	dc.b $03,$04,$0b,$04,$03,$09,$09,$09
	dc.b $04,$05,$0c,$05,$04,$03,$0a,$03
	dc.b $05,$00,$06,$00,$05,$04,$0b,$04

;##############################################################################
;Character Select
loc_00d4aa:
	btst #1,($b8,a1)
	bne.w loc_00d5ba
	move.b (a1),d0
	btst d0,$101000
	bne.b loc_00d4cc
	cmpi.w #$40,$106912
	beq.b loc_00d4d4
	bra.w loc_00d5ba

loc_00d4cc:
	tst.w $106732
	bne.b loc_00d4da

loc_00d4d4:
	move.b #$10,($b0,a1)

loc_00d4da:
	move.b ($b0,a1),d0
	andi.w #$f0,d0
	beq.w loc_00d57a
	move.b (a1),d1
	btst d1,$101000
	beq.b loc_00d4f8
	move.b (1,a1),(2,a1)
	bra.b loc_00d502

loc_00d4f8:
	btst #4,$101001
	bne.b loc_00d51e

loc_00d502:
	move.b (1,a1),d1
	addi.b #$4f,d1
	move.b d1,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_00d51e:
	clr.b (buttonset,a1)
	move.b BIOS_STATCURNT,d2
	cmpa.l #player1mem,a1
	bne.b player2set

	andi.w #$3,d2
	tst.b d2
	beq.b setskip
	bset #0,(buttonset,a1)
	bra.b setskip

player2set:
	andi.w #$c,d2
	tst.b d2
	beq.b setskip
	bset #0,(buttonset,a1)

setskip:
	lsr.w #4,d0
	bsr.w CharPalSelect
	move.b (a1),d1
	btst d1,$101000
	beq.b SamePalettePrevention
	move.b d0,(3,a1);Palette Write

SamePalettePrevention:
	bset #1,($b8,a1)
	movea.l ($14,a1),a2
	move.b (1,a1),d0
	cmp.b (1,a2),d0
	bne.w loc_00d5ba
	move.b $101000,d0
	andi.b #3,d0
	cmpi.b #3,d0
	bne.b loc_00d5ba;not vs mode
	move.b (3,a1),d0
	cmp.b (3,a2),d0
	bne.w loc_00d5ba
	btst #1,($b8,a2)
	beq.w loc_00d5ba
	addq.b #1,(3,a1)
	andi.b #7,(3,a1);amount of palettes
	bra.b loc_00d5ba

loc_00d57a:
	moveq #0,d0
	move.b ($b2,a1),d0
	andi.w #$f,d0
	beq.b loc_00d5ba
	lea.l loc_00d432(pc),a2
	move.b (a2,d0.w),d0
	moveq #0,d1
	move.b (1,a1),d1
	lsl.w #3,d1
	add.w d1,d0
	lea.l loc_00d442(pc),a2
	move.b (a2,d0.w),d0
	move.b d0,(1,a1)
	move.b #$c,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_00d5ba:
	jsr charpalwrite
	jsr portraitwrites
	rts

;##############################################################################
loc_00d5bc:
	lsl.w #2,d0
	movea.l (a1,d0.w),a4
	move.w (a4)+,d6
	andi.w #$ff,d6
	subq.w #1,d6

loc_00d5ca:
	move.w a3,(a6)
	move.w (a4)+,d5
	andi.w #$1f,d5
	subq.w #1,d5
	movem.w (a4)+,d1-d2

loc_00d5d8:
	move.w d1,(2,a6)
	addq.w #1,d1
	move.w d2,(2,a6)
	dbra d5,loc_00d5d8
	lea.l (4,a4),a4
	lea.l ($40,a3),a3
	dbra d6,loc_00d5ca
	rts

;##############################################################################
loc_00d5f4:
	lea.l player1mem,a0
	move.b #$40,($20,a0)
	lea.l player2mem,a0
	move.b #$50,($20,a0)
	rts

;old code
;	lea.l player1mem,a0
;	bsr.w loc_00d604
;	lea.l player2mem,a0
;
;loc_00d604:
;	move.b (3,a0),d0
;	andi.w #1,d0
;	lsl.w #4,d0
;	addi.w #$40,d0
;	move.b d0,($20,a0)
;	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00d618:
	dc.b $00 ;A			0
	dc.b $00 ;A+C+D		b	Start+A works as well
	dc.b $01 ;B			1
	dc.b $04 ;A+B		4
	dc.b $02 ;C			2
	dc.b $06 ;A+C		6
	dc.b $00 ;B+C		9
	dc.b $00 ;A+B+C		a
	dc.b $03 ;D			3
	dc.b $00 ;A+D		8
	dc.b $07 ;B+D		7
	dc.b $00 ;A+B+D		c
	dc.b $05 ;C+D		5
	dc.b $00 ;			f
	dc.b $00 ;B+C+D		d
	dc.b $00 ;A+B+C+D	e

;##############################################################################
CharPalSelect:
	andi.w #$f,d0
	move.b loc_00d618(pc,d0.w),d0
	rts

;##############################################################################
loc_00d632:
	cmpi.b #8,$103a72
	beq.b loc_00d652
	tst.w $106986
	beq.b loc_00d652
	move.w #$ff,d2
	bsr.w loc_00d66c
	subq.w #1,$106986

loc_00d652:
	rts

;##############################################################################
loc_00d654:
	cmpi.w #$16,$106986
	bcc.b loc_00d66a
	moveq #0,d2
	bsr.w loc_00d66c
	addq.w #1,$106986

loc_00d66a:
	rts

;##############################################################################
loc_00d66c:
	move.w $106986,d0
	cmpi.w #1,d0
	beq.b loc_00d6ac
	subq.w #1,d0
	lsl.w #5,d0
	move.w d0,d1
	addi.w #$7002,d0
	moveq #$1b,d7
	movea.l $101420,a0

loc_00d68a:
	move.w d0,(a0)+
	move.w d2,(a0)+
	addq.w #1,d0
	dbra d7,loc_00d68a
	neg.w d1
	addi.w #$74e2,d1
	moveq #$1b,d7

loc_00d69c:
	move.w d1,(a0)+
	move.w d2,(a0)+
	addq.w #1,d1
	dbra d7,loc_00d69c
	move.l a0,$101420

loc_00d6ac:
	rts

;##############################################################################
;Portraits
loc_00d6ae:;d6c2
	movea.l $101420,a6
	lea.l player1mem,a1
	lea.l $1040.w,a2
	move.w #$10e0,d0
	moveq #0,d6
;	move.b (3,a1),d6
;	andi.w #1,d6
;	mulu.w #$1400,d6
	moveq #0,d3
	bsr.w loc_00d760

;Player 2
	lea.l (playeroffset,a1),a1
	lea.l $11c0.w,a2
	move.w #$10e0,d0
;	moveq #0,d6
	moveq #1,d6
;	andi.w #1,d6
	mulu.w #$1400,d6
	move.w #1,d3
	bsr.w loc_00d760

	lea.l player1mem,a1
	move.w #$8441,(a6)+
	move.w ($150,a1),(a6)+
	move.w #$8447,(a6)+
	move.w ($350,a1),(a6)+
	move.w #$8241,(a6)+
	move.w ($152,a1),(a6)+
	move.w #$8247,(a6)+
	move.w ($352,a1),(a6)+
	lea.l $1066b0,a1
	lea.l $824d,a2
	lea.l $844d,a3
	moveq #$c,d7

loc_00d732:
	move.w (4,a1),d0
	andi.w #$ff80,d0
	ori.w #2,d0
	move.w a2,(a6)+
	move.w d0,(a6)+
	move.w a3,(a6)+
	move.w (2,a1),(a6)+
	lea.l ($a,a1),a1
	lea.l (2,a2),a2
	lea.l (2,a3),a3
	dbra d7,loc_00d732
	move.l a6,$101420
	rts

;##############################################################################
loc_00d760:
	lea.l loc_090020,a5
	moveq #0,d1
	move.b (1,a1),d1
	add.w d1,d0
	lsl.w #2,d0
	movea.l (a5,d0.w),a5
	move.w (a5)+,d7
	andi.w #$ff,d7
	subq.w #1,d7
	btst #0,d3
	beq.b loc_00d786
	lea.l ($140,a2),a2

loc_00d786:
	movea.l a2,a3
	move.w (a5)+,d0
	andi.w #$3f,d0
	move.w d0,d1
	lsl.w #2,d1
	move.w (a5,d1.w),d1
	neg.w d1
	lsr.w #4,d1
	move.w #8,d2
	sub.w d1,d2
	beq.b loc_00d7b8
	subq.w #1,d2

loc_00d7a4:
	move.w a3,(a6)+
	lea.l (1,a3),a3
	clr.w (a6)+
	move.w a3,(a6)+
	lea.l (1,a3),a3
	clr.w (a6)+
	dbra d2,loc_00d7a4

loc_00d7b8:
	subq.w #1,d0

loc_00d7ba:
	movem.w (a5)+,d1-d2
	move.w a3,(a6)+
	lea.l (1,a3),a3
	move.w d1,(a6)+
	move.w a3,(a6)+
	lea.l (1,a3),a3
	add.w d6,d2
	eor.w d3,d2
	move.w d2,(a6)+
	dbra d0,loc_00d7ba
	moveq #$17,d0

loc_00d7d8:
	move.w a3,(a6)+
	lea.l (1,a3),a3
	move.w #7,(a6)+
	move.w a3,(a6)+
	lea.l (1,a3),a3
	move.w #7,(a6)+
	dbra d0,loc_00d7d8
	lea.l (4,a5),a5
	btst #0,d3
	beq.b loc_00d800
	lea.l (-$40,a2),a2
	bra.b loc_00d804

loc_00d800:
	lea.l ($40,a2),a2

loc_00d804:
	dbra d7,loc_00d786
	rts

;##############################################################################
loc_00d80a:
	btst #4,$101000
	beq.w loc_00d8ba
	movea.l $10141c,a1
	lea.l loc_00ccfc(pc),a2
	move.l #$20000ea3,d0
	move.l #$22000ea4,d1
	btst #1,$103928
	beq.b loc_00d83c
	move.l #$1e000ea4,d1

loc_00d83c:
	btst #1,$103728
	bne.b loc_00d850
	btst #2,$10346b
	beq.b loc_00d878

loc_00d850:
	btst #0,$101000
	beq.b loc_00d878
	move.l d0,(a1)+
	moveq #0,d2
	move.b $103671,d2
	lsl.w #2,d2
	move.l (a2,d2.w),d2
	lsr.l #7,d2
	addi.l #$100000,d2
	subi.w #$18,d2
	move.l d2,(a1)+

loc_00d878:
	btst #1,$103928
	bne.b loc_00d88c
	btst #2,$10346b
	bne.b loc_00d8b4

loc_00d88c:
	btst #1,$101000
	beq.b loc_00d8b4
	move.l d1,(a1)+
	moveq #0,d2
	move.b $103871,d2
	lsl.w #2,d2
	move.l (a2,d2.w),d2
	lsr.l #7,d2
	addi.l #$100000,d2
	subi.w #$18,d2
	move.l d2,(a1)+

loc_00d8b4:
	move.l a1,$10141c

loc_00d8ba:
	rts

;##############################################################################
loc_00d8bc:
	btst #4,$101000
	beq.b loc_00d8ec
	move.w $10346a,d0
	lsr.w #2,d0
	andi.w #$c,d0
	beq.b loc_00d8ec
	movea.l $10141c,a1
	move.l #$80010fb,(a1)+
	move.l #$a00130,(a1)+
	move.l a1,$10141c

loc_00d8ec:
	rts

;##############################################################################
loc_00d8ee:
	lea.l $106732,a1
	tst.w (a1)
	beq.b loc_00d912
	subq.b #1,(1,a1)
	bcc.b loc_00d912
	move.b #$10,(1,a1)
	move.b (a1),d0
	beq.b loc_00d912
	moveq #1,d1
	andi.w #$ffef,sr
	sbcd.b d1,d0
	move.b d0,(a1)

loc_00d912:
	rts

;##############################################################################
loc_00d914:
	btst #4,$101000
	beq.b loc_00d94a
	movea.l $101420,a1
	lea.l $7256.w,a2
	rol.w #4,d1
	move.w d1,d0
	andi.w #$f,d0
	bsr.w loc_00d94c
	lea.l $7296.w,a2
	rol.w #4,d1
	move.w d1,d0
	andi.w #$f,d0
	bsr.w loc_00d94c
	move.l a1,$101420

loc_00d94a:
	rts

;##############################################################################
loc_00d94c:
	lsl.w #2,d0
	addi.w #$e492,d0
	move.w a2,(a1)+
	move.w d0,(a1)+
	lea.l (1,a2),a2
	addq.w #1,d0
	move.w a2,(a1)+
	move.w d0,(a1)+
	lea.l ($1f,a2),a2
	subq.w #3,d0
	move.w a2,(a1)+
	move.w d0,(a1)+
	lea.l (1,a2),a2
	addq.w #1,d0
	move.w a2,(a1)+
	move.w d0,(a1)+
	rts

;##############################################################################
loc_00d976:
	lea.l VRAMADDR,a6
	bset #3,$101001
	moveq #$12,d7
	move.w #1,(4,a6)
	move.w #$8222,(a6)
	moveq #$40,d0

loc_00d992:
	move.w d0,(2,a6)
	dbra d7,loc_00d992
	move.w #$3bf0,d0
	lea.l loc_090020,a3
	movea.l (a3,d0.w),a3
	moveq #$13,d7
	lea.l (2,a3),a3
	lea.l $840.w,a2
	move.w #$ff,d2

loc_00d9b6:
	move.w a2,(a6)
	move.w (a3)+,d6
	andi.w #$3f,d6
	subq.w #1,d6

loc_00d9c0:
	move.w (a3)+,(2,a6)
	move.w (a3)+,d1
	and.w d2,d1
	or.w d3,d1
	move.w d1,(2,a6)
	dbra d6,loc_00d9c0
	lea.l ($40,a2),a2
	lea.l (4,a3),a3
	dbra d7,loc_00d9b6
	move.w #$8221,(a6)
	move.w #$10,(2,a6)
	move.w #$8421,(a6)
	clr.w (2,a6)
	bclr #3,$101001
	rts

;##############################################################################
loc_00d9fa:
	movea.l $10141c,a2
	moveq #0,d0
	move.b (1,a0),d0
	addi.w #$10ff,d0
	ori.l #$20000000,d0
	move.l d0,(a2)+
	tst.b (a0)
	bne.b loc_00da1e
	move.l #$5000f8,d0
	bra.b loc_00da24

loc_00da1e:
	move.l #$f000f8,d0

loc_00da24:
	move.l d0,(a2)+
	move.l a2,$10141c
	rts

;##############################################################################
loc_00da2e:
	btst #4,$101000
	beq.w loc_00da66
	movea.l $101420,a1
	lea.l $7255.w,a2
	move.w #$ff,d0
	moveq #3,d7

loc_00da4a:
	moveq #2,d6

loc_00da4c:
	move.w a2,(a1)+
	move.w d0,(a1)+
	lea.l (1,a2),a2
	dbra d6,loc_00da4c
	lea.l ($1d,a2),a2
	dbra d7,loc_00da4a
	move.l a1,$101420

loc_00da66:
	rts

;##############################################################################
loc_00da68:
	movea.l $101420,a6
	lea.l $5440.w,a2
	move.w #$3a94,d0
	lea.l loc_090020,a5
	movea.l (a5,d0.w),a5
	move.w (a5)+,d7
	andi.w #$ff,d7
	subq.w #1,d7

loc_00da88:
	move.w (a5)+,d6
	andi.w #$3f,d6
	moveq #$20,d5
	sub.w d6,d5
	subq.w #1,d5
	subq.w #1,d6
	movem.w (a5)+,d0-d1

loc_00da9a:
	move.w a2,(a6)+
	move.w d0,(a6)+
	lea.l (1,a2),a2
	move.w a2,(a6)+
	move.w d1,(a6)+
	lea.l (1,a2),a2
	addq.w #1,d0
	dbra d6,loc_00da9a
	moveq #$3f,d0
	moveq #0,d1

loc_00dab4:
	move.w a2,(a6)+
	move.w d0,(a6)+
	lea.l (1,a2),a2
	move.w a2,(a6)+
	move.w d1,(a6)+
	lea.l (1,a2),a2
	dbra d5,loc_00dab4
	lea.l (4,a5),a5
	dbra d7,loc_00da88
	lea.l $8352,a2
	moveq #$40,d0
	moveq #3,d7

loc_00dada:
	move.w a2,(a6)+
	move.w d0,(a6)+
	lea.l (1,a2),a2
	dbra d7,loc_00dada
	move.l a6,$101420
	rts

;##############################################################################
loc_00daee:
	movea.l $101420,a6
	cmpi.w #$ff0,$10673c
	bcc.b loc_00db2a
	jsr loc_006cf8

loc_00db04:
	subi.w #$200,$106738
	addi.w #$200,$10673a
	addi.w #$220,$10673c
	cmpi.w #$ff0,$10673c
	beq.b loc_00db2a
	dbra d0,loc_00db04

loc_00db2a:
	lea.l $1066ac,a1
	move.w #$8351,(a6)+
	move.w ($8e,a1),d0
	ori.w #4,d0
	move.w d0,(a6)+
	move.w #$8551,(a6)+
	move.w ($8c,a1),(a6)+
	lea.l $8151,a2
	move.w ($90,a1),d0
	moveq #4,d7

loc_00db52:
	move.w a2,(a6)+
	lea.l (1,a2),a2
	move.w d0,(a6)+
	dbra d7,loc_00db52
	move.l a6,$101420
	rts

;##############################################################################
loc_00db66:
	movea.l $101420,a6
	lea.l $1341.w,a2
	moveq #0,d0
	move.w $101018,d1
	move.b $103671,d2
	move.b $103871,d3

loc_00db84:
	move.b $101000,d4
	andi.b #3,d4
	cmpi.b #3,d4
	beq.b loc_00dbaa
	btst d0,d1
	beq.b loc_00dbaa
	btst #4,$101000
	beq.b loc_00dbb0
	cmp.b d0,d2
	beq.b loc_00dbaa
	cmp.b d0,d3
	bne.b loc_00dbb0

loc_00dbaa:
	move.w #$21,d4
	bra.b loc_00dbb4

loc_00dbb0:
	move.w #$31,d4

loc_00dbb4:
	add.w d0,d4
	lsl.w #8,d4
	move.w a2,(a6)+
	move.w d4,(a6)+
	lea.l (2,a2),a2
	move.w a2,(a6)+
	move.w d4,(a6)+
	lea.l ($3e,a2),a2
	move.w a2,(a6)+
	move.w d4,(a6)+
	lea.l (2,a2),a2
	move.w a2,(a6)+
	move.w d4,(a6)+
	lea.l ($3e,a2),a2
	addq.w #1,d0
	cmpi.w #$c,d0
	bls.b loc_00db84
	move.l a6,$101420
	rts

;##############################################################################
loc_00dbe8:
	lea.l $1066ac,a1
	cmpi.w #$d,($92,a1)
	bcc.b loc_00dc0a
	addq.w #1,($94,a1)
	cmpi.w #3,($94,a1)
	bcs.b loc_00dc0a
	clr.w ($94,a1)
	addq.w #1,($92,a1)

loc_00dc0a:
	rts

;##############################################################################
loc_00dc0c:
	move.w $10673e,d0
	cmpi.w #9,d0
	bcc.b loc_00dc38
	movea.l $10141c,a6
	addi.w #$257,d0
	swap d0
	move.w #$3000,d0
	swap d0
	move.l d0,(a6)+
	move.l #$a00140,(a6)+
	move.l a6,$10141c

loc_00dc38:
	rts

;##############################################################################
;Memory Clear
loc_00dc3a:
	moveq #0,d0
	lea.l $1066ac,a0
	moveq #$7f,d7

loc_00dc44:
	move.l d0,(a0)+
	dbra d7,loc_00dc44
	rts

;##############################################################################
loc_00dc4c:
	lea.l player1mem,a0
	lea.l (playeroffset,a0),a1
	move.b $101000,d0
	andi.b #3,d0
	cmpi.b #3,d0
	beq.b loc_00dc90;not versus

	move.b (1,a0),d0
	cmp.b (1,a1),d0
	bne.b loc_00dc90
	move.b (3,a0),d0
	cmp.b (3,a1),d0
	bne.b loc_00dc90
	btst #0,$101000
	beq.b loc_00dc86
	movea.l a1,a0

loc_00dc86:
	addq.b #1,(3,a0)
	andi.b #1,(3,a0)

loc_00dc90:
	rts

;##############################################################################
loc_00dc92:
	lea.l player1mem,a0
	bsr.w loc_00e024
	movea.l $101420,a1
	bset #0,$101006
	bne.b loc_00dcfa
	jsr FIX_CLEAR
	lea.l player1mem,a0
	move.b #0,($28,a0)
	move.b #0,($2b,a0)
	move.l #0,($2c,a0)
	move.b #$ff,($c0,a0)
	move.w #$232a,d2
	bsr.w loc_00dd7a
	move.b #4,($28,a0)
	lea.l ($2f,a0),a3

loc_00dce4:
	bsr.w loc_00dd8c
	lea.l (-1,a3),a3
	subq.b #1,($28,a0)
	bcc.b loc_00dce4
	clr.b ($28,a0)
	bsr.w loc_00dfee

loc_00dcfa:
	bsr.w loc_00dd0a
	bsr.w loc_00ddc2
	move.l a1,$101420
	rts

;##############################################################################
loc_00dd0a:
	move.b ($b6,a0),d0
	move.b ($28,a0),d1
	cmpi.b #1,d0
	bne.b loc_00dd26
	tst.b d1
	bne.b loc_00dd22
	move.b #5,d1
	bra.b loc_00dd38

loc_00dd22:
	subq.b #1,d1
	bra.b loc_00dd38

loc_00dd26:
	cmpi.b #2,d0
	bne.b loc_00dd4e
	cmpi.b #5,d1
	bcs.b loc_00dd36
	clr.b d1
	bra.b loc_00dd38

loc_00dd36:
	addq.b #1,d1

loc_00dd38:
	move.w #$ff,d2
	bsr.w loc_00dd7a
	move.b d1,($28,a0)
	move.w #$232a,d2
	bsr.w loc_00dd7a
	bra.b loc_00dd78

loc_00dd4e:
	cmpi.b #4,d0
	beq.b loc_00dd5a
	cmpi.b #8,d0
	bne.b loc_00dd78

loc_00dd5a:
	cmpi.b #5,d1
	beq.b loc_00dd78
	andi.w #$ff,d1
	lea.l ($2b,a0,d1.w),a3
	btst #2,d0
	beq.b loc_00dd72
	subq.b #1,(a3)
	bra.b loc_00dd74

loc_00dd72:
	addq.b #1,(a3)

loc_00dd74:
	bsr.w loc_00dd8c

loc_00dd78:
	rts

;##############################################################################
loc_00dd7a:
	lea.l $718e.w,a3
	moveq #0,d3
	move.b ($28,a0),d3
	adda.w d3,a3
	move.w a3,(a1)+
	move.w d2,(a1)+
	rts

;##############################################################################
loc_00dd8c:
	lea.l $72ee.w,a2
	moveq #0,d3
	move.b ($28,a0),d3
	adda.w d3,a2
	move.b (a3),d4
	moveq #1,d7

loc_00dd9c:
	rol.b #4,d4
	move.b d4,d5
	andi.w #$f,d5
	addi.w #$330,d5
	cmpi.w #$33a,d5
	bcs.b loc_00ddb0
	addq.w #7,d5

loc_00ddb0:
	move.w a2,(a1)+
	addi.w #$2000,d5
	move.w d5,(a1)+
	lea.l ($20,a2),a2
	dbra d7,loc_00dd9c
	rts

;##############################################################################
loc_00ddc2:
	move.b ($b6,a0),d0
	move.b d0,d1
	andi.b #$f0,d1
	cmpi.b #5,($28,a0)
	bne.b loc_00de12
	tst.b d1
	beq.w loc_00de12
	move.w #1,mainmode
	clr.w $101004
	clr.w $101006
	clr.w $106908
	clr.w $10690a
	clr.w $10690c
	move.b #3,$1068c6
	jsr loc_00ded2(pc)
	nop
	bra.w loc_00ded0

loc_00de12:
	cmpi.b #$10,d0
	bne.b loc_00de58
	move.b ($c0,a0),d2
	cmp.b ($2b,a0),d2
	bne.b loc_00de3a
	move.b #$15,$1068c6
	jsr loc_00ded2(pc)
	nop
	move.b #$ff,($c0,a0)
	bra.w loc_00deb0

loc_00de3a:
	move.b ($2b,a0),$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054(pc)
	nop
	move.b ($2b,a0),($c0,a0)
	bra.b loc_00deb0

loc_00de58:
	cmpi.b #$20,d0
	bne.b loc_00de76
	move.b ($2c,a0),$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054(pc)
	nop
	bra.b loc_00deb0

loc_00de76:
	cmpi.b #$40,d0
	bne.b loc_00de94
	move.b ($2d,a0),$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054(pc)
	nop
	bra.b loc_00deb0

loc_00de94:
	cmpi.b #$80,d0
	bne.b loc_00deb0
	move.b ($2e,a0),$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054(pc)
	nop

loc_00deb0:
	btst #0,BIOS_STATCURNT
	beq.b loc_00ded0
	move.b ($2f,a0),$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054(pc)
	nop

loc_00ded0:
	rts

;##############################################################################
loc_00ded2:
	bsr.w loc_00e0d8
	cmpi.b #$ff,$1068c6
	beq.w loc_00df28
	movem.l d0/a0-a2,-(a7)
	lea.l $1068ac,a0
	tst.b ($19,a0)
	beq.b loc_00df24
	movea.l ($10,a0),a1
	movea.l ($14,a0),a2
	move.b $1068c6,(a2)+
	cmpa.l #$1068bc,a2
	bcs.b loc_00df0e
	lea.l $1068ac,a2

loc_00df0e:
	cmpa.l a1,a2
	bne.b loc_00df16
	clr.b ($19,a0)

loc_00df16:
	move.b #1,($18,a0)
	move.l a1,($10,a0)
	move.l a2,($14,a0)

loc_00df24:
	movem.l (a7)+,d0/a0-a2

loc_00df28:
	rts

;##############################################################################
loc_00df2a:
	move.w $100068,d0
	beq.b loc_00df70
	cmpi.w #2,d0
	bne.b loc_00df52
	tst.b $1068c4
	bne.b loc_00df70
	subq.w #1,$100068
	move.b #$18,SOUNDREG
	bra.w loc_00dfbe

loc_00df52:
	cmpi.b #1,d0
	bne.b loc_00df6a
	subq.w #1,$100068
	move.b #1,SOUNDREG
	bra.w loc_00dfbe

loc_00df6a:
	clr.w $100068

loc_00df70:
	lea.l $1068ac,a0
	tst.b ($18,a0)
	beq.w loc_00dfbe
	movea.l ($10,a0),a1
	movea.l ($14,a0),a2
	moveq #0,d0
	move.b (a1),d0
	clr.b (a1)+
	movem.l d0/a0,-(a7)
	move.b d0,SOUNDREG
	movem.l (a7)+,d0/a0
	cmpa.l #$1068bc,a1
	bcs.b loc_00dfa8
	lea.l $1068ac,a1

loc_00dfa8:
	cmpa.l a1,a2
	bne.b loc_00dfb0
	clr.b ($18,a0)

loc_00dfb0:
	move.b #1,($19,a0)
	move.l a1,($10,a0)
	move.l a2,($14,a0)

loc_00dfbe:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00dfc0:
	dc.b "BGM",$fe
	dc.b "PCMA(SE)1",$fe
	dc.b "PCMA(SE)2",$fe
	dc.b "PCMB(SE)",$fe
	dc.b "DIRECT",$fe
	dc.b "EXIT",$ff,$42

;##############################################################################
loc_00dfee:
	lea.l loc_00dfc0(pc),a2
	lea.l $71ae.w,a3
	bsr.w loc_00dffc
	rts

;##############################################################################
;Text Render 1
loc_00dffc:
	movea.l a3,a4

loc_00dffe:
	moveq #0,d0
	move.b (a2)+,d0
	cmpi.w #$fe,d0
	bne.b loc_00e00e
	lea.l (1,a3),a3
	bra.b loc_00dffc

loc_00e00e:
	cmpi.w #$ff,d0
	bne.b loc_00e016
	rts

loc_00e016:
	addi.w #$2300,d0
	move.w a4,(a1)+
	move.w d0,(a1)+
	lea.l ($20,a4),a4
	bra.b loc_00dffe

;##############################################################################
loc_00e024:
	move.b ($30,a0),d0
	move.b ($31,a0),d1
	move.b d0,($b6,a0)
	cmp.b d0,d1
	beq.b loc_00e03a
	clr.b ($b7,a0)
	bra.b loc_00e052

loc_00e03a:
	addq.b #1,($b7,a0)
	cmpi.b #$21,($b7,a0)
	bcs.b loc_00e04e
	move.b #$20,($b7,a0)
	bra.b loc_00e052

loc_00e04e:
	clr.b ($b6,a0)

loc_00e052:
	rts

;##############################################################################
loc_00e054:
	bsr.w loc_00e0d8
	cmpi.b #$ff,$1068c6
	beq.b loc_00e0d6
	movem.l d0/a0-a2,-(a7)
	lea.l $1068ac,a0
	tst.b ($19,a0)
	beq.b loc_00e0d2
	movea.l ($10,a0),a1
	movea.l ($14,a0),a2
	lea.l (1,a2),a2
	cmpa.l #$1068bc,a2
	bcs.b loc_00e08c
	lea.l $1068ac,a2

loc_00e08c:
	cmpa.l a1,a2
	beq.b loc_00e0d2
	movea.l ($14,a0),a2
	move.b $1068c7,(a2)+
	cmpa.l #$1068bc,a2
	bcs.b loc_00e0a8
	lea.l $1068ac,a2

loc_00e0a8:
	move.b $1068c6,(a2)+
	cmpa.l #$1068bc,a2
	bcs.b loc_00e0bc
	lea.l $1068ac,a2

loc_00e0bc:
	cmpa.l a1,a2
	bne.b loc_00e0c4
	clr.b ($19,a0)

loc_00e0c4:
	move.b #1,($18,a0)
	move.l a1,($10,a0)
	move.l a2,($14,a0)

loc_00e0d2:
	movem.l (a7)+,d0/a0-a2

loc_00e0d6:
	rts

;##############################################################################
loc_00e0d8:
	cmpi.w #9,mainmode
	beq.b loc_00e108
	cmpi.b #2,BIOS_USER_MODE
	beq.b loc_00e108
	tst.b BIOS_MVS_FLAG
	beq.b loc_00e108
	tst.b soundstop
	bne.w loc_00e126
	tst.b BIOS_GAMEDIP_03
	bne.w loc_00e126

loc_00e108:
	cmpi.b #$ff,$1068c6
	beq.b loc_00e11a
	tst.b $1068c6
	bne.b loc_00e124

loc_00e11a:
	move.b #3,SOUNDREG
	bra.b loc_00e126

loc_00e124:
	bra.b loc_00e12e

loc_00e126:
	move.b #$ff,$1068c6

loc_00e12e:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00e130:
	dc.l loc_00e15c,loc_00e15c,loc_00e166,loc_00e170
	dc.l loc_00e17a,loc_00e184,loc_00e18e,loc_00e198
	dc.l loc_00e1a2,loc_00e1ac,loc_00e1b6

loc_00e15c:
	dc.w $1803,$1904,$1a02,$1b04,$ffff

loc_00e166:
	dc.w $1c03,$1d03,$1e03,$1f04,$ffff

loc_00e170:
	dc.w $2003,$2103,$2203,$2304,$ffff

loc_00e17a:
	dc.w $2403,$2503,$2603,$2704,$ffff

loc_00e184:
	dc.w $0003,$0104,$0202,$0304,$ffff

loc_00e18e:
	dc.w $0803,$0904,$0a02,$0b04,$ffff

loc_00e198:
	dc.w $1003,$1104,$1202,$1304,$ffff

loc_00e1a2:
	dc.w $0403,$0504,$0602,$0704,$ffff

loc_00e1ac:
	dc.w $0c03,$0d04,$0e02,$0f04,$ffff

loc_00e1b6:
	dc.w $1403,$1504,$1602,$1704,$ffff

;##############################################################################
loc_00e1c0:
	lea.l $1068c8,a1
	moveq #3,d7

loc_00e1c8:
	tst.w (a1)
	beq.b loc_00e1d6
	lea.l ($c,a1),a1
	dbra d7,loc_00e1c8
	rts

loc_00e1d6:
	movem.w d0-d2,(a1)
	moveq #0,d1
	move.w d1,($6,a1)
	move.w d1,($8,a1)
	lea.l loc_00e130(pc),a2
	lsl.w #2,d0
	movea.l (a2,d0.w),a2
	moveq #0,d3
	move.b (a2),d3
	addi.w #$13c,d3
	move.w d3,($a,a1)
	rts

;##############################################################################
loc_00e1fc:
	lea.l $1068c8,a0
	moveq #3,d7

loc_00e204:
	move.w (a0),d0
	tst.w d0
	bne.b loc_00e214

loc_00e20a:
	lea.l ($c,a0),a0
	dbra d7,loc_00e204
	rts

loc_00e214:
	addq.w #1,(8,a0)
	movem.w (6,a0),d1-d2
	lea.l loc_00e130(pc),a2
	lsl.w #2,d0
	movea.l (a2,d0.w),a2
	cmp.b (1,a2,d1.w),d2
	bcs.b loc_00e24e
	clr.w (8,a0)
	addq.w #2,(6,a0)
	moveq #0,d3
	move.b (2,a2,d1.w),d3
	cmpi.b #$ff,d3
	bne.b loc_00e246
	clr.w (a0)
	bra.b loc_00e24e

loc_00e246:
	addi.w #$13c,d3
	move.w d3,($a,a0)

loc_00e24e:
	bra.b loc_00e20a

;##############################################################################
loc_00e250:
	lea.l $1068c8,a0
	lea.l $162.w,a4
	movea.l $101420,a5
	moveq #3,d7

loc_00e262:
	move.w (a0),d0
	tst.w d0
	bne.b loc_00e290

loc_00e268:
	lea.l ($c,a0),a0
	dbra d7,loc_00e262

loc_00e270:
	cmpa.w #$16a,a4
	bcc.b loc_00e288
	movea.l a4,a3
	adda.l #$8201,a3
	move.w a3,(a5)+
	clr.w (a5)+
	lea.l (1,a4),a4
	bra.b loc_00e270

loc_00e288:
	move.l a5,$101420
	rts

loc_00e290:
	lea.l loc_090020,a6
	move.w ($a,a0),d1
	move.w (2,a0),d0
	sub.w $103424,d0
	swap d0
	move.w (4,a0),d0
	addi.w #$120,d0
	sub.w $103428,d0
	sub.w $106928,d0
	andi.l #$ffff,d1
	movem.l d7/a0,-(a7)
	jsr loc_00ad16
	movem.l (a7)+,d7/a0
	bra.b loc_00e268

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00e2d0:
	dc.b "PRESENTED BY DATA EAST",$ff

loc_00e2e7:
	dc.b "THANK YOU",$ff

loc_00e2f1:
	dc.b "FOR YOUR PLAYING",$ff

;##############################################################################
loc_00e302:
	addq.w #1,$10690a
	cmpi.w #1,$10690a
	bne.w loc_00e32e
	jsr loc_006be6
	move.w #$700,d3
	jsr loc_00d976
	clr.w $10690c
	bra.w loc_00e3dc

loc_00e32e:
	move.w $10690a,d0
	cmpi.w #$a,d0
	bcs.w loc_00e3c4
	cmpi.w #$40,d0
	bcc.w loc_00e39a
	jsr loc_00d632
	tst.w $106986
	bne.w loc_00e3c4
	move.w #$40,$10690a
	movea.l $101420,a1
	lea.l loc_00e2d0(pc),a2
	lea.l $7132.w,a3
	jsr loc_00dffc
	move.l a1,$101420
	move.w #$2000,d0
	lea.l loc_00e2e7(pc),a1
	lea.l $7167.w,a2
	jsr loc_006f88
	lea.l loc_00e2f1(pc),a1
	lea.l $708a.w,a2
	jsr loc_006f88
	bra.w loc_00e3c4

loc_00e39a:
	jsr loc_00e5fa(pc)
	nop
	tst.w d0
	bne.w loc_00e3b6
	addq.w #1,$10690c
	cmpi.w #$f8,$10690c
	bcs.b loc_00e3c4

loc_00e3b6:
	move.w #5,$106908
	clr.w $10690a

loc_00e3c4:
	movea.l $10141c,a6
	move.l #$c000112e,(a6)+
	move.l #$a00100,(a6)+
	move.l a6,$10141c

loc_00e3dc:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00e3de:
	dc.b "1 COIN ALL CLEARED!",$ff

;##############################################################################
loc_00e3f2:
	addq.w #1,$10690a
	cmpi.w #1,$10690a
	bne.w loc_00e426
	jsr loc_006be6
	move.w #$700,d3
	jsr loc_00d976
	clr.w $10690c
	move.w #$15,$106986
	bra.w loc_00e5f8

loc_00e426:
	move.w $10690a,d0
	cmpi.w #$a,d0
	bcs.w loc_00e5f8
	cmpi.w #$40,d0
	bcc.w loc_00e4e6
	jsr loc_00d632
	tst.w $106986
	bne.w loc_00e5f8
	move.w #$40,$10690a
	movea.l $101420,a1
	lea.l loc_00e3de(pc),a2
	lea.l $71ca.w,a3
	jsr loc_00dffc
	move.l a1,$101420
	movea.l $101420,a6
	lea.l $71c6.w,a2
	lea.l asciinames,a5
	move.w $10673a,d0
	lsl.w #4,d0
	lea.l (a5,d0.w),a5

loc_00e48a:
	moveq #0,d2
	move.b (a5)+,d2
	cmpi.w #$20,d2
	beq.b loc_00e4a6
	subi.w #$41,d2
	lsl.w #2,d2
	addi.w #$2428,d2
	jsr loc_006f5c
	bra.b loc_00e48a

loc_00e4a6:
	move.l a6,$101420
	move.w #$c6,d0
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_00e4bc
	addi.w #$c8,d0

loc_00e4bc:
	lsl.w #2,d0
	lea.l loc_02e000,a2
	lea.l $1066ac,a0
	move.l (a2,d0.w),(a0)
	lea.l $708d.w,a2
	move.w a2,(4,a0)
	move.w a2,($a,a0)
	clr.w (6,a0)
	clr.w (8,a0)
	bra.w loc_00e5f8

loc_00e4e6:
	jsr loc_00e5fa(pc)
	nop
	tst.w d0
	bne.w loc_00e5ea
	addq.w #1,$10690c
	cmpi.w #$ba,$10690c
	bne.b loc_00e53c
	movea.l $101420,a1
	lea.l loc_00e2d0(pc),a2
	lea.l $713a.w,a3
	jsr loc_00dffc
	move.l a1,$101420
	move.w #$2000,d0
	lea.l loc_00e2e7(pc),a1
	lea.l $7174.w,a2
	jsr loc_006f88
	lea.l loc_00e2f1(pc),a1
	lea.l $7097.w,a2
	jsr loc_006f88

loc_00e53c:
	cmpi.w #$1b2,$10690c
	bcc.w loc_00e5ea
	movea.l $10141c,a6
	moveq #0,d0
	move.b $103671,d0
	btst #7,$103728
	beq.b loc_00e566
	move.b $103871,d0

loc_00e566:
	addi.l #$c0001222,d0
	move.l d0,(a6)+
	move.l #$4001a0,(a6)+
	move.l a6,$10141c
	lea.l $1066ac,a0
	cmpi.w #2,(8,a0)
	beq.w loc_00e5f8
	subq.w #1,(6,a0)
	bcc.b loc_00e5f8
	movea.l (a0),a1
	movea.w (4,a0),a2
	lea.l loc_0070c8,a5
	moveq #0,d0
	moveq #0,d4
	movea.l $101420,a6
	jsr loc_0081c2
	move.l a6,$101420
	move.l a1,(a0)
	move.w a2,(4,a0)
	move.w d0,(8,a0)
	move.w #3,(6,a0)
	cmpi.w #1,(8,a0)
	bne.w loc_00e5f8
	move.w ($a,a0),d0
	tst.b BIOS_COUNTRY_CODE
	bne.b loc_00e5dc
	addq.w #3,d0
	bra.b loc_00e5de

loc_00e5dc:
	addq.w #2,d0

loc_00e5de:
	move.w d0,(4,a0)
	move.w d0,($a,a0)
	bra.w loc_00e5f8

loc_00e5ea:
	move.w #5,$106908
	clr.w $10690a

loc_00e5f8:
	rts

;##############################################################################
loc_00e5fa:
	moveq #0,d0
	lea.l player1mem,a0
	btst #7,($b8,a0)
	bne.b loc_00e618
	btst #0,BIOS_STATCURNT
	beq.b loc_00e618

loc_00e614:
	moveq #1,d0
	bra.b loc_00e62e

loc_00e618:
	lea.l (playeroffset,a0),a0
	btst #7,($b8,a0)
	bne.b loc_00e62e
	btst #2,BIOS_STATCURNT
	bne.b loc_00e614

loc_00e62e:
	rts

;##############################################################################
loc_00e630:
	nop
	lea.l $103a78,a1
	btst #0,(a1)
	beq.w loc_00e704
	btst #2,(a1)
	bne.b loc_00e64a
	bset #2,(a1)

loc_00e64a:
	moveq #4,d0
	lea.l $103a7c,a2
	move.b (2,a1),d5
	addq.b #2,d5
	move.b d5,(2,a1)

loc_00e65c:
	btst d0,(a1)
	beq.w loc_00e6f6
	moveq #0,d1
	move.w (a2)+,d1
	lsl.l #5,d1
	lea.l loc_065000,a3
	adda.l d1,a3
	moveq #0,d3
	move.b (a2)+,d3
	lsl.l #5,d3
	lea.l $103a98,a4
	adda.l d3,a4
	move.b (a2)+,d6
	add.w d6,d6
	addq.w #1,d6
	lea.l loc_00e7ce(pc),a5
	nop

loc_00e68a:
	move.w #$f,d7

loc_00e68e:
	move.w (a3)+,d1
	move.w d1,d2
	move.w d1,d3
	move.w d1,d4
	andi.w #$f,d2
	andi.w #$f0,d3
	andi.w #$f00,d4
	lsl.w #2,d2
	lsr.w #2,d3
	lsr.w #6,d4
	btst #$c,d1
	beq.b loc_00e6b0
	addq.w #2,d2

loc_00e6b0:
	btst #$d,d1
	beq.b loc_00e6b8
	addq.w #2,d3

loc_00e6b8:
	btst #$e,d1
	beq.b loc_00e6c0
	addq.w #2,d4

loc_00e6c0:
	cmp.b d5,d2
	bmi.b loc_00e6c6
	move.b d5,d2

loc_00e6c6:
	cmp.b d5,d3
	bmi.b loc_00e6cc
	move.b d5,d3

loc_00e6cc:
	cmp.b d5,d4
	bmi.b loc_00e6d2
	move.b d5,d4

loc_00e6d2:
	move.w (a5,d2.w),d2
	addi.w #$40,d3
	move.w (a5,d3.w),d3
	addi.w #$80,d4
	move.w (a5,d4.w),d4
	or.w d2,d3
	or.w d3,d4
	move.w d4,(a4)+
	dbra d7,loc_00e68e
	subq.b #1,d6
	bne.w loc_00e68a

loc_00e6f6:
	addq.w #1,d0
	cmpi.w #8,d0
	bmi.w loc_00e65c
	bra.w loc_00e7cc

loc_00e704:
	btst #1,(a1)
	beq.w loc_00e7cc
	btst #3,(a1)
	bne.b loc_00e716
	bset #3,(a1)

loc_00e716:
	moveq #4,d0
	lea.l $103a7c,a2
	move.b (2,a1),d5
	addq.b #2,d5
	move.b d5,(2,a1)

loc_00e728:
	btst d0,(a1)
	beq.w loc_00e7c2
	moveq #0,d1
	move.w (a2)+,d1
	lsl.l #5,d1
	lea.l loc_065000,a3
	adda.l d1,a3
	moveq #0,d3
	move.b (a2)+,d3
	lsl.l #5,d3
	lea.l $103a98,a4
	adda.l d3,a4
	move.b (a2)+,d6
	add.w d6,d6
	addq.w #1,d6
	lea.l loc_00e7ce(pc),a5
	nop

loc_00e756:
	move.w #$f,d7

loc_00e75a:
	move.w (a4),d1
	move.w d1,d2
	move.w d1,d3
	move.w d1,d4
	andi.w #$f,d2
	andi.w #$f0,d3
	andi.w #$f00,d4
	lsl.w #2,d2
	lsr.w #2,d3
	lsr.w #6,d4
	btst #$c,d1
	beq.b loc_00e77c
	addq.w #2,d2

loc_00e77c:
	btst #$d,d1
	beq.b loc_00e784
	addq.w #2,d3

loc_00e784:
	btst #$e,d1
	beq.b loc_00e78c
	addq.w #2,d4

loc_00e78c:
	subq.b #2,d2
	bpl.b loc_00e792
	moveq #0,d2

loc_00e792:
	subq.b #2,d3
	bpl.b loc_00e798
	moveq #0,d3

loc_00e798:
	subq.b #2,d4
	bpl.b loc_00e79e
	moveq #0,d4

loc_00e79e:
	move.w (a5,d2.w),d2
	addi.w #$40,d3
	move.w (a5,d3.w),d3
	addi.w #$80,d4
	move.w (a5,d4.w),d4
	or.w d2,d3
	or.w d3,d4
	move.w d4,(a4)+
	dbra d7,loc_00e75a
	subq.b #1,d6
	bne.w loc_00e756

loc_00e7c2:
	addq.w #1,d0
	cmpi.w #8,d0
	bmi.w loc_00e728

loc_00e7cc:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00e7ce:
	dc.w $0000,$1000,$0001,$1001,$0002,$1002,$0003,$1003
	dc.w $0004,$1004,$0005,$1005,$0006,$1006,$0007,$1007
	dc.w $0008,$1008,$0009,$1009,$000a,$100a,$000b,$100b
	dc.w $000c,$100c,$000d,$100d,$000e,$100e,$000f,$100f

loc_00e80e:
	dc.w $0000,$2000,$0010,$2010,$0020,$2020,$0030,$2030
	dc.w $0040,$2040,$0050,$2050,$0060,$2060,$0070,$2070
	dc.w $0080,$2080,$0090,$2090,$00a0,$20a0,$00b0,$20b0
	dc.w $00c0,$20c0,$00d0,$20d0,$00e0,$20e0,$00f0,$20f0

loc_00e84e:
	dc.w $0000,$4000,$0100,$4100,$0200,$4200,$0300,$4300
	dc.w $0400,$4400,$0500,$4500,$0600,$4600,$0700,$4700
	dc.w $0800,$4800,$0900,$4900,$0a00,$4a00,$0b00,$4b00
	dc.w $0c00,$4c00,$0d00,$4d00,$0e00,$4e00,$0f00,$4f00

;##############################################################################
loc_00e88e:
	nop
	bra.w loc_00e9d0

	lea.l stageid,a1
	move.w (a1),d0
	lea.l loc_00e8cc(pc),a3
	nop
	move.w d0,d1
	lsl.w #4,d0
	add.w d1,d1
	add.w d1,d1
	add.w d1,d0
	adda.w d0,a3
	lea.l $103a78,a4
	move.l (a3)+,(a4)+
	move.l (a3)+,(a4)+
	move.l (a3)+,(a4)+
	move.l (a3)+,(a4)+
	move.l (a3)+,(a4)+
	lea.l LSPCMODE,a3
	move.w #$1080,(a3)
	bra.w loc_00e9d0

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00e8cc:
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$0100,$e00f,$0110,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$0120,$e00f,$0130,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$0140,$e00f,$0150,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$0160,$e00f,$0170,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$0180,$e00f,$0190,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$01a0,$e00f,$01b0,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$01c0,$e00f,$01d0,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$01e0,$e00f,$01f0,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$0200,$e00f,$0210,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$0220,$e00f,$0230,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$0240,$e00f,$0250,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$0260,$e00f,$0270,$f00f
	dc.w $f100,$0000,$0000,$000f,$0040,$400f,$0280,$e00f,$0290,$f00f

;##############################################################################
loc_00e9d0:
	cmpi.w #5,$10100c
	bne.b loc_00ea12
	lea.l player1mem,a1
	btst #7,($b8,a1)
	bne.b loc_00e9ee
	adda.l #playeroffset,a1

loc_00e9ee:
	lea.l $105cac,a2
	move.w #$1413,(a2)
	move.w ($c0,a1),(8,a2)
	move.w #$128,($c,a2)
	move.b #0,(6,a2)
	move.b #0,(3,a2)
	rts

loc_00ea12:
	move.w stageid,d0
	lea.l loc_00ea58(pc),a1
	nop
	tst.w $10100c
	beq.b loc_00ea2c
	lea.l loc_00ea8c(pc),a1
	nop

loc_00ea2c:
	add.w d0,d0
	add.w d0,d0
	movea.l (a1,d0.w),a1
	move.w (a1)+,d7
	lea.l $105cac,a2

loc_00ea3c:
	move.w (a1)+,(a2)
	move.w (a1)+,(8,a2)
	move.w (a1)+,($c,a2)
	move.b (a1)+,(6,a2)
	move.b (a1)+,(3,a2)
	adda.w #$30,a2
	subq.w #1,d7
	bne.b loc_00ea3c
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00ea58:
	dc.l loc_00eac0,loc_00eaf2,loc_00eb14,loc_00eb2e
	dc.l loc_00eb38,loc_00eb4a,loc_00eb54,loc_00eb66
	dc.l loc_00eb88,loc_00eb92,loc_00ec1c,loc_00ec46
	dc.l loc_00ec58

loc_00ea8c:
	dc.l loc_00ec7a,loc_00ecb4,loc_00ecde,loc_00eb2e
	dc.l loc_00eb38,loc_00eb4a,loc_00eb54,loc_00ecf8
	dc.l loc_00eb88,loc_00ed1a,loc_00ed24,loc_00ec46
	dc.l loc_00ed4e

loc_00eac0:
	dc.w $0006
	dc.w $3400,$0300,$01a0,$0001
	dc.w $3401,$0300,$01a0,$0001
	dc.w $4000,$0260,$0130,$0002
	dc.w $2400,$02c0,$012e,$0002
	dc.w $0403,$01c0,$012c,$0002
	dc.w $1400,$0190,$0128,$0002

loc_00eaf2:
	dc.w $0004
	dc.w $1401,$01b0,$0128,$0003
	dc.w $1402,$0350,$0128,$0003
	dc.w $2800,$0270,$0144,$0003
	dc.w $2800,$0290,$0144,$0103

loc_00eb14:
	dc.w $0003
	dc.w $6805,$01d8,$018d,$0001
	dc.w $1403,$01b0,$0128,$0001
	dc.w $1403,$0360,$0128,$0001

loc_00eb2e:
	dc.w $0001
	dc.w $140a,$0380,$0128,$0003

loc_00eb38:
	dc.w $0002
	dc.w $0401,$0280,$0100,$0003
	dc.w $6400,$0280,$0100,$0000

loc_00eb4a:
	dc.w $0001
	dc.w $1406,$01c0,$0134,$0003

loc_00eb54:
	dc.w $0001
	dc.w $1407,$0360,$0128,$0002
	dc.w $0000,$0000,$0000,$0000

loc_00eb66:
	dc.w $0004
	dc.w $4002,$02a0,$015f,$0001
	dc.w $5c03,$02a0,$015f,$0001
	dc.w $2c00,$0200,$0148,$0001
	dc.w $1411,$0380,$0124,$0001

loc_00eb88:
	dc.w $0001
	dc.w $1410,$0280,$0128,$0000

loc_00eb92:
	dc.w $0011
	dc.w $1408,$0190,$0128,$0002
	dc.w $1409,$0370,$0128,$0002
	dc.w $3800,$0140,$0208,$0002
	dc.w $3801,$0140,$0210,$0002
	dc.w $3802,$0140,$0220,$0002
	dc.w $3800,$0140,$0210,$0002
	dc.w $3801,$0140,$0230,$0002
	dc.w $3802,$0140,$0240,$0002
	dc.w $3800,$0140,$0248,$0002
	dc.w $3801,$0140,$0238,$0002
	dc.w $3802,$0140,$0290,$0002
	dc.w $3800,$0140,$0284,$0002
	dc.w $3801,$0140,$028c,$0002
	dc.w $3802,$0140,$0298,$0002
	dc.w $4800,$0320,$0170,$0002
	dc.w $4801,$0328,$0180,$0002
	dc.w $4802,$0330,$0190,$0002

loc_00ec1c:
	dc.w $0005
	dc.w $0407,$0280,$0150,$0003
	dc.w $0408,$01e0,$0130,$0003
	dc.w $4001,$02b0,$0130,$0003
	dc.w $0406,$02d0,$01b8,$0003
	dc.w $1405,$0340,$0120,$0003

loc_00ec46:
	dc.w $0002
	dc.w $140b,$01b0,$0138,$0003
	dc.w $140b,$0320,$0138,$0103

loc_00ec58:
	dc.w $0002
	dc.w $140c,$0320,$0138,$0003
	dc.w $140d,$01e0,$0138,$0003
	dc.w $140e,$0340,$0118,$0003
	dc.w $140f,$01c0,$0118,$0003

loc_00ec7a:
	dc.w $0007
	dc.w $4000,$0260,$0130,$0002
	dc.w $2400,$02c0,$012e,$0002
	dc.w $0403,$01c0,$012c,$0002
	dc.w $1400,$0190,$0128,$0002
	dc.w $6000,$0270,$01c0,$0001
	dc.w $6004,$0290,$01e0,$0001
	dc.w $040c,$0280,$0100,$0002

loc_00ecb4:
	dc.w $0005
	dc.w $5010,$0280,$0100,$0002
	dc.w $0404,$0220,$0138,$0102
	dc.w $0404,$02e0,$0138,$0002
	dc.w $1404,$0340,$0120,$0003
	dc.w $1404,$01c0,$0120,$0103

loc_00ecde:
	dc.w $0003
	dc.w $6805,$01d8,$018d,$0001
	dc.w $1403,$01b0,$0128,$0001
	dc.w $1403,$0360,$0128,$0001

loc_00ecf8:
	dc.w $0004
	dc.w $4002,$02b0,$015f,$0001
	dc.w $5c03,$02b0,$015f,$0001
	dc.w $0402,$0200,$0158,$0001
	dc.w $1412,$0380,$0124,$0001

loc_00ed1a:
	dc.w $0001
	dc.w $0000,$0000,$0000,$0000

loc_00ed24:
	dc.w $0005
	dc.w $0407,$0280,$0150,$0003
	dc.w $0408,$01e0,$0130,$0003
	dc.w $4001,$02b0,$0130,$0003
	dc.w $0406,$02d0,$01b8,$0003
	dc.w $1405,$0340,$0120,$0003

loc_00ed4e:
	dc.w $0003
	dc.w $140c,$0320,$0138,$0003
	dc.w $140d,$01e0,$0138,$0003
	dc.w $5800,$0280,$0100,$0001

;##############################################################################
loc_00ed68:
	nop
	lea.l player1mem,a0
	lea.l $1068f8,a2
	moveq #1,d7

loc_00ed78:
	move.w ($22,a0),d0
	move.w d0,d1
	lsl.w #5,d0
	lsl.w #4,d1
	add.w d1,d0
	lea.l loc_037000+$10,a3
	adda.w d0,a3
	move.w ($c0,a0),d2
	sub.w $103424,d2
	move.w ($c4,a0),d3
	sub.w $103428,d3
	move.b (4,a3),d4
	move.b (5,a3),d5
	ext.w d4
	ext.w d5
	btst #0,($21,a0)
	beq.b loc_00edb8
	neg.w d4
	addq.w #1,d4

loc_00edb8:
	sub.w d4,d2
	sub.w d5,d3
	addi.w #$128,d3
	move.w d2,(a2)+
	move.w d3,(a2)+
	moveq #0,d4
	moveq #0,d5
	move.b (6,a3),d4
	move.b (7,a3),d5
	move.w d4,(a2)+
	btst #7,($cc,a0)
	beq.b loc_00ede2
	btst #3,($be,a0)
	bne.b loc_00ede4

loc_00ede2:
	moveq #0,d5

loc_00ede4:
	move.w d5,(a2)+
	adda.w #$200,a0
	dbra d7,loc_00ed78
	jsr loc_00f5d6(pc)
	nop
	lea.l $105cac,a0
	move.w #$8d,$105c9c
	move.w #$c9,$105ca0

loc_00ee0a:
	move.l #$0,$106996
	move.b (a0),d0
	beq.b loc_00ee28
	lea.l loc_00ee64(pc),a1
	nop
	andi.w #$fc,d0
	movea.l (a1,d0.w),a1
	jsr (a1)

loc_00ee28:
	adda.w #$30,a0
	cmpa.l #$1062ac,a0
	bmi.w loc_00ee0a
	move.w $105ca0,d0
	move.w $105c9c,d1
	sub.w d1,d0
	bcs.b loc_00ee62
	movea.l $101420,a1
	addi.w #$8200,d1
	moveq #0,d2

loc_00ee52:
	move.w d1,(a1)+
	move.w d2,(a1)+
	addq.w #1,d1
	dbra d0,loc_00ee52
	move.l a1,$101420

loc_00ee62:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00ee64:
	dc.l $00000000
	dc.l loc_00eed8,loc_00f112,loc_00f120,loc_00f1ec
	dc.l loc_00f322,loc_00fa54,loc_00f12e,loc_00faf6
	dc.l loc_00fbf4,loc_00fc3c,loc_00fd2c,loc_00f13c
	dc.l loc_00fd9e,loc_00ff38,loc_010038,loc_010320
	dc.l loc_010554,loc_010644,loc_0106d2,loc_010736
	dc.l loc_010830,loc_010ac8,loc_010bf6,loc_010d24
	dc.l loc_010e44,loc_010e98,loc_00f14a,loc_00f158

;##############################################################################
loc_00eed8:
	btst #0,($1a,a0)
	bne.b loc_00eee6
	bset #0,($1a,a0)

loc_00eee6:
	subq.b #1,($18,a0)
	bpl.b loc_00ef2a
	moveq #0,d0
	move.b (1,a0),d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_012bf0,a1
	movea.l (a1,d0.w),a1
	moveq #0,d1
	move.b ($19,a0),d1
	adda.w d1,a1
	move.w (a1)+,(4,a0)
	move.b (a1)+,($18,a0)
	move.b (a1)+,($1a,a0)
	bset #0,($1a,a0)
	addq.b #4,d1
	bclr #7,($1a,a0)
	beq.b loc_00ef26
	moveq #0,d1

loc_00ef26:
	move.b d1,($19,a0)

loc_00ef2a:
	moveq #0,d0
	move.b (1,a0),d0
	add.w d0,d0
	lea.l loc_012ed8,a1
	move.w (a1,d0.w),d1
	beq.b loc_00ef60
	move.w $105c9c,$105c9e
	move.w d1,$105c9c
	jsr loc_00ef60(pc)
	nop
	move.w $105c9e,$105c9c
	rts

loc_00ef60:
	move.l (8,a0),d0
	move.l ($c,a0),d1
	move.l ($10,a0),d2
	move.l ($14,a0),d3
	add.l d2,d0
	add.l d3,d1
	move.l d0,(8,a0)
	move.l d1,($c,a0)

loc_00ef7c:
	movea.l $101420,a1
	moveq #0,d0
	move.w $105c9c,d0
	move.w (4,a0),d2
	add.w d2,d2
	add.w d2,d2
	lea.l loc_090020,a2
	movea.l (a2,d2.w),a2
	move.w (a2)+,d7
	move.w d7,($2e,a0)
	andi.w #$ff,d7
	beq.w loc_00f110
	lea.l $103424,a3
	moveq #0,d1
	move.b (3,a0),d1
	lsl.w #4,d1
	adda.w d1,a3

loc_00efba:
	move.w (a2),d5
	andi.w #$1f,d5
	add.w d5,d5
	add.w d5,d5
	addq.w #4,d5
	btst #7,($2e,a0)
	beq.b loc_00efd0
	moveq #8,d5

loc_00efd0:
	move.w d0,d1
	lsl.l #6,d1
	move.w (8,a0),d2
	move.w (a2,d5.w),d3
	btst #0,(6,a0)
	beq.b loc_00efea
	neg.w d3
	subi.w #$10,d3

loc_00efea:
	add.w d3,d2
	move.w (a3),d4
	sub.w d4,d2
	cmpi.w #$fff0,d2
	bmi.b loc_00effc
	cmpi.w #$140,d2
	bmi.b loc_00f004

loc_00effc:
	addq.w #2,d5
	adda.w d5,a2
	bra.w loc_00f0fe

loc_00f004:
	move.w (a2)+,d2
	andi.w #$3f,d2
	move.w d2,($2c,a0)
	move.b (6,a0),d5

loc_00f012:
	move.w (a2)+,d3
	move.w (a2)+,d4
	eor.b d5,d4
	move.b (7,a0),d5
	beq.b loc_00f02a
	andi.w #$ff,d5
	lsl.w #8,d5
	andi.w #$ff,d4
	or.w d5,d4

loc_00f02a:
	move.w d1,(a1)+
	move.w d3,(a1)+
	addq.w #1,d1
	move.w d1,(a1)+
	move.w d4,(a1)+
	addq.w #1,d1
	addq.w #1,d3
	subq.w #1,($2c,a0)
	beq.b loc_00f048
	btst #7,($2e,a0)
	beq.b loc_00f012
	bra.b loc_00f02a

loc_00f048:
	move.w d0,d1
	addi.w #$8000,d1
	move.w (8,a0),d4
	move.w ($c,a0),d5
	btst #0,$106996
	beq.b loc_00f0ac
	move.w d1,(a1)+
	move.w $106998,(a1)+
	movem.l d0-d7,-(a7)
	move.w $10699a,d0
	move.w $10699c,d1
	move.w $106998,d2
	move.w d2,d3
	andi.w #$f00,d2
	lsl.w #8,d3
	andi.w #$ff00,d3
	jsr loc_00066c
	move.w d0,$10699a
	move.w d1,$10699c
	movem.l (a7)+,d0-d7
	add.w $10699a,d4
	sub.w $10699c,d5

loc_00f0ac:
	addi.w #$200,d1
	move.w d1,(a1)+
	sub.w (a2)+,d5
	sub.w $106928,d5
	sub.w (4,a3),d5
	lsl.w #7,d5
	or.w d5,d2
	btst #1,$106996
	beq.b loc_00f0da
	bset #2,$106996
	beq.b loc_00f0da
	bset #6,d2

loc_00f0da:
	move.w d2,(a1)+
	addi.w #$200,d1
	move.w d1,(a1)+
	move.w (a2)+,d5
	btst #0,(6,a0)
	beq.b loc_00f0f2
	neg.w d5
	subi.w #$10,d5

loc_00f0f2:
	add.w d5,d4
	move.w (a3),d5
	sub.w d5,d4
	lsl.w #7,d4
	move.w d4,(a1)+
	addq.w #1,d0

loc_00f0fe:
	subq.w #1,d7
	bne.w loc_00efba
	move.l a1,$101420
	move.w d0,$105c9c

loc_00f110:
	rts

;##############################################################################
loc_00f112:
	move.w #$16a,d1
	move.b #7,d6
	move.b #4,d7
	bra.b loc_00f164

;##############################################################################
loc_00f120:
	move.w #$164,d1
	move.b #6,d6
	move.b #4,d7
	bra.b loc_00f164

;##############################################################################
loc_00f12e:
	move.w #$171,d1
	move.b #4,d6
	move.b #$c,d7
	bra.b loc_00f164

;##############################################################################
loc_00f13c:
	move.w #$175,d1
	move.b #6,d6
	move.b #4,d7
	bra.b loc_00f164

;##############################################################################
loc_00f14a:
	move.w #$11d0,d1
	move.b #6,d6
	move.b #0,d7
	bra.b loc_00f164

;##############################################################################
loc_00f158:
	move.w #$e92,d1
	move.b #6,d6
	move.b #1,d7

;##############################################################################
loc_00f164:
	bset #0,($1a,a0)
	bne.b loc_00f176
	clr.b ($7,a0)
	ori.w #$6400,(6,a0)

loc_00f176:
	subq.b #1,($18,a0)
	bpl.w loc_00f19c
	move.b d7,($18,a0)
	moveq #0,d0
	move.b ($19,a0),d0
	add.w d0,d1
	move.w d1,(4,a0)
	addq.b #1,d0
	move.b d0,($19,a0)
	cmp.b d6,d0
	bcs.b loc_00f19c
	clr.w (a0)
	rts

loc_00f19c:
	cmpi.b #$1c,(a0)
	bpl.b loc_00f1ac
	btst #0,$10346b
	bne.b loc_00f1b2

loc_00f1ac:
	jsr loc_00f1b4(pc)
	nop

loc_00f1b2:
	rts

;##############################################################################
loc_00f1b4:
	movea.l $10141c,a1
	move.w (6,a0),(a1)+
	move.w (4,a0),(a1)+
	move.w (8,a0),d4
	sub.w $103424,d4
	move.w d4,(a1)+
	move.w ($c,a0),d5
	sub.w $103428,d5
	addi.w #$120,d5
	sub.w $106928,d5
	move.w d5,(a1)+
	move.l a1,$10141c
	rts

;##############################################################################
loc_00f1ec:
	bset #0,($1a,a0)
	bne.b loc_00f224
	clr.b (7,a0)
	ori.w #$6400,(6,a0)
	lea.l loc_0126d0,a1
	moveq #0,d0
	move.b (1,a0),d0
	move.b (a1,d0.w),d1
	move.b d1,($1c,a0)
	move.b #$ff,($1d,a0)
	addi.b #$40,d1
	andi.w #$c0,d1
	move.b d1,($1e,a0)

loc_00f224:
	move.b ($1c,a0),d1
	andi.l #$7f,d1
	lea.l loc_012b6e,a2
	moveq #0,d2
	move.b (a2,d1.w),d2
	move.b ($1e,a0),d3
	andi.l #$7f,d3
	move.b (a2,d3.w),d1
	btst #7,($1e,a0)
	beq.b loc_00f254
	neg.l d1
	addq.l #1,d1

loc_00f254:
	btst #7,($1c,a0)
	beq.b loc_00f260
	neg.l d2
	addq.l #1,d2

loc_00f260:
	lea.l player1mem,a3
	move.b (3,a0),d3
	andi.l #$10,d3
	lsl.l #5,d3
	adda.l d3,a3
	moveq #0,d4
	move.b ($128,a3),d4
	moveq #$c,d5
	sub.b d4,d5
	btst #0,(6,a0)
	beq.b loc_00f28a
	neg.b d5
	addq.b #1,d5

loc_00f28a:
	add.b d5,($1c,a0)
	andi.b #$ff,($1c,a0)
	add.b d5,($1e,a0)
	andi.b #$ff,($1e,a0)
	moveq #$d,d5
	lsl.l d5,d2
	moveq #$b,d5
	lsl.l d5,d1
	move.l ($c0,a3),d4
	add.l d2,d4
	move.l d4,(8,a0)
	move.l ($c4,a3),d5
	add.l d1,d5
	addi.l #$700000,d5
	move.l d5,($c,a0)
	subq.b #1,($18,a0)
	bpl.w loc_00f310
	move.b #2,($18,a0)
	move.b (3,a0),d1
	andi.w #$f,d1
	add.w d1,d1
	add.w d1,d1
	addi.w #$1132,d1
	move.b #4,(7,a0)
	move.b ($1c,a0),d3
	cmpi.b #$40,d3
	bmi.b loc_00f2fc
	cmpi.b #$c0,d3
	bpl.b loc_00f2fc
	addq.w #2,d1
	ori.b #$34,(6,a0)

loc_00f2fc:
	move.b ($19,a0),d2
	add.b d2,d1
	move.w d1,(4,a0)
	addq.b #1,d2
	andi.w #1,d2
	move.b d2,($19,a0)

loc_00f310:
	jsr loc_00f1b4(pc)
	move.w ($d0,a3),d0
	cmpi.w #6,d0
	beq.b loc_00f320
	clr.w (a0)

loc_00f320:
	rts

;##############################################################################
loc_00f322:
	bset #0,($1a,a0)
	bne.b loc_00f33e
	lea.l loc_012670,a1
	moveq #0,d0
	move.b (1,a0),d0
	add.w d0,d0
	move.w (a1,d0.w),(4,a0)

loc_00f33e:
	moveq #0,d0
	move.b (1,a0),d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_00f5f4(pc),a1
	nop
	movea.l (a1,d0.w),a1
	jsr (a1)
	btst #4,($1a,a0)
	bne.w loc_00f4b2
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #3,d0
	lea.l loc_0125c8,a1
	adda.w d0,a1
	move.l #$1000000,d0
	move.w (a1)+,d0
	btst #0,(6,a0)
	beq.b loc_00f382
	neg.w d0
	addq.w #1,d0

loc_00f382:
	move.w (a1)+,d1
	move.w (a1)+,d2
	move.w (a1)+,d3
	add.w (8,a0),d0
	add.w ($c,a0),d1
	moveq #0,d4
	move.b (3,a0),d4
	lsl.w #4,d4
	lea.l $103424,a2
	sub.w (a2,d4.w),d0
	sub.w (4,a2,d4.w),d1
	jsr loc_00f4e4(pc)
	nop
	lea.l $1068f8,a2

loc_00f3b2:
	move.w (a2)+,d4
	move.w (a2)+,d5
	move.w (a2)+,d6
	move.w (a2)+,d7
	beq.w loc_00f4a8
	sub.w d0,d4
	bpl.b loc_00f3c6
	neg.w d4
	addq.w #1,d4

loc_00f3c6:
	add.w d2,d6
	cmp.w d6,d4
	bpl.w loc_00f4a8
	sub.w d1,d5
	bpl.b loc_00f3d6
	neg.w d5
	addq.w #1,d5

loc_00f3d6:
	add.w d3,d7
	cmp.w d7,d5
	bpl.w loc_00f4a8
	cmpi.b #$10,(1,a0)
	bne.b loc_00f3fc
	move.b #8,($1b,a0)
	bclr #2,($1a,a0)
	bset #4,($1a,a0)
	bra.w loc_00f4b2

loc_00f3fc:
	swap d0
	andi.w #$100,d0
	lsl.w #1,d0
	lea.l player2mem,a3
	suba.w d0,a3
	move.b #$10,($14c,a3)
	movem.l a0,-(a7)
	lea.l player1mem,a0
	adda.w d0,a0
	move.l #$3e8,d0
	jsr loc_0043a8
	movem.l (a7)+,a0
	moveq #0,d0
	move.b (1,a0),d0
	lea.l loc_0126d4,a2
	add.w d0,d0
	add.w d0,d0
	movea.l (a2,d0.w),a2
	move.w (a2)+,d7

loc_00f444:
	move.w (a2)+,d0
	move.w (a2)+,d1
	move.w (a2)+,d2
	add.w (8,a0),d1
	add.w ($c,a0),d2
	swap d1
	swap d2
	move.w #0,d3
	move.w (2,a0),d4
	jsr loc_010f40(pc)
	nop
	dbra d7,loc_00f444
	moveq #0,d0
	move.b (1,a0),d0
	add.w d0,d0
	lea.l loc_0126a0,a1
	move.w (a1,d0.w),d1
	move.b d1,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bset #4,($1a,a0)
	cmpi.b #$11,(1,a0)
	beq.b loc_00f4b2
	cmpi.b #$b,(1,a0)
	beq.b loc_00f4b2
	clr.w (a0)
	rts

loc_00f4a8:
	subi.l #$1000000,d0
	bpl.w loc_00f3b2

loc_00f4b2:
	cmpi.b #6,(1,a0)
	bne.b loc_00f4e0
	tst.w $10100c
	beq.b loc_00f4e0
	move.w $105c9c,($20,a0)
	move.w #$63,$105c9c
	jsr loc_00ef7c(pc)
	move.w ($20,a0),$105c9c
	rts

loc_00f4e0:
	jmp loc_00ef7c(pc)

loc_00f4e4:
	rts

;##############################################################################
loc_00f4e6:
	movem.l d0-d7,-(a7)
	movea.l $101420,a1
	move.w $105ca0,d7
	move.w d7,d6
	lsl.l #6,d6
	move.w d6,(a1)+
	move.w #$6f,(a1)+
	addq.w #1,d6
	move.w d6,(a1)+
	move.w #$100,(a1)+
	move.w d7,d6
	addi.w #$8200,d6
	move.w d6,(a1)+
	move.w d1,d4
	add.w d3,d4
	lsl.w #7,d4
	addq.w #1,d4
	move.w d4,(a1)+
	addi.w #$200,d6
	move.w d6,(a1)+
	move.w d0,d5
	add.w d2,d5
	lsl.w #7,d5
	move.w d5,(a1)+
	subq.w #1,d7
	move.w d7,d6
	lsl.l #6,d6
	move.w d6,(a1)+
	move.w #$6f,(a1)+
	addq.w #1,d6
	move.w d6,(a1)+
	move.w #$101,(a1)+
	move.w d7,d6
	addi.w #$8200,d6
	move.w d6,(a1)+
	move.w d1,d4
	add.w d3,d4
	lsl.w #7,d4
	addq.w #1,d4
	move.w d4,(a1)+
	addi.w #$200,d6
	move.w d6,(a1)+
	move.w d0,d5
	sub.w d2,d5
	lsl.w #7,d5
	move.w d5,(a1)+
	subq.w #1,d7
	move.w d7,d6
	lsl.l #6,d6
	move.w d6,(a1)+
	move.w #$6f,(a1)+
	addq.w #1,d6
	move.w d6,(a1)+
	move.w #$102,(a1)+
	move.w d7,d6
	addi.w #$8200,d6
	move.w d6,(a1)+
	move.w d1,d4
	sub.w d3,d4
	lsl.w #7,d4
	addq.w #1,d4
	move.w d4,(a1)+
	addi.w #$200,d6
	move.w d6,(a1)+
	move.w d0,d5
	add.w d2,d5
	lsl.w #7,d5
	move.w d5,(a1)+
	subq.w #1,d7
	move.w d7,d6
	move.w d6,(a1)+
	move.w #$6f,(a1)+
	addq.w #1,d6
	move.w d6,(a1)+
	move.w #$103,(a1)+
	move.w d7,d6
	addi.w #$8200,d6
	move.w d6,(a1)+
	move.w d1,d4
	sub.w d3,d4
	lsl.w #7,d4
	addq.w #1,d4
	move.w d4,(a1)+
	addi.w #$200,d6
	move.w d6,(a1)+
	move.w d0,d5
	sub.w d2,d5
	lsl.w #7,d5
	move.w d5,(a1)+
	subq.w #1,d7
	move.w d7,$105ca0
	move.l a1,$101420
	movem.l (a7)+,d0-d7
	rts

;##############################################################################
loc_00f5d6:
	nop
	movem.l d0-d7,-(a7)
	lea.l $1068f8,a2
	move.w (a2)+,d0
	move.w (a2)+,d1
	move.w (a2)+,d2
	move.w (a2)+,d3
	jsr loc_00f4e4(pc)
	movem.l (a7)+,d0-d7
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00f5f4:
	dc.l loc_00f674,loc_00f674,loc_00f674,loc_00f674
	dc.l loc_00f674,loc_00f674,loc_00f674,loc_00f676
	dc.l loc_00f674,loc_00f674,loc_00f674,loc_00f6d8
	dc.l loc_00f674,loc_00f674,loc_00f674,loc_00f674
	dc.l loc_00f7ea,loc_00f9f4,loc_00f674,loc_00f674
	dc.l loc_00f674,loc_00f674,loc_00f674,loc_00f674
	dc.l loc_00f674,loc_00f674,loc_00f674,loc_00f674
	dc.l loc_00f674,loc_00f674,loc_00f674,loc_00f674

;##############################################################################
loc_00f674:
	rts

;##############################################################################
loc_00f676:
	lea.l loc_00f6b6(pc),a1
	nop
	moveq #8,d7

loc_00f67e:
	bset #1,($1a,a0)
	bne.b loc_00f68c
	move.w #0,($18,a0)

loc_00f68c:
	subq.b #1,($18,a0)
	bpl.b loc_00f6b4
	move.b #4,($18,a0)
	moveq #0,d2
	move.b ($19,a0),d2
	move.w d2,d0
	add.w d0,d0
	move.w (a1,d0.w),(4,a0)
	addq.w #1,d2
	cmp.w d7,d2
	bmi.b loc_00f6b0
	moveq #0,d2

loc_00f6b0:
	move.b d2,($19,a0)

loc_00f6b4:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00f6b6:
	dc.w $0220,$0221,$0222,$0223,$0224,$0225,$0226,$0227

loc_00f6c6:
	dc.w $1266,$1267,$1268,$1269,$126a,$126b,$126c,$126d
	dc.w $126e

;##############################################################################
loc_00f6d8:
	bset #1,($1a,a0)
	bne.b loc_00f6e6
	move.b #0,($1b,a0)

loc_00f6e6:
	moveq #0,d0
	move.b ($1b,a0),d0
	lea.l loc_00f6f8(pc),a1
	nop
	movea.l (a1,d0.w),a1
	jmp (a1)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00f6f8:
	dc.l loc_00f704
	dc.l loc_00f732
	dc.l loc_00f784

;##############################################################################
loc_00f704:
	bset #2,($1a,a0)
	bne.b loc_00f712
	move.w #0,($18,a0)

loc_00f712:
	btst #4,($1a,a0)
	beq.b loc_00f728
	move.b #4,($1b,a0)
	bclr #2,($1a,a0)
	bra.b loc_00f732

loc_00f728:
	lea.l loc_00f6c6(pc),a1
	moveq #9,d7
	bra.w loc_00f67e

;##############################################################################
loc_00f732:
	bset #2,($1a,a0)
	bne.b loc_00f74e
	move.w #$126f,(4,a0)
	move.l #$30000,($14,a0)
	move.w #$180,($c,a0)

loc_00f74e:
	subi.l #$3000,($14,a0)
	move.l ($c,a0),d0
	add.l ($14,a0),d0
	cmpi.w #$131,($c,a0)
	bpl.b loc_00f780
	move.w #$130,($c,a0)
	move.l #0,($14,a0)
	move.b #8,($1b,a0)
	bclr #2,($1a,a0)

loc_00f780:
	jmp loc_00ef60(pc)

;##############################################################################
loc_00f784:
	bset #2,($1a,a0)
	bne.b loc_00f7aa
	move.w #0,($18,a0)
	move.l #$10000,($10,a0)
	btst #0,(6,a0)
	beq.b loc_00f7aa
	move.l #$ffff0000,($10,a0)

loc_00f7aa:
	subq.b #1,($18,a0)
	bpl.b loc_00f7d4
	move.b #4,($18,a0)
	moveq #0,d0
	move.b ($19,a0),d0
	addi.w #$126f,d0
	move.w d0,(4,a0)
	addq.b #1,($19,a0)
	cmpi.b #3,($19,a0)
	bmi.b loc_00f7d4
	clr.b ($19,a0)

loc_00f7d4:
	cmpi.w #$100,(8,a0)
	bmi.b loc_00f7e4
	cmpi.w #$3c0,(8,a0)
	bmi.b loc_00f7e6

loc_00f7e4:
	clr.w (a0)

loc_00f7e6:
	jmp loc_00ef60(pc)

;##############################################################################
loc_00f7ea:
	bset #1,($1a,a0)
	bne.b loc_00f7f8
	move.b #0,($1b,a0)

loc_00f7f8:
	moveq #0,d0
	move.b ($1b,a0),d0
	lea.l loc_00f80c(pc),a1
	nop
	movea.l (a1,d0.w),a1
	jmp (a1)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00f80a:
	dc.w $001b

loc_00f80c:
	dc.l loc_00f818
	dc.l loc_00f870
	dc.l loc_00f8fc

;##############################################################################
loc_00f818:
	bset #2,($1a,a0)
	bne.b loc_00f838
	moveq #0,d0
	move.l d0,($10,a0)
	lea.l loc_00f960(pc),a1
	nop
	move.w (a1,d0.w),(4,a0)
	bclr #4,($1a,a0)
 
loc_00f838:
	lea.l player1mem,a1
	move.w ($c0,a1),d2
	move.w ($2c0,a1),d3
	sub.w d2,d3
	asr.w #1,d3
	add.w d3,d2
	move.w (8,a0),d4
	sub.w d4,d2
	move.w d2,d3
	bpl.b loc_00f85a
	neg.w d3
	addq.w #1,d3

loc_00f85a:
	moveq #0,d5
	cmpi.w #$c,d3
	bmi.b loc_00f86e
	move.b #4,($1b,a0)
	bclr #2,($1a,a0)

loc_00f86e:
	rts

;##############################################################################
loc_00f870:
	bset #2,($1a,a0)
	bne.b loc_00f87e
	move.w #2,($18,a0)

loc_00f87e:
	subq.b #1,($18,a0)
	bpl.b loc_00f8f2
	move.b #3,($18,a0)
	lea.l player1mem,a1
	move.w ($c0,a1),d2
	move.w ($2c0,a1),d3
	sub.w d2,d3
	asr.w #1,d3
	add.w d3,d2
	move.w (8,a0),d4
	sub.w d4,d2
	move.w d2,d3
	bpl.b loc_00f8ac
	neg.w d3
	addq.w #1,d3

loc_00f8ac:
	moveq #0,d5
	cmpi.w #5,d3
	bpl.b loc_00f8c0
	move.b #0,($1b,a0)
	bclr #2,($1a,a0)

loc_00f8c0:
	move.l #$20000,d5
	tst.w d2
	bpl.b loc_00f8ce
	neg.l d5
	addq.l #1,d5

loc_00f8ce:
	move.l d5,($10,a0)
	moveq #0,d0
	move.b ($19,a0),d0
	lea.l loc_00f960(pc),a1
	nop
	move.w (a1,d0.w),(4,a0)
	addq.w #2,d0
	cmpi.w #$12,d0
	bmi.b loc_00f8ee
	moveq #2,d0

loc_00f8ee:
	move.b d0,($19,a0)

loc_00f8f2:
	move.l ($10,a0),d0
	add.l d0,(8,a0)
	rts

;##############################################################################
loc_00f8fc:
	bset #2,($1a,a0)
	bne.b loc_00f914
	move.w #$100,($18,a0)
	moveq #0,d0
	move.l d0,($10,a0)
	move.l d0,($14,a0)
 
loc_00f914:
	moveq #0,d0
	move.b ($19,a0),d0
	lea.l loc_00f974(pc),a1
	nop
	lsl.w #3,d0
	move.l (4,a1,d0.w),d1
	move.l ($14,a0),d2
	add.l d1,d2
	move.l d2,($14,a0)
	add.l d2,($c,a0)
	subq.b #1,($18,a0)
	bne.b loc_00f95e
	move.b (a1,d0.w),($18,a0)
	move.w (2,a1,d0.w),(4,a0)
	addq.b #1,($19,a0)
	cmpi.b #$10,($19,a0)
	bmi.b loc_00f95e
	move.b #0,($1b,a0)
	bclr #2,($1a,a0)

loc_00f95e:
	rts

;##############################################################################
loc_00f960:
	bset d0,(a3)
	bset d0,(a0)
	bset d0,(a1)
	bset d0,(a2)
	bset d0,(a3)
	bset d0,(a4)+
	bset d0,(a5)+
	bset d0,(a6)+
	bset d0,(a7)+
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00f974:
	dc.w $0800,$01d4,$0000,$0000,$0100,$01d4,$0000,$0000
	dc.w $2000,$01d5,$0003,$0000,$0100,$01d5,$ffff,$d000
	dc.w $0800,$01d6,$0003,$0000,$0800,$01d6,$0000,$0000
	dc.w $0800,$01d7,$0000,$0000,$0800,$01d8,$0000,$0000
	dc.w $0800,$01d9,$0000,$0000,$0800,$01da,$0000,$0000
	dc.w $0800,$01d9,$0000,$0000,$0800,$01d8,$0000,$0000
	dc.w $0800,$01d9,$0000,$0000,$0800,$01da,$0000,$0000
	dc.w $0800,$01db,$0000,$0000,$0800,$01cf,$0000,$0000

;##############################################################################
loc_00f9f4:
	bset #1,($1a,a0)
	bne.b loc_00fa08
	move.b #0,($1b,a0)
	move.w #$1187,(4,a0)

loc_00fa08:
	btst #4,($1a,a0)
	beq.b loc_00fa42
	subq.b #1,($18,a0)
	bpl.b loc_00fa42
	moveq #0,d0
	move.b ($19,a0),d0
	lea.l loc_00fa44(pc),a1
	nop
	move.b (a1,d0.w),($18,a0)
	move.w (2,a1,d0.w),(4,a0)
	addq.b #4,($19,a0)
	cmpi.b #$10,($19,a0)
	bmi.w loc_00f95e
	move.b #8,($19,a0)

loc_00fa42:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00fa44:
	dc.w $0400,$1188,$0400,$1189
	dc.w $0400,$118a,$0400,$118b

;##############################################################################
loc_00fa54:
	bset #0,($1a,a0)
	bne.b loc_00fa88
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #4,d0
	lea.l loc_011c08,a1
	move.w (2,a1,d0.w),(4,a0)
	move.l (4,a1,d0.w),($10,a0)
	move.l (8,a1,d0.w),($14,a0)
	move.l ($c,a1,d0.w),($1c,a0)
	move.b #2,($1b,a0)

loc_00fa88:
	move.l (8,a0),d0
	add.l ($10,a0),d0
	move.l d0,(8,a0)
	move.l ($14,a0),d1
	add.l ($1c,a0),d1
	move.l d1,($14,a0)
	add.l d1,($c,a0)
	cmpi.w #$120,($c,a0)
	bpl.b loc_00fade
	move.l #$1200000,($c,a0)
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #4,d0
	lea.l loc_011c08,a1
	move.l (8,a1,d0.w),d1
	asr.l #1,d1
	move.l d1,($14,a0)
	move.l ($c,a1,d0.w),d2
	asr.l #1,d2
	move.l d2,($1c,a0)
	subq.b #1,($1b,a0)
	bne.b loc_00fade
	clr.w (a0)

loc_00fade:
	move.l a0,d0
	lsr.l #4,d0
	move.w $10346a,d1
	eor.w d0,d1
	btst #0,d1
	bne.b loc_00faf2
	rts

loc_00faf2:
	jmp loc_00ef7c(pc)

;##############################################################################
loc_00faf6:
	bset #0,($1a,a0)
	bne.b loc_00fb0a
	ori.b #$34,(6,a0)
	move.w #0,($18,a0)

loc_00fb0a:
	lea.l player1mem,a3
	move.b (3,a0),d3
	andi.l #$10,d3
	lsl.l #5,d3
	adda.l d3,a3
	moveq #0,d3
	move.b (1,a3),d3
	lsl.w #3,d3
	lea.l loc_00fb84(pc),a1
	nop
	move.l (a1,d3.w),d4
	move.l (4,a1,d3.w),d5
	btst #0,(6,a0)
	beq.b loc_00fb40
	neg.l d4
	addq.l #1,d4

loc_00fb40:
	add.l ($c0,a3),d4
	move.l d4,(8,a0)
	add.l ($c4,a3),d5
	move.l d5,($c,a0)
	subq.b #1,($18,a0)
	bpl.b loc_00fb7e
	move.b #8,($18,a0)
	moveq #0,d0
	move.b ($19,a0),d0
	move.w #$17c,d1
	add.w d0,d1
	move.w d1,(4,a0)
	addq.b #1,d0
	move.b d0,($19,a0)
	cmpi.b #4,d0
	bmi.b loc_00fb7e
	moveq #0,d0
	clr.w (a0)
	rts

loc_00fb7e:
	jmp loc_00f1b4(pc)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00fb82:
	dc.w $1140
	
loc_00fb84:
	dc.w $ffe0,$0000,$0050,$0000,$ffd0,$0000,$0050,$0000
	dc.w $ffe0,$0000,$0050,$0000,$ffe0,$0000,$0050,$0000
	dc.w $ffe0,$0000,$0060,$0000,$ffe8,$0000,$0050,$0000
	dc.w $ffe8,$0000,$0058,$0000,$ffe8,$0000,$0060,$0000
	dc.w $ffe8,$0000,$0058,$0000,$ffe0,$0000,$0050,$0000
	dc.w $ffd8,$0000,$0060,$0000,$ffe8,$0000,$0058,$0000
	dc.w $ffd8,$0000,$0050,$0000,$0008,$0000,$0088,$0000

;##############################################################################
loc_00fbf4:
	bset #0,($1a,a0)
	bne.b loc_00fc02
	move.w #$18a,(4,a0)

loc_00fc02:
	btst #0,(6,a0)
	bne.b loc_00fc22
	move.l #$fffe0000,($10,a0)
	cmpi.w #$120,(8,a0)
	bpl.b loc_00fc38
	bchg.b #0,(6,a0)
	bra.b loc_00fc38

loc_00fc22:
	move.l #$20000,($10,a0)
	cmpi.w #$3a0,(8,a0)
	bmi.b loc_00fc38
	bchg.b #0,(6,a0)

loc_00fc38:
	jmp loc_00ef60(pc)

;##############################################################################
loc_00fc3c:
	bset #0,($1a,a0)
	bne.b loc_00fc5c
	move.w #0,($18,a0)
	move.w #$c0,($1c,a0)
	move.w #1,($20,a0)
	move.w #0,($22,a0)

;Feilin
loc_00fc5c:
	subq.w #1,($20,a0)
	bne.w loc_00fcaa
	move.w #$10,($20,a0)
	tst.b exstageflag
	bne.b Extrafeilinprog

	lea.l $106a5e,a1
	move.w ($22,a0),d0
	addi.w #$2600,d0
	move.w d0,(a1)+
	move.w #$1c00,(a1)+
	move.w ($22,a0),d0
	addi.w #$2680,d0
	move.w d0,(a1)+
	move.w #$1d40,(a1)+
	move.w ($22,a0),d0
	addi.w #$2700,d0
	move.w d0,(a1)+
	move.w #$1d80,(a1)+
	addi.w #$20,($22,a0)
	cmpi.w #$80,($22,a0)
	bmi.b loc_00fcaa
	clr.w ($22,a0)
	bra.b loc_00fcaa

Extrafeilinprog:
	lea.l $106a5e,a1
	move.w ($22,a0),d0
	addi.w #ExFeilinEffect0-loc_065000,d0
	move.w d0,(a1)+
	move.w #$1c00,(a1)+
	move.w ($22,a0),d0
	addi.w #ExFeilinEffect1-loc_065000,d0
	move.w d0,(a1)+
	move.w #$1d40,(a1)+
	move.w ($22,a0),d0
	addi.w #ExFeilinEffect2-loc_065000,d0
	move.w d0,(a1)+
	move.w #$1d80,(a1)+
	addi.w #$20,($22,a0)
	cmpi.w #$80,($22,a0)
	bmi.b loc_00fcaa
	clr.w ($22,a0)

loc_00fcaa:
	subq.w #1,($1c,a0)
	bne.b loc_00fcbc
	move.w #$c0,($1c,a0)
	bchg.b #0,(6,a0)

loc_00fcbc:
	subq.b #1,($18,a0)
	bpl.b loc_00fce6
	move.b #4,($18,a0)
	moveq #0,d0
	move.b ($19,a0),d0
	move.w #$1a3,d1
	add.w d0,d1
	move.w d1,(4,a0)
	addq.b #1,d0
	cmpi.b #4,d0
	bmi.b loc_00fce2
	moveq #0,d0

loc_00fce2:
	move.b d0,($19,a0)

loc_00fce6:
	move.l #$10000,($10,a0)
	btst #0,(6,a0)
	bne.b loc_00fcfe
	move.l #$ffff0000,($10,a0)

loc_00fcfe:
	move.w $105c9c,($1e,a0)
	move.w #$5f,$105c9c
	cmpi.b #$28,(-$30,a0)
	bne.b loc_00fd1e
	addi.w #4,$105c9c

loc_00fd1e:
	jsr loc_00ef60(pc)
	move.w ($1e,a0),$105c9c
	rts

;##############################################################################
loc_00fd2c:
	bset #0,($1a,a0)
	bne.b loc_00fd3a
	move.w #0,($18,a0)

loc_00fd3a:
	subq.b #1,($18,a0)
	bpl.b loc_00fd64
	move.b #$c,($18,a0)
	moveq #0,d0
	move.b ($19,a0),d0
	move.w #$1183,d1
	add.w d0,d1
	move.w d1,(4,a0)
	addq.b #1,d0
	cmpi.b #4,d0
	bmi.b loc_00fd60
	moveq #0,d0

loc_00fd60:
	move.b d0,($19,a0)

loc_00fd64:
	btst #0,(6,a0)
	beq.b loc_00fd84
	move.l #$ffff8000,($10,a0)
	cmpi.w #$200,(8,a0)
	bpl.b loc_00fd9a
	bchg.b #0,(6,a0)
	bra.b loc_00fd9a

loc_00fd84:
	move.l #$8000,($10,a0)
	cmpi.w #$3c0,(8,a0)
	bmi.b loc_00fd9a
	bchg.b #0,(6,a0)

loc_00fd9a:
	jmp loc_00ef60(pc)

;##############################################################################
loc_00fd9e:
	bset #0,($1a,a0)
	bne.b loc_00fdba
	move.w #1,($18,a0)
	move.w #0,($1c,a0)
	move.l #$fffff000,($10,a0)

loc_00fdba:
	subq.w #1,($18,a0)
	bne.b loc_00fe08
	move.w ($1c,a0),d0
	tst.b (1,a0)
	bne.b loc_00fde2
	move.w #4,($18,a0)
	andi.w #3,d0
	addi.w #$12c3,d0
	move.w d0,(4,a0)
	addq.w #1,($1c,a0)
	bra.b loc_00fe08

loc_00fde2:
	lea.l loc_00fe34(pc),a1
	nop
	move.w ($1c,a0),d0
	addq.w #4,($1c,a0)
	move.w (a1,d0.w),(4,a0)
	move.w (2,a1,d0.w),($18,a0)
	bne.b loc_00fe08
	move.w #$40,($18,a0)
	clr.w ($1c,a0)

loc_00fe08:
	move.w $105c9c,($1e,a0)
	move.w #$3a,$105c9c
	tst.b (1,a0)
	beq.b loc_00fe26
	move.w #$3f,$105c9c

loc_00fe26:
	jsr loc_00ef60(pc)
	move.w ($1e,a0),$105c9c
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_00fe34:
	dc.w $12c7,$0060
	dc.w $12c8,$0008
	dc.w $12c9,$0008
	dc.w $12ca,$0008
	dc.w $12cb,$0008
	dc.w $12cc,$0008
	dc.w $12cd,$0008
	dc.w $12ce,$0060
	dc.w $017b,$0040
	dc.w $12cf,$0008
	dc.w $12d0,$0008
	dc.w $12d1,$0008
	dc.w $12d2,$0008
	dc.w $12d3,$0008
	dc.w $12d4,$0008
	dc.w $12d3,$0008
	dc.w $12d4,$0008
	dc.w $12d3,$0008
	dc.w $12d4,$0008
	dc.w $12d3,$0008
	dc.w $12d4,$0008
	dc.w $017b,$0040
	dc.w $12d5,$0020
	dc.w $12d6,$0020
	dc.w $12d5,$0020
	dc.w $12d6,$0020
	dc.w $12d5,$0020
	dc.w $12d6,$0020
	dc.w $12d5,$0020
	dc.w $12d6,$0020
	dc.w $017b,$0040
	dc.w $12d7,$0020
	dc.w $12d8,$0020
	dc.w $12d7,$0020
	dc.w $12d8,$0020
	dc.w $12d7,$0020
	dc.w $12d8,$0020
	dc.w $12d7,$0020
	dc.w $12d8,$0020
	dc.w $017b,$0040
	dc.w $12d9,$0008
	dc.w $12da,$0008
	dc.w $12db,$0008
	dc.w $12dc,$0008
	dc.w $12dd,$0008
	dc.w $12de,$0008
	dc.w $12df,$0008
	dc.w $12e0,$0008
	dc.w $12e1,$0008
	dc.w $12e2,$0008
	dc.w $12e3,$0008
	dc.w $12e4,$0008
	dc.w $12e5,$0008
	dc.w $12e6,$0008
	dc.w $12e7,$0008
	dc.w $12e8,$0008
	dc.w $12e9,$0008
	dc.w $12ea,$0008
	dc.w $12eb,$0008
	dc.w $12ec,$0008
	dc.w $12ed,$0008
	dc.w $12ee,$0008
	dc.w $12ef,$0008
	dc.w $12f0,$0008
	dc.w $017b,$0000

;##############################################################################
loc_00ff38:
	bset #0,($1a,a0)
	bne.b loc_00ff9a
	move.w #0,($18,a0)
	move.w #0,($1c,a0)
	move.b #$10,($1e,a0)
	moveq #0,d0
	move.b (1,a0),d0
	move.l #$ffffc000,d1
	lsl.l d0,d1
	move.l d1,($14,a0)
	move.l a0,d1
	subi.l #$105cac,d1
	andi.l #$1f0,d1
	move.w $10346a,d6
	andi.w #$f8,d6
	lsr.w #3,d6
	add.w d6,d1
	swap d1
	add.l $103424,d1
	move.l d1,(8,a0)
	cmpi.w #$128,($c,a0)
	bpl.b loc_00ff9a
	move.w #$200,($c,a0)

loc_00ff9a:
	subq.b #1,($18,a0)
	bpl.b loc_00ffce
	move.b #4,($18,a0)
	moveq #0,d0
	move.b ($19,a0),d0
	addi.w #$1260,d0
	moveq #0,d1
	move.b (1,a0),d1
	add.w d1,d1
	add.w d1,d0
	move.w d0,(4,a0)
	addq.b #1,($19,a0)
	cmpi.b #2,($19,a0)
	bmi.b loc_00ffce
	clr.b ($19,a0)

loc_00ffce:
	cmpi.w #$128,($c,a0)
	bpl.b loc_00fffa
	moveq #0,d0
	move.l d0,($10,a0)
	move.l d0,($14,a0)
	move.b #$ff,($18,a0)
	subq.b #1,($1e,a0)
	bne.b loc_00fff0
	clr.b ($1a,a0)

loc_00fff0:
	btst #0,($1e,a0)
	beq.b loc_010034
	rts

loc_00fffa:
	move.b ($1c,a0),d1
	andi.l #$7f,d1
	lea.l loc_012b6e,a2
	moveq #0,d2
	move.b (a2,d1.w),d2
	btst #7,($1c,a0)
	beq.b loc_01001c
	neg.l d2
	addq.l #1,d2

loc_01001c:
	move.w #$9,d3
	lsl.l d3,d2
	move.l d2,($10,a0)
	move.b (1,a0),d0
	add.b d0,d0
	add.b d0,d0
	addq.b #4,d0
	add.b d0,($1c,a0)

loc_010034:
	jmp loc_00ef60(pc)

;##############################################################################
loc_010038:
	bset #0,($1a,a0)
	bne.b loc_010052
	ori.b #$74,(6,a0)
	move.w #0,($18,a0)
	move.w #0,($1c,a0)

loc_010052:
	moveq #0,d0
	move.b (1,a0),d0
	lea.l loc_010064(pc),a1
	nop
	movea.l (a1,d0.w),a1
	jmp (a1)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_010064:
	dc.l loc_010088
	dc.l loc_0100d6
	dc.l loc_01012c
	dc.l loc_0101b2
	dc.l loc_0101b2
	dc.l loc_0101b2
	dc.l loc_0101b2
	dc.l loc_0101b2
	dc.l loc_0101b2

;##############################################################################
loc_010088:
	bset #1,($1a,a0)
	bne.b loc_0100aa
	move.w #$1397,(4,a0)
	move.l #$20000,($10,a0)
	btst #0,(6,a0)
	beq.b loc_0100aa
	neg.l ($10,a0)

loc_0100aa:
	addi.l #$ffffd000,($14,a0)
	move.l (8,a0),d0
	move.l ($c,a0),d1
	cmpi.l #$90000,d1
	bmi.b loc_0100d2
	add.l ($10,a0),d0
	add.l ($14,a0),d1
	move.l d0,(8,a0)
	move.l d1,($c,a0)

loc_0100d2:
	jmp loc_00f1b4(pc)

;##############################################################################
loc_0100d6:
	bset #1,($1a,a0)
	bne.b loc_010100
	move.w #$1710,(4,a0)
	move.l #$ffff4000,($10,a0)
	move.l #$50000,($14,a0)
	btst #0,(6,a0)
	beq.b loc_010100
	neg.l ($10,a0)

loc_010100:
	addi.l #$ffffd000,($14,a0)
	move.l (8,a0),d0
	move.l ($c,a0),d1
	cmpi.l #$90000,d1
	bmi.b loc_010128
	add.l ($10,a0),d0
	add.l ($14,a0),d1
	move.l d0,(8,a0)
	move.l d1,($c,a0)

loc_010128:
	jmp loc_00f1b4(pc)

;##############################################################################
loc_01012c:
	bset #1,($1a,a0)
	bne.b loc_010150
	move.b #$1d,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	move.w #0,($18,a0)

loc_010150:
	subq.b #1,($18,a0)
	bpl.b loc_010180
	moveq #0,d0
	move.b ($19,a0),d0
	lea.l loc_010184(pc),a1
	nop
	move.w (a1,d0.w),(4,a0)
	move.b #1,($18,a0)
	addq.b #2,($19,a0)
	cmpi.b #$2c,($19,a0)
	bmi.b loc_010180
	move.b #$28,($19,a0)

loc_010180:
	jmp loc_00f1b4(pc)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_010184:
	dc.w $0e72,$0e73,$0e74,$0e75,$0e76,$0e77,$0e78,$0e79
	dc.w $0e7a,$0e7b,$0e7c,$0e7d,$0e7e,$0e7f,$0e80,$0e81
	dc.w $0e82,$0e83,$0e9e,$0e9f,$0ea0,$0ea1,$0ea2

;##############################################################################
loc_0101b2:
	bset #1,($1a,a0)
	bne.b loc_0101dc
	move.b #$1d,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bclr #0,(6,a0)
	move.w #0,($18,a0)

loc_0101dc:
	btst #2,($1a,a0)
	bne.w loc_010296
	subq.b #1,($18,a0)
	bpl.b loc_010210
	move.b #4,($18,a0)
	moveq #0,d1
	move.b ($19,a0),d1
	addi.w #$e8c,d1
	move.w d1,(4,a0)
	addq.b #1,($19,a0)
	cmpi.b #$c,($19,a0)
	bmi.b loc_010210
	clr.b ($19,a0)

loc_010210:
	lea.l loc_010308(pc),a1
	nop
	moveq #0,d0
	move.b (1,a0),d0
	subi.b #$c,d0
	move.b (3,a0),d1
	andi.w #$10,d1
	lsl.w #5,d1
	lea.l player1mem,a2
	adda.w d1,a2
	move.w ($c0,a2),d2
	move.w ($c4,a2),d3
	add.w (a1,d0.w),d2
	add.w (2,a1,d0.w),d3
	moveq #2,d4
	sub.w (8,a0),d2
	beq.b loc_010262
	bpl.b loc_010250
	move.w #$fffe,d4

loc_010250:
	cmpi.w #$ffff,d2
	beq.b loc_01025c
	cmpi.w #1,d2
	bne.b loc_01025e

loc_01025c:
	asr.w #1,d4

loc_01025e:
	add.w d4,(8,a0)

loc_010262:
	moveq #2,d5
	sub.w ($c,a0),d3
	beq.b loc_010282
	bpl.b loc_010270
	move.w #$fffe,d5

loc_010270:
	cmpi.w #$ffff,d3
	beq.b loc_01027c
	cmpi.w #1,d3
	bne.b loc_01027e

loc_01027c:
	asr.w #1,d5

loc_01027e:
	add.w d5,($c,a0)

loc_010282:
	tst.w d2
	bne.b loc_0102d4
	tst.w d3
	bne.b loc_0102d4
	bset #2,($1a,a0)
	move.w #0,($18,a0)

loc_010296
	subq.b #1,($18,a0)
	bpl.b loc_0102d4
	lea.l loc_0102d8(pc),a1
	nop
	moveq #0,d0
	move.b (1,a0),d0
	subi.w #$c,d0
	add.w d0,d0
	moveq #0,d1
	move.b ($19,a0),d1
	add.w d0,d1
	move.w (a1,d1.w),(4,a0)
	move.b #4,($18,a0)
	addq.b #2,($19,a0)
	cmpi.b #8,($19,a0)
	bmi.b loc_0102d4
	move.b #0,($19,a0)

loc_0102d4:
	jmp loc_00f1b4(pc)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0102d8:
	dc.w $1653,$1654,$1655,$1656
	dc.w $1657,$1658,$1659,$165a
	dc.w $165b,$165c,$165d,$165e
	dc.w $165f,$1660,$1661,$1662
	dc.w $1663,$1664,$1665,$1666
	dc.w $1667,$1668,$1669,$166a

loc_010308:
	dc.w $ffb0,$0060,$ffd0,$0070
	dc.w $fff0,$0080,$0010,$0080
	dc.w $0030,$0070,$0050,$0060

;##############################################################################
loc_010320:
	bset #0,($1a,a0)
	bne.b loc_01032e
	move.b #0,($1b,a0)

loc_01032e:
	moveq #0,d0
	move.b ($1b,a0),d0
	lea.l loc_010340(pc),a1
	nop
	movea.l (a1,d0.w),a1
	jmp (a1)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_010340:
	dc.l loc_010348
	dc.l loc_01039c


;##############################################################################
loc_010348:
	bset #1,($1a,a0)
	bne.b loc_010356
	move.w #0,($18,a0)

loc_010356:
	subq.b #1,($18,a0)
	bpl.b loc_010382
	moveq #0,d0
	move.b (1,a0),d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_0103e0(pc),a1
	nop
	movea.l (a1,d0.w),a1
	moveq #0,d1
	move.b ($19,a0),d1
	move.w (a1,d1.w),($18,a0)
	move.w (2,a1,d1.w),(4,a0)

loc_010382:
	btst #6,$101000
	beq.b loc_010398
	bclr #1,($1a,a0)
	move.b #4,($1b,a0)

loc_010398:
	jmp loc_00ef7c(pc)


;##############################################################################
loc_01039c:
	bset #1,($1a,a0)
	bne.b loc_0103aa
	move.w #0,($18,a0)

loc_0103aa:
	subq.b #1,($18,a0)
	bpl.b loc_0103dc
	moveq #0,d0
	move.b (1,a0),d0
	cmpi.b #2,d0
	beq.b loc_0103dc
	add.w d0,d0
	add.w d0,d0
	lea.l loc_0104c8(pc),a1
	nop
	movea.l (a1,d0.w),a1
	moveq #0,d1
	move.b ($19,a0),d1
	move.w (a1,d1.w),($18,a0)
	move.w (2,a1,d1.w),(4,a0)

loc_0103dc:
	jmp loc_00ef7c(pc)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0103e0:
	dc.l loc_0103f0,loc_010400,loc_01043c,loc_010494

loc_0103f0:
	dc.w $0404,$018b
	dc.w $0408,$018c
	dc.w $040c,$018d
	dc.w $0400,$018e

loc_010400:
	dc.w $0404,$01ef
	dc.w $0408,$01f0
	dc.w $040c,$01f1
	dc.w $0410,$01f0
	dc.w $0414,$01ef
	dc.w $0418,$01f0
	dc.w $041c,$01f1
	dc.w $0420,$01f0
	dc.w $0424,$01ef
	dc.w $0428,$01f7
	dc.w $042c,$01f8
	dc.w $0430,$01f7
	dc.w $0434,$01f8
	dc.w $0438,$01f7
	dc.w $0400,$01f8


loc_01043c:
	dc.w $1004,$124a
	dc.w $1008,$124b
	dc.w $100c,$124a
	dc.w $1010,$124b
	dc.w $1014,$124a
	dc.w $1018,$124b
	dc.w $101c,$124a
	dc.w $1020,$124b
	dc.w $1024,$124a
	dc.w $1028,$124b
	dc.w $102c,$124a
	dc.w $1030,$124b
	dc.w $0234,$1240
	dc.w $0238,$1241
	dc.w $023c,$1242
	dc.w $0240,$1243
	dc.w $0244,$1244
	dc.w $0248,$1245
	dc.w $024c,$1246
	dc.w $0250,$1247
	dc.w $0254,$1248
	dc.w $0230,$1249

loc_010494:
	dc.w $0804,$124c
	dc.w $0808,$124d
	dc.w $080c,$124e
	dc.w $0810,$124f
	dc.w $0814,$1250
	dc.w $0818,$1251
	dc.w $081c,$1252
	dc.w $0820,$124f
	dc.w $0824,$1259
	dc.w $0828,$125a
	dc.w $082c,$1259
	dc.w $0830,$125a
	dc.w $0800,$125b

loc_0104c8:
	dc.l loc_0104d8,loc_0104e8,loc_01053c,loc_010548

loc_0104d8:
	dc.w $0404,$018e
	dc.w $0408,$018f
	dc.w $040c,$0190
	dc.w $ff0c,$0191

loc_0104e8:
	dc.w $0404,$01ef
	dc.w $0408,$01f2
	dc.w $040c,$01f3
	dc.w $0410,$01f4
	dc.w $0414,$01f2
	dc.w $0418,$01f3
	dc.w $041c,$01f4
	dc.w $0420,$01f2
	dc.w $0424,$01f3
	dc.w $0428,$01f4
	dc.w $042c,$01f5
	dc.w $0430,$01f4
	dc.w $0434,$01f6
	dc.w $0438,$01f4
	dc.w $043c,$01f5
	dc.w $0440,$01f4
	dc.w $0444,$01f6
	dc.w $0448,$01f4
	dc.w $044c,$01f5
	dc.w $0450,$01f4
	dc.w $0404,$01f3

loc_01053c:
	dc.w $1004,$1245
	dc.w $1008,$1246
	dc.w $1000,$1247

loc_010548:
	dc.w $0804,$1256
	dc.w $0808,$1257
	dc.w $0800,$1258


;##############################################################################
loc_010554:
	bset #0,($1a,a0)
	bne.b loc_010562
	move.w #0,($18,a0)

loc_010562:
	moveq #0,d0
	move.b ($1b,a0),d0
	lea.l loc_010574(pc),a1
	nop
	movea.l (a1,d0.w),a1
	jmp (a1)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_010574:
	dc.l loc_01057c
	dc.l loc_0105d8

;##############################################################################
loc_01057c:
	bset #1,($1a,a0)
	bne.b loc_010592
	move.l #$20000,($14,a0)
	move.b #3,($1c,a0)

loc_010592:
	subq.b #1,($18,a0)
	bpl.b loc_0105d4
	tst.b ($1c,a0)
	bne.b loc_0105ac
	bclr #1,($1a,a0)
	move.b #4,($1b,a0)
	bra.b loc_0105d4

loc_0105ac:
	move.b #3,($18,a0)
	moveq #0,d0
	move.b ($19,a0),d0
	addi.w #$1eb,d0
	move.w d0,(4,a0)
	addq.b #1,($19,a0)
	cmpi.b #4,($19,a0)
	bmi.b loc_0105d4
	clr.b ($19,a0)
	subq.b #1,($1c,a0)

loc_0105d4:
	jmp loc_00ef60(pc)

;##############################################################################
loc_0105d8:
	bset #1,($1a,a0)
	bne.b loc_0105f0
	move.l #$fffe0000,($10,a0)
	move.l #$8000,($14,a0)

loc_0105f0:
	subq.b #1,($18,a0)
	bpl.b loc_01061a
	move.b #6,($18,a0)
	moveq #0,d0
	move.b ($19,a0),d0
	addi.w #$1eb,d0
	move.w d0,(4,a0)
	addq.b #1,($19,a0)
	cmpi.b #4,($19,a0)
	bmi.b loc_01061a
	clr.b ($19,a0)

loc_01061a:
	move.w (8,a0),d0
	move.w $103424,d1
	subi.w #$40,d1
	cmp.w d1,d0
	bpl.b loc_010640
	move.w ($c,a0),d0
	move.w $103428,d1
	addi.w #$40,d1
	cmp.w d1,d0
	bmi.b loc_010640
	clr.w (a0)

loc_010640:
	jmp loc_00ef60(pc)

;##############################################################################
loc_010644:
	bset #0,($1a,a0)
	bne.b loc_010664
	move.w #$100,($18,a0)
	move.l #$10000,($1c,a0)
	move.b (1,a0),d0
	lsl.b #3,d0
	move.b d0,($1b,a0)

loc_010664:
	tst.b ($1b,a0)
	beq.b loc_010670
	subq.b #1,($1b,a0)
	bra.b loc_0106ce

loc_010670:
	subq.b #1,($18,a0)
	bne.b loc_010694
	move.b #4,($18,a0)
	moveq #0,d0
	move.b ($19,a0),d0
	addi.w #$1260,d0
	move.w d0,(4,a0)
	addq.b #1,($19,a0)
	andi.b #1,($19,a0)

loc_010694:
	move.w ($1e,a0),d0
	lea.l loc_010a68(pc),a1
	nop
	move.l (a1,d0.w),d1
	add.l d1,($10,a0)
	move.l (4,a1,d0.w),d2
	add.l d2,($14,a0)
	subq.w #1,($1c,a0)
	bne.b loc_0106c0
	move.w ($a,a1,d0.w),($1c,a0)
	addi.w #$c,($1e,a0)

loc_0106c0:
	move.w (8,a0),d0
	cmp.w $103424,d0
	bpl.b loc_0106ce
	clr.w (a0)

loc_0106ce:
	jmp loc_00ef60(pc)

;##############################################################################
loc_0106d2:
	bset #0,($1a,a0)
	bne.b loc_0106ee
	move.w #0,($18,a0)
	move.l #$ffffe000,($10,a0)
	move.b (1,a0),($19,a0)

loc_0106ee:
	subq.b #1,($18,a0)
	bpl.b loc_010718
	move.b #8,($18,a0)
	moveq #0,d0
	move.b ($19,a0),d0
	move.w #$1272,d1
	add.w d0,d1
	move.w d1,(4,a0)
	addq.b #1,d0
	cmpi.b #4,d0
	bmi.b loc_010714
	moveq #0,d0

loc_010714:
	move.b d0,($19,a0)

loc_010718:
	move.w $105c9c,($1e,a0)
	move.w #$3b,$105c9c
	jsr loc_00ef60(pc)
	move.w ($1e,a0),$105c9c
	rts

;##############################################################################
loc_010736:
	bset #0,($1a,a0)
	bne.b loc_01076e
	move.w #0,($18,a0)
	move.w #$1835,(4,a0)
	bset #1,$106996
	move.w $105c9c,($1c,a0)
	jsr loc_00ef7c(pc)
	move.w $105c9c,($1e,a0)
	move.l #$10000,($20,a0)

loc_01076e:
	lea.l loc_010a48(pc),a1
	nop
	move.w ($22,a0),d0
	move.l (a1,d0.w),d1
	add.l d1,($14,a0)
	move.l ($14,a0),d2
	add.l d2,($c,a0)
	subq.w #1,($20,a0)
	bne.b loc_010794
	move.l (4,a1,d0.w),($20,a0)

loc_010794:
	move.w (4,a0),d2
	add.w d2,d2
	add.w d2,d2
	lea.l loc_090020,a2
	movea.l (a2,d2.w),a2
	move.w (a2)+,d7
	move.w d7,($2e,a0)
	lea.l $103424,a3
	moveq #0,d1
	move.b (3,a0),d1
	lsl.w #4,d1
	adda.w d1,a3
	move.w (a2),d5
	andi.w #$1f,d5
	add.w d5,d5
	add.w d5,d5
	addq.w #4,d5
	btst #7,($2e,a0)
	beq.b loc_0107d2
	moveq #8,d5

loc_0107d2:
	move.w (8,a0),d0
	move.w (a2,d5.w),d3
	btst #0,(6,a0)
	beq.b loc_0107e8
	neg.w d3
	subi.w #$10,d3

loc_0107e8:
	add.w d3,d0
	sub.w (a3),d0
	move.w ($c,a0),d1
	sub.w (-2,a2,d5.w),d1
	sub.w (4,a3),d1
	sub.w $106928,d1
	lsl.w #7,d0
	lsl.w #7,d1
	addi.w #$a,d1
	move.w ($1c,a0),d2
	addi.w #$8200,d2
	movea.l $101420,a2
	move.w d2,(a2)+
	move.w d1,(a2)+
	addi.w #$200,d2
	move.w d2,(a2)+
	move.w d0,(a2)+
	move.l a2,$101420
	move.w ($1e,a0),$105c9c
	rts

;##############################################################################
loc_010830:
	bset #0,($1a,a0)
	bne.b loc_010884
	lea.l player1mem,a3
	move.b (3,a0),d3
	andi.l #$10,d3
	lsl.l #5,d3
	move.b ($20,a3,d3.w),(7,a0)
	clr.b (3,a0)
	ori.b #$74,(6,a0)
	move.w #0,($18,a0)
	move.w #0,($1c,a0)
	move.b #0,($1b,a0)
	move.w #$e4e,d0
	cmpi.b #$c,(1,a0)
	bmi.b loc_01087c
	move.w #$1223,d0

loc_01087c:
	add.b (1,a0),d0
	move.w d0,(4,a0)

loc_010884:
	moveq #0,d0
	move.b (1,a0),d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_0108b8(pc),a1
	nop
	movea.l (a1,d0.w),a1
	jsr (a1)
	cmpi.b #$18,($1b,a0)
	bpl.b loc_0108a8
	addq.b #1,($1b,a0)
	bra.b loc_0108b4

loc_0108a8:
	btst #0,$10346b
	bne.b loc_0108b4
	rts

loc_0108b4:
	jmp loc_00f1b4(pc)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0108b8:
	dc.l loc_0109aa,loc_0109aa,loc_0109aa,loc_0109aa
	dc.l loc_0109aa,loc_0109aa,loc_0109aa,loc_0109aa
	dc.l loc_0109aa,loc_0109aa,loc_0109aa,loc_0109aa
	dc.l loc_0109aa,loc_0109aa,loc_0109aa,loc_0109aa
	dc.l loc_0109aa,loc_0109aa,loc_0109aa

loc_010904:
	dc.l $00010000,$00060000
	dc.l $00010000,$00060000
	dc.l $00010000,$00060000
	dc.l $00010000,$00060000
	dc.l $00010000,$00060000
	dc.l $ffff0000,$00060000
	dc.l $00010000,$00060000
	dc.l $ffff0000,$00060000
	dc.l $00010000,$00060000
	dc.l $00010000,$00060000
	dc.l $00010000,$00060000
	dc.l $ffff0000,$00060000
	dc.l $00010000,$00060000
	dc.l $00010000,$00060000
	dc.l $00010000,$00060000
	dc.l $ffff0000,$00060000
	dc.l $00010000,$00060000
	dc.l $00010000,$00060000
	dc.l $ffff0000,$00060000

loc_01099c:
	dc.b $00,$0e,$02,$0f,$04,$05,$06,$0f
	dc.b $08,$0d,$0d,$0b,$0f,$9e

;##############################################################################
loc_0109aa:
	bset #1,($1a,a0)
	bne.b loc_0109ea
	move.w #3,($20,a0)
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #3,d0
	lea.l loc_010904(pc),a1
	move.l (a1,d0.w),d1
	btst #0,(6,a0)
	bne.b loc_0109d4
	neg.l d1
	addq.l #1,d1

loc_0109d4:
	move.l d1,($10,a0)
	move.l (4,a1,d0.w),d1
	move.l d1,($14,a0)
	asr.l #4,d1
	neg.l d1
	addq.l #1,d1
	move.l d1,($1c,a0)

loc_0109ea:
	move.l ($1c,a0),d1
	add.l d1,($14,a0)
	move.l ($14,a0),d2
	add.l d2,($c,a0)
	move.l ($10,a0),d3
	add.l d3,(8,a0)
	cmpi.w #1,($c,a0)
	bpl.b loc_010a44
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #3,d0
	lea.l loc_010904(pc),a1
	move.l (4,a1,d0.w),d1
	move.w #3,d2
	sub.w ($20,a0),d2
	asr.l d2,d1
	move.l d1,($14,a0)
	move.l ($10,a0),d3
	asr.l #1,d3
	move.l d3,($10,a0)
	subq.w #1,($20,a0)
	bne.b loc_010a44
	moveq #0,d0
	move.l d0,($10,a0)
	move.l d0,($14,a0)
	move.l d0,(a0)

loc_010a44:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_010a46:
	dc.w $5368

loc_010a48:
	dc.l $ffff8000,$00400008,$00000400,$00400010
	dc.l $fffffc00,$00400008,$00000000,$00000000

loc_010a68:
	dc.l $fffd0000,$fffd0000,$00000030,$00000000
	dc.l $00001000,$00000010,$00003000,$00002000
	dc.l $00000010,$00003000,$ffffe000,$00000010
	dc.l $ffffd000,$ffffe000,$00000010,$ffffd000
	dc.l $00002000,$00000010,$00000000,$00000800
	dc.l $00000000,$00000000,$00000000,$00000000

;##############################################################################
loc_010ac8:
	bset #0,($1a,a0)
	bne.b loc_010ad6
	move.w #0,($18,a0)

loc_010ad6:
	subq.b #1,($18,a0)
	bpl.b loc_010af4
	moveq #0,d0
	move.b ($19,a0),d0
	lea.l loc_010b66(pc),a1
	nop
	move.w (a1,d0.w),(4,a0)
	move.w (2,a1,d0.w),($18,a0)

loc_010af4:
	tst.b exstageflag
	bne.b ExKarnovEffect

	move.w #$5200,d0
	move.w #$5220,d1
	move.w #$5240,d2
	move.w #$5260,d3
	move.w #$5280,d4
	cmpi.w #$255,(4,a0)
	bne.b loc_010b24
	move.w #$52a0,d0
	move.w #$52c0,d1
	move.w #$52e0,d2
	move.w #$5300,d3
	move.w #$5320,d4


loc_010b24:
	lea.l $106a5e,a1
	move.w d0,(a1)+
	move.w #$1ca0,(a1)+
	move.w d1,(a1)+
	move.w #$1cc0,(a1)+
	move.w d2,(a1)+
	move.w #$1ce0,(a1)+
	move.w d3,(a1)+
	move.w #$1d00,(a1)+
	move.w d4,(a1)+
	move.w #$1d20,(a1)+
	move.w $105c9c,($1e,a0)
	move.w #$36,$105c9c
	jsr loc_00ef7c(pc)
	move.w ($1e,a0),$105c9c

ExKarnovEffect:
	rts

;ExKarnovEffect:
;	tst.b player1mem+$1d1
;	bne.b editingpalette
;	move.w #ExKarnovNormal0-loc_065000,d0
;	move.w #ExKarnovNormal1-loc_065000,d1
;	move.w #ExKarnovNormal2-loc_065000,d2
;	move.w #ExKarnovNormal3-loc_065000,d3
;	move.w #ExKarnovNormal4-loc_065000,d4
;	cmpi.w #$255,(4,a0)
;	bne.b Exkarpalwrite
;	move.w #ExKarnovLighting0-loc_065000,d0
;	move.w #ExKarnovLighting1-loc_065000,d1
;	move.w #ExKarnovLighting2-loc_065000,d2
;	move.w #ExKarnovLighting3-loc_065000,d3
;	move.w #ExKarnovLighting4-loc_065000,d4
;
;Exkarpalwrite:
;	lea.l $106a5e,a1
;	move.w d0,(a1)+
;	move.w #$1ca0,(a1)+
;	move.w d1,(a1)+
;	move.w #$1cc0,(a1)+
;	move.w d2,(a1)+
;	move.w #$1ce0,(a1)+
;	move.w d3,(a1)+
;	move.w #$1d00,(a1)+
;	move.w d4,(a1)+
;	move.w #$1d20,(a1)+
;	move.w $105c9c,($1e,a0)
;	move.w #$36,$105c9c
;	jsr loc_00ef7c(pc)
;	move.w ($1e,a0),$105c9c
;
;editingpalette:
;	rts

;1c00 Close
;1c20 Close
;1c40 Close
;1c60 Close
;1c80 Close

;1ca0 Far
;1cc0 Far
;1ce0 Far
;1d00 Far
;1d20 Far

;1dc0 Karnov Statue
;1de0 Lady Statue

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_010b66:
	dc.w $017b,$4004
	dc.w $0242,$0408
	dc.w $0243,$040c
	dc.w $0244,$0410
	dc.w $0245,$0414
	dc.w $0246,$0418
	dc.w $017b,$041c
	dc.w $0247,$0420
	dc.w $017b,$0424
	dc.w $0242,$0428
	dc.w $017b,$402c
	dc.w $017b,$0430
	dc.w $0248,$0434
	dc.w $017b,$0438
	dc.w $0249,$043c
	dc.w $024a,$0440
	dc.w $017b,$0444
	dc.w $024b,$0448
	dc.w $017b,$404c
	dc.w $017b,$0450
	dc.w $024c,$0454
	dc.w $024d,$0858
	dc.w $024e,$045c
	dc.w $017b,$0460
	dc.w $024f,$0464
	dc.w $017b,$0468
	dc.w $017b,$046c
	dc.w $017b,$0470
	dc.w $0250,$0474
	dc.w $0251,$0878
	dc.w $0252,$047c
	dc.w $0253,$0480
	dc.w $017b,$4084
	dc.w $0254,$0488
	dc.w $0255,$048c
	dc.w $0256,$0400

;##############################################################################
;Jean Checks
loc_010bf6:
	bset #0,($1a,a0)
	bne.b loc_010c28

	move.w #0,($18,a0)
	move.l #0,($1c,a0)
	lea.l player1mem,a1
	cmpi.b #7,(1,a1)
	beq.b loc_010c28
	cmpi.b #7,($201,a1)
	beq.b loc_010c28
	move.w #$10,($1c,a0)

loc_010c28:
	btst #2,($1a,a0)
	bne.b loc_010c8a
	btst #6,$101000
	beq.b loc_010c8a
	bset #2,($1a,a0)
	lea.l player1mem,a1
	lea.l player2mem,a2
	cmpi.b #7,(1,a1)
	bne.b loc_010c5e
	move.b ($143,a1),d1
	move.b ($143,a2),d0
	bra.b loc_010c6e

loc_010c5e:
	cmpi.b #7,(1,a2)
	bne.b loc_010c8a
	move.b ($143,a1),d0
	move.b ($143,a2),d1

loc_010c6e:
	move.w #4,d2
	move.w #8,d7
	sub.b d0,d1
	beq.b loc_010c80
	bpl.b loc_010c7e
	neg.w d2

loc_010c7e:
	add.w d2,d7

loc_010c80:
	move.w d7,($1c,a0)
	move.w #0,($1e,a0)

loc_010c8a:
	subq.w #1,($18,a0)
	bpl.b loc_010cba
	lea.l loc_010cc0(pc),a1
	nop
	move.w ($1c,a0),d0
	movea.l (a1,d0.w),a2
	move.w ($1e,a0),d1
	move.w (a2,d1.w),(4,a0)
	moveq #0,d2
	move.b (2,a2,d1.w),d2
	move.w d2,($18,a0)
	move.b (3,a2,d1.w),d2
	move.w d2,($1e,a0)

loc_010cba:
	jmp loc_00ef7c(pc)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_010cbe:
	dc.w $1432

loc_010cc0:
	dc.l loc_010cd4
	dc.l loc_010cf0
	dc.l loc_010d08
	dc.l loc_010cfc
	dc.l loc_010d14

loc_010cd4:
	dc.w $124c,$1004,$124d,$1008
	dc.w $124e,$100c,$124f,$1010
	dc.w $1250,$1014,$1251,$1018
	dc.w $1252,$1000

loc_010cf0:
	dc.w $1253,$1004,$1254,$1008,$1255,$1000

loc_010cfc:
	dc.w $1256,$1004,$1257,$1008,$1258,$1000

loc_010d08:
	dc.w $1259,$1004,$125a,$1008,$125b,$1000

loc_010d14:
	dc.w $125c,$1004,$125d,$1008,$125e,$100c,$125d,$1000

;##############################################################################
loc_010d24:
	bset #0,($1a,a0)
	bne.b loc_010d44
	move.w #1,($18,a0)
	move.w #0,($1c,a0)
	move.w #1,($20,a0)
	move.w #0,($22,a0)

loc_010d44:
	tst.w ($20,a0)
	beq.b loc_010d54
	subq.w #1,($20,a0)
	bne.b loc_010d52
	nop

loc_010d52:
	rts

loc_010d54:
	subq.w #1,($18,a0)
	bne.b loc_010da2
	move.w #4,($18,a0)
	cmpi.w #$a,($1c,a0)
	bmi.b loc_010d92
	clr.w ($1c,a0)
	moveq #0,d0
	move.b (1,a0),d0
	lea.l loc_010da8(pc),a1
	nop
	movea.l (a1,d0.w),a2
	adda.w ($22,a0),a2
	move.w (a2)+,($20,a0)
	move.w (a2)+,(8,a0)
	move.w (a2)+,($c,a0)
	move.w (a2)+,($22,a0)
	rts

loc_010d92:
	move.w ($1c,a0),d0
	addi.w #$1236,d0
	move.w d0,(4,a0)
	addq.w #1,($1c,a0)

loc_010da2:
	jmp loc_00ef7c(pc)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_010da6:
	dc.w $3028

loc_010da8:
	dc.l loc_010db4
	dc.l loc_010de4
	dc.l loc_010e14

loc_010db4:
	dc.w $0010,$0270,$01d0,$0008,$0001,$0200,$01f0,$0010
	dc.w $0001,$01a0,$01c0,$0018,$0001,$02c0,$01e0,$0020
	dc.w $0001,$02e0,$01c0,$0028,$0001,$01e0,$0200,$0000

loc_010de4:
	dc.w $0030,$0240,$01b0,$0008,$0001,$02f0,$0200,$0010
	dc.w $0001,$01b0,$01f0,$0018,$0001,$01f0,$01c0,$0020
	dc.w $0001,$0290,$01c0,$0028,$0001,$02a0,$01d0,$0000

loc_010e14:
	dc.w $0050,$0190,$0200,$0008,$0001,$02f0,$01c0,$0010
	dc.w $0001,$0280,$01d0,$0018,$0001,$0210,$01c0,$0020
	dc.w $0001,$02c0,$01d0,$0028,$0001,$01f0,$01f0,$0000

;##############################################################################
loc_010e44:
	bset #0,($1a,a0)
	bne.b loc_010e5e
	move.w #1,($18,a0)
	move.w #0,($1c,a0)
	move.w #$20f,(4,a0)

loc_010e5e:
	lea.l $103424,a1
	move.w ($20,a1),d0
	move.w ($30,a1),d1
	sub.w d0,d1
	asr.w #3,d1
	add.w d1,d0
	addi.w #$a0,d0
	move.w d0,(8,a0)
	move.w $105c9c,($1c,a0)
	move.w #$67,$105c9c
	jsr loc_00ef60(pc)
	move.w ($1c,a0),$105c9c
	rts

;##############################################################################
loc_010e98:
	bset #0,($1a,a0)
	bne.b loc_010eac
	move.w #1,($20,a0)
	move.w #0,($22,a0)

loc_010eac:
	subq.b #1,($18,a0)
	bpl.b loc_010ef0
	moveq #0,d0
	move.b (1,a0),d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_012bf0,a1
	movea.l (a1,d0.w),a1
	moveq #0,d1
	move.b ($19,a0),d1
	adda.w d1,a1
	move.w (a1)+,(4,a0)
	move.b (a1)+,($18,a0)
	move.b (a1)+,($1a,a0)
	bset #0,($1a,a0)
	addq.b #4,d1
	bclr #7,($1a,a0)
	beq.b loc_010eec
	moveq #0,d1

loc_010eec:
	move.b d1,($19,a0)

;Ryoko Palette Code
loc_010ef0:
	tst.b exstageflag
	bne.b exryokopal

	move.w $105c9c,($1e,a0)
	move.w #$45,$105c9c
	jsr loc_00ef7c(pc)
	move.w ($1e,a0),$105c9c
	subq.w #1,($20,a0)
	bne.b loc_010f3e
	move.w #$10,($20,a0)
	lea.l $106a5e,a1
	move.w ($22,a0),d0
	addi.w #$3600,d0
	move.w d0,(a1)+
	move.w #$1cc0,(a1)+
	addi.w #$20,($22,a0)
	cmpi.w #$80,($22,a0)
	bmi.b loc_010f3e
	clr.w ($22,a0)
	bra.b loc_010f3e

exryokopal:
	move.w $105c9c,($1e,a0)
	move.w #$45,$105c9c
	jsr loc_00ef7c(pc)
	move.w ($1e,a0),$105c9c
	subq.w #1,($20,a0)
	bne.b loc_010f3e
	move.w #$10,($20,a0)
	lea.l $106a5e,a1
	move.w ($22,a0),d0
	addi.w #ExRyokoPaperLantern-loc_065000,d0
	move.w d0,(a1)+
	move.w #$1cc0,(a1)+
	addi.w #$20,($22,a0)
	cmpi.w #$80,($22,a0)
	bmi.b loc_010f3e
	clr.w ($22,a0)

loc_010f3e:
	rts

;##############################################################################
loc_010f40:
	nop
	lea.l $105cac,a1
	move.w #$1f,d6

loc_010f4c:
	tst.b (a1)
	beq.b loc_010f5a
	adda.w #$30,a1
	dbra d6,loc_010f4c
	bra.b loc_010f8a

loc_010f5a:
	move.w d4,d6
	andi.w #$f00,d6
	lsr.w #4,d6
	or.b d6,d4
	andi.l #$ff,d4
	moveq #0,d6
	move.w d0,(a1)+
	move.w d4,(a1)+
	move.w d6,(a1)+
	move.b d3,(a1)+
	move.b d6,(a1)+
	move.l d1,(a1)+
	move.l d2,(a1)+
	move.l d6,(a1)+
	move.l d6,(a1)+
	move.l d6,(a1)+
	move.l d6,(a1)+
	move.l d6,(a1)+
	move.l d6,(a1)+
	move.l d6,(a1)+
	move.l d6,(a1)+

loc_010f8a:
	rts

;##############################################################################
loc_010f8c:
	moveq #$c,d7
	bra.b loc_010fc4

;##############################################################################
loc_010f90:
	moveq #$e,d7
	bra.b loc_010fc4

;##############################################################################
loc_010f94:
	moveq #$10,d7
	bra.b loc_010fc4

;##############################################################################
loc_010f98:
	moveq #$12,d7
	bset #4,($be,a0)
	bra.b loc_010fc4

;##############################################################################
loc_010fa2:
	moveq #$14,d7
	bset #4,($be,a0)
	bra.b loc_010fc4

;##############################################################################
loc_010fac:
	moveq #$d,d7
	bra.b loc_010fcc

;##############################################################################
loc_010fb0:
	moveq #$13,d7
	bset #4,($be,a0)
	bra.b loc_010fcc

;##############################################################################
loc_010fba:
	moveq #$20,d7
	bset #2,($bf,a0)
	bra.b loc_011012

;##############################################################################
loc_010fc4:
	moveq #0,d1
	move.b ($144,a0),d1
	add.w d1,d7

loc_010fcc:
	btst #0,($bf,a0)
	bne.b loc_011012
	move.w #$c00,d0
	move.l ($c0,a0),d1
	move.l ($c4,a0),d2
	move.b ($21,a0),d3
	jsr loc_010f40
	cmpi.w #$a,($d0,a0)
	bne.b loc_011012
	cmpi.b #1,($144,a0)
	bne.b loc_011012
	move.w #$2000,d0
	add.l ($c0,a0),d1
	add.l ($c4,a0),d2
	move.b ($21,a0),d3
	move.w (a0),d4
	jsr loc_010f40

loc_011012
	bset #0,($bf,a0)
	bne.b loc_011030
	move.w #0,($124,a0)
	move.b #1,($126,a0)
	move.b #0,($127,a0)
	move.l d7,($13c,a0)

loc_011030:
	jmp loc_011036(pc)

;##############################################################################
loc_011034:
	nop

loc_011036:
	subq.b #1,($126,a0)
	bne.w loc_0110c6
	move.b ($127,a0),d3
	andi.w #$f0,d3
	beq.b loc_011054
	subi.w #$10,d3
	lsr.w #2,d3
	move.w d3,($124,a0)
	bra.b loc_01108e

loc_011054:
	btst #0,($127,a0)
	beq.b loc_01108e
	bclr #0,($bf,a0)
	lea.l loc_0110c8(pc),a2
	nop
	moveq #0,d6
	move.w ($d0,a0),d6
	move.b (a2,d6.w),d6
	move.w d6,($d0,a0)
	move.w #1,$10346c
	cmpi.w #$13,($d0,a0)
	bne.b loc_01108c
	move.b #8,($14e,a0)

loc_01108c:
	bra.b loc_0110c6

loc_01108e:
	moveq #0,d0
	move.b (1,a0),d0
	move.l d0,d1
	lsl.l #7,d0
	lsl.l #6,d1
	lea.l loc_05a000,a1
	add.l d1,d0
	add.l d7,d7
	add.l d7,d0
	move.w (a1,d0.l),d0
	move.w ($124,a0),d1
	add.w d1,d0
	addq.w #4,d1
	move.w d1,($124,a0)
	move.w (a1,d0.w),d1
	move.w (2,a1,d0.w),d2
	move.w d1,($22,a0)
	move.w d2,($126,a0)

loc_0110c6:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0110c8:
	dc.b $00,$00,$00,$00,$00,$00,$00,$15
	dc.b $15,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$13,$00,$00,$13,$15,$13,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00

;##############################################################################
loc_0110e8:
	bset #0,($bf,a0)
	bne.b loc_011128
	ori.b #$d,($bf,a0)
	move.w #0,($124,a0)
	move.b #1,($126,a0)
	move.b #0,($127,a0)
	move.l #$a8000,($cc,a0)
	move.l #$20000,d0
	btst #1,($bd,a0)
	bne.b loc_011124
	move.l #$fffe0000,d0

loc_011124:
	move.l d0,($c8,a0)

loc_011128:
	subi.l #$9000,($cc,a0)
	btst #7,($c4,a0)
	beq.b loc_01117e
	moveq #0,d0
	move.l d0,($c4,a0)
	move.l d0,($c8,a0)
	move.l d0,($cc,a0)
	move.b #1,($126,a0)
	bclr #3,($bf,a0)
	moveq #6,d0
	btst #5,($146,a0)
	beq.b loc_01116a
	bclr #0,($bf,a0)
	move.w #$16,($d0,a0)
	moveq #$b,d0

loc_01116a:
	move.b d0,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_01117e:
	moveq #$1a,d7
	btst #5,($146,a0)
	beq.b loc_011190
	moveq #$1b,d7
	bset #3,($be,a0)

loc_011190:
	move.b #8,($14e,a0)
	jmp loc_011036

;##############################################################################
loc_01119c:
	bset #0,($bf,a0)
	bne.b loc_0111d6
	bset #2,($bf,a0)
	bset #3,($be,a0)
	move.w #0,($124,a0)
	move.b #1,($126,a0)
	move.b #0,($127,a0)
	move.b #0,($128,a0)
	move.b #1,($129,a0)
	move.l #$60000,($cc,a0)

loc_0111d6:
	btst #3,($bf,a0)
	bne.b loc_0111fc
	bset #3,($bf,a0)
	move.l #$20000,d0
	btst #1,($bd,a0)
	bne.b loc_0111f8
	move.l #$fffe0000,d0

loc_0111f8:
	move.l d0,($c8,a0)

loc_0111fc:
	tst.b ($128,a0)
	beq.b loc_01121a
	subq.b #1,($128,a0)
	bne.w loc_011294
	move.b #1,($126,a0)
	bclr #3,($bf,a0)
	bra.w loc_011294

loc_01121a:
	subi.l #$6001,($cc,a0)
	btst #7,($c4,a0)
	beq.b loc_011294
	bclr #3,($be,a0)
	moveq #0,d0
	move.l d0,($c4,a0)
	move.l d0,($c8,a0)
	move.l d0,($cc,a0)
	move.b #$10,($128,a0)
	move.w #2,d0
	move.w #4,d1
	jsr loc_00cbde
	move.b #$b,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	move.w #$800,d0
	move.l ($c0,a0),d1
	move.l ($c4,a0),d2
	move.b ($21,a0),d3
	jsr loc_010f40
	btst #5,($146,a0)
	beq.b loc_0112c4
	move.w #$16,($d0,a0)
	bclr #0,($bf,a0)
	rts

loc_011294:
	moveq #$17,d7
	btst #5,($146,a0)
	beq.b loc_0112c4
	moveq #$1b,d7
	subq.b #1,($129,a0)
	bne.b loc_0112c4
	move.b #$10,($129,a0)
	move.w #$3000,d0
	move.l ($c0,a0),d1
	move.l ($c4,a0),d2
	move.b ($21,a0),d3
	move.w (a0),d4
	jsr loc_010f40

loc_0112c4:
	jmp loc_011036

;##############################################################################
loc_0112ca:
	bset #0,($bf,a0)
	bne.b loc_011300
	ori.b #$d,($bf,a0)
	bclr #3,($be,a0)
	move.w #0,($124,a0)
	move.b #1,($126,a0)
	move.b #0,($127,a0)
	move.l #$36000,($cc,a0)
	move.w #1,$10346c

loc_011300:
	subi.l #$6000,($cc,a0)
	btst #7,($c4,a0)
	beq.b loc_011366
	move.w #2,d0
	move.w #4,d1
	jsr loc_00cbde
	moveq #0,d0
	move.l d0,($c4,a0)
	move.l d0,($c8,a0)
	move.l d0,($cc,a0)
	move.b #1,($126,a0)
	bclr #3,($bf,a0)
	bclr #0,($bf,a0)
	move.b #$b,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	move.w #$13,($d0,a0)
	tst.b ($147,a0)
	bne.b loc_011366
	move.w #$15,($d0,a0)

loc_011366:
	moveq #$19,d7
	jmp loc_011036

;##############################################################################
loc_01136e:
	bset #0,($bf,a0)
	bne.w loc_01140c
	bclr #2,($bf,a0)
	bclr #3,($bf,a0)
	move.w #0,($124,a0)
	move.b #0,($126,a0)
	move.b #0,($127,a0)
	move.w #5,d0
	add.b ($144,a0),d0
	move.w d0,($12a,a0)
	move.b #1,($12c,a0)
	move.w #$3e,d7
	lea.l ($6f,a0),a1
	move.b (a1),d1
	move.w #$800,d0

loc_0113b6:
	move.b -(a1),d2
	eor.b d2,d1
	and.b d2,d1
	beq.b loc_0113cc
	subi.w #$30,d0
	cmpi.w #$200,d0
	bpl.b loc_0113cc
	move.w #$300,d0

loc_0113cc:
	move.b d2,d1
	dbra d7,loc_0113b6
	move.w d0,($128,a0)
	move.l ($c0,a0),d1
	move.l ($c4,a0),d2
	move.b ($21,a0),d3
	move.w (a0),d4
	move.w #$1000,d0
	jsr loc_010f40
	move.w #$1001,d0
	jsr loc_010f40
	move.w #$1002,d0
	jsr loc_010f40
	move.w #$1003,d0
	jsr loc_010f40

loc_01140c:
	subq.b #1,($12c,a0)
	bne.b loc_011418
	move.b #$10,($12c,a0)

loc_011418:
	move.w ($128,a0),d0
	addi.w #$30,d0
	cmpi.w #$800,d0
	bmi.b loc_01142a
	move.w #$800,d0

loc_01142a:
	moveq #1,d3
	tst.b ($b0,a0)
	beq.b loc_011442
	addq.w #1,d3
	subi.w #$90,d0
	cmpi.w #$200,d0
	bpl.b loc_011442
	move.w #$300,d0

loc_011442:
	move.w d0,($128,a0)
	sub.b d3,($126,a0)
	bpl.b loc_0114a8
	btst #0,($127,a0)
	beq.b loc_011478
	move.b ($127,a0),d0
	andi.w #$f0,d0
	lsr.w #2,d0
	move.w d0,($124,a0)
	subq.w #1,($12a,a0)
	bne.b loc_011478
	nop
	bclr #0,($bf,a0)
	move.w #0,($d0,a0)
	bra.b loc_0114a8

loc_011478:
	tst.w fighttimer
	beq.b loc_01148c
	movea.l ($14,a0),a2
	cmpi.w #$15,($d0,a2)
	bne.b loc_01149a

loc_01148c:
	bclr #0,($bf,a0)
	move.w #0,($d0,a0)
	bra.b loc_0114a8

loc_01149a:
	moveq #$1d,d7
	jsr loc_01108e
	move.b ($128,a0),($126,a0)

loc_0114a8:
	rts

;##############################################################################
loc_0114aa:
	bset #0,($bf,a0)
	bne.b loc_0114e8
	ori.b #$d,($bf,a0)
	bclr #3,($be,a0)
	move.w #0,($124,a0)
	move.b #1,($126,a0)
	move.b #0,($127,a0)
	move.b #0,($128,a0)
	move.b #1,($129,a0)
	move.l #$c0000,($cc,a0)
	bra.w loc_0115a0

loc_0114e8:
	bset #3,($be,a0)
	bne.w loc_0115a0
	tst.b ($147,a0)
	bne.b loc_01151c
	moveq #0,d0
	move.b (1,a0),d0
	lea.l loc_0116aa(pc),a1
	nop
	move.b (a1,d0.w),d0
	move.b d0,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_01151c:
	move.l #$20000,d0
	btst #1,($bd,a0)
	bne.b loc_011530
	move.l #$fffe0000,d0

loc_011530:
	move.l d0,($c8,a0)
	btst #2,($be,a0)
	beq.b loc_0115a0
	movem.l a0, -(a7)
	movea.l ($14,a0),a0
	move.l #$3e8,d0
	jsr loc_0043a8
	movem.l (a7)+,a0
	bclr #1,($bf,a0)
	lea.l loc_0116b8(pc),a1
	nop
	moveq #0,d0
	move.b (1,a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a1,d0.w),a2
	move.w (a2)+,d7

loc_011570:
	move.w (a2)+,d0
	move.w (a2)+,d1
	move.w (a2)+,d1
	move.w (a2)+,d2
	btst #0,($21,a0)
	beq.b loc_011584
	neg.w d1
	addq.w #1,d1

loc_011584:
	add.w ($c0,a0),d1
	add.w ($c4,a0),d2
	swap d1
	swap d2
	move.b ($21,a0),d3
	move.w (a0),d4
	jsr loc_010f40
	dbra d7,loc_011570

loc_0115a0:
	tst.b ($128,a0)
	beq.b loc_0115b8
	subq.b #1,($128,a0)
	bne.w loc_011646
	move.b #1,($126,a0)
	bra.w loc_011646

loc_0115b8:
	subi.l #$9000,($cc,a0)
	btst #7,($c4,a0)
	beq.w loc_011646
	move.w #2,d0
	move.w #4,d1
	jsr loc_00cbde
	moveq #0,d0
	move.l d0,($c4,a0)
	move.l d0,($cc,a0)
	move.b #$b,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	move.w #2,d0
	move.w #4,d1
	jsr loc_00cbde
	move.b #8,($128,a0)
	move.b #1,($126,a0)
	move.w #$800,d0
	move.l ($c0,a0),d1
	move.l ($c4,a0),d2
	move.b ($21,a0),d3
	jsr loc_010f40
	move.l ($c8,a0),d0
	asr.l #2,d0
	add.l d0,($c8,a0)
	btst #5,($146,a0)
	beq.b loc_011646
	bclr #0,($bf,a0)
	move.w #$16,($d0,a0)

loc_011646:
	moveq #$16,d7
	btst #5,($146,a0)
	beq.b loc_011676
	moveq #$1b,d7
	subq.b #1,($129,a0)
	bne.b loc_011676
	move.b #$10,($129,a0)
	move.w #$3000,d0
	move.l ($c0,a0),d1
	move.l ($c4,a0),d2
	move.b ($21,a0),d3
	move.w (a0),d4
	jsr loc_010f40

loc_011676:
	subq.b #1,($126,a0)
	bne.b loc_0116a8
	move.b ($127,a0),d3
	andi.w #$f0,d3
	beq.b loc_01168e
	lsr.w #2,d3
	move.w d3,($124,a0)
	bra.b loc_011696

loc_01168e:
	btst #0,($127,a0)
	bne.b loc_01169c

loc_011696:
	jmp loc_01108e

loc_01169c:
	bclr #0,($bf,a0)
	move.w #$16,($d0,a0)

loc_0116a8:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0116aa:
	dc.w $606b,$81af,$969e,$8cc0
	dc.w $76bc,$a87b,$c81b

loc_0116b8:
	dc.l loc_0116f0
	dc.l loc_0116fa
	dc.l loc_011704
	dc.l loc_01170e
	dc.l loc_011718
	dc.l loc_01172a
	dc.l loc_01173c
	dc.l loc_011746
	dc.l loc_011750
	dc.l loc_011762
	dc.l loc_01176c
	dc.l loc_011776
	dc.l loc_011788
	dc.l loc_011792

loc_0116f0:
	dc.w $0000
	dc.w $5400,$0000,$fff8,$0042

loc_0116fa:
	dc.w $0000
	dc.w $5401,$0000,$ffee,$0048

loc_011704:
	dc.w $0000
	dc.w $5402,$0000,$ffe6,$0052

loc_01170e:
	dc.w $0000
	dc.w $5403,$0000,$ffe6,$0050

loc_011718:
	dc.w $0001
	dc.w $5404,$0000,$fff4,$003a
	dc.w $5405,$0000,$000a,$0052

loc_01172a:
	dc.w $0001
	dc.w $5406,$0000,$000e,$0024
	dc.w $5407,$0000,$0016,$003a

loc_01173c:
	dc.w $0000
	dc.w $5408,$0000,$ffd8,$0050

loc_011746:
	dc.w $0000
	dc.w $5409,$0000,$000e,$0042

loc_011750:
	dc.w $0001
	dc.w $540a,$0000,$001e,$003a
	dc.w $540b,$0000,$0010,$0010

loc_011762:
	dc.w $0000
	dc.w $540c,$0000,$0000,$004e

loc_01176c:
	dc.w $0000
	dc.w $540d,$0000,$ffd8,$0056

loc_011776:
	dc.w $0001
	dc.w $540e,$0000,$ffe6,$0052
	dc.w $540f,$0000,$ffe6,$0058

loc_011788:
	dc.w $0000
	dc.w $5410,$0000,$ffde,$0048

loc_011792:
	dc.w $0001
	dc.w $5411,$0000,$0022,$0066
	dc.w $5412,$0000,$0036,$0066

;##############################################################################
loc_0117a4:
	bset #0,($bf,a0)
	bne.b loc_0117dc
	ori.b #4,($bf,a0)
	move.w #0,($124,a0)
	move.b #1,($126,a0)
	move.b #0,($127,a0)
	moveq #0,d0
	move.l d0,($c8,a0)
	move.l d0,($cc,a0)
	btst #2,($be,a0)
	beq.b loc_0117dc
	nop
	nop
	nop

loc_0117dc:
	moveq #$1c,d7
	subq.b #1,($126,a0)
	bne.b loc_011826
	btst #0,($127,a0)
	bne.b loc_0117f2
	jmp loc_01108e

loc_0117f2:
	move.b #8,($14e,a0)
	bclr #0,($bf,a0)
	move.w #0,($d0,a0)
	bclr #2,($be,a0)
	beq.b loc_011826
	tst.w fighttimer
	beq.b loc_011826
	movea.l ($14,a0),a2
	cmpi.w #$15,($d0,a0)
	beq.b loc_011826
	move.w #6,($d0,a0)

loc_011826:
	rts

;##############################################################################
loc_011828:
	lea.l player1mem,a1
	cmpa.l a1,a0
	bne.b loc_011836
	adda.w #$200,a1

loc_011836:
	move.b ($143,a1),d0
	move.b ($143,a0),d1
	cmp.b d1,d0
	bcs.b loc_011844
	rts

;##############################################################################
loc_011844:
	bset #0,($bf,a0)
	bne.b loc_011896
	ori.b #5,($bf,a0)
	move.w #0,($128,a0)
	move.b #0,($12a,a0)
	move.b (1,a0),d0
	add.b d0,d0
	add.b d0,d0
	move.b (7,a0),d1
	add.b d1,d1
	add.b d1,d0
	andi.w #$fe,d0
	lea.l loc_011b5c(pc),a2
	nop
	move.w (a2,d0.w),($12c,a0)
	lea.l loc_011b94(pc),a2
	nop
	move.w (a2,d0.w),($130,a0)
	moveq #$1e,d7
	move.b (7,a0),d0
	add.w d0,d7
	move.w d7,($12e,a0)

loc_011896:
	lea.l player1mem,a1
	cmpa.l a1,a0
	bne.b loc_0118a4
	adda.w #$200,a1

loc_0118a4:
	lea.l loc_0118b4(pc),a2
	nop
	move.w ($128,a0),d0
	movea.l (a2,d0.w),a2
	jmp (a2)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0118b4:
	dc.l loc_0118c4
	dc.l loc_011922
	dc.l loc_011aec
	dc.l loc_011b1c

;##############################################################################
loc_0118c4:
	bset #0,($12a,a0)
	bne.b loc_0118f2
	move.w #0,($124,a0)
	move.b #1,($126,a0)
	move.b #0,($127,a0)
	bclr #0,($21,a0)
	btst #0,($bd,a0)
	beq.b loc_0118f2
	bset #0,($21,a0)

loc_0118f2:
	move.w ($d0,a1),d0
	cmpi.b #1,$103a72
	beq.b loc_01190c
	cmpi.w #$15,d0
	beq.b loc_01190c
	cmpi.w #8,d0
	bne.b loc_011918

loc_01190c:
	bclr #0,($12a,a0)
	move.w #4,($128,a0)

loc_011918:
	move.w #0,d7
	jmp loc_011036

;##############################################################################
loc_011922:
	bset #0,($12a,a0)
	bne.b loc_011976
	move.w #0,($124,a0)
	move.b #1,($126,a0)
	move.b #0,($127,a0)
	bclr #0,($21,a0)
	cmpi.b #$c,(1,a0)
	bne.b loc_011968
	tst.b (7,a0)
	bne.b loc_011976
	move.w $103424,d0
	addi.w #$a0,d0
	cmp.w ($c0,a0),d0
	bpl.b loc_011976
	bset #0,($21,a0)
	bra.b loc_011976

loc_011968:
	btst #0,($bd,a0)
	beq.b loc_011976
	bset #0,($21,a0)

loc_011976:
	subq.b #1,($126,a0)
	bne.w loc_011aea
	move.b ($12c,a0),d0
	cmp.b ($125,a0),d0
	bne.b loc_0119de
	moveq #0,d0
	move.b ($12d,a0),d0
	beq.b loc_0119de
	move.b d0,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	cmpi.b #$9d,($12d,a0)
	bne.b loc_0119ba
	move.w #2,d0
	move.w #4,d1
	jsr loc_00cbde

loc_0119ba:
	cmpi.b #$bb,($12d,a0)
	bne.b loc_0119d8
	move.b #$21,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_0119d8:
	move.b #0,($12d,a0)

loc_0119de:
	move.b ($130,a0),d0
	cmp.b ($125,a0),d0
	bne.w loc_011a94
	moveq #0,d7
	move.l d7,d1
	move.l d7,d2
	move.b ($131,a0),d7
	lea.l loc_011bcc(pc),a1
	nop
	move.w (a1,d7.w),d0
	move.w (2,a1,d7.w),d1
	move.w (4,a1,d7.w),d2
	btst #0,($21,a0)
	beq.b loc_011a10
	neg.l d1

loc_011a10:
	swap d1
	swap d2
	add.l ($c0,a0),d1
	add.l ($c4,a0),d2
	move.b ($21,a0),d3
	move.w (a0),d4
	jsr loc_010f40
	cmpi.b #$c,(1,a0)
	bne.b loc_011a94
	tst.b (7,a0)
	beq.b loc_011a94
	cmpi.b #$10,($130,a0)
	bne.b loc_011a46
	move.w #$341e,($130,a0)
	bra.b loc_011a94

loc_011a46:
	cmpi.b #$34,($130,a0)
	bne.b loc_011a56
	move.w #$5024,($130,a0)
	bra.b loc_011a94

loc_011a56:
	cmpi.b #$50,($130,a0)
	bne.b loc_011a66
	move.w #$742a,($130,a0)
	bra.b loc_011a94

loc_011a66:
	cmpi.b #$74,($130,a0)
	bne.b loc_011a76
	move.w #$9430,($130,a0)
	bra.b loc_011a94

loc_011a76:
	cmpi.b #$94,($130,a0)
	bne.b loc_011a86
	move.w #$b036,($130,a0)
	bra.b loc_011a94

loc_011a86:
	cmpi.b #$b0,($130,a0)
	bne.b loc_011a94
	move.w #$fc3c,($130,a0)

loc_011a94:
	btst #0,($127,a0)
	beq.b loc_011ae0
	bclr #0,($12a,a0)
	move.w #8,($128,a0)
	move.l d7,($13c,a0)
	move.b ($127,a0),d0
	andi.w #$f0,d0
	bne.b loc_011aca
	move.w #$15,($d0,a0)
	bclr #0,($12a,a0)
	move.w #$c,($128,a0)
	bra.b loc_011aea

loc_011aca:
	lsr.w #2,d0
	subq.w #4,d0
	move.w d0,($124,a0)
	move.b #1,($126,a0)
	bclr #0,($127,a0)
	bra.b loc_011aea

loc_011ae0:
	move.w ($12e,a0),d7
	jmp loc_01108e

loc_011aea:
	rts

;##############################################################################
loc_011aec:
	bset #0,($12a,a0)
	bne.b loc_011afa
	move.b #$40,($12b,a0)

loc_011afa:
	subq.b #1,($12b,a0)
	bne.b loc_011b12
	move.w #$15,($d0,a0)
	bclr #0,($12a,a0)
	move.w #8,($128,a0)

loc_011b12:
	move.w ($12e,a0),d7
	jmp loc_011036

;##############################################################################
loc_011b1c:
	bset #0,($12a,a0)
	bne.b loc_011b2a
	move.b #$40,($12b,a0)

loc_011b2a:
	btst #0,($127,a0)
	beq.b loc_011b52
	move.b ($127,a0),d0
	andi.w #$f0,d0
	bne.b loc_011b3e
	rts

loc_011b3e:
	lsr.w #2,d0
	subq.w #4,d0
	move.w d0,($124,a0)
	move.b #1,($126,a0)
	bclr #0,($127,a0)

loc_011b52:
	move.w ($12e,a0),d7
	jmp loc_01108e

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_011b5c:
	dc.w $0062,$0061,$0067,$0067
	dc.w $107f,$1080,$50ad,$08ae
	dc.w $0c94,$2095,$109d,$209f
	dc.w $108a,$108b,$1008,$0cbf
	dc.w $1471,$0c72,$10ba,$0cbb
	dc.w $10a7,$10a6,$107a,$007c
	dc.w $1cc4,$ccc7,$0c1b,$0c1b

loc_011b94:
	dc.w $fc00,$fc00,$fc00,$fc00
	dc.w $fc00,$fc00,$fc00,$fc00
	dc.w $fc00,$fc00,$fc00,$fc00
	dc.w $fc00,$fc00,$fc00,$0c06
	dc.w $fc00,$0c0c,$fc00,$fc00
	dc.w $fc00,$fc00,$fc00,$fc00
	dc.w $0c12,$1018,$fc00,$0000

loc_011bcc:
	dc.w $0000,$0000,$0000,$3c00
	dc.w $0038,$0060,$3c04,$fff0
	dc.w $0050,$3c08,$0057,$003b
	dc.w $3c0c,$ffb0,$0060,$3c10
	dc.w $ffd0,$0070,$3c14,$fff0
	dc.w $0080,$3c18,$0010,$0080
	dc.w $3c1c,$0030,$0070,$3c20
	dc.w $0050,$0060

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_011c08:
	dc.l $00000181,$00030000,$00030000,$ffffd000
	dc.l $00000182,$fffd0000,$00020000,$ffffe000
	dc.l $00000183,$00020000,$00040000,$ffffc000
	dc.l $00000184,$fffe0000,$00050000,$ffffb000
	dc.l $00000185,$00010000,$00030000,$ffffd000
	dc.l $00000186,$ffff0000,$00020000,$ffffe000
	dc.l $00000187,$00040000,$00010000,$fffff000
	dc.l $00000188,$fffc0000,$00040000,$ffffc000
	dc.l $00000189,$00050000,$00050000,$ffffb000
	dc.l $00000194,$ffff0000,$00020000,$ffffe000
	dc.l $00000195,$00010000,$00020000,$ffffe000
	dc.l $00000196,$fffe0000,$00030000,$ffffd000
	dc.l $00000197,$00020000,$00030000,$ffffd000
	dc.l $00000198,$fffd0000,$00040000,$ffffc000
	dc.l $00000199,$00030000,$00040000,$ffffc000
	dc.l $0000019a,$fffc0000,$00010000,$fffff000
	dc.l $0000019b,$00040000,$00010000,$fffff000
	dc.l $0000019d,$ffff0000,$00030000,$ffffd000
	dc.l $0000019e,$00010000,$00030000,$ffffd000
	dc.l $0000019f,$fffe0000,$00020000,$ffffe000
	dc.l $000001a0,$00020000,$00020000,$ffffe000
	dc.l $000001a1,$fffd0000,$00010000,$fffff000
	dc.l $000001b8,$00000000,$00010000,$fffff000
	dc.l $000001b9,$00010000,$00060000,$ffffa000
	dc.l $000001ba,$fffe0000,$00050000,$ffffb000
	dc.l $000001bb,$00020000,$00050000,$ffffb000
	dc.l $000001bc,$fffd0000,$00040000,$ffffc000
	dc.l $000001bd,$00030000,$00040000,$ffffc000
	dc.l $000001be,$fffc0000,$00030000,$ffffd000
	dc.l $000001bf,$00040000,$00030000,$ffffd000
	dc.l $000001c0,$fffb0000,$00020000,$ffffe000
	dc.l $000001c1,$00050000,$00020000,$ffffe000
	dc.l $000001c2,$fffa0000,$00010000,$fffff000
	dc.l $000001c3,$00060000,$00010000,$fffff000
	dc.l $000001fb,$ffff0000,$00060000,$ffffa000
	dc.l $000001fc,$00010000,$00060000,$ffffa000
	dc.l $000001fd,$fffe0000,$00050000,$ffffb000
	dc.l $000001fe,$00020000,$00050000,$ffffb000
	dc.l $000001ff,$fffd0000,$00040000,$ffffc000
	dc.l $00000200,$00030000,$00040000,$ffffc000
	dc.l $00000201,$fffc0000,$00030000,$ffffd000
	dc.l $00000202,$00040000,$00030000,$ffffd000
	dc.l $00000203,$fffb0000,$00020000,$ffffe000
	dc.l $00000204,$00050000,$00020000,$ffffe000
	dc.l $00000205,$fffa0000,$00010000,$fffff000
	dc.l $00000206,$00060000,$00010000,$fffff000
	dc.l $00000211,$00010000,$00080000,$ffff8000
	dc.l $00000212,$ffff0000,$00080000,$ffff8000
	dc.l $00000213,$00020000,$00070000,$ffff9000
	dc.l $00000214,$fffe0000,$00070000,$ffff9000
	dc.l $00000215,$00030000,$00060000,$ffffa000
	dc.l $00000216,$fffd0000,$00060000,$ffffa000
	dc.l $00000217,$00040000,$00050000,$ffffb000
	dc.l $00000218,$fffc0000,$00050000,$ffffb000
	dc.l $00000219,$00050000,$00040000,$ffffc000
	dc.l $0000021a,$fffb0000,$00040000,$ffffc000
	dc.l $0000021b,$00060000,$00030000,$ffffd000
	dc.l $0000021c,$fffa0000,$00030000,$ffffd000
	dc.l $0000021d,$00070000,$00020000,$ffffe000
	dc.l $0000021e,$fff90000,$00020000,$ffffe000
	dc.l $0000021f,$00080000,$00010000,$fffff000
	dc.l $00000228,$00010000,$00030000,$ffffd000
	dc.l $00000229,$ffff0000,$00030000,$ffffd000
	dc.l $0000022a,$00020000,$00020000,$ffffe000
	dc.l $0000022b,$fffe0000,$00020000,$ffffe000
	dc.l $0000022c,$00030000,$00010000,$fffff000
	dc.l $0000022d,$fffd0000,$00010000,$fffff000
	dc.l $0000023a,$00000000,$00010000,$fffff000
	dc.l $0000023b,$ffff0000,$00030000,$ffffd000
	dc.l $0000023c,$00010000,$00030000,$ffffd000
	dc.l $0000023d,$fffe0000,$00020000,$ffffe000
	dc.l $0000023e,$00020000,$00020000,$ffffe000
	dc.l $0000023f,$fffd0000,$00010000,$fffff000
	dc.l $00000240,$00030000,$00010000,$fffff000
	dc.l $0000117a,$00010000,$00040000,$ffffc000
	dc.l $0000117b,$ffff0000,$00040000,$ffffc000
	dc.l $0000117c,$00020000,$00030000,$ffffd000
	dc.l $0000117d,$fffe0000,$00030000,$ffffd000
	dc.l $0000117e,$00030000,$00020000,$ffffe000
	dc.l $0000117f,$fffd0000,$00020000,$ffffe000
	dc.l $00001180,$00040000,$00010000,$fffff000
	dc.l $00001181,$fffc0000,$00010000,$fffff000
	dc.l $00001182,$00050000,$00000000,$00000000
	dc.l $00001171,$ffff0000,$00040000,$ffffc000
	dc.l $00001172,$00010000,$00040000,$ffffc000
	dc.l $00001173,$fffe0000,$00030000,$ffffd000
	dc.l $00001174,$00020000,$00030000,$ffffd000
	dc.l $00001175,$fffd0000,$00020000,$ffffe000
	dc.l $00001176,$00030000,$00020000,$ffffe000
	dc.l $00001177,$fffc0000,$00010000,$fffff000
	dc.l $00001178,$00040000,$00010000,$fffff000
	dc.l $00001199,$00000000,$00080000,$ffffc000
	dc.l $0000119a,$00060000,$00010000,$ffffc000
	dc.l $0000119b,$fffb0000,$00020000,$ffffc000
	dc.l $0000119c,$00050000,$00020000,$ffffc000
	dc.l $0000119d,$fffc0000,$00030000,$ffffc000
	dc.l $0000119e,$00040000,$00030000,$ffffc000
	dc.l $0000119f,$fffd0000,$00040000,$ffffc000
	dc.l $000011a0,$00030000,$00040000,$ffffc000
	dc.l $000011a1,$fffe0000,$00050000,$ffffc000
	dc.l $000011a2,$00020000,$00050000,$ffffc000
	dc.l $000011a3,$ffff0000,$00060000,$ffffc000
	dc.l $000011a4,$00010000,$00060000,$ffffc000
	dc.l $000011a5,$fffe8000,$00070000,$ffffc000
	dc.l $000011ab,$fff80000,$00010000,$ffffc000
	dc.l $000011ac,$00080000,$00010000,$ffffc000
	dc.l $000011ad,$fff90000,$00020000,$ffffc000
	dc.l $000011ae,$00070000,$00020000,$ffffc000
	dc.l $000011af,$fffa0000,$00030000,$ffffc000
	dc.l $000011b0,$00060000,$00030000,$ffffc000
	dc.l $000011b1,$fffb0000,$00040000,$ffffc000
	dc.l $000011b2,$00050000,$00040000,$ffffc000
	dc.l $000011b3,$fffc0000,$00050000,$ffffc000
	dc.l $000011b4,$00040000,$00050000,$ffffc000
	dc.l $000011b5,$fffd0000,$00060000,$ffffc000
	dc.l $000011b6,$00030000,$00060000,$ffffc000
	dc.l $000011b7,$fffe0000,$00070000,$ffffc000
	dc.l $000011b8,$00020000,$00070000,$ffffc000
	dc.l $000011b9,$ffff0000,$00080000,$ffffc000
	dc.l $000011ac,$00010000,$00080000,$ffffc000
	dc.l $000011bb,$00000000,$00090000,$ffffc000
	dc.l $000001a2,$ffff0000,$00010000,$fffff000
	dc.l $0000118c,$ffff0000,$00060000,$ffffa000
	dc.l $0000118d,$00014000,$00060000,$ffffa000
	dc.l $0000118e,$fffe8000,$00050000,$ffffb000
	dc.l $0000118f,$0001c000,$00050000,$ffffb000
	dc.l $00001190,$fffe0000,$00040000,$ffffc000
	dc.l $00001191,$fffdc000,$00040000,$ffffc000
	dc.l $00001192,$fffd8000,$00030000,$ffffd000
	dc.l $00001193,$fffd4000,$00030000,$ffffd000
	dc.l $00001194,$fffd0000,$00020000,$ffffe000
	dc.l $00001195,$fffcc000,$00020000,$ffffe000
	dc.l $00001196,$fffc8000,$00010000,$fffff000
	dc.l $00001197,$fffc4000,$00010000,$fffff000
	dc.l $00001189,$00010000,$00010000,$fffff000
	dc.l $000012f7,$ffff0000,$00060000,$ffffa000
	dc.l $000012f8,$00014000,$00060000,$ffffa000
	dc.l $000012f9,$fffe8000,$00050000,$ffffb000
	dc.l $000012fa,$0001c000,$00050000,$ffffb000
	dc.l $000012fb,$fffe0000,$00040000,$ffffc000
	dc.l $000012fc,$00024000,$00040000,$ffffc000
	dc.l $000012fd,$fffd8000,$00030000,$ffffd000
	dc.l $000012fe,$0002c000,$00030000,$ffffd000
	dc.l $000012ff,$fffd0000,$00020000,$ffffe000
	dc.l $00001837,$ffff0000,$00030000,$ffffd000
	dc.l $00001838,$00010000,$00030000,$ffffd000
	dc.l $00001839,$00000000,$00038000,$ffffc800
	dc.l $0000183d,$00020000,$00028000,$ffffd800
	dc.l $0000183e,$fffe0000,$00028000,$ffffd800
	dc.l $0000183f,$00030000,$00020000,$ffffe000
	dc.l $0000185a,$fffd0000,$00020000,$ffffe000
	dc.l $0000185b,$00018000,$00018000,$ffffe800
	dc.l $0000185c,$fffe8000,$00018000,$ffffe800
	dc.l $0000185d,$00028000,$00010000,$fffff000
	dc.l $0000185e,$fffd8000,$00010000,$fffff000
	dc.l $0000022e,$00030000,$00030000,$ffffd000

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0125c8:
	dc.w $0000,$0018,$0010,$0018
	dc.w $0000,$0028,$000c,$0020
	dc.w $0000,$0038,$0010,$0038
	dc.w $0000,$0030,$0018,$0020
	dc.w $0000,$0010,$0020,$0020
	dc.w $0000,$0020,$0018,$0010
	dc.w $0000,$0030,$0020,$0030
	dc.w $0000,$0030,$0010,$0030
	dc.w $0000,$0030,$0010,$0020
	dc.w $0000,$0030,$0010,$0020
	dc.w $0000,$0010,$0018,$0010
	dc.w $0000,$0030,$0010,$0020
	dc.w $0000,$0040,$0020,$0040
	dc.w $0000,$0018,$0018,$0018
	dc.w $0000,$0010,$0020,$0020
	dc.w $0000,$0010,$0020,$0020
	dc.w $0000,$0020,$0014,$0020
	dc.w $ffd0,$0010,$0020,$0028
	dc.w $ffd0,$0010,$0020,$0028
	dc.w $0000,$0020,$0010,$0020
	dc.w $0000,$0010,$0020,$0020

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_012670:
	dc.w $0180,$0193,$019c,$01b7
	dc.w $12f5,$01f9,$0210,$022c
	dc.w $0238,$0239,$1179,$1170
	dc.w $1198,$11a8,$11a9,$11aa
	dc.w $0000,$1187,$1189,$1836
	dc.w $0000,$0000,$0000,$0000

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0126a0:
	dc.w $0004,$0007,$0004,0002
	dc.w $0003,$0003,$001c,0004
	dc.w $0007,$0007,$0004,0002
	dc.w $001c,$0004,$0004,0004
	dc.w $0004,$0004,$0004,0004
	dc.w $0004,$0004,$0004,0004

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0126d0:
	dc.w $4000,$c080

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0126d4:
	dc.l loc_012728,loc_012760,loc_012792,loc_0127b8
	dc.l loc_012802,loc_01283a,loc_01288a,loc_0128e6
	dc.l loc_012912,loc_012932,loc_01295e,loc_012996
	dc.l loc_0129c8,loc_012a18,loc_012a18,loc_012a18
	dc.l loc_012728,loc_012a80,loc_012aca,loc_012b0e
	dc.l loc_012728

loc_012728:
	dc.w $0009
	dc.w $1800,$0000,$0000
	dc.w $1801,$0004,$0018
	dc.w $1802,$fff4,$0024
	dc.w $1803,$fff4,$0014
	dc.w $1804,$fff4,$0010
	dc.w $1805,$0004,$0004
	dc.w $1806,$002c,$0008
	dc.w $1807,$000c,$0028
	dc.w $1808,$fff0,$0008

loc_012760:
	dc.w $0008
	dc.w $1809,$fff8,$0048
	dc.w $180a,$0008,$004c
	dc.w $180b,$0008,$004c
	dc.w $180c,$fff8,$003c
	dc.w $180d,$0000,$0030
	dc.w $180e,$0008,$00c0
	dc.w $180f,$0010,$0040
	dc.w $1810,$0000,$0020

loc_012792:
	dc.w $0006
	dc.w $1811,$0000,$0020
	dc.w $1812,$0000,$0058
	dc.w $1813,$fff8,$0038
	dc.w $1814,$0000,$0010
	dc.w $1815,$0000,$0064
	dc.w $1879,$0008,$0034

loc_0127b8:
	dc.w $000c
	dc.w $1816,$0000,$0000
	dc.w $1817,$0010,$004c
	dc.w $1818,$0010,$0030
	dc.w $1819,$0008,$0044
	dc.w $181a,$ffec,$0048
	dc.w $181b,$0000,$0024
	dc.w $181c,$0008,$0020
	dc.w $181d,$fff0,$0020
	dc.w $181e,$0000,$0028
	dc.w $181f,$0000,$0038
	dc.w $1820,$0014,$0030
	dc.w $1821,$0010,$002c

loc_012802:
	dc.w $0009
	dc.w $1888,$0000,$0020
	dc.w $1889,$0000,$0020
	dc.w $188a,$0000,$0020
	dc.w $188b,$0000,$0020
	dc.w $188c,$0000,$0020
	dc.w $188d,$0000,$0020
	dc.w $188e,$0000,$0020
	dc.w $188f,$0000,$0020
	dc.w $1890,$0000,$0020

loc_01283a:
	dc.w $000d
	dc.w $1822,$0038,$001c
	dc.w $1823,$fff0,$000c
	dc.w $1824,$0014,$002c
	dc.w $1825,$0028,$000c
	dc.w $1826,$0018,$0010
	dc.w $1827,$0008,$0018
	dc.w $1828,$0018,$0010
	dc.w $1829,$000c,$0020
	dc.w $182a,$fff4,$000c
	dc.w $182b,$000c,$0028
	dc.w $182c,$fff0,$0014
	dc.w $182d,$0000,$0020
	dc.w $4400,$ffec,$001c

loc_01288a:
	dc.w $000f
	dc.w $182e,$fffe,$0050
	dc.w $182f,$0000,$0000
	dc.w $1830,$ffdc,$0026
	dc.w $1831,$fffa,$0032
	dc.w $1832,$0010,$002e
	dc.w $1833,$ffe0,$0056
	dc.w $1834,$001e,$000c
	dc.w $1835,$ffd4,$001c
	dc.w $1836,$ffd8,$0004
	dc.w $1837,$0014,$0042
	dc.w $1838,$ffde,$003c
	dc.w $1839,$0024,$002a
	dc.w $183a,$0028,$000a
	dc.w $183b,$ffe2,$0036
	dc.w $183c,$ffd4,$001a

loc_0128e6:
	dc.w $0007
	dc.w $183d,$fffc,$005c
	dc.w $183e,$0004,$0048
	dc.w $183f,$fffc,$006c
	dc.w $1840,$fff4,$0028
	dc.w $1841,$fff8,$0040
	dc.w $1842,$0000,$0010
	dc.w $189b,$fffc,$0020

loc_012912:
	dc.w $0005
	dc.w $1843,$0000,$0000
	dc.w $1844,$0000,$0060
	dc.w $1845,$0000,$0044
	dc.w $1848,$0000,$0034
	dc.w $1849,$0004,$0056

loc_012932:
	dc.w $0007
	dc.w $1843,$0000,$0000
	dc.w $1844,$0000,$0066
	dc.w $1845,$0004,$0056
	dc.w $1846,$0002,$0042
	dc.w $1847,$fffe,$0028
	dc.w $1848,$fff8,$0040
	dc.w $1849,$fffa,$001e

loc_01295e:
	dc.w $0009
	dc.w $184a,$ffe8,$0056
	dc.w $184b,$ffdc,$0002
	dc.w $184c,$ffea,$0022
	dc.w $184d,$ffe4,$0038
	dc.w $184e,$ffe4,$001a
	dc.w $184f,$ffe0,$0026
	dc.w $1850,$ffe4,$0018
	dc.w $1851,$fff6,$0006
	dc.w $1852,$000c,$0004

loc_012996:
	dc.w $0008
	dc.w $1853,$fffa,$0054
	dc.w $1854,$000e,$002e
	dc.w $1855,$0004,$0048
	dc.w $1856,$fff6,$0002
	dc.w $1857,$fff0,$003a
	dc.w $1858,$0010,$0030
	dc.w $1859,$fffa,$0038
	dc.w $185a,$0008,$0032

loc_0129c8:
	dc.w $000d
	dc.w $185b,$fffe,$0086
	dc.w $185c,$0002,$0074
	dc.w $185d,$000e,$000c
	dc.w $185e,$ffc6,$0094
	dc.w $185f,$0008,$008c
	dc.w $1860,$ffe8,$005c
	dc.w $1861,$fff8,$000e
	dc.w $1862,$fff0,$003e
	dc.w $1863,$fff0,$000e
	dc.w $1864,$0006,$0050
	dc.w $1865,$0014,$0090
	dc.w $1866,$ffc8,$0098
	dc.w $1867,$fff2,$0098

loc_012a18:
	dc.w $0011
	dc.w $1868,$000a,$0022
	dc.w $1869,$ffee,$0000
	dc.w $186a,$001e,$000e
	dc.w $186b,$fff4,$001a
	dc.w $186c,$000e,$000c
	dc.w $186d,$fff6,$002e
	dc.w $186e,$000a,$0030
	dc.w $186f,$0012,$0024
	dc.w $1870,$fff6,$0018
	dc.w $1871,$0012,$0004
	dc.w $1872,$fff6,$0020
	dc.w $1873,$fff2,$000a
	dc.w $1874,$0014,$0024
	dc.w $1875,$0000,$0000
	dc.w $1876,$0010,$0020
	dc.w $1877,$ffee,$0004
	dc.w $1878,$002c,$001c

loc_012a80:
	dc.w $000c
	dc.w $187a,$ffe0,$0010
	dc.w $187b,$fff0,$0060
	dc.w $187c,$ffc0,$0030
	dc.w $187d,$0002,$004a
	dc.w $187e,$ffba,$0034
	dc.w $187f,$ffc0,$003c
	dc.w $1880,$ffc0,$003c
	dc.w $1881,$ffbe,$001e
	dc.w $1882,$ffd8,$003e
	dc.w $1883,$ffb4,$002e
	dc.w $1884,$ffc8,$003e
	dc.w $1885,$ffce,$0032

loc_012aca:
	dc.w $000b
	dc.w $187c,$ffc0,$0030
	dc.w $187d,$0002,$004a
	dc.w $187e,$ffba,$0034
	dc.w $187f,$ffc0,$003c
	dc.w $1880,$ffc0,$003c
	dc.w $1881,$ffbe,$001e
	dc.w $1882,$ffd8,$003e
	dc.w $1883,$ffb4,$002e
	dc.w $1884,$ffc8,$003e
	dc.w $1885,$ffce,$0032
	dc.w $1886,$000e,$0000

loc_012b0e:
	dc.w $000b
	dc.w $1890,$0000,$003c
	dc.w $1891,$0000,$0000
	dc.w $1892,$fffc,$0034
	dc.w $1893,$0008,$0050
	dc.w $1894,$fffc,$004c
	dc.w $1895,$0000,$005c
	dc.w $1896,$fffc,$0048
	dc.w $1897,$fffc,$0020
	dc.w $1898,$0008,$0018
	dc.w $1899,$0000,$0054
	dc.w $189a,$0000,$006c

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_012b52:
	dc.w $1132,$1136,$113a,$113e,$1142,$1146,$114a
	dc.w $114e,$1152,$1156,$115a,$115e,$1162,$1166

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_012b6e:
	dc.w $0006
	dc.w $0c12,$181f,$252b,$3137,$3d44,$4a4f,$555b,$6167,$6d72,$787d
	dc.w $8388,$8d92,$979c,$a1a6,$abaf,$b4b8,$bcc1,$c5c9,$ccd0,$d4d7
	dc.w $dadd,$e0e3,$e6e9,$ebed,$f0f2,$f4f5,$f7f8,$fafb,$fcfd,$fdfe
	dc.w $fefe,$fffe,$fefe,$fdfd,$fcfb,$faf8,$f7f5,$f4f2,$f0ed,$ebe9
	dc.w $e6e3,$e0dd,$dad7,$d4d0,$ccc9,$c5c1,$bcb8,$b4af,$aba6,$a19c
	dc.w $9792,$8d88,$837d,$7872,$6d67,$615b,$554f,$4a44,$3d37,$312b
	dc.w $251f,$1812,$0c06,$0072

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_012bf0:
	dc.l loc_012c80,loc_012cb8,loc_012cbc
	dc.l loc_012cdc,loc_012ce0,loc_012cf0
	dc.l loc_012d60,loc_012dc0,loc_012df8
	dc.l loc_012e40,loc_012e44,loc_012ec8
	dc.l loc_012ecc,loc_012ed0,loc_012ed0
	dc.l loc_012ed0,loc_012ed0,loc_012ed4
	dc.l loc_012ed4,loc_012ed4,loc_012ed4
	dc.l loc_012ed4,loc_012ed4,loc_012ed4
	dc.l loc_012ed4,loc_012ed4,loc_012ed4
	dc.l loc_012ed4,loc_012ed4,loc_012ed4
	dc.l loc_012ed4,loc_012ed4,loc_012ed4
	dc.l loc_012ed4,loc_012ed4,loc_012ed4

loc_012c80:
	dc.w $0246,$0400,$0247,$0400
	dc.w $0248,$0400,$024b,$0400
	dc.w $024c,$0400,$0248,$0400
	dc.w $0249,$0400,$024a,$0400
	dc.w $0249,$0400,$0248,$0400
	dc.w $0249,$0400,$024a,$0400
	dc.w $0249,$0400,$0248,$0480

loc_012cb8:
	dc.w $022f,$ff80

loc_012cbc:
	dc.w $0230,$0c00,$0231,$0c00
	dc.w $0232,$0c00,$0233,$0c00
	dc.w $0234,$0c00,$0235,$0c00
	dc.w $0236,$0c00,$0237,$0c80

loc_012cdc:
	dc.w $0192,$ff80

loc_012ce0:
	dc.w $12f1,$0800
	dc.w $12f2,$0800
	dc.w $12f3,$0800
	dc.w $12f4,$0880

loc_012cf0:
	dc.w $01c4,$0400,$01c5,$0400
	dc.w $01c6,$0400,$01c5,$0400
	dc.w $01c4,$0400,$01c5,$0400
	dc.w $01c6,$0400,$01c5,$0400
	dc.w $01c7,$0400,$01c8,$0400
	dc.w $01c7,$0400,$01c8,$0400
	dc.w $01c7,$0400,$01c8,$0400
	dc.w $01c9,$0400,$01ca,$0400
	dc.w $01cb,$0400,$01cc,$0400
	dc.w $01cd,$0400,$01ce,$0400
	dc.w $01c7,$0400,$01c8,$0400
	dc.w $01c9,$0400,$01ca,$0400
	dc.w $01cb,$0400,$01cc,$0400
	dc.w $01cd,$0400,$01ce,$0480

loc_012d60:
	dc.w $0207,$0400,$0208,$0400
	dc.w $0207,$0400,$0208,$0400
	dc.w $0207,$0400,$0208,$0400
	dc.w $0209,$0400,$0207,$0400
	dc.w $020a,$0400,$020b,$0400
	dc.w $020a,$0400,$020b,$0400
	dc.w $020c,$0400,$020d,$0400
	dc.w $020e,$0400,$020c,$0400
	dc.w $020d,$0400,$020e,$0400
	dc.w $020c,$0400,$020d,$0400
	dc.w $020e,$0400,$020c,$0400
	dc.w $020d,$0400,$020e,$0480

loc_012dc0:
	dc.w $01e0,$0400,$01e1,$0400
	dc.w $01e2,$0400,$01e0,$0400
	dc.w $01e1,$0400,$01e2,$0400
	dc.w $01e0,$0400,$01e1,$0400
	dc.w $01e2,$0400,$01e0,$1000
	dc.w $01e3,$0400,$01e4,$0400
	dc.w $01e5,$0400,$01e0,$1080

loc_012df8:
	dc.w $01e6,$0400,$01e7,$0400
	dc.w $01e8,$0400,$01e7,$0400
	dc.w $01e6,$0400,$01e7,$0400
	dc.w $01e8,$0400,$01e7,$0400
	dc.w $01e6,$1000,$01e9,$0400
	dc.w $01ea,$0400,$01e6,$1000
	dc.w $01e9,$0400,$01ea,$0400
	dc.w $01e6,$1000,$01e9,$0400
	dc.w $01ea,$0400,$01e6,$1080

loc_012e40:
	dc.w $127b,$ff80

loc_012e44:
	dc.w $1881,$0400,$185c,$0400
	dc.w $185d,$0400,$185e,$0400
	dc.w $185f,$0400,$1860,$0400
	dc.w $1881,$0400,$1861,$0400
	dc.w $1881,$0400,$185c,$0400
	dc.w $1881,$2000,$1862,$0400
	dc.w $1881,$0400,$1863,$0400
	dc.w $1864,$0400,$1881,$0400
	dc.w $1865,$0400,$1881,$2000
	dc.w $1866,$0400,$1867,$0800
	dc.w $1868,$0400,$1881,$0400
	dc.w $1869,$0400,$1881,$2000
	dc.w $186a,$0400,$186b,$0800
	dc.w $186c,$0400,$186d,$0400
	dc.w $1881,$2000,$186e,$0400
	dc.w $186f,$0800,$1870,$0400
	dc.w $1881,$4080

loc_012ec8:
	dc.w $1278,$0880

loc_012ecc:
	dc.w $1834,$ff80

loc_012ed0:
	dc.w $1835,$ff80

loc_012ed4:
	dc.w $0000,$0080

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_012ed8:
	dc.w $0000,$0000,$0000,$0000
	dc.w $0000,$0045,$0000,$0000
	dc.w $0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000

;##############################################################################
loc_012f18:
	nop
	lea.l scoreboard,a1
	lea.l loc_013162(pc),a2
	nop
	lea.l $10694c,a3
	btst #0,($e8,a0)
	bne.w loc_012fc8
	move.l ($c,a0),d0
	cmp.l ($44,a1),d0
	bgt.w loc_012f52
	move.b #3,($4,a0)
	move.b #0,($b,a0)
	bra.w loc_013138

loc_012f52:
	lea.l $106946,a4
	move.b (a0),d4
	andi.w #1,d4
	lsl.w #5,d4
	adda.w d4,a4
	move.l #$31c031c,d1
	move.l d1,(a4)+
	move.l d1,(a4)+
	move.l d1,(a4)+
	move.l d1,(a4)+
	move.l d1,(a4)+
	move.l d1,(a4)+
	move.l d1,(a4)+
	move.l d1,(a4)+
	move.l d0,($f4,a0)
	bset #0,($e8,a0)
	moveq #0,d7

loc_012f84:
	cmp.l (4,a1),d0
	bgt.b loc_012f94
	adda.l #$10,a1
	addq.w #1,d7
	bra.b loc_012f84

loc_012f94:
	move.w d7,($ea,a0)
	move.b #$10,($e9,a0)
	move.w #0,($ec,a0)
	move.w #$10,($ee,a0)
	move.l #$202020,($f0,a0)
	moveq #0,d0
	move.b (a0),d0
	lea.l BIOS_PLAYER1_MODE,a4
	move.b #3,(a4,d0.w)
	move.w #$3c0,($f8,a0)

loc_012fc8:
	subq.w #1,($ee,a0)
	bne.b loc_012fda
	move.w #$10,($ee,a0)
	bchg.b #4,($e8,a0)

loc_012fda:
	lea.l ($f0,a0),a4
	move.w ($ec,a0),d0
	moveq #0,d1
	move.b (a4,d0.w),d1
	subq.w #1,($f8,a0)
	beq.b loc_01304c
	move.b ($b2,a0),d2
	andi.w #$c,d2
	beq.b loc_013022
	move.w #$10,($ee,a0)
	bclr #4,($e8,a0)
	lea.l loc_01313a(pc),a5
	nop
	lsr.w #2,d2
	add.b (a5,d2.w),d1
	andi.w #$1f,d1
	cmpi.w #3,d0
	bne.b loc_013022
	andi.w #1,d1
	addi.w #$1e,d1

loc_013022:
	btst #4,($b2,a0)
	beq.w loc_0130ee
	move.w #$10,($ee,a0)
	bclr #4,($e8,a0)
	cmpi.w #$1d,d1
	bmi.b loc_013044
	move.b #$20,(a4,d0.w)

loc_013044:
	cmpi.w #$1f,d1
	bne.w loc_0130c8

loc_01304c:
	clr.b ($e8,a0)
	moveq #5,d1
	lea.l $100044,a1
	move.l ($f4,a0),d3
	cmp.l (4,a1),d3
	ble.w loc_0130ac

loc_013064:
	cmp.l (4,a1),d3
	ble.b loc_01308a
	move.l (a1),($10,a1)
	move.l (4,a1),($14,a1)
	move.l (8,a1),($18,a1)
	move.l ($c,a1),($1c,a1)
	suba.l #$10,a1
	subq.w #1,d1
	bne.b loc_013064

loc_01308a:
	move.w d1,($ea,a0)
	move.l ($f0,a0),($10,a1)
	move.l d3,($14,a1)
	move.b (2,a0),($19,a1)
	move.b (5,a0),($1b,a1)
	move.b (6,a0),($1d,a1)
	bra.b loc_0130ba

loc_0130ac:
	move.w #6,($ea,a0)
	move.l #$e141320,($f0,a0)

loc_0130ba:
	move.b #3,(4,a0)
	move.b #0,($b,a0)
	bra.b loc_0130f6

loc_0130c8:
	moveq #1,d3
	cmpi.w #$1e,d1
	bne.b loc_0130de
	tst.b d0
	beq.b loc_0130ee
	move.b #$20,(a4,d0.w)
	move.w #$ffff,d3

loc_0130de:
	andi.w #3,d0
	add.w d3,d0
	cmpi.w #3,d0
	bmi.b loc_0130ee
	move.w #$1f,d1

loc_0130ee:
	move.w d0,($ec,a0)
	move.b d1,(a4,d0.w)

loc_0130f6:
	move.b (a0),d4
	andi.w #1,d4
	lsl.w #5,d4
	adda.w d4,a3
	move.w #$234e,(a3)+
	move.w #$2341,(a3)+
	move.w #$234d,(a3)+
	move.w #$2345,(a3)+
	move.w #$31c,(a3)+
	moveq #3,d7

loc_013116:
	moveq #0,d4
	move.b (a4)+,d4
	add.w d4,d4
	move.w (a2,d4.w),(a3)+
	dbra d7,loc_013116
	btst #4,($e8,a0)
	beq.b loc_013138
	add.w d0,d0
	subi.w #$a,d0
	move.w #$31c,(2,a3,d0.w)

loc_013138:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01313a:
	dc.w $00ff,$0100,$2331,$2306
	dc.w $2332,$2307,$2333,$2308
	dc.w $2334,$2309,$2335,$2309
	dc.w $2336,$2309,$2337,$2309
	dc.w $2338,$2309,$2339,$2309

loc_013162:
	dc.w $2341,$2342,$2343,$2344
	dc.w $2345,$2346,$2347,$2348
	dc.w $2349,$234a,$234b,$234c
	dc.w $234d,$234e,$234f,$2350
	dc.w $2351,$2352,$2353,$2354
	dc.w $2355,$2356,$2357,$2358
	dc.w $2359,$235a,$232e,$2321
	dc.w $233f,$230b,$230a,$230c
	dc.w $2320

;##############################################################################
loc_0131a4:
	nop
	movea.w #$70c4,a1
	move.w #$242c,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$2438,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$2470,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$2474,d0
	jsr loc_0133c2(pc)
	nop
	movea.w #$7204,a1
	move.w #$2440,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$246c,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$2428,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$2464,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$2464,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$2454,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$2438,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$246c,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$2470,d0
	jsr loc_0133c2(pc)
	nop
	move.w #$2404,d0
	movea.w #$7068,a1
	jsr loc_0133c2(pc)
	nop
	move.w #$2408,d0
	movea.w #$706c,a1
	jsr loc_0133c2(pc)
	nop
	move.w #$240c,d0
	movea.w #$7070,a1
	jsr loc_0133c2(pc)
	nop
	move.w #$2410,d0
	movea.w #$7074,a1
	jsr loc_0133c2(pc)
	nop
	move.w #$2414,d0
	movea.w #$7078,a1
	jsr loc_0133c2(pc)
	nop
	movea.w #$70c8,a1
	lea.l scoreboard,a2
	lea.l loc_01349a(pc),a3
	nop
	moveq #4,d6

loc_013288:
	moveq #2,d7

loc_01328a:
	moveq #0,d0
	move.b (a2)+,d0
	add.w d0,d0
	move.w (a3,d0.w),d0
	jsr loc_0133c2(pc)
	nop
	dbra d7, loc_01328a
	move.b (a2)+,d0
	adda.w #$20,a1
	move.l (a2)+,d7
	moveq #6,d5
	moveq #0,d1

loc_0132aa:
	move.w d5,d4
	add.w d4,d4
	add.w d4,d4
	lea.l loc_0134dc(pc),a4
	nop
	move.l (a4,d4.w),d4
	move.w #$2400,d0
	cmpi.l #$98967f,d7
	bmi.b loc_0132ce
	move.w #$2424,d0
	moveq #1,d1
	bra.b loc_0132e0

loc_0132ce:
	cmp.l d4,d7
	blt.b loc_0132e0
	sub.l d4,d7
	addq.w #4,d0
	moveq #1,d1
	cmpi.w #$2424,d0
	bpl.b loc_0132e0
	bra.b loc_0132ce

loc_0132e0:
	cmpi.w #$2400,d0
	bne.b loc_0132f2
	tst.w d1
	bne.b loc_0132f2
	tst.w d5
	beq.b loc_0132f2
	move.w #$231c,d0

loc_0132f2:
	jsr loc_0133c2(pc)
	nop
	dbra d5,loc_0132aa
	move.w (a2)+,d7
	adda.w #$c0,a1
	movea.l $101420,a6
	move.w a1,(a6)+
	move.w #$a39f,(a6)+
	adda.w #1,a1
	move.w a1,(a6)+
	move.w #$a3bf,(a6)+
	adda.w #$1f,a1
	move.w a1,(a6)+
	move.w #$a39e,(a6)+
	adda.w #1,a1
	move.w a1,(a6)+
	move.w #$a39e,(a6)+
	adda.w #$1f,a1
	move.l a6,$101420
	moveq #0,d7
	move.w (a2)+,d7
	addq.w #1,d7
	moveq #1,d5

loc_01333e:
	move.w d5,d4
	add.w d4,d4
	add.w d4,d4
	move.l (a4,d4.w),d4
	move.w #$2330,d0

loc_01334c:
	cmp.l d4,d7
	blt.b loc_01335c
	sub.l d4,d7
	addq.w #1,d0
	cmpi.w #$2339,d0
	bpl.b loc_01335c
	bra.b loc_01334c

loc_01335c:
	movea.l $101420,a6
	move.w a1,(a6)+
	move.w d0,(a6)+
	adda.w #$20,a1
	move.l a6,$101420
	dbra d5,loc_01333e
	suba.w #$3f,a1
	moveq #0,d7
	move.w (a2)+,d7
	moveq #1,d5

loc_01337e:
	move.w d5,d4
	add.w d4,d4
	add.w d4,d4
	move.l (a4,d4.w),d4
	move.w #$2330,d0

loc_01338c:
	cmp.l d4,d7
	blt.b loc_01339c
	sub.l d4,d7
	addq.w #1,d0
	cmpi.w #$2339,d0
	bpl.b loc_01339c
	bra.b loc_01338c

loc_01339c:
	movea.l $101420,a6
	move.w a1,(a6)+
	move.w d0,(a6)+
	adda.w #$20,a1
	move.l a6,$101420
	dbra d5,loc_01337e
	adda.w #2,a2
	suba.w #$3dd,a1
	dbra d6,loc_013288
	rts

;##############################################################################
loc_0133c2:
	movea.l $101420,a6
	move.w a1,(a6)+
	addq.w #2,d0
	move.w d0,(a6)+
	adda.w #1,a1
	move.w a1,(a6)+
	addq.w #1,d0
	move.w d0,(a6)+
	adda.w #$1f,a1
	move.w a1,(a6)+
	subq.w #3,d0
	move.w d0,(a6)+
	adda.w #1,a1
	move.w a1,(a6)+
	addq.w #1,d0
	move.w d0,(a6)+
	adda.w #$1f,a1
	move.l a6,$101420
	rts

;##############################################################################
loc_0133f8:
	lea.l scoreboard,a1
	move.l #$e0e0400,(a1)+
	move.l #$c350,(a1)+
	move.l #$c0000,(a1)+
	move.l #$0,(a1)+
	move.l #$d0e0300,(a1)+
	move.l #$9c40,(a1)+
	move.l #$b0001,(a1)+
	move.l #$0,(a1)+
	move.l #$e061400,(a1)+
	move.l #$7530,(a1)+
	move.l #$a0002,(a1)+
	move.l #$0,(a1)+
	move.l #$a040800,(a1)+
	move.l #$4e20,(a1)+
	move.l #$90003,(a1)+
	move.l #$0,(a1)+
	move.l #$7000b00,(a1)+
	move.l #$2710,(a1)+
	move.l #$80004,(a1)+
	move.l #$0,(a1)+
	rts

;##############################################################################
loc_013478:
	lea.l loc_01349a(pc),a3
	nop

loc_01347e:
	moveq #0,d0
	move.b (a2)+,d0
	cmpi.w #$ff,d0
	beq.b loc_013498
	subi.w #$41,d0
	lsl.w #1,d0
	move.w (a3,d0.w),d0
	jsr loc_0133c2(pc)
	bra.b loc_01347e

loc_013498:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01349a:
	dc.w $2428,$242c,$2430,$2434
	dc.w $2438,$243c,$2440,$2444
	dc.w $2448,$244c,$2450,$2454
	dc.w $2458,$245c,$2460,$2464
	dc.w $2468,$246c,$2470,$2474
	dc.w $2478,$247c,$2480,$2484
	dc.w $2488,$248c,$2ffc,$2ff8
	dc.w $2ff4,$231c,$231c,$231c
	dc.w $231c

loc_0134dc:
	dc.w $0000,$0001,$0000,$000a
	dc.w $0000,$0064,$0000,$03e8
	dc.w $0000,$2710,$0001,$86a0
	dc.w $000f,$4240,$0098,$9680
	dc.w $05f5,$e100,$0000,$0000

;##############################################################################
loc_013504:
	nop
	nop
	nop
	nop
	nop
	nop
	move.w #0,$101006
	lea.l $105cac,a6
	bset #0,(a6)
	bne.b loc_013534
	move.l #1,(4,a6)
	move.b #$ff,$103a8c

loc_013534:
	subq.l #1,(4,a6)
	bne.w loc_0135bc
	lea.l loc_013634(pc),a1
	nop
	cmpi.b #1,BIOS_COUNTRY_CODE
	bls.b loc_013552
	lea.l loc_013658(pc),a1
	nop

loc_013552:
	move.w (2,a6),d0
	movea.l (a1,d0.w),a1
	move.l (a1)+,d0
	move.w LSPCMODE,d1
	btst #3,d1
	beq.b loc_013574
	divu.w #6,d0
	mulu.w #5,d0
	bne.b loc_013574
	moveq #1,d0

loc_013574:
	move.l d0,(4,a6)
	move.w (a1)+,d0
	move.w (a1)+,d1
	lea.l $105cdc,a0
	adda.w d1,a0
	moveq #0,d1

loc_013586:
	move.w (a1)+,(a0)+
	move.w d1,(a0)+
	move.w (a1)+,(a0)+
	move.w d1,(a0)+
	move.w (a1)+,(a0)+
	move.w d1,(a0)+
	move.w (a1)+,(a0)+
	move.w d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	dbra d0,loc_013586
	addq.w #4,(2,a6)

loc_0135ae:
	cmpa.l #$1062ac,a0
	bpl.b loc_0135bc
	adda.w #$30,a0
	bra.b loc_0135ae

loc_0135bc:
	lea.l $105cdc,a0
	move.w #$40,$105c9c

loc_0135ca:
	move.l #$0,$106996
	tst.b (a0)
	beq.b loc_0135fa
	lea.l loc_013674(pc),a1
	nop
	moveq #0,d0
	move.b (a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a1,d0.w),a1
	jsr (a1)
	btst #4,($1a,a0)
	bne.b loc_0135fa
	jsr loc_00ef7c

loc_0135fa:
	adda.w #$30,a0
	cmpa.l #$1062ac,a0
	bmi.b loc_0135ca
	move.w #$1bb,d0
	move.w $105c9c,d1
	sub.w d1,d0
	bcs.b loc_013630
	movea.l $101420,a1
	addi.w #$8200,d1
	moveq #0,d2

loc_013620:
	move.w d1,(a1)+
	move.w d2,(a1)+
	addq.w #1,d1
	dbra d0,loc_013620
	move.l a1,$101420

loc_013630:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_013632:
	dc.w $7400

loc_013634:
	dc.l loc_0138e4
	dc.l loc_0136ac
	dc.l loc_0136cc
	dc.l loc_0136dc
	dc.l loc_0136fc
	dc.l loc_013784
	dc.l loc_0137ac
	dc.l loc_013804
	dc.l loc_01385c

loc_013658:
	dc.l loc_0138e4
	dc.l loc_0136ac
	dc.l loc_0136cc
	dc.l loc_0136dc
	dc.l loc_0136fc
	dc.l loc_0138b4
	dc.l loc_0138cc

loc_013674:
	dc.l $00000000
	dc.l loc_013ba4
	dc.l loc_0139e8
	dc.l loc_013bca
	dc.l loc_013c6e
	dc.l loc_013cd0
	dc.l loc_013d1a
	dc.l loc_013d9c
	dc.l loc_013dfe
	dc.l loc_014102
	dc.l loc_014188
	dc.l loc_0141b2
	dc.l loc_014366
	dc.l loc_01448c

loc_0136ac:
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0100,$0ef4,$00a0,$0100
	dc.w $0200,$0ef5,$00a0,$0000
	dc.w $0500,$0ef6,$00a0,$0000

loc_0136cc:
	dc.w $0000,$03c0,$0000,$0540
	dc.w $0300,$0000,$00a0,$0100

loc_0136dc:
	dc.w $0000,$03c0,$0002,$0000
	dc.w $0a00,$0ef4,$00a0,$0100
	dc.w $0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000

loc_0136fc:
	dc.w $0000,$03c0,$000f,$0000
	dc.w $0400,$01a7,$00a0,$0100
	dc.w $0400,$01a8,$00a0,$0100
	dc.w $0400,$01a9,$00a0,$0100
	dc.w $0400,$01aa,$00a0,$0100
	dc.w $0400,$01ab,$00a0,$0100
	dc.w $0400,$01ac,$00a0,$0100
	dc.w $0400,$01ad,$00a0,$0100
	dc.w $0400,$01ae,$00a0,$0100
	dc.w $0400,$01af,$00a0,$0100
	dc.w $0400,$01b0,$00a0,$0100
	dc.w $0400,$01b1,$00a0,$0100
	dc.w $0400,$01b2,$00a0,$0100
	dc.w $0400,$01b3,$00a0,$0100
	dc.w $0400,$01b4,$00a0,$0100
	dc.w $0400,$01b5,$00a0,$0100
	dc.w $0400,$01b6,$00a0,$0100

loc_013784:
	dc.w $0000,$03c0,$0003,$0000
	dc.w $0608,$0eb1,$ff60,$0100
	dc.w $0608,$0eb2,$ff60,$0100
	dc.w $06f8,$0eb3,$01e0,$00f8
	dc.w $06f8,$0eb4,$01e0,$00f8

loc_0137ac:
	dc.w $0000,$0060,$0009,$0000
	dc.w $0800,$0eb1,$00a0,$0100
	dc.w $0801,$0eb2,$00a0,$0100
	dc.w $0802,$0eb3,$00a0,$00f8
	dc.w $0803,$0eb4,$00a0,$00f8
	dc.w $0700,$0e1f,$0070,$01d0
	dc.w $070d,$0e1f,$00b0,$0180
	dc.w $0719,$0e1f,$0100,$01c0
	dc.w $0704,$0e1f,$0040,$0130
	dc.w $0709,$0e1f,$0110,$0120
	dc.w $0712,$0e1f,$0060,$0140

loc_013804:
	dc.w $0000,$03c0,$0009,$0000
	dc.w $0b00,$0ea6,$00a0,$0118
	dc.w $0b20,$0ea7,$00a0,$0118
	dc.w $0970,$0ea9,$0220,$0118
	dc.w $0980,$0eaa,$0220,$0118
	dc.w $0990,$0eab,$0220,$0118
	dc.w $09a0,$0eac,$0220,$0118
	dc.w $09b0,$0ead,$0220,$0118
	dc.w $09c0,$0eae,$0220,$0118
	dc.w $09d0,$0eaf,$0220,$0118
	dc.w $09e0,$0eb0,$0220,$0118

loc_01385c:
	dc.w $0000,$03c0,$0009,$0000
	dc.w $0100,$116d,$00a0,$0118
	dc.w $0100,$116e,$00a0,$0118
	dc.w $0c00,$0ef4,$00a0,$0100
	dc.w $0000,$0000,$00a0,$0100
	dc.w $0000,$0000,$00a0,$0100
	dc.w $0000,$0000,$00a0,$0100
	dc.w $0000,$0000,$00a0,$0100
	dc.w $0000,$0000,$00a0,$0100
	dc.w $0000,$0000,$00a0,$0100
	dc.w $0000,$0000,$00a0,$0100

loc_0138b4:
	dc.w $0000,$0270,$0001,$0000
	dc.w $0b00,$183a,$00a0,$011a
	dc.w $0bf0,$183b,$00a0,$011a

loc_0138cc:
	dc.w $0000,$03c0,$0001,$0000
	dc.w $0c00,$0ef4,$00a0,$0100
	dc.w $0000,$0000,$00a0,$0118

loc_0138e4:
	dc.w $0000,$03c0,$0001,$0000
	dc.w $0d00,$0efe,$00a0,$0100
	dc.w $0d04,$0eff,$00a0,$0100

;##############################################################################
loc_0138fc:
	nop
	btst #0,$105c98
	bne.w loc_013976
	lea.l $106b7a,a0
	bset #0,(1,a0)
	bne.b loc_013920
	move.l #$10000,(4,a0)

loc_013920:
	movea.l $105cd0,a3
	cmpa.l #palramaddr,a3
	bmi.b loc_013976
	cmpa.l #$402000,a3
	bpl.b loc_013976
	subq.w #1,(4,a0)
	bne.b loc_013976
	move.w $105cd6,(4,a0)
	movea.l $105ccc,a1
	move.w (6,a0),d0
	adda.w d0,a1
	move.l (a1)+,(a3)+
	move.l (a1)+,(a3)+
	move.l (a1)+,(a3)+
	move.l (a1)+,(a3)+
	move.l (a1)+,(a3)+
	move.l (a1)+,(a3)+
	move.l (a1)+,(a3)+
	move.l (a1)+,(a3)+
	addi.w #$20,(6,a0)
	move.w (6,a0),d1
	cmp.w $105cd4,d1
	bmi.b loc_013976
	clr.w (6,a0)

loc_013976:
	rts

;##############################################################################
loc_013978:
	nop
	bclr #3,$101001
	lea.l VRAMADDR,a1
	move.w #$20,(4,a1)
	movea.w #$7044,a2
	movea.w #$7047,a3

loc_013996:
	move.w d7,d5

loc_013998:
	move.w #$22,d6
	lea.l $106bba,a5
	movea.w a3,a4

loc_0139a4:
	move.w a4,(a1)
	nop
	nop
	nop
	move.w (2,a1),(a5)+
	adda.w #$20,a4
	dbra d6,loc_0139a4
	move.w a2,(a1)
	move.w #$22,d6
	lea.l $106bba,a5

loc_0139c4:
	move.w (a5)+,(2,a1)
	nop
	nop
	nop
	dbra d6,loc_0139c4
	adda.w #$1,a2
	adda.w #$1,a3
	dbra d5,loc_013998
	cmpa.w #$7059,a2
	bmi.w loc_013996
	rts

;##############################################################################
loc_0139e8:
	bset #0,($1a,a0)
	bne.b loc_013a30
	move.b #$32,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054
	move.l #loc_014594,$105ccc
	move.l #$401aa0,$105cd0
	move.w #$e0,$105cd4
	move.w #4,$105cd6
	move.b #0,($1b,a0)

loc_013a30:
	lea.l loc_013a42(pc),a1
	nop
	moveq #0,d0
	move.b ($1b,a0),d0
	movea.l (a1,d0.w),a2
	jmp (a2)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_013a42:
	dc.l loc_013a4e
	dc.l loc_013a88
	dc.l loc_013b6e

;##############################################################################
loc_013a4e:
	bset #1,($1a,a0)
	bne.b loc_013a5e
	move.l #$10000,($14,a0)

loc_013a5e:
	move.l ($14,a0),d0
	add.l d0,($c,a0)
	cmpi.w #$100,($c,a0)
	bmi.b loc_013a86
	move.w #$100,($c,a0)
	move.l #0,($14,a0)
	addq.b #4,($1b,a0)
	bclr #1,($1a,a0)

loc_013a86:
	rts

;##############################################################################
loc_013a88:
	bset #1,($1a,a0)
	bne.b loc_013acc
	move.w #$40,($1c,a0)
	move.w LSPCMODE,d7
	btst #3,d7
	beq.b loc_013aa8
	move.w #$32,($1c,a0)

loc_013aa8:
	move.w #$7097,($1e,a0)
	lea.l loc_02e000,a1
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_013ac2
	lea.l loc_02e320,a1

loc_013ac2:
	move.l (a1),($20,a0)
	move.w #$709a,($24,a0)

loc_013acc:
	subq.w #1,($1c,a0)
	bne.w loc_013b6c
	movea.l ($20,a0),a1
	movea.w ($1e,a0),a2
	lea.l loc_0070c8,a5
	movea.l $101420,a6
	moveq #0,d0
	moveq #0,d4
	jsr loc_0081c2
	move.l a6,$101420
	move.w #4,($1c,a0)
	move.w LSPCMODE,d7
	btst #3,d7
	beq.b loc_013b10
	move.w #3,($1c,a0)

loc_013b10:
	move.w a2,($1e,a0)
	move.l a1,($20,a0)
	cmpi.w #4,d0
	bne.b loc_013b28
	andi.w #$ff,d1
	move.w d1,($1c,a0)
	bra.b loc_013b6c

loc_013b28:
	cmpi.w #1,d0
	bne.b loc_013b56
	move.w ($24,a0),($1e,a0)
	addq.w #3,($24,a0)
	cmpi.w #$7097,($24,a0)
	bmi.b loc_013b54
	move.w #$7097,($24,a0)
	move.w #$7097,($1e,a0)
	move.w #2,d7
	jsr loc_013978(pc)

loc_013b54:
	bra.b loc_013b6c

loc_013b56:
	cmpi.w #2,d0
	bne.b loc_013b6c
	move.w #$ffff,($1c,a0)
	addq.b #4,($1b,a0)
	bclr #1,($1a,a0)

loc_013b6c:
	rts

;##############################################################################
loc_013b6e:
	bset #1,($1a,a0)
	bne.b loc_013b92
	move.b #$c4,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	move.w #$50,($1c,a0)

loc_013b92:
	subq.w #1,($1c,a0)
	bne.b loc_013ba2
	move.l #$1,$105cb0

loc_013ba2:
	rts

;##############################################################################
loc_013ba4:
	bset #0,($1a,a0)
	bne.b loc_013bc0
	jsr loc_00ef7c
	bset #4,($1a,a0)
	move.w $105c9c,($1c,a0)

loc_013bc0:
	move.w ($1c,a0),$105c9c
	rts

;##############################################################################
loc_013bca:
	bset #0,($1a,a0)
	bne.b loc_013bf0
	move.b #$11,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	move.l #$10000,($1c,a0)

loc_013bf0:
	subq.w #1,($1c,a0)
	bne.w loc_013c6c
	cmpi.w #4,($1e,a0)
	bmi.b loc_013c56
	bne.b loc_013c3e
	move.b #$15,$1068c6
	jsr loc_00ded2
	move.b #2,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	move.l #$1,$105cb0
	move.w #5,($1e,a0)
	move.w #$40,($1c,a0)
	bra.b loc_013c6c

loc_013c3e:
	move.w #1,($1c,a0)
	cmpi.w #9,($c,a0)
	bpl.b loc_013c4e
	clr.w (a0)

loc_013c4e:
	addi.w #$fff8,($c,a0)
	bra.b loc_013c6c

loc_013c56:
	move.w #4,($1c,a0)
	move.w #$ef8,d0
	add.w ($1e,a0),d0
	move.w d0,(4,a0)
	addq.w #1,($1e,a0)

loc_013c6c:
	rts

;##############################################################################
loc_013c6e:
	bset #0,($1a,a0)
	bne.b loc_013c9c
	move.w #$1b6,d0
	sub.w (4,a0),d0
	lsl.w #3,d0
	addi.w #$40,d0
	move.w LSPCMODE,d7
	btst #3,d7
	beq.b loc_013c98
	divu.w #6,d0
	mulu.w #5,d0

loc_013c98:
	move.w d0,($1c,a0)

loc_013c9c:
	subq.w #1,($1c,a0)
	bne.b loc_013caa
	move.l #$fff80000,($14,a0)

loc_013caa:
	move.l ($14,a0),d0
	add.l d0,($c,a0)
	cmpi.w #1,($c,a0)
	bpl.b loc_013cce
	clr.w (a0)
	cmpi.w #$1a7,(4,a0)
	bne.b loc_013cce
	move.l #$1,$105cb0

loc_013cce:
	rts

;##############################################################################
loc_013cd0:
	bset #0,($1a,a0)
	bne.b loc_013cde
	move.w #$90,($1c,a0)

loc_013cde:
	tst.w ($1c,a0)
	beq.b loc_013cf2
	subq.w #1,($1c,a0)
	bne.b loc_013d18
	move.l #$20000,($14,a0)

loc_013cf2:
	move.l ($14,a0),d0
	add.l d0,($c,a0)
	cmpi.w #$100,($c,a0)
	bmi.b loc_013d18
	bset #1,($1a,a0)
	bne.b loc_013d18
	move.w #$100,($c,a0)
	move.l #0,($14,a0)

loc_013d18:
	rts

;##############################################################################
loc_013d1a:
	bset #0,($1a,a0)
	bne.b loc_013d4a
	move.b (1,a0),d0
	ext.w d0
	move.w d0,($10,a0)
	cmpi.w #$eb1,(4,a0)
	bne.b loc_013d4a
	move.b #2,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054
  
loc_013d4a:
	move.l ($10,a0),d0
	add.l d0,(8,a0)
	cmpi.w #$a0,(8,a0)
	bne.b loc_013d82
	bset #1,($1a,a0)
	bne.b loc_013d82
	move.l #0,($10,a0)
	move.w #$b0,($1c,a0)
	move.w LSPCMODE,d7
	btst #3,d7
	beq.b loc_013d82
	move.w #$91,($1c,a0)

loc_013d82:
	tst.w ($1c,a0)
	beq.b loc_013d9a
	subq.w #1,($1c,a0)
	bne.b loc_013d9a
	clr.w (a0)
	move.l #1,$105cb0

loc_013d9a:
	rts

;##############################################################################
loc_013d9c:
	bset #0,($1a,a0)
	bne.b loc_013dc8
	move.l #$10000,($1c,a0)
	tst.b (1,a0)
	bne.b loc_013dc8
	move.b #$17,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
 
loc_013dc8:
	tst.b (1,a0)
	beq.b loc_013dd4
	subq.b #1,(1,a0)
	bne.b loc_013dfc

loc_013dd4:
	subq.w #1,($1c,a0)
	bne.b loc_013dfc
	cmpi.w #$a,($1e,a0)
	bmi.b loc_013de6
	clr.w (a0)
	bra.b loc_013dfc

loc_013de6:
	move.w #$e20,d0
	add.w ($1e,a0),d0
	move.w d0,(4,a0)
	move.w #4,($1c,a0)
	addq.w #1,($1e,a0)

loc_013dfc:
	rts

;##############################################################################
loc_013dfe:
	bset #0,($1a,a0)
	bne.b loc_013e1e
	move.w #$10,($1c,a0)
	move.w LSPCMODE,d7
	btst #3,d7
	beq.b loc_013e1e
	move.w #$a,($1c,a0)

loc_013e1e:
	tst.w ($1c,a0)
	beq.b loc_013e46
	subq.w #1,($1c,a0)
	bne.b loc_013e46
	lea.l loc_013e62(pc),a1
	nop
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #3,d0
	move.l (a1,d0.w),($10,a0)
	move.l (4,a1,d0.w),($14,a0)
	bra.b loc_013e60

loc_013e46:
	move.l ($10,a0),d0
	move.l ($14,a0),d1
	add.l d0,(8,a0)
	add.l d1,($c,a0)
	cmpi.w #1,($c,a0)
	bpl.b loc_013e60
	clr.w (a0)

loc_013e60:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_013e62:
	dc.l $fff80000,$00080000,$00080000,$00080000
	dc.l $fff80000,$fff80000,$00080000,$fff80000

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_013e82:
	dc.w $6777,$7fff,$6ffd,$7ffa,$6ff8,$7ff5,$6ff3,$6fd3
	dc.w $7fb2,$4f92,$5f71,$6f41,$7f20,$4e00,$216f,$37bf
	dc.w $0000,$7fff,$6ffc,$4ff8,$6ff0,$6fe0,$4fd0,$4fb0
	dc.w $4f90,$4f70,$2f30,$4e00,$0d00,$0b00,$216f,$37bf
	dc.w $0000,$7fff,$4ffc,$6fe8,$6ff4,$6fc3,$7f91,$6f60
	dc.w $2f40,$2e20,$0d20,$6b10,$4a10,$0900,$216f,$37bf
	dc.w $0000,$7fff,$6ff8,$6ff0,$7fd0,$4fb1,$7f81,$3f52
	dc.w $5e31,$4d00,$4c10,$4a10,$6900,$6800,$216f,$37bf
	dc.w $0000,$6ffb,$6ff0,$5fd0,$6fa1,$4f82,$5f61,$4f41
	dc.w $4f00,$0e00,$4c00,$4a00,$0900,$0700,$216f,$37bf
	dc.w $0000,$6ff0,$4fc0,$6f80,$6f60,$2f40,$6e20,$0d20
	dc.w $2b10,$0910,$4700,$0600,$4400,$0300,$216f,$37bf
	dc.w $0000,$6ffb,$6ff0,$5fd0,$6fa1,$4f82,$5f61,$4f41
	dc.w $4f00,$0e00,$4c00,$4a00,$0900,$0700,$216f,$37bf
	dc.w $0000,$7fff,$6ff8,$6ff0,$7fd0,$4fb1,$7f81,$3f52
	dc.w $5e31,$4d00,$4c10,$4a10,$6900,$6800,$216f,$37bf
	dc.w $0000,$7fff,$4ffc,$6fe8,$6ff4,$6fc3,$7f91,$6f60
	dc.w $2f40,$2e20,$0d20,$6b10,$4a10,$0900,$216f,$37bf
	dc.w $0000,$7fff,$6ffc,$4ff8,$6ff0,$6fe0,$4fd0,$4fb0
	dc.w $4f90,$4f70,$2f30,$4e00,$0d00,$0b00,$216f,$37bf

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_013fc2:
	dc.w $0aaa,$7fff,$6ffd,$7ffa,$6ff8,$7ff5,$6ff3,$6fd3
	dc.w $7fb2,$4f92,$5f71,$6f41,$2118,$625c,$539f,$77df
	dc.w $0000,$7fff,$6ffc,$4ff8,$6ff0,$6fe0,$4fd0,$4fb0
	dc.w $4f90,$4f70,$2f30,$4e00,$2118,$625c,$539f,$77df
	dc.w $0000,$7fff,$4ffc,$6fe8,$6ff4,$6fc3,$6fa2,$4f81
	dc.w $6f60,$6e30,$2d20,$6b10,$2118,$625c,$539f,$77df
	dc.w $0000,$7fff,$6ff8,$6ff0,$7fd0,$4fb1,$7f81,$3f52
	dc.w $5e31,$4d00,$0b00,$6800,$2118,$625c,$539f,$77df
	dc.w $0000,$6ffb,$6ff0,$5fd0,$6fa1,$4f82,$7f51,$4f00
	dc.w $6d00,$2b10,$0910,$4610,$2118,$625c,$539f,$77df
	dc.w $0000,$6ff0,$4fc0,$6f80,$6f60,$2f40,$6e20,$0d20
	dc.w $2b10,$0910,$2700,$0500,$2118,$625c,$539f,$77df
	dc.w $0000,$6ffb,$6ff0,$5fd0,$6fa1,$4f82,$7f51,$4f00
	dc.w $6d00,$2b10,$0910,$4610,$2118,$625c,$539f,$77df
	dc.w $0000,$7fff,$6ff8,$6ff0,$7fd0,$4fb1,$7f81,$3f52
	dc.w $5e31,$4d00,$0b00,$6800,$2118,$625c,$539f,$77df
	dc.w $0000,$7fff,$4ffc,$6fe8,$6ff4,$6fc3,$6fa2,$4f81
	dc.w $6f60,$6e30,$2d20,$6b10,$2118,$625c,$539f,$77df
	dc.w $0000,$7fff,$6ffc,$4ff8,$6ff0,$6fe0,$4fd0,$4fb0
	dc.w $4f90,$4f70,$2f30,$4e00,$2118,$625c,$539f,$77df

;##############################################################################
loc_014102:
	bset #0,($1a,a0)
	bne.b loc_014136
	move.l #$ffc00000,($10,a0)
	move.w #0,($1c,a0)
	move.w LSPCMODE,d7
	btst #3,d7
	beq.b loc_014136
	moveq #0,d0
	move.b (1,a0),d0
	divu.w #6,d0
	mulu.w #5,d0
	move.b d0,(1,a0)

loc_014136:
	tst.b (1,a0)
	beq.b loc_014142
	subq.b #1,(1,a0)
	bra.b loc_014186

loc_014142:
	move.l ($10,a0),d0
	beq.b loc_014186
	add.l d0,(8,a0)
	cmpi.w #$a0,(8,a0)
	bne.w loc_014186
	move.l #0,($10,a0)
	move.b #$12,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	cmpi.w #$eb0,(4,a0)
	bne.b loc_014186
	move.l #$50,$105cb0

loc_014186:
	rts

;##############################################################################
loc_014188:
	bset #0,($1a,a0)
	bne.b loc_01419e
	move.b #1,(7,a0)
	move.l #$40000,($1c,a0)

loc_01419e:
	subq.w #1,($1c,a0)
	bne.b loc_0141b0
	clr.w (a0)
	move.l #$1,$105cb0

loc_0141b0
	rts

;##############################################################################
loc_0141b2:
	bset #0,($1a,a0)
	bne.w loc_014230
	move.l #$10000,($1c,a0)
	move.b #1,($20,a0)
	move.w LSPCMODE,d0
	btst #3,d0
	beq.b loc_0141e8
	moveq #0,d0
	move.b (1,a0),d0
	divu.w #6,d0
	mulu.w #5,d0
	move.b d0,(1,a0)

loc_0141e8:
	cmpi.w #$183a,(4,a0)
	bne.b loc_014208
	move.b #2,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054
	bra.b loc_014226

loc_014208:
	cmpi.w #$ea6,(4,a0)
	bne.b loc_014230
	move.b #$49,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_014226:
	move.w #$1f,d6
	jsr loc_0142ec(pc)
	nop

loc_014230:
	tst.b (1,a0)
	beq.b loc_01425c
	subq.b #1,(1,a0)
	bne.b loc_01425a
	cmpi.w #$ea7,(4,a0)
	bne.b loc_01425a
	move.b #$cc,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_01425a:
	bra.b loc_0142b0

loc_01425c:
	subq.w #1,($1c,a0)
	bne.b loc_0142b0
	cmpi.b #$ff,($1f,a0)
	beq.b loc_014276
	move.w #1,($1c,a0)
	addi.b #$f,($1f,a0)

loc_014276:
	cmpi.b #$f,($1e,a0)
	beq.b loc_0142b0
	subq.b #1,($20,a0)
	bne.b loc_0142b0
	move.b #1,($20,a0)
	addq.b #1,($1e,a0)
	cmpi.w #$fff,($1e,a0)
	bne.b loc_0142b0
	cmpi.w #$ea6,(4,a0)
	beq.b loc_0142a6
	cmpi.w #$183b,(4,a0)
	bne.b loc_0142b0

loc_0142a6:
	move.l #$1,$105cb0

loc_0142b0:
	bset #0,$106996
	bset #1,$106996
	move.w ($1e,a0),$106998
	move.w (4,a0),d0
	andi.w #$f,d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_014326(pc),a1
	nop
	move.w (a1,d0.w),$10699a
	move.w (2,a1,d0.w),$10699c
	rts

;##############################################################################
loc_0142ec:
	move.w $105c9c,d0
	lea.l $101420,a1
	move.w #$ff,d2
	move.w #0,d3

loc_014300:
	move.w d0,d1
	lsl.w #6,d1
	move.w #$f,d7

loc_014308:
	move.w d1,(a1)+
	move.w d2,(a1)+
	addq.w #1,d1
	move.w d1,(a1)+
	move.w d3,(a1)+
	addq.w #1,d1
	dbra d7,loc_014308
	addq.w #1,d0
	dbra d6,loc_014300
	move.l a1,$101420
	rts
 
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_014326:
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0060,$0038,$0070,$0038
	dc.w $0000,$0000,$0000,$0000,$0078,$0030,$0070,$0030
	dc.w $0000,$0000,$0000,$0000,$0080,$0038,$0010,$0038

;##############################################################################
loc_014366:
	bset #0,($1a,a0)
	bne.b loc_0143ca
	move.l #loc_013fc2,d0
	move.l #$401b00,d1
	move.w #$140,d2
	move.w #4,d3
	cmpi.b #2,BIOS_COUNTRY_CODE
	bpl.b loc_0143a0
	move.l #loc_013e82,d0
	move.l #$401b00,d1
	move.w #$140,d2
	move.w #4,d3

loc_0143a0:
	move.l d0,$105ccc
	move.l d1,$105cd0
	move.w d2,$105cd4
	move.w d3,$105cd6
	move.b #1,(7,a0)
	move.w #8,($1c,a0)
	move.w #0,($1e,a0)

loc_0143ca:
	subq.w #1,($1c,a0)
	bne.w loc_014468
	movea.l $101420,a1
	lea.l loc_00582b,a2
	lea.l $71f8.w,a3
	jsr loc_00dffc
	lea.l loc_005836,a2
	lea.l $7119.w,a3
	jsr loc_00dffc
	move.w #$70f9,(a1)+
	move.w #$e38a,(a1)+
	lea.l loc_005851,a2
	lea.l $7435.w,a3
	cmpi.b #2,BIOS_COUNTRY_CODE
	bcs.b loc_014418
	lea.l $7454.w,a3

loc_014418:
	jsr loc_00dffc
	move.l a1,$101420
	move.b #0,(7,a0)
	move.w #$140,($1e,a0)
	move.w #$183c,(4,a0)
	move.w #$11a,($c,a0)
	cmpi.b #2,BIOS_COUNTRY_CODE
	bpl.b loc_014468
	move.w #$118,($c,a0)
	move.w #$116f,(4,a0)
	move.b #$4a,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_014468:
	tst.w ($1e,a0)
	beq.b loc_01448a
	cmpi.w #$100,($1e,a0)
	bpl.b loc_01447c
	jsr loc_007ac8

loc_01447c:
	subq.w #1,($1e,a0)
	bne.b loc_01448a
	move.w #$300,$101006

loc_01448a:
	rts

;##############################################################################
loc_01448c:
	bset #0,($1a,a0)
	bne.b loc_01449a
	bclr #1,($1a,a0)

loc_01449a:
	lea.l loc_0144ac(pc),a1
	nop
	moveq #0,d0
	move.b ($1b,a0),d0
	movea.l (a1,d0.w),a2
	jmp (a2)

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0144ac:
	dc.l loc_0144b8
	dc.l loc_014526
	dc.l loc_014574

;##############################################################################
loc_0144b8:
	bset #1,($1a,a0)
	bne.b loc_0144de
	move.l #$10000,($1c,a0)
	move.b #1,($20,a0)
	cmpi.w #$efe,(4,a0)
	bne.b loc_0144de
	move.w #$f,d6
	jsr loc_0142ec(pc)

loc_0144de:
	cmpi.b #8,($1e,a0)
	bmi.b loc_0144f8
	move.l #$fff80000,d0
	tst.b (1,a0)
	beq.b loc_0144f4
	neg.l d0

loc_0144f4:
	move.l d0,($10,a0)

loc_0144f8:
	move.l ($10,a0),d0
	add.l d0,(8,a0)
	cmpi.w #$ff60,(8,a0)
	bmi.b loc_014510
	cmpi.w #$1e0,(8,a0)
	bmi.b loc_014522

loc_014510:
	move.l #0,($10,a0)
	addq.b #4,($1b,a0)
	bclr #1,($1a,a0)

loc_014522:
	 jmp loc_01425c(pc)

;##############################################################################
loc_014526:
	bset #1,($1a,a0)
	bne.b loc_014540
	move.l #$80000,d0
	tst.b (1,a0)
	beq.b loc_01453c
	neg.l d0

loc_01453c:
	move.l d0,($10,a0)

loc_014540:
	move.l ($10,a0),d0
	add.l d0,(8,a0)
	cmpi.w #$a0,(8,a0)
	bne.b loc_014562
	move.l #0,($10,a0)
	addq.b #4,($1b,a0)
	bclr #1,($1a,a0)

loc_014562:
	bset #0,$106996
	move.w #$fff,$106998
	rts

;##############################################################################
loc_014574:
	bset #1,($1a,a0)
	bne.b loc_014582
	move.w #$c0,($1c,a0)

loc_014582:
	subq.w #1,($1c,a0)
	bne.b loc_014592
	move.l #$1,$105cb0

loc_014592:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;intro flame palette
loc_014594:
	dc.w $27cf,$0000,$7002,$0115,$7117,$022a,$722c,$133f
	dc.w $744f,$166f,$777f,$199f,$7aaf,$1ccf,$7ddf,$6fff
	dc.w $668f,$7117,$022a,$722c,$133f,$744f,$166f,$777f
	dc.w $199f,$7aaf,$1ccf,$7ddf,$6fff,$7ddf,$1ccf,$7aaf
	dc.w $278f,$744f,$166f,$777f,$199f,$7aaf,$1ccf,$7ddf
	dc.w $6fff,$7ddf,$1ccf,$7aaf,$199f,$777f,$166f,$744f
	dc.w $668f,$199f,$7aaf,$1ccf,$7ddf,$6fff,$7ddf,$1ccf
	dc.w $7aaf,$199f,$777f,$166f,$744f,$133f,$722c,$022a
	dc.w $668f,$6fff,$7ddf,$1ccf,$7aaf,$199f,$777f,$166f
	dc.w $744f,$133f,$722c,$022a,$7117,$0115,$0000,$7002
	dc.w $668f,$777f,$166f,$744f,$133f,$722c,$022a,$7117
	dc.w $0115,$0000,$7002,$7002,$0115,$7117,$022a,$722c
	dc.w $668f,$7117,$0115,$0000,$7002,$7002,$0115,$7117
	dc.w $022a,$722c,$133f,$744f,$166f,$777f,$199f,$1ccf


;##############################################################################
loc_014674:
	nop
	move.w #0,$101006
	lea.l player1mem,a6
	btst #7,($b8,a6)
	beq.b loc_014690
	adda.w #$200,a6

loc_014690:
	lea.l $105cac,a4
	bset #0,(a4)
	bne.w loc_014758
	move.w #0,(2,a4)
	move.l #1,(4,a4)
	move.w #1,($1c,a4)
	moveq #0,d0
	lea.l $103424,a1
	move.l d0,(a1)
	move.l d0,(4,a1)
	lea.l $103a78,a1
	move.l #0,(a1)+
	move.w #0,(a1)+
	move.w #$f,(a1)+
	move.w $10673a,d0
	lsl.w #5,d0
	addi.w #$440,d0
	move.w d0,(a1)+
	move.w #$e00f,(a1)+
	addi.w #$10,d0
	move.w d0,(a1)+
	move.w #$f00f,(a1)+
	move.w #$7093,($1e,a4)
	lea.l loc_02e2e0,a1
	move.w $10673a,d1
	lsl.w #2,d1
	adda.w d1,a1
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_014712
	adda.w #$320,a1

loc_014712:
	move.l (a1),($20,a4)
	move.w #$7096,($24,a4)
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_01472a
	move.w #$7095,($24,a4)

loc_01472a:
	move.w $10673a,d0
	addi.w #$24,d0
	move.b d0,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054
	move.l #$72000000,$103a78
	move.w #5,(8,a4)

loc_014758:
	tst.b $103a78
	bne.w loc_0148d6
	subq.w #1,($1c,a4)
	bne.w loc_0147ce
	move.w #2,($1c,a4)
	move.w (8,a4),d0
	lea.l loc_014918(pc),a1
	nop
	lsl.w #2,d0
	movea.l (a1,d0.w),a2
	jsr (a2)
	tst.w d0
	bne.b loc_0147ce
	movem.l a6, -(a7)
	movea.l ($20,a4),a1
	movea.w ($1e,a4),a2
	lea.l loc_0070c8,a5
	movea.l $101420,a6
	moveq #0,d0
	move.w #0,d4
	jsr loc_0081c2
	move.l a6,$101420
	move.w d0,($8,a4)
	move.w a2,($1e,a4)
	move.l a1,($20,a4)
	movem.l (a7)+,a6
	lea.l loc_014a50(pc),a1
	nop
	lsl.w #2,d0
	movea.l (a1,d0.w),a2
	jsr (a2)

loc_0147ce:
	subq.l #1,(4,a4)
	bne.w loc_01486a
	bset #3,$101001
	jsr FIX_CLEAR
	bclr #3,$101001
	lea.l loc_014ae8(pc),a1
	nop
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_014800
	lea.l loc_014b1c(pc),a1
	nop

loc_014800:
	move.w $10673a,d1
	lsl.w #2,d1
	movea.l (a1,d1.w),a2
	move.w (2,a4),d2
	movea.l (a2,d2.w),a1
	move.l (a1)+,(4,a4)
	move.w (a1)+,d0
	move.w (a1)+,d1
	lea.l $105cdc,a0
	adda.w d1,a0
	moveq #0,d1

loc_014826:
	move.w (a1)+,(a0)+
	move.w d1,(a0)+
	move.w (a1)+,d2
	btst #0,(3,a6)
	beq.b loc_014838
	addi.w #$50,d2

loc_014838:
	move.w d2,(a0)+
	move.w d1,(a0)+
	move.w (a1)+,(a0)+
	move.w d1,(a0)+
	move.w (a1)+,(a0)+
	move.w d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	move.l d1,(a0)+
	dbra d0,loc_014826
	addq.w #4,(2,a4)

loc_01485c:
	cmpa.l #$1062ac,a0
	bpl.b loc_01486a
	adda.w #$30,a0
	bra.b loc_01485c

loc_01486a:
	lea.l $105cdc,a0
	move.w #$40,$105c9c

loc_014878:
	move.l #0,$106996
	tst.b (a0)
	beq.b loc_0148a0
	lea.l loc_014dc8(pc),a1
	nop
	moveq #0,d0
	move.b (a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a1,d0.w),a1
	jsr (a1)
	jsr loc_00ef7c

loc_0148a0:
	adda.w #$30,a0
	cmpa.l #$1062ac,a0
	bmi.b loc_014878
	move.w #$1bb,d0
	move.w $105c9c,d1
	sub.w d1,d0
	bcs.b loc_0148d6
	movea.l $101420,a1
	addi.w #$8200,d1
	moveq #0,d2

loc_0148c6:
	move.w d1,(a1)+
	move.w d2,(a1)+
	addq.w #1,d1
	dbra d0,loc_0148c6
	move.l a1,$101420

loc_0148d6:
	nop
	nop
	nop
	nop
	nop
	bra.b loc_0148e8

loc_0148e2:
	jsr loc_014954(pc)
	nop

loc_0148e8:
	move.w #0,d0
	btst #7,$103728
	beq.b loc_0148fa
	move.w #2,d0

loc_0148fa:
	btst d0,BIOS_STATCURNT
	beq.b loc_01490e
	move.w #2,($8,a4)
	move.w #1,($1c,a4)

loc_01490e:
	jmp loc_00e630

;##############################################################################
loc_014914:
	rts

;##############################################################################
loc_014916:
	dc.w $397c

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_014918:
	dc.l loc_014934
	dc.l loc_014938
	dc.l loc_014954
	dc.l loc_014a22
	dc.l loc_014934
	dc.l loc_014a36
	dc.l loc_014934

;##############################################################################
loc_014934:
	moveq #0,d0
	rts

;##############################################################################
loc_014938:
	moveq #0,d0
	cmpi.w #$7093,($1e,a4)
	bne.b loc_014952
	move.l #1,(4,a4)
	move.w #0,(8,a4)
	moveq #1,d0

loc_014952:
	rts

;##############################################################################
loc_014954:
	bset #5,(a4)
	bne.b loc_01497e
	move.l #$72000000,$103a78
	move.b #1,$1068c6
	move.b #$a,$1068c7
	jsr loc_00e054
	bra.w loc_014a20

loc_01497e:
	tst.b GameDifficulty
	beq.b loc_0149c8
	tst.b (5,a6)
	bne.b loc_0149c8
	tst.w $106c3a
	bne.b loc_0149c8
	tst.b (8,a6)
	bne.b loc_0149c8
	move.w #5,$10100c
	lea.l $106908,a1
	move.w #2,(a1)
	clr.w (2,a1)
	move.w #$15,$106986
	bset #7,$101000
	jsr loc_006ef2
	bra.b loc_014a20

loc_0149c8:
	lea.l $106908,a1
	move.w #$a,(a1)
	clr.w (2,a1)
	moveq #0,d0
	move.l d0,$105cac
	tst.b GameDifficulty
	bne.b loc_014a20
	lea.l $106908,a1
	move.w #5,(a1)
	clr.w (2,a1)
	jsr loc_006be6
	moveq #0,d1
	move.l d1,$105cac
	move.w #$15,$106986
	bset #7,$101000
	jsr loc_006ef2
	move.w #8,$106930

loc_014a20:
	rts

;##############################################################################
loc_014a22:
	move.l #$72000000,$103a78
	move.w #5,($8,a4)
	moveq #1,d0
	rts

;##############################################################################
loc_014a36:
	move.l #$71000000,$103a78
	move.l #1,(4,a4)
	move.w #0,(8,a4)
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_014a50:
	dc.l loc_014934
	dc.l loc_014a68
	dc.l loc_014aa8
	dc.l loc_014aba
	dc.l loc_014adc
	dc.l loc_014934

;##############################################################################
loc_014a68:
	move ($24,a4),($1e,a4)
	moveq #3,d0
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_014a7a
	moveq #2,d0

loc_014a7a:
	add.w d0,($24,a4)
	cmpi.w #$709f,($24,a4)
	bmi.b loc_014aa6
	move.w #$7096,($24,a4)
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_014a9a
	move.w #$7095,($24,a4)

loc_014a9a:
	move.w #$7093,($1e,a4)
	move.w #$c0,($1c,a4)

loc_014aa6:
	rts

;##############################################################################
loc_014aa8:
	move.w #$100,($1c,a4)
	addq.b #4,($1b,a4)
	bclr #1,($1a,a4)
	rts

;##############################################################################
loc_014aba:
	move.w #$7096,($24,a4)
	tst.b BIOS_COUNTRY_CODE
	beq.b loc_014ace
	move.w #$7095,($24,a4)

loc_014ace:
	move.w #$7093,($1e,a4)
	move.w #$100,($1c,a4)
	rts

;##############################################################################
loc_014adc:
	andi.w #$ff,d1
	move.w d1,($1c,a4)
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_014ae6:
	dc.w $001e

loc_014ae8:
	dc.l loc_014b50,loc_014b8c,loc_014bac,loc_014bec
	dc.l loc_014c14,loc_014c3c,loc_014c74,loc_014cb4
	dc.l loc_014cd4,loc_014cfc,loc_014d40,loc_014d68
	dc.l loc_014da0

loc_014b1c:
	dc.l loc_014b70,loc_014b9c,loc_014bcc,loc_014c00
	dc.l loc_014c28,loc_014c60,loc_014c94,loc_014cc4
	dc.l loc_014ce8,loc_014d20,loc_014d54,loc_014d84
	dc.l loc_014db4

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_014b50:
	dc.l loc_014e20,loc_014e20,loc_014de0,loc_014e38
	dc.l loc_014e38,loc_014e38,loc_014e50,loc_014de0

loc_014b70:
	dc.l loc_014e20,loc_014e20,loc_014de0
	dc.l loc_014e38,loc_014e38,loc_014e50
	dc.l loc_014de0

loc_014b8c:
	dc.l loc_014e68,loc_014e78,loc_014e88,loc_014de0

loc_014b9c:
	dc.l loc_014e68,loc_014e78,loc_014e88,loc_014de0

loc_014bac:
	dc.l loc_014e98,loc_014eb0,loc_014eb0,loc_014de0
	dc.l loc_014de0,loc_014ec8,loc_014ec8,loc_014de0

loc_014bcc:
	dc.l loc_014e98,loc_014eb0,loc_014eb0,loc_014de0
	dc.l loc_014de0,loc_014ec8,loc_014ec8,loc_014de0

loc_014bec:
	dc.l loc_014ee0,loc_014ef0,loc_014ef0,loc_014f00
	dc.l loc_014de0

loc_014c00:
	dc.l loc_014ee0,loc_014ef0,loc_014ef0,loc_014f00
	dc.l loc_014de0

loc_014c14:
	dc.l loc_014f10,loc_014f28,loc_014f48,loc_014f68
	dc.l loc_014de0

loc_014c28:
	dc.l loc_014f10,loc_014f28,loc_014f48,loc_014f68
	dc.l loc_014de0

loc_014c3c:
	dc.l loc_014f88,loc_014f88,loc_014f88,loc_014fa0
	dc.l loc_014fa0,loc_014fa0,loc_014fc0,loc_014fc0
	dc.l loc_014de0

loc_014c60:
	dc.l loc_014f88,loc_014f88,loc_014fa0,loc_014fc0
	dc.l loc_014de0

loc_014c74:
	dc.l loc_014fe0,loc_014ff0,loc_015000,loc_015000
	dc.l loc_015000,loc_015000,loc_015010,loc_014de0

loc_014c94:
	dc.l loc_014fe0,loc_014ff0,loc_015000,loc_015000
	dc.l loc_015000,loc_015000,loc_015010,loc_014de0

loc_014cb4:
	dc.l loc_015020,loc_015038,loc_015050,loc_014de0

loc_014cc4:
	dc.l loc_015020,loc_015038,loc_015050,loc_014de0

loc_014cd4:
	dc.l loc_015060,loc_015078,loc_015090,loc_0150a8
	dc.l loc_014de0

loc_014ce8:
	dc.l loc_015060,loc_015078,loc_015090,loc_0150a8
	dc.l loc_014de0

loc_014cfc:
	dc.l loc_0150c0,loc_0150c0,loc_0150e0,loc_0150e0
	dc.l loc_015100,loc_015100,loc_015120,loc_015140
	dc.l loc_014de0

loc_014d20:
	dc.l loc_0150c0,loc_0150c0,loc_0150e0,loc_0150e0
	dc.l loc_015100,loc_015120,loc_015140,loc_014de0

loc_014d40:
	dc.l loc_015158,loc_015168,loc_015180,loc_015198
	dc.l loc_014de0

loc_014d54:
	dc.l loc_015158,loc_015168,loc_015180,loc_015198
	dc.l loc_014de0

loc_014d68:
	dc.l loc_0151a8,loc_0151a8,loc_0151b8,loc_0151b8
	dc.l loc_0151b8,loc_014de0,loc_014de0

loc_014d84:
	dc.l loc_0151a8,loc_0151a8,loc_0151b8,loc_0151b8
	dc.l loc_0151b8,loc_014de0,loc_014de0

loc_014da0:
	dc.l loc_0151c8,loc_0151c8,loc_0151d8,loc_0151f0
	dc.l loc_014de0

loc_014db4:
	dc.l loc_0151c8,loc_0151c8,loc_0151d8,loc_0151f0
	dc.l loc_014de0

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_014dc8:
	dc.l $00000000
	dc.l loc_015208,loc_01520a,loc_015250,loc_0152a8
	dc.l loc_0152cc

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_014de0:
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0100,$0000,$0000,$0000
	dc.w $0100,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000

loc_014e20:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$1860,$00a0,$0170
	dc.w $0100,$1861,$00a0,$0170

loc_014e38:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$1862,$00a0,$0170
	dc.w $0100,$1863,$00a0,$0170

loc_014e50:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$1864,$00a0,$0170
	dc.w $0100,$1865,$00a0,$0170

loc_014e68:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$1866,$00a0,$0170

loc_014e78:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$1867,$00a0,$0170

loc_014e88:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$1868,$00a0,$0170

loc_014e98:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$1869,$00a0,$0170
	dc.w $0100,$186a,$00a0,$0170

loc_014eb0:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$186b,$00a0,$0170
	dc.w $0100,$186c,$00a0,$0170

loc_014ec8:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$186d,$00a0,$0170
	dc.w $0100,$186e,$00a0,$0170

loc_014ee0:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$186f,$00a0,$0170

loc_014ef0:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$1870,$00a0,$0170

loc_014f00:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$1871,$00a0,$0170

loc_014f10:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$1872,$00a0,$0170
	dc.w $0100,$1873,$00a0,$0170

loc_014f28:
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0100,$1872,$00a0,$0170
	dc.w $0100,$1873,$00a0,$0170
	dc.w $0300,$1874,$00a0,$0170

loc_014f48:
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0100,$1876,$00a0,$0170
	dc.w $0100,$1877,$00a0,$0170
	dc.w $0000,$0000,$00a0,$0170

loc_014f68:
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0100,$1878,$00a0,$0170
	dc.w $0100,$1879,$00a0,$0170
	dc.w $0000,$0000,$00a0,$0170

loc_014f88:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$187a,$00a0,$0170
	dc.w $0100,$187b,$00a0,$0170

loc_014fa0:
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0100,$187c,$00a0,$0170
	dc.w $0100,$187d,$00a0,$0170
	dc.w $0100,$187e,$00a0,$0170

loc_014fc0:
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0100,$187f,$00a0,$0170
	dc.w $0100,$1880,$00a0,$0170
	dc.w $0000,$0000,$0000,$0000

loc_014fe0:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$1881,$00a0,$0170

loc_014ff0:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0200,$1881,$00a0,$0170

loc_015000:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$1884,$00a0,$0170

loc_015010:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$1885,$00a0,$0170

loc_015020:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$1886,$00a0,$0170
	dc.w $0100,$1887,$00a0,$0170

loc_015038:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0500,$1888,$00a0,$0170
	dc.w $0000,$0000,$0000,$0000

loc_015050:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0400,$1889,$00a0,$0170

loc_015060:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$188a,$00a0,$0170
	dc.w $0100,$188b,$00a0,$0170

loc_015078:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$188c,$00a0,$0170
	dc.w $0204,$188d,$00a0,$0170

loc_015090:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$1892,$00a0,$0170
	dc.w $0000,$0000,$0000,$0000

loc_0150a8:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$1893,$00a0,$0170
	dc.w $0100,$1894,$00a0,$0170

loc_0150c0:
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0100,$1895,$00a0,$0170
	dc.w $0100,$1896,$00a0,$0170
	dc.w $0100,$1897,$00a0,$0170

loc_0150e0:
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0100,$1895,$00a0,$0170
	dc.w $0100,$1898,$00a0,$0170
	dc.w $0100,$1897,$00a0,$0170

loc_015100:
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0100,$1895,$00a0,$0170
	dc.w $0100,$1898,$00a0,$0170
	dc.w $0100,$1899,$00a0,$0170

loc_015120:
	dc.w $0000,$0f00,$0002,$0000
	dc.w $0100,$189a,$00a0,$0170
	dc.w $0100,$189b,$00a0,$0170
	dc.w $0000,$0000,$00a0,$0170

loc_015140:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$189a,$00a0,$0170
	dc.w $0000,$0000,$00a0,$0170

loc_015158:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$189c,$00a0,$0170

loc_015168:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$189d,$00a0,$0170
	dc.w $0100,$189e,$00a0,$0170

loc_015180:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$189f,$00a0,$0170
	dc.w $0100,$18a0,$00a0,$0170

loc_015198:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$18a1,$00a0,$0170

loc_0151a8:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$18a2,$00a0,$0170

loc_0151b8:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$18a3,$00a0,$0170

loc_0151c8:
	dc.w $0000,$0f00,$0000,$0000
	dc.w $0100,$18a4,$00a0,$0170

loc_0151d8:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0100,$18a5,$00a0,$0170
	dc.w $0100,$18a6,$00a0,$0170

loc_0151f0:
	dc.w $0000,$0f00,$0001,$0000
	dc.w $0208,$18a7,$00a0,$0170
	dc.w $0000,$0000,$00a0,$0170

;##############################################################################
loc_015208:
	rts

;##############################################################################
loc_01520a:
	bset #0,($1a,a0)
	bne.b loc_015218
	move.w #$100,($18,a0)

loc_015218:
	subq.b #1,($18,a0)
	bne.b loc_01524e
	moveq #0,d0
	move.b (1,a0),d0
	lea.l loc_015318(pc),a1
	nop
	movea.l (a1,d0.w),a2
	moveq #0,d1
	move.b ($19,a0),d1
	move.w (a2,d1.w),d2
	btst #0,(3,a6)
	beq.b loc_015244
	addi.w #$50,d2

loc_015244:
	move.w d2,(4,a0)
	move.w (2,a2,d1.w),($18,a0)

loc_01524e:
	rts

;##############################################################################
loc_015250:
	bset #0,($1a,a0)
	bne.b loc_01526e
	move.l #$fffd8000,($10,a0)
	move.l #$ffff0000,($14,a0)
	move.w #$2000,($18,a0)

loc_01526e:
	move.l ($10,a0),d0
	move.l ($14,a0),d1
	add.l d0,(8,a0)
	add.l d1,($c,a0)
	subq.b #1,($18,a0)
	bne.b loc_0152a6
	cmpi.w #$1875,(4,a0)
	bne.b loc_015290
	clr.w (a0)
	rts

loc_015290:
	moveq #0,d0
	move.l d0,($10,a0)
	move.l d0,($14,a0)
	move.w #$1875,(4,a0)
	move.b #8,($18,a0)

loc_0152a6:
	rts

;##############################################################################
loc_0152a8:
	bset #0,($1a,a0)
	bne.b loc_0152ee
	move.w #1,($18,a0)
	move.l #$30000,($1c,a0)
	move.l ($8,a0),($10,a0)
	move.l ($c,a0),($14,a0)
	bra.b loc_0152ee
 
loc_0152cc:
	bset #0,($1a,a0)
	bne.b loc_0152ee
	move.w #$80,($18,a0)
	move.l #$20000,($1c,a0)
	move.l ($8,a0),($10,a0)
	move.l ($c,a0),($14,a0)

loc_0152ee:
	subq.w #1,($18,a0)
	bne.b loc_015316
	move.w #4,($18,a0)
	move.l ($10,a0),d0
	move.l ($14,a0),d1
	add.l ($1c,a0),d1
	move.l d0,(8,a0)
	move.l d1,($c,a0)
	neg.l ($1c,a0)
	addq.l #1,($1c,a0)

loc_015316:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_015318:
	dc.l loc_015324
	dc.l loc_015330
	dc.l loc_015358

loc_015324:
	dc.w $1881,$0104,$1882,$0408,$1883,$2008

loc_015330:
	dc.w $188c,$0404,$188d,$0408,$188e,$040c,$188f,$4810
	dc.w $1890,$0414,$1891,$0418,$1890,$041c,$1891,$0420
	dc.w $1890,$0424,$1891,$2024

loc_015358:
	dc.w $18a7,$1004,$18a8,$1008,$18a9,$100c,$18a8,$1000


;##############################################################################
loc_015368:
	nop
	move.l #$0,$106996
	lea.l $105cac,a4
	bset #0,(a4)
	bne.w loc_015402
	jsr loc_006be6
	move.w #$700,d3
	jsr loc_00d976
	lea.l $105cdc,a0
	moveq #0,d0
	move.w #$17f,d7

loc_01539e:
	move.l d0,(a0)+
	dbra d7,loc_01539e
	move.w #0,(8,a4)
	move.w #1,($26,a4)
	move.w #0,($28,a4)
	move.l #loc_0157d0,($20,a4)
	cmpi.b #6,GameDifficulty
	bmi.b loc_0153d6
	move.l #loc_015968,($20,a4)
	move.w #$80,($26,a4)

loc_0153d6:
	move.w #0,$105c9e
	lea.l $103a78,a1
	move.l #$72000000,(a1)+
	move.w #0,(a1)+
	move.w #$f,(a1)+
	move.w #$c0,(a1)+
	move.w #$c00f,(a1)+
	move.w #$60,(a1)+
	move.w #$600f,(a1)+

loc_015402:
	tst.b $103a78
	bne.w loc_015534
	bset #1,(a4)
	bne.w loc_0154c2
	bset #3,$101001
	jsr FIX_CLEAR
	bclr #3,$101001
	move.w $10673a,d0
	addi.w #$a,d0
	move.b d0,$1068c6
	move.b #$16,$1068c7
	jsr loc_00e054
	move.l #$71000000,$103a78
	moveq #0,d1
	move.l d1,$103424
	move.l d1,$103428
	lea.l player1mem,a0
	btst #7,($b8,a0)
	beq.b loc_015472
	lea.l (playeroffset,a0),a0

loc_015472:
	tst.w $106c3a
	bne.b loc_0154c2
	tst.b GameDifficulty
	beq.b loc_0154c2
	tst.b (5,a0)
	bne.b loc_0154c2
	movem.l a0-a6,-(a7)
	move.w #$40,$105c9c
	lea.l $105cdc,a0
	move.w #0,(2,a0)
	move.w #$112e,(4,a0)
	move.w #0,(6,a0)
	move.w #$a0,(8,a0)
	move.w #$100,($c,a0)
	jsr loc_00ef7c
	movem.l (a7)+,a0-a6

loc_0154c2:
	subq.w #1,($26,a4)
	bne.w loc_015534
	cmpi.w #2,(8,a4)
	bne.b loc_0154de
	move.w #1,($26,a4)
	jmp loc_015b10(pc)
	nop

loc_0154de:
	move.w #$20,($26,a4)
	lea.l $105cdc,a0
	move.w #$1e,d7

loc_0154ee:
	tst.b (a0)
	beq.b loc_0154fe
	adda.w #$30,a0
	dbra d7,loc_0154ee
	bra.w loc_0155ce

loc_0154fe:
	movea.l ($20,a4),a1
	moveq #0,d7

loc_015504:
	move.w (a1)+,(a0)+
	move.w d7,(a0)+
	move.w (a1)+,(a0)+
	move.w d7,(a0)+
	move.l #$a00000,(a0)+
	move.w (a1)+,(a0)+
	move.w #0,(a0)+
	move.l d7,(a0)+
	move.l d7,(a0)+
	move.l d7,(a0)+
	move.l d7,(a0)+
	move.l d7,(a0)+
	move.l d7,(a0)+
	move.l d7,(a0)+
	move.l d7,(a0)+
	move.w (a1)+,d0
	beq.b loc_015504
	move.w d0,($26,a4)
	move.l a1,($20,a4)

loc_015534:
	move.w #0,d0
	btst #$7,$103728
	beq.b loc_015546
	move.w #2,d0

loc_015546:
	btst d0,BIOS_STATCURNT
	beq.b loc_015560
	move.w #2,(8,a4)
	move.w #1,($1c,a4)
	move.w #1,($26,a4)

loc_015560:
	move.w #$90,$105c9c
	lea.l $105cdc,a0

loc_01556e:
	moveq #0,d0
	move.b (a0),d0
	beq.b loc_01558a
	move.l #$0,$106996
	lea.l loc_0155d4(pc),a1
	nop
	movea.l (a1,d0.w),a1
	jsr (a1)

loc_01558a:
	adda.l #$30,a0
	cmpa.l #$1062ac,a0
	bmi.b loc_01556e
	movea.l $101420,a6
	move.w $105c9c,d0
	move.w $105c9e,d1
	sub.w d0,d1
	bmi.b loc_0155be
	addi.w #$8200,d0

loc_0155b2:
	move.w d0,(a6)+
	move.w #0,(a6)+
	addq.w #1,d0
	dbra d1,loc_0155b2

loc_0155be:
	move.w $105c9c,$105c9e
	move.l a6,$101420

loc_0155ce:
	jmp loc_00e630

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0155d4:
	dc.l $00000000
	dc.l loc_015710,loc_015740,loc_015764,loc_015780
	dc.l loc_0157b4,loc_015728,loc_015710,loc_015604
	dc.l loc_015614,loc_015614,loc_015614


;##############################################################################
loc_015604:
	btst #3,(a4)
	beq.b loc_015614
	bclr #3,(a4)
	move.w #$3f,($1c,a0)

;##############################################################################
loc_015614:
	bset #0,($1a,a0)
	bne.b loc_015642
	bclr #0,($1b,a0)
	move.w #$ff,($1e,a0)
	move.w #0,($1c,a0)
	cmpi.b #$28,(a0)
	bne.b loc_015642
	cmpi.b #1,BIOS_COUNTRY_CODE
	bls.b loc_015642
	addq.w #3,(4,a0)

loc_015642:
	tst.w ($1c,a0)
	beq.b loc_01564e
	subq.w #1,($1c,a0)
	bra.b loc_0156cc

loc_01564e:
	btst #0,($1b,a0)
	bne.b loc_01569e
	addi.b #1,($1e,a0)
	cmpi.b #$f,($1e,a0)
	bmi.b loc_015692
	bset #0,($1b,a0)
	move.w #$40,($1c,a0)
	cmpi.w #$18ff,(4,a0)
	bne.b loc_015686
	move.w #$40,d0
	add.w d0,($1c,a0)
	add.w d0,$105cd2

loc_015686:
	cmpi.b #$20,(a0)
	bne.b loc_015692
	move.w #$ffff,($1c,a0)

loc_015692:
	tst.b (1,a0)
	beq.b loc_01569c
	bset #3,(a4)

loc_01569c:
	bra.b loc_0156cc

loc_01569e:
	cmpi.b #$2c,(a0)
	bne.b loc_0156c0
	cmpi.w #2,(8,a4)
	beq.b loc_0156cc
	move.w #2,(8,a4)
	move.w #1,($1c,a4)
	move.w #1,($26,a4)
	bra.b loc_0156cc

loc_0156c0:
	subi.b #1,($1e,a0)
	beq.b loc_0156ca
	bpl.b loc_0156cc

loc_0156ca:
	clr.w (a0)

loc_0156cc:
	bset #0,$106996
	bset #1,$106996
	move.w ($1e,a0),$106998
	lea.l loc_090020,a1
	move.w (4,a0),d0
	lsl.w #2,d0
	movea.l (a1,d0.w),a1
	move.w (a1),d0
	andi.w #$ff,d0
	lsl.w #3,d0
	move.w d0,$10699a
	move.w #0,$10699c
	jmp loc_00ef7c

;##############################################################################
loc_015710:
	addi.l #$8000,($c,a0)
	cmpi.w #$210,($c,a0)
	bmi.b loc_015722
	clr.w (a0)

loc_015722:
	jmp loc_00ef7c

;##############################################################################
loc_015728:
	bset #0,($1a,a0)
	bne.b loc_015740
	cmpi.b #1,BIOS_COUNTRY_CODE
	bls.b loc_015740
	move.w #$192f,(4,a0)

;##############################################################################
loc_015740:
	tst.b (1,a0)
	beq.b loc_01574c
	subq.b #1,(1,a0)
	bra.b loc_01575e

loc_01574c:
	addi.l #$8000,($c,a0)
	cmpi.w #$280,($c,a0)
	bmi.b loc_01575e
	clr.w (a0)

loc_01575e:
	jmp loc_00ef7c

;##############################################################################
loc_015764:
	addi.l #$8000,($c,a0)
	cmpi.w #$180,($c,a0)
	bmi.b loc_01577a
	move.w #$180,($c,a0)

loc_01577a:
	jmp loc_00ef7c

;##############################################################################
loc_015780:
	addi.l #$8000,($c,a0)
	cmpi.w #$160,($c,a0)
	bmi.b loc_0157ae
	move.w #$160,($c,a0)
	subq.b #1,(1,a0)
	bne.b loc_0157ae
	move.w #2,(8,a4)
	move.w #1,($1c,a4)
	move.w #1,($26,a4)

loc_0157ae:
	jmp loc_00ef7c

;##############################################################################
loc_0157b4:
	addi.l #$8000,($c,a0)
	cmpi.w #$1c0,($c,a0)
	bmi.b loc_0157ca
	move.w #$1c0,($c,a0)

loc_0157ca:
	jmp loc_00ef7c


;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0157d0:
	dc.w $1840,$192c,$00b0,$00f0
	dc.w $0400,$1900,$00b0,$00a0
	dc.w $0400,$1901,$00b0,$0040
	dc.w $0400,$1902,$00b0,$0060
	dc.w $0400,$1903,$00b0,$0040
	dc.w $0400,$1904,$00b0,$0040
	dc.w $0400,$1905,$00b0,$0060
	dc.w $0400,$1906,$00b0,$0040
	dc.w $0400,$1907,$00b0,$0040
	dc.w $0400,$1908,$00b0,$0040
	dc.w $0400,$1909,$00b0,$0060
	dc.w $0400,$190a,$00b0,$0040
	dc.w $0400,$190b,$00b0,$0040
	dc.w $0400,$190c,$00b0,$0040
	dc.w $0400,$190d,$00b0,$0040
	dc.w $0400,$190e,$00b0,$0040
	dc.w $0400,$190f,$00b0,$0040
	dc.w $0400,$1910,$00b0,$0040
	dc.w $0400,$1911,$00b0,$0040
	dc.w $0400,$1912,$00b0,$0040
	dc.w $0400,$18fa,$00b0,$0040
	dc.w $0400,$1913,$00b0,$0040
	dc.w $0400,$1914,$00b0,$0040
	dc.w $0400,$1915,$00b0,$0040
	dc.w $0400,$1916,$00b0,$0040
	dc.w $0400,$1917,$00b0,$0060
	dc.w $0400,$1918,$00b0,$0040
	dc.w $0400,$1919,$00b0,$0040
	dc.w $0400,$191a,$00b0,$0040
	dc.w $0400,$191b,$00b0,$0040
	dc.w $0400,$191c,$00b0,$0040
	dc.w $0400,$191d,$00b0,$0060
	dc.w $0400,$191e,$00b0,$0040
	dc.w $0400,$191f,$00b0,$0040
	dc.w $0400,$1920,$00b0,$0040
	dc.w $0400,$1921,$00b0,$0040
	dc.w $0400,$1922,$00b0,$0040
	dc.w $0400,$1923,$00b0,$0040
	dc.w $0400,$18fb,$00b0,$0040
	dc.w $0400,$18fc,$00b0,$0040
	dc.w $0400,$18fd,$00b0,$0040
	dc.w $0400,$1924,$00b0,$0060
	dc.w $0800,$192d,$00b0,$00a0
	dc.w $0400,$1925,$00b0,$0080
	dc.w $0400,$1926,$00b0,$0040
	dc.w $0400,$1927,$00b0,$0060
	dc.w $0400,$1928,$00b0,$0040
	dc.w $0400,$1929,$00b0,$0180
	dc.w $1400,$192e,$00b0,$0080
	dc.w $0c00,$192a,$00b0,$0040
	dc.w $10c0,$192b,$00b0,$ffff

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_015968:
	dc.w $2800,$1930,$01c0,$0020
	dc.w $2800,$1931,$01a0,$0020
	dc.w $2800,$1932,$0180,$0020
	dc.w $2400,$1900,$0160,$0080
	dc.w $2000,$1901,$01c0,$0080
	dc.w $2401,$1902,$0190,$00c0
	dc.w $2000,$1903,$01c0,$0080
	dc.w $2400,$1904,$0190,$0080
	dc.w $2401,$1905,$0190,$00c0
	dc.w $2000,$1906,$01c0,$0080
	dc.w $2400,$1907,$0190,$0080
	dc.w $2400,$1908,$0190,$0080
	dc.w $2401,$1909,$0190,$00c0
	dc.w $2000,$190a,$01c0,$0080
	dc.w $2400,$190b,$0190,$0080
	dc.w $2400,$190c,$0190,$0080
	dc.w $2400,$18ff,$0190,$0080
	dc.w $2400,$190e,$0190,$0080
	dc.w $2400,$190f,$0190,$0080
	dc.w $2400,$1910,$0190,$0080
	dc.w $2400,$1911,$0190,$0080
	dc.w $2400,$1912,$0190,$0080
	dc.w $2400,$18fa,$0190,$0080
	dc.w $2400,$1913,$0190,$0080
	dc.w $2400,$1914,$0190,$0080
	dc.w $2400,$1915,$0190,$0080
	dc.w $2400,$1916,$0190,$0080
	dc.w $2401,$1917,$0190,$00c0
	dc.w $2000,$1918,$01c0,$0080
	dc.w $2400,$1919,$0190,$0080
	dc.w $2400,$191a,$0190,$0080
	dc.w $2400,$191b,$0190,$0080
	dc.w $2400,$191c,$0190,$0080
	dc.w $2401,$191d,$0190,$00c0
	dc.w $2000,$191e,$01c0,$0080
	dc.w $2400,$191f,$0190,$0080
	dc.w $2400,$1920,$0190,$0080
	dc.w $2400,$1921,$0190,$0080
	dc.w $2400,$1922,$0190,$0080
	dc.w $2400,$1923,$0190,$0080
	dc.w $2400,$18fb,$0190,$0080
	dc.w $2400,$18fc,$0190,$0080
	dc.w $2401,$18fd,$0190,$0080
	dc.w $2400,$1924,$01c0,$0020
	dc.w $2400,$1930,$01a0,$0020
	dc.w $2400,$1931,$0180,$0020
	dc.w $2400,$1925,$0160,$0080
	dc.w $2000,$1926,$01c0,$0080
	dc.w $2401,$1927,$0190,$00c0
	dc.w $2000,$1928,$01c0,$0080
	dc.w $2401,$1929,$0190,$0080
	dc.w $2c00,$192a,$01b0,$0000
	dc.w $2c00,$192b,$0190,$ffff

;##############################################################################
loc_015b10:
	bset #5,(a4)
	bne.b loc_015b3a
	move.l #$72000000,$103a78
	move.b #$1,$1068c6
	move.b #$a,$1068c7
	jsr loc_00e054
	bra.w loc_015bac

loc_015b3a:
	lea.l player1mem,a0
	btst #7,($b8,a0)
	beq.b loc_015b4c
	lea.l (playeroffset,a0),a0

loc_015b4c:
	lea.l $106908,a1
	tst.b (5,a0)
	bne.b loc_015b68
	tst.b (8,a0)
	bne.b loc_015b68
	move.w #$b,(a1)
	clr.w (2,a1)
	bra.b loc_015b86

loc_015b68:
	tst.b ($5,a0)
	bne.b loc_015b78
	move.w #$c,(a1)
	clr.w (2,a1)
	bra.b loc_015b86

loc_015b78:
	move.w #5,(a1)
	clr.w (2,a1)
	jsr loc_006be6

loc_015b86:
	moveq #0,d1
	move.l d1,$105cac
	move.w #$15,$106986
	bset #7,$101000
	jsr loc_006ef2
	move.w #8,$106930

loc_015bac:
	rts

;##############################################################################
loc_015bae:
	lea.l player1mem,a6

loc_015bb4:
	bclr #7,($bf,a6)
	moveq #9,d0

loc_015bbc:
	clr.w ($d4,a6)
	adda.l #2,a6
	dbra d0,loc_015bbc
	cmpa.l #player2mem,a6
	bcc.b loc_015bda
	lea.l player2mem,a6
	bra.b loc_015bb4

loc_015bda:
	rts

;##############################################################################
loc_015bdc:
	movem.l a0,-(a7)
	btst #6,$101000
	bne.b loc_015c1a
	jsr loc_01682c
	lea.l player1mem,a0
	lea.l player2mem,a1
	jsr loc_015c20(pc)
	nop
	lea.l player2mem,a0
	lea.l player1mem,a1
	jsr loc_015c20(pc)
	nop
	jsr loc_015d62(pc)
	nop

loc_015c1a:
	movem.l (a7)+,a0
	rts

;##############################################################################
loc_015c20:
	btst #7,($bf,a1)
	bne.w loc_015cf0
	moveq #0,d0
	move.w ($22,a0),d0
	move.l d0,d1
	lsl.l #5,d0
	lsl.l #4,d1
	lea.l loc_037000+$10,a2
	adda.l d0,a2
	adda.l d1,a2
	moveq #0,d0
	move.w ($22,a1),d0
	move.l d0,d1
	lsl.l #5,d0
	lsl.l #4,d1
	lea.l loc_037000+$10,a3
	adda.l d0,a3
	adda.l d1,a3
	cmpi.l #0,($24,a2)
	bne.b loc_015c70
	bclr #4,($bf,a1)
	bclr #5,($bf,a0)
	bra.w loc_015cf0

loc_015c70:
	btst #2,($bf,a1)
	bne.w loc_015cf0
	bset #4,($bf,a1)
	btst #5,($bf,a0)
	bne.w loc_015cf0
	jsr loc_015ebc(pc)
	nop
	btst #7,($bf,a1)
	beq.w loc_015cf0
	bset #5,($bf,a0)
	move.b ($140,a0),d0
	move.b d0,($144,a1)
	move.b ($141,a0),d0
	move.b d0,($145,a1)
	move.b ($142,a0),d0
	move.b d0,($146,a1)
	move.w ($d0,a0),($fc,a1)
	lea.l loc_016a14,a2
	moveq #0,d0
	move.w ($d0,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a2
	move.b (a2),d1
	bset #6,($21,a0)
	bclr #6,($21,a1)
	btst #2,d1
	beq.b loc_015cf0
	bclr #6,($21,a0)
	bset #6,($21,a1)

loc_015cf0
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_015cf2:
	dc.w $1000,$100d,$0800,$1802
	dc.w $1700,$160d,$1700,$1602
	dc.w $10f8,$0a10,$10f8,$0a10
	dc.w $1800,$1806,$1800,$1802
	dc.w $1004,$1008,$0204,$1e02
	dc.w $1800,$180d,$1800,$1802
	dc.w $2afd,$201c,$2afd,$2002
	dc.w $1400,$1208,$1000,$1608
	dc.w $1802,$1808,$1806,$180c
	dc.w $1804,$180a,$1804,$1802
	dc.w $0900,$0a0c,$0300,$100c
	dc.w $19f8,$1408,$09f0,$2410
	dc.w $19f0,$1410,$09f0,$2410
	dc.w $1800,$1c17,$1800,$1c17

;##############################################################################
loc_015d62:
	lea.l $1064f0,a0

loc_015d68:
	btst #0,(1,a0)
	beq.w loc_015ea2
	btst #2,($b,a0)
	beq.w loc_015ea2
	lea.l player1mem,a1
	btst #2,(1,a0)
	bne.b loc_015d90
	adda.l #playeroffset,a1

loc_015d90:
	btst #2,($bf,a1)
	bne.b loc_015e0e
	btst #7,($bf,a1)
	bne.b loc_015e0e
	cmpi.w #$12,($d0,a1)
	beq.b loc_015e0e
	lea.l loc_015cf2(pc),a4
	btst #3,($b,a0)
	beq.b loc_015dba
	adda.l #4,a4

loc_015dba:
	moveq #0,d0
	move.b (a0),d0
	lsl.w #3,d0
	adda.l d0,a4
	lea.l loc_037000+$10,a3
	moveq #0,d0
	move.w ($22,a1),d0
	move.l d0,d1
	lsl.l #5,d0
	lsl.l #4,d1
	adda.l d0,a3
	adda.l d1,a3
	jsr loc_015f98(pc)
	nop
	btst #7,($bf,a1)
	beq.b loc_015e0e
	move.w (2,a0),($fc,a1)
	move.b (4,a0),($144,a1)
	move.b (5,a0),($145,a1)
	move.b (6,a0),($146,a1)
	ori.b #5,($146,a1)
	bset #4,(1,a0)
	bra.w loc_015ea2

loc_015e0e:
	lea.l $1064f0,a1

loc_015e14:
	btst #0,(1,a1)
	beq.b loc_015e8a
	btst #2,($b,a1)
	beq.b loc_015e8a
	move.b (1,a0),d0
	move.b (1,a1),d1
	eor.b d1,d0
	btst #2,d0
	beq.b loc_015e8a
	lea.l loc_015cf2(pc),a4
	btst #3,($b,a0)
	beq.b loc_015e46
	adda.l #4,a2

loc_015e46:
	moveq #0,d0
	move.b (a0),d0
	lsl.w #3,d0
	adda.l d0,a4
	lea.l loc_015cf2(pc),a5
	btst #3,($b,a1)
	beq.b loc_015e60
	adda.l #4,a2

loc_015e60:
	moveq #0,d0
	move.b (a1),d0
	lsl.w #3,d0
	adda.l d0,a5
	jsr loc_0160f8(pc)
	nop
	or.l d7,d6
	beq.b loc_015e8a
	btst #6,($b,a0)
	beq.b loc_015e82
	btst #6,($b,a1)
	beq.b loc_015ea2

loc_015e82:
	bset #4,(1,a0)
	bra.b loc_015ea2

loc_015e8a:
	adda.l #$40,a1
	lea.l $1064f0,a2
	moveq #4,d0
	lsl.l #6,d0
	adda.l d0,a2
	cmpa.l a2,a1
	bcs.w loc_015e14

loc_015ea2:
	adda.l #$40,a0
	lea.l $1064f0,a1
	moveq #4,d0
	lsl.l #6,d0
	adda.l d0,a1
	cmpa.l a1,a0
	bcs.w loc_015d68
	rts

;##############################################################################
loc_015ebc:
	movea.l a2,a4
	adda.l #$24,a4
	movea.l a3,a5
	adda.l #8,a5
	cmpi.l #0,(a5)
	beq.b loc_015ee2
	jsr loc_01606c(pc)
	nop
	move.w d6,($d4,a1)
	move.w d7,($d6,a1)

loc_015ee2:
	adda.l #4,a5
	cmpi.l #0,(a5)
	beq.b loc_015f02
	jsr loc_01606c(pc)
	nop
	move.w d6,($d8,a1)
	move.w d7,($da,a1)
	or.w d6,d7
	bne.b loc_015f1e

loc_015f02:
	adda.l #4,a5
	cmpi.l #0,(a5)
	beq.b loc_015f1e
	jsr loc_01606c(pc)
	nop
	move.w d6,($d8,a1)
	move.w d7,($da,a1)

loc_015f1e:
	movea.l a3,a5
	adda.l #$14,a5
	cmpi.l #0,(a5)
	beq.b loc_015f3c
	jsr loc_01606c(pc)
	nop
	move.w d6,($dc,a1)
	move.w d7,($de,a1)

loc_015f3c:
	adda.l #4,a5
	cmpi.l #0,(a5)
	beq.b loc_015f5c
	jsr loc_01606c(pc)
	nop
	move.w d6,($e0,a1)
	move.w d7,($e2,a1)
	or.w d6,d7
	bne.b loc_015f78

loc_015f5c:
	adda.l #4,a5
	cmpi.l #0,(a5)
	beq.b loc_015f78
	jsr loc_01606c(pc)
	nop
	move.w d6,($e0,a1)
	move.w d7,($e2,a1)

loc_015f78:
	movea.l a3,a5
	adda.l #$20,a5
	cmpi.l #0,(a5)
	beq.b loc_015f96
	jsr loc_01606c(pc)
	nop
	move.w d6,($e4,a1)
	move.w d7,($e6,a1)

loc_015f96:
	rts

;##############################################################################
loc_015f98:
	movea.l a3,a5
	adda.l #8,a5
	cmpi.l #0,(a5)
	beq.b loc_015fb6
	jsr loc_0160ba(pc)
	nop
	move.w d6,($d4,a1)
	move.w d7,($d6,a1)

loc_015fb6:
	adda.l #4,a5
	cmpi.l #0,(a5)
	beq.b loc_015fd6
	jsr loc_0160ba(pc)
	nop
	move.w d6,($d8,a1)
	move.w d7,($da,a1)
	or.w d6,d7
	bne.b loc_015ff2

loc_015fd6:
	adda.l #4,a5
	cmpi.l #0,(a5)
	beq.b loc_015ff2
	jsr loc_0160ba(pc)
	nop
	move.w d6,($d8,a1)
	move.w d7,($da,a1)

loc_015ff2:
	movea.l a3,a5
	adda.l #$14,a5
	cmpi.l #0,(a5)
	beq.b loc_016010
	jsr loc_0160ba(pc)
	nop
	move.w d6,($dc,a1)
	move.w d7,($de,a1)

loc_016010:
	adda.l #4,a5
	cmpi.l #0,(a5)
	beq.b loc_016030
	jsr loc_0160ba(pc)
	nop
	move.w d6,($e0,a1)
	move.w d7,($e2,a1)
	or.w d6,d7
	bne.b loc_01604c

loc_016030:
	adda.l #4,a5
	cmpi.l #0,(a5)
	beq.b loc_01604c
	jsr loc_0160ba(pc)
	nop
	move.w d6,($e0,a1)
	move.w d7,($e2,a1)

loc_01604c:
	movea.l a3,a5
	adda.l #$20,a5
	cmpi.l #0,(a5)
	beq.b loc_01606a
	jsr loc_0160ba(pc)
	nop
	move.w d6,($e4,a1)
	move.w d7,($e6,a1)

loc_01606a:
	rts

;##############################################################################
loc_01606c:
	lea.l $10668c,a6
	move.w ($c0,a0),(a6)
	move.w ($c0,a1),(2,a6)
	move.w ($c4,a0),(4,a6)
	move.w ($c4,a1),(6,a6)
	move.b ($21,a0),(8,a6)
	move.b ($21,a1),(9,a6)
	move.b ($be,a0),($a,a6)
	move.b ($bf,a1),($b,a6)
	moveq #0,d4
	move.b ($14f,a0),d4
	jsr loc_01612a(pc)
	nop
	move.b ($a,a6),($be,a0)
	move.b ($b,a6),($bf,a1)
	rts

;##############################################################################
loc_0160ba:
	lea.l $10668c,a6
	move.w ($10,a0),(a6)
	move.w ($c0,a1),(2,a6)
	move.w ($14,a0),(4,a6)
	move.w ($c4,a1),(6,a6)
	move.b ($d,a0),(8,a6)
	move.b ($21,a1),(9,a6)
	move.b ($bf,a1),($b,a6)
	moveq #0,d4
	jsr loc_01612a(pc)
	nop
	move.b ($b,a6),($bf,a1)
	rts

;##############################################################################
loc_0160f8:
	lea.l $10668c,a6
	move.w ($10,a0),(a6)
	move.w ($10,a1),(2,a6)
	move.w ($14,a0),(4,a6)
	move.w ($14,a1),(6,a6)
	move.b ($d,a0),(8,a6)
	move.b ($d,a1),(9,a6)
	moveq #0,d4
	jsr loc_01612a(pc)
	nop
	rts

;##############################################################################
loc_01612a:
	move.w (a6),d0
	move.b (a4),d2
	lsl.w #8,d2
	asr.w #8,d2
	btst #0,(8,a6)
	beq.b loc_01613c
	neg.w d2

loc_01613c:
	add.w d2,d0
	move.w (2,a6),d1
	move.b (a5),d2
	lsl.w #8,d2
	asr.w #8,d2
	btst #0,(9,a6)
	beq.b loc_016152
	neg.w d2

loc_016152:
	add.w d2,d1
	cmp.w d0,d1
	bgt.w loc_016164
	blt.w loc_0161a2
	move.w d0,d6
	bra.w loc_0161de

loc_016164:
	moveq #0,d2
	move.b (2,a4),d2
	add.w d0,d2
	add.w d4,d2
	moveq #0,d3
	move.b (2,a5),d3
	neg.w d3
	add.w d1,d3
	cmp.w d3,d2
	blt.w loc_01628c
	cmp.w d1,d2
	blt.b loc_016192
	cmp.w d0,d3
	bgt.b loc_01618e
	move.w d0,d6
	add.w d1,d6
	asr.w #1,d6
	bra.b loc_0161de

loc_01618e:
	move.w d1,d6
	bra.b loc_0161de

loc_016192:
	cmp.w d0,d3
	bgt.b loc_01619a
	move.w d0,d6
	bra.b loc_0161de

loc_01619a:
	move.w d2,d6
	add.w d3,d6
	asr.w #1,d6
	bra.b loc_0161de

loc_0161a2:
	moveq #0,d2
	move.b (2,a4),d2
	neg.w d2
	add.w d0,d2
	sub.w d4,d2
	moveq #0,d3
	move.b (2,a5),d3
	add.w d1,d3
	cmp.w d2,d3
	blt.w loc_01628c
	cmp.w d1,d2
	bgt.b loc_0161d0
	cmp.w d0,d3
	blt.b loc_0161cc
	move.w d0,d6
	add.w d1,d6
	asr.w #1,d6
	bra.b loc_0161de

loc_0161cc:
	move.w d1,d6
	bra.b loc_0161de

loc_0161d0:
	cmp.w d0,d3
	blt.b loc_0161d8
	move.w d0,d6
	bra.b loc_0161de

loc_0161d8:
	move.w d2,d6
	add.w d3,d6
	asr.w #1,d6

loc_0161de:
	move.w (4,a6),d0
	move.b (1,a4),d2
	lsl.w #8,d2
	asr.w #8,d2
	neg.w d2
	add.w d2,d0
	move.w (6,a6),d1
	move.b (1,a5),d2
	lsl.w #8,d2
	asr.w #8,d2
	neg.w d2
	add.w d2,d1
	cmp.w d0,d1
	blt.w loc_01620c
	bgt.w loc_016246
	move.w d0,d7
	bra.b loc_01627e

loc_01620c:
	moveq #0,d2
	move.b (3,a4),d2
	neg.w d2
	add.w d0,d2
	moveq #0,d3
	move.b (3,a5),d3
	add.w d1,d3
	cmp.w d2,d3
	blt.b loc_01628c
	cmp.w d1,d2
	bgt.b loc_016236
	cmp.w d0,d3
	blt.b loc_016232
	move.w d0,d7
	add.w d1,d7
	asr.w #1,d7
	bra.b loc_01627e

loc_016232:
	move.w d1,d7
	bra.b loc_01627e

loc_016236:
	cmp.w d0,d3
	blt.b loc_01623e
	move.w d0,d7
	bra.b loc_01627e

loc_01623e:
	move.w d2,d7
	add.w d3,d7
	asr.w #1,d7
	bra.b loc_01627e

loc_016246:
	moveq #0,d2
	move.b (3,a4),d2
	add.w d0,d2
	moveq #0,d3
	move.b (3,a5),d3
	neg.w d3
	add.w d1,d3
	cmp.w d3,d2
	blt.b loc_01628c
	cmp.w d1,d2
	blt.b loc_016270
	cmp.w d0,d3
	bgt.b loc_01626c
	move.w d0,d7
	add.w d1,d7
	asr.w #1,d7
	bra.b loc_01627e

loc_01626c:
	move.w d1,d7
	bra.b loc_01627e

loc_016270:
	cmp.w d0,d3
	bgt.b loc_016278
	move.w d0,d7
	bra.b loc_01627e

loc_016278:
	move.w d2,d7
	add.w d3,d7
	asr.w #1,d7

loc_01627e:
	bset #5,($a,a6)
	bset #7,($b,a6)
	bra.b loc_016290

loc_01628c:
	moveq #0,d6
	moveq #0,d7

loc_016290:
	rts

;##############################################################################
loc_016292:;00
	jsr RaySpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_0162a0:;01
	jsr FeilinSpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_0162ae:;02
	jsr RyokoSpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_0162bc:;03
	jsr MatlokSpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_0162ca:;04
	jsr SamchaySpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_0162d8:
	jsr LeeSpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_0162e6:
	jsr MizoguchiSpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_0162f4:
	jsr JeanSpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_016302:
	jsr MarstoriusSpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_016310:
	jsr YungmieSpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_01631e:
	jsr ZazieSpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_01632c:
	jsr ClownSpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_01633a:
	jsr KarnovSpecial
	jsr loc_016366(pc)
	nop
	rts

;##############################################################################
loc_016348:
	jsr loc_016366(pc)
	nop
	cmpi.w #$29b,($d0,a0)
	bne.b loc_016364
	btst #0,($bf,a0)
	bne.b loc_016364
	move.b #$ac,($12d,a0)

loc_016364:
	rts

;##############################################################################
loc_016366:
	move.b ($b0,a0),d0
	andi.b #$f0,d0
	beq.w loc_0163c6
	cmpi.b #0,($14d,a0)
	bne.w loc_0163c6
	move.b ($b0,a0),d2
	jsr loc_0163c8(pc)
	nop
	cmpi.w #5,($d0,a0)
	bls.w loc_0163b8
	cmpi.w #$20,($d0,a0)
	bcs.w loc_0163c6
	btst #0,($bf,a0)
	beq.b loc_0163c6
	movea.l ($14,a0),a1
	cmpi.b #0,($14c,a1)
	bne.w loc_0163c6
	btst #2,($12b,a0)
	beq.b loc_0163c6

loc_0163b8:;Attack write?
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)
	clr.b ($12d,a0)

loc_0163c6:
	rts

;##############################################################################
loc_0163c8:
	moveq #0,d7
	move.b (1,a0),d7
	move.w d7,d0
	lsl.w #5,d7
	lsl.w #4,d0
	add.w d0,d7
	addi.w #$20,d7
	btst #3,($bf,a0)
	beq.b loc_0163f6
	addi.w #$c,d7
	move.w ($d0,a0),d0
	cmpi.w #2,d0
	beq.b loc_016438
	addi.w #4,d7
	bra.b loc_016438

loc_0163f6:
	btst #1,($30,a0)
	beq.b loc_016404
	addi.w #8,d7
	bra.b loc_016438

loc_016404:
	moveq #0,d0
	move.b ($b0,a0),d0
	lsr.b #4,d0
	lea.l loc_016488(pc),a6
	nop
	move.b (a6,d0.w),d0
	lea.l loc_016498(pc),a6
	nop
	moveq #0,d1
	move.b (1,a0),d1
	lsl.b #2,d1
	adda.l d1,a6
	move.b (a6,d0.w),d0
	moveq #$10,d1
	lsl.l d1,d0
	cmp.l ($100,a0),d0
	bcc.b loc_016438
	addi.w #4,d7

loc_016438:
	lsr.b #4,d2
	andi.w #$f,d2
	lea.l loc_016488(pc),a6
	nop
	move.b (a6,d2.w),d2
	add.w d2,d7
	rts

;##############################################################################
loc_01644c:
	move.b ($b0,a0),d2
	jsr loc_0163c8(pc)

loc_016454:
	cmpi.w #0,($138,a0)
	ble.b loc_016462
	move.w ($130,a0),d0
	bra.b loc_016466

loc_016462:
	move.w ($132,a0),d0

loc_016466:
	btst #0,($21,a0)
	beq.b loc_016470
	neg.w d0

loc_016470:
	moveq #$10,d1
	lsl.l d1,d0
	asr.l #8,d0
	move.l d0,($c8,a0)
	move.w ($138,a0),d0
	lsl.l d1,d0
	asr.l #8,d0
	move.l d0,($cc,a0)
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_016488:
	dc.w $0000,$0100,$0200,$0200
	dc.w $0300,$0100,$0200,$0200

loc_016498:
	dc.w $303c,$2838,$223c,$3830
	dc.w $2440,$3038,$2838,$2830
	dc.w $3838,$4030,$2830,$3030
	dc.w $3038,$3030,$3040,$3034
	dc.w $3830,$3030,$3040,$3030
	dc.w $3040,$3030,$3040,$5030
	dc.w $3030,$302c,$3040,$3030

loc_0164d0:
	dc.l INPUT_236,INPUT_66,INPUT_214,loc_0165ec
	dc.l INPUT_236,INPUT2_236,INPUT_412,loc_0165f7
	dc.l loc_0165fa,INPUT_236,loc_0165fe,loc_016602
	dc.l loc_016606,loc_01660a,loc_01660d,loc_016611
	dc.l loc_016614,loc_016617,INPUT_236,INPUT_236
	dc.l loc_01661a,loc_01661e,loc_016622,INPUT_236
	dc.l INPUT_236,loc_016626,loc_01662a,loc_01662e
	dc.l loc_016632,INPUT_236,loc_016637,loc_01663b
	dc.l loc_01663f,loc_016643,loc_016647,loc_01664b
	dc.l loc_01664e,loc_016651,loc_016654,INPUT_236
	dc.l loc_016658,loc_01665b,loc_01665e,loc_016661
	dc.l loc_016664,loc_016668,loc_01666c,INPUT_236
	dc.l INPUT_236,INPUT_236,loc_016670,loc_016674
	dc.l loc_016677,loc_01667b,INPUT_236,loc_016680
	dc.l loc_016683,loc_016686,loc_016689,INPUT_236
	dc.l loc_01668c,loc_016690,loc_016694,loc_016697
	dc.l INPUT_236,loc_01669c,loc_0166a1,loc_0166a3

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
INPUT_236:
	dc.b $08,$0a,$02,$ff

INPUT_66:
	dc.b $08,$00,$08,$ff

INPUT_214:
	dc.b $04,$06,$02,$ff

loc_0165ec:
	dc.b $08,$04,$ff

INPUT2_236:
	dc.b $08,$0a,$02,$ff

INPUT_412:
	dc.b $02,$06,$04,$ff

loc_0165f7:
	dc.b $01,$02,$ff

loc_0165fa:
	dc.b $09,$0a,$06,$ff

loc_0165fe:
	dc.b $04,$02,$08,$ff

loc_016602:
	dc.b $08,$02,$04,$ff

loc_016606:
	dc.b $02,$00,$02,$ff

loc_01660a:
	dc.b $08,$04,$ff

loc_01660d:
	dc.b $08,$01,$04,$ff

loc_016611:
	dc.b $08,$04,$ff

loc_016614:
	dc.b $01,$02,$ff

loc_016617:
	dc.b $08,$04,$ff

loc_01661a:
	dc.b $08,$0a,$02,$ff

loc_01661e:
	dc.b $08,$0a,$02,$ff

loc_016622:
	dc.b $0a,$06,$08,$ff

loc_016626:
	dc.b $08,$0a,$02,$ff

loc_01662a:
	dc.b $08,$0a,$02,$ff

loc_01662e:
	dc.b $08,$00,$08,$ff

loc_016632:
	dc.b $0a,$06,$08,$04,$ff

loc_016637:
	dc.b $08,$0a,$02,$ff

loc_01663b:
	dc.b $02,$06,$04,$ff

loc_01663f:
	dc.b $08,$0a,$02,$ff

loc_016643:
	dc.b $08,$0a,$02,$ff

loc_016647:
	dc.b $0a,$02,$08,$ff

loc_01664b:
	dc.b $08,$04,$ff

loc_01664e:
	dc.b $01,$02,$ff

loc_016651:
	dc.b $04,$08,$ff

loc_016654:
	dc.b $04,$06,$02,$ff

loc_016658:
	dc.b $08,$04,$ff

loc_01665b:
	dc.b $01,$02,$ff

loc_01665e:
	dc.b $08,$04,$ff

loc_016661:
	dc.b $01,$02,$ff

loc_016664:
	dc.b $04,$01,$08,$ff

loc_016668:
	dc.b $08,$0a,$02,$ff

loc_01666c:
	dc.b $0a,$06,$08,$ff

loc_016670:
	dc.b $02,$06,$04,$ff

loc_016674:
	dc.b $02,$01,$ff

loc_016677:
	dc.b $08,$00,$08,$ff

loc_01667b:
	dc.b $04,$00,$08,$00,$ff

loc_016680:
	dc.b $08,$04,$ff

loc_016683:
	dc.b $08,$06,$ff

loc_016686:
	dc.b $01,$06,$ff

loc_016689:
	dc.b $09,$06,$ff

loc_01668c:
	dc.b $08,$0a,$02,$ff

loc_016690:
	dc.b $08,$00,$08,$ff

loc_016694:
	dc.b $08,$04,$ff

loc_016697:
	dc.b $05,$04,$02,$08,$ff

loc_01669c:
	dc.b $04,$00,$04,$00,$ff

loc_0166a1:
	dc.b $0f,$ff

loc_0166a3:
	dc.b $06,$06,$06,$06,$ff
	even

;##############################################################################
SpecialMoveInputs:
	lea.l loc_0164d0(pc),a1
	add.w d6,d6
	add.w d6,d6
	movea.l (a1,d6.w),a1
	movea.l a0,a2
	adda.l #$30,a2

loc_0166bc:
	moveq #$b,d5
	move.b (a1)+,d1
	cmpi.b #$ff,d1
	beq.b loc_0166f8

loc_0166c6:
	move.b (a2)+,d2
	btst #0,($bd,a0)
	beq.b loc_0166e8
	move.b d2,d0
	move.b d2,d3
	andi.b #3,d2
	lsl.b #1,d0
	andi.b #8,d0
	or.b d0,d2
	lsr.b #1,d3
	andi.b #4,d3
	or.b d3,d2

loc_0166e8:
	andi.b #$f,d2
	cmp.b d2,d1
	beq.b loc_0166bc
	dbra d5,loc_0166c6
	moveq #1,d6
	bra.b loc_0166fa

loc_0166f8:
	moveq #0,d6

loc_0166fa:
	rts

;##############################################################################
loc_0166fc:
	lea.l loc_0164d0(pc),a1
	move.w d6,d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a1,d0.w),a1
	movea.l a0,a2
	adda.l #$30,a2
	moveq #$b,d4
	move.b (a1)+,d1
	cmpi.b #$ff,d1
	beq.w loc_0167dc

loc_01671e:
	move.b (a2)+,d2
	btst #0,($bd,a0)
	beq.b loc_016740
	move.b d2,d0
	move.b d2,d3
	andi.b #3,d2
	lsl.b #1,d0
	andi.b #8,d0
	or.b d0,d2
	lsr.b #1,d3
	andi.b #4,d3
	or.b d3,d2

loc_016740:
	andi.b #$f,d2
	cmpi.b #$f,d2
	beq.w loc_0167de
	and.b d1,d2
	bne.b loc_01675a
	dbra d4,loc_01671e
	moveq #1,d6
	bra.w loc_0167de

loc_01675a:
	moveq #$b,d4
	move.b (a1)+,d1
	cmpi.b #$ff,d1
	beq.b loc_0167dc

loc_016764:
	move.b (a2)+,d2
	btst #0,($bd,a0)
	beq.b loc_016786
	move.b d2,d0
	move.b d2,d3
	andi.b #3,d2
	lsl.b #1,d0
	andi.b #8,d0
	or.b d0,d2
	lsr.b #1,d3
	andi.b #4,d3
	or.b d3,d2

loc_016786:
	cmpi.w #$38,d6
	bcs.b loc_016794
	cmpi.w #$3b,d6
	bcs.w loc_0167e0

loc_016794:
	andi.b #$f,d2
	and.b d1,d2
	bne.b loc_0167a4
	dbra d4,loc_016764
	moveq #1,d6
	bra.b loc_0167de

loc_0167a4:
	subq.b #1,d5
	beq.b loc_0167dc
	move.b (a2)+,d2
	btst #0,($bd,a0)
	beq.b loc_0167ca
	move.b d2,d0
	move.b d2,d3
	andi.b #3,d2
	lsl.b #1,d0
	andi.b #8,d0
	or.b d0,d2
	lsr.b #1,d3
	andi.b #4,d3
	or.b d3,d2

loc_0167ca:
	andi.b #$f,d2
	cmpi.b #$f,d2
	beq.b loc_0167dc
	and.b d1,d2
	bne.b loc_0167a4
	moveq #1,d6
	bra.b loc_0167de

loc_0167dc:
	moveq #0,d6

loc_0167de:
	rts

loc_0167e0:
	andi.b #$f,d2
	cmp.b d1,d2
	beq.b loc_0167f0
	dbra d4,loc_016764
	moveq #1,d6
	bra.b loc_01682a

loc_0167f0:
	subq.b #1,d5
	beq.b loc_016828
	move.b (a2)+,d2
	btst #0,($bd,a0)
	beq.b loc_016816
	move.b d2,d0
	move.b d2,d3
	andi.b #3,d2
	lsl.b #1,d0
	andi.b #8,d0
	or.b d0,d2
	lsr.b #1,d3
	andi.b #4,d3
	or.b d3,d2

loc_016816:
	andi.b #$f,d2
	cmpi.b #$f,d2
	beq.b loc_016828
	cmp.b d1,d2
	beq.b loc_0167f0
	moveq #1,d6
	bra.b loc_01682a

loc_016828:
	moveq #0,d6

loc_01682a:
	rts

;##############################################################################
loc_01682c:
	lea.l player2mem,a0
	lea.l player1mem,a1
	jsr loc_016924(pc)
	nop
	lea.l player1mem,a0
	lea.l player2mem,a1
	jsr loc_016924(pc)
	nop
	btst #1,($be,a0)
	beq.b loc_016864
	btst #1,($be,a1)
	bne.w loc_0168dc
	bra.b loc_01687a

loc_016864:
	btst #1,($be,a1)
	beq.w loc_0168dc
	lea.l player2mem,a0
	lea.l player1mem,a1

loc_01687a:
	lea.l loc_016a14(pc),a2
	nop
	moveq #0,d0
	move.w ($d0,a0),d0
	add.w d0,d0
	add.w d0,d0
	moveq #0,d1
	move.b (1,a2,d0.w),d1
	move.b d1,($12c,a0)
	lea.l loc_017514(pc),a2
	nop
	lsl.l #4,d1
	adda.l d1,a2
	move.w (a2),($d0,a0)
	move.b (7,a2),($12d,a0)
	bclr #0,($bf,a0)
	move.w #$12,($d0,a1)
	bclr #0,($bf,a1)
	bclr #3,($bf,a1)
	subi.l #1,($110,a0)
	lea.l loc_00b8f6,a2
	move.w ($d0,a0),d0
	lsl.w #2,d0
	movea.l (a2,d0.w),a2
	jsr (a2)
	bra.b loc_0168f6

loc_0168dc:
	btst #5,($bf,a0)
	bne.b loc_0168e8
	clr.b ($14f,a0)

loc_0168e8:
	btst #5,($bf,a1)
	bne.b loc_01690a
	clr.b ($14f,a1)
	bra.b loc_01690a

loc_0168f6:
	lea.l player1mem,a0
	lea.l player2mem,a1
	clr.b ($14f,a0)
	clr.b ($14f,a1)

loc_01690a:
	lea.l player1mem,a0
	lea.l player2mem,a1
	bclr #1,($be,a0)
	bclr #1,($be,a1)
	rts

;##############################################################################
loc_016924:
	btst #1,($be,a0)
	beq.w loc_016a12
	cmpi.b #0,($14e,a1)
	bne.w loc_016a0c
	cmpi.b #0,($14f,a0)
	beq.b loc_016950
	cmpi.w #9,($d0,a1)
	bls.b loc_016960
	cmpi.w #$11,($d0,a1)
	bcs.b loc_016984

loc_016950:
	cmpi.w #$12,($d0,a1)
	bne.b loc_016960
	cmpi.b #2,($12c,a1)
	beq.b loc_016984

loc_016960:
	cmpi.w #$20,($d0,a1)
	bcc.b loc_016984
	cmpi.w #6,($d0,a1)
	bhi.w loc_016a0c
	cmpi.w #5,($d0,a1)
	bne.b loc_016984
	cmpi.b #0,($14d,a1)
	bne.w loc_016a0c

loc_016984:
	move.b ($bf,a0),d0
	move.b ($bf,a1),d1
	eor.b d0,d1
	btst #3,d1
	bne.b loc_016a0c
	cmpi.b #0,($14f,a0)
	bne.b loc_0169ae
	move.b ($30,a0),d0
	andi.b #$c,d0
	beq.b loc_016a0c
	cmpi.b #0,($140,a0)
	beq.b loc_016a0c

loc_0169ae:
	lea.l loc_037000+$10,a4
	moveq #0,d0
	move.w ($22,a0),d0
	move.l d0,d1
	lsl.l #5,d0
	lsl.l #4,d1
	adda.l d0,a4
	adda.l d1,a4
	adda.l #$28,a4
	cmpi.l #0,(a4)
	beq.b loc_016a0c
	lea.l loc_037000+$10,a5
	moveq #0,d0
	move.w ($22,a1),d0
	move.l d0,d1
	lsl.l #5,d0
	lsl.l #4,d1
	adda.l d0,a5
	adda.l d1,a5
	adda.l #4,a5
	cmpi.l #0,(a5)
	beq.b loc_016a0c
	jsr loc_01606c
	btst #7,($bf,a1)
	beq.b loc_016a0c
	bclr #7,($bf,a1)
	bne.b loc_016a12

loc_016a0c:
	bclr #1,($be,a0)

loc_016a12:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_016a14:
	dc.w $1000,$0000,$1000,$0000,$1000,$0000,$1000,$0000
	dc.w $0000,$0000,$1000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$3403,$8000,$3403,$0000,$3403,$8000,$3403
	dc.w $0000,$3403,$8000,$2e03,$1000,$3403,$8000,$3403
	dc.w $0100,$3a03,$8100,$3403,$0100,$2d03,$9100,$3523
	dc.w $0000,$3083,$8001,$3083,$0000,$3083,$8400,$3083
	dc.w $0000,$3982,$8001,$3982,$0000,$3982,$8000,$3982
	dc.w $0200,$0000,$0200,$0000,$825c,$3102,$825f,$3264
	dc.w $825f,$3264,$f35e,$3604,$f35e,$3684,$f35e,$3684
	dc.w $f35e,$3684,$c200,$3266,$c200,$3266,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$3403,$8003,$3403,$0000,$3403,$8000,$3403
	dc.w $0000,$3403,$a003,$3403,$0000,$3403,$8000,$3403
	dc.w $0100,$3a03,$8100,$3403,$0100,$2d03,$9100,$3523
	dc.w $0000,$3083,$8000,$3083,$0000,$3083,$8000,$3083
	dc.w $0000,$3982,$8000,$3982,$0000,$3982,$8000,$3982
	dc.w $0269,$0000,$0200,$0000,$826c,$3102,$f366,$3425
	dc.w $f366,$3605,$836c,$3102,$8000,$3402,$8300,$3902
	dc.w $0300,$0080,$f366,$3604,$8300,$0080,$f366,$3604
	dc.w $8300,$0080,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0004,$3401,$8004,$3402,$0000,$3403,$8000,$3403
	dc.w $0004,$3401,$8004,$2e02,$0000,$3403,$8400,$3403
	dc.w $0105,$3a01,$9105,$3422,$0100,$2d03,$9500,$3523
	dc.w $0006,$3083,$8006,$3083,$0000,$3083,$8000,$3083
	dc.w $0006,$3982,$8006,$3982,$0000,$3982,$8000,$3982
	dc.w $0100,$0000,$0100,$0000,$0286,$0000,$0300,$0000
	dc.w $0200,$0000,$0200,$0000,$0300,$0000,$0284,$0000
	dc.w $021d,$0000,$0200,$0000,$0382,$0000,$0285,$3401
	dc.w $0300,$0000,$0285,$0000,$0300,$0000,$d283,$0000
	dc.w $d383,$3502,$8105,$3403,$0287,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$3403,$8012,$3403,$0000,$3403,$8000,$3403
	dc.w $0000,$3403,$8412,$2e03,$0000,$3b03,$8100,$3403
	dc.w $0100,$3a03,$8300,$3403,$0100,$2d03,$9100,$3523
	dc.w $0000,$3083,$8000,$3083,$0000,$3083,$8000,$3083
	dc.w $0000,$3982,$8000,$3982,$0000,$3982,$8000,$3982
	dc.w $0000,$0000,$82b3,$3102,$f3b4,$3684,$f3b4,$3684
	dc.w $0000,$0000,$0000,$0000,$83b5,$3902,$93b5,$3902
	dc.w $12b6,$3602,$0a00,$0000,$92b6,$3602,$0a00,$0000
	dc.w $b2b4,$0000,$8200,$3403,$8300,$0080,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0400,$3403,$8413,$3403,$0000,$3403,$8016,$3403
	dc.w $2000,$3403,$c413,$3403,$0000,$3403,$8016,$3403
	dc.w $0500,$3a03,$8100,$3403,$0100,$2d03,$9100,$3523
	dc.w $0000,$3083,$8000,$3083,$0000,$3083,$8000,$3083
	dc.w $0000,$3982,$8000,$3982,$0000,$3982,$8000,$3982
	dc.w $8200,$0000,$8200,$0000,$8200,$0000,$8200,$0000
	dc.w $8200,$0000,$8200,$0000,$8297,$3102,$d398,$3603
	dc.w $d398,$3603,$d398,$3483,$d398,$3483,$8299,$3263
	dc.w $8299,$3263,$8013,$3403,$8016,$3403,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$3403,$8019,$3403,$0000,$3403,$8000,$3403
	dc.w $0000,$3403,$8019,$2e03,$0000,$3403,$8000,$3403
	dc.w $0100,$3a03,$8100,$3403,$0100,$2d03,$9100,$3523
	dc.w $0000,$3083,$8000,$3083,$0000,$3083,$8000,$3083
	dc.w $0000,$3982,$8000,$3982,$0000,$3982,$8000,$3982
	dc.w $0000,$0000,$82a1,$3222,$82a1,$3222,$0000,$0000
	dc.w $f3a2,$3683,$f3a2,$3683,$92a3,$3404,$0000,$0000
	dc.w $92a5,$0000,$9219,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$3403,$801a,$3403,$0400,$3403,$801b,$3403
	dc.w $0000,$3403,$c01a,$2e03,$0000,$3403,$841b,$3403
	dc.w $0100,$3a03,$8100,$3403,$0100,$2d03,$9100,$3523
	dc.w $0000,$3083,$8000,$3083,$0000,$3083,$8000,$3083
	dc.w $0000,$3982,$8000,$3982,$0000,$3982,$8000,$3982
	dc.w $0000,$0000,$0000,$0000,$8392,$3102,$f28f,$3504
	dc.w $d28f,$3504,$8200,$0000,$8690,$3602,$b290,$0000
	dc.w $b690,$0000,$b290,$0000,$b290,$0000,$8300,$0000
	dc.w $8391,$0000,$f229,$0000,$8300,$3684,$8200,$0000
	dc.w $8200,$0000,$8300,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$3403,$8022,$3403,$0000,$3403,$8022,$3403
	dc.w $0000,$3403,$d022,$3403,$0000,$3403,$8422,$3403
	dc.w $0100,$3a03,$8100,$3403,$0100,$2d03,$9100,$3523
	dc.w $0000,$3083,$8023,$3083,$0000,$3083,$8000,$3083
	dc.w $0000,$3982,$8023,$3982,$0000,$3982,$8000,$3982
	dc.w $0100,$0000,$0300,$0000,$82c9,$3102,$82ca,$2e04
	dc.w $82ca,$2e04,$d3ca,$3983,$d3ca,$3983,$0300,$3503
	dc.w $8300,$3503,$d2c1,$0000,$83c2,$0000,$8300,$0080
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0024,$3403,$8024,$3403,$0000,$3403,$8100,$3403
	dc.w $4024,$3402,$8024,$3403,$0400,$3403,$8000,$3403
	dc.w $0125,$3a02,$8125,$3403,$0100,$3403,$9100,$3523
	dc.w $0000,$3083,$8000,$3083,$0000,$3083,$8000,$3083
	dc.w $0000,$3982,$8000,$3982,$0000,$3982,$8400,$3982
	dc.w $8100,$0000,$8100,$0000,$8700,$0000,$8224,$3502
	dc.w $8224,$3502,$d36e,$3482,$0000,$0000,$d373,$3402
	dc.w $0000,$0000,$8000,$3082,$8000,$3002,$d377,$3602
	dc.w $9300,$0080,$d377,$3602,$9300,$0080,$8270,$3401
	dc.w $8300,$0000,$1228,$0000,$0211,$0000,$0300,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0400,$3403,$841c,$3403,$0000,$3403,$8000,$3403
	dc.w $0400,$3c03,$801c,$2e03,$0000,$3c03,$8400,$3403
	dc.w $0100,$3a03,$8100,$3423,$0100,$2d03,$9100,$3523
	dc.w $0000,$3083,$8000,$3083,$0000,$3083,$8000,$3083
	dc.w $0000,$3980,$8400,$3982,$0000,$3980,$8000,$3982
	dc.w $0000,$0000,$82be,$3102,$f300,$3484,$d300,$4024
	dc.w $8200,$3402,$0000,$0000,$0ab7,$4180,$0100,$0080
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$3403,$801d,$3403,$0000,$3403,$8000,$3403
	dc.w $0000,$3403,$e01d,$3403,$1000,$3423,$9000,$3f23
	dc.w $0100,$3a03,$8100,$3403,$0100,$2d03,$9100,$3523
	dc.w $0000,$3083,$8000,$3083,$0000,$3083,$8000,$3083
	dc.w $0000,$3982,$8000,$3982,$0000,$3982,$8400,$3982
	dc.w $0100,$0000,$8200,$2f02,$8200,$2f02,$d2aa,$3422
	dc.w $d2aa,$3422,$0600,$0000,$0600,$0000,$c600,$0000
	dc.w $0600,$0000,$c600,$0000,$0600,$0000,$8000,$3403
	dc.w $8000,$3422,$8000,$3422,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$3403,$801e,$3403,$0000,$3403,$8000,$3403
	dc.w $0000,$3404,$801e,$2e03,$0000,$3c03,$8500,$3403
	dc.w $0100,$3a03,$8100,$3403,$0100,$2d03,$9100,$3523
	dc.w $0000,$3083,$8000,$3083,$0000,$3083,$8000,$3083
	dc.w $0000,$3982,$8000,$3382,$0000,$3982,$8000,$3982
	dc.w $827e,$0000,$8200,$0000,$837a,$0000,$827c,$3102
	dc.w $c200,$0060,$8200,$3262,$8300,$0000,$c200,$3602
	dc.w $9200,$0000,$8300,$0080,$9200,$3602,$8300,$0080
	dc.w $9200,$3602,$8300,$0080,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$3403,$8021,$3403,$0000,$3403,$8000,$3403
	dc.w $0000,$3403,$8021,$2e03,$0000,$3403,$8400,$3403
	dc.w $0100,$3a03,$8100,$3403,$0100,$2d03,$9300,$3503
	dc.w $0000,$3003,$8000,$3083,$0000,$3083,$8000,$3083
	dc.w $0000,$3905,$8000,$3982,$0000,$3982,$8000,$3982
	dc.w $8000,$0000,$82c6,$3102,$82c6,$3102,$82c6,$3102
	dc.w $82c6,$3102,$82c6,$3102,$c300,$3344,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$02c5,$0000,$0b00,$0000
	dc.w $02c5,$0000,$0b00,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $802c,$0000,$802c,$0000,$802c,$0000,$802c,$0000
	dc.w $802c,$0000,$802c,$0000,$802c,$0000,$802c,$0000
	dc.w $802c,$0000,$802c,$0000,$802c,$0000,$821b,$0000
	dc.w $8000,$0000,$8000,$0000,$8000,$0000,$8000,$0000
	dc.w $8000,$0000,$8000,$0000,$8000,$0000,$8000,$0000
	dc.w $8000,$0000,$8200,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_017514:
	dc.w $0034,$0605,$1c2a,$d800,$05ff,$0500,$2800,$0000
	dc.w $0035,$0504,$1c2e,$d801,$04ff,$0400,$2800,$0000
	dc.w $00a6,$04ff,$1860,$c89c,$ffff,$ff00,$0000,$0000
	dc.w $0064,$0706,$0410,$f00a,$06ff,$0600,$0818,$0002
	dc.w $0094,$0504,$1c20,$e000,$04ff,$0400,$6800,$0000
	dc.w $0095,$0504,$1020,$e01a,$04ff,$0400,$7000,$0000
	dc.w $0096,$0504,$1430,$d812,$04ff,$0400,$1c00,$0000
	dc.w $0098,$ffff,$0000,$001a,$ffff,$0400,$0000,$0000
	dc.w $0099,$ff01,$0000,$001b,$01ff,$ff00,$3c08,$0000
	dc.w $009a,$01ff,$1020,$d81c,$ffff,$ff00,$0000,$0000
	dc.w $009b,$ffff,$0000,$0016,$ffff,$ff00,$0000,$0000
	dc.w $009c,$ffff,$0000,$0017,$ffff,$ff00,$0000,$0000
	dc.w $009d,$ffff,$0000,$0018,$ffff,$ff00,$0000,$0000
	dc.w $009e,$0100,$2040,$c819,$00ff,$0000,$2000,$0001
	dc.w $009f,$ff07,$0000,$0014,$07ff,$0700,$2800,$0000
	dc.w $00a0,$01ff,$1010,$e015,$ffff,$ff00,$0000,$0000
	dc.w $00a1,$ff04,$0000,$001f,$04ff,$0400,$2800,$0000
	dc.w $00a2,$01ff,$1018,$ec20,$ffff,$ff00,$0000,$0000
	dc.w $00c4,$0404,$5014,$d800,$ff05,$ff00,$0000,$0000
	dc.w $00f4,$ffff,$0000,$002a,$ffff,$ff00,$0000,$0000
	dc.w $00f5,$ff01,$0000,$002b,$01ff,$ff00,$2048,$0002
	dc.w $00f6,$0201,$4020,$d82c,$01ff,$ff00,$3c54,$0002
	dc.w $00f7,$ffff,$0000,$002d,$ffff,$ff00,$0000,$0000
	dc.w $00f8,$ff01,$0000,$002e,$01ff,$ff00,$2c44,$0002
	dc.w $00f9,$0201,$1828,$d02f,$01ff,$ff00,$2c5c,$0002
	dc.w $0124,$0404,$4810,$d800,$ffff,$ff00,$0000,$0000
	dc.w $0154,$0504,$1020,$e000,$04ff,$0400,$3400,$0000
	dc.w $0155,$0404,$4020,$d800,$ffff,$ff00,$0000,$0000
	dc.w $01e4,$0404,$4020,$d800,$ff05,$ff00,$0000,$0000
	dc.w $0214,$0605,$1838,$d800,$05ff,$0500,$3400,$0000
	dc.w $0244,$ffff,$0000,$0060,$ffff,$ff00,$0000,$0000
	dc.w $0245,$ffff,$0000,$0061,$ffff,$ff00,$f050,$0000
	dc.w $0246,$00ff,$3030,$d862,$ffff,$ff00,$1c70,$0000
	dc.w $0274,$0504,$3030,$d800,$04ff,$ff00,$2450,$0000
	dc.w $0184,$0505,$7010,$d800,$ffff,$ff00,$0000,$0000
	dc.w $0185,$0303,$00c0,$d07d,$ffff,$ff00,$0000,$0000
	dc.w $01b4,$0706,$1030,$e000,$06ff,$0600,$5000,$0000
	dc.w $01b5,$0403,$1030,$e000,$03ff,$0300,$3000,$0000
	dc.w $01c3,$ffff,$0000,$008e,$07ff,$0700,$5000,$0000
	dc.w $01c4,$0807,$1030,$e08f,$0703,$0700,$5000,$0001
	dc.w $01c6,$0d0c,$1030,$e0a1,$0cff,$0c00,$1000,$0001
	dc.w $0163,$ffff,$0000,$00a5,$ffff,$ff00,$3030,$0000
	dc.w $0164,$ff00,$0000,$00a6,$00ff,$ff00,$2060,$0002
	dc.w $0165,$00ff,$1010,$e0a7,$ffff,$ff00,$0000,$0000
	dc.w $02a4,$0202,$a040,$c000,$00ff,$ff00,$3018,$0002

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0177e4:
	dc.l loc_017c64,loc_017c64,loc_017c64,loc_017c64
	dc.l loc_017c64,loc_017c64,loc_017c64,loc_017c64
	dc.l loc_017c64,loc_017c64,loc_01804c,loc_017ec0
	dc.l loc_017ec0,loc_017ec0
	
loc_01781c:
	dc.l loc_017854,loc_0178a0,loc_0178c8,loc_0178f0
	dc.l loc_017918,loc_017944,loc_01797c,loc_0179bc
	dc.l loc_0179ec,loc_017a14,loc_017a3c,loc_017a7c
	dc.l loc_017a7c,loc_017ae4

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_017854:
	dc.w $0e37,$011c,$0e38,$0104,$0e39,$0204,$0e3a,$0104
	dc.w $0e3b,$0204,$0e3c,$0104,$0e3d,$0204,$0e3e,$0104
	dc.w $0e37,$7204,$0e3f,$0300,$0e40,$0300,$0e41,$0300
	dc.w $0e42,$0200,$e420,$0120,$0e43,$0200,$0e43,$0120
	dc.w $0e44,$0200,$0e44,$0120,$0e45,$0201

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0178a0:
	dc.w $120c,$011c,$1209,$0204,$120a,$0204,$120b,$0204
	dc.w $120c,$3204,$11d6,$0400,$11d7,$0400,$11d8,$0400
	dc.w $11d9,$0400,$11da,$0401

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0178c8:
	dc.w $1208,$011c,$1205,$0204,$1206,$0204,$1207,$0204
	dc.w $1208,$3204,$11db,$0400,$11dc,$0400,$11dd,$0400
	dc.w $11de,$0400,$11df,$0401

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0178f0:
	dc.w $0e48,$011c,$0e49,$0104,$0e46,$0104,$0e47,$0104
	dc.w $0e48,$3104,$11e5,$0400,$11e6,$0400,$11e7,$0400
	dc.w $11e8,$0400,$11e9,$0401

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_017918:
	dc.w $0e4a,$011c,$0e4b,$0204,$0e4c,$0204,$0e4d,$0204
	dc.w $0e4a,$3204,$11ea,$0400,$11eb,$0400,$11ec,$0400
	dc.w $11ed,$0400,$11ee,$0400,$11ef,$0401

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_017944:
	dc.w $0e5a,$0202,$0e5b,$011c,$0e5c,$0204,$0e5d,$0204
	dc.w $0e5e,$0204,$0e5f,$0204,$0e60,$0204,$0e61,$5204
	dc.w $11f0,$0400,$11f1,$0400,$11f2,$0400,$11f3,$0400
	dc.w $11f4,$0400,$11f5,$0401

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01797c:
	dc.w $0e63,$015c,$0e64,$0244,$0e65,$0244,$0e63,$2244
	dc.w $0e66,$0400,$0e67,$0400,$0e68,$0400,$0e69,$0400
	dc.w $0e6a,$0400,$0e6b,$0400,$120d,$0400,$120e,$0400
	dc.w $120f,$0400,$1210,$0400,$1211,$0400,$1212,$0401

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0179bc:
	dc.w $1214,$011c,$1215,$0204,$1216,$0204,$1217,$0204
	dc.w $1218,$0204,$1219,$4204,$11f6,$0400,$11f7,$0400
	dc.w $11f8,$0400,$11f9,$0400,$11fa,$0400,$11fb,$0401

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0179ec:
	dc.w $121c,$011c,$121d,$0104,$121a,$0104,$121b,$0104
	dc.w $121c,$3104,$11fc,$0400,$11fd,$0400,$11fe,$0400
	dc.w $11ff,$0400,$1200,$0401

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_017a14:
	dc.w $1221,$011c,$121e,$0104,$121f,$0104,$1220,$0104
	dc.w $1221,$3104,$11e0,$0400,$11e1,$0400,$11e2,$0400
	dc.w $11e3,$0400,$11e4,$0401

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_017a3c:
	dc.w $0e8d,$011c,$0e8c,$0204,$0e8d,$0104,$0e8e,$0104
	dc.w $0e8f,$0104,$0e90,$0204,$0e91,$0104,$0e8e,$0104
	dc.w $0e8f,$7104,$0e88,$0400,$0e89,$0300,$0e8a,$0400
	dc.w $0e8b,$0300,$0175,$0400,$0176,$0400,$0177,$0401

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_017a7c:
	dc.w $0e72,$0102,$0e73,$0102,$0e74,$0102,$0e75,$0102
	dc.w $0e76,$0112,$0e77,$0102,$0e78,$010e,$0e79,$0106
	dc.w $0e7a,$0106,$0e7b,$0106,$0e7c,$0106,$0e7d,$0106
	dc.w $0e7e,$0306,$0e7f,$0206,$0e80,$0306,$0e81,$0206
	dc.w $0e82,$0206,$0e83,$5206,$0e84,$0300,$0e85,$0100
	dc.w $0e86,$0200,$0e87,$0100,$0e88,$0200,$0e89,$0100
	dc.w $0e8a,$0200,$0e8b,$0101

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_017ae4:
	dc.w $1279,$025e,$127a,$0246,$1279,$1246,$127a,$0400
	dc.w $127b,$0400,$127c,$0400,$127d,$0400,$127e,$0400
	dc.w $127f,$0401
	
loc_017b08:
	dc.w $3240,$0000,$4000,$6000,$2638,$0000,$4000,$5c00
	dc.w $0810,$0000,$10d0,$20a0,$0840,$0000,$4000,$5800
	dc.w $4549,$0000,$4000,$7000,$163a,$163a,$4000,$5c00
	dc.w $f033,$0000,$7000,$7000,$3045,$0000,$4000,$5800
	dc.w $163e,$0000,$4000,$6000,$1848,$0000,$4000,$6000
	dc.w $3636,$3636,$2c00,$3000,$573b,$573b,$0000,$0000
	dc.w $5b1f,$5b1f,$0000,$0000,$4537,$4537,$0000,$0000

;##############################################################################
loc_017b78:
	lea.l $1064f0,a1
	movea.l a1,a2
	moveq #4,d0
	lsl.l #6,d0
	adda.l d0,a2

loc_017b86:
	btst #0,(1,a1)
	beq.b loc_017b9a
	adda.l #$40,a1
	cmpa.l a1,a2
	bls.b loc_017c02
	bra.b loc_017b86

loc_017b9a:
	move.b #1,(1,a1)
	move.b ($130,a0),(a1)
	move.b ($132,a0),($20,a1)
	move.b ($133,a0),d0
	andi.b #1,d0
	lsl.b #3,d0
	or.b d0,(1,a1)
	move.l a0,d0
	subi.l #player1mem,d0
	lsr.w #7,d0
	or.b d0,(1,a1)
	move.l ($c0,a0),($10,a1)
	move.l ($c4,a0),($14,a1)
	move.b ($21,a0),d0
	andi.b #1,d0
	bclr #0,($d,a1)
	or.b d0,($d,a1)
	move.w ($d0,a0),(2,a1)
	move.b ($140,a0),(4,a1)
	move.b ($141,a0),(5,a1)
	move.b ($142,a0),(6,a1)
	addi.b #1,($149,a0)

loc_017c02:
	rts

;##############################################################################
loc_017c04:
	lea.l $1064f0,a0
	movea.l a0,a1
	moveq #4,d0
	lsl.l #6,d0
	adda.l d0,a1
	move.w #$150,d7

loc_017c16:
	lea.l loc_0177e4(pc),a2
	btst #0,(1,a0)
	beq.b loc_017c38
	movem.l a1,-(a7)
	moveq #0,d0
	move.b (a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a2,d0.w),a2
	jsr (a2)
	movem.l (a7)+,a1

loc_017c38:
	adda.l #$40,a0
	cmpa.l a1,a0
	bcs.b loc_017c16
	movea.l $101420,a2

loc_017c48:
	move.w d7,d0
	addi.w #$8200,d0
	move.w d0,(a2)+
	move.w #0,(a2)+
	addq.w #1,d7
	cmpi.w #$162,d7
	bcs.b loc_017c48
	move.l a2,$101420
	rts

;##############################################################################
loc_017c64:
	lea.l player1mem,a1
	btst #2,(1,a0)
	beq.b loc_017c78
	adda.l #playeroffset,a1

loc_017c78:
	btst #1,(1,a0)
	bne.b loc_017cb4
	bset #1,(1,a0)
	move.b ($21,a1),d0
	andi.b #1,d0
	bclr #0,($d,a0)
	or.b d0,($d,a0)
	lea.l loc_01781c(pc),a2
	moveq #0,d0
	move.b (a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a2,d0.w),a2
	move.b (3,a2),($b,a0)
	move.b #1,($a,a0)

loc_017cb4:
	btst #7,$101001
	bne.w loc_017e96
	btst #1,($b,a0)
	beq.b loc_017d0e
	cmpi.w #$30,($d0,a1)
	bcs.w loc_017eaa
	lea.l loc_017b08(pc),a3
	moveq #0,d0
	move.b (a0),d0
	lsl.w #3,d0
	adda.l d0,a3
	move.l ($c0,a1),($10,a0)
	move.b (2,a3),d0
	lsl.w #8,d0
	asr.w #8,d0
	btst #0,($21,a1)
	beq.b loc_017cf6
	neg.w d0

loc_017cf6:
	add.w d0,($10,a0)
	move.l ($c4,a1),($14,a0)
	move.b (3,a3),d0
	lsl.w #8,d0
	asr.w #8,d0
	add.w d0,($14,a0)
	bra.b loc_017d5a

loc_017d0e:
	move.l ($18,a0),d0
	add.l d0,($10,a0)
	move.l ($1c,a0),d0
	add.l d0,($14,a0)
	btst #5,(1,a0)
	bne.w loc_017df4
	move.w $103424,d0
	addi.w #$a0,d0
	move.w ($10,a0),d1
	sub.w d1,d0
	bpl.w loc_017d3e
	neg.w d0

loc_017d3e:
	cmpi.w #$c0,d0
	bcc.w loc_017eaa
	cmpi.l #0,($14,a0)
	bge.w loc_017d5a
	clr.l ($14,a0)
	bra.w loc_017d64

loc_017d5a:
	btst #4,(1,a0)
	beq.w loc_017df4

loc_017d64:
	lea.l loc_01781c(pc),a2
	moveq #0,d0
	move.b (a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a2,d0.w),a2

loc_017d74:
	movea.l a2,a3
	moveq #0,d0
	move.b (8,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a3
	move.b (2,a3),d0
	andi.b #$f0,d0
	bne.b loc_017d9c
	btst #0,(3,a3)
	bne.b loc_017d9c
	addi.b #1,(8,a0)
	bra.b loc_017d74

loc_017d9c:
	move.l ($18,a0),d0
	move.b ($20,a0),d1
	asr.l d1,d0
	move.l d0,($18,a0)
	clr.l ($1c,a0)
	clr.b (9,a0)
	clr.b (7,a0)
	bclr #4,(1,a0)
	bset #5,(1,a0)
	bclr #0,($a,a0)
	subi.b #1,($149,a1)
	cmpi.b #6,(a0)
	bne.b loc_017df4
	moveq #2,d0
	moveq #4,d1
	jsr loc_00cbde
	move.b #$1e,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_017df4:
	jsr loc_01829e(pc)
	nop
	btst #2,($a,a0)
	bne.w loc_017eb0
	btst #5,(1,a0)
	bne.w loc_017e96
	btst #1,($a,a0)
	beq.w loc_017e96
	btst #4,($b,a0)
	beq.b loc_017e96
	bset #6,(1,a0)
	lea.l loc_017b08(pc),a3
	moveq #0,d0
	move.b (a0),d0
	lsl.w #3,d0
	adda.l d0,a3
	move.l ($c0,a1),($10,a0)
	move.b (a3),d0
	lsl.w #8,d0
	asr.w #8,d0
	btst #0,($21,a1)
	beq.b loc_017e48
	neg.w d0

loc_017e48:
	add.w d0,($10,a0)
	move.l ($c4,a1),($14,a0)
	move.b (1,a3),d0
	lsl.w #8,d0
	asr.w #8,d0
	add.w d0,($14,a0)
	adda.l #4,a3
	btst #3,(1,a0)
	beq.b loc_017e72
	adda.l #2,a3

loc_017e72:
	move.b (a3),d0
	moveq #$18,d1
	lsl.l d1,d0
	moveq #$c,d2
	asr.l d2,d0
	btst #0,($21,a1)
	beq.b loc_017e86
	neg.l d0

loc_017e86:
	move.l d0,($18,a0)
	move.b (1,a3),d0
	lsl.l d1,d0
	asr.l d2,d0
	move.l d0,($1c,a0)

loc_017e96:
	move.w ($e,a0),d4
	move.w ($10,a0),d5
	move.w ($14,a0),d6
	jsr loc_01832c(pc)
	nop
	bra.b loc_017ebe

loc_017eaa:
	subi.b #1,($149,a1)

loc_017eb0:
	movea.l a0,a2
	moveq #$f,d0

loc_017eb4:
	move.l #0,(a2)+
	dbra d0,loc_017eb4

loc_017ebe:
	rts

;##############################################################################
loc_017ec0:
	lea.l player1mem,a1
	btst #2,(1,a0)
	beq.b loc_017ed4
	adda.l #playeroffset,a1

loc_017ed4:
	btst #1,(1,a0)
	bne.b loc_017f10
	bset #1,(1,a0)
	move.b ($21,a1),d0
	andi.b #1,d0
	bclr #0,($d,a0)
	or.b d0,($d,a0)
	lea.l loc_01781c(pc),a2
	moveq #0,d0
	move.b (a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a2,d0.w),a2
	move.b (3,a2),($b,a0)
	move.b #1,($a,a0)

loc_017f10:
	btst #7,$101001
	bne.w loc_018022
	btst #1,($b,a0)
	beq.b loc_017f7a
	btst #5,(1,a0)
	bne.b loc_017f40
	cmpi.w #$30,($d0,a1)
	bcs.w loc_018036
	btst #6,($12b,a1)
	beq.w loc_017f88

loc_017f40:
	lea.l loc_017b08(pc),a3
	moveq #0,d0
	move.b (a0),d0
	lsl.w #3,d0
	adda.l d0,a3
	move.l ($c0,a1),($10,a0)
	move.b (2,a3),d0
	lsl.w #8,d0
	asr.w #8,d0
	btst #0,($21,a1)
	beq.b loc_017f64
	neg.w d0

loc_017f64:
	add.w d0,($10,a0)
	move.l ($c4,a1),($14,a0)
	move.b (3,a3),d0
	lsl.w #8,d0
	asr.w #8,d0
	add.w d0,($14,a0)

loc_017f7a:
	btst #4,(1,a0)
	beq.b loc_017fe6
	move.b #1,($121,a1)

loc_017f88:
	bset #5,(1,a0)
	lea.l loc_01781c(pc),a2
	moveq #0,d0
	move.b (a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a2,d0.w),a2

loc_017f9e:
	movea.l a2,a3
	moveq #0,d0
	move.b (8,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a3
	move.b (2,a3),d0
	andi.b #$f0,d0
	bne.b loc_017fc6
	btst #0,(3,a3)
	bne.b loc_017fc6
	addi.b #1,(8,a0)
	bra.b loc_017f9e

loc_017fc6:
	clr.b (9,a0)
	clr.b (7,a0)
	bclr #4,(1,a0)
	bset #5,(1,a0)
	bclr #0,($a,a0)
	subi.b #1,($149,a1)

loc_017fe6:
	jsr loc_01829e(pc)
	nop
	btst #2,($a,a0)
	bne.w loc_01803c
	btst #5,(1,a0)
	bne.w loc_018022
	btst #1,($a,a0)
	beq.w loc_018022
	btst #4,($b,a0)
	beq.b loc_018022
	bset #6,(1,a0)
	moveq #0,d0
	move.l d0,($18,a0)
	move.l d0,($1c,a0)

loc_018022:
	move.w ($e,a0),d4
	move.w ($10,a0),d5
	move.w ($14,a0),d6
	jsr loc_01832c(pc)
	nop
	bra.b loc_01804a

loc_018036:
	subi.b #1,($149,a1)

loc_01803c:
	movea.l a0,a2
	moveq #$f,d0

loc_018040:
	move.l #0,(a2)+
	dbra d0,loc_018040

loc_01804a:
	rts

;##############################################################################
loc_01804c:
	lea.l player1mem,a1
	btst #2,(1,a0)
	beq.b loc_018060
	adda.l #playeroffset,a1

loc_018060:
	btst #1,(1,a0)
	bne.b loc_0180c2
	bset #1,(1,a0)
	move.b ($21,a1),d0
	andi.b #1,d0
	bclr #0,($d,a0)
	or.b d0,($d,a0)
	lea.l loc_01781c(pc),a2
	moveq #0,d0
	move.b (a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a2,d0.w),a2
	move.b (3,a2),($b,a0)
	move.b #1,($a,a0)
	move.l #$fffec000,($24,a0)
	move.l #$c0000,($28,a0)
	btst #3,(1,a0)
	beq.b loc_0180c2
	move.l #$e0000,($28,a0)
	move.b #1,($21,a0)

loc_0180c2:
	btst #7,$101001
	bne.w loc_018274
	move.l ($18,a0),d0
	add.l d0,($10,a0)
	move.l ($1c,a0),d0
	add.l d0,($14,a0)
	btst #5,(1,a0)
	bne.w loc_01819c
	move.w $103424,d0
	addi.w #$a0,d0
	move.w ($10,a0),d1
	sub.w d1,d0
	bpl.w loc_0180fe
	neg.w d0

loc_0180fe:
	cmpi.w #$c0,d0
	bcc.w loc_018288
	cmpi.l #0,($14,a0)
	bge.w loc_018122
	move.l #0,($14,a0)
	move.l ($28,a0),d0
	move.l d0,($1c,a0)

loc_018122:
	move.l ($24,a0),d0
	add.l d0,($1c,a0)
	btst #4,(1,a0)
	beq.b loc_01819c
	lea.l loc_01781c(pc),a2
	moveq #0,d0
	move.b (a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a2,d0.w),a2

loc_018142:
	movea.l a2,a3
	moveq #0,d0
	move.b (8,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a3
	move.b (2,a3),d0
	andi.b #$f0,d0
	bne.b loc_01816a
	btst #0,(3,a3)
	bne.b loc_01816a
	addi.b #1,(8,a0)
	bra.b loc_018142

loc_01816a:
	move.l ($18,a0),d0
	move.b ($20,a0),d1
	asr.l d1,d0
	move.l d0,($18,a0)
	clr.l ($1c,a0)
	clr.b (9,a0)
	clr.b (7,a0)
	bclr #4,(1,a0)
	bset #5,(1,a0)
	bclr #0,($a,a0)
	subi.b #1,($149,a1)

loc_01819c:
	jsr loc_01829e(pc)
	nop
	btst #2,($a,a0)
	bne.w loc_01828e
	btst #5,(1,a0)
	bne.w loc_018274
	btst #1,($a,a0)
	beq.w loc_01823e
	btst #4,($b,a0)
	beq.b loc_01823e
	bset #6,(1,a0)
	lea.l loc_017b08(pc),a3
	moveq #0,d0
	move.b (a0),d0
	lsl.w #3,d0
	adda.l d0,a3
	move.l ($c0,a1),($10,a0)
	move.b (a3),d0
	lsl.w #8,d0
	asr.w #8,d0
	btst #0,($21,a1)
	beq.b loc_0181f0
	neg.w d0

loc_0181f0:
	add.w d0,($10,a0)
	move.l ($c4,a1),($14,a0)
	move.b (1,a3),d0
	lsl.w #8,d0
	asr.w #8,d0
	add.w d0,($14,a0)
	adda.l #4,a3
	btst #3,(1,a0)
	beq.b loc_01821a
	adda.l #2,a3

loc_01821a:
	move.b (a3),d0
	moveq #$18,d1
	lsl.l d1,d0
	moveq #$c,d2
	asr.l d2,d0
	btst #0,($21,a1)
	beq.b loc_01822e
	neg.l d0

loc_01822e:
	move.l d0,($18,a0)
	move.b (1,a3),d0
	lsl.l d1,d0
	asr.l d2,d0
	move.l d0,($1c,a0)

loc_01823e:
	subi.b #1,($21,a0)
	bcc.b loc_01824c
	move.b #1,($21,a0)

loc_01824c:
	cmpi.b #0,($21,a0)
	bne.b loc_018274
	movem.l a0-a1,-(a7)
	move.w #$7000,d0
	move.l ($10,a0),d1
	move.l ($14,a0),d2
	move.b ($d,a0),d3
	move.w (a1),d4
	jsr loc_010f40
	movem.l (a7)+,a0-a1

loc_018274:
	move.w ($e,a0),d4
	move.w ($10,a0),d5
	move.w ($14,a0),d6
	jsr loc_01832c(pc)
	nop
	bra.b loc_01829c

loc_018288:
	subi.b #1,($149,a1)

loc_01828e:
	movea.l a0,a2
	moveq #$f,d0

loc_018292:
	move.l #0,(a2)+
	dbra d0,loc_018292

loc_01829c:
	rts

;##############################################################################
loc_01829e:
	btst #0,($a,a0)
	beq.b loc_0182ac
	clr.b ($a,a0)
	bra.b loc_0182d4

loc_0182ac:
	clr.b ($a,a0)
	subi.b #1,(9,a0)
	bhi.b loc_01832a
	beq.w loc_01831c
	cmpi.b #0,(7,a0)
	beq.b loc_0182ce
	move.b (7,a0),d0
	sub.b d0,(8,a0)
	bra.b loc_0182d4

loc_0182ce:
	addi.b #1,(8,a0)

loc_0182d4:
	bset #1,($a,a0)
	lea.l loc_01781c(pc),a2
	moveq #0,d0
	move.b (a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a2,d0.w),a2
	moveq #0,d0
	move.b (8,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a2
	move.w (a2),($e,a0)
	move.b (2,a2),d0
	move.b d0,d1
	andi.b #$f,d0
	move.b d0,(9,a0)
	lsr.b #4,d1
	move.b d1,(7,a0)
	move.b (3,a2),($b,a0)
	subi.b #1,(9,a0)
	bne.b loc_01832a

loc_01831c:
	btst #0,($b,a0)
	beq.b loc_01832a
	bset #2,($a,a0)

loc_01832a:
	rts

;##############################################################################
loc_01832c:
	btst #5,($b,a0)
	bne.w loc_0183fc
	movea.l $101420,a2
	lea.l loc_090020,a3
	lsl.l #2,d4
	movea.l (a3,d4.w),a3
	move.b (1,a3),d4
	adda.l #2,a3

loc_018352:
	move.b (1,a3),d3
	andi.b #$3f,d3
	move.w d7,d0
	lsl.w #6,d0
	move.w (2,a3),d1
	move.w (4,a3),d2
	btst #0,($d,a0)
	beq.b loc_018372
	bchg #0,d2

loc_018372:
	move.w d0,(a2)+
	move.w d1,(a2)+
	addq.w #1,d0
	move.w d0,(a2)+
	move.w d2,(a2)+
	addq.w #1,d0
	addq.w #1,d1
	subq.b #1,d3
	bne.b loc_018372
	move.w d7,d0
	addi.w #$8000,d0
	move.w d0,(a2)+
	move.w #$fff,(a2)+
	move.w (6,a3),d1
	neg.w d1
	add.w d6,d1
	add.w $103428,d1
	addi.w #$110,d1
	sub.w $106928,d1
	lsl.w #7,d1
	move.b (1,a3),d0
	andi.w #$3f,d0
	or.w d0,d1
	move.w d7,d0
	addi.w #$8200,d0
	move.w d0,(a2)+
	move.w d1,(a2)+
	move.w (8,a3),d1
	lsl.w #7,d1
	asr.w #7,d1
	btst #0,($d,a0)
	beq.b loc_0183d4
	neg.w d1
	subi.w #$f,d1

loc_0183d4:
	add.w d5,d1
	sub.w $103424,d1
	lsl.w #7,d1
	move.w d7,d0
	addi.w #$8400,d0
	move.w d0,(a2)+
	move.w d1,(a2)+
	addq.l #1,d7
	adda.l #$a,a3
	subq.b #1,d4
	bne.w loc_018352
	move.l a2,$101420

loc_0183fc:
	rts

;##############################################################################
loc_0183fe:
	movea.l ($14,a0),a1
	move.b ($31,a0),d0
	andi.b #$f,d0
	move.b d0,($30,a0)
	andi.b #$f,($b0,a0)
	andi.b #$f,($b1,a0)
	btst #7,$101001
	bne.w loc_0185a2
	jsr loc_0185a4(pc)
	nop
	jsr loc_018698(pc)
	nop
	jsr loc_01897c(pc)
	nop
	btst #5,($180,a0)
	bne.w loc_018554
	move.b ($184,a0),d7
	btst #0,($183,a0)
	bne.w loc_0184da
	move.w ($d0,a0),d0
	cmpi.w #$20,d0
	bcc.w loc_018546
	cmpi.b #0,($14d,a0)
	bne.w loc_018496
	btst #4,($196,a0)
	beq.w loc_0185a2
	btst #7,($180,a0)
	bne.b loc_0184ac
	move.b ($180,a0),d0
	andi.b #$40,d0
	bne.w loc_018546
	jsr loc_018bde(pc)
	nop
	move.b ($180,a0),d0
	andi.b #$48,d0
	bne.w loc_018546

loc_018496:
	jsr loc_018e98(pc)
	nop
	jsr loc_019022(pc)
	nop
	btst #0,($180,a0)
	bne.w loc_018546

loc_0184ac:
	jsr loc_018ee0(pc)
	nop
	btst #7,($180,a0)
	bne.w loc_018546
	jsr loc_019022(pc)
	nop
	btst #0,($180,a0)
	bne.w loc_018546
	jsr loc_018d8e(pc)
	nop
	jsr loc_019022(pc)
	nop
	bra.b loc_0184f6

loc_0184da:
	btst #0,($b0,a0)
	beq.b loc_0184e6
	addq.b #1,d7
	bra.b loc_0184f4

loc_0184e6:
	btst #1,($b0,a0)
	beq.b loc_0184f6
	subq.b #1,d7
	bcc.b loc_0184f4
	moveq #0,d7

loc_0184f4:
	bra.b loc_018536

loc_0184f6:
	cmpi.b #0,($180,a0)
	bne.b loc_018546
	btst #4,($181,a0)
	bne.b loc_018546
	move.b ($184,a0),d7
	btst #0,($183,a0)
	bne.b loc_018536
	moveq #6,d7
	jsr loc_004554
	btst #1,($182,a0)
	beq.b loc_018532
	addi.b #$d,d7
	btst #2,($182,a0)
	beq.b loc_018532
	addi.b #2,d7

loc_018532:
	add.b ($190,a0),d7

loc_018536:
	moveq #0,d0
	move.l d0,($184,a0)
	move.b d7,($184,a0)
	bset #4,($181,a0)

loc_018546:
	btst #0,($180,a0)
	bne.b loc_018554
	jsr loc_019096(pc)
	nop

loc_018554:
	cmpi.b #0,($189,a0)
	beq.b loc_0185a2
	move.b #$30,d1
	moveq #0,d2
	move.b ($148,a0),d2
	cmpi.b #0,GameDifficulty
	bne.b loc_018578
	move.b #$30,d1
	addi.w #$20,d2

loc_018578:
	move.b ($189,a0),d0
	cmp.b d1,d0
	bcc.b loc_0185a2
	moveq #0,d3
	move.b ($148,a1),d3
	cmp.w d2,d3
	bcc.b loc_0185a2
	move.b ($31,a0),d0
	andi.b #$f,d0
	bne.b loc_018598
	move.b #2,d0

loc_018598:
	move.b d0,($30,a0)
	andi.w #$f0f,($b0,a0)

loc_0185a2:
	rts

;##############################################################################
loc_0185a4:
	move.w ($c0,a0),d0
	move.w ($c0,a1),d1
	sub.w d1,d0
	bpl.w loc_0185b4
	neg.w d0

loc_0185b4:
	move.w d0,($1a4,a0)
	move.w ($c4,a0),d0
	move.w ($c4,a1),d1
	sub.w d1,d0
	bpl.w loc_0185c8
	neg.w d0

loc_0185c8:
	move.w d0,($1a6,a0)
	move.w ($c0,a1),d0
	move.w ($1ac,a0),d1
	sub.w d0,d1
	btst #1,($bd,a0)
	beq.b loc_0185e0
	neg.w d1

loc_0185e0:
	move.w d1,($1ae,a0)
	move.w d0,($1ac,a0)
	cmpi.b #1,BIOS_USER_MODE
	beq.b loc_018602
	andi.b #$f9,($182,a0)
	cmpi.b #$32,fighttimer
	bcc.b loc_01861a

loc_018602:
	bset #1,($182,a0)
	cmpi.b #$14,fighttimer
	bcc.b loc_018628
	bset #2,($182,a0)
	bra.b loc_018636

loc_01861a:
	cmpi.b #$80,($148,a0)
	bcc.b loc_018636
	bset #1,($182,a0)

loc_018628:
	cmpi.b #4,($148,a0)
	bcc.b loc_018636
	bset #2,($182,a0)

loc_018636:
	subi.b #1,($18b,a0)
	bcc.b loc_018644
	move.b #0,($18b,a0)

loc_018644:
	lea.l loc_016a14,a2
	moveq #0,d1
	move.w ($d0,a1),d1
	add.w d1,d1
	add.w d1,d1
	adda.l d1,a2
	move.b (a2),d1
	move.b d1,($1a1,a0)
	move.b (3,a2),d1
	move.b d1,($1a2,a0)
	lea.l loc_016a14,a2
	moveq #0,d1
	move.w ($18c,a0),d1
	add.w d1,d1
	add.w d1,d1
	adda.l d1,a2
	move.b (3,a2),d1
	move.b d1,($1a3,a0)
	lea.l loc_016a14,a2
	moveq #0,d1
	move.w ($d0,a0),d1
	add.w d1,d1
	add.w d1,d1
	adda.l d1,a2
	move.b (a2),d1
	move.b d1,($196,a0)
	rts

;##############################################################################
;A0 = AI Player
;A1 = Opponent
;##############################################################################
loc_018698:
	btst #5,($180,a0)
	bne.b loc_018700
	cmpi.w #5,($d0,a0)
	bcs.b loc_0186b2
	cmpi.w #$20,($d0,a0)
	bcc.b loc_0186b2
	bra.b loc_0186d2

loc_0186b2:
	btst #3,($180,a0)
	beq.b loc_01870e
	cmpi.w #5,($d0,a1)
	bcs.b loc_01870e
	cmpi.w #$20,($d0,a1)
	bcc.b loc_01870e
	move.b #1,($18a,a0)
	bra.b loc_01870e
 
loc_0186d2:
	cmpi.w #$13,($d0,a0)
	bne.b loc_0186e0
	move.b #$10,($18b,a0)

loc_0186e0:
	cmpi.w #5,($d0,a0)
	bne.b loc_0186f2
	btst #2,($180,a0)
	bne.b loc_01870e
	bra.b loc_018700

loc_0186f2:
	btst #3,($180,a0)
	beq.b loc_018700
	move.b #0,($18a,a0)

loc_018700:
	move.w #0,($180,a0)
	move.l #0,($184,a0)

loc_01870e:
	btst #3,($bf,a0)
	beq.b loc_01871e
	bset #0,($182,a0)
	bra.b loc_018734

loc_01871e:
	bclr #0,($182,a0)
	beq.b loc_018734
	bclr #1,($180,a0)
	beq.b loc_018734
	moveq #0,d0
	move.w d0,($180,a0)

loc_018734:
	cmpi.w #$3c,($1a4,a0)
	bcc.w loc_018766
	cmpi.w #$20,($d0,a0)
	bcc.b loc_018766
	cmpi.w #5,($d0,a0)
	bcc.b loc_018756
	btst #3,($bf,a0)
	bne.b loc_018766

loc_018756:
	addi.b #1,($188,a0)
	bcc.b loc_01876c
	move.b #$ff,($188,a0)
	bra.b loc_01876c

loc_018766:
	move.b #0,($188,a0)

loc_01876c:
	bclr #5,($180,a0)
	btst #2,($bf,a1)
	beq.b loc_0187e6
	move.w #0,($180,a0)
	bset #5,($180,a0)
	move.b #0,($30,a0)
	move.w ($1a4,a0),d0
	cmpi.w #$58,d0
	bcc.b loc_0187b0
	move.l #$4000004,($30,a0)
	btst #0,($bd,a0)
	beq.b loc_0187e6
	move.l #$8000008,($30,a0)
	bra.b loc_0187e6

loc_0187b0:
	cmpi.w #$74,d0
	bcc.b loc_0187cc
	move.b #4,($30,a0)
	btst #0,($bd,a0)
	beq.b loc_0187e6
	move.b #8,($30,a0)
	bra.b loc_0187e6

loc_0187cc:
	cmpi.w #$c0,d0
	bcs.b loc_0187e6
	move.b #9,($30,a0)
	btst #0,($bd,a0)
	beq.b loc_0187e6
	move.b #5,($30,a0)

loc_0187e6:;18c7c
	jsr loc_019302(pc)
	nop
	addi.b #$40,d0
	cmpi.b #$40,d0
	beq.b loc_018800
	move.b GameDifficulty,d1
	subq.b #1,d1
	add.b d1,d0

loc_018800:
	cmpi.b #0,(7,a1)
	beq.b loc_01880a
	addq.b #2,d0

loc_01880a:
	cmpi.b #0,(7,a0)
	beq.b loc_01881e
	subq.b #1,d0
	cmpi.b #0,(7,a1)
	bne.b loc_01881e
	subq.b #1,d0

loc_01881e:
	bclr #3,($182,a0)
	move.b ($147,a0),d1
	move.b ($147,a1),d2
	andi.w #$c0,d1
	andi.w #$c0,d2
	sub.w d1,d2
	bcc.b loc_01883e
	bset #3,($182,a0)

loc_01883e:
	asr.l #6,d2
	add.b d2,d0
	subi.b #$40,d0
	bcc.b loc_01884c
	moveq #0,d0
	bra.b loc_018854

loc_01884c:
	cmpi.b #8,d0
	bcs.b loc_018854
	moveq #7,d0

loc_018854:;18d00
	move.b d0,($190,a0)
	cmpi.b #0,($189,a0)
	bne.b loc_0188ae
	cmpi.b #1,BIOS_USER_MODE
	beq.b loc_0188b4
	move.w #$80,d7
	jsr loc_004554
	moveq #8,d0
	moveq #0,d1
	move.b ($190,a0),d1
	sub.b d1,d0
	add.b d0,d0
	cmp.b d0,d7
	bcc.b loc_0188b4
	move.b GameDifficulty,d0
	cmpi.b #0,d0
	bne.b loc_018896
	addi.b #$10,d1
	bra.b loc_01889e

loc_018896:
	cmpi.b #3,d0
	bcc.b loc_01889e
	addq.b #8,d1

loc_01889e:
	lea.l loc_018964(pc),a2
	nop
	move.b (a2,d1.w),d1
	move.b d1,($189,a0)
	bra.b loc_0188b4

loc_0188ae:
	subi.b #1,($189,a0)

loc_0188b4:
	move.w ($d0,a0),d0
	cmpi.w #6,d0
	beq.b loc_0188f0
	cmpi.w #$12,d0
	beq.b loc_0188f0
	move.w ($d0,a1),d0
	cmpi.w #$12,d0
	bne.b loc_018916
	btst #3,($142,a0)
	beq.b loc_018916
	move.w #$10,d7
	jsr loc_004554
	move.b ($190,a0),d0
	cmp.b d0,d7
	bcc.b loc_018916
	move.b #2,($b0,a0)
	bra.b loc_018916

loc_0188f0:
	move.w #$c0,d7
	jsr loc_004554
	move.b ($190,a0),d0
	cmp.b d0,d7
	bcc.b loc_018916
	btst #3,($142,a1)
	beq.b loc_018910
	subi.w #$40,($138,a1)

loc_018910:
	move.b #2,($b0,a0)

loc_018916:
	move.w ($d0,a0),d0
	move.w d0,($194,a0)
	btst #3,($bf,a1)
	bne.b loc_01894e
	btst #5,($1a0,a0)
	beq.b loc_01894e
	cmpi.w #$3c,($1a4,a0)
	bcc.b loc_01894e
	move.w ($d0,a1),d0
	addi.w #1,d0
	bclr #0,d0
	cmpi.w #$126,d0
	beq.b loc_01894e
	move.b #$40,($188,a0)

loc_01894e:
	bclr #5,($1a0,a0)
	btst #3,($bf,a1)
	beq.b loc_018962
	bset #5,($1a0,a0)

loc_018962:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_018964:
	dc.w $8030,$1408,$0604,$0201
	dc.w $8030,$2c28,$2018,$100c
	dc.w $8048,$4440,$3c38,$3430

;##############################################################################
loc_01897c:
	bclr #3,($1a0,a0)
	moveq #0,d0
	move.w ($22,a1),d0
	move.l d0,d1
	lsl.l #5,d0
	lsl.l #4,d1
	lea.l loc_037000+$10,a2
	adda.l d0,a2
	adda.l d1,a2
	cmpi.l #0,($24,a2)
	beq.b loc_0189a8
	bset #3,($1a0,a0)

loc_0189a8:
	bclr #0,($1a0,a0)
	move.w ($d0,a1),d7
	cmpi.w #$20,d7
	bcs.b loc_0189d6
	btst #1,($12b,a1)
	beq.b loc_0189d0
	btst #3,($1a0,a0)
	beq.b loc_0189d6
	btst #5,($bf,a1)
	bne.b loc_0189d6

loc_0189d0:
	bset #0,($1a0,a0)

loc_0189d6:
	bclr #1,($1a0,a0)
	lea.l $1064f0,a2
	movea.l a2,a3
	moveq #4,d0
	lsl.l #6,d0
	adda.l d0,a3

loc_0189ea:
	btst #0,(1,a2)
	beq.w loc_018ab6
	btst #5,(1,a2)
	bne.w loc_018ab6
	movea.l a0,a4
	btst #2,(1,a2)
	bne.b loc_018a14
	cmpa.l #player1mem,a0
	beq.w loc_018ab6
	bra.b loc_018a1e

loc_018a14:
	cmpa.l #player1mem,a0
	bne.w loc_018ab6

loc_018a1e:
	move.w (a2),($1b0,a0)
	move.w ($10,a2),d0
	move.w ($c0,a0),d1
	sub.w d1,d0
	bpl.w loc_018a32
	neg.w d0

loc_018a32:
	move.w d0,($1b2,a0)
	move.w ($14,a2),d0
	move.w ($c4,a0),d1
	sub.w d1,d0
	bpl.w loc_018a46
	neg.w d0

loc_018a46:
	move.w d0,($1b4,a0)
	move.l ($18,a2),d0
	move.w ($10,a2),d1
	move.w ($c0,a0),d2
	cmp.w d2,d1
	bcc.b loc_018a5c
	neg.l d0

loc_018a5c:
	cmpi.l #0,d0
	ble.b loc_018a6e
	cmpi.w #$1c,($1b2,a0)
	bcc.b loc_018ab6
	bra.b loc_018a9e

loc_018a6e:
	lea.l loc_015cf2,a3
	moveq #0,d1
	move.b ($1b0,a0),d1
	lsl.w #3,d1
	adda.l d1,a3
	moveq #0,d1
	move.b (a3),d1
	asl.w #8,d1
	asr.w #8,d1
	sub.w d1,($1b2,a0)
	moveq #0,d1
	move.b (2,a3),d1
	asl.w #8,d1
	asr.w #8,d1
	sub.w d1,($1b2,a0)
	subi.w #$1c,($1b2,a0)

loc_018a9e:
	asr.l #8,d0
	move.w d0,($1b6,a0)
	move.l ($14,a2),d0
	asr.l #8,d0
	move.w d0,($1b8,a0)
	bset #1,($1a0,a0)
	bra.b loc_018ac2

loc_018ab6:
	adda.l #$40,a2
	cmpa.l a3,a2
	bcs.w loc_0189ea

loc_018ac2:
	bclr #2,($1a0,a0)
	move.l ($c4,a1),d0
	cmp.l ($1a8,a0),d0
	bcc.b loc_018ad8
	bset #2,($1a0,a0)

loc_018ad8:
	move.l d0,($1a8,a0)
	btst #3,($bf,a1)
	bne.b loc_018b2e
	bclr #2,($181,a0)
	bclr #2,($180,a0)
	beq.b loc_018b2e
	lea.l loc_000718,a2
	moveq #0,d0
	move.b (1,a0),d0
	add.b d0,d0
	add.b d0,d0
	movea.l (a2,d0.w),a2
	moveq #0,d0
	move.b ($184,a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a2,d0.w),a2
	moveq #0,d0
	move.b ($185,a0),d0
	adda.l d0,a2
	lsl.l #3,d0
	adda.l d0,a2
	cmpi.b #0,(7,a2)
	beq.b loc_018b2e
	moveq #0,d0
	move.w d0,($180,a0)

loc_018b2e:
	lea.l loc_016a14,a2
	moveq #0,d1
	move.w ($d0,a1),d1
	add.w d1,d1
	add.w d1,d1
	adda.l d1,a2
	move.w ($d0,a1),d0
	cmpi.w #$20,d0
	bcc.b loc_018b50
	move.w d0,($18e,a0)
	bra.b loc_018bb2

loc_018b50:
	move.b (2,a2),d1
	cmpi.b #0,d1
	beq.b loc_018bb2
	btst #3,($1a0,a0)
	bne.b loc_018b6a
	bclr #4,($1a0,a0)
	bra.b loc_018b86

loc_018b6a:
	btst #4,($1a0,a0)
	bne.b loc_018b86
	bset #4,($1a0,a0)
	move.w ($d0,a1),d0
	move.w ($18c,a0),d1
	cmp.w d0,d1
	beq.b loc_018b9a
	bra.b loc_018ba2

loc_018b86:
	move.w ($d0,a1),d0
	cmp.w ($18e,a0),d0
	beq.b loc_018bb2
	move.w d0,($18e,a0)
	cmp.w ($18c,a0),d0
	bne.b loc_018ba2

loc_018b9a:
	addi.b #1,($18a,a0)
	bra.b loc_018bb2

loc_018ba2:
	move.b #0,($18a,a0)
	move.w d0,($18c,a0)
	bclr #3,($180,a0)

loc_018bb2:
	bclr #6,($1a0,a0)
	btst #0,($1a0,a0)
	beq.b loc_018bdc
	btst #4,($1a1,a0)
	beq.b loc_018bdc
	btst #3,($bf,a0)
	bne.b loc_018bdc
	bset #6,($1a0,a0)
	move.w #0,($180,a0)

loc_018bdc:
	rts

;##############################################################################
loc_018bde:
	cmpi.b #$10,($189,a0)
	bcc.w loc_018d8c
	move.b ($180,a0),d0
	andi.b #$f3,d0
	bne.w loc_018d8c
	btst #6,($1a0,a0)
	bne.w loc_018ede
	btst #3,($bf,a0)
	bne.w loc_018d8c
	cmpi.w #6,($d0,a1)
	bne.b loc_018c42
	move.b #$40,($180,a0)
	move.b #$2b,($184,a0)
	cmpi.b #0,(7,a0)
	beq.w loc_018d6e
	cmpi.b #0,(7,a1)
	beq.b loc_018c38
	cmpi.b #6,($190,a0)
	bcc.w loc_018d6e

loc_018c38:
	subi.b #1,($184,a0)
	bra.w loc_018d6e

loc_018c42:
	btst #3,($bf,a1)
	bne.w loc_018c7c
	cmpi.b #0,($14e,a1)
	bne.b loc_018c7c
	moveq #$40,d0
	move.b ($190,a0),d1
	add.b d1,d1
	add.b d1,d1
	sub.b d1,d0
	btst #1,($182,a0)
	beq.b loc_018c6c
	subi.b #$20,d0

loc_018c6c:
	cmp.b ($188,a0),d0
	bcc.b loc_018c7c
	move.b #$2c,($184,a0)
	bra.w loc_018d68

loc_018c7c:
	btst #3,($180,a0)
	beq.b loc_018cc4
	btst #5,($1a3,a0)
	beq.b loc_018c9a
	move.w ($18c,a0),d0
	move.w ($d0,a1),d1
	cmp.w d0,d1
	bne.w loc_018d7e

loc_018c9a:
	move.b ($184,a0),d0
	cmpi.b #$30,d0
	beq.b loc_018cb8
	cmpi.b #$39,d0
	bne.w loc_018d8c
	cmpi.w #0,($1ae,a0)
	ble.b loc_018cc4
	bra.w loc_018d8c

loc_018cb8:
	cmpi.w #0,($1ae,a0)
	bgt.b loc_018cc4
	bra.w loc_018d8c

loc_018cc4:
	move.b ($1a3,a0),d0
	andi.b #7,d0
	move.b ($18a,a0),d1
	cmp.b d0,d1
	bcs.w loc_018d8c
	btst #5,($1a3,a0)
	beq.b loc_018d00
	cmpi.b #0,($14d,a0)
	bne.w loc_018d8c
	btst #4,($196,a0)
	beq.w loc_018d8c
	move.w ($d0,a1),d0
	move.w ($18c,a0),d1
	cmp.w d0,d1
	bne.w loc_018d8c

loc_018d00:
	btst #6,($1a3,a0)
	beq.b loc_018d10
	cmpi.w #$50,($1a4,a0)
	bcs.b loc_018d8c

loc_018d10:
	moveq #0,d7
	move.b #$d,d7
	btst #1,($182,a0)
	beq.b loc_018d20
	subq.b #2,d7

loc_018d20:
	moveq #0,d0
	move.b ($190,a0),d0
	sub.l d0,d7
	jsr loc_004554
	cmp.b ($18a,a0),d7
	bhi.b loc_018d8c
	bset #3,($180,a0)
	moveq #0,d0
	move.w ($18c,a0),d0
	lea.l loc_016a14,a2
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a2
	move.b (2,a2),d0
	move.b d0,($184,a0)
	cmpi.b #$39,d0
	bne.b loc_018d68
	cmpi.w #0,($1ae,a0)
	bgt.b loc_018d68
	move.b #$30,($184,a0)

loc_018d68:
	move.b #8,($180,a0)

loc_018d6e:
	bset #3,($181,a0)
	andi.l #$ff000000,($184,a0)
	bra.b loc_018d8c

loc_018d7e:
	move.w #0,($180,a0)
	move.l #0,($184,a0)

loc_018d8c:
	rts

;##############################################################################
loc_018d8e:
	btst #3,($bf,a1)
	beq.w loc_018e96
	cmpi.w #$69,($d0,a1)
	bne.b loc_018db2
	btst #2,($180,a0)
	bne.w loc_018e96
	move.b #$34,d7
	bra.w loc_018e70

loc_018db2:
	btst #7,($1a2,a0)
	beq.b loc_018df0
	btst #0,($1a0,a0)
	bne.b loc_018df0
	btst #3,($12b,a1)
	beq.b loc_018dd2
	btst #5,($be,a1)
	bne.b loc_018df0

loc_018dd2:
	cmpi.b #$3d,($184,a0)
	beq.w loc_018e96
	move.b #$3d,d7
	cmpi.b #8,(1,a1)
	bne.w loc_018e70
	addq.b #1,d7
	bra.w loc_018e70

loc_018df0:
	btst #2,($180,a0)
	bne.w loc_018e96
	cmpi.w #$30,($1a6,a0)
	bcs.w loc_018e96
	cmpi.w #$88,($1a4,a0)
	bcc.w loc_018e96
	btst #0,($1a0,a0)
	bne.b loc_018e22
	btst #2,($1a0,a0)
	beq.b loc_018e96
	moveq #8,d7
	bra.b loc_018e58

loc_018e22:
	btst #2,($1a0,a0)
	bne.b loc_018e34
	btst #0,($140,a1)
	beq.b loc_018e34
	bra.b loc_018e8a

loc_018e34:
	btst #6,($1a0,a0)
	bne.w loc_018e8a
	moveq #8,d7
	move.b #0,d0
	move.b ($18b,a0),d0
	cmpi.b #0,d0
	beq.b loc_018e58
	add.b d0,d7
	cmpi.b #$40,($147,a0)
	bcs.b loc_018e8a

loc_018e58:
	jsr loc_004554
	cmpi.b #4,d7
	bcc.b loc_018e8a
	addi.b #$1c,d7
	move.b ($190,a0),d0
	lsr.b #1,d0
	add.b d0,d7

loc_018e70:
	move.b d7,($184,a0)
	bset #2,($180,a0)
	bset #4,($181,a0)
	andi.l #$ff000000,($184,a0)
	bra.b loc_018e96

loc_018e8a:
	bset #0,($181,a0)
	bset #2,($180,a0)

loc_018e96:
	rts

;##############################################################################
loc_018e98:
	btst #0,($1a0,a0)
	beq.b loc_018ed2
	btst #0,($180,a0)
	bne.b loc_018eca
	cmpi.w #$88,($1a4,a0)
	bcc.b loc_018ed2
	cmpi.w #$30,($1a6,a0)
	bcc.b loc_018ed2
	btst #3,($bf,a0)
	bne.b loc_018ed2
	btst #1,($181,a0)
	bne.w loc_018ed2

loc_018eca:
	bset #0,($181,a0)
	bra.b loc_018ede

loc_018ed2:
	bclr #0,($181,a0)
	bclr #1,($181,a0)

loc_018ede:
	rts

;##############################################################################
loc_018ee0:
	btst #1,($1a0,a0)
	beq.w loc_019004
	btst #6,($1b1,a0)
	beq.w loc_019004
	btst #3,($bf,a0)
	bne.w loc_019004
	cmpi.b #2,($1b0,a0)
	bne.b loc_018f48
	cmpi.w #$60,($1b4,a0)
	bcc.w loc_018f2c
	cmpi.w #$c,($1b2,a0)
	bcs.w loc_018ff6
	cmpi.w #$20,($1b2,a0)
	bcc.w loc_018ff6
	move.b #$37,d7
	bra.w loc_018fe2

loc_018f2c:
	cmpi.w #$80,($1a4,a0)
	bcs.w loc_018ff6
	cmpi.w #$70,($1a4,a0)
	bcs.w loc_018ff6
	move.b #$38,d7
	bra.w loc_018fe2

loc_018f48:
	btst #1,($186,a0)
	beq.b loc_018f64
	cmpi.w #$10,($1b2,a0)
	bcc.w loc_019004
	move.w #1,($180,a0)
	bra.w loc_019004

loc_018f64:
	cmpi.w #$4b,($1b4,a0)
	bcs.b loc_018f76
	bset #1,($30,a0)
	bra.w loc_018ff6

loc_018f76:
	cmpi.w #0,($1b2,a0)
	blt.w loc_018ff6
	move.w ($1b6,a0),d0
	cmpi.w #0,d0
	bge.w loc_018ff6
	bpl.w loc_018f92
	neg.w d0

loc_018f92:
	lea.l loc_019006(pc),a2
	nop
	moveq #0,d1
	move.b (1,a0),d1
	add.b d1,d1
	adda.l d1,a2
	move.b (a2),d1
	moveq #0,d2

loc_018fa6:
	add.w d0,d2
	dbra d1,loc_018fa6
	move.w ($1b2,a0),d3
	asl.w #8,d3
	cmp.w d3,d2
	bcc.b loc_018ff6
	moveq #0,d1
	move.b (1,a2),d1

loc_018fbc:
	add.w d0,d2
	dbra d1,loc_018fbc
	cmp.w d3,d2
	bcs.b loc_019004
	cmpi.b #0,($180,a0)
	bne.b loc_019004
	moveq #4,d7
	jsr loc_004554
	addi.b #$23,d7
	move.b ($190,a0),d0
	lsr.b #1,d0
	add.b d0,d7

loc_018fe2:
	move.b d7,($184,a0)
	bset #7,($180,a0)
	andi.l #$ff000000,($184,a0)
	bra.b loc_019004

loc_018ff6:
	btst #1,($181,a0)
	bne.b loc_019004
	bset #0,($181,a0)

loc_019004:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_019006:
	dc.b $03,$04,$03,$07,$06,$03,$02,$06
	dc.b $03,$04,$04,$02,$02,$04,$02,$0a
	dc.b $0a,$06,$02,$08,$05,$04,$02,$0a
	dc.b $03,$06,$05,$0e

;##############################################################################
loc_019022:
	btst #0,($181,a0)
	beq.b loc_01908e
	cmpi.b #0,($189,a0)
	beq.b loc_019044
	cmpi.b #0,($18b,a0)
	beq.w loc_01908e
	cmpi.b #$10,($189,a0)
	bcs.b loc_01908e

loc_019044:
	move.w #6,($32,a0)
	andi.b #2,($30,a0)
	btst #0,($bd,a0)
	bne.b loc_019060
	bset #2,($30,a0)
	bra.b loc_019066

loc_019060:
	bset #3,($30,a0)

loc_019066:
	btst #5,($1a1,a0)
	bne.b loc_019080
	cmpi.b #1,($141,a1)
	beq.b loc_019086
	bcs.b loc_019080
	bclr #1,($30,a0)
	bra.b loc_019086

loc_019080:
	bset #1,($30,a0)

loc_019086:
	bset #0,($180,a0)
	bra.b loc_019094

loc_01908e:
	bclr #0,($180,a0)

loc_019094:
	rts

;##############################################################################
loc_019096:
	lea.l loc_000718,a2
	moveq #0,d0
	move.b (1,a0),d0
	add.b d0,d0
	add.b d0,d0
	movea.l (a2,d0.w),a2
	moveq #0,d0
	move.b ($184,a0),d0
	add.w d0,d0
	add.w d0,d0
	movea.l (a2,d0.w),a2
	moveq #0,d0
	move.b ($185,a0),d0
	adda.l d0,a2
	lsl.l #3,d0
	adda.l d0,a2
	btst #0,($186,a0)
	bne.b loc_0190e4
	move.b #1,($186,a0)
	move.b (1,a2),($187,a0)
	btst #7,(a2)
	beq.b loc_0190e4
	bset #1,($186,a0)

loc_0190e4:
	cmpi.b #0,($187,a0)
	beq.b loc_0190fa
	subi.b #1,($187,a0)
	beq.w loc_0191d6
	bra.w loc_019300

loc_0190fa:
	btst #1,(a2)
	beq.b loc_019130
	cmpi.w #2,($d0,a0)
	bcs.w loc_0192e0
	cmpi.w #3,($d0,a0)
	bhi.w loc_0192e0
	btst #3,($bf,a0)
	beq.w loc_019300
	btst #3,($bf,a1)
	bne.b loc_019130
	cmpi.w #0,($cc,a0)
	bpl.w loc_019300

loc_019130:
	btst #5,(a2)
	bne.b loc_019140
	cmpi.w #$20,($d0,a0)
	bcc.w loc_019300

loc_019140:
	btst #3,(a2)
	bne.b loc_0191ba
	moveq #0,d4
	btst #6,(a2)
	beq.b loc_019154
	move.w ($1ae,a0),d4
	asl.w #2,d4

loc_019154:
	move.w ($1a4,a0),d0
	moveq #0,d1
	move.b (4,a2),d1
	add.w d1,d1
	add.w d4,d1
	bge.b loc_019166
	moveq #0,d1

loc_019166:
	cmp.w d1,d0
	bcs.w loc_019290
	moveq #0,d1
	move.b (5,a2),d1
	add.w d1,d1
	add.w d4,d1
	bge.b loc_01917c
	move.w #$24,d1

loc_01917c:
	cmpi.b #$3d,($184,a0)
	beq.b loc_01918c
	btst #2,($181,a0)
	bne.b loc_0191b4

loc_01918c:
	cmp.w d1,d0
	bcc.w loc_0192b8
	bset #2,($181,a0)
	btst #2,(a2)
	bne.b loc_0191a6
	bclr #3,($181,a0)
	bra.b loc_0191ba

loc_0191a6:
	bset #3,($181,a0)
	bset #1,($30,a0)
	bra.b loc_0191ba

loc_0191b4:
	andi.b #$f3,($30,a0)

loc_0191ba:
	move.w ($1a6,a0),d0
	moveq #0,d1
	move.b (6,a2),d1
	cmp.w d1,d0
	bcs.w loc_019300
	moveq #0,d1
	move.b (7,a2),d1
	cmp.w d1,d0
	bhi.w loc_019300

loc_0191d6:
	move.b (2,a2),d0
	btst #0,($bd,a0)
	beq.b loc_0191fa
	move.b d0,d2
	move.b d0,d3
	andi.b #$f3,d0
	andi.b #4,d2
	andi.b #8,d3
	lsl.b #1,d2
	lsr.b #1,d3
	or.b d2,d0
	or.b d3,d0

loc_0191fa:
	move.l #0,($30,a0)
	move.b d0,($30,a0)
	move.b d0,($b0,a0)
	move.b d0,($b1,a0)
	lea.l loc_0164d0,a3
	moveq #0,d1
	move.b (8,a2),d1
	cmpi.b #$ff,d1
	beq.b loc_019266
	add.w d1,d1
	add.w d1,d1
	movea.l (a3,d1.w),a3
	move.b (a3),d1
	lsl.l #8,d1
	move.b (1,a3),d1
	lsl.l #8,d1
	move.b (2,a3),d1
	lsl.l #8,d1
	move.b (3,a3),d1
	btst #0,($bd,a0)
	beq.b loc_019262
	move.l d1,d2
	move.l d1,d3
	andi.l #$03030303,d1
	andi.l #$04040404,d2
	andi.l #$08080808,d3
	lsl.l #1,d2
	lsr.l #1,d3
	or.l d2,d1
	or.l d3,d1

loc_019262:
	move.l d1,($34,a0)

loc_019266:
	btst #4,(a2)
	beq.b loc_019272
	move.w #$1010,($b4,a0)

loc_019272:
	bclr #2,($181,a0)
	btst #0,(a2)
	bne.w loc_0192e0
	addi.b #1,($185,a0)
	bclr #0,($186,a0)
	bra.w loc_019300

loc_019290:
	cmpi.w #$13,($18,a0)
	bls.b loc_0192e0
	cmpi.w #$12c,($18,a0)
	bcc.b loc_0192e0

loc_0192a0:
	btst #0,($bd,a0)
	bne.b loc_0192b0
	move.b #4,($30,a0)
	bra.b loc_019300

loc_0192b0:
	move.b #8,($30,a0)
	bra.b loc_019300

loc_0192b8:
	btst #2,($180,a0)
	beq.b loc_0192c8
	btst #0,($1a0,a0)
	bne.b loc_0192a0

loc_0192c8:
	btst #0,($bd,a0)
	bne.b loc_0192d8
	move.b #8,($30,a0)
	bra.b loc_019300

loc_0192d8:
	move.b #4,($30,a0)
	bra.b loc_019300

loc_0192e0:
	btst #3,($180,a0)
	beq.b loc_0192ee
	move.b #0,($18a,a0)

loc_0192ee:
	move.b #0,($180,a0)
	move.b #0,($185,a0)
	bclr #4,($181,a0)

loc_019300:
	rts

;##############################################################################
loc_019302:
	moveq #0,d0
	moveq #$c,d1
	move.w $101018,d2

loc_01930c:
	btst.l d1,d2
	beq.b loc_019312
	addq.b #1,d0

loc_019312:
	dbra d1,loc_01930c
	rts

;##############################################################################
loc_019318:
	btst #0,($bf,a0)
	bne.b loc_019338
	bset #0,($bf,a0)
	jsr loc_019476
	cmpi.l #loc_05a000,($124,a0)
	beq.w loc_01942c

loc_019338:
	btst #2,($12f,a0)
	beq.b loc_01935a
	btst #5,($be,a0)
	beq.b loc_01935a
	clr.l ($c8,a0)
	clr.l ($cc,a0)
	bset #2,($123,a0)
	bra.w loc_01942c

loc_01935a:
	jsr loc_019628
	btst #2,($122,a0)
	bne.w loc_01942c
	btst #3,($bf,a0)
	beq.w loc_019432
	move.l #$20000,d0
	jsr loc_01a7f0
	btst #6,($12b,a0)
	bne.b loc_0193a0
	lea.l loc_064000,a2
	moveq #0,d0
	move.b (1,a0),d0
	lsl.w #5,d0
	move.l ($10,a2,d0.w),d0
	sub.l d0,($cc,a0)
	bra.b loc_0193c4

loc_0193a0:
	move.l ($c8,a0),d0
	asr.l #2,d0
	sub.l d0,($c8,a0)
	move.l ($cc,a0),d0
	asr.l #2,d0
	sub.l d0,($cc,a0)
	cmpi.w #8,($c4,a0)
	bpl.b loc_0193c4
	move.l #0,($cc,a0)

loc_0193c4:
	move.l ($c4,a0),d0
	add.l ($cc,a0),d0
	bpl.b loc_019432
	clr.l ($c4,a0)
	clr.l ($cc,a0)
	bclr #3,($bf,a0)
	move.b #6,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	movea.l ($124,a0),a6
	moveq #0,d0
	move.b ($120,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a6

loc_019402:
	btst #0,(3,a6)
	bne.b loc_019418
	addi.b #1,($120,a0)
	adda.l #4,a6
	bra.b loc_019402

loc_019418:
	bset #0,($122,a0)
	jsr loc_019628
	btst #2,($122,a0)
	beq.b loc_019432

loc_01942c:
	jsr loc_0195e4

loc_019432:
	rts

;##############################################################################
loc_019434:
	btst #0,($bf,a0)
	bne.b loc_019460
	jsr loc_019476(pc)
	nop
	cmpi.l #loc_05a000,($124,a0)
	beq.w loc_01946e
	move.b ($bd,a0),d0
	andi.w #1,d0
	bclr #0,($21,a0)
	or.b d0,($21,a0)

loc_019460:
	jsr loc_019628(pc)
	nop
	btst #2,($122,a0)
	beq.b loc_019474

loc_01946e:
	jsr loc_0195e4(pc)
	nop

loc_019474:
	rts

;##############################################################################
;Attack Data Get
loc_019476:
	movea.l ($14,a0),a1
	bset #0,($bf,a0)
	lea.l loc_064000,a2
	adda.l #$1c0,a2
	moveq #0,d0
	move.w ($d0,a0),d0
	subi.w #$20,d0
	add.l d0,d0
	add.l d0,d0

;##############################################################################
loc_01949a:
	adda.l d0,a2
	move.b (a2),d0
	andi.b #$30,d0
	lsr.b #4,d0
	move.b d0,($141,a0)
	move.b (1,a2),d0
	andi.b #$1d,d0
	btst #7,(2,a2)
	beq.b loc_0194bc
	bset #6,d0

loc_0194bc:
	move.b d0,($142,a0)
	lea.l loc_05a000,a3
	moveq #0,d0
	move.w ($d0,a0),d0
	subi.w #$20,d0
	moveq #0,d1
	move.b (1,a0),d1
	lsl.w #4,d1
	sub.w d1,d0
	add.w d1,d1
	sub.w d1,d0
	move.w d0,d2
	add.w d1,d0
	add.w d1,d1
	add.w d1,d0
	addi.w #$30,d0
	add.w d0,d0
	adda.l d0,a3
	moveq #0,d0
	movea.w (a3),a3
	adda.l #loc_05a000,a3
	move.l a3,($124,a0)
	move.b (2,a3),($121,a0)
	move.b #0,($120,a0)
	move.b #1,($122,a0)
	move.b #0,($123,a0)
	bset #1,($be,a0)
	bclr #5,($be,a0)
	addi.l #1,($110,a0)
	lea.l loc_016a14,a4
	moveq #0,d0
	move.w ($d0,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a4
	move.b (a4),d1
	btst #1,d1
	bne.b loc_019548
	clr.w ($12e,a0)
	bra.b loc_019578

loc_019548:
	lea.l loc_019716(pc),a5
	nop
	moveq #0,d0
	move.b ($12d,a0),d0
	lsl.w #2,d0
	adda.l d0,a5
	lsl.w #2,d0
	adda.l d0,a5
	move.l (a5),($12c,a0)
	move.l (4,a5),($130,a0)
	move.l (8,a5),($134,a0)
	move.l ($c,a5),($138,a0)
	move.l ($10,a5),($13c,a0)

loc_019578:
	btst #4,d1
	beq.b loc_019582
	clr.b ($123,a0)

loc_019582:
	clr.b ($140,a0)
	btst #7,d1
	beq.b loc_019592
	move.b #1,($140,a0)

loc_019592:
	bset #6,($21,a0)
	bclr #6,($21,a1)
	btst #2,d1
	beq.b loc_0195b0
	bclr #6,($21,a0)
	bset #6,($21,a1)

loc_0195b0:
	btst #6,d1
	beq.b loc_0195bc
	move.b #$10,($14e,a0)

loc_0195bc:
	btst #6,($12e,a0)
	beq.b loc_0195dc
	move.b (1,a4),d0
	move.b d0,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_0195dc:
	addi.w #1,($110,a0)
	rts

;##############################################################################
loc_0195e4:
	lea.l loc_016a14,a2
	moveq #0,d0
	move.w ($d0,a0),d0
	add.w d0,d0
	add.w d0,d0
	move.b (a2,d0.l),d0
	bclr #4,($be,a0)
	btst #0,d0
	beq.b loc_01960a
	bset #4,($be,a0)

loc_01960a:
	btst #3,($12e,a0)
	beq.b loc_01961a
	addi.w #1,($d0,a0)
	bra.b loc_019620

loc_01961a:
	move.w #0,($d0,a0)

loc_019620:
	bclr #0,($bf,a0)
	rts

;##############################################################################
loc_019628:
	btst #0,($122,a0)
	beq.b loc_019636
	clr.b ($122,a0)
	bra.b loc_019666

loc_019636:
	clr.b ($122,a0)
	subi.b #1,($121,a0)
	bhi.w loc_019714
	beq.w loc_0196fe
	btst #1,($12e,a0)
	beq.b loc_019660
	btst #0,($12b,a0)
	beq.b loc_019660
	move.b #0,($120,a0)
	bra.b loc_019666

loc_019660:
	addi.b #1,($120,a0)

loc_019666:
	bset #1,($122,a0)
	movea.l ($124,a0),a6
	moveq #0,d0
	move.b ($120,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a6
	move.l (a6),($128,a0)
	move.w (a6),($22,a0)
	move.b (2,a6),($121,a0)
	btst #7,($12b,a0)
	beq.b loc_0196c6
	lea.l loc_064000,a2
	adda.l #$1c0,a2
	moveq #0,d0
	move.w ($d0,a0),d0
	subi.w #$20,d0
	add.l d0,d0
	add.l d0,d0
	adda.l d0,a2
	move.b (3,a2),d0
	move.b d0,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_0196c6:
	btst #1,($12b,a0)
	beq.b loc_0196f6
	lea.l loc_064000,a2
	adda.l #$1c0,a2
	moveq #0,d0
	move.w ($d0,a0),d0
	subi.w #$20,d0
	add.l d0,d0
	add.l d0,d0
	adda.l d0,a2
	move.b (1,a2),d0
	andi.b #$3f,d0
	or.b d0,($142,a0)

loc_0196f6:
	subi.b #1,($121,a0)
	bne.b loc_019714

loc_0196fe:
	btst #0,($12b,a0)
	beq.b loc_019714
	btst #1,($12e,a0)
	bne.b loc_019714
	bset #2,($122,a0)

loc_019714:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_019716:
	dc.w $0000,$0000,$0000,$0000,$0200,$0700,$0000,$ffa0,$0000,$fec0
	dc.w $0100,$0000,$0000,$0000,$0000,$0000,$0000,$ff90,$0000,$ff90
	dc.w $0000,$4000,$0000,$0200,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0000,$0201,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0009,$0000,$ffff,$4000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$000e,$0000,$ffff,$8000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0800,$0300,$0000,$fffe,$0800,$0800,$ff40,$ff80
	dc.w $0000,$4000,$0a00,$0300,$0000,$fffe,$0b00,$0b00,$ff40,$ff80
	dc.w $0000,$4000,$0800,$0300,$0000,$fffe,$0800,$0800,$ff40,$ff80
	dc.w $0000,$4000,$0a00,$0300,$0000,$fffe,$0b00,$0b00,$ff40,$ff80
	dc.w $030b,$4800,$0000,$0000,$0200,$0800,$0000,$ffa0,$0000,$ff00
	dc.w $0000,$0100,$fe00,$fe00,$0000,$0001,$0400,$0400,$ffdc,$ffa0
	dc.w $0000,$4000,$0100,$0100,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0100,$0101,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0200,$0100,$ff80,$0600,$0000,$ffc0,$0000,$ff80
	dc.w $0000,$4000,$0200,$0101,$ff80,$0600,$0000,$ffc0,$0000,$ff80
	dc.w $0000,$4000,$0900,$0000,$fe00,$0000,$0800,$0800,$ff40,$ff90
	dc.w $0000,$4000,$0f00,$0000,$fe00,$0000,$0d00,$0800,$ff40,$ff80
	dc.w $0613,$4800,$0000,$0000,$0000,$0000,$0000,$ff40,$0000,$ff40
	dc.w $0000,$0100,$fe00,$fe00,$0000,$0000,$0600,$0600,$ffc0,$ff80
	dc.w $0e15,$4900,$0000,$0000,$0300,$0280,$0000,$ffc0,$0000,$ffc0
	dc.w $0f00,$0100,$0000,$0000,$0280,$0300,$0000,$ff80,$0000,$ff80
	dc.w $0a17,$4900,$0000,$0000,$0100,$1000,$0000,$0000,$0000,$0000
	dc.w $0b18,$4b01,$0000,$0000,$0100,$0d00,$0000,$ffc0,$0000,$ffa0
	dc.w $0c19,$0b02,$0000,$0000,$0100,$0000,$0000,$ffa0,$0000,$fe80
	dc.w $0d00,$4100,$0000,$0000,$ff00,$0380,$0000,$ffe0,$ffe8,$ffb0
	dc.w $071b,$0900,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $081c,$0b00,$0000,$0000,$0000,$0000,$0180,$0000,$0000,$0000
	dc.w $0900,$0100,$0000,$0000,$ff80,$0180,$0000,$ffe0,$0000,$ffe0
	dc.w $001e,$4800,$0480,$0480,$0000,$0000,$0300,$0300,$ff80,$ff80
	dc.w $0000,$4100,$03e0,$03e0,$0000,$0000,$0300,$0300,$ff80,$ff80
	dc.w $1020,$4d00,$0000,$0000,$0000,$0000,$0000,$ffa8,$0000,$ffa8
	dc.w $1100,$0100,$0000,$0000,$0100,$0380,$0000,$ff40,$0000,$ff40
	dc.w $0000,$4000,$0300,$0400,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0300,$0401,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0900,$0180,$ff00,$0000,$0800,$0800,$ff40,$ffa0
	dc.w $0000,$4000,$0c00,$0180,$ff00,$0000,$0b00,$0b00,$ff40,$ffa0
	dc.w $0000,$4000,$0300,$0300,$0000,$0000,$0880,$0880,$ff50,$fee0
	dc.w $0000,$4000,$0400,$0400,$0000,$0000,$0b00,$0b00,$ff50,$fee0
	dc.w $0000,$0000,$0180,$0180,$0000,$0000,$0800,$0600,$ff00,$ffa0
	dc.w $0029,$4c04,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$2040,$fe80,$fe80,$0000,$0000,$0d00,$0000,$ff30,$ff30
	dc.w $132b,$0800,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $142c,$0b00,$0000,$0000,$0000,$0000,$0100,$0000,$0000,$0000
	dc.w $1500,$0140,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $162e,$0800,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $172f,$0b00,$0000,$0000,$0000,$0000,$0100,$0000,$0000,$0000
	dc.w $1800,$0140,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0400,$0400,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0400,$0401,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0780,$0580,$ffe0,$ffe0,$0580,$0580,$ff40,$ffb0
	dc.w $0000,$4000,$0900,$0700,$ffe0,$ffe0,$0600,$0600,$ff40,$ffa0
	dc.w $0000,$4000,$1000,$0000,$fc80,$0000,$0b00,$0b00,$ff00,$ff90
	dc.w $0000,$4000,$1000,$0000,$fc80,$0000,$0e00,$0e00,$ff00,$ff90
	dc.w $0000,$4000,$0006,$0000,$fffe,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0008,$0000,$fffe,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0800,$0800,$0000,$0000,$0340,$0340,$ff40,$ff40
	dc.w $0000,$4000,$0800,$0800,$0000,$0000,$04e0,$04e0,$ff40,$ff40
	dc.w $0000,$4000,$0800,$0800,$0000,$0000,$01a0,$01a0,$ff40,$ff40
	dc.w $0000,$4000,$1000,$1000,$0000,$0000,$0340,$0340,$ff40,$ffa0
	dc.w $0000,$4000,$000a,$0000,$fffe,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$000a,$0000,$fffe,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0500,$0280,$0000,$0000,$0b00,$0b00,$ff00,$ff40
	dc.w $0000,$4000,$0600,$0280,$0000,$0000,$0e00,$0e00,$ff00,$ff40
	dc.w $0000,$4000,$0500,$0400,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0500,$0401,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0600,$0200,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0004,$0000,$ffff,$4000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0008,$0000,$ffff,$8000,$0000,$0000,$0000,$0000
	dc.w $0046,$0800,$0200,$0200,$0000,$0000,$0a00,$0000,$ff40,$0000
	dc.w $0047,$4980,$0200,$0200,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0048,$4980,$0200,$0200,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0049,$4980,$0200,$0200,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $004a,$4980,$0200,$0200,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $004b,$4900,$0200,$0200,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0100,$0200,$0200,$0000,$0000,$0000,$0000,$ffa0,$ffa0
	dc.w $004d,$0800,$0400,$0400,$0000,$0000,$0600,$0000,$ff40,$0000
	dc.w $004e,$4980,$0400,$0400,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $004f,$4980,$0400,$0400,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0050,$4980,$0400,$0400,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0051,$4980,$0400,$0400,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $004b,$4900,$0400,$0400,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0800,$0400,$0000,$ff00,$0000,$ffff,$0000,$ffa0
	dc.w $0000,$4000,$0800,$0401,$0000,$ff00,$0000,$ffff,$0000,$ffa0
	dc.w $0000,$0000,$0480,$0000,$ff80,$0000,$0b00,$0000,$ff20,$ffa0
	dc.w $0000,$0000,$0600,$0000,$ff80,$0000,$0d00,$0000,$ff40,$ff40
	dc.w $0000,$2200,$0608,$0a0c,$0000,$6000,$0008,$0008,$0603,$0000
	dc.w $0000,$0400,$0000,$4000,$0000,$0000,$0040,$0000,$0000,$0000
	dc.w $0000,$6100,$0600,$0600,$0000,$0000,$0800,$0800,$ff60,$ff40
	dc.w $0000,$4000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0100,$0006,$0000,$ffff,$c000,$0000,$0000,$0000,$0000
	dc.w $0000,$0100,$0007,$0000,$ffff,$c000,$0000,$0000,$0000,$0000
	dc.w $005d,$0800,$fa00,$fa00,$0000,$0000,$0200,$0000,$ff80,$ff80
	dc.w $0000,$0100,$ff00,$ff00,$0000,$0000,$0200,$0000,$ff80,$ff80
	dc.w $005f,$0800,$fa00,$fa00,$0000,$0000,$0200,$0000,$ff80,$ff80
	dc.w $0000,$0100,$0600,$0600,$0000,$0000,$0200,$0000,$ff80,$ff80
	dc.w $1e61,$4800,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $1f62,$0b00,$0000,$0000,$0000,$0000,$0100,$0000,$0000,$0000
	dc.w $2000,$4100,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0900,$0400,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0900,$0401,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0066,$0800,$0300,$0300,$0000,$0000,$0800,$0800,$ff80,$ff80
	dc.w $0067,$0b1c,$0800,$0800,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0100,$fd80,$fd80,$0000,$0000,$0500,$0000,$ff80,$ff80
	dc.w $0069,$0800,$0300,$0300,$0000,$0000,$0800,$0800,$ff80,$ff80
	dc.w $006a,$0b1c,$1000,$1000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0100,$fe00,$fe00,$0000,$0000,$0c00,$0c00,$ff80,$ff80
	dc.w $006c,$0c00,$0200,$0100,$0000,$0000,$0800,$0000,$0000,$0000
	dc.w $006d,$0b06,$0300,$0300,$0000,$0000,$0800,$0000,$ffc0,$fe00
	dc.w $0000,$0140,$fe00,$fe00,$0000,$0000,$0800,$0800,$ff80,$ff80
	dc.w $006f,$0c00,$0200,$0100,$0000,$0000,$0c00,$0000,$0000,$0000
	dc.w $0070,$0b06,$0400,$0400,$0000,$0000,$0800,$0000,$ffc0,$fe00
	dc.w $0000,$0140,$fe00,$fe00,$0000,$0000,$0800,$0800,$ff80,$ff80
	dc.w $0072,$0804,$0500,$0000,$0000,$0000,$0b00,$0000,$ff80,$ff00
	dc.w $0000,$2100,$0000,$0000,$0000,$0000,$0600,$0600,$ffc0,$ffc0
	dc.w $0074,$0804,$0400,$0000,$0000,$ffb0,$0c00,$0000,$ff48,$ff40
	dc.w $0000,$2100,$0000,$0000,$0000,$0000,$0800,$0800,$ff80,$ff80
	dc.w $0000,$0000,$0d00,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0a00,$0400,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0a00,$0401,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0b00,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0c00,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0006,$0000,$ffff,$e000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0008,$0000,$ffff,$e000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0005,$0000,$ffff,$8000,$0000,$0000,$0000,$0000
	dc.w $2300,$0000,$0000,$0000,$fd00,$0700,$0000,$ffa0,$0000,$ffa0
	dc.w $0000,$4000,$0700,$0400,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0700,$0401,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$fe00,$fe00,$0000,$0000,$0800,$0000,$ff60,$ffb0
	dc.w $0000,$4000,$fd00,$fd00,$0000,$0000,$0d00,$0000,$ff40,$ffb0
	dc.w $0000,$0000,$0005,$0000,$ffff,$8000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0005,$0000,$ffff,$8000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0008,$0000,$ffff,$8000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$0008,$0000,$ffff,$8000,$0000,$0000,$0000,$0000
	dc.w $0000,$4000,$0200,$0200,$0000,$0000,$0800,$0000,$ff80,$ffa0
	dc.w $0000,$4000,$0200,$0200,$0000,$0000,$0940,$0000,$ff80,$ffa0
	dc.w $0000,$4000,$0400,$0400,$0000,$0000,$0300,$0000,$ff80,$ffa0
	dc.w $0000,$4000,$0500,$0500,$0000,$0000,$0300,$0000,$ff80,$ffb0
	dc.w $008b,$4800,$0200,$0200,$0000,$0000,$0800,$0000,$ff80,$0000
	dc.w $0000,$0100,$0200,$0200,$0000,$0000,$0000,$0000,$ff40,$ff40
	dc.w $008d,$4800,$0400,$0400,$fff0,$0000,$0800,$0000,$ffa0,$0000
	dc.w $0000,$0100,$0300,$0300,$0000,$0000,$0000,$0000,$ff40,$ff40
	dc.w $268f,$4900,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $2700,$0100,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0091,$6900,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$2140,$0000,$0000,$0000,$0000,$0000,$0000,$ff80,$ff80
	dc.w $0000,$6200,$0608,$0a0c,$0000,$1000,$0008,$0008,$0601,$0000
	dc.w $0000,$6200,$0608,$0a0c,$0000,$1000,$0008,$0008,$0601,$0000
	dc.w $0000,$2200,$0608,$0a0c,$0000,$1000,$0008,$0008,$0601,$0000
	dc.w $0000,$2200,$0608,$0a0c,$0000,$2000,$0008,$0008,$0601,$0000
	dc.w $0000,$0000,$0009,$0000,$ffff,$4000,$0000,$0000,$0000,$0000
	dc.w $0000,$0000,$000e,$0000,$ffff,$8000,$0000,$0000,$0000,$0000
	dc.w $0099,$4800,$0009,$0000,$ffff,$4000,$0000,$0000,$0000,$0000
	dc.w $0000,$0100,$0000,$0000,$0000,$0000,$1000,$0000,$ff40,$ff80
	dc.w $009b,$0906,$0600,$0600,$0000,$0000,$fa00,$fa00,$0000,$0000
	dc.w $0000,$0140,$fe00,$fe00,$0000,$0000,$0800,$0800,$ffa0,$ffa0
	dc.w $0200,$4000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w $009e,$4800,$0c00,$0180,$ff00,$0000,$0b00,$0b00,$ff40,$ffa0
	dc.w $009f,$2b00,$0608,$0a0c,$0002,$0000,$0020,$0008,$0602,$0000
	dc.w $0000,$0100,$0100,$0100,$0000,$0000,$0900,$0900,$ff40,$ffa0
	dc.w $0000,$0000,$0008,$0000,$ffff,$8000,$0000,$0000,$0000,$0000
	dc.w $28a2,$4900,$0000,$0000,$0800,$0400,$ffe0,$ffe0,$fff8,$ff00
	dc.w $0000,$0100,$fe00,$fe00,$0000,$0001,$0400,$0400,$ffdc,$ffa0
	dc.w $00a4,$0800,$0008,$0000,$ffff,$0000,$0000,$0000,$0000,$0000
	dc.w $0000,$0100,$0000,$0000,$0000,$0000,$1000,$0000,$ff20,$ff80
	dc.w $29a6,$0900,$0000,$0000,$0000,$0800,$0000,$0000,$0000,$0000
	dc.w $2aa7,$0b01,$0000,$0000,$0000,$0800,$0000,$ffd0,$0000,$ffd0
	dc.w $2b00,$0100,$0000,$0000,$0000,$0000,$0000,$ffa0,$0000,$ffa0
	dc.w $00a9,$4800,$0180,$0180,$0000,$0000,$0500,$0000,$ff70,$ff60
	dc.w $00aa,$4904,$0300,$0300,$0000,$0000,$1000,$0000,$fee0,$fe40
	dc.w $0000,$0140,$fe00,$fe00,$0000,$0000,$0800,$0000,$ffa0,$ffa0
	dc.w $0000,$0000,$0100,$0100,$0000,$0000,$0500,$0000,$ffa0,$ffa0
	dc.w $0000,$4000,$0008,$0000,$ffff,$8000,$0000,$0000,$0000,$0000

;##############################################################################
loc_01a49a:
	btst #0,($bf,a0)
	bne.b loc_01a4cc
	bset #0,($bf,a0)
	jsr loc_019476
	cmpi.l #loc_05a000,($124,a0)
	beq.w loc_01a5b0
	move.b ($bd,a0),d0
	andi.w #1,d0
	bclr #0,($21,a0)
	or.b d0,($21,a0)

loc_01a4cc:
	jsr loc_019628
	btst #2,($122,a0)
	bne.w loc_01a5b0
	btst #6,($12b,a0)
	beq.b loc_01a526
	btst #5,($bf,a0)
	beq.w loc_01a526
	cmpi.l #0,($130,a0)
	beq.w loc_01a5a2
	moveq #0,d0
	move.l d0,($130,a0)
	move.l d0,($134,a0)
	move.b #1,($121,a0)
	cmpi.w #$161,($d0,a0)
	beq.b loc_01a51a
	cmpi.w #$1c5,($d0,a0)
	bne.b loc_01a526

loc_01a51a:
	bset #1,($be,a0)
	move.b #$30,($14f,a0)

loc_01a526:
	btst #4,($12b,a0)
	beq.b loc_01a5a2
	move.l #$10000,d0
	jsr loc_01a7f0
	btst #5,($12b,a0)
	beq.b loc_01a54e
	move.l ($134,a0),d0
	add.l d0,($130,a0)
	ble.b loc_01a59a
	bra.b loc_01a586

loc_01a54e:
	move.w ($d0,a0),d0
	andi.w #$fffe,d0
	cmpi.w #$12c,d0
	bne.b loc_01a586
	cmpi.l #0,($130,a0)
	beq.b loc_01a586
	movem.l a0,-(a7)
	move.w #$6c00,d0
	move.l ($c0,a0),d1
	move.l ($c4,a0),d2
	move.b ($21,a0),d3
	move.w (a0),d4
	jsr loc_010f40
	movem.l (a7)+,a0

loc_01a586:
	move.l ($130,a0),d0
	btst #0,($21,a0)
	beq.b loc_01a594
	neg.l d0

loc_01a594:
	add.l d0,($c0,a0)
	bra.b loc_01a5a2

loc_01a59a:
	clr.l ($130,a0)
	clr.l ($134,a0)

loc_01a5a2:
	jsr loc_01b0a4
	btst #2,($122,a0)
	beq.b loc_01a5b6

loc_01a5b0:
	jsr loc_0195e4

loc_01a5b6:
	rts

;##############################################################################s
loc_01a5b8:
	btst #0,($bf,a0)
	bne.b loc_01a620
	bset #0,($bf,a0)
	jsr loc_019476
	cmpi.l #loc_05a000,($124,a0)
	beq.w loc_01a7d4
	btst #0,($12e,a0)
	bne.b loc_01a5f2
	move.b ($bd,a0),d0
	andi.w #1,d0
	bclr #0,($21,a0)
	or.b d0,($21,a0)

loc_01a5f2:
	clr.l ($c8,a0)
	clr.l ($cc,a0)
	btst #3,($bf,a0)
	bne.b loc_01a620
	btst #2,($123,a0)
	bne.w loc_01a620
	btst #6,($12f,a0)
	beq.w loc_01a620
	bclr #6,($12f,a0)
	bra.w loc_01a790

loc_01a620:
	jsr loc_019628
	btst #2,($122,a0)
	bne.w loc_01a7d4
	btst #2,($12f,a0)
	beq.b loc_01a64c
	btst #5,($be,a0)
	beq.w loc_01a64c
	bset #2,($123,a0)
	bra.w loc_01a7e8

loc_01a64c:
	btst #3,($12f,a0)
	beq.w loc_01a670
	move.w ($18,a0),d0
	subi.w #$a0,d0
	btst #0,($21,a0)
	beq.b loc_01a668
	neg.w d0

loc_01a668:
	cmpi.w #$8c,d0
	bge.w loc_01a7e8

loc_01a670:
	btst #1,($122,a0)
	beq.w loc_01a68a
	btst #4,($12b,a0)
	beq.w loc_01a68a
	bset #3,($bf,a0)

loc_01a68a:
	btst #3,($bf,a0)
	beq.w loc_01a7ee
	btst #6,($12b,a0)
	bne.w loc_01a7ee
	move.l #$20000,d0
	jsr loc_01a7f0(pc)
	nop
	cmpi.w #0,($138,a0)
	ble.b loc_01a6cc
	move.w ($134,a0),d0
	neg.w d0
	sub.w d0,($130,a0)
	bcc.b loc_01a6c6
	clr.w ($134,a0)
	clr.w ($130,a0)

loc_01a6c6:
	move.w ($130,a0),d0
	bra.b loc_01a6d8

loc_01a6cc:
	move.w ($136,a0),d0
	add.w d0,($132,a0)
	move.w ($132,a0),d0

loc_01a6d8:
	moveq #$10,d1
	lsl.l d1,d0
	asr.l #8,d0
	btst #0,($21,a0)
	beq.b loc_01a6e8
	neg.l d0

loc_01a6e8:
	add.l d0,($c0,a0)
	btst #4,($12f,a0)
	beq.b loc_01a748
	lea.l loc_037000+$10,a4
	moveq #0,d0
	move.w ($22,a0),d0
	move.l d0,d1
	lsl.l #5,d0
	lsl.l #4,d1
	adda.l d0,a4
	adda.l d1,a4
	adda.l #4,a4
	movea.l ($14,a0),a1
	lea.l loc_037000+$10,a5
	moveq #0,d0
	move.w ($22,a1),d0
	move.l d0,d1
	lsl.l #5,d0
	lsl.l #4,d1
	adda.l d0,a5
	adda.l d1,a5
	adda.l #4,a5
	jsr loc_01606c
	btst #7,($bf,a1)
	beq.b loc_01a748
	bclr #7,($bf,a1)
	bne.w loc_01a7e8

loc_01a748:
	cmpi.w #0,($138,a0)
	ble.b loc_01a756
	move.w ($13c,a0),d0
	bra.b loc_01a75a

loc_01a756:
	move.w ($13e,a0),d0

loc_01a75a:
	add.w d0,($138,a0)
	move.w ($138,a0),d0
	moveq #$10,d1
	lsl.l d1,d0
	asr.l #8,d0
	add.l d0,($c4,a0)
	bge.w loc_01a7ee
	clr.l ($c4,a0)
	bclr #3,($bf,a0)
	move.b #6,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_01a790:
	movea.l ($124,a0),a6
	moveq #0,d0
	move.b ($120,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a6

loc_01a7a0:
	btst #5,(3,a6)
	bne.b loc_01a7b6
	addi.b #1,($120,a0)
	adda.l #4,a6
	bra.b loc_01a7a0

loc_01a7b6:
	bset #0,($122,a0)
	jsr loc_019628
	btst #2,($122,a0)
	bne.b loc_01a7d4
	btst #1,($12f,a0)
	beq.b loc_01a7ee
	bra.b loc_01a7e8

loc_01a7d4:
	btst #7,($12f,a0)
	beq.b loc_01a7e8
	move.w #$15e,($d0,a0)
	move.b #$4b,($12d,a0)

loc_01a7e8:
	jsr loc_0195e4

loc_01a7ee:
	rts

;##############################################################################
loc_01a7f0:
	btst #5,($12e,a0)
	beq.b loc_01a812
	btst #2,($30,a0)
	beq.b loc_01a806
	sub.l d0,($c0,a0)
	bra.b loc_01a812

loc_01a806:
	btst #3,($30,a0)
	beq.b loc_01a812
	add.l d0,($c0,a0)

loc_01a812:
	rts

;##############################################################################s
loc_01a814:
	btst #0,($bf,a0)
	bne.b loc_01a884
	bset #0,($bf,a0)
	jsr loc_019476
	cmpi.l #loc_05a000,($124,a0)
	beq.w loc_01a97a
	btst #0,($12e,a0)
	bne.b loc_01a84e
	move.b ($bd,a0),d0
	andi.w #1,d0
	bclr #0,($21,a0)
	or.b d0,($21,a0)

loc_01a84e:
	bclr #3,($bf,a0)
	clr.l ($c8,a0)
	clr.l ($cc,a0)
	movea.l ($14,a0),a1
	move.l ($c0,a0),d0
	move.l ($c0,a1),d1
	sub.l d0,d1
	move.b ($130,a0),d0
	asr.l d0,d1
	asr.l #8,d1
	btst #0,($21,a0)
	beq.b loc_01a87c
	neg.w d1

loc_01a87c:
	move.w d1,($130,a0)
	move.w d1,($132,a0)

loc_01a884:
	jsr loc_019628
	btst #2,($122,a0)
	bne.w loc_01a97a
	btst #2,($12f,a0)
	beq.b loc_01a8a8
	btst #5,($be,a0)
	beq.b loc_01a8a8
	bra.w loc_01a97a

loc_01a8a8:
	btst #1,($122,a0)
	beq.w loc_01a8c2
	btst #4,($12b,a0)
	beq.w loc_01a8c2
	bset #3,($bf,a0)

loc_01a8c2:
	btst #3,($bf,a0)
	beq.w loc_01a980
	cmpi.w #0,($138,a0)
	ble.b loc_01a8ee
	move.w ($134,a0),d0
	neg.w d0
	sub.w d0,($130,a0)
	bcc.b loc_01a8e8
	clr.w ($134,a0)
	clr.w ($130,a0)

loc_01a8e8:
	move.w ($130,a0),d0
	bra.b loc_01a8fa

loc_01a8ee:
	move.w ($136,a0),d0
	add.w d0,($132,a0)
	move.w ($132,a0),d0

loc_01a8fa:
	moveq #$10,d1
	lsl.l d1,d0
	asr.l #8,d0
	btst #0,($21,a0)
	beq.b loc_01a90a
	neg.l d0

loc_01a90a:
	add.l d0,($c0,a0)
	cmpi.w #0,($138,a0)
	ble.b loc_01a91c
	move.w ($13c,a0),d0
	bra.b loc_01a920

loc_01a91c:
	move.w ($13e,a0),d0

loc_01a920:
	add.w d0,($138,a0)
	move.w ($138,a0),d0
	moveq #$10,d1
	lsl.l d1,d0
	asr.l #8,d0
	add.l d0,($c4,a0)
	bge.b loc_01a980
	clr.l ($c4,a0)
	bclr #3,($bf,a0)
	movea.l ($124,a0),a6
	moveq #0,d0
	move.b ($120,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a6

loc_01a94e:
	btst #5,(3,a6)
	bne.b loc_01a964
	addi.b #1,($120,a0)
	adda.l #4,a6
	bra.b loc_01a94e

loc_01a964:
	bset #0,($122,a0)
	jsr loc_019628
	btst #2,($122,a0)
	bne.w loc_01a97a

loc_01a97a:
	jsr loc_0195e4

loc_01a980:
	rts

;##############################################################################s
loc_01a982:
	btst #0,($bf,a0)
	bne.b loc_01a9c4
	jsr loc_019476
	cmpi.l #loc_05a000,($124,a0)
	beq.w loc_01aa8a
	move.b ($bd,a0),d0
	andi.w #1,d0
	bclr #0,($21,a0)
	or.b d0,($21,a0)
	clr.l ($c8,a0)
	clr.l ($cc,a0)
	cmpi.l #0,($c4,a0)
	bge.b loc_01a9c4
	clr.l ($c4,a0)

loc_01a9c4:
	jsr loc_019628
	btst #2,($122,a0)
	bne.w loc_01aa8a
	btst #1,($122,a0)
	beq.b loc_01a9ea
	btst #4,($12b,a0)
	beq.b loc_01a9ea
	jsr loc_017b78

loc_01a9ea:
	btst #5,($12b,a0)
	beq.w loc_01aa90
	move.w ($134,a0),d0
	moveq #$10,d1
	lsl.l d1,d0
	asr.l #8,d0
	btst #0,($21,a0)
	beq.b loc_01aa08
	neg.l d0

loc_01aa08:
	add.l d0,($c0,a0)
	move.w ($13a,a0),d0
	btst #7,($136,a0)
	beq.b loc_01aa1c
	move.w ($13e,a0),d0

loc_01aa1c:
	add.w d0,($136,a0)
	move.w ($136,a0),d0
	moveq #$10,d1
	lsl.l d1,d0
	asr.l #8,d0
	add.l d0,($c4,a0)
	bge.b loc_01aa90
	clr.l ($c4,a0)
	bclr #3,($bf,a0)
	move.b #6,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	movea.l ($124,a0),a6
	moveq #0,d0
	move.b ($120,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a6

loc_01aa60:
	btst #6,(3,a6)
	bne.b loc_01aa76
	addi.b #1,($120,a0)
	adda.l #4,a6
	bra.b loc_01aa60

loc_01aa76:
	bset #0,($122,a0)
	jsr loc_019628
	btst #2,($122,a0)
	beq.b loc_01aa90

loc_01aa8a:
	jsr loc_0195e4

loc_01aa90:
	rts

;##############################################################################s
loc_01aa92:
	btst #0,($bf,a0)
	bne.b loc_01aabe
	bset #0,($bf,a0)
	ori.b #$c0,($bd,a0)
	bclr #0,($123,a0)
	moveq #0,d0
	move.b d0,($137,a0)
	move.l d0,($c8,a0)
	move.l d0,($cc,a0)
	bra.w loc_01ac0e

loc_01aabe:
	cmpi.b #0,($147,a0)
	bne.b loc_01ab16
	cmpi.b #$20,($137,a0)
	bcc.b loc_01aad4
	addi.b #1,($137,a0)

loc_01aad4:
	cmpi.b #$10,($137,a0)
	bcs.b loc_01aae4
	move.w #1,$10346c

loc_01aae4:
	btst #0,($123,a0)
	bne.b loc_01ab16
	bset #0,($123,a0)
	moveq #0,d0
	move.b (1,a0),d0
	lea.l loc_0116aa,a1
	move.b (a1,d0.w),d0
	move.b d0,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_01ab16:
	btst #7,($bd,a0)
	bne.w loc_01ac0e
	move.w ($c0,a0),d0
	move.w #$160,d1
	cmp.w d1,d0
	bcs.b loc_01ab34
	move.w #$3a0,d1
	cmp.w d1,d0
	bcs.b loc_01ab4c

loc_01ab34:
	move.l ($138,a0),d0
	cmpi.l #0,d0
	beq.b loc_01ab4c
	move.l d0,($c8,a0)
	move.l #0,($138,a0)

loc_01ab4c:
	move.l ($138,a0),d0
	add.l d0,($c0,a0)
	movea.l ($130,a0),a2
	moveq #0,d0
	move.b (6,a2),d0
	moveq #$18,d1
	lsl.l d1,d0
	moveq #$f,d1
	asr.l d1,d0
	add.l d0,($13c,a0)
	move.l ($13c,a0),d0
	add.l d0,($c4,a0)
	bpl.w loc_01ac0e
	move.w #$16,($d0,a0)
	bclr #0,($bf,a0)
	move.l ($138,a0),d0
	move.l d0,($c8,a0)
	moveq #0,d0
	move.l d0,($c4,a0)
	move.l d0,($cc,a0)
	cmpi.b #2,($12c,a0)
	bne.b loc_01abcc
	move.w #0,($d0,a0)
	bclr #3,($bf,a0)
	bset #4,($be,a0)
	bchg.b #0,($21,a0)
	move.b #6,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	bra.b loc_01abf0

loc_01abcc:
	movem.l a0-a1, -(a7)
	moveq #2,d0
	moveq #4,d1
	jsr loc_00cbde
	move.b #$b,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_01abf0:
	move.w #$800,d0
	move.l ($c0,a0),d1
	move.l #$100000,d2
	move.b ($21,a0),d3
	move.w (a0),d4
	jsr loc_010f40
	movem.l (a7)+,a0-a1

loc_01ac0e:
	rts

;##############################################################################s
loc_01ac10:
	movea.l ($14,a0),a1
	btst #0,($bf,a0)
	bne.w loc_01aca4

loc_01ac1e:
	jsr loc_019476
	btst #0,($12e,a0)
	bne.b loc_01ac4e
	btst #2,($30,a0)
	beq.b loc_01ac42
	bset #0,($21,a0)
	bset #0,($21,a1)
	bra.b loc_01ac4e

loc_01ac42:
	bclr #0,($21,a0)
	bclr #0,($21,a1)

loc_01ac4e:
	lea.l loc_017514,a2
	moveq #0,d1
	move.b ($12c,a0),d1
	lsl.l #4,d1
	adda.l d1,a2
	move.l a2,($130,a0)
	btst #2,($12e,a0)
	beq.b loc_01ac88
	move.l ($c8,a0),d0
	lsr.l #8,d0
	btst #0,($21,a0)
	beq.b loc_01ac7a
	neg.w d0

loc_01ac7a:
	move.w d0,($134,a0)
	move.l ($cc,a0),d0
	lsr.l #8,d0
	move.w d0,($136,a0)

loc_01ac88:
	clr.l ($c8,a0)
	clr.l ($cc,a0)
	clr.l ($10c,a0)
	clr.l ($10c,a1)
	bset #6,($bd,a1)
	bclr #0,($123,a0)

loc_01aca4:
	jsr loc_01accc(pc)
	nop
	jsr loc_01af52(pc)
	nop
	jsr loc_01b01c(pc)
	nop
	jsr loc_01b0a4(pc)
	nop
	btst #2,($122,a0)
	beq.b loc_01acca
	jsr loc_0195e4

loc_01acca:
	rts

;##############################################################################s
loc_01accc:
	btst #7,($122,a0)
	beq.b loc_01ace2
	cmpi.w #$a6,($d0,a0)
	beq.b loc_01ace2
	bset #2,($bf,a1)

loc_01ace2:
	jsr loc_019628
	btst #1,($122,a0)
	beq.w loc_01af50
	btst #4,($12b,a0)
	beq.b loc_01ad06
	bset #3,($bf,a0)
	bset #3,($bf,a1)

loc_01ad06:
	movea.l ($130,a0),a2
	move.b (9,a2),d0
	cmp.b ($120,a0),d0
	bne.b loc_01ad1a
	bchg.b #0,($21,a0)

loc_01ad1a:
	movea.l ($130,a0),a2
	move.b (8,a2),d0
	cmp.b ($120,a0),d0
	bne.b loc_01ad78
	moveq #8,d0
	move.b ($c,a2),d1
	lsl.w #8,d1
	asr.w #8,d1
	btst #0,($21,a0)
	beq.b loc_01ad3c
	neg.w d1

loc_01ad3c:
	add.w ($c0,a0),d1
	move.b ($d,a2),d2
	lsl.w #8,d2
	asr.w #8,d2
	add.w ($c4,a0),d2
	movem.l a0-a2, -(a7)
	jsr loc_00e1c0
	movem.l (a7)+,a0-a2
	btst #1,($f,a2)
	beq.b loc_01ad78
	move.b #$d,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_01ad78:
	move.b (3,a2),d0
	cmp.b ($120,a0),d0
	bne.b loc_01adaa
	btst #6,$101000
	bne.b loc_01adaa
	move.w ($d0,a0),($fc,a1)
	move.b ($140,a0),($144,a1)
	move.b #3,($145,a1)
	move.b ($142,a0),($146,a1)
	bset #7,($bf,a1)

loc_01adaa:
	move.b ($a,a2),d0
	cmp.b ($120,a0),d0
	bne.w loc_01ae34
	movem.l a0-a1,-(a7)
	moveq #2,d0
	moveq #6,d1
	btst #0,($f,a2)
	beq.b loc_01adc8
	moveq #6,d0

loc_01adc8:
	jsr loc_00cbde
	move.b #$b,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	move.w #$800,d0
	moveq #$18,d3
	move.b ($c,a2),d1
	lsl.l d3,d1
	asr.l #8,d1
	btst #0,($21,a0)
	beq.b loc_01adfc
	neg.l d1

loc_01adfc:
	add.l ($c0,a0),d1
	move.l #$100000,d2
	move.b ($21,a0),d3
	move.w (a0),d4
	jsr loc_010f40
	btst #0,($f,a2)
	beq.b loc_01ae30
	move.w #$1c00,d0
	move.l #$80000,d2
	move.b ($21,a0),d3
	move.w (a0),d4
	jsr loc_010f40

loc_01ae30:
	movem.l (a7)+,a0-a1

loc_01ae34:
	btst #0,($123,a0)
	bne.w loc_01af50
	lea.l loc_060000,a2
	moveq #0,d0
	move.b ($12c,a0),d0
	add.w d0,d0
	move.w (a2,d0.w),d0
	adda.l d0,a2
	moveq #0,d0
	move.b ($120,a0),d0
	lsl.l #3,d0
	adda.l d0,a2
	lsl.l #1,d0
	adda.l d0,a2
	lsl.l #1,d0
	adda.l d0,a2
	moveq #0,d0
	move.b (1,a1),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a2
	move.w (a2),d0
	andi.w #$1ff,d0
	move.w d0,($22,a1)
	bclr #0,($21,a1)
	move.b ($21,a0),d0
	andi.b #1,d0
	btst #6,(a2)
	beq.b loc_01ae92
	eori.b #1,d0

loc_01ae92:
	or.b d0,($21,a1)
	bset #6,($21,a0)
	bclr #6,($21,a1)
	btst #5,(a2)
	beq.b loc_01aeb4
	bclr #6,($21,a0)
	bset #6,($21,a1)

loc_01aeb4:
	movea.l ($130,a0),a2
	move.b (2,a2),d0
	cmp.b ($120,a0),d0
	bne.w loc_01af50
	bset #3,($bf,a1)
	move.l ($130,a0),($130,a1)
	move.b (4,a2),d0
	moveq #$18,d1
	lsl.l d1,d0
	moveq #$c,d2
	asr.l d2,d0
	btst #0,($21,a0)
	beq.b loc_01aee6
	neg.l d0

loc_01aee6:
	move.l d0,($138,a1)
	move.b (5,a2),d0
	lsl.l d1,d0
	subq.b #1,d2
	asr.l d2,d0
	move.l d0,($13c,a1)
	move.b ($12c,a0),($12c,a1)
	clr.b ($120,a1)
	move.b #$ff,($121,a1)
	bclr #6,($bd,a1)
	bclr #7,($bd,a1)
	jsr loc_01b01c(pc)
	nop
	bset #7,($122,a0)
	bset #0,($123,a0)
	cmpi.b #2,($12c,a0)
	beq.b loc_01af34
	bset #3,($be,a1)

loc_01af34:
	cmpi.w #$9e,($d0,a0)
	bne.b loc_01af50
	move.w #$11,($d0,a1)
	bclr #0,($bf,a1)
	move.l ($138,a1),d0
	move.l d0,($c8,a1)

loc_01af50:
	rts

;##############################################################################s
loc_01af52
	btst #5,($12b,a0)
	bne.w loc_01b01a
	btst #3,($bf,a0)
	beq.w loc_01b01a
	cmpi.w #0,($136,a0)
	ble.b loc_01af84
	move.w ($138,a0),d0
	neg.w d0
	sub.w d0,($134,a0)
	bcc.b loc_01af8c
	clr.w ($134,a0)
	clr.w ($138,a0)
	bra.b loc_01af8c

loc_01af84:
	move.w ($13c,a0),d0
	add.w d0,($134,a0)

loc_01af8c:
	move.w ($134,a0),d0
	moveq #$10,d1
	lsl.l d1,d0
	asr.l #8,d0
	btst #0,($21,a0)
	beq.b loc_01afa0
	neg.l d0

loc_01afa0:
	add.l d0,($c0,a0)
	cmpi.w #0,($136,a0)
	ble.b loc_01afb2
	move.w ($13a,a0),d0
	bra.b loc_01afb6

loc_01afb2:
	move.w ($13e,a0),d0

loc_01afb6:
	add.w d0,($136,a0)
	move.w ($136,a0),d0
	moveq #$10,d1
	lsl.l d1,d0
	asr.l #8,d0
	add.l d0,($c4,a0)
	bge.b loc_01b01a
	clr.l ($c4,a0)
	bclr #3,($bf,a0)
	move.b #6,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054
	movea.l ($124,a0),a6
	moveq #0,d0
	move.b ($120,a0),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a6

loc_01affa:
	btst #6,(3,a6)
	bne.b loc_01b010
	addi.b #1,($120,a0)
	adda.l #4,a6
	bra.b loc_01affa

loc_01b010: 
	bset #0,($122,a0)
	jsr loc_01accc(pc)

loc_01b01a:
	rts

;##############################################################################
loc_01b01c:
	btst #0,($123,a0)
	bne.w loc_01b0a2
	lea.l loc_060000,a2
	moveq #0,d0
	move.b ($12c,a0),d0
	add.w d0,d0
	move.w (a2,d0.w),d0
	adda.l d0,a2
	moveq #0,d0
	move.b ($120,a0),d0
	lsl.l #3,d0
	adda.l d0,a2
	lsl.l #1,d0
	adda.l d0,a2
	lsl.l #1,d0
	adda.l d0,a2
	moveq #0,d0
	move.b (1,a1),d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a2
	move.b (2,a2),d0
	lsl.w #8,d0
	asr.w #8,d0
	btst #0,($21,a0)
	beq.b loc_01b06a
	neg.w d0

loc_01b06a:
	add.w ($c0,a0),d0
	move.w d0,($c0,a1)
	move.b (3,a2),d0
	lsl.w #8,d0
	asr.w #8,d0
	neg.w d0
	add.w ($c4,a0),d0
	move.w d0,($c4,a1)
	move.w ($c0,a1),d0
	move.w #$160,d1
	cmp.w d1,d0
	bcs.b loc_01b098
	move.w #$39e,d1
	cmp.w d1,d0
	bcs.b loc_01b0a2

loc_01b098:
	sub.w d0,d1
	add.w d1,($c0,a0)
	add.w d1,($c0,a1)

loc_01b0a2:
	rts

;##############################################################################
loc_01b0a4:
	btst #0,($12f,a0)
	beq.b loc_01b0b4
	cmpi.w #0,($136,a0)
	blt.b loc_01b0ee

loc_01b0b4:
	btst #1,($12f,a0)
	beq.b loc_01b0cc
	cmpi.w #0,($c4,a0)
	bgt.b loc_01b0cc
	bclr #3,($bf,a0)
	bra.b loc_01b0ee

loc_01b0cc:
	btst #5,($12f,a0)
	beq.b loc_01b0dc
	subi.w #1,($138,a0)
	bls.b loc_01b0ee

loc_01b0dc:
	btst #6,($12f,a0)
	beq.b loc_01b0ec
	cmpi.b #0,($147,a0)
	beq.b loc_01b0ee

loc_01b0ec:
	bra.b loc_01b0f4

loc_01b0ee:
	bset #2,($122,a0)

loc_01b0f4:
	rts

;##############################################################################
loc_01b0f6:
	lea.l player1mem,a1
	cmpa.l a0,a1
	bne.b loc_01b106
	adda.l #playeroffset,a1

loc_01b106:
	btst #0,($bf,a0)
	bne.w loc_01aca4
	move.b ($14f,a0),d0
	cmpi.b #0,d0
	beq.w loc_01b1de
	cmpi.b #$18,d0
	beq.w loc_01b1c8
	bclr #0,($21,a0)
	btst #0,($bd,a0)
	beq.b loc_01b138
	bset #0,($21,a0)

loc_01b138:
	btst #3,($bf,a0)
	bne.w loc_01b1c4
	movem.l a0-a1,-(a7)
	move.w #$c00,d0
	move.l ($c0,a0),d1
	move.l #$80000,d2
	move.b ($21,a0),d3
	move.w (a0),d4
	jsr loc_010f40
	movem.l (a7)+,a0-a1
	move.w ($c0,a0),d0
	sub.w ($c0,a1),d0
	bpl.w loc_01b172
	neg.w d0

loc_01b172:
	lea.l loc_037000+$10,a2
	moveq #0,d1
	move.w ($22,a0),d1
	lsl.l #4,d1
	adda.l d1,a2
	add.l d1,d1
	adda.l d1,a2
	moveq #0,d1
	move.b (6,a2),d1
	sub.w d1,d0
	lea.l loc_037000+$10,a2
	moveq #0,d1
	move.w ($22,a1),d1
	lsl.l #4,d1
	adda.l d1,a2
	add.l d1,d1
	adda.l d1,a2
	moveq #0,d1
	move.b (6,a2),d1
	sub.w d1,d0
	subi.w #$18,d0
	bge.b loc_01b1b4
	moveq #$a,d1
	bra.b loc_01b1ca

loc_01b1b4:
	eori.b #1,($21,a0)
	move.w ($c0,a1),($c0,a0)
	moveq #$e,d1
	bra.b loc_01b1ca

loc_01b1c4:
	moveq #$10,d1
	bra.b loc_01b1ca

loc_01b1c8:
	moveq #2,d1

loc_01b1ca:
	lea.l loc_017514,a2
	lsl.l #4,d1
	adda.l d1,a2
	move.w (a2),($d0,a0)
	move.b (7,a2),($12d,a0)

loc_01b1de:
	bra.w loc_01ac1e

;##############################################################################
loc_01b1e2:
	lea.l player1mem,a1
	cmpa.l a0,a1
	bne.b loc_01b1f2
	adda.l #playeroffset,a1

loc_01b1f2:
	btst #0,($bf,a0)
	bne.w loc_01aca4
	move.b ($14f,a0),d0
	cmpi.b #0,d0
	beq.w loc_01b232
	bclr #0,($21,a0)
	btst #0,($bd,a0)
	beq.b loc_01b21c
	bset #0,($21,a0)

loc_01b21c:
	moveq #$26,d1
	lea.l loc_017514,a2
	lsl.l #4,d1
	adda.l d1,a2
	move.w (a2),($d0,a0)
	move.b (7,a2),($12d,a0)

loc_01b232:
	bra.w loc_01ac1e

;##############################################################################
loc_01b236:
	movea.l ($14,a0),a1
	btst #0,($bf,a0)
	bne.b loc_01b27c
	jsr loc_019476
	lea.l loc_017514,a2
	moveq #0,d1
	move.b ($12c,a0),d1
	lsl.l #4,d1
	adda.l d1,a2
	move.l a2,($130,a0)
	move.l a2,($130,a1)
	clr.l ($c8,a0)
	clr.l ($cc,a0)
	clr.l ($10c,a0)
	clr.l ($10c,a1)
	bset #6,($bd,a1)
	bclr #0,($123,a0)

loc_01b27c:
	jsr loc_01accc
	jsr loc_01b01c
	cmpi.b #0,($b0,a1)
	beq.b loc_01b296
	subi.w #4,($138,a0)

loc_01b296:
	cmpi.b #0,($b0,a0)
	beq.b loc_01b2ac
	cmpi.b #2,($121,a0)
	bls.b loc_01b2ac
	subi.b #2,($121,a0)

loc_01b2ac:
	subi.w #1,($138,a0)
	ble.b loc_01b2c6
	cmpi.w #0,fighttimer
	beq.b loc_01b2c6
	cmpi.b #0,($147,a1)
	bne.b loc_01b2cc

loc_01b2c6:
	jsr loc_0195e4

loc_01b2cc:
	rts

;##############################################################################
;Ray's Special moves
RaySpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01b40c
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01b40c
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01b392
	btst #3,($bf,a0)
	bne.w loc_01b392
	cmpi.b #0,($149,a0)
	bne.b loc_01b32e
	moveq #0,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01b32e

	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$36,d7
	moveq #2,d6
	add.b d0,d6
	bra.w loc_01b3da

loc_01b32e:
	moveq #1,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01b392
	moveq #3,d6
	moveq #$40,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	beq.b loc_01b370
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$37,d7
	add.w d0,d7
	moveq #4,d6
	add.b d0,d6
	bra.b loc_01b3da

loc_01b370:
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$3d,d7
	add.w d0,d7
	move.b #$96,d6
	add.b d0,d6
	bra.b loc_01b3da

loc_01b392:
	move.b d7,d0
	andi.b #$c,d0
	beq.w loc_01b40c
	moveq #2,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.w loc_01b40c
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.b #2,d0
	move.w #$39,d7
	add.w d0,d7
	moveq #6,d6
	add.b d0,d6
	btst #3,($bf,a0)
	beq.b loc_01b3da
	addq.w #2,d7
	addq.b #2,d6

loc_01b3da:
	cmpi.w #5,($d0,a0)
	bls.w loc_01b3fe
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01b40c
	btst #3,($12b,a0)
	beq.b loc_01b40c
	btst #5,($be,a0)
	beq.b loc_01b40c

loc_01b3fe:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01b40c:
	rts

;##############################################################################
FeilinSpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01b5be
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01b5be
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01b52e
	btst #3,($bf,a0)
	bne.w loc_01b4de
	moveq #7,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.b loc_01b4a0
	moveq #8,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	beq.b loc_01b47c
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$67,d7
	add.w d0,d7
	move.b #$10,d6
	add.w d0,d6
	bra.w loc_01b566

loc_01b47c:
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$6d,d7
	add.w d0,d7
	add.w d0,d7
	move.b #$98,d6
	bra.w loc_01b566

loc_01b4a0:
	cmpi.b #0,($149,a0)
	bne.w loc_01b5be
	moveq #5,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.w loc_01b5be
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$66,d7
	move.b #$c,d6
	add.b d0,d6
	bra.w loc_01b566

loc_01b4de:
	cmpi.l #0,($cc,a0)
	bge.b loc_01b4f2
	btst #5,($bf,a0)
	beq.w loc_01b5be

loc_01b4f2:
	cmpi.b #0,($149,a0)
	bne.w loc_01b5be
	moveq #6,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.w loc_01b5be
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$69,d7
	move.b #$e,d6
	add.b d0,d6
	bra.b loc_01b566

loc_01b52e:
	btst #7,($b0,a0)
	beq.w loc_01b5be
	move.b ($30,a0),d0
	btst #3,($bf,a0)
	bne.b loc_01b54e
	andi.b #$f,d0
	bne.b loc_01b5be
	moveq #$6a,d7
	bra.b loc_01b58c

loc_01b54e:
	btst #1,d0
	beq.b loc_01b5be
	move.w ($cc,a0),d0
	andi.w #$fffe,d0
	bne.b loc_01b5be
	moveq #$6b,d7
	move.b #$9a,d6
	bra.b loc_01b58c

loc_01b566:
	cmpi.w #5,($d0,a0)
	bls.w loc_01b5b0
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01b5be
	btst #3,($12b,a0)
	beq.b loc_01b5be
	btst #5,($be,a0)
	beq.b loc_01b5be
	bra.b loc_01b5b0

loc_01b58c
	cmpi.w #5,($d0,a0)
	bls.b loc_01b5b0
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01b5be
	movea.l ($14,a0),a1
	cmpi.b #0,($14c,a1)
	bne.b loc_01b5be
	btst #2,($12b,a0)
	beq.b loc_01b5be

loc_01b5b0:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01b5be:
	rts

;##############################################################################
RyokoSpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01b774
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01b774
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01b6ac
	moveq #$a,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	beq.b loc_01b5fe
	moveq #$b,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01b612

loc_01b5fe:
	move.b #$2c,($14f,a0)
	move.b ($b1,a0),d2
	jsr loc_0163c8
	bra.w loc_01b71c

loc_01b612:
	btst #3,($bf,a0)
	bne.w loc_01b774
	moveq #$e,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	beq.b loc_01b63c
	moveq #$2c,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01b650

loc_01b63c:
	move.b #$18,($14f,a0)
	move.b ($b1,a0),d2
	jsr loc_0163c8
	bra.w loc_01b71c

loc_01b650:
	cmpi.w #$95,($d0,a0)
	bne.b loc_01b6ac
	cmpi.b #3,($120,a0)
	bcc.w loc_01b774
	moveq #$c,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.w loc_01b774
	move.w #$98,($d0,a0)
	move.b #7,($12c,a0)
	move.b ($120,a0),d0
	movem.l d0, -(a7)
	jsr loc_019476
	movem.l (a7)+,d0
	move.b d0,($120,a0)
	lea.l loc_017514,a2
	move.b ($12c,a0),d1
	lsl.l #4,d1
	adda.l d1,a2
	move.l a2,($130,a0)
	bra.w loc_01b774

loc_01b6ac:
	btst #3,($bf,a0)
	bne.w loc_01b774
	move.b d7,d0
	andi.b #$c,d0
	beq.w loc_01b6f8
	moveq #$d,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.w loc_01b6f8
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.b #2,d0
	move.w #$a4,d7
	sub.w d0,d7
	move.b #$1e,d6
	sub.b d0,d6
	bra.b loc_01b71c

loc_01b6f8:
	btst #5,($b0,a0)
	beq.b loc_01b774
	btst #3,($bf,a0)
	bne.b loc_01b774
	move.b ($30,a0),d0
	andi.b #$f,d0
	cmpi.b #2,d0
	bne.b loc_01b774
	move.w #$a5,d7
	bra.b loc_01b742

loc_01b71c:
	cmpi.w #5,($d0,a0)
	bls.w loc_01b766
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01b774
	btst #3,($12b,a0)
	beq.b loc_01b774
	btst #5,($be,a0)
	beq.b loc_01b774
	bra.b loc_01b766

loc_01b742:
	cmpi.w #5,($d0,a0)
	bls.b loc_01b766
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01b774
	movea.l ($14,a0),a1
	cmpi.b #0,($14c,a1)
	bne.b loc_01b774
	btst #2,($12b,a0)
	beq.b loc_01b774

loc_01b766:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01b774:
	rts

;##############################################################################
MatlokSpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01b996
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01b996
	btst #3,($bf,a0)
	bne.w loc_01b868
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01b7da
	cmpi.b #0,($149,a0)
	bne.b loc_01b7da
	moveq #$f,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.b loc_01b7da
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$c5,d7
	move.b #$21,d6
	add.b d0,d6
	bra.w loc_01b93e

loc_01b7da:
	move.b d7,d0
	andi.b #$c,d0
	beq.w loc_01b922
	moveq #$10,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.b loc_01b82e
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	cmpi.w #$c,d0
	beq.b loc_01b822
	move.b (a1,d0.w),d0
	subq.w #2,d0
	move.w #$c6,d7
	add.w d0,d7
	move.b #$23,d6
	add.b d0,d6
	bra.w loc_01b93e

loc_01b822:
	move.w #$d0,d7
	move.b #$9d,d6
	bra.w loc_01b93e

loc_01b82e:
	moveq #$11,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.w loc_01b922
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.w #2,d0
	move.w #$ca,d7
	add.w d0,d7
	move.b #$25,d6
	add.b d0,d6
	bra.w loc_01b93e

loc_01b868:
	lea.l loc_016a14,a2
	move.w ($d0,a0),d0
	add.w d0,d0
	add.w d0,d0
	move.b (a2,d0.w),d2
	btst #0,($bf,a0)
	bne.b loc_01b886
	bclr #3,d2

loc_01b886:
	move.b ($b0,a0),d0
	andi.w #$c0,d0
	beq.w loc_01b8d0
	move.b ($30,a0),d1
	btst #1,d1
	beq.b loc_01b8d0
	move.b ($21,a0),d3
	andi.b #1,d3
	lsr.b d3,d1
	btst #2,d1
	bne.b loc_01b8d0
	lea.l loc_016488,a1
	lsr.b #4,d0
	move.b (a1,d0.w),d0
	subq.w #2,d0
	add.w d0,d0
	move.w #$cc,d7
	add.w d0,d7
	move.b #$28,d6
	cmpi.w #5,($d0,a0)
	bls.w loc_01b988

loc_01b8d0:
	btst #3,d2
	beq.w loc_01b996
	move.b ($b0,a0),d0
	andi.w #$f0,d0
	beq.w loc_01b996
	move.b ($b0,a0),d2
	jsr loc_0163c8
	cmpi.w #0,($138,a0)
	ble.b loc_01b8fc
	move.w ($130,a0),d0
	bra.b loc_01b900

loc_01b8fc:
	move.w ($132,a0),d0

loc_01b900:
	btst #0,($21,a0)
	beq.b loc_01b90a
	neg.w d0

loc_01b90a:
	moveq #$10,d1
	lsl.l d1,d0
	asr.l #8,d0
	move.l d0,($c8,a0)
	move.w ($138,a0),d0
	lsl.l d1,d0
	asr.l #8,d0
	move.l d0,($cc,a0)
	bra.b loc_01b988

loc_01b922:
	btst #5,($b0,a0)
	beq.w loc_01b996
	btst #1,($30,a0)
	beq.b loc_01b996
	move.w #$b9,d7
	move.b #$27,d6
	bra.b loc_01b964

loc_01b93e:
	cmpi.w #5,($d0,a0)
	bls.w loc_01b988
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01b996
	btst #3,($12b,a0)
	beq.b loc_01b996
	btst #5,($be,a0)
	beq.b loc_01b996
	bra.b loc_01b988

loc_01b964:
	cmpi.w #5,($d0,a0)
	bls.b loc_01b988
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01b996
	movea.l ($14,a0),a1
	cmpi.b #0,($14c,a1)
	bne.b loc_01b996
	btst #2,($12b,a0)
	beq.b loc_01b996

loc_01b988:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01b996:
	rts

;##############################################################################
SamchaySpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01bb22
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01bb22
	btst #3,($bf,a0)
	bne.w loc_01bb22
	move.b d7,d0
	andi.b #3,d0
	beq.b loc_01b9f8
	cmpi.b #0,($149,a0)
	bne.b loc_01b9f8
	moveq #$14,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01b9f8
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$fa,d7
	move.b #$30,d6
	add.b d0,d6
	bra.w loc_01baca

loc_01b9f8:
	move.b d7,d0
	andi.b #$c,d0
	beq.w loc_01ba6e
	moveq #$15,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01ba38
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.b #2,d0
	move.w #$fb,d7
	add.w d0,d7
	move.b #$32,d6
	add.b d0,d6
	bra.w loc_01baca

loc_01ba38:
	moveq #$16,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01ba6e
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.b #2,d0
	move.w #$fd,d7
	add.w d0,d7
	move.b #$34,d6
	add.b d0,d6
	bra.w loc_01baca

loc_01ba6e:
	move.b ($b0,a0),d0
	andi.b #$f0,d0
	lsr.b #4,d0
	move.b d0,d1
	lsr.b #2,d1
	and.b d1,d0
	beq.b loc_01ba96
	subq.b #1,d0
	andi.w #1,d0
	move.w #$ff,d7
	add.w d0,d7
	move.b #$36,d6
	add.b d0,d6
	bra.w loc_01baca

loc_01ba96:
	moveq #8,d0
	btst #0,($bd,a0)
	beq.b loc_01baa2
	moveq #4,d0

loc_01baa2:
	move.b ($30,a0),d1
	andi.b #$f,d1
	cmp.b d0,d1
	bne.b loc_01bb22
	btst #5,($b0,a0)
	beq.b loc_01babc
	move.w #$101,d7
	bra.b loc_01baf0

loc_01babc:
	btst #7,($b0,a0)
	beq.b loc_01bb22
	move.w #$102,d7
	bra.b loc_01baf0

loc_01baca:
	cmpi.w #5,($d0,a0)
	bls.w loc_01bb14
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01bb22
	btst #3,($12b,a0)
	beq.b loc_01bb22
	btst #5,($be,a0)
	beq.b loc_01bb22
	bra.b loc_01bb14

loc_01baf0:
	cmpi.w #5,($d0,a0)
	bls.b loc_01bb14
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01bb22
	movea.l ($14,a0),a1
	cmpi.b #0,($14c,a1)
	bne.b loc_01bb22
	btst #2,($12b,a0)
	beq.b loc_01bb22

loc_01bb14:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01bb22:
	rts

;##############################################################################
LeeSpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01bc82
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01bc82
	btst #3,($bf,a0)
	bne.w loc_01bc82
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01bc12
	move.w ($d0,a0),d6
	subq.w #1,d6
	bclr #0,d6
	cmpi.w #$124,d6
	bne.b loc_01bb9a
	btst #5,($be,a0)
	beq.w loc_01bc82
	moveq #$1b,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01bb9a
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$12c,d7
	add.w d0,d7
	move.b #$3c,d6
	add.b d0,d6
	bra.w loc_01bc74

loc_01bb9a:
	moveq #$19,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01bbea
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$125,d7
	move.b #$38,d6
	add.b d0,d6
	moveq #4,d0
	btst #0,($bd,a0)
	beq.b loc_01bbd4
	moveq #8,d0

loc_01bbd4:
	move.b ($30,a0),d1
	andi.b #$f,d1
	cmp.b d1,d0
	bne.w loc_01bc50
	addq.w #1,d7
	addq.b #2,d6
	bra.w loc_01bc50

loc_01bbea:
	move.b d7,d0
	andi.b #3,d0
	cmpi.b #3,d0
	bne.b loc_01bc12
	moveq #$1c,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01bc12
	move.w #$12a,d7
	move.b #$75,d6
	bra.w loc_01bc50

loc_01bc12:
	move.b d7,d0
	andi.b #$c,d0
	beq.w loc_01bc82
	moveq #$1a,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.w loc_01bc82
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.b #2,d0
	move.w #$128,d7
	add.w d0,d7
	move.b #$3e,d6
	add.b d0,d6

loc_01bc50:
	cmpi.w #5,($d0,a0)
	bls.w loc_01bc74
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01bc82
	btst #3,($12b,a0)
	beq.b loc_01bc82
	btst #5,($be,a0)
	beq.b loc_01bc82

loc_01bc74:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01bc82:
	rts

;##############################################################################
MizoguchiSpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01bdea
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01bdea
	btst #3,($bf,a0)
	bne.w loc_01bd44
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01bd44
	moveq #$1e,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01bcf8
	move.b ($b1,a0),d0
	lsr.b #4,d0
	cmpi.b #$f,d0
	beq.b loc_01bcec
	cmpi.b #0,($149,a0)
	bne.b loc_01bcf8
	lea.l loc_016488,a1
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$156,d7
	move.b #$40,d6
	add.b d0,d6
	bra.w loc_01bdb8

loc_01bcec:
	move.w #$160,d7
	move.b #$42,d6
	bra.w loc_01bdb8

loc_01bcf8:
	moveq #$1f,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01bd44
	move.b ($b1,a0),d0
	lsr.b #4,d0
	cmpi.b #$f,d0
	beq.b loc_01bd38
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$157,d7
	add.w d0,d7
	move.b #$43,d6
	add.b d0,d6
	bra.w loc_01bdb8

loc_01bd38:
	move.w #$161,d7
	move.b #$a3,d6
	bra.w loc_01bdb8

loc_01bd44:
	move.b d7,d0
	andi.b #$c,d0
	beq.w loc_01bdea
	moveq #$20,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.w loc_01bdea
	cmpi.w #$159,($d0,a0)
	bls.b loc_01bd7a
	cmpi.w #$15d,($d0,a0)
	bhi.b loc_01bd7a
	bclr #7,($12f,a0)
	bra.w loc_01bdea

loc_01bd7a:
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.b #2,d0
	move.w #$159,d7
	move.b #$45,d6
	btst #3,($bf,a0)
	beq.b loc_01bdac
	btst #5,($bf,a0)
	beq.b loc_01bdea
	addq.w #2,d7
	addq.b #2,d6

loc_01bdac:
	btst #0,d0
	beq.b loc_01bdb8
	addq.b #7,d6
	bra.w loc_01bdb8

loc_01bdb8:
	cmpi.w #5,($d0,a0)
	bls.w loc_01bddc
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01bdea
	btst #3,($12b,a0)
	beq.b loc_01bdea
	btst #5,($be,a0)
	beq.b loc_01bdea

loc_01bddc:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01bdea:
	rts

;##############################################################################
JeanSpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01bfd4
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01bfd4
	btst #3,($bf,a0)
	bne.w loc_01bfd4
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01beba
	cmpi.b #0,($149,a0)
	bne.b loc_01be50
	moveq #$23,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.b loc_01be50
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$186,d7
	move.b #$7e,d6
	add.b d0,d6
	bra.w loc_01bf7c

loc_01be50:
	move.b ($b1,a0),d0
	andi.b #$f0,d0
	cmpi.b #$f0,d0
	bne.b loc_01be64
	move.b #$c,($b4,a0)

loc_01be64:
	cmpi.b #6,($b4,a0)
	bcs.b loc_01beba
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	cmpi.b #0,d0
	beq.b loc_01be8e
	cmpi.b #8,($b4,a0)
	bcs.b loc_01beba

loc_01be8e:
	move.w #$187,d7
	add.w d0,d7
	move.b #$92,d6
	add.b d0,d6
	cmpi.w #5,($d0,a0)
	bls.w loc_01bfc6
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01beba
	btst #2,($12b,a0)
	bne.w loc_01bfc6
	bra.w loc_01bf7c

loc_01beba:
	move.b ($b1,a0),d7
	lsr.b #4,d7
	move.b d7,d0
	andi.b #$c,d0
	beq.w loc_01bfd4
	moveq #$24,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.b loc_01bf02
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.w #2,d0
	move.w #$189,d7
	add.w d0,d7
	move.b #$80,d6
	add.b d0,d6
	bra.w loc_01bf7c

loc_01bf02:
	moveq #$25,d6
	moveq #$40,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.b loc_01bf30
	moveq #$26,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01bf30
	move.w #$18d,d7
	move.b #$a8,d6
	bra.w loc_01bf7c

loc_01bf30:
	move.b ($b0,a0),d0
	andi.b #$c0,d0
	beq.w loc_01bfd4
	moveq #$a,d0
	btst #0,($bd,a0)
	beq.b loc_01bf48
	moveq #6,d0

loc_01bf48:
	move.b ($30,a0),d1
	andi.b #$f,d1
	cmp.b d0,d1
	bne.w loc_01bfd4
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.w #2,d0
	move.w #$18b,d7
	add.w d0,d7
	move.b #$82,d6
	add.b d0,d6
	bra.w loc_01bfa2

loc_01bf7c:
	cmpi.w #5,($d0,a0)
	bls.w loc_01bfc6
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01bfd4
	btst #3,($12b,a0)
	beq.b loc_01bfd4
	btst #5,($be,a0)
	beq.b loc_01bfd4
	bra.b loc_01bfc6

loc_01bfa2:
	cmpi.w #5,($d0,a0)
	bls.b loc_01bfc6
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01bfd4
	movea.l ($14,a0),a1
	cmpi.b #0,($14c,a1)
	bne.b loc_01bfd4
	btst #2,($12b,a0)
	beq.b loc_01bfd4

loc_01bfc6:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01bfd4:
	rts

;##############################################################################
MarstoriusSpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01c1f2
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01c1f2
	btst #3,($bf,a0)
	bne.w loc_01c176
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01c0ca
	moveq #$a,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	beq.b loc_01c01e
	moveq #$b,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01c032

loc_01c01e:
	move.b #$28,($14f,a0)
	move.b ($b1,a0),d2
	jsr loc_0163c8
	bra.w loc_01c19a

loc_01c032:
	moveq #$e,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	beq.b loc_01c052
	moveq #$2c,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01c05e

loc_01c052:
	move.w #$1c5,d7
	move.b #$a0,d6
	bra.w loc_01c19a

loc_01c05e:
	moveq #$28,d6
	moveq #$48,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.b loc_01c094
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$1b7,d7
	add.w d0,d7
	move.b #$84,d6
	add.b d0,d6
	bra.w loc_01c19a

loc_01c094:
	moveq #$29,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.w loc_01c0ca
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$1b9,d7
	move.b #$86,d6
	add.b d0,d6
	bra.w loc_01c19a

loc_01c0ca:
	move.b d7,d0
	andi.b #$c,d0
	beq.w loc_01c1f2
	moveq #$2a,d6
	moveq #$48,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.b loc_01c10a
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.b #2,d0
	move.w #$1bb,d7
	move.b #$88,d6
	add.b d0,d6
	bra.w loc_01c19a

loc_01c10a:
	moveq #$2b,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.w loc_01c146
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.b #2,d0
	move.w #$1bf,d7
	add.w d0,d7
	add.w d0,d7
	move.b #$8a,d6
	add.b d0,d6
	add.b d0,d6
	bra.b loc_01c19a

loc_01c146:
	moveq #9,d0
	btst #0,($bd,a0)
	beq.b loc_01c152
	moveq #5,d0

loc_01c152:
	move.b ($30,a0),d1
	andi.b #$f,d1
	cmp.b d0,d1
	bne.w loc_01c1f2
	btst #7,($b0,a0)
	beq.w loc_01c1f2
	move.w #$1b6,d7
	move.b #$ab,d6
	bra.w loc_01c1c0

loc_01c176:
	btst #1,($30,a0)
	beq.b loc_01c1f2
	btst #5,($b0,a0)
	beq.b loc_01c18c
	move.w #$1be,d7
	bra.b loc_01c1c0

loc_01c18c:
	btst #7,($b0,a0)
	beq.b loc_01c1f2
	move.w #$1bd,d7
	bra.b loc_01c1c0

loc_01c19a:
	cmpi.w #5,($d0,a0)
	bls.w loc_01c1e4
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01c1f2
	btst #3,($12b,a0)
	beq.b loc_01c1f2
	btst #5,($be,a0)
	beq.b loc_01c1f2
	bra.b loc_01c1e4

loc_01c1c0:
	cmpi.w #5,($d0,a0)
	bls.b loc_01c1e4
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01c1f2
	movea.l ($14,a0),a1
	cmpi.b #0,($14c,a1)
	bne.b loc_01c1f2
	btst #2,($12b,a0)
	beq.b loc_01c1f2

loc_01c1e4:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01c1f2:
	rts

;##############################################################################
YungmieSpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01c3c0
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01c3c0
	btst #3,($bf,a0)
	beq.w loc_01c2e4
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01c25a
	cmpi.b #0,($149,a0)
	bne.w loc_01c25a
	moveq #$2d,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.w loc_01c25a
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$1e5,d7
	move.b #$52,d6
	add.b d0,d6
	bra.w loc_01c358

loc_01c25a:
	move.w #8,d2
	moveq #0,d3
	move.w $103424,d0
	addi.w #$a0,d0
	move.w ($c0,a0),d1
	sub.w d1,d0
	bpl.w loc_01c276
	neg.w d0

loc_01c276:
	bcc.b loc_01c27c
	moveq #4,d2
	moveq #1,d3

loc_01c27c:
	cmpi.w #$78,d0
	bcs.w loc_01c298
	move.b ($30,a0),d0
	and.b d2,d0
	beq.b loc_01c298
	move.w #$1ea,d7
	move.b #$58,d6
	bra.w loc_01c37e

loc_01c298:
	lea.l loc_016a14,a2
	move.w ($d0,a0),d0
	add.w d0,d0
	add.w d0,d0
	move.b (a2,d0.w),d2
	btst #3,d2
	beq.w loc_01c3c0
	move.b ($b0,a0),d0
	andi.w #$f0,d0
	beq.w loc_01c3c0
	btst #7,d0
	beq.b loc_01c2da
	btst #1,($30,a0)
	beq.b loc_01c2da
	jsr loc_016454
	move.w #$1eb,d7
	bra.w loc_01c3a2

loc_01c2da:
	jsr loc_01644c
	bra.w loc_01c3a2

loc_01c2e4:
	move.b d7,d0
	andi.b #$c,d0
	beq.w loc_01c324
	moveq #$2e,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01c324
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.w #2,d0
	move.w #$1e6,d7
	add.w d0,d7
	move.b #$54,d6
	add.b d0,d6
	bra.w loc_01c358

loc_01c324:
	cmpi.b #6,($b4,a0)
	bcs.w loc_01c3c0
	cmpi.b #6,($b5,a0)
	bcs.w loc_01c3c0
	move.w #$1e8,d7
	move.b #$56,d6
	cmpi.w #5,($d0,a0)
	bls.b loc_01c3a2
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01c3c0
	btst #2,($12b,a0)
	bne.b loc_01c3a2

loc_01c358:
	cmpi.w #5,($d0,a0)
	bls.w loc_01c3a2
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01c3c0
	btst #3,($12b,a0)
	beq.b loc_01c3c0
	btst #5,($be,a0)
	beq.b loc_01c3c0
	bra.b loc_01c3a2

loc_01c37e:
	cmpi.w #5,($d0,a0)
	bls.b loc_01c3a2
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01c3c0
	movea.l ($14,a0),a1
	cmpi.b #0,($14c,a1)
	bne.b loc_01c3c0
	btst #2,($12b,a0)
	beq.b loc_01c3c0

loc_01c3a2:
	cmpi.w #$1ea,d7
	bne.b loc_01c3b2
	bclr #0,($21,a0)
	or.b d3,($21,a0)

loc_01c3b2:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01c3c0:
	rts

;##############################################################################
ZazieSpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01c5b6
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01c5b6
	btst #3,($bf,a0)
	bne.w loc_01c5b6
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01c49c
	moveq #$32,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01c430
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$217,d7
	add.w d0,d7
	move.b #$59,d6
	move.w ($d0,a0),d0
	subq.w #1,d0
	bclr #0,d0
	cmpi.w #$218,d0
	bne.w loc_01c55e
	addq.b #1,d6
	bra.w loc_01c57a

loc_01c430:
	move.b ($b1,a0),d0
	andi.b #$f0,d0
	cmpi.b #$f0,d0
	bne.b loc_01c444
	move.b #$c,($b4,a0)

loc_01c444:
	cmpi.b #6,($b4,a0)
	bcs.b loc_01c49c
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	cmpi.b #0,d0
	beq.b loc_01c46e
	cmpi.b #8,($b4,a0)
	bcs.b loc_01c49c

loc_01c46e:
	move.w #$215,d7
	add.w d0,d7
	move.b #$94,d6
	add.b d0,d6
	cmpi.w #5,($d0,a0)
	bls.w loc_01c5a8
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01c5b6
	btst #2,($12b,a0)
	bne.w loc_01c5a8
	bra.w loc_01c55e

loc_01c49c:
	move.b d7,d0
	andi.b #$c,d0
	beq.w loc_01c544
	moveq #$33,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01c4d6
	move.w #$220,d7
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	lea.l loc_016488,a1
	move.b (a1,d0.w),d0
	subq.w #2,d0
	add.b d0,d7
	bra.w loc_01c55e

loc_01c4d6:
	moveq #$34,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01c50c
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.w #2,d0
	move.w #$219,d7
	add.w d0,d7
	move.b #$5a,d6
	add.b d0,d6
	bra.w loc_01c55e

loc_01c50c:
	moveq #$35,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01c544
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.w #2,d0
	add.w d0,d0
	move.w #$21b,d7
	add.w d0,d7
	move.b #$5c,d6
	add.b d0,d6
	bra.w loc_01c55e

loc_01c544:
	btst #5,($b0,a0)
	beq.b loc_01c5b6
	move.b ($30,a0),d0
	andi.b #$f,d0
	bne.b loc_01c5b6
	move.w #$21f,d7
	bra.w loc_01c584

loc_01c55e:
	cmpi.w #5,($d0,a0)
	bls.w loc_01c5a8
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01c5b6
	btst #5,($be,a0)
	beq.b loc_01c5b6

loc_01c57a:
	btst #3,($12b,a0)
	beq.b loc_01c5b6
	bra.b loc_01c5a8

loc_01c584:
	cmpi.w #5,($d0,a0)
	bls.b loc_01c5a8
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01c5b6
	movea.l ($14,a0),a1
	cmpi.b #0,($14c,a1)
	bne.b loc_01c5b6
	btst #2,($12b,a0)
	beq.b loc_01c5b6

loc_01c5a8:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01c5b6:
	rts

;##############################################################################
ClownSpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01c746
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01c746
	btst #3,($bf,a0)
	bne.w loc_01c6ea
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01c664
	moveq #$3a,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01c628
	moveq #$3a,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.b loc_01c628
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	add.b d0,d0
	move.w #$24e,d7
	add.w d0,d7
	move.b #$71,d6
	add.b d0,d6
	bra.w loc_01c6ee

loc_01c628:
	cmpi.b #0,($149,a0)
	bne.b loc_01c664
	moveq #$37,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.b loc_01c664
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$247,d7
	move.b #$63,d6
	add.b d0,d6
	bra.w loc_01c6ee

loc_01c664:
	move.b ($b1,a0),d7
	lsr.b #4,d7
	move.b d7,d0
	andi.b #$c,d0
	beq.w loc_01c746
	moveq #$38,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.b loc_01c6ae
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.w #2,d0
	move.w #$248,d7
	move.b #$65,d6
	add.b d0,d6
	add.b d0,d6
	add.b d0,d6
	bra.w loc_01c6ee

loc_01c6ae:
	moveq #$39,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.w loc_01c746
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.w #2,d0
	move.w #$24b,d7
	move.b #$6b,d6
	add.b d0,d6
	add.b d0,d6
	add.b d0,d6
	bra.w loc_01c6ee

loc_01c6ea:
	bra.w loc_01c746

loc_01c6ee:
	cmpi.w #5,($d0,a0)
	bls.w loc_01c738
	cmpi.w #$20,($d0,a0)
	bcs.w loc_01c746
	btst #3,($12b,a0)
	beq.b loc_01c746
	btst #5,($be,a0)
	beq.b loc_01c746
	bra.b loc_01c738


	cmpi.w #5,($d0,a0)
	bls.b loc_01c738
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01c746
	movea.l ($14,a0),a1
	cmpi.b #0,($14c,a1)
	bne.b loc_01c746
	btst #2,($12b,a0)
	beq.b loc_01c746

loc_01c738:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01c746:
	rts

;##############################################################################
KarnovSpecial:
	cmpi.b #0,($14d,a0)
	bne.w loc_01c95c
	move.b ($b1,a0),d7
	lsr.b #4,d7
	beq.w loc_01c95c
	btst #3,($bf,a0)
	bne.w loc_01c81a
	cmpi.b #0,($149,a0)
	bne.b loc_01c7da
	moveq #$3d,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01c7a0
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	move.b (a1,d0.w),d0
	move.w #$276,d7
	add.w d0,d7
	lsr.b #1,d0
	move.b #$78,d6
	add.b d0,d6
	bra.w loc_01c908

loc_01c7a0:
	move.b d7,d0
	andi.b #3,d0
	beq.b loc_01c7da
	moveq #$3c,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01c7da
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$275,d7
	move.b #$76,d6
	add.b d0,d6
	bra.w loc_01c908

loc_01c7da:
	move.b d7,d0
	andi.b #$c,d0
	beq.b loc_01c84e
	moveq #$3e,d6
	moveq #$28,d5
	jsr loc_0166fc
	cmpi.l #0,d6
	bne.w loc_01c84e
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #$c,d0
	move.b (a1,d0.w),d0
	subq.b #2,d0
	move.w #$27a,d7
	move.b #$7a,d6
	add.w d0,d6
	bra.w loc_01c908

loc_01c81a:
	lea.l loc_016a14,a2
	move.w ($d0,a0),d0
	add.w d0,d0
	add.w d0,d0
	move.b (a2,d0.w),d2
	btst #3,d2
	beq.w loc_01c84e
	move.b ($b0,a0),d0
	andi.w #$f0,d0
	beq.w loc_01c84e
	move.b ($b0,a0),d2
	jsr loc_01644c
	bra.w loc_01c94e

loc_01c84e:
	move.b d7,d0
	andi.b #3,d0
	beq.w loc_01c8dc
	moveq #$3f,d6
	jsr SpecialMoveInputs
	cmpi.l #0,d6
	bne.b loc_01c8dc
	lea.l loc_016488,a1
	move.b ($b1,a0),d0
	lsr.b #4,d0
	andi.w #3,d0
	move.b (a1,d0.w),d0
	move.w #$27e,d7
	add.w d0,d7
	add.w d0,d7
	move.b #$90,d6
	btst #3,($bf,a0)
	bne.w loc_01c908
	cmpi.w #5,($d0,a0)
	bls.b loc_01c8b8
	cmpi.w #$269,($d0,a0)
	bne.w loc_01c95c
	btst #3,($12b,a0)
	beq.w loc_01c95c
	btst #5,($be,a0)
	beq.w loc_01c95c

loc_01c8b8:
	bset #3,($bf,a0)
	move.l #$90000,d0
	move.l d0,($c4,a0)
	moveq #0,d0
	move.l d0,($c8,a0)
	move.l #$100000,d0
	move.l d0,($cc,a0)
	bra.w loc_01c94e

loc_01c8dc:
	btst #7,($b0,a0)
	beq.w loc_01c95c
	move.b ($30,a0),d0
	btst #3,($bf,a0)
	bne.w loc_01c95c
	btst #1,d0
	beq.w loc_01c95c
	move.w #$26b,d7
	move.b #$7c,d6
	bra.w loc_01c92a

loc_01c908:
	cmpi.w #5,($d0,a0)
	bls.b loc_01c94e
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01c95c
	btst #3,($12b,a0)
	beq.b loc_01c95c
	btst #5,($be,a0)
	beq.b loc_01c95c
	bra.b loc_01c94e

loc_01c92a:
	cmpi.w #5,($d0,a0)
	bls.b loc_01c94e
	cmpi.w #$20,($d0,a0)
	bcs.b loc_01c95c
	movea.l ($14,a0),a1
	cmpi.b #0,($14c,a1)
	bne.b loc_01c95c
	btst #2,($12b,a0)
	beq.b loc_01c95c

loc_01c94e:
	move.b d6,($12d,a0)
	move.w d7,($d0,a0)
	bclr #0,($bf,a0)

loc_01c95c:
	rts

;##############################################################################
loc_01c95e:
	btst #0,($bf,a0)
	bne.b loc_01c990
	bset #0,($bf,a0)
	jsr loc_019476
	cmpi.l #loc_05a000,($124,a0)
	beq.w loc_01ca22
	move.b ($bd,a0),d0
	andi.w #1,d0
	bclr #0,($21,a0)
	or.b d0,($21,a0)

loc_01c990:
	move.b #0,($13e,a0)
	btst #0,($13d,a0)
	beq.b loc_01c9a6
	move.b ($b4,a0),d0
	or.b d0,($13e,a0)

loc_01c9a6:
	btst #1,($13d,a0)
	beq.b loc_01c9b6
	move.b ($b5,a0),d0
	or.b d0,($13e,a0)

loc_01c9b6:
	moveq #3,d1
	movea.l a0,a2
	adda.l #$130,a2

loc_01c9c0:
	move.b ($13e,a0),d0
	cmp.b (a2)+,d0
	bcs.b loc_01c9da
	cmpi.b #1,($121,a0)
	bcs.b loc_01c9da
	subi.b #1,($121,a0)
	dbra d1,loc_01c9c0

loc_01c9da:
	jsr loc_019628
	btst #2,($122,a0)
	bne.b loc_01ca22
	btst #5,($12e,a0)
	beq.b loc_01c9fa
	move.l ($134,a0),d0
	jsr loc_01a7f0

loc_01c9fa:
	subi.w #1,($138,a0)
	bls.b loc_01ca22
	move.b ($13e,a0),d0
	cmp.b ($13c,a0),d0
	bcs.b loc_01ca20
	addi.w #1,($138,a0)
	move.w ($13a,a0),d0
	cmp.w ($138,a0),d0
	bcc.b loc_01ca20
	move.w d0,($138,a0)

loc_01ca20:
	bra.b loc_01ca50

loc_01ca22:
	move.w ($d0,a0),d0
	addi.w #1,d0
	bclr #0,d0
	cmpi.w #$188,d0
	bne.b loc_01ca4a
	move.b #$ca,$1068c6
	move.b #$18,$1068c7
	jsr loc_00e054

loc_01ca4a:
	jsr loc_0195e4

loc_01ca50:
	rts

;##############################################################################
loc_01ca52:
	lea.l $103770,a5
	lea.l $1037a0,a6
	move.w $101004,d0
	cmpi.b #0,d0
	bne.w loc_01cb0a
	move.w #1,$101004
	jsr FIX_CLEAR
	lea.l player1mem,a0
	lea.l $10376f,a1
	jsr loc_01ddc4
	move.b #1,$103831
	move.b #$41,$103832
	move.b #$41,$103833
	move.b #$41,$103834
	move.b #$43,$103835
	move.b #$47,$103836
	move.b #$47,$103837
	move.b #$45,$103838
	move.b #5,$103839
	move.b #$33,$10383a
	move.b #3,($b4,a5)
	move.b #$c,($b5,a5)
	move.w #$80,$1037d0
	move.w #$130,$1037d2
	move.w loc_090004,$10384e
	subi.w #1,$10384e

loc_01cb0a:
	jsr loc_01dd30
	btst #0,BIOS_STATCHANGE
	beq.b loc_01cb40
	bchg.b #1,$103840
	beq.b loc_01cb40
	move.b #0,$103849
	bclr #0,$103841
	lea.l loc_01d441,a2
	jsr loc_01cc6e

loc_01cb40:
	btst #1,$103840
	bne.b loc_01cb5e
	moveq #0,d0
	move.b $103844,d0
	add.w d0,d0
	add.w d0,d0
	movea.l loc_01cb78(pc,d0.w),a0
	jsr (a0)
	bra.b loc_01cb70

loc_01cb5e:
	moveq #0,d0
	move.b $103849,d0
	add.w d0,d0
	add.w d0,d0
	movea.l loc_01cbc0(pc,d0.w),a0
	jsr (a0)

loc_01cb70:
	jsr loc_020562
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01cb78:
	dc.l loc_01de96,loc_01e09e,loc_01e1d2,loc_01e238
	dc.l loc_01e318,loc_01e3fa,loc_01e3fa,loc_01e4d4
	dc.l loc_01e584,loc_01e850,loc_01e958,loc_01eab8
	dc.l loc_01ef40,loc_01f19c,loc_01f30a,loc_01ec1a
	dc.l loc_01edb6,loc_01e6fa

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01cbc0:
	dc.l loc_020a88,loc_020b44,loc_020c7c,loc_020d24
	dc.l loc_020e48

;##############################################################################
loc_01cbd4:
	movea.l $101420,a1
	lea.l loc_01d2e8,a0
	add.w d0,d0
	add.w d0,d0
	movea.l (a0,d0.w),a0
	move.w (a0)+,d2
	moveq #$c,d0
	lsl.w d0,d1

loc_01cbee:
	moveq #0,d0
	move.b (a0)+,d0
	cmpi.b #$ff,d0
	beq.b loc_01cc0a
	move.w d2,(a1)+
	or.w d1,d0
	ori.w #$300,d0
	move.w d0,(a1)+
	addi.l #$20,d2
	bra.b loc_01cbee
 
loc_01cc0a:
	move.l a1,$101420
	rts

;##############################################################################
loc_01cc12:
	movea.l $101420,a1
	lea.l loc_01d2e8,a0
	add.w d0,d0
	add.w d0,d0
	movea.l (a0,d0.w),a0
	move.w (a0)+,d2

loc_01cc28:
	moveq #0,d0
	move.b (a0)+,d0
	cmpi.b #$ff,d0
	beq.b loc_01cc40
	move.w d2,(a1)+
	move.w #$320,(a1)+
	addi.l #$20,d2
	bra.b loc_01cc28
 
loc_01cc40:
	move.l a1,$101420
	rts

;##############################################################################
loc_01cc48:
	move.b #2,d4
	move.b (a3),d5
	moveq #0,d6

loc_01cc50:
	cmpi.b #$ff,(a2)
	beq.b loc_01cc6c
	cmp.b d5,d6
	bne.b loc_01cc5e
	move.b d3,d1
	bra.b loc_01cc60

loc_01cc5e:
	move.b d4,d1

loc_01cc60:
	moveq #0,d0
	move.b (a2)+,d0
	jsr loc_01cbd4(pc)
	addq.b #1,d6
	bra.b loc_01cc50

loc_01cc6c:
	rts

;##############################################################################
loc_01cc6e:
	moveq #0,d6

loc_01cc70:
	cmpi.b #$ff,(a2)
	beq.b loc_01cc82
	moveq #0,d0
	move.b (a2)+,d0
	jsr loc_01cc12(pc)
	addq.b #1,d6
	bra.b loc_01cc70

loc_01cc82:
	rts

;##############################################################################
loc_01cc84:
	movea.l $101420,a1
	lea.l loc_01d45a,a0
	moveq #$c,d5
	lsl.w d5,d3
	lsl.w #5,d1
	add.w d2,d1
	addi.w #$7000,d1
	moveq #0,d2
	move.b d4,d2
	subq.b #1,d2
	lsl.w #5,d2
	add.w d2,d1

loc_01cca6:
	subq.b #1,d4
	bcs.b loc_01ccca
	move.w d1,(a1)+
	move.l d0,d2
	andi.l #$f,d2
	move.b (a0,d2.w),d2
	or.w d3,d2
	ori.w #$300,d2
	move.w d2,(a1)+
	subi.l #$20,d1
	lsr.l #4,d0
	bra.b loc_01cca6

loc_01ccca:
	move.l a1,$101420
	rts

;##############################################################################
loc_01ccd2:
	movea.l $101420,a1
	lea.l loc_01d45a,a0
	moveq #$c,d5
	lsl.w d5,d3
	moveq #2,d6
	lsl.w d5,d6
	lsl.w #5,d1
	add.w d2,d1
	addi.w #$7000,d1
	moveq #7,d5

loc_01ccf0:
	move.w d1,(a1)+
	btst.l d5,d0
	bne.b loc_01ccfa
	moveq #0,d2
	bra.b loc_01ccfc

loc_01ccfa:
	moveq #1,d2

loc_01ccfc:
	move.b (a0,d2.w),d2
	cmp.b d4,d5
	bne.b loc_01cd08
	or.w d3,d2
	bra.b loc_01cd0a

loc_01cd08:
	or.w d6,d2

loc_01cd0a:
	ori.w #$300,d2
	move.w d2,(a1)+
	addi.l #$20,d1
	dbra d5,loc_01ccf0
	move.l a1,$101420
	rts

;##############################################################################
loc_01cd22:
	movea.l $101420,a1
	lea.l loc_01d72e,a0
	move.w $103860,d0

loc_01cd34:
	cmpi.l #$60,d0
	bcs.b loc_01cd44
	subi.l #$60,d0
	bra.b loc_01cd34

loc_01cd44:
	lsl.l #4,d0
	adda.l d0,a0
	move.w #$709b,d2
	moveq #2,d1
	moveq #$c,d0
	lsl.w d0,d1
	moveq #$f,d3

loc_01cd54:
	moveq #0,d0
	move.b (a0)+,d0
	move.w d2,(a1)+
	or.w d1,d0
	ori.w #$300,d0
	move.w d0,(a1)+
	addi.w #$20,d2
	dbra d3,loc_01cd54
	move.l a1,$101420
	rts

;##############################################################################
loc_01cd72:
	move.l #loc_037000+$10,d0
	moveq #0,d1
	move.w $10384c,d1
	move.l d1,d2
	lsl.l #5,d1
	lsl.l #4,d2
	add.l d1,d0
	add.l d2,d0
	move.l d0,$103850
	jsr loc_01ddd8
	lea.l $1037a4,a0
	moveq #0,d0
	move.b $103848,d0
	add.b d0,d0
	add.b d0,d0
	move.l (a0,d0.w),d0
	move.l d0,$103860
	move.w $1037a0,d0
	move.w #$1c,d1
	move.w #7,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84(pc)
	move.b $1037a2,d0
	move.w #$1f,d1
	move.w #9,d2
	move.b #2,d3
	move.b #1,d4
	jsr loc_01cc84(pc)
	move.b $1037a3,d0
	move.w #$23,d1
	move.w #9,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	move.b $103860,d0
	move.w #$1f,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	move.b $103861,d0
	move.w #$23,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	move.b $103862,d0
	move.w #$1f,d1
	move.w #$19,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	move.b $103863,d0
	move.w #$23,d1
	move.w #$19,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	rts

;##############################################################################
loc_01ce6a:
	moveq #0,d0
	move.w $103860,d0
	add.w d0,d0
	lea.l loc_05a000,a0
	adda.l d0,a0
	move.l a0,$103868
	moveq #0,d1
	move.w (a0),d1
	cmpi.l #0,d1
	bne.b loc_01ceb8
	moveq #0,d0
	move.b d0,$103864
	move.w d0,$10384c
	move.b d0,$10384e
	move.b d0,$10384f
	move.b d0,$103865
	move.l d0,$10386c
	bra.w loc_01cf00

loc_01ceb8:
	lea.l loc_05a000,a0
	adda.l d1,a0
	move.l a0,$10386c
	movea.l a0,a1
	moveq #0,d0

loc_01ceca:
	addq.b #1,d0
	btst #0,(3,a1)
	bne.b loc_01cedc
	adda.l #4,a1
	bra.b loc_01ceca

loc_01cedc:
	move.b d0,$103865
	move.b #0,$103864
	move.w (a0),$10384c
	move.b (2,a0),$10384e
	move.b (3,a0),$10384f

loc_01cf00:
	move.b $103864,d0
	move.w #$1c,d1
	move.w #8,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	move.b $103865,d0
	move.w #$1f,d1
	move.w #8,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #$b,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84(pc)
	move.w loc_037000,d0
	move.w #$21,d1
	move.w #$b,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84(pc)
	move.b $10384e,d0
	move.w #$1c,d1
	move.w #$e,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	moveq #0,d0
	move.b $10384f,d0
	move.w #$1c,d1
	move.w #$11,d2
	move.b #2,d3
	move.b $103845,d4
	jsr loc_01ccd2(pc)
	move.l #loc_037000+$10,d0
	moveq #0,d1
	move.w $10384c,d1
	move.l d1,d2
	lsl.l #5,d1
	lsl.l #4,d2
	add.l d1,d0
	add.l d2,d0
	move.l d0,$103850
	jsr loc_01ddd8
	jsr loc_01cd22(pc)
	rts

;##############################################################################
loc_01cfca:
	movea.l $103868,a0
	cmpi.l #0,(a0)
	beq.w loc_01d09c
	moveq #0,d0
	movea.l $103868,a0
	move.w (a0),d0
	lea.l loc_05a000,a0
	adda.l d0,a0
	moveq #0,d0
	move.b $103864,d0
	add.w d0,d0
	add.w d0,d0
	adda.l d0,a0
	move.l a0,$10386c
	move.b $103864,d0
	cmp.b $103865,d0
	beq.w loc_01d09c
	move.w (a0),$10384c
	move.b (2,a0),$10384e
	move.b (3,a0),$10384f
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #$b,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84(pc)
	move.b $10384e,d0
	move.w #$1c,d1
	move.w #$e,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	moveq #0,d0
	move.b $10384f,d0
	move.w #$1c,d1
	move.w #$11,d2
	move.b #2,d3
	move.b $103845,d4
	jsr loc_01ccd2(pc)
	move.l #loc_037000+$10,d0
	moveq #0,d1
	move.w $10384c,d1
	move.l d1,d2
	lsl.l #5,d1
	lsl.l #4,d2
	add.l d1,d0
	add.l d2,d0
	move.l d0,$103850
	jsr loc_01ddd8

loc_01d09c:
	rts

;##############################################################################
loc_01d09e:
	moveq #0,d0
	move.b $1037f4,d0
	add.w d0,d0
	lea.l loc_060000,a0
	adda.l d0,a0
	move.l a0,$103800
	moveq #0,d1
	move.w (a0),d1
	cmpi.l #0,d1
	bne.b loc_01d0f8
	moveq #0,d0
	move.b d0,$1037f5
	move.b d0,$1037fb
	move.w d0,$1037f6
	move.b d0,$1037f8
	move.b d0,$1037f9
	move.b d0,$1037fa
	move.b d0,$1037fc
	move.l d0,$103804
	bra.w loc_01d15a

loc_01d0f8:
	lea.l loc_060000,a0
	adda.l d1,a0
	move.l a0,$103804
	movea.l a0,a1
	moveq #0,d1
	move.b $1037fb,d1
	add.w d1,d1
	add.w d1,d1
	moveq #0,d0

loc_01d116:
	addq.b #1,d0
	btst #7,(a1)
	bne.b loc_01d126
	adda.l #$38,a1
	bra.b loc_01d116

loc_01d126:
	move.b d0,$1037fc
	move.b #0,$1037f5
	move.w (a0,d1.w),d0
	andi.w #$1ff,d0
	move.w d0,$1037f6
	move.b (2,a0,d1.w),$1037f8
	move.b (3,a0,d1.w),$1037f9
	move.b (a0,d1.w),$1037fa

loc_01d15a:
	move.b $1037f5,d0
	move.w #$23,d1
	move.w #$14,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	move.b $1037fb,d0
	move.w #$23,d1
	move.w #$15,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	move.w $1037f6,d0
	move.w #$22,d1
	move.w #$16,d2
	move.b #2,d3
	move.b #3,d4
	jsr loc_01cc84(pc)
	move.b $1037f8,d0
	move.w #$1f,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	move.b $1037f9,d0
	move.w #$23,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	moveq #0,d0
	move.b $1037fa,d0
	move.w #$1f,d1
	move.w #$18,d2
	move.b #2,d3
	move.b $1037f3,d4
	jsr loc_01ccd2(pc)
	rts

;##############################################################################
loc_01d1fc:
	movea.l $103800,a0
	cmpi.l #0,(a0)
	beq.w loc_01d09c
	moveq #0,d0
	movea.l $103800,a0
	move.w (a0),d0
	lea.l loc_060000,a0
	adda.l d0,a0
	moveq #0,d0
	move.b $1037f5,d0
	lsl.w #3,d0
	adda.l d0,a0
	lsl.w #1,d0
	adda.l d0,a0
	lsl.w #1,d0
	adda.l d0,a0
	move.l a0,$103804
	move.b $1037f5,d0
	cmp.b $1037fc,d0
	beq.w loc_01d2e6
	moveq #0,d1
	move.b $1037fb,d1
	add.w d1,d1
	add.w d1,d1
	move.w (a0,d1.w),d0
	andi.w #$1ff,d0
	move.w d0,$1037f6
	move.b (2,a0,d1.w),$1037f8
	move.b (3,a0,d1.w),$1037f9
	move.b (a0,d1.w),$1037fa
	move.w $1037f6,d0
	move.w #$22,d1
	move.w #$16,d2
	move.b #2,d3
	move.b #3,d4
	jsr loc_01cc84(pc)
	move.b $1037f8,d0
	move.w #$1f,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	move.b $1037f9,d0
	move.w #$23,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84(pc)
	moveq #0,d0
	move.b $1037fa,d0
	move.w #$1f,d1
	move.w #$18,d2
	move.b #2,d3
	move.b $1037f3,d4
	jsr loc_01ccd2(pc)

loc_01d2e6:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01d2e8:
	dc.l loc_01d46c,loc_01d47a,loc_01d486
	dc.l loc_01d48e,loc_01d496,loc_01d4a0
	dc.l loc_01d4aa,loc_01d4b2,loc_01d4ba
	dc.l loc_01d4c4,loc_01d4ce loc_01d4d2
	dc.l loc_01d4dc,loc_01d4e0,loc_01d4ea
	dc.l loc_01d4f4,loc_01d4fa,loc_01d504
	dc.l loc_01d50c,loc_01d514,loc_01d51c
	dc.l loc_01d524,loc_01d52c,loc_01d534
	dc.l loc_01d540,loc_01d54c,loc_01d558
	dc.l loc_01d562,loc_01d56a,loc_01d572
	dc.l loc_01d57a,loc_01d584,loc_01d58a
	dc.l loc_01d590,loc_01d598,loc_01d5a2
	dc.l loc_01d5b0,loc_01d5be,loc_01d5cc
	dc.l loc_01d5cc,loc_01d5cc,loc_01d5cc
	dc.l loc_01d5d0,loc_01d5e0,loc_01d5f0
	dc.l loc_01d600,loc_01d610,loc_01d620
	dc.l loc_01d630,loc_01d63e,loc_01d64c
	dc.l loc_01d656,loc_01d65a,loc_01d664
	dc.l loc_01d668,loc_01d670,loc_01d67a
	dc.l loc_01d688,loc_01d69c,loc_01d6b0
	dc.l loc_01d6c4,loc_01d6c4,loc_01d6c4
	dc.l loc_01d6c4,loc_01d6d8,loc_01d6de
	dc.l loc_01d6e4,loc_01d6ea,loc_01d6f4
	dc.l loc_01d6fe,loc_01d708,loc_01d712
	dc.l loc_01d718,loc_01d71e,loc_01d726

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01d414:
	dc.b $01,$02,$ff

loc_01d417:
	dc.b $03,$04,$05,$06
	dc.b $07,$08,$ff

loc_01d41e:
	dc.b $09,$0b,$0d
	dc.b $0f,$1e,$ff

loc_01d424:
	dc.b $10,$11,$12,$13
	dc.b $14,$15,$16,$17
	dc.b $18,$19,$ff

loc_01d42f:
	dc.b $21,$22

loc_01d431:
	dc.b $1a,$1c
	dc.b $ff

loc_01d434:
	dc.b $1f,$20,$ff

loc_01d437:
	dc.b $09,$1e,$ff

loc_01d43a:
	dc.b $31,$32,$34,$36,$37,$1e,$ff

loc_01d441:
	dc.b $39,$3a,$3b,$3c,$ff

loc_01d446:
	dc.b $40,$41,$42,$ff

loc_01d44a:
	dc.b $43,$44,$45,$46
	dc.b $47,$48,$49,$ff

loc_01d452:
	dc.b $2a,$2b,$2c,$2d
	dc.b $2e,$2f,$49,$ff

loc_01d45a:
	dc.b "0123456789ABCDEFCD"
	
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01d46c:
	dc.w $71e3
	dc.b "GX4 HITGEN",$ff,$47

loc_01d47a:
	dc.w $7210
	dc.b "CONTINUE",$ff,$4e

loc_01d486:
	dc.w $7232
	dc.b "START",$ff

loc_01d48e:
	dc.w $7064
	dc.b "EDIT",$ff,$44

loc_01d496:
	dc.w $7065
	dc.b "INSERT",$ff,$45

loc_01d4a0:
	dc.w $7066
	dc.b "DELETE",$ff,$45

loc_01d4aa:
	dc.w $7067
	dc.b "COPY",$ff,$4f

loc_01d4b2:
	dc.w $7068
	dc.b "MOVE",$ff,$4f

loc_01d4ba:
	dc.w $7069
	dc.b "UPLOAD",$ff,$4f

loc_01d4c4:
	dc.w $7364
	dc.b "HIT No.",$ff

loc_01d4ce:
	dc.w $7405
	dc.b "/",$ff

loc_01d4d2:
	dc.w $7366
	dc.b "OBJ No.",$ff

loc_01d4dc:
	dc.w $7407
	dc.b "/",$ff

loc_01d4e0:
	dc.w $7368
	dc.b "SHADOW",$ff,$44

loc_01d4ea:
	dc.w $7389
	dc.b "No. /H",$ff,$20

loc_01d4f4:
	dc.w $736b
	dc.b "BOX",$ff

loc_01d4fa:
	dc.w $738c
	dc.b "OUTLINE",$ff

loc_01d504:
	dc.w $738d
	dc.b "HEAD",$ff,$45

loc_01d50c:
	dc.w $738e
	dc.b "ARM-L",$ff

loc_01d514:
	dc.w $738f
	dc.b "ARM-R",$ff

loc_01d51c:
	dc.w $7390
	dc.b "BODY",$ff,$4f

loc_01d524:
	dc.w $7391
	dc.b "LEG-L",$ff

loc_01d52c:
	dc.w $7392
	dc.b "LEG-R",$ff

loc_01d534:
	dc.w $7393
	dc.b "WEAKPOINT",$ff

loc_01d540:
	dc.w $7394
	dc.b "ATTACK   ",$ff

loc_01d54c:
	dc.w $7395
	dc.b "THROW    ",$ff

loc_01d558:
	dc.w $73b6
	dc.b "OFFSET",$ff,$53

loc_01d562:
	dc.w $73d7
	dc.b "H  /V",$ff

loc_01d56a:
	dc.w $73b8
	dc.b "SIZE",$ff,$49

loc_01d572:
	dc.w $73d9
	dc.b "H  /V",$ff

loc_01d57a:
	dc.w $737b
	dc.b "WRITE?",$ff,$54

loc_01d584:
	dc.w $745b
	dc.b "YES",$ff

loc_01d58a:
	dc.w $745c
	dc.b "N O",$ff

loc_01d590:
	dc.w $7394
	dc.b "  No.",$ff

loc_01d598:
	dc.w $7395
	dc.b "  H  /V",$ff

loc_01d5a2:
	dc.w $706b
	dc.b "HITDAT.HEX",$ff,$48

loc_01d5b0:
	dc.w $708c
	dc.b "TOP =      ",$ff

loc_01d5be:
	dc.w $708d
	dc.b "END =      ",$ff

loc_01d5cc:
	dc.w $7405
	dc.b ">",$ff

loc_01d5d0:
	dc.w $7373
	dc.b "            ",$ff,$20

loc_01d5e0:
	dc.w $7374
	dc.b "            ",$ff,$20

loc_01d5f0:
	dc.w $7375
	dc.b "            ",$ff,$20

loc_01d600:
	dc.w $7376
	dc.b "            ",$ff,$20

loc_01d610:
	dc.w $7377
	dc.b "            ",$ff,$20

loc_01d620:
	dc.w $7378
	dc.b "            ",$ff,$20

loc_01d630:
	dc.w $71e3
	dc.b "GX4 PTNGEN",$ff,$47

loc_01d63e:
	dc.w $7364
	dc.b "ACTION No.",$ff,$4e

loc_01d64c:
	dc.w $7367
	dc.b "PTN No.",$ff

loc_01d656:
	dc.w $73c8
	dc.b "/",$ff

loc_01d65a:
	dc.w $736a
	dc.b "HIT No.",$ff

loc_01d664:
	dc.w $740b
	dc.b "/",$ff

loc_01d668:
	dc.w $736d
	dc.b "TIMER",$ff

loc_01d670:
	dc.w $7370
	dc.b "STATUS",$ff,$54

loc_01d67a:
	dc.w $706b
	dc.b "ACTDAT.HEX",$ff,$48

loc_01d688:
	dc.w $706f
	dc.b "BOX PALETTE      ",$ff

loc_01d69c:
	dc.w $7070
	dc.b "BG  PALETTE      ",$ff

loc_01d6b0:
	dc.w $7071
	dc.b "ORIGIN MOVE      ",$ff

loc_01d6c4:
	dc.w $7072
	dc.b "REPEAT TIME      ",$ff

loc_01d6d8:
	dc.w $72f3
	dc.b "EDI",$ff

loc_01d6de:
	dc.w $72f4
	dc.b "INS",$ff

loc_01d6e4:
	dc.w $72f5
	dc.b "DEL",$ff

loc_01d6ea:
	dc.w $7373
	dc.b "NAG No.",$ff

loc_01d6f4:
	dc.w $7374
	dc.b "PTN No.",$ff

loc_01d6fe:
	dc.w $7375
	dc.b "PLAYER",$ff,$59

loc_01d708:
	dc.w $7376
	dc.b "HIT No.",$ff

loc_01d712:
	dc.w $7377
	dc.b "OF.",$ff

loc_01d718:
	dc.w $7378
	dc.b "STS",$ff

loc_01d71e:
	dc.w $7379
	dc.b "WRITE",$ff

loc_01d726:
	dc.w $73d7
	dc.b "H  /V",$ff


;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01d72e:
	dc.b "Neutral         "
	dc.b "Crouch          "
	dc.b "Squat           "
	dc.b "Forword         "
	dc.b "Backword        "
	dc.b "Stand Turn      "
	dc.b "Crouch Turn     "
	dc.b "Stand Guard     "
	dc.b "Crouch Guard    "
	dc.b "Vertical Jump   "
	dc.b "Forword Jump    "
	dc.b "Backword Jump   "
	dc.b "S.Head.Light Dmg"
	dc.b "S.Head.Heavy Dmg"
	dc.b "S.Body.Light Dmg"
	dc.b "S.Body.Heavy Dmg"
	dc.b "S.Legs.Light Dmg"
	dc.b "S.Legs.Heavy Dmg"
	dc.b "C.Head.Light Dmg"
	dc.b "C.Head.Heavy Dmg"
	dc.b "C.Legs.Light Dmg"
	dc.b "C.Legs.Heavy Dmg"
	dc.b "Head Blowing    "
	dc.b "Body Blowing    "
	dc.b "Head Bound      "
	dc.b "Body Bound      "
	dc.b "Jump Damage     "
	dc.b "Fire Damage     "
	dc.b "Get Up          "
	dc.b "Piyo Piyo       "
	dc.b "Win 1           "
	dc.b "Win 2           "
	dc.b "Draw            "
	dc.b "Back Step       "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01da2e:
	dc.b "Near Light Punch"
	dc.b "Near Heavy Punch"
	dc.b "Near Light Kick "
	dc.b "Near Heavy Kick "
	dc.b "Far Light Punch "
	dc.b "Far Heavy Punch "
	dc.b "Far Light Kick  "
	dc.b "Far Heavy Kick  "
	dc.b "Crouch L.Punch  "
	dc.b "Crouch H.Punch  "
	dc.b "Crouch L.Kick   "
	dc.b "Crouch H.Kick   "
	dc.b "V.Jump L.Punch  "
	dc.b "V.Jump H.Punch  "
	dc.b "V.Jump L.Kick   "
	dc.b "V.Jump H.Kick   "
	dc.b "S.Jump L.Punch  "
	dc.b "S.Jump H.Punch  "
	dc.b "S.Jump L.Kick   "
	dc.b "S.Jump H.Kick   "
	dc.b "Special 1       "
	dc.b "Special 2       "
	dc.b "Special 3       "
	dc.b "Special 4       "
	dc.b "Special 5       "
	dc.b "Special 6       "
	dc.b "Special 7       "
	dc.b "Special 8       "
	dc.b "Special 9       "
	dc.b "Special 11      "
	dc.b "Special 12      "
	dc.b "Special 13      "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "                "
	dc.b "  "

;##############################################################################
loc_01dd30:
	move.b BIOS_P1CURRENT,($b0,a5)
	move.b BIOS_P1CHANGE,($b1,a5)
	cmpi.b #0,($b1,a5)
	beq.b loc_01dd50
	move.b ($b5,a5),($b3,a5)
	bra.b loc_01dd58

loc_01dd50:
	subi.b #1,($b3,a5)
	beq.b loc_01dd62

loc_01dd58:
	move.b BIOS_P1CHANGE,($b2,a5)
	bra.b loc_01dd76

loc_01dd62:
	move.b BIOS_P1CURRENT,($b2,a5)
	andi.b #$cf,($b2,a5)
	move.b ($b4,a5),($b3,a5)

loc_01dd76:
	move.b BIOS_P2CURRENT,($b8,a5)
	move.b BIOS_P2CHANGE,($b9,a5)
	cmpi.b #0,($b9,a5)
	beq.b loc_01dd96
	move.b ($b5,a5),($bb,a5)
	bra.b loc_01dd9e

loc_01dd96:
	subi.b #1,($bb,a5)
	beq.b loc_01dda8

loc_01dd9e:
	move.b BIOS_P2CHANGE,($ba,a5)
	bra.b loc_01ddbc

loc_01dda8:
	move.b BIOS_P2CURRENT,($ba,a5)
	andi.b #$cf,($ba,a5)
	move.b ($b4,a5),($bb,a5)

loc_01ddbc:
	subi.b #1,($b6,a5)
	rts

;##############################################################################
loc_01ddc4:
	cmpa.l a0,a1
	bcs.b loc_01ddcc
	clr.l (a0)+
	bra.b loc_01ddc4

loc_01ddcc:
	rts

;##############################################################################
loc_01ddce:
	moveq #$b,d0

loc_01ddd0:
	move.l (a0)+,(a1)+
	dbra d0,loc_01ddd0
	rts

;##############################################################################
loc_01ddd8:
	movea.l $103850,a0
	movea.l loc_037000+4,a1
	cmpa.l a0,a1
	beq.b loc_01ddf8
	lea.l $1037a0,a1
	moveq #$b,d0

loc_01ddf0:
	move.l (a0)+,(a1)+
	dbra d0,loc_01ddf0
	bra.b loc_01de0a

loc_01ddf8:
	lea.l $1037a0,a1
	moveq #$b,d0

loc_01de00:
	move.l #0,(a1)+
	dbra d0,loc_01de00

loc_01de0a:
	rts

;##############################################################################
loc_01de0c:
	movea.l $103868,a0
	cmpi.w #0,(a0)
	beq.b loc_01de94
	move.b ($b0,a5),d0
	btst #6,d0
	bne.b loc_01de2e
	move.b ($b2,a5),d0
	btst #7,d0
	bne.b loc_01de2e
	bra.b loc_01de94

loc_01de2e:
	subi.b #1,$10384e
	bls.b loc_01de56
	move.b $10384e,d0
	move.w #$1c,d1
	move.w #$e,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	bra.b loc_01de94

loc_01de56:
	btst #0,$10384f
	beq.b loc_01de6a
	move.b #0,$103864
	bra.b loc_01de72

loc_01de6a:
	addi.b #1,$103864

loc_01de72:
	jsr loc_01cfca
	move.b $103864,d0
	move.w #$1c,d1
	move.w #8,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_01de94:
	rts

;##############################################################################
loc_01de96:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01ded8
	bset #0,d0
	move.b d0,$103840
	move.w #0,d0
	move.b #4,d1
	jsr loc_01cbd4
	move.b #0,$103845
	lea.l loc_01d414,a2
	move.b #3,d3
	lea.l $103845,a3
	jsr loc_01cc48

loc_01ded8:
	move.b ($b1,a5),d0
	btst #4,d0
	bne.b loc_01df36
	btst #0,d0
	bne.b loc_01def2
	btst #1,d0
	bne.b loc_01df08
	bra.w loc_01e09c

loc_01def2:
	cmpi.b #0,$103845
	beq.w loc_01e09c
	subi.b #1,$103845
	bra.b loc_01df1c
 
loc_01df08:
	cmpi.b #1,$103845
	beq.w loc_01e09c
	addi.b #1,$103845

loc_01df1c:
	lea.l loc_01d414,a2
	move.b #3,d3
	lea.l $103845,a3
	jsr loc_01cc48
	bra.w loc_01e09c

loc_01df36:
	cmpi.b #0,$103845
	beq.b loc_01df54
	move.w #$0,loc_037000
	move.l #loc_037000+$10,loc_037000+4
	bra.b loc_01df72

loc_01df54:
	move.l #loc_037000+$10,d0
	moveq #0,d1
	move.w loc_037000,d1
	move.l d1,d2
	lsl.l #5,d1
	lsl.l #4,d2
	add.l d1,d0
	add.l d2,d0
	move.l d0,loc_037000+4

loc_01df72:
	move.b #1,$103844
	bclr.b #0,$103840
	lea.l loc_01d414,a2
	jsr loc_01cc6e
	lea.l loc_01d417,a2
	move.b #2,d3
	lea.l $103845,a3
	jsr loc_01cc48
	lea.l loc_01d41e,a2
	move.b #2,d3
	lea.l $103845,a3
	jsr loc_01cc48
	lea.l loc_01d424,a2
	move.b #2,d3
	lea.l $103845,a3
	jsr loc_01cc48
	lea.l loc_01d431,a2
	move.b #2,d3
	lea.l $103845,a3
	jsr loc_01cc48
	lea.l loc_01d434,a2
	move.b #2,d3
	lea.l $103845,a3
	jsr loc_01cc48
	move.w #$a,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.w #$c,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.w #$e,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.w #$1b,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.w #$1d,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	move.w loc_037000,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	move.w $10384e,d0
	move.w #$21,d1
	move.w #7,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	jsr loc_01cd72

loc_01e09c:
	rts

;##############################################################################
loc_01e09e:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01e0c2
	bset #0,d0
	move.b d0,$103840
	move.b #0,$103845
	jsr loc_01cd72

loc_01e0c2:
	move.w loc_037000,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84

loc_01e0de:
	lea.l loc_01d417,a2
	move.b #3,d3
	lea.l $103845,a3
	jsr loc_01cc48
	move.w #$a,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.b ($b2,a5),d0
	btst #4,d0
	bne.b loc_01e15a
	btst #0,d0
	bne.b loc_01e11c
	btst #1,d0
	bne.b loc_01e130
	bra.w loc_01e190

loc_01e11c:
	cmpi.b #0,$103845
	beq.b loc_01e190
	subi.b #1,$103845
	bra.b loc_01e142

loc_01e130:
	cmpi.b #5,$103845
	beq.b loc_01e190
	addi.b #1,$103845

loc_01e142:
	lea.l loc_01d417,a2
	move.b #3,d3
	lea.l $103845,a3
	jsr loc_01cc48
	bra.b loc_01e190

loc_01e15a:
	move.b $103845,d0
	addi.b #2,d0
	move.b d0,$103844
	bclr.b #0,$103840
	lea.l loc_01d417,a2
	move.b #4,d3
	lea.l $103845,a3
	jsr loc_01cc48
	move.b #0,$103846

loc_01e190:
	rts

;##############################################################################
loc_01e192:
	move.b $103840,d0
	btst #0,d0
	bne.w loc_01e1b2
	bset #0,d0
	move.b d0,$103840
	move.b #0,$103845

loc_01e1b2:
	move.w $103862,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	bra.w loc_01e0de

;##############################################################################
loc_01e1d2:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01e24e
	bset #0,d0
	move.b d0,$103840
	cmpi.w #0,loc_037000
	beq.w loc_01e2f8
	move.w $10384c,d0
	cmp.w loc_037000,d0
	bcs.b loc_01e236
	subi.w #1,$10384c
	subi.l #$30,$103850
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	jsr loc_01cd72

loc_01e236:
	bra.b loc_01e24e

;##############################################################################
loc_01e238:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01e24e
	bset #0,d0
	move.b d0,$103840

loc_01e24e:
	lea.l loc_01d41e,a2
	move.b #3,d3
	lea.l $103846,a3
	jsr loc_01cc48
	move.b ($b2,a5),d0
	btst #4,d0
	bne.b loc_01e2c6
	btst #5,d0
	bne.w loc_01e2f8
	btst #0,d0
	bne.b loc_01e286
	btst #1,d0
	bne.b loc_01e29c
	bra.w loc_01e316

loc_01e286:
	cmpi.b #0,$103846
	beq.w loc_01e316
	subi.b #1,$103846
	bra.b loc_01e2ae

loc_01e29c:
	cmpi.b #4,$103846
	beq.b loc_01e316
	addi.b #1,$103846

loc_01e2ae:
	lea.l loc_01d41e,a2
	move.b #3,d3
	lea.l $103846,a3
	jsr loc_01cc48
	bra.b loc_01e316

loc_01e2c6:
	move.b $103846,$103844
	addi.b #8,$103844
	bclr.b #0,$103840
	lea.l loc_01d41e,a2
	move.b #4,d3
	lea.l $103846,a3
	jsr loc_01cc48
	bra.b loc_01e316

loc_01e2f8:
	move.b #1,$103844
	lea.l loc_01d41e,a2
	move.b #2,d3
	lea.l $103846,a3
	jsr loc_01cc48

loc_01e316:
	rts

;##############################################################################
loc_01e318:
	move.b $103840,d0
	btst #0,d0
	bne.w loc_01e37c
	bset #0,d0
	move.b d0,$103840
	cmpi.w #0,loc_037000
	beq.b loc_01e2f8
	move.w $10384c,d0
	cmp.w loc_037000,d0
	bcs.b loc_01e37c
	subi.w #1,$10384c
	subi.l #$30,$103850
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	jsr loc_01cd72

loc_01e37c:
	lea.l loc_01d41e,a2
	move.b #3,d3
	lea.l $103846,a3
	jsr loc_01cc48
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01e2c6
	btst #5,d0
	bne.w loc_01e2f8
	btst #0,d0
	bne.b loc_01e3b6
	btst #1,d0
	bne.b loc_01e3cc
	bra.w loc_01e316

loc_01e3b6:
	cmpi.b #0,$103846
	beq.w loc_01e316
	subi.b #4,$103846
	bra.b loc_01e3e0

loc_01e3cc:
	cmpi.b #4,$103846
	beq.w loc_01e316
	addi.b #4,$103846

loc_01e3e0:
	lea.l loc_01d41e,a2
	move.b #3,d3
	lea.l $103846,a3
	jsr loc_01cc48
	bra.w loc_01e316

;##############################################################################
loc_01e3fa:
	move.b $103840,d0
	btst #0,d0
	bne.w loc_01e37c
	bset #0,d0
	move.b d0,$103840
	cmpi.w #0,loc_037000
	beq.w loc_01e2f8
	move.w $10384c,d0
	cmp.w loc_037000,d0
	bcs.w loc_01e462
	subi.w #1,$10384c
	subi.l #$30,$103850
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	jsr loc_01cd72

loc_01e462:
	move.w $10384c,$10385c
	move.l $103850,$103854
	move.w $10384c,$10385e
	move.l $103850,$103858
	move.w $10385c,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	move.w $10385e,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	move.w #$26,d0
	move.b #2,d1
	jsr loc_01cbd4
	bra.w loc_01e37c

;##############################################################################
loc_01e4d4:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01e552
	bset #0,d0
	move.b d0,$103840
	move.w #$23,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.w #$24,d0
	move.b #3,d1
	jsr loc_01cbd4
	move.w #$25,d0
	move.b #3,d1
	jsr loc_01cbd4
	move.l #loc_037000,d0
	move.l d0,d0
	move.w #9,d1
	move.w #$c,d2
	move.b #3,d3
	move.b #5,d4
	jsr loc_01cc84
	move.l loc_037000+4,d0
	subq.l #1,d0
	move.l d0,d0
	move.w #9,d1
	move.w #$d,d2
	move.b #3,d3
	move.b #5,d4
	jsr loc_01cc84

loc_01e552:
	move.b ($b1,a5),d0
	btst #5,d0
	beq.b loc_01e582
	move.b #1,$103844
	move.w #$23,d0
	jsr loc_01cc12
	move.w #$24,d0
	jsr loc_01cc12
	move.w #$25,d0
	jsr loc_01cc12

loc_01e582:
	rts

;##############################################################################
loc_01e584:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01e5b4
	bset #0,d0
	move.b d0,$103840
	cmpi.b #3,$103845
	bcs.b loc_01e5ae
	move.w $10385c,$10384c

loc_01e5ae:
	jsr loc_01cd72

loc_01e5b4:
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01e6b4
	btst #5,d0
	bne.w loc_01e6cc
	btst #0,d0
	bne.b loc_01e600
	btst #1,d0
	bne.b loc_01e622
	btst #2,d0
	bne.b loc_01e636
	btst #3,d0
	bne.b loc_01e65c
	bra.w loc_01e6f8

loc_01e600:
	move.w loc_037000,d1
	cmpi.b #1,$103845
	beq.b loc_01e612
	subq.w #1,d1

loc_01e612:
	move.w $10384c,d0
	cmp.w d1,d0
	beq.w loc_01e6f8
	addq.w #1,d0
	bra.b loc_01e66c

loc_01e622:
	move.w $10384c,d0
	cmpi.w #0,d0
	beq.w loc_01e6f8
	subi.w #1,d0
	bra.b loc_01e66c

loc_01e636:
	move.w loc_037000,d1
	cmpi.b #1,$103845
	beq.b loc_01e648
	subq.w #1,d1

loc_01e648:
	move.w $10384c,d0
	addi.w #$10,d0
	cmp.w d1,d0
	bls.w loc_01e66c
	move.w d1,d0
	bra.b loc_01e66c

loc_01e65c:
	move.w $10384c,d0
	subi.w #$10,d0
	bcc.b loc_01e66c
	move.w #0,d0

loc_01e66c:
	move.w d0,$10384c
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	jsr loc_01cd72
	cmpi.b #3,$103845
	bcs.b loc_01e6f8
	move.w $10384c,$10385c
	move.l $103850,$103854
	bra.b loc_01e6f8

loc_01e6b4:
	cmpi.b #3,$103845
	bcs.b loc_01e6cc
	move.b #$11,d0
	bclr.b #0,$103840
	bra.b loc_01e6d6

loc_01e6cc:
	move.b $103845,d0
	addi.b #2,d0

loc_01e6d6:
	move.b d0,$103844
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84

loc_01e6f8:
	rts

;##############################################################################
loc_01e6fa:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01e73c
	bset #0,d0
	move.b d0,$103840
	move.w $10385e,$10384c
	jsr loc_01cd72
	move.w $10385e,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84

loc_01e73c:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01e806
	btst #5,d0
	bne.w loc_01e818
	btst #0,d0
	bne.w loc_01e774
	btst #1,d0
	bne.w loc_01e788
	btst #2,d0
	bne.w loc_01e79c
	btst #3,d0
	bne.w loc_01e7b8
	bra.w loc_01e84e

loc_01e774:
	move.w $10384c,d0
	cmp.w loc_037000,d0
	beq.w loc_01e84e
	addq.w #1,d0
	bra.b loc_01e7c8

loc_01e788:
	move.w $10384c,d0
	cmpi.w #0,d0
	beq.w loc_01e84e
	subi.w #1,d0
	bra.b loc_01e7c8

loc_01e79c:
	move.w $10384c,d0
	addi.w #$10,d0
	cmp.w loc_037000,d0
	bls.w loc_01e7c8
	move.w loc_037000,d0
	bra.b loc_01e7c8

loc_01e7b8:
	move.w $10384c,d0
	subi.w #$10,d0
	bcc.b loc_01e7c8
	move.w #0,d0

loc_01e7c8:
	move.w d0,$10384c
	jsr loc_01cd72
	move.w $10384c,$10385e
	move.l $103850,$103858
	move.w $10385e,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	bra.b loc_01e84e

loc_01e806:
	move.b $103845,d0
	addi.b #2,d0
	move.b d0,$103844
	bra.b loc_01e832

loc_01e818:
	move.b #8,$103844
	bclr.b #0,$103840
	move.w $10385c,$10384c

loc_01e832:
	move.w $10385e,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84

loc_01e84e:
	rts

;##############################################################################
loc_01e850:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01e866
	bset #0,d0
	move.b d0,$103840

loc_01e866:
	move.w $1037a0,d0
	move.w #$1c,d1
	move.w #7,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01e92a
	btst #5,d0
	bne.w loc_01e92a
	btst #0,d0
	bne.b loc_01e8b2
	btst #1,d0
	bne.b loc_01e8c6
	btst #2,d0
	bne.b loc_01e8da
	btst #3,d0
	bne.b loc_01e8f6
	bra.w loc_01e956

loc_01e8b2:
	move.w $1037a0,d0
	cmp.w $10384e,d0
	beq.w loc_01e956
	addq.w #1,d0
	bra.b loc_01e906

loc_01e8c6:
	move.w $1037a0,d0
	cmpi.w #0,d0
	beq.w loc_01e956
	subi.w #1,d0
	bra.b loc_01e906

loc_01e8da:
	move.w $1037a0,d0
	addi.w #$10,d0
	cmp.w $10384e,d0
	bls.w loc_01e906
	move.w $10384e,d0
	bra.b loc_01e906

loc_01e8f6:
	move.w $1037a0,d0
	subi.w #$10,d0
	bcc.b loc_01e906
	move.w #0,d0

loc_01e906:
	move.w d0,$1037a0
	move.w $1037a0,d0
	move.w #$1c,d1
	move.w #7,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	bra.b loc_01e956

loc_01e92a:
	move.b $103845,d0
	addi.b #2,d0
	move.b d0,$103844
	move.w $1037a0,d0
	move.w #$1c,d1
	move.w #7,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84

loc_01e956:
	rts

;##############################################################################
loc_01e958:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01e9a6
	bset #0,d0
	move.b d0,$103840
	move.b $1037a2,d0
	move.w #$1f,d1
	move.w #9,d2
	move.b #3,d3
	move.b #1,d4
	jsr loc_01cc84
	move.b $1037a3,d0
	move.w #$23,d1
	move.w #9,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84

loc_01e9a6:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01ea66
	btst #5,d0
	bne.w loc_01ea66
	btst #0,d0
	bne.b loc_01e9d6
	btst #1,d0
	bne.b loc_01e9ec
	btst #2,d0
	bne.b loc_01ea02
	btst #3,d0
	bne.b loc_01ea18
	bra.w loc_01eab6

loc_01e9d6:
	cmpi.b #$b,$1037a2
	beq.w loc_01eab6
	addi.b #1,$1037a2
	bra.b loc_01ea2c

loc_01e9ec:
	cmpi.b #0,$1037a2
	beq.w loc_01eab6
	subi.b #1,$1037a2
	bra.b loc_01ea2c

loc_01ea02:
	cmpi.b #$80,$1037a3
	beq.w loc_01eab6
	subi.b #1,$1037a3
	bra.b loc_01ea2c

loc_01ea18:
	cmpi.b #$7f,$1037a3
	beq.w loc_01eab6
	addi.b #1,$1037a3

loc_01ea2c:
	move.b $1037a2,d0
	move.w #$1f,d1
	move.w #9,d2
	move.b #3,d3
	move.b #1,d4
	jsr loc_01cc84
	move.b $1037a3,d0
	move.w #$23,d1
	move.w #9,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	bra.b loc_01eab6

loc_01ea66:
	move.b $103845,d0
	addi.b #2,d0
	move.b d0,$103844
	bclr.b #0,$103840
	move.b $1037a2,d0
	move.w #$1f,d1
	move.w #9,d2
	move.b #2,d3
	move.b #1,d4
	jsr loc_01cc84
	move.b $1037a3,d0
	move.w #$23,d1
	move.w #9,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_01eab6:
	rts

;##############################################################################
loc_01eab8:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01eae4
	bset #0,d0
	move.b d0,$103840
	lea.l loc_01d424,a2
	move.b #3,d3
	lea.l $103848,a3
	jsr loc_01cc48

loc_01eae4:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01ebd6
	btst #5,d0
	bne.w loc_01ebea
	btst #0,d0
	bne.b loc_01eb08
	btst #1,d0
	bne.b loc_01eb1e
	bra.w loc_01ec18

loc_01eb08:
	cmpi.b #0,$103848
	beq.w loc_01ec18
	subi.b #1,$103848
	bra.b loc_01eb32

loc_01eb1e:
	cmpi.b #9,$103848
	beq.w loc_01ec18
	addi.b #1,$103848

loc_01eb32:
	lea.l $1037a4,a0
	moveq #0,d0
	move.b $103848,d0
	add.b d0,d0
	add.b d0,d0
	move.l (a0,d0.w),d0
	move.l d0,$103860
	move.b $103860,d0
	move.w #$1f,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $103861,d0
	move.w #$23,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $103862,d0
	move.w #$1f,d1
	move.w #$19,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $103863,d0
	move.w #$23,d1
	move.w #$19,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	lea.l loc_01d424,a2
	move.b #3,d3
	lea.l $103848,a3
	jsr loc_01cc48
	bra.b loc_01ec18

loc_01ebd6:
	move.b #$f,d0
	cmpi.b #7,$103848
	bne.b loc_01ebf4
	move.b #$d,d0
	bra.b loc_01ebf4

loc_01ebea:
	move.b $103845,d0
	addi.b #2,d0

loc_01ebf4:
	move.b d0,$103844
	bclr.b #0,$103840
	lea.l loc_01d424,a2
	move.b #2,d3
	lea.l $103848,a3
	jsr loc_01cc48

loc_01ec18:
	rts

;##############################################################################
loc_01ec1a:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01ec74
	bset #0,d0
	move.b d0,$103840
	move.b $103860,d0
	move.w #$1f,d1
	move.w #$17,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $103861,d0
	move.w #$23,d1
	move.w #$17,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b ($b4,a5),($bc,a5)
	move.b #1,($b4,a5)

loc_01ec74:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01ed4a
	btst #5,d0
	bne.w loc_01ed54
	btst #0,d0
	beq.b loc_01eca4
	cmpi.b #$80,$103861
	beq.w loc_01ecbe
	subi.b #1,$103861
	bra.b loc_01ecbe

loc_01eca4:
	btst #1,d0
	beq.b loc_01ecbe
	cmpi.b #$7f,$103861
	beq.w loc_01ecbe
	addi.b #1,$103861

loc_01ecbe:
	btst #2,d0
	beq.b loc_01ecda
	cmpi.b #$80,$103860
	beq.w loc_01ecf4
	subi.b #1,$103860
	bra.b loc_01ecf4

loc_01ecda:
	btst #3,d0
	beq.b loc_01ecf4
	cmpi.b #$7f,$103860
	beq.w loc_01ecf4
	addi.b #1,$103860

loc_01ecf4:
	lea.l $1037a4,a0
	moveq #0,d0
	move.b $103848,d0
	add.b d0,d0
	add.b d0,d0
	move.l $103860,(a0,d0.w)
	move.b $103860,d0
	move.w #$1f,d1
	move.w #$17,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $103861,d0
	move.w #$23,d1
	move.w #$17,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	bra.w loc_01edb4

loc_01ed4a:
	addi.b #1,$103844
	bra.b loc_01ed6e

loc_01ed54:
	move.b #$b,$103844
	cmpi.b #7,$103848
	bne.b loc_01ed6e
	move.b #$e,$103844

loc_01ed6e:
	bclr.b #0,$103840
	move.b $103860,d0
	move.w #$1f,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $103861,d0
	move.w #$23,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b ($bc,a5),($b4,a5)

loc_01edb4:
	rts

;##############################################################################
loc_01edb6:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01ee10
	bset #0,d0
	move.b d0,$103840
	move.b $103862,d0
	move.w #$1f,d1
	move.w #$19,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $103863,d0
	move.w #$23,d1
	move.w #$19,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b ($b4,a5),($bc,a5)
	move.b #1,($b4,a5)

loc_01ee10:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01eee6
	btst #5,d0
	bne.w loc_01eef0
	btst #0,d0
	beq.b loc_01ee40
	cmpi.b #0,$103863
	beq.w loc_01ee5a
	subi.b #1,$103863
	bra.b loc_01ee5a

loc_01ee40:
	btst #1,d0
	beq.b loc_01ee5a
	cmpi.b #$ff,$103863
	beq.w loc_01ee5a
	addi.b #1,$103863

loc_01ee5a:
	btst #2,d0
	beq.b loc_01ee76
	cmpi.b #0,$103862
	beq.w loc_01ee90
	subi.b #1,$103862
	bra.b loc_01ee90

loc_01ee76:
	btst #3,d0
	beq.b loc_01ee90
	cmpi.b #$ff,$103862
	beq.w loc_01ee90
	addi.b #1,$103862

loc_01ee90:
	lea.l $1037a4,a0
	moveq #0,d0
	move.b $103848,d0
	add.b d0,d0
	add.b d0,d0
	move.l $103860,(a0,d0.w)
	move.b $103862,d0
	move.w #$1f,d1
	move.w #$19,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $103863,d0
	move.w #$23,d1
	move.w #$19,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	bra.w loc_01ef3e

loc_01eee6:
	move.b #$b,$103844
	bra.b loc_01eef8

loc_01eef0:
	subi.b #1,$103844

loc_01eef8:
	bclr.b #0,$103840
	move.b $103862,d0
	move.w #$1f,d1
	move.w #$19,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $103863,d0
	move.w #$23,d1
	move.w #$19,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b ($bc,a5),($b4,a5)

loc_01ef3e:
	rts

;##############################################################################
loc_01ef40:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01ef74
	bset #0,d0
	move.b d0,$103840
	move.b #0,$103847
	lea.l loc_01d434,a2
	move.b #3,d3
	lea.l $103847,a3
	jsr loc_01cc48

loc_01ef74:
	move.b ($b1,a5),d0
	btst #4,d0
	bne.b loc_01efda
	btst #5,d0
	bne.w loc_01f044
	btst #0,d0
	bne.b loc_01ef96
	btst #1,d0
	bne.b loc_01efac
	bra.w loc_01f088

loc_01ef96:
	cmpi.b #0,$103847
	beq.w loc_01f088
	subi.b #1,$103847
	bra.b loc_01efc0

loc_01efac:
	cmpi.b #1,$103847
	beq.w loc_01f088
	addi.b #1,$103847

loc_01efc0:
	lea.l loc_01d434,a2
	move.b #3,d3
	lea.l $103847,a3
	jsr loc_01cc48
	bra.w loc_01f088

loc_01efda:
	cmpi.b #0,$103847
	bne.w loc_01f044
	moveq #0,d0
	move.b $103845,d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_01f08a(pc),a0
	nop
	movea.l (a0,d0.w),a0
	jsr (a0)
	move.b #0,$103846
	jsr loc_01cd72
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	move.w loc_037000,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84

loc_01f044:
	move.b $103845,d0
	addi.b #2,d0
	move.b d0,$103844
	bclr.b #0,$103840
	lea.l loc_01d434,a2
	move.b #2,d3
	lea.l $103847,a3
	jsr loc_01cc48
	lea.l loc_01d41e,a2
	move.b #3,d3
	lea.l $103846,a3
	jsr loc_01cc48

loc_01f088:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01f08a:
	dc.l loc_01f09e,loc_01f0b4,loc_01f104,loc_01f136
	dc.l loc_01f15a

;###############################################################################
loc_01f09e:
	moveq #$b,d0
	movea.l $103850,a0
	lea.l $1037a0,a1

loc_01f0ac:
	move.l (a1)+,(a0)+
	dbra d0,loc_01f0ac
	rts

;###############################################################################
loc_01f0b4:
	movea.l $103850,a0
	movea.l loc_037000+4,a1
	suba.l #4,a1
	movea.l a1,a2
	adda.l #$30,a2

loc_01f0ce:
	cmpa.l a0,a1
	bcs.b loc_01f0e2
	move.l (a1),(a2)
	suba.l #4,a1
	suba.l #4,a2
	bra.b loc_01f0ce

loc_01f0e2:
	moveq #$b,d0
	lea.l $1037a0,a1

loc_01f0ea:
	move.l (a1)+,(a0)+
	dbra d0,loc_01f0ea
	addi.l #$30,loc_037000+4
	addi.w #1,loc_037000
	rts

;###############################################################################
loc_01f104:
	movea.l $103850,a0
	movea.l a0,a1
	adda.l #$30,a1
	movea.l loc_037000+4,a2

loc_01f118:
	cmpa.l a1,a2
	beq.w loc_01f122
	move.l (a1)+,(a0)+
	bra.b loc_01f118

loc_01f122:
	subi.l #$30,loc_037000+4
	subi.w #1,loc_037000
	rts

;###############################################################################
loc_01f136:
	movea.l $103854,a0
	lea.l $1037a0,a1
	moveq #$b,d0

loc_01f144:
	move.l (a0)+,(a1)+
	dbra d0,loc_01f144
	move.l $103858,$103850
	jsr loc_01f0b4(pc)
	rts

;###############################################################################
loc_01f15a:
	movea.l $103854,a0
	lea.l $1037a0,a1
	moveq #$b,d0

loc_01f168:
	move.l (a0)+,(a1)+
	dbra d0,loc_01f168
	move.l $103854,$103850
	jsr loc_01f104(pc)
	move.l $103858,d0
	cmp.l $103854,d0
	bls.b loc_01f190
	subi.l #$30,d0

loc_01f190:
	move.l d0,$103850
	bra.w loc_01f0b4

loc_01f19a:
	rts

;##############################################################################
loc_01f19c:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01f206
	bset #0,d0
	move.b d0,$103840
	move.w #$21,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.w #$22,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.b $1037ce,d0
	move.w #$1f,d1
	move.w #$15,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $1037cf,d0
	move.w #$23,d1
	move.w #$15,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_01f206:
	move.w $1037cc,d0
	move.w #$21,d1
	move.w #$14,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01f2ca
	btst #5,d0
	bne.w loc_01f2f8
	btst #0,d0
	bne.b loc_01f252
	btst #1,d0
	bne.b loc_01f266
	btst #2,d0
	bne.b loc_01f27a
	btst #3,d0
	bne.b loc_01f296
	bra.w loc_01f308

loc_01f252:
	move.w $1037cc,d0
	cmp.w $10384e,d0
	beq.w loc_01f308
	addq.w #1,d0
	bra.b loc_01f2a6

loc_01f266:
	move.w $1037cc,d0
	cmpi.w #0,d0
	beq.w loc_01f308
	subi.w #1,d0
	bra.b loc_01f2a6

loc_01f27a:
	move.w $1037cc,d0
	addi.w #$10,d0
	cmp.w $10384e,d0
	bls.w loc_01f2a6
	move.w $10384e,d0
	bra.b loc_01f2a6

loc_01f296:
	move.w $1037cc,d0
	subi.w #$10,d0
	bcc.b loc_01f2a6
	move.w #0,d0

loc_01f2a6:
	move.w d0,$1037cc
	move.w $1037cc,d0
	move.w #$21,d1
	move.w #$14,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	bra.b loc_01f308

loc_01f2ca:
	move.w $1037cc,d0
	move.w #$21,d1
	move.w #$14,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	addi.b #1,$103844
	bclr.b #0,$103840
	bra.b loc_01f308

loc_01f2f8:
	move.b #$b,$103844
	bclr.b #0,$103840

loc_01f308:
	rts

;##############################################################################
loc_01f30a:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01f358
	bset #0,d0
	move.b d0,$103840
	move.b $1037ce,d0
	move.w #$1f,d1
	move.w #$15,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $1037cf,d0
	move.w #$23,d1
	move.w #$15,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84

loc_01f358:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01f414
	btst #5,d0
	bne.w loc_01f426
	btst #0,d0
	beq.b loc_01f388
	cmpi.b #$80,$1037cf
	beq.w loc_01f3a2
	subi.b #1,$1037cf
	bra.b loc_01f3a2

loc_01f388:
	btst #1,d0
	beq.b loc_01f3a2
	cmpi.b #$7f,$1037cf
	beq.w loc_01f3a2
	addi.b #1,$1037cf

loc_01f3a2:
	btst #2,d0
	beq.b loc_01f3be
	cmpi.b #$80,$1037ce
	beq.w loc_01f3d8
	subi.b #1,$1037ce
	bra.b loc_01f3d8

loc_01f3be:
	btst #3,d0
	beq.b loc_01f3d8
	cmpi.b #$7f,$1037ce
	beq.w loc_01f3d8
	addi.b #1,$1037ce

loc_01f3d8:
	move.b $1037ce,d0
	move.w #$1f,d1
	move.w #$15,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $1037cf,d0
	move.w #$23,d1
	move.w #$15,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	bra.w loc_01f466

loc_01f414:
	addi.b #1,$103844
	bclr.b #0,$103840
	bra.b loc_01f42e

loc_01f426:
	subi.b #1,$103844

loc_01f42e:
	move.b $1037ce,d0
	move.w #$1f,d1
	move.w #$15,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $1037cf,d0
	move.w #$23,d1
	move.w #$15,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_01f466:
	rts

;##############################################################################
loc_01f468:
	lea.l $103770,a5
	lea.l $10384c,a6
	move.w $101004,d0
	cmpi.b #0,d0
	bne.w loc_01f50e
	move.w #1,$101004
	jsr FIX_CLEAR
	lea.l player1mem,a0
	lea.l $10376f,a1
	jsr loc_01ddc4
	move.b #1,$103831
	move.b #$41,$103832
	move.b #$41,$103833
	move.b #$41,$103834
	move.b #$43,$103835
	move.b #$47,$103836
	move.b #$47,$103837
	move.b #$45,$103838
	move.b #5,$103839
	move.b #$33,$10383a
	move.b #3,($b4,a5)
	move.b #$c,($b5,a5)
	move.w #$80,$1037d0
	move.w #$130,$1037d2

loc_01f50e:
	jsr loc_01dd30
	btst #0,BIOS_STATCHANGE
	beq.b loc_01f544
	bchg.b #1,$103840
	beq.b loc_01f544
	move.b #0,$103849
	bclr.b #0,$103841
	lea.l loc_01d441,a2
	jsr loc_01cc6e

loc_01f544:
	btst #1,$103840
	bne.b loc_01f568
	moveq #0,d0
	move.b $103844,d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_01f5e6(pc),a0
	nop
	movea.l (a0,d0.w),a0
	jsr (a0)
	bra.b loc_01f580

loc_01f568:
	moveq #0,d0
	move.b $103849,d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_01cbc0,a0
	movea.l (a0,d0.w),a0
	jsr (a0)

loc_01f580:
	btst #2,BIOS_STATCHANGE
	beq.b loc_01f5bc
	bchg.b #2,$103840
	beq.b loc_01f5bc
	move.b #0,$1037f0
	bclr.b #0,$103842
	lea.l loc_01d446,a2
	jsr loc_01cc6e
	lea.l loc_01d452,a2
	jsr loc_01cc6e

loc_01f5bc:
	btst #2,$103840
	beq.b loc_01f5de
	moveq #0,d0
	move.b $1037f0,d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_01f622(pc),a0
	nop
	movea.l (a0,d0.w),a0
	jsr (a0)

loc_01f5de:
	jsr loc_020680
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_01f5e6:
	dc.l loc_01f64e,loc_01e192,loc_01f7ba,loc_01f7ba
	dc.l loc_01f7ba,loc_01f8c8,loc_01f8c8,loc_01fa36
	dc.l loc_01faec,loc_01fda6,loc_01fe9c,loc_01fff0
	dc.l loc_0200ee,loc_0201f2,loc_01fc50
	
loc_01f622:
	dc.l loc_020f48,loc_01f954,loc_01f954,loc_01f954
	dc.l loc_021050,loc_021128,loc_021234,loc_021316
	dc.l loc_02141c,loc_021568,loc_021668

;##############################################################################
loc_01f64e:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01f698
	bset #0,d0
	move.b d0,$103840
	move.w #$30,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.b #0,$103845
	lea.l loc_01d414,a2
	move.b #3,d3
	lea.l $103845,a3
	jsr loc_01cc48
	move.w #$53f,$103862

loc_01f698:
	move.b ($b1,a5),d0
	btst #4,d0
	bne.b loc_01f6f6
	btst #0,d0
	bne.b loc_01f6b2
	btst #1,d0
	bne.b loc_01f6c8
	bra.w loc_01f7b8

loc_01f6b2:
	cmpi.b #0,$103845
	beq.w loc_01f7b8
	subi.b #1,$103845
	bra.b loc_01f6dc

loc_01f6c8:
	cmpi.b #1,$103845
	beq.w loc_01f7b8
	addi.b #1,$103845

loc_01f6dc:
	lea.l loc_01d414,a2
	move.b #3,d3
	lea.l $103845,a3
	jsr loc_01cc48
	bra.w loc_01f7b8

loc_01f6f6:
	cmpi.b #0,$103845
	beq.b loc_01f71c
	move.l #$1000,loc_05a000+$ff0
	moveq #0,d0
	lea.l loc_05a000,a0

loc_01f712:
	move.l d0,(a0)+
	cmpa.l #loc_05a000+$ff0,a0
	bcs.b loc_01f712

loc_01f71c:
	move.b #1,$103844
	bclr.b #0,$103840
	lea.l loc_01d414,a2
	jsr loc_01cc6e
	lea.l loc_01d417,a2
	move.b #2,d3
	lea.l $103845,a3
	jsr loc_01cc48
	lea.l loc_01d43a,a2
	move.b #2,d3
	lea.l $103845,a3
	jsr loc_01cc48
	lea.l loc_01d434,a2
	move.b #2,d3
	lea.l $103845,a3
	jsr loc_01cc48
	move.w #$33,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.w #$35,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.w $103860,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	jsr loc_01ce6a

loc_01f7b8:
	rts

;##############################################################################
loc_01f7ba:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01f7d0
	bset #0,d0
	move.b d0,$103840

loc_01f7d0:
	lea.l loc_01d43a,a2
	move.b #3,d3
	lea.l $103846,a3
	jsr loc_01cc48
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01f876
	btst #5,d0
	bne.w loc_01f8a8
	btst #0,d0
	bne.b loc_01f80a
	btst #1,d0
	bne.b loc_01f834
	bra.w loc_01f8c6

loc_01f80a:
	cmpi.b #0,$103846
	beq.w loc_01f8c6
	cmpi.b #2,$103845
	bcs.b loc_01f82a
	move.b #0,$103846
	bra.b loc_01f85e

loc_01f82a:
	subi.b #1,$103846
	bra.b loc_01f85e

loc_01f834:
	cmpi.b #5,$103846
	beq.w loc_01f8c6
	cmpi.b #2,$103845
	bcs.b loc_01f856
	move.b #5,$103846
	bra.w loc_01f85e

loc_01f856:
	addi.b #1,$103846

loc_01f85e:
	lea.l loc_01d43a,a2
	move.b #3,d3
	lea.l $103846,a3
	jsr loc_01cc48
	bra.b loc_01f8c6

loc_01f876:
	move.b $103846,$103844
	addi.b #8,$103844
	bclr.b #0,$103840
	lea.l loc_01d43a,a2
	move.b #4,d3
	lea.l $103846,a3
	jsr loc_01cc48
	bra.b loc_01f8c6

loc_01f8a8:
	move.b #1,$103844
	lea.l loc_01d43a,a2
	move.b #2,d3
	lea.l $103846,a3
	jsr loc_01cc48

loc_01f8c6:
	rts

;##############################################################################
loc_01f8c8:
	move.b $103840,d0
	btst #0,d0
	bne.w loc_01f7d0
	bset #0,d0
	move.b d0,$103840
	lea.l loc_01d43a,a2
	move.b #3,d3
	lea.l $103846,a3
	jsr loc_01cc48
	move.w $103860,$10385c
	move.w $103860,$10385e
	move.w $10385c,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	move.w $10385e,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	move.w #$26,d0
	move.b #2,d1
	jsr loc_01cbd4
	bra.w loc_01f7d0

;##############################################################################
loc_01f954:
	move.b $103842,d0
	btst #0,d0
	bne.b loc_01f968
	bset #0,$103842

loc_01f968:
	lea.l loc_01d44a,a2
	move.b #3,d3
	lea.l $1037f2,a3
	jsr loc_01cc48
	move.b ($ba,a5),d0
	btst #4,d0
	bne.w loc_01f9e4
	btst #5,d0
	bne.w loc_01fa16
	btst #0,d0
	bne.b loc_01f9a2
	btst #1,d0
	bne.b loc_01f9b8
	bra.w loc_01fa34

loc_01f9a2:
	cmpi.b #0,$1037f2
	beq.w loc_01fa34
	subi.b #1,$1037f2
	bra.b loc_01f9cc

loc_01f9b8:
	cmpi.b #6,$1037f2
	beq.w loc_01fa34
	addi.b #1,$1037f2

loc_01f9cc:
	lea.l loc_01d44a,a2
	move.b #3,d3
	lea.l $1037f2,a3
	jsr loc_01cc48
	bra.b loc_01fa34

loc_01f9e4:
	move.b $1037f2,$1037f0
	addi.b #4,$1037f0
	bclr.b #0,$103842
	lea.l loc_01d44a,a2
	move.b #4,d3
	lea.l $1037f2,a3
	jsr loc_01cc48
	bra.b loc_01fa34

loc_01fa16:
	move.b #0,$1037f0
	lea.l loc_01d44a,a2
	move.b #2,d3
	lea.l $1037f2,a3
	jsr loc_01cc48

loc_01fa34:
	rts

;##############################################################################
loc_01fa36:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01faba
	bset #0,d0
	move.b d0,$103840
	move.w #$38,d0
	move.b #2,d1
	jsr loc_01cbd4
	move.w #$24,d0
	move.b #3,d1
	jsr loc_01cbd4
	move.w #$25,d0
	move.b #3,d1
	jsr loc_01cbd4
	move.l #loc_05a000,d0
	move.l d0,d0
	move.w #$a,d1
	move.w #$c,d2
	move.b #3,d3
	move.b #5,d4
	jsr loc_01cc84
	move.l #loc_05a000,d0
	add.l loc_05a000+$ff0,d0
	subq.l #1,d0
	move.l d0,d0
	move.w #$a,d1
	move.w #$d,d2
	move.b #3,d3
	move.b #5,d4
	jsr loc_01cc84

loc_01faba:
	move.b ($b1,a5),d0
	btst #5,d0
	beq.b loc_01faea
	move.b #1,$103844
	move.w #$38,d0
	jsr loc_01cc12
	move.w #$24,d0
	jsr loc_01cc12
	move.w #$25,d0
	jsr loc_01cc12

loc_01faea:
	rts

;##############################################################################
loc_01faec:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01fb1c
	bset #0,d0
	move.b d0,$103840
	cmpi.b #3,$103845
	bcs.b loc_01fb16
	move.w $10385c,$103860

loc_01fb16:
	jsr loc_01ce6a

loc_01fb1c:
	move.w $103860,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01fc04
	btst #5,d0
	bne.w loc_01fc1c
	btst #0,d0
	bne.b loc_01fb68
	btst #1,d0
	bne.b loc_01fb7c
	btst #2,d0
	bne.b loc_01fb90
	btst #3,d0
	bne.b loc_01fbac
	bra.w loc_01fc48

loc_01fb68:
	move.w $103860,d0
	cmp.w $103862,d0
	beq.w loc_01fc48
	addq.w #1,d0
	bra.b loc_01fbbc

loc_01fb7c:
	move.w $103860,d0
	cmpi.w #0,d0
	beq.w loc_01fc48
	subi.w #1,d0
	bra.b loc_01fbbc

loc_01fb90:
	move.w $103860,d0
	addi.w #$60,d0
	cmp.w $103862,d0
	bls.w loc_01fbbc
	move.w $103862,d0
	bra.b loc_01fbbc

loc_01fbac:
	move.w $103860,d0
	subi.w #$60,d0
	bcc.b loc_01fbbc
	move.w #0,d0

loc_01fbbc:
	move.w d0,$103860
	move.w $103860,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	jsr loc_01ce6a
	cmpi.b #3,$103845
	bcs.b loc_01fc48
	move.w $103860,$10385c
	move.l $103868,$103854
	bra.b loc_01fc48

loc_01fc04:
	cmpi.b #3,$103845
	bcs.b loc_01fc1c
	move.b #$e,d0
	bclr.b #0,$103840
	bra.b loc_01fc26

loc_01fc1c:
	move.b $103845,d0
	addi.b #2,d0

loc_01fc26:
	move.b d0,$103844
	move.w $103860,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84

loc_01fc48:
	jsr loc_01de0c
	rts

;##############################################################################
loc_01fc50:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01fc92
	bset #0,d0
	move.b d0,$103840
	move.w $10385e,$103860
	jsr loc_01ce6a
	move.w $10385e,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84

loc_01fc92:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01fd5c
	btst #5,d0
	bne.w loc_01fd6e
	btst #0,d0
	bne.w loc_01fcca
	btst #1,d0
	bne.w loc_01fcde
	btst #2,d0
	bne.w loc_01fcf2
	btst #3,d0
	bne.w loc_01fd0e
	bra.w loc_01fda4

loc_01fcca:
	move.w $103860,d0
	cmp.w $103862,d0
	beq.w loc_01fda4
	addq.w #1,d0
	bra.b loc_01fd1e

loc_01fcde:
	move.w $103860,d0
	cmpi.w #0,d0
	beq.w loc_01fda4
	subi.w #1,d0
	bra.b loc_01fd1e

loc_01fcf2:
	move.w $103860,d0
	addi.w #$60,d0
	cmp.w $103862,d0
	bls.w loc_01fd1e
	move.w $103862,d0
	bra.b loc_01fd1e

loc_01fd0e:
	move.w $103860,d0
	subi.w #$60,d0
	bcc.b loc_01fd1e
	move.w #0,d0

loc_01fd1e:
	move.w d0,$103860
	jsr loc_01ce6a
	move.w $103860,$10385e
	move.l $103868,$103858
	move.w $10385e,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	bra.b loc_01fda4

loc_01fd5c:
	move.b $103845,d0
	addi.b #2,d0
	move.b d0,$103844
	bra.b loc_01fd88

loc_01fd6e:
	move.b #8,$103844
	bclr.b #0,$103840
	move.w $10385c,$103860

loc_01fd88:
	move.w $10385e,d0
	move.w #$21,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84

loc_01fda4:
	rts

;##############################################################################
loc_01fda6:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01fdd0
	bset #0,d0
	move.b d0,$103840
	movea.l $103868,a0
	cmpi.w #0,(a0)
	beq.w loc_01fe6e
	jsr loc_01cfca

loc_01fdd0:
	move.b $103864,d0
	move.w #$1c,d1
	move.w #8,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01fe6e
	btst #5,d0
	bne.w loc_01fe6e
	btst #0,d0
	bne.b loc_01fe10
	btst #1,d0
	bne.b loc_01fe32
	bra.w loc_01fe9a

loc_01fe10:
	move.b $103865,d1
	cmpi.b #1,$103845
	beq.b loc_01fe22
	subq.b #1,d1

loc_01fe22:
	move.b $103864,d0
	cmp.b d1,d0
	beq.w loc_01fe9a
	addq.b #1,d0
	bra.b loc_01fe44

loc_01fe32:
	move.b $103864,d0
	cmpi.b #0,d0
	beq.w loc_01fe9a
	subi.b #1,d0

loc_01fe44:
	move.b d0,$103864
	move.b $103864,d0
	move.w #$1c,d1
	move.w #8,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	jsr loc_01cfca
	bra.b loc_01fe9a

loc_01fe6e:
	move.b $103845,d0
	addi.b #2,d0
	move.b d0,$103844
	move.b $103864,d0
	move.w #$1c,d1
	move.w #8,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_01fe9a:
	rts

;##############################################################################
loc_01fe9c:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_01fef2
	bset #0,d0
	move.b d0,$103840
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #$b,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	move.l #loc_037000+$10,d0
	moveq #0,d1
	move.w $10384c,d1
	move.l d1,d2
	lsl.l #5,d1
	lsl.l #4,d2
	add.l d1,d0
	add.l d2,d0
	move.l d0,$103850
	jsr loc_01ddd8

loc_01fef2:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_01ffc2
	btst #5,d0
	bne.w loc_01ffc2
	btst #0,d0
	bne.b loc_01ff22
	btst #1,d0
	bne.b loc_01ff3a
	btst #2,d0
	bne.b loc_01ff4e
	btst #3,d0
	bne.b loc_01ff6a
	bra.w loc_01ffee

loc_01ff22:
	move.w loc_037000,d1
	subq.w #1,d1
	move.w $10384c,d0
	cmp.w d1,d0
	beq.w loc_01ffee
	addq.w #1,d0
	bra.b loc_01ff7a

loc_01ff3a:
	move.w $10384c,d0
	cmpi.w #0,d0
	beq.w loc_01ffee
	subi.w #1,d0
	bra.b loc_01ff7a

loc_01ff4e:
	move.w loc_037000,d1
	subq.w #1,d1
	move.w $10384c,d0
	addi.w #$10,d0
	cmp.w d1,d0
	bls.w loc_01ff7a
	move.w d1,d0
	bra.b loc_01ff7a

loc_01ff6a:
	move.w $10384c,d0
	subi.w #$10,d0
	bcc.b loc_01ff7a
	move.w #0,d0

loc_01ff7a:
	move.w d0,$10384c
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #$b,d2
	move.b #3,d3
	move.b #4,d4
	jsr loc_01cc84
	move.l #loc_037000+$10,d0
	moveq #0,d1
	move.w $10384c,d1
	move.l d1,d2
	lsl.l #5,d1
	lsl.l #4,d2
	add.l d1,d0
	add.l d2,d0
	move.l d0,$103850
	jsr loc_01ddd8
	bra.b loc_01ffee

loc_01ffc2:
	move.b $103845,d0
	addi.b #2,d0
	move.b d0,$103844
	move.w $10384c,d0
	move.w #$1c,d1
	move.w #$b,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84

loc_01ffee:
	rts

;##############################################################################
loc_01fff0:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_020022
	bset #0,d0
	move.b d0,$103840
	move.b $10384e,d0
	move.w #$1c,d1
	move.w #$e,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84

loc_020022:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_0200c0
	btst #5,d0
	bne.w loc_0200c0
	btst #0,d0
	bne.b loc_020052
	btst #1,d0
	bne.b loc_020064
	btst #2,d0
	bne.b loc_020078
	btst #3,d0
	bne.b loc_02008c
	bra.w loc_0200ec

loc_020052:
	move.b $10384e,d0
	cmpi.b #$ff,d0
	beq.w loc_0200ec
	addq.b #1,d0
	bra.b loc_02009c

loc_020064:
	move.b $10384e,d0
	cmpi.b #0,d0
	beq.w loc_0200ec
	subi.b #1,d0
	bra.b loc_02009c

loc_020078:
	move.b $10384e,d0
	addi.b #$10,d0
	bcc.w loc_02009c
	move.b #$ff,d0
	bra.b loc_02009c

loc_02008c:
	move.b $10384e,d0
	subi.b #$10,d0
	bcc.b loc_02009c
	move.b #0,d0

loc_02009c:
	move.b d0,$10384e
	move.b $10384e,d0
	move.w #$1c,d1
	move.w #$e,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	bra.b loc_0200ec

loc_0200c0:
	move.b $103845,d0
	addi.b #2,d0
	move.b d0,$103844
	move.b $10384e,d0
	move.w #$1c,d1
	move.w #$e,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_0200ec:
	rts

;##############################################################################
loc_0200ee:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_02012c
	bset #0,d0
	move.b d0,$103840
	move.b #0,$103847
	moveq #0,d0
	move.b $10384f,d0
	move.w #$1c,d1
	move.w #$11,d2
	move.b #3,d3
	move.b $103847,d4
	jsr loc_01ccd2

loc_02012c:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_0201c0
	btst #5,d0
	bne.w loc_0201c0
	btst #0,d0
	bne.b loc_02015c
	btst #1,d0
	bne.b loc_02016a
	btst #2,d0
	bne.b loc_020178
	btst #3,d0
	bne.b loc_02018c
	bra.w loc_0201f0

loc_02015c:
	move.b $103847,d0
	bset d0,$10384f
	bra.b loc_02019e

loc_02016a:
	move.b $103847,d0
	bclr.b d0,$10384f
	bra.b loc_02019e

loc_020178:
	cmpi.b #7,$103847
	beq.b loc_0201f0
	addi.b #1,$103847
	bra.b loc_02019e

loc_02018c:
	cmpi.b #0,$103847
	beq.b loc_0201f0
	subi.b #1,$103847

loc_02019e:
	moveq #0,d0
	move.b $10384f,d0
	move.w #$1c,d1
	move.w #$11,d2
	move.b #3,d3
	move.b $103847,d4
	jsr loc_01ccd2
	bra.b loc_0201f0

loc_0201c0:
	move.b $103845,d0
	addi.b #2,d0
	move.b d0,$103844
	moveq #0,d0
	move.b $10384f,d0
	move.w #$1c,d1
	move.w #$11,d2
	move.b #2,d3
	move.b $103847,d4
	jsr loc_01ccd2

loc_0201f0:
	rts

;##############################################################################
loc_0201f2:
	move.b $103840,d0
	btst #0,d0
	bne.b loc_020226
	bset #0,d0
	move.b d0,$103840
	move.b #0,$103847
	lea.l loc_01d434,a2
	move.b #3,d3
	lea.l $103847,a3
	jsr loc_01cc48

loc_020226:
	move.b ($b1,a5),d0
	btst #4,d0
	bne.b loc_02028c
	btst #5,d0
	bne.w loc_0202b0
	btst #0,d0
	bne.b loc_020248
	btst #1,d0
	bne.b loc_02025e
	bra.w loc_0202ec

loc_020248:
	cmpi.b #0,$103847
	beq.w loc_0202ec
	subi.b #1,$103847
	bra.b loc_020272

loc_02025e:
	cmpi.b #1,$103847
	beq.w loc_0202ec
	addi.b #1,$103847

loc_020272:
	lea.l loc_01d434,a2
	move.b #3,d3
	lea.l $103847,a3
	jsr loc_01cc48
	bra.w loc_0202ec

loc_02028c:
	cmpi.b #0,$103847
	bne.w loc_0202b0
	moveq #0,d0
	move.b $103845,d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_0202ee(pc),a0
	nop
	movea.l (a0,d0.w),a0
	jsr (a0)

loc_0202b0:
	move.b $103845,d0
	addi.b #2,d0
	move.b d0,$103844
	lea.l loc_01d434,a2
	move.b #2,d3
	lea.l $103847,a3
	jsr loc_01cc48
	lea.l loc_01d43a,a2
	move.b #3,d3
	lea.l $103846,a3
	jsr loc_01cc48

loc_0202ec:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0202ee:
	dc.l loc_020302,loc_020372,loc_020430,loc_0204ea
	dc.l loc_020524

;##############################################################################
loc_020302:
	movea.l $103868,a0
	cmpi.w #0,(a0)
	beq.b loc_020370
	movea.l $10386c,a1
	move.w $10384c,(a1)
	move.b $10384e,(2,a1)
	move.b $10384f,(3,a1)
	move.b #1,$103846
	jsr loc_01cfca
	move.b $103864,d0
	move.w #$1c,d1
	move.w #8,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $103865,d0
	move.w #$1f,d1
	move.w #8,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_020370:
	rts

;##############################################################################
loc_020372:
	movea.l $103868,a0
	cmpi.w #0,(a0)
	beq.b loc_0203ac
	movea.l $10386c,a1
	movea.l loc_05a000+$ff0,a3
	adda.l #loc_05a000,a3
	movea.l a3,a2
	suba.l #4,a2

loc_020398:
	cmpa.l a3,a1
	beq.b loc_0203c0
	move.l (a2),(a3)
	suba.l #4,a2
	suba.l #4,a3
	bra.b loc_020398

loc_0203ac:
	movea.l loc_05a000+$ff0,a1
	move.w a1,(a0)
	adda.l #loc_05a000,a1
	move.l a1,$10386c

loc_0203c0:
	move.w $10384c,(a1)
	move.b $10384e,(2,a1)
	move.b $10384f,(3,a1)
	addi.l #4,loc_05a000+$ff0
	addi.b #1,$103865
	move.b #1,$103846
	jsr loc_01cfca
	move.b $103864,d0
	move.w #$1c,d1
	move.w #8,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $103865,d0
	move.w #$1f,d1
	move.w #8,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	rts

;##############################################################################
loc_020430:
	movea.l $103868,a0
	cmpi.w #0,(a0)
	beq.w loc_0204e8
	lea.l loc_05a000,a1
	move.w (a0),d0
	move.w #0,d1

loc_02044a:
	cmp.w (a1)+,d0
	bne.b loc_020450
	addq.w #1,d1

loc_020450:
	cmpa.l #loc_05a000+$ff0,a1
	bcs.b loc_02044a
	cmpi.w #1,d1
	bne.b loc_0204ba
	lea.l loc_05a000,a1
	adda.w (a0),a1
	moveq #0,d0
	move.b $103865,d0
	add.w d0,d0
	add.w d0,d0
	movea.l a1,a2
	adda.w d0,a2
	movea.l loc_05a000+$ff0,a3
	adda.l #loc_05a000,a3

loc_020482:
	cmpa.l a3,a2
	bcc.b loc_02048a
	move.l (a2)+,(a1)+
	bra.b loc_020482

loc_02048a:
	lea.l loc_05a000,a1
	lea.l loc_05a000+$ff0,a2
	move.w (a0),d1

loc_020498:
	move.w (a1),d2
	cmp.w d1,d2
	bcs.b loc_0204a2
	sub.w d0,d2
	move.w d2,(a1)

loc_0204a2:
	adda.l #2,a1
	cmpa.l a1,a2
	bne.b loc_020498
	suba.l d0,a3
	suba.l #loc_05a000,a3
	move.l a3,loc_05a000+$ff0

loc_0204ba:
	move.w #0,(a0)
	move.b #0,$103846
	jsr loc_01ce6a
	move.w $103860,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84

loc_0204e8:
	rts

;##############################################################################
loc_0204ea:
	movea.l $103854,a0
	movea.l $103858,a1
	move.w (a0),(a1)
	move.b #0,$103846
	jsr loc_01ce6a
	move.w $103860,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	rts

;##############################################################################
loc_020524:
	movea.l $103854,a0
	movea.l $103858,a1
	move.w (a0),(a1)
	move.w #0,(a0)
	move.b #0,$103846
	jsr loc_01ce6a
	move.w $103860,d0
	move.w #$1c,d1
	move.w #5,d2
	move.b #2,d3
	move.b #4,d4
	jsr loc_01cc84
	rts

;##############################################################################
loc_020562:
	cmpi.b #0,$103844
	beq.w loc_02067e
	move.l #1,$1037d4
	jsr loc_02096e(pc)
	nop

loc_02057e:
	move.w #$2e,d0
	andi.l #$ffff,d0
	move.w #0,d1
	move.w #0,d2
	move.w #0,d3
	jsr loc_020872(pc)
	nop
	cmpi.b #0,$1037a2
	beq.b loc_0205d4
	moveq #0,d0
	move.b $1037a2,d0
	addi.w #$130,d0
	moveq #0,d1
	move.b $1037a3,d1
	lsl.w #8,d1
	asr.w #8,d1
	move.w d0,d0
	andi.l #$ffff,d0
	move.w d1,d1
	move.w #0,d2
	move.w #0,d3
	jsr loc_020872(pc)
	nop

loc_0205d4:
	move.w $1037a0,d0
	andi.l #$ffff,d0
	move.w #0,d1
	move.w #0,d2
	move.w #0,d3
	jsr loc_020872(pc)
	nop
	cmpi.w #0,$1037cc
	beq.b loc_02062a
	move.b $1037ce,d1
	lsl.w #8,d1
	asr.w #8,d1
	move.b $1037cf,d2
	lsl.w #8,d2
	asr.w #8,d2
	move.w $1037cc,d0
	andi.l #$ffff,d0
	move.w d1,d1
	move.w d2,d2
	move.w #0,d3
	jsr loc_020872(pc)
	nop

loc_02062a:
	jsr loc_0207a2(pc)
	nop
	cmpi.b #$f,$103844
	bcs.b loc_020654
	cmpi.b #$11,$103844
	bcc.b loc_020654
	lea.l $103860,a0
	move.w #$c00,d6
	jsr loc_0207da(pc)
	nop

loc_020654:
	movea.l #VRAMADDR,a0
	movea.l #VRAMRW,a1
	move.l $1037d4,d0
	move.l #$17c,d1
	sub.b d0,d1
	addi.w #$8200,d0

loc_020672:
	move.w d0,(a0)
	move.w #0,(a1)
	addq.w #1,d0
	dbra d1,loc_020672

loc_02067e:
	rts

;##############################################################################
loc_020680:
	cmpi.b #0,$103844
	beq.w loc_0207a0
	move.l #1,$1037d4
	jsr loc_02096e(pc)
	nop
	move.w #$2e,d0
	andi.l #$ffff,d0
	move.w #0,d1
	move.w #0,d2
	move.w #0,d3
	jsr loc_020872(pc)
	nop
	cmpi.b #1,$103845
	beq.b loc_0206d0
	movea.l $103868,a0
	cmpi.b #0,(a0)
	beq.w loc_020776

loc_0206d0:
	cmpi.b #0,$1037a2
	beq.b loc_02070a
	moveq #0,d0
	move.b $1037a2,d0
	addi.w #$130,d0
	moveq #0,d1
	move.b $1037a3,d1
	lsl.w #8,d1
	asr.w #8,d1
	move.w d0,d0
	andi.l #$ffff,d0
	move.w d1,d1
	move.w #0,d2
	move.w #0,d3
	jsr loc_020872(pc)
	nop

loc_02070a:
	moveq #0,d0
	jsr loc_020a22(pc)
	nop
	move.w $1037a0,d0
	andi.l #$ffff,d0
	move.w #0,d1
	move.w #0,d2
	move.w #0,d3
	jsr loc_020872(pc)
	nop
	cmpi.w #0,$1037cc
	beq.b loc_020768
	move.b $1037ce,d1
	lsl.w #8,d1
	asr.w #8,d1
	move.b $1037cf,d2
	lsl.w #8,d2
	asr.w #8,d2
	move.w $1037cc,d0
	andi.l #$ffff,d0
	move.w d1,d1
	move.w d2,d2
	move.w #0,d3
	jsr loc_020872(pc)
	nop

loc_020768:
	moveq #$20,d0
	jsr loc_020a22(pc)
	nop
	jsr loc_0207a2(pc)
	nop

loc_020776:
	movea.l #VRAMADDR,a0
	movea.l #VRAMRW,a1
	move.l $1037d4,d0
	move.l #$17c,d1
	sub.b d0,d1
	addi.w #$8200,d0
	move.w d0,(a0)
	move.w #0,(a1)
	addq.w #1,d0
	dbra d1,loc_020672

loc_0207a0:
	rts

;##############################################################################
loc_0207a2:
	lea.l $1037a0,a0
	lea.l $103831,a3
	cmpi.b #0,(a3)
	beq.b loc_0207d8

loc_0207b4:
	adda.l #4,a0
	cmpa.l #$1037cc,a0
	bcc.w loc_0207d8
	move.b (a3)+,d6
	lsl.w #8,d6
	cmpi.l #0,(a0)
	beq.b loc_0207b4
	jsr loc_0207da(pc)
	nop
	bra.b loc_0207b4

loc_0207d8:
	rts

;##############################################################################
loc_0207da:
	move.b (a0),d1
	lsl.w #8,d1
	asr.w #8,d1
	move.b (1,a0),d2
	lsl.w #8,d2
	asr.w #8,d2
	moveq #0,d4
	move.b (2,a0),d4
	moveq #0,d5
	move.b (3,a0),d5
	movem.l a0, -(a7)
	movem.w d1-d6, -(a7)
	move.w #$2f,d0
	add.w d4,d1
	add.w d5,d2
	move.w #$12,d3
	add.w d6,d3
	jsr loc_020872(pc)
	nop
	movem.w (a7)+,d1-d6
	movem.w d1-d6, -(a7)
	move.w #$2f,d0
	sub.w d4,d1
	subq.w #1,d1
	add.w d5,d2
	move.w #$13,d3
	add.w d6,d3
	jsr loc_020872(pc)
	nop
	movem.w (a7)+,d1-d6
	movem.w d1-d6, -(a7)
	move.w #$2f,d0
	add.w d4,d1
	sub.w d5,d2
	move.w #$10,d3
	add.w d6,d3
	jsr loc_020872(pc)
	nop
	movem.w (a7)+,d1-d6
	movem.w d1-d6, -(a7)
	move.w #$2f,d0
	sub.w d4,d1
	subq.w #1,d1
	sub.w d5,d2
	move.w #$31,d3
	add.w d6,d3
	jsr loc_020872(pc)
	nop
	movem.w (a7)+,d1-d6
	movem.l (a7)+,a0
	rts

;##############################################################################
loc_020872:
	move.l $1037d4,d7
	movea.l #VRAMADDR,a0
	movea.l #VRAMRW,a1
	move.w #1,(2,a1)
	lea.l loc_090020,a2
	lsl.l #2,d0
	movea.l (a2,d0.w),a2
	btst #7,(a2)
	beq.w loc_02096c
	move.b (1,a2),d6
	adda.l #2,a2

loc_0208a8:
	movem.l d6,-(a7)
	movem.l d1,-(a7)
	move.b (1,a2),d5
	andi.w #$3f,d5
	move.w (2,a2),d4
	moveq #1,d1
	btst #1,(5,a2)
	beq.b loc_0208c8
	subq.w #2,d1

loc_0208c8:
	move.w d7,d0
	lsl.w #6,d0
	move.w d0,(a0)

loc_0208ce:
	move.w d4,(a1)
	move.w (4,a2),d0
	move.b d3,d6
	andi.b #3,d6
	eor.b d6,d0
	btst #4,d3
	beq.b loc_0208ec
	andi.w #$ff00,d3
	andi.w #$ff,d0
	or.w d3,d0

loc_0208ec:
	move.w d0,(a1)
	add.w d1,d4
	subq.b #1,d5
	bne.b loc_0208ce
	movem.l (a7)+,d1
	move.w d7,d0
	addi.w #$8000,d0
	move.w d0,(a0)
	move.w #$fff,(a1)
	move.w $1037d2,d4
	sub.w d2,d4
	move.w (6,a2),d0
	lsl.w #7,d0
	asr.w #7,d0
	sub.w d0,d4
	lsl.w #7,d4
	move.w (a2),d0
	andi.w #$3f,d0
	or.w d0,d4
	move.w d7,d0
	addi.w #$8200,d0
	move.w d0,(a0)
	move.w d4,(a1)
	move.w $1037d0,d0
	add.w d1,d0
	move.w (8,a2),d4
	lsl.w #7,d4
	asr.w #7,d4
	btst #0,d6
	beq.b loc_020946
	neg.w d4
	subi.w #$f,d4

loc_020946:
	add.w d0,d4
	lsl.w #7,d4
	move.w d7,d0
	addi.w #$8400,d0
	move.w d0,(a0)
	move.w d4,(a1)
	addq.l #1,d7
	adda.l #$a,a2
	movem.l (a7)+,d6
	subq.b #1,d6
	bne.w loc_0208a8
	move.l d7,$1037d4

loc_02096c:
	rts

;##############################################################################
loc_02096e:
	move.l $1037d4,d7
	movea.l #VRAMADDR,a0
	movea.l #VRAMRW,a1
	move.w #1,(2,a1)
	moveq #$13,d6
	move.w #$80,d4
	move.b loc_037000+8,d3
	lsl.w #8,d3
	move.w #$10,d2
	move.w #0,d1

loc_02099c:
	moveq #$f,d5
	move.w d7,d0
	lsl.w #6,d0
	move.w d0,(a0)

loc_0209a4:
	move.w d4,(a1)
	nop
	nop
	nop
	nop
	move.w d3,(a1)
	nop
	nop
	nop
	nop
	dbra d5,loc_0209a4
	move.w d7,d0
	addi.w #$8000,d0
	move.w d0,(a0)
	nop
	nop
	nop
	nop
	move.w #$fff,(a1)
	nop
	nop
	nop
	nop
	move.w d7,d0
	addi.w #$8200,d0
	move.w d0,(a0)
	nop
	nop
	nop
	nop
	move.w d2,d0
	move.w d0,(a1)
	nop
	nop
	nop
	nop
	move.w d7,d0
	addi.w #$8400,d0
	move.w d0,(a0)
	nop
	nop
	nop
	nop
	move.w d1,d0
	move.w d0,(a1)
	nop
	nop
	nop
	nop
	ori.w #$40,d2
	addq.l #1,d7
	dbra d6,loc_02099c
	move.l d7,$1037d4
	rts

;##############################################################################
loc_020a22:
	btst #2,$103840
	beq.b loc_020a86
	move.b $1037fa,d1
	eor.b d1,d0
	btst #5,d0
	bne.b loc_020a86
	moveq #0,d0
	move.w $1037f6,d0
	move.l d0,d1
	lsl.l #5,d0
	lsl.l #4,d1
	lea.l loc_037000+$10,a0
	adda.l d0,a0
	adda.l d1,a0
	move.w (a0),d0
	move.b $1037f8,d1
	lsl.w #8,d1
	asr.w #8,d1
	move.b $1037f9,d2
	lsl.w #8,d2
	asr.w #8,d2
	move.b $1037fa,d3
	lsr.b #6,d3
	andi.w #1,d3
	move.w d0,d0
	andi.l #$ffff,d0
	move.w d1,d1
	move.w d2,d2
	move.w d3,d3
	jsr loc_020872(pc)

loc_020a86:
	rts

;##############################################################################
loc_020a88:
	move.b $103841,d0
	btst #0,d0
	bne.b loc_020aa6
	bset #0,d0
	move.b d0,$103841
	move.b #0,$10384a

loc_020aa6:
	lea.l loc_01d441,a2
	move.b #3,d3
	lea.l $10384a,a3
	jsr loc_01cc48
	move.b ($b2,a5),d0
	btst #4,d0
	bne.b loc_020b14
	btst #0,d0
	bne.b loc_020ad6
	btst #1,d0
	bne.b loc_020aea
	bra.w loc_020b42

loc_020ad6:
	cmpi.b #0,$10384a
	beq.b loc_020b42
	subi.b #1,$10384a
	bra.b loc_020afc

loc_020aea:
	cmpi.b #3,$10384a
	beq.b loc_020b42
	addi.b #1,$10384a

loc_020afc:
	lea.l loc_01d441,a2
	move.b #3,d3
	lea.l $10384a,a3
	jsr loc_01cc48
	bra.b loc_020b42

loc_020b14:
	move.b $10384a,d0
	addi.b #1,d0
	move.b d0,$103849
	bclr.b #0,$103841
	lea.l loc_01d441,a2
	move.b #4,d3
	lea.l $10384a,a3
	jsr loc_01cc48

loc_020b42:
	rts

;##############################################################################
loc_020b44:
	move.b $103841,d0
	btst #0,d0
	bne.b loc_020ba8
	bset #0,d0
	move.b d0,$103841
	move.b #0,$10384b
	move.b $10384b,d0
	move.w #$f,d1
	move.w #$f,d2
	move.b #2,d3
	move.b #1,d4
	jsr loc_01cc84
	lea.l $103831,a0
	moveq #0,d0
	move.b $10384b,d0
	adda.l d0,a0
	move.b (a0),d0
	move.b d0,d0
	move.w #$11,d1
	move.w #$f,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84

loc_020ba8:
	lea.l $103831,a0
	moveq #0,d0
	move.b $10384b,d0
	adda.l d0,a0
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_020c72
	btst #5,d0
	bne.w loc_020c72
	btst #0,d0
	bne.b loc_020be8
	btst #1,d0
	bne.b loc_020bf6
	btst #2,d0
	bne.b loc_020c04
	btst #3,d0
	bne.b loc_020c20
	bra.w loc_020c7a

loc_020be8:
	cmpi.b #$ff,(a0)
	beq.w loc_020c7a
	addi.b #1,(a0)
	bra.b loc_020c3a

loc_020bf6:
	cmpi.b #0,(a0)
	beq.w loc_020c7a
	subi.b #1,(a0)
	bra.b loc_020c3a

loc_020c04:
	cmpi.b #0,$10384b
	beq.w loc_020c7a
	subi.b #1,$10384b
	suba.l #1,a0
	bra.b loc_020c3a

loc_020c20:
	cmpi.b #9,$10384b
	beq.w loc_020c7a
	addi.b #1,$10384b
	adda.l #1,a0

loc_020c3a:
	move.b (a0),d0
	move.b d0,d0
	move.w #$11,d1
	move.w #$f,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $10384b,d0
	move.w #$f,d1
	move.w #$f,d2
	move.b #2,d3
	move.b #1,d4
	jsr loc_01cc84
	bra.b loc_020c7a

loc_020c72:
	move.b #0,$103849

loc_020c7a:
	rts

;##############################################################################
loc_020c7c:
	move.b $103841,d0
	btst #0,d0
	bne.b loc_020cae
	bset #0,d0
	move.b d0,$103841
	move.b loc_037000+8,d0
	move.w #$f,d1
	move.w #$10,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84

loc_020cae:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_020d1a
	btst #5,d0
	bne.w loc_020d1a
	btst #0,d0
	bne.b loc_020cd2
	btst #1,d0
	bne.b loc_020ce8
	bra.w loc_020d22

loc_020cd2:
	cmpi.b #$ff,loc_037000+8
	beq.w loc_020d22
	addi.b #1,loc_037000+8
	bra.b loc_020cfc

loc_020ce8:
	cmpi.b #0,loc_037000+8
	beq.w loc_020d22
	subi.b #1,loc_037000+8

loc_020cfc:
	move.b loc_037000+8,d0
	move.w #$f,d1
	move.w #$10,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	bra.b loc_020d22

loc_020d1a:
	move.b #0,$103849

loc_020d22:
	rts

;##############################################################################
loc_020d24:
	move.b $103841,d0
	btst #0,d0
	bne.b loc_020d7a
	bset #0,d0
	move.b d0,$103841
	move.w $1037d0,d0
	lsr.w #4,d0
	move.b d0,d0
	move.w #$f,d1
	move.w #$11,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.w $1037d2,d0
	lsr.w #4,d0
	move.b d0,d0
	move.w #$12,d1
	move.w #$11,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84

loc_020d7a:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_020e3e
	btst #5,d0
	bne.w loc_020e3e
	btst #0,d0
	beq.b loc_020daa
	cmpi.w #$200,$1037d2
	beq.w loc_020dc4
	addi.w #$10,$1037d2
	bra.b loc_020dc4

loc_020daa:
	btst #1,d0
	beq.b loc_020dc4
	cmpi.w #$100,$1037d2
	beq.w loc_020dc4
	subi.w #$10,$1037d2

loc_020dc4:
	btst #2,d0
	beq.b loc_020de0
	cmpi.w #0,$1037d0
	beq.w loc_020dfa
	subi.w #$10,$1037d0
	bra.b loc_020dfa

loc_020de0:
	btst #3,d0
	beq.b loc_020dfa
	cmpi.w #$140,$1037d0
	beq.w loc_020dfa
	addi.w #$10,$1037d0

loc_020dfa:
	move.w $1037d0,d0
	lsr.w #4,d0
	move.b d0,d0
	move.w #$f,d1
	move.w #$11,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.w $1037d2,d0
	lsr.w #4,d0
	move.b d0,d0
	move.w #$12,d1
	move.w #$11,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	bra.w loc_020e46

loc_020e3e:
	move.b #0,$103849

loc_020e46:
	rts

;##############################################################################
loc_020e48:
	move.b $103841,d0
	btst #0,d0
	bne.b loc_020e92
	bset #0,d0
	move.b d0,$103841
	move.b ($b4,a5),d0
	move.w #$f,d1
	move.w #$12,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b ($b5,a5),d0
	move.w #$12,d1
	move.w #$12,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84

loc_020e92:
	move.b ($b2,a5),d0
	btst #4,d0
	bne.w loc_020f3e
	btst #5,d0
	bne.w loc_020f3e
	btst #0,d0
	bne.b loc_020ec2
	btst #1,d0
	bne.b loc_020ed4
	btst #2,d0
	bne.b loc_020ee6
	btst #3,d0
	bne.b loc_020ef8
	bra.w loc_020f46

loc_020ec2:
	cmpi.b #$ff,($b4,a5)
	beq.w loc_020f46
	addi.b #1,($b4,a5)
	bra.b loc_020f08

loc_020ed4:
	cmpi.b #1,($b4,a5)
	beq.w loc_020f46
	subi.b #1,($b4,a5)
	bra.b loc_020f08

loc_020ee6:
	cmpi.b #$ff,($b5,a5)
	beq.w loc_020f46
	addi.b #1,($b5,a5)
	bra.b loc_020f08

loc_020ef8:
	cmpi.b #1,($b5,a5)
	beq.w loc_020f46
	subi.b #1,($b5,a5)

loc_020f08:
	move.b ($b4,a5),d0
	move.w #$f,d1
	move.w #$12,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b ($b5,a5),d0
	move.w #$12,d1
	move.w #$12,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	bra.b loc_020f46

loc_020f3e:
	move.b #0,$103849

loc_020f46:
	rts

;##############################################################################
loc_020f48:
	move.b $103842,d0
	btst #0,d0
	bne.b loc_020fac
	bset #0,d0
	move.b d0,$103842
	move.b #0,$1037f1
	lea.l loc_01d44a,a2
	move.b #2,d3
	lea.l $1037f1,a3
	jsr loc_01cc48
	move.w #$4a,d0
	move.b #2,d1
	jsr loc_01cbd4
	jsr loc_01d09e
	move.b $1037f4,d0
	move.w #$23,d1
	move.w #$13,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_020fac:
	lea.l loc_01d446,a2
	move.b #3,d3
	lea.l $1037f1,a3
	jsr loc_01cc48
	move.b ($ba,a5),d0
	btst #4,d0
	bne.b loc_02101a
	btst #0,d0
	bne.b loc_020fdc
	btst #1,d0
	bne.b loc_020ff0
	bra.w loc_02104e

loc_020fdc:
	cmpi.b #0,$1037f1
	beq.b loc_02104e
	subi.b #1,$1037f1
	bra.b loc_021002

loc_020ff0:
	cmpi.b #2,$1037f1
	beq.b loc_02104e
	addi.b #1,$1037f1

loc_021002:
	lea.l loc_01d446,a2
	move.b #3,d3
	lea.l $1037f1,a3
	jsr loc_01cc48
	bra.b loc_02104e

loc_02101a:
	move.b $1037f1,d0
	addq.b #1,d0
	move.b d0,$1037f0
	bclr.b #0,$103842
	lea.l loc_01d446,a2
	move.b #4,d3
	lea.l $1037f1,a3
	jsr loc_01cc48
	move.b #0,$1037f2

loc_02104e:
	rts

;##############################################################################
loc_021050:
	btst #0,$103842
	bne.b loc_021068
	bset #0,$103842
	jsr loc_01d09e

loc_021068:
	move.b $1037f4,d0
	move.w #$23,d1
	move.w #$13,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b ($ba,a5),d0
	btst #4,d0
	bne.w loc_0210fa
	btst #5,d0
	bne.w loc_0210fa
	btst #0,d0
	bne.b loc_0210a8
	btst #1,d0
	bne.b loc_0210c0
	bra.w loc_021126

loc_0210a8:
	move.b $1037f4,d0
	cmpi.b #$40,d0
	beq.w loc_021126
	addi.b #1,$1037f4
	bra.b loc_0210d6

loc_0210c0:
	move.b $1037f4,d0
	cmpi.b #0,d0
	beq.w loc_021126
	subi.b #1,$1037f4

loc_0210d6:
	move.b $1037f4,d0
	move.w #$23,d1
	move.w #$13,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	jsr loc_01d09e
	bra.b loc_021126

loc_0210fa:
	move.b $1037f1,d0
	addi.b #1,d0
	move.b d0,$1037f0
	move.b $1037f4,d0
	move.w #$23,d1
	move.w #$13,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_021126:
	rts

;##############################################################################
loc_021128:
	btst #0,$103842
	bne.b loc_02114e
	bset #0,$103842
	movea.l $103800,a0
	cmpi.w #0,(a0)
	beq.w loc_021206
	jsr loc_01d1fc

loc_02114e:
	move.b $1037f5,d0
	move.w #$23,d1
	move.w #$14,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b ($ba,a5),d0
	move.b ($b8,a5),d1
	btst #6,d1
	beq.b loc_021188
	move.b ($b2,a5),d1
	move.b ($ba,a5),d2
	or.b d2,d1
	andi.b #3,d1
	or.b d1,d0

loc_021188:
	btst #4,d0
	bne.w loc_021206
	btst #5,d0
	bne.w loc_021206
	btst #0,d0
	bne.b loc_0211a8
	btst #1,d0
	bne.b loc_0211ca
	bra.w loc_021232

loc_0211a8:
	move.b $1037fc,d1
	cmpi.b #1,$1037f1
	beq.b loc_0211ba
	subq.b #1,d1

loc_0211ba:
	move.b $1037f5,d0
	cmp.b d1,d0
	beq.w loc_021232
	addq.b #1,d0
	bra.b loc_0211dc

loc_0211ca:
	move.b $1037f5,d0
	cmpi.b #0,d0
	beq.w loc_021232
	subi.b #1,d0

loc_0211dc:
	move.b d0,$1037f5
	move.b $1037f5,d0
	move.w #$23,d1
	move.w #$14,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	jsr loc_01d1fc
	bra.b loc_021232

loc_021206:
	move.b $1037f1,d0
	addi.b #1,d0
	move.b d0,$1037f0
	move.b $1037f5,d0
	move.w #$23,d1
	move.w #$14,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_021232:
	rts

;##############################################################################
loc_021234:
	btst #0,$103842
	bne.b loc_02125a
	bset #0,$103842
	movea.l $103800,a0
	cmpi.w #0,(a0)
	beq.w loc_0212e8
	jsr loc_01d1fc

loc_02125a:
	move.b $1037fb,d0
	move.w #$23,d1
	move.w #$15,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b ($ba,a5),d0
	btst #4,d0
	bne.w loc_0212e8
	btst #5,d0
	bne.w loc_0212e8
	btst #0,d0
	bne.b loc_02129a
	btst #1,d0
	bne.b loc_0212b0
	bra.w loc_021314

loc_02129a:
	cmpi.b #$d,$1037fb
	beq.w loc_021314
	addi.b #1,$1037fb
	bra.b loc_0212c4

loc_0212b0:
	cmpi.b #0,$1037fb
	beq.w loc_021314
	subi.b #1,$1037fb

loc_0212c4:
	move.b $1037fb,d0
	move.w #$23,d1
	move.w #$15,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	jsr loc_01d1fc
	bra.b loc_021314

loc_0212e8:
	move.b $1037f1,d0
	addi.b #1,d0
	move.b d0,$1037f0
	move.b $1037fb,d0
	move.w #$23,d1
	move.w #$15,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_021314:
	rts

;##############################################################################
loc_021316:
	btst #0,$103842
	bne.b loc_021344
	bset #0,$103842
	move.w $1037f6,d0
	move.w #$22,d1
	move.w #$16,d2
	move.b #3,d3
	move.b #3,d4
	jsr loc_01cc84

loc_021344:
	move.b ($ba,a5),d0
	btst #4,d0
	bne.w loc_0213ee
	btst #5,d0
	bne.w loc_0213ee
	btst #0,d0
	bne.b loc_021374
	btst #1,d0
	bne.b loc_02138a
	btst #2,d0
	bne.b loc_0213a0
	btst #3,d0
	bne.b loc_0213be
	bra.w loc_02141a

loc_021374:
	cmpi.w #$1d0,$1037f6
	beq.w loc_02141a
	addi.w #1,$1037f6
	bra.b loc_0213d0

loc_02138a:
	cmpi.w #0,$1037f6
	beq.w loc_02141a
	subi.w #1,$1037f6
	bra.b loc_0213d0

loc_0213a0:
	addi.w #$10,$1037f6
	cmpi.w #$1d0,$1037f6
	bls.w loc_0213d0
	move.w #$1d0,$1037f6
	bra.b loc_0213d0

loc_0213be:
	subi.w #$10,$1037f6
	bcc.b loc_0213d0
	move.w #0,$1037f6

loc_0213d0:
	move.w $1037f6,d0
	move.w #$22,d1
	move.w #$16,d2
	move.b #3,d3
	move.b #3,d4
	jsr loc_01cc84
	bra.b loc_02141a

loc_0213ee:
	move.b $1037f1,d0
	addi.b #1,d0
	move.b d0,$1037f0
	move.w $1037f6,d0
	move.w #$22,d1
	move.w #$16,d2
	move.b #2,d3
	move.b #3,d4
	jsr loc_01cc84

loc_02141a:
	rts

;##############################################################################
loc_02141c:
	btst #0,$103842
	bne.b loc_021466
	bset #0,$103842
	move.b $1037f8,d0
	move.w #$1f,d1
	move.w #$17,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $1037f9,d0
	move.w #$23,d1
	move.w #$17,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84

loc_021466:
	move.b ($ba,a5),d0
	btst #4,d0
	bne.w loc_02151e
	btst #5,d0
	bne.w loc_02151e
	btst #0,d0
	beq.b loc_021494
	cmpi.b #$80,$1037f9
	beq.b loc_0214ac
	subi.b #1,$1037f9
	bra.b loc_0214ac

loc_021494:
	btst #1,d0
	beq.b loc_0214ac
	cmpi.b #$7f,$1037f9
	beq.b loc_0214ac
	addi.b #1,$1037f9

loc_0214ac:
	btst #2,d0
	beq.b loc_0214c8
	cmpi.b #$80,$1037f8
	beq.w loc_0214e2
	subi.b #1,$1037f8
	bra.b loc_0214e2

loc_0214c8:
	btst #3,d0
	beq.b loc_0214e2
	cmpi.b #$7f,$1037f8
	beq.w loc_0214e2
	addi.b #1,$1037f8

loc_0214e2:
	move.b $1037f8,d0
	move.w #$1f,d1
	move.w #$17,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $1037f9,d0
	move.w #$23,d1
	move.w #$17,d2
	move.b #3,d3
	move.b #2,d4
	jsr loc_01cc84
	bra.w loc_021566

loc_02151e:
	move.b $1037f1,d0
	addi.b #1,d0
	move.b d0,$1037f0
	move.b $1037f8,d0
	move.w #$1f,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	move.b $1037f9,d0
	move.w #$23,d1
	move.w #$17,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_021566:
	rts

;##############################################################################
loc_021568:
	btst #0,$103842
	bne.b loc_0215a2
	bset #0,$103842
	move.b #7,$1037f3
	moveq #0,d0
	move.b $1037fa,d0
	move.w #$1f,d1
	move.w #$18,d2
	move.b #3,d3
	move.b $1037f3,d4
	jsr loc_01ccd2

loc_0215a2:
	move.b ($ba,a5),d0
	btst #4,d0
	bne.w loc_021636
	btst #5,d0
	bne.w loc_021636
	btst #0,d0
	bne.b loc_0215d2
	btst #1,d0
	bne.b loc_0215e0
	btst #2,d0
	bne.b loc_0215ee
	btst #3,d0
	bne.b loc_021602
	bra.w loc_021666

loc_0215d2:
	move.b $1037f3,d0
	bset d0,$1037fa
	bra.b loc_021614

loc_0215e0:
	move.b $1037f3,d0
	bclr.b d0,$1037fa
	bra.b loc_021614

loc_0215ee:
	cmpi.b #7,$1037f3
	beq.b loc_021666
	addi.b #1,$1037f3
	bra.b loc_021614

loc_021602:
	cmpi.b #1,$1037f3
	beq.b loc_021666
	subi.b #1,$1037f3

loc_021614:
	moveq #0,d0
	move.b $1037fa,d0
	move.w #$1f,d1
	move.w #$18,d2
	move.b #3,d3
	move.b $1037f3,d4
	jsr loc_01ccd2
	bra.b loc_021666

loc_021636:
	move.b $1037f1,d0
	addi.b #1,d0
	move.b d0,$1037f0
	moveq #0,d0
	move.b $1037fa,d0
	move.w #$1f,d1
	move.w #$18,d2
	move.b #2,d3
	move.b $1037f3,d4
	jsr loc_01ccd2

loc_021666:
	rts

;##############################################################################
loc_021668:
	btst #0,$103842
	bne.b loc_02167a
	bset #0,$103842

loc_02167a:
	moveq #0,d0
	move.b $1037f1,d0
	add.w d0,d0
	add.w d0,d0
	lea.l loc_0216ba(pc),a0
	nop
	movea.l (a0,d0.w),a0
	jsr (a0)
	move.b $1037f1,d0
	addi.b #1,d0
	move.b d0,$1037f0
	lea.l loc_01d44a,a2
	move.b #3,d3
	lea.l $1037f2,a3
	jsr loc_01cc48
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
loc_0216ba:
	dc.l loc_0216c6,loc_021738,loc_021812

;##############################################################################
loc_0216c6:
	movea.l $103800,a0
	cmpi.w #0,(a0)
	beq.b loc_021736
	movea.l $103804,a1
	moveq #0,d2
	move.b $1037fb,d2
	add.w d2,d2
	add.w d2,d2
	move.w $1037f6,d0
	move.b $1037fa,d1
	andi.b #$fe,d1
	lsl.w #8,d1
	or.w d1,d0
	lsl.l #8,d0
	move.b $1037f8,d0
	lsl.l #8,d0
	move.b $1037f9,d0
	move.l d0,(a1,d2.w)
	move.b #1,$1037f2
	jsr loc_01d1fc
	move.b $1037f5,d0
	move.w #$23,d1
	move.w #$14,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84

loc_021736:
	rts

;##############################################################################
loc_021738:
	movea.l $103800,a0
	cmpi.w #0,(a0)
	beq.b loc_021778
	movea.l $103804,a1
	movea.l loc_0600fc,a3
	adda.l #loc_060000,a3
	movea.l a3,a2
	suba.l #$38,a2

loc_02175e:
	cmpa.l a3,a1
	beq.b loc_02178c
	moveq #$d,d0

loc_021764:
	move.l (a2)+,(a3)+
	dbra d0,loc_021764
	suba.l #$70,a2
	suba.l #$70,a3
	bra.b loc_02175e

loc_021778:
	movea.l loc_0600fc,a1
	move.w a1,(a0)
	adda.l #loc_060000,a1
	move.l a1,$10386c

loc_02178c:
	move.w $1037f6,d0
	move.b $1037fa,d1
	andi.b #$fe,d1
	lsl.w #8,d1
	or.w d1,d0
	lsl.l #8,d0
	move.b $1037f8,d0
	lsl.l #8,d0
	move.b $1037f9,d0
	moveq #$d,d1

loc_0217b2:
	move.l d0,(a1)+
	dbra d1,loc_0217b2
	addi.l #$38,loc_0600fc
	addi.b #1,$1037fc
	lea.l loc_060000,a1
	move.w (a0),d0
	moveq #$3f,d1

loc_0217d4:
	cmp.w (a1),d0
	bcc.b loc_0217dc
	addi.w #$38,(a1)

loc_0217dc:
	adda.l #2,a1
	dbra d1,loc_0217d4
	move.b #1,$1037f2
	jsr loc_01d1fc
	move.b $1037f5,d0
	move.w #$23,d1
	move.w #$14,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	rts

;##############################################################################
loc_021812:
	movea.l $103800,a0
	cmpi.w #0,(a0)
	beq.w loc_0218ac
	movea.l $103804,a1
	movea.l a1,a2
	adda.w #$38,a2
	movea.l loc_0600fc,a3
	adda.l #loc_060000,a3

loc_021838:
	cmpa.l a3,a2
	bcc.b loc_021840
	move.l (a2)+,(a1)+
	bra.b loc_021838

loc_021840:
	lea.l loc_060000,a1
	lea.l loc_0600fc,a2
	move.w (a0),d1

loc_02184e:
	cmp.w (a1),d1
	bcc.b loc_021856
	subi.w #$38,(a1)

loc_021856:
	adda.l #2,a1
	cmpa.l a1,a2
	bne.b loc_02184e
	subi.l #$38,loc_0600fc
	jsr loc_01d09e
	move.b $1037f5,d0
	move.w #$23,d1
	move.w #$14,d2
	move.b #2,d3
	move.b #2,d4
	jsr loc_01cc84
	cmpi.b #1,$1037fc
	bls.b loc_0218a0
	move.b #1,$1037f2
	bra.b loc_0218ac

loc_0218a0:
	move.w #0,(a0)
	move.b #0,$1037f2

loc_0218ac:
	rts

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;Data Start 0219f2
	include "Data/data.asm"