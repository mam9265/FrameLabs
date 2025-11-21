; ______________________________
;| Guy by Phantom.of.the.Server |
; ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
;==============================================================================================
;========================================<SUPER STATES>========================================
;==============================================================================================

;======================<BUSHIN GOURAI KYAKU>=============================
[Statedef 3000]
type = S
physics = N
movetype = A
ctrl = 0
anim = 3000
velset = 0, 0
poweradd = -1000 + 0 * (map(superlevel) := 1)
sprpriority = 2
facep2 = 1

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = ifelse((prevstateno = [3000, 4999]), 3, ifelse((prevstateno = [1000, 2999]) && !map(customcombo), 2, 1))

[State Cancel Flags]
type = null
trigger1 = time <= 0
trigger1 = 1 || map(supercancelflag) := (prevstateno = [1000, 2999] && map(supercancel) && !map(customcombo))
trigger1 = 1 || map(hypercancelflag) := (prevstateno = [3000, 4999] && map(hypercancel))
ignorehitpause = 1
persistent = 0

[State Super Cancel Flash]
type = palfx
trigger1 = time % 2
trigger1 = time = [1, 11]
trigger1 = map(supercancelflag) || map(hypercancelflag)
trigger1 = 1 || map(juggle_count) := 0
time = 1
add = 255, 255, 255
ignorehitpause = 1

[State 3000, Custom Combo End]
type = palfx
trigger1 = !time
trigger1 = map(customcombo) > 0
trigger1 = (map(customcombo) := 0) || (map(juggle_count) := 0) || 1
time = 1

[State 3000, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_super) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 3000, Sound]
type = playsnd
trigger1 = time = 3
value = 4, 1
channel = 0

[State 3000, Super Pause FX]
type = helper
trigger1 = map(cfg_superfx)
trigger1 = time = 3
helpertype = normal
stateno = 8500
ID = 8500
name = "Superpause FX"
postype = p1
pos = 32 * const(size.xscale), -68 * const(size.yscale)
supermovetime = 255
size.xscale = 1
size.yscale = 1
ownpal = 1

[State 3000, Super Pause]
type = superpause
trigger1 = time = 3
time = 41
movetime = 41
anim = ifelse(map(cfg_superfx), -1, 100)
pos = 32 * const(size.xscale), -68 * const(size.yscale)
sound = s0, 8500
p2defmul = 1
darken = !map(cfg_superfx)

[State 3000, NHB]
type = nothitby
trigger1 = anim = 3000
trigger1 = animelemtime(2) < 0
time = 1
value = SCA
ignorehitpause = 1

[State 3000, Vel]
type = velmul
trigger1 = anim = 3000
trigger1 = animelemtime(20) < 0
x = 0.6

[State 3000, Vel]
type = velset
trigger1 = anim = 3000
trigger1 = animelem = 2
x = 9

[State 3000, Vel]
type = velset
trigger1 = anim = 3000
trigger1 = animelem = 4 || animelem = 8 || animelem = 12 || animelem = 16
x = 18

[State 3000, Vel]
type = velset
trigger1 = anim = 3000
trigger1 = animelem = 20
x = -5
y = -4

[State 3000, Type]
type = statetypeset
trigger1 = anim = 3000
trigger1 = animelem = 17
statetype = A
physics = N

[State 3000, Accel]
type = veladd
trigger1 = anim = 3000
trigger1 = animelemtime(20) > 0
y = 0.55

[State 3000, Anim]
type = changeanim
trigger1 = anim = 3000
trigger1 = animelemtime(20) > 0
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 3001
persistent = 0

[State 3000, Type]
type = statetypeset
trigger1 = anim = 3001
trigger1 = animelemtime(3) < 0
statetype = S
physics = S

[State 3000, Vel]
type = velset
trigger1 = anim = 3001
trigger1 = animelemtime(3) < 0
x = 0
y = 0

[State 3000, Pos]
type = posset
trigger1 = anim = 3001
trigger1 = animelemtime(3) < 0
y = 0

[State 3000, Type]
type = statetypeset
trigger1 = anim = 3001
trigger1 = animelem = 3
statetype = A
physics = N

[State Accel]
type = veladd
trigger1 = anim = 3001
trigger1 = animelemtime(3) >= 0
y = 0.45

[State 3000, Vel]
type = velset
trigger1 = anim = 3001
trigger1 = animelemtime(3) = 0
x = 10
y = -4.55

[State 3000, Vel]
type = velset
trigger1 = anim = 3001
trigger1 = animelemtime(5) >= 0 && animelemtime(6) < 0
y = 0

[State 3000, Trail]
type = explod
trigger1 = anim = 3001
trigger1 = animelem = 5
anim = 1121
sprpriority = 3
postype = p1
scale = const(size.xscale), const(size.yscale)
removeongethit = 1
ignorehitpause = 1
persistent = 0

[State 3000, Sound]
type = playsnd
trigger1 = anim = 3000
trigger1 = animelem = 2 || animelem = 6 || animelem = 10
value = 3, 8
channel = 0

[State 3000, Sound]
type = playsnd
trigger1 = anim = 3000
trigger1 = animelem = 13 || animelem = 17 || animelem = 19
value = 3, 4
channel = 0

[State 3000, Sound]
type = playsnd
trigger1 = anim = 3001
trigger1 = animelem = 4
value = 3, 7
channel = 0

[State 3000, Sound]
type = playsnd
trigger1 = anim = 3000
trigger1 = animelem = 2
value = 1, 1
;channel = 1
stopongethit = 1

[State 3000, Sound]
type = playsnd
trigger1 = anim = 3000
trigger1 = animelem = 6 || animelem = 13
value = 1, 2
;channel = 1
stopongethit = 1

[State 3000, Sound]
type = playsnd
trigger1 = anim = 3000
trigger1 = animelem = 10
value = 1, 3
;channel = 1
stopongethit = 1

[State 3000, Sound]
type = playsnd
trigger1 = anim = 3000
trigger1 = animelem = 17
value = 1, 5
;channel = 1
stopongethit = 1

[State 3000, Sound]
type = playsnd
trigger1 = anim = 3000
trigger1 = animelem = 19
trigger2 = anim = 3001 && animelem = 5
value = 1, 6
;channel = 1
stopongethit = 1

[State 3000, Hit High]
type = hitdef
trigger1 = anim = 3000
trigger1 = animelem = 2 || animelem = 10 || animelem = 19
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 4)
attr = S, HA
damage = 35, 9
dizzypoints = 0
animtype = Hard
hitflag = MAF
guardflag = M
priority = 4, Hit
pausetime = ifelse((animelem = 10), 12, 4), ifelse((animelem = 10), 12, 4)
sparkno = -1 + 0 * (map(sparkno) := 8014)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 70) * (map(sparkx.max) := 100), map(sparky) := ifelse((animelem = 2), -92, ifelse((animelem = 10), -76, -65))
hitsound = s2, ifelse((animelem = 19), 6, 3)
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 32
ground.slidetime = 12
ground.velocity = -4.49, 0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
air.type = Low
air.velocity = ifelse((animelem = 19), -1, -3), ifelse((animelem = 19), -7.2, -2.7)
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; super
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -4, 4)
envshake.mul = 0.667
p1sprpriority = sprpriority
forcestand = 1
air.fall = 1
fall.recover = 0
down.recover = 1
yaccel = 0.4850

