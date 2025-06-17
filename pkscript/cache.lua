pkscript.Cache = pkscript.Cache or {}
local Cache = pkscript.Cache

Cache.Materials = Cache.Materials or {}

Cache.ScreenSetup = Cache.ScreenSetup or {}
Cache.ScreenSetup.Width = ScrW()
Cache.ScreenSetup.Height = ScrH()
Cache.ScreenSetup.Center = Vector(Cache.ScreenSetup.Width / 2, Cache.ScreenSetup.Height / 2)

function Cache.FrameUpdate()
	Cache.ViewSetup = Cache.ViewSetup or {}
	local EngineView = render.GetViewSetup()

	Cache.ViewSetup.ViewOrigin = EngineView.origin
	Cache.ViewSetup.ViewAngles = EngineView.angles
	Cache.ViewSetup.ViewFOV = EngineView.fov
end

function Cache.ScreenUpdate()
	Cache.ScreenSetup.Width = ScrW()
	Cache.ScreenSetup.Height = ScrH()

	Cache.ScreenSetup.Center.x = Cache.ScreenSetup.Width / 2
	Cache.ScreenSetup.Center.y = Cache.ScreenSetup.Height / 2
end

pkscript.Hooks.Register("PostDrawEffects", Cache.FrameUpdate)
pkscript.Hooks.Register("OnScreenSizeChanged", Cache.ScreenUpdate)
