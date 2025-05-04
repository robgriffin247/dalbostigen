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



#### Adding a Tilemap, Levels and Spawn Points

1. Create and save a scene called ``Terrain``, of type ``TileMapLayer``
1. In the ``Terrain`` scene, 
	- Add the terrain tilesheet
	- Set ordering z-index to -1
	- Add a physics collision layer
	- Unselect collision layer and mask, then select layer 5 on collision layer
	- Set layer names to 1 = Player, 5 = walls
	- Paint the tiles accordingly
	<!-- - **Add a terrain layer (ep04 16:00) and build paths** -->
1. Unselect mask layer 1 and select mask layer 5 on the root node of the ``Player`` scene
1. Create and open a ``Node2D`` scene called ``Level01`` (add it to the ``Playground`` scene for now)
1. Create a level script, attaching it to the ``Level01`` and adding `y_sort_enabled = true` to the `ready()` function
1. Add a ``Terrain`` scene to ``Level01`` and draw the level in the ``Level01`` scene (not in the ``Terrain`` scene; this will be reused across levels)
1. Limit the camera bounds to the tilemap
	- Create player_camera script and attach to camera2d node
	- Fill script
	- Add global_level_manager to globals
	- Add level_tilemap script to tilemap
1. Create the global_player_manager
1. Create a ``Node2D`` scene called ``PlayerSpawn``
	- Add a ``Sprite2D`` to represent the player sprite
	- Modulate to make see through and discolored
	- Position to match ``Player`` sprite
	- Attach a player_spawn script
1. Place the ``PlayerSpawn`` in the level(s)


#### Adding Scene Manager/Level Transition

- Create Area2D scene called LevelTransition
	- Add a collision shape, set local to scene
	- Add a script (@tool)
- Add ``LevelTransition``s to levels
- Add scenetransition and add to globals


#### Add Pause Menu, Save and Load

- add canvaslayer with process mode set to always
	- add styling (control containing colorrect, buttons, labels etc)
<!-- watch ep 15 -->

#### Adding a Player HUD

<!-- add to this -->