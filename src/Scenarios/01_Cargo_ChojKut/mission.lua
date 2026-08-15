-- SimRail - The Railway Simulator
-- LUA Scripting scenario
-- Version: 1.0
--
require("SimRailCore")
require("../../libs/EridorCommon")
require("../../libs/EridorTrains")
require("../../libs/EridorWeather")
require("Trainsets")

--DeveloperMode = function() return true end
StartPosition = {21375.32, 203.19, 165028.70}
Sounds = {
    ['StaticNoise'] = {
        [Languages.Polish]  = "../../../Sounds/radio-static.mp3",
        [Languages.English] = "../../../Sounds/radio-static.mp3"
    },
    ['Welcome'] = {
        [Languages.Polish]  = "pl/Welcome.mp3",
        [Languages.English] = "en/Welcome.mp3"
    },
    ['LCH_Start_1'] = {
        [Languages.Polish]  = "pl/LCH_Start_1.mp3",
        [Languages.English] = "en/LCH_Start_1.mp3"
    },
    ['LCH_Start_2'] = {
        [Languages.Polish]  = "pl/LCH_Start_2.mp3",
        [Languages.English] = "en/LCH_Start_2.mp3"
    },
    ['LZ_Proba_1'] = {
        [Languages.Polish]  = "pl/LZ_Proba_1.mp3",
        [Languages.English] = "en/LZ_Proba_1.mp3"
    },
    ['LZ_Proba_2'] = {
        [Languages.Polish]  = "pl/LZ_Proba_2.mp3",
        [Languages.English] = "en/LZ_Proba_2.mp3"
    },
    ['LZ_Proba_3'] = {
        [Languages.Polish]  = "pl/LZ_Proba_3.mp3",
        [Languages.English] = "en/LZ_Proba_3.mp3"
    },
    ['Zg_Proba_1'] = {
        [Languages.Polish]  = "pl/Zg_Proba_1.mp3",
        [Languages.English] = "en/Zg_Proba_1.mp3"
    },
    ['Zg_Proba_2'] = {
        [Languages.Polish]  = "pl/Zg_Proba_2.mp3",
        [Languages.English] = "en/Zg_Proba_2.mp3"
    },
    ['Zg_Proba_3'] = {
        [Languages.Polish]  = "pl/Zg_Proba_3.mp3",
        [Languages.English] = "en/Zg_Proba_3.mp3"
    },
    ['Le_Postoj_1'] = {
        [Languages.Polish]  = "pl/Le_Postoj_1.mp3",
        [Languages.English] = "en/Le_Postoj_1.mp3"
    },
    ['Le_Postoj_2'] = {
        [Languages.Polish]  = "pl/Le_Postoj_2.mp3",
        [Languages.English] = "en/Le_Postoj_2.mp3"
    },
    ['Le_Postoj_3'] = {
        [Languages.Polish]  = "pl/Le_Postoj_3.mp3",
        [Languages.English] = "en/Le_Postoj_3.mp3"
    },
    ['Le_Postoj_4'] = {
        [Languages.Polish]  = "pl/Le_Postoj_4.mp3",
        [Languages.English] = "en/Le_Postoj_4.mp3"
    },
}

VDLoaded = false
ScenarioStep = "Start"

function PrepareScenario() end

function EarlyScenarioStart()
    CameraSetEulerRotation(Vector3Create(0.26, 279.85, 0.00))
    SetCameraView(CameraView.FirstPersonWalkingOutside)
    StartRecorder()
    Triggers()
    Ai()
end

