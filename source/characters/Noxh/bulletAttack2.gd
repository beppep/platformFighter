extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the script loads or somethn
func _init():
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"start":1,
			"damage":3,
			"kb":60,
			"kbscaling":0.3,
			"angle":70,
		},
	]


func update():
	pass #nevercalled?

