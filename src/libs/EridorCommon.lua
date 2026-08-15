-- Eridor's common package v1.8
-- Last edit: 08.08.2026

-- procs

require("libs/internal/Procedures")

function CreateRoute(startSignalName, endSignalName, OrderType)
    local request = VDSetRouteWithRepeat(startSignalName, endSignalName, OrderType, 60, 10)
    coroutine.yield(CoroutineYields.WaitForVDRouteResponded, request)
end

function CreateRouteVariant(startSignalName, endSignalName, OrderType, Variant)
    local request = VDSetRouteWithVariantAndRepeat(startSignalName, endSignalName, OrderType, Variant, 60, 10)
    coroutine.yield(CoroutineYields.WaitForVDRouteResponded, request)
end


function Halt(trainset)
    CreateCoroutine(function()
        coroutine.yield(CoroutineYields.WaitForSeconds, 1)
        AddBotCommand(trainset, CreateMediumBotCommand(BotCommandType.bcStop, "Stop", 0, 0, false, false, true))
    end)
end

function Proceed(trainset)
    CreateCoroutine(function()
        coroutine.yield(CoroutineYields.WaitForSeconds, 1)
        AddBotCommand(trainset, CreateMediumBotCommand(BotCommandType.bcDrive, "Go", 0, 0, false, false, true))
    end)
end

function SetVelocity(trainset, vel)
    for i = 1, #trainset.Vehicles, 1 do
        trainset.Vehicles[i].vel = vel
    end
end

---@return number
local function GetRadioVolume(type)
    if type == nil then
        return 1
    else
        return 0.2
    end
end

function Comms(caller, text)
    if caller == nil then
        DisplayMessage("#" .. text, 10)
        DisplayChatText("#" .. text)
    elseif caller == false then
        DisplayChatText("#" .. text)
    else
        DisplayCommunicationChatText(caller, GetIsTranslated(caller), GetColor(caller), "#" .. text)
    end

    if(Sounds[text]) then
        local radioType = GetRadioVariant(caller)
        local radioVolume = GetRadioVolume(radioType)
        PlayNarrationAudioClip(text, radioVolume, radioType)
        coroutine.yield(CoroutineYields.WaitForAudioFinishedPlaying, text)
        coroutine.yield(CoroutineYields.WaitForSeconds, 1)
    else
        coroutine.yield(CoroutineYields.WaitForSeconds, 3)
    end
end

function CommsLocal(caller, text)
    if caller == nil then
        DisplayMessage(text, 10)
        DisplayChatText(text)
    elseif caller == false then
        DisplayChatText(text)
    else
        DisplayCommunicationChatText(caller, GetIsTranslated(caller), GetColor(caller), text)
    end

    if(Sounds[text]) then
        local radioType = GetRadioVariant(caller)
        local radioVolume = GetRadioVolume(radioType)
        PlayNarrationAudioClip(text, radioVolume, radioType)
        coroutine.yield(CoroutineYields.WaitForAudioFinishedPlaying, text)
        coroutine.yield(CoroutineYields.WaitForSeconds, 1)
    else
        coroutine.yield(CoroutineYields.WaitForSeconds, 3)
    end
end

-- funcs
---@return RadioFilterVariant|nil
function GetRadioVariant(caller)
    if caller == "#Caller_You" then return nil
    elseif caller == nil then return nil
    elseif caller == false then return nil
    else 
        local rnd = GetRandomInt(0,3)
        if rnd == 0 then return RadioFilterVariant.GenericFilter1
        --elseif rnd == 1 then return RadioFilterVariant.GenericFilter2
        --elseif rnd == 2 then return RadioFilterVariant.GenericFilter3
        else return RadioFilterVariant.GenericFilter1
        end
    end
end

