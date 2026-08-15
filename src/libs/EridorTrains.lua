-- Eridor's common package v1.8
-- Last edit: 08.08.2026


local Types = {
	EN57 = 0,
	EN71 = 1,
	Elf = 2,
}

Loc = {
    Other = 0,
    Katowice = 1,
    Warszawa = 2,
    Lodz = 3
}

---------

local EN57 = {
    LocomotiveNames.EN57_047,
    LocomotiveNames.EN57_206,
    LocomotiveNames.EN57_612,
    LocomotiveNames.EN57_650,
    LocomotiveNames.EN57_1051,
    LocomotiveNames.EN57_1181,
    LocomotiveNames.EN57_1219,
    LocomotiveNames.EN57_1316,
    LocomotiveNames.EN57_1331,
}
local EN57_KM = {
    LocomotiveNames.EN57_038,
    LocomotiveNames.EN57_047,
    LocomotiveNames.EN57_1000,
    LocomotiveNames.EN57_1796,
    LocomotiveNames.EN57_1000,
    LocomotiveNames.EN57_1796,
    LocomotiveNames.EN57_1000,
    LocomotiveNames.EN57_1796,
    LocomotiveNames.EN57_1000,
    LocomotiveNames.EN57_1796,
}
local EN57_LKA = {
    LocomotiveNames.EN57_047,
    LocomotiveNames.EN57_206,
    LocomotiveNames.EN57_612,
    LocomotiveNames.EN57_650,
    LocomotiveNames.EN57_919,
    LocomotiveNames.EN57_1181,
    LocomotiveNames.EN57_1316,
    LocomotiveNames.EN57_1331,
}
local EN71 = {
    LocomotiveNames.EN71_002,
    LocomotiveNames.EN71_004,
    LocomotiveNames.EN71_005,
    LocomotiveNames.EN71_015,
}
local EN96 = {
    LocomotiveNames.EN96_001,
}
local EN76_KS = {
    LocomotiveNames.EN76_006,
}
local EN76_KM = {
    LocomotiveNames.EN76_022,
}
local WE36_LKA = {
    LocomotiveNames._36WEd_001,
    LocomotiveNames._36WEd_002,
    LocomotiveNames._36WEd_003,
    LocomotiveNames._36WEd_004,
    LocomotiveNames._36WEd_005,
    LocomotiveNames._36WEd_006,
    LocomotiveNames._36WEd_007,
    LocomotiveNames._36WEd_008,
    LocomotiveNames._36WEd_009,
    LocomotiveNames._36WEd_010,
    LocomotiveNames._36WEd_011,
    LocomotiveNames._36WEd_012,
    LocomotiveNames._36WEd_013,
    LocomotiveNames._36WEd_014,
}
local RegionSpecificEzt = {
    LocomotiveNames.EN76_006,
    LocomotiveNames.EN76_022,
    LocomotiveNames.EN57_038,
    LocomotiveNames.ED250_018
}

