local P=game.Players.LocalPlayer
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local W=Color3.fromRGB(255,255,255)
local G=Color3.fromRGB(40,160,60)
local R=Color3.fromRGB(200,50,50)
local B=Color3.fromRGB(40,120,200)
local D=Color3.fromRGB(14,14,22)
local CA=Color3.fromRGB(24,24,36)
local GR=Color3.fromRGB(120,120,140)
local GO=Color3.fromRGB(240,190,50)
local PU=Color3.fromRGB(120,60,200)
local CY=Color3.fromRGB(0,200,220)
local OR=Color3.fromRGB(220,120,30)
local function cr(p,r) local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 10) c.Parent=p end
local function on(b,c) b.BackgroundColor3=c or G b.TextColor3=W b.Text="ON" end
local function off(b) b.BackgroundColor3=Color3.fromRGB(50,50,70) b.TextColor3=GR b.Text="OFF" end

-- GUI
local sg=Instance.new("ScreenGui") sg.ResetOnSpawn=false sg.DisplayOrder=9999 sg.Parent=gethui and gethui() or P.PlayerGui

-- CHAT ATAS LAYAR
local CD=Instance.new("Frame") CD.Size=UDim2.new(0,440,0,76) CD.Position=UDim2.new(0.5,-220,0,10) CD.BackgroundColor3=Color3.fromRGB(8,8,18) CD.ZIndex=99998 CD.Visible=false CD.Parent=sg cr(CD,12)
local CDS=Instance.new("UIStroke") CDS.Color=CY CDS.Thickness=2.5 CDS.Parent=CD
local CDB=Instance.new("Frame") CDB.Size=UDim2.new(0,72,0,22) CDB.Position=UDim2.new(0,10,0,7) CDB.BackgroundColor3=CY CDB.ZIndex=99999 CDB.Parent=CD cr(CDB,5)
local CDBL=Instance.new("TextLabel") CDBL.Size=UDim2.new(1,0,1,0) CDBL.BackgroundTransparency=1 CDBL.Text="⚡ ADMIN" CDBL.TextColor3=D CDBL.Font=Enum.Font.GothamBold CDBL.TextSize=11 CDBL.ZIndex=99999 CDBL.Parent=CDB
local CDN=Instance.new("TextLabel") CDN.Size=UDim2.new(1,-100,0,22) CDN.Position=UDim2.new(0,88,0,7) CDN.BackgroundTransparency=1 CDN.Text=P.Name CDN.TextColor3=CY CDN.Font=Enum.Font.GothamBold CDN.TextSize=14 CDN.TextXAlignment=Enum.TextXAlignment.Left CDN.ZIndex=99999 CDN.Parent=CD
local CDM=Instance.new("TextLabel") CDM.Size=UDim2.new(1,-16,0,40) CDM.Position=UDim2.new(0,10,0,32) CDM.BackgroundTransparency=1 CDM.Text="" CDM.TextColor3=W CDM.Font=Enum.Font.GothamBold CDM.TextSize=22 CDM.TextWrapped=true CDM.TextXAlignment=Enum.TextXAlignment.Left CDM.ZIndex=99999 CDM.Parent=CD
local CDBAR=Instance.new("Frame") CDBAR.Size=UDim2.new(1,0,0,3) CDBAR.Position=UDim2.new(0,0,1,-3) CDBAR.BackgroundColor3=CY CDBAR.ZIndex=99999 CDBAR.Parent=CD cr(CDBAR,2)

-- MAIN FRAME
local F=Instance.new("Frame") F.Size=UDim2.new(0,390,0,310) F.Position=UDim2.new(0.5,-195,0.5,-155) F.BackgroundColor3=D F.ZIndex=100 F.ClipsDescendants=true F.Parent=sg cr(F,14)
local TB=Instance.new("Frame") TB.Size=UDim2.new(1,0,0,40) TB.BackgroundColor3=Color3.fromRGB(16,16,36) TB.ZIndex=101 TB.Parent=F cr(TB,14)
local TFX=Instance.new("Frame") TFX.Size=UDim2.new(1,0,0,10) TFX.Position=UDim2.new(0,0,1,-10) TFX.BackgroundColor3=Color3.fromRGB(16,16,36) TFX.ZIndex=101 TFX.Parent=TB
local TL=Instance.new("TextLabel") TL.Size=UDim2.new(1,-50,1,0) TL.Position=UDim2.new(0,12,0,0) TL.BackgroundTransparency=1 TL.Text="⚡ Universal Admin  •  ☰ geser" TL.TextColor3=CY TL.Font=Enum.Font.GothamBold TL.TextSize=14 TL.TextXAlignment=Enum.TextXAlignment.Left TL.ZIndex=102 TL.Parent=TB