[State 3000, Hit Low]
type = hitdef
trigger1 = anim = 3000
trigger1 = animelem = 6 || animelem = 13 || animelem = 17
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 4)
attr = S, HA
damage = 35, 9
dizzypoints = 0
animtype = Hard
hitflag = MAF
guardflag = M
priority = 4, Hit
pausetime = 4, 4
sparkno = -1 + 0 * (map(sparkno) := 8014)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 70) * (map(sparkx.max) := 100), map(sparky) := ifelse((animelem = 17), -60, -58)
hitsound = s2, ifelse((animelem = 17), 6, 3)
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = Low
ground.hittime = 32
ground.slidetime = 12
ground.velocity = -4.49
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
air.type = Low
air.velocity = -3, -2.7
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; super
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -4, 4)
envshake.mul = 0.667
p1sprpriority = sprpriority
forcestand = 1
air.fall = 1
fall.recover = 0
down.recover = 1
yaccel = 0.4850

[State 3000, Hit Final]
type = hitdef
trigger1 = anim = 3001
trigger1 = animelem = 5
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 4)
attr = A, HA
damage = 30, 8
dizzypoints = 0
animtype = Diagup
hitflag = MAF
guardflag = M
priority = 4, Hit
pausetime = 14 / ((map(customcombo) > 0) + 1), 14 / ((map(customcombo) > 0) + 1)
sparkno = -1 + 0 * (map(sparkno) := 8014)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 30) * (map(sparkx.max) := 88), map(sparky) := -81
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18
ground.slidetime = 18
ground.velocity = -6, -5.7
air.type = Low
air.velocity = -6, -5.7
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
guard.cornerpush.veloff = 0
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; super
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -4, 4)
envshake.mul = 0.667
fall = 1
fall.recover = 0
down.recover = 1
yaccel = 0.4850
p1sprpriority = sprpriority
forcestand = 1

[State 3000, Sound]
type = playsnd
trigger1 = anim = 3001
trigger1 = animelem = 1
value = 0, 52
persistent = 0

[State 3000, Dust]
type = explod
trigger1 = anim = 3001
trigger1 = animelem = 1
anim = 7102
ID = 7102
sprpriority = -2
postype = p1
ownpal = 1
scale = 0.5, 0.5
persistent = 0
pausemovetime = -1
supermovetime = -1

[State 3000, Sound]
type = playsnd
trigger1 = anim = 3001
trigger1 = animelem = 3
value = 0, 41

[State 3000, Dust]
type = helper
trigger1 = anim = 3001
trigger1 = animelem = 3
helpertype = normal
stateno = 7100
ID = 7100
name = "Dust"
postype = p1
ownpal = 1

[State 3000, Idle]
type = statetypeset
trigger1 = anim = 3001
trigger1 = animelemtime(6) >= 0
movetype = I
persistent = 0

[State Land]
type = changestate
trigger1 = anim = 3001
trigger1 = animelemtime(6) >= 0
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 3002


;---Land---
[Statedef 3002]
type = S
physics = S
movetype = I
anim = 3002
ctrl = 0
velset = 0, 0
sprpriority = 2
movehitpersist = 1
hitcountpersist = 1

[State 3002, Pos]
type = posset
trigger1 = 1
y = 0

[State 3002, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 3002, Dust]
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

[State 3002, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;======================<BUSHIN HASSOU KEN>=============================
[Statedef 3050]
type = A
physics = N
movetype = A
ctrl = 0
anim = 3050
velset = 0, 0
poweradd = -1000 + 0 * (map(superlevel) := 1)
sprpriority = 2

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = ifelse((prevstateno = [3000, 4999]), 3, ifelse((prevstateno = [1000, 2999]) && !map(customcombo), 2, 1))

[State Cancel Flags]
type = null
trigger1 = time <= 0
trigger1 = 1 || map(supercancelflag) := (prevstateno = [1000, 2999] && map(supercancel) && !map(customcombo))
trigger1 = 1 || map(hypercancelflag) := (prevstateno = [3000, 4999] && map(hypercancel))
ignorehitpause = 1
persistent = 0

[State Super Cancel Flash]
type = palfx
trigger1 = time % 2
trigger1 = time = [1, 11]
trigger1 = map(supercancelflag) || map(hypercancelflag)
trigger1 = 1 || map(juggle_count) := 0
time = 1
add = 255, 255, 255
ignorehitpause = 1

[State 3050, Custom Combo End]
type = palfx
trigger1 = !time
trigger1 = map(customcombo) > 0
trigger1 = (map(customcombo) := 0) || (map(juggle_count) := 0) || 1
time = 1

[State 3050, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_super) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 3050, Sound]
type = playsnd
trigger1 = time = 3
value = 4, 1
channel = 0

[State 3050, Super Pause FX]
type = helper
trigger1 = map(cfg_superfx)
trigger1 = time = 3
helpertype = normal
stateno = 8500
ID = 8500
name = "Superpause FX"
postype = p1
pos = ceil(22 * const(size.xscale)), ceil(-99 * const(size.yscale))
supermovetime = 255
size.xscale = 1
size.yscale = 1
ownpal = 1

[State 3050, Super Pause]
type = superpause
trigger1 = time = 3
time = 41
movetime = 41
anim = ifelse(map(cfg_superfx), -1, 100)
pos = ceil(22 * const(size.xscale)), ceil(-99 * const(size.yscale))
sound = s0, 8500
p2defmul = 1
darken = !map(cfg_superfx)

[State 3050, NHB]
type = nothitby
trigger1 = anim = 3050
trigger1 = animelemtime(5) < 0
time = 1
value = SCA
ignorehitpause = 1

[State 3050, Sound]
type = playsnd
trigger1 = animelem = 3
value = 0, 41

[State 3050, Dust]
type = helper
trigger1 = animelem = 3
helpertype = normal
stateno = 7100
ID = 7100
name = "Dust"
postype = p1
ownpal = 1

[State 3050, Accel]
type = veladd
trigger1 = animelemtime(3) >= 0
trigger1 = animelemtime(5) < 0
x = -0.66
y = 1.1

[State 3050, Vel]
type = velset
trigger1 = animelem = 3
x = 12
y = -12

[State 3050, Vel]
type = velset
trigger1 = animelemtime(7) >= 0
trigger1 = animelemtime(37) < 0
x = 1.5
y = -1.5

[State 3050, Anim]
type = changeanim
trigger1 = animelem = 7 && !movecontact
trigger2 = animelem = 13 || animelem = 19 || animelem = 22 || animelem = 33
trigger2 = (movecontact != [1, 12]) && (movereversed != [1, 12])
value = 3050
elem = 37

[State 3050, Anim]
type = velset
trigger1 = animelem = 37
x = 0
y = 0

[State 3050, trail]
type = explod
trigger1 = animelem = 35
anim = 1121
sprpriority = 3
postype = p1
scale = const(size.xscale), const(size.yscale)
pos = 0, -10
removeongethit = 1
ignorehitpause = 1
persistent = 0

[State 3050, Sound]
type = playsnd
trigger1 = animelem = 5 || animelem = 10 || animelem = 15
value = 3, 8
channel = 0

[State 3050, Sound]
type = playsnd
trigger1 = animelem = 20 || animelem = 26
value = 3, 6
channel = 0

[State 3050, Sound]
type = playsnd
trigger1 = animelem = 35
value = 3, 4
channel = 0

[State 3050, Sound]
type = playsnd
trigger1 = animelem = 10
value = 1, 2
;channel = 1
stopongethit = 1

[State 3050, Sound]
type = playsnd
trigger1 = animelem = 5 || animelem = 15
value = 1, 3
;channel = 1
stopongethit = 1

[State 3050, Sound]
type = playsnd
trigger1 = animelem = 20
value = 1, 3
;channel = 1
stopongethit = 1

[State 3050, Sound]
type = playsnd
trigger1 = animelem = 24
value = 1, 5
;channel = 1
stopongethit = 1

[State 3050, Sound]
type = playsnd
trigger1 = animelem = 26 || animelem = 35
value = 1, 6
;channel = 1
stopongethit = 1

