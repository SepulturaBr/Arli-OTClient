
CatcherWindow = nil

function init()
	CatcherWindow = g_ui.displayUI('CatcherWindow.otui')
	CatcherWindow:hide()

	connect(g_game, 'onTextMessage', serverComunication)
	connect(g_game, { onGameEnd = hide } )
end

function terminate()
	disconnect(g_game, { onGameEnd = hide })
	disconnect(g_game, 'onTextMessage', serverComunication)
	
	CatcherWindow:destroy()
end

function hide()
	CatcherWindow:destroy()
end

function CatcherWindowHide()
	CatcherWindow:hide()
end

function serverComunication(mode, text)
	if not g_game.isOnline() then
		return
	end

	if mode == MessageModes.Failure then
		if text:find("%#CatcherWindow") then
			local search = text:explode("@")

			CatcherWindow:show()
			CatcherWindow:recursiveGetChildById("ImagePortrait"):setItemId(search[2])
			CatcherWindow:recursiveGetChildById("PokeName"):setText("Você capturou um ".. search[3])
			CatcherWindow:recursiveGetChildById("Experience"):setText("Você ganhou ".. search[4] .." de XP")

			local pb = text:match("pb=(.-),")
			local gb = text:match("gb=(.-),")
			local sb = text:match("sb=(.-),")
			local ub = text:match("ub=(.-),")
			local sf = text:match("sf=(.-),")

			local allballs = tonumber(pb + gb + sb + ub + sf)

			CatcherWindow:recursiveGetChildById("CountPB"):setText(pb.." PokeBalls")
			CatcherWindow:recursiveGetChildById("CountGB"):setText(gb.." GreatBalls")
			CatcherWindow:recursiveGetChildById("CountSB"):setText(sb.." SuperBalls")
			CatcherWindow:recursiveGetChildById("CountUB"):setText(ub.." UltraBalls")
			CatcherWindow:recursiveGetChildById("CountSF"):setText(sf.." SaffariBalls")

			CatcherWindow:recursiveGetChildById("TotalBalls"):setText("Total de balls usadas: "..allballs)
		end
	end
end

function hide()
CatcherWindow:hide()
end

