-- Garden Horizons Hub
-- Terbang + Auto Beli Seeds & Gear

local player = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.DisplayOrder = 9999
sg.Parent = gethui and gethui() or player.PlayerGui

local WHITE = Color3.fromRGB(255,255,255)
local GREEN = Color3.fromRGB(40,160,60)
local RED   = Color3.fromRGB(200,50,50)
local BLUE  = Color3.fromRGB(40,120,200)
local DARK  = Color3.fromRGB(14,14,22)
local CARD  = Color3.fromRGB(24,24,36)
local GRAY  = Color3.fromRGB(120,120,140)
local GOLD  = Color3.fromRGB(240,190,50)

local rarityColor = {
    Common    = Color3.fromRGB(160,160,160),
    Uncommon  = Color3.fromRGB(80,200,100),
    Rare      = Color3.fromRGB(80,140,220),
    Epic      = Color3.fromRGB(160,80,220),
    Legendary = Color3.fromRGB(240,180,40),
}

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = p
end

-- ================================
-- MAIN FRAME
-- ================================
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 360, 0, 300)
Frame.Position = UDim2.new(0.5, -180, 0.5, -150)
Frame.BackgroundColor3 = DARK
Frame.BorderSizePixel = 0
Frame.Visible = true
Frame.ZIndex = 100
Frame.ClipsDescendants = true
Frame.Parent = sg
corner(Frame, 14)
local fStroke = Instance.new("UIStroke")
fStroke.Color = Color3.fromRGB(40,80,45)
fStroke.Thickness = 1.5
fStroke.Parent = Frame

-- TITLE BAR
local TBar = Instance.new("Frame")
TBar.Size = UDim2.new(1, 0, 0, 40)
TBar.BackgroundColor3 = Color3.fromRGB(18,36,20)
TBar.BorderSizePixel = 0
TBar.ZIndex = 101
TBar.Parent = Frame
corner(TBar, 14)

local TFix = Instance.new("Frame")
TFix.Size = UDim2.new(1, 0, 0, 10)
TFix.Position = UDim2.new(0, 0, 1, -10)
TFix.BackgroundColor3 = Color3.fromRGB(18,36,20)
TFix.BorderSizePixel = 0
TFix.ZIndex = 101
TFix.Parent = TBar

local TLbl = Instance.new("TextLabel")
TLbl.Size = UDim2.new(1, -50, 1, 0)
TLbl.Position = UDim2.new(0, 12, 0, 0)
TLbl.BackgroundTransparency = 1
TLbl.Text = "🌱 GH Hub  •  ☰ geser"
TLbl.TextColor3 = GREEN
TLbl.Font = Enum.Font.GothamBold
TLbl.TextSize = 14
TLbl.TextXAlignment = Enum.TextXAlignment.Left
TLbl.ZIndex = 102
TLbl.Parent = TBar

-- TOMBOL X (parent sg biar tidak terpotong)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 34, 0, 34)
CloseBtn.BackgroundColor3 = RED
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = WHITE
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.ZIndex = 99999
CloseBtn.Parent = sg
corner(CloseBtn, 8)

local function updateClose()
    local fp = Frame.AbsolutePosition
    local fs = Frame.AbsoluteSize
    CloseBtn.Position = UDim2.new(0, fp.X + fs.X - 38, 0, fp.Y + 4)
end
Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateClose)
Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateClose)
updateClose()

-- DRAG FRAME
local drag, dragStart, startPos = false, nil, nil
TBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true; dragStart = i.Position; startPos = Frame.Position
    end
end)
TBar.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = false
    end
end)
uis.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMove) then
        local d = i.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
        updateClose()
    end
end)

-- ================================
-- SECTION TERBANG (atas)
-- ================================
local FlySection = Instance.new("Frame")
FlySection.Size = UDim2.new(1, -12, 0, 94)
FlySection.Position = UDim2.new(0, 6, 0, 46)
FlySection.BackgroundColor3 = CARD
FlySection.BorderSizePixel = 0
FlySection.ZIndex = 101
FlySection.Parent = Frame
corner(FlySection, 10)

