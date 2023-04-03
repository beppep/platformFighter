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
			"damage":5,
			"kb":30,
			"kbscaling":0.7,
			"angle":90,
			"extrahitpause":30,
		},
	]


func update():
	pass #nevercalled?

