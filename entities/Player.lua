Player.IsBot = false
Player.IsConnected = false
Player.IsLoggedIn = false
Player.LoggedUsername = ""
Player.Data = {
	Weapons = {},
	Inventory = {},
	HP = 10,
	Armor = 10,
}

function Player.Player() -- Player Created!
	if this:GetCID() == 15 then
		self.IsBot = true
		self.IsConnected = true
	else
		self.IsBot = false
		self.IsConnected = false
        self.IsLoggedIn = false
        self.LoggedUsername = ""
		Srv.Server:SetClientAccessLevel(this:GetCID(),PlayerAuthLevel,true)
		print(this:GetCID())
	end
end

function Player.OnDisconnect(Reason)
	print(Srv.Server:GetClientName(this:GetCID()) .." disconnected with reason " .. Reason)
	SaveData(this:GetCID())
end

local function ConnectPlayer(this)
	Srv.Game:SendChatTarget(this:GetCID(),"Welcome to Tee Boss Fight!")
	Srv.Game:SendChatTarget(this:GetCID(),"Use /login or /register to access to your account!")
	self.IsConnected = true
end

function Player.Tick()
	this:Tick()
	if not self.IsConnected then
		ConnectPlayer(this)
	end
end

function LoadData(CID)
	if Srv.Game:GetPlayer(CID):GetSelf().IsLoggedIn == false then return false end
	if LuaAccount.GetAccountFile(CID)~= nil then
		dofile(Srv.Storage:GetFullPath(LuaAccount.GetAccountFile(CID)))
		if data ~= nil then
			Srv.Game:GetPlayer(CID):GetSelf().Data = data
			return true
		else
			return false
		end
	else
		return false
	end
end
function SaveData(CID)
	if Srv.Game:GetPlayer(CID):GetSelf().IsLoggedIn == false then return false end
	return LuaAccount.SaveData(Srv.Game:GetPlayer(CID):GetSelf().LoggedUsername,Srv.Game:GetPlayer(CID):GetSelf().Data)
end

function PlayerAddWeapon(CID,Weap,Stats,Rarity)
	AddInventory(Srv.Game:GetPlayer(CID),Weap,Stats,Rarity)
end

function AddInventory(this,weapon,stats,rarity)
	table.insert(this:GetSelf().Data.Inventory,{Weapon = weapon,Stats = stats,Rarity = rarity})
end

--[[
	Movement Speed
	Wendigkeit in der luft
	Hooklength
	Hookduration
	Jumps
	Jumpheigh
	HP UP
	Armor UP
	Lifesteal
	Projectiles (always 2 or more on shotguns)
	Bounces
	Damage
	Ammo (Endless or Regen)
	Crit
	Freeze Chance
	Damage resist
	Thorns (in percent)
	Attackspeed
	Explosion shots
	Heal
	Spreading (only with more than 1 projectile)
]]