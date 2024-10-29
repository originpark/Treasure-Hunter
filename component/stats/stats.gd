class_name Stats
extends Node

@export_group("基础状态")
@export var MAX_HP: float

@export_group("即时状态")
@export var HP: float = MAX_HP:
	set(v):
		#print("开始设置hp")
		if v > MAX_HP:
			HP = MAX_HP
		elif v < 0:
			HP = 0
		else:
			HP = v
		#print("设置完成, 当前hp = ", HP)
		if owner and owner.name == "CaptainClownNose":
			#print("玩家hp变化, 开始更新UserStore")
			Store.user_store.HP = HP
		
@export var STR: float
@export var DEF: float
@export var ATS: float
@export var ADF: float
## 影响角色的移动速度, (velocity.x * SPD), 默认为1
@export var SPD: float = 1


var current_effect_origin: Node2D
