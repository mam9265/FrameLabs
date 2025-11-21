; ______________________________
;| Guy by Phantom.of.the.Server |
; ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
;============================================================================================
;=====================================<SPECIAL STATES>=======================================
;============================================================================================

;=========<HOUZANTOU>==========
[Statedef 1000]
type = S
physics = N
movetype = A
anim = 1000
ctrl = 0
velset = 0, 0
poweradd = 100 * map(meterscaling)
sprpriority = -1
facep2 = 1

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = 1

[State 1000, Strength]
type = mapset
trigger1 = !AIlevel
trigger1 = time <= 0
map = "strength"
value = ifelse(map(cmd_strength_z), 2, ifelse(map(cmd_strength_y), 1, 0))
ignorehitpause = 1
persistent = 0

[State 1000, Strength AI]
type = mapset
trigger1 = AIlevel
trigger1 = time <= 0
map = "strength"
value = ifelse(p2movetype = H, 0, ifelse(p2movetype = A || random < 333, 2, ifelse(random < 500, 0, 1)))
ignorehitpause = 1

[State 1000, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1000, Anim]
type = changeanim
trigger1 = !time
value = ifelse(map(strength) = 2, 1002, ifelse(map(strength) = 1, 1001, 1000))

[State 1000, Width]
type = width
trigger1 = animelemtime(9) >= 0 && animelemtime(11) < 0
value = ceil(40 * const(size.xscale)), 0

[State 1000, Sprite Priority]
type = sprpriority
trigger1 = animelemtime(8) >= 0
value = 1

[State 1000, Accel]
type = veladd
trigger1 = vel x > 0
x = ifelse(anim = 1002, -1.0, ifelse(anim = 1001, -0.75, -0.5))

[State 1000, Accel]
type = velset
trigger1 = vel x < 0
x = 0

[State 1000, Vel]
type = velset
trigger1 = animelemtime(4) = 1
x = ifelse(anim = 1002, 12.0, ifelse(anim = 1001, 9.0, 6.0))

[State 1000, Vel]
type = velset
trigger1 = animelemtime(8) = 1
x = ifelse(anim = 1002, 8.0, ifelse(anim = 1001, 6.0, 4.0))

[State 1000, Sound]
type = playsnd
trigger1 = animelem = 9
value = 3, 3
channel = 0

[State 1000, Sound]
type = playsnd
trigger1 = animelem = 9
value = 1, 3
;channel = 1
stopongethit = 1

[State 1000, Dust]
type = explod
trigger1 = animelem = 9
anim = 7103
ID = 7103
sprpriority = 3
postype = p1
pos = ceil(48 * const(size.xscale)), 0
ownpal = 1
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1

[State 1000, Dust]
type = modifyexplod
trigger1 = numexplod(7103)
trigger1 = animelemtime(9) >= 0
trigger1 = animelemtime(11) < 0
ID = 7103
postype = p1
pos = ceil(45 * const(size.xscale)), 0

[State 1000, Hit]
type = hitdef
trigger1 = animelem = 9
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 1)
attr = S, SA
damage = ifelse(map(strength) = 2, 140, ifelse(map(strength) = 1, 100, 80)), ifelse(map(strength) = 2, 35, ifelse(map(strength) = 1, 25, 20))
dizzypoints = ifelse(map(strength) = 2, 200, ifelse(map(strength) = 1, 150, 100)) * !map(customcombo)
animtype = Back
hitflag = MAF
guardflag = M
priority = 4, Hit
pausetime = 12, 12
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 55) * (map(sparkx.max) := 105), map(sparky) := -60
hitsound = s2, 3
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
ground.velocity = ifelse(map(strength) = 2, -7.3, ifelse(map(strength) = 1, -6.1, -4.8)), -4.2
air.type = High
air.velocity = ifelse(map(strength) = 2, -7.3, ifelse(map(strength) = 1, -6.1, -4.8)), -4.2
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
getpower = ifelse(movehit, 25, 100) * map(meterscaling), ifelse(moveguarded, 25, 50) * map(meterscaling)
givepower = 40, 40
envshake.time = 12; special
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.mul = 0.667
fall = 1
fall.recover = 1
fall.recovertime = 120
yaccel = 0.4850
p1sprpriority = sprpriority
forcestand = 1

[State 1000, Anim]
type = assertspecial
trigger1 = anim = [1000, 1002]
trigger1 = hitpausetime > 0
trigger1 = animelemtime(9) >= 1 && animelemtime(10) <= 0
flag = animatehitpause
ignorehitpause = 1

[State 1000, FX]
type = explod
trigger1 = animelem = 9
ID = 1090
anim = 1090
postype = p1
pos = 50, -60
bindtime = 60
sprpriority = sprpriority + 1
removeongethit = 1
removeonchangestate = 1
ownpal = 1

[State 1000, Idle]
type = statetypeset
trigger1 = animelemtime(11) >= 0
movetype = I
persistent = 0

[State 1000, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;=========<EX HOUZANTOU>==========
[Statedef 1010]
type = S
physics = N
movetype = A
anim = 1010
ctrl = 0
velset = 0, 0
poweradd = -500
sprpriority = -1
facep2 = 1

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = 1

[State 1010, Custom Combo End]
type = palfx
trigger1 = !time
trigger1 = map(customcombo) > 0
trigger1 = (map(customcombo) := 0) || (map(juggle_count) := 0) || 1
time = 1

[State 1010, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1010, EX FX]
type = playsnd
trigger1 = !time
value = 0, 1000

[State 1010, EX FX]
type = explod
trigger1 = !time
trigger1 = 1 || map(exflash) := 30
anim = 7210
sprpriority = 3
postype = p1
pos = ceil(20 * const(size.xscale)), ceil(-38 * const(size.yscale))
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 1010, Width]
type = width
trigger1 = animelemtime(9) >= 0 && animelemtime(11) < 0
value = ceil(40 * const(size.xscale)), 0

[State 1010, Sprite Priority]
type = sprpriority
trigger1 = animelemtime(8) >= 0
value = 1

[State 1010, Accel]
type = veladd
trigger1 = vel x > 0
x = -0.75

[State 1010, Accel]
type = velset
trigger1 = vel x < 0
x = 0

[State 1010, Vel]
type = velset
trigger1 = animelemtime(4) = 1
x = 9.0

[State 1010, Vel]
type = velset
trigger1 = animelemtime(8) = 1
x = 6.0

[State 1010, Sound]
type = playsnd
trigger1 = animelem = 9
value = 3, 3
channel = 0

[State 1010, Sound]
type = playsnd
trigger1 = animelem = 9
value = 1, 3
;channel = 1
stopongethit = 1

[State 1010, Dust]
type = explod
trigger1 = animelem = 9
anim = 7103
ID = 7103
sprpriority = 3
postype = p1
pos = ceil(45 * const(size.xscale)), 0
ownpal = 1
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1

[State 1010, Dust]
type = modifyexplod
trigger1 = numexplod(7103)
trigger1 = animelemtime(9) >= 0
trigger1 = animelemtime(11) < 0
ID = 7103
postype = p1
pos = ceil(48 * const(size.xscale)), 0

[State 1010, Hit]
type = hitdef
trigger1 = animelem = 9
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 1)
ID = 1010
attr = S, SA
damage = 80, 20
dizzypoints = 100 * !map(customcombo)
animtype = Back
hitflag = MAF
guardflag = M
priority = 4, Hit
pausetime = 12, 12
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 55) * (map(sparkx.max) := 105), map(sparky) := -60
hitsound = s2, 3
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
ground.velocity = -16.0, -4.00
air.type = High
air.velocity = -16.0, -4.00
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
guard.cornerpush.veloff = 0
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; special
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.mul = 0.667
fall = 1
fall.recover = 1
fall.recovertime = 120
ID = 1010
p1sprpriority = sprpriority
forcestand = 1
yaccel = 0.4850

