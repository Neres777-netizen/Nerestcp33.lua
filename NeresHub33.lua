--[[ 
    ╔═════════════════════════════════════════════════════════════╗
    ║                 MASTER HUB - EXIT LAG MOBILE                ║
    ╠═════════════════════════════════════════════════════════════╣
    ║ Fundo: Preto | Estilo: Sofisticado                          ║
    ║ Som: Click de Teclado ASMR                                  ║
    ╚═════════════════════════════════════════════════════════════╝
]]

if not game:IsLoaded() then game.Loaded:Wait() end

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- Criação da GUI Principal
local gui = Instance.new("ScreenGui")
gui.Name = "MasterExitLagHub"
pcall(function() gui.Parent = CoreGui end)

-- ==================== SISTEMA DE ARRASTE ====================
local function drag(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ==================== SISTEMA DE SOM (ASMR TECLADO) ====================
local function playASMRClick()
    task.spawn(function()
        local clickSound = Instance.new("Sound")
        clickSound.SoundId = "rbxassetid://5854737227" 
        clickSound.Volume = 2
        clickSound.Parent = game:GetService("SoundService")
        clickSound:Play()
        task.wait(1.5)
        clickSound:Destroy()
    end)
end

-- ==================== BOTÃO DE ABRIR E FECHAR ====================
local ToggleBtn = Instance.new("TextButton", gui)
ToggleBtn.Size = UDim2.new(0, 160, 0, 40)
ToggleBtn.Position = UDim2.new(0, 20, 0, 20)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.Text = "exit lag mobile"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamMedium 
ToggleBtn.TextSize = 16
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)
local strokeToggle = Instance.new("UIStroke", ToggleBtn)
strokeToggle.Color = Color3.fromRGB(100, 100, 100)
strokeToggle.Thickness = 1
drag(ToggleBtn)

-- ==================== PAINEL PRINCIPAL ====================
local MainPanel = Instance.new("Frame", gui)
MainPanel.Size = UDim2.new(0, 350, 0, 320)
MainPanel.Position = UDim2.new(0.5, -175, 0.5, -160)
MainPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainPanel.Visible = false
Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0, 10)
local strokeMain = Instance.new("UIStroke", MainPanel)
strokeMain.Color = Color3.fromRGB(200, 200, 200)
strokeMain.Thickness = 2
drag(MainPanel)

local Title = Instance.new("TextLabel", MainPanel)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "MENU DE FUNÇÕES"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Layout das funções
local ListLayout = Instance.new("UIListLayout", MainPanel)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 10)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

-- Espaçador invisível
local Spacer = Instance.new("Frame", MainPanel)
Spacer.Size = UDim2.new(1, 0, 0, 30)
Spacer.BackgroundTransparency = 1

-- Toggle de abrir/fechar painel
ToggleBtn.MouseButton1Click:Connect(function()
    playASMRClick()
    MainPanel.Visible = not MainPanel.Visible
end)

