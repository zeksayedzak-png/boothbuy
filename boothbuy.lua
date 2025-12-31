-- 🎯 PET SHOP EXPLOITER
-- loadstring(game:HttpGet("رابط_هذا_الكود"))()

local player = game.Players.LocalPlayer

-- 🔍 البحث عن PetShop Systems
local function findPetShopSystems()
    local petShopSystems = {}
    
    print("🔍 يبحث عن PetShop Systems...")
    
    -- RemoteEvents للـ PetShop
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local lowerName = obj.Name:lower()
            
            if lowerName:find("petshop") or 
               lowerName:find("buy") and lowerName:find("pet") then
                
                table.insert(petShopSystems, {
                    name = obj.Name,
                    path = obj:GetFullName(),
                    type = "RemoteEvent",
                    object = obj
                })
            end
        end
        
        -- RemoteFunctions للـ PetShop
        if obj:IsA("RemoteFunction") then
            local lowerName = obj.Name:lower()
            
            if lowerName:find("petshop") or 
               lowerName:find("pet") and lowerName:find("buy") then
                
                table.insert(petShopSystems, {
                    name = obj.Name,
                    path = obj:GetFullName(),
                    type = "RemoteFunction",
                    object = obj
                })
            end
        end
    end
    
    return petShopSystems
end

-- ⚡ اختراق PetShop
local function exploitPetShop(petId, price)
    price = price or 0
    
    print("🎯 جرب اختراق PetShop...")
    print("🐶 Pet ID: " .. tostring(petId))
    
    local systems = findPetShopSystems()
    
    if #systems == 0 then
        return false, "❌ ما لقيت PetShop systems"
    end
    
    print("📊 وجد " .. #systems .. " نظام PetShop")
    
    -- جرب كل نظام
    for i, system in ipairs(systems) do
        print("\n🔧 جرب: " .. system.name)
        
        if system.type == "RemoteEvent" then
            -- Payloads للـ RemoteEvent
            local payloads = {
                {petId = petId, price = price},
                {id = petId, cost = price, player = player.Name},
                {item = petId, amount = 1, currency = "FREE"}
            }
            
            for j, payload in ipairs(payloads) do
                local success, result = pcall(function()
                    system.object:FireServer(payload)
                    return "تم الإرسال"
                end)
                
                if success then
                    print("   ✅ Payload " .. j .. " ناجح")
                    return true, "PetShop اختراق ناجح!"
                end
            end
        else
            -- RemoteFunction
            local success, result = pcall(function()
                return system.object:InvokeServer("buyPet", petId, price)
            end)
            
            if success then
                print("   ✅ RemoteFunction ناجح")
                return true, "اشتريت Pet!"
            end
        end
    end
    
    return false, "كل الأنظمة فشلت"
end

-- 📱 واجهة موبايل بسيطة
local function createMobileUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PetShopExploiter"
    screenGui.ResetOnSpawn = false
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.9, 0, 0.35, 0)
    mainFrame.Position = UDim2.new(0.05, 0, 0.32, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    
    -- العنوان
    local title = Instance.new("TextLabel")
    title.Text = "🐶 PET SHOP EXPLOITER"
    title.Size = UDim2.new(1, 0, 0.15, 0)
    title.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    
    -- حقل Pet ID
    local petIdBox = Instance.new("TextBox")
    petIdBox.PlaceholderText = "Pet ID (مثال: pet_123)"
    petIdBox.Text = "pet_001"
    petIdBox.Size = UDim2.new(0.9, 0, 0.15, 0)
    petIdBox.Position = UDim2.new(0.05, 0, 0.2, 0)
    petIdBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    petIdBox.TextColor3 = Color3.new(1, 1, 1)
    
    -- حقل السعر
    local priceBox = Instance.new("TextBox")
    priceBox.PlaceholderText = "السعر (0 مجاناً)"
    priceBox.Text = "0"
    priceBox.Size = UDim2.new(0.9, 0, 0.12, 0)
    priceBox.Position = UDim2.new(0.05, 0, 0.4, 0)
    priceBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    priceBox.TextColor3 = Color3.new(1, 1, 1)
    
    -- زر الاختراق
    local exploitBtn = Instance.new("TextButton")
    exploitBtn.Text = "⚡ اختراق PetShop"
    exploitBtn.Size = UDim2.new(0.9, 0, 0.15, 0)
    exploitBtn.Position = UDim2.new(0.05, 0, 0.57, 0)
    exploitBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 100)
    exploitBtn.TextColor3 = Color3.new(1, 1, 1)
    exploitBtn.Font = Enum.Font.SourceSansBold
    
    -- النتائج
    local resultLabel = Instance.new("TextLabel")
    resultLabel.Text = "أدخل Pet ID واضغط ⚡"
    resultLabel.Size = UDim2.new(0.9, 0, 0.25, 0)
    resultLabel.Position = UDim2.new(0.05, 0, 0.77, 0)
    resultLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    resultLabel.TextColor3 = Color3.new(1, 1, 1)
    resultLabel.TextWrapped = true
    
    -- حدث الاختراق
    exploitBtn.MouseButton1Click:Connect(function()
        local petId = petIdBox.Text
        local price = tonumber(priceBox.Text) or 0
        
        if petId == "" then return end
        
        exploitBtn.Text = "⏳ جاري..."
        resultLabel.Text = "🎯 جاري اختراق PetShop..."
        
        task.spawn(function()
            local success, message = exploitPetShop(petId, price)
            
            if success then
                resultLabel.Text = "✅ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
            else
                resultLabel.Text = "❌ " .. message
                resultLabel.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
            end
            
            exploitBtn.Text = "⚡ اختراق PetShop"
        end)
    end)
    
    -- التجميع
    title.Parent = mainFrame
    petIdBox.Parent = mainFrame
    priceBox.Parent = mainFrame
    exploitBtn.Parent = mainFrame
    resultLabel.Parent = mainFrame
    mainFrame.Parent = screenGui
    screenGui.Parent = player.PlayerGui
end

-- أوامر الكونسول
_G.HackPetShop = function(petId, price)
    return exploitPetShop(petId, price)
end

_G.FindPetShops = function()
    return findPetShopSystems()
end

-- أمثلة لـ Pet IDs
local EXAMPLE_PET_IDS = {
    "pet_001", "pet_002", "pet_003",
    "pet_rare_001", "pet_epic_001",
    "pet_legendary_001", "dragon_pet",
    "cat_pet", "dog_pet", "bird_pet"
}

-- تشغيل
print([[
    
🐶 PET SHOP EXPLOITER
⚡ اختراق متجر الحيوانات الأليفة

🎯 PetShop ≠ Booth:
• PetShop: متجر اللعبة الرسمي
• Booth: تداول بين لاعبين

🔍 أمثلة Pet IDs:
]])

for i, petId in ipairs(EXAMPLE_PET_IDS) do
    print(i .. ". " .. petId)
end

print([[
  
⚡ الأوامر:
_G.HackPetShop("pet_001", 0)
_G.FindPetShops() - البحث عن أنظمة

🎯 جرب مع:
1. pet_001
2. pet_rare_001  
3. dragon_pet

]])

-- إنشاء الواجهة
createMobileUI()

-- بحث تلقائي عن PetShop systems
task.spawn(function()
    task.wait(2)
    local systems = findPetShopSystems()
    if #systems > 0 then
        print("✅ وجد " .. #systems .. " نظام PetShop")
        for _, system in ipairs(systems) do
            print("• " .. system.name .. " (" .. system.type .. ")")
        end
    end
end)
