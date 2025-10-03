/**
 * This file, `point_script.d.ts`, documents the JavaScript API for cs_script scripts attached to point_script entities.
 * This file is a TypeScript Declaration file. https://www.typescriptlang.org/docs/handbook/2/type-declarations.html#dts-files
 * This file can be used by various editors to provide tooling while editing JavaScript. https://www.typescriptlang.org/docs/handbook/intro-to-js-ts.html 
 * Next to this file is a `tsconfig.json` file configured for editing JavaScript targetting the current version used by CS2.
 * Place copies of these two files, `point_script.d.ts` and `tsconfig.json`, next to your scripts and some editors will begin providing tooling without further configuration.
 * These two files will be maintained as the cs_script API changes or the JavaScript version in CS2 is updated.
 */

/**
 * `"cs_script/point_script"` is the module provided to scripts loaded for point_script entities.
 * 
 * # Setup:
 * - Create a JavaScript file (.js) that imports this module.
 *      - See `hello.js` for an example.
 * - Create a point_script entity in your map and set its cs_script field to reference your JavaScript file as a vjs asset.
 *      - See `script_zoo.vmap`. There is a point_script entity in there named "hello_cs_script" that runs `hello.js`. There are a handful of other examples as well.
 * 
 * # Execution:
 * - The compiled version of your script (.vjs_c) will be loaded during map load.
 * - When the point_script entity is spawned it will execute all code at the top level scope of your script.
 * - Register callbacks on `Instance` to setup code that executes at various times throughout the lifetime of the map.
 *      - A function passed to `Instance.OnActivate` will be invoked when the point_script entity is activated.
 *      - A function passed to `Instance.OnPlayerJump` will be invoked when any player in the map jumps.
 *
 * # Tips:
 * - Entity variables are stable. Two variables referring to the same entity will be reference equals (===).
 * - Extra values attached to an entity variable will still be there if the variable is fetched again.
 * - A map can have multiple point_script entities. Each script will run with its own Instance, set of globals, and set of entity variables.
 * 
 * # Tools Mode:
 * - In tools mode, saving changes to your script will recompile your file, clear all registered callbacks, and re-run the top level scope of your script.
 * - Global variables and instances of entity variables will persist across reloads.
 *      - Beware. This is an avenue for holding references to code from previous iterations of your script. This is only a concern in tools mode.
 * - See `Instance.OnScriptReload` for a tool to handle edge cases around reloading.
 */
declare module "cs_script/point_script"
{
    export const Instance: Domain;

    /**
     * The top level API provided to scripts attached to a point_script entity.
     * Access these functions by importing Instance from "cs_script/point_script".
     */
    class Domain {
        /** Log a message to the console. */
        Msg(text: any): void;
        /** Print some text to the game window. Only works in dev environments. */
        DebugScreenText(config: { text: any, x: number, y: number, duration?: number, color?: Color }): void;
        /** Draw a line in the world. Only works in dev environments. */
        DebugLine(config: { start: Vector, end: Vector, duration?: number, color?: Color }): void;
        /** Draw a wire sphere in the world. Only works in dev environments. */
        DebugSphere(config: { center: Vector, radius: number, duration?: number, color?: Color }): void;
        /** Draw an axis aligned box in the world. Only works in dev environments. */
        DebugBox(config: { mins: Vector, maxs: Vector, duration?: number, color?: Color }): void;

        /**
         * Called in Tools mode when the script is reloaded due to changes.
         * The before callback will be invoked before pre-load teardown.
         * The after callback will be invoked after the new script is evaluated and will be passed the return value of the before callback.
         */
        OnScriptReload<T>(config: { before?: () => T, after?: (memory: T) => void }): void;

        /** Called at a specified time. Control when this is run using SetNextThink. */
        SetThink(callback: () => void): void;
        /** Set when the OnThink callback should next be run. The exact time will be on the tick nearest to the specified time, which may be earlier or later. */
        SetNextThink(time: number): void;

        /** Called when the point_script entity is activated */
        OnActivate(callback: () => void): void;
        /** Called when input RunScriptInput is triggered on the point_script entity with a parameter value that matches name. */
        OnScriptInput(name: string, callback: (inputData: { caller?: Entity, activator?: Entity }) => void): void;

