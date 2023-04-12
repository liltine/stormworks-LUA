Form = {}
Form.Objects = {}
function Form:draw()
    for b, c in pairs(self.Objects) do
        c:draw()
    end
end

function IsInRectangle(x, y, x_rect, y_rect, width, height)
    return x >= x_rect and x <= x_rect + width and y >= y_rect and y <= y_rect + height
end

function Form:callbacks(x, y)
    for b, c in pairs(self.Objects) do
        if c.ckbl then
            if IsInRectangle(x, y, c.x, c.y, c.w, c.h) then
                c:callback()
            end
        end
    end
end

Object = {}
function Object.new(name, x, y, w, h, asCallBack)
    local s = {}
    s.name = name
    s.x = x
    s.y = y
    s.w = w
    s.h = h
    s.asCallBack = asCallBack
    for b, t in pairs(Object) do
        s[b] = t
    end
    Form.Objects[name] = s
    return s
end

function Object:draw()
end

Button = {}
function Button.new(name, x, y, isOn, text, colorOff, colorOn, callback)
    local s = Object.new(name, x, y, string.len(text) * 5 + 1, 7, true)
    s.isOn = isOn
    s.text = text
    s.colorOff = colorOff
    s.colorOn = colorOn
    s.CallBack = callback
    for b, t in pairs(Button) do
        s[b] = t
    end
    return s
end

function Button:draw()
    if self.isOn then
        color = self.colorOn
    else
        color = self.colorOff
    end
    screen.setColor(color[1], color[2], color[3])
    screen.drawText(self.x + 1, self.y + 1, self.text)
    screen.drawRect(self.x, self.y, string.len(self.text) * 5 + 1, 7)
end

ValueBar = {}
function ValueBar.new(name, label, x, y, w, h, asCallBack, value, minValue, maxValue, CallBack)
    local s = Object.new(name, x, y, w, h, asCallBack)
    s.label = label
    s.value = value
    s.minValue = minValue
    s.maxValue = maxValue
    s.CallBack = CallBack
    for b, t in pairs(ValueBar) do
        s[b] = t
    end
    return s
end

HorizontalValueBar = {}
function HorizontalValueBar.new(name, label, x, y, w, asCallBack, value, minValue, maxValue, color, CallBack)
    local self = ValueBar.new(name, label, x, y, w, 5, asCallBack, value, minValue, maxValue, CallBack)
    self.color = color
    for b, t in pairs(HorizontalValueBar) do
        self[b] = t
    end
    return self
end

function HorizontalValueBar:draw()
    local BarEnd, ZeroPosition = (self.value - self.minValue) / (self.maxValue - self.minValue), (0 - self.minValue) / (self.maxValue - self.minValue)
    local cappedBarEnd, cappedZeroPosition = math.min(1, math.max(0, BarEnd)), math.min(1, math.max(0, ZeroPosition))
    screen.setColor(self.color[1], self.color[2], self.color[3])
    screen.drawRectF(self.x + 5 + (self.w - 5) * cappedZeroPosition, self.y, (self.w - 5) * (cappedBarEnd - cappedZeroPosition), self.h)
    screen.setColor(255, 255, 255)
    if BarEnd > 1 or BarEnd < 0 then
        screen.setColor(255, 0, 0)
    end
    screen.drawRect(self.x + 5, self.y, self.w - 5, self.h)
    screen.drawLine(self.x + 5 + (self.w - 5) * cappedZeroPosition, self.y, self.x + 5 + (self.w - 5) * cappedZeroPosition, self.y + self.h)
    screen.drawText(self.x, self.y, self.label)
end

VerticalValueBar = {}
function VerticalValueBar.new(name, label, x, y, h, hasCallBack, value, minValue, maxValue, color, CallBack)
    local self = ValueBar.new(name, label, x, y, 4, h, hasCallBack, value, minValue, maxValue, CallBack)
    self.color = color
    for b, t in pairs(VerticalValueBar) do
        self[b] = t
    end
    return self
end

function VerticalValueBar:draw()
    local s = self
    local BarEnd, ZeroPosition = (s.value - s.minValue) / (s.maxValue - s.minValue), (0 - s.minValue) / (s.maxValue - s.minValue)
    local cappedBarEnd, cappedZeroPosition = math.min(1, math.max(0, BarEnd)), math.min(1, math.max(0, ZeroPosition))
    screen.setColor(s.color[1], s.color[2], s.color[3])
    screen.drawRectF(s.x, s.y + 6 + (s.h - 6) * (1 - cappedZeroPosition), s.w, (s.h - 6) * (cappedZeroPosition - cappedBarEnd))
    screen.setColor(255, 255, 255)
    if BarEnd > 1 or BarEnd < 0 then
        screen.setColor(255, 0, 0)
    end
    screen.drawRect(s.x, s.y + 6, s.w, s.h - 6)
    screen.drawLine(s.x, s.y + 6 + (s.h - 6) * (1 - cappedZeroPosition), s.x + s.w, s.y + 6 + (s.h - 6) * (1 - cappedZeroPosition))
    screen.drawText(s.x, s.y, s.label)