local FlyTitle = Instance.new("TextLabel")
FlyTitle.Size = UDim2.new(1, -12, 0, 22)
FlyTitle.Position = UDim2.new(0, 8, 0, 4)
FlyTitle.BackgroundTransparency = 1
FlyTitle.Text = "✈️ Terbang"
FlyTitle.TextColor3 = WHITE
FlyTitle.Font = Enum.Font.GothamBold
FlyTitle.TextSize = 13
FlyTitle.TextXAlignment = Enum.TextXAlignment.Left
FlyTitle.ZIndex = 102
FlyTitle.Parent = FlySection

local FlyStatLbl = Instance.new("TextLabel")
FlyStatLbl.Size = UDim2.new(0, 80, 0, 20)
FlyStatLbl.Position = UDim2.new(1, -88, 0, 4)
FlyStatLbl.BackgroundTransparency = 1
FlyStatLbl.Text = "❌ OFF"
FlyStatLbl.TextColor3 = RED
FlyStatLbl.Font = Enum.Font.GothamBold
FlyStatLbl.TextSize = 12
FlyStatLbl.TextXAlignment = Enum.TextXAlignment.Right
FlyStatLbl.ZIndex = 102
FlyStatLbl.Parent = FlySection

-- Row tombol: Naik | Toggle | Turun
local NaikBtn = Instance.new("TextButton")
NaikBtn.Size = UDim2.new(0, 90, 0, 34)
NaikBtn.Position = UDim2.new(0, 6, 0, 30)
NaikBtn.BackgroundColor3 = Color3.fromRGB(30,120,50)
NaikBtn.Text = "⬆️  Naik"
NaikBtn.TextColor3 = WHITE
NaikBtn.Font = Enum.Font.GothamBold
NaikBtn.TextSize = 13
NaikBtn.ZIndex = 102
NaikBtn.Parent = FlySection
corner(NaikBtn, 8)

local FlyTogBtn = Instance.new("TextButton")
FlyTogBtn.Size = UDim2.new(1, -200, 0, 34)
FlyTogBtn.Position = UDim2.new(0, 102, 0, 30)
FlyTogBtn.BackgroundColor3 = GREEN
FlyTogBtn.Text = "✈️ Aktifkan"
FlyTogBtn.TextColor3 = WHITE
FlyTogBtn.Font = Enum.Font.GothamBold
FlyTogBtn.TextSize = 13
FlyTogBtn.ZIndex = 102
FlyTogBtn.Parent = FlySection
corner(FlyTogBtn, 8)

local TurunBtn = Instance.new("TextButton")
TurunBtn.Size = UDim2.new(0, 90, 0, 34)
TurunBtn.Position = UDim2.new(1, -96, 0, 30)
TurunBtn.BackgroundColor3 = Color3.fromRGB(160,40,40)
TurunBtn.Text = "⬇️  Turun"
TurunBtn.TextColor3 = WHITE
TurunBtn.Font = Enum.Font.GothamBold
TurunBtn.TextSize = 13
TurunBtn.ZIndex = 102
TurunBtn.Parent = FlySection
corner(TurunBtn, 8)

-- Kecepatan row
local SpeedLbl = Instance.new("TextLabel")
SpeedLbl.Size = UDim2.new(0, 100, 0, 22)
SpeedLbl.Position = UDim2.new(0, 8, 0, 68)
SpeedLbl.BackgroundTransparency = 1
SpeedLbl.Text = "⚡ Speed: 60"
SpeedLbl.TextColor3 = GOLD
SpeedLbl.Font = Enum.Font.GothamBold
SpeedLbl.TextSize = 12
SpeedLbl.TextXAlignment = Enum.TextXAlignment.Left
SpeedLbl.ZIndex = 102
SpeedLbl.Parent = FlySection

