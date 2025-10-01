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

        /** Called per-think. Control when this is run using SetNextThink. */
        SetThink(callback: () => void): void;
        /** Set when the OnThink callback should next be run. The exact time will be on the tick nearest to the specified time, which may be earlier or later. */
        SetNextThink(time: number): void;

        /** Called when the point_script entity is activated */
        OnActivate(callback: () => void): void;
        /** Called when input RunScriptInput is triggered on the point_script entity with a parameter value that matches name. */
        OnScriptInput(name: string, callback: (inputData: { caller?: Entity, activator?: Entity }) => void): void;

        OnPlayerConnect(callback: (event: { player: CSPlayerController }) => void): void;
        OnPlayerActivate(callback: (event: { player: CSPlayerController }) => void): void;
        OnPlayerDisconnect(callback: (event: { playerSlot: number }) => void): void;
        OnPlayerReset(callback: (event: { player: CSPlayerPawn }) => void): void
        OnRoundStart(callback: () => void): void;
        OnRoundEnd(callback: (event: { winningTeam: number }) => void): void;
        OnBombPlant(callback: (event: { plantedC4: Entity, planter: CSPlayerPawn }) => void): void;
        OnBombDefuse(callback: (event: { plantedC4: Entity, defuser: CSPlayerPawn }) => void): void;
        OnBeforePlayerDamage(callback: (event: { player: CSPlayerPawn, damage: number, inflictor?: Entity, attacker?: Entity, weapon?: CSWeaponBase }) => BeforeDamageResult): void;
        OnPlayerDamage(callback: (event: { player: CSPlayerPawn, damage: number, inflictor?: Entity, attacker?: Entity, weapon?: CSWeaponBase }) => void): void;
        OnPlayerKill(callback: (event: { player: CSPlayerPawn, inflictor?: Entity, attacker?: Entity, weapon?: CSWeaponBase }) => void): void;
        OnPlayerJump(callback: (event: { player: CSPlayerPawn }) => void): void;
        OnPlayerLand(callback: (event: { player: CSPlayerPawn }) => void): void;
        OnPlayerChat(callback: (event: { player: CSPlayerController | undefined, text: string, team: number }) => void): void;
        OnPlayerPing(callback: (event: { player: CSPlayerController, position: Vector }) => void): void;
        OnGunReload(callback: (event: { weapon: CSWeaponBase }) => void): void;
        OnGunFire(callback: (event: { weapon: CSWeaponBase }) => void): void;
        OnBulletImpact(callback: (event: { weapon: CSWeaponBase, position: Vector }) => void): void;
        OnGrenadeThrow(callback: (event: { weapon: CSWeaponBase, projectile: Entity }) => void): void;
        OnGrenadeBounce(callback: (event: { projectile: Entity, bounces: number }) => void): void;
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

        /** @deprecated */
        OnBeforeReload(callback: () => any): void;
        /** @deprecated */
        OnReload(callback: (memory: any) => void): void;
        /** @deprecated */
        DebugScreenText(text: any, x: number, y: number, duration: number, color: Color): void;
        /** @deprecated */
        DebugLine(start: Vector, end: Vector, duration: number, color: Color): void;
        /** @deprecated */
        DebugBox(mins: Vector, maxs: Vector, duration: number, color: Color): void;
        /** @deprecated */
        DebugSphere(center: Vector, radius: number, duration: number, color: Color): void;
        /** @deprecated */
        GetTraceHit(start: Vector, end: Vector, config?: { ignoreEntity?: Entity, ignorePlayers?: boolean }): TraceResult;
        /** @deprecated */
        EntFireAtName(name: string, input: string, inputData?: InputValue | { value?: InputValue, caller?: Entity, activator?: Entity }, delay?: number): void;
        /** @deprecated */
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
     * @example {damage:30, rangeModifer:.85, penetration:1} // Glock
     * @example {damage:30, rangeModifer:.45, penetration:1} // Mag-7
     * @example {damage:36, rangeModifier:.98, penetration:2} // AK47
     * @example {damage:115, rangeModifier:.99, penetration:2.5} // AWP
     */
    interface BulletTrace {
        start: Vector,
        end: Vector,
        shooter: CSPlayerPawn,
        damage?: number, // Default = 100
        rangeModifier?: number, // Default = .85
        penetration?: number, // Default = 1
    }

    interface BulletTraceResult {
        hitEntity: Entity;
        damage: number; // Damage value reduced by travel, before damage modification (body armor, headhshots, etc)
        position: Vector;
    }

    export class Entity {
        IsValid(): boolean;
        GetAbsOrigin(): Vector;
        GetLocalOrigin(): Vector;
        GetAbsAngles(): QAngle;
        GetLocalAngles(): QAngle;
        GetAbsVelocity(): Vector;
        GetLocalVelocity(): Vector;
        GetEyeAngles(): QAngle;
        GetEyePosition(): Vector;
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
        IsWorld(): boolean;
        GetGroundEntity(): Entity | undefined;
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
        GetDamage(): number; // Starting damage as the bullet travels
        GetRange(): number;
        GetRangeModifier(): number; // Exponential damage drop off from traveling through air. nextDamage = currentDamage * rangeModifier ^ (distance / 500).
        GetPenetration(): number; // Power to maintain damage during penetration
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