        /** Called when a client finishes the initial connection handshake with the server. */
        OnPlayerConnect(callback: (event: { player: CSPlayerController }) => void): void;
        /** Called when a client finishes loading and is ready to spawn. */
        OnPlayerActivate(callback: (event: { player: CSPlayerController }) => void): void;
        /** Called when a client disconnects from the server. */
        OnPlayerDisconnect(callback: (event: { playerSlot: number }) => void): void;
        /** Called when a player respawns, changes team, or is placed back at spawn due to a round restart */
        OnPlayerReset(callback: (event: { player: CSPlayerPawn }) => void): void
        /** Called when a new round begins */
        OnRoundStart(callback: () => void): void;
        /** Called when a team wins a round */
        OnRoundEnd(callback: (event: { winningTeam: number }) => void): void;
        /** Called when a player plants the c4 */
        OnBombPlant(callback: (event: { plantedC4: Entity, planter: CSPlayerPawn }) => void): void;
        /** Called when a player defuses the c4 */
        OnBombDefuse(callback: (event: { plantedC4: Entity, defuser: CSPlayerPawn }) => void): void;
        /**
         * Called when a CSPlayerPawn is about to take damage
         * @param callback
         * Return `{ damage: N }` to modify the amount of damage. Armor and hitgroup modifications will be applied to this new value.
         * Return `{ aborted: true }` to cancel the damage event.
         */
        OnBeforePlayerDamage(callback: (event: { player: CSPlayerPawn, damage: number, inflictor?: Entity, attacker?: Entity, weapon?: CSWeaponBase }) => BeforeDamageResult): void;
        /** 
         * Called when a player has taken damage.
         * `player` is the victim that has taken damage.
         * `damage` is the actual health lost after armor and hitgroup modifications.
         * `inflictor` is the entity applying the damage. For bullets this is the owner of the gun. For grenades this is the exploding projectile.
         * `attacker` is the entity credited with causing the damage. For bullets this is the shooter. For grenades this is the thrower.
         * `weapon` is the weapon used. For grenades this will not be present because the weapon is often removed before the projectile explodes.
         */
        OnPlayerDamage(callback: (event: { player: CSPlayerPawn, damage: number, inflictor?: Entity, attacker?: Entity, weapon?: CSWeaponBase }) => void): void;
        /** Called when a player dies. `inflictor`, `attacker` and `weapon` will match the damage event that caused the kill. */
        OnPlayerKill(callback: (event: { player: CSPlayerPawn, inflictor?: Entity, attacker?: Entity, weapon?: CSWeaponBase }) => void): void;
        /** Called when a player jumps off the ground. */
        OnPlayerJump(callback: (event: { player: CSPlayerPawn }) => void): void;
        /** Called when a player lands on the ground. */
        OnPlayerLand(callback: (event: { player: CSPlayerPawn }) => void): void;
        /** Called when a player sends a chat message. `team` will match they player's team if the message was sent to team chat. */
        OnPlayerChat(callback: (event: { player: CSPlayerController | undefined, text: string, team: number }) => void): void;
        /** Called when a player pings a location. */
        OnPlayerPing(callback: (event: { player: CSPlayerController, position: Vector }) => void): void;
        /** Called when a gun is reloaded. */
        OnGunReload(callback: (event: { weapon: CSWeaponBase }) => void): void;
        /** Called when a gun emits bullets. A shotgun will only trigger this once when emitting multiple bullets at once. */
        OnGunFire(callback: (event: { weapon: CSWeaponBase }) => void): void;
        /** Called when a bullet hits a surface. This will trigger for each bullet and for each impact. Penetrations can cause a single bullet to trigger multiple impacts. */
        OnBulletImpact(callback: (event: { weapon: CSWeaponBase, position: Vector }) => void): void;
        /** Called when a grenade is thrown. `projectile` is the newly created grenade projectile. */
        OnGrenadeThrow(callback: (event: { weapon: CSWeaponBase, projectile: Entity }) => void): void;
        /** Called when a grenade bounces off a surface. `bounces` is the number of bounces so far. */
        OnGrenadeBounce(callback: (event: { projectile: Entity, bounces: number }) => void): void;
        /** Called when a knife attacks, even if it misses. */
        OnKnifeAttack(callback: (event: { weapon: CSWeaponBase }) => void): void;

