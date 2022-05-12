extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Register_button_down():
	var username = $UsernameText.text.strip_edges()
	var password = $PasswordText.text.strip_edges()
	var email = $EmailText.text.strip_edges()
	
	var session = yield(Online.nakama_client.authenticate_email_async(email, password, username, true), "completed")
	if session.is_exception():
		print(session.get_exception().message)
	Online.nakama_session = session
	self.hide()
	pass # Replace with function body.


func _on_Login_button_down():
	var username = $UsernameText.text.strip_edges()
	var password = $PasswordText.text.strip_edges()
	var email = $EmailText.text.strip_edges()
	
	var session = yield(Online.nakama_client.authenticate_email_async(email, password, null, false), "completed")
	if session.is_exception():
		print(session.get_exception().message)
	Online.nakama_session = session
	self.hide()
	pass # Replace with function body.
