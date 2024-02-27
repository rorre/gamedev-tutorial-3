extends KinematicBody2D

export (int) var speed = 400
export (int) var GRAVITY = 1200
export (int) var jump_speed = -600

const UP = Vector2(0,-1)

var double_jumped = false
var dashed = false
var velocity = Vector2()

var normal_icon = preload("res://assets/normal.png")
var easy_icon = preload("res://assets/easy.png")

var screen_size: Vector2
var spriteSize: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	spriteSize = $Sprite.texture.get_size()

func get_input():
	if Input.is_action_just_pressed('jump'):
		if is_on_floor() or not double_jumped:
			velocity.y = jump_speed
			if not is_on_floor():
				double_jumped = true
	
	var new_x = 0
	if abs(velocity.x) > speed:
		new_x = (abs(velocity.x) - speed) * sign(velocity.x)
	if Input.is_action_pressed('right'):
		new_x += speed
	if Input.is_action_pressed('left'):
		new_x -= speed
		
	if Input.is_action_just_pressed("dash") and not dashed:
		new_x *= 2
		dashed = true
		$Sprite.set_texture(easy_icon)
	
	velocity.x = new_x

func _physics_process(delta):
	if is_on_floor():
		double_jumped = false
		# I genuinely have no idea why I need to add this grace +1
		# but if it doesn't, sometimes it just always detect its dashing
		if abs(velocity.x) <= speed + 1:
			dashed = false
			$Sprite.set_texture(normal_icon)

	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)


func _process(_delta: float) -> void:
	position.x = clamp(position.x, 0, screen_size.x)
	if position.y > screen_size.y:
		position = Vector2(88, 216)
