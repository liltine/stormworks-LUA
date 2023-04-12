-- Author: Liltine
-- GitHub: <GithubLink>
-- Workshop: <WorkshopLink>
--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey


--[====[ HOTKEYS ]====]
-- Press F6 to simulate this file
-- Press F7 to build the project, copy the output from /_build/out/ into the game to use
-- Remember to set your Author name etc. in the settings: CTRL+COMMA


--[====[ EDITABLE SIMULATOR CONFIG - *automatically removed from the F7 build output ]====]
---@section __LB_SIMULATOR_ONLY__
do
    ---@type Simulator -- Set properties and screen sizes here - will run once when the script is loaded
    simulator = simulator
    simulator:setScreen(1, "3x3")
    simulator:setProperty("ExampleNumberProperty", 123)

    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)

        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputBool(1, screenConnection.isTouched)
        simulator:setInputNumber(1, screenConnection.width)
        simulator:setInputNumber(2, screenConnection.height)
        simulator:setInputNumber(3, screenConnection.touchX)
        simulator:setInputNumber(4, screenConnection.touchY)

        -- NEW! button/slider options from the UI
        simulator:setInputBool(31, simulator:getIsClicked(1))       -- if button 1 is clicked, provide an ON pulse for input.getBool(31)
        simulator:setInputNumber(31, simulator:getSlider(1))        -- set input 31 to the value of slider 1

        simulator:setInputBool(32, simulator:getIsToggled(2))       -- make button 2 a toggle, for input.getBool(32)
        simulator:setInputNumber(32, simulator:getSlider(2) * 50)   -- set input 32 to the value from slider 2 * 50
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

d=pairs
A=string
C=screen
P=math
a8=input
--yyy--
a={}
a.Objects={}
function a:draw()
for b,c in d(self.Objects)do
c:draw()
end
end

function e(f,g,h,i,j,k)
return f>=h and f<=h+j and g>=i and g<=i+k 
end

function a:callbacks(f,g)
for b,c in d(self.Objects)do
if c.ckbl then
if e(f,g,c.x,c.y,c.w,c.h)then
c:cb()
end
end
end
end
l={}
function l.new(m,n,o,p,q,r)
local s={}
s.name=m
s.x=n
s.y=o
s.w=p
s.h=q
s.ckbl=r
for b,t in d(l)do
s[b]=t 
end
a.Objects[m]=s
return s 
end

function l:draw()
end
u={}
function u.new(m,n,o,v,w,x,y,z)
local s=l.new(m,n,o,A.len(w)*5+1,7,true)s.OF=v
s.text=w
s.colorOff=x
s.colorOn=y
s.cb=z
for b,t in d(u)do
s[b]=t 
end
return s 
end

function u:draw()
if self.OF then
B=self.colorOn
else B=self.colorOff
end
C.setColor(B[1],B[2],B[3])
C.drawText(self.x+1,self.y+1,self.text)
C.drawRect(self.x,self.y,A.len(self.text)*5+1,7)
end
D={}
function D.new(m,E,n,o,p,q,r,F,G,H,I)
local s=l.new(m,n,o,p,q,r)s.lbl=E
s.val=F
s.minv=G
s.maxv=H
s.cb=I
for b,t in d(D)do
s[b]=t 
end
return s 
end
J={}
function J.new(m,E,n,o,p,r,F,G,H,K,I)
local self=D.new(m,E,n,o,p,5,r,F,G,H,I)self.col=K
for b,t in d(J)do
self[b]=t 
end
return self 
end

function J:draw()
local s=self
local L,M=(s.val-s.minv)/(s.maxv-s.minv),(0-s.minv)/(s.maxv-s.minv)
local N,O=P.min(1,P.max(0,L)),P.min(1,P.max(0,M))
C.setColor(s.col[1],s.col[2],s.col[3])
C.drawRectF(s.x+5+(s.w-5)*O,s.y,(s.w-5)*(N-O),s.h)
C.setColor(255,255,255)
if L>1 or L<0 then
C.setColor(255,0,0)
end
C.drawRect(s.x+5,s.y,s.w-5,s.h)
C.drawLine(s.x+5+(s.w-5)*O,s.y,s.x+5+(s.w-5)*O,s.y+s.h)
C.drawText(s.x,s.y,s.lbl)
end
Q={}
function Q.new(m,E,n,o,q,r,F,G,H,K,I)
local self=D.new(m,E,n,o,4,q,r,F,G,H,I)self.col=K
for b,t in d(Q)do
self[b]=t 
end
return self 
end