        /** Fire the input on all targets matching the specified names. */
        EntFireAtName(config: { name: string, input: string, value?: InputValue, caller?: Entity, activator?: Entity, delay?: number }): void;
        /** Fire the input on the specified target. */
        EntFireAtTarget(config: { target: Entity, input: string, value?: InputValue, caller?: Entity, activator?: Entity, delay?: number }): void;
        /** Connect the output of an entity to a callback. The return value is a connection id that can be used in `DisconnectOutput` */
        ConnectOutput(target: Entity, output: string, callback: (inputData: { value?: InputValue, caller?: Entity, activator?: Entity }) => any): number | undefined;
        /** Find entities by name. */
        DisconnectOutput(connectionId: number): void;

        /** Find the first entity matching the specified name. */
        FindEntityByName(name: string): Entity | undefined;
        /** Find entities matching the specified name. */
        FindEntitiesByName(name: string): Entity[];
        /** Find the first entity of the specified class name. */
        FindEntityByClass(className: string): Entity | undefined;
        /** Find entities of the specified class name. */
        FindEntitiesByClass(className: string): Entity[];
        /** Get the player controller in the given slot. */
        GetPlayerController(playerSlot: number): CSPlayerController | undefined;

        /** Trace a point along a line and detect collisions */
        TraceLine(trace: { start: Vector, end: Vector, ignoreEntity?: Entity, ignorePlayers?: boolean }): TraceResult;
        /** Trace a sphere along a line and detect collisions */
        TraceSphere(trace: { start: Vector, end: Vector, radius: number, ignoreEntity?: Entity, ignorePlayers?: boolean }): TraceResult;
        /** Trace an axis aligned bounding box along a line and detect collisions */
        TraceBox(trace: { start: Vector, end: Vector, mins: Vector, maxs: Vector, ignoreEntity?: Entity, ignorePlayers?: boolean }): TraceResult;
        /** Trace as a bullet and detect hits and damage */
        TraceBullet(trace: BulletTrace): BulletTraceResult[];

        /** Get the game time in seconds. */
        GetGameTime(): number;
        /** Get if the game is currently in a Warmup period. */
        IsWarmupPeriod(): boolean;
        /** Get if the game is currently in a Freeze period. */
        IsFreezePeriod(): boolean;
        /** Get the current Game Type. */
        GetGameType(): number;
        /** Get the current Game Mode. */
        GetGameMode(): number;
        /** Get the name of the current map. */
        GetMapName(): string;
        /** Get the number of rounds played in the current game. */
        GetRoundsPlayed(): number;

        /** Issue the specified command to the specified client. */
        ClientCommand(playerSlot: number, command: string): void;
        /** Issue a command. */
        ServerCommand(command: string): void;

        /** @deprecated This method will be removed in a future update */
        OnBeforeReload(callback: () => any): void;
        /** @deprecated This method will be removed in a future update */
        OnReload(callback: (memory: any) => void): void;
        /** @deprecated This overload will be removed in a future update */
        DebugScreenText(text: any, x: number, y: number, duration: number, color: Color): void;
        /** @deprecated This overload will be removed in a future update */
        DebugLine(start: Vector, end: Vector, duration: number, color: Color): void;
        /** @deprecated This overload will be removed in a future update */
        DebugBox(mins: Vector, maxs: Vector, duration: number, color: Color): void;
        /** @deprecated This overload will be removed in a future update */
        DebugSphere(center: Vector, radius: number, duration: number, color: Color): void;
        /** @deprecated This method will be removed in a future update */
        GetTraceHit(start: Vector, end: Vector, config?: { ignoreEntity?: Entity, ignorePlayers?: boolean }): TraceResult;
        /** @deprecated This overload will be removed in a future update */
        EntFireAtName(name: string, input: string, inputData?: InputValue | { value?: InputValue, caller?: Entity, activator?: Entity }, delay?: number): void;
        /** @deprecated This overload will be removed in a future update */
        EntFireAtTarget(target: Entity, input: string, inputData?: InputValue | { value?: InputValue, caller?: Entity, activator?: Entity }, delay?: number): void;
    }

