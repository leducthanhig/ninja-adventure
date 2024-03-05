extends CharacterBody2D

const SPEED = 300

@onready var animation = get_node("AnimatedSprite2D")
@onready var on_left = true
var hurt = false

func _ready():
	animation.play("fly")

func _physics_process(delta):
	if not hurt:
		if animation.flip_h:
			velocity.x = -SPEED
		else:
			velocity.x = SPEED
			
		if is_on_wall():
			if on_left:
				velocity.x = SPEED
				animation.flip_h = false
				on_left = false
			else:
				velocity.x = -SPEED
				animation.flip_h = true
				on_left = true
		
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
