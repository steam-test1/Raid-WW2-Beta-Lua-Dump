RaidMainMenuGui = RaidMainMenuGui or class(RaidGuiBase)
RaidMainMenuGui.WIDGET_PANEL_Y = 256
RaidMainMenuGui.WIDGET_PANEL_W = 576
RaidMainMenuGui.WIDGET_PANEL_H = 256
RaidMainMenuGui.STEAM_GROUP_BUTTON_W = 544
RaidMainMenuGui.STEAM_GROUP_BUTTON_H = 306

function RaidMainMenuGui:init(ws, fullscreen_ws, node, component_name)
	RaidMainMenuGui.super.init(self, ws, fullscreen_ws, node, component_name)
	managers.menu:mark_main_menu(true)
	managers.raid_menu:show_background()
end

function RaidMainMenuGui:_setup_properties()
	RaidMainMenuGui.super._setup_properties(self)

	self._background = "ui/backgrounds/raid_main_bg_hud"
end

function RaidMainMenuGui:_layout()
	self._display_invite_widget = SystemInfo:platform() ~= Idstring("WIN32")

	RaidMainMenuGui.super._layout(self)
	self:_layout_logo()
	self:_layout_list_menu()
	self:_layout_steam_group_button()
	self:_layout_full_game_button()

	if game_state_machine:current_state_name() == "menu_main" then
		self:_layout_beta_updates_text()
	end

	if managers.platform:presence() == "Playing" then
		self:_layout_kick_mute_widget()
		managers.system_event_listener:add_listener("main_menu_drop_in", {
			CoreSystemEventListenerManager.SystemEventListenerManager.EVENT_DROP_IN
		}, callback(self, self, "_layout_kick_mute_widget"))
		managers.system_event_listener:add_listener("main_menu_drop_out", {
			CoreSystemEventListenerManager.SystemEventListenerManager.EVENT_DROP_OUT
		}, callback(self, self, "_layout_kick_mute_widget"))
	end
end

function RaidMainMenuGui:close()
	managers.system_event_listener:remove_listener("main_menu_drop_in")
	managers.system_event_listener:remove_listener("main_menu_drop_out")
	self._list_menu:set_selected(false)
	RaidMainMenuGui.super.close(self)
end

function RaidMainMenuGui:_layout_logo()
	self._raid_logo_small = self._root_panel:image({
		name = "raid_logo_small",
		h = 180,
		y = 64,
		w = 400,
		x = 64,
		texture = tweak_data.gui.icons.raid_logo_small.texture,
		texture_rect = tweak_data.gui.icons.raid_logo_small.texture_rect
	})
end

function RaidMainMenuGui:_layout_list_menu()
	local list_menu_params = {
		selection_enabled = true,
		name = "list_menu",
		h = 640,
		w = 480,
		loop_items = true,
		y = 256,
		x = 64,
		on_item_clicked_callback = callback(self, self, "_on_list_menu_item_selected"),
		data_source_callback = callback(self, self, "_list_menu_data_source"),
		on_menu_move = {}
	}
	self._list_menu = self._root_panel:list(list_menu_params)

	self._list_menu:set_selected(true)
end

