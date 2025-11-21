; ______________________________
;| Guy by Phantom.of.the.Server |
; ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
;==============================================================================================
;=======================================<COMMON STATES>========================================
;==============================================================================================

;====================<STANDING>====================
[Statedef 0]
type = S
physics = S
movetype = I
velset = 0, 0
sprpriority = 0
juggle = 0

[State 0, Gone]
type = destroyself
trigger1 = ishelper
removeexplods = 1

[State 0, Anim]
type = changeanim
trigger1 = anim != 0 && anim != 5
trigger2 = anim = 5 && !animtime
value = 0

[State 0, Dead]
type = selfstate
trigger1 = !alive
value = 5050
ctrl = 0

[State 0, Not Myself]
type = selfstate
trigger1 = incustomstate
trigger1 = time > 0
value = 5040


;====================<CROUCHING>====================
[Statedef 10]
type = C
physics = C
movetype = I
velset = 0, 0
sprpriority = 0

[State 10, Anim]
type = changeanim
trigger1 = !time
trigger1 = anim = 12
value = 10
elem = 3 - animelemno(0)

[State 10, Anim]
type = changeanim
trigger1 = !time
trigger1 = anim = 47
value = 10
elem = 2

[State 10, Anim]
type = changeanim
trigger1 = anim != 10
value = 10

[State 10, End]
type = selfstate
trigger1 = !animtime
value = 11


[Statedef 11]
type = C
physics = C
movetype = I
anim = 11
velset = 0, 0
sprpriority = 0

[State 11, Anim]
type = changeanim
trigger1 = anim = 6
trigger1 = !animtime
value = 11


[Statedef 12]
type = S
physics = S
movetype = I
velset = 0, 0
sprpriority = 0

[State 12, Anim]
type = changeanim
trigger1 = !time
trigger1 = anim = 10
value = 12
elem = 3 - animelemno(0)

[State 12, Anim]
type = changeanim
trigger1 = anim != 12
value = 12

[State 12, End]
type = selfstate
trigger1 = !animtime
value = 0


;====================<WALKING>====================
[Statedef 20]
type = S
physics = S
movetype = I
sprpriority = 0

[State 20, Vel]
type = velset
trigger1 = command = "holdfwd"
x = const(velocity.walk.fwd.x)

[State 20, Vel]
type = velset
trigger1 = command = "holdback"
x = const(velocity.walk.back.x)

[State 20, Anim]
type = changeanim
triggerall = vel x > 0
trigger1 = anim != 5 && anim != 12 && anim != 20
trigger2 = anim = 5
trigger2 = !animtime
trigger3 = anim = 12
trigger3 = !animtime
value = 20

[State 20, Anim]
type = changeanim
triggerall = vel x < 0
trigger1 = anim != 5 && anim != 12 && anim != 21
trigger2 = anim = 5
trigger2 = !animtime
trigger3 = anim = 12
trigger3 = !animtime
value = 21


;===================<JUMPING>================
;----- JUMP START -----
[Statedef 40]
type = S
physics = S
movetype = I
anim = 40
ctrl = 0
velset = 0, 0
sprpriority = 1
facep2 = (prevstateno != 100)

[State 40, Keyboard Check]; currently obsolete in Ikemen
type = changestate
trigger1 = !time
trigger1 = !AIlevel
trigger1 = prevstateno = 52
trigger1 = command = "holddown" && command = "holdup"
value = 10
ctrl = 1

[State 40, Direction]
type = varset
trigger1 = !time
sysvar(1) = 0

[State 40, Direction]
type = varset
trigger1 = !AIlevel
trigger1 = time >= 1
trigger1 = command = "holdfwd" || command = "holdback"
sysvar(1) = (command = "holdfwd") - (command = "holdback")
persistent = 0

[State 40, Direction]
type = varset
trigger1 = AIlevel
sysvar(1) = ifelse(p2bodydist x < 30, 0, ifelse((life - p2life) > 200 && p2movetype != H && random < 333, -1, 1))

[State 40, High Jump]
type = mapset
trigger1 = !time
map = "jumptype"
value = 0

[State 40, High Jump]
type = mapset
trigger1 = !time
trigger1 = !AIlevel
trigger1 = map(cmd_highjump)
map = "jumptype"
value = 3

[State 40, High Jump]
type = mapset
trigger1 = !time
trigger1 = AIlevel
trigger1 = p2bodydist x > 80 && p2statetype != L
trigger1 = random < 333
map = "jumptype"
value = 3

[State 40, Running Jump]
type = mapset
trigger1 = prevstateno = 100
map = "jumptype"
value = 3

[State 40, Running Jump]
type = varset
trigger1 = prevstateno = 100
sysvar(1) = 1

[State 40, Low Jump]
type = mapset
trigger1 = !AIlevel
trigger1 = command != "holdup"
trigger1 = map(jumptype) != [1, 2]
map = "jumptype"
value = ifelse((map(jumptype) = 3 && sysvar(1)), 2, 1)

[State 40, Low Jump]
type = mapset
trigger1 = AIlevel
trigger1 = !animtime
trigger1 = map(jumptype) != [1, 2]
trigger1 = p2statetype = S || p2statetype = C
trigger1 = p2bodydist x < 70
trigger1 = random < ifelse(sysvar(1) = 1, 500, 125)
trigger1 = random < ifelse(p2statetype = C, 500, 250)
map = "jumptype"
value = ifelse((map(jumptype) = 3 && sysvar(1)), 2, 1)

[State 40, Sound]
type = playsnd
trigger1 = !animtime
value = 0, ifelse(map(jumptype) = [2, 3], 41, 40)

[State 40, Dust]
type = helper
trigger1 = !animtime
helpertype = normal
stateno = 7100
ID = 7100
name = "Jump Dust"
postype = p1
ownpal = 1

[State 40, Vel Normal]
type = velset
trigger1 = !animtime
x = ifelse(!sysvar(1), const(velocity.jump.neu.x), ifelse(sysvar(1) = 1, const(velocity.jump.fwd.x), const(velocity.jump.back.x)))
y = const(velocity.jump.y)

[State 40, Vel Short]
type = velset
trigger1 = !animtime && map(jumptype) = 1
x = ifelse(!sysvar(1), const(velocity.jump.neu.x), ifelse(sysvar(1) = 1, const(velocity.jump.fwd.x), const(velocity.jump.back.x)))
y = 0.75 * const(velocity.jump.y)

[State 40, Vel Medium]
type = velset
trigger1 = !animtime && map(jumptype) = 2
x = ifelse(!sysvar(1), const(velocity.jump.neu.x), ifelse(sysvar(1) = 1, const(velocity.runjump.fwd.x), const(velocity.runjump.back.x)))
y = 0.75 * const(velocity.jump.y)

[State 40, Vel Long]
type = velset
trigger1 = !animtime && map(jumptype) = 3
x = ifelse(!sysvar(1), const(velocity.jump.neu.x), ifelse(sysvar(1) = 1, const(velocity.runjump.fwd.x), const(velocity.runjump.back.x)))
y = ifelse(!sysvar(1), const(velocity.runjump.y), const(velocity.jump.y))

[State 40, End]
type = selfstate
trigger1 = !animtime
value = 50
ctrl = 1


;----- JUMP UP -----
[Statedef 50]
type = A
physics = N
movetype = I
sprpriority = 1

[State 50, Anim]
type = changeanim
trigger1 = !time
value = ifelse(!vel x, 41, ifelse(vel x > 0, 42, 43)) + 10 * (map(jumptype) = [1, 2])
persistent = 0

[State 50, No Guard]
type = assertspecial
trigger1 = map(jumptype) = 1 || map(jumptype) = 2
flag = noairguard

[State 50, Grounded Frame]
type = posfreeze
trigger1 = time < 1 && prevstateno = 40
value = 1

[State 50, Accel]
type = gravity
trigger1 = time >= 1 || prevstateno != 40

[State 50, Land]
type = selfstate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 52


;----- JUMP FALL -----
[Statedef 51]
type = A
physics = N
movetype = I
sprpriority = 1

[State 51, Accel]
type = gravity
trigger1 = 1

[State 51, Land]
type = selfstate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 52


;----- JUMP LAND -----
[Statedef 52]
type = S
physics = S
movetype = I
anim = 47
ctrl = 1; state -1 only sees this in the next frame
velset = 0, 0
sprpriority = 1

[State 52, Pos]
type = posset
trigger1 = 1
y = 0

[State 52, Hop Recovery]
type = changeanim
trigger1 = !time
trigger1 = map(jumptype) = 1 || map(jumptype) = 2
trigger1 = prevstateno = [600, 699]
value = 57

[State 52, Hop Recovery]
type = ctrlset
trigger1 = !time
trigger1 = anim = 57
value = 0

[State 52, Disable Trip Guard]; this is a bit different between Mugen and Ikemen
type = assertspecial
trigger1 = !time
trigger1 = prevstateno != [5000, 5999] && prevmovetype != H
trigger1 = prevstateno != 50 && prevstateno != 51 && prevstateno != [120, 155]
trigger1 = prevstateno != 703; air parry
flag = nostandguard
flag2 = nocrouchguard
flag3 = noairguard

[State 52, Trip Guard]; actually no longer necessary for human players
type = changestate
triggerall = !time
triggerall = ctrl
triggerall = inguarddist
triggerall = isasserted(nostandguard) = 0
triggerall = isasserted(nocrouchguard) = 0
trigger1 = !AIlevel
trigger1 = command = "holdback"
trigger2 = AIlevel
trigger2 = random < (1000 * (AIlevelF / 8.0))
value = 120

[State 52, No Walk]
type = assertspecial
trigger1 = animtime
trigger1 = anim != 5
flag = nowalk

[State 52, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 52, Dust]
type = explod
trigger1 = !time
anim = 7102
sprpriority = -5
postype = p1
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 52, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;======================<SANKAKU TOBI>===========================
;----- < FORWARD > -----
[Statedef 60]
type = A
movetype = I
physics = A
anim = 60
ctrl = 0

[State 60, Sound]
type = playsnd
trigger1 = animelem = 2
value = 0, 40

[State 60, Pos]
type = posadd
trigger1 = !time
trigger1 = backedgedist = [-80, 80]
x = backedgedist

[State 60, Stop]
type = velset
trigger1 = animelemtime(2) < 0
x = 0
y = 0

[State 60, Vel]
type = velset
trigger1 = animelem = 2
x = const(velocity.jump.fwd.x)
y = const(velocity.jump.y)

[State 60, Ctrl]
type = ctrlset
trigger1 = animelemtime(2) >= 0
value = 1


;----- < BACKWARD > -----
[Statedef 61]
type = A
movetype = I
physics = A
anim = 61
ctrl = 0

[State 61, Sound]
type = playsnd
trigger1 = animelem = 2
value = 0, 40

[State 61, Pos]
type = posadd
trigger1 = animelemtime(2) < 0
trigger1 = frontedgedist = [-80, 80]
x = frontedgedist

[State 61, Stop]
type = velset
trigger1 = animelemtime(2) < 0
x = 0
y = 0

[State 60, Vel]
type = velset
trigger1 = animelem = 2
x = const(velocity.jump.back.x)
y = const(velocity.jump.y)

[State 61, Ctrl]
type = ctrlset
trigger1 = animelemtime(3) >= 0
value = 1


;======================<RUN>===========================
[Statedef 100]
type = S
physics = S
anim = 100
ctrl = 0
sprpriority = 1

[State 100, Sound]
type = playsnd
trigger1 = animelem = 2
value = 0, 100
persistent = 0

[State 100, Dust]
type = helper
trigger1 = animelem = 2
helpertype = normal
stateno = 7104
ID = 8100
name = "Dash Dust"
postype = p1
pos = ceil(-20 * const(size.xscale)), 0
pausemovetime = 255
supermovetime = 255
ownpal = 1

[State 100, Vel]
type = velset
trigger1 = animelemtime(2) >= 0
x = const(velocity.run.fwd.x)

[State 100, steps]
type = playsnd
trigger1 = animelem = 3 || animelem = 6
value = 0, ifelse((animelem = 3), 103, 106)

[State 100, Jump]
type = changestate
trigger1 = !AIlevel
trigger1 = command = "holdfwd" && command = "holdup"
value = 40

[State 100, Jump]
type = changestate
trigger1 = AIlevel
trigger1 = random < 25
value = 40

[State 100, change]
type = changestate
triggerall = time >= 9
trigger1 = !AIlevel
trigger1 = command != "holdfwd" || command = "holdback"
trigger2 = AIlevel && p2dist x < 80
trigger3 = p2dist x < -const(size.ground.back)
value = 101


