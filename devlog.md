#### Project Setup

1. Project Settings
	- Window sizes (480 x 270, override to 1920x1080)
	- Stretch mode to viewport
	- Texture rendering to nearest

1. Add ``Playground``
	- Create a ``Node2D`` called ``Playground``
	- Save ``Playground`` as a scene
	- Run the project, setting ``Playground`` as the main scene



#### Adding Player, States and Movement

1. Create a ``Player``
	- Create a ``CharacterBody2D`` called ``Player`` as a child of ``Playground``
	- Save ``Player`` as a scene
	- In the ``Player`` scene
		- Set Motion Mode to floating on the ``Player``
		- Add a ``CollisionShape2D`` node to ``Player``, adding a suitable shape
		- Add a ``Sprite2D`` node to ``Player``, adding a suitable texture
		- Adjust the position of the ``CollisionShape2D`` and ``Sprite2d`` nodes as needed
		- Add a ``Camera2D`` node to ``Player``, adjusting position
		- Add an ``AnimationPlayer`` node to ``Player`` and add animations for all combos of idle/walk and up/down/side
	- Create a ``Player`` class and attach it to the ``Player`` scene

1. Add direction controls to the input map
		
1. Add a ``PlayerStateMachine``
	- Create a ``State`` class as a blueprint for all states
	- Create a ``PlayerStateMachine`` class to orchestrate player state; note the most important function to how this works is ``change_state()``			
	- Add a Node called ``StateMachine`` as a child of `Player`, with child Nodes `Idle` and `Walk`
	- Attach the ``PlayerStateMachine`` class to the ``StateMachine`` node
	- Create and attach ``StateIdle`` and ``StateWalk`` classes






#### Adding a tilemap and levels

- Add a TileMapLayer to Playground
- Call it terrain
- Save it as a scene
- In the terrain scene:
	- Add the terrain tilesheet
	- Set ordering z-index to -1
	- Add a physics collision layer
	- Unselect collision layer and mask, then select layer 5 on collision layer
	- Set layer names to 1 = Player, 5 = walls
	- Paint the tiles accordingly
- Unselect mask layer 1 and select mask layer 5 on Player root node
- Add a Node2D called Level01 to playground and save the scene
- In the level scene, add the terrain scene, then draw the terrain 
- **Add a terrain layer (ep04 16:00) to build paths**
- **Add y sort enabled on the level**
- Limit the camera bounds to the tilemap
	- Create player_camera script and attach to camera2d node
	- Fill script
	- Add global_level_manager to globals
	- Add level_tilemap script to tilemap
	- 