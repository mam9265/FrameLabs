;-| Super Motions |--------------------------------------------------------

[Command]
name = "Kpn_a"
command = ~20$B, F, B, F, a
[Command]
name = "Kpn_b"
command = ~20$B, F, B, F, b
[Command]
name = "Kpn_c"
command = ~20$B, F, B, F, c



;-| Special Motions |------------------------------------------------------

[Command]
name = "press"
command = ~20$D,$U,x

[Command]
name = "press"
command = ~20$D,$U,y

[Command]
name = "press"
command = ~20$D,$U,z


[Command]
name = "psycrsh1"
command = ~20$B,F,x

[Command]
name = "psycrsh2"
command = ~20$B,F,y

[Command]
name = "psycrsh3"
command = ~20$B,F,z

[Command]
name = "knee_press1"
command = ~20$B,F,a

[Command]
name = "knee_press2"
command = ~20$B,F,b

[Command]
name = "knee_press3"
command = ~20$B,F,c


[Command]
name = "head_press1"
command = ~20$D,$U,a

[Command]
name = "head_press2"
command = ~20$D,$U,b

[Command]
name = "head_press3"
command = ~20$D,$U,c


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

[Command]
name = "xy"
command = x+y
time = 5

[Command]
name = "yz"
command = y+z
time = 5

[Command]
name = "xz"
command = x+z
time = 5

[Command]
name = "xyz"
command = x+y+z
time = 5

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "fwd_a"
command = /F,a
time = 1

[Command]
name = "fwd_b"
command = /F,b
time = 1

[Command]
name = "fwd_c"
command = /F,c
time = 1

[Command]
name = "fwd_x"
command = /F,x
time = 1

[Command]
name = "fwd_y"
command = /F,y
time = 1

[Command]
name = "fwd_z"
command = /F,z
time = 1

[Command]
name = "back_a"
command = /B,a
time = 1

[Command]
name = "back_b"
command = /B,b
time = 1

[Command]
name = "back_c"
command = /B,c
time = 1

[Command]
name = "back_x"
command =/B,x
time = 1

[Command]
name = "back_y"
command =/B,y
time = 1

[Command]
name = "back_z"
command =/B,z
time = 1

[Command]
name = "down_a"
command =/D,a
time = 1

[Command]
name = "down_b"
command =/D,b
time = 1

[Command]
name = "down_c"
command =/D,c
time = 1

[Command]
name = "down_x"
command =/D,x
time = 1

[Command]
name = "down_y"
command =/D,y
time = 1

[Command]
name = "down_z"
command =/D,z
time = 1

[Command]
name = "fwd_ab"
command =/F, a+b
time = 1

[Command]
name = "fwd_bc"
command =/F, b+c
time = 1

[Command]
name = "fwd_xy"
command =/F, x+y
time = 1

[Command]
name = "fwd_yz"
command =/F, y+z
time = 1

[Command]
name = "back_xy"
command =/B, x+y
time = 1

[Command]
name = "back_yz"
command =/B, y+z
time = 1

[Command]
name = "back_ab"
command =/B, a+b
time = 1

[Command]
name = "back_bc"
command =/B, b+c
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
;===========================================================================
;===========================================================================

[State -1, Catch]
type = ChangeState
value = 800
trigger1 = command = "holdfwd" && command="y"
trigger2 = command = "holdfwd" && command="z"
triggerall = p2bodydist X < 15
triggerall = stateno != 100
triggerall = statetype = S
triggerall = p2movetype != H
triggerall = ctrl

[State -1, Catch]
type = ChangeState
value = 810
trigger1 = command = "holdback" && command="y"
trigger2 = command = "holdback" && command="z"
triggerall = p2bodydist X < 15
triggerall = stateno != 100
triggerall = statetype = S
triggerall = p2movetype != H
triggerall = ctrl

;---------------------------------------------------------------------------
[State -1, Knee Press Nightmare]
type = ChangeState
value = ifelse(palno>6,0,ifelse(palno<=6,2100,1))
triggerall = command="Kpn_a" || command="Kpn_b" || command="Kpn_c"
triggerall = power = 1000
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 270

[State -1, press]
type = ChangeState
value = 1200
triggerall = command = "head_press1" || command = "head_press2" || command = "head_press3"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 40

[State -1, head_press1]
type = ChangeState
value = 1100
triggerall = command = "press"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 40

[State -1, head_press2]
type = ChangeState
value = 1105
triggerall = command = "press"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 40

[State -1, head_press3]
type = ChangeState
value = 1110
triggerall = command = "press"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 40

[State -1, Psycho]
type = ChangeState
value = 1000
triggerall = command = "psycrsh1"
trigger1 = statetype = S
trigger1 = ctrl

[State -1, Psycho2]
type = ChangeState
value = 1010
triggerall = command = "psycrsh2"
trigger1 = statetype = S
trigger1 = ctrl

[State -1, Psycho3]
type = ChangeState
value = 1020
triggerall = command = "psycrsh3"
trigger1 = statetype = S
trigger1 = ctrl

[State -1, knee_press]
type = ChangeState
value = 1050
triggerall = command = "knee_press1"
trigger1 = statetype = S
trigger1 = ctrl

