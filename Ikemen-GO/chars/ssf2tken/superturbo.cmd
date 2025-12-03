;ken
;
; Two parts: 1. Command definition and  2. State entry
; (state entry is after the commands def section)
;
; 1. Command definition
; ---------------------
; Note: The commands are CASE-SENSITIVE, and so are the command names.
; The eight directions are:
;   B, DB, D, DF, F, UF, U, UB     (all CAPS)
;   corresponding to back, down-back, down, downforward, etc.
; The six buttons are:
;   a, b, c, x, y, z               (all lower case)
;   In default key config, abc are are the bottom, and xyz are on the
;   top row. For 2 button characters, we recommend you use a and b.
;   For 6 button characters, use abc for kicks and xyz for punches.
;
; Each [Command] section defines a command that you can use for
; state entry, as well as in the CNS file.
; The command section should look like:
;
;   [Command]
;   name = some_name
;   command = the_command
;   time = time (optional -- defaults to 15 if omitted)
;
; - some_name
;   A name to give that command. You'll use this name to refer to
;   that command in the state entry, as well as the CNS. It is case-
;   sensitive (QCB_a is NOT the same as Qcb_a or QCB_A).
;
; - command
;   list of buttons or directions, separated by commas.
;   Directions and buttons can be preceded by special characters:
;   slash (/) - means the key must be held down
;          egs. command = /D       ;hold the down direction
;               command = /DB, a   ;hold down-back while you press a
;   tilde (~) - to detect key releases
;          egs. command = ~a       ;release the a button
;               command = ~D, F, a ;release down, press fwd, then a
;          If you want to detect "charge moves", you can specify
;          the time the key must be held down for (in game-ticks)
;          egs. command = ~30a     ;hold a for at least 30 ticks, then release
;   dollar ($) - Direction-only: detect as 4-way
;          egs. command = $D       ;will detect if D, DB or DF is held
;               command = $B       ;will detect if B, DB or UB is held
;   plus (+) - Buttons only: simultaneous press
;          egs. command = a+b      ;press a and b at the same time
;               command = x+y+z    ;press x, y and z at the same time
;   You can combine them:
;     eg. command = ~30$D, a+b     ;hold D, DB or DF for 30 ticks, release,
;                                  ;then press a and b together
;   It's recommended that for most "motion" commads, eg. quarter-circle-fwd,
;   you start off with a "release direction". This matches the way most
;   popular fighting games implement their command detection.
;
; - time (optional)
;   Time allowed to do the command, given in game-ticks. Defaults to 15
;   if omitted
;
; If you have two or more commands with the same name, all of them will
; work. You can use it to allow multiple motions for the same move.
;
; Some common commands examples are given below.
;
; [Command] ;Quarter circle forward + x
; name = "QCF_x"
; command = ~D, DF, F, x
;
; [Command] ;Half circle back + a
; name = "HCB_a"
; command = ~F, DF, D, DB, B, a
;
; [Command] ;Two quarter circles forward + y
; name = "2QCF_y"
; command = ~D, DF, F, D, DF, F, y
;
; [Command] ;Tap b rapidly
; name = "5b"
; command = b, b, b, b, b
; time = 30
;
; [Command] ;Charge back, then forward + z
; name = "charge_B_F_z"
; command = ~60$B, F, z
; time = 10
; 
; [Command] ;Charge down, then up + c
; name = "charge_D_U_c"
; command = ~60$D, U, c
; time = 10
;--------------------------------------------------------------------------
;Shoryu Reppa
;superL_01A
[Command]
name = "reppa"
command = ~D,DF,F,D,DF,x
time = 30

;superL_01A
[Command]
name = "reppa"
command = ~D,DF,F,D,DF,y
time = 30

;superL_01A
[Command]
name = "reppa"
command = ~D,DF,F,D,DF,z
time = 30

;--------------------------------------------------------------------------
;Shoryuken
[Command]
Name = "shoryuken_x"
command = ~F, D, DF, x
Time = 20
[Command]
Name = "shoryuken_y"
command = ~F, D, DF, y
Time = 20
[Command]
Name = "shoryuken_z"
command = ~F, D, DF, z
Time = 20

