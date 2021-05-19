--[[
    Attempts to find an associated Remote object from a method type and a topic
    string.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Constants = require(script.Parent.Parent.Constants)

local function findRemote(method: string, topic: string)
	local container = ReplicatedStorage:FindFirstChild(Constants.INTERNAL_REMOTE_CONTAINER_NAME)

	if not container then
		return
	end

	local kind

	if method == "fire" then
		kind = "RemoteEvent"
	elseif method == "invoke" then
		kind = "RemoteFunction"
	end

	local remote

	for _, remoteCandidate in pairs(container:GetChildren()) do
		if remoteCandidate.ClassName == kind and remoteCandidate.Name == topic then
			remote = remoteCandidate
		end
	end

	return remote
end

return findRemote