[State 3050, Hit First]
type = hitdef
trigger1 = animelem = 5
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := (3 + hitcount))
attr = A, HA
damage = 35, 9
dizzypoints = 0
animtype = Hard
air.animtype = Back
fall.animtype = Back
hitflag = MAF
guardflag = M
priority = 4, Hit
pausetime = 6, 6
sparkno = -1 + 0 * (map(sparkno) := 8014)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 30) * (map(sparkx.max) := 69), map(sparky) := -88
hitsound = s2, 3
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18
ground.slidetime = 18
ground.velocity = -1.5, -7.50
air.type = Low
air.velocity = -1.5, ifelse(p2dist y > 0, -7.50, -5.50)
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
guard.cornerpush.veloff = 0
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; super
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -4, 4)
envshake.mul = 0.667
fall = 1
fall.recover = 0
down.recover = 1
p1sprpriority = sprpriority
forcestand = 1

[State 3050, Hit Middle]
type = hitdef
trigger1 = animelem = 10 || animelem = 15 || animelem = 20 || animelem = 26
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := (3 + hitcount))
attr = A, HA
damage = 35, 9
dizzypoints = 0
animtype = Hard
air.animtype = Hard
fall.animtype = Hard
hitflag = MAF
guardflag = M
priority = 4, Hit
pausetime = 6, 6
sparkno = -1 + 0 * (map(sparkno) := 8014)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 30) * (map(sparkx.max) := 88), map(sparky) := -60
hitsound = s2, ifelse((animelem = 20 || animelem = 26), 6, 3)
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18
ground.slidetime = 18
ground.velocity = -1.5, -7.50
air.type = Low
air.velocity = -1.5, ifelse(p2dist y > 0, -5.50, -3.50)
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
guard.cornerpush.veloff = 0
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; super
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -4, 4)
envshake.mul = 0.667
fall = 1
fall.recover = 0
down.recover = 1
p1sprpriority = sprpriority
forcestand = 1

[State 3050, Hit Middle High Anim]
type = modifyhitdef
trigger1 = animelem = 10 || animelem = 15 || animelem = 20 || animelem = 26
trigger1 = p2, anim = [5010, 5019]
air.type = High

[State 3050, Hit Final]
type = hitdef
trigger1 = animelem = 35
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := (4 + hitcount))
attr = A, HA
damage = 45, 11
dizzypoints = 0
animtype = Diagup
hitflag = MAF
guardflag = M
priority = 4, Hit
pausetime = 6, 6
sparkno = -1 + 0 * (map(sparkno) := 8014)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 30) * (map(sparkx.max) := 88), map(sparky) := -92
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18
ground.slidetime = 18
ground.velocity = -12, -4
air.type = High
air.velocity = -12, -4
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
guard.cornerpush.veloff = 0
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; super
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -4, 4)
envshake.mul = 0.667
fall = 1
fall.recover = 0
down.recover = 1
yaccel = 0.4850
p1sprpriority = sprpriority
forcestand = 1
p2facing = 1

[State 3050, Slow]
type = pause
trigger1 = animelemtime(34) >= 0
trigger1 = animelemtime(35) < 0
time = 1

[State Idle]
type = statetypeset
trigger1 = animelemtime(36) >= 0
movetype = I
persistent = 0

[State Type]
type = statetypeset
trigger1 = animelemtime(37) >= 0
physics = N

[State Gravity]
type = veladd
trigger1 = animelemtime(37) >= 0
y = 0.6

[State Land]
type = changestate
trigger1 = animelemtime(3) >= 0
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 3059


;---Land---
[Statedef 3059]
type = S
physics = S
movetype = I
anim = 3059
ctrl = 0
velset = 0, 0
sprpriority = 2
movehitpersist = 1
hitcountpersist = 1

[State 3059, Pos]
type = posset
trigger1 = 1
y = 0

[State 3059, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 3059, Dust]
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

[State 3059, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;======================<TESSHINHOU>=============================
[Statedef 3100]
type = S
physics = S
movetype = A
ctrl = 0
anim = 3100
velset = 0, 0
poweradd = -2000 + 0 * (map(superlevel) := 2)
sprpriority = 2
facep2 = 1

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = ifelse((prevstateno = [3000, 4999]), 3, ifelse((prevstateno = [1000, 2999]) && !map(customcombo), 2, 1))

[State Cancel Flags]
type = null
trigger1 = time <= 0
trigger1 = 1 || map(supercancelflag) := (prevstateno = [1000, 2999] && map(supercancel) && !map(customcombo))
trigger1 = 1 || map(hypercancelflag) := (prevstateno = [3000, 4999] && map(hypercancel))
ignorehitpause = 1
persistent = 0

[State Super Cancel Flash]
type = palfx
trigger1 = time % 2
trigger1 = time = [1, 11]
trigger1 = map(supercancelflag) || map(hypercancelflag)
trigger1 = 1 || map(juggle_count) := 0
time = 1
add = 255, 255, 255
ignorehitpause = 1

[State 3100, Custom Combo End]
type = palfx
trigger1 = !time
trigger1 = map(customcombo) > 0
trigger1 = (map(customcombo) := 0) || (map(juggle_count) := 0) || 1
time = 1

[State 3100, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_super) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 3100, Sound]
type = playsnd
trigger1 = time = 3
value = 4, 0
channel = 0

[State 3100, Super Pause FX]
type = helper
trigger1 = map(cfg_superfx)
trigger1 = time = 3
helpertype = normal
stateno = 8510
ID = 8500
name = "Superpause FX"
postype = p1
pos = ceil(22 * const(size.xscale)), ceil(-26 * const(size.yscale))
supermovetime = 255
size.xscale = 1
size.yscale = 1
ownpal = 1

[State 3100, Super Pause]
type = superpause
trigger1 = time = 3
time = 43
movetime = 43
anim = ifelse(map(cfg_superfx), -1, 101)
pos = ceil(22 * const(size.xscale)), ceil(-26 * const(size.yscale))
sound = s0, 8510
p2defmul = 1
darken = !map(cfg_superfx)

[State 3100, NHB]
type = nothitby
trigger1 = time <= 43
time = 10; carries to next state
value = SCA
ignorehitpause = 1

[State 3100, Vel]
type = velset
trigger1 = animelemtime(3) >= 0
x = 11

[State 3100, Sound]
type = playsnd
trigger1 = animelem = 3
value = 0, 100
persistent = 0

[State 3100, Dust]
type = helper
trigger1 = animelem = 3
helpertype = normal
stateno = 7104
ID = 8100
name = "Dash Dust"
postype = p1
pos = ceil(-20 * const(size.xscale)), 0
pausemovetime = 255
supermovetime = 255
ownpal = 1
persistent = 0

[State 3100, Steps]
type = playsnd
trigger1 = animelem = 4 || animelem = 7
value = 0, ifelse((animelem = 4), 103, 106)

[State 3100, Dust]
type = explod
trigger1 = animelem = 4 || animelem = 7
anim = 7101
ID = 7101
sprpriority = 3
postype = p1
pos = ceil(-55 * const(size.xscale)), 0
scale = 0.5, 0.5
ownpal = 1
pausemovetime = -1
supermovetime = -1

[State 3100, Anim]
type = changestate
triggerall = animelemtime(3) >= 0
trigger1 = !AIlevel
trigger1 = command = "/a" || command = "/b" || command = "/c"
trigger2 = AIlevel
trigger2 = p2bodydist x <= 120
value = 3110

[State 3100, End]
type = changestate
triggerall = time >= 53
trigger1 = !AIlevel
trigger1 = command = "x" || command = "y" || command = "z"
trigger2 = frontedgedist <= 0
trigger3 = time >= 90
value = 3101


