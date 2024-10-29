class_name Interface
extends Node 
const HUD = preload("res://ui/interface/hud.tscn")

func _ready() -> void:
	var hud := HUD.instantiate()
