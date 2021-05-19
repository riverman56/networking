local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Constants = require(script.Parent.Parent.Constants)

local function createContainer()
    local container = Instance.new("Folder")
    container.Name = Constants.INTERNAL_REMOTE_CONTAINER_NAME
    container.Parent = ReplicatedStorage

    return container
end

return createContainer