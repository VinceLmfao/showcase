-- // Variables
Main = require(game.ReplicatedStorage.Instruction)
FirePlace = workspace.FirePlace
BaseFire = FirePlace.Base
Plonks = FirePlace.Wood
FireEmitter = FirePlace.FIreEmitter
count = 0
WoodProximity = workspace.Campfireproximity
planks = 0 
dialog = require(game.ReplicatedStorage.Dialog)
PlankTool = game.ServerStorage.Plank
Door = workspace["Proximity Door"]
frame = Door:WaitForChild("DoorFrame")
openSound = frame:WaitForChild("DoorOpen")
closeSound = frame:WaitForChild("DoorClose")
DoorPrompt = frame:WaitForChild("ProximityPrompt")
RunService = game:GetService("RunService")
HttpService = game:GetService("HttpService")
ReplicatedStorage = game:GetService("ReplicatedStorage")
frameClose = Door:WaitForChild("DoorFrameClose")
frameOpen = Door:WaitForChild("DoorFrameOpen")
tweenService = game:GetService("TweenService")
Monster = game.ServerStorage.monster1
Campfireprox = workspace.Campfireproximity
LightSwitch = workspace.LightSwitch.LightSwitch
Light = LightSwitch.Parent.Light
Flashlight = workspace.Flashlight
FlashlightTool = game.ServerStorage.Flashlight
Crowbar = workspace.Crowbar
CrowbarTool = game.ServerStorage.Crowbar
WrenchTool = game.ServerStorage.Wrench
	Wrench = workspace["Meshes/CLUC (1)"]
Powerbox = workspace.Powerbox
Generator = workspace.Generator
GenPart =Generator.Part
StatusGrid = Generator["Status grid"]
local odoro = false
local Zone = require(game:GetService("ReplicatedStorage").Zone)
local yoyo = true
Works = game:GetService("Workspace")
local HitBoxHouse = workspace.H
local zone = Zone.new(HitBoxHouse)
isOn = false
power = true
broadcasted = false
DoorDisabledPart = false
Door.DoorFrame.ProximityPrompt.Enabled = false
radioactive = false
--  // Join Handler
monsteerdoorthing = false
closeddoor =false
game.Players.PlayerAdded:Connect(function(plr)
	wait(2)
	Main:instruct("Walk To the campfire", true)
end)

--// Plank Handler
for i,plank in pairs(workspace.Plank:GetChildren()) do

	plank.Part.Attachment.ProximityPrompt.Triggered:Connect(function(plr)
		
		PlankTool:Clone().Parent = plr.Backpack
		plank:Destroy()
        count = count + 1
		Main:instruct(plr.DisplayName.." ".."Has Found A Plank "..count.."/3")
	end)
end

-- // FirePlace Handler
Plonks.Plank1.ProximityPrompt.Triggered:Connect(function(plr)
	if plr.Character:FindFirstChild("Plank") then
		plr.Character:FindFirstChild("Plank"):Destroy()
		if planks == 0 then
			Plonks.Plank1.Transparency = 0
			planks = 1
		else
			if planks == 1 then
				Plonks.Plank2.Transparency = 0
				planks = 2
			else
				if planks == 2 then
					Plonks.Plank3.Transparency = 0
					FireEmitter.Fire.Enabled = true
					FireEmitter.Smoke.Enabled = true
					FireEmitter.PointLight.Enabled = true
					FireEmitter.Sound:Play()
					Main:hideinstruct()
					WoodProximity:Destroy()
					planks = 3
					Plonks.Plank1.ProximityPrompt.Enabled = false
					wait(3)
					workspace.howl:Play()
					wait(7)
					dialog:talk("Wolves, Maybe we should head inside the cabin")
					Main:instruct("Head inside the cabin", false)
					Door.DoorFrame.ProximityPrompt.Enabled = true
				end
			end

		end
	end
end) 
function closedoor()
	closeSound:Play()
	frame.CanCollide = true
	tweenService:Create(frame,TweenInfo.new(.35),{CFrame = frameClose.CFrame}):Play()
	DoorPrompt.ActionText= "Open"
