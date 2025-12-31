-- 🎯 BOOTH EXPLOITER V2 (FilteringEnabled=false Exploit)
-- loadstring(game:HttpGet("رابط_هذا_الكود"))()

local player = game.Players.LocalPlayer
local buyRemote = game:GetService("ReplicatedStorage").GameEvents.TradeEvents.Booths.BuyListing

-- 📋 IDs التي وجدتها سابقاً
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

-- ⚡ الاستغلال المباشر (FilteringEnabled=false)
local function exploitBuy(listingId, price)
    price = price or 0
    
    -- Payloads خاصة للاستغلال
    local exploitPayloads = {
        -- Payload 1: استغلال مباشر
        {
            listingId = listingId,
            price = price,
            buyerId = player.UserId,
            sellerId = 1, -- ID خادم
            force = true,
            bypass = true
        },
        
        -- Payload 2: مع بيانات إضافية
        {
            id = listingId,
            cost = price,
            buyer = player.Name,
            timestamp = os.time(),
            _bypassValidation = true
        },
        
        -- Payload 3: كطلب من السيرفر
        {
            listingId = listingId,
            price = price,
            source = "Server",
            admin = true,
            noCheck = true
        },
        
        -- Payload 4: بسيط جداً
        {listingId = listingId, price = price}
    }
    
    -- جرب كل Payload
    for i, payload in ipairs(exploitPayloads) do
        print("🎯 جرب Payload " .. i .. " مع ID: " .. listingId)
        
        local success, result = pcall(function()
            return buyRemote:InvokeServer(payload)
        end)
        
        if success then
            print("✅ نجح Payload " .. i .. "!")
            print("📦 النتيجة: " .. tostring(result))
            return true, "✅ نجح! - " .. tostring(result)
        else
            print("❌ فشل Payload " .. i)
        end
        
        task.wait(0.2) -- تأخير بسيط
    end
    
    return false, "❌ كل الطرق فشلت"
end

-- 📱 واجهة بسيطة في نصف الشاشة
local function createHalfScreenUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BoothExploiterV2"
    screenGui.ResetOnSpawn = false
    
    -- الإطار في نصف الشاشة
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.96, 0, 0.5, 0) -- نصف الشاشة
    mainFrame.Position = UDim2.new(0.02, 0, 0.25, 0) -- في المنتصف
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 50, 50) -- أحمر تحذيري
    
    -- العنوان
    local title = Instance.new("TextLabel")
    title.Text = "⚡ BOOTH EXPLOITER V2"
    title.Size = UDim2.new(1, 0, 0.15, 0)
    title.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 22
    
    -- حقل إدخال ID
    local idBox = Instance.new("TextBox")
    idBox.PlaceholderText = "أدخل Booth ID هنا"
    idBox.Text = BOOTH_IDS[1] -- أول ID افتراضي
    idBox.Size = UDim2.new(0.9, 0, 0.12, 0)
    idBox.Position = UDim2.new(0.05, 0, 0.2, 0)
    idBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    idBox.TextColor3 = Color3.new(1, 1, 1)
    idBox.Font = Enum.Font.SourceSans
    idBox.TextSize = 18
    
    -- حقل السعر
    local priceBox = Instance.new("TextBox")
    priceBox.PlaceholderText = "السعر (0 مجاناً)"
    priceBox.Text = "0"
    priceBox.Size = UDim2.new(0.9, 0, 0.1, 0)
    priceBox.Position = UDim2.new(0.05, 0, 0.35, 0)
    priceBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    priceBox.TextColor3 = Color3.new(1, 1, 1)
    priceBox.Font = Enum.Font.SourceSans
    
    -- زر الشراء الفردي
    local buyBtn = Instance.new("TextButton")
    buyBtn.Text = "⚡ استغل الآن!"
    buyBtn.Size = UDim2.new(0.9, 0, 0.15, 0)
    buyBtn.Position = UDim2.new(0.05, 0, 0.5, 0)
    buyBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    buyBtn.TextColor3 = Color3.new(1, 1, 1)
    buyBtn.Font = Enum.Font.SourceSansBold
    buyBtn.TextSize = 20
    
    -- زر استغلال كل IDs
    local exploitAllBtn = Instance.new("TextButton")
    exploitAllBtn.Text = "💣 استغل كل IDs"
    exploitAllBtn.Size = UDim2.new(0.9, 0, 0.12, 0)
    exploitAllBtn.Position = UDim2.new(0.05, 0, 0.68, 0)
    exploitAllBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 100)
    exploitAllBtn.TextColor3 = Color3.new(1, 1, 1)
    exploitAllBtn.Font = Enum.Font.SourceSansBold
    
    -- النتائج
    local resultLabel = Instance.new("TextLabel")
    resultLabel.Text = "🟢 جاهز للاستغلال"
    resultLabel.Size = UDim2.new(0.9, 0, 0.2, 0)
    resultLabel.Position = UDim2.new(0.05, 0, 0.83, 0)
    resultLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    resultLabel.TextColor3 = Color3.new(1, 1, 1)
    resultLabel.TextWrapped = true
    resultLabel.Font = Enum.Font.SourceSans
    resultLabel.TextSize = 16
    
    -- ⚡ حدث الشراء الفردي
    buyBtn.MouseButton1Click:Connect(function()
        local listingId = idBox.Text:gsub("%s+", "")
        local price = tonumber(priceBox.Text) or 0
        
        if listingId == "" then
            resultLabel.Text = "❌ أدخل Booth ID"
            return
        end
        
        buyBtn.Text = "💥 يستغل..."
        resultLabel.Text = "🎯 جاري استغلال: " .. listingId
        
        task.spawn(function()
            local success, message = exploitBuy(listingId, price)
            
            if success then
                resultLabel.Text = "✅ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
                
                -- إشعار في الكونسول
                print("\n🎉🎉🎉 استغلال ناجح! 🎉🎉🎉")
                print("📌 ID: " .. listingId)
                print("💰 السعر: " .. price)
                print("📝 النتيجة: " .. message)
            else
                resultLabel.Text = "❌ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
            end
            
            buyBtn.Text = "⚡ استغل الآن!"
        end)
    end)
    
    -- 💣 حدث استغلال كل IDs
    exploitAllBtn.MouseButton1Click:Connect(function()
        exploitAllBtn.Text = "💥 يستغل الكل..."
        resultLabel.Text = "💣 جاري استغلال جميع IDs..."
        
        task.spawn(function()
            local successCount = 0
            
            for i, id in ipairs(BOOTH_IDS) do
                resultLabel.Text = "💣 يستغل (" .. i .. "/" .. #BOOTH_IDS .. "): " .. id
                
                local success, message = exploitBuy(id, 0)
                
                if success then
                    successCount = successCount + 1
                    print("✅ [" .. i .. "] استغلنا: " .. id)
                else
                    print("❌ [" .. i .. "] فشل: " .. id)
                end
                
                task.wait(0.5) -- تأخير بين المحاولات
            end
            
            resultLabel.Text = "📊 استغلنا " .. successCount .. "/" .. #BOOTH_IDS .. " IDs"
            
            if successCount > 0 then
                resultLabel.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
                print("\n🎉 استغلنا " .. successCount .. " Booth بنجاح!")
            else
                resultLabel.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
            end
            
            exploitAllBtn.Text = "💣 استغل كل IDs"
        end)
    end)
    
    -- زر نسخ IDs
    local copyIdsBtn = Instance.new("TextButton")
    copyIdsBtn.Text = "📋 نسخ IDs"
    copyIdsBtn.Size = UDim2.new(0.28, 0, 0.08, 0)
    copyIdsBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
    copyIdsBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    copyIdsBtn.TextColor3 = Color3.new(1, 1, 1)
    copyIdsBtn.Visible = false
    
    -- حدث نسخ IDs
    copyIdsBtn.MouseButton1Click:Connect(function()
        local idsText = table.concat(BOOTH_IDS, "\n")
        
        pcall(function()
            if setclipboard then
                setclipboard(idsText)
                resultLabel.Text = "📋 نسخت " .. #BOOTH_IDS .. " IDs"
            else
                resultLabel.Text = "📋 انسخ من الكونسول"
                print("\n📋 Booth IDs:\n" .. idsText)
            end
        end)
    end)
    
    -- التجميع
    title.Parent = mainFrame
    idBox.Parent = mainFrame
    priceBox.Parent = mainFrame
    buyBtn.Parent = mainFrame
    exploitAllBtn.Parent = mainFrame
    copyIdsBtn.Parent = mainFrame
    resultLabel.Parent = mainFrame
    mainFrame.Parent = screenGui
    screenGui.Parent = player.PlayerGui
    
    -- جعل الإطار قابل للسحب
    local dragging = false
    local dragStart, startPos
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    mainFrame.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X,
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    mainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    return screenGui
end

