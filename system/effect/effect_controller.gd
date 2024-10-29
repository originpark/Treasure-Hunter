class_name EffectController
extends Node

static func physical_attack(sender: Stats, receiver: Stats, back_power: Vector2) -> void:
	receiver.HP -= sender.STR - receiver.DEF
	if receiver.owner is BasicCharacter:
		var character: BasicCharacter = receiver.owner
		character.stats.current_effect_origin = sender.owner
		character.is_hurt = true
