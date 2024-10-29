class_name Tip
extends Node
const BUBBLE: PackedScene = preload("res://ui/dialogue/Bubble.tscn")
@export var tip_text: String
var _bubble: Bubble = null
@export var disposable_tip: bool = false

func tip_in() -> void:
	var bubble := BUBBLE.instantiate()
	bubble.show_right_now = true
	bubble.text = tip_text
	var bubble_marker: Marker2D = owner.find_child("BubbleMarker")
	if bubble_marker:
		get_tree().current_scene.add_child(bubble)
		var tween := get_tree().create_tween()
		bubble.modulate.a = 0
		tween.tween_property(bubble, "modulate:a", 1, 0.5)
		bubble.global_position = bubble_marker.global_position
		_bubble = bubble


func tip_out() -> void:
	var bubble_marker: Marker2D = owner.find_child("BubbleMarker")
	if bubble_marker:
		if _bubble:
			if get_tree():
				var tween := get_tree().create_tween()
				tween.tween_property(_bubble, "modulate:a", 0, 0.5)
				await tween.finished
				_bubble.queue_free()