function StartScenario()
    CreateCoroutine(function() 
        Loco = MsgBox_Train({"M_E6ACTa", "M_ET22", "M_E186", "M_EU07x2", "M_CD163", "M_EU07", "M_Ty2"})
        Cargo = MsgBox_Cargo({"M_Easy_Sggrss", "M_Med_Sggrss", "M_Hard_Sggrss", "M_Easy_Sgns", "M_Med_Sgns", "M_Hard_Sgns", "M_Easy_Sgmmns", "M_Med_Sgmmns", "M_Hard_Sgmmns", "M_Zero_Sggrss", "M_Zero_Sgns", "M_Zero_Sgmmns", "M_VHard_Sggrss", "M_VHard_Sgns", "M_VHard_Sgmmns"})
        local Season = MsgBox_Season()
        local Weather = MsgBox_Weather(Season)
        local StartHour = MsgBox_Hour(12)
        local IsCold = MsgBox_IsCold()

        local environmentSettings = {
            ["#Summer"] = { date = {2026, 07, 22, StartHour, 30} },
            ["#Autumn"] = { date = {2026, 10, 16, StartHour, 30} },
            ["#Winter"] = { date = {2026, 02, 26, StartHour, 30} },
            ["#Spring"] = { date = {2026, 04, 09, StartHour, 30} },
        }
        ExecuteEnvironment(environmentSettings, Season, Weather, IsCold)
        SpawnPlayer(Loco, IsCold)
        AlternativeScoring(true)

        coroutine.yield(CoroutineYields.WaitForSeconds, 3)
        CommsLocal(nil, "Welcome")
    end)
end

function OnVirtualDispatcherReady()
    Log("VD ready")
    VDLoaded = true
end

function SpawnPlayer(Loco, IsCold)
    local player_trainset = SpawnTrainsetOnSignal("player", FindSignal("2426_LCH_D"), 20, false, true, false, false, GetTrainset(Loco, Cargo))
    -- ustaw stan ciapongu.
    if IsCold ~= LocState.Hot then
        player_trainset.SetState(DynamicState.dsCold, TrainsetState.tsDeactivation, true)
    else
        player_trainset.SetState(DynamicState.dsStop, TrainsetState.tsTrain, true)
    end
    -- inne duperele.
    player_trainset.SetTimetable(LoadTimetableFromFile("Timetable.xml"), true)
    player_trainset.SetRadioChannel(5, true)
end