;----- STOP -----
[Statedef 3101]
type = S
physics = S
movetype = I
anim = 1102
ctrl = 0
sprpriority = 2

[State 3101, Sound]
type = playsnd
trigger1 = !time
value = 5, 0

[State 3101, Dust]
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

[State 3101, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;---Land---
[Statedef 3109]
type = S
physics = S
movetype = I
anim = 3109
ctrl = 0
velset = 0, 0
sprpriority = 2
movehitpersist = 1
hitcountpersist = 1

[State 3109, Pos]
type = posset
trigger1 = 1
y = 0

[State 3109, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 3109, Dust]
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

[State 3109, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;----- Flying Kick -----
[Statedef 3110]
type = A
physics = N
movetype = A
ctrl = 0
anim = 3110
sprpriority = 2

[State Accel]
type = veladd
trigger1 = animelemtime(10) >= 0
y = 0.45

[State 3110, Vel]
type = velset
trigger1 = animelem = 3
x = 8
y = -3

[State 3110, Accel]
type = veladd
trigger1 = animelemtime(3) > 0
y = 0.6

[State 3110, Vel]
type = velset
trigger1 = animelemtime(5) >= 0 && animelemtime(11) < 0
y = 0

[State 3110, Shield]
type = helper
trigger1 = animelem = 5
helpertype = normal
stateno = 3105
ID = 3105
name = "Shield"
postype = p1
size.xscale = 0.5
size.yscale = 0.5
supermovetime = p2, pausetime
ownpal = 1

[State 3110, Sound]
type = playsnd
trigger1 = animelem = 4
value = 3, 4
channel = 0

[State 3110, Sound]
type = playsnd
trigger1 = animelem = 5
value = 1, 6
;channel = 1
stopongethit = 1

[State 3110, Hit]
type = hitdef
trigger1 = animelem = 5 || animelem = 6 || animelem = 7 || animelem = 8 || animelem = 9 || animelem = 10
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := (3 + hitcount))
attr = S, HA
damage = 30, 8
dizzypoints = 0
animtype = Hard
hitflag = MAF
guardflag = M
priority = 4, Hit
pausetime = 4, 4
sparkno = -1 + 0 * (map(sparkno) := 8014)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 50) * (map(sparkx.max) := 100), map(sparky) := -60
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18
ground.slidetime = 12
ground.velocity = -4.49, 0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
air.type = Low
air.velocity = -6.0, -1.0
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; super
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -4, 4)
envshake.mul = 0.667
p1sprpriority = sprpriority
forcestand = 1
air.fall = 1
fall.recover = 0
down.recover = 0; cannot mash
down.recovertime = 30
yaccel = 0.4850

[State 3110, Sound]
type = playsnd
trigger1 = animelem = 3
value = 0, 41
persistent = 0

[State 3110, Continue]
type = changestate
trigger1 = animelemtime(11) >= 0
trigger1 = movehit
value = 3111

[State Idle]
type = statetypeset
trigger1 = animelemtime(11) >= 0
movetype = I
persistent = 0

[State Land]
type = changestate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 3109


;----- Somersault -----
[Statedef 3111]
type = A
physics = N
movetype = A
ctrl = 0
anim = 3111
sprpriority = 2
movehitpersist = 1
hitcountpersist = 1

[State Accel]
type = veladd
trigger1 = animelemtime(4) >= 0
y = 0.4

[State 3111, Friction]
type = velmul
trigger1 = animelemtime(4) >= 0
x = 0.95

[State 3111, Vel]
type = velset
trigger1 = animelemtime(4) < 0
y = 0

[State 3111, Vel]
type = velset
trigger1 = animelemtime(4) = 0
x = 8.0
y = -8.0

[State 3111, Sound]
type = playsnd
trigger1 = animelem = 1 || animelem = 3
value = 3, ifelse((animelem = 1), 3, 5)
channel = 0

[State 3110, Sound]
type = playsnd
trigger1 = animelem = 12
value = 3, 6
channel = 0

[State 3111, Sound]
type = playsnd
trigger1 = animelem = 1 || animelem = 3 || animelem = 12
value = 1, ifelse((animelem = 1), 5, 6)
;channel = 1
stopongethit = 1

[State 3111, Hit 1]
type = hitdef
trigger1 = animelem = 1
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 99)
attr = S, HA
damage = 30, 7
dizzypoints = 0
animtype = Hard
air.animtype = Hard
fall.animtype = Hard
hitflag = MAF
guardflag = M
priority = 4, Hit
pausetime = 8, 8
sparkno = -1 + 0 * (map(sparkno) := 8014)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 30) * (map(sparkx.max) := 97), map(sparky) := -61
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = Low
ground.hittime = 1 + 18
ground.slidetime = 18
ground.velocity = 0.0, 0.0
air.type = Low
air.velocity = 0.0, -3.0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
guard.cornerpush.veloff = 0
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; super
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -4, 4)
envshake.mul = 0.667
fall = 0
air.fall = 1
fall.recover = 0
down.recover = 0; cannot mash
down.recovertime = 30
yaccel = 0.4850
p1sprpriority = sprpriority
forcestand = 1

[State 3111, Hit 2]
type = hitdef
trigger1 = animelem = 3
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 99)
attr = S, HA
damage = 30, 7
dizzypoints = 0
animtype = Hard
air.animtype = Up
fall.animtype = Up
hitflag = MAF
guardflag = M
priority = 4, Hit
pausetime = 8, 8
sparkno = -1 + 0 * (map(sparkno) := 8014)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 30) * (map(sparkx.max) := 97), map(sparky) := -61
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = High
ground.hittime = 1 + 18
ground.slidetime = 18
ground.velocity = -4.0, -8.5
air.type = Low
air.velocity = -4.0, -7.5
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
guard.velocity = -10.52
guard.cornerpush.veloff = 0
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; super
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -4, 4)
envshake.mul = 0.667
fall = 1
fall.recover = 0
down.recover = 0; cannot mash
down.recovertime = 30
yaccel = 0.4850
p1sprpriority = sprpriority
forcestand = 1

[State 3111, Hit Final]
type = hitdef
trigger1 = animelem = 13
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 99)
attr = A, HA
damage = 60, 8
dizzypoints = 0
animtype = Hard
air.animtype = Hard
fall.animtype = Back
hitflag = MAF
guardflag = H
priority = 4, Hit
pausetime = 12, 12
sparkno = -1 + 0 * (map(sparkno) := 8014)
guard.sparkno = -1 + 0 * (map(guard.sparkno) := 8001)
sparkxy = -10 + 0 * (map(sparkx.min) := 20) * (map(sparkx.max) := 81), map(sparky) := -31
hitsound = s2, 6
hitsound.channel = 2
guardsound = s2, 0
guardsound.channel = 2
ground.type = Low
ground.hittime = 1 + 18
ground.slidetime = 18
ground.velocity = -6.0, 6.0
ground.cornerpush.veloff = 0
guard.hittime = 1 + 16
guard.ctrltime = 1 + 16
guard.slidetime = 16
air.type = Low
air.velocity = -6.0, 6.0
guard.velocity = -10.52
guard.cornerpush.veloff = 0
getpower = 0, 0
givepower = 40, 40
envshake.time = 12; super
envshake.freq = 180
envshake.ampl = ifelse((gametime % 2), -4, 4)
envshake.mul = 0.667
fall = 1
fall.recover = 0
down.recover = 0; cannot mash
down.recovertime = 30
yaccel = 0.4850
p1sprpriority = sprpriority
forcestand = 1

[State Idle]
type = statetypeset
trigger1 = animelemtime(14) >= 0
movetype = I
persistent = 0

[State Land]
type = changestate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 3109