local SDecBtn = Instance.new("TextButton")
SDecBtn.Size = UDim2.new(0, 60, 0, 22)
SDecBtn.Position = UDim2.new(0, 110, 0, 68)
SDecBtn.BackgroundColor3 = Color3.fromRGB(140,50,20)
SDecBtn.Text = "- 10"
SDecBtn.TextColor3 = WHITE
SDecBtn.Font = Enum.Font.GothamBold
SDecBtn.TextSize = 11
SDecBtn.ZIndex = 102
SDecBtn.Parent = FlySection
corner(SDecBtn, 6)

local SIncBtn = Instance.new("TextButton")
SIncBtn.Size = UDim2.new(0, 60, 0, 22)
SIncBtn.Position = UDim2.new(0, 176, 0, 68)
SIncBtn.BackgroundColor3 = Color3.fromRGB(30,90,160)
SIncBtn.Text = "+ 10"
SIncBtn.TextColor3 = WHITE
SIncBtn.Font = Enum.Font.GothamBold
SIncBtn.TextSize = 11
SIncBtn.ZIndex = 102
SIncBtn.Parent = FlySection
corner(SIncBtn, 6)

-- ================================
-- SECTION AUTO BELI (bawah, scrollable horizontal)
-- ================================
local BuyLabel = Instance.new("TextLabel")
BuyLabel.Size = UDim2.new(1, -80, 0, 22)
BuyLabel.Position = UDim2.new(0, 8, 0, 148)
BuyLabel.BackgroundTransparency = 1
BuyLabel.Text = "🛒 Auto Beli Seeds & Gear"
BuyLabel.TextColor3 = WHITE
BuyLabel.Font = Enum.Font.GothamBold
BuyLabel.TextSize = 13
BuyLabel.TextXAlignment = Enum.TextXAlignment.Left
BuyLabel.ZIndex = 101
BuyLabel.Parent = Frame

local BuyStatLbl = Instance.new("TextLabel")
BuyStatLbl.Size = UDim2.new(0, 70, 0, 22)
BuyStatLbl.Position = UDim2.new(1, -76, 0, 148)
BuyStatLbl.BackgroundTransparency = 1
BuyStatLbl.Text = "❌ OFF"
BuyStatLbl.TextColor3 = RED
BuyStatLbl.Font = Enum.Font.GothamBold
BuyStatLbl.TextSize = 12
BuyStatLbl.TextXAlignment = Enum.TextXAlignment.Right
BuyStatLbl.ZIndex = 101
BuyStatLbl.Parent = Frame

-- Scroll horizontal untuk item cards
local ItemScroll = Instance.new("ScrollingFrame")
ItemScroll.Size = UDim2.new(1, -12, 0, 96)
ItemScroll.Position = UDim2.new(0, 6, 0, 172)
ItemScroll.BackgroundColor3 = CARD
ItemScroll.BorderSizePixel = 0
ItemScroll.ScrollBarThickness = 4
ItemScroll.ScrollBarImageColor3 = GREEN
ItemScroll.ScrollingDirection = Enum.ScrollingDirection.X
ItemScroll.ZIndex = 101
ItemScroll.Parent = Frame
corner(ItemScroll, 10)

local ItemLayout = Instance.new("UIListLayout")
ItemLayout.FillDirection = Enum.FillDirection.Horizontal
ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
ItemLayout.Padding = UDim.new(0, 6)
ItemLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ItemLayout.Parent = ItemScroll

local UIPad = Instance.new("UIPadding")
UIPad.PaddingLeft = UDim.new(0, 6)
UIPad.PaddingRight = UDim.new(0, 6)
UIPad.Parent = ItemScroll

-- Toggle Auto Beli
local BuyTogBtn = Instance.new("TextButton")
BuyTogBtn.Size = UDim2.new(1, -12, 0, 28)
BuyTogBtn.Position = UDim2.new(0, 6, 0, 270)
BuyTogBtn.BackgroundColor3 = BLUE
BuyTogBtn.Text = "🛒 Aktifkan Auto Beli"
BuyTogBtn.TextColor3 = WHITE
BuyTogBtn.Font = Enum.Font.GothamBold
BuyTogBtn.TextSize = 13
BuyTogBtn.ZIndex = 101
BuyTogBtn.Parent = Frame
corner(BuyTogBtn, 8)

