--!nonstrict
-- Control-center tile: click = toggle backlight, right-click = open the slider panel.
local DEV = "/sys/class/leds/kbd_backlight"
local level = 0
local lastOn = 50

local function readLevel()
  local cur = tonumber(((noctalia.readFile(DEV .. "/brightness")) or ""):match("%d+"))
  local max = tonumber(((noctalia.readFile(DEV .. "/max_brightness")) or ""):match("%d+"))
  if cur == nil or max == nil or max == 0 then return nil end
  return math.floor(cur * 100 / max + 0.5)
end

local function render()
  local on = level > 0
  shortcut.setLabel(on and `Keyboard {level}%` or "Keyboard off")
  shortcut.setIcon("keyboard", "keyboard-off")
  shortcut.setActive(on)
  shortcut.setEnabled(true)
end

local function refresh()
  local l = readLevel()
  if l ~= nil then
    level = l
    if l > 0 then lastOn = l end
  end
  render()
end

function update()
  noctalia.setUpdateInterval(1000)
  refresh()
end

function onClick()
  level = level > 0 and 0 or lastOn
  noctalia.runAsync({ "brightnessctl", "-q", "-d", "kbd_backlight", "set", `{level}%` })
  noctalia.osd.show(level > 0 and "keyboard" or "keyboard-off", `{level}%`, { progress = level / 100, inactive = level == 0 })
  render()
end

function onRightClick()
  noctalia.togglePanel("local/kbd-backlight:panel")
end

refresh()