end

TimeGraph = {}
function TimeGraph.new(name, x, y, w, h, valueBar, duration, color)
    local s = Object.new(name, x, y, w, h, false)
    s.valueD = valueBar
    s.duration = duration
    s.color = color
    s.timePerPixel = duration / w
    s.valueTable = {}
    for U = 1, w, 1 do
        s.valueTable[U] = 0
    end
    s.lastValueTickTime = 0
    for b, t in pairs(TimeGraph) do
        s[b] = t
    end
    return s
end

function TimeGraph:draw()
    local s = self
    local ZeroPosition, oldValueHeight, valueHeight = (0 - self.valueD.minValue) / (self.valueD.maxValue - self.valueD.minValue), 0, 0
    local ZeroPositionCapped = math.min(1, math.max(0, ZeroPosition))
    screen.setColor(255, 255, 255)
    screen.drawRect(self.x, self.y, self.w, self.h)
    screen.drawText(self.x + 1, self.y + 1, self.valueD.label)
    for U = 1, self.w, 4 do
        screen.drawLine(self.x + U, self.y + self.h * (1 - ZeroPositionCapped), self.x + U + 1, self.y + self.h * (1 - ZeroPositionCapped))
    end
    screen.setColor(self.color[1], self.color[2], self.color[3])
    valueHeight = math.min(1, math.max(0, (self.valueTable[1] - self.valueD.minValue) / (self.valueD.maxValue - self.valueD.minValue)))
    for U = 2, self.w, 1 do
        oldValueHeight = valueHeight
        valueHeight = math.min(1, math.max(0, (self.valueTable[U] - self.valueD.minValue) / (self.valueD.maxValue - self.valueD.minValue)))
        screen.drawLine(self.x + self.w - U + 1, self.y + self.h * (1 - oldValueHeight), self.x + self.w - U, self.y + self.h * (1 - valueHeight))
    end
    if (TickTimer - self.lastValueTickTime) % 6000 > self.timePerPixel then
        for U = self.w, 2, -1 do
            self.valueTable[U] = self.valueTable[U - 1]
        end
        self.valueTable[1] = self.valueD.value
        self.lastValueTickTime = TickTimer
    end
end

--function Y(Z)
--    Z.isOn = not Z.isOn
--end

function changeGraph(valueBarToDisplay)
    for U = 1, Graph.w, 1 do
        Graph.valueTable[U] = 0
    end
    Graph.valueD = valueBarToDisplay
end
rpsBar = HorizontalValueBar.new("rps", "E", 1, 1, 25, true, 4, 5, 20, {255, 50, 0}, changeGraph)
throttleBar = HorizontalValueBar.new("thrtl", "T", 1, 9, 25, true, 0, 0, 1, {0, 255, 20}, changeGraph)
yawBar = HorizontalValueBar.new("yaw", "Y", 1, 17, 25, true, 0, -0.1, 0.4, {0, 122, 255}, changeGraph)
RollBar = HorizontalValueBar.new("roll", "R", 1, 25, 25, true, 0, -1, 1, {0, 122, 255}, changeGraph)
pitchBar = VerticalValueBar.new("pitch", "P", 7, 33, 25, true, 0, -1, 1, {0, 122, 255}, changeGraph)
CollectiveBar = VerticalValueBar.new("Col", "C", 14, 33, 25, true, 0, -1, 1, {0, 122, 255}, changeGraph)
Graph = TimeGraph.new("pitchG", 27, 1, 37, 63, pitchBar, 180, {0, 0, 255})
TickTimer = 0
function onTick()
    TickTimer = TickTimer + 1 % 6000
    Touched = input.getBool(1)
    TouchedSec = input.getBool(2)
    newTouch = Touched and not oldTouched
    newTouchSec = TouchedSec and not oldTouchedSec
    oldTouched = Touched
    oldTouchedSec = TouchedSec
    screenResolutionX = input.getNumber(1)
    screenResolutionY = input.getNumber(2)
    input1X = input.getNumber(3)
    input1Y = input.getNumber(4)
    input2X = input.getNumber(5)
    input2Y = input.getNumber(6)
    rpsBar.value = input.getNumber(7)
    throttleBar.value = input.getNumber(8)
    yawBar.value = input.getNumber(9)
    RollBar.value = input.getNumber(10)
    pitchBar.value = input.getNumber(11)
    CollectiveBar.value = input.getNumber(12)
    if newTouch then
        Form:callbacks(input1X, input1Y)
    end
end

function onDraw()
    Form:draw()
end