[State 1010, Anim]
type = changeanim
trigger1 = anim = 1010
trigger1 = movecontact = 1 && hitpausetime
trigger1 = animelemtime(9) >= 0 && animelemtime(10) <= 0
trigger1 = hitpausetime <= 10
value = 1010
elem = 10
ignorehitpause = 1

[State 1010, Wall Bounce]
type = targetstate
trigger1 = !map(wallbounce)
trigger1 = movehit = 1
trigger1 = numtarget(1010)
trigger1 = target(1010), dizzy = 0
trigger1 = target(1010), dizzypoints > abs(target(1010), gethitvar(dizzypoints))
trigger1 = target(1010), stateno = 5000 || target(1010), stateno = 5010 || target(1010), stateno = 5020
trigger1 = 1 || map(wallbounce) := 1
value = 1111010
ID = 1010
ignorehitpause = 1

[State 1010, Juggle Reset]
type = mapset
trigger1 = numtarget(1010)
trigger1 = target(1010), stateno = 1111010
map = "juggle_count"
value = 0
ignorehitpause = 1

[State 1010, FX]
type = explod
trigger1 = animelem = 9
ID = 1090
anim = 1090
postype = p1
pos = 50, -60
bindtime = 60
sprpriority = sprpriority + 1
removeongethit = 1
removeonchangestate = 1
ownpal = 1

[State 1010, Idle]
type = statetypeset
trigger1 = animelemtime(11) >= 0
movetype = I
persistent = 0

[State 1010, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;========================<HIT by EX HOUZANTOU>=============================
;----- Hit Pause -----
[Statedef 1111010]
type = A
physics = N
movetype = H
velset = 0, 0

[State 1111010, Anim]
type = changeanim
trigger1 = 1
value = 5002

[State 1111010, End]
type = changestate
trigger1 = hitshakeover
value = 1111011


;----- Target Falling -----
[Statedef 1111011]
type = A
physics = N
movetype = H

[State 1111011, Accel]
type = veladd
trigger1 = 1
y = ifelse(vel y < 0, 0.5, 1.0) * gethitvar(yaccel)

[State 1111011, Vel]
type = hitvelset
trigger1 = !time
x = 1
y = 1

[State 1111011, Screen]
type = screenbound
trigger1 = 1
value = 1
movecamera = abs(player(gethitvar(playerno)), pos x - pos x) < (320 - stagevar(camera.tension) * 2), 0

[State 1111011, Push]
type = playerpush
trigger1 = 1
value = 0

[State 1111011, Anim]
type = changeanim
trigger1 = !time
value = 5030

[State 1111011, Bounce]
type = changestate
trigger1 = time >= 4
trigger1 = pos y < 0
trigger1 = backedgebodydist <= 0 || frontedgebodydist <= 0
value = 1111012

[State 1111011, End]
type = selfstate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 5100


;----- Target Hitting Wall -----
[Statedef 1111012]
type = A
physics = N
movetype = H

[State 1111012, turn]
type = turn
trigger1 = !time
trigger1 = frontedgedist < backedgedist

[State 1111012, Pos]
type = posadd
trigger1 = 1
x = -backedgebodydist

[State 1111012, Pos]
type = posfreeze
trigger1 = 1
x = 1
y = 1

[State 1111012, Screen]
type = screenbound
trigger1 = 1
value = 0
movecamera = 0, 0

[State 1111012, Push]
type = playerpush
trigger1 = 1
value = 0

[State 1111012, Anim]
type = changeanim
trigger1 = 1
value = 5000

[State 1111012, Sound]
type = playsnd
trigger1 = !time
value = F 7, 2

[State 1111012, FX]
type = explod
trigger1 = !time
anim = F 72
postype = p1
pos = -15, const(size.mid.pos.y)
sprpriority = -5
ownpal = 1

[State 1111012, End]
type = changestate
trigger1 = time >= 4
value = 1111013


;----- Falling -----
[Statedef 1111013]
type = A
physics = N
movetype = H

[State 1111013, turn]
type = turn
trigger1 = !time

[State 1111013, Accel]
type = veladd
trigger1 = 1
y = 0.4850; yaccel

[State 1111013, Track Nearest Player]
type = velset
trigger1 = !time
x = ((p2, pos x - pos x) * facing + 50) / 36.0
y = (pos y + 0.5 * 0.4850 * 36 ** 2) / -36.0

[State 1111013, Track Exact Player]
type = velset
trigger1 = !time
trigger1 = gethitvar(playerno)
trigger1 = playerIDexist(player(gethitvar(playerno)), ID)
x = ((player(gethitvar(playerno)), pos x - pos x) * facing + 50) / 36.0

[State 1111013, Vel]
type = velset
trigger1 = !time
trigger1 = vel x != [-8, 0]
x = ifelse(vel x <= -8, -8, 0)

[State 1111013, Anim]
type = changeanim
trigger1 = !time
value = ifelse(selfanimexist(5051), 5051, 5030)

[State 1111013, Anim]
type = changeanim
trigger1 = anim = 5030
trigger1 = !animtime
value = 5050

[State 1111013, Anim]
type = changeanim
trigger1 = anim = 5051
trigger1 = vel y > -2
value = 5061

[State 1111013, Screen]
type = screenbound
trigger1 = 1
value = 1
movecamera = 0, 0

[State 1111013, Fall Recovery]
type = selfstate
trigger1 = alive = 1 && dizzy = 0 && dizzypoints > 0
trigger1 = gethitvar(fall.recover)
trigger1 = command = "recovery"
trigger1 = vel y > 0
trigger1 = pos y >= const(movement.air.gethit.groundrecover.ground.threshold)
value = 5200

[State 1111013, End]
type = selfstate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 5100


;======================<HAYAGAKE>=============================
;----- RUNNING -----
[Statedef 1100]
type = S
physics = S
movetype = A
anim = 1100
ctrl = 0
velset = 0, 0
poweradd = 100 * map(meterscaling)
sprpriority = 2
facep2 = 1

[State 1100, Strength]
type = mapset
trigger1 = !AIlevel
trigger1 = time <= 0
map = "strength"
value = ifelse(map(cmd_strength_c), 2, ifelse(map(cmd_strength_b), 1, 0))
ignorehitpause = 1
persistent = 0

[State 1100, Strength AI]
type = mapset
trigger1 = AIlevel
trigger1 = time <= 0
map = "strength"
value = ifelse((p2stateno = [150, 155] || power >= 3000) && p2bodydist x < 50, 0, ifelse(random < 500, 1, 2))
ignorehitpause = 1
persistent = 0

[State 1100, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1100, Vel]
type = velset
trigger1 = 1
x = 8.87

[State 1100, Fadeout]
type = explod
trigger1 = !time
anim = 1199
ID = 1199
sprpriority = 0
postype = p1
pos = ceil(-vel x)
scale = const(size.xscale), const(size.yscale)

[State 1100, Afterimage]
type = explod
trigger1 = 1
ID = 1500
postype = p1
pos = 0, 0
sprpriority = sprpriority - 1
anim = anim
animfreeze = 1
animelem = animelemno(0)
removetime = 6
trans = addalpha
alpha = 256, 0
scale = const(size.xscale), const(size.yscale)
interpolation.time = 6
interpolation.alpha = 0, 256
removeonchangestate = 1
ownpal = 0

[State 1100, Sound]
type = playsnd
trigger1 = !time
value = 3, 3
channel = 0

[State 1100, Steps]
type = playsnd
trigger1 = animelem = 2 || animelem = 5
value = 0, ifelse((animelem = 2), 103, 106)

[State 1100, Dust]
type = explod
trigger1 = animelem = 2 || animelem = 5
anim = 7101
ID = 7101
sprpriority = 3
postype = p1
pos = ceil(-55 * const(size.xscale)), 0
scale = 0.5, 0.5
ownpal = 1
pausemovetime = -1
supermovetime = -1

[State 1100, Stop Light]
type = changestate
trigger1 = map(strength) = 0
trigger1 = p2bodydist x <= 32
value = 1102

[State 1100, Kick]
type = changestate
trigger1 = map(strength) > 0
trigger1 = !AIlevel
trigger1 = time >= 2
trigger1 = command = "a" || command = "b" || command = "c"
value = ifelse(command = "c", 1115, ifelse(command = "b", 1120, 1110))

[State 1100, Kick]
type = changestate
triggerall = map(strength) > 0
triggerall = AIlevel
triggerall = time >= 2
trigger1 = p2bodydist x < 80
trigger1 = random < (200 * (AIlevelF / 8.0))
trigger2 = inguarddist
value = ifelse((random < 250 || inguarddist || p2statetype = L), 1110, ifelse((random < 666 || p2statetype = A), 1120, 1110))

[State 1100, Stop]
type = changestate
trigger1 = time >= ifelse(map(strength) = 2, 32, ifelse(map(strength) = 1, 20, 8))
value = 1102


;----- STOP -----
[Statedef 1102]
type = S
physics = S
movetype = I
anim = 1102
ctrl = 0
sprpriority = 2

[State 1102, Sound]
type = playsnd
trigger1 = !time
value = 5, 0

[State 1102, Dust]
type = explod
trigger1 = animelemtime(2) < 0
anim = 7103
ID = 7103
sprpriority = 3
postype = p1
pos = 64 * const(size.xscale), 0
vel = 1, 0
scale = 0.5, 0.5
trans = addalpha
alpha = 64, 256
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 1102, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;=========<KAGE SUKUI>==========
[Statedef 1110]
type = S
physics = N
movetype = A
anim = 1110
ctrl = 0
sprpriority = 2
juggle = ifelse(p2statetype = L && !map(customcombo), 8, 0)

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = 1

[State 1110, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1110, Sound]
type = playsnd
trigger1 = animelem = 3
value = 3, 6
channel = 0

[State 1110, Sound]
type = playsnd
trigger1 = animelem = 5
value = 1, 6
;channel = 1
stopongethit = 1

[State 1110, Meter Scaling after EX]
type = null
trigger1 = prevstateno = 1150
trigger1 = map(meterscaling) := 0

[State 1110, Hit]
type = hitdef
trigger1 = animelem = 6
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 1)
attr = C, SA
damage = 110, 27
dizzypoints = 100 * !map(customcombo)
animtype = Hard
hitflag = MAFD
guardflag = L
priority = 4, Hit
pausetime = 12, 12
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 30) * (map(sparkx.max) := 100), map(sparky) := -7
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = Trip
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
ground.velocity = -6, -8.0
air.type = Trip
air.velocity = -6, -8.0
down.hittime = 20
down.velocity = 0, 0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
getpower = ifelse(movehit, 25, 100) * map(meterscaling), ifelse(moveguarded, 25, 50) * map(meterscaling)
givepower = 40, 40
envshake.time = 12; special
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.mul = 0.667
fall = 1
fall.recover = 1
fall.recovertime = 120
yaccel = 0.695
p1sprpriority = sprpriority
forcestand = 1
ID = 1110

