# Explorasi Mekanika Pergerakan

## Double jump

Untuk melakukan double jump, saya membuat variable untuk tracking apabila karakter sudah melakukan double jump atau tidak.
Setiap kali jump dan berada di air, variable ini akan diset `true`. Maka apabila variable ini `true`, maka tidak bisa jump lagi hingga menyentuh lantai.

Tombol untuk jump yang digunakan adalah Z

Berikut snippet code dari function `get_input()`
```gdscript
if Input.is_action_just_pressed('jump'):
	if is_on_floor() or not double_jumped:
		velocity.y = jump_speed
		if not is_on_floor():
			double_jumped = true
```

## Dash

Di sini saya cukup mengecek apabila tombol dash (X) terpencet, lalu mengalikan velocity 2 kali lipat saja. Lalu disable dash hingga
dash sebelumnya sudah habis dan berada di lantai.

Untuk pengecekan apakah dash sudah habis, saya cukup melihat apakah velocity dari player itu dibawah speed.

```gdscript
func _physics_process(delta):
	if is_on_floor():
		double_jumped = false
		# I genuinely have no idea why I need to add this grace +1
		# but if it doesn't, sometimes it just always detect its dashing
		if abs(velocity.x) <= speed + 1:
			dashed = false
			$Sprite.set_texture(normal_icon)
```

Sedangkan untuk logic dash, cukup saya cek tombolnya.

```gdscript
if Input.is_action_just_pressed("dash") and not dashed:
	new_x *= 2
	dashed = true
	$Sprite.set_texture(easy_icon)
```

Sprite juga saya rubah apabila sedang melakukan dash.