-- ==================== CRIADOR DE BOTÕES ====================
local function createFunctionButton(text, parent, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(50, 50, 50)
    
    btn.MouseButton1Click:Connect(function()
        playASMRClick()
        callback()
    end)
    return btn
end

-- ==================== INSERÇÃO DOS SCRIPTS COMO FUNÇÕES ====================

-- FUNÇÃO 1: Script 1
createFunctionButton("Desacelerar Bola, é normal o fps ficar em 52.", MainPanel, function()
    task.spawn(function()
        local RunService = game:GetService("RunService")
        local Stats = game:GetService("Stats")

        if setfpscap then
            setfpscap(53)
            print("[ZYCK] Limite de FPS cravado com sucesso em: 57 📈")
        else
            print("[ZYCK] Erro: Seu executor não suporta a função setfpscap.")
        end

        pcall(function()
            settings().Physics.AllowSleep = false
            settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
            Stats.Network.ServerToClientConnection.RouterLagLowerBound = 0
            print("[ZYCK] Input lag de rede minimizado!")
        end)
    end)
end)

-- FUNÇÃO 2: Script 2 (Painel Exit Lag Mobile Secundário)
createFunctionButton("Abrir Sub-Painel Exit Lag", MainPanel, function()
    task.spawn(function()
        if not game:IsLoaded() then game.Loaded:Wait() end
        local UIS = game:GetService("UserInputService")
        local RS = game:GetService("RunService")
        local Lighting = game:GetService("Lighting")
        local Players = game:GetService("Players")
        local HttpService = game:GetService("HttpService")
        local CoreGui2 = game:GetService("CoreGui")

        local player = Players.LocalPlayer
        local opt, white, anti, esferica = false, false, false, false
        local THEME_BLACK = Color3.fromRGB(0, 0, 0)
        local THEME_RED = Color3.fromRGB(255, 0, 0)
        local FONT_STYLE = Enum.Font.FredokaOne

        local function drag2(obj)
            local dragging, dragInput, dragStart, startPos
            obj.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true; dragStart = input.Position; startPos = obj.Position
                    input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
                end
            end)
            obj.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
            end)
            UIS.InputChanged:Connect(function(input)
                if input == dragInput and dragging then
                    local delta = input.Position - dragStart
                    obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)
        end

        local function showNotification(titulo, mensagem)
            task.spawn(function()
                local Notif = Instance.new("Frame")
                Notif.Size = UDim2.new(0, 300, 0, 75)
                Notif.Position = UDim2.new(0.5, -150, 0, -100)
                Notif.BackgroundColor3 = THEME_BLACK
                Notif.Parent = player:WaitForChild("PlayerGui")
                Instance.new("UICorner", Notif).CornerRadius = UDim.new(0, 12)
                local s = Instance.new("UIStroke", Notif)
                s.Color = THEME_RED
                s.Thickness = 2
                
                local t = Instance.new("TextLabel", Notif); t.Size = UDim2.new(1, 0, 0.4, 0); t.Text = titulo; t.TextColor3 = THEME_RED; t.Font = FONT_STYLE; t.BackgroundTransparency = 1; t.TextScaled = true
                local m = Instance.new("TextLabel", Notif); m.Size = UDim2.new(1, -20, 0.5, 0); m.Position = UDim2.new(0, 10, 0.4, 0); m.Text = mensagem; m.TextColor3 = Color3.new(1, 1, 1); m.Font = FONT_STYLE; m.BackgroundTransparency = 1; m.TextScaled = true

                Notif:TweenPosition(UDim2.new(0.5, -150, 0, 60), "Out", "Back", 0.5, true)
                task.wait(3)
                Notif:TweenPosition(UDim2.new(0.5, -150, 0, -120), "In", "Quart", 0.5, true)
                task.wait(0.6); Notif:Destroy()
            end)
        end

        local function applyWhiteBall(p)
            p.Color = Color3.new(1,1,1); p.Material = Enum.Material.SmoothPlastic; p.CastShadow = false
            local m = p:FindFirstChildOfClass("SpecialMesh")
            if m then m.TextureId = "" end
        end

        local function applyEsfericaPro(v)
            v.Shape = Enum.PartType.Ball; v.Material = Enum.Material.SmoothPlastic; v.Color = Color3.new(1, 1, 1)
            for _, child in ipairs(v:GetChildren()) do
                if child:IsA("SpecialMesh") or child:IsA("MeshPart") or child:IsA("Decal") or child:IsA("Texture") then child:Destroy() end
            end
        end

        local gui2 = Instance.new("ScreenGui"); gui2.Name = "exitlag_prime_sub"
        pcall(function() gui2.Parent = CoreGui2 end)

        local Main = Instance.new("Frame", gui2)
        Main.Size = UDim2.new(0, 540, 0, 300); Main.Position = UDim2.new(0.5, -270, 0.5, -150); Main.BackgroundColor3 = THEME_BLACK
        Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
        local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = THEME_RED; MainStroke.Thickness = 3
        drag2(Main)

        local TabBar = Instance.new("Frame", Main); TabBar.Size = UDim2.new(1, 0, 0, 50); TabBar.BackgroundTransparency = 1
        local Aba1 = Instance.new("TextButton", TabBar); Aba1.Size = UDim2.new(0.5, 0, 1, 0); Aba1.Text = "PRINCIPAIS"; Aba1.Font = FONT_STYLE; Aba1.TextColor3 = THEME_RED; Aba1.BackgroundTransparency = 1; Aba1.TextSize = 18
        local Aba2 = Instance.new("TextButton", TabBar); Aba2.Size = UDim2.new(0.5, 0, 1, 0); Aba2.Position = UDim2.new(0.5, 0, 0, 0); Aba2.Text = "otm"; Aba2.Font = FONT_STYLE; Aba2.TextColor3 = Color3.new(1, 1, 1); Aba2.BackgroundTransparency = 1; Aba2.TextSize = 18

        local Page1 = Instance.new("ScrollingFrame", Main); Page1.Size = UDim2.new(1, -20, 1, -70); Page1.Position = UDim2.new(0, 10, 0, 60); Page1.BackgroundTransparency = 1; Page1.ScrollBarThickness = 0
        local Page2 = Instance.new("ScrollingFrame", Main); Page2.Size = UDim2.new(1, -20, 1, -70); Page2.Position = UDim2.new(0, 10, 0, 60); Page2.BackgroundTransparency = 1; Page2.Visible = false; Page2.ScrollBarThickness = 0

        Aba1.MouseButton1Click:Connect(function() Page1.Visible = true; Page2.Visible = false; Aba1.TextColor3 = THEME_RED; Aba2.TextColor3 = Color3.new(1, 1, 1) end)
        Aba2.MouseButton1Click:Connect(function() Page2.Visible = true; Page1.Visible = false; Aba2.TextColor3 = THEME_RED; Aba1.TextColor3 = Color3.new(1, 1, 1) end)

        local function createToggle(txt, pos, parent, callback)
            local state = false
            local b = Instance.new("TextButton", parent); b.Size = UDim2.new(0.48, 0, 0, 45); b.Position = pos; b.Text = txt .. ": OFF"; b.Font = FONT_STYLE; b.BackgroundColor3 = THEME_RED; b.TextColor3 = Color3.new(0, 0, 0); b.TextSize = 14
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
            b.MouseButton1Click:Connect(function() state = not state; b.Text = txt .. (state and ": ON" or ": OFF"); b.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or THEME_RED; callback(state) end)
            return b
        end

        createToggle("otm", UDim2.new(0, 0, 0, 5), Page1, function(v) opt = v; if opt then for _, obj in pairs(game:GetDescendants()) do if obj:IsA("BasePart") then obj.Material = Enum.Material.Plastic end end end end)
        createToggle("antipulo", UDim2.new(0.52, 0, 0, 5), Page1, function(v) anti = v; local hum = player.Character and player.Character:FindFirstChild("Humanoid"); if hum then hum.JumpPower = anti and 0 or 50; hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, not anti) end end)
        createToggle("bola lisa", UDim2.new(0, 0, 0, 60), Page1, function(v) esferica = v; if esferica then for _, ball in ipairs(workspace:GetDescendants()) do if ball:IsA("BasePart") and (ball.Shape == Enum.PartType.Ball or ball.Name:lower():find("ball")) then applyEsfericaPro(ball) end end end end)

        local locBtn = Instance.new("TextButton", Page2); locBtn.Size = UDim2.new(1, 0, 0, 45); locBtn.Text = "local do server"; locBtn.BackgroundColor3 = THEME_RED; locBtn.TextColor3 = Color3.new(0, 0, 0); locBtn.Font = FONT_STYLE
        Instance.new("UICorner", locBtn).CornerRadius = UDim.new(0, 10)
        locBtn.MouseButton1Click:Connect(function()
            locBtn.Text = "localizando..."
            local success, response = pcall(function() return game:HttpGet("http://ip-api.com/json/") end)
            if success then local data = HttpService:JSONDecode(response); local country = data.country or "Unknown"; local flag = (country:find("Brazil") or country:find("Brasil")) and "🇧🇷" or "🌎"; showNotification("SERVIDOR", "País: " .. country .. " " .. flag); locBtn.Text = "PAÍS: " .. country:upper() else showNotification("ERRO", "API Offline") end
            task.wait(2); locBtn.Text = "local do server"
        end)

        createToggle("0 delay", UDim2.new(0, 0, 0, 60), Page2, function(v) settings().Network.IncomingReplicationLag = 0; for _, obj in pairs(workspace:GetDescendants()) do if obj:IsA("BasePart") then obj.CastShadow = false end end end)
        createToggle("melhorar ping", UDim2.new(0.52, 0, 0, 60), Page2, function(v) setfpscap(999); settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled end)
        createToggle("mnh otimizacao", UDim2.new(0, 0, 0, 115), Page2, function(v) if v then for _, item in ipairs(game:GetDescendants()) do if item:IsA("Texture") or item:IsA("Decal") or item:IsA("Cloud") or item:IsA("Atmosphere") then item:Destroy() end end; settings().Rendering.QualityLevel = 1 end end)
        createToggle("bola branca", UDim2.new(0.52, 0, 0, 115), Page2, function(v) white = v; if white then for _, item in ipairs(workspace:GetDescendants()) do if item:IsA("BasePart") and (item.Shape == Enum.PartType.Ball or item.Name:lower():find("ball")) then applyWhiteBall(item) end end end end)

        workspace.DescendantAdded:Connect(function(v) task.wait(0.1); if esferica then applyEsfericaPro(v) end; if white and not esferica then if v:IsA("BasePart") and (v.Shape == Enum.PartType.Ball or v.Name:lower():find("ball")) then applyWhiteBall(v) end end end)

        local OpenBtn2 = Instance.new("TextButton", gui2); OpenBtn2.Size = UDim2.new(0, 120, 0, 45); OpenBtn2.Position = UDim2.new(0, 10, 0.5, 0); OpenBtn2.BackgroundColor3 = THEME_BLACK; OpenBtn2.Text = "EXIT LAG"; OpenBtn2.TextColor3 = THEME_RED; OpenBtn2.Font = FONT_STYLE; OpenBtn2.Visible = false
        Instance.new("UICorner", OpenBtn2).CornerRadius = UDim.new(0, 10); Instance.new("UIStroke", OpenBtn2).Color = THEME_RED; drag2(OpenBtn2)

        createToggle("fechar o painel", UDim2.new(0, 0, 0, 170), Page1, function() Main.Visible = false; OpenBtn2.Visible = true end)
        OpenBtn2.MouseButton1Click:Connect(function() Main.Visible = true; OpenBtn2.Visible = false end)
        showNotification("quem usar isso e viado, so eu(zyck) e lecrec pode usar")
    end)
