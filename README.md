# Frontline

A free, offline-first 2D Android strategy and base-defense game.

## Premise

The player is an Iranian soldier caught in the surprise attack on the first day of a fictionalized Iran–United States war. The first objective is survival. The story then expands into regrouping with fellow soldiers, defending the area, restoring defensive capabilities, bringing a missile facility back online, and carrying out the final operation.

## Project principles

- Android is the primary target.
- Offline single-player experience; no account or paid service required.
- Lightweight 2D presentation suitable for mid-range phones.
- Build with free and open-source tools wherever practical.
- Develop in small, playable milestones and keep the project reproducible.
- Keep the story and setting fictionalized; avoid presenting invented events as factual reporting.

## Current status

The first mission prototype includes keyboard movement plus a continuous drag virtual joystick, camera follow, physical cover and map-boundary collisions, player health, three pursuing hostile units, mission success/failure states, and restart.

The player now uses a transparent cutout extracted from the user-supplied M. Reza character design sheet. The source sheet contains character turnarounds and equipment references, but not sequential walk-cycle frames; this first integration therefore uses the front hero pose with directional rotation and a subtle movement bob. Proper front/side/back directional animation remains a planned art task.

Godot headless validation and Android export run through free GitHub Actions workflows. A successful cloud build is not a substitute for testing on a physical Android device.

## Project documents

- [Game design](docs/GAME_DESIGN.md)
- [Development roadmap](docs/ROADMAP.md)
- [Technical decisions](docs/TECHNICAL_DECISIONS.md)

## Toolchain direction

Godot 4.3 (2D) is the pinned prototype direction because it is free, open source, lightweight, and supports Android export.

## Contributing / workflow

Keep changes small, explain each milestone, and test the Android build regularly. Do not commit generated build outputs, credentials, signing keys, or private data.
