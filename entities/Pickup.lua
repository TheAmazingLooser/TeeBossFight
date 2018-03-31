Pickup.PickupPlayers = {}
Pickup.Rarity = 0

function Pickup.OnCreate()
    local rnd = math.random(1,100)
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
    table.insert(Pickups,this)
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
    if CanPickedUp(Chr:GetPlayer():GetCID()) then -- This item is for us!
        -- Handle Pickup for players :)
    end
end
