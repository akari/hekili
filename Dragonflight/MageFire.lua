-- MageFire.lua
-- November 2022

if UnitClassBase( "player" ) ~= "MAGE" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State

local strformat = string.format

local spec = Hekili:NewSpecialization( 63 )

spec:RegisterResource( Enum.PowerType.ArcaneCharges )
spec:RegisterResource( Enum.PowerType.Mana )

-- Talents
spec:RegisterTalents( {
    -- Mage
    accumulative_shielding   = { 62093, 382800, 2 }, -- Your barrier's cooldown recharges 20% faster while the shield persists.
    alter_time               = { 62115, 342245, 1 }, -- Alters the fabric of time, returning you to your current location and health when cast a second time, or after 10 seconds. Effect negated by long distance or death.
    arcane_warding           = { 62114, 383092, 2 }, -- Reduces magic damage taken by 3%.
    blast_wave               = { 62103, 157981, 1 }, -- Causes an explosion around yourself, dealing 916 Fire damage to all enemies within 8 yards, knocking them back, and reducing movement speed by 70% for 6 sec.
    cryofreeze               = { 62107, 382292, 2 }, -- While inside Ice Block, you heal for 40% of your maximum health over the duration.
    displacement             = { 62092, 389713, 1 }, -- Teleports you back to where you last Blinked. Only usable within 8 sec of Blinking.
    diverted_energy          = { 62101, 382270, 2 }, -- Your Barriers heal you for 10% of the damage absorbed.
    dragons_breath           = { 62091, 31661 , 1 }, -- Enemies in a cone in front of you take 1,130 Fire damage and are disoriented for 4 sec. Damage will cancel the effect. Always deals a critical strike and contributes to Hot Streak.
    energized_barriers       = { 62100, 386828, 1 }, -- When your barrier receives melee attacks, you have a 10% chance to be granted 1 Fire Blast charge. Casting your barrier removes all snare effects.
    flow_of_time             = { 62096, 382268, 2 }, -- The cooldown of Blink is reduced by 2.0 sec.
    freezing_cold            = { 62087, 386763, 1 }, -- Enemies hit by Cone of Cold are frozen in place for 5 sec instead of snared. When your roots expire or are dispelled, your target is snared by 80%, decaying over 3 sec.
    frigid_winds             = { 62128, 235224, 2 }, -- All of your snare effects reduce the target's movement speed by an additional 10%.
    greater_invisibility     = { 62095, 110959, 1 }, -- Makes you invisible and untargetable for 20 sec, removing all threat. Any action taken cancels this effect. You take 60% reduced damage while invisible and for 3 sec after reappearing.
    ice_block                = { 62122, 45438 , 1 }, -- Encases you in a block of ice, protecting you from all attacks and damage for 10 sec, but during that time you cannot attack, move, or cast spells. While inside Ice Block, you heal for 40% of your maximum health over the duration. Causes Hypothermia, preventing you from recasting Ice Block for 30 sec.
    ice_floes                = { 62105, 108839, 1 }, -- Makes your next Mage spell with a cast time shorter than 10 sec castable while moving. Unaffected by the global cooldown and castable while casting.
    ice_nova                 = { 62126, 157997, 1 }, -- Causes a whirl of icy wind around the enemy, dealing 2,328 Frost damage to the target and reduced damage to all other enemies within 8 yards, and freezing them in place for 2 sec.
    ice_ward                 = { 62086, 205036, 1 }, -- Frost Nova now has 2 charges.
    improved_frost_nova      = { 62108, 343183, 1 }, -- Frost Nova duration is increased by 2 sec.
    incantation_of_swiftness = { 62112, 382293, 2 }, -- Invisibility increases your movement speed by 40% for 6 sec.
    incanters_flow           = { 62113, 1463  , 1 }, -- Magical energy flows through you while in combat, building up to 20% increased damage and then diminishing down to 4% increased damage, cycling every 10 sec.
    invisibility             = { 62118, 66    , 1 }, -- Turns you invisible over 3 sec, reducing threat each second. While invisible, you are untargetable by enemies. Lasts 20 sec. Taking any action cancels the effect.
    mass_polymorph           = { 62106, 383121, 1 }, -- Transforms all enemies within 10 yards into sheep, wandering around incapacitated for 1 min. While affected, the victims cannot take actions but will regenerate health very quickly. Damage will cancel the effect. Only works on Beasts, Humanoids and Critters.
    mass_slow                = { 62109, 391102, 1 }, -- Slow applies to all enemies within 5 yds of your target.
    master_of_time           = { 62102, 342249, 1 }, -- Reduces the cooldown of Alter Time by 10 sec. Alter Time resets the cooldown of Blink when you return to your original location.
    meteor                   = { 62090, 153561, 1 }, -- Calls down a meteor which lands at the target location after 3 sec, dealing 5,044 Fire damage, split evenly between all targets within 8 yards, and burns the ground, dealing 1,280 Fire damage over 8.5 sec to all enemies in the area.
    mirror_image             = { 62124, 55342 , 1 }, -- Creates 3 copies of you nearby for 40 sec, which cast spells and attack your enemies. While your images are active damage taken is reduced by 20%. Taking direct damage will cause one of your images to dissipate.
    overflowing_energy       = { 62120, 390218, 1 }, -- Your spell critical strike damage is increased by 10%. When your direct damage spells fail to critically strike a target, your spell critical strike chance is increased by 2%, up to 10% for 8 sec. When your spells critically strike Overflowing Energy is reset.
    quick_witted             = { 62104, 382297, 1 }, -- Successfully interrupting an enemy with Counterspell reduces its cooldown by 4 sec.
    reabsorption             = { 62125, 382820, 1 }, -- You are healed for 5% of your maximum health whenever a Mirror Image dissipates due to direct damage.
    reduplication            = { 62125, 382569, 1 }, -- Mirror Image's cooldown is reduced by 10 sec whenever a Mirror Image dissipates due to direct damage.
    remove_curse             = { 62116, 475   , 1 }, -- Removes all Curses from a friendly target.
    rigid_ice                = { 62110, 382481, 1 }, -- Frost Nova can withstand 80% more damage before breaking.
    ring_of_frost            = { 62088, 113724, 1 }, -- Summons a Ring of Frost for 10 sec at the target location. Enemies entering the ring are incapacitated for 10 sec. Limit 10 targets. When the incapacitate expires, enemies are slowed by 65% for 4 sec.
    rune_of_power            = { 62113, 116011, 1 }, -- Places a Rune of Power on the ground for 12 sec which increases your spell damage by 40% while you stand within 8 yds. Casting Combustion will also create a Rune of Power at your location.
    shifting_power           = { 62085, 382440, 1 }, -- Draw power from the Night Fae, dealing 4,113 Nature damage over 3.5 sec to enemies within 18 yds. While channeling, your Mage ability cooldowns are reduced by 12 sec over 3.5 sec.
    shimmer                  = { 62105, 212653, 1 }, -- Teleports you 20 yards forward, unless something is in the way. Unaffected by the global cooldown and castable while casting. Gain a shield that absorbs 3% of your maximum health for 15 sec after you Shimmer.
    slow                     = { 62097, 31589 , 1 }, -- Reduces the target's movement speed by 50% for 15 sec.
    spellsteal               = { 62084, 30449 , 1 }, -- Steals a beneficial magic effect from the target. This effect lasts a maximum of 2 min.
    tempest_barrier          = { 62111, 382289, 2 }, -- Gain a shield that absorbs 3% of your maximum health for 15 sec after you Blink.
    temporal_velocity        = { 62099, 382826, 2 }, -- Increases your movement speed by 5% for 2 sec after casting Blink and 20% for 5 sec after returning from Alter Time.
    temporal_warp            = { 62094, 386539, 1 }, -- While you have Temporal Displacement or other similar effects, you may use Time Warp to grant yourself 30% Haste for 40 sec.
    time_anomaly             = { 62094, 383243, 1 }, -- At any moment, you have a chance to gain Combustion for 5 sec, 1 Fire Blast charge, or Time Warp for 6 sec.
    time_manipulation        = { 62129, 387807, 2 }, -- Casting Fire Blast reduces the cooldown of your loss of control abilities by 1 sec.
    tome_of_antonidas        = { 62098, 382490, 1 }, -- Increases Haste by 2%.
    tome_of_rhonin           = { 62127, 382493, 1 }, -- Increases Critical Strike chance by 2%.
    volatile_detonation      = { 62089, 389627, 1 }, -- Greatly increases the effect of Blast Wave's knockback. Blast Wave's cooldown is reduced by 5 seconds.
    winters_protection       = { 62123, 382424, 2 }, -- The cooldown of Ice Block is reduced by 20 sec.

    -- Fire
    alexstraszas_fury        = { 62220, 235870, 1 }, -- Phoenix Flames and Dragon's Breath always critically strikes and Dragon's Breath deals 50% increased critical strike damage contributes to Hot Streak.
    blazing_barrier          = { 62119, 235313, 1 }, -- Shields you in flame, absorbing 8,622 damage for 1 min. Melee attacks against you cause the attacker to take 242 Fire damage.
    call_of_the_sun_king     = { 62210, 343222, 1 }, -- Phoenix Flames gains 1 additional charge.
    cauterize                = { 62206, 86949 , 1 }, -- Fatal damage instead brings you to 35% health and then burns you for 28% of your maximum health over 6 sec. While burning, movement slowing effects are suppressed and your movement speed is increased by 150%. This effect cannot occur more than once every 5 min.
    combustion               = { 62207, 190319, 1 }, -- Engulfs you in flames for 10 sec, increasing your spells' critical strike chance by 100% . Castable while casting other spells.
    conflagration            = { 62188, 205023, 1 }, -- Fireball applies Conflagration to the target, dealing an additional 145 Fire damage over 8 sec. Enemies affected by either Conflagration or Ignite have a 10% chance to flare up and deal 131 Fire damage to nearby enemies.
    controlled_destruction   = { 62204, 383669, 2 }, -- Pyroblast's initial damage is increased by 5% when the target is above 70% health or below 30% health.
    critical_mass            = { 62219, 117216, 2 }, -- Your spells have a 15% increased chance to deal a critical strike. You gain 10% more of the Critical Strike stat from all sources.
    feel_the_burn            = { 62195, 383391, 2 }, -- Fire Blast increases your Mastery by 3% for 5 sec. This effect stacks up to 3 times.
    fervent_flickering       = { 62216, 387044, 1 }, -- Ignite's damage has a 5% chance to reduce the cooldown of Fire Blast by 1 sec.
    fevered_incantation      = { 62187, 383810, 2 }, -- Each consecutive critical strike you deal increases critical strike damage you deal by 1%, up to 5% for 6 sec.
    fiery_rush               = { 62203, 383634, 1 }, -- While Combustion is active, your Fire Blast and Phoenix Flames recharge 50% faster.
    fire_blast               = { 62214, 108853, 1 }, -- Blasts the enemy for 2,047 Fire damage. Fire: Castable while casting other spells. Always deals a critical strike.
    firefall                 = { 62197, 384033, 1 }, -- Damaging an enemy with 30 Fireballs or Pyroblasts causes your next Fireball to call down a Meteor on your target. Hitting an enemy player counts as double.
    firemind                 = { 62208, 383499, 2 }, -- Consuming Hot Streak grants you 1% increased Intellect for 12 sec. This effect stacks up to 3 times.
    firestarter              = { 62083, 205026, 1 }, -- Your Fireball and Pyroblast spells always deal a critical strike when the target is above 90% health.
    flame_accelerant         = { 62200, 203275, 2 }, -- If you have not cast Fireball for 8 sec, your next Fireball will deal 70% increased damage with a 40% reduced cast time.
    flame_on                 = { 62190, 205029, 2 }, -- Reduces the cooldown of Fire Blast by 2 seconds and increases the maximum number of charges by 1.
    flame_patch              = { 62193, 205037, 1 }, -- Flamestrike leaves behind a patch of flames that burns enemies within it for 788 Fire damage over 8 sec.
    flamestrike              = { 62192, 2120  , 1 }, -- Calls down a pillar of fire, burning all enemies within the area for 1,240 Fire damage and reducing their movement speed by 20% for 8 sec.
    from_the_ashes           = { 62220, 342344, 1 }, -- Increases Mastery by 2% for each charge of Phoenix Flames off cooldown and your direct-damage critical strikes reduce its cooldown by 1 sec.
    hyperthermia             = { 62186, 383860, 1 }, -- When Hot Streak activates, you have a low chance to cause all Pyroblasts and Flamestrikes to have no cast time and be guaranteed critical strikes for 5 sec.
    improved_combustion      = { 62201, 383967, 1 }, -- Combustion grants Mastery equal to 50% of your Critical Strike stat and lasts 2 sec longer.
    improved_flamestrike     = { 62191, 343230, 1 }, -- Flamestrike's cast time is reduced by 1.0 sec and its radius is increased by 15%.
    improved_scorch          = { 62211, 383604, 2 }, -- Casting Scorch on targets below 30% health increase the target's damage taken from you by 4% for 8 sec, stacking up to 3 times. Additionally, Scorch critical strikes increase your movement speed by 30% for 3 sec.
    incendiary_eruptions     = { 62189, 383665, 1 }, -- Enemies damaged by Flame Patch have an 5% chance to erupt into a Living Bomb.
    kindling                 = { 62198, 155148, 1 }, -- Your Fireball, Pyroblast, Fire Blast, and Phoenix Flames critical strikes reduce the remaining cooldown on Combustion by 1.0 sec.
    living_bomb              = { 62194, 44457 , 1 }, -- The target becomes a Living Bomb, taking 581 Fire damage over 3.5 sec, and then exploding to deal an additional 340 Fire damage to the target and reduced damage to all other enemies within 10 yards. Other enemies hit by this explosion also become a Living Bomb, but this effect cannot spread further.
    master_of_flame          = { 62196, 384174, 1 }, -- Ignite deals 15% more damage while Combustion is not active. Fire Blast spreads Ignite to 4 additional nearby targets during Combustion.
    phoenix_flames           = { 62217, 257541, 1 }, -- Hurls a Phoenix that deals 1,641 Fire damage to the target and reduced damage to other nearby enemies. Always deals a critical strike.
    phoenix_reborn           = { 62199, 383476, 1 }, -- Targets affected by your Ignite have a chance to erupt in flame, taking 242 additional Fire damage and reducing the remaining cooldown of Phoenix Flames by 10 sec.
    pyroblast                = { 62215, 11366 , 1 }, -- Hurls an immense fiery boulder that causes 2,929 Fire damage. Pyroblast's initial damage is increased by 5% when the target is above 70% health or below 30% health.
    pyroclasm                = { 62209, 269650, 1 }, -- Consuming Hot Streak has a 15% chance to make your next non-instant Pyroblast cast within 15 sec deal 230% additional damage. Maximum 2 stacks.
    pyromaniac               = { 62197, 205020, 1 }, -- Casting Pyroblast or Flamestrike while Hot Streak is active has an 8% chance to instantly reactivate Hot Streak.
    pyrotechnics             = { 62218, 157642, 1 }, -- Each time your Fireball fails to critically strike a target, it gains a stacking 10% increased critical strike chance. Effect ends when Fireball critically strikes.
    scorch                   = { 62213, 2948  , 1 }, -- Scorches an enemy for 397 Fire damage. Castable while moving.
    searing_touch            = { 62212, 269644, 1 }, -- Scorch deals 150% increased damage and is a guaranteed Critical Strike when the target is below 30% health.
    sun_kings_blessing       = { 62205, 383886, 1 }, -- After consuming 8 Hot Streaks, your next non-instant Pyroblast or Flamestrike cast within 15 sec grants you Combustion for 6 sec.
    tempered_flames          = { 62201, 383659, 1 }, -- Pyroblast has a 30% reduced cast time and a 10% increased critical strike chance. The duration of Combustion is reduced by 50%.
    wildfire                 = { 62202, 383489, 2 }, -- Ignite deals 5% additional damage. When you activate Combustion, you gain 4% Critical Strike, and up to 4 nearby allies gain 1% Critical Strike for 10 sec.
} )


