extends Area

onready var background_music = get_parent()  # Adjust path if needed
export var zone_track: String = "Track2"  # Set the desired track to fade in for this zone

func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Play the designated track for this music zone
		background_music.play_song(zone_track)

func _on_body_exited(body):
	if body.is_in_group("player"):
		# Reset back to the original track when leaving the zone
		background_music.reset_to_original()
