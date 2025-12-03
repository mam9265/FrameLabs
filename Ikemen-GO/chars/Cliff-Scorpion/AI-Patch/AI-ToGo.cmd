; The CMD file.

[Command]
name = "CPU1"
command = B,F,B,a
time = 0

[Command]
name = "CPU2"
command = B,F,B,b
time = 0

[Command]
name = "CPU3"
command = B,F,B,c
time = 0

[Command]
name = "CPU4"
command = B,F,B,x
time = 0

[Command]
name = "CPU5"
command = B,F,B,y
time = 0

[Command]
name = "CPU6"
command = B,F,B,z
time = 0

[Command]
name = "CPU7"
command = B,D,B,a
time = 0

[Command]
name = "CPU8"
command = B,D,B,b
time = 0

[Command]
name = "CPU9"
command = B,D,B,c
time = 0

[Command]
name = "CPU10"
command = B,D,B,x
time = 0

[Command]
name = "CPU11"
command = B,D,B,y
time = 0

[Command]
name = "CPU12"
command = B,D,B,z
time = 0


;-| AI Activators|-------------------------------------------------------------------

[Command]
name = "CPU"
command = a
time = 1

[Command]
name = "CPU"
command = b
time = 1

[Command]
name = "CPU"
command = c
time = 1

[Command]
name = "CPU"
command = x
time = 1

[Command]
name = "CPU"
command = y
time = 1

[Command]
name = "CPU"
command = z
time = 1

[Command]
name = "CPU"
command = F
time = 1

[Command]
name = "CPU"
command = B
time = 1

[Command]
name = "CPU"
command = U
time = 1

[Command]
name = "CPU"
command = D
time = 1

[Command]
name = "AI1"
command = D, D, D, U, U, U, x, U, U, U, a, U, U, U, U, U, U, U, b, U
time = 1

[Command]
name = "AI2"
command = F, F, F, U, U, U, U, U, x, U, U, U, U, U, U, U, U, U, U, U
time = 1

[Command]
name = "AI3"
command = B, B, B, U, U, U, U, U, x, U, U, U, z, U, U, U, U, U, U, b
time = 1

[Command]
name = "AI4"
command = U, U, U, U, U, U, U, a, U, U, U, U, U, U, U, U, U, U, U, U
time = 1

[Command]
name = "AI5"
command = D, D, D, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U
time = 1

[Command]
name = "AI6"
command = F, F, F, U, U, U, U, U, U, y, U, U, z, y, U, U, U, U, U, U
time = 1

[Command]
name = "AI7"
command = B, B, B, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U
time = 1

[Command]
name = "AI8"
command = U, U, U, U, U, U, U, a, U, U, U, U, U, y, y, U, U, U, U, U
time = 1

[Command]
name = "AI9"
command = D, D, D, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U
time = 1

[Command]
name = "AI10"
command = F, B, F, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U
time = 1

[Command]
name = "AI11"
command = D, U, D, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U
time = 1

[Command]
name = "AI12"
command = F, B, F, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U, U
time = 1


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
; 

;-| Button Remapping |-----------------------------------------------------
; This section lets you remap the player's buttons (to easily change the
; button configuration). The format is:
;   old_button = new_button
; If new_button is left blank, the button cannot be pressed.
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
command.time = 30

; Default value for the "buffer.time" parameter of a Command. Minimum 1,
; maximum 30.
command.buffer.time = 1

;-| Super Motions |--------------------------------------------------------

;-| Special Motions |------------------------------------------------------

;-| Double Tap |-----------------------------------------------------------

[Command]
name = "FF"     ;Required (do not remove)
command = F, F
time = 10

[Command]
name = "BB"     ;Required (do not remove)
command = B, B
time = 10

[command]
name = "Spear"
command = D,F,a
time = 10

[command]
name = "Fire Breath"
command = D,B,a
time = 10

[command]
name = "Teleport"
command = D,F,x
time = 10

[command]
name = "Teleport"
command = D,B,x
time = 10

[command]
name = "Air Teleport"
command = D,B,x
time = 10

[command]
name = "Air Teleport"
command = D,F,x
time = 10