---@return Color
function GetColor(caller)
    if caller == "#Caller_You" then return ColorCreateHex("#8fce00")    -- lime
    elseif caller == "#Caller_Shunter" then return ColorCreateHex("#FFFF00")    -- yellow
    elseif caller == "#Caller_Auditor" then return ColorCreateHex("#FFFF00")    -- yellow
    elseif caller == "#Caller_Conductor" then return ColorCreateHex("#009619")   -- green
    elseif IsmatchRegex(caller, "^[0-9]*$") then return ColorCreateHex("#9370DB") -- train, violet
    elseif string.len(caller) < 4 then return ColorCreateHex("#FFA500") -- dispo, orange
    else return ColorCreateHex("#C0C0C0")   -- gray
    end
end

---@return boolean
function GetIsTranslated(caller)
    if caller == "#Caller_You" then return true
    elseif caller == "#Caller_Shunter" then return true
    elseif caller == "#Caller_Auditor" then return true
    elseif caller == "#Caller_Conductor" then return true
    else return false
    end
end

---@return boolean
function IsmatchRegex(txt, regex)
    local out = string.match(txt, regex)
    return out ~= nil
end

function UnconditialCheck(e)
    return true
end

function PlayerTrainsetCheck(e)
    return e == RailstockGetPlayerTrainset()
end

function OnVirtualDispatcherResponseReceived(ordered_id, status)
    --Log("VD response to order ID " .. ordered_id .. " => " .. status)
end

function DelayedZewNotification()
    CreateCoroutine(function ()
        coroutine.yield(CoroutineYields.WaitForSeconds, 10)
        if(ScenarioStep ~= 0) then
            ShowUseRadioNotification()
        end
    end)
end

function ExecuteEnvironment(environmentSettings, season, weather, cold)
    local setting = environmentSettings[season]
    if setting then
        local year, month, day, hour, min = table.unpack(setting.date)
        ScenarioStartDateTime = DateTimeCreate(year, month, day, hour, min, 0)
        SetStartDateTime(ScenarioStartDateTime)
        SetDateTime(AlterDateForLocoStartup(ScenarioStartDateTime, cold))
        StartWeather(weather, season)
        AutoPassengerMultiplier()
    else
        Error("Weather/environment setup not found")
    end
end

---@return DateTime
function AlterDateForLocoStartup(dt, isCold)
    if isCold == LocState.Cold10 then
        return dt.AddMinutes(-10)
    elseif isCold == LocState.Cold5 then
        return dt.AddMinutes(-5)
    else
        return dt
    end
end

---@return string
function MsgBox_Train(options)
    local select = ""
    ShowDropdownMessageBox(
        "#Choose_your_train_Descripted", 
        options, 
        {
            ["OnConfirm"] = function (s, i)
                Log("confirm" .. s .. ", index " .. i)
                select = s
            end,
            ["OnSelect"] = function () end,
            ["ConfirmationText"] = "#Confirm_btn"
        }
    )
    coroutine.yield(CoroutineYields.WaitUntil, function ()
        return select ~= ""
    end)
    return select
end

---@return string
function MsgBox_Cargo(options)
    local select = ""
    ShowDropdownMessageBox(
        "#Choose_your_cargo", 
        options, 
        {
            ["OnConfirm"] = function (s, i)
                Log("confirm" .. s .. ", index " .. i)
                select = s
            end,
            ["OnSelect"] = function () end,
            ["ConfirmationText"] = "#Confirm_btn"
        }
    )
    coroutine.yield(CoroutineYields.WaitUntil, function ()
        return select ~= ""
    end)
    return select
end

---@return string
function MsgBox_Season()
    local select = ""
    ShowDropdownMessageBox(
        "#Choose_season", 
        {"#Summer", "#Autumn", "#Winter", "#Spring"},
        {
            ["OnConfirm"] = function (s, i)
                Log("confirm" .. s .. ", index " .. i)
                select = s
            end,
            ["OnSelect"] = function () end,
            ["ConfirmationText"] = "#Confirm_btn"
        }
    )
    coroutine.yield(CoroutineYields.WaitUntil, function ()
        return select ~= ""
    end)
    return select
end