end
-- // Door Handler
DoorPrompt.Triggered:Connect(function(plr)
	if 	DoorPrompt.ActionText == "Close" then
		DoorPrompt.ActionText = "Open"
		closeSound:Play()
		frame.CanCollide = true
		tweenService:Create(frame,TweenInfo.new(.35),{CFrame = frameClose.CFrame}):Play()
		if odoro == false then
			for i,Players in pairs(game.Players:GetPlayers()) do
				Players.Character:FindFirstChild("HumanoidRootPart").Position = plr.Character:FindFirstChild("HumanoidRootPart").Position
			end
			DoorPrompt.Enabled = false
			wait(2)
			Door.Bangs:Play()
			wait(1)
			dialog:talk("What's that sound")
			wait(2)
			dialog:talk("I think its a knock")
			wait(2)
			dialog:talk("...")
			wait(1)
			dialog:talk("But there are only us here, who could possibly be at the door?")
			DoorPrompt.Enabled = true
			

            

			odoro = true
			yoyo = false
	
			
		end
		
		



	else
		
		
		if DoorDisabledPart then
			
			
			
			
			DoorDisabledPart = false
			dialog:talk("What in the world, i cant open the door.")
			wait(1)
			dialog:talk("It seems broken, we are gonna need to break it up")
			wait(0.5)
			DoorPrompt.ActionText = "Break Open door"
			DoorPrompt.ObjectText = "Requires a crowbar"
			Main:instruct("Find a crowbar", true)
			if plr.Character:FindFirstChild("Crowbar") then
				DoorPrompt.Triggered:Connect(function(plr)
					if monsteerdoorthing then
						DoorPrompt.Enabled = false
						dialog:talk("i hear something, im scared...")
						Main:instruct("ESCAPE FROM THE MONSTER", true)
						game.ServerStorage.monsta.Parent = workspace
						wait(10)
						monsteerdoorthing = false
						workspace:FindFirstChild("monsta"):Destroy()


					else

						dialog:talk("Im gonna berak open the door")
						wait(5)
						dialog:talk("BOOM*")
						frame.CanCollide = false
						tweenService:Create(frame,TweenInfo.new(0),{CFrame = frameOpen.CFrame}):Play()

					end
			end)
			
			
			end
		else
			DoorPrompt.ActionText = "Close"
			openSound:Play()
			tweenService:Create(frame,TweenInfo.new(.35),{CFrame = frameOpen.CFrame}):Play()
				
		end
				
		
		
		
		if yoyo == false then

			local monster1 = Monster:Clone()
			monster1.Parent = workspace
			plr.Character:FindFirstChild("Humanoid").WalkSpeed = 0
			plr.PlayerGui.Camera.Disabled = true
			monster1["Jumpscare sound effect"]:Play()
			wait(3.599)
			monster1:Destroy()
			plr.Character:FindFirstChild("Humanoid").WalkSpeed = 10
			plr.PlayerGui.Camera.Disabled = false
			yoyo = true
			
			power = false
			isOn = false
			Light.PointLight.Enabled = false
			Powerbox.Indicator.Transparency = 1
			wait(1)
			Powerbox.Prox["Static Rough 25 (SFX)"]:Stop()
			dialog:talk("...")
			wait(1)
			dialog:talk("Seems like the power went out.. looks like we are gonna have to repair the power box")
			
			wait(1)
			Main:instruct("Fix The Power Box")

			
		end


	end
end)
-- // WalkSpeed Handler
speed = 10

function onPlayerRespawned(character)
	wait(1) --loading delay
	local player = game.Players:GetPlayerFromCharacter(character)
	local human = character:findFirstChild("Humanoid")
	if player ~= nil and human ~= nil then
		human.WalkSpeed = speed
	end
end

game.Workspace.ChildAdded:connect(onPlayerRespawned)

-- // Lightning Handler
for i,v in pairs(game.ReplicatedStorage.Lightning:GetChildren()) do
	v.Parent = game.Lighting
end

--// Campfire Proximity
Campfireprox.Touched:Connect(function(ad)
	if ad.Parent:FindFirstChild("Humanoid") then
		Main:instruct("Find 3 Planks and put them in the campfire", true)
	end
end)


--// Character Sounds
game.Players.PlayerAdded:connect(function(p)
	p.CharacterAdded:connect(function(c)
		local x = script:FindFirstChild("MaterialAssets"):Clone()
		x.Parent = c
		x.Manage.Disabled = false
	end)
end)
--// Lights


LightSwitch.ProximityPrompt.Triggered:Connect(function()
	
	if power then
		isOn = not isOn
		Light.PointLight.Enabled = isOn
		if isOn then
			LightSwitch.ProximityPrompt.ActionText = "Off"
			LightSwitch.LightSwitchOn:Play()
		else
			LightSwitch.ProximityPrompt.ActionText = "On"
			LightSwitch.LightSwitchOff:Play()
		end
	end
end)
	

--// Tool Giver
Flashlight.Handle.ProximityPrompt.Triggered:Connect(function(plr)
	if plr.Backpack:FindFirstChild("Flashlight") then
	else
		if plr.Character:FindFirstChild("Flashlight") then
		else
			FlashlightTool:Clone().Parent = plr.Backpack
		end
		
	end
end)

