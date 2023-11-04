local wezterm = require 'wezterm'

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'AtomOneLight'

config.font_size = 14

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.font = wezterm.font {
    family = 'Iosevka Term',
    stretch = 'Expanded',
    weight = 'Regular',
}

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }

-- Use bash as NON login shell.
-- Login shells won't run .bashrc and I have my things set up
-- in .bashrc. I probably should migrate to .bash_profile at some point
config.default_prog = { '/usr/bin/bash' }


return config