function RaidMainMenuGui:_layout_steam_group_button()
	local steam_group_panel_params = {
		layer = 50,
		name = "steam_group_panel",
		h = 576,
		halign = "right",
		w = 1024,
		valign = "bottom"
	}
	self._steam_group_panel = self._root_panel:panel(steam_group_panel_params)

	self._steam_group_panel:set_right(self._root_panel:w() - 96)
	self._steam_group_panel:set_bottom(self._root_panel:h() - 77)

	self._steam_button_t = 0
	self._steam_button_pressed_scale = 0.95
	local group_button_frame_params = {
		texture = "ui/elements/banner_beta_frame_hud",
		name = "steam_group_button_frame",
		layer = 10,
		halign = "scale",
		valign = "scale"
	}
	self._steam_group_button_frame = self._steam_group_panel:bitmap(group_button_frame_params)

	self._steam_group_button_frame:set_center_x(self._steam_group_panel:w() / 2)

	local group_button_image_params = {
		texture = "ui/elements/banner_beta_hud",
		name = "steam_group_button_image",
		layer = 5,
		halign = "scale",
		valign = "scale",
		on_mouse_enter_callback = callback(self, self, "mouse_over_steam_group_button"),
		on_mouse_exit_callback = callback(self, self, "mouse_exit_steam_group_button"),
		on_mouse_pressed_callback = callback(self, self, "mouse_pressed_steam_group_button"),
		on_mouse_released_callback = callback(self, self, "mouse_released_steam_group_button")
	}
	self._steam_group_button_image = self._steam_group_panel:image(group_button_image_params)

	self._steam_group_button_image:set_center_x(self._steam_group_panel:w() / 2)
	self._steam_group_panel:set_w(RaidMainMenuGui.STEAM_GROUP_BUTTON_W)
	self._steam_group_panel:set_h(RaidMainMenuGui.STEAM_GROUP_BUTTON_H)
	self._steam_group_panel:set_right(self._root_panel:w() - 96)
	self._steam_group_panel:set_bottom(self._root_panel:h() - 77)
end

function RaidMainMenuGui:_layout_full_game_button()
	local full_game_panel_params = {
		layer = 50,
		name = "full_game_panel",
		h = 576,
		halign = "right",
		w = 1024,
		valign = "bottom"
	}
	self._full_game_panel = self._root_panel:panel(full_game_panel_params)

	self._full_game_panel:set_right(self._root_panel:w() - 96)
	self._full_game_panel:set_bottom(self._root_panel:h() - 77)

	self._steam_button_t = 0
	self._steam_button_pressed_scale = 0.95
	local group_button_frame_params = {
		texture = "ui/elements/banner_beta_frame_hud",
		name = "full_game_button_frame",
		layer = 10,
		halign = "scale",
		valign = "scale"
	}
	self._full_game_button_frame = self._full_game_panel:bitmap(group_button_frame_params)

	self._full_game_button_frame:set_center_x(self._full_game_panel:w() / 2)

	local group_button_image_params = {
		texture = "ui/elements/banner_launch_release",
		name = "full_game_button_image",
		layer = 5,
		halign = "scale",
		valign = "scale",
		on_mouse_enter_callback = callback(self, self, "mouse_over_full_game_button"),
		on_mouse_exit_callback = callback(self, self, "mouse_exit_full_game_button"),
		on_mouse_pressed_callback = callback(self, self, "mouse_pressed_full_game_button"),
		on_mouse_released_callback = callback(self, self, "mouse_released_full_game_button")
	}
	self._full_game_button_image = self._full_game_panel:image(group_button_image_params)

	self._full_game_button_image:set_center_x(self._full_game_panel:w() / 2)
	self._full_game_panel:set_w(RaidMainMenuGui.STEAM_GROUP_BUTTON_W)
	self._full_game_panel:set_h(RaidMainMenuGui.STEAM_GROUP_BUTTON_H)
	self._full_game_panel:set_right(self._root_panel:w() - 96 - RaidMainMenuGui.STEAM_GROUP_BUTTON_W - 42)
	self._full_game_panel:set_bottom(self._steam_group_panel:bottom())
end