[command]
name = "Air Teleport"
command = D,B,a
time = 10

[command]
name = "Air Teleport"
command = D,F,a
time = 10

[command]
name = "Teleport Kick BWD"
command = D,F,y
time = 10

[command]
name = "Teleport Kick FWD"
command = D,B,y
time = 10

[command]
name = "Dash 1"
command = y+c
time = 10

[command]
name = "Dash 2"
command = a+b
time = 10

[command]
name = "Dash 3"
command = z+x
time = 10

[command]
name = "Super Hyper"
command = D,F,D,F,b
time = 50

[command]
name = "Super Hyper"
command = D,B,D,B,b
time = 50

[command]
name = "Super Hyper"
command = D,F,D,F,c
time = 50

[command]
name = "Super Hyper"
command = D,B,D,B,c
time = 50

[command]
name = "Super Hyper"
command = D,F,D,F,z
time = 50

[command]
name = "Super Hyper"
command = D,B,D,B,z
time = 50

[command]
name = "Fatality Clone Spawn"
command = D,D,B,F,b
time = 30

[command]
name = "Fatality Hell Hand"
command = D,D,B,F,a
time = 30

[command]
name = "Fatality Animality"
command = D,F,y
time = 10

[command]
name = "Fatality Burn Toasty"
command = F,B,x
time = 10

[command]
name = "Fatality Burn Forever"
command = F,B,z
time = 10

[command]
name = "Fatality Cutter"
command = D,D,B,F,x
time = 30

[command]
name = "Fatality Test Your Might"
command = D,D,B,F,z
time = 30

[command]
name = "Fatality Buy A Scorpion Doll"
command = F,B,b
time = 10

[command]
name = "Fatality Babality"
command = F,B,a
time = 10

[command]
name = "Fatality Uppercut Train Hit"
command = D,F,a+x
time = 10

;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "recovery" ;Required (do not remove)
command = x+y
time = 1

[Command]
name = "recovery"
command = y+z
time = 1

[Command]
name = "recovery"
command = x+z
time = 1

[Command]
name = "recovery"
command = a+b
time = 1

[Command]
name = "recovery"
command = b+c
time = 1

[Command]
name = "recovery"
command = a+c
time = 1

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "back_x"
command = /$B,x
time = 1

[Command]
name = "back_y"
command = /$B,y
time = 1

[Command]
name = "back_z"
command = /$B,z
time = 1

[Command]
name = "down_x"
command = /$D,x
time = 1

[Command]
name = "down_y"
command = /$D,y
time = 1

[Command]
name = "down_z"
command = /$D,z
time = 1

[Command]
name = "fwd_x"
command = /$F,x
time = 1

[Command]
name = "fwd_y"
command = /$F,y
time = 1

[Command]
name = "fwd_z"
command = /$F,z
time = 1

[Command]
name = "up_x"
command = /$U,x
time = 1

[Command]
name = "up_y"
command = /$U,y
time = 1

[Command]
name = "up_z"
command = /$U,z
time = 1

[Command]
name = "back_a"
command = /$B,a
time = 1

[Command]
name = "back_b"
command = /$B,b
time = 1

[Command]
name = "back_c"
command = /$B,c
time = 1

