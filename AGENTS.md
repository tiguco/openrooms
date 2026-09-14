# Openrooms

Openrooms is an open-source first-person exploration game.

The project is inspired by liminal spaces and maze-like artificial environments,
including the general aesthetic associated with the Backrooms, but Openrooms
should evolve as its own project with its own visual, architectural, and gameplay
identity.

The repository contains more than the game engine project itself. It may also
contain documentation, artwork, source assets, soundtrack material, design notes,
and other project resources.

## Project philosophy

Openrooms should remain:

* open and easy to study;
* easy to modify and experiment with;
* reasonably simple to build and understand;
* modular without unnecessary abstraction;
* friendly to contributors.

Avoid unnecessary complexity and premature infrastructure.

Prefer simple solutions that can be extended later.

## License

The project source code is licensed under the GNU General Public License version
3 or later unless otherwise specified.

Do not remove copyright or license information.

Assets may eventually use different compatible licenses. When adding third-party
assets, always preserve their attribution and licensing information.

Do not assume that an external asset can be redistributed merely because it is
available online.

## Repository organization

The repository represents the Openrooms project as a whole.

The intended high-level organization is:

* `game/` - playable game implementations and engine-specific projects;
* `game/godot/` - current Godot implementation;
* `docs/` - design, technical, development, and player documentation;
* `artwork/` - concept art, promotional art, illustrations, and related material;
* `soundtrack/` - soundtrack projects, masters, and related material;
* `source-assets/` - editable production sources for textures, models, audio,
  and other assets.

Not all of these directories need to exist yet. Create them only when needed.

Files used directly by the Godot runtime belong inside the Godot project rather
than in the repository-level source asset directories.

For example:

```
source-assets/textures/wall/wall_master.kra
```

may be the editable source, while:

```
game/godot/assets/textures/wall.webp
```

may be the optimized runtime asset.

Avoid unnecessary duplication, but keep a clear distinction between production
source files and runtime game assets when appropriate.

## Engine independence

The current game implementation uses Godot, but the repository structure should
not unnecessarily assume that Godot will always be the only implementation.

Engine-specific code and files should remain isolated inside their corresponding
engine directory.

For example:

```
game/godot/
```

A future experimental implementation using another engine could therefore live
alongside it without reorganizing the entire Openrooms project.

Do not move engine-specific files into the repository root without a good reason.

## Documentation

Keep persistent project knowledge in the repository.

Use documentation for decisions and concepts that are too detailed for
`AGENTS.md`.

Possible documentation areas include:

* game design;
* environment and architectural generation;
* lighting design;
* sound design;
* technical architecture;
* asset pipeline;
* contributor information.

Keep `AGENTS.md` focused on working rules rather than turning it into a complete
design document.

## Development approach

Work incrementally.

For substantial changes:

1. inspect the relevant files first;
2. understand the existing structure;
3. preserve working behavior unless a change requires otherwise;
4. make the smallest coherent change;
5. validate the result;
6. report what changed and any remaining concerns.

Do not introduce unrelated features while implementing a focused task.

Do not rewrite working systems merely to make them different.

When requirements are ambiguous, prefer a simple and reversible solution.

## Git

Assume the repository is version-controlled with Git and hosted publicly.

Before substantial modifications, inspect:

```
git status
```

Never discard, overwrite, or revert existing user changes without explicit
instruction.

Do not rewrite Git history.

Do not make commits, create tags, push branches, or publish releases unless
explicitly asked.

Keep generated files and local development state out of version control.

Prefer meaningful, focused changes that are easy to review with `git diff`.

## Generated and temporary files

Do not commit:

* editor caches;
* build caches;
* temporary files;
* engine-generated metadata that is normally regenerated;
* local machine configuration unless it is intentionally part of the project.

Engine-specific ignore rules may be defined inside the corresponding engine
project or in the repository root.

## General principle

Treat Openrooms as a long-lived open-source creative project rather than only as
a collection of source files.

Keep the repository understandable to someone encountering it for the first
time.

Prefer clarity, portability, and maintainability over cleverness.
