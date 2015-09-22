--Soraka by Lostflash--
require('Inspired')
require('IOW')

if(GetObjectName(GetMyHero())) ~= "Soraka" then return end

local info = "Soraka by Lostflash loaded!";
PrintChat(info);


SorakaMenu = Menu("Soraka", "Soraka")
SorakaMenu:Info("Sep1", "Created by Lostflash")

SorakaMenu:SubMenu("Combo", "Combo")
SorakaMenu.Combo:Boolean("Q", "Use Q", true)
SorakaMenu.Combo:Boolean("W", "Use W", true)
SorakaMenu.Combo:Boolean("E", "Use E", true)
SorakaMenu.Combo:Boolean("R", "Use R", true)

SorakaMenu:SubMenu("Harass", "Harass")
SorakaMenu.Harass:Boolean("Q", "Use Q", true)
SorakaMenu.Harass:Boolean("E", "Use E", true)

SorakaMenu:SubMenu("Healing", "Healing")
SorakaMenu.Healing:Boolean("W", "Auto W", true)
SorakaMenu.Healing:Slider("HealW", "W Heal At %", 70, 1, 100, 1)
SorakaMenu.Healing:Info("Sep", "")
SorakaMenu.Healing:Boolean("R", "Auto R", true)
SorakaMenu.Healing:Slider("HealR", "R Heal At %", 20, 1, 100, 1)

SorakaMenu:SubMenu("AutoPot", "Auto Pot")
SorakaMenu.AutoPot:Boolean("AutoRed", "Use Red Potion", true)
SorakaMenu.AutoPot:Slider("PotRedPro", "Use At %", 50, 1, 100, 1)
SorakaMenu.AutoPot:Info("Sep", "")
SorakaMenu.AutoPot:Boolean("AutoBlue", "Use Blue Potion", true)
SorakaMenu.AutoPot:Slider("PotBluePro", "Use At %", 50, 1, 100, 1)

SorakaMenu:SubMenu("Misc", "Misc")
SorakaMenu.Misc:Boolean("Autolvl", "Auto Level Spells", false)

global_ticks = 0
currentTicks = GetTickCount()

OnLoop(function(myHero)

local target = IOW:GetTarget()
local myHero = GetMyHero()


--Combo
    if IOW:Mode() == "Combo" then
        local target = GetCurrentTarget()
            
            local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,0,GetCastRange(myHero, _Q),50,false,true);
                if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero, _E)) and SorakaMenu.Combo.E:Value() then
                    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z);
                end
            
            local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1750,500,GetCastRange(myHero, _E),300,false,true);
                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero, _Q)) and SorakaMenu.Combo.Q:Value() then
                    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z);
                end
                
			if SorakaMenu.Combo.W:Value() then
				for _, ally in pairs(GoS:GetAllyHeroes()) do
                    if (100 * GetCurrentHP(ally)/GetMaxHP(ally)) < SorakaMenu.Healing.HealW:Value() and
                        CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(ally, 600) then
                            CastTargetSpell(ally, _W);
                        end
                    end
                end
                
			if SorakaMenu.Combo.R:Value() then
                for _, ally in pairs(GoS:GetAllyHeroes()) do
                        if(100 * GetCurrentHP(ally)/GetMaxHP(ally)) < SorakaMenu.Healing.HealR:Value() and
                            CanUseSpell(myHero, _R) == READY and IsObjectAlive(ally) then
                                CastSpell(_R);
                            end
                        end
                end
        end
        

--Harass		
	if IOW:Mode() == "Harass" then
            local target = IOW:GetTarget(1000, DAMAGE_MAGIC)
            
			if GetCurrentMana(myHero)>GetCastMana(myHero,_Q,GetCastLevel(myHero,_Q)) + GetCastMana(myHero,_E,GetCastLevel(myHero,_E)) then
            local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,0,GetCastRange(myHero, _E),50,false,true);
                if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero, _E)) and SorakaMenu.Harass.E:Value() then
                    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z);
                end
            
            local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1750,500,GetCastRange(myHero, _Q),300,false,true);
                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero, _Q)) and SorakaMenu.Harass.Q:Value() then
                    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z);
                end
            end
			
			else if GetCurrentMana(myHero)<GetCastMana(myHero,_Q,GetCastLevel(myHero,_Q)) + GetCastMana(myHero,_E,GetCastLevel(myHero,_E)) then
			local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1750,500,GetCastRange(myHero, _Q),300,false,true);
                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero, _Q)) and SorakaMenu.Harass.Q:Value() then
                    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z);
                end
			
			local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,0,GetCastRange(myHero, _E),50,false,true);
                if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero, _E)) and SorakaMenu.Harass.E:Value() then
                    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z);
                end
			end
		end
	
		