;--------------------------------------------------------------------------
;
;[Command]
;name = "special_01A"
;command = ~B, DB, D, a
;time = 15
;[Command]
;name = "special_01A"
;command = ~B, DB, D, b
;time = 15
;[Command]
;name = "special_01A"
;command = ~B, DB, D, c
;time = 15

;Crazy Kicks
[Command]
name = "kicks"
command = ~D, DF, F, a
time = 15
[Command]
name = "kicks"
command = ~D, DF, F, b
time = 15
[Command]
name = "kicks"
command = ~D, DF, F, c
time = 15

;
;[Command]
;name = "special_01C"
;command = ~D, DF, F, a
;time = 15
;[Command]
;name = "special_01C"
;command = ~D, DF, F, b
;time = 15
;[Command]
;name = "special_01C"
;command = ~D, DF, F, c
;time = 15

;--------------------------------------------------------------------------
;Tatsumaki Senpuu Kyaku
[Command]
Name = "tatsumaki_a"
command = ~D, DB, B, a
Time = 15

;SPECIAL_04_B
[Command]
Name = "tatsumaki_b"
command = ~D, DB, B, b
Time = 15

;SPECIAL_04_B
[Command]
Name = "tatsumaki_c"
command = ~D, DB, B, c
Time = 15

;--------------------------------------------------------------------------
;Hadouken
[Command]
Name = "hadouken_x"
command = ~D, DF, F, x
Time = 10
[Command]
Name = "hadouken_y"
command = ~D, DF, F, y
Time = 10
[Command]
Name = "hadouken_z"
command = ~D, DF, F, z
Time = 10

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
name = "rolling"
command = x+a
time = 1

[Command]
name = "recovery"			;Required (do not remove)
command = x+c
time = 1

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "throw_01"
command = /$F,y
time = 1

[Command]
name = "throw_02"
command = /$F,z
time = 1

;-| Single Button |---------------------------------------------------------
[Command]
name = "up"
command = U
time = 1

[Command]
name = "down"
command = D
time = 1

[Command]
name = "fwd"
command = F
time = 1

[Command]
name = "back"
command = B
time = 1

[Command]
name = "upback"
command = UB
time = 1

[Command]
name = "downback"
command = DB
time = 1

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

;-| Hold button |--------------------------------------------------------------
[Command]
name = "hold_x"
command = /x
time = 2

[Command]
name = "hold_y"
command = /y
time = 2

[Command]
name = "hold_z"
command = /z
time = 2

[Command]
name = "hold_a"
command = /a
time = 2

[Command]
name = "hold_b"
command = /b
time = 2

[Command]
name = "hold_c"
command = /c
time = 2

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd"				;Required (do not remove)
command = /$F
time = 1

[Command]
name = "holdback"				;Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdup" 				;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holddown"				;Required (do not remove)
command = /$D
time = 1

[Command]
name = "block_air"
command = ~$D~
time = 1

[Command]
name = "block_air"
command = ~$F~
time = 1

;---------------------------------------------------------------------------
; 2. State entry
; Don't remove the following line. It's required by the CMD standard.
[Statedef -1]
;==========================================================================================
;--------------------------------------------------------------------------
;Shoryu Reppa
[State -1, 2000]
type = ChangeState
value = 2000
trigger1 = command = "reppa" &&  statetype != A && power >= 1000 && ctrl = 1
trigger2 = movecontact && command = "reppa" &&  ( stateno = [200,210] ) && time <= 17
trigger3 = movecontact && command = "reppa" &&  ( stateno = [300,330] ) && time <= 17
;
trigger4 = movecontact && command = "reppa" && stateno = 266
trigger5 = movecontact && command = "reppa" && stateno = 270
trigger6 = movecontact && command = "reppa" && stateno = 425

[State -1, 2000]
type = ChangeState
value = 2000
triggerall = random <= 120 && var(25) = 1 &&  statetype != A && power >= 1000 && movetype != H
trigger1 = movehit && stateno = 225 && P2stateno != [5110,5130]
trigger2 = movehit && stateno = 210 && P2stateno != [5110,5130]

