class_name CannonIdle
extends StateBase

func enter() -> void:
	character.animation_player.play("idle")
	print("火炮正在休息")


func physics_update(delta: float) -> void:
	if (character as Cannon).detected:
		if Store.user_store.visible:
			print("火炮看得到你")
			transition_to("CannonFire")
			return
		else:
			print("你藏起来了")
			transition_to("CannonLook")
			return 