-- PvP Talents
spec:RegisterPvpTalents( {
    flamecannon       = 647 , -- (203284) After standing still in combat for 2 sec, your maximum health increases by 3%, damage done increases by 3%, and range of your Fire spells increase by 3 yards. This effect stacks up to 5 times and lasts for 3 sec.
    glass_cannon      = 5495, -- (390428) Increases damage of Fireball and Scorch by 40% but decreases your maximum health by 15%.
    greater_pyroblast = 648 , -- (203286) Hurls an immense fiery boulder that deals up to 35% of the target's total health in Fire damage.
    ice_wall          = 5489, -- (352278) Conjures an Ice Wall 30 yards long that obstructs line of sight. The wall has 40% of your maximum health and lasts up to 15 sec.
    netherwind_armor  = 53  , -- (198062) Reduces the chance you will suffer a critical strike by 10%.
    precognition      = 5493, -- (377360) If an interrupt is used on you while you are not casting, gain 15% haste and become immune to control and interrupt effects for 4 sec.
    prismatic_cloak   = 828 , -- (198064) After you Shimmer, you take 50% less magical damage for 2 sec.
    pyrokinesis       = 646 , -- (203283) Your Fireball reduces the cooldown of your Combustion by 2 sec.
    ring_of_fire      = 5389, -- (353082) Summons a Ring of Fire for 8 sec at the target location. Enemies entering the ring burn for 24% of their total health over 6 sec.
    world_in_flames   = 644 , -- (203280) Flamestrike reduces the cast time of Flamestrike by 50% and increases its damage by 30% for 3 sec.
} )


