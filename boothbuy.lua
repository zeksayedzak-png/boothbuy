-- 🎯 Quick Booth Buyer
-- loadstring(game:HttpGet("رابط_هذا_الكود"))()

local player = game.Players.LocalPlayer
local buyRemote = game:GetService("ReplicatedStorage").GameEvents.TradeEvents.Booths.BuyListing

-- 📋 IDs اللي لقيتها
local foundIDs = {
    "booth_Booths_8494",
    "booth_BlacksmithStand_3592", 
    "booth_GardenCoinShop_2291",
    "booth_PhysicalEggsShop_1102",
    "booth_CosmeticShop_UI_9806",
    "booth_EventShop_UI_3708",
    "booth_GardenCoinShop_UI_4345",
    "booth_Gear_Shop_1175",
    "booth_PetShop_UI_7215",
    "booth_system_main"
}

-- ⚡ دالة الشراء
local function buyBooth(listingId, price)
    price = price or 0
    
    -- Payloads مختلفة
    local payloads = {
        {listingId = listingId, price = price},
        {id = listingId, cost = price, buyerId = player.UserId},
        {boothId = listingId, amount = 1, currency = "Gems", price = price},
        {productId = listingId, price = price, buyer = player.Name}
    }
    
    for i, payload in ipairs(payloads) do
        local success, result = pcall(function()
            return buyRemote:InvokeServer(payload)
        end)
        
        if success then
            return true, "✅ نجح! الطريقة " .. i .. " - " .. tostring(result)
        end
    end
    
    return false, "❌ فشل كل الطرق"
end

-- 📱 واجهة سريعة
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "QuickBuyer"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.95, 0, 0.6, 0)
mainFrame.Position = UDim2.new(0.025, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)

-- العنوان
local title = Instance.new("TextLabel")
title.Text = "⚡ QUICK BOOTH BUYER"
title.Size = UDim2.new(1, 0, 0.1, 0)
title.BackgroundColor3 = Color3.fromRGB(200, 50, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold

-- قائمة IDs
local idsFrame = Instance.new("ScrollingFrame")
idsFrame.Size = UDim2.new(0.9, 0, 0.6, 0)
idsFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
idsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
idsFrame.ScrollBarThickness = 8
idsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local idsLayout = Instance.new("UIListLayout")
idsLayout.Parent = idsFrame

-- النتائج
local resultLabel = Instance.new("TextLabel")
resultLabel.Text = "اختر ID واضغط شراء"
resultLabel.Size = UDim2.new(1, 0, 0.2, 0)
resultLabel.Position = UDim2.new(0, 0, 0.84, 0)
resultLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
resultLabel.TextColor3 = Color3.new(1, 1, 1)
resultLabel.TextWrapped = true

-- إنشاء أزرار لكل ID
for _, id in ipairs(foundIDs) do
    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(1, 0, 0, 50)
    btnFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    
    local idLabel = Instance.new("TextLabel")
    idLabel.Text = id
    idLabel.Size = UDim2.new(0.7, 0, 1, 0)
    idLabel.BackgroundTransparency = 1
    idLabel.TextColor3 = Color3.new(1, 1, 1)
    idLabel.TextXAlignment = Enum.TextXAlignment.Left
    idLabel.PaddingLeft = UDim.new(0, 10)
    
    local buyBtn = Instance.new("TextButton")
    buyBtn.Text = "⚡ شراء"
    buyBtn.Size = UDim2.new(0.25, 0, 0.7, 0)
    buyBtn.Position = UDim2.new(0.73, 0, 0.15, 0)
    buyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    buyBtn.TextColor3 = Color3.new(1, 1, 1)
    
    -- حدث الشراء
    buyBtn.MouseButton1Click:Connect(function()
        buyBtn.Text = "⏳"
        resultLabel.Text = "🎯 جاري شراء: " .. id
        
        task.spawn(function()
            local success, message = buyBooth(id, 0)
            
            if success then
                resultLabel.Text = "✅ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
                buyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            else
                resultLabel.Text = "❌ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
                buyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            end
            
            buyBtn.Text = "⚡ شراء"
        end)
    end)
    
    idLabel.Parent = btnFrame
    buyBtn.Parent = btnFrame
    btnFrame.Parent = idsFrame
end

-- زر شراء الكل
local buyAllBtn = Instance.new("TextButton")
buyAllBtn.Text = "🎯 شراء كل IDs"
buyAllBtn.Size = UDim2.new(0.9, 0, 0.08, 0)
buyAllBtn.Position = UDim2.new(0.05, 0, 0.74, 0)
buyAllBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
buyAllBtn.TextColor3 = Color3.new(1, 1, 1)
buyAllBtn.Font = Enum.Font.SourceSansBold

buyAllBtn.MouseButton1Click:Connect(function()
    resultLabel.Text = "🎯 جاري شراء جميع IDs..."
    
    task.spawn(function()
        local successCount = 0
        
        for _, id in ipairs(foundIDs) do
            local success, _ = buyBooth(id, 0)
            if success then
                successCount = successCount + 1
                print("✅ اشترينا: " .. id)
            else
                print("❌ فشل: " .. id)
            end
            task.wait(0.5) -- تأخير بين المحاولات
        end
        
        resultLabel.Text = string.format("📊 النتائج: %d/%d ناجحة", successCount, #foundIDs)
    end)
end)

-- التجميع
title.Parent = mainFrame
idsFrame.Parent = mainFrame
buyAllBtn.Parent = mainFrame
resultLabel.Parent = mainFrame
mainFrame.Parent = screenGui
screenGui.Parent = player.PlayerGui

-- أوامر الكونسول
_G.BuyID = function(id)
    if not id then
        print("📋 IDs المتاحة:")
        for _, bid in ipairs(foundIDs) do
            print("• " .. bid)
        end
        return "اختر ID من القائمة"
    end
    
    return buyBooth(id, 0)
end

_G.BuyAll = function()
    local successCount = 0
    
    for _, id in ipairs(foundIDs) do
        local success, _ = buyBooth(id, 0)
        if success then successCount = successCount + 1 end
        task.wait(0.3)
    end
    
    return string.format("اشترينا %d/%d", successCount, #foundIDs)
end

print([[
    
🎯 QUICK BOOTH BUYER
⚡ IDs اللي لقيتها:

1. booth_Booths_8494 ← Booths للتداول 🎯
2. booth_BlacksmithStand_3592 ← حداد ⚒️
3. booth_GardenCoinShop_2291 ← عملات الحديقة 🌱
4. booth_PhysicalEggsShop_1102 ← بيض 🥚
5. booth_system_main ← النظام الرئيسي ⚡

الأوامر:
_G.BuyID("booth_Booths_8494")
_G.BuyAll() - شراء الكل

]])

print("✅ السكربت جاهز! جرب booth_Booths_8494 أولاً!")
