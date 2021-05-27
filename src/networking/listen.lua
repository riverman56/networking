local RunService = game:GetService("RunService")

local createRemote = require(script.Parent.Utility.createRemote)
local findRemote = require(script.Parent.Utility.findRemote)

local function listen(topic: string, methods: table, callback: () -> any)
    assert(RunService:IsServer(), "Listeners may only be created on the server.")

    assert(topic, "You must provide a topic string.")
    assert(methods, "You must provide a methods list.")
    assert(typeof(topic) == "string", "Topic must be a string.")
    assert(typeof(methods) == "table", "Methods must be an array of methods.")
    assert(typeof(callback) == "function", "Callback must be a function.")

    for _, method in pairs(methods) do
        local remote = findRemote(method, topic)
        
        assert(not remote, "A listener already exists for this topic.")

        remote = createRemote(method, topic)
        
        if method == "fire" then
            remote.OnServerEvent:Connect(function(player, body)
                local request = {
                    type = "fire",
                    client = player,
                    body = body,
                }

                local function reply()
                end

                callback(request, reply)
            end)
        elseif method == "invoke" then
            remote.OnServerInvoke = function(player, body)
                local request = {
                    type = "invoke",
                    client = player,
                    body = body,
                }
                local response

                local function reply(data: any)
                    response = data
                end

                callback(request, reply)

                return response
            end
        end
    end
end

return listen