--!nonstrict
-- Slider panel for the keyboard backlight.
local DEV = "/sys/class/leds/kbd_backlight"
local level = 0

local function readLevel()
  local cur = tonumber(((noctalia.readFile(DEV .. "/brightness")) or ""):match("%d+"))
  local max = tonumber(((noctalia.readFile(DEV .. "/max_brightness")) or ""):match("%d+"))
  if cur == nil or max == nil or max == 0 then return nil end
  return math.floor(cur * 100 / max + 0.5)
end

local function render()
  panel.render(ui.column({ flexGrow = 1, gap = 14 }, {
    ui.row({ align = "center", gap = 10 }, {
      ui.glyph({ name = level > 0 and "keyboard" or "keyboard-off", size = 20 }),
      ui.label({ text = "Keyboard backlight", fontWeight = "bold", color = "on_surface", flexGrow = 1 }),
      ui.label({ text = `{level}%`, color = "primary" }),
    }),
    ui.slider({ min = 0, max = 100, step = 1, value = level, onChange = "onSlide" }),
  }))
end

function onOpen(_context)
  level = readLevel() or 0
  render()
end

function onSlide(value)
  level = math.clamp(math.floor((tonumber(value) or 0) + 0.5), 0, 100)
  noctalia.runAsync({ "brightnessctl", "-q", "-d", "kbd_backlight", "set", `{level}%` })
  render()
end
