class_name CannonFire
extends StateBase

const EXCLAMATION = preload("res://ui/dialogue/emoj/exclamation.tscn")
const CANNON_BALL = preload("res://character/cannon/cannon_ball.tscn")

var can_stop_time: float = 0.0

var tween: Tween

func enter() -> void:
	#print("火炮看见你了")
	var emoj := EXCLAMATION.instantiate()
	if owner.find_child("BubbleMarker"):
		var bubble_marker: Marker2D = owner.find_child("BubbleMarker")
		bubble_marker.add_child(emoj)	
	tween = create_tween().set_loops()
	tween.tween_callback(shot).set_delay(1)

func physics_update(delta: float) -> void:
	if not (character as Cannon).detected:
		can_stop_time += delta
		if can_stop_time > 3:
			transition_to("CannonIdle")
			return
	else: 
		can_stop_time = 0.0


func exit() -> void:
	if owner.find_child("BubbleMarker"):
		var bubble_marker: Marker2D = owner.find_child("BubbleMarker")
		var emoj: AnimatedSprite2D = bubble_marker.get_child(0)
		emoj.play("out")
		await emoj.animation_finished
		emoj.queue_free()
	can_stop_time = 0.0
	tween.kill()


func shot() -> void:
	character.animation_player.play("fire")
	await character.animation_player.animation_finished

func ball() -> void:
	var ball := CANNON_BALL.instantiate()
	get_tree().current_scene.add_child(ball)
	ball.global_position = (character as Cannon).shot_marker.global_position
	
