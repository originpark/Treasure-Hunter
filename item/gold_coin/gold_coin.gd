class_name GoldCoin
extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func do_enter(body: Node2D) -> void:
	animated_sprite_2d.play("exit")
	await animated_sprite_2d.animation_finished
	queue_free()
