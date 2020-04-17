
scoreboard = $100004

rngstart = $100064
rngbyte1 = $100065
rngbyte2 = $100066
rngread = $100067

;'Droid Sans Mono', 'monospace', monospace, 'Droid Sans Fallback'
; = $101000 if 3 vsmode
mainmode = $101002

stageid = $103464

vsstagecounter = $106932
exstageflag = $106932 ;Byte

GameDifficulty = $106C3C
prevstageholder = $100C00
prevstagevalue = $100C04;which one you're on

;Player Memory
player1mem = $103670
player2mem = $103870
playeroffset = $200

;
charid = $01
Palid = $03 ;Byte
playerstate = $05
wins = $06
palramoffset = $20

;cpu = bf

playerx =  $c0
playery =  $c4

atkactive = $d0

life = $147
lifegfx = $148

;AI Memory
; = $180
; = $181
; = $182
; = $183
; = $184
; = $185
; = $186
CpuAttackTimer = $187 ;Attack Timer short timer when hits 0/1 attacks
; = $188
CPUtimer2 = $189 ;Action Timer?
;counter = $18a
Cputimer3 = $18b
previousatk = $18c
opponentaction = $18e

;Cpu???= $190

buttonset = $1d0

;Direct
p1wins = player1mem+wins
p2wins = player2mem+wins


;------------------------------------------------------------------------------
fighttimer = $103a70

projectilestart = $1064f0
paletteeffectstart = $106a5e