-- CLOSE BTN
local XB=Instance.new("TextButton") XB.Size=UDim2.new(0,34,0,34) XB.BackgroundColor3=R XB.Text="✕" XB.TextColor3=W XB.Font=Enum.Font.GothamBold XB.TextSize=16 XB.ZIndex=99999 XB.Parent=sg cr(XB,8)
local function upX() local fp=F.AbsolutePosition local fs=F.AbsoluteSize XB.Position=UDim2.new(0,fp.X+fs.X-38,0,fp.Y+4) end
F:GetPropertyChangedSignal("AbsolutePosition"):Connect(upX) F:GetPropertyChangedSignal("AbsoluteSize"):Connect(upX) upX()

-- DRAG
local dr,ds,sp2=false,nil,nil
TB.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true ds=i.Position sp2=F.Position end end)
TB.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end)
UIS.InputChanged:Connect(function(i) if dr and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMove) then local d=i.Position-ds F.Position=UDim2.new(sp2.X.Scale,sp2.X.Offset+d.X,sp2.Y.Scale,sp2.Y.Offset+d.Y) upX() end end)

-- SCROLL
local HS=Instance.new("ScrollingFrame") HS.Size=UDim2.new(1,-10,1,-48) HS.Position=UDim2.new(0,5,0,44) HS.BackgroundTransparency=1 HS.ScrollBarThickness=4 HS.ScrollBarImageColor3=CY HS.ScrollingDirection=Enum.ScrollingDirection.X HS.ZIndex=101 HS.Parent=F
local HL=Instance.new("UIListLayout") HL.FillDirection=Enum.FillDirection.Horizontal HL.Padding=UDim.new(0,8) HL.VerticalAlignment=Enum.VerticalAlignment.Center HL.Parent=HS
local UP=Instance.new("UIPadding") UP.PaddingLeft=UDim.new(0,4) UP.PaddingRight=UDim.new(0,4) UP.Parent=HS
HL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() HS.CanvasSize=UDim2.new(0,HL.AbsoluteContentSize.X+10,0,0) end)

-- HELPERS
local function ms(o,w) local f=Instance.new("Frame") f.Size=UDim2.new(0,w or 168,1,-10) f.BackgroundColor3=CA f.LayoutOrder=o f.ZIndex=102 f.Parent=HS cr(f,10) return f end
local function st(p,t,c) local l=Instance.new("TextLabel") l.Size=UDim2.new(1,-10,0,24) l.Position=UDim2.new(0,6,0,4) l.BackgroundTransparency=1 l.Text=t l.TextColor3=c or W l.Font=Enum.Font.GothamBold l.TextSize=13 l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=103 l.Parent=p end
local function sl(p,t,y,c) local l=Instance.new("TextLabel") l.Size=UDim2.new(1,-10,0,18) l.Position=UDim2.new(0,6,0,y) l.BackgroundTransparency=1 l.Text=t l.TextColor3=c or GR l.Font=Enum.Font.GothamBold l.TextSize=11 l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=103 l.Parent=p return l end
local function sb(p,t,x,y,w,h,c) local b=Instance.new("TextButton") b.Size=UDim2.new(0,w or 70,0,h or 28) b.Position=UDim2.new(0,x,0,y) b.BackgroundColor3=c or B b.Text=t b.TextColor3=W b.Font=Enum.Font.GothamBold b.TextSize=12 b.ZIndex=103 b.Parent=p cr(b,7) return b end
local function sg2(p,x,y,w,h) local b=Instance.new("TextButton") b.Size=UDim2.new(0,w or 148,0,h or 30) b.Position=UDim2.new(0,x,0,y) b.BackgroundColor3=Color3.fromRGB(50,50,70) b.Text="OFF" b.TextColor3=GR b.Font=Enum.Font.GothamBold b.TextSize=13 b.ZIndex=103 b.Parent=p cr(b,7) return b end
local function sv(p,v,x,y,c) local l=Instance.new("TextLabel") l.Size=UDim2.new(0,50,0,22) l.Position=UDim2.new(0,x,0,y) l.BackgroundTransparency=1 l.Text=tostring(v) l.TextColor3=c or GO l.Font=Enum.Font.GothamBold l.TextSize=17 l.TextXAlignment=Enum.TextXAlignment.Center l.ZIndex=103 l.Parent=p return l end