[State 1110, Type]
type = statetypeset
trigger1 = animelem = 5
statetype = C

[State 1110, Type]
type = statetypeset
trigger1 = animelem = 7
physics = C

[State 1110, Idle]
type = statetypeset
trigger1 = animelemtime(7) >= 0
movetype = I
persistent = 0

[State 1110, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;=========<KUBIKARI>==========
[Statedef 1115]
type = S
movetype = A
physics = S
anim = 1115
ctrl = 0
sprpriority = 2
velset = 0, 0
poweradd = 0
facep2 = (map(strength) = 3)

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = 1

[State 1115, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1115, Sound]
type = playsnd
trigger1 = animelem = 3
value = 3, 7
channel = 0

[State 1115, Sound]
type = playsnd
trigger1 = animelem = 5
value = 1, 6
;channel = 1
stopongethit = 1

;[State 1115, Force Push]
;type = posadd
;trigger1 = p2statetype = C
;trigger1 = p2dist y >= -60 && (p2bodydist x = [-20, 0])
;x = -vel x

[State 1115, Trail]
type = explod
trigger1 = animelem = 6
anim = 1116
sprpriority = 3
postype = p1
scale = const(size.xscale), const(size.yscale)
removeongethit = 1
ignorehitpause = 1
persistent = 0

[State 1115, Meter Scaling after EX]
type = null
trigger1 = prevstateno = 1150
trigger1 = map(meterscaling) := 0

[State 1115, Hit]
type = hitdef
trigger1 = animelem = 5
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 1)
attr = A, SA
damage = 60, 15
dizzypoints = 100 * !map(customcombo)
animtype = Hard
guardflag = HA
hitflag = HAF
priority = 4, Hit
pausetime = 4, 4
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 0) * (map(sparkx.max) := 15), map(sparky) := -55
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
ground.velocity = -10.52, 0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
air.type = Low
air.velocity = -6, -3.7
getpower = ifelse(movehit, 25, 100) * map(meterscaling), ifelse(moveguarded, 25, 50) * map(meterscaling)
givepower = 40, 40
envshake.time = 12; special
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.mul = 0.667
air.fall = 1
fall.recover = 1
fall.recovertime = 120
p1sprpriority = sprpriority
forcestand = 1
yaccel = 0.4850
airguard.ctrltime = 1 + 16
airguard.velocity = -6.00, -1.00
airguard.cornerpush.veloff = 0

[State 1115, Hit]
type = hitdef
trigger1 = animelem = 6
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 2)
attr = A, SA
damage = 80, 20
dizzypoints = 100 * !map(customcombo)
animtype = Hard
guardflag = HA
hitflag = MAF
priority = 4, Hit
pausetime = 12, 12
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 20) * (map(sparkx.max) := 85), map(sparky) := -45
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
ground.velocity = -10.52, 0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
air.type = Low
air.velocity = -6, -3.7
getpower = ifelse(movehit, 25, 100) * map(meterscaling), ifelse(moveguarded, 25, 50) * map(meterscaling)
givepower = 40, 40
envshake.time = 12; special
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.mul = 0.667
air.fall = 1
fall.recover = 1
fall.recovertime = 120
p1sprpriority = sprpriority
forcestand = 1
yaccel = 0.4850
airguard.ctrltime = 1 + 16
airguard.velocity = -6.00, -1.00
airguard.cornerpush.veloff = 0

[State 1115, Type]
type = statetypeset
trigger1 = animelem = 3
statetype = A
physics = N

[State 1115, Accel]
type = veladd
trigger1 = animelemtime(3) >= 0
y = 1.0

[State 1115, Vel]
type = velset
trigger1 = animelem = 3
x = 6.50
y = -9.20

[State 1115, End]
type = changestate
trigger1 = animelemtime(3) >= 0
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 1117


;---Land---
[Statedef 1117]
type = S
physics = S
movetype = I
anim = 1117
ctrl = 0
velset = 0, 0
sprpriority = 2
movehitpersist = 1
hitcountpersist = 1

[State 1117, Pos]
type = posset
trigger1 = 1
y = 0

[State 1117, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 1117, Dust]
type = explod
trigger1 = !time
anim = 7102
ID = 7100
sprpriority = -5
postype = p1
scale = 0.5, 0.5
ownpal = 1
pausemovetime = -1
supermovetime = -1

