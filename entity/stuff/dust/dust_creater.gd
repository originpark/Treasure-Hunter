class_name DustCreater
extends Node

const FALL_DUST = preload("res://entity/stuff/dust/fall_dust.tscn")
const JUMP_DUST = preload("res://entity/stuff/dust/jump_dust.tscn")
const RUN_DUST = preload("res://entity/stuff/dust/run_dust.tscn")
const CANNON_DUST = preload("res://entity/stuff/dust/cannon_dust.tscn")

static func generete(dust_scene: PackedScene, parent: Node2D, pos: Vector2) -> Dust:
	var dust: Dust = dust_scene.instantiate()
	dust.position = pos
	parent.add_child(dust)
	return dust
