--Soraka by Lostflash--
require('DLib')
require('Inspired')
require('IAC')

if(GetObjectName(GetMyHero())) ~= "Soraka" then return end

local info = "Soraka by Lostflash loaded!";
PrintChat(info);


local root = menu.addItem(SubMenu.new("Soraka"))

local Combo = root.addItem(SubMenu.new("Combo"))
local CUseQ = Combo.addItem(MenuBool.new("Use Q", true))
local CUseW = Combo.addItem(MenuBool.new("Use W", true))
local CUseE = Combo.addItem(MenuBool.new("Use E", true))
local CUseR = Combo.addItem(MenuBool.new("Use R", true))

local Harass = root.addItem(SubMenu.new("Harass"))
local HUseQ = Harass.addItem(MenuBool.new("Use Q",true))
local HUseE = Harass.addItem(MenuBool.new("Use E",true))

local Healing = root.addItem(SubMenu.new("Healing"))
local HealUseW = Healing.addItem(MenuBool.new("Auto W",true))
local HealProW = Healing.addItem(MenuSlider.new("W Heal At %", 70, 1, 100, 1))
local HealSep1 = Healing.addItem(MenuSeparator.new(""))
local HealUseR = Healing.addItem(MenuBool.new("Auto R",true))
local HealProR = Healing.addItem(MenuSlider.new("R Heal At %", 20, 1, 100, 1))

local AutoPot = root.addItem(SubMenu.new("Auto Pot"))
local PotRed = AutoPot.addItem(MenuBool.new("Auto Use HP Pots",true))
local PotRedPro = AutoPot.addItem(MenuSlider.new("Use At %", 50, 1, 100, 1))
local PotSep1 = AutoPot.addItem(MenuSeparator.new(""))
local PotBlue = AutoPot.addItem(MenuBool.new("Auto Use MP Pots",true))
local PotBluePro = AutoPot.addItem(MenuSlider.new("Use At %", 60, 1, 100, 1))

local Misc = root.addItem(SubMenu.new("Misc"))
local MAutolvl = Misc.addItem(MenuBool.new("Auto Level Spells", false))

global_ticks = 0
currentTicks = GetTickCount()

myIAC = IAC();

OnLoop(function(myHero)

local myHero = GetMyHero()
local target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)


--Combo
    if IWalkConfig.Combo then
        local target = GetTarget(1000, DAMAGE_MAGIC)
            
            local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,0,GetCastRange(myHero, _Q),50,false,true);
                if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero, _E)) and CUseE.getValue() then
                    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z);
                end
            
            local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1750,500,GetCastRange(myHero, _E),300,false,true);
                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero, _Q)) and CUseQ.getValue() then
                    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z);
                end
                
            for _, ally in pairs(GetAllyHeroes()) do
                if CUseW.getValue() then
                    if (GetCurrentHP(ally)/GetMaxHP(ally)) < HealProW.getValue() / 100 and
                        CanUseSpell(myHero, _W) == READY and IsInDistance(ally, 600) then
                            CastTargetSpell(ally, _W);
                        end
                    end
                end
                
                for _, ally in pairs(GetAllyHeroes()) do
                    if CUseR.getValue() then
                        if(GetCurrentHP(ally)/GetMaxHP(ally)) < HealProR.getValue() / 100 and
                            CanUseSpell(myHero, _R) == READY and IsObjectAlive(ally) then
                                CastSpell(_R);
                            end
                        end
                end
        end
        

--Harass		
        if IWalkConfig.Harass then
            local target = GetTarget(1000, DAMAGE_MAGIC)
            
			if GetCurrentMana(myHero)>GetCastMana(myHero,_Q,GetCastLevel(myHero,_Q)) + GetCastMana(myHero,_E,GetCastLevel(myHero,_E)) then
            local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,0,650,50,false,true);
                if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero, _E)) and HUseE.getValue() then
                    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z);
                end
            
            local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1750,500,950,300,false,true);
                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero, _Q)) and HUseQ.getValue() then
                    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z);
                end
            end
			
			else if GetCurrentMana(myHero)<GetCastMana(myHero,_Q,GetCastLevel(myHero,_Q)) + GetCastMana(myHero,_E,GetCastLevel(myHero,_E)) then
			local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1750,500,950,300,false,true);
                if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero, _Q)) and HUseQ.getValue() then
                    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z);
                end
			
			local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1600,0,650,50,false,true);
                if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero, _E)) and HUseR.getValue() then
                    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z);
                end
			end
		end
	
		
--Healing
			if HealUseW.getValue() then
				for _, ally in pairs(GetAllyHeroes()) do
						if (GetCurrentHP(ally)/GetMaxHP(ally)) < HealProW.getValue() / 100 and
							CanUseSpell(myHero, _W) == READY and IsInDistance(ally, 600) then
								CastTargetSpell(ally, _W);
                        end
                    end
                end
			if HealUseR.getValue() then
				for _, ally in pairs(GetAllyHeroes()) do
						if (GetCurrentHP(ally)/GetMaxHP(ally)) < HealProR.getValue() / 100 and
							CanUseSpell(myHero, _R) == READY and IsObjectAlive(ally) then
								CastTargetSpell(_R);
                        end
                    end
				end
				
				
--Potting
			if (global_ticks + 15000) < currentTicks then
				if PotRed.getValue() then
				local potionslot = GetItemSlot(myHero, 2003)
					if potionslot > 0 then
						if GetCurrentHP(myHero) < GetMaxHP(myHero) * PotRedPro.getValue() / 100 then
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2003))
						end
					end
				end
			end
			
			if (global_ticks + 15000) < currentTicks then
				if PotBlue.getValue() then
				local potionslot = GetItemSlot(myHero, 2004)
					if potionslot > 0 then
						if GetCurrentMana(myHero) < GetMaxMana(myHero) * PotBluePro.getValue() / 100 then
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2004))
						end
					end
				end
			end
			
			
--AutoLevel
			if MAutolvl.getValue() then
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