-- ================================
-- DATABASE ITEMS
-- ================================
local items = {
    -- SEEDS
    {n="Carrot",      icon="🥕", t="seed", r="Common"},
    {n="Corn",        icon="🌽", t="seed", r="Common"},
    {n="Dandelion",   icon="🌼", t="seed", r="Common"},
    {n="Sunpetal",    icon="🌻", t="seed", r="Common"},
    {n="Onion",       icon="🧅", t="seed", r="Uncommon"},
    {n="Strawberry",  icon="🍓", t="seed", r="Uncommon"},
    {n="Mushroom",    icon="🍄", t="seed", r="Uncommon"},
    {n="Bell Pepper", icon="🫑", t="seed", r="Uncommon"},
    {n="Goldenberry", icon="🫐", t="seed", r="Uncommon"},
    {n="Beetroot",    icon="🟣", t="seed", r="Rare"},
    {n="Tomato",      icon="🍅", t="seed", r="Rare"},
    {n="Apple",       icon="🍎", t="seed", r="Rare"},
    {n="Rose",        icon="🌹", t="seed", r="Rare"},
    {n="Birch",       icon="🌳", t="seed", r="Rare"},
    {n="Amber Pine",  icon="🌲", t="seed", r="Rare"},
    {n="Wheat",       icon="🌾", t="seed", r="Epic"},
    {n="Banana",      icon="🍌", t="seed", r="Epic"},
    {n="Plum",        icon="🍑", t="seed", r="Epic"},
    {n="Potato",      icon="🥔", t="seed", r="Epic"},
    {n="Orange",      icon="🍊", t="seed", r="Epic"},
    {n="Cabbage",     icon="🥬", t="seed", r="Legendary"},
    {n="Cherry",      icon="🍒", t="seed", r="Legendary"},
    {n="Olive",       icon="🫒", t="seed", r="Legendary"},
    {n="Dawnfruit",   icon="🌟", t="seed", r="Legendary"},
    -- GEAR
    {n="Trowel",         icon="🔧", t="gear", r="Common"},
    {n="Shovel",         icon="⛏️", t="gear", r="Common"},
    {n="Watering Can",   icon="💧", t="gear", r="Common"},
    {n="Basic Sprinkler",icon="🚿", t="gear", r="Uncommon"},
    {n="Harvesting Bell",icon="🔔", t="gear", r="Rare"},
    {n="Turbo Sprinkler",icon="💦", t="gear", r="Epic"},
    {n="Favoriting Tool",icon="⭐", t="gear", r="Epic"},
    {n="Super Sprinkler",icon="🌊", t="gear", r="Legendary"},
}

local autoBuyList = {}
local itemRefs = {}

