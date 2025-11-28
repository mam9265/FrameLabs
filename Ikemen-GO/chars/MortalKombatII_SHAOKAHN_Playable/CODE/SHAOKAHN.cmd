;-| Button Remapping |-----------------------------------------------------
[Remap]
x = x
y = y
z = z
a = a
b = b
c = c
s = s

;-| Default Values |-------------------------------------------------------
[Defaults]
; Default value for the "time" parameter of a Command. Minimum 1.
command.time = 15

; Default value for the "buffer.time" parameter of a Command. Minimum 1,
; maximum 30.
command.buffer.time = 1


;-| Super Motions |--------------------------------------------------------



[Command]
name = "Fatality2"
command = ~D,F,F,D+a
time = 40

[Command]
name = "Fatality2"
command = ~D,F,F,D,a
time = 40

[Command]
name = "Fatality1"
command = ~B,B,F,F+y
time = 40

[Command]
name = "Fatality1"
command = ~B,B,F,F,y
time = 40

[Command]
name = "ShadowCharge1"
command = ~D,F+x
time = 14

[Command]
name = "ShadowCharge2"
command = ~D,F,y
time = 14

[Command]
name = "ShadowCharge2"
command = ~D,F+y
time = 14

[Command]
name = "ShadowCharge1"
command = ~D,F,x
time = 14

[Command]
name = "Grab&Pound"
command = ~F,F,+y
time = 20

[Command]
name = "Grab&Pound"
command = ~F,F,y
time = 20

[Command]
name = "Hammer"
command = ~B,B, F+x
time = 20

[Command]
name = "Hammer"
command = ~B,B, F, x
time = 20

[Command]
name = "FireBall"
command = ~B,B, F+y
time = 20

[Command]
name = "FireBall"
command = ~B,B, F, y
time = 20

[Command]
name = "Arrow"
command = ~B,B, F+b
time = 20

[Command]
name = "Arrow"
command = ~B,B, F, b
time = 20

[Command]
name = "Guarding"
command = /z
time = 1

[Command]
name = "Laugh1"
command = D, D, a
time = 20

[Command]
name = "Laugh2"
command = D, D, b
time = 20

[Command]
name = "Taunt1"
command = D, D, x
time = 20

[Command]
name = "Taunt2"
command = D, D, y
time = 20

;-| Double Tap |-----------------------------------------------------------
[Command]
name = "FF"     ;Required (do not remove)
command = F, F
time = 10

[Command]
name = "BB"     ;Required (do not remove)
command = B, B
time = 10

;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "recovery";Required (do not remove)
command = x+y
time = 1

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
time = 1

;-| Single Button |---------------------------------------------------------
[Command]
name = "a"
command = a
time = 1

[Command]
name = "b"
command = b
time = 1

