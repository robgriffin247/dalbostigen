### Project Setup

1. Set appropriate window sizes, strecth mode to viewport, and texture rendering to nearest in project settings
1. Add Node2D called `Playground`
1. Add a CharacterBody2D called `Player` as a child of `Playground`
1. Save `Playground` and `Player` as scenes (`./playground.tscn` and `./player/player.tscn`)
1. Add a CollisionShape2D node to `Player`, adding a suitable shape
1. Add a Sprite2D node to `Player`, adding a suitable texture
1. Adjust the collision shape size/position, and sprite position
1. Run the project setting playground as the main scene

### Adding Player Control & States

1. Add an AnimationPlayer node to `Player`, adding animations for walk/idle and up, down and side.