-- S1: TERBANG
local s1=ms(1) st(s1,"✈️ Terbang",CY)
local fst=sl(s1,"❌ OFF",30,R) local fsp=sl(s1,"Speed: 60",48,GO)
local NB=sb(s1,"⬆️",6,68,44,36,Color3.fromRGB(30,120,50))
local FTB=sb(s1,"FLY",56,68,58,36,G)
local DNB=sb(s1,"⬇️",120,68,44,36,Color3.fromRGB(160,40,40))
local FDB=sb(s1,"-10",6,110,50,24,Color3.fromRGB(140,50,20))
local FIB=sb(s1,"+10",114,110,50,24,Color3.fromRGB(30,90,160))

-- S2: SPEED & JUMP
local s2=ms(2) st(s2,"🏃 Speed & Jump",W)
sl(s2,"Speed",34,GR) local spv=16 local spl=sv(s2,spv,60,34)
local sdb=sb(s2,"-5",6,38,50,22,Color3.fromRGB(140,50,20)) local sib=sb(s2,"+5",114,38,50,22,Color3.fromRGB(30,90,160)) local ssb=sb(s2,"✅ Set Speed",6,66,156,26,B)
sl(s2,"Jump",102,GR) local jpv=50 local jpl=sv(s2,jpv,60,102)
local jdb=sb(s2,"-10",6,106,50,22,Color3.fromRGB(140,50,20)) local jib=sb(s2,"+10",114,106,50,22,Color3.fromRGB(30,90,160)) local jsb=sb(s2,"✅ Set Jump",6,134,156,26,PU)

-- S3: INVIS & GOD
local s3=ms(3) st(s3,"👻 Invis & 🛡️ God",W)
local ivsl=sl(s3,"👻 Invisible: ❌ OFF",30,R) local ivb=sg2(s3,8,50,152)
local gdsl=sl(s3,"🛡️ God Mode: ❌ OFF",90,R) local gdb=sg2(s3,8,110,152)

-- S4: ESP
local s4=ms(4) st(s4,"👁️ ESP",B)
local epsl=sl(s4,"Player ESP: ❌ OFF",30,R) local epb=sg2(s4,8,50,152,28)
local eisl=sl(s4,"Item ESP: ❌ OFF",90,R) local eib=sg2(s4,8,110,152,28)

-- S5: TELEPORT
local s5=ms(5) st(s5,"🌀 Teleport",GO)
sl(s5,"Tap player untuk TP",30,GR)
local tpb=sb(s5,"🌀 TP ke Spawn",6,50,156,28,GO)
local tcb=sb(s5,"📍 TP ke Camera",6,84,156,28,OR)
sl(s5,"TP ke Player:",118,GR)
local tpplb=sb(s5,"Pilih Player ▼",6,134,156,28,Color3.fromRGB(60,60,90))

-- S6: CHAT ADMIN
local s6=ms(6) st(s6,"💬 Chat Admin",CY)
local cbx=Instance.new("TextBox") cbx.Size=UDim2.new(1,-12,0,34) cbx.Position=UDim2.new(0,6,0,30) cbx.BackgroundColor3=Color3.fromRGB(16,16,26) cbx.PlaceholderText="Tulis pesan..." cbx.PlaceholderColor3=GR cbx.TextColor3=W cbx.Font=Enum.Font.Gotham cbx.TextSize=11 cbx.ZIndex=103 cbx.ClearTextOnFocus=false cbx.TextWrapped=true cbx.Parent=s6 cr(cbx,7)
sl(s6,"⚡ Pesan Cepat:",70,GR)
local pc1=sb(s6,"⚠️ Jangan cheat!",6,86,156,22,Color3.fromRGB(180,80,20))
local pc2=sb(s6,"👋 Hai semua!",6,114,156,22,Color3.fromRGB(30,80,160))
local pc3=sb(s6,"🚫 Kalian di kick!",6,142,156,22,R)
local csb=sb(s6,"📢 Kirim Chat",6,170,156,30,G)
local csl=sl(s6,"",206,G)