;======================<KAITEN IZUNA OTOSHI>=============================
[Statedef 3200]
type = A
physics = N
movetype = A
anim = 3200
ctrl = 0
velset = 0, 0
sprpriority = 2
poweradd = -1000 + 0 * (map(superlevel) := 1)
facep2 = 0

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = ifelse((prevstateno = [3000, 4999]), 3, ifelse((prevstateno = [1000, 2999]) && !map(customcombo), 2, 1))

[State Cancel Flags]
type = null
trigger1 = time <= 0
trigger1 = 1 || map(supercancelflag) := (prevstateno = [1000, 2999] && map(supercancel) && !map(customcombo))
trigger1 = 1 || map(hypercancelflag) := (prevstateno = [3000, 4999] && map(hypercancel))
ignorehitpause = 1
persistent = 0

[State Super Cancel Flash]
type = palfx
trigger1 = time % 2
trigger1 = time = [1, 11]
trigger1 = map(supercancelflag) || map(hypercancelflag)
trigger1 = 1 || map(juggle_count) := 0
time = 1
add = 255, 255, 255
ignorehitpause = 1

[State 3200, Custom Combo End]
type = palfx
trigger1 = !time
trigger1 = map(customcombo) > 0
trigger1 = (map(customcombo) := 0) || (map(juggle_count) := 0) || 1
time = 1

[State 3200, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_super) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 3200, Sound]
type = playsnd
trigger1 = time = 3
value = 4, 1
channel = 0

[State 3200, Super Pause FX]
type = helper
trigger1 = map(cfg_superfx)
trigger1 = time = 3
helpertype = normal
stateno = 8500
ID = 8500
name = "Superpause FX"
postype = p1
pos = ceil(30 * const(size.xscale)), ceil(-60 * const(size.yscale))
supermovetime = 255
size.xscale = 1
size.yscale = 1
ownpal = 1

[State 3200, Super Pause]
type = superpause
trigger1 = time = 3
time = 41
movetime = 41
anim = ifelse(map(cfg_superfx), -1, 100)
pos = ceil(35 * const(size.xscale)), ceil(-70 * const(size.yscale))
sound = s0, 8500
p2defmul = 1
darken = !map(cfg_superfx)
movetime = 45

[State 3200, NHB]
type = nothitby
trigger1 = animelemtime(2) < 1
time = 1
value = SCA

[State 3200, No proximity block]
type = attackdist
trigger1 = 1
value = 0

[State 3200, Hit]
type = hitdef
trigger1 = animelem = 2
air.juggle = 0 * (map(juggle_start) := 1 || map(juggle_increase) := 1 || map(juggle_limit) := 3)
trigger1 = !map(unthrowable) && !map(grabbehind)
trigger1 = map(truebodydistx) <= ceil((70 * const(size.xscale)) - const(size.air.front))
trigger1 = p2dist y = [-60, 20]
attr = A, HT
hitflag = AF
priority = 7, Miss
sparkno = -1 + 0 * (map(sparkno) := 0)
hitsound = s2, 800
hitsound.channel = 2
sprpriority = 2
p1facing = 1
p2facing = 1
p1stateno = 3210
p2stateno = 3220
fall = 1
fall.recover = 0
down.recover = 0; cannot mash
down.recovertime = 30
numhits = 0
ID = 3200

[State 3200, Miss]
type = playsnd
trigger1 = animelem = 3
value = 3, 0
channel = 0

[State 3200, Sound]
type = playsnd
trigger1 = animelem = 3
value = 1, 1
;channel = 1
stopongethit = 1

[State 3200, Accel]
type = veladd
trigger1 = animelemtime(5) >= 0
y = 0.5

[State 3200, Vel]
type = velset
trigger1 = animelem = 5
x = 0
y = -3

[State 3200, Land]
type = changestate
trigger1 = statetype = A
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 3201


;---Land---
[Statedef 3201]
type = S
physics = S
movetype = I
anim = 3201
ctrl = 0
velset = 0, 0
sprpriority = 2
movehitpersist = 1
hitcountpersist = 1

[State 3201, Pos]
type = posset
trigger1 = 1
y = 0

[State 3201, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 3201, Dust]
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

