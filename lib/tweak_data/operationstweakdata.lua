OperationsTweakData = OperationsTweakData or class()
OperationsTweakData.JOB_TYPE_RAID = 1
OperationsTweakData.JOB_TYPE_OPERATION = 2
OperationsTweakData.IN_LOBBY = "in_lobby"
OperationsTweakData.STATE_ZONE_MISSION_SELECTED = "system_zone_mission_selected"
OperationsTweakData.STATE_LOCATION_MISSION_SELECTED = "system_location_mission_selected"
OperationsTweakData.ENTRY_POINT_LEVEL = "streaming_level"

function OperationsTweakData:init()
	self.missions = {}
	self.HEAT_OTHER_JOBS_RATIO = 0.3
	self.ABSOLUTE_ZERO_JOBS_HEATS_OTHERS = false
	self.HEATED_MAX_XP_MUL = 1.15
	self.FREEZING_MAX_XP_MUL = 0.7
	self.DEFAULT_HEAT = {
		this_job = -5,
		other_jobs = 5
	}
	self.MAX_JOBS_IN_CONTAINERS = {
		6,
		18,
		24,
		false,
		12,
		4,
		1
	}

	self:_init_loading_screens()
	self:_init_regions()
	self:_init_raids()
	self:_init_operations()
	self:_init_consumable_missions_data()
end

function OperationsTweakData:_init_regions()
	self.regions = {
		"germany",
		"france",
		"africa"
	}
end

function OperationsTweakData:_init_consumable_missions_data()
	self.consumable_missions = {
		base_document_spawn_chance = {
			0.2,
			0.2,
			0.2,
			0.2
		},
		spawn_chance_modifier_increase = 0.1
	}
end

function OperationsTweakData:_init_loading_screens()
	self._loading_screens = {
		generic = {}
	}
	self._loading_screens.generic.image = "loading_raid_ww2"
	self._loading_screens.generic.text = "loading_generic"
	self._loading_screens.city = {
		image = "loading_raid_ww2",
		text = "loading_german_city"
	}
	self._loading_screens.camp_church = {
		image = "loading_raid_ww2",
		text = "loading_camp"
	}
	self._loading_screens.tutorial = {
		image = "loading_raid_ww2",
		text = "loading_tutorial"
	}
	self._loading_screens.flakturm = {
		image = "loading_flak",
		text = "loading_flaktower"
	}
	self._loading_screens.train_yard = {
		image = "loading_raid_ww2",
		text = "loading_trainyard"
	}
	self._loading_screens.bridge = {
		image = "loading_raid_ww2",
		text = "loading_bridge"
	}
	self._loading_screens.tnd = {
		image = "loading_screens_07",
		text = "loading_bridge"
	}
	self._loading_screens.hunters = {
		image = "loading_screens_07",
		text = "loading_bridge"
	}
end

