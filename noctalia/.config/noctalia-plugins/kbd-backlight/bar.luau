--!nonstrict
-- Bar widget: shows keyboard backlight %, click = slider panel, scroll = +/-5%, right-click = on/off.
local DEV = "/sys/class/leds/kbd_backlight"
local level = nil
local lastOn = 50

local function readLevel()
  local cur = tonumber(((noctalia.readFile(DEV .. "/brightness")) or ""):match("%d+"))
  local max = tonumber(((noctalia.readFile(DEV .. "/max_brightness")) or ""):match("%d+"))
  if cur == nil or max == nil or max == 0 then return nil end
  return math.floor(cur * 100 / max + 0.5)
end

local function render()
  local on = level ~= nil and level > 0
  barWidget.setGlyph(on and "keyboard" or "keyboard-off")
  barWidget.setText(level ~= nil and `{level}%` or "-")
  barWidget.setTooltip("Keyboard backlight - click: slider, scroll: adjust, right-click: on/off")
end

local function setLevel(v)
  v = math.clamp(math.floor(v + 0.5), 0, 100)
  level = v
  if v > 0 then lastOn = v end
  noctalia.runAsync({ "brightnessctl", "-q", "-d", "kbd_backlight", "set", `{v}%` })
  noctalia.osd.show(v > 0 and "keyboard" or "keyboard-off", `{v}%`, { progress = v / 100, inactive = v == 0 })
  render()
end

function update()
  noctalia.setUpdateInterval(1000)
  local l = readLevel()
  if l ~= nil then level = l end
  render()
end

function onClick()
  noctalia.togglePanel("local/kbd-backlight:panel")
end

function onRightClick()
  if level ~= nil and level > 0 then setLevel(0) else setLevel(lastOn) end
end

function onScroll(axis, steps)
  if axis == "vertical" then setLevel((level or 0) - steps * 5) end
end