local PassengerFastLocos = {
    LocomotiveNames.EU43_001,
    LocomotiveNames.E186_136,
    LocomotiveNames.E186_241,
    LocomotiveNames.EP08_001,
    LocomotiveNames.EP08_008,
    LocomotiveNames.EP08_013,
    LocomotiveNames.EP07_135,
    LocomotiveNames.EP07_174,
}
local PassengerSlowLocos = {
    LocomotiveNames.ET22_644,
    LocomotiveNames.ET22_836,
    LocomotiveNames.EU07_005,
    LocomotiveNames.EU07_085,
    LocomotiveNames.EU07_092,
    LocomotiveNames.EU07_241,
    LocomotiveNames.EU07_005,
    LocomotiveNames.EU07_085,
    LocomotiveNames.EU07_092,
    LocomotiveNames.CD163_021_9,
    LocomotiveNames.CD163_029_2,
    LocomotiveNames.CD163_030_0,
    LocomotiveNames.CD163_040_9,
    LocomotiveNames.CD163_041_7,
    LocomotiveNames.CD163_042_5,
    LocomotiveNames.EU43_003,
    LocomotiveNames.E186_134,
    LocomotiveNames.E186_930,
}
local FreightLocos = {
    LocomotiveNames.E6ACTa_014,
    LocomotiveNames.E6ACTa_016,
    LocomotiveNames.E6ACTadb_027,
    LocomotiveNames.ET22_243,
    LocomotiveNames.ET22_256,
    LocomotiveNames.ET22_644,
    LocomotiveNames.ET22_836,
    LocomotiveNames.ET22_911,
    LocomotiveNames.ET22_1163,
    LocomotiveNames.ET25_002,
    LocomotiveNames.EU07_068,
    LocomotiveNames.EU07_070,
    LocomotiveNames.EU07_096,
    LocomotiveNames.EU07_153,
    LocomotiveNames.EU07_193,
    LocomotiveNames.EU07_241,
    --LocomotiveNames.CD163_021_9,
    --LocomotiveNames.CD163_040_9,
    --LocomotiveNames.CD163_042_5,
    LocomotiveNames.CD163_034_2,
    LocomotiveNames.CD163_035_9,
    LocomotiveNames.CD163_043_3,
    LocomotiveNames.CD163_045_8,
    LocomotiveNames.CD163_046_6,
    LocomotiveNames.EU43_002,
    LocomotiveNames.EU43_004,
    LocomotiveNames.EU43_005,
    LocomotiveNames.E186_133,
    LocomotiveNames.E186_138,
    LocomotiveNames.E186_139,
    LocomotiveNames.E186_242,
    LocomotiveNames.E186_245,
    LocomotiveNames.E186_246,
    LocomotiveNames.E186_248,
    LocomotiveNames.E186_250,
    LocomotiveNames.E186_928,
    LocomotiveNames.E186_929,
    LocomotiveNames.E186_941,
    LocomotiveNames.E186_942,
}

local PassOldCarts1 = {
    PassengerWagonNames.Adnu_5051_1900_189_7,
    PassengerWagonNames.Adnu_5051_1908_095_8_,
}
local PassOldPaintedCarts1 = {
    PassengerWagonNames.A9ou_5051_1908_136_0,
    PassengerWagonNames.A9ou_5151_1970_003_4,
}
local PassNewCarts1 = {
    PassengerWagonNames.A9mnouz_6151_1970_214_5,
    PassengerWagonNames.A9mnouz_6151_1970_234_3
}
local PassOldCarts2 = {
    PassengerWagonNames.B10ou_5051_2000_608_3,
    PassengerWagonNames.B10nou_5051_2008_607_7,
}
local PassOldPaintedCarts2 = {
    PassengerWagonNames.B10ou_5151_2070_829_9,
    PassengerWagonNames.B10nouz_5151_2071_102_0,
}
local PassNewCarts2 = {
    PassengerWagonNames.B10bmnouz_6151_2071_105_1,
    PassengerWagonNames.B11gmnouz_6151_2170_107_7,
    PassengerWagonNames.B11bmnouz_6151_2170_064_0,
    PassengerWagonNames.B11bmnouz_6151_2170_098_8
}
local PassNewCartsRestaurant = {
    PassengerWagonNames.WRmnouz_6151_8870_191_1
}
local Pendos = {
    LocomotiveNames.ED250_001,
    LocomotiveNames.ED250_009,
    LocomotiveNames.ED250_015,
    LocomotiveNames.ED250_018
}

