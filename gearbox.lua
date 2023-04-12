-- Tick function that will be executed every logic tick
gear=0
tickdown=0
gearboxes={1.2,1.5,2.16,4.5}

function getRatio(gearnumber)
		local ratio = 1
		if (gearnumber & 1) ~=0 then
			ratio = ratio * gearboxes[1]
		end
		if (gearnumber & 2) ~=0 then
			ratio = ratio * gearboxes[2]
		end
		if (gearnumber & 4) ~=0 then
			ratio = ratio * gearboxes[3]
		end
		if (gearnumber & 8) ~=0 then
			ratio = ratio * gearboxes[4]
		end
		return ratio
end

function onTick()
	curentRPS = input.getNumber(1)
	gearUpRPS = input.getNumber(2)
	gearDownRPS = input.getNumber(3)
	if gear >0 then
	gearDownRPS = 0.95* gearUpRPS * getRatio(gear-1) / getRatio(gear)
	end
--	print(gearDownRPS)
	
	

    if(tickdown > 0) then 
    	tickdown =tickdown - 1
	end
	
    if (curentRPS > gearUpRPS) and (tickdown ==0 )then
        gear = gear+1
        tickdown =30
    end
    
	if (curentRPS < gearDownRPS) and (tickdown ==0 )then
        gear = gear-1
        tickdown =30
	end
	gear = math.max(math.min(gear,15)	,0)

    output.setBool(1, (gear & 1) ~=0)
    output.setBool(2, (gear & 2) ~=0)
    output.setBool(3, (gear & 4) ~=0)
    output.setBool(4, (gear & 8) ~=0)
	output.setNumber(5, gear)		
	
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()

end