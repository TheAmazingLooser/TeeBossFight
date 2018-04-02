-- set all the info
vec2f = vec2
vec3f = vec3
vec4f = vec4

PlayerAuthLevel = 0

LuaCrypt = require("LuaDec")
LuaAccount = require("LuaAccounts")
if not LuaAccount.Login(1,"Flyme","Cool") then
    LuaAccount.Register("Flyme","Cool")
end
local Helps = {
    player = "Display all the information about your player profile!",
    inventory = "Displays you current inventory. The items with a '*' behind the names are equipped items.",
    inv = "Displays you current inventory. The items with a '*' behind their names are equipped items.",
}

math.randomseed(os.time())

Srv.Console:Register("help", "s", "Shows a detailed info about the command.", function(result)
    local Cmd = result:GetString(0):lower()
    local CID = result:GetCID()
    if Cmd ~= nil or Cmd ~= "" or Helps[Cmd] ~= nil then
        Srv.Console:Print("HELP", Helps[Cmd] ,CID)
    end
end)

Srv.Console:Register("player", "", "Fuck yeah! I'm cool.", function(result)
    local CID = result:GetCID()
    Srv.Console:Print("HELP", "You are too cool for this game :3" ,CID)
end)

Srv.Console:Register("inv", "", "Look at my stuff!", function(result)
    local CID = result:GetCID()
    Srv.Console:Print("INV", "Itz EmptY ;c" ,CID)
end)
Srv.Console:Register("inventory", "", "Look at my stuff!", function(result)
    local CID = result:GetCID()
    Srv.Console:Print("INV", "Itz EmptY ;c" ,CID)
end)

Srv.Console:SetCommandAccessLevel("help",PlayerAuthLevel)
Srv.Console:SetCommandAccessLevel("player",PlayerAuthLevel)
Srv.Console:SetCommandAccessLevel("inv",PlayerAuthLevel)
Srv.Console:SetCommandAccessLevel("inventory",PlayerAuthLevel)
