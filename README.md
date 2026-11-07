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

The repository contains the initial design documents and a minimal Godot 4 project scaffold. The first test scene includes a placeholder soldier, keyboard movement, a touch D-pad, and a safe-zone objective marker. It has **not yet been run or exported**; the next step is to open it in Godot, resolve any parser/runtime issues, and test on Android.

## Project documents

- [Game design](docs/GAME_DESIGN.md)
- [Development roadmap](docs/ROADMAP.md)
- [Technical decisions](docs/TECHNICAL_DECISIONS.md)

## Toolchain direction

Godot 4.x (2D) is the selected prototype direction because it is free, open source, lightweight, and supports Android export. The exact engine version and Android export setup will be pinned after the first local build test.

## Contributing / workflow

Keep changes small, explain each milestone, and test the Android build regularly. Do not commit generated build outputs, credentials, signing keys, or private data.