function RaidMainMenuGui:_layout_beta_updates_text()
	local beta_updates_scrollable_area_params = {
		name = "challenge_cards_grid_scrollable_area",
		h = 500,
		y = 60,
		x = 0,
		scroll_step = 45,
		w = self._steam_group_panel:w()
	}
	self._beta_updates_scrollable_area = self._root_panel:scrollable_area(beta_updates_scrollable_area_params)

	self._beta_updates_scrollable_area:set_right(self._steam_group_panel:right())

	local panel = self._beta_updates_scrollable_area:get_panel()
	local beta_updates_panel_params = {
		name = "beta_updates_panel",
		halign = "right",
		valign = "top",
		w = self._steam_group_panel:w() - 10
	}
	self._beta_updates_panel = panel:panel(beta_updates_panel_params)
	local beta_updates_title_params = {
		name = "beta_updates_panel",
		h = 64,
		vertical = "center",
		align = "left",
		halign = "left",
		w = self._beta_updates_panel:w(),
		font = tweak_data.gui:get_font_path(tweak_data.gui.fonts.din_compressed, tweak_data.gui.font_sizes.menu_list),
		font_size = tweak_data.gui.font_sizes.menu_list,
		color = tweak_data.gui.colors.raid_dirty_white,
		text = self:translate("patch_notes_title_11", true)
	}
	self._beta_updates_title = self._beta_updates_panel:text(beta_updates_title_params)
	local beta_updates_line_params = {
		h = 3,
		w = self._beta_updates_panel:w(),
		color = tweak_data.gui.colors.raid_red
	}
	self._beta_updates_line = self._beta_updates_panel:rect(beta_updates_line_params)

	self._beta_updates_line:set_top(self._beta_updates_title:bottom())

	local beta_update_notes_params = {
		name = "beta_updates_panel",
		vertical = "top",
		wrap = true,
		align = "left",
		halign = "left",
		y = self._beta_updates_line:bottom() + 10,
		w = self._beta_updates_panel:w(),
		font = tweak_data.gui:get_font_path(tweak_data.gui.fonts.din_compressed, tweak_data.gui.font_sizes.extra_small),
		font_size = tweak_data.gui.font_sizes.extra_small,
		color = tweak_data.gui.colors.raid_dirty_white,
		text = self:translate("patch_notes_text_11")
	}
	self._beta_update_notes = self._beta_updates_panel:text(beta_update_notes_params)
	local _, _, _, h = self._beta_update_notes:text_rect()

	self._beta_update_notes:set_h(h)
	self._beta_updates_panel:set_h(self._beta_update_notes:y() + h)
	self._beta_updates_scrollable_area:setup_scroll_area()
end

function RaidMainMenuGui:mouse_over_steam_group_button()
	self._steam_group_button_frame:set_color(Color("ff8880"))
end

function RaidMainMenuGui:mouse_exit_steam_group_button()
	self._steam_group_button_frame:set_color(Color.white)
	self._steam_group_button_frame:stop()
	self._steam_group_button_frame:animate(callback(self, self, "_animate_steam_group_button_release"))
end

function RaidMainMenuGui:mouse_pressed_steam_group_button()
	self._steam_group_button_frame:stop()
	self._steam_group_button_frame:animate(callback(self, self, "_animate_steam_group_button_press"))
end

function RaidMainMenuGui:mouse_released_steam_group_button()
	self._steam_group_button_frame:stop()
	self._steam_group_button_frame:animate(callback(self, self, "_animate_steam_group_button_release"))
	Steam:overlay_activate("url", "http://steamcommunity.com/games/414740")
end

function RaidMainMenuGui:_animate_steam_group_button_press(o)
	local duration = 0.15
	local t = self._steam_button_t * duration
	local center_x = self._steam_group_panel:center_x()
	local center_y = self._steam_group_panel:center_y()

	while t < duration do
		local dt = coroutine.yield()
		t = t + dt
		local current_scale = Easing.quartic_out(t, 1, self._steam_button_pressed_scale - 1, duration)

		self._steam_group_panel:set_w(RaidMainMenuGui.STEAM_GROUP_BUTTON_W * current_scale)
		self._steam_group_panel:set_h(RaidMainMenuGui.STEAM_GROUP_BUTTON_H * current_scale)
		self._steam_group_panel:set_center_x(center_x)
		self._steam_group_panel:set_center_y(center_y)

		self._steam_button_t = t / duration
	end

	self._steam_group_panel:set_w(RaidMainMenuGui.STEAM_GROUP_BUTTON_W * self._steam_button_pressed_scale)
	self._steam_group_panel:set_h(RaidMainMenuGui.STEAM_GROUP_BUTTON_H * self._steam_button_pressed_scale)
	self._steam_group_panel:set_center_x(center_x)
	self._steam_group_panel:set_center_y(center_y)

	self._steam_button_t = 1
end

