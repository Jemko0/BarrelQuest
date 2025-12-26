local hook = {}

hook.Add = function(eventName, identifier, func)
  __hookAdd(eventName, identifier, func)
end

hook.Remove = function(eventName, identifier)
  __hookRemove(eventName, identifier)
end

hook.Call = function(eventName, ...)
  return __hookCall(eventName, ...)
end

hook.Names = {
  GlobalTick = "GlobalTick",
  PlayerTick = "PlayerTick",
  ItemTick = "ItemTick",
  ItemPickUp = "ItemPickUp",
  LuaActorSpawned = "LuaActorSpawned",
  ServerSpawnPlayer = "ServerSpawnPlayer",
  ItemServerUse = "ItemServerUse",
  ItemClientUse = "ItemClientUse"
}

hook.fsig = {
  GlobalTick = {"number"},
  ActorTick = {"Object", "number"},
  PlayerTick = {"BarrelCharacter_C", "number"},
  ItemTick = {"BarrelItem_C", "number"},
  ItemPickUp = {"BarrelItem_C", "ContainerComponentNew_C"},
  ItemServerUse = {"BarrelItem_C", "Character"},
  ItemClientUse = {"BarrelItem_C", "Character"},
  LuaActorSpawned = {"Class"},
  ServerSpawnPlayer = {"BarrelPlayerController_C", "string"}
}

_G.hook = hook