[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
time = 1

[Command]
name = "down_c"
command = /$D,c
time = 1

[Command]
name = "fwd_a"
command = /$F,a
time = 1

[Command]
name = "fwd_b"
command = /$F,b
time = 1

[Command]
name = "fwd_c"
command = /$F,c
time = 1

[Command]
name = "up_a"
command = /$U,a
time = 1

[Command]
name = "up_b"
command = /$U,b
time = 1

[Command]
name = "up_c"
command = /$U,c
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
name = "s"
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
name = "holdfwd" ;Required (do not remove)
command = /$F
time = 1

[Command]
name = "holddownfwd"
command = /$DF
time = 1

[Command]
name = "holddown" ;Required (do not remove)
command = /$D
time = 1

[Command]
name = "holddownback"
command = /$DB
time = 1

[Command]
name = "holdback" ;Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdupback"
command = /$UB
time = 1

[Command]
name = "holdup" ;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holdupfwd"
command = /$UF
time = 1

;---------------------------------------------------------------------------
; 2. State entry
; --------------
; This is where you define what commands bring you to what states.
;
; Each state entry block looks like:
;   [State -1, Label]           ;Change Label to any name you want to use to
;                               ;identify the state with.
;   type = ChangeState          ;Don't change this
;   value = new_state_number
;   trigger1 = command = command_name
;   . . .  (any additional triggers)
;
; - new_state_number is the number of the state to change to
; - command_name is the name of the command (from the section above)
; - Useful triggers to know:
;   - statetype
;       S, C or A : current state-type of player (stand, crouch, air)
;   - ctrl
;       0 or 1 : 1 if player has control. Unless "interrupting" another
;                move, you'll want ctrl = 1
;   - stateno
;       number of state player is in - useful for "move interrupts"
;   - movecontact
;       0 or 1 : 1 if player's last attack touched the opponent
;                useful for "move interrupts"
;
; Note: The order of state entry is important.
;   State entry with a certain command must come before another state
;   entry with a command that is the subset of the first.  
;   For example, command "fwd_a" must be listed before "a", and
;   "fwd_ab" should come before both of the others.
;
; For reference on triggers, see CNS documentation.
;
; Just for your information (skip if you're not interested):
; This part is an extension of the CNS. "State -1" is a special state
; that is executed once every game-tick, regardless of what other state
; you are in.


; Don't remove the following line. It's required by the CMD standard.
[Statedef -1]

[State -1, Scorpion AI]
type = VarSet
triggerall = var(50) = 0
trigger1 = command = "AI1"
trigger2 = command = "AI2"
trigger3 = command = "AI3"
trigger4 = command = "AI4"
trigger5 = command = "AI5"
trigger6 = command = "AI6"
trigger7 = command = "AI7"
trigger8 = command = "AI8"
trigger9 = command = "AI9"
trigger10 = command = "AI10"
trigger11 = command = "AI11"
trigger12 = command = "AI12"
v = 50
value = 1

[State -1, Demon AI 1]
type = VarSet
triggerall = var(50) = 0
triggerall = statetype = S
trigger1 = command = "CPU1"
trigger2 = command = "CPU2"
trigger3 = command = "CPU3"
trigger4 = command = "CPU4"
trigger5 = command = "CPU5"
trigger6 = command = "CPU6"
trigger7 = command = "CPU7"
trigger8 = command = "CPU8"
trigger9 = command = "CPU9"
trigger10 = command = "CPU10"
trigger11 = command = "CPU11"
trigger12 = command = "CPU12"
v = 50
value = 1

[State -1,Demon AI 2]
type = VarSet
triggerall = var(50) = 0
triggerall = statetype = S
triggerall = p2statetype = S
trigger1 = command = "CPU1"
trigger2 = command = "CPU2"
trigger3 = command = "CPU3"
trigger4 = command = "CPU4"
trigger5 = command = "CPU5"
trigger6 = command = "CPU6"
trigger7 = command = "CPU7"
trigger8 = command = "CPU8"
trigger9 = command = "CPU9"
trigger10 = command = "CPU10"
trigger11 = command = "CPU11"
trigger12 = command = "CPU12"
v = 50
value = 1

[State -1,Demon AI 3]
type = VarSet
triggerall = var(50) = 0
triggerall = statetype = A
trigger1 = command = "CPU1"
trigger2 = command = "CPU2"
trigger3 = command = "CPU3"
trigger4 = command = "CPU4"
trigger5 = command = "CPU5"
trigger6 = command = "CPU6"
trigger7 = command = "CPU7"
trigger8 = command = "CPU8"
trigger9 = command = "CPU9"
trigger10 = command = "CPU10"
trigger11 = command = "CPU11"
trigger12 = command = "CPU12"
v = 50
value = 1

[State -1, Activate AI]
type = VarSet
trigger1 = var(50) = 2
trigger1 = RoundState != 3
v = 50
value = 1

[State -1, Deactivate AI]
type = VarSet
triggerall = var(50) != 0
trigger1 = RoundState = 3
v = 50
value = 2

;===========================================================================
[State -1
;===========================================================================

[State -1, Shows Mercy]
type = ChangeState
value = 40001
triggerall = p2life < 2
triggerall = p2bodydist X > 50
triggerall = var(4)
triggerALL = command = "s" && command = "a"
triggerall = command = "holddown"
trigger1 = (statetype = C) && ctrl

;===========================================================================
[State -1
;===========================================================================

[State -1, Fatality Clone Spawn]
type = ChangeState
value = 70011
triggerall = p2bodydist X > 20
triggerall = p2life < 2
triggerall = var(4)
triggerALL = command = "Fatality Clone Spawn"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Fatality Hell Hand]
type = ChangeState
value = 70007
triggerall = p2bodydist X > 80
triggerall = p2life < 2
triggerall = var(4)
triggerALL = command = "Fatality Hell Hand"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Fatality Animality]
type = ChangeState
value = 70006
triggerall = p2bodydist X < 60
triggerall = p2life < 2
triggerall = var(4)
triggerALL = command = "Fatality Animality"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Fatality Burn Toasty]
type = ChangeState
value = 70003
triggerall = p2bodydist x = [50,90]
triggerall = p2life < 2
triggerall = var(4)
triggerALL = command = "Fatality Burn Toasty"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Fatality Burn Forever]
type = ChangeState
value = 70001
triggerall = p2bodydist x = [50,90]
triggerall = p2life < 2
triggerall = var(4)
triggerALL = command = "Fatality Burn Forever"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Fatality Cutter]
type = ChangeState
value = 70000
triggerall = p2name = "SubZero-By cliff-A" ||  p2name = "Scorpion-By cliff-A"
triggerall = p2life < 2
triggerall = p2bodydist X < 10
triggerall = var(4)
triggerALL = command = "Fatality Cutter"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Fatality Test Your Might]
type = ChangeState
value = 70002
triggerall = p2life < 2
triggerall = var(4)
triggerall = p2bodydist X > 40
triggerALL = command = "Fatality Test Your Might"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Fatality Uppercut Train Hit]
type = ChangeState
value = 70010
triggerall = p2life < 2
triggerall = p2bodydist X < 10
triggerall = var(4)
triggerALL = command = "Fatality Uppercut Train Hit"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Fatality Babality]
type = ChangeState
value = 70005
triggerall = p2life < 2
triggerall = p2bodydist X > 40
triggerall = var(4)
triggerALL = command = "Fatality Babality"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Fatality Buy A Scorpion Doll]
type = ChangeState
value = 70004
triggerall = p2life < 2
triggerall = p2bodydist X > 40
triggerall = var(4)
triggerALL = command = "Fatality Buy A Scorpion Doll"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