[State 1117, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;=========<SEICHUUKARI>==========
[Statedef 1120]
type = S
movetype = A
physics = S
anim = 1120
ctrl = 0
sprpriority = 2
velset = 0, 0
facep2 = (map(strength) = 3)

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = 1

[State 1120, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1120, Sound]
type = playsnd
trigger1 = animelem = 3
value = 3, 8
channel = 0

[State 1120, Sound]
type = playsnd
trigger1 = animelem = 5
value = 1, 6
;channel = 1
stopongethit = 1

[State 1120, Trail]
type = explod
trigger1 = animelem = 5
anim = 1121
sprpriority = 3
postype = p1
scale = const(size.xscale), const(size.yscale)
removeongethit = 1
ignorehitpause = 1
persistent = 0

[State 1120, Meter Scaling after EX]
type = null
trigger1 = prevstateno = 1150
trigger1 = map(meterscaling) := 0

[State 1120, Hit]
type = hitdef
trigger1 = animelem = 5
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 1)
ID = 1120
attr = A, SA
damage = 90, 23
dizzypoints = 100 * !map(customcombo)
animtype = Back
hitflag = MAF
guardflag = MA
priority = 4, Hit
pausetime = 12, 12
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 30) * (map(sparkx.max) := 88), map(sparky) := -82
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
ground.velocity = -3, -8.7
air.type = Low
air.velocity = -3, -8.7
getpower = ifelse(movehit, 25, 100) * map(meterscaling), ifelse(moveguarded, 25, 50) * map(meterscaling)
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
givepower = 40, 40
envshake.time = 12; special
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.mul = 0.667
fall = 1
air.fall = 1
fall.recover = 1
fall.recovertime = 120
p1sprpriority = sprpriority
forcestand = 1
yaccel = 0.4850
airguard.ctrltime = 1 + 16
airguard.velocity = -6.00, -1.00
airguard.cornerpush.veloff = 0

[State Accel]
type = veladd
trigger1 = animelemtime(3) >= 0
y = 0.50

[State 1120, Vel]
type = velset
trigger1 = animelem = 3
x = 8
y = -4.5

[State STS]
type = statetypeset
trigger1 = animelem = 3
statetype = A
physics = N

[State 1120, Idle]
type = statetypeset
trigger1 = animelemtime(6) >= 0
movetype = I
persistent = 0

[State Land]
type = changestate
trigger1 = animelemtime(3) >= 0
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 1122


;---Land---
[Statedef 1122]
type = S
physics = S
movetype = I
anim = 1122
ctrl = 0
velset = 0, 0
sprpriority = 2
movehitpersist = 1
hitcountpersist = 1

[State 1122, Pos]
type = posset
trigger1 = 1
y = 0

[State 1122, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 1122, Dust]
type = explod
trigger1 = !time
anim = 7102
ID = 7100
sprpriority = -5
postype = p1
scale = 0.5, 0.5
ownpal = 1
pausemovetime = -1
supermovetime = -1

[State 1122, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;======================<EX HAYAGAKE>=============================
;----- RUNNING -----
[Statedef 1150]
type = S
physics = N
movetype = A
anim = 1150
ctrl = 0
velset = 0, 0
poweradd = -500
sprpriority = 2
facep2 = 1

[State 1150, Strength]
type = mapset
trigger1 = time <= 0
map = "strength"
value = 3
ignorehitpause = 1
persistent = 0

[State 1150, Custom Combo End]
type = palfx
trigger1 = !time
trigger1 = map(customcombo) > 0
trigger1 = (map(customcombo) := 0) || (map(juggle_count) := 0) || 1
time = 1

[State 1150, EX FX]
type = playsnd
trigger1 = !time
value = 0, 1000

[State 1150, EX FX]
type = explod
trigger1 = !time
trigger1 = 1 || map(exflash) := 30
anim = 7210
sprpriority = 3
postype = p1
pos = ceil(8 * const(size.xscale)), ceil(-12 * const(size.yscale))
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 1150, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1150, Vel]
type = velset
trigger1 = animelem = 2
x = 10

[State 1150, Vel]
type = velmul
trigger1 = animelemtime(9) > 0
trigger1 = animelemtime(14) < 0
x = 0.8

[State 1150, Vel]
type = velset
trigger1 = animelem = 16
x = 0

[State 1150, Fadeout]
type = explod
trigger1 = animelem = 2
anim = 1199
ID = 1199
sprpriority = 0
postype = p1
pos = -vel x, 0
scale = const(size.xscale), const(size.yscale)

[State 1150, Push]
type = playerpush
trigger1 = animelemtime(2) >= 0 && animelemtime(14) < 0
value = 0

[State 1150, HB]
type = hitby
trigger1 = animelemtime(2) >= 0 && animelemtime(14) < 0
value2 = SCA, AA, AT
time = 1

[State 1150, Corner reached]
type = changeanim
trigger1 = frontedgedist <= 0
trigger1 = animelemtime(8) >= 6
trigger1 = animelemtime(9) < 0
value = 1150
elem = 9

[State 1150, Sound]
type = playsnd
trigger1 = animelem = 3
value = 3, 2
channel = 0

[State 1150, Sound]
type = playsnd
trigger1 = animelem = 2
value = 5, 5

[State 1150, Sound]
type = playsnd
trigger1 = animelem = 9
value = 0, 101

[State 1150, Dust]
type = explod
trigger1 = animelemtime(9) >= 0
trigger1 = animelemtime(15) < 0
anim = 7103
ID = 7103
sprpriority = 3
postype = p1
pos = 40 * const(size.xscale), 0
vel = 0, 0
scale = 0.5, 0.5
trans = addalpha
alpha = 48, 256
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 1150, Kick]
type = changestate
trigger1 = !AIlevel
trigger1 = animelemtime(2) > 0 && animelemtime(9) < 0
trigger1 = command = "a" || command = "b" || command = "c"
value = ifelse(command = "c", 1115, ifelse(command = "b", 1120, 1110))

[State 1150, Kick]
type = changestate
trigger1 = AIlevel
trigger1 = animelemtime(2) > 0 && animelemtime(9) < 0
trigger1 = !inguarddist || animelemtime(10) = -1
trigger1 = p2bodydist x < 80 && random < 333
value = ifelse(random < 250 || p2statetype = L, 1110, ifelse(random < 500 && p2statetype != C, 1120, 1110))

[State 1150, Idle]
type = statetypeset
trigger1 = animelem = 15
movetype = I

