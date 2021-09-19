WeaponInventoryTweakData = WeaponInventoryTweakData or class()

function WeaponInventoryTweakData:init()
	self.weapon_primaries_index = {
		{
			weapon_id = "m1903",
			slot = 1
		},
		{
			weapon_id = "carbine",
			slot = 2
		},
		{
			weapon_id = "sten",
			slot = 3
		},
		{
			weapon_id = "m1912",
			slot = 4
		},
		{
			weapon_id = "thompson",
			slot = 5
		},
		{
			weapon_id = "garand",
			slot = 6
		},
		{
			weapon_id = "m1918",
			slot = 7
		}
	}
	self.weapon_secondaries_index = {
		{
			weapon_id = "c96",
			slot = 1
		}
	}
	self.weapon_grenades_index = {
		{
			default = true,
			slot = 1,
			weapon_id = "m24"
		}
	}
	self.weapon_melee_index = {
		{
			default = true,
			slot = 1,
			redeemed_xp = 0,
			droppable = false,
			weapon_id = "m3_knife"
		},
		{
			droppable = true,
			slot = 2,
			weapon_id = "bc41_knuckle_knife",
			redeemed_xp = 50
		}
	}
end