;==========================================================================================
;--------------------------------------------------------------------------
;SPECIAL
;SPECIAL_01_B
[State -1, 1010]
type = ChangeState
value = ifelse(var(40)=0,1010,ifelse(var(40)=1,1020,1030))
triggerall = var(14) = 0
trigger1 = command = "kicks" &&  statetype != A && ctrl 
trigger2 = movecontact && command = "kicks" &&  ( stateno = [200,210] )
trigger3 = movecontact && command = "kicks" &&  ( stateno = [300,330] )
;
trigger4 = movecontact && command = "kicks" && stateno = 266
trigger5 = movecontact && command = "kicks" && stateno = 270
trigger6 = movecontact && command = "kicks" && stateno = 425
;
;SPECIAL_01_C
[State -1, 1020]
type = ChangeState
value = ifelse(var(40)=0,1010,ifelse(var(40)=1,1020,1030))
triggerall = var(14) = 0
trigger1 = command = "kicks" &&  statetype != A && ctrl 
trigger2 = movecontact && command = "kicks" &&  ( stateno = [200,210] )
trigger3 = movecontact && command = "kicks" &&  ( stateno = [300,330] )
;
trigger4 = movecontact && command = "kicks" && stateno = 266
trigger5 = movecontact && command = "kicks" && stateno = 270
trigger6 = movecontact && command = "kicks" && stateno = 425
;
;--------------------------------------------------------------------------
;SPECIAL_02
;SPECIAL_02_A
[State -1, 1100]
type = ChangeState
value = 1100
trigger1 = command = "hadouken_x" &&  statetype != A && ctrl ;&& NumProjID(1130) = 0  
trigger2 = movecontact && command = "hadouken_x" &&  ( stateno = [200,210] )
trigger3 = movecontact && command = "hadouken_x" &&  ( stateno = [300,330] )
;
trigger4 = movecontact && command = "hadouken_x" && stateno = 266
trigger5 = movecontact && command = "hadouken_x" && stateno = 270
trigger6 = movecontact && command = "hadouken_x" && stateno = 425

;SPECIAL_02_B
[State -1, 1110]
type = ChangeState
value = 1110
trigger1 = command = "hadouken_y" &&  statetype != A && ctrl ;&& NumProjID(1130) = 0  
trigger2 = movecontact && command = "hadouken_y" &&  ( stateno = [200,210] )
trigger3 = movecontact && command = "hadouken_y" &&  ( stateno = [300,330] )
;
trigger4 = movecontact && command = "hadouken_y" && stateno = 266
trigger5 = movecontact && command = "hadouken_y" && stateno = 270
trigger6 = movecontact && command = "hadouken_y" && stateno = 425

;SPECIAL_02_C
[State -1, 1120]
type = ChangeState
value = 1120
trigger1 = command = "hadouken_z" &&  statetype != A && ctrl ;&& NumProjID(1130) = 0  
trigger2 = movecontact && command = "hadouken_z" &&  ( stateno = [200,210] )
trigger3 = movecontact && command = "hadouken_z" &&  ( stateno = [300,330] )
;
trigger4 = movecontact && command = "hadouken_z" && stateno = 266
trigger5 = movecontact && command = "hadouken_z" && stateno = 270
trigger6 = movecontact && command = "hadouken_z" && stateno = 425

;SPECIAL_02_C AIAIAI
[State -1, 1020]
type = ChangeState
value = 1120
triggerall = var(25) = 1 &&  statetype != A && NumProjID(1130) = 0 && movetype != H && P2stateno != [5110,5130]
trigger1 =  random <= 20 && movecontact && ( stateno = 210 || stateno = 325 || stateno = 330 )
trigger2 =   random <= 10 && ctrl && P2bodydist x = [50,250]

;--------------------------------------------------------------------------
;SPECIAL_03
;SPECIAL_03_A
[State -1, 1000]
type = ChangeState
value = 1200
trigger1 = command = "shoryuken_x" &&  statetype != A && ctrl
trigger2 = movecontact && command = "shoryuken_x" &&  ( stateno = [200,210] )
trigger3 = movecontact && command = "shoryuken_x" &&  ( stateno = [300,330] )
;
trigger4 = movecontact && command = "shoryuken_x" && stateno = 266
trigger5 = movecontact && command = "shoryuken_x" && stateno = 270
trigger6 = movecontact && command = "shoryuken_x" && stateno = 425
;
;SPECIAL_03_A AIAIAI
[State -1, 1000]
type = ChangeState
value = 1200
triggerall = var(25) = 1 &&  statetype != A && ctrl && movetype != H
trigger1 = random <= 120 && P2bodydist X <= 10 && P2statetype = A && P2stateno != [5110,5130]
trigger2 = movecontact && stateno = 210
trigger3 = movecontact && stateno = 325
;
;SPECIAL_03_B
[State -1, 1000]
type = ChangeState
value = 1210
trigger1 = command = "shoryuken_y" &&  statetype != A && ctrl
trigger2 = movecontact && command = "shoryuken_y" &&  ( stateno = [200,210] )
trigger3 = movecontact && command = "shoryuken_y" &&  ( stateno = [300,330] )
;
trigger4 = movecontact && command = "shoryuken_y" && stateno = 266
trigger5 = movecontact && command = "shoryuken_y" && stateno = 270
trigger6 = movecontact && command = "shoryuken_y" && stateno = 425