end)

-- FUNÇÃO 3: Script 3
createFunctionButton("Otimização Anti Lag + Ping", MainPanel, function()
    task.spawn(function()
        local Players = game:GetService("Players")
        local Lighting = game:GetService("Lighting")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local localPlayer = Players.LocalPlayer

        Lighting.GlobalShadows = false
        Lighting.FogEnd = 999999
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.EnvironmentSpecularScale = 0
        Lighting.EnvironmentDiffuseScale = 0

        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.CastShadow = false
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = false
            end
        end

        settings().Rendering.QualityLevel = 1
        settings().Network.IncomingReplicationLag = -0.05
        UserInputService.MouseDeltaSensitivity = 1
        RunService:Set3dRenderingEnabled(true)

        local mt = getrawmetatable(game)
        if mt and not isreadonly(mt) then
            local old = mt.__namecall
            setreadonly(mt, false)
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                if method == "FireServer" or method == "InvokeServer" then
                    task.wait(0.001)
                end
                return old(self, ...)
            end)
            setreadonly(mt, true)
        end
        print("✅ Otimização carregada! MS e Input Lag reduzidos.")
    end)
end)

-- FUNÇÃO 4: Script 4
createFunctionButton("Anti Bola Atravessar (Leve)", MainPanel, function()
    task.spawn(function()
        local RunService = game:GetService("RunService")
        local workspace = game:GetService("Workspace")
        local protectedBalls = {}

        local function protectBall(part)
            if protectedBalls[part] then return end
            protectedBalls[part] = true

            RunService.Heartbeat:Connect(function()
                if part and part.Parent then
                    part.CanCollide = true
                    local vel = part.Velocity
                    if vel.Magnitude > 35 then
                        part.Velocity = vel * 0.75
                    end
                else
                    protectedBalls[part] = nil
                end
            end)
        end

        spawn(function()
            while true do
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj.Name == "SoccerBall" or obj.Name:lower():find("ball") or obj.Name:lower():find("football") then
                        local part = obj:FindFirstChildWhichIsA("MeshPart") or obj:FindFirstChildWhichIsA("Part") or obj
                        if part then protectBall(part) end
                    end
                end
                task.wait(2)
            end
        end)
        print("🛡️ Anti Bola Leve ativado! (FPS otimizado)")
    end)
end)