;===========================================================================
[State -1
;===========================================================================

[State -1, Fatality Movelist]
type = ChangeState
value = 500
triggerall = Var(50) != 1
triggerall = var(4)
triggerALL = command = "s"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

;===========================================================================
[State -1
;===========================================================================

[State -1, Super Hyper Combo]
type = ChangeState
value = 9030
triggerall = !var(4)
triggerALL = power >= 1500
triggerALL = command = "Super Hyper"
trigger1 = (statetype = S) && ctrl

[State -1, Spear]
type = ChangeState
value = 9005
triggerall = p2Stateno != 9012
triggerall = p2bodydist X >= 50
triggerall = !var(4)
triggerALL = power >= 700
triggerALL = command = "Spear"
trigger1 = (statetype = S) && ctrl

[State -1, Fire Breath]
type = ChangeState
value = 9000
triggerall = !var(4)
triggerALL = power >= 700
triggerALL = command = "Fire Breath"
trigger1 = (statetype = S) && ctrl

[State -1, Teleport Punch FWD]
type = ChangeState
value = 304
triggerall = !var(4)
triggerALL = power >= 700
triggerALL = command = "Teleport Kick BWD"
trigger1 = (statetype = S) && ctrl

[State -1, Teleport Kick BWD]
type = ChangeState
value = 301
triggerall = !var(4)
triggerALL = power >= 700
triggerall = p2bodydist x > 40
triggerALL = command = "Teleport Kick FWD"
trigger1 = (statetype != C) && ctrl

[State -1, Air Teleport]
type = ChangeState
value = 704
triggerALL = power >= 500
triggerALL = command = "Air Teleport"
trigger1 = (statetype = A) && ctrl

[State -1, Teleport]
type = ChangeState
value = 700
triggerALL = power >= 500
triggerALL = command = "Teleport"
trigger1 = (statetype = S) && ctrl

[State -1, Roll 1]
type = ChangeState
value = 99
triggerALL = power <= 499
triggerALL = command = "Dash 1" && command = "holdfwd"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Roll 2]
type = ChangeState
value = 99
triggerALL = power <= 499
triggerALL = command = "Dash 2" && command = "holdfwd"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Roll 3]
type = ChangeState
value = 99
triggerALL = power <= 499
triggerALL = command = "Dash 3" && command = "holdfwd"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Dash 1]
type = ChangeState
value = 100
triggerALL = power >= 500
triggerALL = command = "Dash 1" && command = "holdfwd"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Dash 2]
type = ChangeState
value = 100
triggerALL = power >= 500
triggerALL = command = "Dash 2" && command = "holdfwd"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