function OperationsTweakData:_init_raids()
	self._raids_index = {
		"flakturm",
		"hunters",
		"ger_bridge",
		"tnd",
		"train_yard"
	}
	self.missions.streaming_level = {
		name_id = "menu_stream",
		level_id = "streaming_level"
	}
	self.missions.camp = {
		name_id = "menu_camp_hl",
		level_id = "camp",
		briefing_id = "menu_germany_desc",
		audio_briefing_id = "menu_enter",
		music_id = "camp",
		region = "germany",
		xp = 0,
		icon_hud = "mission_camp",
		loading = {
			text = "loading_camp",
			image = "camp_loading_screen"
		},
		loading_success = {
			image = "success_loading_screen_01"
		},
		loading_fail = {
			image = "fail_loading_screen_01"
		},
		tab_background_image = "ui/hud/backgrounds/tab_screen_bg_camp_hud"
	}
	self.missions.tutorial = {
		name_id = "menu_tutorial_hl",
		level_id = "tutorial",
		briefing_id = "menu_tutorial_desc",
		audio_briefing_id = "flakturm_briefing_long",
		short_audio_briefing_id = "flakturm_brief_short",
		music_id = "camp",
		region = "germany",
		xp = 1000,
		stealth_bonus = 1.5,
		start_in_stealth = true,
		mission_state = OperationsTweakData.STATE_LOCATION_MISSION_SELECTED,
		mission_flag = "level_tutorial",
		job_type = OperationsTweakData.JOB_TYPE_RAID,
		icon_menu = "missions_tutorial",
		icon_hud = "miissions_raid_flaktower",
		excluded_continents = {
			"operation"
		},
		tab_background_image = "ui/hud/backgrounds/tab_screen_bg_raid_flak_hud",
		loading = {
			text = "loading_tutorial",
			image = "raid_loading_tutorial"
		},
		photos = {
			{
				title_id = "flak_mission_photo_1_title",
				description_id = "flak_mission_photo_1_description",
				photo = "intel_flak_01"
			}
		}
	}
	self.missions.flakturm = {
		name_id = "menu_ger_miss_01_hl",
		level_id = "flakturm",
		briefing_id = "menu_ger_miss_01_desc",
		audio_briefing_id = "flakturm_briefing_long",
		short_audio_briefing_id = "flakturm_brief_short",
		music_id = "flakturm",
		region = "germany",
		xp = 1000,
		stealth_bonus = 1.5,
		start_in_stealth = true,
		dogtags_min = 32,
		dogtags_max = 37,
		mission_state = OperationsTweakData.STATE_LOCATION_MISSION_SELECTED,
		mission_flag = "level_raid_flakturm",
		job_type = OperationsTweakData.JOB_TYPE_RAID,
		icon_menu = "missions_raid_flaktower_menu",
		icon_hud = "miissions_raid_flaktower",
		excluded_continents = {
			"operation"
		},
		tab_background_image = "ui/hud/backgrounds/tab_screen_bg_raid_flak_hud",
		loading = {
			text = "menu_ger_miss_01_loading_desc",
			image = "loading_flak"
		},
		photos = {
			{
				title_id = "flak_mission_photo_1_title",
				description_id = "flak_mission_photo_1_description",
				photo = "intel_flak_01"
			},
			{
				title_id = "flak_mission_photo_2_title",
				description_id = "flak_mission_photo_2_description",
				photo = "intel_flak_02"
			},
			{
				title_id = "flak_mission_photo_3_title",
				description_id = "flak_mission_photo_3_description",
				photo = "intel_flak_03"
			},
			{
				title_id = "flak_mission_photo_4_title",
				description_id = "flak_mission_photo_4_description",
				photo = "intel_flak_04"
			},
			{
				title_id = "flak_mission_photo_5_title",
				description_id = "flak_mission_photo_5_description",
				photo = "intel_flak_05"
			},
			{
				title_id = "flak_mission_photo_6_title",
				description_id = "flak_mission_photo_6_description",
				photo = "intel_flak_06"
			}
		}
	}
	self.missions.train_yard = {
		name_id = "menu_ger_miss_05_hl",
		level_id = "train_yard",
		briefing_id = "menu_ger_miss_05_desc",
		audio_briefing_id = "trainyard_briefing_long",
		short_audio_briefing_id = "trainyard_brief_short",
		region = "germany",
		music_id = "train_yard",
		start_in_stealth = true,
		xp = 1000,
		mission_state = OperationsTweakData.STATE_LOCATION_MISSION_SELECTED,
		mission_flag = "level_raid_train_yard",
		job_type = OperationsTweakData.JOB_TYPE_RAID,
		icon_menu = "mission_raid_railyard_menu",
		icon_hud = "mission_raid_railyard",
		tab_background_image = "ui/hud/backgrounds/tab_screen_bg_raid_railyard_hud",
		loading = {
			text = "menu_ger_miss_05_loading_desc",
			image = "loading_trainyard"
		},
		photos = {
			{
				title_id = "rail_yard_mission_photo_1_title",
				description_id = "rail_yard_mission_photo_1_description",
				photo = "intel_train_01"
			},
			{
				title_id = "rail_yard_mission_photo_2_title",
				description_id = "rail_yard_mission_photo_2_description",
				photo = "intel_train_02"
			},
			{
				title_id = "rail_yard_mission_photo_4_title",
				description_id = "rail_yard_mission_photo_4_description",
				photo = "intel_train_04"
			},
			{
				title_id = "rail_yard_mission_photo_5_title",
				description_id = "rail_yard_mission_photo_5_description",
				photo = "intel_train_05"
			}
		}
	}
	self.missions.ger_bridge = {
		name_id = "menu_ger_bridge_00_hl",
		level_id = "ger_bridge",
		briefing_id = "menu_ger_bridge_00_hl_desc",
		audio_briefing_id = "bridge_briefing_long",
		short_audio_briefing_id = "bridge_brief_short",
		region = "germany",
		music_id = "ger_bridge",
		mission_state = OperationsTweakData.STATE_LOCATION_MISSION_SELECTED,
		mission_flag = "level_raid_bridge",
		job_type = OperationsTweakData.JOB_TYPE_RAID,
		xp = 1000,
		dogtags_min = 28,
		dogtags_max = 34,
		icon_menu = "missions_raid_bridge_menu",
		icon_hud = "missions_raid_bridge",
		tab_background_image = "ui/hud/backgrounds/tab_screen_bg_raid_bridge_hud",
		loading = {
			text = "menu_ger_bridge_00_hl_loading_desc",
			image = "loading_bridge"
		},
		excluded_continents = {
			"operation"
		},
		photos = {
			{
				title_id = "bridge_mission_photo_1_title",
				description_id = "bridge_mission_photo_1_description",
				photo = "intel_bridge_01"
			},
			{
				title_id = "bridge_mission_photo_2_title",
				description_id = "bridge_mission_photo_2_description",
				photo = "intel_bridge_02"
			},
			{
				title_id = "bridge_mission_photo_3_title",
				description_id = "bridge_mission_photo_3_description",
				photo = "intel_bridge_03"
			},
			{
				title_id = "bridge_mission_photo_4_title",
				description_id = "bridge_mission_photo_4_description",
				photo = "intel_bridge_04"
			},
			{
				title_id = "bridge_mission_photo_5_title",
				description_id = "bridge_mission_photo_5_description",
				photo = "intel_bridge_05"
			}
		}
	}
	self.missions.tnd = {
		name_id = "menu_tnd_hl",
		level_id = "tnd",
		briefing_id = "menu_tnd_desc",
		audio_briefing_id = "mrs_white_tank_depot_brief_long",
		short_audio_briefing_id = "mrs_white_tank_depot_briefing_short",
		music_id = "castle",
		region = "germany",
		xp = 1000,
		stealth_bonus = 1.5,
		dogtags_min = 30,
		dogtags_max = 37,
		mission_state = OperationsTweakData.STATE_LOCATION_MISSION_SELECTED,
		mission_flag = "level_raid_tnd",
		job_type = OperationsTweakData.JOB_TYPE_RAID,
		icon_menu = "missions_tank_depot",
		icon_hud = "missions_raid_flaktower",
		tab_background_image = "ui/hud/backgrounds/tab_screen_bg_raid_flak_hud",
		loading = {
			text = "loading_tnd",
			image = "raid_loading_tank_depot"
		},
		photos = {
			{
				title_id = "tank_depot_mission_photo_1_title",
				description_id = "tank_depot_mission_photo_1_description",
				photo = "intel_tank_depot_05"
			},
			{
				title_id = "tank_depot_mission_photo_2_title",
				description_id = "tank_depot_mission_photo_2_description",
				photo = "intel_tank_depot_01"
			},
			{
				title_id = "tank_depot_mission_photo_3_title",
				description_id = "tank_depot_mission_photo_3_description",
				photo = "intel_tank_depot_03"
			},
			{
				title_id = "tank_depot_mission_photo_4_title",
				description_id = "tank_depot_mission_photo_4_description",
				photo = "intel_tank_depot_02"
			}
		}
	}
	self.missions.hunters = {
		name_id = "menu_hunters_hl",
		level_id = "hunters",
		briefing_id = "menu_hunters_desc",
		audio_briefing_id = "mrs_white_hunters_brief_long",
		short_audio_briefing_id = "mrs_white_hunters_briefing_short",
		music_id = "radio_defense",
		region = "germany",
		xp = 1000,
		stealth_bonus = 1.5,
		dogtags_min = 30,
		dogtags_max = 37,
		mission_state = OperationsTweakData.STATE_LOCATION_MISSION_SELECTED,
		mission_flag = "level_raid_hunters",
		job_type = OperationsTweakData.JOB_TYPE_RAID,
		icon_menu = "missions_hunters",
		icon_hud = "missions_raid_flaktower",
		tab_background_image = "ui/hud/backgrounds/tab_screen_bg_raid_flak_hud",
		loading = {
			text = "loading_hunters",
			image = "raid_loading_hunters"
		},
		start_in_stealth = true,
		photos = {
			{
				title_id = "hunters_mission_photo_1_title",
				description_id = "hunters_mission_photo_1_description",
				photo = "intel_hunters_01"
			},
			{
				title_id = "hunters_mission_photo_2_title",
				description_id = "hunters_mission_photo_2_description",
				photo = "intel_hunters_02"
			},
			{
				title_id = "hunters_mission_photo_3_title",
				description_id = "hunters_mission_photo_3_description",
				photo = "intel_hunters_03"
			},
			{
				title_id = "hunters_mission_photo_4_title",
				description_id = "hunters_mission_photo_4_description",
				photo = "intel_hunters_04"
			}
		}
	}
