extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func on_entered(body: Node) -> void:
	if body.name != "Player":
		return
	OS.alert("You did it!", "Congrations")