[State -1, Dash 3]
type = ChangeState
value = 100
triggerALL = power >= 500
triggerALL = command = "Dash 3" && command = "holdfwd"
triggerall = command != "holddown"
trigger1 = (statetype = s) && ctrl

;===========================================================================
[State -1
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------

[State -1, Guard Jump]
type = ChangeState
value = 132
triggerall = Var(50) != 1
triggerall = !var(4)
;Triggerall = Inguarddist
triggerall = statetype = A
triggerall = ctrl
trigger1 = command = "hold_c"

;---------------------------------------------------------------------------

[State -1, Guard Standing]
type = ChangeState
value = 130
triggerall = Var(50) != 1
;Triggerall = Inguarddist
triggerall = statetype = S
triggerall = ctrl
trigger1 = command = "hold_c"

;---------------------------------------------------------------------------

[State -1, Guard Crouch]
type = ChangeState
value = 131
triggerall = Var(50) != 1
triggerall = !var(4)
triggerall = statetype = C
triggerall = ctrl
trigger1 = command = "hold_c"

;---------------------------------------------------------------------------

[State -1, FF Jump Farward]
type = ChangeState
value = 101
triggerALL = command = "FF"
trigger1 = statetype = S
trigger1 = ctrl = 1

;---------------------------------------------------------------------------
; Run Back
[State -1, Hop Back]
type = ChangeState
value = 105
trigger1 = command = "BB"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Throw
[State -1, Grab Throw]
type = ChangeState
value = 800
triggerall = !var(4)
triggerall = command = "y" || command = "z"
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
trigger1 = command = "holdfwd"
trigger1 = p2bodydist X < 10
trigger1 = (p2statetype = S) || (p2statetype = C)
trigger1 = p2movetype != H
trigger2 = command = "holdback"
trigger2 = p2bodydist X < 10
trigger2 = (p2statetype = S) || (p2statetype = C)
trigger2 = p2movetype != H

;===========================================================================
;---------------------------------------------------------------------------
; Taunt
[State -1, Taunt]
type = ChangeState
value = 195
triggerall = !var(4)
triggerall = command = "s"
trigger1 = statetype != A
trigger1 = ctrl

;===========================================================================
[State -1
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------

[State -1, Upper Slice]
type = ChangeState
value = 9050
triggerall = command = "a" && command = "b" && command = "holdback"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Lower Slice]
type = ChangeState
value = 9051
triggerall = command = "a" && command = "x" && command = "holdback"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Kick Fwd Trigger]
type = ChangeState
value = 290
triggerall = !var(4)
triggerall = command = "b" && command = "holdfwd"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Trip Kick Fwd Trigger]
type = ChangeState
value = 291
triggerall = !var(4)
triggerall = command = "a" && command = "holdfwd"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

