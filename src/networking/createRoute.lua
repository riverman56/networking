local function createRoute(options: table)
    assert(options.path, "You must provide a path name in the options table.")
    assert(options.methods, "You must provide method(s) in the options table.")
    assert(options.callback, "You must provide callback in the options table.")

    return {
        topic = options.path,
        methods = options.methods,
        callback = options.callback,
    }
end

--[[
    createRoute({
        path = "",
        methods = {},
        callback = "fn",
    })
]]

return createRoute