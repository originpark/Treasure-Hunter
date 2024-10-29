class_name DialogueController
extends Node
const BUBBLE: PackedScene = preload("res://ui/dialogue/Bubble.tscn")

@export var dialogue_list: DialogueList
@export var actor_list: Array[BasicCharacter]

var _index: int = -1
var _count: int
var _list: Array[Dialogue]
var _started: bool = false

signal finished()

func _ready() -> void:
	_count = dialogue_list.value.size()
	_list = dialogue_list.value


func _physics_process(delta: float) -> void:
	if _started:
		if Input.is_action_just_pressed("left_click"):
			if not next():
				end()
	

func next() -> bool:
	for character: BasicCharacter in actor_list:
		if character.bubble_marker.get_child_count() > 0:
			character.bubble_marker.get_child(0).queue_free()
	_index += 1
	if _index == _count:
		return false
	var dialogue: Dialogue = _list[_index]
	var character: BasicCharacter = actor_list[dialogue.actor_id]
	var bubble: Bubble = BUBBLE.instantiate()
	bubble.text = dialogue.content
	character.bubble_marker.add_child(bubble)
	return true

func start() -> void:
	print(name, " 对话开始")
	next()
	_started = true


func end() -> void:
	print(name, " 对话结束")
	_started = false
	finished.emit()
	queue_free()