[State 1150, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;======================<BUSHIN SENPUU KYAKU>=============================
[Statedef 1200]
type = S
physics = S
movetype = A
anim = 1200
ctrl = 0
velset = 0, 0
poweradd = 100 * map(meterscaling)
facep2 = 1
sprpriority = 2

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = 1

[State 1200, Strength]
type = mapset
trigger1 = !AIlevel
trigger1 = time <= 0
map = "strength"
value = ifelse(map(cmd_strength_c), 2, ifelse(map(cmd_strength_b), 1, 0))
ignorehitpause = 1
persistent = 0

[State 1200, Strength AI]
type = mapset
trigger1 = AIlevel
trigger1 = time <= 0
map = "strength"
value = ifelse((p2movetype = H || random < 500), 2, ifelse(random < 500, 1, 0))
ignorehitpause = 1

[State 1200, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1200, Anim]
type = changeanim
trigger1 = !time
value = ifelse(map(strength) = 2, 1202, ifelse(map(strength) = 1, 1201, 1200))

[State 1200, HB]
type = hitby
trigger1 = animelemtime(4) < 0
value = SCA, AA, AT
time = 1
ignorehitpause = 1

[State 1200, HB]
type = hitby
trigger1 = animelemtime(4) >= 0
trigger1 = animelemtime(6) < 0
value = SC, AA, AT
time = 1
ignorehitpause = 1

[State 1200, Sound]
type = playsnd
trigger1 = animelem = 3
value = 3, 7
channel = 0

[State 1200, Sound]
type = playsnd
trigger1 = animelemtime(4) = 1
value = 0, 40
persistent = 0

[State 1200, Dust]
type = helper
trigger1 = animelemtime(4) = 1
helpertype = normal
stateno = 7100
ID = 7100
name = "Dust"
postype = p1
ownpal = 1
persistent = 0

[State 1200, Type]
type = statetypeset
trigger1 = animelem = 4
statetype = A
physics = N

[State 1200, Accel]
type = veladd
trigger1 = vel x > 0
x = -0.25

[State 1200, Accel]
type = velset
trigger1 = vel x < 0
x = 0

[State 1200, Accel]
type = veladd
trigger1 = animelemtime(4) >= 1
y = 0.433

[State 1200, Vel]
type = velset
trigger1 = animelemtime(4) = 1
x = ifelse(map(strength) = 2, 6.31, ifelse(map(strength) = 1, 5.63, 4.88))
y = ifelse(map(strength) = 2, -8.126, ifelse(map(strength) = 1, -7.175, -6.082))

[State 1200, Sound]
type = playsnd
trigger1 = animelem = 4 || animelem = 8 || animelem = 12 || (anim = 1202 && animelem = 16)
value = 1, 4
;channel = 1
stopongethit = 1

[State 1200, Blur FX]
type = explod
trigger1 = animelem = 5 || animelem = 9 || animelem = 13 || (anim = 1202 && animelem = 17)
ID = 1290
anim = 1290
postype = p1
pos = 0, -70
scale = -1, -1
bindtime = 60
sprpriority = sprpriority - 1
removeongethit = 1
removeonchangestate = 1
ownpal = 1

[State 1200, Blur FX]
type = explod
trigger1 = animelem = 7 || animelem = 11 || (anim = 1202 && animelem = 15)
ID = 1290
anim = 1290
postype = p1
pos = 0, -60
scale = 1, 1
bindtime = 60
sprpriority = sprpriority + 1
removeongethit = 1
removeonchangestate = 1
ownpal = 1

[State 1200, Anim]
type = changeanim
trigger1 = map(strength) < 2
trigger1 = animelemtime(14) >= 0 && animelemtime(18) < 0
value = 1201
elem = 18

[State 1200, Hit]
type = hitdef
trigger1 = animelem = 5 || animelem = 9 || animelem = 13 || (anim = 1202 && animelem = 17)
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := (map(strength) + 2))
attr = A, SA
damage = ifelse(map(strength) = 2, 35, ifelse(map(strength) = 1, 40, 50)), ifelse(map(strength) = 2, 9, ifelse(map(strength) = 1, 10, 13))
dizzypoints = ifelse(map(strength) = 2, 50, ifelse(map(strength) = 1, 67, 100)) * !map(customcombo)
animtype = Hard
air.animtype = Back
fall.animtype = Back
hitflag = MAF
guardflag = MA
priority = 4, Hit
pausetime = 8, 8
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 20) * (map(sparkx.max) := 72), map(sparky) := -66
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
ground.velocity = -3.5, ifelse(map(strength) = 2, -7.0, ifelse(map(strength) = 1, -6.0, -5.0))
air.type = Low
air.velocity = -3.5, -5.0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
getpower = ifelse(movehit, 25, 100) * map(meterscaling), ifelse(moveguarded, 25, 50) * map(meterscaling)
givepower = 40, 40
envshake.time = 12; special
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.mul = 0.667
fall = 1
fall.recover = 1
fall.recovertime = 120
yaccel = 0.4850
airguard.ctrltime = 1 + 16
airguard.velocity = -6.00, -1.00
p1sprpriority = sprpriority
forcestand = 1
airguard.cornerpush.veloff = 0

[State Idle]
type = statetypeset
trigger1 = anim = 1200 || anim = 1201
trigger1 = animelem = 14
trigger2 = anim = 1202
trigger2 = animelem = 18
movetype = I

[State Land]
type = changestate
trigger1 = statetype = A
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 1209


;---Land---
[Statedef 1209]
type = S
physics = S
movetype = I
anim = 1209
ctrl = 0
velset = 0, 0
sprpriority = 2
movehitpersist = 1
hitcountpersist = 1

[State 1209, Pos]
type = posset
trigger1 = 1
y = 0

[State 1209, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 1209, Dust]
type = explod
trigger1 = !time
anim = 7102
ID = 7100
sprpriority = -5
postype = p1
scale = 0.5, 0.5
ownpal = 1
pausemovetime = -1
supermovetime = -1

[State 1209, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;======================<EX BUSHIN SENPUU KYAKU>=============================
[Statedef 1210]
type = S
physics = S
movetype = A
anim = 1210
ctrl = 0
velset = 0, 0
poweradd = -500
facep2 = 1
sprpriority = 2

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = 1

[State 1210, Custom Combo End]
type = palfx
trigger1 = !time
trigger1 = map(customcombo) > 0
trigger1 = (map(customcombo) := 0) || (map(juggle_count) := 0) || 1
time = 1

[State 1210, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1210, EX FX]
type = playsnd
trigger1 = !time
value = 0, 1000

[State 1210, EX FX]
type = explod
trigger1 = !time
trigger1 = 1 || map(exflash) := 30
anim = 7210
sprpriority = 3
postype = p1
pos = ceil(0 * const(size.xscale)), ceil(-54 * const(size.yscale))
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 1210, NHB]
type = nothitby
trigger1 = anim = 1210
trigger1 = animelemtime(6) < 0
time = 1
value = SCA
ignorehitpause = 1

[State 1210, Sound]
type = playsnd
trigger1 = animelem = 3
value = 3, 7
channel = 0

[State 1210, Sound]
type = playsnd
trigger1 = animelemtime(4) = 1
value = 0, 40
persistent = 0

[State 1210, Dust]
type = helper
trigger1 = animelemtime(4) = 1
helpertype = normal
stateno = 7100
ID = 7100
name = "Dust"
postype = p1
ownpal = 1
persistent = 0

[State 1210, Type]
type = statetypeset
trigger1 = animelem = 4
statetype = A
physics = N

[State 1210, Accel]
type = veladd
trigger1 = vel x > 0
x = -0.25

[State 1210, Accel]
type = velset
trigger1 = vel x < 0
x = 0

[State 1210, Accel]
type = veladd
trigger1 = animelemtime(4) >= 1
y = 0.433

[State 1210, Vel]
type = velset
trigger1 = animelemtime(4) = 1
x = 6.96
y = -8.977

[State 1210, Sound]
type = playsnd
trigger1 = animelem = 4 || animelem = 8 || animelem = 12 || animelem = 16 || animelem = 20
value = 1, 4
;channel = 1
stopongethit = 1

[State 1210, Blur FX]
type = explod
trigger1 = animelem = 5 || animelem = 9 || animelem = 13 || animelem = 17 || animelem = 21
ID = 1290
anim = 1291
postype = p1
pos = 0, -70
scale = 1, 1
bindtime = 60
sprpriority = sprpriority - 1
removeongethit = 1
removeonchangestate = 1
ownpal = 1

[State 1210, Blur FX]
type = explod
trigger1 = animelem = 7 || animelem = 11 || animelem = 15 || animelem = 19
ID = 1290
anim = 1290
postype = p1
pos = 0, -60
scale = 1, 1
bindtime = 60
sprpriority = sprpriority + 1
removeongethit = 1
removeonchangestate = 1
ownpal = 1

