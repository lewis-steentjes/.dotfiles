-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'AdventureTime' 

-- Configure Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false 
config.tab_and_split_indices_are_zero_based = true
config.show_tab_index_in_tab_bar = true

-- Configure Window Padding
config.window_padding = {
  left = "1cell",
  right = "1cell",
  
  bottom = "1cell",
  top = "1cell",
}


-- Configure padding to automatically adjust when window is resized
function recompute_padding(window)
  local window_dims = window:get_dimensions()
  local overrides = window:get_config_overrides() or {}

  if not window_dims.is_full_screen then
    if not overrides.window_padding then
      -- not changing anything
      return
    end
    overrides.window_padding = nil
  else
    -- Use only the middle 33%
    local third = math.floor(window_dims.pixel_width / 3)
    local new_padding = {
      left = third,
      right = third,
      top = 0,
      bottom = 0,
    }
    if
      overrides.window_padding
      and new_padding.left == overrides.window_padding.left
    then
      -- padding is same, avoid triggering further changes
      return
    end
    overrides.window_padding = new_padding
  end
  window:set_config_overrides(overrides)
end

wezterm.on('window-resized', function(window, pane)
  recompute_padding(window)
end)

wezterm.on('window-config-reloaded', function(window)
  recompute_padding(window)
end)




-- Configure Close Behaviour
config.window_close_confirmation = 'NeverPrompt'

-- Configure Framerate
--config.animation_fps = 200
-- and finally, return the configuration to wezterm
return config

