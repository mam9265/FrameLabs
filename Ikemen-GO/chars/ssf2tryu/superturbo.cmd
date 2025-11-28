
[Command]
name = "QCB2_x"
command = ~D, B, D, B, x
time = 22

[Command]
name = "QCB2_y"
command = ~D, B, D, B, y
time = 22

[Command]
name = "QCB2_z"
command = ~D, B, D, B, z
time = 22

[Command]
name = "QCF2_x"
command = ~D, F, D, F, x
time = 22

[Command]
name = "QCF2_y"
command = ~D, F, D, F, y
time = 22

[Command]
name = "QCF2_z"
command = ~D, F, D, F, z
time = 22

[Command]
name = "QCB2_a"
command = ~D, B, D, B, a
time = 22

[Command]
name = "QCB2_b"
command = ~D, B, D, B, b
time = 22

[Command]
name = "QCB2_c"
command = ~D, B, D, B, c
time = 22

[Command]
name = "QCF2_a"
command = ~D, F, D, F, a
time = 22

[Command]
name = "QCF2_b"
command = ~D, F, D, F, b
time = 22

[Command]
name = "QCF2_c"
command = ~D, F, D, F, c
time = 22

;-| Special move |------------------------------------------------------------------
[Command]
name = "QCF_x"
command = ~D, DF, F, x
time = 20

[Command]
name = "QCF_y"
command = ~D, DF, F, y
time = 20

[Command]
name = "QCF_z"
command = ~D, DF, F, z
time = 20

[Command]
name = "HCF_x"
command = ~B, DB, D, DF, F, x
time = 25

[Command]
name = "HCF_y"
command = ~B, DB, D, DF, F, y
time = 25

[Command]
name = "HCF_z"
command = ~B, DB, D, DF, F, z
time = 25


[Command]
name = "QCF_a"
command = ~D, DF, F, a
time = 20

[Command]
name = "QCF_b"
command = ~D, DF, F, b
time = 20

[Command]
name = "QCF_c"
command = ~D, DF, F, c
time = 20

[Command]
name = "QCB_x"
command = ~D, DB, B, x
time = 20

[Command]
name = "QCB_y"
command = ~D, DB, B, y
time = 20

[Command]
name = "QCB_z"
command = ~D, DB, B, z
time = 20

[Command]
name = "DP_x"
command = ~F, D, DF, x
time = 20

[Command]
name = "DP_y"
command = ~F, D, DF, y
time = 20

[Command]
name = "DP_z"
command = ~F, D, DF, z
time = 20

[Command]
name = "QCB_a"
command = ~D, DB, B, a
time = 20

[Command]
name = "QCB_b"
command = ~D, DB, B, b
time = 20

[Command]
name = "QCB_c"
command = ~D, DB, B, c
time = 20

[Command]
name = "ZC_p"
command = ~B, D, x
time = 20

[Command]
name = "ZC_p"
command = ~B, D, y
time = 20

[Command]
name = "ZC_p"
command = ~B, D, z
time = 20

[Command]
name = "ZC_k"
command = ~B, D, a
time = 20

[Command]
name = "ZC_k"
command = ~B, D, b
time = 20

[Command]
name = "ZC_k"
command = ~B, D, c
time = 20

;-| Throw |-----------------------------------------------------------
[Command]
name = "fwdthrow_y"
command = /$F, y
time = 2

[Command]
name = "fwdthrow_z"
command = /$F, z
time = 2

[Command]
name = "fwdthrow_b"
command = /$F, b
time = 2

[Command]
name = "fwdthrow_c"
command = /$F, c
time = 2

[Command]
name = "backthrow_y"
command = /$B, y
time = 2

[Command]
name = "backthrow_z"
command = /$B, z
time = 2

[Command]
name = "backthrow_b"
command = /$B, b
time = 2

[Command]
name = "backthrow_c"
command = /$B, c
time = 2

;-| Double Tap |-----------------------------------------------------------
[Command]
name = "FF"       ;Required (do not remove)
command = F, F
time = 10

[Command]
name = "BB"       ;Required (do not remove)
command = B, B
time = 10
 
;-| Throw Tap |------------------------------------------------------------
[Command]
name = "B&F"
command = B, F, B, F
time = 30

[Command]
name = "yyyy"
command = y, y, y, y
time = 30

[Command]
name = "zzzz"
command = z, z, z, z
time = 30

[Command]
name = "bbbb"
command = b, b, b, b
time = 30

[Command]
name = "cccc"
command = c, c, c, c
time = 30

;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "recovery" ;Required (do not remove)
command = x+y
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

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd"  ;Required (do not remove)
command = /$F
time = 1

[Command]
name = "holdback" ;Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdup"   ;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holddown" ;Required (do not remove)
command = /$D
time = 1

[Statedef -1]
;-| Super Move |-------------------------------