-- S7: EFEK & RESET
local s7=ms(7) st(s7,"🎨 Efek & Reset",W)
local ncsl=sl(s7,"Noclip: ❌ OFF",30,R) local ncb=sg2(s7,8,50,152,28)
local ijsl=sl(s7,"Inf Jump: ❌ OFF",86,R) local ijb=sg2(s7,8,106,152,28)
local rstb=sb(s7,"↺ Reset Karakter",6,142,156,28,Color3.fromRGB(55,60,80))

-- OPEN BTN
local OB=Instance.new("TextButton") OB.Size=UDim2.new(0,56,0,56) OB.Position=UDim2.new(0,14,0.43,0) OB.BackgroundColor3=D OB.Text="⚡" OB.TextScaled=true OB.ZIndex=9999 OB.Visible=false OB.Parent=sg cr(OB,28)
local obs=Instance.new("UIStroke") obs.Color=CY obs.Thickness=2 obs.Parent=OB
local od,ods,osp=false,nil,nil
OB.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then od=true ods=i.Position osp=OB.Position end end)
OB.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then od=false end end)
UIS.InputChanged:Connect(function(i) if od and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMove) then local d=i.Position-ods OB.Position=UDim2.new(osp.X.Scale,osp.X.Offset+d.X,osp.Y.Scale,osp.Y.Offset+d.Y) end end)

-- TERBANG LOGIKA
local fly=false local fspd=60 local gU,gD=false,false local bv,bg
local function startF()
	fly=true local c=P.Character if not c then return end
	local h=c:FindFirstChildOfClass("Humanoid") local r=c:FindFirstChild("HumanoidRootPart") if not h or not r then return end
	h.PlatformStand=true
	bv=Instance.new("BodyVelocity") bv.MaxForce=Vector3.new(1e5,1e5,1e5) bv.Velocity=Vector3.zero bv.Parent=r
	bg=Instance.new("BodyGyro") bg.MaxTorque=Vector3.new(1e5,1e5,1e5) bg.D=50 bg.Parent=r
	FTB.BackgroundColor3=R FTB.Text="🛑" fst.Text="✅ ON" fst.TextColor3=G
end
local function stopF()
	fly=false local c=P.Character if not c then return end
	local h=c:FindFirstChildOfClass("Humanoid") if h then h.PlatformStand=false end
	if bv then bv:Destroy() bv=nil end if bg then bg:Destroy() bg=nil end
	FTB.BackgroundColor3=G FTB.Text="FLY" fst.Text="❌ OFF" fst.TextColor3=R
end
RS.RenderStepped:Connect(function()
	if not fly then return end
	local c=P.Character if not c then return end
	local r=c:FindFirstChild("HumanoidRootPart") local h=c:FindFirstChildOfClass("Humanoid")
	if not r or not bv then return end
	local dir=Vector3.zero
	if h and h.MoveDirection.Magnitude>0 then dir=Vector3.new(h.MoveDirection.X,0,h.MoveDirection.Z) end
	if gU then dir=dir+Vector3.new(0,1,0) end if gD then dir=dir-Vector3.new(0,1,0) end
	if dir.Magnitude>0 then dir=dir.Unit end
	bv.Velocity=dir*fspd bg.CFrame=workspace.CurrentCamera.CFrame
end)
FTB.MouseButton1Click:Connect(function() if fly then stopF() else startF() end end)
FDB.MouseButton1Click:Connect(function() fspd=math.max(10,fspd-10) fsp.Text="Speed: "..fspd end)
FIB.MouseButton1Click:Connect(function() fspd=math.min(500,fspd+10) fsp.Text="Speed: "..fspd end)
NB.MouseButton1Down:Connect(function() gU=true end) NB.MouseButton1Up:Connect(function() gU=false end)
NB.TouchStarted:Connect(function() gU=true end) NB.TouchEnded:Connect(function() gU=false end)
DNB.MouseButton1Down:Connect(function() gD=true end) DNB.MouseButton1Up:Connect(function() gD=false end)
DNB.TouchStarted:Connect(function() gD=true end) DNB.TouchEnded:Connect(function() gD=false end)

