require("lib/managers/BuffEffectManager")
require("lib/tweak_data/WeaponTweakData")

ChallengeCardsTweakData = ChallengeCardsTweakData or class()
ChallengeCardsTweakData.CARD_TYPE_RAID = "card_type_raid"
ChallengeCardsTweakData.CARD_TYPE_OPERATION = "card_type_operation"
ChallengeCardsTweakData.CARD_TYPE_NONE = "card_type_none"
ChallengeCardsTweakData.CARD_CATEGORY_CHALLENGE_CARD = "card_category_challenge_card"
ChallengeCardsTweakData.CARD_CATEGORY_BOOSTER = "card_category_booster"
ChallengeCardsTweakData.KEY_NAME_FIELD = "key_name"
ChallengeCardsTweakData.FILTER_ALL_ITEMS = "filter_all_items"
ChallengeCardsTweakData.CARDS_TEXTURE_PATH = "ui/atlas/raid_atlas_cards"
ChallengeCardsTweakData.TEXTURE_RECT_PATH_COMMON_THUMB = ""
ChallengeCardsTweakData.TEXTURE_RECT_PATH_UNCOMMON_THUMB = ""
ChallengeCardsTweakData.TEXTURE_RECT_PATH_RARE_THUMB = ""
ChallengeCardsTweakData.EFFECT_TYPE_POSITIVE = "positive_effect"
ChallengeCardsTweakData.EFFECT_TYPE_NEGATIVE = "negative_effect"
ChallengeCardsTweakData.CARD_SELECTION_TIMER = 60
ChallengeCardsTweakData.PACK_TYPE_REGULAR = 1
ChallengeCardsTweakData.STACKABLE_AREA = {
	width = 500,
	height = 680
}

