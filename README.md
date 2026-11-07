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

The repository contains the initial design documents and a minimal Godot 4 project scaffold. The first mission prototype now includes a placeholder soldier, keyboard movement plus a continuous drag virtual joystick, camera follow, physical cover and map-boundary collisions, player health, three pursuing hostile units, mission success/failure states, and restart. The Godot headless import and smoke-test workflow has passed on the current gameplay prototype. An Android export preset and a free cloud APK-build workflow have also been added; the first APK build is currently being validated. No APK is considered ready until that workflow succeeds.

## Project documents

- [Game design](docs/GAME_DESIGN.md)
- [Development roadmap](docs/ROADMAP.md)
- [Technical decisions](docs/TECHNICAL_DECISIONS.md)

## Toolchain direction

Godot 4.x (2D) is the selected prototype direction because it is free, open source, lightweight, and supports Android export. The exact engine version and Android export setup will be pinned after the first local build test.

## Contributing / workflow

Keep changes small, explain each milestone, and test the Android build regularly. Do not commit generated build outputs, credentials, signing keys, or private data.