-- Buat card per item
for i, item in ipairs(items) do
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 80, 0, 82)
    card.BackgroundColor3 = Color3.fromRGB(18,20,30)
    card.BorderSizePixel = 0
    card.LayoutOrder = i
    card.ZIndex = 102
    card.Parent = ItemScroll
    corner(card, 8)

    -- Rarity strip atas
    local strip = Instance.new("Frame")
    strip.Size = UDim2.new(1, 0, 0, 4)
    strip.BackgroundColor3 = rarityColor[item.r] or GRAY
    strip.BorderSizePixel = 0
    strip.ZIndex = 103
    strip.Parent = card
    corner(strip, 4)

    local iconL = Instance.new("TextLabel")
    iconL.Size = UDim2.new(1, 0, 0, 28)
    iconL.Position = UDim2.new(0, 0, 0, 6)
    iconL.BackgroundTransparency = 1
    iconL.Text = item.icon
    iconL.TextScaled = true
    iconL.ZIndex = 103
    iconL.Parent = card

    local nameL = Instance.new("TextLabel")
    nameL.Size = UDim2.new(1, -4, 0, 24)
    nameL.Position = UDim2.new(0, 2, 0, 34)
    nameL.BackgroundTransparency = 1
    nameL.Text = item.n
    nameL.TextColor3 = WHITE
    nameL.Font = Enum.Font.GothamBold
    nameL.TextSize = 9
    nameL.TextWrapped = true
    nameL.TextXAlignment = Enum.TextXAlignment.Center
    nameL.ZIndex = 103
    nameL.Parent = card

    local rarL = Instance.new("TextLabel")
    rarL.Size = UDim2.new(1, -4, 0, 14)
    rarL.Position = UDim2.new(0, 2, 0, 56)
    rarL.BackgroundTransparency = 1
    rarL.Text = item.r
    rarL.TextColor3 = rarityColor[item.r] or GRAY
    rarL.Font = Enum.Font.Gotham
    rarL.TextSize = 8
    rarL.TextXAlignment = Enum.TextXAlignment.Center
    rarL.ZIndex = 103
    rarL.Parent = card

    -- Checkbox toggle
    local chk = Instance.new("TextButton")
    chk.Size = UDim2.new(1, -10, 0, 16)
    chk.Position = UDim2.new(0, 5, 1, -20)
    chk.BackgroundColor3 = Color3.fromRGB(35,38,50)
    chk.Text = "OFF"
    chk.TextColor3 = GRAY
    chk.Font = Enum.Font.GothamBold
    chk.TextSize = 9
    chk.ZIndex = 104
    chk.Parent = card
    corner(chk, 5)

    local on = false
    chk.MouseButton1Click:Connect(function()
        on = not on
        autoBuyList[item.n] = on
        if on then
            chk.BackgroundColor3 = GREEN
            chk.TextColor3 = WHITE
            chk.Text = "ON"
            card.BackgroundColor3 = Color3.fromRGB(18,30,20)
            strip.BackgroundColor3 = GREEN
        else
            chk.BackgroundColor3 = Color3.fromRGB(35,38,50)
            chk.TextColor3 = GRAY
            chk.Text = "OFF"
            card.BackgroundColor3 = Color3.fromRGB(18,20,30)
            strip.BackgroundColor3 = rarityColor[item.r] or GRAY
        end
    end)

    table.insert(itemRefs, {card=card, item=item})
end

-- Update canvas size
ItemLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ItemScroll.CanvasSize = UDim2.new(0, ItemLayout.AbsoluteContentSize.X + 12, 0, 0)
end)
ItemScroll.CanvasSize = UDim2.new(0, (#items * 86) + 12, 0, 0)

-- ================================
-- TOMBOL BUKA ⚡
-- ================================
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 56, 0, 56)
openBtn.Position = UDim2.new(0, 16, 0.45, 0)
openBtn.BackgroundColor3 = DARK
openBtn.Text = "🌱"
openBtn.TextScaled = true
openBtn.ZIndex = 9999
openBtn.Visible = false
openBtn.Parent = sg
corner(openBtn, 28)
local obStroke = Instance.new("UIStroke")
obStroke.Color = GREEN
obStroke.Thickness = 2
obStroke.Parent = openBtn

local obDrag, obDragStart, obStartPos = false, nil, nil
openBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        obDrag = true; obDragStart = i.Position; obStartPos = openBtn.Position
    end
end)
openBtn.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        obDrag = false
    end
end)
uis.InputChanged:Connect(function(i)
    if obDrag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMove) then
        local d = i.Position - obDragStart
        openBtn.Position = UDim2.new(obStartPos.X.Scale, obStartPos.X.Offset+d.X, obStartPos.Y.Scale, obStartPos.Y.Offset+d.Y)
    end
end)

-- ================================
-- LOGIKA TERBANG
-- ================================
local flying = false
local flySpeed = 60
local goUp, goDown = false, false
local bv, bg

