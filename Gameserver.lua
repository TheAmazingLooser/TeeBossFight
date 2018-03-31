-- Chat related things
local CID = -1

local function Answer(txt)
    Srv.Game:SendChatTarget(CID,txt)
end

local function HandleCommand(cmd,prm)
    cmd = cmd:lower()
    if cmd == "login" then
        if Srv.Game:GetPlayer(CID):GetSelf().IsLoggedIn then
            Answer("You are already logged in as '"..Srv.Game:GetPlayer(CID):GetSelf().LoggedUsername.."'!")
            return
        end
        if #prm >= 2 then
            local Usr = prm[1]
            local Pas = prm[2]
            -- No matter how much params we got, use only 1st 2 params!
            local x = LuaAccount.Login(CID,Usr,Pas)
            if x == nil then
                return
            elseif x == false then -- Wrong username, password or not existent!
                Answer("Wrong username, password or this user is not existent!")
            else
                Answer("Successfully logged in!\nWelcome back '"..Usr.."'!")
                Srv.Game:GetPlayer(CID):GetSelf().IsLoggedIn = true
                Srv.Game:GetPlayer(CID):GetSelf().LoggedUsername = Usr
            end
        else
            Answer("Too less info given! Be sure you wrote: /login USER PASS")
        end
    else

    end
end

function Gameserver.OnChat(Msg, ClientID, Team)
    CID = ClientID
    local TrimmedString = Msg:gsub(" ","")
    local FirstChar = TrimmedString:sub(1,1)
    local SecretCommand = TrimmedString:sub(1,2)
    if FirstChar == "/" then -- Handle Command
        local Command = Msg:sub(1,Msg:find(" "))
        local Paramter = {}
        for l in Msg:gmatch("%S+") do
            if l ~= Command:gsub(" ","") then
                table.insert(Paramter,l)
            end
        end
        Command = Command:gsub("/","")
        Command = Command:gsub(" ","")
        HandleCommand(Command,Paramter)
        return false
    elseif SecretCommand == "#~" then -- Bot controll if everything went wrong!
        -- Empty!
        return false
    end
    return true
end

