-- 🎯 ULTIMATE UUID BOOTH EXPLOITER
-- loadstring(game:HttpGet("رابط_هذا_الكود"))()

local player = game.Players.LocalPlayer
local buyRemote = game:GetService("ReplicatedStorage").GameEvents.TradeEvents.Booths.BuyListing

-- 📋 UUIDs للاستخدام
local UUID_LIST = {
    "e96ef05f-a864-40ae-8e86-93a457352f01",
    "e96ef05f-a864-40ae-8e86-93a457352f02",
    "e96ef05f-a864-40ae-8e86-93a457352f03",
    "e96ef05f-a864-40ae-8e86-93a457352f04",
    "e96ef05f-a864-40ae-8e86-93a457352f05"
}

-- ⚡ استغلال مباشر (FilteringEnabled=false)
local function exploitUUID(uuid)
    -- Payloads قوية للاستغلال
    local exploitPayloads = {
        -- Payload 1: استغلال مباشر
        {
            listingId = uuid,
            price = 0,
            buyerId = player.UserId,
            bypassValidation = true,
            forcePurchase = true,
            _bypass = "filtering_enabled_false"
        },
        
        -- Payload 2: كأنه من السيرفر
        {
            id = uuid,
            cost = 0,
            buyer = player.Name,
            source = "Server",
            adminOverride = true,
            noChecks = true
        },
        
        -- Payload 3: مع بيانات إضافية
        {
            uuid = uuid,
            price = 0,
            transactionType = "FORCE_BUY",
            timestamp = os.time(),
            requester = "SYSTEM"
        },
        
        -- Payload 4: بسيط لكن قوي
        {listingId = uuid, price = 0}
    }
    
    print("🎯 جرب UUID: " .. string.sub(uuid, 1, 12) .. "...")
    
    for i, payload in ipairs(exploitPayloads) do
        local success, result = pcall(function()
            return buyRemote:InvokeServer(payload)
        end)
        
        if success then
            print("✅ Payload " .. i .. " ناجح!")
            print("📦 النتيجة: " .. tostring(result))
            
            -- تحقق إذا حصلنا على شيء
            if result and type(result) == "table" then
                if result.pet then
                    print("🎉 حصلت على Pet: " .. result.pet)
                elseif result.item then
                    print("🎁 حصلت على Item: " .. result.item)
                elseif result.success then
                    print("✨ عملية ناجحة!")
                end
            end
            
            return true, "✅ نجح! - " .. tostring(result)
        end
    end
    
    return false, "❌ فشل كل الطرق"
end