;SPECIAL_03_C
[State -1, 1000]
type = ChangeState
value = 1220
trigger1 = command = "shoryuken_z" &&  statetype != A && ctrl
trigger2 = movecontact && command = "shoryuken_z" &&  ( stateno = [200,210] )
trigger3 = movecontact && command = "shoryuken_z" &&  ( stateno = [300,330] )
;
trigger4 = movecontact && command = "shoryuken_z" && stateno = 266
trigger5 = movecontact && command = "shoryuken_z" && stateno = 270
trigger6 = movecontact && command = "shoryuken_z" && stateno = 425
;
;SPECIAL_03_C AIAIAI
[State -1, 1000]
type = ChangeState
value = 1220
triggerall = var(25) = 1 &&  statetype != A && movetype != H
trigger1 = random <= 120 && movecontact && ( stateno = 210 || stateno = 325 )
trigger2 = ctrl && random <= 120 && P2bodydist X <= 50 && P2statetype = A && P2stateno != [5110,5130]
trigger3 = life <= 200 && ctrl

;--------------------------------------------------------------------------
;SPECIAL_04_A
[State -1, 1300]
type = ChangeState
value = 1300
trigger1 = command = "tatsumaki_a" &&  statetype != A && ctrl
trigger2 = movecontact && command = "tatsumaki_a" &&  ( stateno = [200,210] )
trigger3 = movecontact && command = "tatsumaki_a" &&  ( stateno = [300,330] )
;
trigger4 = movecontact && command = "tatsumaki_a" && stateno = 266
trigger5 = movecontact && command = "tatsumaki_a" && stateno = 270
trigger6 = movecontact && command = "tatsumaki_a" && stateno = 425

;SPECIAL_04_B
[State -1, 1300]
type = ChangeState
value = 1310
trigger1 = command = "tatsumaki_b" &&  statetype != A && ctrl
trigger2 = movecontact && command = "tatsumaki_b" &&  ( stateno = [200,210] )
trigger3 = movecontact && command = "tatsumaki_b" &&  ( stateno = [300,330] )
;
trigger4 = movecontact && command = "tatsumaki_b" && stateno = 266
trigger5 = movecontact && command = "tatsumaki_b" && stateno = 270
trigger6 = movecontact && command = "tatsumaki_b" && stateno = 425

;SPECIAL_04_C
[State -1, 1300]
type = ChangeState
value = 1320
trigger1 = command = "tatsumaki_c" &&  statetype != A && ctrl
trigger2 = movecontact && command = "tatsumaki_c" &&  ( stateno = [200,210] )
trigger3 = movecontact && command = "tatsumaki_c" &&  ( stateno = [300,330] )
;
trigger4 = movecontact && command = "tatsumaki_c" && stateno = 266
trigger5 = movecontact && command = "tatsumaki_c" && stateno = 270
trigger6 = movecontact && command = "tatsumaki_c" && stateno = 425

;SPECIAL_04_C AIAIAI
[State -1, 1300]
type = ChangeState
value = 1320
triggerall = var(25) = 1 &&  statetype != A && movetype != H && P2stateno != [5110,5130]
trigger1 = random <= 120 && ctrl && P2statetype != A && random <= 100 && P2bodydist x = [50,150]
trigger2 = movecontact && stateno = [200,210] 
trigger3 = movecontact && stateno = [300,330] 

;--------------------------------------------------------------------------
;SPECIAL_05_A
[State -1, 1400]
type = ChangeState
value = 1400
triggerall = command = "tatsumaki_a" &&  statetype = A  
trigger1 = ctrl
;
trigger2 = movecontact && command = "tatsumaki_a" && var(14) = 1
trigger2 = stateno = [340,395]

