-- 🎯 BOOTH EXPLOITER V2 - Mobile Optimized
-- loadstring(game:HttpGet("رابط_هذا_الكود"))()

local player = game.Players.LocalPlayer
local buyRemote = game:GetService("ReplicatedStorage").GameEvents.TradeEvents.Booths.BuyListing

-- 📋 IDs
local BOOTH_IDS = {
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

-- ⚡ استغلال للهاتف
local function mobileExploit(listingId, price)
    price = price or 0
    
    -- Payloads مبسطة للهاتف
    local payloads = {
        {listingId = listingId, price = price},
        {id = listingId, cost = price}
    }
    
    for i, payload in ipairs(payloads) do
        local success, result = pcall(function()
            return buyRemote:InvokeServer(payload)
        end)
        
        if success then
            return true, "✅ ناجح! - " .. tostring(result)
        end
        
        task.wait(0.1) -- تأخير أقل للهاتف
    end
    
    return false, "❌ فشل"
end

-- 📱 واجهة موبايل خفيفة
local function createMobileUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MobileExploiter"
    screenGui.ResetOnSpawn = false
    
    -- إطار بسيط
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.9, 0, 0.4, 0)
    mainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    
    -- عنوان
    local title = Instance.new("TextLabel")
    title.Text = "⚡ MOBILE EXPLOITER"
    title.Size = UDim2.new(1, 0, 0.15, 0)
    title.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    
    -- حقل ID
    local idBox = Instance.new("TextBox")
    idBox.PlaceholderText = "Booth ID هنا"
    idBox.Text = BOOTH_IDS[1]
    idBox.Size = UDim2.new(0.85, 0, 0.15, 0)
    idBox.Position = UDim2.new(0.075, 0, 0.2, 0)
    idBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    idBox.TextColor3 = Color3.new(1, 1, 1)
    idBox.Font = Enum.Font.SourceSans
    
    -- زر نسخ ID (بدون setclipboard)
    local copyBtn = Instance.new("TextButton")
    copyBtn.Text = "📋"
    copyBtn.Size = UDim2.new(0.1, 0, 0.15, 0)
    copyBtn.Position = UDim2.new(0.8, 0, 0.2, 0)
    copyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
    copyBtn.TextColor3 = Color3.new(1, 1, 1)
    
    -- زر الاستغلال
    local exploitBtn = Instance.new("TextButton")
    exploitBtn.Text = "⚡ استغل الآن"
    exploitBtn.Size = UDim2.new(0.85, 0, 0.2, 0)
    exploitBtn.Position = UDim2.new(0.075, 0, 0.4, 0)
    exploitBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    exploitBtn.TextColor3 = Color3.new(1, 1, 1)
    exploitBtn.Font = Enum.Font.SourceSansBold
    exploitBtn.TextSize = 18
    
    -- النتائج
    local resultLabel = Instance.new("TextLabel")
    resultLabel.Text = "أدخل ID واضغط ⚡"
    resultLabel.Size = UDim2.new(0.85, 0, 0.3, 0)
    resultLabel.Position = UDim2.new(0.075, 0, 0.65, 0)
    resultLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    resultLabel.TextColor3 = Color3.new(1, 1, 1)
    resultLabel.TextWrapped = true
    
    -- حدث النسخ (للجوال)
    copyBtn.MouseButton1Click:Connect(function()
        local id = idBox.Text
        print("\n📋 ID للنسخ:")
        print("=" .. string.rep("=", 30))
        print(id)
        print("=" .. string.rep("=", 30))
        print("📱 على الجوال: اضغط مطولاً على النص وانسخ")
        resultLabel.Text = "📋 انسخ ID من الكونسول"
    end)
    
    -- حدث الاستغلال
    exploitBtn.MouseButton1Click:Connect(function()
        local listingId = idBox.Text
        if listingId == "" then return end
        
        exploitBtn.Text = "⏳"
        resultLabel.Text = "جاري: " .. listingId
        
        task.spawn(function()
            local success, message = mobileExploit(listingId, 0)
            
            if success then
                resultLabel.Text = message
                resultLabel.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
            else
                resultLabel.Text = message
                resultLabel.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
            end
            
            exploitBtn.Text = "⚡ استغل الآن"
        end)
    end)
    
    -- التجميع
    title.Parent = mainFrame
    idBox.Parent = mainFrame
    copyBtn.Parent = mainFrame
    exploitBtn.Parent = mainFrame
    resultLabel.Parent = mainFrame
    mainFrame.Parent = screenGui
    screenGui.Parent = player.PlayerGui
    
    return screenGui
end

-- 🔧 تحميل الـ RemoteFunction
local function loadBuyRemote()
    local success, remote = pcall(function()
        return game:GetService("ReplicatedStorage").GameEvents.TradeEvents.Booths.BuyListing
    end)
    
    if success and remote then
        print("✅ BuyListing RemoteFunction موجود")
        return remote
    else
        print("❌ BuyListing مش موجود")
        return nil
    end
end

-- أوامر بسيطة للجوال
_G.Buy = function(id)
    if not id then
        print("📋 IDs المتاحة:")
        for i, bid in ipairs(BOOTH_IDS) do
            print(i .. ". " .. bid)
        end
        return "اختر ID"
    end
    
    return mobileExploit(id, 0)
end

_G.BuyAll = function()
    local successCount = 0
    for i, id in ipairs(BOOTH_IDS) do
        print("🎯 جرب: " .. id)
        local success, _ = mobileExploit(id, 0)
        if success then successCount = successCount + 1 end
        task.wait(0.3)
    end
    return "نجح: " .. successCount .. "/" .. #BOOTH_IDS
end

-- بدء التشغيل
print([[
    
📱 MOBILE BOOTH EXPLOITER
⚡ مصمم خصيصاً للهاتف

🎯 IDs جاهزة:
booth_Booths_8494 ← الأهم!
booth_PhysicalEggsShop_1102 ← البيض

⚡ الأوامر:
_G.Buy("booth_id")
_G.BuyAll() - جرب الكل

]])

-- التحقق من النظام
local remoteLoaded = loadBuyRemote()
if not remoteLoaded then
    print("❌ المشكلة: BuyListing مش موجود")
    print("🔍 تأكد من المسار:")
    print("ReplicatedStorage.GameEvents.TradeEvents.Booths.BuyListing")
else
    print("✅ النظام جاهز!")
end

-- إنشاء الواجهة
createMobileUI()

print("✅ استخدم _G.Buy('booth_Booths_8494')")
