# Openrooms — Godot implementation

This directory contains the current playable implementation of Openrooms using
Godot 4 and GDScript.

Instructions in the repository-level `AGENTS.md` also apply here. This file
contains additional rules specific to the Godot implementation.

## Current development stage

Openrooms is currently at the prototype stage.

The immediate goals are:

* first-person exploration;
* a convincing maze-like indoor environment;
* appropriate architectural scale;
* dynamic ceiling lighting;
* a player flashlight;
* atmosphere through lighting, sound, repetition, and environmental design.

Do not add major gameplay systems unless explicitly requested.

In particular, do not introduce enemies, entities, inventory systems, combat,
objectives, save systems, or complex interaction systems merely because they
might be useful later.

Avoid overengineering the prototype.

## Technology

* Engine: Godot 4.x
* Language: GDScript
* Primary development platform: Linux
* Physics: use normal Godot facilities unless a specific reason requires
  otherwise.

Prefer standard Godot functionality over third-party addons.

Prefer typed GDScript when it improves clarity.

Do not introduce C#, GDExtension, native libraries, or external runtime
dependencies unless explicitly requested.

## Godot project root

This directory is the Godot project root.

`project.godot` must remain here.

Commands that operate on the Godot project should normally be executed from this
directory.

A basic validation command is:

```
godot --headless --path . --editor --quit
```

If executing from the repository root instead, use the appropriate project path,
for example:

```
godot --headless --path game/godot --editor --quit
```

## Project organization

Use this general structure:

* `scenes/` - Godot scenes;
* `scripts/` - GDScript source code;
* `materials/` - reusable Godot materials;
* `assets/` - runtime textures, sounds, models, and other imported assets.

Create additional directories only when they provide a clear organizational
benefit.

Keep reusable components in reusable scenes when appropriate.

Do not place unrelated systems into one large script.

Do not manually modify files inside `.godot/`.

## Godot conventions

Use Godot 4 APIs and syntax.

Prefer:

* `snake_case` for variables and functions;
* `PascalCase` for named classes;
* descriptive node names;
* exported properties for values that are useful to tune in the Inspector;
* signals when they reduce unnecessary coupling.

Prefer normal Godot node composition over unnecessarily deep inheritance
hierarchies.

When manually editing `.tscn` or `.tres` files, preserve Godot's text format
carefully and validate the project afterward.

Do not replace editor-generated identifiers or resource references without a
reason.

## Player

The player is a first-person 3D character.

Use `CharacterBody3D` as the basis of the player.

The basic hierarchy should remain conceptually similar to:

```
Player (CharacterBody3D)
├── CollisionShape3D
└── Head (Node3D)
    └── Camera3D
```

Horizontal mouse movement should rotate the player body.

Vertical mouse movement should rotate the head/camera and be constrained to a
reasonable vertical range.

The basic player currently supports:

* WASD movement;
* mouse look;
* collision with the environment;
* configurable walking speed;
* configurable mouse sensitivity;
* mouse capture and release.

Do not add jumping, crouching, sprinting, stamina, head bob, or similar movement
features unless explicitly requested.

Preserve the existing working controller unless a task specifically requires
changing it.

## VirtualBox development environment

Development is currently performed inside an Oracle VirtualBox virtual machine.

VirtualBox Mouse Integration interferes with relative mouse input required by the
first-person camera.

When manually testing mouse look, VirtualBox Mouse Integration must be disabled.

Do not modify the player controller to compensate for this VirtualBox-specific
behavior unless explicitly requested.

If WASD works but mouse look does not, consider the VirtualBox mouse integration
state before diagnosing the Godot input code.

## Environment

The Openrooms environment should feel like a large, repetitive, artificial
indoor space whose architecture is locally plausible but globally strange.

The initial visual vocabulary includes:

* yellowish walls;
* beige or brownish carpet;
* relatively low ceilings;
* fluorescent ceiling fixtures;
* repeated architectural patterns;
* corridors and rooms whose organization feels subtly incorrect;
* areas capable of becoming completely dark.

The environment should feel more like a badly or impossibly designed building
than a conventional maze.

Do not make the entire environment resemble a perfect maze-generation algorithm.

For early prototypes, simple primitive geometry is acceptable.

Use CSG for prototyping where convenient, but do not assume that large final
levels should consist of thousands of independent CSG nodes.

## Lighting

Lighting is both an atmospheric and gameplay system.

Ceiling lights normally begin turned off.

Lights near the player should activate as the player approaches and turn off
again after the player moves sufficiently far away.

Prefer separate activation and deactivation thresholds when useful to prevent
rapid switching near the boundary.

Lighting should eventually support behavior such as:

* normal startup;
* delayed startup;
* flickering;
* intermittent failure;
* permanently broken lights;
* permanent burnout during gameplay.

Not every light must activate.

Some rooms and corridors may remain partially or completely dark.

A light that permanently burns out during gameplay should remain burned out.

Do not make every distant lamp perform unnecessary per-frame processing.

Design lighting systems with potentially large environments in mind.

Avoid strong global ambient illumination. Areas without working lights should
be capable of becoming genuinely dark.

## Flashlight

The player starts with a flashlight and always has access to it.

Use `SpotLight3D` unless there is a strong technical reason to use another
approach.

Initially:

* the flashlight should be toggleable;
* it should not consume batteries;
* it should not have limited energy.

Do not introduce battery management, collectible batteries, inventory
integration, or related systems unless explicitly requested later.

## Performance

Openrooms may eventually contain many rooms, walls, lights, and repeated
objects.

Keep scalability in mind without prematurely optimizing the prototype.

Avoid designs that require every distant object to execute `_process()` or
`_physics_process()` continuously.

Prefer:

* reusable scenes;
* shared resources;
* spatial activation;
* grouping or managing repeated systems when scale requires it.

Optimize based on observed problems rather than speculation.

## Assets

Runtime assets used by Godot belong under this project, normally beneath
`assets/`.

Editable production source files may instead live in the repository-level
`source-assets/` directory.

Examples:

```
../../../source-assets/textures/wall/wall_master.kra
```

may produce:

```
assets/textures/wall.webp
```

Do not make the Godot project depend directly on files outside its project root.

Assets required at runtime should be copied or exported into the Godot project
in an appropriate runtime format.

## Validation

After changing GDScript, scenes, resources, or project configuration, validate
the project when practical with:

```
godot --headless --path . --editor --quit
```

Check the output for:

* GDScript parse errors;
* invalid resources;
* broken scene references;
* missing files;
* malformed `.tscn` or `.tres` files;
* other Godot errors caused by the change.

If validation fails because of a modification you made, diagnose and fix the
problem before considering the task complete.

Headless validation does not replace manual gameplay testing.

Changes involving movement, camera behavior, scale, lighting, visual appearance,
audio, or player experience should be reported as requiring manual testing when
appropriate.

## Development workflow

Before implementing a substantial feature:

1. inspect the existing scene and script structure;
2. understand the current implementation;
3. propose a simple approach when architectural choices are significant;
4. make the smallest coherent implementation;
5. validate it with Godot;
6. report files changed and any manual tests still required.

Do not silently introduce unrelated systems.

Do not restructure working scenes or scripts without a concrete benefit.

When several implementations are possible, prefer the one that best fits normal
Godot practices and remains easy to understand.

## General principle

The immediate objective is a convincing exploration experience, not a general
game framework.

Keep the Godot implementation simple, modular, readable, and easy to change.