;SPECIAL_05_A
[State -1, 1400]
type = ChangeState
value = 1410
triggerall = command = "tatsumaki_b" &&  statetype = A  
trigger1 = ctrl
;
trigger2 = movecontact && command = "tatsumaki_c" && var(14) = 1
trigger2 = stateno = [340,395]

;SPECIAL_05_A
[State -1, 1400]
type = ChangeState
value = 1420
triggerall = command = "tatsumaki_c" &&  statetype = A  
trigger1 = ctrl
;
trigger2 = movecontact && command = "tatsumaki_c" && var(14) = 1
trigger2 = stateno = [340,395]
;--------------------------------------------------------------------------
;SPECIAL_06_A

;--------------------------------------------------------------------------
;SPECIAL_07_A

;-----------------------------------------------------------------------------------------------------------------------------------

;==========================================================================================
;--------------------------------------------------------------------------
; Basic Throws
[State -1, throw]
type = ChangeState
value = 500
triggerall = statetype = S && ctrl && stateno != 100
trigger1 = command = "holdback" && command = "y" 
trigger1 = p2bodydist X < 25

[State -1, throw]
type = ChangeState
value = 510
triggerall = statetype = S && ctrl && stateno != 100
trigger1 = command = "holdback" && command = "z" 
trigger1 = p2bodydist X < 25


[State -1, throw]
type = ChangeState
value = 520
triggerall = statetype = S && ctrl && stateno != 100
trigger1 = command = "holdfwd" && command = "y" 
trigger1 = p2bodydist X < 25

[State -1, throw]
type = ChangeState
value = 530
triggerall = statetype = S && ctrl && stateno != 100
trigger1 = command = "holdfwd" && command = "z" 
trigger1 = p2bodydist X < 25

[State -1, throw]
type = ChangeState
value = 540
triggerall = statetype = S && ctrl && stateno != 100
trigger1 = command = "holdback" && command = "c" 
trigger1 = p2bodydist X < 25

[State -1, throw]
type = ChangeState
value = 550
triggerall = statetype = S && ctrl && stateno != 100
trigger1 = command = "holdfwd" && command = "c" 
trigger1 = p2bodydist X < 25

[State -1, throw]
type = ChangeState
value = 560
triggerall = statetype = S && ctrl && stateno != 100
trigger1 = command = "holdfwd" && command = "b" 
trigger1 = p2bodydist X < 25

;---------------------------------------------------------------------

;==========================================================================================
;--------------------------------------------------------------------------
;basic PK
;
;--------------------------------------------------------------------------
;FSHP
[State -1, 410]
type = ChangeState
value = 425
triggerall = command = "c" && statetype != A && command = "holdfwd" && command != "holddown" && var(14) = 1
trigger1 = ctrl 
trigger2 = movecontact && var(14) = 1 && stateno = [200,230] 
trigger3 = movecontact && var(14) = 1 && stateno = 300
trigger4 = movecontact && var(14) = 1 && stateno = 305
trigger5 = movecontact && var(14) = 1 && stateno = 310
trigger6 = movecontact && var(14) = 1 && stateno = 315
trigger7 = movecontact && var(14) = 1 && stateno = 320
trigger8 = movecontact && var(14) = 1 && stateno = 325
trigger9 = movecontact && var(14) = 1 && stateno = 330

;--------------------------------------------------------------------------
;C LP
[State -1, 300]
type = ChangeState
value = 300
triggerall = command = "x" && command = "holddown" &&  statetype = C
trigger1 = ctrl
trigger2 = stateno = 300 && movecontact = 1

;C MP
[State -1, 305]
type = ChangeState
value = 305
triggerall = command = "y" && command = "holddown" &&  statetype = C
trigger1 = ctrl

;C HP
[State -1, 310]
type = ChangeState
value = 310
triggerall = command = "z" && command = "holddown" &&  statetype = C
trigger1 = ctrl

;C LK
[State -1, 320]
type = ChangeState
value = 320
triggerall = command = "a" && command = "holddown" &&  statetype = C
trigger1 = ctrl
trigger2 = stateno = 320 && movecontact = 1
trigger3 = stateno = 320 && time >= 6

