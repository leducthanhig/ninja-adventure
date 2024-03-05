extends CharacterBody2D

const SPEED = 300

@onready var animation = get_node("AnimatedSprite2D")
var hurt = false
@onready var player = get_parent().get_node("Player")
var player_in_sight = false

func _ready():
	animation.play("idle")

func _physics_process(delta):
	if not hurt: 
		if player_in_sight:
			velocity = (player.position - position).normalized() * SPEED
			
			if player.position > position:
				animation.flip_h = false
			else:
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

func _on_sight_body_entered(body):
	if body.name == "Player":
		player_in_sight = true
		animation.play("fly")