---@return integer
function MsgBox_Weather(Season)
    local select = 0

    local options = {}
    if Season == "#Winter" then
        options = {"#Sunny", "#Foggy", "#Snowy"}
    else
        options = {"#Sunny", "#Foggy", "#Rainy", "#Thunderstormy"}
    end

    ShowDropdownMessageBox(
        "#M_Weather", options,
        {
            ["OnConfirm"] = function (s, i)
                Log("confirm" .. s .. ", index " .. i)
                if s == "#Sunny" then select = WeatherEnum.Sunny
                elseif s == "#Foggy" then select = WeatherEnum.Fogy
                elseif s == "#Snowy" then select = WeatherEnum.Snowy
                elseif s == "#Rainy" then select = WeatherEnum.Rainy
                elseif s == "#Thunderstormy" then select = WeatherEnum.Thunder
                else Error("Invalid weather code")
                end
            end,
            ["OnSelect"] = function () end,
            ["ConfirmationText"] = "#Confirm_btn"
        }
    )
    coroutine.yield(CoroutineYields.WaitUntil, function ()
        return select ~= 0
    end)
    return select
end

---@return number
function MsgBox_Hour(default)
    local select = -1
    ShowDropdownMessageBox(
        "#Choose_start_hour", 
        {
            "#Choose_start_hour_default", 
            "M_0", "M_1", "M_2", "M_3", "M_4", "M_5", "M_6", "M_7", "M_8", "M_9", "M_10", "M_11", "M_12", 
            "M_13", "M_14", "M_15", "M_16", "M_17", "M_18", "M_19", "M_20", "M_21", "M_22", "M_23"},
        {
            ["OnConfirm"] = function (s, i)
                if s == "#Choose_start_hour_default" then
                    select = default
                else
                    select = tonumber(string.match(s, "M_(%d+)"))
                end
                Log("confirm" .. s .. ", index " .. i)
            end,
            ["OnSelect"] = function () end,
            ["ConfirmationText"] = "#Confirm_btn"
        }
    )
    coroutine.yield(CoroutineYields.WaitUntil, function ()
        return select ~= -1
    end)
    return select
end

---@return LocState state
function MsgBox_IsCold()
    local select = false
    local isCold = LocState.Hot
    ShowMessageBox("#Cold_or_hot_start", 
        {
            ["Text"] = "#Train_ready",
            ["OnClick"] = function()
                isCold = LocState.Hot
                select = true
            end,
        }, {
            ["Text"] = "#Train_cold_plus_5_min",
            ["OnClick"] = function()
                isCold = LocState.Cold5
                select = true
            end,
        }, {
            ["Text"] = "#Train_cold_plus_10_min",
            ["OnClick"] = function()
                isCold = LocState.Cold10
                select = true
            end,
        }
    )
    coroutine.yield(CoroutineYields.WaitUntil, function ()
        return select
    end)
    return isCold
end

---@enum LocState
LocState = {
    Hot = 1,
    Cold5 = 2,
    Cold10 = 3
}

local MultiplierTable = {
    [0] = 0.25,
    [1] = 0.10,
    [2] = 0.10,
    [3] = 0.25,
    [4] = 0.50,
    [5] = 1.00,
    [6] = 2.00,
    [7] = 4.00,
    [8] = 3.00,
    [9] = 2.00,
    [10] = 1.50,
    [11] = 1.25,
    [12] = 1.00,
    [13] = 1.50,
    [14] = 2.00,
    [15] = 3.00,
    [16] = 3.50,
    [17] = 3.50,
    [18] = 3.00,
    [19] = 2.50,
    [20] = 2.00,
    [21] = 1.50,
    [22] = 1.00,
    [23] = 0.50
}


function AutoPassengerMultiplier()
    CreateCoroutine(function ()
        while true do
            local dt = GetDateTime()
            Log("Set passengers to x"..MultiplierTable[dt.Hour])
            SetPassengersAtPlatformMultiplier(MultiplierTable[dt.Hour])
            coroutine.yield(CoroutineYields.WaitForSeconds, 600)
        end
    end)
end


function ConcatArray(a, b)
    local data = {}
    for k,v in pairs(a) do
        data[k] = v
    end
    
    if(#b > 0) then
        for i = 1, #b do
            table.insert(data, b[i])
        end
    end
    return data
  end