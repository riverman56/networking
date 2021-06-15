local listen = require(script.Parent.listen)

local function registerRoutes(folder: Folder)
    assert(folder, "You must provide a folder to register routes in.")
    assert(folder:IsA("Folder"), "Folder must be a valid Folder instance.")

    local routes = folder:GetChildren()

    for _, route in pairs(routes) do
        if not route:IsA("ModuleScript") then
            continue
        end

        local routeInformation = require(route)
        
        listen(routeInformation.topic, routeInformation.methods, routeInformation.callback)
    end
end

return registerRoutes