; Stand Light Punch
[State -1,Punch 1]
type = ChangeState
value = 200
triggerall = !var(4)
triggerall = command = "x"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Stand Medium Punch
[State -1,Punch 2]
type = ChangeState
value = 210
triggerall = !var(4)
triggerall = command = "z"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Combo set 1 punch 1]
type = ChangeState
value = 220
triggerall = !var(4)
triggerall = command = "b"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Combo set 1 punch 2]
type = ChangeState
value = 230
triggerall = !var(4)
triggerall = command = "b"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 2
trigger2 = stateno = 220
trigger2 = movecontact

;---------------------------------------------------------------------------

[State -1, Combo set 1 punch 3]
type = ChangeState
value = 240
triggerall = !var(4)
triggerall = command = "b"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 2
trigger2 = stateno = 230
trigger2 = movecontact

;---------------------------------------------------------------------------

[State -1, Combo set 1 punch 4]
type = ChangeState
value = 250
triggerall = !var(4)
triggerall = command = "b"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 2
trigger2 = stateno = 240
trigger2 = movecontact

;---------------------------------------------------------------------------

[State -1, Combo set 2 Kick 1]
type = ChangeState
value = 280
triggerall = !var(4)
triggerall = command = "a"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Combo set 2 punch]
type = ChangeState
value = 293
triggerall = !var(4)
triggerall = command = "a"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 11
trigger2 = stateno = 280
trigger2 = movecontact

;---------------------------------------------------------------------------

[State -1, Combo set 2 Kick 2]
type = ChangeState
value = 292
triggerall = !var(4)
triggerall = command = "a"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 4
trigger2 = stateno = 293
trigger2 = movecontact

;---------------------------------------------------------------------------

[State -1, Combo set 2 Two Price Kick]
type = ChangeState
value = 300
triggerall = !var(4)
triggerall = command = "a"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 4
trigger2 = stateno = 292
trigger2 = movecontact

;---------------------------------------------------------------------------

[State -1, Kick Random Changer]
type = ChangeState
value = 260
triggerall = !var(4)
triggerall = command = "y"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Crouching Light Punch
[State -1, Crouch Uppercut]
type = ChangeState
value = 400
triggerall = command = "x"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Crouch Trip Kick]
type = ChangeState
value = 410
triggerall = !var(4)
triggerall = command = "z"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Crouch Punch]
type = ChangeState
value = 420
triggerall = p2name != "Scorpion-By cliff-A"
triggerall = p2name != "SubZero-By cliff-A"
triggerall = command = "y"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Crouch Nut Punch 1]
type = ChangeState
value = 421
triggerall = p2name = "Scorpion-By cliff-A"
triggerall = p2stateno != 10002
triggerall = command = "y"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Crouch Nut Punch 2]
type = ChangeState
value = 421
triggerall = p2name = "SubZero-By cliff-A"
triggerall = p2stateno != 10002
triggerall = command = "y"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Crouch Kick Up]
type = ChangeState
value = 430
triggerall = command = "a"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, Crouch Kick Low]
type = ChangeState
value = 440
triggerall = !var(4)
triggerall = command = "b"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Light kick
[State -1, Jump Kick]
type = ChangeState
value = 600
triggerall = command = "x"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Light Punch
[State -1, Jump Punch]
type = ChangeState
value = 610
triggerall = command = "a"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump hard kick
[State -1, Jump Killer Kick]
type = ChangeState
value = 620
triggerall = command = "y"
trigger1 = statetype = A
trigger1 = ctrl

