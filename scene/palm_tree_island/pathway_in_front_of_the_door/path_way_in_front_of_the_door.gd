extends Node2D
@onready var demo_dialogue: DialogueController = $DemoDialogue

func _ready() -> void:
	demo_dialogue.start()