; Shinkuu Hadou ken (Light)
[State -1]
type = ChangeState
value = ifelse(palno <= 6, 2000,0)
triggerall= numhelper(2999) != 1
triggerall= numhelper(3001) != 1
triggerall= numhelper(3003) != 1
triggerall = Command = "QCF2_x" && StateType != A && Numproj = 0 && Power >= 1000 && var(16) != 1
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1
trigger13 = stateno = 220 && movecontact = 1

; Shinkuu Hadou ken (Medium)
[State -1]
type = ChangeState
value = ifelse(palno <= 6, 2000,0)
triggerall= numhelper(2999) != 1
triggerall= numhelper(3001) != 1
triggerall= numhelper(3003) != 1
triggerall = Command = "QCF2_y" && StateType != A && Numproj = 0 && Power >= 1000 && var(16) != 1
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1
trigger13 = stateno = 220 && movecontact = 1

; Shinkuu Hadou ken (Hard)
[State -1]
type = ChangeState
value = ifelse(palno <= 6, 2000,0)
triggerall= numhelper(2999) != 1
triggerall= numhelper(3001) != 1
triggerall= numhelper(3003) != 1
triggerall = Command = "QCF2_z" && StateType != A && Numproj = 0 && Power >= 1000 && var(16) != 1
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1
trigger13 = stateno = 220 && movecontact = 1



; Shakunetsu Hadou ken (Light)
[State -1]
type = ChangeState
value = 1100
triggerall= numhelper(2999) != 1
triggerall= numhelper(3001) != 1
triggerall= numhelper(3003) != 1
triggerall = Command = "HCF_x" && StateType != A && Numproj = 0 && var(16) != 1
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

; Shakunetsu Hadou ken (Medium)
[State -1]
type = ChangeState
value = 1101
triggerall= numhelper(2999) != 1
triggerall= numhelper(3001) != 1
triggerall= numhelper(3003) != 1
triggerall = Command = "HCF_y" && StateType != A && Numproj = 0 && var(16) != 1
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

; Shakunetsu Hadou ken (Hard)
[State -1]
type = ChangeState
value = 1102
triggerall= numhelper(2999) != 1
triggerall= numhelper(3001) != 1
triggerall= numhelper(3003) != 1
triggerall = Command = "HCF_z" && StateType != A && Numproj = 0 && var(16) != 1
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

; Shouryuu ken (Light)
[State -1]
type = ChangeState
value = 1200
triggerall = Command = "DP_x" && StateType != A
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

; Shouryuu ken (Medium)
[State -1]
type = ChangeState
value = 1200
triggerall = Command = "DP_y" && StateType != A
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

; Shouryuu ken (Hard)
[State -1]
type = ChangeState
value = 1200
triggerall = Command = "DP_z" && StateType != A
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

; Air Tatsumaki Senpuu Kyaku (Light)
[State -1]
type = ChangeState
value = 1300
trigger1 = Ctrl = 1 && StateType = A && Command = "QCB_a" && var(16) != 1

; Air Tatsumaki Senpuu Kyaku (Medium)
[State -1]
type = ChangeState
value = 1310
trigger1 = Ctrl = 1 && StateType = A && Command = "QCB_b" && var(16) != 1

; Air Tatsumaki Senpuu Kyaku (Hard)
[State -1]
type = ChangeState
value = 1320
trigger1 = Ctrl = 1 && StateType = A && Command = "QCB_c" && var(16) != 1

; Tatsumaki Senpuu Kyaku (Light)
[State -1]
type = ChangeState
value = 1400
triggerall = Command = "QCB_a" && StateType != A
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

; Tatsumaki Senpuu Kyaku (Medium)
[State -1]
type = ChangeState
value = 1410
triggerall = Command = "QCB_b" && StateType != A
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

; Tatsumaki Senpuu Kyaku (Hard)
[State -1]
type = ChangeState
value = 1420
triggerall = Command = "QCB_c" && StateType != A
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

; Hadou ken (Light)
[State -1]
type = ChangeState
value = 1000
triggerall= numhelper(2999) != 1
triggerall= numhelper(3001) != 1
triggerall= numhelper(3003) != 1
triggerall = Command = "QCF_x" && StateType != A && Numproj = 0
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

; Hadou ken (Medium)
[State -1]
type = ChangeState
value = 1001
triggerall= numhelper(2999) != 1
triggerall= numhelper(3001) != 1
triggerall= numhelper(3003) != 1
triggerall = Command = "QCF_y" && StateType != A && Numproj = 0
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

; Hadou ken (Hard)
[State -1]
type = ChangeState
value = 1002
triggerall= numhelper(2999) != 1
triggerall= numhelper(3001) != 1
triggerall= numhelper(3003) != 1
triggerall = Command = "QCF_z" && StateType != A && Numproj = 0
trigger1 = Ctrl = 1
trigger2 = stateno = 200 && movecontact = 1
trigger3 = stateno = 300 && movecontact = 1
trigger4 = stateno = 310 && movecontact = 1
trigger5 = stateno = 320 && time < 6 && movecontact = 1
trigger6 = stateno = 340 && movecontact = 1
trigger7 = stateno = 400 && movecontact = 1
trigger8 = stateno = 410 && movecontact = 1
trigger9 = stateno = 420 && time < 7 && movecontact = 1
trigger10 = stateno = 430 && var(11) < 2 && movecontact = 1
trigger11 = stateno = 440 && movecontact = 1
trigger12 = stateno = 450 && time < 9 && movecontact = 1