;----- STOP -----
[Statedef 101]
type = S
physics = S
movetype = I
anim = 101
ctrl = 0
sprpriority = 1

[State 101, Sound]
type = playsnd
trigger1 = !time
value = 0, 101

[State 101, Dust]
type = explod
trigger1 = !time
anim = 7103
sprpriority = 3
postype = p1
pos = 0, 0
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 101, Jump]
type = changestate
trigger1 = !AIlevel
trigger1 = command = "holdup"
value = 40

[State 101, End]
type = changestate
trigger1 = !animtime
value = ifelse(command = "holddown", 10, 0)
ctrl = 1


;========================<BACK DASH>==========================
[Statedef 105]
type = A
physics = N
movetype = I
velset = 0, 0
anim = 105
ctrl = 0
sprpriority = 1

[State 105, Pos]
type = posadd
trigger1 = animelem = 2
x = ceil(-26 * const(size.xscale))

[State 105, Sound]
type = playsnd
trigger1 = animelem = 2
value = 0, 105

[State 105, Dust]
type = helper
trigger1 = animelem = 2
helpertype = normal
stateno = 7104
ID = 8100
name = "Dash Dust"
postype = p1
pos = ceil(25 * const(size.xscale)), 0
facing = -1
pausemovetime = 255
supermovetime = 255
ownpal = 1

[State 105, Accel]
type = veladd
trigger1 = animelemtime(2) >= 0
y = 0.6

[State 105, Vel]
type = velset
trigger1 = animelem = 2
x = const(velocity.run.back.x)
y = const(velocity.run.back.y)

[State 105, End]
type = changestate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 106


;----- Land -----
[Statedef 106]
type = S
physics = S
ctrl = 0
anim = 47
velset = 0, 0

[State 106, Pos]
type = posset
trigger1 = 1
y = 0

[State 106, Sound]
type = playsnd
trigger1 = !time
value = 0, 106
persistent = 0

[State 106, Dust]
type = explod
trigger1 = !time
anim = 7102
sprpriority = -3
postype = p1
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 106, Ctrl]
type = ctrlset
trigger1 = time >= 2
value = 1

[State 106, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;========================<GUARD>========================
;----- START -----
[Statedef 120]
type = U
physics = U

[State 120, Do or do not]
type = assertspecial
trigger1 = 1
flag = nostandguard
flag2 = nocrouchguard
flag3 = noairguard

[State 120, AI Tranquilizer]
type = assertspecial
trigger1 = AIlevel
flag = nohardcodedkeys

[State 120, Type]
type = statetypeset
trigger1 = !time
trigger1 = statetype = S
physics = S

[State 120, Type]
type = statetypeset
trigger1 = !time
trigger1 = statetype = C
physics = C

[State 120, Type]
type = statetypeset
trigger1 = !time
trigger1 = statetype = A
physics = A

[State 120, Vel]
type = velset
trigger1 = !time
trigger1 = statetype != A
x = 0
y = 0

[State 120, High to Low]
type = statetypeset
triggerall = statetype = S
trigger1 = !AIlevel
trigger1 = command = "holddown"
trigger2 = AIlevel
trigger2 = !map(ai_blockhigh)
statetype = C
physics = C

[State 120, Low to High]
type = statetypeset
triggerall = statetype = C
trigger1 = !AIlevel
trigger1 = command != "holddown"
trigger2 = AIlevel
trigger2 = map(ai_blockhigh)
statetype = S
physics = S

[State 120, Anim]
type = changeanim
trigger1 = !time
value = 120 + (statetype = C) + (statetype = A) * 2

[State 120, End]
type = changestate
trigger1 = !animtime
value = 130 + (statetype = C) + (statetype = A) * 2

[State 120, Stop Guarding]
type = changestate
triggerall = statetype != A
trigger1 = !inguarddist
trigger2 = !AIlevel
trigger2 = p2dist x >= 0
trigger2 = command != "holdback" || command = "holdfwd"
trigger3 = !AIlevel
trigger3 = p2dist x < 0
trigger3 = command != "holdfwd" || command = "holdback"
trigger4 = AIlevel && numenemy
trigger4 = p2, hitdefattr = SCA, AT
value = 140

[State 120, No Walking]
type = assertspecial
triggerall = ctrl
trigger1 = p2dist x >= 0
trigger1 = command != "holdfwd"
trigger2 = p2dist x < 0
trigger2 = command != "holdback"
flag = nowalk


;----- STAND GUARD (Guarding) -----
[Statedef 130]
type = S
physics = S
velset = ifelse(prevstateno = 132 && abs(vel x) < 5, 0, vel x), 0

[State 130, Do or do not]
type = assertspecial
trigger1 = 1
flag = nostandguard
flag2 = nocrouchguard

[State 130, AI Tranquilizer]
type = assertspecial
trigger1 = AIlevel
flag = nohardcodedkeys

[State 130, Anim]
type = changeanim
trigger1 = anim != 130
value = 130

[State 130, AI fix]
type = changestate
trigger1 = AIlevel
trigger1 = numenemy
trigger1 = time >= 120 || p2, time >= 60
trigger1 = random < 17
value = 40

[State 130, Sound]
type = playsnd
trigger1 = !time
trigger1 = prevstateno = 132 || (prevstateno = [154, 155])
value = 0, 52

[State 130, Dust]
type = explod
trigger1 = !time
trigger1 = prevstateno = 132 || (prevstateno = [154, 155])
anim = 7102
sprpriority = -3
postype = p1
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 130, High to Low]
type = changestate
trigger1 = !AIlevel
trigger1 = command = "holddown"
trigger2 = AIlevel
trigger2 = !map(ai_blockhigh)
value = 131

[State 130, Stop Guarding]
type = changestate
trigger1 = !inguarddist
trigger2 = !AIlevel
trigger2 = p2dist x >= 0
trigger2 = command != "holdback" || command = "holdfwd"
trigger3 = !AIlevel
trigger3 = p2dist x < 0
trigger3 = command != "holdfwd" || command = "holdback"
trigger4 = AIlevel && numenemy
trigger4 = p2, hitdefattr = SCA, AT
value = 140

[State 130, No Walking]
type = assertspecial
triggerall = ctrl
trigger1 = p2dist x >= 0
trigger1 = command != "holdfwd"
trigger2 = p2dist x < 0
trigger2 = command != "holdback"
flag = nowalk


;----- CROUCH GUARD (Guarding) -----
[Statedef 131]
type = C
physics = C
velset = ifelse(prevstateno = 132 && abs(vel x) < 5, 0, vel x), 0

[State 131, Do or do not]
type = assertspecial
trigger1 = 1
flag = nostandguard
flag2 = nocrouchguard

[State 131, AI Tranquilizer]
type = assertspecial
trigger1 = AIlevel
flag = nohardcodedkeys

[State 131, Anim]
type = changeanim
trigger1 = anim != 131
value = 131

[State 131, Low to High]
type = changestate
trigger1 = !AIlevel
trigger1 = command != "holddown"
trigger2 = AIlevel
trigger2 = map(ai_blockhigh)
value = 130

[State 131, AI fix]
type = changestate
trigger1 = AIlevel
trigger1 = numenemy
trigger1 = time >= 120 || p2, time >= 60
trigger1 = random < 17
value = 40

[State 131, Stop Guarding]
type = changestate
trigger1 = !inguarddist
trigger2 = !AIlevel
trigger2 = p2dist x >= 0
trigger2 = command != "holdback" || command = "holdfwd"
trigger3 = !AIlevel
trigger3 = p2dist x < 0
trigger3 = command != "holdfwd" || command = "holdback"
trigger4 = AIlevel && numenemy
trigger4 = p2, hitdefattr = SCA, AT
value = 140


;----- AIR GUARD (Guarding) -----
[Statedef 132]
type = A
physics = N

[State 132, Do or do not]
type = assertspecial
trigger1 = 1
flag = noairguard

[State 132, AI Tranquilizer]
type = assertspecial
trigger1 = AIlevel
flag = nohardcodedkeys

[State 132, Anim]
type = changeanim
trigger1 = anim != 132
value = 132

[State 132, Accel]
type = veladd
trigger1 = 1
y = const(movement.yaccel)

[State 132, Var]
type = varset
trigger1 = 1
sysvar(0) = vel y > 0 && (pos y > -vel y)

[State 132, Vel]
type = velset
trigger1 = sysvar(0)
y = 0

[State 132, Pos]
type = posset
trigger1 = sysvar(0)
y = 0

[State 132, End]
type = changestate
triggerall = sysvar(0) && inguarddist
trigger1 = !AIlevel
trigger1 = ifelse(p2dist x < 0, command = "holdfwd", command = "holdback")
trigger2 = AIlevel
value = 130

[State 132, End]
type = changestate
trigger1 = sysvar(0)
value = 52

;[State 132, Stop guarding was here]


;----- GUARD (End) -----
[Statedef 140]
type = U
physics = U
ctrl = 1

[State 140, Type]
type = statetypeset
trigger1 = !time
trigger1 = statetype = S
physics = S

[State 140, Type]
type = statetypeset
trigger1 = !time
trigger1 = statetype = C
physics = C

[State 140, Type]
type = statetypeset
trigger1 = !time
trigger1 = statetype = A
physics = A

[State 140, High to Low]
type = statetypeset
triggerall = statetype = S
trigger1 = !AIlevel
trigger1 = command = "holddown"
trigger2 = AIlevel
trigger2 = !map(ai_blockhigh)
statetype = C
physics = C

[State 140, Low to High]
type = statetypeset
triggerall = statetype = C
trigger1 = !AIlevel
trigger1 = command != "holddown"
trigger2 = AIlevel
trigger2 = map(ai_blockhigh)
statetype = S
physics = S

[State 140, Anim]
type = changeanim
trigger1 = !time
value = 140 + (statetype = C) + (statetype = A) * 2

[State 140, No Walking]
type = assertspecial
triggerall = ctrl
trigger1 = p2dist x >= 0
trigger1 = command != "holdfwd"
trigger2 = p2dist x < 0
trigger2 = command != "holdback"
flag = nowalk

[State 140, End]
type = changestate
trigger1 = !animtime
value = (statetype = C) * 11 + (statetype = A) * 51


;----- STAND GUARD HIT (Shaking) -----
[Statedef 150]
type = S
physics = N
movetype = H
velset = 0, 0

[State 150, Stop Snd]
type = stopsnd
trigger1 = !time
channel = 0

[State 150, Anim]
type = changeanim
trigger1 = 1
value = 150

[State 150, End]
type = changestate
trigger1 = hitshakeover
value = ifelse((!AIlevel && command = "holddown") || (AIlevel && !map(ai_blockhigh)), 153, 151)

[State 150, High to Low]
type = statetypeset
triggerall = statetype = S
trigger1 = !AIlevel
trigger1 = command = "holddown"
trigger2 = AIlevel
trigger2 = !map(ai_blockhigh)
statetype = C
physics = C

[State 150, Low to High]
type = statetypeset
triggerall = statetype = C
trigger1 = !AIlevel
trigger1 = command != "holddown"
trigger2 = AIlevel
trigger2 = map(ai_blockhigh)
statetype = S
physics = S

[State 150, Rumble]
type = forcefeedback
trigger1 = !time
waveform = square
time = max(4, gethitvar(hitshaketime) / 2)


;----- STAND GUARD HIT 2 (Knocked back) -----
[Statedef 151]
type = S
physics = S
movetype = H
anim = 130

[State 151, Vel]
type = hitvelset
trigger1 = !time
x = 1

[State 151, Vel]
type = velset
trigger1 = time = gethitvar(slidetime)
trigger2 = hitover
x = 0

[State 151, Ctrl]
type = ctrlset
trigger1 = time = gethitvar(ctrltime)
value = 1

[State 151, High to Low]
type = statetypeset
triggerall = statetype = S
trigger1 = !AIlevel
trigger1 = command = "holddown"
trigger2 = AIlevel
trigger2 = !map(ai_blockhigh)
statetype = C
physics = C

[State 151, Low to High]
type = statetypeset
triggerall = statetype = C
trigger1 = !AIlevel
trigger1 = command != "holddown"
trigger2 = AIlevel
trigger2 = map(ai_blockhigh)
statetype = S
physics = S

[State 151, End]
type = changestate
trigger1 = hitover
value = 130
ctrl = 1


;----- CROUCH GUARD HIT (Shaking) -----
[Statedef 152]
type = C
physics = N
movetype = H
velset = 0, 0

[State 152, Stop Snd]
type = stopsnd
trigger1 = !time
channel = 0

[State 152, Anim]
type = changeanim
trigger1 = 1
value = 151

