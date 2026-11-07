# Development Roadmap

The project is developed in small vertical slices. Each milestone should produce something testable, preferably on an Android phone.

## Milestone 0 — Repository and design foundation
- [x] Initialize repository
- [x] Record the game premise and campaign outline
- [x] Define the first playable prototype
- [ ] Confirm engine version and local toolchain
- [x] Add project folders and starter project

## Milestone 1 — Movement prototype
- [x] Create a small test scene
- [x] Add player movement and collision
- [x] Add mobile touch controls (basic D-pad)
- [x] Add basic HUD and objective marker
- [ ] Add camera follow
- [ ] Test frame rate and controls on Android

**Exit criteria:** a player can move around a small map on a phone without editor or keyboard input.

## Milestone 2 — Interaction and objective
- [ ] Add interactable objects
- [x] Add objective marker and completion state
- [ ] Add pause, restart, and a simple local save
- [ ] Build and test an APK

**Exit criteria:** the player can complete a short start-to-safe-zone objective on Android.

## Milestone 3 — First encounter
- [ ] Add one simple enemy behavior
- [ ] Add health, damage feedback, and defeat/retry flow
- [ ] Tune readability and difficulty for touch screens

## Milestone 4 — First chapter slice
- [ ] Add placeholder story dialogue
- [ ] Add one compact level with beginning, middle, and end
- [ ] Add basic sound and original/licensed visual assets
- [ ] Run a performance and usability pass

## Milestone 5 — Campaign systems
- [ ] Squad members and simple companion behaviors
- [ ] Resource and defensive-position systems
- [ ] Chapter progression and local save slots
- [ ] Later chapter prototypes

## Release preparation
- [ ] Accessibility and settings
- [ ] Test on multiple Android screen sizes
- [ ] Verify offline behavior
- [ ] Verify all asset licenses
- [ ] Create release build and installation instructions

## Working rules

- Keep the main branch buildable.
- Make one focused change per commit.
- Do not add large features before the current milestone works on a phone.
- Prefer free tools and original/appropriately licensed assets.
- Record important technical choices in docs/TECHNICAL_DECISIONS.md.