;-| Throw |-------------------------------
[State -1]
Type = ChangeState
Trigger1 = StateNo = 20 && (Command = "y" || Command = "z" || Command = "b" || Command = "c" || (Var(10) = 2 && Command = "a")) && P2BodyDist X<(65*Const(Size.XScale)) && Var(30) != 1 && RoundState = 2
Value = IFelse(Command = "y", 504, IFelse(Command = "z", 500, IFelse(Command = "b", 510, 514)))
;-| Normal Attack |-------------------------------
; Stand Light Punch
[State -1]
type = ChangeState
value = 200
triggerall = Command = "x"
trigger1 = Command != "holddown" && P2bodydist X > 30 && StateType = S && Ctrl = 1
trigger2 = Stateno = 200 && time > 6
trigger3 = Stateno = 300 && time > 6 && P2bodydist X > 30

[State -1, 410]
type = ChangeState
value = 910
triggerall = command = "z" && command != "holddown"  && statetype != A && command = "holdfwd" && P2statetype != A
trigger1 = ctrl

[State -1]
Type = ChangeState
Trigger1 = (Command = "x" || Command = "y" || Command = "z") && StateType = S && (Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver)) && Var(30) != 1 && RoundState = 2
Value = IFelse(Command="x", 200+(P2BodyDist X<(35*Const(Size.XScale))), IFelse(Command="y", 210+(P2BodyDist X<(42*Const(Size.XScale))), 220+(P2BodyDist X<(46*Const(Size.XScale)))))
[State -1]
Type = ChangeState
Trigger1 = (Command = "a" || Command = "b" || Command = "c") && StateType = S && (Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver)) && Var(30) != 1 && RoundState = 2
Value = IFelse(P2BodyDist X>(29*Const(Size.XScale)), IFelse(Command = "a", 230, IFelse(Command = "b", 240, IFelse(P2BodyDist X<(45*Const(Size.XScale)), 251, 250))), IFelse(Command = "a", 231, IFelse(Command = "b", 241, 251)))
[State -1]
Type = ChangeState
Trigger1 = (Command = "x" || Command = "y" || Command = "z" || Command = "a" || Command = "b" || Command = "c") && StateType = C && (Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver)) && Var(30) != 1 && RoundState = 2
Value = IFelse(Command = "x", 300, IFelse(Command = "y", 310, IFelse(Command = "z", 320, IFelse(Command = "a", 330, IFelse(Command = "b", 340, 350)))))
[State -1]
Type = ChangeState
Trigger1 = (Command = "x" || Command = "y" || Command = "z") && StateType = A && (Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver&&Pos Y<=0)) && Var(30) != 1 && RoundState = 2
Value = IFelse(Command = "x", 400, IFelse(Command = "y", 410, 420))
[State -1]
Type = ChangeState
Trigger1 = (Command = "a" || Command = "b" || Command = "c") && StateType = A && (Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver&&Pos Y<=0)) && Var(30) != 1 && RoundState = 2
Value = IFelse(Vel X = 0, IFelse(Command = "a", 430, IFelse(Command = "b", 440, 450)), IFelse(Command = "a", 431, IFelse(Command = "b", 441, 451)))
[State -1]
Type = ChangeState
Trigger1 = Command = "a" && AnimElem = 2,>1 && (Command="x"||Command="y"||Command="z"||Command="holdup") && ((StateNo=231&&Command="holddown") || (Command!="holddown"&&StateNo=330)) && RoundState = 2
Value=IFelse(Command="holdup",40,IFelse(Command="holddown",IFelse(Command="x",300,IFelse(Command="y",310,320)),IFelse(P2Dist X<60*Const(Size.XScale),IFelse(Command="x",201,IFelse(Command="y",211,221)),IFelse(Command="x",200,IFelse(Command="y",210,220)))))
[State -1]
Type = ChangeState
Trigger1 = (Command="x"&&((StateNo=[200,201])||StateNo=300)&&AnimElem=2,>1) || ((Command = "holddown" || P2Dist X < 60*Const(Size.XScale)) && Command = "a" && ((StateNo = 231 && AnimElem = 2,>1) || (StateNo = 330 && AnimElem = 2,>1)))&&RoundState=2
Value = IFelse(Command="x", IFelse(Command="holddown", 300, IFelse(P2Dist X>59*Const(Size.XScale),200,201)), IFelse(Command="holddown", 330, IFelse(StateNo=330||P2Dist X<60*Const(Size.XScale), 231, 230)))

