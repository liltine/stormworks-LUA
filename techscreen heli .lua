a = {}
a.Objects = {}
function a:draw()
    for b, c in pairs(self.Objects) do
        c:draw()
    end
end

function e(f, g, h, i, j, k)
    return f >= h and f <= h + j and g >= i and g <= i + k
end

function a:callbacks(f, g)
    for b, c in pairs(self.Objects) do
        if c.ckbl then
            if e(f, g, c.x, c.y, c.w, c.h) then
                c:cb()
            end
        end
    end
end
l = {}
function l.new(m, n, o, p, q, r)
    local s = {}
    s.name = m
    s.x = n
    s.y = o
    s.w = p
    s.h = q
    s.ckbl = r
    for b, t in pairs(l) do
        s[b] = t
    end
    a.Objects[m] = s
    return s
end

function l:draw()
end
u = {}
function u.new(m, n, o, v, w, x, y, z)
    local s = l.new(m, n, o, string.len(w) * 5 + 1, 7, true)
    s.OF = v
    s.text = w
    s.colorOff = x
    s.colorOn = y
    s.cb = z
    for b, t in pairs(u) do
        s[b] = t
    end
    return s
end

function u:draw()
    if self.OF then
        B = self.colorOn
    else
        B = self.colorOff
    end
    screen.setColor(B[1], B[2], B[3])
    screen.drawText(self.x + 1, self.y + 1, self.text)
    screen.drawRect(self.x, self.y, string.len(self.text) * 5 + 1, 7)
end
D = {}
function D.new(m, E, n, o, p, q, r, F, G, H, I)
    local s = l.new(m, n, o, p, q, r)
    s.lbl = E
    s.val = F
    s.minv = G
    s.maxv = H
    s.cb = I
    for b, t in pairs(D) do
        s[b] = t
    end
    return s
end
J = {}
function J.new(m, E, n, o, p, r, F, G, H, K, I)
    local self = D.new(m, E, n, o, p, 5, r, F, G, H, I)
    self.col = K
    for b, t in pairs(J) do
        self[b] = t
    end
    return self
end

function J:draw()
    local s = self
    local L, M = (s.val - s.minv) / (s.maxv - s.minv), (0 - s.minv) / (s.maxv - s.minv)
    local N, O = math.min(1, math.max(0, L)), math.min(1, math.max(0, M))
    screen.setColor(s.col[1], s.col[2], s.col[3])
    screen.drawRectF(s.x + 5 + (s.w - 5) * O, s.y, (s.w - 5) * (N - O), s.h)
    screen.setColor(255, 255, 255)
    if L > 1 or L < 0 then
        screen.setColor(255, 0, 0)
    end
    screen.drawRect(s.x + 5, s.y, s.w - 5, s.h)
    screen.drawLine(s.x + 5 + (s.w - 5) * O, s.y, s.x + 5 + (s.w - 5) * O, s.y + s.h)
    screen.drawText(s.x, s.y, s.lbl)
end
Q = {}
function Q.new(m, E, n, o, q, r, F, G, H, K, I)
    local self = D.new(m, E, n, o, 4, q, r, F, G, H, I)
    self.col = K
    for b, t in pairs(Q) do
        self[b] = t
    end
    return self
end

function Q:draw()
    local s = self
    local L, M = (s.val - s.minv) / (s.maxv - s.minv), (0 - s.minv) / (s.maxv - s.minv)
    local N, O = math.min(1, math.max(0, L)), math.min(1, math.max(0, M))
    screen.setColor(s.col[1], s.col[2], s.col[3])
    screen.drawRectF(s.x, s.y + 6 + (s.h - 6) * (1 - O), s.w, (s.h - 6) * (O - N))
    screen.setColor(255, 255, 255)
    if L > 1 or L < 0 then
        screen.setColor(255, 0, 0)
    end
    screen.drawRect(s.x, s.y + 6, s.w, s.h - 6)
    screen.drawLine(s.x, s.y + 6 + (s.h - 6) * (1 - O), s.x + s.w, s.y + 6 + (s.h - 6) * (1 - O))
    screen.drawText(s.x, s.y, s.lbl)
end
R = {}
function R.new(m, n, o, p, q, S, T, K)
    local s = l.new(m, n, o, p, q, false)
    s.valD = S
    s.dur = T
    s.col = K
    s.tpp = T / p
    s.vt = {}
    for U = 1, p, 1 do
        s.vt[U] = 0
    end
    s.lvt = 0
    for b, t in pairs(R) do
        s[b] = t
    end
    return s
end

function R:draw()
    local s = self
    local M, V, W = (0 - s.valD.minv) / (s.valD.maxv - s.valD.minv), 0, 0
    local O = math.min(1, math.max(0, M))
    screen.setColor(255, 255, 255)
    screen.drawRect(s.x, s.y, s.w, s.h)
    screen.drawText(s.x + 1, s.y + 1, s.valD.lbl)
    for U = 1, s.w, 4 do
        screen.drawLine(s.x + U, s.y + s.h * (1 - O), s.x + U + 1, s.y + s.h * (1 - O))
    end
    screen.setColor(s.col[1], s.col[2], s.col[3])
    W = math.min(1, math.max(0, (s.vt[1] - s.valD.minv) / (s.valD.maxv - s.valD.minv)))
    for U = 2, s.w, 1 do
        V = W
        W = math.min(1, math.max(0, (s.vt[U] - s.valD.minv) / (s.valD.maxv - s.valD.minv)))
        screen.drawLine(s.x + s.w - U + 1, s.y + s.h * (1 - V), s.x + s.w - U, s.y + s.h * (1 - W))
    end
    if (X - s.lvt) % 6000 > s.tpp then
        for U = s.w, 2, -1 do
            s.vt[U] = s.vt[U - 1]
        end
        s.vt[1] = s.valD.val
        s.lvt = X
    end
end

function Y(Z)
    Z.OF = not Z.OF
end

function _(c)
    for U = 1, a0.w, 1 do
        a0.vt[U] = 0
    end
    a0.valD = c
end
a1 = J.new("rps", "E", 1, 1, 25, true, 4, 5, 20, {255, 50, 0}, _)
a2 = J.new("thrtl", "T", 1, 9, 25, true, 0, 0, 1, {0, 255, 20}, _)
a3 = J.new("yaw", "Y", 1, 17, 25, true, 0, -0.1, 0.4, {0, 122, 255}, _)
a4 = J.new("roll", "R", 1, 25, 25, true, 0, -1, 1, {0, 122, 255}, _)
a5 = Q.new("pitch", "P", 7, 33, 25, true, 0, -1, 1, {0, 122, 255}, _)
a6 = Q.new("Col", "C", 14, 33, 25, true, 0, -1, 1, {0, 122, 255}, _)
a0 = R.new("pitchG", 27, 1, 37, 63, a5, 180, {0, 0, 255})
X = 0
function onTick()
    X = X + 1 % 6000
    a7 = input.getBool(1)
    a9 = input.getBool(2)
    aa = a7 and not ab
    ac = a9 and not ad
    ab = a7
    ad = a9
    ae = input.getNumber(1)
    af = input.getNumber(2)
    ag = input.getNumber(3)
    ah = input.getNumber(4)
    ai = input.getNumber(5)
    aj = input.getNumber(6)
    a1.val = input.getNumber(7)
    a2.val = input.getNumber(8)
    a3.val = input.getNumber(9)
    a4.val = input.getNumber(10)
    a5.val = input.getNumber(11)
    a6.val = input.getNumber(12)
    if aa then
        a:callbacks(ag, ah)
    end
end

function onDraw()
    a:draw()
end