end

function OperationsTweakData:_init_operations()
	self._operations_index = {}
end

function OperationsTweakData:get_all_loading_screens()
	return self._loading_screens
end

function OperationsTweakData:get_loading_screen(level)
	local level = self._loading_screens[level]

	if level.success and managers.raid_job:current_job() then
		if managers.raid_job:stage_success() then
			return self._loading_screens[level].success
		else
			return self._loading_screens[level].fail
		end
	else
		return self._loading_screens[level]
	end
end

function OperationsTweakData:mission_data(mission_id)
	if not mission_id or not self.missions[mission_id] then
		return
	end

	local res = deep_clone(self.missions[mission_id])
	res.job_id = mission_id

	return res
end

function OperationsTweakData:get_raids_index()
	return self._raids_index
end

function OperationsTweakData:get_operations_index()
	return self._operations_index
end

function OperationsTweakData:get_index_from_raid_id(raid_id)
	for index, entry_name in ipairs(self._raids_index) do
		if entry_name == raid_id then
			return index
		end
	end

	return 0
end

function OperationsTweakData:get_index_from_operation_id(raid_id)
	for index, entry_name in ipairs(self._operations_index) do
		if entry_name == raid_id then
			return index
		end
	end

	return 0
end

function OperationsTweakData:get_region_index_from_name(region_name)
	for index, reg_name in ipairs(self.regions) do
		if region_name == reg_name then
			return index
		end
	end

	return 0
end

function OperationsTweakData:get_raid_name_from_index(index)
	return self._raids_index[index]
end

function OperationsTweakData:get_operation_name_from_index(index)
	return self._operations_index[index]
end

function OperationsTweakData:randomize_operation(operation_id)
	local operation = self.missions[operation_id]
	local template = operation.events_index_template
	local calculated_index = {}

	for _, value in ipairs(template) do
		local index = math.floor(math.rand(#value)) + 1

		table.insert(calculated_index, value[index])
	end

	operation.events_index = calculated_index

	Application:debug("[OperationsTweakData:randomize_operation]", operation_id, inspect(calculated_index))
end

function OperationsTweakData:get_operation_indexes_delimited(operation_id)
	return table.concat(self.missions[operation_id].events_index, "|")
end

function OperationsTweakData:set_operation_indexes_delimited(operation_id, delimited_string)
	self.missions[operation_id].events_index = string.split(delimited_string, "|")
end
