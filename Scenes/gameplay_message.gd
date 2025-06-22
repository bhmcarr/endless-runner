extends Label
@onready var message_timer: Timer = $MessageTimer

func _ready() -> void:
	hide()

func show_message(new_message: String):
	text = new_message
	show()
	message_timer.start()
	
func _on_message_timer_timeout() -> void:
	hide()