[State 152, End]
type = changestate
trigger1 = hitshakeover
value = ifelse((!AIlevel && command = "holddown") || (AIlevel && !map(ai_blockhigh)), 153, 151)

[State 152, High to Low]
type = statetypeset
triggerall = statetype = S
trigger1 = !AIlevel
trigger1 = command = "holddown"
trigger2 = AIlevel
trigger2 = !map(ai_blockhigh)
statetype = C
physics = C

[State 152, Low to High]
type = statetypeset
triggerall = statetype = C
trigger1 = !AIlevel
trigger1 = command != "holddown"
trigger2 = AIlevel
trigger2 = map(ai_blockhigh)
statetype = S
physics = S

[State 152, Rumble]
type = forcefeedback
trigger1 = !time
waveform = square
time = max(4, gethitvar(hitshaketime) / 2)


;----- CROUCH GUARD HIT 2 (Knocked back) -----
[Statedef 153]
type = C
physics = C
movetype = H
anim = 131

[State 153, Vel]
type = hitvelset
trigger1 = !time
x = 1

[State 153, Vel]
type = velset
trigger1 = time = gethitvar(slidetime)
trigger2 = hitover
x = 0

[State 153, Ctrl]
type = ctrlset
trigger1 = time = gethitvar(ctrltime)
value = 1

[State 153, High to Low]
type = statetypeset
triggerall = statetype = S
trigger1 = !AIlevel
trigger1 = command = "holddown"
trigger2 = AIlevel
trigger2 = !map(ai_blockhigh)
statetype = C
physics = C

[State 153, Low to High]
type = statetypeset
triggerall = statetype = C
trigger1 = !AIlevel
trigger1 = command != "holddown"
trigger2 = AIlevel
trigger2 = map(ai_blockhigh)
statetype = S
physics = S

[State 153, End]
type = changestate
trigger1 = hitover
value = 131
ctrl = 1


;----- AIR GUARD HIT (Shaking) -----
[Statedef 154]
type = A
physics = N
movetype = H
velset = 0, 0

[State 154, Stop Snd]
type = stopsnd
trigger1 = !time
channel = 0

[State 154, Anim]
type = changeanim
trigger1 = 1
value = 152

[State 154, End]
type = changestate
trigger1 = hitshakeover
value = 155

[State 154, Rumble]
type = forcefeedback
trigger1 = !time
waveform = square
time = max(4, gethitvar(hitshaketime) / 2)


;----- AIR GUARD HIT 2 (Knocked away) -----
[Statedef 155]
type = A
physics = N
movetype = H
anim = 132

[State 155, Vel]
type = hitvelset
trigger1 = !time
x = 1
y = 1

[State 155, Accel]
type = veladd
trigger1 = 1
y = const(movement.yaccel)

[State 155, Ctrl]
type = ctrlset
trigger1 = time = gethitvar(ctrltime)
value = 1

[State 155, Var]
type = varset
trigger1 = 1
sysvar(0) = vel y > 0 && (pos y > -vel y)

[State 155, Vel]
type = velset
trigger1 = sysvar(0)
y = 0

[State 155, Pos]
type = posset
trigger1 = sysvar(0)
y = 0

[State 155, End]
type = changestate
triggerall = sysvar(0) && inguarddist
trigger1 = !AIlevel
trigger1 = ifelse(p2dist x < 0, command = "holdfwd", command = "holdback")
trigger2 = AIlevel
value = 130

[State 155, End]
type = changestate
trigger1 = sysvar(0)
value = 52


;====================<PARRY>====================
;----- STANDING -----
[Statedef 700]
type = S
physics = S
movetype = I
anim = 700
velset = 0, 0
ctrl = 0
sprpriority = 2
poweradd = 0
facep2 = 1

[State 700, HB]
type = hitby
trigger1 = 1
value = SCA, AT
time = 1

[State Check Parried Helper]
type = null
trigger1 = !time
trigger1 = 1 || map(parry_helper_ID) := 0
trigger1 = gethitvar(ID)
trigger1 = playerIDexist(gethitvar(ID))
trigger1 = playerID(gethitvar(ID)), ishelper
trigger1 = 1 || map(parry_helper_ID) := gethitvar(ID)

[State Freeze Parried Helper]
redirectID = map(parry_helper_ID)
type = posadd
trigger1 = playerIDexist(map(parry_helper_ID))
trigger1 = playerID(map(parry_helper_ID)), movetype = A
trigger1 = playerID(map(parry_helper_ID)), hitpausetime = 0
x = -1 * playerID(map(parry_helper_ID)), vel x
y = -1 * playerID(map(parry_helper_ID)), vel y

[State 700, Consecutive Parries]
type = posadd
trigger1 = !time
trigger1 = map(parry_nowalk) > 0
x = -8

[State 700, Freeze]
type = posfreeze
trigger1 = 1
value = 1

[State 700, No walking]
type = mapset
trigger1 = 1
map = "parry_nowalk"
value = 4

[State 700, Sound]
type = playsnd
trigger1 = !time
value = 3, 3
channel = 0

[State 700, Sound]
type = playsnd
trigger1 = !time
value = 7, 3

[State 700, Flash]
type = palfx
trigger1 = !time
add = 0, 64, 255
sinadd = 0, -64, -255, 60
time = 15

[State 700, FX]
type = explod
trigger1 = !time
anim = 7200
sprpriority = 5
postype = p1
pos = ceil(29 * const(size.xscale)), -75
pausemovetime = -1
supermovetime = -1
scale = 0.5, 0.5
ownpal = 1

[State 700, Shake]
type = envshake
trigger1 = !time
time = 1
ampl = 0