-- ⚡ استغلال تلقائي عند التشغيل
local function autoExploit()
    print("\n🎯 BOOTH EXPLOITER V2 - Auto Mode")
    print("⚡ FilteringEnabled = " .. tostring(workspace.FilteringEnabled))
    
    if workspace.FilteringEnabled == false then
        print("🎉 ثغرة مؤكدة! FilteringEnabled=false")
        print("⚡ بدء الاستغلال التلقائي...")
        
        -- جرب أول IDين
        exploitBuy(BOOTH_IDS[1], 0)
        task.wait(1)
        exploitBuy(BOOTH_IDS[2], 0)
    else
        print("⚠️ FilteringEnabled=true - جرب يدوياً")
    end
end

-- أوامر الكونسول
_G.ExploitBooth = function(listingId, price)
    if not listingId then
        return "الأمر: _G.ExploitBooth('booth_id', 0)"
    end
    
    return exploitBuy(listingId, price or 0)
end

_G.ExploitAll = function()
    local successCount = 0
    
    for i, id in ipairs(BOOTH_IDS) do
        print("🎯 [" .. i .. "] يستغل: " .. id)
        local success, _ = exploitBuy(id, 0)
        if success then successCount = successCount + 1 end
        task.wait(0.3)
    end
    
    return "استغلنا " .. successCount .. "/" .. #BOOTH_IDS
end

_G.GetIDs = function()
    return BOOTH_IDS
end

-- بدء التشغيل
print([[
    
⚡ BOOTH EXPLOITER V2
🎯 استغلال FilteringEnabled=false

📋 IDs المتاحة:
1. booth_Booths_8494 - الأهم!
2. booth_BlacksmithStand_3592
3. booth_GardenCoinShop_2291  
4. booth_PhysicalEggsShop_1102
5. booth_CosmeticShop_UI_9806
6. booth_EventShop_UI_3708
7. booth_GardenCoinShop_UI_4345
8. booth_Gear_Shop_1175
9. booth_PetShop_UI_7215
10. booth_system_main

⚡ الأوامر:
_G.ExploitBooth("booth_id", 0)
_G.ExploitAll() - استغلال الكل
_G.GetIDs() - عرض IDs

]])

-- إنشاء الواجهة
createHalfScreenUI()

-- تشغيل الاستغلال التلقائي بعد 3 ثواني
task.spawn(function()
    task.wait(3)
    autoExploit()
end)

print("✅ Booth Exploiter V2 جاهز!")