[State 3201, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;----- Grab -----
[Statedef 3210]
type = A
physics = N
movetype = A
anim = 3210
ctrl = 0
velset = 0, 0
sprpriority = 2

[State 3210, Width]
type = width
trigger1 = animelemtime(3) < 0
edge = ceil(50 * const(size.xscale)), ceil(50 * const(size.xscale))

[State 3210, Camera]
type = screenbound
trigger1 = 1
value = 1
movecamera = 0, 1

[State 3210, Turn]
type = turn
trigger1 = animelem = 2
trigger1 = backedgedist > frontedgedist

[State 3210, Throw]
type = targetfacing
trigger1 = !time
trigger2 = animelem = 2
value = -1

[State 3210, Throw]
type = targetstate
trigger1 = !time
value = 3220

[State 3200, Accel]
type = veladd
trigger1 = animelemtime(2) >= 0
y = 0.5

[State 3200, Vel]
type = velset
trigger1 = animelem = 2
x = backedgedist / -16.0
y = -6

[State 3210, Bind 1]
type = targetbind
trigger1 = animelemtime(2) < 0
pos = 34 * const(size.xscale), -76

[State 3210, Bind 2]
type = targetbind
trigger1 = animelemtime(2) >= 0 && animelemtime(3) < 0
pos = -13 * const(size.xscale), -79

[State 3210, Bind 3]
type = targetbind
trigger1 = animelemtime(3) >= 0
pos = -60 * const(size.xscale), -64

[State 3212, Sound]
type = playsnd
trigger1 = animelem = 2
value = 1, 6
;channel = 1
stopongethit = 1

[State 3210, Wall]
type = changestate
triggerall = animelemtime(3) >= 3
trigger1 = time && vel x > 0 && frontedgebodydist <= (50 * const(size.xscale))
trigger2 = time && vel x < 0 && backedgebodydist <= (50 * const(size.xscale))
trigger3 = time >= 120
value = 3211

[State 3210, Safety]
type = changestate
trigger1 = animelemtime(3) >= 3
trigger1 = vel y > 0
trigger1 = pos y > 0
value = 3213


;----- Hit Wall -----
[Statedef 3211]
type = A
physics = N
movetype = A
anim = 3211
ctrl = 0
velset = 0, 0
sprpriority = 2

[State 3211, Camera]
type = screenbound
trigger1 = 1
value = 1
movecamera = 0, 1

[State 3211, Throw]
type = targetstate
trigger1 = !time
value = 3221

[State 3211, Throw]
type = targetfacing
trigger1 = !time
value = -1

[State 3211, Pos]
type = posadd
trigger1 = !time
x = -backedgebodydist + (54 * const(size.xscale))

[State 3211, Pos]
type = posadd
trigger1 = animelem = 2
x = -backedgebodydist

[State 3211, Turn]
type = turn
trigger1 = !time
trigger1 = frontedgedist < backedgedist

[State 3211, Sound]
type = playsnd
trigger1 = !time
value = 3, 3
channel = 0

[State 3211, Sound]
type = playsnd
trigger1 = !time
value = 5, 2

[State 3211, Dust]
type = explod
trigger1 = !time
anim = F 71
postype = p1
pos = -15 - backedgebodydist, -40
sprpriority = -5
ownpal = 1

[State 3211, Horizontal Shake]
type = zoom
trigger1 = time = [1, 12]
scale = 1
pos = 3 * cos(time * pi), 0
lag = 0
stagebound = 1
camerabound = 0

[State 3211, Bind 1]
type = targetbind
trigger1 = animelemtime(1) >= 0 && animelemtime(2) < 0
pos = -54 * const(size.xscale), -40

[State 3211, Bind 2]
type = targetbind
trigger1 = animelemtime(2) >= 0
pos = -24 * const(size.xscale), -70

[State 3211, Hit]
type = hitadd
trigger1 = !time
value = 1

[State 3211, Damage]
type = targetlifeadd
trigger1 = !time
value = floor(-70 * map(damagescaling))
dizzy = 0
kill = 0

[State 3211, Give Power]
type = targetpoweradd
trigger1 = !time
value = 40; givepower

[State 3211, End]
type = changestate
trigger1 = !animtime
value = 3212


;----- Jump off -----
[Statedef 3212]
type = A
physics = N
movetype = A
anim = 3212
ctrl = 0
velset = 0, 0
sprpriority = 2

[State 3212, Camera]
type = screenbound
trigger1 = 1
value = 1
movecamera = 0, 1

[State 3212, Throw]
type = targetstate
trigger1 = !time
value = 3222

[State 3212, Accel]
type = veladd
trigger1 = vel x > 0
x = -0.1

[State 3212, Accel]
type = velset
trigger1 = vel x < 0
x = 0

[State 3212, Accel]
type = veladd
trigger1 = 1
y = 0.5

[State 3212, Vel]
type = velset
trigger1 = !time
x = 5.5
y = -12.5

[State 3212, Offset]
type = offset
triggerall = numtarget(3200)
triggerall = vel y < 0 || (pos y <= -vel y);stop before landing
trigger1 = !animtime
trigger2 = animelemtime(4) >= 0 && animelemtime(5) < 0
trigger3 = animelemtime(7) >= 0 && animelemtime(8) < 0
trigger4 = animelemtime(10) >= 0 && animelemtime(11) < 0
x = ceil(-0.5 * target(3200), const(size.ground.back)) * facing

[State 3212, Offset]
type = offset
triggerall = numtarget(3200)
triggerall = vel y < 0 || (pos y <= -vel y)
trigger1 = animelemtime(6) >= 0 && animelemtime(7) < 0
trigger2 = animelemtime(9) >= 0 && animelemtime(10) < 0
trigger3 = animelemtime(12) >= 0 && animtime
x = ceil(0.5 * target(3200), const(size.ground.back)) * facing

[State 3212, Bind 1]
type = targetbind
trigger1 = animelemtime(2) < 0
pos = -35 * const(size.xscale), -78

[State 3212, Bind 2]
type = targetbind
trigger1 = animelemtime(2) >= 0 && animelemtime(3) < 0
pos = -12 * const(size.xscale), -78

[State 3212, Bind 3]
type = targetbind
trigger1 = animelemtime(3) >= 0 && animelemtime(4) < 0
pos = 60 * const(size.xscale), -63

[State 3212, Bind 4]
type = targetbind
triggerall = numtarget(3200)
trigger1 = !animtime
trigger2 = animelemtime(4) >= 0 && animelemtime(5) < 0
trigger3 = animelemtime(7) >= 0 && animelemtime(8) < 0
trigger4 = animelemtime(10) >= 0 && animelemtime(11) < 0
pos = (0.5 * target(3200), const(size.ground.back)), -28

[State 3212, Bind 5]
type = targetbind
triggerall = numtarget(3200)
trigger1 = animelemtime(5) >= 0 && animelemtime(6) < 0
trigger2 = animelemtime(8) >= 0 && animelemtime(9) < 0
trigger3 = animelemtime(11) >= 0 && animelemtime(12) < 0
pos = 0, -28

[State 3212, Bind 6]
type = targetbind
triggerall = numtarget(3200)
trigger1 = animelemtime(6) >= 0 && animelemtime(7) < 0
trigger2 = animelemtime(9) >= 0 && animelemtime(10) < 0
trigger3 = animelemtime(12) >= 0 && animtime
pos = (-0.5 * target(3200), const(size.ground.back)), -28

[State 3212, Sprite Priority]
type = sprpriority
trigger1 = 1
value = 2

[State 3212, Sprite Priority]
type = sprpriority
trigger1 = animelemtime(5) >= 0 && animelemtime(6) < 0
trigger2 = animelemtime(8) >= 0 && animelemtime(9) < 0
trigger3 = animelemtime(11) >= 0 && animelemtime(12) < 0
value = -1

[State 3212, Sound]
type = playsnd
trigger1 = !time
value = 0, 41
;channel = 1
stopongethit = 1

[State 3212, Sound]
type = playsnd
trigger1 = vel y > 0
value = 3, 7
channel = 0
persistent = 0

[State 3212, Sound]
type = playsnd
trigger1 = vel y > 0
value = 5, 6
persistent = 0

[State 3212, Spiral]
type = explod
trigger1 = vel y > 8
trigger1 = pos y >= -160; stay visible
anim = 3219
ID = 3219
sprpriority = 4
postype = p1
facing = -1
vel = 0, vel y
friction = 0.66, 0.66
scale = 0.5, 0.5
ownpal = 1
persistent = 0

[State 3212, End]
type = changestate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 3213


;----- Hit floor -----
[Statedef 3213]
type = C
physics = C
movetype = A
anim = 3213
ctrl = 0
velset = 0, 0
sprpriority = 2

[State 3213, Turn]
type = turn
trigger1 = !time

[State 3213, Throw]
type = targetfacing
trigger1 = !time
value = 1

[State 3213, Throw]
type = targetstate
trigger1 = !time
value = 3223

[State 3213, Pos]
type = posset
trigger1 = 1
y = 0

[State 3213, Bind 1]
type = posadd
trigger1 = !time
trigger1 = numtarget(3200)
x = target(3200), const(size.ground.back)

[State 3213, Bind 1]
type = targetbind
trigger1 = numtarget(3200)
pos = -(target(3200), const(size.ground.back) + target(3200), const(size.ground.front)), 0

[State 3213, Sound]
type = playsnd
trigger1 = !time
value = 5, 1

[State 3213, Dust]
type = helper
trigger1 = map(cfg_sparks)
trigger1 = !time
trigger1 = numtarget(3200)
helpertype = normal
stateno = 8110
ID = 8110
name = "Impact Dust"
postype = p1
pos = -0.5 * (target(3200), const(size.ground.back) + target(3200), const(size.ground.front)), 0
ownpal = 1

[State 3213, Dust]
type = explod
trigger1 = !map(cfg_sparks)
trigger1 = !time
trigger1 = numtarget(3200)
anim = F 62
postype = p1
pos = -0.5 * (target(3200), const(size.ground.back) + target(3200), const(size.ground.front)), 0
sprpriority = -10
ownpal = 1

[State 3213, Floor Cracks]
type = explod
trigger1 = !time
trigger1 = numtarget(3200)
anim = 8115
ID = 8115
postype = p1
pos = ceil(-0.5 * (target(3200), const(size.ground.back) + target(3200), const(size.ground.front))), 0
scale = ifelse(random < 500, -0.5, 0.5), 0.5
ownpal = 1
under = 1

[State 3213, Shake]
type = envshake
trigger1 = !time
time = 18
freq = 180
ampl = -4
mul = 0.8

[State 3213, Hit]
type = hitadd
trigger1 = !time
value = 1

[State 3213, Damage]
type = targetlifeadd
trigger1 = !time
value = floor(-140 * map(damagescaling))
dizzy = 0

[State 3213, Give Power]
type = targetpoweradd
trigger1 = !time
value = 40; givepower

[State 3213, End]
type = changestate
trigger1 = !animtime
value = 3214


;----- Hop back -----
[Statedef 3214]
type = A
physics = N
movetype = I
anim = 3214
ctrl = 0
velset = 2, -9

[State 3214, Throw]
type = targetstate
trigger1 = !time
value = 3224

[State 3214, Throw]
type = targetfacing
trigger1 = !time
value = 1

[State 3214, Accel]
type = veladd
trigger1 = time
y = 0.55

[State 3214, Land]
type = changestate
trigger1 = statetype = A
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 52


;----- Target grabbed -----
[Statedef 3220]
type = A
physics = N
movetype = H
velset = 0, 0
sprpriority = 0

[State 3220, Camera]
type = screenbound
trigger1 = 1
value = 0
movecamera = 0, 0

[State 3220, Anim]
type = changeanim2
trigger1 = !time
value = 3220

[State 3220, Safety]
type = selfstate
trigger1 = time >= 180
value = 5040


;----- Target hit wall -----
[Statedef 3221]
type = A
physics = N
movetype = H
velset = 0, 0
sprpriority = 0

[State 3221, Camera]
type = screenbound
trigger1 = 1
value = 0
movecamera = 0, 1

[State 3221, Anim]
type = changeanim2
trigger1 = !time
value = 3221

[State 3221, Safety]
type = selfstate
trigger1 = time >= 180
value = 5040


;----- Target jump off -----
[Statedef 3222]
type = A
physics = N
movetype = H
velset = 0, 0
sprpriority = 0

[State 3222, Camera]
type = screenbound
trigger1 = 1
value = 0
movecamera = 0, 1

[State 3222, Anim]
type = changeanim2
trigger1 = !time
value = 3222

[State 3222, Safety]
type = selfstate
trigger1 = time >= 180
value = 5040


;----- Target hit ground -----
[Statedef 3223]
type = A
physics = N
movetype = H
velset = 0, 0
sprpriority = 0

[State 3223, Camera]
type = screenbound
trigger1 = 1
value = 0
movecamera = 1, 1

[State 3223, Anim]
type = changeanim2
trigger1 = !time
value = 3223

[State 3223, Safety]
type = selfstate
trigger1 = time >= 180
value = 5040


;----- Target bounce off -----
[Statedef 3224]
type = A
physics = N
movetype = H
velset = -3, -10
sprpriority = 0

[State 3224, Anim]
type = changeanim2
trigger1 = !time
value = 3224

[State 3224, Accel]
type = veladd
trigger1 = time
y = 0.68

[State 3224, End]
type = selfstate
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = 5100


;======================<BUSHIN MUSOU RENGE>=============================
[Statedef 4000]
type = S
physics = S
movetype = A
anim = 4000
ctrl = 0
velset = 0, 0
poweradd = -3000 + 0 * (map(superlevel) := 3)
facep2 = 1
sprpriority = 2

[State Damage Scaling - Add]
type = mapadd
trigger1 = !time
trigger1 = map(combocheck)
trigger1 = 1 || map(combocheck) := 0
map = "combototal"
value = ifelse((prevstateno = [3000, 4999]), 3, ifelse((prevstateno = [1000, 2999]) && !map(customcombo), 2, 1))

[State Cancel Flags]
type = null
trigger1 = time <= 0
trigger1 = 1 || map(supercancelflag) := (prevstateno = [1000, 2999] && map(supercancel) && !map(customcombo))
trigger1 = 1 || map(hypercancelflag) := (prevstateno = [3000, 4999] && map(hypercancel))
ignorehitpause = 1
persistent = 0

[State Super Cancel Flash]
type = palfx
trigger1 = time % 2
trigger1 = time = [1, 11]
trigger1 = map(supercancelflag) || map(hypercancelflag)
trigger1 = 1 || map(juggle_count) := 0
time = 1
add = 255, 255, 255
ignorehitpause = 1

[State 4000, Custom Combo End]
type = palfx
trigger1 = !time
trigger1 = map(customcombo) > 0
trigger1 = (map(customcombo) := 0) || (map(juggle_count) := 0) || 1
time = 1

[State 4000, Erase Inputs]
type = null
trigger1 = !AIlevel
trigger1 = time <= 0
trigger1 = 1 || map(cmd_erase_motion_super) := 1
trigger1 = 1 || map(cmd_erase_completed) := 1
ignorehitpause = 1
persistent = 0

[State 4000, Sound]
type = playsnd
trigger1 = time = 3
value = 4, 1
channel = 0

[State 4000, Super Pause FX]
type = helper
trigger1 = map(cfg_superfx)
trigger1 = time = 3
helpertype = normal
stateno = 8520
ID = 8500
name = "Superpause FX"
postype = p1
pos = ceil(-23 * const(size.xscale)), ceil(-64 * const(size.yscale))
supermovetime = 255
size.xscale = 1
size.yscale = 1
ownpal = 1

[State 4000, Super Pause]
type = superpause
trigger1 = time = 3
time = 45
movetime = 45
anim = ifelse(map(cfg_superfx), -1, 102)
pos = ceil(-23 * const(size.xscale)), ceil(-64 * const(size.yscale))
sound = s0, 8520
p2defmul = 1
darken = !map(cfg_superfx)

[State 4000, NHB]
type = nothitby
trigger1 = animelemtime(5) < 1
time = 1
value = SCA

[State 4000, Pos]
type = posadd
trigger1 = animelem = 5
x = 16 * const(size.xscale)

[State 4000, Hit]
type = hitdef
trigger1 = animelem = 5
trigger1 = !map(unthrowable) && !map(grabbehind)
trigger1 = map(truebodydistx) <= ceil(30 * const(size.xscale)); this distance accounts for the posadd
ID = 4000
attr = S, HT
hitflag = M
priority = 7, Miss
numhits = 0
sparkno = -1 + 0 * (map(sparkno) := 0)
hitsound = s2, 800
hitsound.channel = 2
p1facing = 1
p2facing = 1
p1stateno = 4010
p2stateno = 4020
animtype = Up
sprpriority = -1
fall = 1
fall.recover = 0
down.recover = 0; cannot mash
down.recovertime = 30

[State 4000, Sound]
type = playsnd
trigger1 = animelem = 6
value = 3, 0
channel = 0

[State 4000, Sound]
type = playsnd
trigger1 = animelem = 6
value = 1, 1
;channel = 1
stopongethit = 1

[State Idle]
type = statetypeset
trigger1 = animelemtime(6) >= 0
movetype = I
persistent = 0

[State 4000, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;----- PLAYER -----
[Statedef 4010]
type = S
physics = N
movetype = A
anim = 4010
ctrl = 0
velset = 0, 0
sprpriority = -1

[State Throw]
type = targetstate
trigger1 = !time
value = 4020

[State 4010, Throw]
type = targetfacing
trigger1 = !time
value = -1

[State 4010, Push]
type = playerpush
trigger1 = 1
value = 0

[State 4010, NHB]
type = nothitby
trigger1 = 1
value = SCA
time = 1

[State 4010, Sprite Priority]
type = sprpriority
trigger1 = animelemtime(2) >= 0
value = 1

[State 4010, fadeout]
type = allpalfx
trigger1 = animelemtime(1) = 10
time = 20
sinadd = -255, -255, -255, 80

[State 4010, Afterimage]
type = afterimagetime
trigger1 = animelemtime(11) < 0
time = 0

[State 4010, BG PalFX]
type = bgpalfx
trigger1 = animelemtime(2) = 0 || animelemtime(3) = 0 || animelemtime(4) = 0 || animelemtime(5) = 0 || animelemtime(6) = 0
trigger2 = animelemtime(7) = 0 || animelemtime(8) = 0 || animelemtime(9) = 0 || animelemtime(10) = 0 || animelemtime(11) = 0
add = 128, 128, 128
sinadd = -512, -512, -512, 80
color = 0
time = 20

[State 4010, Palfx]
type = palfx
trigger1 = animelemtime(2) = 0 || animelemtime(3) = 0 || animelemtime(4) = 0 || animelemtime(5) = 0 || animelemtime(6) = 0
trigger2 = animelemtime(7) = 0 || animelemtime(8) = 0 || animelemtime(9) = 0 || animelemtime(10) = 0 || animelemtime(11) = 0
sinadd = -128, -128, -128, 80
time = 20

[State 4010, Palfx]
type = palfx
trigger1 = animelemtime(12) = -1
add = 0, 0, 0
sinadd = 0, 0, 0, 1
time = 1

[State 4010, BG PalFX]
type = bgpalfx
trigger1 = animelemtime(12) = -1
add = 0, 0, 0
sinadd = 0, 0, 0, 1
color = 256
time = 1

[State 4010, Sound Music]
type = playsnd
trigger1 = animelem = 2
value = 5, 8
abspan = 0

[State 4010, Camera]
type = posadd
trigger1 = animelem = 2
trigger1 = frontedgedist < 160
x = frontedgedist - 160

[State 4010, Zoom]
type = zoom
trigger1 = numtarget(4000)
trigger1 = animelemtime(11) < 0
scale = 1.20 / camerazoom
;pos = (pos x + target(4000), pos x) / 2.0 * camerazoom, 0
pos = target(4000), pos x * camerazoom, 0
camerabound = 0
stagebound = 1
lag = ifelse(animelemtime(2) < 0, 0.90, 0)

[State 4010, Assert]
type = assertspecial
trigger1 = animelemtime(2) >= 0
trigger1 = animelemtime(11) < 0
flag = nobardisplay

[State 4010, Pos]
type = posadd
trigger1 = animelem = 3 || animelem = 4 || animelem = 5 || animelem = 6
trigger2 = animelem = 7 || animelem = 8 || animelem = 9 || animelem = 10
x = 140 * const(size.xscale)

[State 4010, Turn]
type = turn
trigger1 = animelem = 3 || animelem = 4 || animelem = 5 || animelem = 6
trigger2 = animelem = 7 || animelem = 8 || animelem = 9 || animelem = 10

[State 4010, Width]
type = width
trigger1 = animelemtime(2) < 0
edge = ceil(64 * const(size.xscale)), 0

[State 4010, Bind]
type = targetbind
trigger1 = animelemtime(2) < 0
pos = 45 * const(size.xscale), 0

[State 4010, Bind]
type = targetbind
trigger1 = animelemtime(2) >= 0 && animelemtime(12) < 0
pos = 70 * const(size.xscale), 0

[State 4010, Hitadd]
type = hitadd
trigger1 = animelem = 2 || animelem = 3 || animelem = 4 || animelem = 5 || animelem = 6
trigger2 = animelem = 7 || animelem = 8 || animelem = 9 || animelem = 10 || animelem = 11
value = 1

[State 4010, Hitdamage]
type = targetlifeadd
trigger1 = animelem = 2 || animelem = 3 || animelem = 4 || animelem = 5 || animelem = 6
trigger2 = animelem = 7 || animelem = 8 || animelem = 9 || animelem = 10 || animelem = 11
value = floor(-43 * map(damagescaling))
dizzy = 0
kill = animelem = 11

[State 4010, Hitpower]
type = targetpoweradd
trigger1 = animelem = 2 || animelem = 3 || animelem = 4 || animelem = 5 || animelem = 6
trigger2 = animelem = 7 || animelem = 8 || animelem = 9 || animelem = 10 || animelem = 11
value = 33

[State 4010, HitSound]
type = playsnd
trigger1 = animelem = 2 || animelem = 3 || animelem = 4 || animelem = 5 || animelem = 9
value = 2, 7
channel = 2

[State 4010, HitSound]
type = playsnd
trigger1 = animelem = 6 || animelem = 7 || animelem = 8 || animelem = 10 || animelem = 11
value = 2, ifelse((animelem = 11), 9, 8)
channel = 2

[State 4010, Shake]
type = envshake
trigger1 = animelem = 2 || animelem = 3 || animelem = 4 || animelem = 5 || animelem = 6
trigger2 = animelem = 7 || animelem = 8 || animelem = 9 || animelem = 10 || animelem = 11
time = 12
freq = 180
ampl = 2

;[State 4010, Spark]
;in ZSS

[State 4010, Throw]
type = targetstate
trigger1 = numtarget
trigger1 = animelem = 12
value = 4021

[State 4010, Type]
type = statetypeset
trigger1 = animelem = 11
statetype = A
movetype = I
physics = N

[State 4010, gravity]
type = veladd
trigger1 = animelemtime(11) >= 0
y = 0.43

[State 4010, Vel]
type = velset
trigger1 = animelem = 11
x = -3
y = -6.67

[State 4010, End]
type = changestate
trigger1 = animelemtime(11) > 0
trigger1 = vel y > 0
trigger1 = pos y > -vel y
value = ifelse(winko, 4090, 4011)


;----- Taunt -----
[Statedef 4011]
type = S
movetype = I
physics = S
anim = 4011
velset = 0, 0
sprpriority = -1
ctrl = 0

[State 4011, Pos]
type = posset
trigger1 = !time
y = 0

[State 4011, Sound]
type = playsnd
trigger1 = animelem = 4
value = 4, 3
channel = 0

[State 4011, Sound]
type = playsnd
trigger1 = animelem = 5
value = 1, 1
;channel = 1
stopongethit = 1

[State 4011, Sound]
type = playsnd
trigger1 = !time
value = 0, 52

[State 4011, Dust]
type = explod
trigger1 = !time
anim = 7102
sprpriority = -5
postype = p1
scale = 0.5, 0.5
pausemovetime = -1
supermovetime = -1
ownpal = 1

[State 4011, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1


;----- TARGET -----
[Statedef 4020]
type = A
physics = N
movetype = H
velset = 0, 0
ctrl = 0

[State 4020, Anim]
type = changeanim2
trigger1 = !time
value = 4020

[State 4020, Palfx]
type = palfx
trigger1 = animelemtime(2) = 0 || animelemtime(3) = 0 || animelemtime(4) = 0 || animelemtime(5) = 0 || animelemtime(6) = 0
trigger2 = animelemtime(7) = 0 || animelemtime(8) = 0 || animelemtime(9) = 0 || animelemtime(10) = 0 || animelemtime(11) = 0
sinadd = -128, -128, -128, 80
time = 20

[State 4020, Camera]
type = screenbound
trigger1 = 1
value = 1
movecamera = 0, 0

[State 4020, Safety]
type = selfstate
trigger1 = time >= 180
value = 5040


[Statedef 4021]
type = A
physics = N
movetype = H
ctrl = 0

[State 4021, Palfx]
type = palfx
trigger1 = !time
add = 0, 0, 0
sinadd = 0, 0, 0, 1
time = 1

[State 4021, Camera]
type = screenbound
trigger1 = 1
value = 1
movecamera = 1, 0

[State 4021, Accel]
type = veladd
trigger1 = 1
y = 0.4850; yaccel

[State 4021, Accel]
type = velset
trigger1 = !time
x = -2
y = -16

[State 4021, Anim]
type = changeanim
trigger1 = !time
value = ifelse(selfanimexist(5051), 5051, 5030)

[State 4021, Anim]
type = changeanim
trigger1 = anim = 5051
trigger1 = vel y > 0
value = 5061

[State 4021, Anim]
type = changeanim
trigger1 = anim = 5030
trigger1 = vel y > 0
value = ifelse(selfanimexist(5035), 5035, 5050)

[State 4021, Anim]
type = changeanim
trigger1 = !animtime
trigger1 = anim = 5035
value = 5050

[State 4021, Hit Ground]
type = selfstate
trigger1 = vel y > 0
trigger1 = pos y >= 0
value = 5100