-- 💣 استغلال كل UUIDs
local function exploitAllUUIDs()
    local successCount = 0
    
    print("\n💣 بدء استغلال كل UUIDs...")
    
    for i, uuid in ipairs(UUID_LIST) do
        print("\n🎯 [" .. i .. "/" .. #UUID_LIST .. "] UUID: " .. string.sub(uuid, 1, 16) .. "...")
        
        local success, message = exploitUUID(uuid)
        
        if success then
            successCount = successCount + 1
            print("✅ ناجح!")
        else
            print("❌ فشل")
        end
        
        task.wait(0.5) -- تأخير بسيط
    end
    
    print("\n📊 النتائج: " .. successCount .. "/" .. #UUID_LIST .. " ناجحة")
    return successCount
end

-- 📱 واجهة موبايل في نصف الشاشة
local function createHalfScreenUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UUIDExploiter"
    screenGui.ResetOnSpawn = false
    
    -- الإطار في النصف
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.95, 0, 0.5, 0)
    mainFrame.Position = UDim2.new(0.025, 0, 0.25, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 3
    mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0) -- أحمر تأكيد
    
    -- العنوان
    local title = Instance.new("TextLabel")
    title.Text = "💣 UUID EXPLOITER"
    title.Size = UDim2.new(1, 0, 0.15, 0)
    title.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 22
    
    -- حقل إدخال UUID
    local uuidBox = Instance.new("TextBox")
    uuidBox.PlaceholderText = "أدخل UUID هنا"
    uuidBox.Text = UUID_LIST[1]
    uuidBox.Size = UDim2.new(0.9, 0, 0.12, 0)
    uuidBox.Position = UDim2.new(0.05, 0, 0.18, 0)
    uuidBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    uuidBox.TextColor3 = Color3.new(1, 1, 1)
    uuidBox.Font = Enum.Font.SourceSans
    uuidBox.TextSize = 16
    
    -- زر الشراء الفردي
    local buyBtn = Instance.new("TextButton")
    buyBtn.Text = "⚡ استغل هذا UUID"
    buyBtn.Size = UDim2.new(0.9, 0, 0.15, 0)
    buyBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
    buyBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    buyBtn.TextColor3 = Color3.new(1, 1, 1)
    buyBtn.Font = Enum.Font.SourceSansBold
    buyBtn.TextSize = 18
    
    -- زر استغلال الكل
    local exploitAllBtn = Instance.new("TextButton")
    exploitAllBtn.Text = "💣 استغل كل UUIDs"
    exploitAllBtn.Size = UDim2.new(0.9, 0, 0.15, 0)
    exploitAllBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
    exploitAllBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 100)
    exploitAllBtn.TextColor3 = Color3.new(1, 1, 1)
    exploitAllBtn.Font = Enum.Font.SourceSansBold
    
    -- النتائج
    local resultLabel = Instance.new("TextLabel")
    resultLabel.Text = "🎯 جاهز للاستغلال (FilteringEnabled=false)"
    resultLabel.Size = UDim2.new(0.9, 0, 0.25, 0)
    resultLabel.Position = UDim2.new(0.05, 0, 0.75, 0)
    resultLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    resultLabel.TextColor3 = Color3.new(1, 1, 1)
    resultLabel.TextWrapped = true
    resultLabel.Font = Enum.Font.SourceSans
    resultLabel.TextSize = 16
    
    -- ⚡ حدث الشراء الفردي
    buyBtn.MouseButton1Click:Connect(function()
        local uuid = uuidBox.Text:gsub("%s+", "")
        if uuid == "" then return end
        
        buyBtn.Text = "💥 يستغل..."
        resultLabel.Text = "🎯 جاري استغلال UUID..."
        
        task.spawn(function()
            local success, message = exploitUUID(uuid)
            
            if success then
                resultLabel.Text = "✅ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
                print("\n🎉🎉🎉 استغلال ناجح! 🎉🎉🎉")
            else
                resultLabel.Text = "❌ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
            end
            
            buyBtn.Text = "⚡ استغل هذا UUID"
        end)
    end)
    
    -- 💣 حدث استغلال الكل
    exploitAllBtn.MouseButton1Click:Connect(function()
        exploitAllBtn.Text = "💥 يستغل الكل..."
        resultLabel.Text = "💣 جاري استغلال جميع UUIDs..."
        
        task.spawn(function()
            local successCount = exploitAllUUIDs()
            
            resultLabel.Text = "📊 نجح " .. successCount .. "/" .. #UUID_LIST .. " UUIDs"
            
            if successCount > 0 then
                resultLabel.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
            else
                resultLabel.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
            end
            
            exploitAllBtn.Text = "💣 استغل كل UUIDs"
        end)
    end)
    
    -- زر توليد UUIDs جديدة
    local generateBtn = Instance.new("TextButton")
    generateBtn.Text = "🔄 توليد UUIDs"
    generateBtn.Size = UDim2.new(0.44, 0, 0.1, 0)
    generateBtn.Position = UDim2.new(0.05, 0, 0.18, 0)
    generateBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
    generateBtn.TextColor3 = Color3.new(1, 1, 1)
    generateBtn.Visible = false
    
    -- التجميع
    title.Parent = mainFrame
    uuidBox.Parent = mainFrame
    buyBtn.Parent = mainFrame
    exploitAllBtn.Parent = mainFrame
    generateBtn.Parent = mainFrame
    resultLabel.Parent = mainFrame
    mainFrame.Parent = screenGui
    screenGui.Parent = player.PlayerGui
    
    return screenGui
end

-- 🔧 التحقق من النظام
local function checkSystem()
    print("\n🔧 التحقق من النظام...")
    print("⚡ FilteringEnabled = " .. tostring(workspace.FilteringEnabled))
    
    if workspace.FilteringEnabled == false then
        print("🎉 THICC VULN: FilteringEnabled=false!")
        print("🎯 يمكن الاستغلال المباشر!")
        return true
    else
        print("⚠️ FilteringEnabled=true - جرب مع Payloads القوية")
        return false
    end
end

-- أوامر الكونسول
_G.ExploitUUID = function(uuid)
    if not uuid then
        print("📋 UUIDs المتاحة:")
        for i, uid in ipairs(UUID_LIST) do
            print(i .. ". " .. uid)
        end
        return "اختر UUID"
    end
    
    return exploitUUID(uuid)
end

_G.ExploitAll = function()
    return exploitAllUUIDs()
end

_G.AddUUID = function(newUUID)
    table.insert(UUID_LIST, newUUID)
    return "أضيف UUID: " .. newUUID
end

-- تشغيل
print([[
    
💣 ULTIMATE UUID EXPLOITER
⚡ استغلال FilteringEnabled=false

🎯 تقنية الاستغلال:
1. FilteringEnabled = false
2. Client → Server بدون تحقق
3. Purchase بسعر 0
4. الحصول على Pets مجاناً

📋 UUIDs جاهزة:
]])

for i, uuid in ipairs(UUID_LIST) do
    print(i .. ". " .. string.sub(uuid, 1, 16) .. "...")
end

print([[
  
⚡ الأوامر:
_G.ExploitUUID("uuid_here")
_G.ExploitAll() - استغلال الكل
_G.AddUUID("new_uuid") - إضافة UUID جديد

]])

-- التحقق التلقائي
checkSystem()

-- إنشاء الواجهة
createHalfScreenUI()

-- استغلال تلقائي بعد 3 ثواني
task.spawn(function()
    task.wait(3)
    print("\n🎯 بدء الاستغلال التلقائي...")
    exploitUUID(UUID_LIST[1])
end)

print("✅ UUID Exploiter جاهز!")