-- Auras
spec:RegisterAuras( {
    -- Talent: Altering Time. Returning to past location and health when duration expires.
    -- https://wowhead.com/beta/spell=342246
    alter_time = {
        id = 110909,
        duration = 10,
        type = "Magic",
        max_stack = 1,
        copy = 342246
    },
    arcane_intellect = {
        id = 1459,
        duration = 3600,
        type = "Magic",
        max_stack = 1,
        shared = "player", -- use anyone's buff on the player, not just player's.
    },
    -- Talent: Movement speed reduced by $s2%.
    -- https://wowhead.com/beta/spell=157981
    blast_wave = {
        id = 157981,
        duration = 6,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Absorbs $w1 damage.  Melee attackers take $235314s1 Fire damage.
    -- https://wowhead.com/beta/spell=235313
    blazing_barrier = {
        id = 235313,
        duration = 60,
        type = "Magic",
        max_stack = 1
    },
    -- $s1% increased movement speed and unaffected by movement speed slowing effects.
    -- https://wowhead.com/beta/spell=108843
    blazing_speed = {
        id = 108843,
        duration = 6,
        max_stack = 1
    },
    -- Blinking.
    -- https://wowhead.com/beta/spell=1953
    blink = {
        id = 1953,
        duration = 0.3,
        type = "Magic",
        max_stack = 1
    },
    -- Movement speed reduced by $w1%.
    -- https://wowhead.com/beta/spell=12486
    blizzard = {
        id = 12486,
        duration = 3,
        mechanic = "snare",
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Burning away $s1% of maximum health every $t1 sec.
    -- https://wowhead.com/beta/spell=87023
    cauterize = {
        id = 87023,
        duration = 6,
        max_stack = 1
    },
    -- You have recently benefited from Cauterize and cannot benefit from it again.
    -- https://wowhead.com/beta/spell=87024
    cauterized = {
        id = 87024,
        duration = 300,
        max_stack = 1
    },
    -- Movement speed reduced by $w1%.
    -- https://wowhead.com/beta/spell=205708
    chilled = {
        id = 205708,
        duration = 8,
        max_stack = 1
    },
    -- Talent: Critical Strike chance of your spells increased by $w1%.$?a383967[  Mastery increased by $w2.][]
    -- https://wowhead.com/beta/spell=190319
    combustion = {
        id = 190319,
        duration = function()
            return ( talent.improved_combustion.enabled and 12 or 10 )
                * ( talent.tempered_flames.enabled and 0.5 or 1 )
        end,
        type = "Magic",
        max_stack = 1
    },
    -- Movement speed reduced by $s1%.
    -- https://wowhead.com/beta/spell=212792
    cone_of_cold = {
        id = 212792,
        duration = 5,
        max_stack = 1
    },
    -- Talent: Deals $w1 Fire damage every $t1 sec.
    -- https://wowhead.com/beta/spell=226757
    conflagration = {
        id = 226757,
        duration = 8,
        tick_time = 2,
        type = "Magic",
        max_stack = 1
    },
    -- Able to teleport back to where last Blinked from.
    -- https://wowhead.com/beta/spell=389714
    displacement_beacon = {
        id = 389714,
        duration = 8,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Disoriented.
    -- https://wowhead.com/beta/spell=31661
    dragons_breath = {
        id = 31661,
        duration = 4,
        type = "Magic",
        max_stack = 1
    },
    -- Time Warp also increases the rate at which time passes by $s1%.
    -- https://wowhead.com/beta/spell=320919
    echoes_of_elisande = {
        id = 320919,
        duration = 3600,
        max_stack = 3
    },
    -- Talent: Mastery increased by ${$w1*$mas}%.
    -- https://wowhead.com/beta/spell=383395
    feel_the_burn = {
        id = 383395,
        duration = 5,
        max_stack = 3,
        copy = { "infernal_cascade", 336832 }
    },
    -- Talent: Your spells deal an additional $w1% critical hit damage.
    -- https://wowhead.com/beta/spell=383811
    fevered_incantation = {
        id = 383811,
        duration = 6,
        type = "Magic",
        max_stack = 5,
        copy = 333049
    },
    -- Talent: Your Fire Blast and Phoenix Flames recharge $s1% faster.
    -- https://wowhead.com/beta/spell=383637
    fiery_rush = {
        id = 383637,
        duration = 3600,
        type = "Magic",
        max_stack = 1
    },
    firefall = {
        id = 384035,
        duration = 30,
        max_stack = 30
    },
    firefall_ready = {
        id = 384038,
        duration = 30,
        max_stack = 1
    },
    -- Talent: Increases Intellect by $w1%.
    -- https://wowhead.com/beta/spell=383501
    firemind = {
        id = 383501,
        duration = 12,
        max_stack = 3
    },
    -- Talent: Cast time of your Fireball reduced by $203275m1%, and damage increased by $203275m2%.
    -- https://wowhead.com/beta/spell=203278
    flame_accelerant = {
        id = 203278,
        duration = 8,
        max_stack = 1
    },
    -- Talent: Burning
    -- https://wowhead.com/beta/spell=205470
    flame_patch = {
        id = 205470,
        duration = 8,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Movement speed slowed by $s2%.
    -- https://wowhead.com/beta/spell=2120
    flamestrike = {
        id = 2120,
        duration = 8,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Frozen in place.
    -- https://wowhead.com/beta/spell=386770
    freezing_cold = {
        id = 386770,
        duration = 5,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Movement speed reduced by $w1%
    -- https://wowhead.com/beta/spell=394255
    freezing_cold_snare = {
        id = 394255,
        duration = 3,
        mechanic = "snare",
        type = "Magic",
        max_stack = 1
    },
    -- Movement speed increased by $s1%.
    -- https://wowhead.com/beta/spell=236060
    frenetic_speed = {
        id = 236060,
        duration = 3,
        max_stack = 1
    },
    -- Frozen in place.
    -- https://wowhead.com/beta/spell=122
    frost_nova = {
        id = 122,
        duration = function() return talent.improved_frost_nova.enabled and 8 or 6 end,
        type = "Magic",
        max_stack = 1
    },
    -- Movement speed reduced by $w1%.
    -- https://wowhead.com/beta/spell=289308
    frozen_orb = {
        id = 289308,
        duration = 3,
        mechanic = "snare",
        max_stack = 1
    },
    -- Frozen in place.
    -- https://wowhead.com/beta/spell=228600
    glacial_spike = {
        id = 228600,
        duration = 4,
        type = "Magic",
        max_stack = 1
    },
    heating_up = {
        id = 48107,
        duration = 10,
        max_stack = 1,
    },
    hot_streak = {
        id = 48108,
        duration = 15,
        type = "Magic",
        max_stack = 1,
    },
    -- Talent: Pyroblast and Flamestrike have no cast time and are guaranteed to critically strike.
    -- https://wowhead.com/beta/spell=383874
    hyperthermia = {
        id = 383874,
        duration = 5,
        max_stack = 1
    },
    -- Cannot be made invulnerable by Ice Block.
    -- https://wowhead.com/beta/spell=41425
    hypothermia = {
        id = 41425,
        duration = 30,
        max_stack = 1
    },
    -- Talent: Frozen.
    -- https://wowhead.com/beta/spell=157997
    ice_nova = {
        id = 157997,
        duration = 2,
        type = "Magic",
        max_stack = 1
    },
    -- Deals $w1 Fire damage every $t1 sec.$?$w3>0[  Movement speed reduced by $w3%.][]
    -- https://wowhead.com/beta/spell=12654
    ignite = {
        id = 12654,
        duration = 9,
        tick_time = 1,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Taking $383604s3% increased damage from $@auracaster's spells and abilities.
    -- https://wowhead.com/beta/spell=383608
    improved_scorch = {
        id = 383608,
        duration = 12,
        type = "Magic",
        max_stack = 3
    },
    incantation_of_swiftness = {
        id = 382294,
        duration = 6,
        max_stack = 1,
        copy = 337278,
    },
    -- Talent: Increases spell damage by $w1%.
    -- https://wowhead.com/beta/spell=116267
    incanters_flow = {
        id = 116267,
        duration = 25,
        max_stack = 5,
        meta = {
            stack = function() return state.incanters_flow_stacks end,
            stacks = function() return state.incanters_flow_stacks end,
        }
    },
    -- Spell damage increased by $w1%.
    -- https://wowhead.com/beta/spell=384280
    invigorating_powder = {
        id = 384280,
        duration = 12,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Causes $w1 Fire damage every $t1 sec. After $d, the target explodes, causing $w2 Fire damage to the target and all other enemies within $44461A2 yards, and spreading Living Bomb.
    -- https://wowhead.com/beta/spell=217694
    living_bomb = {
        id = 217694,
        duration = 4,
        tick_time = 1,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Causes $w1 Fire damage every $t1 sec. After $d, the target explodes, causing $w2 Fire damage to the target and all other enemies within $44461A2 yards.
    -- https://wowhead.com/beta/spell=244813
    living_bomb_spread = { -- TODO: Check for differentiation in SimC.
        id = 244813,
        duration = 4,
        tick_time = 1,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Incapacitated. Cannot attack or cast spells.  Increased health regeneration.
    -- https://wowhead.com/beta/spell=383121
    mass_polymorph = {
        id = 383121,
        duration = 60,
        mechanic = "polymorph",
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Movement speed reduced by $w1%.
    -- https://wowhead.com/beta/spell=391104
    mass_slow = {
        id = 391104,
        duration = 15,
        mechanic = "snare",
        type = "Magic",
        max_stack = 1
    },
    -- Burning for $w1 Fire damage every $t1 sec.
    -- https://wowhead.com/beta/spell=155158
    meteor_burn = {
        id = 155158,
        duration = 10,
        tick_time = 1,
        type = "Magic",
        max_stack = 3
    },
    --[[ Burning for $w1 Fire damage every $t1 sec.
    -- https://wowhead.com/beta/spell=175396
    meteor_burn = { -- AOE ground effect?
        id = 175396,
        duration = 8.5,
        type = "Magic",
        max_stack = 1
    }, ]]
    -- Talent: Damage taken is reduced by $s3% while your images are active.
    -- https://wowhead.com/beta/spell=55342
    mirror_image = {
        id = 55342,
        duration = 40,
        max_stack = 3,
        generate = function( mi )
            if action.mirror_image.lastCast > 0 and query_time < action.mirror_image.lastCast + 40 then
                mi.count = 1
                mi.applied = action.mirror_image.lastCast
                mi.expires = mi.applied + 40
                mi.caster = "player"
                return
            end

            mi.count = 0
            mi.applied = 0
            mi.expires = 0
            mi.caster = "nobody"
        end,
    },
    -- Covenant: Attacking, casting a spell or ability, consumes a mirror to inflict Shadow damage and reduce cast and movement speed by $320035s3%.     Your final mirror will instead Root and Silence you for $317589d.
    -- https://wowhead.com/beta/spell=314793
    mirrors_of_torment = {
        id = 314793,
        duration = 25,
        type = "Magic",
        max_stack = 3
    },
    -- Absorbs $w1 damage.  Magic damage taken reduced by $s3%.  Duration of all harmful Magic effects reduced by $w4%.
    -- https://wowhead.com/beta/spell=235450
    prismatic_barrier = {
        id = 235450,
        duration = 60,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Suffering $w1 Fire damage every $t2 sec.
    -- https://wowhead.com/beta/spell=321712
    pyroblast = {
        id = 321712,
        duration = 6,
        tick_time = 2,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Damage done by your next non-instant Pyroblast increased by $s1%.
    -- https://wowhead.com/beta/spell=269651
    pyroclasm = {
        id = 269651,
        duration = 15,
        max_stack = 2
    },
    -- Talent: Increases critical strike chance of Fireball by $s1%$?a337224[ and your Mastery by ${$s2}.1%][].
    -- https://wowhead.com/beta/spell=157644
    pyrotechnics = {
        id = 157644,
        duration = 15,
        max_stack = 10,
        copy = "fireball"
    },
    -- Talent: Incapacitated.
    -- https://wowhead.com/beta/spell=82691
    ring_of_frost = {
        id = 82691,
        duration = 10,
        mechanic = "freeze",
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Movement speed slowed by $s1%.
    -- https://wowhead.com/beta/spell=321329
    ring_of_frost_snare = {
        id = 321329,
        duration = 4,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Spell damage increased by $w1%.$?$w2=0[][  Health restored by $w2% per second.]
    -- https://wowhead.com/beta/spell=116014
    rune_of_power = {
        id = 116014,
        duration = 12,
        max_stack = 1
    },
    -- Talent: Every $t1 sec, deal $382445s1 Nature damage to enemies within $382445A1 yds and reduce the remaining cooldown of your abilities by ${-$s2/1000} sec.
    -- https://wowhead.com/beta/spell=382440
    shifting_power = {
        id = 382440,
        duration = 4,
        tick_time = 1,
        type = "Magic",
        max_stack = 1,
        copy = 314791
    },
    -- Talent: Shimmering.
    -- https://wowhead.com/beta/spell=212653
    shimmer = {
        id = 212653,
        duration = 0.65,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Movement speed reduced by $w1%.
    -- https://wowhead.com/beta/spell=31589
    slow = {
        id = 31589,
        duration = 15,
        mechanic = "snare",
        type = "Magic",
        max_stack = 1
    },
    sun_kings_blessing = {
        id = 383882,
        duration = 30,
        max_stack = 8,
        copy = 333314
    },
    -- Talent: Your next non-instant Pyroblast will grant you Combustion.
    -- https://wowhead.com/beta/spell=383883
    sun_kings_blessing_ready = {
        id = 383883,
        duration = 15,
        max_stack = 5,
        copy = 333315,
        meta = {
            expiration_delay_remains = function()
                return buff.sun_kings_blessing_ready_expiration_delay.remains
            end,
        },
    },
    sun_kings_blessing_ready_expiration_delay = {
        duration = 0.03,
    },
    -- Talent: Absorbs $w1 damage.
    -- https://wowhead.com/beta/spell=382290
    tempest_barrier = {
        id = 382290,
        duration = 15,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Movement speed increased by $w1%.
    -- https://wowhead.com/beta/spell=382824
    temporal_velocity_alter_time = {
        id = 382824,
        duration = 5,
        max_stack = 1
    },
    -- Talent: Movement speed increased by $w1%.
    -- https://wowhead.com/beta/spell=384360
    temporal_velocity_blink = {
        id = 384360,
        duration = 2,
        max_stack = 1
    },
    -- Talent: Haste increased by $w1%.
    -- https://wowhead.com/beta/spell=386540
    temporal_warp = {
        id = 386540,
        duration = 40,
        max_stack = 1
    },
    -- Frozen in time for $d.
    -- https://wowhead.com/beta/spell=356346
    timebreakers_paradox = {
        id = 356346,
        duration = 8,
        mechanic = "stun",
        max_stack = 1
    },
    -- Rooted and Silenced.
    -- https://wowhead.com/beta/spell=317589
    tormenting_backlash = {
        id = 317589,
        duration = 4,
        type = "Magic",
        max_stack = 1
    },
    -- Suffering $w1 Fire damage every $t1 sec.
    -- https://wowhead.com/beta/spell=277703
    trailing_embers = {
        id = 277703,
        duration = 6,
        tick_time = 2,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Critical Strike increased by $w1%.
    -- https://wowhead.com/beta/spell=383493
    wildfire = {
        id = 383493,
        duration = 10,
        max_stack = 1
    },


    -- Legendaries
    expanded_potential = {
        id = 327495,
        duration = 300,
        max_stack = 1
    },
    firestorm = {
        id = 333100,
        duration = 4,
        max_stack = 1
    },
    molten_skyfall = {
        id = 333170,
        duration = 30,
        max_stack = 18
    },
    molten_skyfall_ready = {
        id = 333182,
        duration = 30,
        max_stack = 1
    },
} )


spec:RegisterStateTable( "firestarter", setmetatable( {}, {
    __index = setfenv( function( t, k )
        if k == "active" then return talent.firestarter.enabled and target.health.pct > 90
        elseif k == "remains" then
            if not talent.firestarter.enabled or target.health.pct <= 90 then return 0 end
            return target.time_to_pct_90
        end
    end, state )
} ) )

spec:RegisterStateTable( "searing_touch", setmetatable( {}, {
    __index = setfenv( function( t, k )
        if k == "active" then return talent.searing_touch.enabled and target.health.pct < 30
        elseif k == "remains" then
            if not talent.searing_touch.enabled or target.health.pct < 30 then return 0 end
            return target.time_to_die
        end
    end, state )
} ) )

spec:RegisterTotem( "rune_of_power", 609815 )


spec:RegisterGear( "tier30", 202554, 202552, 202551, 202550, 202549 )
spec:RegisterAuras( {
    charring_embers = {
        id = 408665,
        duration = 12,
        max_stack = 1
    },
    calefaction = {
        id = 408673,
        duration = 60,
        max_stack = 20
    },
    flames_fury = {
        id = 409964,
        duration = 30,
        max_stack = 2
    }
} )


spec:RegisterGear( "tier29", 200318, 200320, 200315, 200317, 200319 )


spec:RegisterHook( "reset_precast", function ()
    if pet.rune_of_power.up then applyBuff( "rune_of_power", pet.rune_of_power.remains )
    else removeBuff( "rune_of_power" ) end

    incanters_flow.reset()
end )

spec:RegisterHook( "runHandler", function( action )
    if buff.ice_floes.up then
        local ability = class.abilities[ action ]
        if ability and ability.cast > 0 and ability.cast < 10 then removeStack( "ice_floes" ) end
    end
end )

spec:RegisterHook( "advance", function ( time )
    if Hekili.ActiveDebug then Hekili:Debug( "\n*** Hot Streak (Advance) ***\n    Heating Up:  %.2f\n    Hot Streak:  %.2f\n", state.buff.heating_up.remains, state.buff.hot_streak.remains ) end
end )

spec:RegisterStateFunction( "hot_streak", function( willCrit )
    willCrit = willCrit or buff.combustion.up or stat.crit >= 100

    if Hekili.ActiveDebug then Hekili:Debug( "*** HOT STREAK (Cast/Impact) ***\n    Heating Up: %s, %.2f\n    Hot Streak: %s, %.2f\n    Crit: %s, %.2f", buff.heating_up.up and "Yes" or "No", buff.heating_up.remains, buff.hot_streak.up and "Yes" or "No", buff.hot_streak.remains, willCrit and "Yes" or "No", stat.crit ) end

    if willCrit then
        if buff.heating_up.up then removeBuff( "heating_up" ); applyBuff( "hot_streak" )
        elseif buff.hot_streak.down then applyBuff( "heating_up" ) end

        if talent.fevered_incantation.enabled then addStack( "fevered_incantation" ) end
        if talent.from_the_ashes.enabled then gainChargeTime( "phoenix_flames", 1 ) end

        if Hekili.ActiveDebug then Hekili:Debug( "*** HOT STREAK END ***\nHeating Up: %s, %.2f\nHot Streak: %s, %.2f", buff.heating_up.up and "Yes" or "No", buff.heating_up.remains, buff.hot_streak.up and "Yes" or "No", buff.hot_streak.remains ) end
        return true
    end

    -- Apparently it's safe to not crit within 0.2 seconds.
    if buff.heating_up.up then
        if query_time - buff.heating_up.applied > 0.2 then
            if Hekili.ActiveDebug then Hekili:Debug( "May not crit; Heating Up was applied %.2f ago, so removing Heating Up..", query_time - buff.heating_up.applied ) end
            removeBuff( "heating_up" )
        else
            if Hekili.ActiveDebug then Hekili:Debug( "May not crit; Heating Up was applied %.2f ago, so ignoring the non-crit impact.", query_time - buff.heating_up.applied ) end
        end
    end

    if Hekili.ActiveDebug then Hekili:Debug( "*** HOT STREAK END ***\nHeating Up: %s, %.2f\nHot Streak: %s, %.2f\n***", buff.heating_up.up and "Yes" or "No", buff.heating_up.remains, buff.hot_streak.up and "Yes" or "No", buff.hot_streak.remains ) end
end )


local hot_streak_spells = {
    -- "dragons_breath",
    "fireball",
    -- "fire_blast",
    "phoenix_flames",
    "pyroblast",
    -- "scorch",
}
spec:RegisterStateExpr( "hot_streak_spells_in_flight", function ()
    local count = 0

    for i, spell in ipairs( hot_streak_spells ) do
        if state:IsInFlight( spell ) then count = count + 1 end
    end

    return count
end )

spec:RegisterStateExpr( "expected_kindling_reduction", function ()
    -- This only really works well in combat; we'll use the old APL value instead of dynamically updating for now.
    return 0.4
end )


Hekili:EmbedDisciplinaryCommand( spec )

-- # APL Variable Option: If set to a non-zero value, the Combustion action and cooldowns that are constrained to only be used when Combustion is up will not be used during the simulation.
-- actions.precombat+=/variable,name=disable_combustion,op=reset
spec:RegisterVariable( "disable_combustion", function ()
    return false
end )

-- # APL Variable Option: This variable specifies whether Combustion should be used during Firestarter.
-- actions.precombat+=/variable,name=firestarter_combustion,default=-1,value=runeforge.sun_kings_blessing|talent.sun_kings_blessing,if=variable.firestarter_combustion<0
spec:RegisterVariable( "firestarter_combustion", function ()
    return talent.sun_kings_blessing.enabled or runeforge.sun_kings_blessing.enabled
end )

-- # APL Variable Option: This variable specifies the number of targets at which Hot Streak Flamestrikes outside of Combustion should be used.
-- actions.precombat+=/variable,name=hot_streak_flamestrike,if=variable.hot_streak_flamestrike=0,value=2*talent.flame_patch+999*!talent.flame_patch
spec:RegisterVariable( "hot_streak_flamestrike", function ()
    if talent.flame_patch.enabled then return 2 end
    return 999
end )

-- # APL Variable Option: This variable specifies the number of targets at which Hard Cast Flamestrikes outside of Combustion should be used as filler.
-- actions.precombat+=/variable,name=hard_cast_flamestrike,if=variable.hard_cast_flamestrike=0,value=3*talent.flame_patch+999*!talent.flame_patch
spec:RegisterVariable( "hard_cast_flamestrike", function ()
    if talent.flame_patch.enabled then return 3 end
    return 999
end )

-- # APL Variable Option: This variable specifies the number of targets at which Hot Streak Flamestrikes are used during Combustion.
-- actions.precombat+=/variable,name=combustion_flamestrike,if=variable.combustion_flamestrike=0,value=3*talent.flame_patch+999*!talent.flame_patch
spec:RegisterVariable( "combustion_flamestrike", function ()
    if talent.flame_patch.enabled then return 3 end
    return 999
end )

-- # APL Variable Option: This variable specifies the number of targets at which Arcane Explosion outside of Combustion should be used.
-- actions.precombat+=/variable,name=arcane_explosion,if=variable.arcane_explosion=0,value=999
spec:RegisterVariable( "arcane_explosion", function ()
    return 999
end )

-- # APL Variable Option: This variable specifies the percentage of mana below which Arcane Explosion will not be used.
-- actions.precombat+=/variable,name=arcane_explosion_mana,default=40,op=reset
spec:RegisterVariable( "arcane_explosion_mana", function ()
    return 40
end )

-- # APL Variable Option: The number of targets at which Shifting Power can used during Combustion.
-- actions.precombat+=/variable,name=combustion_shifting_power,if=variable.combustion_shifting_power=0,value=variable.combustion_flamestrike
spec:RegisterVariable( "combustion_shifting_power", function ()
    return variable.combustion_flamestrike
end )

-- # APL Variable Option: The time remaining on a cast when Combustion can be used in seconds.
-- actions.precombat+=/variable,name=combustion_cast_remains,default=0.3,op=reset
spec:RegisterVariable( "combustion_cast_remains", function ()
    return 0.3
end )

-- # APL Variable Option: This variable specifies the number of seconds of Fire Blast that should be pooled past the default amount.
-- actions.precombat+=/variable,name=overpool_fire_blasts,default=0,op=reset
spec:RegisterVariable( "overpool_fire_blasts", function ()
    return 0
end )

-- # APL Variable Option: How long before Combustion should Empyreal Ordnance be used?
-- actions.precombat+=/variable,name=empyreal_ordnance_delay,default=18,op=reset
spec:RegisterVariable( "empyreal_ordnance_delay", function ()
    return 18
end )

-- # APL Variable Option: How much delay should be inserted after consuming an SKB proc before spending a Hot Streak? The APL will always delay long enough to prevent the SKB stack from being wasted.
-- actions.precombat+=/variable,name=skb_delay,default=-1,value=0,if=variable.skb_delay<0
spec:RegisterVariable( "skb_delay", function ()
    return 0
end )

-- # The duration of a Sun King's Blessing Combustion.
-- actions.precombat+=/variable,name=skb_duration,op=set,value=5
spec:RegisterVariable( "skb_duration", function ()
    return 5
end )

-- # The number of seconds of Fire Blast recharged by Mirrors of Torment
-- actions.precombat+=/variable,name=mot_recharge_amount,value=dbc.effect.871274.base_value
spec:RegisterVariable( "mot_recharge_amount", function ()
    return 6
end )


-- # Whether a usable item used to buff Combustion is equipped.
-- actions.precombat+=/variable,name=combustion_on_use,value=equipped.gladiators_badge|equipped.macabre_sheet_music|equipped.inscrutable_quantum_device|equipped.sunblood_amethyst|equipped.empyreal_ordnance|equipped.flame_of_battle|equipped.wakeners_frond|equipped.instructors_divine_bell|equipped.shadowed_orb_of_torment|equipped.the_first_sigil|equipped.neural_synapse_enhancer|equipped.fleshrenders_meathook|equipped.enforcers_stun_grenade
spec:RegisterVariable( "combustion_on_use", function ()
    return equipped.gladiators_badge or equipped.macabre_sheet_music or equipped.inscrutable_quantum_device or equipped.sunblood_amethyst or equipped.empyreal_ordnance or equipped.flame_of_battle or equipped.wakeners_frond or equipped.instructors_divine_bell or equipped.shadowed_orb_of_torment or equipped.the_first_sigil or equipped.neural_synapse_enhancer or equipped.fleshrenders_meathook or equipped.enforcers_stun_grenade
end )

-- # How long before Combustion should trinkets that trigger a shared category cooldown on other trinkets not be used?
-- actions.precombat+=/variable,name=on_use_cutoff,op=set,value=20,if=variable.combustion_on_use
-- actions.precombat+=/variable,name=on_use_cutoff,op=set,value=25,if=equipped.macabre_sheet_music
-- actions.precombat+=/variable,name=on_use_cutoff,op=set,value=20+variable.empyreal_ordnance_delay,if=equipped.empyreal_ordnance
spec:RegisterVariable( "on_use_cutoff", function ()
    if equipped.empyreal_ordnance then return 20 + variable.empyreal_ordnance_delay end
    if equipped.macabre_sheet_music then return 25 end
    if variable.combustion_on_use then return 20 end
    return 0
end )

-- # Variable that estimates whether Shifting Power will be used before the next Combustion.
-- actions+=/variable,name=shifting_power_before_combustion,value=variable.time_to_combustion>cooldown.shifting_power.remains
spec:RegisterVariable( "shifting_power_before_combustion", function ()
    if variable.time_to_combustion > cooldown.shifting_power.remains then
        return 1
    end
    return 0
end )


-- actions+=/variable,name=item_cutoff_active,value=(variable.time_to_combustion<variable.on_use_cutoff|buff.combustion.remains>variable.skb_duration&!cooldown.item_cd_1141.remains)&((trinket.1.has_cooldown&trinket.1.cooldown.remains<variable.on_use_cutoff)+(trinket.2.has_cooldown&trinket.2.cooldown.remains<variable.on_use_cutoff)+(equipped.neural_synapse_enhancer&cooldown.enhance_synapses_300612.remains<variable.on_use_cutoff)>1)
spec:RegisterVariable( "item_cutoff_active", function ()
    return ( variable.time_to_combustion < variable.on_use_cutoff or buff.combustion.remains > variable.skb_duration and cooldown.hyperthread_wristwraps.remains ) and safenum( safenum( trinket.t1.has_use_buff and trinket.t1.cooldown.remains < variable.on_use_cutoff ) + safenum( trinket.t2.has_use_buff and trinket.t2.cooldown.remains < variable.on_use_cutoff ) + safenum( equipped.neural_synapse_enhancer and cooldown.neural_synapse_enhancer.remains < variable.on_use_cutoff ) > 1 )
end )

-- fire_blast_pooling relies on the flow of the APL for differing values before/after rop_phase.

-- # Variable that controls Phoenix Flames usage to ensure its charges are pooled for Combustion when needed. Only use Phoenix Flames outside of Combustion when full charges can be obtained during the next Combustion.
-- actions+=/variable,name=phoenix_pooling,if=active_enemies<variable.combustion_flamestrike,value=(variable.time_to_combustion+buff.combustion.duration-5<action.phoenix_flames.full_recharge_time+cooldown.phoenix_flames.duration-action.shifting_power.full_reduction*variable.shifting_power_before_combustion&variable.time_to_combustion<fight_remains|talent.sun_kings_blessing)&!talent.alexstraszas_fury
-- # When using Flamestrike in Combustion, save as many charges as possible for Combustion without capping.
-- actions+=/variable,name=phoenix_pooling,if=active_enemies>=variable.combustion_flamestrike,value=(variable.time_to_combustion<action.phoenix_flames.full_recharge_time-action.shifting_power.full_reduction*variable.shifting_power_before_combustion&variable.time_to_combustion<fight_remains|talent.sun_kings_blessing)&!talent.alexstraszas_fury
spec:RegisterVariable( "phoenix_pooling", function ()
    local val = 0
    if active_enemies < variable.combustion_flamestrike then
        val = ( variable.time_to_combustion + buff.combustion.duration - 5 <  action.phoenix_flames.full_recharge_time + cooldown.phoenix_flames.duration - action.shifting_power.full_reduction * variable.shifting_power_before_combustion and variable.time_to_combustion < fight_remains or talent.sun_kings_blessing.enabled ) and not talent.alexstraszas_fury.enabled
    end

    if active_enemies>=variable.combustion_flamestrike then
        val = ( variable.time_to_combustion < action.phoenix_flames.full_recharge_time - action.shifting_power.full_reduction * variable.shifting_power_before_combustion and variable.time_to_combustion < fight_remains or ( runeforge.sun_kings_blessing.enabled or talent.sun_kings_blessing.enabled ) or time < 5 ) and not talent.alexstraszas_fury.enabled
    end

    return val
end )

-- # Estimate how long Combustion will last thanks to Sun King's Blessing to determine how Fire Blasts should be used.
-- actions.combustion_phase+=/variable,use_off_gcd=1,use_while_casting=1,name=extended_combustion_remains,value=buff.combustion.remains+buff.combustion.duration*(cooldown.combustion.remains<buff.combustion.remains)
-- # Adds the duration of the Sun King's Blessing Combustion to the end of the current Combustion if the cast would start during this Combustion.
-- actions.combustion_phase+=/variable,use_off_gcd=1,use_while_casting=1,name=extended_combustion_remains,op=add,value=variable.skb_duration,if=(runeforge.sun_kings_blessing|talent.sun_kings_blessing)&(buff.sun_kings_blessing_ready.up|variable.extended_combustion_remains>gcd.remains+1.5*gcd.max*(buff.sun_kings_blessing.max_stack-buff.sun_kings_blessing.stack))
spec:RegisterVariable( "extended_combustion_remains", function ()
    local value = 0
    if cooldown.combustion.remains < buff.combustion.remains then
        value = buff.combustion.remains + buff.combustion.duration
    end
    if ( talent.sun_kings_blessing.enabled or runeforge.sun_kings_blessing.enabled ) and ( buff.sun_kings_blessing_ready.up or value > gcd.remains + 1.5 * gcd.max * ( buff.sun_kings_blessing.max_stack - buff.sun_kings_blessing.stack ) ) then
        value = value + variable.skb_duration
    end
    return value
end )

-- # With Feel the Burn, Fire Blast use should be additionally constrained so that it is not be used unless Feel the Burn is about to expire or there are more than enough Fire Blasts to extend Feel the Burn to the end of Combustion.
-- actions.combustion_phase+=/variable,use_off_gcd=1,use_while_casting=1,name=expected_fire_blasts,value=action.fire_blast.charges_fractional+(variable.extended_combustion_remains-buff.feel_the_burn.duration)%cooldown.fire_blast.duration,if=talent.feel_the_burn|conduit.infernal_cascade

spec:RegisterVariable( "expected_fire_blasts", function ()
    if talent.feel_the_burn.enabled or conduit.infernal_cascade.enabled then
        return action.fire_blast.charges_fractional + ( variable.extended_combustion_remains - buff.feel_the_burn.duration ) / cooldown.fire_blast.duration
    end
    return 0
end )

-- actions.combustion_phase+=/variable,use_off_gcd=1,use_while_casting=1,name=needed_fire_blasts,value=ceil(variable.extended_combustion_remains%(buff.feel_the_burn.duration-gcd.max)),if=talent.feel_the_burn|conduit.infernal_cascade
spec:RegisterVariable( "needed_fire_blasts", function ()
    if talent.feel_the_burn.enabled or conduit.infernal_cascade.enabled then
        return ceil( variable.extended_combustion_remains / ( buff.feel_the_burn.duration - gcd.max ) )
    end
    return 0
end )

-- # Use Shifting Power during Combustion when there are not enough Fire Blasts available to fully extend Feel the Burn and only when Rune of Power is on cooldown.
-- actions.combustion_phase+=/variable,use_off_gcd=1,use_while_casting=1,name=use_shifting_power,value=firestarter.remains<variable.extended_combustion_remains&((talent.feel_the_burn|conduit.infernal_cascade)&variable.expected_fire_blasts<variable.needed_fire_blasts)&(!talent.rune_of_power|cooldown.rune_of_power.remains>variable.extended_combustion_remains)|active_enemies>=variable.combustion_shifting_power,if=covenant.night_fae
spec:RegisterVariable( "use_shifting_power", function ()
    if action.shifting_power.known then
        return firestarter.remains < variable.extended_combustion_remains and ( ( talent.feel_the_burn.enabled or conduit.infernal_cascade.enabled ) and variable.expected_fire_blasts < variable.needed_fire_blasts ) and ( not talent.rune_of_power.enabled or cooldown.rune_of_power.remains > variable.extended_combustion_remains ) or active_enemies >= variable.combustion_shifting_power
    end
    return 0
end )

-- # Helper variable that contains the actual estimated time that the next Combustion will be ready.
-- actions.combustion_timing=variable,use_off_gcd=1,use_while_casting=1,name=combustion_ready_time,value=cooldown.combustion.remains*expected_kindling_reduction
spec:RegisterVariable( "combustion_ready_time", function ()
    return cooldown.combustion.remains_expected
end )

-- # The cast time of the spell that will be precast into Combustion.
-- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=combustion_precast_time,value=(action.fireball.cast_time*!conduit.flame_accretion+action.scorch.cast_time+conduit.flame_accretion)*(active_enemies<variable.combustion_flamestrike)+action.flamestrike.cast_time*(active_enemies>=variable.combustion_flamestrike)-variable.combustion_cast_remains
spec:RegisterVariable( "combustion_precast_time", function ()
    return ( ( not conduit.flame_accretion.enabled and action.fireball.cast_time or 0 ) + action.scorch.cast_time + ( conduit.flame_accretion.enabled and 1 or 0 ) ) * ( ( active_enemies < variable.combustion_flamestrike ) and 1 or 0 ) + ( ( active_enemies >= variable.combustion_flamestrike ) and action.flamestrike.cast_time or 0 ) - variable.combustion_cast_remains
end )

spec:RegisterVariable( "time_to_combustion", function ()
    -- # Delay Combustion for after Firestarter unless variable.firestarter_combustion is set.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,value=variable.combustion_ready_time
    local value = variable.combustion_ready_time

    -- # Use the next Combustion on cooldown if it would not be expected to delay the scheduled one or the scheduled one would happen less than 20 seconds before the fight ends.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,value=variable.combustion_ready_time,if=variable.combustion_ready_time+cooldown.combustion.duration*(1-(0.4+0.2*talent.firestarter)*talent.kindling)<=variable.time_to_combustion|variable.time_to_combustion>fight_remains-20
    if variable.combustion_ready_time + cooldown.combustion.duration * ( 1 - ( 0.6 + 0.2 * ( talent.firestarter.enabled and 1 or 0 ) ) * ( talent.kindling.enabled and 1 or 0 ) ) <= value or boss and value > fight_remains - 20 then
        return value
    end

    -- # Delay Combustion for after Firestarter unless variable.firestarter_combustion is set.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=firestarter.remains,if=talent.firestarter&!variable.firestarter_combustion
    if talent.firestarter.enabled and not variable.firestarter_combustion then
        value = max( value, firestarter.remains )
    end

    -- # Delay Combustion until SKB is ready during Firestarter
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=(buff.sun_kings_blessing.max_stack-buff.sun_kings_blessing.stack)*(3*gcd.max),if=talent.sun_kings_blessing&firestarter.active&buff.sun_kings_blessing_ready.down
    if talent.sun_kings_blessing.enabled and firestarter.active and buff.sun_kings_blessing_ready.down then
        value = max( value, ( buff.sun_kings_blessing.max_stack - buff.sun_kings_blessing.stack ) * ( 3 * gcd.max ) )
    end

    -- # Delay Combustion for Radiant Spark if it will come off cooldown soon.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=cooldown.radiant_spark.remains,if=covenant.kyrian&cooldown.radiant_spark.remains-10<variable.time_to_combustion
    if action.radiant_spark.known then
        value = max( value, cooldown.radiant_spark.remains )
    end

    -- # Delay Combustion for Mirrors of Torment
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=cooldown.mirrors_of_torment.remains,if=covenant.venthyr&cooldown.mirrors_of_torment.remains-25<variable.time_to_combustion
    if action.mirrors_of_torment.known and cooldown.mirrors_of_torment.remains - 25 < value then
        value = max( value, cooldown.mirrors_of_torment.remains )
    end

    -- # Delay Combustion for Deathborne.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=cooldown.deathborne.remains+(buff.deathborne.duration-buff.combustion.duration)*runeforge.deaths_fathom,if=covenant.necrolord&cooldown.deathborne.remains-10<variable.time_to_combustion
    if action.deathborne.known and cooldown.deathborne.remains - 10 < value then
        value = max( value, cooldown.deathborne.remains + ( buff.deathborne.duration - buff.combustion.duration ) * ( runeforge.deaths_fathom.enabled and 1 or 0 ) )
    end

    -- # Delay Combustion for Death's Fathom stacks if there are at least two targets.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=buff.deathborne.remains-buff.combustion.duration,if=runeforge.deaths_fathom&buff.deathborne.up&active_enemies>=2
    if runeforge.deaths_fathom.enabled and buff.deathborne.up and active_enemies > 1 then
        value = max( value, buff.deathborne.remains - buff.combustion.duration )
    end

    -- # Delay Combustion for the Empyreal Ordnance buff if the player is using that trinket.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=variable.empyreal_ordnance_delay-(cooldown.empyreal_ordnance.duration-cooldown.empyreal_ordnance.remains)*!cooldown.empyreal_ordnance.ready,if=equipped.empyreal_ordnance
    if equipped.empyreal_ordnance then
        value = max( value, variable.empyreal_ordnance_delay - ( cooldown.empyreal_ordnance.duration - cooldown.empyreal_ordnance.remains ) * ( cooldown.empyreal_ordnance.ready and 0 or 1 ) )
    end

    -- # Delay Combustion for Gladiators Badge, unless it would be delayed longer than 20 seconds.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=cooldown.gladiators_badge_345228.remains,if=equipped.gladiators_badge&cooldown.gladiators_badge_345228.remains-20<variable.time_to_combustion
    if equipped.gladiators_badge and cooldown.gladiators_badge.remains - 20 < value then
        value = max( value, cooldown.gladiators_badge.remains )
    end

    -- # Delay Combustion until Combustion expires if it's up.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=buff.combustion.remains
    value = max( value, buff.combustion.remains )

    -- # Delay Combustion until RoP expires if it's up.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=buff.rune_of_power.remains,if=talent.rune_of_power&buff.combustion.down
    if talent.rune_of_power.enabled and buff.combustion.down then
        value = max( value, buff.rune_of_power.remains )
    end

    -- # Delay Combustion for an extra Rune of Power if the Rune of Power would come off cooldown at least 5 seconds before Combustion would.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=cooldown.rune_of_power.remains+buff.rune_of_power.duration,if=talent.rune_of_power&buff.combustion.down&cooldown.rune_of_power.remains+5<variable.time_to_combustion
    if talent.rune_of_power.enabled and buff.combustion.down and cooldown.rune_of_power.remains + 5 < value then
        value = max( value, cooldown.rune_of_power.remains + buff.rune_of_power.duration )
    end

    -- # Delay Combustion if Disciplinary Command would not be ready for it yet.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=cooldown.buff_disciplinary_command.remains,if=runeforge.disciplinary_command&buff.disciplinary_command.down
    if runeforge.disciplinary_command.enabled and buff.disciplinary_command.down then
        value = max( value, cooldown.buff_disciplinary_command.remains )
    end

    -- # Raid Events: Delay Combustion for add spawns of 3 or more adds that will last longer than 15 seconds. These values aren't necessarily optimal in all cases.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,op=max,value=raid_event.adds.in,if=raid_event.adds.exists&raid_event.adds.count>=3&raid_event.adds.duration>15
    -- Unsupported, don't bother.

    -- # Raid Events: Always use Combustion with vulnerability raid events, override any delays listed above to make sure it gets used here.
    -- actions.combustion_timing+=/variable,use_off_gcd=1,use_while_casting=1,name=time_to_combustion,value=raid_event.vulnerable.in*!raid_event.vulnerable.up,if=raid_event.vulnerable.exists&variable.combustion_ready_time<raid_event.vulnerable.in
    -- Unsupported, don't bother.

    return value
end )

local ExpireSKB = setfenv( function()
    removeBuff( "sun_kings_blessing_ready" )
end, state )


spec:RegisterStateTable( "incanters_flow", {
    changed = 0,
    count = 0,
    direction = 0,

    startCount = 0,
    startTime = 0,
    startIndex = 0,

    values = {
        [0] = { 0, 1 },
        { 1, 1 },
        { 2, 1 },
        { 3, 1 },
        { 4, 1 },
        { 5, 0 },
        { 5, -1 },
        { 4, -1 },
        { 3, -1 },
        { 2, -1 },
        { 1, 0 }
    },

    f = CreateFrame( "Frame" ),
    fRegistered = false,

    reset = setfenv( function ()
        if talent.incanters_flow.enabled then
            if not incanters_flow.fRegistered then
                Hekili:ProfileFrame( "Incanters_Flow_Arcane", incanters_flow.f )
                -- One-time setup.
                incanters_flow.f:RegisterUnitEvent( "UNIT_AURA", "player" )
                incanters_flow.f:SetScript( "OnEvent", function ()
                    -- Check to see if IF changed.
                    if state.talent.incanters_flow.enabled then
                        local flow = state.incanters_flow
                        local name, _, count = FindUnitBuffByID( "player", 116267, "PLAYER" )
                        local now = GetTime()

                        if name then
                            if count ~= flow.count then
                                if count == 1 then flow.direction = 0
                                elseif count == 5 then flow.direction = 0
                                else flow.direction = ( count > flow.count ) and 1 or -1 end

                                flow.changed = GetTime()
                                flow.count = count
                            end
                        else
                            flow.count = 0
                            flow.changed = GetTime()
                            flow.direction = 0
                        end
                    end
                end )

                incanters_flow.fRegistered = true
            end

            if now - incanters_flow.changed >= 1 then
                if incanters_flow.count == 1 and incanters_flow.direction == 0 then
                    incanters_flow.direction = 1
                    incanters_flow.changed = incanters_flow.changed + 1
                elseif incanters_flow.count == 5 and incanters_flow.direction == 0 then
                    incanters_flow.direction = -1
                    incanters_flow.changed = incanters_flow.changed + 1
                end
            end

            if incanters_flow.count == 0 then
                incanters_flow.startCount = 0
                incanters_flow.startTime = incanters_flow.changed + floor( now - incanters_flow.changed )
                incanters_flow.startIndex = 0
            else
                incanters_flow.startCount = incanters_flow.count
                incanters_flow.startTime = incanters_flow.changed + floor( now - incanters_flow.changed )
                incanters_flow.startIndex = 0

                for i, val in ipairs( incanters_flow.values ) do
                    if val[1] == incanters_flow.count and val[2] == incanters_flow.direction then incanters_flow.startIndex = i; break end
                end
            end
        else
            incanters_flow.count = 0
            incanters_flow.changed = 0
            incanters_flow.direction = 0
        end
    end, state ),
} )

spec:RegisterStateExpr( "incanters_flow_stacks", function ()
    if not talent.incanters_flow.enabled then return 0 end

    local index = incanters_flow.startIndex + floor( query_time - incanters_flow.startTime )
    if index > 10 then index = index % 10 end

    return incanters_flow.values[ index ][ 1 ]
end )

spec:RegisterStateExpr( "incanters_flow_dir", function()
    if not talent.incanters_flow.enabled then return 0 end

    local index = incanters_flow.startIndex + floor( query_time - incanters_flow.startTime )
    if index > 10 then index = index % 10 end

    return incanters_flow.values[ index ][ 2 ]
end )

-- Seemingly, a very silly way to track Incanter's Flow...
local incanters_flow_time_obj = setmetatable( { __stack = 0 }, {
    __index = function( t, k )
        if not state.talent.incanters_flow.enabled then return 0 end

        local stack = t.__stack
        local ticks = #state.incanters_flow.values

        local start = state.incanters_flow.startIndex + floor( state.offset + state.delay )

        local low_pos, high_pos

        if k == "up" then low_pos = 5
        elseif k == "down" then high_pos = 6 end

        local time_since = ( state.query_time - state.incanters_flow.changed ) % 1

        for i = 0, 10 do
            local index = ( start + i )
            if index > 10 then index = index % 10 end

            local values = state.incanters_flow.values[ index ]

            if values[ 1 ] == stack and ( not low_pos or index <= low_pos ) and ( not high_pos or index >= high_pos ) then
                return max( 0, i - time_since )
            end
        end

        return 0
    end
} )

spec:RegisterStateTable( "incanters_flow_time_to", setmetatable( {}, {
    __index = function( t, k )
        incanters_flow_time_obj.__stack = tonumber( k ) or 0
        return incanters_flow_time_obj
    end
} ) )


-- Abilities
spec:RegisterAbilities( {
    -- Talent: Alters the fabric of time, returning you to your current location and health when cast a second time, or after 10 seconds. Effect negated by long distance or death.
    alter_time = {
        id = function () return buff.alter_time.down and 342247 or 342245 end,
        cast = 0,
        cooldown = function () return talent.master_of_time.enabled and 50 or 60 end,
        gcd = "off",
        school = "arcane",

        spend = 0.01,
        spendType = "mana",

        talent = "alter_time",
        startsCombat = false,

        handler = function ()
            if buff.alter_time.down then
                applyBuff( "alter_time" )
            else
                removeBuff( "alter_time" )
                if talent.master_of_time.enabled then setCooldown( "blink", 0 ) end
            end
        end,

        copy = { 342247, 342245 }
    },

    -- Causes an explosion of magic around the caster, dealing 513 Arcane damage to all enemies within 10 yards.
    arcane_explosion = {
        id = 1449,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "arcane",

        spend = 0.1,
        spendType = "mana",

        startsCombat = false,

        handler = function ()
        end,
    },

    -- Infuses the target with brilliance, increasing their Intellect by 5% for 1 |4hour:hrs;. If the target is in your party or raid, all party and raid members will be affected.
    arcane_intellect = {
        id = 1459,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "arcane",

        spend = 0.04,
        spendType = "mana",

        startsCombat = false,
        nobuff = "arcane_intellect",
        essential = true,

        handler = function ()
            applyBuff( "arcane_intellect" )
        end,
    },

    -- Talent: Causes an explosion around yourself, dealing 482 Fire damage to all enemies within 8 yards, knocking them back, and reducing movement speed by 70% for 6 sec.
    blast_wave = {
        id = 157981,
        cast = 0,
        cooldown = function() return talent.volatile_detonation.enabled and 25 or 30 end,
        gcd = "spell",
        school = "fire",

        talent = "blast_wave",
        startsCombat = true,

        usable = function () return target.distance < 8, "target must be in range" end,
        handler = function ()
            applyDebuff( "target", "blast_wave" )
        end,
    },

    -- Talent: Shields you in flame, absorbing 4,240 damage for 1 min. Melee attacks against you cause the attacker to take 127 Fire damage.
    blazing_barrier = {
        id = 235313,
        cast = 0,
        cooldown = 25,
        gcd = "spell",
        school = "fire",

        spend = 0.03,
        spendType = "mana",

        talent = "blazing_barrier",
        startsCombat = false,

        handler = function ()
            applyBuff( "blazing_barrier" )
            if legendary.triune_ward.enabled then
                applyBuff( "ice_barrier" )
                applyBuff( "prismatic_barrier" )
            end
        end,
    },

    -- Talent: Engulfs you in flames for 10 sec, increasing your spells' critical strike chance by 100% . Castable while casting other spells.
    combustion = {
        id = 190319,
        cast = 0,
        cooldown = 120,
        gcd = "off",
        dual_cast = true,
        school = "fire",

        spend = 0.1,
        spendType = "mana",

        talent = "combustion",
        startsCombat = false,

        toggle = "cooldowns",

        usable = function () return time > 0, "must already be in combat" end,
        handler = function ()
            applyBuff( "combustion" )
            stat.crit = stat.crit + 100

            if talent.rune_of_power.enabled then applyBuff( "rune_of_power" ) end
            if talent.wildfire.enabled or azerite.wildfire.enabled then applyBuff( "wildfire" ) end
        end,
    },

    -- Talent: Teleports you back to where you last Blinked. Only usable within 8 sec of Blinking.
    displacement = {
        id = 389713,
        cast = 0,
        cooldown = 45,
        gcd = "spell",
        school = "arcane",

        talent = "displacement",
        startsCombat = false,
        buff = "displacement_beacon",

        handler = function ()
            removeBuff( "displacement_beacon" )
        end,
    },

    -- Talent: Enemies in a cone in front of you take 595 Fire damage and are disoriented for 4 sec. Damage will cancel the effect. Always deals a critical strike and contributes to Hot Streak.
    dragons_breath = {
        id = 31661,
        cast = 0,
        cooldown = 45,
        gcd = "spell",
        school = "fire",

        spend = 0.04,
        spendType = "mana",

        talent = "dragons_breath",
        startsCombat = true,

        usable = function () return target.within12, "target must be within 12 yds" end,
        handler = function ()
            hot_streak( talent.alexstraszas_fury.enabled )
            applyDebuff( "target", "dragons_breath" )
            if talent.alexstraszas_fury.enabled then applyBuff( "alexstraszas_fury" ) end
        end,
    },

    -- Talent: Blasts the enemy for 962 Fire damage. Fire: Castable while casting other spells. Always deals a critical strike.
    fire_blast = {
        id = 108853,
        cast = 0,
        charges = function () return 1 + talent.flame_on.rank end,
        cooldown = function ()
            return ( talent.flame_on.enabled and 10 or 12 )
            * ( talent.fiery_rush.enabled and buff.combustion.up and 0.5 or 1 )
            * ( buff.memory_of_lucid_dreams.up and 0.5 or 1 ) * haste
        end,
        recharge = function () return ( talent.flame_on.enabled and 10 or 12 ) * ( buff.memory_of_lucid_dreams.up and 0.5 or 1 ) * haste end,
        icd = 0.5,
        gcd = "off",
        dual_cast = function() return state.spec.fire end,
        school = "fire",

        spend = 0.01,
        spendType = "mana",

        talent = "fire_blast",
        startsCombat = true,

        usable = function ()
            if time == 0 then return false, "no fire_blast out of combat" end
            return true
        end,

        handler = function ()
            hot_streak( true )
            applyDebuff( "target", "ignite" )

            if talent.feel_the_burn.enabled then addStack( "feel_the_burn" ) end
            if talent.kindling.enabled then setCooldown( "combustion", max( 0, cooldown.combustion.remains - 1 ) ) end
            if talent.master_of_flame.enabled and buff.combustion.up then active_dot.ignite = min( active_enemies, active_dot.ignite + 4 ) end

            if set_bonus.tier30_4pc > 0 and debuff.charring_embers.up then
                if buff.calefaction.stack == 19 then
                    removeBuff( "calefaction" )
                    applyBuff( "flames_fury", nil, 2 )
                else
                    addStack( "calefaction" )
                end
            end

            if azerite.blaster_master.enabled then addStack( "blaster_master" ) end
            if conduit.infernal_cascade.enabled and buff.combustion.up then addStack( "infernal_cascade" ) end
            if legendary.sinful_delight.enabled then gainChargeTime( "mirrors_of_torment", 4 ) end
        end,
    },

    -- Throws a fiery ball that causes 749 Fire damage. Each time your Fireball fails to critically strike a target, it gains a stacking 10% increased critical strike chance. Effect ends when Fireball critically strikes.
    fireball = {
        id = 133,
        cast = function() return 2.25 * ( buff.flame_accelerant.up and 0.6 or 1 ) * haste end,
        cooldown = 0,
        gcd = "spell",
        school = "fire",

        spend = 0.02,
        spendType = "mana",

        startsCombat = false,
        velocity = 45,

        usable = function ()
            if moving and settings.prevent_hardcasts and action.fireball.cast_time > buff.ice_floes.remains then return false, "prevent_hardcasts during movement and ice_floes is down" end
            return true
        end,

        handler = function ()
            removeBuff( "molten_skyfall_ready" )
        end,

        impact = function ()
            if hot_streak( firestarter.active or stat.crit + buff.fireball.stack * 10 >= 100 ) then
                removeBuff( "fireball" )
                if talent.kindling.enabled then setCooldown( "combustion", max( 0, cooldown.combustion.remains - 1 ) ) end
            else
                addStack( "fireball" )
                if conduit.flame_accretion.enabled then addStack( "flame_accretion" ) end
            end

            if buff.firefall_ready.up then
                action.meteor.impact()
                removeBuff( "firefall_ready" )
            end
            removeBuff( "flame_accelerant" )

            if talent.conflagration.enabled then applyDebuff( "target", "conflagration" ) end
            if talent.firefall.enabled then
                addStack( "firefall" )
                if buff.firefall.stack == buff.firefall.max_stack then
                    applyBuff( "firefall_ready" )
                    removeBuff( "firefall" )
                end
            end
            if talent.flame_accelerant.enabled then
                applyBuff( "flame_accelerant" )
                buff.flame_accelerant.applied = query_time + 8
                buff.flame_accelerate.expires = query_time + 8 + 8
            end

            if set_bonus.tier30_4pc > 0 and debuff.charring_embers.up then
                if buff.calefaction.stack == 19 then
                    removeBuff( "calefaction" )
                    applyBuff( "flames_fury", nil, 2 )
                else
                    addStack( "calefaction" )
                end
            end

            if legendary.molten_skyfall.enabled and buff.molten_skyfall_ready.down then
                addStack( "molten_skyfall" )
                if buff.molten_skyfall.stack == 18 then
                    removeBuff( "molten_skyfall" )
                    applyBuff( "molten_skyfall_ready" )
                end
            end

            applyDebuff( "target", "ignite" )
        end,
    },

    -- Talent: Calls down a pillar of fire, burning all enemies within the area for 526 Fire damage and reducing their movement speed by 20% for 8 sec.
    flamestrike = {
        id = 2120,
        cast = function () return ( buff.hot_streak.up or buff.firestorm.up or buff.hyperthermia.up ) and 0 or ( ( 4 - talent.improved_flamestrike.rank ) * haste ) end,
        cooldown = 0,
        gcd = "spell",
        school = "fire",

        spend = 0.025,
        spendType = "mana",

        talent = "flamestrike",
        startsCombat = true,

        handler = function ()
            if not hardcast then
                if buff.expanded_potential.up then removeBuff( "expanded_potential" )
                else
                    removeBuff( "hot_streak" )
                    if legendary.sun_kings_blessing.enabled then
                        addStack( "sun_kings_blessing" )
                        if buff.sun_kings_blessing.stack == 8 then
                            removeBuff( "sun_kings_blessing" )
                            applyBuff( "sun_kings_blessing_ready" )
                        end
                    end
                end
            end

            applyDebuff( "target", "ignite" )
            applyDebuff( "target", "flamestrike" )
            removeBuff( "alexstraszas_fury" )
        end,
    },

    frostbolt = {
        id = 116,
        cast = 1.874,
        cooldown = 0,
        gcd = "spell",
        school = "frost",

        spend = 0.02,
        spendType = "mana",

        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "chilled" )
            if debuff.radiant_spark.up and buff.radiant_spark_consumed.down then handle_radiant_spark() end
            if set_bonus.tier30_4pc > 0 and debuff.charring_embers.up then
                if buff.calefaction.stack == 19 then
                    removeBuff( "calefaction" )
                    applyBuff( "flames_fury", nil, 2 )
                else
                    addStack( "calefaction" )
                end
            end
        end,
    },


    invisibility = {
        id = 66,
        cast = 0,
        cooldown = 300,
        gcd = "spell",

        discipline = "arcane",

        spend = 0.03,
        spendType = "mana",

        toggle = "defensives",
        startsCombat = false,

        handler = function ()
            applyBuff( "preinvisibility" )
            applyBuff( "invisibility", 23 )
            if conduit.incantation_of_swiftness.enabled then applyBuff( "incantation_of_swiftness" ) end
        end,
    },

    -- Talent: The target becomes a Living Bomb, taking 245 Fire damage over 3.6 sec, and then exploding to deal an additional 143 Fire damage to the target and reduced damage to all other enemies within 10 yards. Other enemies hit by this explosion also become a Living Bomb, but this effect cannot spread further.
    living_bomb = {
        id = 44457,
        cast = 0,
        cooldown = 12,
        gcd = "spell",
        school = "fire",

        spend = 0.015,
        spendType = "mana",

        talent = "living_bomb",
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "living_bomb" )
        end,
    },

    -- Talent: Transforms all enemies within 10 yards into sheep, wandering around incapacitated for 1 min. While affected, the victims cannot take actions but will regenerate health very quickly. Damage will cancel the effect. Only works on Beasts, Humanoids and Critters.
    mass_polymorph = {
        id = 383121,
        cast = 1.7,
        cooldown = 60,
        gcd = "spell",
        school = "arcane",

        spend = 0.04,
        spendType = "mana",

        talent = "mass_polymorph",
        startsCombat = false,

        handler = function ()
            applyDebuff( "target", "mass_polymorph" )
        end,
    },

    -- Talent: Creates 3 copies of you nearby for 40 sec, which cast spells and attack your enemies. While your images are active damage taken is reduced by 20%. Taking direct damage will cause one of your images to dissipate.
    mirror_image = {
        id = 55342,
        cast = 0,
        cooldown = 120,
        gcd = "spell",
        school = "arcane",

        spend = 0.02,
        spendType = "mana",

        talent = "mirror_image",
        startsCombat = false,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "mirror_image" )
        end,
    },

    -- Talent: Hurls a Phoenix that deals 864 Fire damage to the target and reduced damage to other nearby enemies. Always deals a critical strike.
    phoenix_flames = {
        id = 257541,
        cast = 0,
        charges = function() return talent.call_of_the_sun_king.enabled and 3 or 2 end,
        cooldown = function() return 25 * ( talent.fiery_rush.enabled and buff.combustion.up and 0.5 or 1 ) end,
        recharge = function() return 25 * ( talent.fiery_rush.enabled and buff.combustion.up and 0.5 or 1 ) end,
        gcd = "spell",
        school = "fire",

        talent = "phoenix_flames",
        startsCombat = true,
        velocity = 50,

        impact = function ()
            if buff.flames_fury.up then
                gainCharges( "phoenix_flames", 1 )
                removeStack( "flames_fury" )
            end

            if hot_streak( firestarter.active ) and talent.kindling.enabled then
                setCooldown( "combustion", max( 0, cooldown.combustion.remains - 1 ) )
            end

            applyDebuff( "target", "ignite" )
            if active_dot.ignite < active_enemies then active_dot.ignite = active_enemies end

            if set_bonus.tier30_4pc > 0 and debuff.charring_embers.up then
                if buff.calefaction.stack == 19 then
                    removeBuff( "calefaction" )
                    applyBuff( "flames_fury", nil, 2 )
                else
                    addStack( "calefaction" )
                end
            end

            if set_bonus.tier30_2pc > 0 then
                applyDebuff( "target", "charring_embers" )
            end
        end,
    },


    polymorph = {
        id = 118,
        cast = 1.7,
        cooldown = 0,
        gcd = "spell",

        discipline = "arcane",

        spend = 0.04,
        spendType = "mana",

        startsCombat = false,
        texture = 136071,

        handler = function ()
            applyDebuff( "target", "polymorph" )
        end,
    },

    -- Talent: Hurls an immense fiery boulder that causes 1,311 Fire damage. Pyroblast's initial damage is increased by 5% when the target is above 70% health or below 30% health.
    pyroblast = {
        id = 11366,
        cast = function () return ( buff.hot_streak.up or buff.firestorm.up or buff.hyperthermia.up ) and 0 or ( 4.5 * ( talent.tempered_flames.enabled and 0.7 or 1 ) * haste ) end,
        cooldown = 0,
        gcd = "spell",
        school = "fire",

        spend = 0.02,
        spendType = "mana",

        talent = "pyroblast",
        startsCombat = true,

        usable = function ()
            if action.pyroblast.cast > 0 then
                if moving and settings.prevent_hardcasts and action.fireball.cast_time > buff.ice_floes.remains then return false, "prevent_hardcasts during movement and ice_floes is down" end
                if combat == 0 and not boss and not settings.pyroblast_pull then return false, "opener pyroblast disabled and/or target is not a boss" end
            end
            return true
        end,

        handler = function ()
            if hardcast then
                removeStack( "pyroclasm" )
                if buff.sun_kings_blessing_ready.up then
                    applyBuff( "combustion", 6 )
                    -- removeBuff( "sun_kings_blessing_ready" )
                    applyBuff( "sun_kings_blessing_ready_expiration_delay" )
                    state:QueueAuraExpiration( "sun_kings_blessing_ready_expiration_delay", ExpireSKB, buff.sun_kings_blessing_ready_expiration_delay.expires )
                end
            else
                if buff.hot_streak.up then
                    if buff.expanded_potential.up then removeBuff( "expanded_potential" )
                    else
                        removeBuff( "hot_streak" )
                        if legendary.sun_kings_blessing.enabled then
                            addStack( "sun_kings_blessing" )
                            if buff.sun_kings_blessing.stack == 12 then
                                removeBuff( "sun_kings_blessing" )
                                applyBuff( "sun_kings_blessing_ready" )
                            end
                        end
                    end
                end
            end
            removeBuff( "molten_skyfall_ready" )

            if talent.firefall.enabled then
                addStack( "firefall" )
                if buff.firefall.stack == buff.firefall.max_stack then
                    applyBuff( "firefall_ready" )
                    removeBuff( "firefall" )
                end
            end

            if set_bonus.tier30_4pc > 0 and debuff.charring_embers.up then
                if buff.calefaction.stack == 19 then
                    removeBuff( "calefaction" )
                    applyBuff( "flames_fury", nil, 2 )
                else
                    addStack( "calefaction" )
                end
            end
        end,

        velocity = 35,

        impact = function ()
            if hot_streak( firestarter.active or buff.firestorm.up or buff.hyperthermia.up ) then
                if talent.kindling.enabled then
                    setCooldown( "combustion", max( 0, cooldown.combustion.remains - 1 ) )
                end
            end

            if legendary.molten_skyfall.enabled and buff.molten_skyfall_ready.down then
                addStack( "molten_skyfall" )
                if buff.molten_skyfall.stack == 18 then
                    removeBuff( "molten_skyfall" )
                    applyBuff( "molten_skyfall_ready" )
                end
            end

            applyDebuff( "target", "ignite" )
            removeBuff( "alexstraszas_fury" )
        end,
    },

    -- Talent: Removes all Curses from a friendly target.
    remove_curse = {
        id = 475,
        cast = 0,
        cooldown = 8,
        gcd = "spell",
        school = "arcane",

        spend = 0.013,
        spendType = "mana",

        talent = "remove_curse",
        startsCombat = false,
        debuff = "dispellable_curse",
        handler = function ()
            removeDebuff( "player", "dispellable_curse" )
        end,
    },

    -- Talent: Places a Rune of Power on the ground for 12 sec which increases your spell damage by 40% while you stand within 8 yds. Casting Combustion will also create a Rune of Power at your location.
    rune_of_power = {
        id = 116011,
        cast = 1.5,
        cooldown = 45,
        gcd = "spell",
        school = "arcane",

        talent = "rune_of_power",
        startsCombat = false,
        nobuff = "rune_of_power",

        handler = function ()
            applyBuff( "rune_of_power" )
        end,
    },

    -- Talent: Scorches an enemy for 170 Fire damage. Castable while moving.
    scorch = {
        id = 2948,
        cast = 1.5,
        cooldown = 0,
        gcd = "spell",
        school = "fire",

        spend = 0.01,
        spendType = "mana",

        talent = "scorch",
        startsCombat = true,

        handler = function ()
            hot_streak( talent.searing_touch.enabled and target.health_pct < 30 )
            applyDebuff( "target", "ignite" )
            if talent.frenetic_speed.enabled then applyBuff( "frenetic_speed" ) end
            if talent.improved_scorch.enabled and target.health_pct < 30 then applyDebuff( "target", "improved_scorch", nil, debuff.scorch.stack + 1 ) end

            if set_bonus.tier30_4pc > 0 and debuff.charring_embers.up then
                if buff.calefaction.stack == 19 then
                    removeBuff( "calefaction" )
                    applyBuff( "flames_fury", nil, 2 )
                else
                    addStack( "calefaction" )
                end
            end
        end,
    },

    -- Talent: Draw power from the Night Fae, dealing 2,168 Nature damage over 3.6 sec to enemies within 18 yds. While channeling, your Mage ability cooldowns are reduced by 12 sec over 3.6 sec.
    shifting_power = {
        id = function() return talent.shifting_power.enabled and 382440 or 314791 end,
        cast = function() return 4 * haste end,
        channeled = true,
        cooldown = 60,
        gcd = "spell",
        school = "nature",

        spend = 0.05,
        spendType = "mana",

        startsCombat = true,

        cdr = function ()
            return - action.shifting_power.execute_time / action.shifting_power.tick_time * ( -3 + conduit.discipline_of_the_grove.time_value )
        end,

        full_reduction = function ()
            return - action.shifting_power.execute_time / action.shifting_power.tick_time * ( -3 + conduit.discipline_of_the_grove.time_value )
        end,

        start = function ()
            applyBuff( "shifting_power" )
        end,

        tick  = function ()
            local seen = {}
            for _, a in pairs( spec.abilities ) do
                if not seen[ a.key ] then
                    reduceCooldown( a.key, 3 )
                    seen[ a.key ] = true
                end
            end
        end,

        finish = function ()
            removeBuff( "shifting_power" )
        end,

        copy = { 382440, 314791 }
    },

    -- Talent: Reduces the target's movement speed by 50% for 15 sec.
    slow = {
        id = 31589,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "arcane",

        spend = 0.01,
        spendType = "mana",

        talent = "slow",
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "slow" )
        end,
    },
} )

spec:RegisterOptions( {
    enabled = true,

    aoe = 3,
    gcdSync = false,
    -- can_dual_cast = true,

    nameplates = false,
    nameplateRange = 8,

    damage = true,
    damageExpiration = 6,

    potion = "spectral_intellect",

    package = "Fire",
} )


spec:RegisterSetting( "pyroblast_pull", false, {
    name = strformat( "%s: Non-Instant Opener", Hekili:GetSpellLinkWithTexture( spec.abilities.pyroblast.id ) ),
    desc = strformat( "If checked, a non-instant %s may be recommended as an opener against bosses.", Hekili:GetSpellLinkWithTexture( spec.abilities.pyroblast.id ) ),
    type = "toggle",
    width = "full"
} )


spec:RegisterSetting( "prevent_hardcasts", false, {
    name = strformat( "%s and %s: Instant-Only When Moving", Hekili:GetSpellLinkWithTexture( spec.abilities.pyroblast.id ),
        Hekili:GetSpellLinkWithTexture( spec.abilities.fireball.id ) ),
    desc = strformat( "If checked, non-instant %s and %s casts will not be recommended while you are moving.\n\nAn exception is made if %s is talented and active and your cast "
        .. "would be complete before |W%s|w expires.", Hekili:GetSpellLinkWithTexture( spec.abilities.pyroblast.id ), Hekili:GetSpellLinkWithTexture( spec.abilities.fireball.id ),
        Hekili:GetSpellLinkWithTexture( 108839 ), ( GetSpellInfo( 108839 ) ) ),
    type = "toggle",
    width = "full"
} )

spec:RegisterStateExpr( "fireball_hardcast_prevented", function()
    return settings.prevent_hardcasts and moving and action.fireball.cast_time > 0 and buff.ice_floes.down
end )

spec:RegisterSetting( "check_explosion_range", true, {
    name = strformat( "%s: Range Check", Hekili:GetSpellLinkWithTexture( 1449 ) ),
    desc = strformat( "If checked, %s will not be recommended when you are more than 10 yards from your target.", Hekili:GetSpellLinkWithTexture( 1449 ) ),
    type = "toggle",
    width = "full"
} )


spec:RegisterPack( "Fire", 20230508, [[Hekili:S33AZTXnYI(Br7PIczKmTeLLJ3CL0TYgVjRZ5EYMAL3t(MihoeuCwpCgUZdjRTuXF73UB8yaWaGzOezw7TCvUSnNbdqJg9B0OXnNEZ7V565rvSB(LXNm(Sto)K3m60tp)Bp7MRREyn7MRxhf)HOBH)tw0k4V)XKc6HpKMhnh)2Y86Iy4rlRQwx(DV8L3MuTSE2O48vVSmzvDAuvsEwCr0Ik83XV8MRNvNKw9USBM5CGh)6BUoQUAzEXnxFDYQFa65K5Zz8MZkJV5AS5V4KZFXjV572mDZ0)(ASxk3mDrEXMPNEYOtpEZ0KS4065jz3Uz6QOSh2m9UOIKOzPy7kxMSOInh(GI8vBMUUijViPcAtvo(HvSISO0ntJZNZgT5N38Z8X7Sxm(eA8(FYNNS4b9VJg4)W7YkRIYQEXFnlfE2VTKLHT9oag(dWyYQQG)Nz)9Tu)93yRYVJTz61X5fXl3m9Qnt)1hkYNLgvwTz6YOI5X0)RmMLbtICT(4vV4KXI(4UKsV9boVIxYI)WMP)LC43xxvWI(WOBUonPSQexexxWGfSzrvWp(fIKikgx3G)TiokJnbrlPPS4QBUgGcapo)M)0nvWsh22MNO(mGQiDsYTzja28MRJlW)nj6MRpOzLajrMvxITFc8NAe(pCZuOfS)zDY61S5JMdW58faf3K7yLLSuQbdO2ufLYYQgHVeq7fq3psagBM(4JAJIwlM0mIBMousrBaQWu6mFtPLrZZVNnFsEXSj5lMuLxScabRzNc2RwYMaJDz1KYKBtsvJMNEbg4xPJ3xLuuKxmjzfX7zGZpxVDlas6Le7LvRETERwljgmBe8tD0dHPPMvQOd0qeWk0K7xMKYMGeKa1m2eINSiznFC(n81aXg)9BMIslMfLclCilIIK8yK7k7owbqm(xyr82(3xZPuJmOspqBQQapFuunTyY688uQB5KuZQxSy0YCyXGt7d)vCLKCIpa0xJa7i2hzX1vSjfSvrjzLe70TXZhP(nsGj(ifMv8v0yoK6z(yYNEtQxlhZJaMAfGmPCnWxvc8xtwKMC7s49xccXKqwmmlaYLSrKmlSFwdepfyxn)boCedsiULXbYt5pIg4fmw6eKiCwDrwdOFXMPJ3m9B4tOvrFezeCWhVv43DWevYoBa0kg6d7Co1A5PdmNsociyEYS8S6YrvjSIZozY41X8EyoJgte)wGFpB1mwr5iDIcBmjjvbztYxSyc8yIbXf5RbtZ7wSzAgsXRyBanwvlH)hWNqIfr2Ont)tnsZRksU9wwHjNcWKrQEsG(7hzO0savbFgGRGhwkrYicnkd(R7bbFW)W(4AQ7NXa9ymXh9t)WBH3KnVKZ5ID51cejWhJysExgDxuskrBWfNmNTiQoTYL4djEioVg1Xs0dwyI)mNXdbkq4aQrozLeIGppV9GAsOwuNHtIBzJMNugNSgOqJkEaf7dgbmxspfsVfoGtUpQyTfK9EeekbLKiI79eu9BqR4WtDzni24befIlqWsg0OKvRyZtaltWxGkCwxJYbVhmpc6b2Q15fOvg8EPextxgbFCcshKVczObIOg6yaLevKcKOhJTehvqVm(HRyimxIdo8tI1chX7ZlqkhCHBEoTQHJX9jimqeBGyFyHcn4bqOZNNGZteGAMCdkhIJvrE9TlZRReRdSmXc4Ont)E13L(WXCyVCjNQkk9(OheqfhHe10dZXjN4xl4cdky3cw6akZk5V7h0uvpJrtabRloLWrYpLGqysLajtRNgctgiKNW(4Yi(GmQEnNRNS)BDoy2kOJMGTj6YzOpBwAE(8u4dhnVUisAoHdthAaj67wNtdvZhDLMSvIYRk3WgLJedyZZuFSMUDQxvgq4GO(20iKseOiMmlAoAprdGfC8VsQMBsdz4l2m9CyuwSamgCc3MMw9V0ifhWcSM8aSqMc2)mplklU)aZfxQHTA1ntMZsJ4c27Ak1DNWNJ8jxBawAC1tZgXbDaGgttntKrt0rfVCrIhrkFqc220Ob7Entt0PQOLwLsrFgXAPA16Tto71F74xDQHgYxDIUL2(T99B9r6wKSAclonzD52rP8MNa2rcNgdkaCVXdWTkhu4Ma2cvKuUARGUZFgqN5OcG3F0lB)dRxI45OsWZ7KuHCd3M2bpB1eq5lA5c2b3P843D3aJ7PN4dVefhndm2PCjdSUAvDzs82HDutvhDeoW2Mw0YCkOLKDuG(iyqZtqfozVGSLcNOh3OFIE2BL(zUz6)RWrtqHxzYCMTYiqP3Ffi7lUhC3(yvmas(xm1y6OV46811O1HHAkDvKDAryFdUbIk1Z(6kUo10C0uJ87qdXOVUrRIPQvaIFpzVaOKVKJswrEKDxuAntyoj26gr8yh4AAqH0qynH0gK0yriEqWkosGIf2fLHcoHPCSWZUYYAU9CslD42J0yJWAwbQxrAYKssZMP)sEL6l54ZRRHw8FdaZxxI2gdaj3Iz5OVohEYSuXuS8HSyjul(()7)K(IszBBqKKmG12zFGvvossxAhxI(Zuzy(rs2ckwtO)0XrZzJahXXG0CPV3dEzmr0gu8XbKB0ZRtQA3u3bdXBixgOB8CzD2KpaitqDUaTA2Dc7Rc1SHwdShvXHS26RWaBnWHfihHr5t6TLuMtRLeuoHTv(gYjUgmuDZ03Xd8tJHRneJKLXa1cAraNWBEoRK4aj4gW4mjXuokuWbfJqCrZtWorybUYjoKNe8YehZ3H(DHiNemijOj7Kdbrz6awb3K5OfeGtH3094pYzmUmngrXJT8bG7dm3hWJtUh0TuDFr06stVQ7I4EOMre9J00nHU0ACB7uWNp0LHkTJuOHLk2VEYzV6p(MZ)wdtvo3GEYoQGN6lSGXOnHPtqi1smq3iGdLE4EHYKGNPGbUNgtSx15Sigo0kj(SydqVmFqsv)oX4aYj5depAaCfbK87iuql3Y0reAY2hetvZajtzdZKGpygde8G9MUgsj74)OUSsN23JEzU7LO3WOGFG9ur6dlVXf1vian5FwhLvvVcmZ)Uetppues2(YyiW2LfZHfXPBmpxIRGLXs(O17Gp7edYXaZceR7ZBRfPaoaTDBwuvv6wmJ7NPH2Dpck(Cn6(OpaRZWGSOa4l21qIvVJaIpxkauzvrDmnmZtUljJnzgfkQDle5ByqqZNdfGgvk2ctGEOA5dMb6ExauThaeC85abWYdJbS8UamTKlWbMtjlyTISH3wo5veNIA892Jym5S9NOVgv1aXipe((sQ)8fbsGgb8znl)Uil5t)DkyRfKP1)c86nMbB9NaTIOWX3fNeBfYPgJNULA0KeEBAfcBpoD3LHsTmcQtRRUONHrqUzh8hW3maFrhnqOB)jMm8EVvl0RKi6vKxm4SheIVgJPDg3gBDWfTlVe8S1dwnu8CjCOsvpP)ZzZBc9pTs4Qnt4B3zZsZbbAmznspw(oQzhMqsRz5PvJ0wdUQxaFJ7D9zL)C5kP)is(Fm4wtc4)9GSpuFpPrmlkJJVHtnUe1At1zFCn4gFcpAkJTTCA)Tu1eUjnmtWLocxUZx52)RldTe6JKdeY22GP9hYUB(I9aY93j0jxhkIpTT6lFnOSNv10EzVBP24xbOedmKmnD02PZs(ZBcJdLMnAHId700AMwafzFSILnNnxd07B0vj0QuYHANAhj2DD0Ef6DOVqh1n(VrkK12pVOonfaP51X8g(nADKztNW3pw7UDGAJP5zisPwG01Jp0lOnxFO5iSkhJVcFobMaIAZPgeNFhS2bDa8pGzHf0d1JnGJXQbVEz3B5a8NxQ1DAi4gAqoeFH7MHZmvMoCKUJt3Hbqkpvp5v63G5YPo177SdgIrN6RKzWqx8ogH2QDkcaFUWL92zyHN8Ubz6S9WzlcX(j(JVsFKf0TLL6Ih1gaNCJE6e9ySaCnctGXCwJN5AcuM(xVmIVJnJT9WYYFLyhwHtVWu3TUmzj5cpHPaMazAUOWJIaOXkwLejF5W(jU(s3dVIARlsSRCj7siRrWUZxw6CX9Qw7kLE822tHjM7g3eWd(vjuQmPlsbZasIYFcfUb0FXpW0q7T7)jKwxZGi6akelrkKVJM0sGQ7DTl4Ah)tAstXizSsBOVn(uI(12LC35ExBLRk9UU9D2tcCTZxwDjIJuvxYIOKPQkVoEPcv4u1RlYxG68m9CUYYAIVFopCHKFOYjTmEJX5zvf5PLwPtLyR1O9ikcbgttqUNNrJxZH7ntFpc4IKpra9b2oQrDiBhZze)r9iuad8AQIm4HgC6Uw3v81k50MuW2b(VdVBmSD1zMw2BdD0ZNc9wsORG79lpRRf7e7pQlUa3mNgBhpwUy3y5Pc9f0Ot(QnLnuXrRxZxI9RMYAT0e3jSL37QCxYPpXqnyr(6g9FNzhbN9R8JWKg(1T6vmXEvBJpH9cb9xTfQdgAAOJhgOl6R4TxSfUnmylyOmHYwzeRw8a6yM075RLbV7sP0SSYA8njO45gUw8rrP4oMIuM4YnX6(3aqKVzruwR2hbY2XmZnVZwXG0jRSsh42AgexORl7l6sCS0G22jUTM64MHQDwXdlZNmsSTLU8tgb)XpTuIMlh)Vio7l2sZp2wjD79UhjuUf3rOimTr0Ys6srs1qusu4cALdo0gzEwWnY8T1CRb(Xg8ElGIOi5qdpVPOnwfh35IV2iTI(jcA5jslakpy0bHMo8DJfjhlnsWxezCpakQ8iIBNI1KvnA64WY1Of00MTYhBCfVkc1HsFyRKwIiK2cfHUu35HgUtwhdTGADIXXzbxrTJ5xpoplF)DuUJju1Bjtsj7ryJi87SmgNN3kz5DtY3GuCl1x7eLG4hhkmUWNcJQK4p0OWGM(2HORNrlqjDkK)XUwu7P774HMBokBRiVsLAHNrH2qzfiDQ20bE6Sg0yXJJtBGjU1Vu1MdOITy1bEfEIc8EYHdyO1UZZhrYPVWocmhKtVCwErgtA5OwOQX3bsFH)oFLHLxDfjh7UwjD3J(OXMKY45LIwWEIOFVk1621(oBKEY94yJo8(D0bIHif55dEJgVljXnEw(8V)nFgmxAoGGvTZD)y98f7Pq17zC8lrYjJNNEXokO7aZ1cJtvs9SjTVOxu2(nxBGMfBUmklO5ChqjI1Ds7S0MAY(oQLpinNDWlvNNGbkxPG)(JWWev(VIarl1fp4EZVMxeDBEgGLkqPiYD8s4RL7498epOCu6zKJ2ZBOhwKYAO1j)T8FLNw1pKxJzygLSMljp9zj8uK048MMBEe6GVdtJbYAjE7)oaHenu2hRehqomDmRUhZO5uA6cgrnyMQvFFdEdJf0pwJ5bHaTGgtvtPooo0dIhgk0sGvHVLpfMtjPDsJTgi51MPUmoUuph9Cguk(qWPLrgi7yLVdyG8tJ3twRbY)Or0QD2CtAcCP7g4Xnf7Gk0ihZvSemKLPhfbTWwN75iaBaC2TyVdDbpaYdvm6EJgBqFdpOXOtYWm9PTyAeumvNED2UB5FyWtt8WNNyftjkczfsh1IAoj7VuRUket)nNtZqSIE0HZ16hXQVkKXgC(eVOVuXlOj0c9qC6cYxhVhnhTcbGboG)(YrkBQp6YxYxgoozXLUOtouqgMSADr(DS5t4n)qXUtB9yPbmxC23OcDVL6Ee0IbqBLgbHMPosBv1BwJPQoAONGtD4EEVS8bKx0wuLzI4P9RVXr3WzDPfx)(6qwaGi4tfmrHKdCyabarHmTXPptESoR1zWWqpsVS0yGz2TUEzoll5Jn6B42z46y8Fy3NIFh1db5GU9FQA9NJx4tf6mlOHDeGpVjekYVZtFkIF8pj7LCAdfiMiJrMnB3UeOfLYnIALr4vf)(Z5IRPv0kQCKw(b8k2WZAttQPUYVVsT6kDhSTZ0qcXUkklA0A5EF7TTtW21auUsArVjzVHGbZq7sQ(yzyvfafaalivLAhBpqx7T8inMl1WASrE42ZTijnLQafzLv8avUOrd9OEJCC6JgnT8N(iA1wawbEO14uU68JhOtbckTJzaWgrPmvKxVy5jHVUTkuOvSJ5vRKDjyOV4mp(clhXPvo5Fup)w5XWUJqq5TRMfDlLByfjXFOClJhKmhQ6cyXkPfidB1mxbBXGetCK7KEOwk3BP2Btq7tMRSn8tORDlrh)aiQMosuAFfNoL8BKI9UO1EDadSnk(jgVC9ib1SbGFy2e7moXojvgFIV0MsHOCf8hjm6(4bAB8by4HEGhoIhuIrJD(0ZmEQigehgmqf8OwXNbEGihbwsohYy1y9aP8HmOHin4s8W7vSnXc)1QH3xN5iKu(xNdAfVVJjKFHRVZ6qXHcuXv2JvNsprjJzjrgkl5p0ql8FjPAux89MX)Xt29zgLYGYH1ifTeeB7oupGRWby4tVGT2YvT(ohD5VKpNp0Ni(GJTtnYtGg4GnQJeRs1ybJ(i5W2wbyyxiE(qMt7222maORYC2jEvWrVi8E0O(EUD(998jOme275iiyleNkbb)sNj4tpoTbnbg2XCXZPMdbrHpaMTW(GGRYG9mwCrEAEH4JBIsTJT4QbbyU1Ao7yvQXB0THsmEv3i0N5mSwUEhZ9HwqxJns(Amp00z6ioPUF7ZyC8fZtpV(zmsTtbf7jvh5Os3JwGGg28nwAADzZOM1IumbPeKqP3LCUjDfD4sxKKLuUKn39zMxo4MPfS54BLxtBSRreM574gJQMMWIGz8A6gDYlBz17CAFws4LsgkDRkL7)HE3YfUJUQPof)8QQRyts4F79n4h(BX3zv)v2mfRcifTn(WtkhOwwdEOF8zKSt3Z7smFtaR8xNk1uYfSUp0JnrHlaYmYnJFZKxzvGkDicIJKuI36y7w6ITEOtTxcndh8msfId7yVccQw9iVX1KNCKgveuEsSmK7h0tylc(nzs)2o7P45YyT1EiuQjd4bvHBAvDggswKIQu4UiVv)Oe11WGoYzyF6Ie9)mP94qJQai42Xp1Mp1rfTzYzNCYPVAS0EehXfm8e0WcbnPqRzX8QyK25qZWnNmgBUDdu4jp2PAexZ(jY7cVvjgZie4UnI0B(cv(a4UzEHr)zzS8GWQMfiTSzR4DrNRZhUTRXbLGn45jeRF4iApE)exKNR452L8M(Op8lYA(pFznMeaoe0y2a3szcxEV)IiMaiOpxKVS9H0861uo6BMZ7TZG(nubaBzcUPsYBMddFjgecTeT9HNuppAEYRSp1H(f7OmfQzNNC5(jwMPYaS16OIpy7(j)DWsc(s)BTsKv(1vyKgCBmRs6IcAizDn3NzHFYLQIyQ48nevvxWl56Lyc7HSz2JeqEJWhDiGQ4vdv6uPie9GEoBojcg2BbJ84MCZOnDKF2NECtimM2(n)Xc(jsI5jyVTknwwZCNmjTXj(6D)bSDBtqfBUdpXZXz2J3lq1)T9IXjp1oJXiPpTUreCjwcj15lzmRSmJ8)7x5jEGytU1mpqfphEGvItIsLXSrDFdWdxdokFF(FEKZTXYLgWGEZh1eQq7nF7q9OzAL6gQgDHVwyucp0Kofi5w41WQNs4XWncl82VAevkuK1XToSGUeRTaR35QaJHP0xsjNgO1hZLvjVEnK0gkPBTL3S721kV1elTyL6yNT6(8R697FcQXOfx)PiZogL8Sb3EmE9DdaTrcDCqi2DibF0fn(d9uOkC81(4sRcw2A2XZ29(E32QmZOALz6K5kdOi5aV)Stityo2wrqPVd1kcu8tI5piskUnt)ZuwX5XQy6aUIDzZzraf)vAFIpzzMsK8MXGGO67q3qms2wxUu6xXEx2dDHmtq2TPaixDIpZD9LA0)QC70DI4CVBlsFrq1aA3VG0EI0AHMwI43CFT1j8u3LFNA57V8WEANf3X2WbbQlVxBjwQXI2NiHd)U4XBkWhI30(a)2AXszbJZdX97)RV9V(DBM(Us1wFfHKjvKFn8cjFoNzBo1Is2)3EXZ5841dZ1rNlxg6nx5wy5vRATIF)J6GgSRuHupDpAv7s61chDiocXA1MjfxkwYsx31rR3XX6NsYp1Lpf)qEGHCtUvO0MawYkUd3IxZDq07ACFth(EVsVBK)QXFxKVI4FJixYnyW7z4cf3Cd0YChxww9I4s7xOfCQJwIYlovo90QEoSLdNhAvFzlPE6Q22Ze1wQt7kOkxOP5rkBrvBAvkmgroOWXNljWjcAAt(ZCvJ8L3MGAjailTKfmUhodcRl7NHvwcH0HPSH76g8xsmtwCrRALAKB3X9pu(fljY7kRpvXcwBDDRkFQxAxq)TYNz)rmPp9BWi7FLLidrmlBsHjwflxVG1Drhtgdzv(lhyAkA2QcdLWm)Uwse(EiGE5SHpSB59QLCnH3xezSh2ARdMHl76DE6F5ksSZmxUweIE9y8gxc7BkqfuV7ZdG(EZ566krSZdsKxMe)7QWqJV10ipzAgkerdSI6BtbpwM8JiSUwRgQlphZcCjYV88p9MRDmB8rErY(AxFu2oXFFMwTtA3FE8bVdZicx6R0Fz7GDzNTKnYp7fjMOB8fO0RSvjymT6WCfFtlT4RlbFPir(VMSuuuTWsTlMtRsl40zg5er8NhzhJh9ZCThGp41rtPRD579fcFJUf3phk1afoBlTLHkTd0zEsy1JU0u5Z5YzLvVXN5jbRrbvxHKsxDQNOL1eRnlLH2rKt3K2UgEdN66Jo5U0R(uh)oruDeETQolgmFzjypVe4MtUJy16umu4JhRr33rz6(zvsaujDXNHNYF3yR(vuOnI2GlP6h2RSYkmXKUZtd03wqphabVnyVxkuCQd7tMc1IW4QdcukgcQ5E4g9mp6l16fPHgjEsK73QVlSstRHLsHT1hl3t9oYN7MGakUB6nR5SOPkwxwjGxAFcvMz266dZ)t(8Kfj0MKJL5YBLoJAKYnKpO8aOlPvX2PMkLJ6BQG0x1kkkPTSwLuf88o23iXgK4FGPu29Dv5q5z62)Pb2VmFXEVk4PY8ZoKNFmqVehziN8t5sAI)7W2T6CPhO0OyZlsXf2F8ncvIu6Dvw5lLgLVuAumlnknf0czSYuDCo)F1)wEOOKTGF)OI8ywTQ)7xLE2gIm3Sc0gAvuDmMj4OznqNR3iSMsGcrXJvI9KoGpZdmc6yo(93hvS20(0gdy90intlzFCzKJPh5bl(rUCwu2i7lSwOrlWR5FHaMwV2HJHI7u3IK5SAABW5LSg1q06noCxsuVPxNNKshYImwAfqNxxQjvXXlDzUeVRQYxro5xd8A4RKzIOc54(9Um(q0Ha2eLngVKe8fLsuaAOA7x6spmVRqZWwH7elGvlxgbCd3Yw10zUFTlDeIATsErgovUdgwTzO5JR4mI3bDk(2Fz8jJp7KxDYy86zUidDJ8MRFpA4DcsTvjSw(R1yCP4491ycZ(pRtOleF(v6DunGlJiRj5MFwoAZp))lbt4Ytp97qdTP9ebF)x7Pgt81CXM(ETKOhA2Gt)4WMU)mRUpC9xqok9Rkn05G5kAsYHiuKM6SJ9u5fAd(olmdT6(ZDd3gBqIfC7mBH6SJ9D(wTxD9D(xBnaVEFpaF7(c18gVlPQWr0E5SvKk6SBDeedlW1v8nS72XEOSB5JGvF71hIwdWFCpHNp7K9mKF24)nnaM5ZJnUXzY(001B(zhsYvvp2TteUn8Pj8u)EnWHSvxx7b2tFpmG7m07(HpC)Wg(5eSEQnJxO443gQ9he)ohibq6Fu82aVdX(Mh3NLd7UbWZISL3EwDVhFb7qmYC2IO60QTtiITzG7t708SAA4fLdmrlpSAHK9zl7oZAe)yPDmpL9aTh4PSgI81m(2BwYtFYV(av0maVIxnjgODwSycpShhoG8Q1D5V4s3VtD7)94Jh0fI)XhDL(8WFQlzhEWG(GsF8Xorjd1gM27L8vjzv4LJnwxLWsbGwoX9vF1ar4(KHk5Otpz4q5AXxWC(XCUrC(L0VZzHTL0VRhGX(LrSl8vCCaR929cQ)907DF(48S9EF8R(9Cwy7Y9EDWEDhYW7Z5k4IaCYhY5wDCCM1olnhniqpCKOhcEJS(nQoORRI1Jg4VAVOet(Ith20JRYrHpIR9VOv51zvFJDvP8Bg0Jks5fxgyAoC4xP6cnKLmRWFXPx461ANP7JuDoaBf4o1Px9zc35dSJGU8nb)SHF1xD6HbMsxyi4wsO(fkQF3OOE5(KIkCN7LIk4NnCRiOAKI53T6DRv1TgODVv1TIJ2EBU4jGD7W5IVq39Svi3kIA7lKKVq3TlrsEgINbsYPt9yDWf4KI2s369f7YevEnAbB6z8y)GmTVqxaZUboF6HF2jSk20EEpSBaXNXc9(TF33H0Yt))mJOfVVTTyFxd7E6)NjS7KKR1bqA7O623RIE26XNn1N9gdUR63FVSvy)BQGFlfEoBMGhZcEMBMWNtWQVyNUZyz2)7gXVJBwqSJ0(A7Kq5Ht)zhnF7(THWYzx751UqdVJWayN(gzENUzkMYM4KcZIjw8n)YRpdZX68fjPQ0MSCKYkSJU8LISweJ1zAklUAZp7Qvyk2Jrb(ymrGUSmVoDsYTzyEMH3mOhekyTQQS6C8qJqMwDhisHLE4GdeisnBV0IiRUfzAou2laKsMjGikVyMMhReSQGh0ORfyHCBszYTjPU7xUBVtswfDlZDlwacixgxeTWdQtLfJ4A2)1MP)zEE5dlBmGOapWJ05aIolcW3JKZuAEkRRiJuD7LXOt6Sck3JP5s44TrdhXSuYW4)c)GgQFdiO4dIQgcoJjQF9ZTQgN05QSgp)O8JrW7fuLYEPmFJ4EvdZpvyGPdM5Ifnhep(vZDcR4)ZgX9mbvudP6prc1CQ0trPhDkvL8lOAc6cSc4NG55nogIs(jEqdaQI60kEObJMppHhSf9j3GYH4yvGPqBo)(TGHPuRa)nAZ0Vx9DPpiYTw55Spk9(OheqfhHe10dZ5PsBfVuIsj0Db7wWUiulPDP2qDUqk417u9BFdhlVaTIkrkXvxxsze77IrEy(4J(3OIlOMt5xAATEmo0hvE6WIdj)KOLBeRKRcfelFbyrV7vSMA575L2P7jo6H2lgj10lo3zxt9jGOEaq1Pax)8mmLz7Ot1cCvRpLF6idfhOR66JdbQbeqfkOHAqSMKwXLldDGcpA8JpAsbek4Ch2A9dqXGCzFYiF8rvGZSEZKZE93o(vNkJj4vV6KH(N93wKSAclonzDz3RrVzlMq(hYv55zPj4PMlPCvNJ557KX820hwVexDJalOxbS7s2Sq7SAGPquC0ScSqUYyvtwvxMe39eH0bGvBO6YeXPlReewqhpR8SxWl)Y4q0i4JE2BLkR3m9)L0wdnVUYvbfcKMsx1M3NuYowvO7s(xm1y6OVAFLBYpXDOisRBxfU8sH9pB4fZRiSVrnYY7ufuyDkDPkHrjw81nfZgtz2Q6inO9GFGkkxrLiH7IsRzCdXOw3Ocd7axtd644jutjvULgxNkg3zaJPaflu4MHckGPCmFyakJAU2FPkuUIUgLpGXWOutPUyf)3MP)sEL6lfNXpxf6wTJoISKiWh7YhYILqT47nVmMkBRCtsYuvKK9bgzPPpYvBZ96IWFFLsbpJujiqke80tDGVAGrsdqmOxdMEaSPClQ9vAjJKfpqAfFEoJx4WOHAb)g2IwfZROZtA7LQPIRex5tWorytf8OBVLXRUyGUjYLP39dVLtZLGvMu0imYepZByScUrqII2Eu2d(g)auk2UtmOJlDbPsgyrpa90qqpMFAc30tOXuTphpd11iAtwRPs0(vto7v)X3C(3Q0jEoFX(9sCT1QoAM8dYfX3janGFKdB8d3lxGdjNapNxcn)g42y0cK0j40Wg9kv)4dTCisjFX5(Wo9ItKRWbwnkBOuvNs6m(LdNRRnp(nOvdHLhTnCRX5EZVgK7gIUcW5Xf18dDZ)SokRQEfyz2DjCddvRO2MIEy7TneTkke7EJsyUCfbLOMmcJNFziJJ4hjfWQbW9XQ0oa1NMLe3h9bSwxI7vnqjSpgb8Ghwuht9ZCSi3XMmt406UEOazZ8tRxewqdFOSAVmiXr89(EbwHqjkF80qUGP8AYBlM8kEDYWrFx2LorIzIxYakiRB(L87IegOiLI8tu(wb8C8eUsFCOBVvQckIduJMoJu0YJpa9XzSG6aVOtxv0l5oCrJ)et6Q9B1INbX)tb0GofI4n9bwflZ4MLOzjozKtzoAtQUarROMeoOjhQeNJJvGlXwoEZ5TMlpMACe5bEBgOzjiAwMHi0Q4S8uTcR(v9aiLw)gEr6Cdjr2hH5pRqx6Kt)(G7o8ax75ZWwSGiaSRqLC)rvZMaOv(D38ZfRUpWBTXqoes90rrHP22jOLDlY4)cVTqYt5ND)vKr0wLBAdN3wyxvz0WMYH646MIIZLNs)YOirbpJBTrIDDF6yYlyTqJ9LmKBpNHC)hEoxA6CIzngHteQrzrhCWodR1jUCt75znsJOfToTfDUNpwFkAOlqzEySL9v0dntvaUij(ksZMot1edX0TD5qDyyPux6AyelIbDOPnZRGTtWnGFs4iGyqcGEq)mI0c3yyzrkrZBlNfOebYQDpPQvKEBbhPkqBoETMCc7iehatJn1Ua8XL6)9Z5U9sM8kNvs)MbV0RkYtlTQxyIaFsrWlcl(v2fOSeSlml3xBmQsybcw4(rxIRI4Jd9dTjXU6SVruaKm9uQ9iD4tM8sFgBQdXlZ7aV62qjtbGsGpqjMXKwPjKwonPuyQIDzY6WER9Ji3(nk6rIOYBu0GmVPbowsA1ypIQctf0ueoTfTLRIlpLrDl9xDEXv4BtudykMZvHqsFozxWEXYkRPBObKVQbbqxOlPy8qnR3F1zIOvr38B7hoPNLyuFs1ijAx1dzEdpmm17f9HN(f9YSUb9MYUbMADtal8vkim35CYqmFNIHCX96tzVgp5FruPeT5mp2w8U7BdaFxDnumtiszYi(w7TMz0IuZMEqM2fEiiZ5HBNc9dpOT(tFce5MpzxRrvkBA6u7A76fNm68hFSTlkxD5yUUAzrd9hBGLwRoKSb(YcFhFPi6JlaoVOO(jAzJNckvnLu0Uxx5BdawOVknsngKQ4(iEb3Kw75Q6Tw1vJM5D)wbVsXr5ltU(Dmh9HT2vwcr3T0D9S4sZTeV6wDSu3db9wxyxgs0vsUfMgHz(xglLAO9L3QF2bhmaUfKPkITh2w23fU)KQK4p0i7RBCARKXURSN5eV(B4AnWWIiErz9NfYQ4iqLGQe5LlaQauvHxpEtVVEsoqnwJ8qO0RvIGII8jPqtzLRsr9vAx05CxqYDw8OfjrJTiNJcuSqV8un7aDD)1ReeD1Pc12oV28UyS084HQ88GKdOwHaB3Ol5PJBxmJT2gbJfLUYgdUwUgPmCXiYl5wUkAXh9t4Uid6Ek5ejyx26gt2tcX1FsIgDvDrm8KwRKPPQ(AWHbwwmOCcUqd(f7Qc2(4JHlqSx1SWpe5nLimHEvo8wEP21lLuELMw3tFg78JZRaRWbGrFtpTauybLFRl9uc8JeLOD9w94JArLZ8ITkyilD77LYO6onQd8uPhbvX6YQARs1mui8NyxWubwunR0V4IRVZqGN9C3TO7HIwBFZlbluymdo98HMwmkWSQL3kZJyWNKtaFGAdWQfksjPu5L8C3nCJG5vt5TT7MQkDTUmzREDNDaPFfhVoBPzvUfi2LPVE0855z8uEsqoNKDxog3c0VgEAYGqgwMKvPCh3e31PrpGQyIbB(e8bIuEpEzEEjZsli8rROCURKNB4J4qrhaohAMibgTCVH7ZAs2IA52PsyqZhlDg85mqs31rHrL1RwPf9Q2VY0kpFdgj)rMm6dCLn6p(ONJRIWMiJ0uVZXRUp5jE)7fEEOyvrG3Yp3rLaEl7b3v)3TTtsAv0F3YEWzL(Dl7dJY8RhjruC8UKmCQCY)OE(TYSApOFgT6buUterWcCMXFWR3Ib7HNI1pKgwrAsQWeYig2wrz70yw2gUb02TeZDsUeiZVkMShNSLMKsjATNG0ZVv0gfCY35gTPMDUWTsBQAcc3hMnrF7m0nyz8jbHelIiNz0jcd4nbI4cRJBZ(r0tg36jNP9KRUCS)nA(YTbWYy1O0RYhYa4bjtwIQJ6YI0RED4XW9YGPDgkx3SnCdxEowLKNB0VYELUyr9KW(SKQWKeAb)YB0xcTjOnBvQfRKZdLI(vOxiOs5rD4TknWU51rdK0YwPmJ3277gsRdQPEopSUMVA)qlGn8kQi0fpZLZd8un0do28ad98gzIY3L0tn5MY7Bjn(akCbPROeICrsws5s28oKgQEu)cTDO4bCYwVBuGBRGF(HZSjHFTEYfPaVvKptaBGtVuvRdyheiHPgAaHgjiQkyeMv2pEEXRYhMmwCroyyWC9eIh9AAgy2aRjCi8jsZlS6grA1O1j(tRMHQy4zF)HDORNZA7ITU(qKO0oCFwXguRN9f1W(33ocL4HEE1tO3BVth6aFGTbPRrGhPrRn7S1XcX(MRx)OVkuRnJFWCtkDz0e4VhJ)vvYBj)ntxrQ807wsic5bN6SfGLSCYGTm13EFJqf(BX3zDwN2mfpRofHfJ4o1ECevDfsmqYZ524kviEO9HP9g3W3qB7y5wAEX0jouCRQZWu)qSnr8i1sTIVfwaZuZcshMo4lCR(IhVZiM6)CNeoZoScr643m5vAHi1H8bCc1vwaXBJFEX2Nnwqe7wNDwE27Ha6x4hPA7iu)nd0IP8vNm8IX701RpVwy0onwUDNGonGc1hUBXKZo5KtF1yh72IFGN0uPXzVMfZpDFQnMqZs4mgBU5l9g56leHYxl85HY5wphaRgVZC)EkfoUySVx3cwcVTfkifjOmBXJp2XQZHBZAJt2WbBlFyxZ6tgD(Nn8QUfT(f(0pn5tndXVftQ5ln5q9VZI7C2Z))T3vZUTXnq4NfDryvGJQSd6Lw5uu0Kd9qrcstrVf7nwuXlQSKHw5Ayad9ShoZqYL)mKlPKSHQrrUeyTlx(ZWHZ8nFZWJLTN8d5N89Mq(xFlYokxs2eszhk5tVUbUygv15GhkcZLk(HrDz4PiNVQkCgU0pXRTOzO5JyceQ9hqLb7FcGPFjm9DB96)jowP1E3wWOuezcpAuRtXhsLv5O9VKR)k39BnLWbf5NQ3C3AkSoTqkec3lQ(FjPac0)qUAUHQfeyGJOSwg9LXDq0JVa0ZkL7KpkFOXgE2RyxV5fntscH0hH4G9uHsguCN(7K1pclFWKZQFDDJakota4yEK9icC1QfzOlqTICdO0H)zMvyP9NT3DtJgfZl)DLRIKxDx1aRtGiY91nDlHORlUDcynEg2mUBL3OtbDKCCBPQGICzpE490tTWx8KwXvNpz8KtnlZ9SdM1jABcnwL(O1yqqsXh(1PFz8OFIkotDDXelkrYXXBgLV0e)Wnuwp)wm4g)MNtoLoLY1LWKNUHJNFSk3bPeAxJWJPuOVZFKUkLv8Z1IxHgSp6ex14BykWAe0gWx5xx9(0AwctcHehNZ6LADhgvUreXayM39tT6NNY)Rw5AM5iGacq0XaT0HTYbog4KHtyqtk80J5qPMYGiee4)MwAbn4LPJe0KrBM9D9pCiYUaXZ(h9b2Kt2cgoVOtKME9SVxHNWxIzlhO5GDUV(0eXMNZL6o)JkzHM5TYxp7bA0CicBMXadCt4NFZe0mTt8vP2gJlAqdrur)3u8HC7LVhjezeR0XuDaAYoUXb6EA9P8UyzpQdC1ectRC01COf3dN6RqwnpuoZtNE2WQ00aTJ)VApOWUjvvELUbtzwUo4ISZb8W1RDZbuNQD0rdQEWAgoB)NuKwku8S0OHgCAxFQw61SHkwOQt5qQZ(BTD1fTSoInNfcMxn2xWM7iF(dV7d)K8a3wJ55GP5InO90uDcBLYGy8jAf)YHqsNjbzoB8poSkJDajTDi1HrjIYDejetGSfleRRXigwdL2yD10jLmC4UbyI8AXIB7lFCyYfiIZHAQTtuGhGCsh0kY1hX6)TViyhU8WsCCdhxdjOAgRq7MokZoiNll4mrj70jPx8JtZGWLEZ)7TNRulE4KRmw3A8fgdXMyjuJH1bICHy(MqXh0D1AgHo4VRL5qzmmcPl5k7z683WIcqIfTI0YmEeGlYyuJPOVrzNMSTBUsyQzl90W2uf0KRVN7zIzulcTe(c9G23X0hFSq0pgX014enCiSWqlQCyF3tNKdi(nJElN)a)Si9OCNUytGYJiBb5gChR2T2BFTqPTmArwX6UdUqAr4anHQQrckD(0QpsEi)WQ7qkuaAOUgtKFrZg0yoNK5y1ApisFqOX6GEEP9fv1J0TXnkC(qMvCpKiilWPqPUPQVAEk2etzTdkVNqF6QRgLQoviTX5D0qy2knCFQm4eeYTtdXoj9w7YKzeuiiaiH1(4B(ljGC9NVzjJHwulwZpxORgWEWDSOMmaHGtnUS60jQRfs9ssDRrTTOJXxojmZyCuo6Xh5kaiQah8xbPLOwwvB2BDxIM(dMCmvhqaAL2rS2UuNSYQDu2TBQ)josEphYcClDziFuvfjvvH2SVSyLsR9bfeoNKeuRkYVThFVi5pleKl26gtKm8xd6PpvaLDMi7c4BNinZWbjScEum7iYM(3CVCNPVSZdQjZMBKE1lDF4cfy6ked8(ZgBYmfuNCplY3fDZ5Qtd(zYGgVhGfGR9RCqX)HN6VtW0r6QHHVIBiLZXY5g0IOv6iwf8SM2gP3e6)x8urStlK(1uQGanXmonMlktJ2FaPYBS98p047Vj31Bu54fUKUhy)MTSO7sKjU0Ai4FNWuA1v88TrCaHR0W69MDEH4)WdVPEz94BHsRw0N5c4zSWk24AnmhSP16AmqAqW3q0GX8ugndWPywbLOQ5nlwGLwGLTBeyDnzENzeXoSFF8XkdLi850R6GOyqwX2rvJdBpRdQjihFEyh0f5D(jOnkUfIuuGS)Z8hz4cTBuTq87717wNu(qoOdBDEJUZrvrq4)DX1QQffudkHeMqmJRedYyixNflBPBIaLtzFdC8dzeVkebAuOqxkrXoLNv2aBP)7Kn46Ic340J(SLk3nGm6P(6PJhN7p6eXUouet)XmOAhPI9LamOs)ghaimYtq8)NzFQMzd2IN(e78A0ITn)iZSBRQQggzy9OE7LMcBLM5m9KXlDbBrDL75wAgbTy(fn7JqKhy1xwkcemGmSViu9chbcPnndyDClXbUVyGTqUh8pwnRzEJy2pVvDR4QcpPd2WyL)HczTE2aEoZ2I2EKJZYD6CusUZUtZ2RkWT6y1rUNkxspGEBN3q)OzK)FgNX5MxZdZVuTqVUOFA63pxyb4E3xOU5FW9ePaLD7LB)XmjagFFzJ8FF57)]] )