function RaidMainMenuGui:_animate_steam_group_button_release(o)
	local duration = 0.15
	local t = (1 - self._steam_button_t) * duration
	local center_x = self._steam_group_panel:center_x()
	local center_y = self._steam_group_panel:center_y()

	while t < duration do
		local dt = coroutine.yield()
		t = t + dt
		local current_scale = Easing.quartic_out(t, self._steam_button_pressed_scale, 1 - self._steam_button_pressed_scale, duration)

		self._steam_group_panel:set_w(RaidMainMenuGui.STEAM_GROUP_BUTTON_W * current_scale)
		self._steam_group_panel:set_h(RaidMainMenuGui.STEAM_GROUP_BUTTON_H * current_scale)
		self._steam_group_panel:set_center_x(center_x)
		self._steam_group_panel:set_center_y(center_y)

		self._steam_button_t = t / duration
	end

	self._steam_group_panel:set_w(RaidMainMenuGui.STEAM_GROUP_BUTTON_W)
	self._steam_group_panel:set_h(RaidMainMenuGui.STEAM_GROUP_BUTTON_H)
	self._steam_group_panel:set_right(self._root_panel:w() - 96)
	self._steam_group_panel:set_bottom(self._root_panel:h() - 77)

	self._steam_button_t = 0
end

function RaidMainMenuGui:mouse_over_full_game_button()
	self._full_game_button_frame:set_color(Color("ff8880"))
end

function RaidMainMenuGui:mouse_exit_full_game_button()
	self._full_game_button_frame:set_color(Color.white)
	self._full_game_button_frame:stop()
	self._full_game_button_frame:animate(callback(self, self, "_animate_full_game_button_release"))
end

function RaidMainMenuGui:mouse_pressed_full_game_button()
	self._full_game_button_frame:stop()
	self._full_game_button_frame:animate(callback(self, self, "_animate_full_game_button_press"))
end

function RaidMainMenuGui:mouse_released_full_game_button()
	self._full_game_button_frame:stop()
	self._full_game_button_frame:animate(callback(self, self, "_animate_full_game_button_release"))

	RaidMenuCreditsGui.FILE = "full_game_info"
	RaidMenuCreditsGui.INTRO_VIDEO = nil

	managers.raid_menu:open_menu("raid_credits_menu")
end

function RaidMainMenuGui:_animate_full_game_button_press(o)
	local duration = 0.15
	local t = self._steam_button_t * duration
	local center_x = self._full_game_panel:center_x()
	local center_y = self._full_game_panel:center_y()

	while t < duration do
		local dt = coroutine.yield()
		t = t + dt
		local current_scale = Easing.quartic_out(t, 1, self._steam_button_pressed_scale - 1, duration)

		self._full_game_panel:set_w(RaidMainMenuGui.STEAM_GROUP_BUTTON_W * current_scale)
		self._full_game_panel:set_h(RaidMainMenuGui.STEAM_GROUP_BUTTON_H * current_scale)
		self._full_game_panel:set_center_x(center_x)
		self._full_game_panel:set_center_y(center_y)

		self._steam_button_t = t / duration
	end

	self._full_game_panel:set_w(RaidMainMenuGui.STEAM_GROUP_BUTTON_W * self._steam_button_pressed_scale)
	self._full_game_panel:set_h(RaidMainMenuGui.STEAM_GROUP_BUTTON_H * self._steam_button_pressed_scale)
	self._full_game_panel:set_center_x(center_x)
	self._full_game_panel:set_center_y(center_y)

	self._steam_button_t = 1
end

