-- 🎯 TRADE TOKENS EXPLOITER
-- loadstring(game:HttpGet("رابط_هذا_الكود"))()

local player = game.Players.LocalPlayer

-- 🔧 مسار التوكنات الحقيقي
local TOKEN_SYSTEM = {
    name = "TradeTokensPurchase",
    path = "ReplicatedStorage.GameEvents.TradeEvents.TradeTokens.Purchase",
    object = nil
}

-- 🔍 تحميل النظام
local function loadTokenSystem()
    local pathParts = TOKEN_SYSTEM.path:split(".")
    local current = game
    
    for i = 2, #pathParts do
        if current:FindFirstChild(pathParts[i]) then
            current = current[pathParts[i]]
        else
            print("❌ جزء مفقود: " .. pathParts[i])
            return false
        end
    end
    
    if current and current:IsA("RemoteFunction") then
        TOKEN_SYSTEM.object = current
        print("✅ وجد نظام التوكنات!")
        return true
    else
        print("❌ النظام مش RemoteFunction")
        return false
    end
end

-- ⚡ استغلال شراء التوكنات
local function exploitTradeTokens(tokenType, amount, currency)
    amount = tonumber(amount) or 1000
    tokenType = tokenType or "TradeToken"
    currency = currency or "FREE"
    
    if not TOKEN_SYSTEM.object then
        local loaded = loadTokenSystem()
        if not loaded then
            return false, "❌ نظام التوكنات مش موجود"
        end
    end
    
    print("🎯 جرب شراء " .. amount .. " " .. tokenType .. "...")
    
    -- Payloads خاصة للاستغلال (FilteringEnabled=false)
    local exploitPayloads = {
        -- Payload 1: استغلال مباشر
        {
            tokenType = tokenType,
            amount = amount,
            currency = currency,
            player = player,
            bypass = true,
            free = true,
            _exploit = "filtering_enabled_false"
        },
        
        -- Payload 2: كـ admin
        {
            type = tokenType,
            quantity = amount,
            paymentMethod = "FREE",
            adminOverride = true,
            silentTransaction = true
        },
        
        -- Payload 3: تحديث مباشر
        {
            item = tokenType,
            count = amount,
            cost = 0,
            source = "SystemUpdate",
            noValidation = true
        },
        
        -- Payload 4: هدية من النظام
        {
            tokenId = tokenType,
            amount = amount,
            giver = "SYSTEM",
            receiver = player.Name,
            gift = true,
            price = 0
        }
    }
    
    -- جرب كل payload
    for i, payload in ipairs(exploitPayloads) do
        print("\n🔧 جرب Payload " .. i .. "...")
        
        local success, result = pcall(function()
            return TOKEN_SYSTEM.object:InvokeServer(payload)
        end)
        
        if success then
            print("✅ Payload " .. i .. " ناجح!")
            print("📦 النتيجة: " .. tostring(result))
            
            -- تحقق إذا تمت العملية
            if result == true or (type(result) == "table" and result.success) then
                return true, "✅ تم شراء " .. amount .. " " .. tokenType .. "!"
            else
                return true, "✅ العملية ناجحة: " .. tostring(result)
            end
        else
            print("❌ Payload " .. i .. " فشل")
        end
        
        task.wait(0.2)
    end
    
    return false, "❌ كل المحاولات فشلت"
end