[State 1210, Hit]
type = hitdef
trigger1 = animelem = 5 || animelem = 9 || animelem = 13 || animelem = 17 || animelem = 21
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 5)
attr = A, SA
damage = 30, 8
dizzypoints = 40 * !map(customcombo)
animtype = Hard
air.animtype = Back
fall.animtype = Back
hitflag = MAF
guardflag = MA
priority = 4, Hit
pausetime = 6, 6
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 20) * (map(sparkx.max) := 72), map(sparky) := -66
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
ground.velocity = -4.0, -7.5
air.type = Low
air.velocity = -4.0, -5.0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
guard.cornerpush.veloff = 0
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; special
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.mul = 0.667
fall = 1
fall.recover = 1
fall.recovertime = 120
yaccel = 0.4850
airguard.ctrltime = 1 + 16
airguard.cornerpush.veloff = 0
airguard.velocity = -6.00, -1.00
p1sprpriority = sprpriority
forcestand = 1

[State 1210, Hit Behind]
type = hitdef
trigger1 = animelem = 7 || animelem = 11 || animelem = 15 || animelem = 19
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 5)
attr = A, SA
damage = 30, 8
dizzypoints = 40 * !map(customcombo)
animtype = Hard
air.animtype = Back
fall.animtype = Back
hitflag = MAF
guardflag = MA
priority = 4, Hit
pausetime = 6, 6
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := -76) * (map(sparkx.max) := -20), map(sparky) := -94
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
ground.velocity = 6.5, -5.0
air.type = Low
air.velocity = 6.5, -5.0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
guard.cornerpush.veloff = 0
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; special
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.mul = 0.667
fall = 1
fall.recover = 1
fall.recovertime = 120
yaccel = 0.4850
airguard.ctrltime = 1 + 16
airguard.cornerpush.veloff = 0
airguard.velocity = -6.00, -1.00
p1sprpriority = sprpriority
forcestand = 1

[State Idle]
type = statetypeset
trigger1 = animelemtime(22) >= 0
movetype = I
persistent = 0

[State Land]
type = changestate
trigger1 = statetype = A
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 1209


;======================<BUSHIN IZUNA OTOSHI>=============================
[Statedef 1300]
type = S
physics = S
movetype = A
anim = 1300
ctrl = 0
velset = 0, 0
sprpriority = 2
facep2 = 1
poweradd = 100 * map(meterscaling)

[State 1300, Strength]
type = mapset
trigger1 = !AIlevel
trigger1 = time <= 0
map = "strength"
value = ifelse(map(cmd_strength_z), 2, ifelse(map(cmd_strength_y), 1, 0))
ignorehitpause = 1
persistent = 0

[State 1300, Strength AI]
type = mapset
trigger1 = AIlevel
trigger1 = time <= 0
map = "strength"
value = ifelse(p2dist x > 240, 2, ifelse(p2dist x > 120, 1, 0))
ignorehitpause = 1

[State 1300, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1300, No proximity block]
type = attackdist
trigger1 = 1
value = 0

[State 1300, Sound]
type = playsnd
trigger1 = animelem =2
value = 0, 40
persistent = 0

[State 1300, Dust]
type = helper
trigger1 = animelem = 2
helpertype = normal
stateno = 7100
ID = 7100
name = "Dust"
postype = p1
ownpal = 1
persistent = 0

[State 1300, Vel]
type = velset
trigger1 = animelemtime(2) = 1
x = ifelse(map(strength) = 2, 9.31, ifelse(map(strength) = 1, 6, 3))
y = ifelse(map(strength) = 2, -9.3, ifelse(map(strength) = 1, -9.9, -11.2))

[State 1300, Sound]
type = playsnd
triggerall = animelemtime(2) >= 0
trigger1 = time = 10
trigger2 = map(strength) = 0 && time = 21
trigger3 = map(strength) = 1 && time = 18
trigger4 = map(strength) = 2 && time = 15
value = 1, 4
;channel = 1
stopongethit = 1
freqmul = 0.90
volumescale = 80

[State 1300, Type]
type = statetypeset
trigger1 = animelem = 2
statetype = A
physics = N

[State Accel]
type = veladd
trigger1 = animelemtime(2) > 1
y = 0.61

[State 1300, Elbow]
type = changestate
triggerall = anim = 1300
triggerall = animelemtime(5) >= 0
triggerall = vel y >= 0
trigger1 = !AIlevel
trigger1 = command = "x" || command = "y" || command = "z"
;command = "~x" || command = "~y" || command = "~z"; not anymore
trigger2 = AIlevel
trigger2 = p2, ctrl = 1
trigger2 = random < 100
trigger3 = AIlevel
trigger3 = p2bodydist x = [-40, 0]
trigger3 = p2dist y = [-40, -p2, const(size.head.pos.y) - 32]
value = 1305

[State Land]
type = changestate
trigger1 = anim = 1300 && animelemtime(3) >= 0
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 1301


;---Land---
[Statedef 1301]
type = S
physics = S
movetype = I
anim = 1301
ctrl = 0
velset = 0, 0
sprpriority = 2
movehitpersist = 1
hitcountpersist = 1

[State 1301, Pos]
type = posset
trigger1 = 1
y = 0

[State 1301, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 1301, Dust]
type = explod
trigger1 = !time
anim = 7102
ID = 7100
sprpriority = -5
postype = p1
scale = 0.5, 0.5
ownpal = 1
pausemovetime = -1
supermovetime = -1

[State 1301, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;=========<IZUNA NO HIJI OTOSHI>==========
[Statedef 1305]
type = A
physics = N
movetype = A
anim = 1305
velset = 0, 0
sprpriority = 2
poweradd = 0
ctrl = 0

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = 1

[State 1305, Sound]
type = playsnd
trigger1 = animelem = 3
value = 3, 5
channel = 0

[State 1305, Sound]
type = playsnd
trigger1 = animelem = 3
value = 1, 2
;channel = 1
stopongethit = 1

[State 1305, Accel]
type = veladd
trigger1 = time > 0
y = 0.61

[State 1305, Grab]
type = hitdef
trigger1 = animelem = 1
trigger1 = !map(unthrowable); can grab behind
ID = 1320
attr = A, ST
hitflag = HAF
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 1)
priority = 7, Miss
sparkno = -1 + 0 * (map(sparkno) := 0)
hitsound = s2, 800
hitsound.channel = 2
sprpriority = 2
p1facing = 1
p2facing = 1
p1stateno = 1320
p2stateno = 1325
fall = 1
fall.recover = 1
fall.recovertime = 120
numhits = 0

[State 1305, Hit]
type = hitdef
trigger1 = animelem = 3
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 3)
attr = A, SA
damage = 80, 20
dizzypoints = 100 * !map(customcombo)
animtype = Medium
guardflag = HA
hitflag = MAF
priority = 4, Hit
pausetime = 12, 12
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 10) * (map(sparkx.max) := 25), map(sparky) := -53
hitsound = s2, 3
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
ground.velocity = -7.51
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
air.type = Low
air.velocity = -4, -3.7
getpower = ifelse(movehit, 25, 100) * map(meterscaling), ifelse(moveguarded, 25, 50) * map(meterscaling)
givepower = 40, 40
envshake.time = 12; special
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.mul = 0.667
air.fall = 1
fall.recover = 1
fall.recovertime = 120
yaccel = 0.4850
p1sprpriority = sprpriority
forcestand = 1

[State Land]
type = changestate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 1301


;======================<IZUNA OTOSHI>=============================
;----- PLAYER -----
[Statedef 1320]
type = A
physics = N
movetype = A
anim = 1320
ctrl = 0
velset = 0, 0
sprpriority = 2

[State Throw]
type = targetstate
trigger1 = !time
value = 1325

[State 1320, Sound]
type = playsnd
trigger1 = !time
value = 3, 8
channel = 0

[State 1320, EX Version Flag]
type = varset
trigger1 = !time
var(0) = prevstateno = 1350

