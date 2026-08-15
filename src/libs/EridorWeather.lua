-- Eridor's common package v1.8
-- Last edit: 08.08.2026

SunnyW = {
    WeatherConditionCode.ClearSky,
    WeatherConditionCode.FewClouds,
    WeatherConditionCode.BrokenClouds,
    WeatherConditionCode.OvercastClouds,
}
FoggyW = {
    WeatherConditionCode.Fog,
    WeatherConditionCode.Haze,
    WeatherConditionCode.Mist,
}
SnowyW = {
    WeatherConditionCode.LightSnow,
    WeatherConditionCode.Snow,
    WeatherConditionCode.HeavySnow,
}
RainyW = {
    WeatherConditionCode.LightRain,
    WeatherConditionCode.ModerateRain,
    WeatherConditionCode.HeavyIntensityRain,
    WeatherConditionCode.VeryHeavyRain,
    WeatherConditionCode.ExtremeRain,
}
ThunderW = {
    WeatherConditionCode.ThunderstormWithLightRain,
    WeatherConditionCode.ThunderstormWithRain,
    WeatherConditionCode.ThunderstormWithHeavyRain,
    WeatherConditionCode.LightThunderstorm,
    -- WeatherConditionCode.Thunderstorm,
    -- WeatherConditionCode.HeavyThunderstorm,
    -- WeatherConditionCode.RaggedThunderstorm,
}


local function GetTemperature(Season)
    if Season == "#Winter" then return GetRandomInt(-25,-1)
    elseif Season == "#Spring" then return GetRandomInt(1,15)
    elseif Season == "#Summer" then return GetRandomInt(20,30)
    else return GetRandomInt(5, 10)
    end
end
---@return WeatherConditionCode
local function GetRandomObj(table)
    if #table == 0 then
        return WeatherConditionCode.ClearSky
    end
    local rnd = GetRandomInt(1, #table + 1)
    local ret = table[rnd]
    return ret
end
function StartWeather(weatherType, season)
    local isInit = true
    CreateCoroutine(function ()

        if season == "#Winter" then
            Log("Add snow")
            SetWeather(WeatherConditionCode.LightSnow, -10, 1000, 75, 5000, 0, 0, 10, true)
            isInit = false
            coroutine.yield(CoroutineYields.WaitForSeconds, 6)
        end

        while true do
            Log("SetWeather: " .. tostring(weatherType))
            if weatherType == WeatherEnum.Sunny then
                SetWeather(
                    GetRandomObj(SunnyW),   --code
                    GetTemperature(season), --temp
                    GetRandomInt(1000,1050),--pressure
                    GetRandomInt(30,50),    --humidity
                    GetRandomInt(2500,10000),--visibility
                    GetRandomInt(0,360),    --wind deg
                    GetRandomInt(0,5),      --wind speed
                    0,                      --snow fall speed
                    isInit
                )
            elseif weatherType == WeatherEnum.Fogy then
                SetWeather(
                    GetRandomObj(FoggyW),   --code
                    GetTemperature(season), --temp
                    GetRandomInt(950,1000), --pressure
                    GetRandomInt(80,100),   --humidity
                    GetRandomInt(10,70),    --visibility
                    GetRandomInt(0,360),    --wind deg
                    GetRandomInt(0,10),     --wind speed
                    0,                      --snow fall speed
                    isInit
                )
            elseif weatherType == WeatherEnum.Snowy then
                SetWeather(
                    GetRandomObj(SnowyW),   --code
                    GetTemperature(season), --temp
                    GetRandomInt(950,1000), --pressure
                    GetRandomInt(30,80),    --humidity
                    GetRandomInt(400,1500), --visibility
                    GetRandomInt(0,360),    --wind deg
                    GetRandomInt(0,30),     --wind speed
                    GetRandomInt(1,10),     --snow fall speed
                    isInit
                )
            elseif weatherType == WeatherEnum.Rainy then
                SetWeather(
                    GetRandomObj(RainyW),   --code
                    GetTemperature(season), --temp
                    GetRandomInt(950,1000), --pressure
                    GetRandomInt(60,90),    --humidity
                    GetRandomInt(400,1500), --visibility
                    GetRandomInt(0,360),    --wind deg
                    GetRandomInt(0,30),     --wind speed
                    0,                      --snow fall speed
                    isInit
                )
            elseif weatherType == WeatherEnum.Thunder then
                SetWeather(
                    GetRandomObj(ThunderW), --code
                    GetTemperature(season), --temp
                    GetRandomInt(880,950),  --pressure
                    GetRandomInt(30,100),   --humidity
                    GetRandomInt(400,1000), --visibility
                    GetRandomInt(0,360),    --wind deg
                    GetRandomInt(0,90),     --wind speed
                    0,                      --snow fall speed
                    isInit
                )
            end
            
            isInit = false
            coroutine.yield(CoroutineYields.WaitForSeconds, GetRandomInt(300, 600))
        end
    end)
end

WeatherEnum = {
    Sunny = 1,
    Fogy = 2,
    Snowy = 3,
    Rainy = 4,
    Thunder = 5 
}