function Triggers()
    Log("Setup triggers")
    -- lodz zabieniec proba radia.
    CreateTrackTriggerFront(FindTrack("t42415"), 1, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            ScenarioStep = "LZ_Proba_Radia"
            ShowUseRadioNotification()
        end
    }, true)
    -- zgierz proba radyjka.
    CreateTrackTriggerFront(FindTrack("t50495"), 132, -1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            ScenarioStep = "Zg_Proba_Radia"
            ShowUseRadioNotification()
        end
    }, true)
    -- zgierz mijanka szlak zajety.
    CreateTrackTriggerBack(FindTrack("t50028"), 47, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                coroutine.yield(CoroutineYields.WaitForTrainsetStop, RailstockGetPlayerTrainset())
                -- przebieg dla cargula do mijanki
                VDSetCrossingState("L16_14.618_B", false)
                CreateRoute("5311_Zg_A", "5311_Zg_M", VDOrderType.TrainRoute)
                CreateRoute("5311_Zg_M", "5311_Zg_Rkps", VDOrderType.TrainRoute)
                -- spawn cargula.
                SpawnTrainsetOnSignalAsync("event-1", FindSignal("5311_Zg_A"), 380, false, false, true, CreateRandomCargoTrain(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsAccFast, TrainsetState.tsTrain, true)
                    SetBotSpeed(trainset, 80)
                end)
            end)
        end
    }, true)
    -- trigger dla cargula.
    CreateTrackTriggerBack(FindTrack("t50089"), 49, -1, 
    {
        check = function(trainset)
            return true
        end,
        result = function(trainset)
            -- podaj wyjazd dla nas xd.
            CreateCoroutine(function() 
                CreateRoute("5311_Zg_C", "5311_Zg_Akps", VDOrderType.TrainRoute)
            end)
        end
    }, true)
    -- ZP - ZK
    CreateTrackTriggerFront(FindTrack("t50150"), 85, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                CreateRoute("5314_ZP_B", "5314_ZP_K", VDOrderType.TrainRoute)
                CreateRoute("5314_ZP_K", "5314_ZP_Pkps", VDOrderType.TrainRoute)
                CreateRoute("5313_ZK_A", "5313_ZK_K", VDOrderType.TrainRoute)
                CreateRoute("5313_ZK_K", "5313_ZK_Pkps", VDOrderType.TrainRoute)
            end)
        end
    }, true)
    -- chociszew i ozorkowa przelot
    CreateTrackTriggerFront(FindTrack("t61386"), 256, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                CreateRoute("477_Ch_A", "477_Ch_D1", VDOrderType.TrainRoute)
                CreateRoute("477_Ch_D1", "477_Ch_Fkps", VDOrderType.TrainRoute)
                CreateRoute("3089_Oz_A", "3089_Oz_N", VDOrderType.TrainRoute)
                CreateRoute("3089_Oz_N", "3089_Oz_Ukps", VDOrderType.TrainRoute)
            end)
        end
    }, true)
    -- leczyca mijanka.
    CreateTrackTriggerFront(FindTrack("t61489"), 123, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                CommsLocal("Łe", "Le_Postoj_1")
                ScenarioStep = "Le_Postoj_Radio"
                ShowUseRadioNotification()
            end)
        end
    }, true)
    -- leczyca wjazd.
    CreateTrackTriggerBack(FindTrack("t62417"), 3, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                coroutine.yield(CoroutineYields.WaitForTrainsetStop, RailstockGetPlayerTrainset())
                CreateRoute("2385_Le_E", "2385_Le_Akps", VDOrderType.TrainRoute)
                CreateRoute("2385_Le_P", "2385_Le_E", VDOrderType.TrainRoute)
                SpawnTrainsetOnSignalAsync("event-2", FindSignal("2385_Le_P"), 100, false, false, true, CreateRandomPassengerWagonTrain(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsAccFast, TrainsetState.tsTrain, true)
                    SetBotSpeed(trainset, 80)
                end)
            end)
        end
    }, true)
    -- leczyca wyjazd po mijance. i wjazd do kutna i wgl lmao
    CreateTrackTriggerBack(FindTrack("t61512"), 150, -1, 
    {
        check = function(trainset)
            return true
        end,
        result = function(trainset)
            CreateCoroutine(function() 
                CreateRoute("2385_Le_N", "2385_Le_Pkps", VDOrderType.TrainRoute)
                CreateRoute("4971_Wi_A", "4971_Wi_E", VDOrderType.TrainRoute)
                CreateRoute("4971_Wi_E", "4971_Wi_Hkps", VDOrderType.TrainRoute)
                CreateRoute("2133_Ku_A", "2133_Ku_G6", VDOrderType.TrainRoute)
                CreateRoute("2133_Ku_G6", "2133_Ku_J108", VDOrderType.TrainRoute)
            end)
        end
    }, true)
    -- kutno wjazd i koniec.
    CreateTrackTriggerBack(FindTrack("t62733"), 19, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                coroutine.yield(CoroutineYields.WaitForTrainsetStop, RailstockGetPlayerTrainset())
                coroutine.yield(CoroutineYields.WaitForSeconds, 3)
                FinishMission(MissionResultEnum.Success)
            end)
        end
    }, true)
end