-- ==================== NOVOS BOTÕES ADICIONADOS ====================

createFunctionButton("Tira Analógico 🕹", MainPanel, function()
    task.spawn(function()
        loadstring(game:HttpGet("https://pastefy.app/AJhzcN5G/raw"))()
    end)
end)

createFunctionButton("Otimização🚀", MainPanel, function()
    task.spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Davzxxfixroblox/DavzxHubFixLag/refs/heads/main/FixLagHub"))()
    end)
end)

createFunctionButton("Mega Otimização Brookhaven 🏠", MainPanel, function()
    task.spawn(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/GzrqQWkx"))()
    end)
end)

createFunctionButton("Atravessar Theus 👻", MainPanel, function()
loadstring(game:HttpGet("https://pastefy.app/7e1VxPgW/raw"))()
    end)
end)

createFunctionButton("Anti Pulo + Atravessar + Empurrar ⚽️", MainPanel, function()
    task.spawn(function()
        loadstring(game:HttpGet("https://pastefy.app/sIhEJFAz/raw"))()
    end)
end)

createFunctionButton("Ghost + Reach👻", MainPanel, function()
    task.spawn(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/1if0pn7x"))()
    end)
end)

createFunctionButton("Theus Reach V2 🦿", MainPanel, function()
    task.spawn(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/pm4pyxm4"))()
    end)
end)

createFunctionButton("Reach Forte Do Morales🤣", MainPanel, function()
    task.spawn(function()
        loadstring(game:HttpGet("https://pastefy.app/ckJb1cXM/raw"))()
    end)
end)

-- ==================== OBSERVAÇÃO ABAIXO DA FUNÇÃO 4 ====================
local WarningLabel = Instance.new("TextLabel", MainPanel)
WarningLabel.Size = UDim2.new(0.9, 0, 0, 25)
WarningLabel.BackgroundTransparency = 1
WarningLabel.Text = "⚠️ Observação: Tem que clicar para ativar 7 vezes o ultimo script."
WarningLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
WarningLabel.Font = Enum.Font.GothamSemibold
WarningLabel.TextSize = 12
