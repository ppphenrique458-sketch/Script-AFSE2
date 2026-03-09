local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TabFrame = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")
local MinimizeBtn = Instance.new("TextButton")
local Title = Instance.new("TextLabel")

-- Configurações de exibição
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Janela Principal
MainFrame.Name = "MasterHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

Title.Parent = MainFrame
Title.Size = UDim2.new(0.8, 0, 0, 30)
Title.Text = "ULTRA HUB v2"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold

-- Botão Minimizar
MinimizeBtn.Parent = MainFrame
MinimizeBtn.Size = UDim2.new(0.2, 0, 0, 30)
MinimizeBtn.Position = UDim2.new(0.8, 0, 0, 0)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.TextSize = 25

local minimizado = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    MainFrame:TweenSize(minimizado and UDim2.new(0, 200, 0, 30) or UDim2.new(0, 200, 0, 250), "Out", "Quad", 0.3, true)
end)

-- Sistema de Abas
TabFrame.Parent = MainFrame
TabFrame.Position = UDim2.new(0, 0, 0, 30)
TabFrame.Size = UDim2.new(1, 0, 0, 30)
TabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

ContentFrame.Parent = MainFrame
ContentFrame.Position = UDim2.new(0, 0, 0, 65)
ContentFrame.Size = UDim2.new(1, 0, 1, -65)
ContentFrame.BackgroundTransparency = 1

local function LimparContent()
    for _, child in pairs(ContentFrame:GetChildren()) do
        if not child:IsA("UIListLayout") then child:Destroy() end
    end
end

local list = Instance.new("UIListLayout", ContentFrame)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.Padding = UDim.new(0, 5)

-- --- FUNÇÕES DE FARM ---
local function AbaFarm()
    LimparContent()
    local btn = Instance.new("TextButton", ContentFrame)
    local ativo = false
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Text = "AUTO TRAIN: OFF"
    btn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)

    btn.MouseButton1Click:Connect(function()
        ativo = not ativo
        btn.Text = "AUTO TRAIN: " .. (ativo and "ON" or "OFF")
        btn.BackgroundColor3 = ativo and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 0)
    end)

    task.spawn(function()
        local remote = game:GetService("ReplicatedStorage"):WaitForChild("shared"):WaitForChild("Remotes"):WaitForChild("RemoteEvent")
        game:GetService("RunService").Heartbeat:Connect(function()
            if ativo then
                for i = 1, 2000 do 
                    task.spawn(function() pcall(function() remote:FireServer("Train", 1) end) end)
                end
            end
        end)
    end)
end

-- --- FUNÇÕES DE TELEPORTE ---
local function criarTp(nome, cor, coord)
    local btn = Instance.new("TextButton", ContentFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = cor
    btn.Text = nome
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(coord)
        end
    end)
end

local function AbaTeleport()
    LimparContent()
    criarTp("1sx-FORÇA", Color3.fromRGB(200, 50, 50), Vector3.new(2237.54, 194.50, -609.79))
    criarTp("1sx-DURAB.", Color3.fromRGB(50, 200, 50), Vector3.new(3459.98, 204.58, 1483.95))
    criarTp("1sx-CHAKRA", Color3.fromRGB(50, 50, 200), Vector3.new(-1096.55, 616.07, 1487.13))
end

-- Botões das Abas
local btnFarm = Instance.new("TextButton", TabFrame)
btnFarm.Size = UDim2.new(0.5, 0, 1, 0)
btnFarm.Text = "FARM"
btnFarm.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
btnFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
btnFarm.MouseButton1Click:Connect(AbaFarm)

local btnTp = Instance.new("TextButton", TabFrame)
btnTp.Size = UDim2.new(0.5, 0, 1, 0)
btnTp.Position = UDim2.new(0.5, 0, 0, 0)
btnTp.Text = "TELEPORT"
btnTp.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
btnTp.TextColor3 = Color3.fromRGB(255, 255, 255)
btnTp.MouseButton1Click:Connect(AbaTeleport)

-- Iniciar na aba Farm
AbaFarm()