function Ai()
    -- ŁCH.
    SpawnTrainsetAsync("ai-1-cargo", FindTrack("t37887"), 85, false, false, true, CreateRandomFreighCarts(), function() end)
    SpawnTrainsetOnSignalAsync("ai-2-cargo", FindSignal("2426_LCH_K"), 40, false, false, true, CreateRandomCargoTrain(Loc.Lodz), function(trainset) 
        trainset.SetState(DynamicState.dsStop, TrainsetState.tsTrain, true)
    end)
    -- lch - lk
    CreateTrackTriggerFront(FindTrack("t38080"), 33, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                SpawnTrainsetAsync("ai-3-ic", FindTrack("t41007"), 65, true, false, true, CreateRandomPassengerWagonTrain(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsAccFast, TrainsetState.tsTrain, true)
                    SetBotSpeed(trainset, 80)
                end)
                CreateRoute("2426_LCH_A", "2426_LCH_J", VDOrderType.TrainRoute) 
            end)
            
        end
    }, true)
    CreateTrackTriggerFront(FindTrack("t41012"), 100, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            DespawnTrainsets(false)
            CreateCoroutine(function() 
                SpawnTrainsetOnSignalAsync("ai-4-ezt", FindSignal("2432_LK_P201"), 30, false, false, true, CreateRandomEzt(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsStop, TrainsetState.tsTrain, true)
                    SetBotSpeed(trainset, 40)
                end)
                SpawnTrainsetAsync("ai-5-cargo", FindTrack("t47181"), 98, true, false, true, CreateRandomFreighCarts(), function() end)
                SpawnTrainsetAsync("ai-6-cargo", FindTrack("t47023"), 27, true, false, true, CreateRandomFreighCarts(), function() end)
                CreateRoute("2432_LK_P201", "2432_LK_Ykps", VDOrderType.TrainRoute)
            end)
        end
    }, true)
    CreateTrackTriggerFront(FindTrack("t41052"), 34, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                SpawnTrainsetOnSignalAsync("ai-7-ezt", FindSignal("2432_LK_H154"), 30, false, false, true, CreateRandomEzt(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsStop, TrainsetState.tsTrain, true)
                    Halt(trainset)
                end)
                SpawnTrainsetOnSignalAsync("ai-8-ic", FindSignal("2432_LK_Tm48"), 30, false, false, true, CreateRandomPassengerWagonTrain(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsStop, TrainsetState.tsShunting, true)
                end)
                SpawnTrainsetOnSignalAsync("ai-10-ezt", FindSignal("2432_LK_Tm52"), 15, false, false, true, CreateRandomEzt(Loc.Lodz), function() end)
                SpawnTrainsetAsync("ai-11-luz", FindTrack("t42369"), 48, false, false, true, CreateRandomLoc(), function() end)
            end)
        end
    }, true)
    -- LK - ŁŻ.
    CreateTrackTriggerFront(FindTrack("t42433"), 105, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            DespawnTrainsets(false)
            CreateCoroutine(function() 
                SpawnTrainsetOnSignalAsync("ai-12-cargo", FindSignal("2463_LZ_O"), 20, false, false, true, CreateRandomCargoTrain(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsStop, TrainsetState.tsTrain, true)
                end)
                CreateRoute("2463_LZ_O", "2463_LZ_U", VDOrderType.TrainRoute)
                CreateRoute("2463_LZ_U", "2463_LZ_Wkps", VDOrderType.TrainRoute)
            end)
        end
    }, true)
    CreateTrackTriggerFront(FindTrack("t42436"), 105, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                SpawnTrainsetOnSignalAsync("ai-13-cargo", FindSignal("2463_LZ_G"), 40, false, false, true, CreateRandomCargoTrain(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsStop, TrainsetState.tsTrain, true)
                end)
                SpawnTrainsetOnSignalAsync("ai-14-cargo", FindSignal("2463_LZ_H"), 60, false, false, true, CreateRandomFreighCarts(), function() end)
            end)
        end
    }, true)
    -- LŻ - Zg.
    CreateTrackTriggerFront(FindTrack("t50485"), 36, -1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            DespawnTrainsets(false)
            CreateCoroutine(function() 
                SpawnTrainsetAsync("ai-15-ic", FindTrack("t50459"), 19, false, false, true, CreateRandomPassengerWagonTrain(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsAccFast, TrainsetState.tsTrain, true)
                    SetBotSpeed(trainset, 100)
                end)
            end)
        end
    }, true)
    CreateTrackTriggerFront(FindTrack("t50246"), 80, -1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                SpawnTrainsetOnSignalAsync("ai-16-ezt", FindSignal("5311_Zg_H"), 20, false, false, true, CreateRandomEzt(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsStop, TrainsetState.tsShunting, true)
                    Halt(trainset)
                end)
            end)
        end
    }, true)
    CreateTrackTriggerFront(FindTrack("t50144"), 116, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            DespawnTrainsets(false)
            SpawnTrainsetOnSignalAsync("ai-17-luz", FindSignal("5314_ZP_D"), 20, false, false, true, CreateRandomLoc(), function(trainset) 
                trainset.SetState(DynamicState.dsStop, TrainsetState.tsTrain, true)
            end)
        end
    }, true)
    -- ozorkow.
    CreateTrackTriggerFront(FindTrack("t61427"), 12, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            DespawnTrainsets(false)
            CreateCoroutine(function() 
                SpawnTrainsetAsync("ai-18-cargo", FindTrack("t62362"), 35, false, false, true, CreateRandomFreighCartsQuant(5, 7), function() end)
                SpawnTrainsetAsync("ai-19-cargo", FindTrack("t62370"), 48, false, false, true, CreateRandomFreighCartsQuant(3, 4), function() end)
            end)
        end
    }, true)
    -- leczyca.
    CreateTrackTriggerFront(FindTrack("t61497"), 20, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                SpawnTrainsetOnSignalAsync("ai-20-cargo", FindSignal("2385_Le_G"), 20, false, false, true, CreateRandomCargoTrain(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsStop, TrainsetState.tsTrain, true)
                end)
            end)
        end
    }, true)
    -- despawn za łęczycą.
    CreateTrackTriggerFront(FindTrack("t61536"), 101, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            DespawnTrainsets(false)
        end
    }, true)
    -- witonia
    CreateTrackTriggerFront(FindTrack("t61595"), 7, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            CreateCoroutine(function() 
                SpawnTrainsetOnSignalAsync("ai-21-cargo", FindSignal("4971_Wi_C"), 270, false, false, true, CreateRandomEzt(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsStop, TrainsetState.tsTrain, true)
                    Halt(trainset)
                end)
            end)
        end
    }, true)
    -- zasrane kutno.
    CreateTrackTriggerFront(FindTrack("t61658"), 155, 1, 
    {
        check = PlayerTrainsetCheck,
        result = function(trainset)
            DespawnTrainsets(false)
            CreateCoroutine(function() 
                SpawnTrainsetOnSignalAsync("ai-22-ezt", FindSignal("2133_Ku_F4"), 10, false, false, true, CreateRandomEzt(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsStop, TrainsetState.tsTrain, true)
                end)
                SpawnTrainsetOnSignalAsync("ai-23-cargo", FindSignal("2133_Ku_J110"), 30, false, false, true, CreateRandomCargoTrain(Loc.Lodz), function() end)
                SpawnTrainsetOnSignalAsync("ai-24-cargo", FindSignal("2133_Ku_J106"), 50, false, false, true, CreateRandomFreighCarts(), function() end)
            end)
            CreateCoroutine(function() 
                CreateRoute("2133_Ku_C", "2133_Ku_G1", VDOrderType.TrainRoute)
                SpawnTrainsetOnSignalAsync("ai-25-ic", FindSignal("2133_Ku_C"), 30, false, false, true, CreateRandomPassengerWagonTrain(Loc.Lodz), function(trainset) 
                    trainset.SetState(DynamicState.dsAccFast, TrainsetState.tsTrain, true)
                    SetBotSpeed(trainset, 120)
                end)
            end)
        end
    }, true)
    
