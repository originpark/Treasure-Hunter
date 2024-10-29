extends Node

var user_store: UserStore

func _ready() -> void:
	user_store = UserStore.new()


class UserStore:
	var HP: float:
		set(v):
			#print("正在更新userStore")
			HP = v
			#print("userStore更新完成: ", HP)
			#print("开始更新Hud的health_bar")
			Hud.update_health_bar(HP / MAX_HP)
	
	var MAX_HP: float
	
	var visible: bool = true