-- SPEED & JUMP LOGIKA
local function aSpd(v) local c=P.Character if not c then return end local h=c:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=v end end
local function aJmp(v) local c=P.Character if not c then return end local h=c:FindFirstChildOfClass("Humanoid") if h then h.JumpPower=v end end
sdb.MouseButton1Click:Connect(function() spv=math.max(1,spv-5) spl.Text=tostring(spv) end)
sib.MouseButton1Click:Connect(function() spv=math.min(999,spv+5) spl.Text=tostring(spv) end)
ssb.MouseButton1Click:Connect(function() aSpd(spv) end)
jdb.MouseButton1Click:Connect(function() jpv=math.max(1,jpv-10) jpl.Text=tostring(jpv) end)
jib.MouseButton1Click:Connect(function() jpv=math.min(999,jpv+10) jpl.Text=tostring(jpv) end)
jsb.MouseButton1Click:Connect(function() aJmp(jpv) end)

-- INVISIBLE LOGIKA
local isIv=false
local function aIv(s) local c=P.Character if not c then return end for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then p.Transparency=s and 1 or 0 end if p:IsA("Decal") then p.Transparency=s and 1 or 0 end end end
ivb.MouseButton1Click:Connect(function() isIv=not isIv aIv(isIv) if isIv then on(ivb,PU) else off(ivb) end ivsl.Text="👻 Invisible: "..(isIv and "✅ ON" or "❌ OFF") ivsl.TextColor3=isIv and G or R end)

-- GOD MODE LOGIKA
local isGd=false local gdCn
gdb.MouseButton1Click:Connect(function()
	isGd=not isGd
	if isGd then on(gdb,GO) gdCn=RS.Heartbeat:Connect(function() local c=P.Character if not c then return end local h=c:FindFirstChildOfClass("Humanoid") if h then h.Health=h.MaxHealth end end)
	else off(gdb) if gdCn then gdCn:Disconnect() gdCn=nil end end
	gdsl.Text="🛡️ God Mode: "..(isGd and "✅ ON" or "❌ OFF") gdsl.TextColor3=isGd and G or R
end)

-- ESP LOGIKA
local ePly,eItm=false,false local eoList={}
local function clrESP() for _,v in ipairs(eoList) do pcall(function() v:Destroy() end) end eoList={} end
local function addESP(part,col,lbl)
	local bx=Instance.new("SelectionBox") bx.Adornee=part bx.Color3=col bx.LineThickness=0.04 bx.SurfaceTransparency=0.75 bx.SurfaceColor3=col bx.Parent=workspace table.insert(eoList,bx)
	local bg2=Instance.new("BillboardGui") bg2.Size=UDim2.new(0,90,0,20) bg2.StudsOffset=Vector3.new(0,3,0) bg2.AlwaysOnTop=true bg2.Adornee=part bg2.Parent=workspace table.insert(eoList,bg2)
	local tl=Instance.new("TextLabel") tl.Size=UDim2.new(1,0,1,0) tl.BackgroundTransparency=1 tl.Text=lbl tl.TextColor3=col tl.Font=Enum.Font.GothamBold tl.TextSize=12 tl.Parent=bg2
end
local function refESP()
	clrESP()
	if ePly then for _,p in ipairs(game.Players:GetPlayers()) do if p~=P and p.Character then local r=p.Character:FindFirstChild("HumanoidRootPart") if r then addESP(r,R,"👤 "..p.Name) end end end end
	if eItm then for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") or o:IsA("MeshPart") then local n=o.Name:lower() if n:find("item") or n:find("pickup") or n:find("drop") or n:find("chest") or n:find("coin") or n:find("gem") then addESP(o,GO,"📦 "..o.Name) end end end end
end
epb.MouseButton1Click:Connect(function() ePly=not ePly if ePly then on(epb,B) else off(epb) end epsl.Text="Player ESP: "..(ePly and "✅ ON" or "❌ OFF") epsl.TextColor3=ePly and G or R refESP() end)
eib.MouseButton1Click:Connect(function() eItm=not eItm if eItm then on(eib,GO) else off(eib) end eisl.Text="Item ESP: "..(eItm and "✅ ON" or "❌ OFF") eisl.TextColor3=eItm and G or R refESP() end)
task.spawn(function() while true do if ePly or eItm then refESP() end task.wait(4) end end)

