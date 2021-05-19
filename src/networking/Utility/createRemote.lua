--[[
    Constructs the appropriate Remote object according to the method and
    topic.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local findRemote = require(script.Parent.findRemote)
local createContainer = require(script.Parent.createContainer)
local Constants = require(script.Parent.Parent.Constants)

local function createRemote(method: string, topic: string)
    -- REL: better variable name
    local kind
    
    if method == "fire" then
        kind = "RemoteEvent"
    elseif method == "invoke" then
        kind = "RemoteFunction"
    end

    local extistingRemote = findRemote(kind, topic)

    if extistingRemote then
        return extistingRemote
    end

    local container = ReplicatedStorage:FindFirstChild(Constants.INTERNAL_REMOTE_CONTAINER_NAME)

    if not container then
        container = createContainer()
    end

    local remote = Instance.new(kind)
    remote.Name = topic
    remote.Parent = container

    return remote
end

return createRemote