;C MK
[State -1, 325]
type = ChangeState
value = 325
triggerall = command = "b" && command = "holddown" &&  statetype = C
trigger1 = ctrl

;C MK AI
[State -1, 325]
type = ChangeState
value = 325
triggerall = random <= 120 && var(25) = 1 &&  statetype != A && movetype != H && ctrl
trigger1 = p2bodydist X <= 60 && P2statetype != A && P2stateno != [5110,5310]  

;C HK
[State -1, 330]
type = ChangeState
value = 330
triggerall = command = "c" && command = "holddown" &&  statetype = C
trigger1 = ctrl

;C HK
[State -1, 330]
type = ChangeState
value = 330
triggerall = var(25) = 1 &&  statetype != A && movetype != H && ctrl
trigger1 =  random <= 120 && P2bodydist X <= 60 && P2statetype != A && P2stateno != [5110,5310]

;--------------------------------------------------------------------------
;NEAR STAND LP
[State -1, 200]
type = ChangeState
value = 200
triggerall = command = "x" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl
trigger2 = stateno = 200 && movecontact

;NEAR STAND MP
[State -1, 205]
type = ChangeState
value = 205
triggerall = command = "y" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl

;NEAR STAND HP
[State -1, 210]
type = ChangeState
value = 210
triggerall = command = "z" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl

;NEAR STAND HP
[State -1, 210]
type = ChangeState
value = 210
triggerall = var(25) = 1 &&  statetype != A && movetype != H && ctrl
trigger1 =  random <= 120 && P2bodydist X <= 25 && P2statetype != A && P2stateno != [5110,5310]

;NEAR STAND LK
[State -1, 220]
type = ChangeState
value = 220
triggerall = command = "a" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl
trigger2 = stateno = 200 && movecontact

;NEAR STAND MK
[State -1, 225]
type = ChangeState
value = 225
triggerall = command = "b" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl

;NEAR STAND HK
[State -1, 230]
type = ChangeState
value = 230
triggerall = command = "c" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl

;==========================================================================================
;FAR STAND
;FAR STAND LP
[State -1, 240]
type = ChangeState
value = 240
triggerall = command = "x" && command != "holddown" && p2bodydist X > 25 && statetype = S
trigger1 = ctrl
trigger2 = stateno = 200 && movecontact
trigger3 = stateno = 240 && time >= 6

;FAR STAND MP
[State -1, 245]
type = ChangeState
value = 245
triggerall = command = "y" && command != "holddown" && p2bodydist X > 25 && statetype = S
trigger1 = ctrl

;FAR STAND HP
[State -1, 250]
type = ChangeState
value = 250
triggerall = command = "z" && command != "holddown" && p2bodydist X > 25 && statetype = S
trigger1 = ctrl

;FAR STAND LK
[State -1, 260]
type = ChangeState
value = 260
triggerall = command = "a" && command != "holddown" && p2bodydist X > 25 && statetype = S
trigger1 = ctrl
trigger2 = stateno = 200 && movecontact

;FAR STAND MK
[State -1, 265]
type = ChangeState
value = 265
triggerall = command = "b" && command != "holddown" && p2bodydist X > 25 && statetype = S && var(14) = 0
trigger1 = ctrl

;FAR STAND MK
[State -1, 265]
type = ChangeState
value = 266
triggerall = command = "b" && command != "holddown" && p2bodydist X > 25 && statetype = S && var(14) = 1
trigger1 = ctrl

;FAR STAND HK
[State -1, 270]
type = ChangeState
value = 270
triggerall = command = "c" && command != "holddown" && p2bodydist X > 25 && statetype = S
trigger1 = ctrl

;NEAR STAND HK
[State -1, 210]
type = ChangeState
value = 270
triggerall = var(25) = 1 &&  statetype != A && movetype != H && ctrl
trigger1 =  random <= 10 && P2statetype != A && P2stateno != [5110,5310]
trigger1 = P2bodydist X = [50,60]

;==========================================================================================
;F/B JUMP LIGHT PUNCH
[State -1, 340]
type = ChangeState
value = 340
triggerall = command = "x" && statetype = A && vel X != 0
trigger1 = ctrl

;F/B JUMP M PUNCH
[State -1, 345]
type = ChangeState
value = 345
triggerall = command = "y" && statetype = A && vel X != 0
trigger1 = ctrl