end

function OnPlayerRadioCall(trainsetInfo, radio_SelectionCall)
    Log("Call pressed in " .. trainsetInfo.name .. ". Call type: " .. tostring(radio_SelectionCall) .. ", Step: " ..tostring(ScenarioStep))
    -- start scenariusza.
    if ScenarioStep == "Start" then
        if RailstockGetPlayerTrainset().GetCurrentlyUsedChannel() == 5 then
            ScenarioStep = 0
            CreateCoroutine(function() 
                CommsLocal("#Caller_You", "LCH_Start_1")
                CommsLocal("ŁCH", "LCH_Start_2")
                coroutine.yield(CoroutineYields.WaitUntil, function() return VDLoaded end)
                -- przebieg aż pod kaliską.
                CreateRoute("2426_LCH_X22", "2426_LCH_Xkps", VDOrderType.TrainRoute)
                CreateRoute("2426_LCH_D", "2426_LCH_X22", VDOrderType.TrainRoute)
                CreateRoute("2432_LK_Z", "2432_LK_L202", VDOrderType.TrainRoute)
                CreateRoute("2432_LK_L202", "2432_LK_H152", VDOrderType.TrainRoute)
                CreateRoute("2432_LK_H152", "2432_LK_E102", VDOrderType.TrainRoute)
                CreateRoute("2432_LK_E102", "2432_LK_A2kps", VDOrderType.TrainRoute)
            end)
        else
            CreateCoroutine(function()
                coroutine.yield(CoroutineYields.WaitForSeconds, 0.1)
                ShowUseRadioNotification()
                Comms(false, "StaticNoise")
            end)
        end
    -- proba radia zabieniec.
    elseif ScenarioStep == "LZ_Proba_Radia" then
        if RailstockGetPlayerTrainset().GetCurrentlyUsedChannel() == 1 then
            ScenarioStep = 0
            CreateCoroutine(function() 
                CreateRoute("2463_LZ_X", "2463_LZ_S", VDOrderType.TrainRoute)
                CreateRoute("2463_LZ_S", "2463_LZ_F", VDOrderType.TrainRoute)
                CreateRoute("2463_LZ_F", "2463_LZ_Akps", VDOrderType.TrainRoute)
            end)
            CreateCoroutine(function() 
                CommsLocal("#Caller_You", "LZ_Proba_1")
                CommsLocal("ŁŻ", "LZ_Proba_2")
                CommsLocal("#Caller_You", "LZ_Proba_3")
            end)
        else
            CreateCoroutine(function()
                coroutine.yield(CoroutineYields.WaitForSeconds, 0.1)
                ShowUseRadioNotification()
                Comms(false, "StaticNoise")
            end)
        end
    -- proba radia zgierz.
    elseif ScenarioStep == "Zg_Proba_Radia" then
        if RailstockGetPlayerTrainset().GetCurrentlyUsedChannel() == 4 then
            ScenarioStep = 0
            CreateCoroutine(function() 
                CreateRoute("5311_Zg_S", "5311_Zg_C", VDOrderType.TrainRoute)
            end)
            CreateCoroutine(function() 
                CommsLocal("#Caller_You", "Zg_Proba_1")
                CommsLocal("Zg", "Zg_Proba_2")
                CommsLocal("#Caller_You", "Zg_Proba_3")
            end)
        else
            CreateCoroutine(function()
                coroutine.yield(CoroutineYields.WaitForSeconds, 0.1)
                ShowUseRadioNotification()
                Comms(false, "StaticNoise")
            end)
        end
    -- leczyca na bok.
    elseif ScenarioStep == "Le_Postoj_Radio" then
        if RailstockGetPlayerTrainset().GetCurrentlyUsedChannel() == 4 then
            ScenarioStep = 0
            CreateCoroutine(function() 
                CreateRoute("2385_Le_A", "2385_Le_N", VDOrderType.TrainRoute)
            end)
            CreateCoroutine(function() 
                CommsLocal("#Caller_You", "Le_Postoj_2")
                CommsLocal("Łe", "Le_Postoj_3")
                CommsLocal("#Caller_You", "Le_Postoj_4")
            end)
        else
            CreateCoroutine(function()
                coroutine.yield(CoroutineYields.WaitForSeconds, 0.1)
                ShowUseRadioNotification()
                Comms(false, "StaticNoise")
            end)
        end
    end
end
