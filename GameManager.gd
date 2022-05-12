extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = preload("res://Player.tscn")
var Players = {}
var AlivePlayers = {}
var ReadyPlayers = {}
signal GameOver()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _get_custom_rpc_methods():
	return [
		"setupGame",
		"finishedSetup"
	]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func StartGame(players):
	OnlineMatch.custom_rpc_sync(self, "setupGame", [players])

func setupGame(players):
	Players = players
	AlivePlayers = players
	
	for id in players:
		var currentPlayer = player.instance()
		currentPlayer.name = str(id)
		$PlayersSpawnUnder.add_child(currentPlayer)
		currentPlayer.set_network_master(id)
		currentPlayer.position = get_node("Player Spawn Points/Player" + str(id)).position
		currentPlayer.connect("PlayerHasDied", self, "onPlayerDeath", [id])
	var myID = OnlineMatch.get_network_unique_id()
	var player = $PlayersSpawnUnder.get_node(str(myID))
	player.playerControlled = true
	
	OnlineMatch.custom_rpc_id_sync(self, 1, "finishedSetup", [myID])
	get_tree().get_nodes_in_group("GameWorld")[0].HideMatchMakeInterface()
	
func finishedSetup(id):
	ReadyPlayers[id] = Players[id]
	if ReadyPlayers.size() == Players.size():
		get_tree().get_nodes_in_group("GameWorld")[0].startGame()

func onPlayerDeath(id):
	AlivePlayers.erase(id)
	if AlivePlayers.size() <= 1:
		emit_signal("GameOver", AlivePlayers)
