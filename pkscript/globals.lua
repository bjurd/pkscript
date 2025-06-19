pkscript.LocalPlayer = LocalPlayer()
pkscript.TickInterval = engine.TickInterval()
pkscript.InverseTickInterval = 1 / pkscript.TickInterval

pkscript.Colors = pkscript.Colors or {}
pkscript.Colors.White = Color(255, 255, 255, 255)
pkscript.Colors.Black = Color(0, 0, 0, 255)
pkscript.Colors.Red = Color(255, 0, 0, 255)
pkscript.Colors.Green = Color(0, 255, 0, 255)
pkscript.Colors.Blue = Color(0, 0, 255, 255)
pkscript.Colors.Aqua = Color(0, 255, 255, 255)
pkscript.Colors.Orange = Color(255, 150, 0, 255)
pkscript.Colors.Yellow = Color(255, 255, 0, 255)
pkscript.Colors.Pink = Color(255, 0, 255, 255)
pkscript.Colors.Purple = Color(100, 0, 255, 255)

pkscript.ConVars = pkscript.ConVars or {}
pkscript.ConVars.cl_sidespeed = GetConVar("cl_sidespeed")
pkscript.ConVars.cl_forwardspeed = GetConVar("cl_forwardspeed")
pkscript.ConVars.fov_desired = GetConVar("fov_desired")
pkscript.ConVars.host_timescale = GetConVar("host_timescale")

pkscript.MoveTypes = pkscript.MoveTypes or {}
pkscript.MoveTypes[MOVETYPE_NONE] = "None"
pkscript.MoveTypes[MOVETYPE_ISOMETRIC] = "Isometric"
pkscript.MoveTypes[MOVETYPE_WALK] = "Walk"
pkscript.MoveTypes[MOVETYPE_STEP] = "Step"
pkscript.MoveTypes[MOVETYPE_FLY] = "Fly"
pkscript.MoveTypes[MOVETYPE_FLYGRAVITY] = "FlyGrav"
pkscript.MoveTypes[MOVETYPE_PUSH] = "Push"
pkscript.MoveTypes[MOVETYPE_NOCLIP] = "Noclip"
pkscript.MoveTypes[MOVETYPE_LADDER] = "Ladder"
pkscript.MoveTypes[MOVETYPE_OBSERVER] = "Spectator"
pkscript.MoveTypes[MOVETYPE_CUSTOM] = "Custom"
