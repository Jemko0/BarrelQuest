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
  ActorTick = "ActorTick",
  PlayerTick = "PlayerTick",
  ItemTick = "ItemTick",
}

hook.fsig = {
  GlobalTick = {"number"},
  ActorTick = {"Object", "number"},
  PlayerTick = {"BarrelCharacter_C", "number"},
  ItemTick = {"BarrelItem_C", "number"},
}

_G.hook = hook