extends CharacterBody2D

const SPEED = 300

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimatedSprite2D")
var hurt = false
var attacking = false
@onready var bullet = preload("res://level_2/trunk_bullet.tscn")

func _ready():
	animation.play("run")

func _physics_process(delta):
	if not hurt and not attacking:
		if not is_on_floor():
			velocity.y += gravity * delta

		if animation.flip_h:
			velocity.x = SPEED
		else:
			velocity.x = -SPEED

		if $RayCast2D.is_colliding() == false:
			animation.flip_h = false
		if is_on_wall():
			animation.flip_h = true
		
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
		attacking = true
		animation.flip_h = true
		animation.play("attack")

func _on_sight_body_exited(body):
	if body.name == "Player":
		attacking = false
		animation.play("run")

func _on_animated_sprite_2d_frame_changed():
	if attacking and animation.frame == 7:
		var b = bullet.instantiate()
		get_parent().add_child(b)
		b.start_at($Marker2D.global_position)
