extends CharacterBody2D

var SPEED = 300
@onready var animation = get_node("AnimatedSprite2D")
var direction = 1
var hurt = false
var player_in_sight = false

func _ready():
	animation.play("idle")

func _physics_process(delta):
	position.x = 128
	
	if not hurt:
		if is_on_floor():
			direction = -1
		if is_on_ceiling():
			direction = 1
		
		velocity.y = direction * SPEED

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
		SPEED *= 2
		direction = 1

func _on_sight_body_exited(body):
	if body.name == "Player":
		SPEED /= 2