    type Vector = { x: number, y: number, z: number };
    type QAngle = { pitch: number, yaw: number, roll: number };
    type Color = { r: number, g: number, b: number, a?: number };
    type InputValue = boolean | number | string | Vector | Color | undefined;
    type BeforeDamageResult = { damage?: number, abort?: boolean } | void;

    enum CSWeaponType {
        KNIFE = 0,
        PISTOL = 1,
        SUBMACHINEGUN = 2,
        RIFLE = 3,
        SHOTGUN = 4,
        SNIPER_RIFLE = 5,
        MACHINEGUN = 6,
        C4 = 7,
        TASER = 8,
        GRENADE = 9,
        EQUIPMENT = 10,
        STACKABLEITEM = 11,
        UNKNOWN = 12
    }

    enum CSGearSlot {
        INVALID = -1,
        RIFLE = 0,
        PISTOL = 1,
        KNIFE = 2,
        GRENADES = 3,
        C4 = 4
    }

    interface TraceResult {
        fraction: number;
        end: Vector;
        didHit: boolean;
        startedInSolid: boolean;
        normal: Vector;
        hitEntity?: Entity;
    }

    /**
     * Configuration object for `Instance.TraceBullet`
     * @example {damage:30, rangeModifer:.85, penetration:1} // Glock
     * @example {damage:30, rangeModifer:.45, penetration:1} // Mag-7
     * @example {damage:36, rangeModifier:.98, penetration:2} // AK47
     * @example {damage:115, rangeModifier:.99, penetration:2.5} // AWP
     */
    interface BulletTrace {
        start: Vector,
        end: Vector,
        /** The player shooting the bullet. Acts as `ignoreEnt` for traces. */
        shooter: CSPlayerPawn,
        /** The starting damage value of the bullet. This will reduce as it travels through the air and penetrates solids. @default 100 */
        damage?: number,
        /** The exponential damage drop off constant from traveling through air. @default .85 */
        rangeModifier?: number,
        /** The power to maintain damage during penetration. Will default to 1 if left unspecified. @default 1 */
        penetration?: number,
    }

    /**
     * Result entry for `Instance.TraceBullet`
     */
    interface BulletTraceResult {
        /** The entity hit by the bullet. This is not limited to players. */
        hitEntity: Entity;
        /** Damage value reduced by travel, before damage modification (body armor, headhshots, etc) */
        damage: number;
        position: Vector;
    }

    /**
     * The base class for all entities
     */
    export class Entity {
        /** Returns `false` if the entity has been deleted. */
        IsValid(): boolean;
        /** The position of the origin of this entity relative to the world. */
        GetAbsOrigin(): Vector;
        /** The position of the origin of this entity relative to its parent. Will be relative to the world if no parent. */
        GetLocalOrigin(): Vector;
        /** The angles (pitch, yaw, and roll) of this entity relative to the world. */
        GetAbsAngles(): QAngle;
        /** The angles (pitch, yaw, and roll) of this entity relative to its parent. Will be relative to the world if no parent. */
        GetLocalAngles(): QAngle;
        /** The velocity of this entity relative to the world. */
        GetAbsVelocity(): Vector;
        /** The velocity of this entity relative to its parent. Will be relative to the world if no parent. */
        GetLocalVelocity(): Vector;
        /** The angles of the eyes of this entity relative to the world. */
        GetEyeAngles(): QAngle;
        /** The position of the eyes of this entity relative to the world */
        GetEyePosition(): Vector;
        /** Update the physics state of this entity. */
        Teleport(newValues: { position?: Vector, angles?: QAngle, velocity?: Vector }): void;
        GetClassName(): string;
        GetEntityName(): string;
        SetEntityName(name: string): void;
        GetOwner(): Entity | undefined;
        SetOwner(owner: Entity | undefined): void;
        GetParent(): Entity | undefined;
        SetParent(parent: Entity | undefined): void;
        GetTeamNumber(): number;
        GetHealth(): number;
        SetHealth(health: number): void;
        GetMaxHealth(): number;
        SetMaxHealth(health: number): void;
        IsAlive(): boolean;
        /** Get if this is the world entity */
        IsWorld(): boolean;
        /** Get the entity that this entity is resting on. Will be `undefined` if in the air. */
        GetGroundEntity(): Entity | undefined;
        /** Apply damage to this entity. Damage value will be modified by armor and hitgroup. */
        TakeDamage(takeDamage: { damage: number, inflictor?: Entity, attacker?: Entity, weapon?: CSWeaponBase }): number;
        Kill(): void;
        Remove(): void;

