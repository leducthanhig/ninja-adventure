extends CharacterBody2D

var SPEED = 300

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimatedSprite2D")
var hurt = false

func _ready():
	animation.play("run")

func _physics_process(delta):
	if not hurt:
		if not is_on_floor():
			velocity.y += gravity * delta
		
		if animation.flip_h:
			velocity.x = -SPEED
		else:
			velocity.x = SPEED
			
		if is_on_wall():
			animation.flip_h = true
		if not $RayCast2D.is_colliding():
			animation.flip_h = false
		
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
