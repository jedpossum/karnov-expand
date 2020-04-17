loc_064000:
;RAY
	dc.l $00030000 ;Walk Forward
	dc.l $00021900 ;Walk Backward
	dc.l $00031800 ;Jump DH
	dc.l $000b0000 ;Jump DV
	dc.l $0000b000 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;FEILIN
	dc.l $00030000 ;Walk Forward
	dc.l $00021900 ;Walk Backward
	dc.l $00030000 ;Jump DH
	dc.l $000c8000 ;Jump DV
	dc.l $0000b000 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;RYOKO
	dc.l $00038000 ;Walk Forward
	dc.l $0002cc00 ;Walk Backward
	dc.l $00038000 ;Jump DH
	dc.l $00090000 ;Jump DV
	dc.l $00008800 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;MATLOK
	dc.l $00030000 ;Walk Forward
	dc.l $00021900 ;Walk Backward
	dc.l $00030000 ;Jump DH
	dc.l $000d0000 ;Jump DV
	dc.l $0000d000 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;SAMCHAY
	dc.l $0002e000 ;Walk Forward
	dc.l $00020300 ;Walk Backward
	dc.l $0002e000 ;Jump DH
	dc.l $00098000 ;Jump DV
	dc.l $00009800 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;LEE
	dc.l $0002c000 ;Walk Forward
	dc.l $0001ec00 ;Walk Backward
	dc.l $00030000 ;Jump DH
	dc.l $00098000 ;Jump DV
	dc.l $00009800 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;MIZOGUCHI
	dc.l $00030000 ;Walk Forward
	dc.l $00020000 ;Walk Backward
	dc.l $00030000 ;Jump DH
	dc.l $00090000 ;Jump DV
	dc.l $00009800 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;JEAN
	dc.l $00030000 ;Walk Forward
	dc.l $00020000 ;Walk Backward
	dc.l $00030000 ;Jump DH
	dc.l $000b0000 ;Jump DV
	dc.l $00009000 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;MARSTORIUS
	dc.l $00020000 ;Walk Forward
	dc.l $00018000 ;Walk Backward
	dc.l $00020000 ;Jump DH	;23000 potential buff
	dc.l $00060000 ;Jump DV	;70000
	dc.l $00006000 ;Jump G  ;07000
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;YUNGMIE
	dc.l $00032000 ;Walk Forward
	dc.l $00023000 ;Walk Backward
	dc.l $00032000 ;Jump DH
	dc.l $000c0000 ;Jump DV
	dc.l $0000ac00 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;ZAZIE
	dc.l $0002e000 ;Walk Forward
	dc.l $00020300 ;Walk Backward
	dc.l $0002e000 ;Jump DH
	dc.l $0007e000 ;Jump DV
	dc.l $00008000 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;CLOWN
	dc.l $00030000 ;Walk Forward
	dc.l $00020000 ;Walk Backward
	dc.l $00030000 ;Jump DH
	dc.l $000c0000 ;Jump DV
	dc.l $0000a000 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;KARNOV
	dc.l $00028000 ;Walk Forward
	dc.l $0001c000 ;Walk Backward
	dc.l $00028000 ;Jump DH
	dc.l $000b0000 ;Jump DV
	dc.l $0000a000 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;OX
	dc.l $00048000 ;Walk Forward
	dc.l $00018000 ;Walk Backward
	dc.l $00038000 ;Jump DH
	dc.l $000a0000 ;Jump DV
	dc.l $0000a000 ;Jump G
	dc.l $00050000 ;Back Jump DH
	dc.l $00040000 ;Back Jump DV
	dc.l $0000a000 ;Back Jump G

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;Attack data
loc_0641c0:
;Ray
	dc.w $1080,$0710;Close LP
	dc.w $5180,$1c05;Close LK
	dc.w $1040,$8710;Close HP
	dc.w $5180,$9c05;Close HK
	dc.w $1040,$0710;Far LP
	dc.w $5180,$1c05;Far LK
	dc.w $1040,$8710;Far HP
	dc.w $5180,$9c11;Far HK
	dc.w $1040,$0710;2LP
	dc.w $5180,$1c05;2LK
	dc.w $0040,$8710;2HP
	dc.w $4182,$9c05;2HK
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $3280,$205d
	dc.w $3500,$285d
	dc.w $5285,$1005
	dc.w $5403,$181f
	dc.w $5403,$181f
	dc.w $5403,$1811
	dc.w $5403,$1811
	dc.w $5403,$1c11
	dc.w $5403,$1c11
	dc.w $5283,$185f
	dc.w $5283,$185f
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;Feilin 64280
	dc.w $1040,$0610;Close LP
	dc.w $5180,$1c05;Close LK
	dc.w $1040,$8610;Close HP
	dc.w $5180,$9c11;Close HK
	dc.w $1040,$0610;Far LP
	dc.w $5180,$1c05;Far LK
	dc.w $1040,$8610;Far HP
	dc.w $5180,$9c11;Far HK
	dc.w $1040,$0610;2LP
	dc.w $5180,$1c05;2LK
	dc.w $0040,$8610;2HP
	dc.w $4182,$9c05;2HK
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $3280,$a068
	dc.w $0000,$0005
	dc.w $5185,$1005
	dc.w $1403,$1211
	dc.w $d403,$1411
	dc.w $e285,$1005
	dc.w $5200,$9005
	dc.w $6280,$9811
	dc.w $0000,$0005
	dc.w $1501,$101f
	dc.w $5503,$1011
	dc.w $1501,$101f
	dc.w $5503,$1011
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;Ryoko 64340
	dc.w $1040,$0510;Close LP
	dc.w $5180,$1c05;Close LK
	dc.w $0282,$8510;Close HP
	dc.w $d100,$9005;Close HK
	dc.w $1040,$0510;Far LP
	dc.w $d180,$1c05;Far LK
	dc.w $0282,$9010;Far HP
	dc.w $5180,$9811;Far HK
	dc.w $1040,$0510;2LP
	dc.w $4182,$1c05;2LK
	dc.w $0040,$8510;2HP
	dc.w $4182,$9811;2HK
	dc.w $2080,$0810
	dc.w $6180,$1c05
	dc.w $2080,$8810
	dc.w $6180,$9805
	dc.w $2080,$0810
	dc.w $6180,$1c05
	dc.w $2080,$8810
	dc.w $6200,$9805
	dc.w $3280,$2086
	dc.w $3280,$2089
	dc.w $3400,$2c05
	dc.w $3000,$0005
	dc.w $3000,$0088
	dc.w $3109,$0c82
	dc.w $3000,$0005
	dc.w $3000,$0005
	dc.w $3000,$001d
	dc.w $3000,$001d
	dc.w $3823,$5010
	dc.w $3501,$1405
	dc.w $3000,$0005
	dc.w $3781,$3005
	dc.w $3000,$0005
	dc.w $1181,$0c05
	dc.w $5181,$0c05
	dc.w $5200,$1005
	dc.w $3081,$1011
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;Matlok 64400
	dc.w $1040,$0610;Close LP
	dc.w $5180,$1c05;Close LK
	dc.w $1040,$8610;Close HP
	dc.w $d180,$9005;Close HK
	dc.w $1040,$0610;Far LP
	dc.w $5180,$1c11;Far LK
	dc.w $1040,$8610;Far HP
	dc.w $5180,$9c11;Far HK
	dc.w $1040,$0610;2LP
	dc.w $5280,$1c05;2LK
	dc.w $0040,$8610;2HP
	dc.w $4182,$9c05;2HK
	dc.w $2080,$0c10
	dc.w $6180,$2011
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $2080,$0c10
	dc.w $6180,$1c11
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $3280,$20b2
	dc.w $5185,$1011
	dc.w $d203,$1811
	dc.w $d203,$1811
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $6401,$2011
	dc.w $6401,$2011
	dc.w $2180,$0c10
	dc.w $0000,$0005
	dc.w $2200,$1005
	dc.w $0000,$0005
	dc.w $d203,$1811
	dc.w $d281,$1811
	dc.w $0000,$0005
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;Samchay 644c0
	dc.w $1040,$0a10;Close LP
	dc.w $5180,$1c11;Close LK
	dc.w $1040,$8c10;Close HP
	dc.w $d180,$9411;Close HK
	dc.w $1040,$0a10;Far LP
	dc.w $5180,$1c11;Far LK
	dc.w $1040,$8c10;Far HP
	dc.w $5180,$9e11;Far HK
	dc.w $1040,$0a10;2LP
	dc.w $5180,$1c05;2LK
	dc.w $0040,$8710;2HP
	dc.w $4182,$9c11;2HK
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $3000,$009a
	dc.w $3108,$069a
	dc.w $3208,$209c
	dc.w $3000,$809b
	dc.w $3108,$869b
	dc.w $3208,$a09c
	dc.w $5185,$1011
	dc.w $1283,$1811
	dc.w $5283,$1811
	dc.w $5283,$1811
	dc.w $5283,$1811
	dc.w $5281,$1805
	dc.w $5281,$1805
	dc.w $5280,$1c05
	dc.w $5280,$9c05
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;Lee 64580
	dc.w $1040,$0c10;Close LP
	dc.w $5180,$1e05;Close LK
	dc.w $1040,$8610;Close HP
	dc.w $5180,$9c05;Close HK
	dc.w $1040,$0c10;Far LP
	dc.w $5180,$1e05;Far LK
	dc.w $1040,$8610;Far HP
	dc.w $5180,$9c11;Far HK
	dc.w $1040,$0c10;2LP
	dc.w $5180,$1e05;2LK
	dc.w $0040,$8610;2HP
	dc.w $4182,$9c11;2HK
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $3280,$20a4
	dc.w $5501,$200b
	dc.w $5501,$200b
	dc.w $9283,$10a0
	dc.w $5283,$1611
	dc.w $5283,$1611
	dc.w $1181,$1811
	dc.w $0000,$0000
	dc.w $5281,$200b
	dc.w $5283,$1ca0
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;MIZOGUCHI 64640
	dc.w $1040,$0710;Close LP
	dc.w $5180,$1c05;Close LK
	dc.w $1040,$8710;Close HP
	dc.w $d100,$9005;Close HK
	dc.w $1040,$0710;Far LP
	dc.w $5180,$1e05;Far LK
	dc.w $1040,$8710;Far HP
	dc.w $5180,$9c11;Far HK
	dc.w $1040,$0710;2LP
	dc.w $5200,$1e05;2LK
	dc.w $0040,$8710;2HP
	dc.w $4182,$9c11;2HK
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $e180,$9005
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $3280,$208d
	dc.w $3280,$9c8e
	dc.w $5285,$1011
	dc.w $d283,$1811
	dc.w $d283,$1811
	dc.w $1000,$0005
	dc.w $1101,$0a11
	dc.w $1201,$0c11
	dc.w $1301,$0e11
	dc.w $1401,$1011
	dc.w $5783,$3011
	dc.w $0000,$0005
	dc.w $5901,$5092
	dc.w $1281,$1293
	dc.w $5283,$1811
	dc.w $3281,$080d
	dc.w $3281,$0e11
	dc.w $3281,$1005
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;JEAN 64700
	dc.w $1040,$0610;Close LP
	dc.w $5180,$1c05;Close LK
	dc.w $1040,$8610;Close HP
	dc.w $5180,$9c05;Close HK
	dc.w $1040,$0610;Far LP
	dc.w $5180,$1c05;Far LK
	dc.w $1040,$8610;Far HP
	dc.w $5180,$9c11;Far HK
	dc.w $1040,$0610;2LP
	dc.w $5180,$1c05;2LK
	dc.w $0040,$8610;2HP
	dc.w $4182,$9c05;2HK
	dc.w $2080,$0c10
	dc.w $6180,$1c11
	dc.w $2080,$8c10
	dc.w $6180,$9c11
	dc.w $2080,$0c10
	dc.w $6180,$1c11
	dc.w $2080,$8c10
	dc.w $6180,$9c11
	dc.w $3280,$20c2
	dc.w $3500,$28c2
	dc.w $5285,$1011
	dc.w $d181,$0ac3
	dc.w $d181,$0ac3
	dc.w $5283,$2011
	dc.w $5283,$2011
	dc.w $0080,$8a1f
	dc.w $4182,$981f
	dc.w $5501,$2011
	dc.w $6501,$2011
	dc.w $0000,$0011
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;MARSTORIUS 647c0
	dc.w $1040,$0810;Close LP
	dc.w $5180,$1e05;Close LK
	dc.w $1040,$8810;Close HP
	dc.w $5280,$1e11;Close HK
	dc.w $1040,$0810;Far LP
	dc.w $5180,$1e11;Far LK
	dc.w $1040,$8810;Far HP
	dc.w $5180,$9e11;Far HK
	dc.w $1040,$0810;2LP
	dc.w $5180,$1e11;2LK
	dc.w $0040,$8810;2HP
	dc.w $4182,$9e05;2HK
	dc.w $2080,$0e10
	dc.w $6180,$1e11
	dc.w $2080,$8e10
	dc.w $6180,$9e05
	dc.w $2080,$0e10
	dc.w $6180,$1e05
	dc.w $2080,$8e10
	dc.w $6180,$9e11
	dc.w $3280,$226f
	dc.w $3280,$2078
	dc.w $e282,$9805
	dc.w $9283,$1e74
	dc.w $9283,$1e74
	dc.w $2281,$1e11
	dc.w $2281,$1e11
	dc.w $5283,$1e11
	dc.w $5283,$1e11
	dc.w $6182,$9e05
	dc.w $6180,$1e05
	dc.w $1203,$1811
	dc.w $6203,$1805
	dc.w $1201,$1811
	dc.w $6203,$1805
	dc.w $3000,$0078
	dc.w $3781,$4078
	dc.w $1081,$0172
	dc.w $3801,$7878
	dc.w $0000,$0005
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;YUNGMIE 64880
	dc.w $1040,$8610;Close LP
	dc.w $1100,$9005;Close LK
	dc.w $1040,$8610;Close HP
	dc.w $5180,$9c11;Close HK
	dc.w $1040,$8610;Far LP
	dc.w $5180,$9c05;Far LK
	dc.w $1040,$8610;Far HP
	dc.w $5180,$9c11;Far HK
	dc.w $1040,$8610;2LP
	dc.w $5180,$9c05;2LK
	dc.w $0040,$8610;2HP
	dc.w $4182,$9c11;2HK
	dc.w $2080,$8c10
	dc.w $6180,$9c11
	dc.w $2080,$8c10
	dc.w $6180,$9c11
	dc.w $2080,$8c10
	dc.w $6180,$9c11
	dc.w $2080,$8c10
	dc.w $e180,$9411
	dc.w $3280,$20b9
	dc.w $5285,$1011
	dc.w $1283,$18bd
	dc.w $1283,$18bd
	dc.w $11a3,$28b8
	dc.w $0000,$0000
	dc.w $0000,$0006
	dc.w $6200,$9cb8
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;ZAZIE 64940
	dc.w $1040,$0710;Close LP
	dc.w $d280,$1e11;Close LK
	dc.w $1040,$8c10;Close HP
	dc.w $5200,$9a11;Close HK
	dc.w $1040,$0710;Far LP
	dc.w $5180,$1c05;Far LK
	dc.w $1040,$8a10;Far HP
	dc.w $5200,$9e11;Far HK
	dc.w $1040,$0710;2LP
	dc.w $5180,$1c11;2LK
	dc.w $0040,$8710;2HP
	dc.w $4182,$9c05;2HK
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c11
	dc.w $3280,$14ac
	dc.w $d101,$0ca9
	dc.w $d101,$0ca9
	dc.w $d2a3,$2011
	dc.w $d2a3,$2011
	dc.w $0000,$00ab
	dc.w $0000,$00ab
	dc.w $0000,$00ab
	dc.w $0000,$00ab
	dc.w $0000,$00ab
	dc.w $0000,$00ab
	dc.w $5180,$1c05
	dc.w $5523,$28a6
	dc.w $5523,$20a6
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;CLOWN 64a00
	dc.w $1040,$0610;Close LP
	dc.w $d180,$1011;Close LK
	dc.w $1040,$8610;Close HP
	dc.w $5180,$9c05;Close HK
	dc.w $1280,$0610;Far LP
	dc.w $5180,$1c05;Far LK
	dc.w $1040,$8610;Far HP
	dc.w $5180,$9c11;Far HK
	dc.w $1040,$0610;2LP
	dc.w $5180,$1c05;2LK
	dc.w $0040,$8610;2HP
	dc.w $4182,$9c11;2HK
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $2080,$0c10
	dc.w $6180,$1c05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $3000,$0005
	dc.w $3108,$8606
	dc.w $3200,$1c05
	dc.w $5285,$1008
	dc.w $1000,$0079
	dc.w $5283,$2010
	dc.w $5283,$2010
	dc.w $2000,$007d
	dc.w $e283,$2010
	dc.w $2283,$2010
	dc.w $6503,$1c7e
	dc.w $2000,$007a
	dc.w $6503,$1c7e
	dc.w $2000,$007a
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;KARNOV 64ac0
	dc.w $1040,$0810;Close LP
	dc.w $5180,$1c11;Close LK
	dc.w $1040,$8710;Close HP
	dc.w $5180,$9c05;Close HK
	dc.w $1040,$0810;Far LP
	dc.w $5180,$1e05;Far LK
	dc.w $1040,$8710;Far HP
	dc.w $5180,$9c11;Far HK
	dc.w $1040,$0810;2LP
	dc.w $5180,$1c05;2LK
	dc.w $0040,$8710;2HP
	dc.w $4182,$9c1f;2HK
	dc.w $2080,$0c10
	dc.w $6180,$1c11
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $2080,$0c10
	dc.w $6180,$1e05
	dc.w $2080,$8c10
	dc.w $6180,$9c05
	dc.w $3280,$a00a
	dc.w $51a7,$101d
	dc.w $51a7,$181d
	dc.w $51a7,$181d
	dc.w $51a7,$181d
	dc.w $51a7,$181d
	dc.w $d283,$1805
	dc.w $0000,$0005
	dc.w $0000,$0005
	dc.w $0000,$0005
	dc.w $2501,$1c05
	dc.w $2501,$1c05
	dc.w $2501,$1c05
	dc.w $2501,$1c05
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

;OX 64b80
	dc.w $5003,$2005;Close LP
	dc.w $5003,$2005;Close LK
	dc.w $5003,$2005;Close HP
	dc.w $5003,$2005;Close HK
	dc.w $5003,$2005;Far LP
	dc.w $5003,$2005;Far LK
	dc.w $5003,$2005;Far HP
	dc.w $5003,$2005;Far HK
	dc.w $5003,$2005;2LP
	dc.w $5003,$2005;2LK
	dc.w $5003,$2005;2HP
	dc.w $5003,$2019;2HK
	dc.w $6003,$201b
	dc.w $6003,$201b
	dc.w $6003,$2005
	dc.w $6003,$2005
	dc.w $6003,$201b
	dc.w $6003,$201b
	dc.w $6003,$2005
	dc.w $6003,$2005
	dc.w $7001,$201b
	dc.w $5000,$2005
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000
	dc.w $0000,$0000

