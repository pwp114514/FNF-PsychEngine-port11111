local spacepress = 0
androidPad={}
function addAndroidPad(name, x, y, color) makeAnimatedLuaSprite(name:lower()..'def', 'virtualpad', x, y) setObjectCamera(name:lower()..'def', 'other') addLuaSprite(name:lower()..'def', true) addAnimationByPrefix(name:lower()..'def', 'normal', name:lower()..'1', 24, false) addAnimationByPrefix(name:lower()..'def', 'pressed', name:lower()..'2', 24, false) setProperty(name:lower()..'def.alpha', 0.7) setProperty(name:lower()..'def.color', getColorFromHex(color)) table.insert(androidPad, name:lower()) end
function AndroidPadUpdate() for i = 1, #androidPad do if androidPadPress(androidPad[i]) then objectPlayAnimation(androidPad[i]..'def', 'pressed', true) else objectPlayAnimation(androidPad[i]..'def', 'normal', true) end end end
function androidPadJustPress(name) for i =1,#GetTouch("y") do
if ((GetTouch("y")[i] > getProperty(name:lower()..'def.y') and GetTouch("y")[i] < getProperty(name:lower()..'def.y')+132) and (GetTouch("x")[i] > getProperty(name:lower()..'def.x') and GetTouch("x")[i] < getProperty(name:lower()..'def.x')+132) and mouseClicked('left')) then
return true
end
end
return false end
function androidPadPress(name)
for i =1,#GetTouch("x") do
if ((GetTouch("y")[i] > getProperty(name:lower()..'def.y') and GetTouch("y")[i] < getProperty(name:lower()..'def.y')+132) and (GetTouch("x")[i] > getProperty(name:lower()..'def.x') and GetTouch("x")[i] < getProperty(name:lower()..'def.x')+132) and mousePressed('left')) then
return true
end
end
return false
end
function removeAndroidPad() for i = 1, #androidPad do removeLuaSprite(androidPad[i]..'def', true) end androidPad = {} end
function GetTouch(xy)
return runHaxeCode([[ var jlkk = []; for (touch in FlxG.touches.list) jlkk.push(touch.getScreenPosition().]]..xy..[[+136.0); return jlkk;]])
end
function onCreate()
addAndroidPad('a', 1148, 593, 'FFFFFF')
precacheImage('dodge/dodge');
end
function onUpdate()
AndroidPadUpdate()
if keyPressed('space') or androidPadPress("a") or botPlay and spacepress==1 then
spacepress=2
end
end
function onEvent(name, value1, value2)
	if name == 'dodge' then
		makeAnimatedLuaSprite('Warn', 'dodge/dodge', -200, -100)
    addAnimationByPrefix('Warn','dodge/dodge','dodge',24,true)
    luaSpritePlayAnimation('Warn', 'dodge');
	setObjectCamera('Warn', 'hud')
	addLuaSprite('Warn', true)
	scaleObject('Warn', 1.3, 1.3);
	spacepress=1
		runTimer('second-beep', value1, 1)
		runTimer('alert-time', value2, 1)
	end
end

function onTimerCompleted(tag, Loops, LoopsLeft)
	if tag == 'alert-time' then
		if spacepress==2 then
           characterPlayAnim('boyfriend', 'dodge', true);
           setProperty('boyfriend.specialAnim', true);
           characterPlayAnim('dad', 'attack', true);
           setProperty('dad.specialAnim', true); 
			removeLuaSprite('Warn', true)
			playSound('dodged2', 0.7);
		else
			setProperty('health', getProperty('health')-1.75)
			playSound('dodged2', 0.7);
           characterPlayAnim('dad', 'attack', true);
           setProperty('dad.specialAnim', true);
           characterPlayAnim('boyfriend', 'singRIGHTmiss', true);
           setProperty('boyfriend.specialAnim', true);
           removeLuaSprite('Warn', true)
		end
	end

end