[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1

[Command]
name = "y"
command = y
time = 1

[Command]
name = "z"
command = z
time = 1

[Command]
name = "start"
command = s
time = 1

;-| Single Dir |------------------------------------------------------------
[Command]
name = "fwd" ;Required (do not remove)
command = $F
time = 1

[Command]
name = "downfwd"
command = $DF
time = 1

[Command]
name = "down" ;Required (do not remove)
command = $D
time = 1

[Command]
name = "downback"
command = $DB
time = 1

[Command]
name = "back" ;Required (do not remove)
command = $B
time = 1

[Command]
name = "upback"
command = $UB
time = 1

[Command]
name = "up" ;Required (do not remove)
command = $U
time = 1

[Command]
name = "upfwd"
command = $UF
time = 1

;-| Hold Button |--------------------------------------------------------------
[Command]
name = "hold_x"
command = /x
time = 1

[Command]
name = "hold_y"
command = /y
time = 1

[Command]
name = "hold_z"
command = /z
time = 1

[Command]
name = "hold_a"
command = /a
time = 1

[Command]
name = "hold_b"
command = /b
time = 1

[Command]
name = "hold_c"
command = /c
time = 1

[Command]
name = "hold_s"
command = /s
time = 1

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd";Required (do not remove)
command = /$F
time = 1

[Command]
name = "holdback";Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdup" ;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holddown";Required (do not remove)
command = /$D
time = 1

;-| AI |------------------------------------------------------
[Command]
name = "CPU1"
command = U, D, F, U, D, F, a+b+c+x+y+z
time = 1
[Command]
name = "CPU2"
command = U, B, F, U, B, F, a+b+c+x+y+z
time = 1
[Command]
name = "CPU3"
command = U, D, D, U, D, D, a+b+c+x+y+z
time = 1
[Command]
name = "CPU4"
command = F, B, U, F, B, U, a+b+c+x+y+z
time = 1
[Command]
name = "CPU5"
command = U, F, U, B, U, F, U, B, a+b+c+x+y+z
time = 1
[Command]
name = "CPU6"
command = U, D, B, U, D, B, a+b+c+x+y+z
time = 1
[Command]
name = "CPU7"
command = F, F, B, F, F, B, a+b+c+x+y+z
time = 1
[Command]
name = "CPU8"
command = U, D, U, U, D, U, a+b+c+x+y+z
time = 1
[Command]
name = "CPU9"
command = F, B, B, F, B, B, a+b+c+x+y+z
time = 1
[Command]
name = "CPU10"
command = F, F, B, B, F, F, B, B, a+b+c+x+y+z
time = 1
[Command]
name = "CPU11"
command = U, U, F, U, U, F, a+b+c+x+y+z
time = 1
[Command]
name = "CPU12"
command = U, B, B, U, B, B, a+b+c+x+y+z
time = 1
[Command]
name = "CPU13"
command = U, B, F, F, U, B, F, F, a+b+c+x+y+z
time = 1
[Command]
name = "CPU14"
command = U, F, B, U, U, F, B, U, a+b+c+x+y+z
time = 1
[Command]
name = "CPU15"
command = U, B, F, U, U, B, F, U, a+b+c+x+y+z
time = 1
[Command]
name = "CPU16"
command = U, B, B, B, U, B, B, B, a+b+c+x+y+z
time = 1
[Command]
name = "CPU17"
command = U, D, B, F, U, D, B, F, a+b+c+x+y+z
time = 1
[Command]
name = "CPU18"
command = U, D, B, D, U, D, B, D, a+b+c+x+y+z
time = 1
[Command]
name = "CPU19"
command = U, D, F, U, U, D, F, U, a+b+c+x+y+z
time = 1
[Command]
name = "CPU20"
command = U, D, U, B, U, D, U, B, a+b+c+x+y+z
time = 1
[Command]
name = "CPU21"
command = U, D, F, F, U, D, F, F, a+b+c+x+y+z
time = 1
[Command]
name = "CPU22"
command = F, F, F, F, F, F, F, F, a+b+c+x+y+z
time = 1
[Command]
name = "CPU23"
command = U, U, U, D, U, U, U, D, a+b+c+x+y+z
time = 1
[Command]
name = "CPU24"
command = B, B, B, B, B, B, a+b+c+x+y+z
time = 1
[Command]
name = "CPU25"
command = D, D, D, D, D, D, D, D, a+b+c+x+y+z
time = 1
[Command]
name = "CPU26"
command = D, D, D, D, D, D, a+b+c+x+y+z
time = 1
[Command]
name = "CPU27"
command = F, F, F, F, F, F, a+b+c+x+y+z
time = 1
[Command]
name = "CPU28"
command = U, U, U, U, U, U, a+b+c+x+y+z
time = 1
[Command]
name = "CPU29"
command = U, U, B, B, U, U, B, B, a+b+c+x+y+z
time = 1
[Command]
name = "CPU30"
command = D, D, F, F, D, D, F, F, a+b+c+x+y+z
time = 1
[Command]
name = "CPU31"
command = U, D, F, U, D, F, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU32"
command = U, B, F, U, B, F, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU33"
command = U, D, D, U, D, D, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU34"
command = F, B, U, F, B, U, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU35"
command = U, F, U, B, U, F, U, B, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU36"
command = U, D, B, U, D, B, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU37"
command = F, F, B, F, F, B, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU38"
command = U, D, U, U, D, U, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU39"
command = F, B, B, F, B, B, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU40"
command = F, F, B, B, F, F, B, B, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU41"
command = U, U, F, U, U, F, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU42"
command = U, B, B, U, B, B, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU43"
command = U, B, F, F, U, B, F, F, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU44"
command = U, F, B, U, U, F, B, U, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU45"
command = U, B, F, U, U, B, F, U, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU46"
command = U, B, B, B, U, B, B, B, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU47"
command = U, D, B, F, U, D, B, F, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU48"
command = U, D, B, D, U, D, B, D, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU49"
command = U, D, F, U, U, D, F, U, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU50"
command = U, D, U, B, U, D, U, B, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU51"
command = U, D, F, F, U, D, F, F, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU52"
command = F, F, F, F, F, F, F, F, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU53"
command = U, U, U, D, U, U, U, D, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU54"
command = B, B, B, B, B, B, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU55"
command = D, D, D, D, D, D, D, D, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU56"
command = D, D, D, D, D, D, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU57"
command = F, F, F, F, F, F, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU58"
command = U, U, U, U, U, U, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU59"
command = U, U, B, B, U, U, B, B, a+b+c+x+y+z+s
time = 1
[Command]
name = "CPU60"
command = D, D, F, F, D, D, F, F, a+b+c+x+y+z+s
time = 1

[StateDef -1]

;AI
[State -1, AI]
type = VarSet
triggerall = var(50) != 1
triggerall = RoundState = 2
triggerall = RoundState != 3
trigger1  = command = "CPU1"
trigger2  = command = "CPU2"
trigger3  = command = "CPU3"
trigger4  = command = "CPU4"
trigger5  = command = "CPU5"
trigger6  = command = "CPU6"
trigger7  = command = "CPU7"
trigger8  = command = "CPU8"
trigger9  = command = "CPU9"
trigger10  = command = "CPU10"
trigger11  = command = "CPU11"
trigger12  = command = "CPU12"
trigger13  = command = "CPU13"
trigger14  = command = "CPU14"
trigger15  = command = "CPU15"
trigger16  = command = "CPU16"
trigger17  = command = "CPU17"
trigger18  = command = "CPU18"
trigger19  = command = "CPU19"
trigger20  = command = "CPU20"
trigger21  = command = "CPU21"
trigger22  = command = "CPU22"
trigger23  = command = "CPU23"
trigger24  = command = "CPU24"
trigger25  = command = "CPU25"
trigger26  = command = "CPU26"
trigger27  = command = "CPU27"
trigger28  = command = "CPU28"
trigger29  = command = "CPU29"
trigger30  = command = "CPU30"
trigger31  = command = "CPU31"
trigger32  = command = "CPU32"
trigger33  = command = "CPU33"
trigger34  = command = "CPU34"
trigger35  = command = "CPU35"
trigger36  = command = "CPU36"
trigger37  = command = "CPU37"
trigger38  = command = "CPU38"
trigger39  = command = "CPU39"
trigger40  = command = "CPU40"
trigger41  = command = "CPU41"
trigger42  = command = "CPU42"
trigger43  = command = "CPU43"
trigger44  = command = "CPU44"
trigger45  = command = "CPU45"
trigger46  = command = "CPU46"
trigger47  = command = "CPU47"
trigger48  = command = "CPU48"
trigger49  = command = "CPU49"
trigger50  = command = "CPU50"
trigger51  = command = "CPU51"
trigger52  = command = "CPU52"
trigger53  = command = "CPU53"
trigger54  = command = "CPU54"
trigger55  = command = "CPU55"
trigger56  = command = "CPU56"
trigger57  = command = "CPU57"
trigger58  = command = "CPU58"
trigger59  = command = "CPU59"
trigger60  = command = "CPU60"
var(40) = 1

;===========================================================================
;---------------------------------------------------------------------------
; Guarding
[State -1, Guarding]
type = ChangeState
triggerall = var(40) = 0
triggerall = stateno != 120
triggerall = stateno != 140
triggerall = ctrl
triggerall = statetype = S || statetype = C
trigger1 = command = "Guarding"
value = 120

;Laugh 1
[State -1]
type = ChangeState
triggerall = var(40) = 0
triggerall = roundstate = 2
triggerall = command = "Laugh1"
triggerall = command != "Fatality2"
trigger1 = statetype = S && ctrl
trigger2 = stateno = 200
trigger2 = Movehit
trigger3 = stateno = 250
trigger3 = Movehit
trigger4 = stateno = 260
trigger4 = Movehit
trigger5 = stateno = 300
trigger5 = Movehit
value = 195

;Laugh 2
[State -1]
type = ChangeState
triggerall = var(40) = 0
triggerall = roundstate = 2
triggerall = command = "Laugh2"
trigger1 = statetype = S && ctrl
trigger2 = stateno = 200
trigger2 = Movehit
trigger3 = stateno = 250
trigger3 = Movehit
trigger4 = stateno = 260
trigger4 = Movehit
trigger5 = stateno = 300
trigger5 = Movehit
value = 196

;Taunt 1
[State -1]
type = ChangeState
triggerall = var(40) = 0
triggerall = roundstate = 2
triggerall = command = "Taunt1"
trigger1 = statetype = S && ctrl
trigger2 = stateno = 200
trigger2 = Movehit
trigger3 = stateno = 250
trigger3 = Movehit
trigger4 = stateno = 260
trigger4 = Movehit
trigger5 = stateno = 300
trigger5 = Movehit
value = 197

;Taunt 2
[State -1]
type = ChangeState
triggerall = var(40) = 0
triggerall = roundstate = 2
triggerall = command = "Taunt2"
trigger1 = statetype = S && ctrl
trigger2 = stateno = 200
trigger2 = Movehit
trigger3 = stateno = 250
trigger3 = Movehit
trigger4 = stateno = 260
trigger4 = Movehit
trigger5 = stateno = 300
trigger5 = Movehit
value = 198

;STRONG PUNCH
[State -1,STRONG PUNCH]
type = ChangeState
;triggerall = var(40) = 0
triggerall = RoundState = 2
triggerall = command = "y" 
triggerall = command != "FireBall"
triggerall = command != "ShadowCharge2"
triggerall = command != "Grab&Pound"
triggerall = command != "holddown"
triggerall = command != "Fatality1"
triggerall = statetype != A
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 200
[State -1,STRONG PUNCH]
type = ChangeState
;triggerall = var(40) = 0
triggerall = RoundState = 2
triggerall = command = "x"
triggerall = command != "Hammer"
triggerall = command != "ShadowCharge1"
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = p2bodydist x >= 20
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 200

;STRONG KICK
[State -1,STRONG KICK]
type = ChangeState
;triggerall = var(40) = 0
triggerall = RoundState = 2
triggerall = command = "a" || command = "b" 
triggerall = command != "Arrow"
triggerall = command != "Fatality2"
triggerall = statetype != A
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 250

;LIGHT PUNCH
[State -1,LIGHT PUNCH]
type = ChangeState
;triggerall = var(40) = 0
triggerall = RoundState = 2
triggerall = command = "x"
triggerall = command != "holdfwd"
triggerall = command != "Hammer"
triggerall = command != "ShadowCharge1"
triggerall = statetype != A
triggerall = p2bodydist x < 24
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 260

;UPPERCUT
[State -1,UPPERCUT]
type = ChangeState
;triggerall = var(40) = 0
triggerall = RoundState = 2
triggerall = command = "y" 
triggerall = command = "holddown"
triggerall = command != "ShadowCharge2"
triggerall = command != "Grab&Pound"
triggerall = command != "Fatality1"
triggerall = statetype != A
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 300

;FIREBALL
[State -1,FIREBALL]
type = ChangeState
triggerall = var(40) = 0
triggerall = RoundState = 2
triggerall = command = "FireBall"
triggerall = command != "ShadowCharge2"
triggerall = command != "Grab&Pound"
triggerall = statetype != A
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 500

;ARROW
[State -1,ARROW]
type = ChangeState
triggerall = var(40) = 0
triggerall = RoundState = 2
triggerall = command = "Arrow"
triggerall = statetype != A
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 510

;GRAB & POUND
[State -1,GRAB & POUND]
type = ChangeState
triggerall = RoundState = 2
triggerall = command = "Grab&Pound"
triggerall = command != "ShadowCharge2"
triggerall = command != "Fatality1"
triggerall = statetype != A
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 600

;THROW
[State -1,THROW]
type = ChangeState
triggerall = var(40) = 0
triggerall = RoundState = 2
triggerall = command = "holdfwd"
triggerall = command = "x"
triggerall = command != "ShadowCharge1"
triggerall = command != "Hammer"
triggerall = statetype != A
triggerall = p2bodydist x < 17
triggerall = p2movetype = I
triggerall = p2statetype = S
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 700

;HAMMER
[State -1,HAMMER]
type = ChangeState
;triggerall = var(40) = 0
triggerall = RoundState = 2
triggerall = command = "Hammer"
triggerall = command != "ShadowCharge1"
triggerall = statetype != A
triggerall = p2stateno != 751
triggerall = enemynear,stateno != 751
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 750

;SHADOW CHARGE
[State -1,SHADOW CHARGE]
type = ChangeState
triggerall = var(40) = 0
triggerall = RoundState = 2
triggerall = command = "ShadowCharge1"
triggerall = statetype != A
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 760

;SHADOW CHARGE
[State -1,SHADOW CHARGE]
type = ChangeState
triggerall = var(40) = 0
triggerall = RoundState = 2
triggerall = command = "ShadowCharge2"
triggerall = statetype != A
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 770


;===========================================================================
;FATALITY TIME
[State -1, FATALITY TIME]
type = Changestate
triggerall = var(40) = 0
triggerall = p2name != "MOTARO"
triggerall = RoundState = 2
triggerall = ctrl = 1
triggerall = p2statetype != A
triggerall = statetype != A
triggerall = P2Life <= 1
triggerall = NumHelper(7000) = 0
triggerall = P2StateNo != 49999
triggerall = RoundNo >1
triggerall = var(58) >= 1
triggerall = var(35) = 0
trigger1 = NumEnemy = 1
trigger1 = NumPartner = 0
value = 10000 

;FATALITY # 1
[State -1, FATALITY # 1]
type = ChangeState
triggerall = RoundState = 2
triggerall = p2stateno = 49999
triggerall = var(35) = 1
triggerall = command = "Fatality1"
triggerall = command != "FireBall"
triggerall = statetype != A
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 1000

;FATALITY # 2
[State -1, FATALITY #2]
type = ChangeState
triggerall = RoundState = 2
triggerall = p2stateno = 49999
triggerall = var(35) = 1
triggerall = command = "Fatality2"
triggerall = statetype != A
trigger1 = Ctrl 
trigger2 = stateno = 130
trigger3 = stateno = 131
ignorehitpause = 1
value = 2000


;****************************************************************************
;****************************************************************************
;***************************A.I.*********************************************
;****************************************************************************
;****************************************************************************
;FATALITY TIME
[State -1, FATALITY TIME]
type = Changestate
triggerall = RoundState = 2
triggerall = p2name != "MOTARO"
triggerall = var(40) = 1
triggerall = stateno != [354,357]
triggerall = p2statetype != A
triggerall = statetype != A
triggerall = P2Life = 1
triggerall = NumHelper(7000) = 0
triggerall = P2StateNo != 49999
triggerall = RoundNo >1
triggerall = var(58) >= 1
triggerall = var(35) = 0
trigger1 = NumEnemy = 1
trigger1 = NumPartner = 0
value = 10000

;---------------------------------------------------------------------------
; Guarding
[State -1, Guarding]
type = ChangeState
triggerall = RoundState = 2
triggerall = var(40) = 1
triggerall = stateno != [195,198]
triggerall = life>1
triggerall = stateno != [5100,5150]
triggerall = NumHelper(7000) = 0
triggeral = P2StateNo != 49999
triggerall = Movetype = I
triggerall = p2Movetype != I || enemynear,movetype != I
triggerall = p2Movetype = A || enemynear,movetype = A
triggerall = stateno != 120
triggerall = stateno != 140
triggerall = ctrl
triggerall = statetype != A
triggerall = Random <=830
triggerall = P2Dist X <100
trigger1 = enemy, NumProj = 1
trigger1 = Random <=300
trigger1 = P2Dist X >=100
value = 120

; Guarding
[State -1, Guarding]
type = ChangeState
triggerall = RoundState = 2
triggerall = var(40) = 1
triggerall = life>1
triggerall = stateno != [5100,5150]
triggerall = stateno != [195,198]
triggerall = NumHelper(7000) = 0
triggeral = P2StateNo != 49999
triggerall = Movetype = I
triggerall = stateno != 120
triggerall = stateno != 140
triggerall = stateno != 25
triggerall = stateno != 500
triggerall = stateno != 501
triggerall = ctrl
triggerall = statetype != A
triggerall = p2Movetype != I || enemynear,movetype != I
trigger1 = p2statetype = C
trigger1 = P2Dist X <70
trigger1 = p2movetype = A
trigger2 = Random =[0,600]
trigger2 = p2movetype = A
trigger2 = enemynear,vel x >0
trigger3 = Random =[0,900]
trigger3 = enemynear,movetype = A
trigger3 = enemynear,statetype = C
trigger4 = enemy, NumProj = 1
trigger4 = Random >300
trigger5 = enemy, NumProj >= 1
trigger5 = P2Dist X <190
trigger5 = Random >900
value = 131

;STRONG PUNCH
[State -1,STRONG PUNCH]
type = ChangeState
triggerall = var(40) = 1
triggerall = stateno != 357
triggerall = stateno != [195,198]
triggerall = life>2
triggerall = p2life>2
triggerall = RoundState = 2
triggerall = Movetype = I
triggerall = ctrl
triggerall     = Random <600
triggerall     = RoundState = 2
triggerall     = statetype != A
triggerall     = p2statetype != L
triggerall     = p2bodydist X < 40
trigger1       = p2statetype = S && enemynear,movetype != A && random = [651,999]
ignorehitpause = 1
value = ifelse(enemynear,stateno = 49999,1000,200)
[State -1,STRONG PUNCH]
type = ChangeState
triggerall = var(40) = 1
triggerall = stateno != 357
triggerall = stateno != [195,198]
triggerall = life>2
triggerall = p2life>2
triggerall = RoundState = 2
triggerall = Movetype = I
triggerall = ctrl
triggerall     = Random <500
triggerall     = RoundState = 2
triggerall     = statetype != A
triggerall     = p2statetype != L
triggerall     = p2bodydist X < 40
trigger1       = p2statetype = S && enemynear,movetype != A && random = [651,900]
ignorehitpause = 1
value = ifelse(enemynear,stateno = 49999,2000,200)

;STRONG KICK
[State -1,STRONG KICK]
type = ChangeState
triggerall = var(40) = 1
triggerall = life>2
triggerall = stateno != [195,198]
triggerall = RoundState = 2
triggerall = statetype != A
triggerall = Ctrl || stateno = 130 || stateno = 131 || stateno = 140
triggerall = statetype != L
triggerall = stateno != 357
triggerall = stateno != 196
triggerall = p2statetype != L

trigger1       = p2movetype = A
trigger1       = p2statetype = C
trigger1       = enemynear,vel x = 0
trigger1       = p2bodydist X < 50
trigger1       = random <= 400 

trigger2       = enemynear, Stateno = 11
trigger2       = enemynear, anim = 11
trigger2       = random >= 890 
trigger2       = p2bodydist X < 50

trigger3       = enemynear,vel x <0
trigger3       = p2bodydist X < 40
trigger3       = p2movetype = H
trigger3       = p2statetype != A
trigger3       = enemy, NumProj <= 0
trigger3       = random <= 700 
ignorehitpause = 1
value = 250

;LIGHT PUNCH
[State -1,LIGHT PUNCH]
type = ChangeState
triggerall = var(40) = 1
triggerall = stateno != 357
triggerall = stateno != [195,198]
triggerall = life>2
triggerall = p2life>2
triggerall = RoundState = 2
triggerall = Random <900
triggerall = statetype != A
triggerall = p2statetype != L
triggerall = p2bodydist X < 30
trigger1   = ctrl
trigger1   = p2statetype != A && enemynear,movetype = H
ignorehitpause = 1
value = ifelse(random<=200,260,700)

;UPPERCUT
[State -1,UPPERCUT]
type = ChangeState
triggerall = var(40) = 1
triggerall = stateno != 357
triggerall = stateno != [195,198]
triggerall     = statetype != L
triggerall = life>2
triggerall = p2life>2
triggerall = RoundState = 2
triggerall = statetype != A
triggerall = ctrl
triggerall     = movetype = I
triggerall     = random <= 900
triggerall     = statetype != L
trigger1       = p2movetype != H
trigger1       = p2bodydist X <50
trigger2       = p2movetype = A
trigger2       = p2statetype = A
trigger2       = p2bodydist X <40
ignorehitpause = 1
value = 300

;SPARK ATTACK & ARROW ATTACK
[State -1,FIREBALL]
type = ChangeState
triggerall = var(40) = 1
triggerall = p2name != "MOTARO"
triggerall = stateno != [195,198]
triggerall = life>2
triggerall = RoundState = 2
triggerall     = statetype != A
triggerall = Ctrl || stateno = 130 || stateno = 131 || stateno = 140
triggerall     = statetype != L
trigger1       = p2movetype != H
trigger1       = p2statetype = A
trigger1       = enemynear,vel x <0
trigger1       = p2bodydist X > 50
trigger1      = random <= 900 
trigger2       = enemynear, Stateno = 50
trigger2       = enemynear, anim = 43 || enemynear, anim = 41
trigger2      = random <= 800 
trigger3       = enemynear,vel x = 0
trigger3       = p2bodydist X > 250
trigger3       = p2movetype = A
trigger3       = p2statetype != A
trigger3       = enemy, NumProj >0
trigger3       = random <= 400 
ignorehitpause = 1
value = ifelse(random<=700,500,510)

;SPARK ATTACK
[State -1,FIREBALL]
type = ChangeState
triggerall = var(40) = 1
triggerall = p2name != "MOTARO"
triggerall = p2name != "SHANG TSUNG"
triggerall = stateno != [195,198]
triggerall = life>2
triggerall = RoundState = 2
triggerall     = statetype != A
triggerall = Ctrl || stateno = 130 || stateno = 131 || stateno = 140
triggerall     = statetype != L
trigger1       = p2bodydist X > 200
trigger1       = enemy, NumProj >=1
trigger1       = random <= 200 
trigger2       = p2bodydist X > 100
trigger2       = p2movetype = I
trigger2       = p2statetype = S
trigger2       = random <= 300 
ignorehitpause = 1
value = 500

;SPARK ATTACK
[State -1,FIREBALL]
type = ChangeState
triggerall = var(40) = 1
triggerall = stateno != [195,198]
triggerall = p2name = "SHANG TSUNG"
triggerall = life>2
triggerall = RoundState = 2
triggerall     = statetype != A
triggerall = Ctrl || stateno = 130 || stateno = 131 || stateno = 140
triggerall     = statetype != L
trigger1       = p2bodydist X > 70
trigger1       = enemy, NumProj >=1
trigger1       = random <= 900 
ignorehitpause = 1
value = 500

;GRAB & POUND
[State -1,GRAB & POUND]
type = ChangeState
triggerall = var(40) = 1
triggerall = life>2
triggerall = stateno != 357
triggerall = stateno != [195,198]
triggerall = RoundState = 2
triggerall     = statetype != A
triggerall = Ctrl || stateno = 130 || stateno = 131 || stateno = 140
triggerall     = statetype != L
triggerall     = p2statetype != L
trigger1       = p2movetype = A
trigger1       = p2statetype = S
trigger1       = enemynear,vel x = 0
trigger1       = p2bodydist X < 50
trigger1       = enemy, NumProj <= 0
trigger1      = random <= 350 
trigger2       = p2movetype = A
trigger2       = p2statetype = A
trigger2       = p2bodydist X >10
trigger2       = p2bodydist X <40
trigger3       = enemynear,vel x <0
trigger3       = p2bodydist X < 40
trigger3       = p2movetype = H
trigger3       = enemy, NumProj <= 0
trigger3       = random <= 400 
ignorehitpause = 1
value = 600

;THROW
[State -1,THROW]
type = ChangeState
triggerall = stateno != 357
triggerall = stateno != [195,198]
triggerall = stateno != [354,357]
triggerall = RoundState = 2
triggerall = p2bodydist x <= 27
triggerall = Random <=810
triggerall = life>2
triggerall = stateno != [5100,5150]
triggerall = var(40) = 1
triggerall = movetype = I
triggerall = statetype = S
triggerall = p2statetype != A
triggerall = p2movetype != H
triggerall = p2statetype != L
trigger1 = Ctrl || stateno = 130 || stateno = 131 || stateno = 140
ignorehitpause = 1
value = ifelse(random<=800,700,260)

;JUMP 1
[State -1,JUMP]
type = ChangeState
triggerall = var(40) = 1
triggerall = life>2
triggerall = Random =[301,999]
triggerall = stateno != [195,198]
triggerall = RoundState = 2
triggerall = statetype != A
triggerall = Ctrl || stateno = 130 || stateno = 131 || stateno = 140
triggerall = stateno != 40
triggerall = stateno != 45
triggerall = stateno != 50
triggerall = stateno != 51
triggerall = stateno != 52
trigger1 = enemy, NumProj >= 1
trigger1 = vel x >0
trigger1 = P2Dist X <280
trigger1 = P2Dist X >180
ignorehitpause = 1
value = 40


;GRAB & POUND
[State -1,GRAB & POUND]
type = ChangeState
triggerall = var(40) = 1
triggerall     = statetype != L
triggerall = stateno != [354,357]
triggerall = life>2
triggerall = p2life>1
triggerall = stateno != [195,198]
triggerall = RoundState = 2
triggerall = Movetype = I
triggerall = ctrl
triggerall     = Random <300
triggerall     = statetype != A
triggerall     = p2statetype != L
triggerall     = p2bodydist X < 40
triggerall     = p2bodydist X > 10
trigger1   = ctrl  && p2movetype != H
trigger1   = p2statetype != A && enemynear,movetype != A && random = [751,999]
ignorehitpause = 1
value = ifelse(random<=300,600, ifelse(random>500,750,250))

;SHADOW CHARGE 2
[State -1,SHADOW CHARGE 2] 
type = ChangeState
triggerall = var(40) = 1
triggerall = life>2
triggerall = Random =[1,700]
triggerall = stateno != [195,198]
triggerall = RoundState = 2
triggerall = statetype != A
triggerall = P2Dist X <200
triggerall = Ctrl || stateno = 130 || stateno = 131 || stateno = 140
trigger1       = p2movetype != H
trigger1       = p2statetype = A
trigger1       = enemynear,vel x >0
trigger1       = p2bodydist X > 50
trigger1      = random >= 550 
trigger2       = enemynear, Stateno = 50
trigger2       = enemynear, anim = 43 || enemynear, anim = 42
trigger2      = random <= 800 
ignorehitpause = 1
value = 770


;SHADOW CHARGE 1
[State -1,SHADOW CHARGE 1]
type = ChangeState
triggerall = var(40) = 1
triggerall = life>2
triggerall = stateno != [195,198]
triggerall = RoundState = 2
triggerall     = statetype != A
triggerall = Ctrl || stateno = 130 || stateno = 131 || stateno = 140
triggerall     = statetype != L
triggerall     = p2statetype != L
trigger1       = p2movetype = A
trigger1       = p2statetype = C
trigger1       = enemynear,vel x = 0
trigger1       = p2bodydist X > 80
trigger1       = p2bodydist X < 190
trigger1      = random <= 400 
trigger2       = enemynear, Stateno = 11
trigger2       = enemynear, anim = 11
trigger2      = random <= 400 
trigger2       = p2bodydist X > 80
trigger2       = p2bodydist X < 190
trigger3       = enemynear,vel x <0
trigger3       = p2bodydist X > 150
trigger3       = p2movetype = H
trigger3       = p2statetype != A
trigger3       = enemy, NumProj <= 0
trigger3       = random >= 580 
ignorehitpause = 1
value = 760

;HAMMER
[State -1,HAMMER]
type = ChangeState
triggerall = var(40) = 1
triggerall = life>2
triggerall = stateno != [195,198]
triggerall = RoundState = 2
triggerall     = statetype != A
triggerall = Ctrl || stateno = 130 || stateno = 131 || stateno = 140
triggerall     = statetype != L
triggerall     = p2statetype != L
trigger1       = p2movetype = A
trigger1       = p2statetype = C
trigger1       = enemynear,vel x = 0
trigger1       = p2bodydist X < 110
trigger1      = random >= 700 
trigger2       = enemynear, Stateno = 11
trigger2       = enemynear, anim = 11
trigger2      = random >= 800 
trigger2      = p2bodydist X < 110
trigger3       = enemynear,vel x <0
trigger3       = p2bodydist X < 110
trigger3       = p2movetype = H
trigger3       = p2statetype != A
trigger3       = enemy, NumProj <= 0
trigger3      = random >= 600 
ignorehitpause = 1
value = 750

;Taunt
[State -1]
type = ChangeState
triggerall = var(40) = 1
triggerall = RoundState = 2
triggerall = stateno != [195,198]
triggerall = random <200
triggerall = life>2
triggerall     = statetype != L
triggerall = statetype = S
trigger1 = stateno = 200
trigger1 = Movehit && time <18
trigger2 = stateno = 250
trigger2 = Movehit && time <18
trigger3 = stateno = 300
trigger3 = Movehit && time <18
value = ifelse(random<=500,195, ifelse(random>500,196,197))

;FATALITY
[State -1, FATALITY]
type = ChangeState
triggerall = var(40) = 1
triggerall = life>1
triggerall = RoundState = 2
triggerall = statetype != A
triggerall = Movetype != A
triggerall = enemynear,stateno = 49999 || p2stateno = 49999 
trigger1   = stateno = 0 || stateno = 20
trigger1 = Ctrl 
trigger2 = Ctrl || stateno = 130 || stateno = 131 || stateno = 140
value = ifelse(random<=500,1000,2000)