[State 1320, Vel]
type = velset
trigger1 = !time;!vel x && animelemtime(4) < 0
x = ((target, pos x -pos x) * facing + target, const(size.mid.pos.x) + 41) / 5.0
y = (target, pos y + target, const(size.mid.pos.y) - pos y + 12) / 5.0

[State 1320, Bind 1]
type = bindtotarget
trigger1 = animelemtime(4) >= 0 && animelemtime(5) < 0
pos = (-41 * const(size.xscale)) + (target, const(size.mid.pos.x)), 12 + (target, const(size.mid.pos.y))

[State 1320, Vel]
type = velset
trigger1 = animelemtime(4) >= 0 && animelemtime(5) < 0
x = 0
y = 0

[State 1320, Accel]
type = veladd
trigger1 = animelemtime(5) >= 0
y = 1

[State 1320, Vel]
type = velset
trigger1 = animelem = 5
x = 4
y = -10

[State 1320, Bind 5]
type = targetbind
trigger1 = animelemtime(5) >= 0 && animelemtime(6) < 0
pos = -35 * const(size.xscale), -13

[State 1320, Bind 6]
type = targetbind
trigger1 = animelemtime(6) >= 0 && animelemtime(7) < 0
pos = -49 * const(size.xscale), -31

[State 1320, Bind 7]
type = targetbind
trigger1 = animelemtime(7) >= 0 && animelemtime(8) < 0
pos = -54 * const(size.xscale), -66

[State 1320, Bind 8]
type = targetbind
trigger1 = animelemtime(8) >= 0 && animelemtime(9) < 0
pos = -44 * const(size.xscale), -94

[State 1320, Bind 9]
type = targetbind
trigger1 = animelemtime(9) >= 0
pos = -9 * const(size.xscale), -113

[State 1320, End]
type = changestate
trigger1 = animelemtime(5) > 0 && vel y > 0 && (pos y > -vel y)
value = 1321


;----- HIT FLOOR -----
[Statedef 1321]
type = C
physics = C
movetype = A
anim = 1321
ctrl = 0
velset = 0, 0
sprpriority = 2

[State 1321, Width]
type = width
trigger1 = 1
edge = ceil(100 * const(size.xscale))

[State 1321, Throw]
type = targetstate
trigger1 = !time
value = 1326

[State 1321, Pos]
type = posadd
trigger1 = !time
x = -34 * const(size.xscale)

[State 1321, Pos]
type = posset
trigger1 = 1
y = 0

[State 1321, Dust]
type = explod
trigger1 = !time
anim = 7102
ID = 7102
sprpriority = -2
postype = p1
pos = ceil(16 * const(size.xscale)), 0
ownpal = 1
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1

[State 1321, Sound]
type = playsnd
trigger1 = !time
value = 5, 1

[State 1321, Dust]
type = helper
trigger1 = map(cfg_sparks)
trigger1 = time = 1; delay for corner
helpertype = normal
stateno = 8110
ID = 8110
name = "Impact Dust"
postype = p1
pos = 88 * const(size.xscale), 0
ownpal = 1

[State 1321, Dust]
type = explod
trigger1 = !map(cfg_sparks)
trigger1 = time = 1
anim = F 62
postype = p1
pos = 88 * const(size.xscale), 0
sprpriority = -10
ownpal = 1

[State 1321, Shake]
type = envshake
trigger1 = !time
time = 24
freq = 180
ampl = -4
mul = 0.85

[State 1321, Bind 1]
type = targetbind
trigger1 = animelem = 1
pos = 88 * const(size.xscale), -4

[State 1321, Hit]
type = hitadd
trigger1 = animelem = 1
value = 1

[State 1321, Damage]
type = targetlifeadd
trigger1 = !time
value = floor(-ifelse((map(strength) = 3), 140, 120) * map(damagescaling))
dizzy = 0

[State 1321, Stun Damage]
type = targetdizzypointsadd
trigger1 = !time
trigger1 = numtarget
value = floor(-150 * map(damagescaling)) * !map(customcombo)

[State 1321, Give Power]
type = targetpoweradd
trigger1 = animelem = 1
value = 40; givepower

[State 1321, Get Power]
type = poweradd
trigger1 = animelem = 1
trigger1 = !map(customcombo)
trigger1 = !var(0);not EX version
value = 200 * map(meterscaling); getpower

[State 1321, Sound]
type = playsnd
trigger1 = !time
value = 3, 6
channel = 0

[State 1321, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;----- TARGET -----
[Statedef 1325]
type = A
physics = N
movetype = H
velset = 0, 0
ctrl = 0
sprpriority = 0

[State 1325, Anim]
type = changeanim2
trigger1 = !time
value = 1325

[State 1325, Camera]
type = screenbound
trigger1 = 1
value = 1
movecamera = 0, 0

[State 1325, Safety]
type = selfstate
trigger1 = time >= 180
value = 5040


;----- TARGET HIT FLOOR -----
[Statedef 1326]
type = A
physics = N
movetype = H
velset = 0, 0
ctrl = 0
sprpriority = 0

[State 1326, Anim]
type = changeanim2
trigger1 = !time
value = 1326

[State 1326, Vel]
type = velset
trigger1 = animelem = 2
x = -4.17
y = -6.76

[State 1326, Vel]
type = velset
trigger1 = animelem = 2
trigger1 = gethitvar(chainID) = 1350
x = -2.5
y = -8.5

[State 1326, Accel]
type = veladd
trigger1 = animelemtime(2) > 0
y = 0.6

[State 1326, Dizzy Start]
type = dizzyset
trigger1 = alive
trigger1 = life > 0
trigger1 = dizzypoints <= 0
trigger1 = !gethitvar(isbound)
value = 1

[State 1326, Fall Recovery]
type = selfstate
trigger1 = animelemtime(2) > 0
trigger1 = alive = 1 && dizzy = 0 && dizzypoints > 0
trigger1 = gethitvar(fall.recover)
trigger1 = command = "recovery"
trigger1 = vel y > 0
trigger1 = pos y >= const(movement.air.gethit.groundrecover.ground.threshold)
value = 5200

[State 1326, End]
type = selfstate
trigger1 = animelemtime(2) > 0
trigger1 = vel y > 0 && (pos y > -vel y)
value = 5100


;======================<EX BUSHIN IZUNA OTOSHI>=============================
[Statedef 1350]
type = S
physics = S
movetype = A
anim = 1350
ctrl = 0
velset = 0, 0
sprpriority = 2
facep2 = 1
poweradd = -500

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = 1

[State 1350, Strength]
type = mapset
trigger1 = time <= 0
map = "strength"
value = 3
ignorehitpause = 1
persistent = 0

[State 1350, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1350, Custom Combo End]
type = palfx
trigger1 = !time
trigger1 = map(customcombo) > 0
trigger1 = (map(customcombo) := 0) || (map(juggle_count) := 0) || 1
time = 1

[State 1350, EX FX]
type = playsnd
trigger1 = !time
value = 0, 1000

[State 1350, EX FX]
type = explod
trigger1 = !time
trigger1 = 1 || map(exflash) := 30
anim = 7210
sprpriority = 3
postype = p1
pos = ceil(4 * const(size.xscale)), ceil(-62 * const(size.yscale))
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 1350, Sound]
type = playsnd
trigger1 = animelem = 2
value = 0, 40
persistent = 0

[State 1350, Dust]
type = helper
trigger1 = animelem = 2
helpertype = normal
stateno = 7100
ID = 7100
name = "Dust"
postype = p1
ownpal = 1
persistent = 0

[State 1350, Turn]
type = turn
trigger1 = animelem = 3
trigger1 = p2dist x < 0

[State Accel]
type = veladd
trigger1 = animelemtime(2) >= 0
y = 0.9

[State 1350, Vel]
type = velset
trigger1 = animelem = 2
x = 6
y = -12

