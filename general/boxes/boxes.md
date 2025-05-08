# Hitboxes and Hurtboxes

Hurtboxes are the part of the host character that recieve hits and damage the host; they allow the host character to be hurt.

Hitboxes are the part of the host character that allow it to hit and harm other characters.

In the following, the player can attack and harm the enemy, while the enemy cannot hit and attack the player:

```
player
|- hitbox
|- sprite
|- ...

enemy
|- hurtbox
|- sprite
|- ...
```
