extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ready
var username

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setReady(readytext):
	$Ready.text = readytext
	ready = readytext
	
func setUsername(currentUsername):
	$UserName.text = currentUsername
	username = currentUsername
