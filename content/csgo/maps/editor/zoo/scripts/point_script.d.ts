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
        DebugScreenText(text: any, x: number, y: number, duration: number, color: Color): void;
        /** Draw a line in the world. Only works in dev environments. */
        DebugLine(start: Vector, end: Vector, duration: number, color: Color): void;
        /** Draw an axis aligned box in the world. Only works in dev environments. */
        DebugBox(mins: Vector, maxs: Vector, duraiton: number, color: Color): void;
        /** Draw a wire sphere in the world. Only works in dev environments. */
        DebugSphere(center: Vector, radius: number, duration: number, color: Color): void;

        /** Called in Tools mode before the script is reloaded due to changes. A returned value will be passed to the OnReload callback. */
        OnBeforeReload(callback: () => any): void;
        /** Called in Tools mode after the script reloaded due to changes while. */
        OnReload(callback: (memory: any) => void): void;

        /** Called per-think. Control when this is run using SetNextThink. */
        SetThink(callback: () => void): void;
        /** Set when the OnThink callback should next be run. The exact time will be the tick nearest to the specified time. Will be within 1/128th of a second, before or after. */
        SetNextThink(time: number): void;

        /** Called when the point_script entity is activated */
        OnActivate(callback: () => void): void;
        /** Called when input RunScriptInput is triggered on the point_script entity with a parameter value that matches name. */
        OnScriptInput(name: string, callback: (inputData: { caller?: Entity, activator?: Entity }) => void): void;
        OnPlayerConnect(callback: (player: CSPlayerController) => void): void;
        OnPlayerActivate(callback: (player: CSPlayerController) => void): void;
        OnPlayerDisconnect(callback: (playerSlot: number) => void): void;
        OnRoundStart(callback: () => void): void;
        OnRoundEnd(callback: (winningTeam: number) => void): void;
        OnBombPlant(callback: (c4: Entity, planter: CSPlayerPawn) => void): void;
        OnBombDefuse(callback: (c4: Entity, defuser: CSPlayerPawn) => void): void;
        OnPlayerKill(callback: (victim: CSPlayerPawn, info: { weapon?: CSWeaponBase, attacker?: Entity, inflictor?: Entity }) => void): void;
        OnPlayerChat(callback: (speaker: CSPlayerController, team: number, text: string) => void): void;
        OnGunFire(callback: (weapon: CSWeaponBase) => void): void;
        OnGrenadeThrow(callback: (weapon: CSWeaponBase, projectile: Entity) => void): void;

        /** Fire the input on all targets matching the specified names. */
        EntFireAtName(name: string, input: string, value?: InputValue, delay?: number): void;
        EntFireAtName(name: string, input: string, inputData?: InputData, delay?: number): void;
        /** Fire the input on the specified target. */
        EntFireAtTarget(target: Entity, input: string, value?: InputValue, delay?: number): void;
        EntFireAtTarget(target: Entity, input: string, inputData?: InputData, delay?: number): void;
        /** Connect the output of an entity to a callback. The return value is a connection id that can be used in `DisconnectOutput` */
        ConnectOutput(target: Entity, output: string, callback: (inputData: InputData) => any): number | undefined;
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

        /** Trace along a line and detect collisions */
        GetTraceHit(start: Vector, end: Vector, config?: TraceConfig): TraceResult;

        /** Get the game time in seconds. */
        GetGameTime(): number;
        /** Get if the game is currently in a Warmup period. */
        IsWarmupPeriod(): boolean;
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
    }

    type Vector = { x: number, y: number, z: number };
    type QAngle = { pitch: number, yaw: number, roll: number };
    type Color = { r: number, g: number, b: number, a?: number };
    type InputValue = boolean | number | string | Vector | Color | undefined;
    type InputData = { value?: InputValue, caller?: Entity, activator?: Entity };
    interface TraceConfig {
        ignoreEnt?: Entity, // Set to ignore collisions with an entity, typically the source of a trace
        interacts?: TraceInteracts, // Defaults to trace against any solid
        sphereRadius?: number; // Set to trace a sphere with specified radius
    }
    interface TraceResult {
        fraction: number;
        end: Vector;
        didHit: boolean;
        normal: Vector;
        hitEnt?: Entity;
    }

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

    enum TraceInteracts {
        SOLID = 0,
        WORLD = 1,
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
        Teleport(newPosition: Vector | null, newAngles: QAngle | null, newVelocity: Vector | null): void;
        GetClassName(): string;
        GetEntityName(): string;
        SetEntityName(name: string): void;
        GetTeamNumber(): number;
        GetHealth(): number;
        SetHealth(health: number): void;
        GetMaxHealth(): number;
        SetMaxHealth(health: number): void;
        GetGroundEntity(): Entity | undefined;
        Kill(): void;
        Remove(): void;
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
