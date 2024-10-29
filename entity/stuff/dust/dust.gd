class_name Dust
extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


## 安全自我释放: 等待动画播放完成后释放
func free_deferred() -> void:
	# 如果是循环动画,则等待一次循环结束
	if animated_sprite_2d.sprite_frames.get_animation_loop("default"):
		await animated_sprite_2d.animation_looped
	# 不是循环动画,等待动画播放完成
	else:
		await animated_sprite_2d.animation_finished
	queue_free()
