extends Node

# Define the three audio players
onready var track1 = $Track1
onready var track2 = $Track2
onready var track3 = $Track3

# Path to the audio files
var track1_path = "res://mods/Haigen.TreasureTroveCove/Assets/Audio/TreasureTroveCove.ogg"
var track2_path = "res://mods/Haigen.TreasureTroveCove/Assets/Audio/TheSaltyHippo.ogg"
var track3_path = "res://mods/Haigen.TreasureTroveCove/Assets/Audio/InsideNippersShell.ogg"

# Track control variables
var current_track: AudioStreamPlayer
var original_track: AudioStreamPlayer
var fade_in_target: AudioStreamPlayer
var fade_out_target: AudioStreamPlayer
var fading = false

func _ready():
	# Load the audio streams and assign them to the players
	track1.stream = load(track1_path)
	track2.stream = load(track2_path)
	track3.stream = load(track3_path)
	
	# Set volumes and play
	track1.volume_db = -80
	track2.volume_db = -80
	track3.volume_db = -80
	
	# Start all tracks
	track1.play()
	track2.play()
	track3.play()

	# Set initial track
	original_track = track1
	current_track = original_track
	current_track.volume_db = -20  # Set the original track to be audible at start

func play_song(new_track_name: String):
	# Set the appropriate track based on the song name
	match new_track_name:
		"Track1":
			fade_in_target = track1
		"Track2":
			fade_in_target = track2
		"Track3":
			fade_in_target = track3
		_:
			return # No matching track; do nothing

	# Only proceed if a different track is requested
	if fade_in_target != current_track:
		fade_out_target = current_track
		current_track = fade_in_target
		fading = true

func _process(delta):
	if fading and fade_in_target and fade_out_target:
		# Fade in the new track and fade out the old track
		fade_in_target.volume_db = min(fade_in_target.volume_db + 120 * delta, -20)
		fade_out_target.volume_db = max(fade_out_target.volume_db - 60 * delta, -80)
		
		# Stop fading when we reach target volumes
		if fade_in_target.volume_db == -20 and fade_out_target.volume_db <= -80:
			fading = false
			fade_out_target.volume_db = -80
			fade_in_target.volume_db = -20

func reset_to_original():
	# Fade back to the original track if it's not already playing
	if current_track != original_track:
		fade_in_target = original_track
		fade_out_target = current_track
		current_track = original_track
		fading = true