function Q:draw()
local s=self
local L,M=(s.val-s.minv)/(s.maxv-s.minv),(0-s.minv)/(s.maxv-s.minv)
local N,O=P.min(1,P.max(0,L)),P.min(1,P.max(0,M))
C.setColor(s.col[1],s.col[2],s.col[3])
C.drawRectF(s.x,s.y+6+(s.h-6)*(1-O),s.w,(s.h-6)*(O-N))
C.setColor(255,255,255)
if L>1 or L<0 then
C.setColor(255,0,0)
end
C.drawRect(s.x,s.y+6,s.w,s.h-6)
C.drawLine(s.x,s.y+6+(s.h-6)*(1-O),s.x+s.w,s.y+6+(s.h-6)*(1-O))
C.drawText(s.x,s.y,s.lbl)
end
R={}
function R.new(m,n,o,p,q,S,T,K)
local s=l.new(m,n,o,p,q,false)s.valD=S
s.dur=T
s.col=K
s.tpp=T/p
s.vt={}
for U=1,p,1 do
s.vt[U]=0 
end
s.lvt=0
for b,t in d(R)do
s[b]=t 
end
return s 
end

function R:draw()
local s=self
local M,V,W=(0-s.valD.minv)/(s.valD.maxv-s.valD.minv),0,0
local O=P.min(1,P.max(0,M))
C.setColor(255,255,255)
C.drawRect(s.x,s.y,s.w,s.h)
C.drawText(s.x+1,s.y+1,s.valD.lbl)
for U=1,s.w,4 do
C.drawLine(s.x+U,s.y+s.h*(1-O),s.x+U+1,s.y+s.h*(1-O))
end
C.setColor(s.col[1],s.col[2],s.col[3])
W=P.min(1,P.max(0,(s.vt[1]-s.valD.minv)/(s.valD.maxv-s.valD.minv)))
for U=2,s.w,1 do
V=W
W=P.min(1,P.max(0,(s.vt[U]-s.valD.minv)/(s.valD.maxv-s.valD.minv)))
C.drawLine(s.x+s.w-U+1,s.y+s.h*(1-V),s.x+s.w-U,s.y+s.h*(1-W))
end
if(X-s.lvt)%6000>s.tpp then
for U=s.w,2,-1 do
s.vt[U]=s.vt[U-1]end
s.vt[1]=s.valD.val
s.lvt=X
end
end

function Y(Z)Z.OF=not
Z.OF 
end

function _(c)
for U=1,a0.w,1 do
a0.vt[U]=0 
end
a0.valD=c
end
a1=J.new("rps"
,"E"
,1,1,25,true,4,5,20,{255,50,0},_)
a2=J.new("thrtl"
,"T"
,1,9,25,true,0,0,1,{0,255,20},_)
a3=J.new("yaw"
,"Y"
,1,17,25,true,0,-0.1,0.4,{0,122,255},_)
a4=J.new("roll"
,"R"
,1,25,25,true,0,-1,1,{0,122,255},_)
a5=Q.new("pitch"
,"P"
,7,33,25,true,0,-1,1,{0,122,255},_)
a6=Q.new("Col"
,"C"
,14,33,25,true,0,-1,1,{0,122,255},_)
a0=R.new("pitchG"
,27,1,37,63,a5,180,{0,0,255})
X=0
function onTick()
X=X+1%6000
Touched=a8.getBool(1)
TouchedSec=a8.getBool(2)
newTouch=Touched
and not oldTouched
newTouchSec=TouchedSec
and not oldTouchedSec
oldTouched=Touched
oldTouchedSec=TouchedSec
screenResolutionX=a8.getNumber(1)
screenResolutionY=a8.getNumber(2)
input1X=a8.getNumber(3)
input1Y=a8.getNumber(4)
input2X=a8.getNumber(5)
input2Y=a8.getNumber(6)a1.val=a8.getNumber(7)a2.val=a8.getNumber(8)a3.val=a8.getNumber(9)a4.val=a8.getNumber(10)a5.val=a8.getNumber(11)a6.val=a8.getNumber(12)
if newTouch then
a:callbacks(input1X,input1Y)
end
end

function onDraw()
a:draw()
end