local function startFly()
    flying = true
    local char = player.Character
    if not char then return end
    local hum  = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
    hum.PlatformStand = true
    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5,1e5,1e5)
    bv.Velocity = Vector3.zero
    bv.Parent = root
    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
    bg.D = 50
    bg.Parent = root
    FlyTogBtn.Text = "🛑 Matikan"
    FlyTogBtn.BackgroundColor3 = RED
    FlyStatLbl.Text = "✅ ON"
    FlyStatLbl.TextColor3 = GREEN
end

local function stopFly()
    flying = false
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = false end
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
    FlyTogBtn.Text = "✈️ Aktifkan"
    FlyTogBtn.BackgroundColor3 = GREEN
    FlyStatLbl.Text = "❌ OFF"
    FlyStatLbl.TextColor3 = RED
end

rs.RenderStepped:Connect(function()
    if not flying then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum  = char:FindFirstChildOfClass("Humanoid")
    if not root or not bv then return end
    local dir = Vector3.zero
    if hum and hum.MoveDirection.Magnitude > 0 then
        dir = Vector3.new(hum.MoveDirection.X,0,hum.MoveDirection.Z)
    end
    if goUp   then dir = dir + Vector3.new(0,1,0) end
    if goDown then dir = dir - Vector3.new(0,1,0) end
    if dir.Magnitude > 0 then dir = dir.Unit end
    bv.Velocity = dir * flySpeed
    bg.CFrame = workspace.CurrentCamera.CFrame
end)

FlyTogBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

NaikBtn.MouseButton1Down:Connect(function() goUp = true end)
NaikBtn.MouseButton1Up:Connect(function()   goUp = false end)
NaikBtn.TouchStarted:Connect(function() goUp = true end)
NaikBtn.TouchEnded:Connect(function()   goUp = false end)

TurunBtn.MouseButton1Down:Connect(function() goDown = true end)
TurunBtn.MouseButton1Up:Connect(function()   goDown = false end)
TurunBtn.TouchStarted:Connect(function() goDown = true end)
TurunBtn.TouchEnded:Connect(function()   goDown = false end)

SDecBtn.MouseButton1Click:Connect(function()
    flySpeed = math.max(10, flySpeed-10)
    SpeedLbl.Text = "⚡ Speed: " .. flySpeed
end)
SIncBtn.MouseButton1Click:Connect(function()
    flySpeed = math.min(300, flySpeed+10)
    SpeedLbl.Text = "⚡ Speed: " .. flySpeed
end)

player.CharacterAdded:Connect(function()
    task.wait(0.5)
    flying = false; bv = nil; bg = nil
    FlyTogBtn.Text = "✈️ Aktifkan"
    FlyTogBtn.BackgroundColor3 = GREEN
    FlyStatLbl.Text = "❌ OFF"
    FlyStatLbl.TextColor3 = RED
end)

-- ================================
-- LOGIKA AUTO BELI
-- ================================
local autoBuying = false

local function tryBuy(itemName)
    local rs2 = game:GetService("ReplicatedStorage")
    for _, obj in ipairs(rs2:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local n = obj.Name:lower()
            if n:find("buy") or n:find("purchase") or n:find("shop") then
                pcall(function()
                    if obj:IsA("RemoteEvent") then
                        obj:FireServer(itemName)
                        obj:FireServer(itemName, 1)
                        obj:FireServer({name=itemName, amount=1})
                    end
                end)
            end
        end
    end
end

BuyTogBtn.MouseButton1Click:Connect(function()
    autoBuying = not autoBuying
    if autoBuying then
        BuyTogBtn.Text = "🛑 Matikan Auto Beli"
        BuyTogBtn.BackgroundColor3 = RED
        BuyStatLbl.Text = "✅ ON"
        BuyStatLbl.TextColor3 = GREEN
        task.spawn(function()
            while autoBuying do
                for name, active in pairs(autoBuyList) do
                    if active then pcall(tryBuy, name) end
                end
                task.wait(2)
            end
        end)
   
