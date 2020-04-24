extends KinematicBody2D


var SPEED = 0
var GRAVITY = 12.5
var JUMP_POWER = -330
const FLOOR = Vector2(0, -1)
var velocity = Vector2()
var friction
var jumps = 2
var moving 

func _physics_process(delta) -> void:
		
	if is_on_wall():
		if Input.is_action_pressed("ui_right"):
			$AnimatedSprite.play("idle")
		if Input.is_action_pressed("ui_left"):
			$AnimatedSprite.play("idle")
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED + 15
		$AnimatedSprite.play("run")
		$AnimatedSprite.scale.x = 0.8
		moving = 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x += SPEED - 15
		$AnimatedSprite.play("run")
		$AnimatedSprite.scale.x = -0.8
		moving = 1
	else:
		velocity.x = lerp(velocity.x, 0, 0.2)
		friction = true
		$AnimatedSprite.play("idle")
		moving = 0
		
	if is_on_floor():
		jumps = 2
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_POWER
			jumps = 1
			friction = true
		if Input.is_action_just_released("ui_up"):
			if velocity.y < -450:
				velocity.y = velocity.y * 0.8
	else:
		if moving > 0 and velocity.y < 0:
			$AnimatedSprite.play("jump_move")
		elif moving < 1 and velocity.y < 0:
			$AnimatedSprite.play("jump_stand")
		else:
			$AnimatedSprite.play("fall")
			
	if not is_on_floor():
		if Input.is_action_just_pressed("ui_up") and jumps > 0:
				velocity.y = JUMP_POWER
				jumps = 0
				friction = true
	
	velocity.y += GRAVITY
		
	if friction:
		velocity.x = lerp(velocity.x, 0, 0.05)
			
	velocity = move_and_slide(velocity,FLOOR)
	
func _on_VisibilityNotifier2D_screen_exited():
	get_tree().reload_current_scene() 
	


func _on_Area2D_body_entered(body):
	pass # Replace with function body.
