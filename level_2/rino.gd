extends CharacterBody2D

var SPEED = 300
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimatedSprite2D")
@onready var on_left = true
var hurt = false

func _ready():
	animation.play("run")

func _physics_process(delta):
	if not hurt:
		if not is_on_floor():
			velocity.y += gravity * delta
		
		if animation.flip_h:
			velocity.x = SPEED
			$Sight/Left.disabled = true
			$Sight/Right.disabled = false
		else:
			velocity.x = -SPEED
			$Sight/Left.disabled = false
			$Sight/Right.disabled = true
			
		if $RayCast2D.is_colliding() == false:
			if on_left:
				velocity.x = SPEED
				animation.flip_h = true
				on_left = false
			else:
				velocity.x = -SPEED
				animation.flip_h = false
				on_left = true
		
		move_and_slide()

func _on_hurt_box_area_entered(area):
	if area.get_parent().name == "Player" and area.get_parent().attacking and not hurt:
		hurt = true
		animation.play("hurt")

func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "hurt":
		queue_free()

func _on_sight_body_entered(body):
	if body.name == "Player":
		SPEED *= 3

func _on_sight_body_exited(body):
	if body.name == "Player":
		SPEED /= 3
