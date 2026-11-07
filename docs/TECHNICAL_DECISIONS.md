# Technical Decisions

## TD-001 — Prefer Godot 4.x for the 2D Android game

**Status:** Proposed; validate with a minimal Android export before locking the exact version.

**Reasoning:** Godot is free and open source, has a dedicated 2D workflow, supports Android export, and is a practical fit for a lightweight offline game. It avoids a required subscription or paid runtime service.

**Validation required:**
- Confirm the editor runs acceptably on the development computer.
- Confirm Android export templates and SDK/JDK setup can be installed.
- Export and install a minimal APK on a real Android device.
- Measure basic performance before adding content.

## TD-002 — Build offline-first

**Status:** Accepted.

The first release is single-player and must not require an account, network connection, cloud save, or online API. Game progress is stored locally.

## TD-003 — Prototype before choosing detailed combat systems

**Status:** Accepted.

The first playable milestone tests movement, camera, touch controls, collision, and a simple objective. Combat depth, squad behavior, and base systems are deferred until the control model feels good on a phone.

## TD-004 — Landscape orientation as the initial assumption

**Status:** Proposed; validate during the touch-control prototype.

A landscape layout appears better suited to a tactical field of view and on-screen movement/action controls. Revisit if testing shows otherwise.

## Change log

Add new decisions here with an identifier, status, reasoning, and validation criteria.