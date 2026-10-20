@tool
extends EditorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass

const ACTION_NAME = "Build and publish to itch"

func _enter_tree():
	add_tool_menu_item(ACTION_NAME, build_and_publish)

func _exit_tree():
	remove_tool_menu_item(ACTION_NAME)

var godot_binary = "Godot_v4.7.2-stable_win64.exe"
var itch_target = "namespacev/ld60-idle:web"

func build_and_publish():

	var project_path = ProjectSettings.globalize_path("res://")

	print("Running build and publish for ", project_path)

	print("WEB")

	var out = []
	var commands = [
		"/c",
		"cd \"%s\"" % [project_path],
		"&& %s --headless --export-debug \"Web\" build/web/index.html" % [godot_binary]
	]
	await get_tree().create_timer(0.1).timeout
	OS.execute("cmd",commands,out)

	print("Creating a zip archive ")
	commands = [
		"/c",
		"cd \"%s\"" % [project_path],
		"&& 7z a build/web.zip build/web/*"
	]
	await get_tree().create_timer(0.1).timeout
	OS.execute("cmd",commands,out)

	print("Uploading to itch")
	commands = [
		"/c",
		"cd \"%s\"" % [project_path],
		"&& butler.exe push build/web.zip %s" % [itch_target]
	]
	await get_tree().create_timer(0.1).timeout
	OS.execute("cmd",commands,out)
#
	#print("WIN")
#
	#commands = [
		#"/c",
		#"cd \"%s\"" % [project_path],
		#"&& Godot_v4.5.1-stable_win64.exe --headless --export-debug \"Win\" export/win/game.exe"
	#]
	#await get_tree().create_timer(0.1).timeout
	#OS.execute("cmd",commands,out)
#
	#print("Creating a zip archive ")
	#commands = [
		#"/c",
		#"cd \"%s\"" % [project_path],
		#"&& 7z a export/win.zip export/win/*"
	#]
	#await get_tree().create_timer(0.1).timeout
	#OS.execute("cmd",commands,out)
#
	#print("Uploading to itch")
	#commands = [
		#"/c",
		#"cd \"%s\"" % [project_path],
		#"&& butler.exe push export/win.zip namespacev/wsf2025:win"
	#]
	#await get_tree().create_timer(0.1).timeout
	#OS.execute("cmd",commands,out)

	print("Export done")