Wrench.ProximityPrompt.Triggered:Connect(function(plr)
	if plr.Backpack:FindFirstChild("Wrench") then
	else
		if plr.Character:FindFirstChild("Wrench") then
		else
			WrenchTool:Clone().Parent = plr.Backpack
		end

	end
end)

Crowbar.ProximityPrompt.Triggered:Connect(function(plr)
	CrowbarTool:Clone().Parent = plr.Backpack
	workspace.Crowbar:Destroy()
end)

-- // Powerbox Handler
Powerbox.Prox.ProximityPrompt.Triggered:Connect(function(plr)
	if plr.Character:FindFirstChild("Wrench")  then
		power = true
		Powerbox.Prox["Static Rough 25 (SFX)"]:Play()
		workspace.Explodeing.apapap.Explode:Play()
		isOn = true
		Powerbox.Indicator.Transparency = 0
		Light.PointLight.Enabled = true
		Powerbox.Indicator.Transparency = 0
		dialog:talk("Phew, that was easy.")
		wait(1)
		Main:instruct("Go back into the house and watch some tv and relax", true)
		workspace["Cabin House"].Floor.Touched:Connect(function(ad)
			if ad.Parent:FindFirstChild("Humanoid") then
				if broadcasted == false then
					broadcasted = true
					Main:hideinstruct()
					wait(2)
					workspace.TV.Screen.Decal.Transparency = 0
					workspace.TV.Outside.Sound:Play()
					wait(5)
					dialog:talk("AAA, WHAT DO WE DO?!?!?!?")
					wait(4)
					power = false
					isOn = false
					Light.PointLight.Enabled = false
					Powerbox.Indicator.Transparency = 1
					wait(1)
					Powerbox.Prox["Static Rough 25 (SFX)"]:Stop()
					dialog:talk("We have to enable the backup power generator!!!!!!")
					wait(1)
					Main:instruct("Enable the backup power generator.", true)
					Generator.Switches.attac.Attachment.ProximityPrompt.Enabled = true
			
					-- Crowbar fix the door thingy
					zone.playerExited:Connect(function(player)
						if not closeddoor then
							closedoor()
							for i,v in pairs(game.Players:GetPlayers()) do
								if v.Name == player.Name then
									elsev.Character.HumanoidRootPart.Position = player.Character.HumanoidRootPart.Position
									
								end
								
								closedoor()
							end
						end
						
						
					end)								
					
					

					
				end
				
			end
			
			
			

		end)
	end
end)


	if radioactive then
		zone.playerExited:Connect(function(player)
			while wait(1) do
				player.Character.Humanoid.Health = player.Character.Humanoid.Health - 1
			end
			
		end)
	end
Generator.Switches.attac.Attachment.ProximityPrompt.Triggered:Connect(function()
	StatusGrid.Green.Transparency = 0
	wait(1)
	StatusGrid.Red.Transparency = 0
	wait(1)
	StatusGrid.Yellow.Transparency = 0
	wait(0.5)
	power = true
	isOn = true
	Light.PointLight.Enabled = true
	Main:hideinstruct()
	DoorDisabledPart = true
	workspace.Crowbar.ProximityPrompt.Enabled = true
	
end)
zone.playerExited:Connect(function(player)

		player.Character.Humanoid.Health = player.Character.Humanoid.Health - 1
end)
--// Idk Teo added this
local cameraInterpolateEvent = game.ReplicatedStorage.Remotes.cameraInterpolateEvent
local cameraToPlayerEvent = game.ReplicatedStorage.Remotes.cameraToPlayerEvent

local alreadyPlayed = false

game.Workspace.trigger2.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid")then
		if alreadyPlayed == false then 
			alreadyPlayed = true
			local monsterkilling = game.ReplicatedStorage.monsterkilling:clone()
			monsterkilling.Parent = game.Workspace
			monsterkilling.Head.Scream:play()
			cameraInterpolateEvent:FireAllClients(game.Workspace.CameraPosition.CFrame,game.Workspace.CameraAim.CFrame,0.2)
			wait(2)
			cameraToPlayerEvent:FireAllClients()
			monsterkilling:destroy()
		end
	end
end)



local function customDynamicClock(timestamp)
	local x = os.date('%M')
	for i=2,241 do
		x = x + os.date('%M')+15.3376
	end
	x = x - 1
	for i=1,333 do
		x = x + os.date('%M')+i+.053
	end
	return x
end

do
	local Key = math.random(250000,500000)
	ReplicatedStorage.RemoteFunction.OnServerInvoke = function(Player,Client)
		if customDynamicClock() == Client then
			return Key
		end
		Player:Kick('Tried to invoke RemoteFunction')
	end
end



game.ReplicatedStorage.Events.Remote.OnServerEvent:Connect(function()
	print("Hi vince")
end)
