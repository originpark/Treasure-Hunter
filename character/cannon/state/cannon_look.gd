class_name CannonLook
extends StateBase
const INTERROGATION_BUBBLE = preload("res://ui/dialogue/emoj/interrogation_bubble.tscn")


func enter() -> void:
	print("火炮看见你了")
	var emoj := INTERROGATION_BUBBLE.instantiate()
	if owner.find_child("BubbleMarker"):
		var bubble_marker: Marker2D = owner.find_child("BubbleMarker")
		bubble_marker.add_child(emoj)	


func physics_update(delta: float) -> void:
	if not (character as Cannon).detected or Store.user_store.visible:
		transition_to("CannonIdle")
		return

		
		
func exit() -> void:
	if owner.find_child("BubbleMarker"):
		print("退出look")
		var bubble_marker: Marker2D = owner.find_child("BubbleMarker")
		var emoj: AnimatedSprite2D = bubble_marker.get_child(0)
		emoj.play("out")
		await emoj.animation_finished
		emoj.queue_free()
