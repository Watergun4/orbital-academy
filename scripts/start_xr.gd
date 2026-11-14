extends Node3D

var xr_interface: XRInterface


func _ready() -> void:
	xr_interface = XRServer.find_interface("OpenXR")

	if xr_interface and xr_interface.is_initialized():
		print("OpenXR started")
		# The headset controls the frame rate, so turn off vsync
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		get_viewport().use_xr = true
		_enable_passthrough()
	else:
		print("OpenXR did not start - is the headset connected?")


func _enable_passthrough() -> void:
	var modes := xr_interface.get_supported_environment_blend_modes()

	if XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND in modes:
		xr_interface.environment_blend_mode = XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND
		get_viewport().transparent_bg = true

		# Make the background see-through so the real room shows
		var env: Environment = $WorldEnvironment.environment
		env.background_mode = Environment.BG_COLOR
		env.background_color = Color(0, 0, 0, 0)
		print("Passthrough on")
	else:
		print("Passthrough not supported")
