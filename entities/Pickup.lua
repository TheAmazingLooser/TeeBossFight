Pickup.PickupPlayers = {}
Pickup.Rarity = 0

print("Hallo, diese Clas wurde reinited!")

function Pickup.OnCreate()
    local rnd = math.random(1,100)
    self = this:GetSelf()
    if rnd <= 75 then
        self.Rarity = 1 -- Normal
    elseif rnd <= 80 then
        self.Rarity = 2 -- Rare
    elseif rnd <= 90 then
        self.Rarity = 3 -- Epic
    elseif rnd <= 97 then
        self.Rarity = 4 -- Mythical
    elseif rnd <= 99 then
        self.Rarity = 5 -- Legendary
    else
        self.Rarity = 6 -- Godlike
    end
    print("Cancerly Cancer Cancer",self.Rarity,self.__dbgId,this.Type,this.Subtype)
end

function Pickup.OnPickedUp(Chr)
    local function CanPickedUp(i)
        for _,v in pairs(self.PickupPlayers) do
            if v == i then
                return true
            end
        end
        return false
    end
    if not CanPickedUp(Chr:GetPlayer():GetCID()) then -- This item is for us!
        local Stats = {}
        local r = self.Rarity
        local Gen = {
            {
                -- Hooklength
                smin = 1,
                smax = 5,
                rmin = 40,
                rmax = 50*r
            },
            {
                -- Hookduration
                smin = 6,
                smax = 10,
                rmin = 1,
                rmax = 1*r
            },
            {
                -- Jumps
                smin = 11,
                smax = 17,
                rmin = 1,
                rmax = 1*r
            },
            {
                -- Jumps
                smin = 11,
                smax = 17,
                rmin = 1,
                rmax = 1*r
            },
            {
                -- HP Up
                smin = 18,
                smax = 30,
                rmin = 5,
                rmax = 10*r
            },
            {
                -- Armor Up
                smin = 31,
                smax = 43,
                rmin = 5,
                rmax = 10*r
            },
            {
                -- Lifesteal
                smin = 44,
                smax = 48,
                rmin = 1,
                rmax = 1
            },
            {
                -- Projectiles
                smin = 49,
                smax = 55,
                rmin = 1,
                rmax = 3*r,
                weap = 2
            },
            {
                -- Bounces
                smin = 56,
                smax = 60,
                rmin = 1,
                rmax = 2*r,
                weap = 4
            },
            {
                -- Damage
                smin = 61,
                smax = 70,
                rmin = 10,
                rmax = 100*r
            },
            {
                -- Ammo
                smin = 71,
                smax = 73,
                rmin = 0,
                rmax = 1
            },
            {
                -- Crit
                smin = 74,
                smax = 79,
                rmin = 50,
                rmax = 100*r
            },
            {
                -- Freeze chance
                smin = 80,
                smax = 83,
                rmin = 3,
                rmax = 5*r
            },
            {
                -- Damage Resist
                smin = 83,
                smax = 86,
                rmin = 5,
                rmax = 10*r
            },
            {
                -- Thorns
                smin = 87,
                smax = 90,
                rmin = 10,
                rmax = 20*r
            },
            {
                -- Attackspeed
                smin = 91,
                smax = 95,
                rmin = ((this.Subtype == 0 or this.Subtype == 1) and 125/r or ((this.Subtype == 2 or this.Subtype == 3) and 500/r or 800/r)),
                rmax = ((this.Subtype == 0 or this.Subtype == 1) and 125 or ((this.Subtype == 2 or this.Subtype == 3) and 500 or 800))
            },
            {
                -- Explosion shots
                smin = 96,
                smax = 100,
                rmin = (this.Subtype == 3 and 1 or 0),
                rmax = 1,
                weap = 3
            },
        }
        math.randomseed(Srv.Server.Tick)
        for i = 0, r do
            local Stat = math.random(1,100)
            for i,v in  pairs(Gen) do -- Check for weapon Specific stuff!
                if v.weap ~= nil and v.weap == this.Subtype then
                    if Stats[i] ~= nil then
                        Stats[i] = Stats[i]+math.random(v.rmin,v.rmax)
                    else
                        Stats[i] = math.random(v.rmin,v.rmax)
                    end
                end
            end
            for i,v in pairs(Gen) do
                if Stat >= v.smin and Stat <= v.smax then
                    if Stats[i] ~= nil then
                        Stats[i] = Stats[i]+math.random(v.rmin,v.rmax)
                    else
                        Stats[i] = math.random(v.rmin,v.rmax)
                    end
                end
            end
        end
        print(r,self.__dbgId,_G[self.__dbgId].Rarity,this:GetSelf().Rarity)
        PlayerAddWeapon(Chr:GetPlayer():GetCID(),this.Subtype,Stats,r)
        --[[
            Hooklength -- 1
            Hookduration -- 2
            Jumps -- 3
            *Jumpheigh
            HP UP -- 4+5
            Armor UP -- 6+7
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
        ]]
        return true
    end
    return true
end
