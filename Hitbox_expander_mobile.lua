-- 🔴 Hitbox Expander com personalização via botão
-- ✅ Compatível com Delta (mobile) e jogo "PVP DE DIVISÕES"

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Criação da GUI
local screenGui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.1, 0)
button.Text = "Tamanho da Hitbox"
button.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextScaled = true
button.BorderSizePixel = 0

-- InputBox para digitar o valor
local inputBox = Instance.new("TextBox", screenGui)
inputBox.Size = UDim2.new(0, 150, 0, 40)
inputBox.Position = UDim2.new(0.5, -75, 0.2, 0)
inputBox.PlaceholderText = "Tamanho (ex: 10)"
inputBox.Visible = false
inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
inputBox.TextColor3 = Color3.fromRGB(0, 0, 0)
inputBox.TextScaled = true
inputBox.BorderSizePixel = 2

-- Função que aplica o tamanho
local function aplicarTamanho(valor)
    local tamanho = tonumber(valor)
    if not tamanho then return end
    local size = Vector3.new(tamanho, tamanho, tamanho)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local part = player.Character.HumanoidRootPart
            part.Size = size
            part.Transparency = 0.7
            part.BrickColor = BrickColor.new("Bright red")
            part.Material = Enum.Material.ForceField
            part.CanCollide = false
        end
    end
end

-- Ações dos botões
button.MouseButton1Click:Connect(function()
    inputBox.Visible = not inputBox.Visible
end)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        aplicarTamanho(inputBox.Text)
        inputBox.Visible = false
    end
end)

-- Atualiza automático se alguém nascer depois
while true do
    wait(2)
    if inputBox.Text ~= "" then
        aplicarTamanho(inputBox.Text)
    end
end