-- 📱 واجهة موبايل بسيطة
local function createMobileUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TokenExploiter"
    screenGui.ResetOnSpawn = false
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.9, 0, 0.4, 0)
    mainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    
    -- العنوان
    local title = Instance.new("TextLabel")
    title.Text = "💰 TRADE TOKENS EXPLOITER"
    title.Size = UDim2.new(1, 0, 0.15, 0)
    title.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    
    -- نوع التوكن
    local tokenTypeBox = Instance.new("TextBox")
    tokenTypeBox.PlaceholderText = "نوع التوكن (مثال: TradeToken)"
    tokenTypeBox.Text = "TradeToken"
    tokenTypeBox.Size = UDim2.new(0.9, 0, 0.12, 0)
    tokenTypeBox.Position = UDim2.new(0.05, 0, 0.18, 0)
    tokenTypeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tokenTypeBox.TextColor3 = Color3.new(1, 1, 1)
    
    -- كمية التوكن
    local amountBox = Instance.new("TextBox")
    amountBox.PlaceholderText = "الكمية (مثال: 1000)"
    amountBox.Text = "1000"
    amountBox.Size = UDim2.new(0.9, 0, 0.12, 0)
    amountBox.Position = UDim2.new(0.05, 0, 0.35, 0)
    amountBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    amountBox.TextColor3 = Color3.new(1, 1, 1)
    
    -- العملة
    local currencyBox = Instance.new("TextBox")
    currencyBox.PlaceholderText = "العملة (FREE لـ مجاني)"
    currencyBox.Text = "FREE"
    currencyBox.Size = UDim2.new(0.9, 0, 0.12, 0)
    currencyBox.Position = UDim2.new(0.05, 0, 0.52, 0)
    currencyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    currencyBox.TextColor3 = Color3.new(1, 1, 1)
    
    -- زر الاستغلال
    local exploitBtn = Instance.new("TextButton")
    exploitBtn.Text = "⚡ توليد توكنات"
    exploitBtn.Size = UDim2.new(0.9, 0, 0.15, 0)
    exploitBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
    exploitBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    exploitBtn.TextColor3 = Color3.new(1, 1, 1)
    exploitBtn.Font = Enum.Font.SourceSansBold
    
    -- النتائج
    local resultLabel = Instance.new("TextLabel")
    resultLabel.Text = "املأ الحقول واضغط ⚡"
    resultLabel.Size = UDim2.new(0.9, 0, 0.2, 0)
    resultLabel.Position = UDim2.new(0.05, 0, 0.88, 0)
    resultLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    resultLabel.TextColor3 = Color3.new(1, 1, 1)
    resultLabel.TextWrapped = true
    
    -- حدث الاستغلال
    exploitBtn.MouseButton1Click:Connect(function()
        local tokenType = tokenTypeBox.Text:gsub("%s+", "")
        local amount = tonumber(amountBox.Text) or 1000
        local currency = currencyBox.Text:gsub("%s+", "")
        
        if tokenType == "" then return end
        
        exploitBtn.Text = "⏳ جاري التوليد..."
        resultLabel.Text = "🎯 جاري توليد " .. amount .. " " .. tokenType .. "..."
        
        task.spawn(function()
            local success, message = exploitTradeTokens(tokenType, amount, currency)
            
            if success then
                resultLabel.Text = "✅ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
                
                -- إشعار في الكونسول
                print("\n🎉🎉🎉 تم توليد التوكنات! 🎉🎉🎉")
                print("💰 النوع: " .. tokenType)
                print("📊 الكمية: " .. amount)
                print("💳 العملة: " .. currency)
                print("📝 النتيجة: " .. message)
            else
                resultLabel.Text = "❌ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
            end
            
            exploitBtn.Text = "⚡ توليد توكنات"
        end)
    end)
    
    -- التجميع
    title.Parent = mainFrame
    tokenTypeBox.Parent = mainFrame
    amountBox.Parent = mainFrame
    currencyBox.Parent = mainFrame
    exploitBtn.Parent = mainFrame
    resultLabel.Parent = mainFrame
    mainFrame.Parent = screenGui
    screenGui.Parent = player.PlayerGui
end

-- 🔄 توليد تلقائي
local function autoGenerateTokens()
    print("\n🎯 بدء التوليد التلقائي...")
    
    local tokenTypes = {
        "TradeToken",
        "Gem",
        "Coin",
        "Diamond",
        "Gold",
        "PremiumToken"
    }
    
    local successCount = 0
    
    for _, tokenType in ipairs(tokenTypes) do
        print("\n💰 جرب: " .. tokenType)
        
        local success, message = exploitTradeTokens(tokenType, 500, "FREE")
        
        if success then
            successCount = successCount + 1
            print("✅ ناجح: " .. message)
        else
            print("❌ فشل: " .. tokenType)
        end
        
        task.wait(0.5)
    end
    
    print("\n📊 النتائج: " .. successCount .. "/" .. #tokenTypes .. " ناجحة")
    return successCount
end

-- أوامر الكونسول
_G.GenerateTokens = function(tokenType, amount, currency)
    if not tokenType then
        print("📋 أمثلة لأنواع التوكنات:")
        print("• TradeToken - توكنات التداول")
        print("• Gem - أحجار كريمة")
        print("• Coin - عملات ذهبية")
        print("• Diamond - ألماس")
        print("• Gold - ذهب")
        print("• PremiumToken - توكنات بريميوم")
        return "اختر نوع التوكن"
    end
    
    return exploitTradeTokens(tokenType, amount or 1000, currency or "FREE")
end

_G.AutoGenerate = function()
    return autoGenerateTokens()
end

_G.GetTokenSystem = function()
    local loaded = loadTokenSystem()
    if loaded then
        return "✅ نظام التوكنات موجود: " .. TOKEN_SYSTEM.path
    else
        return "❌ نظام التوكنات مش موجود"
    end
end

-- تشغيل
print([[
    
💰 TRADE TOKENS EXPLOITER
⚡ استغلال FilteringEnabled=false

🎯 نظام التوكنات:
ReplicatedStorage.GameEvents.TradeEvents.TradeTokens.Purchase

📋 أمثلة لأنواع التوكنات:
1. TradeToken - توكنات التداول الرئيسية
2. Gem - أحجار كريمة
3. Coin - عملات ذهبية  
4. Diamond - ألماس
5. Gold - ذهب
6. PremiumToken - توكنات بريميوم

⚡ الأوامر:
_G.GenerateTokens("TradeToken", 1000, "FREE")
_G.AutoGenerate() - توليد تلقائي لكل الأنواع
_G.GetTokenSystem() - التحقق من النظام

]])

-- تحميل النظام أولاً
task.spawn(function()
    task.wait(1)
    local loaded = loadTokenSystem()
    if loaded then
        print("✅ النظام جاهز للاستخدام!")
        
        -- توليد تلقائي بعد 3 ثواني
        task.wait(2)
        print("\n🎯 بدء التوليد التلقائي بعد 3 ثواني...")
        task.wait(1)
        exploitTradeTokens("TradeToken", 500, "FREE")
    else
        print("❌ تأكد من المسار:")
        print(TOKEN_SYSTEM.path)
    end
end)

-- إنشاء الواجهة
createMobileUI()

print("✅ Token Exploiter جاهز!")
