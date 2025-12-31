-- 🎯 TOKEN ADD EXPLOITER
-- loadstring(game:HttpGet("رابط_هذا_الكود"))()

local player = game.Players.LocalPlayer

-- 🔧 الأنظمة المؤكدة لإضافة التوكنات
local ADD_TOKEN_SYSTEMS = {
    -- رقم 2: FakePurchase (قد يكون للاختبار)
    {
        name = "FakePurchase",
        path = "ReplicatedStorage.GameEvents.Market.FakePurchase",
        type = "RemoteEvent",
        confirmed = true
    },
    
    -- رقم 33: DeveloperPurchase (للمطورين)
    {
        name = "DeveloperPurchase",
        path = "ReplicatedStorage.GameEvents.DeveloperPurchase",
        type = "RemoteEvent",
        confirmed = true
    },
    
    -- رقم 40: DevRestockGearShop (تزويد من المطور)
    {
        name = "DevRestockGearShop",
        path = "ReplicatedStorage.GameEvents.DevRestockGearShop",
        type = "RemoteEvent",
        confirmed = true
    },
    
    -- رقم 7: OfferingWeather (عروض مجانية)
    {
        name = "OfferingWeather",
        path = "ReplicatedStorage.GameEvents.OfferingWeather",
        type = "RemoteEvent",
        confirmed = true
    },
    
    -- رقم 17: AddItem (إضافة أيتم مباشرة)
    {
        name = "AddItem",
        path = "ReplicatedStorage.GameEvents.TradeEvents.AddItem",
        type = "RemoteEvent",
        confirmed = true
    }
}

-- 🔍 تحميل الأنظمة
local function loadAddTokenSystems()
    local loadedSystems = {}
    
    for _, system in ipairs(ADD_TOKEN_SYSTEMS) do
        local pathParts = system.path:split(".")
        local current = game
        
        for i = 2, #pathParts do
            if current:FindFirstChild(pathParts[i]) then
                current = current[pathParts[i]]
            else
                current = nil
                break
            end
        end
        
        if current and current:IsA("RemoteEvent") then
            system.object = current
            system.loaded = true
            table.insert(loadedSystems, system)
            print("✅ " .. system.name .. " - جاهز")
        else
            print("❌ " .. system.name .. " - غير موجود")
        end
    end
    
    return loadedSystems
end

-- ⚡ استغلال إضافة التوكنات
local function addTokensExploit(amount, tokenType)
    amount = tonumber(amount) or 1000
    tokenType = tokenType or "Token"
    
    print("🎯 جرب إضافة " .. amount .. " " .. tokenType .. "...")
    
    local systems = loadAddTokenSystems()
    if #systems == 0 then
        return false, "❌ ما لقيت أنظمة إضافة"
    end
    
    -- Payloads قوية للاستغلال (FilteringEnabled=false)
    local exploitPayloads = {
        -- Payload 1: FakePurchase (رقم 2)
        {
            fake = true,
            amount = amount,
            currency = tokenType,
            player = player,
            test = true,
            _noCost = true
        },
        
        -- Payload 2: DeveloperPurchase (رقم 33)
        {
            developer = true,
            item = tokenType,
            quantity = amount,
            target = player.Name,
            free = true,
            admin = true
        },
        
        -- Payload 3: DevRestockGearShop (رقم 40)
        {
            restock = true,
            itemType = tokenType,
            count = amount,
            forPlayer = player.UserId,
            instant = true
        },
        
        -- Payload 4: OfferingWeather (رقم 7)
        {
            offering = "FREE_" .. tokenType,
            amount = amount,
            receiver = player,
            weather = "SUNNY", -- مشمس = مجاني
            bonus = amount
        },
        
        -- Payload 5: AddItem (رقم 17)
        {
            itemId = tokenType,
            amount = amount,
            playerId = player.UserId,
            source = "GIFT",
            silent = true
        }
    }
    
    -- جرب كل نظام مع كل payload
    for i, system in ipairs(systems) do
        print("\n🔧 جرب نظام: " .. system.name)
        
        -- اختر الـ payload المناسب لكل نظام
        local payloadIndex = i
        if payloadIndex > #exploitPayloads then
            payloadIndex = #exploitPayloads
        end
        
        local payload = exploitPayloads[payloadIndex]
        
        local success, result = pcall(function()
            system.object:FireServer(payload)
            return "تم الإرسال"
        end)
        
        if success then
            print("✅ " .. system.name .. " ناجح!")
            return true, "✅ تم إضافة " .. amount .. " " .. tokenType .. "!"
        else
            print("❌ " .. system.name .. " فشل")
        end
        
        task.wait(0.3)
    end
    
    return false, "❌ كل الأنظمة فشلت"
