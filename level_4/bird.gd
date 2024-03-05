extends CharacterBody2D

const SPEED = 300

@onready var animation = get_node("AnimatedSprite2D")
var hurt = false

func _ready():
	animation.play("fly")

func _physics_process(delta):
	position.y = 320
	
	if not hurt:
		if animation.flip_h:
			velocity.x = -SPEED
		else:
			velocity.x = SPEED
		
		if position.x <= 1088:
			animation.flip_h = false
		if position.x >= 1728:
			animation.flip_h = true
		
		move_and_slide()

func _on_hurt_box_area_entered(area):
	if area.get_parent().name == "Player" and area.get_parent().attacking and not hurt:
		hurt = true
		animation.play("hurt")

func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "dead":
		queue_free()
	if animation.animation == "hurt":
		animation.play("dead")