function RaidMainMenuGui:_animate_full_game_button_release(o)
	local duration = 0.15
	local t = (1 - self._steam_button_t) * duration
	local center_x = self._full_game_panel:center_x()
	local center_y = self._full_game_panel:center_y()

	while t < duration do
		local dt = coroutine.yield()
		t = t + dt
		local current_scale = Easing.quartic_out(t, self._steam_button_pressed_scale, 1 - self._steam_button_pressed_scale, duration)

		self._full_game_panel:set_w(RaidMainMenuGui.STEAM_GROUP_BUTTON_W * current_scale)
		self._full_game_panel:set_h(RaidMainMenuGui.STEAM_GROUP_BUTTON_H * current_scale)
		self._full_game_panel:set_center_x(center_x)
		self._full_game_panel:set_center_y(center_y)

		self._steam_button_t = t / duration
	end

	self._full_game_panel:set_w(RaidMainMenuGui.STEAM_GROUP_BUTTON_W)
	self._full_game_panel:set_h(RaidMainMenuGui.STEAM_GROUP_BUTTON_H)
	self._full_game_panel:set_right(self._root_panel:w() - 96 - RaidMainMenuGui.STEAM_GROUP_BUTTON_W - 42)
	self._full_game_panel:set_bottom(self._root_panel:h() - 77)

	self._steam_button_t = 0
end

function RaidMainMenuGui:_layout_kick_mute_widget()
	if self._widget_panel then
		self._widget_panel:clear()
	else
		local widget_panel_params = {
			halign = "right",
			name = "widget_panel",
			valign = "top",
			y = RaidMainMenuGui.WIDGET_PANEL_Y,
			w = RaidMainMenuGui.WIDGET_PANEL_W,
			h = RaidMainMenuGui.WIDGET_PANEL_H
		}
		self._widget_panel = self._root_panel:panel(widget_panel_params)

		self._widget_panel:set_right(self._root_panel:w())
	end

	if not alive(self._widget_label_panel) then
		local label_panel_params = {
			visible = false,
			name = "widget_label_panel",
			h = 64,
			halign = "scale"
		}
		self._widget_label_panel = self._widget_panel:get_engine_panel():panel(label_panel_params)

		self._widget_label_panel:set_right(self._widget_panel:w())
	end

	local widget_title_params = {
		name = "widget_title",
		h = 64,
		vertical = "center",
		align = "left",
		halign = "left",
		x = 32,
		w = self._widget_panel:w() - 32,
		font = tweak_data.gui:get_font_path(tweak_data.gui.fonts.din_compressed, tweak_data.gui.font_sizes.menu_list),
		font_size = tweak_data.gui.font_sizes.menu_list,
		color = tweak_data.gui.colors.raid_dirty_white,
		text = self:translate("menu_kick_mute_widget_title", true)
	}
	local widget_title = self._widget_label_panel:text(widget_title_params)
	local widget_action_title_params = {
		name = "widget_action_title",
		h = 64,
		vertical = "center",
		w = 150,
		align = "right",
		text = "",
		halign = "right",
		font = tweak_data.gui:get_font_path(tweak_data.gui.fonts.din_compressed, tweak_data.gui.font_sizes.extra_small),
		font_size = tweak_data.gui.font_sizes.extra_small,
		color = tweak_data.gui.colors.raid_grey_effects
	}
	self._widget_action_title = self._widget_label_panel:text(widget_action_title_params)

	self._widget_action_title:set_right(self._widget_label_panel:w())
	self._widget_action_title:set_center_y(widget_title:center_y())

	local peers = managers.network:session():peers()
	self._widgets = {}

	for i = 1, 3 do
		local widget_params = {
			index = i,
			name = "kick_mute_widget_" .. tostring(i),
			y = i * 64,
			menu_move = {
				left = "list_menu"
			},
			on_button_selected_callback = callback(self, self, "on_widget_button_selected"),
			on_button_unselected_callback = callback(self, self, "on_widget_button_unselected")
		}
		local widget = self._widget_panel:create_custom_control(RaidGUIControlKickMuteWidget, widget_params)

		table.insert(self._widgets, widget)
	end

	managers.menu_component:gather_controls_for_component(self._name)

	local widget_index = 1
	local invite_widget_shown = false
	local largest_w = 0

	for index, peer in pairs(peers) do
		self._widgets[widget_index]:set_peer(peer, true, Network:is_server())
		self._widgets[widget_index]:set_visible(true)
		self._widget_label_panel:set_visible(true)

		local w = self._widgets[widget_index]:calculate_width()

		if largest_w < w then
			largest_w = w
		end

		widget_index = widget_index + 1
	end

	if widget_index < 4 and self._display_invite_widget then
		self._widgets[widget_index]:set_invite_widget()
		self._widgets[widget_index]:set_visible(true)
		self._widget_label_panel:set_visible(true)

		invite_widget_shown = true
		local w = self._widgets[widget_index]:calculate_width()

		if largest_w < w then
			largest_w = w
		end
	else
		widget_index = widget_index - 1
	end

	for i = 1, #self._widgets do
		local w = self._widgets[i]:calculate_width()

		if largest_w < w then
			largest_w = w
		end

		if self._widgets[i]:visible() then
			self._widgets[i]:set_move_controls(widget_index, invite_widget_shown)
		end
	end

	if not self._widget_label_panel:visible() then
		self._list_menu:set_selected(true)
	else
		self._widget_panel:set_w(largest_w)
		self._widget_panel:set_right(self._root_panel:w())

		for i = 1, #self._widgets do
			self._widgets[i]:set_w(largest_w)
		end
	end

	for id, widget_data in pairs(self._widgets) do
		widget_data:set_selected(false)
	end

	self._list_menu:set_selected(true)

	local menu_move = {}

	if self._widget_label_panel:visible() then
		if widget_index > 0 then
			if SystemInfo:platform() == Idstring("XB1") then
				menu_move.right = "gamercard_button_1"
			else
				menu_move.right = "mute_button_1"
			end
		elseif self._display_invite_widget then
			menu_move.right = "invite_button_1"
		end
	end

	self._list_menu:set_menu_move_controls(menu_move)
