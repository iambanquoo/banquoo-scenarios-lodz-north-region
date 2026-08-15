-- Eridor's common package v1.8
-- Last edit: 08.08.2026

---@param prefix string
function Do_SimplyfiedBreakTest(prefix)
    Comms("#Caller_Auditor", prefix .. "_CheckBrakes1")
    if(RailstockGetPlayerVehicle().controller.brakePipePressure < 4.7) then
        Comms("#Caller_Auditor", prefix .. "_CheckBrakes2")
        coroutine.yield(CoroutineYields.WaitUntil, function ()
            return RailstockGetPlayerVehicle().controller.brakePipePressure > 4.9
        end)
        coroutine.yield(CoroutineYields.WaitForSeconds, 0.5 * #RailstockGetPlayerTrainset().Vehicles)
    end

    Comms("#Caller_Auditor", prefix .. "_CheckBrakes3")
    coroutine.yield(CoroutineYields.WaitUntil, function ()
        return RailstockGetPlayerVehicle().controller.brakePipePressure < 4.7
    end) 
    coroutine.yield(CoroutineYields.WaitForSeconds, GetRandomInt(5,10) + 0.5 * #RailstockGetPlayerTrainset().Vehicles)
    Comms("#Caller_Auditor", prefix .. "_CheckBrakes4")
    coroutine.yield(CoroutineYields.WaitUntil, function ()
        return RailstockGetPlayerVehicle().controller.brakePipePressure > 4.9
    end)
    coroutine.yield(CoroutineYields.WaitForSeconds, GetRandomInt(5,10) + 0.5 * #RailstockGetPlayerTrainset().Vehicles)
    Comms("#Caller_Auditor", prefix .. "_CheckBrakes5")
end

---@param prefix string
function Do_SimplyfiedBreakTest_Local(prefix)
    CommsLocal("#Caller_Auditor", prefix .. "_CheckBrakes1")
    if(RailstockGetPlayerVehicle().controller.brakePipePressure < 4.7) then
        CommsLocal("#Caller_Auditor", prefix .. "_CheckBrakes2")
        coroutine.yield(CoroutineYields.WaitUntil, function ()
            return RailstockGetPlayerVehicle().controller.brakePipePressure > 4.9
        end)
        coroutine.yield(CoroutineYields.WaitForSeconds, 0.5 * #RailstockGetPlayerTrainset().Vehicles)
    end

    CommsLocal("#Caller_Auditor", prefix .. "_CheckBrakes3")
    coroutine.yield(CoroutineYields.WaitUntil, function ()
        return RailstockGetPlayerVehicle().controller.brakePipePressure < 4.7
    end) 
    coroutine.yield(CoroutineYields.WaitForSeconds, GetRandomInt(5,10) + 0.5 * #RailstockGetPlayerTrainset().Vehicles)
    CommsLocal("#Caller_Auditor", prefix .. "_CheckBrakes4")
    coroutine.yield(CoroutineYields.WaitUntil, function ()
        return RailstockGetPlayerVehicle().controller.brakePipePressure > 4.9
    end)
    coroutine.yield(CoroutineYields.WaitForSeconds, GetRandomInt(5,10) + 0.5 * #RailstockGetPlayerTrainset().Vehicles)
    CommsLocal("#Caller_Auditor", prefix .. "_CheckBrakes5")
end

local function AltIsEzt(trainset)
    if #trainset.Vehicles < 4 and (trainset.trainsetLenght / #trainset.Vehicles > 40) then
        Log("Ezt detected (alt)")
        return true
    end
    Log("Ezt not detected (alt)")
    return false
end

function IsEztTrainset(trainset)
    local eztNameList = {"34WE", "EN57", "EN71", "ED250"}

    local set = {}
    for _, tag in ipairs(eztNameList) do
        set[tag] = true
    end

    for _, obj in ipairs(trainset.Vehicles) do
        if obj.tag == "Untagged" then
            return AltIsEzt(trainset)
        end
    end

    for _, obj in ipairs(trainset.Vehicles) do
        if not set[obj.tag] then
            Log("Ezt not detected")
            return false
        end
    end
    Log("Ezt detected")
    return true
end

function CanChangeDir(trainset)
    return IsEztTrainset(trainset)
end


---@param departureTimeSec number
---@param scenarioStartDateTime DateTime
---@param skipOffsetTimeSpan TimeSpan|nil
function TimeSkip(departureTimeSec, scenarioStartDateTime, skipOffsetTimeSpan)
    local currentTime = GetDateTime()
    local departureTime = scenarioStartDateTime + TimeSpanCreate(0,0,0,departureTimeSec,0)
    skipOffsetTimeSpan = skipOffsetTimeSpan or TimeSpanCreate(0,0,1,0,0)

    if departureTime - currentTime > skipOffsetTimeSpan then
        CreateCoroutine(function ()
            BlackoutScreen(true)
            coroutine.yield(CoroutineYields.WaitForSeconds, 0.5)
            SetDateTime(departureTime - skipOffsetTimeSpan)
            coroutine.yield(CoroutineYields.WaitForSeconds, 0.5)
            BlackoutScreen(false)
        end)
    end
end