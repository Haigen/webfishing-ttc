extends Node

const ID = "Haigen.TreasureTroveCove" 
onready var Lure = get_node("/root/SulayreLure")

func _ready():
	Lure.add_map(ID,"bkttc", "mod://Scenes/Map/treasure_trove_cove.tscn", "Treasure Trove Cove")
