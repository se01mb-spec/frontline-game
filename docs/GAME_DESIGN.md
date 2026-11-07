# Game Design Document — Frontline

## 1. High concept

**Genre:** 2D single-player action-strategy / base defense  
**Platform:** Android first  
**Mode:** Offline, single player  
**Business model:** Free; no paid assets, subscriptions, or required online services  
**Camera:** To be validated in the prototype; default direction is top-down with a readable tactical view  
**Tone:** Tense, grounded, cinematic, focused on survival and teamwork

The player controls an Iranian soldier during the opening hours of a fictionalized war. The opening is chaotic and personal: survive the initial attack, find fellow soldiers, rebuild a defensive position, and gradually regain the ability to resist.

## 2. Core player experience

The intended emotional and gameplay progression is:

1. **Vulnerability:** the player begins alone, disoriented, and under-equipped.
2. **Connection:** the player finds fellow soldiers and forms a small squad.
3. **Recovery:** the group secures resources and restores defensive systems.
4. **Preparation:** the player helps bring a damaged missile facility back into operation.
5. **Payoff:** the final operation tests the people and capabilities gathered throughout the campaign.

## 3. Campaign outline

### Chapter 1 — The first day
- Begin during a sudden attack.
- Teach movement, observation, interaction, and basic survival.
- The immediate objective is to reach a safe position.
- End with a clear lead toward missing comrades.

### Chapter 2 — Regroup
- Search for scattered fellow soldiers.
- Introduce squad members and simple companion roles.
- Defend the group against hostile airborne troops.
- Make teamwork and protecting civilians central to the chapter.

### Chapter 3 — Restore air defense
- Secure a damaged defensive position.
- Find parts and personnel needed to restore it.
- Introduce a preparation/defense loop and a limited wave encounter.
- Keep the mechanics readable and abstract rather than simulating real-world weapon operation.

### Chapter 4 — The missile facility
- Reach and secure a damaged underground facility.
- Restore power, communications, and fictionalized launch-system readiness through simple game objectives.
- Use a dramatic, non-technical presentation; do not model real weapon construction or operational procedures.

### Chapter 5 — Final operation
- Bring together the squad and capabilities earned in earlier chapters.
- Complete a multi-stage objective with meaningful choices and consequences.
- Resolve the story around survival, solidarity, and the cost of war.

## 4. Core gameplay loop

Explore → identify an objective → collect or protect what is needed → make a tactical choice → survive an encounter → improve the squad/base → unlock the next story beat.

## 5. Design pillars

- **Readable on a phone:** large controls, clear silhouettes, uncluttered HUD.
- **Meaningful progression:** every chapter adds one main mechanic, not many systems at once.
- **Offline by design:** save locally; no login or server dependency.
- **Performance first:** modest effects, small levels, object pooling where needed, and configurable quality.
- **Human story:** characters, civilians, and consequences matter more than spectacle.

## 6. First playable prototype

The first prototype is deliberately much smaller than Chapter 1:

- One compact test map.
- One controllable placeholder soldier.
- Touch joystick or on-screen directional controls.
- One interaction button.
- One simple objective: reach a marked safe zone.
- One basic enemy or hazard used only to test detection and damage feedback.
- Pause and restart.
- Android export and a short performance check on a real phone.

No full campaign, squad AI, base management, or complex combat is required for this milestone.

## 7. Scope safeguards

- Use fictional characters, locations, unit names, and events.
- Avoid claiming that fictional scenes depict verified historical events.
- Keep weapon-related gameplay abstract and entertainment-focused.
- Prefer original or properly licensed assets; record each asset's source and license.
- Do not add online services unless a later design decision clearly requires them.

## 8. Open design questions

These will be settled through prototypes rather than prolonged speculation:

- Top-down versus isometric presentation.
- Real-time action versus pause-and-command emphasis.
- Portrait versus landscape orientation (initial assumption: landscape).
- How much squad control is fun and manageable on touch screens.
- Final visual style and art production pipeline.
