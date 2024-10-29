extends Node2D
@onready var demo_dialogue: DialogueController = $DemoDialogue

var tween: Tween

@export var tile_map: TileMapLayer
@onready var bomb_guy: BombGuy = $BombGuy
@onready var camera: Camera = $CaptainClownNose/Camera
@onready var captain_clown_nose: CaptainClownNose = $CaptainClownNose

func _ready() -> void:
	if not TimeLine.time_line01:
		time_line01()
	else:
		bomb_guy.queue_free()


func time_line01() -> void:
	TimeLine.time_line01 = true
	bomb_guy.direction.value = -1
	captain_clown_nose.lock_input()
	captain_clown_nose.direction.value = 1
	camera.position_smoothing_enabled = false
	camera.zoom = Vector2(1.6, 1.6)
	camera.reset_smoothing()
	await  get_tree().create_timer(1).timeout
	tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(camera, "position:x", camera.position.x + 110, 2)
	await tween.finished
	demo_dialogue.start()
	await demo_dialogue.finished
	bomb_guy.expect_direction = 1
	await get_tree().create_timer(2).timeout
	tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(camera, "position:x", 0, 2)
	await tween.finished
	tween = create_tween()
	await tween.tween_property(camera, 'zoom', Vector2(1, 1), 2).set_trans(Tween.TRANS_EXPO).finished
	camera.position_smoothing_enabled = true
	captain_clown_nose.unlock_input()
	bomb_guy.queue_free()
	
	
