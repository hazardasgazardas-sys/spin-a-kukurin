local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local state = {
    Forward = false,
    Backward = false,
    Speed = 0,
    MaxSpeed = 40,
    TargetSpeed = 0,
}

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.W then
        state.Forward = true
    elseif input.KeyCode == Enum.KeyCode.S then
        state.Backward = true
    end
end)

UserInputService.InputEnded:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.W then
        state.Forward = false
    elseif input.KeyCode == Enum.KeyCode.S then
        state.Backward = false
    end
end)

RunService.RenderStepped:Connect(function(dt)
    if state.Forward then
        state.TargetSpeed = state.MaxSpeed
    elseif state.Backward then
        state.TargetSpeed = -state.MaxSpeed * 0.5
    else
        state.TargetSpeed = 0
    end

    state.Speed = state.Speed + (state.TargetSpeed - state.Speed) * math.min(1, dt * 2.5)

    local forward = root.CFrame.LookVector
    root.AssemblyLinearVelocity = Vector3.new(
        forward.X * state.Speed * 1.2,
        root.AssemblyLinearVelocity.Y,
        forward.Z * state.Speed * 1.2
    )
end)
