RaidGUIControlPeerDetails = RaidGUIControlPeerDetails or class(RaidGUIControl)
RaidGUIControlPeerDetails.FONT = tweak_data.gui.fonts.din_compressed
RaidGUIControlPeerDetails.NAME_FONT_SIZE = 26
RaidGUIControlPeerDetails.NAME_PADDING_DOWN = 10
RaidGUIControlPeerDetails.NAME_COLOR = tweak_data.gui.colors.raid_light_red
RaidGUIControlPeerDetails.DEFAULT_W = 300
RaidGUIControlPeerDetails.DEFAULT_H = 120
RaidGUIControlPeerDetails.CLASS_ICON_PADDING_LEFT = 5
RaidGUIControlPeerDetails.ICON_TITLE_FONT_SIZE = 38
RaidGUIControlPeerDetails.ICON_FONT_SIZE = 14

function RaidGUIControlPeerDetails:init(parent, params)
	RaidGUIControlPeerDetails.super.init(self, parent, params)

	if not params then
		Application:error("[RaidGUIControlPeerDetails:init] Parameters not specified for the peer details control " .. tostring(self._name))

		return
	end

	self._pointer_type = "arrow"

	self:highlight_off()
	self:_create_panel()
	self:_create_profile_name()
	self:_create_profile_details()
end

function RaidGUIControlPeerDetails:_create_panel()
	local panel_params = clone(self._params)
	panel_params.name = panel_params.name .. "_panel"
	panel_params.layer = self._panel:layer() + 1
	panel_params.x = self._params.x or 0
	panel_params.y = self._params.y or 0
	panel_params.w = self._params.w or RaidGUIControlPeerDetails.DEFAULT_W
	panel_params.h = RaidGUIControlPeerDetails.DEFAULT_H
	self._object = self._panel:panel(panel_params)
end

function RaidGUIControlPeerDetails:_create_profile_name()
	local profile_name_params = {
		text = "PROFILE NAME",
		name = "profile_name",
		y = 0,
		x = 0,
		w = self._object:w(),
		font = RaidGUIControlPeerDetails.FONT,
		font_size = RaidGUIControlPeerDetails.NAME_FONT_SIZE,
		color = RaidGUIControlPeerDetails.NAME_COLOR
	}
	self._profile_name = self._object:text(profile_name_params)
	local _, _, w, h = self._profile_name:text_rect()

	self._profile_name:set_h(h)
end

function RaidGUIControlPeerDetails:_create_profile_details()
	local profile_details_panel_params = {
		name = "profile_details_panel",
		x = 0,
		y = self._profile_name:y() + self._profile_name:h() + RaidGUIControlPeerDetails.NAME_PADDING_DOWN,
		w = self._object:w()
	}
	self._profile_details_panel = self._object:panel(profile_details_panel_params)

	self._profile_details_panel:set_h(self._object:h() - self._profile_details_panel:y())

	local class_icon_params = {
		text = "INFILTRATOR",
		name = "class_icon",
		icon_h = 48,
		y = 0,
		icon = "ico_class_infiltrator",
		x = RaidGUIControlPeerDetails.CLASS_ICON_PADDING_LEFT,
		text_size = RaidGUIControlPeerDetails.ICON_FONT_SIZE
	}
	self._class_icon = self._profile_details_panel:info_icon(class_icon_params)
	local nationality_icon_params = {
		text = "AMERICAN",
		name = "nationality_icon",
		x = 110,
		icon = "ico_flag_american",
		icon_h = 48,
		icon_color = Color.white,
		text_size = RaidGUIControlPeerDetails.ICON_FONT_SIZE
	}
	self._nationality_icon = self._profile_details_panel:info_icon(nationality_icon_params)
	local level_icon_params = {
		name = "level_icon",
		title = "00",
		x = 210,
		title_size = RaidGUIControlPeerDetails.ICON_TITLE_FONT_SIZE,
		text = self:translate("menu_level_label", true),
		text_size = RaidGUIControlPeerDetails.ICON_FONT_SIZE
	}
	self._level_icon = self._profile_details_panel:info_icon(level_icon_params)
end

function RaidGUIControlPeerDetails:set_profile_name(name)
	self._profile_name:set_text(utf8.to_upper(name))
end

function RaidGUIControlPeerDetails:set_class(character_class)
	local params = {
		icon_h = 48,
		color = Color.black,
		text_size = RaidGUIControlPeerDetails.ICON_FONT_SIZE
	}

	self._class_icon:set_icon("ico_class_" .. character_class, params)
	self._class_icon:set_text("skill_class_" .. character_class .. "_name", params)
end

function RaidGUIControlPeerDetails:set_nationality(nationality)
	local params = {
		icon_h = 48,
		text_size = RaidGUIControlPeerDetails.ICON_FONT_SIZE
	}

	self._nationality_icon:set_icon("ico_flag_" .. nationality, params)
	self._nationality_icon:set_text("nationality_" .. nationality, params)
end

function RaidGUIControlPeerDetails:set_level(level)
	self._level_icon:set_title(tostring(level))
end

function RaidGUIControlPeerDetails:close()
end
