--Script to control a BigReactor reactor's output for the turbine to reach and maintain an optimal RPM

local reactor = peripheral.wrap("bottom")
local turbine = peripheral.wrap("BigReactors-Turbine_1")

turn = 0
seq = false
lastDiff = 0

while true do    
    rsLvl = rs.getAnalogInput("right")
    if seq then print(rsLvl .. '.')
    else print(rsLvl) end
    seq = not seq
    
    active = reactor.getActive()
    if rsLvl < 2 and not active then
        reactor.setActive(true)
    elseif rsLvl > 10 and active then
        reactor.setActive(false)
        reactor.setAllControlRodLevels(100)
    end
    
    if active then
        diff = turbine.getRotorSpeed() - 900
        if diff < -100 then
            steam = reactor.getHotFluidProducedLastTick()
            if steam < 1780 then
                crLvl = reactor.getControlRodLevel(turn)
                reactor.setControlRodLevel(turn, crLvl - 1)
                turn = turn + 1
                turn = turn % 8
            elseif steam > 1800 then
                turn = turn - 1
                turn = turn % 8
                crLvl = reactor.getControlRodLevel(turn)
                reactor.setControlRodLevel(turn, crLvl + 1)
            end
        elseif diff < 0 then
            if diff <= lastDiff then
                crLvl = reactor.getControlRodLevel(turn)
                reactor.setControlRodLevel(turn, crLvl - 1)
                turn = turn + 1
                turn = turn % 8
            elseif diff > lastDiff + 1 then
                turn = turn - 1
                turn = turn % 8
                crLvl = reactor.getControlRodLevel(turn)
                reactor.setControlRodLevel(turn, crLvl + 1)
            end
        elseif diff > 0 then
            if diff >= lastDiff then
                turn = turn - 1
                turn = turn % 8
                crLvl = reactor.getControlRodLevel(turn)
                reactor.setControlRodLevel(turn, crLvl + 1)
            end
        end
        
        lastDiff = diff
    end
    
    sleep(1)
end