local FreightCarts = {
    {
        -- węglarki klasyczne
        FreightWagonNames.EAOS_3151_5349_475_9,
        FreightWagonNames.EAOS_3151_5351_989_9,
    },
    {
        -- węglarki nietuzinkowe
        FreightWagonNames.EAOS_3351_5356_394_5,
        FreightWagonNames.EAOS_3356_5300_118_0,
        FreightWagonNames.EAOS_3356_5300_177_6
    },
    {
        -- nowe węglarki
        FreightWagonNames._441V_31516635283_3,
        FreightWagonNames._441V_31516635512_5
    },
    {
        -- platformy
        FreightWagonNames.SGS_3151_3944_773_6,
        FreightWagonNames.SGS_3151_3947_512_5
    },
    {
        -- beczki bez czerwonych
        FreightWagonNames.Zaes_3351_0079_375_1,
        FreightWagonNames.Zaes_3351_7881_520_5,
        FreightWagonNames.Zaes_3351_7980_031_3,
        FreightWagonNames.Zaes_3351_7982_861_1,
    },
    {
        -- beczki bez niebieskich
        FreightWagonNames.Zaes_3351_7980_031_3,
        FreightWagonNames.Zaes_3351_7982_861_1,
        FreightWagonNames.Zaes_3451_7981_215_0,
        FreightWagonNames.Zas_8451_7862_699_8
    },
    {
        -- gruszki
        FreightWagonNames.UACS_3351_9307_587_6
    },
    {
        -- Sgnsy
        FreightWagonNames._230_01_31514508558_7
    },
    {
        -- Sgnsy
        FreightWagonNames._434Z_31514553133_5,
        FreightWagonNames._434Z_33514565217_8
    },
    {
        -- Sgnsy
        FreightWagonNames._629Z_21514960133_0
    }
}


---
local weights = {1, 1, 1}
local decay = 0.5
local recovery = 0.05
local minWeight = 0.2
local maxWeight = 1.0
local callCount = 0
local function WeightedRandomRange(typeLow, typeHigh)
    local total = 0
    for i = typeLow, typeHigh do
        total = total + weights[i + 1]
    end

    local r = math.random() * total
    local cum = 0

    for i = typeLow, typeHigh do
        cum = cum + weights[i + 1]
        if r <= cum then
            return i
        end
    end
end
local function PrintWeights()
    local msg = "Wagi: "
    for i, w in ipairs(weights) do
        msg = msg .. string.format("[%d]=%.2f ", i - 1, w)
    end
    Log(msg)
end
local function RecoverWeights()
    PrintWeights()
    for i = 1, #weights do
        if weights[i] < maxWeight then
            weights[i] = math.min(maxWeight, weights[i] + recovery)
        end
    end
end
local function NormalizeWeights()
    local total = 0
    for _, w in ipairs(weights) do total = total + w end
    for i = 1, #weights do weights[i] = weights[i] / total end
end

---

