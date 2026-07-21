-- Hammerspoon config. Deploy: cp to ~/.hammerspoon/init.lua
--
-- F12: toggle ghostty, restoring focus to the previously-active app.
-- Replaces ghostty's `keybind = global:f12=toggle_visibility` (removed
-- from ghostty.config), because macOS 15.7+ hands focus to Finder on
-- plain hide instead of the previous app. Here we remember the app we
-- came from and re-activate it explicitly, so macOS never gets a vote.
-- vial maps the d+g chord to F12, so this is the home-row terminal
-- toggle. Registered via the native hotkey API: zero idle overhead.

hs.autoLaunch(true)

local prevApp = nil

hs.hotkey.bind({}, "f12", function()
  local ghostty = hs.application.get("com.mitchellh.ghostty")
      or hs.application.get("Ghostty")
  if ghostty and ghostty:isFrontmost() then
    ghostty:hide()
    if prevApp and prevApp:isRunning() then
      prevApp:activate()
    end
  else
    prevApp = hs.application.frontmostApplication()
    if ghostty then
      ghostty:unhide()
      ghostty:activate()
    else
      hs.application.launchOrFocus("Ghostty")
    end
  end
end)