function ChallengeCardsTweakData:init(tweak_data)
	self.challenge_card_texture_path = "ui/challenge_cards/"
	self.challenge_card_texture_rect = {
		0,
		0,
		512,
		512
	}
	self.card_back_challenge_cards = {
		texture = self.challenge_card_texture_path .. "cc_back_hud",
		texture_rect = self.challenge_card_texture_rect
	}
	self.card_back_boosters = {
		texture = self.challenge_card_texture_path .. "cc_back_booster_hud",
		texture_rect = self.challenge_card_texture_rect
	}
	self.challenge_card_stackable_2_texture_path = "ui/challenge_cards/cc_stackable_2_cards_hud"
	self.challenge_card_stackable_2_texture_rect = {
		0,
		0,
		512,
		512
	}
	self.challenge_card_stackable_3_texture_path = "ui/challenge_cards/cc_stackable_3_cards_hud"
	self.challenge_card_stackable_3_texture_rect = {
		0,
		0,
		512,
		512
	}
	self.challenge_card_stackable_booster_2_texture_path = "ui/challenge_cards/cc_stackable_booster_2_cards_hud"
	self.challenge_card_stackable_booster_2_texture_rect = {
		0,
		0,
		512,
		512
	}
	self.challenge_card_stackable_booster_3_texture_path = "ui/challenge_cards/cc_stackable_booster_3_cards_hud"
	self.challenge_card_stackable_booster_3_texture_rect = {
		0,
		0,
		512,
		512
	}
	self.not_selected_cardback = {
		texture_path = ChallengeCardsTweakData.CARDS_TEXTURE_PATH,
		texture_rect = {
			501,
			2,
			497,
			670
		}
	}
	self.rarity_definition = {
		loot_rarity_common = {}
	}
	self.rarity_definition.loot_rarity_common.texture_path = ChallengeCardsTweakData.CARDS_TEXTURE_PATH
	self.rarity_definition.loot_rarity_common.texture_rect = {
		2,
		2,
		497,
		670
	}
	self.rarity_definition.loot_rarity_common.texture_path_icon = tweak_data.gui.icons.loot_rarity_common.texture
	self.rarity_definition.loot_rarity_common.texture_rect_icon = tweak_data.gui.icons.loot_rarity_common.texture_rect
	self.rarity_definition.loot_rarity_common.color = Color("ececec")
	self.rarity_definition.loot_rarity_uncommon = {
		texture_path = ChallengeCardsTweakData.CARDS_TEXTURE_PATH,
		texture_rect = {
			2,
			1346,
			497,
			670
		},
		texture_path_icon = tweak_data.gui.icons.loot_rarity_uncommon.texture,
		texture_rect_icon = tweak_data.gui.icons.loot_rarity_uncommon.texture_rect,
		color = Color("71b35b")
	}
	self.rarity_definition.loot_rarity_rare = {
		texture_path = ChallengeCardsTweakData.CARDS_TEXTURE_PATH,
		texture_rect = {
			501,
			674,
			497,
			670
		},
		texture_path_icon = tweak_data.gui.icons.loot_rarity_rare.texture,
		texture_rect_icon = tweak_data.gui.icons.loot_rarity_rare.texture_rect,
		color = Color("718c9e")
	}
	self.rarity_definition.loot_rarity_none = {
		texture_path = ChallengeCardsTweakData.CARDS_TEXTURE_PATH,
		texture_rect = {
			2,
			674,
			497,
			670
		},
		texture_path_icon = nil,
		texture_rect_icon = nil,
		color = nil
	}
	self.type_definition = {
		card_type_raid = {}
	}
	self.type_definition.card_type_raid.texture_path = tweak_data.gui.icons.ico_raid.texture
	self.type_definition.card_type_raid.texture_rect = tweak_data.gui.icons.ico_raid.texture_rect
	self.type_definition.card_type_operation = {
		texture_path = tweak_data.gui.icons.ico_operation.texture,
		texture_rect = tweak_data.gui.icons.ico_operation.texture_rect
	}
	self.type_definition.card_type_none = {
		texture_path = "ui/main_menu/textures/cards_atlas",
		texture_rect = {
			310,
			664,
			144,
			209
		}
	}
	self.card_glow = {
		texture = "ui/main_menu/textures/cards_atlas",
		texture_rect = {
			305,
			662,
			159,
			222
		}
	}
	self.card_amount_background = {
		texture = tweak_data.gui.icons.card_counter_bg.texture,
		texture_rect = tweak_data.gui.icons.card_counter_bg.texture_rect
	}
	self.steam_inventory = {
		gameplay = {}
	}
	self.steam_inventory.gameplay.def_id = 1
	self.cards = {
		empty = {}
	}
	self.cards.empty.name = "PASS"
	self.cards.empty.description = "PASS"
	self.cards.empty.effects = {}
	self.cards.empty.rarity = LootDropTweakData.RARITY_NONE
	self.cards.empty.card_type = ChallengeCardsTweakData.CARD_TYPE_NONE
	self.cards.empty.texture = ""
	self.cards.empty.achievement_id = ""
	self.cards.empty.bonus_xp = nil
	self.cards.empty.steam_skip = true
	self.cards.ra_no_backups = {
		name = "card_ra_no_backups_name_id",
		description = "card_ra_no_backups_desc_id",
		effects = {
			{
				value = 1.15,
				type = ChallengeCardsTweakData.EFFECT_TYPE_POSITIVE,
				name = BuffEffectManager.EFFECT_PLAYER_RELOAD_SPEED
			},
			{
				value = 0,
				type = ChallengeCardsTweakData.EFFECT_TYPE_NEGATIVE,
				name = BuffEffectManager.EFFECT_PLAYER_SECONDARY_AMMO_CAPACITY
			}
		},
		positive_description = {
			desc_id = "effect_player_faster_reload",
			desc_params = {
				EFFECT_VALUE_1 = "15%"
			}
		},
		negative_description = {
			desc_id = "effect_player_no_secondary_ammo"
		},
		rarity = LootDropTweakData.RARITY_COMMON,
		card_type = ChallengeCardsTweakData.CARD_TYPE_RAID,
		texture = "cc_raid_common_no_backups_hud",
		achievement_id = "",
		bonus_xp = 250,
		def_id = 20002,
		card_category = ChallengeCardsTweakData.CARD_CATEGORY_CHALLENGE_CARD
	}
	self.cards.ra_total_carnage = {
		name = "card_ra_total_carnage_name_id",
		description = "card_ra_total_carnage_desc_id",
		effects = {
			{
				value = 1,
				type = ChallengeCardsTweakData.EFFECT_TYPE_POSITIVE,
				name = BuffEffectManager.EFFECT_AMMO_PICKUPS_REFIL_GRENADES
			},
			{
				value = true,
				type = ChallengeCardsTweakData.EFFECT_TYPE_NEGATIVE,
				name = BuffEffectManager.EFFECT_ENEMIES_VULNERABLE_ONLY_TO_EXPLOSION
			},
			{
				value = true,
				type = ChallengeCardsTweakData.EFFECT_TYPE_NEGATIVE,
				name = BuffEffectManager.EFFECT_ENEMIES_VULNERABLE_ONLY_TO_MELEE
			}
		},
		positive_description = {
			desc_id = "effect_ammo_pickups_refill_grenades"
		},
		negative_description = {
			desc_id = "effect_enemies_vulnerable_only_to_explosion_and_melee"
		},
		rarity = LootDropTweakData.RARITY_UNCOMMON,
		card_type = ChallengeCardsTweakData.CARD_TYPE_RAID,
		texture = "cc_raid_uncommon_total_carnage_hud",
		achievement_id = "",
		bonus_xp_multiplier = 1.4,
		def_id = 20006,
		card_category = ChallengeCardsTweakData.CARD_CATEGORY_CHALLENGE_CARD
	}
	self.cards.ra_crab_people = {
		name = "card_ra_crab_people_name_id",
		description = "card_ra_crab_people_desc_id",
		effects = {
			{
				value = 1.3,
				type = ChallengeCardsTweakData.EFFECT_TYPE_POSITIVE,
				name = BuffEffectManager.EFFECT_PLAYER_MOVEMENT_SPEED
			},
			{
				value = true,
				type = ChallengeCardsTweakData.EFFECT_TYPE_NEGATIVE,
				name = BuffEffectManager.EFFECT_PLAYER_CAN_MOVE_ONLY_BACK_AND_SIDE
			}
		},
		positive_description = {
			desc_id = "effect_player_movement_speed_increased"
		},
		negative_description = {
			desc_id = "effect_player_can_only_walk_backwards_or_sideways"
		},
		rarity = LootDropTweakData.RARITY_RARE,
		card_type = ChallengeCardsTweakData.CARD_TYPE_RAID,
		texture = "cc_raid_rare_crab_people_hud",
		achievement_id = "",
		bonus_xp_multiplier = 2.3,
		def_id = 20015,
		card_category = ChallengeCardsTweakData.CARD_CATEGORY_CHALLENGE_CARD
	}
	self.cards.ra_b_walk_it_off = {
		name = "challenge_card_ra_b_walk_it_off_name_id",
		description = "challenge_card_ra_b_walk_it_off_desc_id",
		effects = {
			{
				value = 5,
				type = ChallengeCardsTweakData.EFFECT_TYPE_POSITIVE,
				name = BuffEffectManager.EFFECT_MODIFY_BLEEDOUT_TIMER
			}
		},
		positive_description = {
			desc_id = "effect_bleedout_timer_increased",
			desc_params = {
				EFFECT_VALUE_1 = "5"
			}
		},
		rarity = LootDropTweakData.RARITY_COMMON,
		card_type = ChallengeCardsTweakData.CARD_TYPE_RAID,
		texture = "cc_booster_raid_common_walk_it_of_hud",
		achievement_id = "",
		bonus_xp = 0,
		def_id = 40002,
		card_category = ChallengeCardsTweakData.CARD_CATEGORY_BOOSTER
	}
	self.cards.ra_b_in_fine_feather = {
		name = "challenge_card_ra_b_in_fine_feather_name_id",
		description = "challenge_card_ra_b_in_fine_feather_desc_id",
		effects = {
			{
				value = 1.1,
				type = ChallengeCardsTweakData.EFFECT_TYPE_POSITIVE,
				name = BuffEffectManager.EFFECT_PLAYER_HEALTH
			}
		},
		positive_description = {
			desc_id = "effect_player_health_increased",
			desc_params = {
				EFFECT_VALUE_1 = "10%"
			}
		},
		rarity = LootDropTweakData.RARITY_UNCOMMON,
		card_type = ChallengeCardsTweakData.CARD_TYPE_RAID,
		texture = "cc_booster_raid_uncommon_in_fine_feather_hud",
		achievement_id = "",
		bonus_xp = 0,
		def_id = 40004,
		card_category = ChallengeCardsTweakData.CARD_CATEGORY_BOOSTER
	}
	self.cards_index = {
		"ra_no_backups",
		"ra_total_carnage",
		"ra_crab_people",
		"ra_b_walk_it_off",
		"ra_b_in_fine_feather"
	}
end

function ChallengeCardsTweakData:get_all_cards_indexed()
	local result = {}
	local counter = 1

	for _, card_key_name in pairs(self.cards_index) do
		self.cards[card_key_name][ChallengeCardsTweakData.KEY_NAME_FIELD] = card_key_name
		result[counter] = self.cards[card_key_name]
		counter = counter + 1
	end

	return result
end

function ChallengeCardsTweakData:get_card_by_key_name(card_key_name)
	local result = {}
	local card_data = self.cards[card_key_name]

	if card_data then
		result = clone(card_data)
		result[ChallengeCardsTweakData.KEY_NAME_FIELD] = card_key_name
	else
		result = nil
	end

	return result
end

function ChallengeCardsTweakData:get_cards_by_rarity(rarity)
	local cards = {}

	for key, card in pairs(self.cards) do
		if card.rarity == rarity then
			table.insert(cards, key)
		end
	end

	return cards
end