;===========================================================================
[State -1
;===========================================================================

;===========================================================================
[State -1
;===========================================================================

;                AI                            SETS

;===========================================================================
[State -1
;===========================================================================

;===========================================================================
[State -1
;===========================================================================

[State -1,AI Fatality Uppercut Train Hit]
type = ChangeState
value = 70010
triggerall = p2life < 2
triggerall = p2bodydist X < 10
triggerall = var(4)
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = RoundState = 2
trigger1 = (statetype = s) && ctrl

[State -1,AI Fatality Animality]
type = ChangeState
value = 70006
triggerall = p2life < 2
triggerall = p2bodydist X < 60
triggerall = var(4)
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = RoundState = 2
trigger1 = (statetype = s) && ctrl

[State -1,AI Fatality Cutter]
type = ChangeState
value = 70000
triggerall = p2name = "SubZero-By cliff-A" ||  p2name = "Scorpion-By cliff-A"
triggerall = p2life < 2
triggerall = p2bodydist X < 10
triggerall = var(4)
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = RoundState = 2
trigger1 = (statetype = s) && ctrl

[State -1,AI Fatality Hell Hand]
type = ChangeState
value = 70007
triggerall = p2life < 2
triggerall = p2bodydist X > 80
triggerall = var(4)
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = RoundState = 2
trigger1 = (statetype = s) && ctrl

[State -1,AI Fatality Burn Toasty]
type = ChangeState
value = 70003
triggerall = p2life < 2
triggerall = var(4)
triggerall = p2bodydist x = [50,90]
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = RoundState = 2
trigger1 = (statetype = s) && ctrl

[State -1,AI Fatality Burn Forever]
type = ChangeState
value = 70001
triggerall = p2life < 2
triggerall = p2bodydist x = [50,90]
triggerall = var(4)
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = RoundState = 2
trigger1 = (statetype = s) && ctrl

[State -1,AI Fatality Test Your Might]
type = ChangeState
value = 70002
triggerall = p2life < 2
triggerall = var(4)
triggerall = p2bodydist X > 40
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = RoundState = 2
trigger1 = (statetype = s) && ctrl

[State -1,AI Fatality Babality]
type = ChangeState
value = 70005
triggerall = p2life < 2
triggerall = p2bodydist X > 40
triggerall = var(4)
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = RoundState = 2
trigger1 = (statetype = s) && ctrl

[State -1,AI Fatality Buy A Scorpion Doll]
type = ChangeState
value = 70004
triggerall = p2life < 2
triggerall = p2bodydist X > 40
triggerall = var(4)
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = RoundState = 2
trigger1 = (statetype = s) && ctrl

[State -1,AI Fatality Clone Spawn]
type = ChangeState
value = 70011
triggerall = p2life < 2
triggerall = p2bodydist X > 40
triggerall = var(4)
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = RoundState = 2
trigger1 = (statetype = s) && ctrl

;===========================================================================
[State -1
;===========================================================================

[State -1,AI Shows Mercy]
type = ChangeState
value = 40001
triggerall = p2life < 2
triggerall = p2bodydist X > 50
triggerall = var(4)
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = RoundState = 2
trigger1 = (statetype = S) && ctrl

;===========================================================================
[State -1
;===========================================================================

[State -1,AI Super Hyper Combo]
type = ChangeState
value = 9030
triggerall = !var(4)
triggerALL = power >= 2000
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = p2bodydist x < 50
trigger1 = (statetype = S) && ctrl

[State -1,AI Spear]
type = ChangeState
value = 9005
triggerall = !var(4)
triggerALL = power >= 700
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random = [0,200]
triggerall = p2Stateno != 9012
triggerall = p2bodydist X > 60
trigger1 = (statetype = s) && ctrl

[State -1,AI Fire Breath]
type = ChangeState
value = 9000
triggerall = !var(4)
triggerALL = power >= 700
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist X = [30,90]
triggerall = random = [0,200]
trigger1 = (statetype = s) && ctrl

[State -1,AI Air Teleport]
type = ChangeState
value = 704
triggerall = !var(4)
triggerALL = power >= 500
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random = [0,200]
trigger1 = (statetype = A) && ctrl

[State -1,AI Teleport]
type = ChangeState
value = 700
triggerall = !var(4)
triggerALL = power >= 500
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist x != [0,30]
triggerall = random = [0,200]
trigger1 = (statetype = s) && ctrl

[State -1,AI Teleport Kick BWD]
type = ChangeState
value = 301
triggerall = !var(4)
triggerALL = power >= 1300
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist X > 50
triggerall = random = [0,200]
trigger1 = (statetype = S) && ctrl

[State -1,AI Teleport Punch FWD]
type = ChangeState
value = 304
triggerall = !var(4)
triggerALL = power >= 1300
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist X > 50
triggerall = random = [0,200]
trigger1 = (statetype = S) && ctrl

;---------------------------------------------------------------------------
; Crouching Light Punch
[State -1,AI Crouch Uppercut]
type = ChangeState
value = 400
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = p2bodydist x < 30
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Kick Fwd Trigger]
type = ChangeState
value = 290
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = p2bodydist x < 30
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Trip Kick Fwd Trigger]
type = ChangeState
value = 291
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = p2bodydist x < 30
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Kick Random Changer]
type = ChangeState
value = 260
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = p2bodydist x < 30
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Crouch Nut Punch 1]
type = ChangeState
value = 421
triggerall = p2name = "Scorpion-By cliff-A"
triggerall = p2stateno != 10002
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = p2bodydist x < 20
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Crouch Nut Punch 2]
type = ChangeState
value = 421
triggerall = p2name = "SubZero-By cliff-A"
triggerall = p2stateno != 10002
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = p2bodydist x < 20
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Combo set 1 punch 1]
type = ChangeState
value = 220
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist x < 30
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Combo set 1 punch 2]
type = ChangeState
value = 230
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 2
trigger2 = stateno = 220
trigger2 = movecontact