[State 1350, Vel]
type = velset
trigger1 = animelem = 2
x = (min(p2dist x, 290) + 40) / 26.0; +40 because he tries to land behind P2
y = -12

[State 1350, Vel]
type = velset
trigger1 = vel x < 0
x = 0

[State 1350, Type]
type = statetypeset
trigger1 = animelem = 2
statetype = A
physics = N

[State 1350, Sound]
type = playsnd
trigger1 = animelemtime(2) >= 0
trigger1 = time = 10 || time = 18
value = 1, 4
;channel = 1
stopongethit = 1
freqmul = 0.90
volumescale = 80

[State 1350, No proximity block]
type = attackdist
trigger1 = 1
value = 0

[State 1350, Miss]
type = hitdef
trigger1 = vel y >= 0
trigger1 = animelemtime(5) >= 0
attr = A, ST
hitflag =

[State 1350, Hit]
type = hitdef
trigger1 = vel y >= 0
trigger1 = animelemtime(5) >= 0
trigger1 = !map(unthrowable); can grab behind
ID = 1350
attr = A, ST
hitflag = HAF
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 2)
priority = 7, Miss
sparkno = -1 + 0 * (map(sparkno) := 0)
hitsound = s2, 800
hitsound.channel = 2
sprpriority = 2
p1facing = 1
p2facing = 1
p1stateno = 1320
p2stateno = 1325
fall = 1
fall.recover = 1
fall.recovertime = 120
numhits = 0

[State Land]
type = changestate
trigger1 = animelemtime(2) >= 0
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 1301


;=========<HASSOU KYAKU>==========
[Statedef 1400]
type = A
physics = N
movetype = A
anim = 1400
ctrl = 0
velset = 0, 0
sprpriority = 2
juggle = ifelse(p2statetype = L && !map(customcombo), 8, 0)

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = 1

[State 1400, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_special) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 1400, Turn]
type = turn
trigger1 = !time
trigger1 = frontedgedist < backedgedist

[State 1400, Pos]
type = posadd
trigger1 = animelemtime(2) < 0
trigger1 = backedgebodydist =[-80, 80]
x = backedgebodydist

[State 1400, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 1400, Dust]
type = explod
trigger1 = !time
anim = 7101
ID = 7101
sprpriority = 3
postype = p1
pos = ceil(-22 * const(size.xscale)), -33
ownpal = 1
scale = 0.66, 0.66
pausemovetime = -1
supermovetime = -1

[State 1400, Vel]
type = velset
trigger1 = animelemtime(3) >= 0
x = 8
y = 8

[State 1400, Sound]
type = playsnd
trigger1 = animelem = 2
value = 3, 8
channel = 0

[State 1400, Sound]
type = playsnd
trigger1 = animelem = 2
value = 0, 41
;channel = 1
stopongethit = 1

[State 1400, Hit]
type = hitdef
trigger1 = animelem = 3
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 2)
attr = A, SA
damage = 110, 28
dizzypoints = 200 * !map(customcombo)
animtype = Hard
guardflag = HA
hitflag = MAFD
priority = 4, Hit
pausetime = 12, 12
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 20) * (map(sparkx.max) := 60), map(sparky) := -14
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
ground.velocity = -10.52
air.type = Low
air.velocity = -3, -4.7
down.hittime = 20
down.velocity = 0, 0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
getpower = ifelse(movehit, 25, 100) * map(meterscaling), ifelse(moveguarded, 25, 50) * map(meterscaling)
givepower = 40, 40
envshake.time = 12; special
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.mul = 0.667
fall = 0
air.fall = 1
fall.recover = 1
fall.recovertime = 120
yaccel = 0.4850
p1sprpriority = sprpriority
forcestand = 1

[State Land]
type = changestate
trigger1 = animelemtime(2) >= 0
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 1401


;---Land---
[Statedef 1401]
type = S
physics = S
movetype = I
anim = 1117
ctrl = 0
velset = 0, 0
sprpriority = 2
movehitpersist = 1
hitcountpersist = 1

[State 1401, Pos]
type = posset
trigger1 = 1
y = 0

[State 1401, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 1401, Dust]
type = explod
trigger1 = !time
anim = 7102
ID = 7100
sprpriority = -5
postype = p1
scale = 0.5, 0.5
ownpal = 1
pausemovetime = -1
supermovetime = -1

[State 1401, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;========================<PUNCH ZERO COUNTER>=============================
[Statedef 2900]
type = S
physics = N
movetype = A
anim = 2900
ctrl = 0
velset = 0, 0
sprpriority = 2
poweradd = 0

[State 2900, NHB]
type = nothitby
trigger1 = animelemtime(3) < 0
value = SCA
time = 1
ignorehitpause = 1

[State 2900, Sound]
type = playsnd
trigger1 = animelem = 2
value = 3, 5
channel = 0

[State 2900, Sound]
type = playsnd
trigger1 = animelem = 3
value = 1, 3
;channel = 1
stopongethit = 1

[State 2900, Hit]
type = hitdef
trigger1 = animelem = 3
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 1)
attr = S, SA
hitflag = MAF
guardflag = M
priority = 4, Hit
damage = 50, 13
dizzypoints = 0
getpower = 0, 0
givepower = 40, 40
pausetime = 12, 12
guard.pausetime = 12, 12
animtype = Diagup
air.animtype = Diagup
fall.animtype = Diagup
ground.type = Low
air.type = Low
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
air.hittime = 120
ground.velocity = -5.54, -5.25
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
guard.cornerpush.veloff = 0
air.velocity = -5.54, -5.25
air.cornerpush.veloff = 0
yaccel = 0.4850
fall = 1
fall.recover = 1
fall.recovertime = 120
forcestand = 1
hitsound = s2, 3
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 60) * (map(sparkx.max) := 110), map(sparky) := -66
envshake.time = 10
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.freq = 180
kill = 0

[State 2900, Type]
type = statetypeset
trigger1 = animelem = 4
movetype = I

[State 2900, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;========================<KICK ZERO COUNTER>=============================
[Statedef 2910]
type = S
physics = N
movetype = A
anim = 2910
ctrl = 0
velset = 0, 0
sprpriority = 2
poweradd = 0

[State 2910, NHB]
type = nothitby
trigger1 = animelemtime(3) < 0
value = SCA
time = 1
ignorehitpause = 1

[State 2910, Sound]
type = playsnd
trigger1 = animelem = 2
value = 3, 5
channel = 0

[State 2910, Sound]
type = playsnd
trigger1 = animelem = 2
value = 1, 3
;channel = 1
stopongethit = 1

[State 2910, Hit]
type = hitdef
trigger1 = animelem = 3
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 1)
attr = S, SA
hitflag = MAF
guardflag = M
priority = 4, Hit
damage = 50, 13
dizzypoints = 0
getpower = 0, 0
givepower = 40, 40
pausetime = 12, 12
guard.pausetime = 12, 12
animtype = Diagup
air.animtype = Diagup
fall.animtype = Diagup
ground.type = Low
air.type = Low
ground.hittime = 1 + 18; + 2 * map(counterhit_buffer)
ground.slidetime = 18
air.hittime = 120
ground.velocity = -5.54, -5.25
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
guard.cornerpush.veloff = 0
air.velocity = -5.54, -5.25
air.cornerpush.veloff = 0
yaccel = 0.4850
fall = 1
fall.recover = 1
fall.recovertime = 120
forcestand = 1
hitsound = s2, 3
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
sparkno = -1 + 0 * (map(sparkno) := 8013)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 60) * (map(sparkx.max) := 102), map(sparky) := -42
envshake.time = 10
envshake.ampl = ifelse((gametime % 2), -2, 2)
envshake.freq = 180
kill = 0

[State 2910, Type]
type = statetypeset
trigger1 = animelem = 4
movetype = I

[State 2910, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1