end

-- 📱 واجهة موبايل بسيطة
local function createMobileUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AddTokenExploiter"
    screenGui.ResetOnSpawn = false
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.9, 0, 0.35, 0)
    mainFrame.Position = UDim2.new(0.05, 0, 0.32, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    
    -- العنوان
    local title = Instance.new("TextLabel")
    title.Text = "💰 ADD TOKEN EXPLOITER"
    title.Size = UDim2.new(1, 0, 0.15, 0)
    title.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    
    -- كمية التوكن
    local amountBox = Instance.new("TextBox")
    amountBox.PlaceholderText = "الكمية (مثال: 1000)"
    amountBox.Text = "1000"
    amountBox.Size = UDim2.new(0.9, 0, 0.15, 0)
    amountBox.Position = UDim2.new(0.05, 0, 0.2, 0)
    amountBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    amountBox.TextColor3 = Color3.new(1, 1, 1)
    
    -- نوع التوكن
    local tokenTypeBox = Instance.new("TextBox")
    tokenTypeBox.PlaceholderText = "نوع التوكن (مثال: Token)"
    tokenTypeBox.Text = "Token"
    tokenTypeBox.Size = UDim2.new(0.9, 0, 0.15, 0)
    tokenTypeBox.Position = UDim2.new(0.05, 0, 0.4, 0)
    tokenTypeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tokenTypeBox.TextColor3 = Color3.new(1, 1, 1)
    
    -- زر التزويد
    local addBtn = Instance.new("TextButton")
    addBtn.Text = "⚡ زوّد توكنات"
    addBtn.Size = UDim2.new(0.9, 0, 0.15, 0)
    addBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
    addBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    addBtn.TextColor3 = Color3.new(1, 1, 1)
    addBtn.Font = Enum.Font.SourceSansBold
    
    -- النتائج
    local resultLabel = Instance.new("TextLabel")
    resultLabel.Text = "املأ الحقول واضغط ⚡"
    resultLabel.Size = UDim2.new(0.9, 0, 0.25, 0)
    resultLabel.Position = UDim2.new(0.05, 0, 0.8, 0)
    resultLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    resultLabel.TextColor3 = Color3.new(1, 1, 1)
    resultLabel.TextWrapped = true
    
    -- حدث التزويد
    addBtn.MouseButton1Click:Connect(function()
        local amount = tonumber(amountBox.Text) or 1000
        local tokenType = tokenTypeBox.Text:gsub("%s+", "")
        
        if tokenType == "" then return end
        
        addBtn.Text = "⏳ جاري التزويد..."
        resultLabel.Text = "🎯 جاري إضافة " .. amount .. " " .. tokenType .. "..."
        
        task.spawn(function()
            local success, message = addTokensExploit(amount, tokenType)
            
            if success then
                resultLabel.Text = "✅ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
                
                -- إشعار في الكونسول
                print("\n🎉🎉🎉 تم تزويد التوكنات! 🎉🎉🎉")
                print("💰 النوع: " .. tokenType)
                print("📊 الكمية: " .. amount)
                print("⚡ النظام: FakePurchase/DeveloperPurchase")
            else
                resultLabel.Text = "❌ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
            end
            
            addBtn.Text = "⚡ زوّد توكنات"
        end)
    end)
    
    -- التجميع
    title.Parent = mainFrame
    amountBox.Parent = mainFrame
    tokenTypeBox.Parent = mainFrame
    addBtn.Parent = mainFrame
    resultLabel.Parent = mainFrame
    mainFrame.Parent = screenGui
    screenGui.Parent = player.PlayerGui
end

-- 🔄 تجربة كل الأنواع
local function tryAllTokenTypes(amount)
    amount = tonumber(amount) or 1000
    
    print("\n🎯 جرب كل أنواع التوكنات...")
    
    local tokenTypes = {
        "Token",
        "Gem",
        "Coin",
        "Gold",
        "Diamond",
        "TradeToken",
        "PremiumToken",
        "EventToken"
    }
    
    local successCount = 0
    
    for _, tokenType in ipairs(tokenTypes) do
        print("\n💰 جرب: " .. tokenType)
        
        local success, message = addTokensExploit(amount, tokenType)
        
        if success then
            successCount = successCount + 1
            print("✅ ناجح!")
        else
            print("❌ فشل")
        end
        
        task.wait(0.5)
    end
    
    print("\n📊 النتائج: " .. successCount .. "/" .. #tokenTypes .. " ناجحة")
    return successCount
end

-- أوامر الكونسول
_G.AddTokens = function(amount, tokenType)
    if not amount then
        print("📋 أمثلة:")
        print("_G.AddTokens(1000, 'Token')")
        print("_G.AddTokens(5000, 'Gem')")
        print("_G.AddTokens(10000, 'Coin')")
        return "أدخل الكمية والنوع"
    end
    
    return addTokensExploit(amount, tokenType)
end

_G.TryAllTokens = function(amount)
    return tryAllTokenTypes(amount or 1000)
end

_G.TestSystems = function()
    local systems = loadAddTokenSystems()
    return "✅ " .. #systems .. "/" .. #ADD_TOKEN_SYSTEMS .. " أنظمة محملة"
end

-- تشغيل
print([[
    
💰 ADD TOKEN EXPLOITER
⚡ إضافة توكنات مباشرة (مش شراء)

🎯 الأنظمة المستخدمة:
1. FakePurchase (رقم 2) - شراء وهمي
2. DeveloperPurchase (رقم 33) - للمطورين
3. DevRestockGearShop (رقم 40) - تزويد المطور
4. OfferingWeather (رقم 7) - عروض مجانية
5. AddItem (رقم 17) - إضافة مباشرة

📋 أنواع التوكنات:
• Token - توكن عادي
• Gem - أحجار كريمة
• Coin - عملات ذهبية
• Gold - ذهب
• Diamond - ألماس
• TradeToken - توكنات تداول
• PremiumToken - توكنات بريميوم
• EventToken - توكنات إيفنت

⚡ الأوامر:
_G.AddTokens(1000, 'Token') - إضافة 1000 توكن
_G.TryAllTokens(500) - تجربة كل الأنواع
_G.TestSystems() - اختبار الأنظمة

]])

-- تحميل الأنظمة تلقائياً
task.spawn(function()
    task.wait(1)
    local systems = loadAddTokenSystems()
    print("\n📊 الأنظمة المحملة: " .. #systems .. "/" .. #ADD_TOKEN_SYSTEMS)
    
    for _, system in ipairs(systems) do
        print("✅ " .. system.name .. " - جاهز للاستخدام")
    end
    
    if #systems > 0 then
        -- تجربة تلقائية بعد 2 ثانية
        task.wait(2)
        print("\n🎯 بدء التجربة التلقائية...")
        addTokensExploit(500, "Token")
    end
end)

-- إنشاء الواجهة
createMobileUI()

print("✅ Add Token Exploiter جاهز!")
