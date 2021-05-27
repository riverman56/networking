local RunService = game:GetService("RunService")

local Promise = require(script.Parent.Promise)
local findRemote = require(script.Parent.Utility.findRemote)

local function request(options: table)
    assert(RunService:IsClient(), "Requests may only be served from the client.")

    local promise = Promise.new(function(resolve)
        assert(options.topic, "You must provide a topic.")
        assert(options.method, "You must provide a method.")
        assert(typeof(options.topic) == "string", "Topic must be a string.")
        assert(typeof(options.method) == "string", "Method must be a string.")
        assert(options.method == "invoke" or options.method == "fire", "You must provide a valid method.")

        local remote = findRemote(options.method, options.topic)

        assert(remote, "A listener does not exist for this topic and method.")
    
        if options.method == "fire" then
            assert(remote.ClassName == "RemoteEvent", string.format("The listener for this topic doesn't support method %s.", options.method))
            
             remote:FireServer(options.body)

             resolve("Networking request successfully sent.")
        elseif options.method == "invoke" then
            assert(remote.ClassName == "RemoteFunction", string.format("The listener for this topic doesn't support method %s.", options.method))

            local result = remote:InvokeServer(options.body)

            local response = {
                success = true,
                body = result,
            }

            resolve(response)
        else
            error(string.format("Method of type %s is not supported", options.method))
        end
    end)

    return promise
end

return request