-- TELEPORT LOGIKA
tpb.MouseButton1Click:Connect(function() local c=P.Character if not c then return end local r=c:FindFirstChild("HumanoidRootPart") if not r then return end local sp=workspace:FindFirstChildWhichIsA("SpawnLocation") if sp then r.CFrame=sp.CFrame+Vector3.new(0,5,0) end end)
tcb.MouseButton1Click:Connect(function() local c=P.Character if not c then return end local r=c:FindFirstChild("HumanoidRootPart") if not r then return end r.CFrame=workspace.CurrentCamera.CFrame*CFrame.new(0,0,-10) end)
local tpIdx=1
tpplb.MouseButton1Click:Connect(function()
	local ot={} for _,p in ipairs(game.Players:GetPlayers()) do if p~=P then table.insert(ot,p) end end
	if #ot==0 then tpplb.Text="Tidak ada!" return end
	tpIdx=(tpIdx % #ot)+1 local tgt=ot[tpIdx] tpplb.Text="→ "..tgt.Name
	local c=P.Character if not c then return end local r=c:FindFirstChild("HumanoidRootPart") if not r then return end
	if tgt.Character then local tr=tgt.Character:FindFirstChild("HumanoidRootPart") if tr then r.CFrame=tr.CFrame+Vector3.new(0,3,0) end end
end)

-- CHAT LOGIKA
local ctmr
local function kirim(msg)
	if msg=="" then return end
	local ok=false
	pcall(function() game:GetService("Chat"):Chat(P.Character,msg,Enum.ChatColor.White) ok=true end)
	if not ok then pcall(function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg,"All") ok=true end) end
	CDM.Text=msg CDN.Text=P.Name CD.Visible=true
	csl.Text=ok and "✅ Terkirim!" or "⚠️ Gagal" csl.TextColor3=ok and G or GO
	if ctmr then task.cancel(ctmr) end
	ctmr=task.delay(6,function() CD.Visible=false csl.Text="" end)
end
csb.MouseButton1Click:Connect(function() kirim(cbx.Text) cbx.Text="" end)
pc1.MouseButton1Click:Connect(function() kirim("⚠️ Jangan cheat!") end)
pc2.MouseButton1Click:Connect(function() kirim("👋 Hai semua!") end)
pc3.MouseButton1Click:Connect(function() kirim("🚫 Kalian di kick!") end)

-- NOCLIP LOGIKA
local nc=false local ncCn
ncb.MouseButton1Click:Connect(function()
	nc=not nc
	if nc then on(ncb,OR) ncCn=RS.Stepped:Connect(function() local c=P.Character if not c then return end for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end)
	else off(ncb) if ncCn then ncCn:Disconnect() ncCn=nil end local c=P.Character if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=true end end end end
	ncsl.Text="Noclip: "..(nc and "✅ ON" or "❌ OFF") ncsl.TextColor3=nc and G or R
end)

-- INF JUMP LOGIKA
local ij=false local ijCn
ijb.MouseButton1Click:Connect(function()
	ij=not ij
	if ij then on(ijb,CY) ijCn=UIS.JumpRequest:Connect(function() local c=P.Character if not c then return end local h=c:FindFirstChildOfClass("Humanoid") if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end)
	else off(ijb) if ijCn then ijCn:Disconnect() ijCn=nil end end
	ijsl.Text="Inf Jump: "..(ij and "✅ ON" or "❌ OFF") ijsl.TextColor3=ij and G or R
end)

-- RESET
rstb.MouseButton1Click:Connect(function() P:LoadCharacter() end)

-- RESPAWN
P.CharacterAdded:Connect(function()
	task.wait(0.5) aSpd(spv) aJmp(jpv)
	if isIv then aIv(true) end
	if isGd then if gdCn then gdCn:Disconnect() end gdCn=RS.Heartbeat:Connect(function() local c=P.Character if not c then return end local h=c:FindFirstChildOfClass("Humanoid") if h then h.Health=h.MaxHealth end end) end
	fly=false bv=nil bg=nil FTB.BackgroundColor3=G FTB.Text="FLY" fst.Text="❌ OFF" fst.TextColor3=R
end)

-- OPEN / CLOSE
XB.MouseButton1Click:Connect(function() F.Visible=false XB.Visible=false OB.Visible=true end)
OB.MouseButton1Click:Connect(function() F.Visible=true XB.Visible=true OB.Visible=false upX() end)