end

function RaidMainMenuGui:on_widget_button_selected(button)
	local widget_action = nil

	if button == "kick" then
		widget_action = "menu_kick_widget_label"
	elseif button == "mute" then
		widget_action = "menu_mute_widget_label"
	elseif button == "unmute" then
		widget_action = "menu_unmute_widget_label"
	elseif button == "gamercard" then
		widget_action = "menu_gamercard_widget_label"
	elseif button == "invite" then
		widget_action = "menu_widget_label_action_invite_player"
	end

	self._widget_action_title:set_text(self:translate(widget_action, true))
end

function RaidMainMenuGui:on_widget_button_unselected(button)
	self._widget_action_title:set_text("")
end

function RaidMainMenuGui:_list_menu_data_source()
	local _list_items = {}

	table.insert(_list_items, {
		callback = "raid_play_online",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_IN_MAIN_MENU
		},
		text = utf8.to_upper(managers.localization:text("menu_play"))
	})
	table.insert(_list_items, {
		callback = "raid_play_offline",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_IN_MAIN_MENU
		},
		text = utf8.to_upper(managers.localization:text("menu_play_offline"))
	})
	table.insert(_list_items, {
		callback = "raid_play_tutorial",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.SHOULD_SHOW_TUTORIAL
		},
		text = utf8.to_upper(managers.localization:text("menu_tutorial_hl"))
	})
	table.insert(_list_items, {
		callback = "resume_game_raid",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_NOT_IN_MAIN_MENU
		},
		text = utf8.to_upper(managers.localization:text("menu_resume_game"))
	})
	table.insert(_list_items, {
		callback = "singleplayer_restart_game_to_camp",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.SINGLEPLAYER_RESTART
		},
		text = utf8.to_upper(managers.localization:text("menu_restart_to_camp"))
	})
	table.insert(_list_items, {
		callback = "restart_to_camp",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.RESTART_LEVEL_VISIBLE
		},
		text = utf8.to_upper(managers.localization:text("menu_restart_to_camp"))
	})
	table.insert(_list_items, {
		callback = "on_mission_selection_clicked",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_IN_CAMP
		},
		breadcrumb = {
			delay = 0.2,
			category = BreadcrumbManager.CATEGORY_CONSUMABLE_MISSION
		},
		text = utf8.to_upper(managers.localization:text("menu_mission_selection"))
	})
	table.insert(_list_items, {
		callback = "on_select_character_profile_clicked",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_IN_CAMP
		},
		breadcrumb = {
			delay = 0.2,
			category = BreadcrumbManager.CATEGORY_CHARACTER_CUSTOMIZATION
		},
		text = utf8.to_upper(managers.localization:text("menu_character_setup"))
	})
	table.insert(_list_items, {
		callback = "on_select_character_skills_clicked",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_IN_CAMP
		},
		breadcrumb = {
			delay = 0.2,
			category = BreadcrumbManager.CATEGORY_RANK_REWARD
		},
		text = utf8.to_upper(managers.localization:text("menu_skills"))
	})
	table.insert(_list_items, {
		callback = "on_weapon_select_clicked",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_IN_CAMP
		},
		breadcrumb = {
			delay = 0.2,
			category = BreadcrumbManager.CATEGORY_WEAPON,
			check_callback = callback(managers.weapon_skills, managers.weapon_skills, "has_new_weapon_upgrades")
		},
		text = utf8.to_upper(managers.localization:text("menu_header_weapons_screen_name"))
	})
	table.insert(_list_items, {
		callback = "on_select_challenge_cards_view_clicked",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_IN_CAMP
		},
		breadcrumb = {
			delay = 0.2,
			category = BreadcrumbManager.CATEGORY_CARD
		},
		text = utf8.to_upper(managers.localization:text("menu_challenge_cards"))
	})
	table.insert(_list_items, {
		callback = "on_multiplayer_clicked",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_IN_CAMP,
			RaidGUIItemAvailabilityFlag.IS_MULTIPLAYER
		},
		text = utf8.to_upper(managers.localization:text("menu_servers"))
	})
	table.insert(_list_items, {
		callback = "on_options_clicked",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_NOT_IN_CAMP,
			RaidGUIItemAvailabilityFlag.IS_NOT_IN_MAIN_MENU
		},
		text = utf8.to_upper(managers.localization:text("menu_options"))
	})
	table.insert(_list_items, {
		callback = "on_options_clicked",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_IN_CAMP
		},
		text = utf8.to_upper(managers.localization:text("menu_options"))
	})
	table.insert(_list_items, {
		callback = "on_options_clicked",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_IN_MAIN_MENU
		},
		text = utf8.to_upper(managers.localization:text("menu_options"))
	})
	table.insert(_list_items, {
		callback = "show_credits",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_IN_MAIN_MENU
		},
		text = utf8.to_upper(managers.localization:text("menu_credits"))
	})
	table.insert(_list_items, {
		callback = "end_game",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_NOT_EDITOR,
			RaidGUIItemAvailabilityFlag.IS_NOT_IN_MAIN_MENU
		},
		text = utf8.to_upper(managers.localization:text("menu_end_game"))
	})
	table.insert(_list_items, {
		callback = "quit_game",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_NOT_EDITOR,
			RaidGUIItemAvailabilityFlag.IS_IN_MAIN_MENU
		},
		text = utf8.to_upper(managers.localization:text("menu_quit"))
	})
	table.insert(_list_items, {
		callback = "quit_game",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_NOT_EDITOR,
			RaidGUIItemAvailabilityFlag.IS_NOT_IN_MAIN_MENU,
			RaidGUIItemAvailabilityFlag.IS_IN_CAMP
		},
		text = utf8.to_upper(managers.localization:text("menu_quit"))
	})
	table.insert(_list_items, {
		callback = "quit_game_pause_menu",
		availability_flags = {
			RaidGUIItemAvailabilityFlag.IS_NOT_EDITOR,
			RaidGUIItemAvailabilityFlag.IS_NOT_IN_MAIN_MENU,
			RaidGUIItemAvailabilityFlag.IS_NOT_IN_CAMP
		},
		text = utf8.to_upper(managers.localization:text("menu_quit"))
	})

	return _list_items
end

function RaidMainMenuGui:_on_list_menu_item_selected(data)
	if not data.callback then
		return
	end

	self._callback_handler = self._callback_handler or RaidMenuCallbackHandler:new()
	local on_click_callback = callback(self._callback_handler, self._callback_handler, data.callback)

	if on_click_callback then
		on_click_callback()
	end
end