[State -1, knee_press2]
type = ChangeState
value = 1055
triggerall = command = "knee_press2"
trigger1 = statetype = S
trigger1 = ctrl

[State -1, knee_press3]
type = ChangeState
value = 1057
triggerall = command = "knee_press3"
trigger1 = statetype = S
trigger1 = ctrl


;---------------------------------------------------------------------------
;Stand Light Punch
[State -1, Stand Light Punch]
type = ChangeState
value = 200
triggerall = command = "x"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = movecontact = 1
trigger3 = stateno = 230
trigger3 = movecontact = 1


;---------------------------------------------------------------------------
;Stand Strong Punch
[State -1, Stand Strong Punch]
type = ChangeState
value = 210
triggerall = command = "y"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = movecontact = 1
trigger3 = stateno = 230
trigger3 = movecontact = 1



;---------------------------------------------------------------------------
;Stand Strong Punch
[State -1, Stand Strong Punch]
type = ChangeState
value = 220
triggerall = command = "z"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = movecontact = 1
trigger3 = stateno = 210
trigger3 = movecontact = 1
trigger4 = stateno = 230
trigger4 = movecontact = 1
trigger5 = stateno = 240
trigger5 = movecontact = 1

;---------------------------------------------------------------------------
;Stand Light Kick
[State -1, Stand Light Kick]
type = ChangeState
value = 230
triggerall = command = "a"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = movecontact = 1

;---------------------------------------------------------------------------
;Standing Strong Kick
[State -1, Standing Strong Kick]
type = ChangeState
value = 240
triggerall = command = "b"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = movecontact = 1
trigger3 = stateno = 210
trigger3 = movecontact = 1
trigger4 = stateno = 230
trigger4 = movecontact = 1

;---------------------------------------------------------------------------
;Standing Strong Kick
[State -1, Standing Strong Kick]
type = ChangeState
value = 250
triggerall = command = "c"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = movecontact = 1
trigger3 = stateno = 210
trigger3 = movecontact = 1
trigger4 = stateno = 220
trigger4 = movecontact = 1
trigger5 = stateno = 230
trigger5 = movecontact = 1
trigger6 = stateno = 240
trigger6 = movecontact = 1

;---------------------------------------------------------------------------
;Crouching Light Punch
[State -1, Crouching Light Punch]
type = ChangeState
value = 400
triggerall = command = "x"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
;Crouching Strong Punch
[State -1, Crouching Strong Punch]
type = ChangeState
value = 410
triggerall = command = "y"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
;Crouching Strong Punch
[State -1, Crouching Strong Punch]
type = ChangeState
value = 420
triggerall = command = "z"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
;Crouching Light Kick
[State -1, Crouching Light Kick]
type = ChangeState
value = 430
triggerall = command = "a"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
;Crouching Strong Kick
[State -1, Crouching Strong Kick]
type = ChangeState
value = 440
triggerall = command = "b"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
;Crouching Strong Kick
[State -1, Crouching Strong Kick]
type = ChangeState
value = 450
triggerall = command = "c"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
;Jump Light Punch
[State -1, Jump Light Punch]
type = ChangeState
value = 600
triggerall = command = "x"
triggerall = vel X = 0
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Jump Strong Punch
[State -1, Jump Strong Punch]
type = ChangeState
value = 610
triggerall = command = "y"
triggerall = vel X = 0
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Jump Strong Punch
[State -1, Jump Strong Punch]
type = ChangeState
value = 620
triggerall = command = "z"
triggerall = vel X = 0
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Jump Light Kick
[State -1, Jump Light Kick]
type = ChangeState
value = 630
triggerall = command = "a"
triggerall = vel X = 0
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Jump Strong Kick
[State -1, Jump Strong Kick]
type = ChangeState
value = 640
triggerall = command = "b"
triggerall = vel X = 0
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Jump Strong Kick
[State -1, Jump Strong Kick]
type = ChangeState
value = 650
triggerall = command = "c"
triggerall = vel X = 0
trigger1 = statetype = A
trigger1 = ctrl


;---------------------------------------------------------------------------
;Jump Light Punch
[State -1, Jump Light Punch]
type = ChangeState
value = 601
triggerall = command = "x"
trigger1 = statetype = A
trigger1 = ctrl

;Jump Strong Punch
[State -1, Jump Strong Punch]
type = ChangeState
value = 611
triggerall = command = "y"
trigger1 = statetype = A
trigger1 = ctrl

;Jump Strong Punch
[State -1, Jump Strong Punch]
type = ChangeState
value = 621
triggerall = command = "z"
trigger1 = statetype = A
trigger1 = ctrl

;Jump Light Kick
[State -1, Jump Light Kick]
type = ChangeState
value = 631
triggerall = command = "a"
trigger1 = statetype = A
trigger1 = ctrl

;Jump Strong Kick
[State -1, Jump Strong Kick]
type = ChangeState
value = 641
triggerall = command = "b"
trigger1 = statetype = A
trigger1 = ctrl

;Jump Strong Kick
[State -1, Jump Strong Kick]
type = ChangeState
value = 651
triggerall = command = "c"
trigger1 = statetype = A
trigger1 = ctrl
;---------------------------------------------------------------------------