        /** @deprecated */
        Teleport(newPosition: Vector | null, newAngles: QAngle | null, newVelocity: Vector | null): void;
    }

    export class BaseModelEntity extends Entity {
        SetModel(modelName: string): void;
        SetModelScale(scale: number): void;
        SetColor(color: Color): void;
        Glow(color?: Color): void;
        Unglow(): void;
    }

    export class CSWeaponBase extends BaseModelEntity {
        GetData(): CSWeaponData;
        GetOwner(): CSPlayerPawn | undefined;
    }

    export class CSWeaponData {
        GetName(): string;
        GetType(): CSWeaponType;
        GetPrice(): number;
        GetDamage(): number;
        /** Maximum distance bullets will travel. */
        GetRange(): number;
        /** Exponential damage drop off from traveling through air. nextDamage = currentDamage * rangeModifier ^ (distance / 500). */
        GetRangeModifier(): number;
        /** Power to maintain damage during penetration */
        GetPenetration(): number;
    }

    export class CSPlayerController extends Entity {
        GetPlayerSlot(): number;
        GetPlayerName(): string;
        GetPlayerPawn(): CSPlayerPawn | undefined;
        GetObserverPawn(): CSObserverPawn | undefined;
        GetScore(): number;
        /** Add to the player's score. Negative values are allowed but the score will not go below zero. */
        AddScore(points: number): void;
        /** Leave team as the default to use the player's current team. */
        GetWeaponDataForLoadoutSlot(slot: number, team?: number): CSWeaponData | undefined;
        IsObserving(): boolean;
        IsBot(): boolean;
        IsConnected(): boolean;
        JoinTeam(team: number): void;
    }

    export class CSObserverPawn extends BaseModelEntity {
        /** Gets the controller currently controlling this player pawn. */
        GetPlayerController(): CSPlayerController | undefined;
        /** Gets the controller that this player pawn was originally spawned for. */
        GetOriginalPlayerController(): CSPlayerController;
        GetObserverMode(): number;
        SetObserverMode(nMode: number): void;
    }

    export class CSPlayerPawn extends BaseModelEntity {
        /** Gets the controller currently controlling this player pawn. */
        GetPlayerController(): CSPlayerController | undefined;
        /** Gets the controller that this player pawn was originally spawned for. */
        GetOriginalPlayerController(): CSPlayerController;
        FindWeapon(name: string): CSWeaponBase | undefined;
        FindWeaponBySlot(slot: CSGearSlot): CSWeaponBase | undefined;
        GetActiveWeapon(): CSWeaponBase | undefined;
        DestroyWeapon(target: CSWeaponBase): void;
        DestroyWeapons(): void;
        DropWeapon(target: CSWeaponBase): void;
        SwitchToWeapon(target: CSWeaponBase): void;
        GiveNamedItem(name: string, autoDeploy?: boolean): void;
        GetArmor(): number;
        SetArmor(value: number): void;
        IsCrouching(): boolean;
        IsCrouched(): boolean;
        IsNoclipping(): boolean;
    }

    export class PointTemplate extends Entity {
        ForceSpawn(origin?: Vector, angle?: QAngle): Entity[] | undefined;
    }
}

/**
 * @deprecated This unreleased feature will be removed in a future update as will the ability to load vts assets.
 */
declare module "server/serverpointentity" {}
/**
 * @deprecated This unreleased feature will be removed in a future update as will the ability to load vts assets.
 */
declare module "server/cspointscript" {}
