# Night Watch: Living Room Prototype

A small Godot 4 first-person horror-game prototype. The living room is built from
primitive meshes in GDScript, so the project runs without external assets.

## Run

Open this folder in Godot 4 and run the main scene.

## Controls

- WASD: move
- Mouse: look around
- Shift: sprint
- Space: jump
- F: toggle the flashlight
- E: examine a highlighted object
- Escape: release the mouse; click the game window to recapture it

## Structure

- `scenes/living_room.tscn`: main scene and player node tree
- `scripts/living_room.gd`: procedural room, furniture, lighting, and interactable props
- `scripts/player_controller.gd`: first-person movement and mouse look
- `scripts/flashlight.gd`: flashlight toggle input
- `scripts/room_interaction.gd`: camera raycast, reticle, and examine prompt