;F/B JUMP H PUNCH
[State -1, 350]
type = ChangeState
value = 350
triggerall = command = "z" && statetype = A && vel X != 0
trigger1 = ctrl

;F/B JUMP LIGHT K
[State -1, 355]
type = ChangeState
value = 355
triggerall = command = "a" && statetype = A && vel X != 0
trigger1 = ctrl

;F/B JUMP MK
[State -1, 360]
type = ChangeState
value = 360
triggerall = command = "b" && statetype = A && vel X != 0
trigger1 = ctrl

;F/B JUMP HK
[State -1, 365]
type = ChangeState
value = 365
triggerall = command = "c" && statetype = A && vel X != 0
trigger1 = ctrl


;==========================================================================================
;JUMP LIGHT PUNCH
[State -1, 370]
type = ChangeState
value = 370
triggerall = command = "x" && statetype = A && vel X = 0
trigger1 = ctrl

;JUMP M PUNCH
[State -1, 375]
type = ChangeState
value = 375
triggerall = command = "y" && statetype = A && vel X = 0
trigger1 = ctrl

; JUMP H PUNCH
[State -1, 380]
type = ChangeState
value = 380
triggerall = command = "z" && statetype = A && vel X = 0
trigger1 = ctrl

; JUMP LIGHT K
[State -1, 385]
type = ChangeState
value = 385
triggerall = command = "a" && statetype = A && vel X = 0
trigger1 = ctrl

; JUMP MK
[State -1, 390]
type = ChangeState
value = 390
triggerall = command = "b" && statetype = A && vel X = 0
trigger1 = ctrl

; JUMP HK
[State -1, 395]
type = ChangeState
value = 395
triggerall = command = "c" && statetype = A && vel X = 0
trigger1 = ctrl


;==========================================================================================
;Auto Guard 一般要放在 state -1 的最上位置
[State -1];這是用來控制人物蹲下擋的
type = ChangeState
triggerall = P2stateno != 1301
triggerall = statetype != A && var(25) = 1 && movetype != H && ctrl = 1 && P2MoveType = A
triggerall = P2BodyDist X <= 200 && P2statetype = S			;距離彼近時
;
trigger1 = PrevStateNo != 151					;而之前又不是擋
trigger2 = PrevStateNo != 152
trigger3 = PrevStateNo != 153
value = 120							;就蹲下預備防禦

[State -1];這是用來控制人物蹲下擋的
type = ChangeState
triggerall = P2stateno != 1301
triggerall = statetype != A && var(25) = 1 && movetype != H && ctrl = 1 && P2MoveType = A
triggerall = P2BodyDist X <= 200 && P2statetype = S			;距離彼近時
;
trigger1 = P2name ="ryu"&& (P2stateno=1100||P2stateno=1110||P2stateno=1120||P2stateno=1000||P2stateno=1010||P2stateno=1020)
trigger2 = P2name ="ken"&& ( P2stateno=1100||P2stateno=1110||P2stateno=1120 )
trigger3 = P2name ="chunli"&&(P2stateno=1200||P2stateno=1201||P2stateno=1202)
trigger4 = P2name ="guile"&&(P2stateno=1000||P2stateno=1010||stateno=1020)
trigger5 = P2name ="dhalsim"&&(P2stateno=1000||P2stateno=1010||P2stateno=1020)
trigger6 = P2name ="deejay"&&(P2stateno=1000||P2stateno=1010||P2stateno=1020)
trigger7 = P2name ="sagat"&&(P2stateno=1100||P2stateno=1110||P2stateno=1120||P2stateno=1000||P2stateno=1010||P2stateno=1020)
;
value = 120

;walk AI
[state -1]
type = ChangeState
trigger1 = P2bodyDist X != [60,100]		;通常會在要在目標位置加減 10-20 作為空間
trigger1 = Anim != 5
trigger1 = StateNo = 0
trigger1 = Pos Y = 0				;確保是在地上
value = 20

[state -1]
type = ChangeState
trigger1 = P2bodyDist X = [160,200]			;通常會在要在目標位置加減 10-20 作為空間
trigger1 = Anim != 5
trigger1 = StateNo = 0
trigger1 = Pos Y = 0				;確保是在地上
value = 20