local function GetRandomObj(table)
    if #table == 0 then
        return ""
    end
    local rnd = GetRandomInt(1, #table + 1)
    local ret = table[rnd]
    return ret
end

local function GetCartContent(wagonType)
    if wagonType == 1 or wagonType == 2 or wagonType == 3 then
        local cargo = GetRandomInt(0, 5)
        if cargo == 0 then return {FreightLoads_412W_v4.Ballast }
        elseif cargo == 1 then return {FreightLoads_412W_v4.Coal}
        elseif cargo == 2 then return {FreightLoads_412W_v4.Sand}
        elseif cargo == 3 then return {FreightLoads_412W_v4.WoodLogs}
        else return {}
        end

    elseif wagonType == 4 then
        local cargo = GetRandomInt(0, 11)
        if cargo == 0 then return {FreightLoads_412W.Concrete_slab }
        elseif cargo == 1 then return {FreightLoads_412W.Gas_pipeline}
        elseif cargo == 2 then return {FreightLoads_412W.Pipeline}
        elseif cargo == 3 then return {FreightLoads_412W.Sheet_metal}
        elseif cargo == 4 then return {FreightLoads_412W.Steel_circle}
        elseif cargo == 5 then return {FreightLoads_412W.T_beam}
        elseif cargo == 6 then return {FreightLoads_412W.Tie}
        elseif cargo == 7 then return {FreightLoads_412W.Tree_trunk}
        elseif cargo == 8 then return {FreightLoads_412W.Wooden_beam}
        elseif cargo == 9 then return {FreightLoads_412W.Sheet_metal, FreightLoads_412W.Steel_circle}
        else return {}
        end

    elseif wagonType == 5 or wagonType == 6 then
        local cargo = GetRandomInt(0, 5)
        if cargo == 0 then return {FreightLoads_406Ra.Crude_Oil }
        elseif cargo == 1 then return {FreightLoads_406Ra.Ethanol}
        elseif cargo == 2 then return {FreightLoads_406Ra.Heating_Oil}
        elseif cargo == 3 then return {FreightLoads_406Ra.Petrol}
        else return {}
        end
        return {FreightLoads_406Ra[cargo]}
    elseif wagonType == 8 or wagonType == 9 or wagonType == 10 then
        return {FreightLoads_412W.RandomContainerAll}
    else 
        return {}
    end
end

local function CreateCartList(list, count)
    local output = {}
    if(count > 0) then
        for i = 1, count do
            table.insert(output, CreateVehicle(GetRandomObj(list)))
        end
    end
    return output
end

local function Reverse(tab)
    
    if(#tab > 0) then
        for i = 1, math.floor(#tab/2), 1 do
            tab[i], tab[#tab-i+1] = tab[#tab-i+1], tab[i]
        end
    end
    return tab
end

local function GetSemiRandomEzt(subtype, loc)
    if subtype == Types.EN57 then 
        if(loc == Loc.Warszawa) then return GetRandomObj(EN57_KM)
        elseif(loc == Loc.Lodz) then return GetRandomObj(EN57_LKA)
        else return GetRandomObj(EN57) end
        
    elseif subtype == Types.EN71 then return GetRandomObj(EN71)
    elseif subtype == Types.Elf then
        if(loc == Loc.Warszawa) then return GetRandomObj(EN76_KM)
        elseif(loc == Loc.Katowice) then return GetRandomObj(EN76_KS)
        elseif(loc == Loc.Lodz) then return GetRandomObj(WE36_LKA)
        else return GetRandomObj(EN96) end
    end
end

local function GetEztQuantity(subtype, loc) 
    local rnd = GetRandomInt(0, 20)
    if rnd == 0 then 
        if subtype == Types.EN57 and loc == Loc.Warszawa then
            return 3
        end
        return 2
    elseif rnd < 13 then return 2
    else return 1
    end
end

local function GetPassengerCartsQuantity(isIc)
    -- local standaloneLoco = GetRandomInt(0, 100)
    -- if standaloneLoco == 0 then
    --     return 0
    -- end
    if isIc then
        return GetRandomInt(3, 12)
    else
        return GetRandomInt(2, 9)
    end
    
end

local function GetEztType(loc) 
    if loc == Loc.Lodz then
        local rnd = GetRandomInt(0, 10)
        if rnd < 3 then return Types.EN57
        elseif rnd < 5 then return Types.EN71
        else return Types.Elf
        end
    else
        local rnd = GetRandomInt(0, 10)
        if rnd < 5 then return Types.EN57
        elseif rnd < 7 then return Types.EN71
        else return Types.Elf
        end
    end

end

local function GetRestaurantCarts(quantity)
    if quantity < 4 then
        return 0
    elseif quantity < 8 then
        local rnd = GetRandomInt(0, 2)
        if rnd == 0 then return 0
        else return 1
        end
    else
        return 1
    end
    
end



---@return table<SpawnVehicleDescription> trainset
local function CreateRandomTrainset(loc, typeLow, typeHigh)
    local trainset = {}
    RecoverWeights()
    local type = WeightedRandomRange(typeLow, typeHigh)
    weights[type + 1] = math.max(minWeight, weights[type + 1] * decay)

    callCount = callCount + 1
    if callCount % 10 == 0 then
        NormalizeWeights()
    end

    if(type == 0) then
        --ezt
        local subtype = GetEztType(loc)
        local quantity = GetEztQuantity(subtype, loc)
        Log("S: ezt [" .. subtype .. "] * " .. quantity)
        for i = 1, quantity do
            table.insert(trainset, CreateVehicle(GetSemiRandomEzt(subtype, loc)))
        end

    elseif type == 1 then 
        --pass train
        local subtype = GetRandomInt(0, 2)
        local order = GetRandomInt(0, 2)
        if subtype == 0 then
            --slow, old            
            local quantity = GetPassengerCartsQuantity(false)
            local secondClass = GetRandomInt(math.ceil(quantity / 2), quantity)
            local firstClass = quantity - secondClass
            Log("S: pass [" .. subtype .. "], quant: " .. quantity .. " [I*" .. firstClass .. ", II*" .. secondClass .. "]")
            local colors = GetRandomInt(0, 2)
            if colors == 0 then
                --red-green
                trainset = ConcatArray(trainset, CreateCartList(PassOldCarts1, firstClass))
                trainset = ConcatArray(trainset, CreateCartList(PassOldCarts2, secondClass))
            else
                --blue
                trainset = ConcatArray(trainset, CreateCartList(PassOldPaintedCarts1, firstClass))
                trainset = ConcatArray(trainset, CreateCartList(PassOldPaintedCarts2, secondClass))
            end

            trainset = order == 0 and trainset or Reverse(trainset)
            table.insert(trainset, 1, CreateVehicle(GetRandomObj(PassengerSlowLocos)))
        else
            --fast, new
            local quantity = GetPassengerCartsQuantity(true)
            local restaurantCarts = GetRestaurantCarts(quantity)
            local secondClass = GetRandomInt(math.ceil(quantity / 2), quantity - restaurantCarts)
            local firstClass = quantity - secondClass - restaurantCarts

            Log("S: pass [" .. subtype .. "], quant: " .. quantity .. " [I*" .. firstClass .. ", II*" .. secondClass .. ", R*" .. restaurantCarts .. "]")
            local age = GetRandomInt(0, 2)
            if age == 0 then
                --new
                trainset = ConcatArray(trainset, CreateCartList(PassNewCarts1, firstClass))
                trainset = ConcatArray(trainset, CreateCartList(PassNewCartsRestaurant, restaurantCarts))
                trainset = ConcatArray(trainset, CreateCartList(PassNewCarts2, secondClass))
            else
                --old
                trainset = ConcatArray(trainset, CreateCartList(PassOldPaintedCarts1, firstClass))
                trainset = ConcatArray(trainset, CreateCartList(PassOldPaintedCarts2, secondClass))
            end
            
            trainset = order == 0 and trainset or Reverse(trainset)
            table.insert(trainset, 1, CreateVehicle(GetRandomObj(PassengerFastLocos)))
        end
    elseif type == 2 then 
        --freight train
        local specialCases = GetRandomInt(0, 100)
        if specialCases == 1 then
            --locos 
            local quantity = GetRandomInt(1, 6)
            Log("S: cargo special: ".. quantity .. " locos")
            for i = 1, quantity do
                table.insert(trainset, CreateVehicle(GetRandomObj(ConcatArray(PassengerFastLocos, ConcatArray(PassengerSlowLocos, FreightLocos)))))
            end
        elseif specialCases == 2 then
            --loco+ezt
            Log("S: cargo special: ezt")
            table.insert(trainset, CreateVehicle(GetRandomObj(ConcatArray(EN57, ConcatArray(EN71, ConcatArray(EN96, RegionSpecificEzt))))))
        elseif specialCases < 4 then
            --just loco
            Log("S: cargo special: solo loco")
        else
            local subtype = GetRandomInt(1, #FreightCarts + 1)
            local quantity = GetRandomInt(15, 25)
            if(subtype == 10 and quantity > 19) then quantity = 19 end

            local cartContent = GetCartContent(subtype)
            for i = 1, quantity do
                table.insert(trainset, CreateCargoVehicle(GetRandomObj(FreightCarts[subtype]), GetRandomObj(cartContent)))
            end
            local extraFrontLoc = GetRandomInt(0, 30)
            local extraBackLoc = GetRandomInt(0, 30)
            if extraFrontLoc == 0 then
                table.insert(trainset, 1, CreateVehicle(GetRandomObj(FreightLocos)))
            end
            if extraBackLoc == 0 then
                table.insert(trainset, CreateVehicle(GetRandomObj(FreightLocos)))
            end
            Log("S: cargo [" .. subtype .. "] * " .. quantity .. "; extra front [" .. extraFrontLoc .. "] back [" .. extraBackLoc .. "]")
        end
       
        table.insert(trainset, 1, CreateVehicle(GetRandomObj(FreightLocos)))
    end

    return trainset
end


---------
function CreateCargoVehicle(veh, cargo)
    return CreateNewSpawnFullVehicleDescriptor(veh, false, cargo, 10, BrakeRegime.P)
end

function CreateVehicle(veh)
    return CreateNewSpawnFullVehicleDescriptor(veh, false, "", 0, BrakeRegime.P)
end

function CreateRandomTrain(loc)
    return CreateRandomTrainset(loc, 0, 2)
end

function CreateRandomEzt(loc)
    return CreateRandomTrainset(loc, 0, 0)
end

function CreateRandomPassengerWagonTrain(loc)
    return CreateRandomTrainset(loc, 1, 1)
end

function CreateRandomPassengerTrain(loc)
    return CreateRandomTrainset(loc, 0, 1)
end

function CreateRandomCargoTrain(loc)
    return CreateRandomTrainset(loc, 2, 2)
end

function CreateRandomWagonTrain(loc)
    return CreateRandomTrainset(loc, 1, 2)
end

function CreateRandomLoc()
    Log("S: Lok")
    return {CreateVehicle(GetRandomObj(ConcatArray(PassengerFastLocos, ConcatArray(PassengerSlowLocos, FreightLocos))))}
end

function CreateRandomPendolino()
    Log("S: Pendo")
    return {CreateVehicle(GetRandomObj(Pendos))}
end

function CreateRandomFreighCartsQuant(lowQuant, highQuant)
    local trainset = {}
    local subtype = GetRandomInt(1, #FreightCarts + 1)
    local quantity = GetRandomInt(lowQuant, highQuant)
    Log("S: Carts [" .. subtype .. "] * " .. quantity)

    for i = 1, quantity do
        table.insert(trainset, CreateCargoVehicle(GetRandomObj(FreightCarts[subtype]), ""))
    end
    return trainset
end

function CreateRandomFreighCarts()
    return CreateRandomFreighCartsQuant(10, 20)
end

function CreateRandomPassengerCartsQuant(lowQuant, highQuant)
    local subtype = GetRandomInt(1, 7)
    local quantity = GetRandomInt(lowQuant, highQuant)
    Log("S: PCarts [" .. subtype .. "] * " .. quantity)
    if subtype == 1 then return CreateCartList(PassOldCarts1, quantity) 
    elseif subtype == 2 then return CreateCartList(PassOldPaintedCarts1, quantity) 
    elseif subtype == 3 then return CreateCartList(PassNewCarts1, quantity) 
    elseif subtype == 4 then return CreateCartList(PassOldCarts2, quantity) 
    elseif subtype == 5 then return CreateCartList(PassOldPaintedCarts2, quantity) 
    elseif subtype == 6 then return CreateCartList(PassNewCarts2, quantity) 
    end
    return CreateCartList(PassOldCarts1, quantity)
end

function CreateRandomPassengerCarts()
    return CreateRandomPassengerCartsQuant(3, 8)
end

function NonEssential(fn)
    if not UseReducedAI() then
        fn()
    end
end