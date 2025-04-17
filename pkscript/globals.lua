pkscript.LocalPlayer = LocalPlayer()
pkscript.TickInterval = engine.TickInterval()
pkscript.InverseTickInterval = 1 / pkscript.TickInterval

pkscript.Colors = pkscript.Colors or {}
pkscript.Colors.White = Color(255, 255, 255, 255)
pkscript.Colors.Red = Color(255, 0, 0, 255)
pkscript.Colors.Green = Color(0, 255, 0, 255)
pkscript.Colors.Blue = Color(0, 0, 255, 255)
pkscript.Colors.Yellow = Color(255, 255, 0, 255)
pkscript.Colors.Pink = Color(255, 0, 255, 255)
pkscript.Colors.Purple = Color(100, 0, 255, 255)

pkscript.ConVars = pkscript.ConVars or {}
pkscript.ConVars.cl_sidespeed = GetConVar("cl_sidespeed")
pkscript.ConVars.cl_forwardspeed = GetConVar("cl_forwardspeed")

pkscript.GlobalCache = pkscript.GlobalCache or {}