;---------------------------------------------------------------------------

[State -1,AI Combo set 1 punch 3]
type = ChangeState
value = 240
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 2
trigger2 = stateno = 230
trigger2 = movecontact

;---------------------------------------------------------------------------

[State -1,AI Combo set 1 punch 4]
type = ChangeState
value = 250
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 2
trigger2 = stateno = 240
trigger2 = movecontact

;---------------------------------------------------------------------------
[State -1,AI Combo set 2 Kick 1]
type = ChangeState
value = 280
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist x < 30
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Combo set 2 punch]
type = ChangeState
value = 293
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 11
trigger2 = stateno = 280
trigger2 = movecontact

;---------------------------------------------------------------------------

[State -1,AI Combo set 2 Kick 2]
type = ChangeState
value = 292
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 4
trigger2 = stateno = 293
trigger2 = movecontact

;---------------------------------------------------------------------------

[State -1,AI Combo set 2 Two Price Kick]
type = ChangeState
value = 300
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = time >= 11
trigger2 = stateno = 292
trigger2 = movecontact

;---------------------------------------------------------------------------
[State -1,AI Upper Slice]
type = ChangeState
value = 9050
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist x < 30
trigger1 = statetype = S
trigger1 = ctrl

[State -1,AI Lower Slice]
type = ChangeState
value = 9050
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist x < 30
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

; Stand Light Punch
[State -1,AI Punch 1]
type = ChangeState
value = 200
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = p2bodydist x < 30
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Stand Medium Punch
[State -1,AI Punch 2]
type = ChangeState
value = 210
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = p2bodydist x < 30
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Crouch Trip Kick]
type = ChangeState
value = 410
triggerall = !var(4)
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = p2bodydist x < 20
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Crouch Punch]
type = ChangeState
value = 420
triggerall = p2name != "Scorpion-By cliff-A"
triggerall = p2name != "SubZero-By cliff-A"
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = p2bodydist x < 20
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Crouch Kick Up]
type = ChangeState
value = 430
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist x < 20
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1,AI Crouch Kick Low]
type = ChangeState
value = 440
triggerall = !var(4)
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist x < 20
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Light kick
[State -1,AI Jump Kick]
type = ChangeState
value = 600
triggerall = random = [0,200]
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist x < 30
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Light Punch
[State -1,AI Jump Punch]
type = ChangeState
value = 610
triggerall = random = [0,200]
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist x < 30
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump hard kick
[State -1,AI Jump Killer Kick]
type = ChangeState
value = 620
triggerall = random = [0,200]
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = p2bodydist x < 30
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Stand Light Punch
[State -1,AI Guard Standing]
type = ChangeState
value = 130
triggerall = !var(4)
Triggerall=Inguarddist
triggerall = p2movetype = A
triggerall = RoundState = 2
triggerall = Var(50) = 1
triggerall = random >= 250 && random < 299 || random >= 550 && random <= 999
triggerall = p2bodydist x < 20
trigger1 = statetype = S
trigger1 = ctrl

