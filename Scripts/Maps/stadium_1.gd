extends Node3D

@onready var home_goal_center: Node3D = $HomeGoalCenter
@onready var away_goal_center: Node3D = $AwayGoalCenter
@onready var time: Node3D = $Scoreboard1/Time
@onready var time_2: Node3D = $Scoreboard2/Time
@onready var ball: RigidBody3D = $Ball

'Crowd Noises'
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $"Crowd Sprites/AudioStreamPlayer3D"
@onready var audio_stream_player_3d_2: AudioStreamPlayer3D = $"Crowd Sprites/AudioStreamPlayer3D2"
@onready var audio_stream_player_3d_3: AudioStreamPlayer3D = $"Crowd Sprites/AudioStreamPlayer3D3"
@onready var audio_stream_player_3d_4: AudioStreamPlayer3D = $"Crowd Sprites/AudioStreamPlayer3D4"
var crowdCheers = preload("uid://c0ep52pjn21ao")
var crowdAmbient = preload("uid://dkputyvhvjsk2")
'''
This state machine is kinda pointless but it is here for reference if maybe needed
it already implemented so just uncomment if needed.
enum crowdState {AMBIENT, SCORE}
var current_state = crowdState.AMBIENT
'''

'stadium geometry'
@onready var animation_player_away: AnimationPlayer = $"Goalie Area Away/AnimationPlayer"
@onready var animation_player_home: AnimationPlayer = $"Goalie Area Home/AnimationPlayer"

func _init() -> void:
	Global.Stadium1 = self
	Global.in_possession_away = false
	Global.in_possession_home = false

func _ready() -> void:
	Global.away_goal_pos = away_goal_center.position
	Global.home_goal_pos = home_goal_center.position
	Global.ball_pos = ball.position
	time.start_countdown()
	time_2.start_countdown()
	Global.score.connect(just_scored)

func _on_away_goal_close_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		animation_player_away.play("Move Back")

func _on_away_goal_close_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		animation_player_away.play_backwards("Move Back")

func _on_home_goal_close_body_entered(body: Node3D) -> void:
	if body.is_in_group("OpposingTeam"):
		if body.play_type == 0:
			animation_player_home.play("Move Back")

func _on_home_goal_close_body_exited(body: Node3D) -> void:
	if body.is_in_group("OpposingTeam"):
		if body.play_type == 0:
			animation_player_home.play_backwards("Move Back")
			

func just_scored():
	#current_state = crowdState.SCORE
	audio_stream_player_3d.stream = crowdCheers
	audio_stream_player_3d_2.stream = crowdCheers
	audio_stream_player_3d_3.stream = crowdCheers
	audio_stream_player_3d_4.stream = crowdCheers
	audio_stream_player_3d.play()
	audio_stream_player_3d_2.play()
	audio_stream_player_3d_3.play()
	audio_stream_player_3d_4.play()
	
	await audio_stream_player_3d_4.finished
	
	return_to_normal()
	
func return_to_normal():
	audio_stream_player_3d.stream = crowdAmbient
	audio_stream_player_3d_2.stream = crowdAmbient
	audio_stream_player_3d_3.stream = crowdAmbient
	audio_stream_player_3d_4.stream = crowdAmbient
	audio_stream_player_3d.play()
	audio_stream_player_3d_2.play()
	audio_stream_player_3d_3.play()
	audio_stream_player_3d_4.play()
	
	#current_state = crowdState.AMBIENT
	