--Healing
			if SorakaMenu.Healing.W:Value() then
				for _, ally in pairs(GoS:GetAllyHeroes()) do
						if (100 * GetCurrentHP(ally))/GetMaxHP(ally) <  SorakaMenu.Healing.HealW:Value() and
							CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(ally, 600) then
								CastTargetSpell(ally, _W);
                        end
                    end
                end
			if SorakaMenu.Healing.R:Value() then
				for _, ally in pairs(GoS:GetAllyHeroes()) do
						if (100 * GetCurrentHP(ally)/GetMaxHP(ally)) < SorakaMenu.Healing.HealR:Value() and
							CanUseSpell(myHero, _R) == READY and IsObjectAlive(ally) then
								CastSpell(_R);
                        end
                    end
				end
				
				
--Potting
			if SorakaMenu.AutoPot.AutoRed:Value() then
				if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2003)
					if potionslot > 0 then
						if 100 * GetCurrentHP(myHero) / GetMaxHP(myHero) < SorakaMenu.AutoPot.PotRedPro:Value() then
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2003))
						end
					end
				end
			end
			
			if SorakaMenu.AutoPot.AutoBlue:Value() then
				if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2004)
					if potionslot > 0 then
						if 100 * GetCurrentMana(myHero) / GetMaxMana(myHero) < SorakaMenu.AutoPot.PotBluePro:Value() then
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2004))
						end
					end
				end
			end
			
			
--AutoLevel
			if SorakaMenu.Misc.Autolvl:Value() then
				if GetLevel(myHero) >= 1 and GetLevel(myHero) < 2 then
				LevelSpell(_Q)
				elseif GetLevel(myHero) >= 2 and GetLevel(myHero) < 3 then
				LevelSpell(_W)
				elseif GetLevel(myHero) >= 3 and GetLevel(myHero) < 4 then
				LevelSpell(_Q)
				elseif GetLevel(myHero) >= 4 and GetLevel(myHero) < 5 then
				LevelSpell(_E)
				elseif GetLevel(myHero) >= 5 and GetLevel(myHero) < 6 then
				LevelSpell(_Q)
				elseif GetLevel(myHero) >= 6 and GetLevel(myHero) < 7 then
				LevelSpell(_R)
				elseif GetLevel(myHero) >= 7 and GetLevel(myHero) < 8 then
				LevelSpell(_Q)
				elseif GetLevel(myHero) >= 8 and GetLevel(myHero) < 9 then
				LevelSpell(_W)
				elseif GetLevel(myHero) >= 9 and GetLevel(myHero) < 10 then
				LevelSpell(_Q)
				elseif GetLevel(myHero) >= 10 and GetLevel(myHero) < 11 then
				LevelSpell(_W)
				elseif GetLevel(myHero) >= 11 and GetLevel(myHero) < 12 then
				LevelSpell(_R)
				elseif GetLevel(myHero) >= 12 and GetLevel(myHero) < 13 then
				LevelSpell(_W)
				elseif GetLevel(myHero) >= 13 and GetLevel(myHero) < 14 then
				LevelSpell(_E)
				elseif GetLevel(myHero) >= 14 and GetLevel(myHero) < 15 then
				LevelSpell(_W)
				elseif GetLevel(myHero) >= 15 and GetLevel(myHero) < 16 then
				LevelSpell(_E)
				elseif GetLevel(myHero) >= 16 and GetLevel(myHero) < 17 then
				LevelSpell(_R)
				elseif GetLevel(myHero) >= 17 and GetLevel(myHero) < 18 then
				LevelSpell(_E)
				elseif GetLevel(myHero) == 18 then
				LevelSpell(_E)
				end
			end
    end)    