[State 700, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;----- CROUCHING -----
[Statedef 701]
type = C
physics = C
movetype = I
anim = 701
velset = 0, 0
ctrl = 0
sprpriority = 2
poweradd = 0
facep2 = 1

[State 701, HB]
type = hitby
trigger1 = 1
value = SCA, AT
time = 1

[State Check Parried Helper]
type = null
trigger1 = !time
trigger1 = 1 || map(parry_helper_ID) := 0
trigger1 = gethitvar(ID)
trigger1 = playerIDexist(gethitvar(ID))
trigger1 = playerID(gethitvar(ID)), ishelper
trigger1 = 1 || map(parry_helper_ID) := gethitvar(ID)

[State Freeze Parried Helper]
redirectID = map(parry_helper_ID)
type = posadd
trigger1 = playerIDexist(map(parry_helper_ID))
trigger1 = playerID(map(parry_helper_ID)), movetype = A
trigger1 = playerID(map(parry_helper_ID)), hitpausetime = 0
x = -1 * playerID(map(parry_helper_ID)), vel x
y = -1 * playerID(map(parry_helper_ID)), vel y

[State 701, Freeze]
type = posfreeze
trigger1 = 1
value = 1

[State 701, No walking]
type = mapset
trigger1 = 1
map = "parry_nowalk"
value = 4

[State 701, Sound]
type = playsnd
trigger1 = !time
value = 3, 3
channel = 0

[State 701, Sound]
type = playsnd
trigger1 = !time
value = 7, 3

[State 701, Flash]
type = palfx
trigger1 = !time
add = 0, 64, 255
sinadd = 0, -64, -255, 60
time = 15

[State 701, FX]
type = explod
trigger1 = !time
anim = 7200
sprpriority = 5
postype = p1
pos = ceil(4 * const(size.xscale)), -40
pausemovetime = -1
supermovetime = -1
scale = 0.5, 0.5
ownpal = 1

[State 701, Shake]
type = envshake
trigger1 = !time
time = 1
ampl = 0

[State 701, End]
type = changestate
trigger1 = !animtime
value = 11
ctrl = 1


;----- JUMPING -----
[Statedef 702]
type = A
physics = N
movetype = I
anim = 702
ctrl = 0
sprpriority = 2
poweradd = 0
facep2 = 1

[State 702, HB]
type = hitby
trigger1 = 1
value = SCA, AT
time = 1

[State Check Parried Helper]
type = null
trigger1 = !time
trigger1 = 1 || map(parry_helper_ID) := 0
trigger1 = gethitvar(ID)
trigger1 = playerIDexist(gethitvar(ID))
trigger1 = playerID(gethitvar(ID)), ishelper
trigger1 = 1 || map(parry_helper_ID) := gethitvar(ID)

[State Freeze Parried Helper]
redirectID = map(parry_helper_ID)
type = posadd
trigger1 = playerIDexist(map(parry_helper_ID))
trigger1 = playerID(map(parry_helper_ID)), movetype = A
trigger1 = playerID(map(parry_helper_ID)), hitpausetime = 0
x = -1 * playerID(map(parry_helper_ID)), vel x
y = -1 * playerID(map(parry_helper_ID)), vel y

[State 702, Freeze]
type = posfreeze
trigger1 = 1
value = 1

[State 702, Sound]
type = playsnd
trigger1 = !time
value = 3, 3
channel = 0

[State 702, Sound]
type = playsnd
trigger1 = !time
value = 7, 3

[State 702, Flash]
type = palfx
trigger1 = !time
add = 0, 64, 255
sinadd = 0, -64, -255, 60
time = 15

[State 702, FX]
type = explod
trigger1 = !time
anim = 7200
sprpriority = 5
postype = p1
pos = ceil(5 * const(size.xscale)), -78
pausemovetime = -1
supermovetime = -1
scale = 0.5, 0.5
ownpal = 1

[State 702, Shake]
type = envshake
trigger1 = !time
time = 1
ampl = 0

[State 702, End]
type = changestate
trigger1 = !animtime
value = 703
ctrl = 1


[Statedef 703]
type = A
physics = N
movetype = I
anim = 703
ctrl = 1

[State 703, Vel]
type = velset
trigger1 = !time
x = vel x
y = ifelse(vel y < -2.5, vel y, -2.5)

[State 703, Accel]
type = gravity
trigger1 = time > 0

[State 703, Land]
type = changestate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 52


;----- HELPER -----
[Statedef 705]
type = A
physics = N
movetype = I
anim = ifelse(root, statetype = C, 706, ifelse(root, statetype = A, 707, 705))
velset = 0, 0
ctrl = 0

[State 705, NHB]
type = nothitby
trigger1 = 1
value = SCA

[State 705, Bind]
type = bindtoroot
trigger1 = 1
time = -1

[State 705, Anim]
type = changeanim
triggerall = !time
trigger1 = !(root, AIlevel)
trigger1 = root, command = "D"
trigger2 = root, AIlevel
trigger2 = (root, statetype != A) && p2statetype = C
value = 706

[State 705, Anim]
type = changeanim
triggerall = !time
trigger1 = !(root, AIlevel)
trigger1 = root, command = "F"
trigger2 = root, AIlevel
trigger2 = anim != 706
value = ifelse((root, statetype = A), 707, 705)

[State 705, Anim]
type = changeanim
trigger1 = anim = 705 || anim = 707
value = ifelse((root, statetype = A), 707, 705)

[State 705, Disable]
type = varset
trigger1 = time >= ifelse((root, statetype = A), 8, 10)
trigger2 = facing != (root, facing)
trigger3 = !(root, ctrl)
trigger3 = root, stateno != [700, 702]
trigger3 = root, stateno != 5120
trigger4 = root, stateno = [120, 155]
trigger4 = root, stateno != 140
var(0) = 1

[State 705, Disable]
type = varset
triggerall = !var(0)
triggerall = !(root, AIlevel)
trigger1 = root, p2dist x >= 0
trigger1 = root, command = "holdback"
trigger2 = root, p2dist x < 0
trigger2 = root, command = "holdfwd"
trigger3 = time < 5
trigger3 = root, p2dist x >= 0
trigger3 = (root, command = "holdfwd" + root, command = "holddown") > 1
trigger4 = time < 5
trigger4 = root, p2dist x < 0
trigger4 = (root, command = "holdback" + root, command = "holddown") > 1
trigger5 = time >= 5
trigger5 = root, p2dist x >= 0
trigger5 = root, command = "holdfwd" || root, command = "holddown"
trigger6 = time >= 5
trigger6 = root, p2dist x < 0
trigger6 = root, command = "holdback" || root, command = "holddown"
trigger7 = time >= 1
trigger7 = anim = 705 || anim = 707
trigger7 = root, command = "D"
trigger8 = time >= 1
trigger8 = anim = 706
trigger8 = ifelse(root, p2dist x < 0, root, command = "B", root, command = "F")
var(0) = 1

[State 705, Disable]
type = changeanim
trigger1 = var(0) = 1
value = 9999

[State 705, Standing / Air]
type = reversaldef
trigger1 = !var(0)
trigger1 = anim = 705 || anim = 707
trigger1 = root, hitbyattr(SCA, AA, AP)
reversal.attr = SCA, AA
p1stateno = 706
pausetime = 0, 15
sparkno = -1
numhits = 0

[State 705, Crouching]
type = reversaldef
trigger1 = !var(0)
trigger1 = anim = 706
trigger1 = root, hitbyattr(SC, AA, AP); no air
reversal.attr = SC, AA
p1stateno = 706
pausetime = 0, 15
sparkno = -1
numhits = 0

[State 705, Disable]
type = reversaldef
trigger1 = var(0) = 1
reversal.attr =
pausetime = 0, 0
sparkno = -1
numhits = 0

[State 705, End]
type = destroyself
trigger1 = time >= 23
trigger2 = root, movetype != I
trigger3 = root, ctrl = 0
trigger3 = root, stateno != [700, 702] && root, stateno != 5120
trigger4 = root, stateno = [700, 702]
trigger4 = root, time <= 1


;----- Success -----
[Statedef 706]
movetype = I
ctrl = 0

[State 706, Disable]
type = varset
trigger1 = 1
var(0) = 1

[State 706, End]
type = destroyself
trigger1 = root, stateno = [700, 702]
trigger2 = time >= 2


;====================<DODGE>====================
[Statedef 710]
type = S
physics = S
movetype = I
anim = 710
ctrl = 0
velset = 0, 0
sprpriority = -2

[State Erase Inputs]
type = mapset
map = "cmd_erase_completed"
trigger1 = !AIlevel
trigger1 = time <= 0
value = 1
ignorehitpause = 1
persistent = 0

[State 710, Sound]
type = playsnd
trigger1 = animelem = 1
value = 3, ifelse(random < 500, 2, 3)
channel = 0

[State 710, Sound]
type = playsnd
trigger1 = animelem = 1
value = 1, 4
;channel = 1

[State 710, Push]
type = playerpush
trigger1 = 1
value = 0

[State 710, HB]
type = hitby
trigger1 = animtime != 0
value = SCA, AT
time = 1

[State 710, Attack]
type = changestate
trigger1 = !AIlevel
trigger1 = time = [15, 25]
trigger1 = command = "a" || command = "b" || command = "c" || command = "x" || command = "y" || command = "z"
value = ifelse((command = "a" || command = "b" || command = "c"), 241, 220)

[State 710, Attack]
type = changestate
trigger1 = AIlevel
trigger1 = time = [15, 25]
trigger1 = !inguarddist
trigger1 = p2dist y >= -60
trigger1 = abs(map(truebodydistx)) < 80
value = ifelse(abs(map(truebodydistx)) < 40, 241, 220)

[State 710, AI Guard]
type = assertinput
trigger1 = AIlevel
trigger1 = animtime = [-10, -1]
trigger1 = facing = 1
flag = L

[State 710, AI Guard]
type = assertinput
trigger1 = AIlevel
trigger1 = animtime = [-10, -1]
trigger1 = facing = -1
flag = R

[State 710, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;==========<FORWARD ROLL>==========
[Statedef 720]
type = S
physics = N
movetype = I
anim = 720
velset = 0, 0
ctrl = 0
sprpriority = 1

[State Erase Inputs]
type = mapset
map = "cmd_erase_completed"
trigger1 = !AIlevel
trigger1 = time <= 0
value = 1
ignorehitpause = 1
persistent = 0

[State 720, Sound]
type = playsnd
trigger1 = animelem = 2
value = 3, ifelse(random < 500, 2, 3)
channel = 0

[State 720, Sound]
type = playsnd
trigger1 = animelem = 3
value = 0, 102

[State 720, Vel]
type = velset
trigger1 = animelem = 3
x = 6.59

[State 720, Vel]
type = velset
trigger1 = animelem = 7
x = 0

[State 720, HB]
type = hitby
trigger1 = animelemtime(7) < 0
value = SCA, AT
time = 1

[State 720, Push]
type = playerpush
trigger1 = animelemtime(7) < 0
value = 0

[State 720, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;==========<BACKWARD ROLL>==========
[Statedef 725]
type = S
physics = N
movetype = I
anim = 725
velset = 0, 0
ctrl = 0
sprpriority = 1

[State Erase Inputs]
type = mapset
map = "cmd_erase_completed"
trigger1 = !AIlevel
trigger1 = time <= 0
value = 1
ignorehitpause = 1
persistent = 0

[State 725, Sound]
type = playsnd
trigger1 = animelem = 2
value = 3, ifelse(random < 500, 2, 3)
channel = 0

[State 725, Sound]
type = playsnd
trigger1 = animelem = 3
value = 0, 102

[State 725, Vel]
type = velset
trigger1 = animelem = 3
x = -4.94

[State 725, Vel]
type = velset
trigger1 = animelem = 7
x = 0

[State 725, HB]
type = hitby
trigger1 = animelemtime(7) < 0
value = SCA, AT
time = 1

[State 725, Push]
type = playerpush
trigger1 = animelemtime(7) < 0
value = 0

[State 725, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;==========<POWER CHARGE>==========
[Statedef 740]
type = S
physics = S
movetype = I
anim = 740
ctrl = 0
velset = 0, 0

[State Erase Inputs]
type = mapset
map = "cmd_erase_completed"
trigger1 = !AIlevel
trigger1 = time <= 0
value = 1
ignorehitpause = 1
persistent = 0

[State 740, Power]
type = poweradd
trigger1 = 1
value = 4 + ifelse(time < 60, 0, (time - 60) / 15)

[State 740, Sound]
type = playsnd
trigger1 = time = 8
value = 3, 1
channel = 0

[State 740, Flash]
type = palfx
trigger1 = 1
time = 1
add = 75 + ceil(sin(time / 6.0 * pi) * 75), 25 + ceil(sin(time / 6.0 * pi) * 25), 0

[State 740, FX]
type = helper
trigger1 = !numhelper(7240)
helpertype = normal
stateno = 7240
ID = 7240
name = "Power Charge"
postype = p1
pausemovetime = 65535
supermovetime = 65535
ownpal = 1

[State 740, FX]
type = helper
trigger1 = !numhelper(7241)
helpertype = normal
stateno = 7241
ID = 7241
name = "Particles"
postype = p1
pausemovetime = 65535
supermovetime = 65535
ownpal = 1

[State 740, End]
type = changestate
triggerall = time >= 24
trigger1 = power >= const(data.power) || power >= powermax || roundstate != 2
trigger2 = !AIlevel
trigger2 = command != "/b" || command != "/y"
trigger3 = AIlevel
trigger3 = inguarddist || p2bodydist x <= 120
trigger4 = AIlevel
trigger4 = p2movetype = A
trigger4 = p2stateno = [3000, 4999] || (p2, vel x * p2, facing * facing) < -1
value = 741


;----- END -----
[Statedef 741]
type = S
physics = S
movetype = I
anim = 741
velset = 0, 0
ctrl = 0

[State 741, Sound]
type = stopsnd
trigger1 = !time
channel = 0

[State 741, Sound]
type = playsnd
trigger1 = !time
trigger1 = power >= const(data.power)
value = 4, 0
channel = 0

[State 741, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;==========<GUARD CANCEL>==========
[Statedef 750]
type = S
physics = S
movetype = I
anim = 750
ctrl = 0
velset = 0, 0
poweradd = -1000
sprpriority = 2
facep2 = 1

[State 750, ECreset]
type = palfx
trigger1 = map(customcombo) > 0
trigger1 = map(customcombo) := -1
time = 1

[State 750, Strength]
type = mapset
trigger1 = !time
trigger1 = !AIlevel
map = "strength"
value = ifelse((command = "counter_a" + command = "counter_b" + command = "counter_c") >= 2, 1, 0)
ignorehitpause = 1

[State 750, Strength AI]
type = mapset
trigger1 = !time
trigger1 = AIlevel
map = "strength"
value = ifelse((p2statetype = A), 0, ifelse((p2statetype = C), 1, ifelse(random < 500, 0, 1)))
ignorehitpause = 1

[State 750, Sound]
type = playsnd
trigger1 = !time
value = 3, 2
channel = 0

[State 750, Flash]
type = palfx
trigger1 = !time
add = 255, 255, 255
time = 5

[State 750, Super Pause FX]
type = helper
trigger1 = !time
helpertype = normal
stateno = 7250
ID = 7250
postype = p1
pos = ceil(29 * const(size.xscale)), -76
ownpal = 1
persistent = 0
supermovetime = 999

[State 750, superchargepause]
type = superpause
trigger1 = !time
time = 10
movetime = 10
anim = -1
sound = s7, 1
darken = 0

[State 750, Guard Points]
type = guardpointsadd
trigger1 = !time
value = -min((guardpoints - 1), 300)

[State 750, End]
type = changestate
trigger1 = time >= 15
value = ifelse(map(strength) = 1, 2910, 2900)


;====================<CUSTOM COMBO>====================
;----- GROUND -----
[Statedef 760]
type = S
physics = S
movetype = A
anim = 760
velset = 0, 0
ctrl = 0
sprpriority = 2
poweradd = -2000

[State 760, NHB]
type = nothitby
trigger1 = 1
value = SCA
time = 8

[State 760, Freeze]
type = posfreeze
trigger1 = 1
value = 1

[State 760, Var]
type = mapset
trigger1 = time >= 4
map = "customcombo"
value = 300

[State 760, Sound]
type = playsnd
trigger1 = time = 4
value = 4, 0
channel = 0

[State 760, Superpause FX]
type = helper
trigger1 = time = 4
helpertype = normal
stateno = 7260
ID = 7260
name = "Custom Combo Startup"
postype = p1
pos = ceil(24 * const(size.xscale)), -98
supermovetime = 255
size.xscale = 1
size.yscale = 1
ownpal = 1

[State 760, Super Pause]
type = superpause
trigger1 = time = 4
time = 30
movetime = 30
anim = -1
sound = s7, 2
p2defmul = 1
darken = 0

[State 760, Afterimage]
type = afterimage
trigger1 = !animtime
time = 2
timegap = 1
framegap = 4
length = 13
palbright = 0, 0, 0
palcontrast = 64, 128, 192
palpostbright = 0, 0, 0
paladd = 0, 0, 0
palmul = 0.75, 0.75, 0.75
trans = add1

[State 760, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;----- AIR -----
[Statedef 765]
type = A
physics = N
movetype = A
anim = 765
ctrl = 0
sprpriority = 2
poweradd = -2000

[State 765, NHB]
type = nothitby
trigger1 = 1
value = SCA
time = 8

[State 765, Var]
type = mapset
trigger1 = time >= 4
map = "customcombo"
value = 300

[State 765, Sound]
type = playsnd
trigger1 = time = 4
value = 4, 0
channel = 0

[State 765, Superpause FX]
type = helper
trigger1 = time = 4
helpertype = normal
stateno = 7260
ID = 7260
name = "Custom Combo Startup"
postype = p1
pos = ceil(11 * const(size.xscale)), -70
supermovetime = 255
size.xscale = 1
size.yscale = 1
ownpal = 1

[State 765, Super Pause]
type = superpause
trigger1 = time = 4
time = 30
movetime = 30
anim = -1
sound = s7, 2
p2defmul = 1
darken = 0

[State 765, Afterimage]
type = afterimage
trigger1 = !animtime
time = 2
timegap = 1
framegap = 4
length = 13
palbright = 0, 0, 0
palcontrast = 64, 128, 192
palpostbright = 0, 0, 0
paladd = 0, 0, 0
palmul = 0.75, 0.75, 0.75
trans = add1

[State 765, End]
type = changestate
trigger1 = !animtime
value = 766
ctrl = 1

[State 765, Freeze]
type = posfreeze
trigger1 = 1
value = 1


[Statedef 766]
type = A
physics = N
movetype = I
anim = 766
ctrl = 1

[State 766, Accel]
type = gravity
trigger1 = 1

[State 766, Land]
type = changestate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 52


;==========<TAUNT>==========
[Statedef 195]
type = S
movetype = I
physics = S
anim = 195
velset = 0, 0
sprpriority = 0
ctrl = 0

[State 195, Give power]
redirectID = p2, ID
type = poweradd
trigger1 = time = 1
trigger1 = numenemy
value = min(ceil(p2, powermax / 9.0), 334)

[State 195, Type]
type = statetypeset
trigger1 = animelem = 4
movetype = A

[State 195, Type]
type = statetypeset
trigger1 = animelem = 6
movetype = I

[State 195, Hit]
type = hitdef
trigger1 = animelem = 5
attr = S, SA
damage = 7, 0
animtype = Light
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 6, 6
sparkno = -1 + 0 * (map(sparkno) := ifelse(map(cfg_sparks) = 2, 8013, 8010))
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 10) * (map(sparkx.max) := 30), map(sparky) := -44
hitsound = s2, 1
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.slidetime = 12
ground.hittime = 1 + 12
ground.velocity = -4.49, 0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 10
guard.ctrltime = 1 + 10
guard.slidetime = 10
getpower = ifelse(movehit, 25, 100) * map(meterscaling), ifelse(moveguarded, 25, 50) * map(meterscaling)
givepower = 40, 40
p1sprpriority = sprpriority

[State 195, Sprite Priority]
type = sprpriority
trigger1 = animelem = 3
value = -1

[State 195, Sound]
type = playsnd
trigger1 = animelem = 4
value = 1, 1
;channel = 1

[State 195, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;==========<LOSE (Time over)>==========
[Statedef 170]
type = S
ctrl = 0
anim = 170
velset = 0, 0

[State 170, NHB]
type = nothitby
trigger1 = 1
value = SCA
time = 1


;==========<DRAWGAME (Time over)>==========
[Statedef 175]
type = S
ctrl = 0
velset = 0, 0

[State 175, End]
type = changestate
trigger1 = 1
value = 170


;==========<INITIALIZE>==========
;----- Before Config -----
[Statedef 5900]
type = S
anim = 9999

[State 5900, Var Reset]
type = varrangeset
trigger1 = !roundsexisted
value = 0

[State 5900, Var Reset]
type = varrangeset
trigger1 = !roundsexisted
fvalue = 0

[State 5900, Palette]
type = remappal
trigger1 = 1
source = 1, 1
dest = 1, palno

[State 5900, End]
type = changestate
trigger1 = time > 0; Wait for enemy to be loaded
value = 5901; Config


;----- After Config -----
[Statedef 5902]
type = S

[State 5902, Turns Intro]
type = changestate
trigger1 = !time
trigger1 = teammode = turns
trigger1 = !roundsexisted && roundno >= 2
value = ifelse(random < 500, 192, 193)

[State 5902, End]
type = changestate
trigger1 = !time
value = ifelse(roundno = 1, 190, 0)


;==========<PREINTRO>==========
[Statedef 190]
type = S
ctrl = 0
velset = 0, 0

[State 190, Oil Drums Intro]
type = changestate
triggerall = numenemy
triggerall = !numpartner
triggerall = !roundsexisted || !(enemy, roundsexisted)
trigger1 = enemy, name = "Guy" || enemy, name = "cvsguy"
trigger2 = enemy, name = "Cody" || enemy, name = "Cody Travers" || enemy, name = "cvscody"
trigger3 = enemy, name = "Haggar" || enemy, name = "Mike Haggar"
trigger4 = enemy, name = "Maki Genryusai" || enemy, name = "cvsmaki"
trigger5 = enemy, name = "Lucia" || enemy, name = "Lucia Morgan"
trigger6 = enemy, name = "Sodom"
trigger7 = enemy, name = "Rolento" || enemy, name = "Rolento F. Schugerg" || enemy, name = "Rolento Schugerg" || enemy, name = "cvsrolento"
trigger8 = enemy, name = "Hugo" || enemy, name = "svchugo"
trigger9 = enemy, name = "Poison"
trigger10 = enemy, name = "Abigail"
trigger11 = enemy, name = "El Gado"
value = 189

[State 190, Oil Drums Intro]
type = changestate
trigger1 = command = "holdup"
;trigger1 = command = "holdfwd" && command = "holdback"
value = 189

[State 190, Waiting Intro]
type = changestate
trigger1 = random < 333
trigger1 = enemy, name != "Guy" || enemy, authorname != "Phantom.of.the.Server" || enemy, stateno != 191; no duplicate intro just in case
trigger1 = enemy, name != "AOF2 Strength Training" && p4name != "AOF2 Strength Training"
value = 191

[State 190, Intro]
type = changestate
trigger1 = 1
value = ifelse(random < 500, 192, 193)


;==========<INTRO 1 - WAITING>==========
[Statedef 191]
type = S
anim = 191

[State 191, Intro]
type = assertspecial
trigger1 = 1
flag = intro

[State 191, Wait]
type = assertspecial
trigger1 = roundstate = 0
flag = animfreeze

[State 191, End]
type = changeanim
trigger1 = time <= 300
trigger1 = animelemtime(2) >= 0 && animelemtime(3) < 0
trigger1 = p2stateno >= 180
value = 191
elem = 2

[State 191, End]
type = changestate
trigger1 = !animtime
value = 0


;==========<INTRO 2 - RUNNING>==========
[Statedef 192]
type = S
physics = N
anim = 192

[State 192, Intro]
type = assertspecial
trigger1 = 1
flag = intro

[State 192, Wait]
type = assertspecial
trigger1 = roundstate = 0
flag = animfreeze

[State 192, Camera]
type = helper
trigger1 = !time
trigger1 = !numhelper(8999)
helpertype = normal
stateno = 8999
ID = 8999
name = "Camera"
postype = p1
pos = 0, 0
facing = 1

[State 192, Bound]
type = screenbound
trigger1 = 1
value = 0

[State 192, Pos]
type = posadd
trigger1 = !time
x = -320

[State 192, Vel]
type = velset
trigger1 = roundstate != 0
persistent = 0
x = 8

[State 192, Vel]
type = velset
trigger1 = animelem = 15
x = 0

[State 192, Afterimage]
type = explod
trigger1 = animelemtime(15) < 0
ID = 1500
postype = p1
pos = 0, 0
sprpriority = sprpriority - 1
anim = anim
animfreeze = 1
animelem = animelemno(0)
removetime = 12
trans = addalpha
alpha = 256, 0
scale = const(size.xscale), const(size.yscale)
interpolation.time = 12
interpolation.alpha = 0, 256
removeonchangestate = 1
ownpal = 1

[State 192, Steps]
type = playsnd
trigger1 = roundstate != 0
trigger1 = animelem = 1 || animelem = 7 || animelem = 13
value = 0, 103

[State 192, Steps]
type = playsnd
trigger1 = roundstate != 0
trigger1 = animelem = 4 || animelem = 10
value = 0, 106

[State 192, Dust]
type = explod
triggerall = roundstate != 0
trigger1 = animelem = 1 || animelem = 7 || animelem = 13
trigger2 = animelem = 4 || animelem = 10
anim = 7101
ID = 7101
sprpriority = 3
postype = p1
pos = ceil(-55 * const(size.xscale)), 0
scale = 0.5, 0.5
ownpal = 1

[State 192, Sound]
type = playsnd
trigger1 = animelem = 15
value = 4, 0
channel = 0

[State 192, Pos]
type = posset
trigger1 = animelem = 15
x = helper(8999), pos x

[State 192, End]
type = changestate
trigger1 = !animtime
value = 0

[State 192, Afterimage]
type = afterimagetime
trigger1 = 1
time = 2
ignorehitpause = 1


;==========<INTRO 3 - KICKING>==========
[Statedef 193]
type = A
physics = N
anim = 193

[State 193, Intro]
type = assertspecial
trigger1 = 1
flag = intro

[State 193, Wait]
type = assertspecial
trigger1 = roundstate = 0
flag = animfreeze

[State 193, Camera]
type = helper
trigger1 = !numhelper(8999)
helpertype = normal
stateno = 8999
ID = 8999
name = "Camera"
postype = p1
pos = 0, 0
facing = 1

[State 193, Bound]
type = screenbound
trigger1 = 1
value = 0

[State 193, Pos]
type = posadd
trigger1 = !time
x = -240
y = -40

[State 193, Vel]
type = velmul
trigger1 = animelemtime(2) >= 0 && animelemtime(5) < 0
x = 0.92

[State 193, Vel]
type = velset
trigger1 = roundstate != 0
persistent = 0
x = 5
y = -1

[State 193, Accel]
type = veladd
trigger1 = animelemtime(2) >= 0 && animelemtime(5) < 0
y = 0.6

[State 193, Sound]
type = playsnd
trigger1 = roundstate != 0
value = 3, 7
channel = 0
persistent = 0

[State 193, barrel]
type = helper
trigger1 = roundstate != 0
helpertype = normal
stateno = 6000
ID = 6000
name = "Barrel"
postype = p1
pos = 88, -60
persistent = 0

[State 193, barrel]
type = helper
trigger1 = roundstate != 0
helpertype = normal
stateno = 6001
ID = 6000
name = "Barrel"
postype = p1
pos = 88, -50
persistent = 0

[State 193, Sound]
type = playsnd
trigger1 = roundstate != 0
value = 5, 4
persistent = 0

[State 193, Pos]
type = posset
trigger1 = animelem = 5
x = helper(8999), pos x
y = 0

[State 193, Vel]
type = velset
trigger1 = animelem = 5
x = 0
y = 0

[State 193, Sound]
type = playsnd
trigger1 = animelem = 5
value = 0, 52

[State 193, Dust]
type = explod
trigger1 = animelem = 5
anim = 7102
ID = 7102
sprpriority = -2
postype = p1
scale = 0.5, 0.5
ownpal = 1

[State 193, End]
type = changestate
trigger1 = !animtime
value = 0


;==========<INTRO vs FINAL FIGHT>==========
[Statedef 189]
type = A
physics = N
anim = 189

[State 189, Intro]
type = assertspecial
trigger1 = 1
flag = intro

[State 189, Camera]
type = helper
trigger1 = !numhelper(8999)
helpertype = normal
stateno = 8999
ID = 8999
name = "Camera"
postype = p1
pos = 0, 0
facing = 1

[State 189, Bound]
type = screenbound
trigger1 = 1
value = 0
movecamera = 0, 0

[State 189, Pos]
type = posadd
trigger1 = !time
x = -28

[State 189, Oil Drums]
type = helper
trigger1 = !(time % 8)
trigger1 = time <= 48 && numhelper(6010) < 7
helpertype = normal
stateno = 6010
ID = 6011 + floor(time / 8.0)
name = "Oil Drum"
postype = p1
pos = 0, 0
ownpal = 1

[State 189, Drum Land]
type = playsnd
trigger1 = time = 36 || time = 44 || time = 52 || time = 60 || time = 68 || time = 76 || time = 84
value = 5, 7
channel = 5

[State 189, Vel]
type = velset
trigger1 = animelem = 4
y = -2

[State 189, Accel]
type = veladd
trigger1 = animelemtime(4) > 0 && animelemtime(11) < 0
y = 0.0625

[State 189, Vel]
type = velset
trigger1 = animelem = 11
y = 0

[State 189, Pos]
type = posset
trigger1 = animelem = 11
y = -33

[State 189, Accel]
type = veladd
trigger1 = animelemtime(25) >= 0 && animelemtime(28) < 0
y = 0.2

[State 189, Pos]
type = posset
trigger1 = animelem = 28
y = 0

[State 189, Vel]
type = velset
trigger1 = animelem = 28
x = 0
y = 0

[State 189, Vel]
type = velset
trigger1 = animelem = 30
x = 1.56
y = 0

[State 189, Sound]
type = playsnd
trigger1 = animelem = 3
value = 3, 7
channel = 0

[State 189, Sound]
type = playsnd
trigger1 = animelem = 5 || animelem = 9
trigger2 = animelem = 7 || animelem = 11
value = 2, 6
channel = 2

[State 189, Sound]
type = playsnd
trigger1 = animelem = 13
value = 5, 4
channel = 2

;[State 189, Spark]
;in ZSS

[State 189, Food]
type = explod
trigger1 = time = 60
anim = 6020
ID = 6020
postype = p1
pos = ceil(50 * const(size.xscale)), 0
facing = facing
scale = 0.8333, 1
removetime = 205
sprpriority = 2
ownpal = 1

[State 189, Food]
type = explod
trigger1 = !animtime
anim = 6021
ID = 6021
postype = back
pos = 20, 40
facing = facing
removetime = 60
sprpriority = 2
ownpal = 1

[State 189, Food]
type = explod
trigger1 = !animtime
anim = 6022
ID = 6022
postype = back
pos = 64, 40
facing = facing
removetime = 60
sprpriority = 2
ownpal = 1

[State 189, Sound]
type = playsnd
trigger1 = animelem = 28
value = 0, 52

[State 189, Dust]
type = explod
trigger1 = animelem = 28
anim = 7102
ID = 7102
sprpriority = -2
postype = p1
scale = 0.5, 0.5
ownpal = 1

[State 189, Vel]
type = velset
trigger1 = !animtime
x = 0

[State 189, Pos]
type = posset
trigger1 = !animtime
x = helper(8999), pos x
y = 0

[State 189, End]
type = changestate
trigger1 = !animtime
value = 0


;====================<WIN POSE DECIDER>====================
[Statedef 180]
type = S
ctrl = 0
velset = 0, 0

[State 180, Quote]
type = victoryquote
trigger1 = 1
value = randomrange(1, 12)

[State 180, Quote]
type = victoryquote
triggerall = numenemy
trigger1 = enemynear, name = "Cody" || enemynear, name = "Cody Travers"
trigger2 = enemynear, name = "cvscody"
value = 50

[State 180, win BMR]
type = changestate
trigger1 = prevstateno = 4090
value = 4090

[State 180, winspecial]
type = changestate
trigger1 = matchover
trigger1 = command = "/s" || random < 250
value = 187

[State 180, winxa]
type = changestate
trigger1 = (command = "/a" || command = "/x")
value = 181

[State 180, winyb]
type = changestate
trigger1 = (command = "/b" || command = "/y")
value = 182

[State 180, winzc]
type = changestate
trigger1 = (command = "/c" || command = "/z")
value = 183

[State 180, win1]
type = changestate
trigger1 = 1
value = ifelse(random < 333, 181, ifelse(random < 500, 182, 183))


;==========<WIN 1>==========
[Statedef 181]
type = S
anim = 181
ctrl = 0
velset = 0, 0

[State 181, Wait]
type = assertspecial
trigger1 = time < 300
flag = roundnotover

[State 181, Pos]
type = posset
trigger1 = pos y
y = 0


;==========<WIN 2>==========
[Statedef 182]
type = S
anim = 182
ctrl = 0
velset = 0, 0

[State 182, Wait]
type = assertspecial
trigger1 = time < 300
flag = roundnotover

[State 182, Pos]
type = posset
trigger1 = pos y
y = 0

[State 182, Sprite Priority]
type = sprpriority
trigger1 = animelemtime(2) >= 0
value = -1

[State 182, Sound]
type = playsnd
trigger1 = animelem = 4
value = 4, 3
channel = 0

[State 182, Sound]
type = playsnd
trigger1 = animelem = 4
value = 1, 1
;channel = 1
volumescale = 80


;==========<WIN 3>==========
[Statedef 183]
type = S
anim = 183
ctrl = 0
velset = 0, 0

[State 183, Wait]
type = assertspecial
trigger1 = time < 300
flag = roundnotover

[State 183, Pos]
type = posset
trigger1 = pos y
y = 0

[State 183, Sound]
type = playsnd
trigger1 = animelem = 4
value = 4, 2
channel = 0
persistent = 0


;==========<WIN 4>==========
[Statedef 187]
type = S
ctrl = 0
velset = 0, 0

[State 187, Assert]
type = assertspecial
trigger1 = time <= 180
trigger2 = frontedgedist > -40
flag = roundnotover

[State 187, Anim]
type = changeanim
trigger1 = time < 60 && anim
value = 0

[State 187, Anim]
type = changeanim
trigger1 = time >= 60 && anim != 187
value = 187

[State 187, Camera]
type = helper
trigger1 = time
trigger1 = !numhelper(8999)
helpertype = normal
stateno = 8999
ID = 8999
name = "Camera"
postype = p1
pos = 0, 0
facing = 1

[State 187, Bound]
type = screenbound
trigger1 = time
trigger1 = anim = 187
value = 0

[State 187, Pos]
type = posset
trigger1 = pos y
y = 0

[State 187, Vel]
type = velset
trigger1 = anim = 187
x = 0.75 * const(velocity.walk.fwd.x)

[State 187, pointer]
type = helper
trigger1 = time = 5
helpertype = normal
stateno = 6005
ID = 6005
name = "GO!"
postype = p1
facing = 1
size.xscale = 1
size.yscale = 1


;==========<WIN by B.M.R.>==========
[Statedef 4090]
type = S
ctrl = 0
velset = 0, 0
sprpriority = 0

[State 4090, Anim]
type = changeanim
trigger1 = anim != 4090
value = 4090

[State 4090, Wait]
type = assertspecial
trigger1 = time < 300
flag = roundnotover

[State 4090, Pos]
type = posset
trigger1 = !time
y = 0

[State 4090, Freeze Anim]
type = changeanim
trigger1 = roundstate = 3
trigger1 = animelemtime(4) >= 0
trigger1 = animelemtime(5) < 0
value = 4090
elem = 4

[State 4090, Sprite Priority]
type = sprpriority
trigger1 = animelemtime(3) >= 0
value = -1

[State 4090, Sound]
type = playsnd
trigger1 = animelem = 5
value = 1, 1
;channel = 1

[State 4090, Sound]
type = playsnd
trigger1 = animelem = 6
value = 4, 3
channel = 0

[State 4090, Sound]
type = playsnd
trigger1 = !time
trigger1 = prevstateno = 4010
value = 0, 52

[State 4090, Dust]
type = explod
trigger1 = !time
trigger1 = prevstateno = 4010
anim = 7102
sprpriority = -5
postype = p1
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 4090, Allow Round End]
type = ctrlset
trigger1 = time >= 120
trigger1 = roundstate = [2, 3]
trigger1 = time > (fightscreenvar(round.over.hittime) + fightscreenvar(round.over.waittime) + fightscreenvar(round.over.wintime))
value = 1


;==========<CONTINUE?>==========
[Statedef 5500]
type = S
ctrl = 0
velset = 0, 0

[State 5500, Anim]
type = changeanim
trigger1 = !time
value = 5500


;==========<FALL RECOVERY>==========
[Statedef 5200]
type = A
physics = N
movetype = H

[State 5200, Anim]
type = changeanim
trigger1 = anim = 5035
trigger1 = !animtime
value = 5050

[State 5200, Accel]
type = veladd
trigger1 = time > 0
y = max(0.35, gethitvar(yaccel))

[State 5200, End]
type = selfstate
trigger1 = vel y > 0
trigger1 = pos y >= const(movement.air.gethit.groundrecover.groundlevel)
value = 5201


[Statedef 5201]
type = S
physics = N
movetype = I
anim = 5200
ctrl = 0
facep2 = 1

[State 5201, Pos]
type = posset
trigger1 = 1
y = 0

[State 5201, Vel]
type = velset
trigger1 = !time
x = -8
y = 0

[State 5201, Vel]
type = velmul
trigger1 = 1
x = 0.9

[State 5201, Sound]
type = playsnd
trigger1 = animelem = 1
value = 3, 2
channel = 0

[State 5201, Sound]
type = playsnd
trigger1 = !time
value = 0, 5200

[State 5201, Flash]
type = palfx
trigger1 = !time
add = 255, 255, 255
sinadd = -255, -255, -255, 20
time = 5

[State 5201, FX]
type = explod
trigger1 = !time
ID = 8200
anim = 8200
postype = p1
pos = 0, ceil(-16 * const(size.yscale))
pausemovetime = -1
supermovetime = -1
ownpal = 1
ontop = 1

[State 5201, NHB]
type = nothitby
trigger1 = 1
value = SCA
time = 1

[State 5201, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


[Statedef 5210]
type = A
physics = N
movetype = I
anim = 5210
ctrl = 0

[State 5210, Sound]
type = playsnd
trigger1 = !time
value = 3, 2
channel = 0

[State 5210, Sound]
type = playsnd
trigger1 = !time
value = 0, 5200

[State 5210, Flash]
type = palfx
trigger1 = !time
add = 255, 255, 255
sinadd = -255, -255, -255, 20
time = 5

[State 5210, FX]
type = explod
trigger1 = !time
ID = 8200
anim = 8200
postype = p1
pos = 0, ceil(-74 * const(size.yscale))
pausemovetime = -1
supermovetime = -1
ownpal = 1
ontop = 1

[State 5210, Accel]
type = veladd
trigger1 = 1
y = const(movement.air.gethit.airrecover.yaccel)

[state 5210, Vel]
type = velmul
trigger1 = !time
x = const(velocity.air.gethit.airrecover.mul.x)
y = const(velocity.air.gethit.airrecover.mul.y)

[state 5210, Vel]
type = veladd
trigger1 = !time
x = const(velocity.air.gethit.airrecover.add.x)
y = const(velocity.air.gethit.airrecover.add.y)

[state 5210, Up]
type = veladd
trigger1 = !time
trigger1 = command = "holdup"
y = const(velocity.air.gethit.airrecover.up)

[state 5210, Down]
type = veladd
trigger1 = !time
trigger1 = command = "holddown"
y = const(velocity.air.gethit.airrecover.down)

[state 5210, Forward]
type = veladd
trigger1 = !time
trigger1 = command = "holdfwd"
x = const(velocity.air.gethit.airrecover.fwd)

[state 5210, Back]
type = veladd
trigger1 = !time
trigger1 = command = "holdback"
x = const(velocity.air.gethit.airrecover.back)

[State 5210, Turn]
type = turn
trigger1 = !time
trigger1 = p2dist x < 0

[State 5210, NHB]
type = nothitby
trigger1 = time < 14
value = SCA
time = 1

[State 5210, Ctrl]
type = ctrlset
trigger1 = time >= 14
value = 1

[State 5210, Land]
type = changestate
trigger1 = vel y > 0
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 52


;==========<RECOVERY ROLL>==========
[Statedef 5220]
type = A
physics = N
movetype = H

[State 5220, Anim]
type = changeanim
trigger1 = anim = 5035
trigger1 = !animtime
value = 5050

[State 5220, Accel]
type = veladd
trigger1 = 1
y = max(0.35, gethitvar(yaccel))

[State 5220, End]
type = selfstate
trigger1 = vel y > 0
trigger1 = pos y >= const(movement.air.gethit.groundrecover.groundlevel)
value = 5221


[Statedef 5221]
type = S
physics = N
movetype = I
anim = 5220
ctrl = 0
velset = 0, 0
sprpriority = 1
facep2 = 1

[State 5221, Push]
type = playerpush
trigger1 = 1
value = 0

[State 5221, Pos]
type = posset
trigger1 = 1
y = 0

[State 5221, Vel]
type = velset
trigger1 = time = 10
x = 6.15

[State 5221, End]
type = changestate
trigger1 = time >= 29 && command != "holdfwd"
trigger2 = time >= 48
value = 11
ctrl = 1


;====================<CHEAP K.O.>====================
[Statedef 5950]
type = S
movetype = H
physics = S
anim = 5950
velset = 0, 0

[State 5950, NHB]
type = nothitby
trigger1 = 1
value = SCA

[State 5950, Pos]
type = posset
trigger1 = 1
y = 0

[State 5950, Assert]
type = assertspecial
trigger1 = 1
flag = nokosnd
flag2 = nomakedust
flag3 = sizepushonly; because anim has no Clsn2

[State 5950, KO Snd]
type = stopsnd
trigger1 = !time
trigger1 = !alive
channel = 0

[State 5950, KO Snd]
type = playsnd
trigger1 = animelem = 2
trigger1 = !alive
value = 11, 1

[State 5950, Pos]
type = posadd
trigger1 = animelem = 7
x = -8 * const(size.xscale)

[State 5950, Sound]
type = playsnd
trigger1 = animelem = 11
value = F 7, 0

[State 5950, FX]
type = explod
trigger1 = animelem = 11
anim = F 60
postype = p1
pos = 0, 0
ownpal = 1
sprpriority = -10

[State 5950, End]
type = changestate
trigger1 = !animtime
value = ifelse(alive, 5110, 5150)


;========================<TARGET OTG OVERRIDE>========================
[Statedef 1115080]
type = L
physics = N
movetype = H
velset = 0, 0

[State 1115080, Pos]
type = posset
trigger1 = 1
y = 0

[State 1115080, Anim]
type = changeanim
trigger1 = 1
value = 5080

[State 1115080, End]
type = changestate
trigger1 = hitshakeover
value = 1115081


[Statedef 1115081]
type = L
physics = C
movetype = H
velset = 0, 0

[State 1115081, Var]
type = varset
trigger1 = !time
sysvar(0) = 1

[State 1115081, End]
type = selfstate
trigger1 = time >= 18
value = 5110


;==================================================================================================
;===========================================<STATE -2>=============================================
;==================================================================================================
[Statedef -2]

[State -2, Throw in Front]
type = null
trigger1 = 1 || map(grabbehind) := 0
trigger1 = p2dist x < 0
trigger1 = p2dist x < ifelse((facing = p2, facing), -(p2, const(size.ground.front)), -(p2, const(size.ground.back)))
trigger1 = map(grabbehind) := 1
ignorehitpause = 1

[State -2, Unthrowable Flag]
type = mapadd
trigger1 = map(unthrowable) > 0
trigger1 = numenemy
trigger1 = p2stateno != 52 || p2, ctrl || p2, time >= 6
map = "unthrowable"
value = -1
ignorehitpause = 1

[State -2, Unthrowable Flag - Jump Start]
type = mapset
trigger1 = numenemy
trigger1 = p2stateno = 40
trigger1 = p2movetype = I
trigger1 = p2, time < 10
map = "unthrowable"
value = 1
ignorehitpause = 1

[State -2, Unthrowable Flag - Hurt]
type = mapset
triggerall = p2, ctrl = 0
triggerall = p2, anim != 5300
triggerall = p2stateno != p2, const(statedizzy)
trigger1 = p2stateno = [150, 155]
trigger2 = p2stateno = 5120; Just in case
trigger3 = p2stateno = 5201
trigger4 = p2movetype = H
trigger4 = p2statetype != A
trigger4 = !map(customcombo)
trigger5 = p2movetype = H
trigger5 = p2statetype = A
trigger5 = p2, hitfall = 0
map = "unthrowable"
value = 3
ignorehitpause = 1

[State -2, Juggle Increase]
type = null; mapadd
trigger1 = movehit = 1
trigger1 = numtarget
trigger1 = target, gethitvar(frame)
trigger1 = target, hitfall
trigger1 = target, movetype = H
trigger1 = target, gethitvar(ID) = ID
map = "juggle_count"
value = 1
ignorehitpause = 1

[State -2, Juggle Reset]
type = null; mapset
triggerall = map(juggle_count)
triggerall = p2, time >= 1
trigger1 = p2movetype != H
trigger2 = p2, hitfall = 0
trigger3 = p2statetype = S || p2statetype = C
trigger4 = p2statetype = L && p2, pos y = 0 && p2, vel y = 0
trigger5 = p2stateno = [120, 155] || p2stateno = 5201 || p2stateno = 5210
trigger6 = moveguarded = 1 || movereversed = 1
trigger7 = roundstate != 2
trigger8 = p2, ctrl
map = "juggle_count"
value = 0
ignorehitpause = 1

[State -2, Reset Combo Limits]
type = null
trigger1 = numenemy
trigger1 = p2, time > 0
trigger1 = p2movetype != H || p2stateno = p2, const(statedizzy)
trigger1 = map(jugglereset) || map(wallbounce)
trigger1 = 1 || map(jugglereset) := 0
trigger1 = 1 || map(wallbounce) := 0
ignorehitpause = 1

[State -2, Custom Combo End]
type = mapset
triggerall = map(customcombo) != 0
trigger1 = map(customcombo) < 0
trigger2 = standby
trigger3 = movetype = H
trigger4 = roundstate != 2
trigger5 = stateno = [3000, 4999]
map = "customcombo"
value = 0
ignorehitpause = 1

[State -2, Custom Combo Timer]
type = mapadd
trigger1 = map(customcombo) > 0
map = "customcombo"
value = -1
ignorehitpause = 1

[State -2, Custom Combo Disable Guard]
type = assertspecial
trigger1 = map(customcombo) > 0
flag = nostandguard
flag2 = nocrouchguard
flag3 = noairguard
ignorehitpause = 1

[State -2, Custom Combo PalFX]
type = palfx
trigger1 = map(customcombo) > 60
time = 2
add = 24 + ceil(sin(map(customcombo) / 16.0 * pi) * 24), 24 + ceil(sin(map(customcombo) / 16.0 * pi) * 24), 24 + ceil(sin(map(customcombo) / 16.0 * pi) * 24)
ignorehitpause = 1

[State -2, Custom Combo PalFX]
type = palfx
trigger1 = map(customcombo) = [1, 60]
trigger1 = !(gametime % 4)
time = 2
add = 0, 96, 256
ignorehitpause = 1

[State -2, Damage Scaling - Reset]
type = null
trigger1 = p2movetype != H
trigger1 = p2, dizzy = 0
trigger1 = p2stateno != p2, const(statedizzy)
trigger1 = 1 || map(combototal) := 0
trigger1 = 1 || map(combocheck) := 0
ignorehitpause = 1

[State -2, Damage Scaling - Attack Connected Flag]
type = mapset
trigger1 = movecontact = 1
trigger1 = hitcount <= 1
map = "combocheck"
value = 1
ignorehitpause = 1

[State -2, Damage Scaling - Base Formula]
type = mapset
trigger1 = 1
map = "damagescaling"
value = ifelse(map(combototal) <= 0, 1, ifelse(map(combototal) >= 9, 0.1, 1 - 0.1 * map(combototal)))
ignorehitpause = 1

[State -2, Damage Scaling - Custom Combo Calculation]
type = null
trigger1 = map(customcombo_p2life) < p2, life
trigger1 = map(customcombo_p2life) := p2, life
trigger2 = !map(customcombo)
trigger2 = map(customcombo_p2life) := p2, life
trigger3 = map(customcombo)
trigger3 = map(customcombo_damage) := (map(customcombo_p2life) - p2, life)
ignorehitpause = 1

[State -2, Damage Scaling - Custom Combo]
type = mapset
trigger1 = map(customcombo)
trigger1 = numenemy
map = "damagescaling"
value = max(0.1, ifelse(map(customcombo_damage) <= 0, 1.0, ifelse(map(customcombo_damage) >= 450, 0.1, (500 - map(customcombo_damage)) / 500.0)) * 0.75)
ignorehitpause = 1

[State -2, Damage Scaling - Minimum Super Damage]
type = null
triggerall = stateno = [3000, 4999]
;Level 3
trigger1 = map(superlevel) = 3
trigger1 = map(damagescaling) < 0.5
trigger1 = 1 || map(damagescaling) := 0.5
;Level 2
trigger2 = map(superlevel) = 2
trigger2 = map(damagescaling) < 0.4
trigger2 = 1 || map(damagescaling) := 0.4
;Other
trigger3 = stateno = [3000, 4999]
trigger3 = map(damagescaling) < 0.3
trigger3 = 1 || map(damagescaling) := 0.3
ignorehitpause = 1

[State -2, Meter Scaling]
type = null
trigger1 = map(customcombo)
trigger1 = 1 || map(meterscaling) := 0
trigger2 = !map(customcombo)
trigger2 = 1 || map(meterscaling) := map(damagescaling)
ignorehitpause = 1

[State -2, Damage Scaling - Override Fall Defense Bonus]
redirectID = p2, ID
type = assertspecial
trigger1 = numenemy
trigger1 = p2movetype = H
trigger1 = p2, gethitvar(playerno) = playerno
flag = nofalldefenceup
ignorehitpause = 1

[State -2, Damage Scaling - Long Combo Guts]
type = mapset
trigger1 = numenemy
trigger1 = p2, receiveddamage >= (p2, lifemax * 0.50)
map = "damagescaling"
value = map(damagescaling) * ifelse(p2, receiveddamage >= (p2, lifemax * 0.85), 0.75, ifelse(p2, receiveddamage >= (p2, lifemax * 0.70), 0.90, 0.95))
ignorehitpause = 1

[State -2, Damage Scaling - Root Multiplier]
type = attackmulset
trigger1 = 1
value = map(damagescaling); * ifelse(map(counterhit_buffer), 1.2, 1)
ignorehitpause = 1

[State -2, Drop Target]
type = targetdrop
triggerall = numtarget = 1
triggerall = target, time > 0
trigger1 = target, stateno = 5040
trigger2 = target, stateno = 5201
trigger3 = target, movetype != H
trigger3 = target, movereversed = 0
ignorehitpause = 1

[State -2, Get Hit Voice]
type = playsnd
triggerall = alive
triggerall = time <= 1
triggerall = movetype = H
triggerall = !hitoverridden
triggerall = stateno != [120, 155]
triggerall = gethitvar(damage) = (0, life)
trigger1 = gethitvar(animtype) = 0 && random < 250
trigger2 = gethitvar(animtype) = 1 && random < 375
trigger3 = gethitvar(animtype) >= 2 && random < 500
trigger4 = gethitvar(damage) >= 100
trigger5 = gethitvar(fall)
trigger6 = gethitvar(attr) = SCA, HA, HT, HP
value = 5000, (random % 4)
channel = 0

[State -2, Get Hit Voice]
type = playsnd
triggerall = alive
triggerall = time = 1
triggerall = movetype = H
trigger1 = stateno = 5100
trigger1 = gethitvar(fall.damage) > 0 || sysvar(1) > 14
trigger2 = stateno = 5050 || stateno = 5100
trigger2 = prevstateno != [5000, 5120]
value = 5000, (random % 4)
lowpriority = 1
channel = 0

[State -2, Get Hit Voice]
type = playsnd
triggerall = alive
triggerall = time = 1
triggerall = movetype = H
triggerall = incustomstate
trigger1 = anim = [5000, 5002]
trigger2 = anim = [5010, 5012]
trigger3 = anim = [5020, 5022]
trigger4 = anim = 5030
trigger5 = anim = 5070
trigger6 = anim = 5080
trigger7 = anim = [5100, 5101]
trigger8 = anim = 5170
trigger9 = anim = 5950
trigger10 = anim = 170
value = 5000, (random % 4)
lowpriority = 1
channel = 0

[State -2, Dizzy Voice]
type = playsnd
trigger1 = time = 1
trigger1 = anim = 5300
value = 5300, 0
channel = 0

[State -2, Guard Break Voice]
type = playsnd
trigger1 = time = 1
trigger1 = stateno = const(StateGuardBreakRecover)
value = 5000, ifelse(random < 500, 2, 3)
lowpriority = 1
channel = 0

;[State -2, Voice Pos];happens automatically in Ikemen GO 0.99
;type = sndpan
;trigger1 = 1
;channel = 0
;pan = 0
;ignorehitpause = 1


;==================================================================================================
;===========================================<STATE -3>=============================================
;==================================================================================================
[Statedef -3]

[State -3, Parry Detection]
type = helper
triggerall = roundstate = 2
triggerall = !numhelper(705)
triggerall = !map(customcombo)
triggerall = ifelse(statetype = A, map(jumptype) != [1, 2], 1)
triggerall = (movetype = I && ctrl) || stateno = [700, 702] || stateno = 5120
trigger1 = !AIlevel
trigger1 = command != "rlsdir"
trigger1 = statetype = S || statetype = C || stateno = 5120
trigger1 = (p2dist x >= 0 && command = "F") || (p2dist x < 0 && command = "B") || command = "D"
trigger2 = !AIlevel
trigger2 = command != "rlsdir"
trigger2 = statetype = A
trigger2 = (p2dist x >= 0 && command = "F") || (p2dist x < 0 && command = "B")
trigger3 = AIlevel
trigger3 = inguarddist
trigger3 = stateno != [700, 702]
trigger3 = p2bodydist x < map(ai_p2fireball_distx)
trigger3 = random < (ifelse(life < 100 || guardpoints < 200, 100, 50) * (AIlevelF / 8.0))
trigger4 = AIlevel
trigger4 = inguarddist
trigger4 = stateno != [700, 702]
trigger4 = map(ai_p2fireball_eta) = [1, 8]
trigger4 = random < 200 * (AIlevelF / 8.0)
trigger5 = AIlevel
trigger5 = stateno = [700, 702]
trigger5 = time = 14 && random < (250 + 700 * (AIlevel / 8.0))
helpertype = normal
stateno = 705
ID = 705
name = "Parry Detection"
postype = p1
pausemovetime = 65535
supermovetime = 65535

[State -3, Parry Attacks]
type = changestate
trigger1 = numhelper(705)
trigger1 = stateno != [700, 702]
trigger1 = helper(705), stateno = 706
value = ifelse((helper(705), anim = 707), 702, ifelse((helper(705), anim = 706), 701, 700))
ctrl = 0

[State -3, Parry Projectiles]
type = hitoverride
trigger1 = numhelper(705)
trigger1 = stateno != [700, 702]
trigger1 = !(helper(705), var(0)) && (helper(705), anim = 705)
attr = SA, AP
stateno = 700
slot = 0
time = 1
ignorehitpause = 1

[State -3, Parry Projectiles]
type = hitoverride
trigger1 = numhelper(705)
trigger1 = stateno != [700, 702]
trigger1 = !(helper(705), var(0)) && (helper(705), anim = 706)
attr = C, AP
stateno = 701
slot = 0
time = 1
ignorehitpause = 1

[State -3, Parry Projectiles]
type = hitoverride
trigger1 = numhelper(705)
trigger1 = stateno != [700, 702]
trigger1 = !(helper(705), var(0)) && (helper(705), anim = 707)
attr = SCA, AP
stateno = 702
slot = 0
time = 1
ignorehitpause = 1

[State -3, NoWalk after Parry]
type = assertspecial
trigger1 = map(parry_nowalk) > 0
trigger1 = 1 || map(parry_nowalk) := (map(parry_nowalk) - 1)
flag = nowalk

[State -3, Cancel into Normals Reset]
type = mapset
trigger1 = movetype = H
trigger2 = movereversed != [1, 2]
map = "normalcancel"
value = 0
ignorehitpause = 1

[State -3, Cancel into Normals Check]
type = mapset
triggerall = map(customcombo)
trigger1 = stateno = [200, 699]
trigger1 = movecontact || movereversed
trigger2 = stateno = [1000, 2999] && statetype != A
trigger2 = movecontact || movereversed || map(projcontact)
trigger3 = stateno = 1321 && animelemtime(2) > 0
trigger3 = cond(numtarget, target, gethitvar(isbound) = 0, 1)
map = "normalcancel"
value = 1
ignorehitpause = 1

[State -3, Special Cancel Reset]
type = mapset
trigger1 = movetype = H
trigger2 = movereversed != [1, 2]
map = "specialcancel"
value = 0
ignorehitpause = 1

[State -3, Special Cancel Check]
type = mapset
triggerall = stateno = [200, 2999]
trigger1 = map(customcombo) && stateno = [200, 699]
trigger2 = map(customcombo) && stateno = [1000, 2999] && (movecontact || movereversed)
trigger3 = !AIlevel
trigger3 = time <= 2
trigger3 = stateno = [200, 699]
trigger3 = prevstateno != [200, 4999]
trigger4 = stateno = 200
trigger5 = stateno = 201
trigger6 = stateno = 210
trigger6 = animelemtime(5) < 0 && (movecontact || movereversed)
trigger7 = stateno = 211
trigger7 = animelemtime(4) < 0 && (movecontact || movereversed)
trigger8 = stateno = 215
trigger8 = animelemtime(5) < 0
trigger9 = stateno = 221
trigger9 = animelemtime(5) < 0 && (movecontact || movereversed)
trigger10 = stateno = 225
trigger10 = animelemtime(5) < 0 && (movecontact || movereversed)
trigger11 = stateno = 230
trigger11 = animelemtime(5) < 0 && (movecontact || movereversed)
trigger12 = stateno = 231
trigger12 = animelemtime(5) < 0 && (movecontact || movereversed)
trigger13 = stateno = 241
trigger13 = animelemtime(5) < 0 && (movecontact || movereversed)
trigger14 = stateno = 245
trigger14 = animelemtime(3) < 0 && (movecontact || movereversed)
trigger15 = stateno = 400
trigger16 = stateno = 410
trigger16 = animelemtime(4) < 0 && (movecontact || movereversed)
trigger17 = stateno = 430
trigger17 = animelemtime(4) < 0 && (movecontact || movereversed)
trigger18 = stateno = 290
trigger18 = animelemtime(5) < 0 && (movecontact || movereversed)
trigger19 = stateno = 291
trigger19 = animelemtime(6) < 0 && (movecontact || movereversed)
trigger20 = stateno = 1321
trigger20 = animelemtime(2) > 0 && map(customcombo)
trigger20 = cond(numtarget, target, gethitvar(isbound) = 0, 1)
map = "specialcancel"
value = 1
ignorehitpause = 1

[State -3, Super Cancel Reset]
type = mapset
trigger1 = movetype = H
trigger2 = movereversed != [1, 2]
map = "supercancel"
value = 0
ignorehitpause = 1

[State -3, Super Cancel Check]
type = mapset
triggerall = stateno = [200, 2999]
trigger1 = map(specialcancel)
trigger2 = stateno = 240
trigger2 = animelemtime(5) < 0 && (movecontact || movereversed)
trigger3 = stateno = 246
trigger3 = animelemtime(3) < 0 && (movecontact || movereversed)
trigger4 = stateno = 251
trigger4 = animelemtime(8) < 0 && (movecontact || movereversed)
trigger5 = stateno = 420
trigger5 = animelemtime(4) < 0 && (movecontact || movereversed)
trigger6 = stateno = 292
trigger6 = animelemtime(5) < 0 && (movecontact || movereversed)
trigger7 = stateno = 1000 || stateno = 1010
trigger7 = (movecontact + movereversed)
trigger8 = stateno = 1200 || stateno = 1210
trigger8 = (movecontact + movereversed)
map = "supercancel"
value = 1
ignorehitpause = 1

[State -3, Hyper Cancel Reset]
type = mapset
trigger1 = movetype = H
trigger2 = movereversed != [1, 2]
map = "hypercancel"
value = 0
ignorehitpause = 1

[State -3, Hyper Cancel Check]
type = mapset
triggerall = stateno = [3000, 4999]
trigger1 = stateno = 3000
trigger1 = anim = 3000 && animelemtime(19) < 0
trigger1 = (movecontact + movereversed) = [1, 12]
trigger2 = stateno = 3050
trigger2 = anim = 3050 && animelemtime(32) < 0
trigger2 = (movecontact + movereversed) = [1, 12]
trigger3 = stateno = 3111 && animelemtime(12) < 0
trigger3 = (movecontact + movereversed) = [1, 24]
map = "hypercancel"
value = 1
ignorehitpause = 1

[State -3, Throw Cancel Fix]; Because first frame of a throw has movehit and Custom Combo has so much freedom
type = null
trigger1 = numtarget
trigger1 = movehitvar(frame)
trigger1 = hitdefattr != SCA, AA
trigger1 = target, gethitvar(frame)
trigger1 = target, stateowner, ID = ID
trigger1 = time <= 0 && target, time <= 0
trigger1 = map(normalcancel) := 0 || map(specialcancel) := 0 || map(supercancel) := 0 || map(hypercancel) := 0
ignorehitpause = 1

[State -3, Super Cancel Flag Reset]
type = mapset
trigger1 = map(supercancelflag)
trigger1 = (stateno != [3000, 4999]) || movetype = H
map = "supercancel_flag"
value = 0
ignorehitpause = 1

[State -3, Hyper Cancel Flag Reset]
type = mapset
trigger1 = map(hypercancelflag)
trigger1 = (stateno != [3000, 4999]) || movetype = H
map = "hypercancel_flag"
value = 0
ignorehitpause = 1

[State -3, Movement Afterimage]
type = afterimage
triggerall = time = 1 && !map(customcombo)
trigger1 = (stateno = 50 || stateno = 1106) && map(jumptype) = [2, 3]
trigger2 = stateno = [710, 725]
time = 2
timegap = 1
framegap = 4
length = 9
palbright = 0, 0, 0
palcontrast = 128, 128, 128
palpostbright = 0, 0, 0
paladd = 0, 0, 0
palmul = 0.9, 0.9, 0.9
trans = add1

[State -3, Lv1 Super Afterimage]
type = afterimage
trigger1 = stateno = 3000 && time = 3
trigger2 = stateno = 3050 && time = 3
trigger3 = stateno = 3200 && time = 3
time = 2
timegap = 1
framegap = 10
length = 21
palcolor = 0
palbright = 0, 0, 0
palcontrast = 0, 64, 192
palpostbright = 0, 0, 0
paladd = 0, 0, 0
palmul = 0.75, 0.75, 0.75
trans = add1

[State -3, Lv2 Super Afterimage]
type = afterimage
trigger1 = stateno = 3100 && time = 3
time = 2
timegap = 1
framegap = 10
length = 21
palcolor = 0
palbright = 0, 0, 0
palcontrast = 128, 0, 192
palpostbright = 0, 0, 0
paladd = 0, 0, 0
palmul = 0.75, 0.75, 0.75
trans = add1

[State -3, Lv3 Super Afterimage]
type = afterimage
trigger1 = stateno = 4000 && time = 3
time = 2
timegap = 1
framegap = 10
length = 21
palcolor = 0
palbright = 0, 0, 0
palcontrast = 192, 0, 0
palpostbright = 0, 0, 0
paladd = 0, 0, 0
palmul = 0.75, 0.75, 0.75
trans = add1

[State -3, Afterimage Persist]
type = afterimagetime
trigger1 = stateno = 50 || stateno = [600, 699]
trigger1 = (map(jumptype) = 2 || map(jumptype) = 3) && vel y < -1
trigger2 = map(customcombo)
trigger3 = stateno = [3000, 4999]
trigger4 = stateno = [710, 725]
time = 2
ignorehitpause = 1

[State -3, Scary Supers]
type = attackdist
trigger1 = stateno = [3000, 4999]
value = 320

[State -3, Jump Reset]
type = mapset
trigger1 = map(jumptype)
trigger1 = stateno != 40
trigger1 = statetype != A || movetype = H
map = "jumptype"
value = 0

[State -3, Reset Super Finish Var]
type = mapset
trigger1 = map(superfinish)
trigger1 = roundstate = [0, 2]
map = "superfinish"
value = 0

[State -3, Custom Combo Finish]
type = helper
triggerall = winKO
triggerall = roundstate = 3
triggerall = map(customcombo) && !numhelper(8600)
triggerall = p2, gethitvar(playerno) = playerno
trigger1 = movecontact = [1, 4]
trigger2 = stateno = 310
trigger2 = animelemtime(4) = [0, 1]
trigger3 = stateno = 810
trigger3 = animelemtime(4) = [0, 1]
trigger4 = stateno = 820
trigger4 = animelemtime(12) = [0, 1]
trigger5 = stateno = 861
trigger5 = time <= 1
trigger6 = stateno = 1321
trigger6 = time <= 1
helpertype = normal
stateno = 8600
ID = 8600 + 0 * (map(superfinish) := 900)
name = "Super Finish"
postype = left
pos = 160, -120
ownpal = 1
ignorehitpause = 1
pausemovetime = 999
supermovetime = 999

[State -3, Super Finish]
type = helper
triggerall = winHyper
triggerall = roundstate = 3
triggerall = !numhelper(8600)
triggerall = p2, gethitvar(playerno) = playerno
trigger1 = movecontact = [1, 4]
trigger1 = stateno = [3000, 4999]
trigger1 = map(superfinish) := stateno
trigger2 = stateno = 3211 || stateno = 3213
trigger2 = map(superfinish) := 3200
trigger3 = stateno = 4010
trigger3 = map(superfinish) := 4000
helpertype = normal
stateno = 8600
ID = 8600
name = "Super Finish"
postype = left
pos = 160, -120
ownpal = 1
ignorehitpause = 1
pausemovetime = 999
supermovetime = 999

[State -3, Victory Camera]
type = mapset
trigger1 = roundstate != 4
map = "victorycam"
value = 0

[State -3, Victory Camera]
type = mapset
trigger1 = map(cfg_winzoom)
trigger1 = map(zoom_allowed)
trigger1 = alive && !standby
trigger1 = winKO
trigger1 = stateno > 180
trigger1 = stateno != 187
trigger1 = roundstate = 4
trigger1 = camerazoom <= 1
trigger1 = screenpos y = [0, gameheight]
trigger1 = numenemy
trigger1 = p2, incustomstate = 0
map = "victorycam"
value = 1

[State -3, Victory Camera]
type = zoom
trigger1 = map(victorycam)
scale = 1.0 / camerazoom
lag = 0.92
stagebound = 1
camerabound = 0
pos = pos x * camerazoom, 0

[State -3, Victory BGM]
type = mapset
map = "victorybgm"
trigger1 = map(victorybgm) != 0
trigger1 = motifstate(victoryscreen) = 0
value = 0

[State -3, Victory BGM]
type = mapadd
map = "victorybgm"
trigger1 = map(cfg_victorybgm)
trigger1 = motifstate(victoryscreen)
trigger1 = teamleader = playerno
trigger1 = matchover
trigger1 = alive
trigger1 = win
value = 1

[State -3, Victory BGM];Assertspecial nomusic does not work here
type = playbgm
trigger1 = map(cfg_victorybgm)
trigger1 = map(victorybgm) = [1, 5]
bgm = ""

[State -3, Victory BGM]
type = playbgm
trigger1 = map(cfg_victorybgm)
trigger1 = map(victorybgm) = 6
bgm = "guywin.mp3"
loop = 0
volume = 100

[State -3, Antifreeze]
type = changestate
triggerall = !ctrl
triggerall = time >= 300
triggerall = roundstate = 2
trigger1 = pos y > 0 && screenpos y > gameheight
trigger2 = !selfanimexist(anim)
value = 5040

[State -3, Antifreeze]
redirectID = p2, ID
type = selfstate
trigger1 = numenemy
trigger1 = movetype != A
trigger1 = p2, time >= 300
trigger1 = p2, incustomstate
trigger1 = p2, stateowner, playerno = playerno
value = 5040
