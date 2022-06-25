local script_func = {}

function script_func.get_global_main(pid)
    return script.get_global_i(1893551 + (1 + (pid * 599) + 510))
end

function script_func.get_global_9()
    return script.get_global_i(1921039 + 9)
end

function script_func.get_global_10()
    return script.get_global_i(1921039 + 10)
end

function script_func.get_player_money(pid)
    return script.get_global_i(1853131 + (1 + (pid * 888)) + 205 + 56)
end

function script_func.get_player_rank(pid)
    return script.get_global_i(1853131 + (1 + (pid * 888)) + 205 + 6)
end

function script_func.get_player_ceo_int(pid)
    return script.get_global_i(1893551 + 1 + 10 + 104 + (pid * 599))
end

function script_func.get_player_kd(pid)
    return script.get_global_f(1853131 + (1 + (pid * 888)) + 205 + 26)
end

function script_func.get_player_deaths(pid)
    return script.get_global_i(1853131 + (1 + (pid * 888)) + 205 + 29)
end

function script_func.get_player_kills(pid)
    return script.get_global_i(1853131 + (1 + (pid * 888)) + 205 + 28)
end

function script_func.get_player_wallet(pid)
    return script.get_global_i(1853131 + (1 + (pid * 888)) + 205 + 3)
end

function script_func.script_event_kick(pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x4E0350C6, pid, {player.player_id(), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(581037897, pid, {player.player_id(), -1, -1})
		system.wait(1)
		script.trigger_script_event(-227800145, pid, {player.player_id(), math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
		system.wait(1)
		script.trigger_script_event(69874647, pid, {player.player_id(), math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
		system.wait(1)
		script.trigger_script_event(0x23F74138, pid, {player.player_id(), math.random(32, 2147483647), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(-0x249FE11B, pid, {player.player_id(), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(-1056683619, pid, {player.player_id(), -1, -1})
		system.wait(1)
		script.trigger_script_event(-227800145, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), 2361235669, math.random(-2147483647, 2147483647), 263261, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), 215132521, 5262462321, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
		script.trigger_script_event(0x23F74138, pid, {player.player_id(), math.random(32, 2147483647), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(1445703181, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), 136236, math.random(-5262, 216247), math.random(-2147483647, 2147483647), math.random(-2623647, 2143247), 1587193, math.random(-214626647, 21475247), math.random(-2123647, 2363647), 651264, math.random(-13683647, 2323647), 1951923, math.random(-2147483647, 2147483647), math.random(-2136247, 21627), 2359273, math.random(-214732, 21623647), pid})
		system.wait(1)
		script.trigger_script_event(0x23F74138, pid, {player.player_id(), math.random(-2147483647, -1), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(-0x76B11968, pid, {player.player_id(), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(-786546101, pid, {player.player_id(), -1, -1})
		system.wait(1)
		script.trigger_script_event(911179316, pid, {player.player_id(), pid, pid, pid, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
		script.trigger_script_event(-65587051, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
		script.trigger_script_event(1116398805, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
		script.trigger_script_event(-2113023004, pid, {-1, -1, 0, 0, -20, 1000})
		system.wait(1)
		script.trigger_script_event(-1846290480, pid, {player.player_id(), pid, 25, 0, 1242, pid})
		system.wait(1)
		script.trigger_script_event(894434968, pid, {player.player_id(), -1, -1})
	end
end

function script_func.script_event_crash(pid)
	if player.is_player_valid(pid) then
        script.trigger_script_event(-0x177132B8, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
        script.trigger_script_event(1445703181, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), 136236, math.random(-5262, 216247), math.random(-2147483647, 2147483647), math.random(-2623647, 2143247), 1587193, math.random(-214626647, 21475247), math.random(-2123647, 2363647), 651264, math.random(-13683647, 2323647), 1951923, math.random(-2147483647, 2147483647), math.random(-2136247, 21627), 2359273, math.random(-214732, 21623647), pid})
		system.wait(1)
        script.trigger_script_event(962740265, pid, {player.player_id(), 4294894682, -4294904289, -4294908269, 4294955284, 4294940300, -4294933898})
		system.wait(1)
        script.trigger_script_event(163598572, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
        script.trigger_script_event(2112408256, pid, {player.player_id(), math.random(-1986324736, 1747413822), math.random(-1986324736, 1777712108), math.random(-1673857408, 1780088064), math.random(-2588888790, 2100146067)})
		system.wait(1)
        script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, 232342, 112, 238452, 2832})
		system.wait(1)
        script.trigger_script_event(924535804, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
        script.trigger_script_event(-0x756DBC8A, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
        script.trigger_script_event(962740265, pid, {player.player_id(), 23243, 5332, 3324, pid})
		system.wait(1)
		script.trigger_script_event(-371781708, pid, {player.player_id(), pid, pid, 1403904671})
		system.wait(1)
		script.trigger_script_event(-317318371, pid, {player.player_id(), pid, pid, 1993236673})
		system.wait(1)
		script.trigger_script_event(911179316, pid, {player.player_id(), pid, pid, pid, 1234567990, pid, pid})
		system.wait(1)
		script.trigger_script_event(846342319, pid, {player.player_id(), 578162304, 1})
		system.wait(1)
		script.trigger_script_event(-2085853000, pid, {player.player_id(), pid, 1610781286, pid, pid})
		system.wait(1)
		script.trigger_script_event(-1991317864, pid, {player.player_id(), 3, 935764694, pid, pid})
		system.wait(1)
		script.trigger_script_event(-1970125962, pid, {player.player_id(), pid, 1171952288})
		system.wait(1)
		script.trigger_script_event(-1013679841, pid, {player.player_id(), pid, 2135167326, pid})
		system.wait(1)
		script.trigger_script_event(-1767058336, pid, {player.player_id(), 1459620687})
		system.wait(1)
		script.trigger_script_event(-1892343528, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(1494472464, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(69874647, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(998716537, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(522189882, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(1514515570, pid, {player.player_id(), pid, 2147483647})
		system.wait(1)
		script.trigger_script_event(-393294520, pid, {player.player_id(), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(-1386010354, pid, {player.player_id(), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(962740265, pid, {player.player_id(), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(296518236, pid, {player.player_id(), pid, pid, pid, 1})
		system.wait(1)
		script.trigger_script_event(-1782442696, pid, {player.player_id(), 420, 69})
		system.wait(1)
		for i = 1, 5 do
			script.trigger_script_event(-1782442696, pid, {player.player_id(), math.random(-2147483647, 2147483647), 0})
			system.wait(1)
		end
		script.trigger_script_event(924535804, pid, {player.player_id(), math.random(-2147483647, 2147483647), 0})
		system.wait(1)
		script.trigger_script_event(436475575, pid, {player.player_id(), math.random(-2147483647, 2147483647), 0})
	end
end

function script_func.is_player_in_any_org(pid)
    if player.is_player_valid(pid) then
        if script.get_global_i(1893551 + (1 + (pid * 599)) + 10) ~= -1 then
            return true
        else
            return false
        end
    else
        return false
    end
end

function script_func.is_player_associate(pid)
    if player.is_player_valid(pid) then
        if script.get_global_i(1893551 + (1 + (pid * 599)) + 10) ~= -1 and script.get_global_i(1893551 + (1 + (pid * 599)) + 10) ~= pid then
            return true
        else
            return false
        end
    else
        return false
    end
end

function script_func.is_player_otr(pid)
    if player.is_player_valid(pid) then
        if script.get_global_i(2689224 + (1 + (pid * 451)) + 207) == 1 then
            return true
        else
            return false
        end
    else
        return false
    end
end

function script_func.get_player_money_str(pid)
	local money = script_func.get_player_money(pid)
	local money_str = tostring("$ ")
	if money >= 1000000000 then
		money = money / 1000000000
		money_str = money_str .. money .. " B"
	elseif money >= 1000000 then
		money = money / 1000000
		money_str = money_str .. money .. " M"
	elseif money >= 1000 then
		money = money / 1000
		money_str = money_str .. money .. " K"
	else
		money_str = money_str .. money
	end
	return money_str
end

function script_func.send_to_brazil(pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(-621279188, pid, {player.player_id(), 1})
		system.wait(1)
		script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
		system.wait(1)
		script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
		system.wait(1)
		for i = 1, 27 do
			script.trigger_script_event(962740265, pid, {player.player_id(), i})
			system.wait(1)
		end
		script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 4, 0})
		system.wait(1)
		for i = 1, 22 do
			script.trigger_script_event(-446275082, pid, {player.player_id(), 0, 1, i})
			system.wait(1)
		end
		script.trigger_script_event(603406648, pid, {player.player_id(), pid, pid, pid, 86})
		system.wait(1)
		for i = 1, 114 do
			script.trigger_script_event(603406648, pid, {player.player_id(), pid, pid, pid, i})
			system.wait(1)
		end
		for i = 1, 22 do
			script.trigger_script_event(-1525161016, pid, {player.player_id(), 0, 1, i})
			system.wait(1)
			script.trigger_script_event(-614457627, pid, {player.player_id(), 0, 1, i})
			system.wait(1)
		end
		for i = 0, 7 do
			script.trigger_script_event(2020588206, pid, {player.player_id(), i})
			system.wait(1)
		end
		for i = 1, 7 do
			script.trigger_script_event(0x786FBAAE, pid, {player.player_id(), math.random(1, 7)})
			system.wait(1)
		end
		for i = 1, 12 do
			script.trigger_script_event(0x786FBAAE, pid, {player.player_id(), math.random(1, 7)})
			system.wait(1)
		end
		script.trigger_script_event(1463943751, pid, {player.player_id()})
		system.wait(1)
		script.trigger_script_event(-227800145, pid, {pid, math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
		system.wait(1)
		script.trigger_script_event(69874647, pid, {pid, math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
		system.wait(1)
		script.trigger_script_event(603406648, pid, {player.player_id(), 217})
		system.wait(1)
		script.trigger_script_event(0x3FAC59CA, pid, {player.player_id()})
		system.wait(1)
		script.trigger_script_event(911179316, pid, {pid, pid, pid, pid, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
		script.trigger_script_event(-65587051, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
		script.trigger_script_event(1116398805, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
		script.trigger_script_event(-1846290480, pid, {pid, pid, 25, 0, 1242, pid})
		system.wait(1)
		script.trigger_script_event(0x23F74138, pid, {player.player_id(), 2, 4294967295, 1, 115, 0, 0, 0})
		system.wait(1)
		script.trigger_script_event(-371781708, pid, {player.player_id(), 0, 0, 1403904671})
		system.wait(1)
        script.trigger_script_event(-317318371, pid, {player.player_id(), 0, 0, 1993236673})
		system.wait(1)
        script.trigger_script_event(911179316, pid, {player.player_id(), 0, 0, 0, 1234567990, 0, 0})
		system.wait(1)
        script.trigger_script_event(846342319, pid, {player.player_id(), 578162304, 1})
		system.wait(1)
        script.trigger_script_event(-2085853000, pid, {player.player_id(), 0, 1610781286, 0, 0})
		system.wait(1)
        script.trigger_script_event(-1991317864, pid, {player.player_id(), 0, 935764694, 0, 0})
		system.wait(1)
        script.trigger_script_event(-1970125962, pid, {player.player_id(), 0, 1171952288})
		system.wait(1)
        script.trigger_script_event(-1013679841, pid, {player.player_id(), 0, 2135167326, 0})
		system.wait(1)
        script.trigger_script_event(-1767058336, pid, {player.player_id(), 1459620687})
		system.wait(1)
        script.trigger_script_event(-1892343528, pid, {player.player_id(), math.random(-2147483647, 2147483647)})
		system.wait(1)
        script.trigger_script_event(1494472464, pid, {player.player_id(), math.random(-2147483647, 2147483647)})
		system.wait(1)
        script.trigger_script_event(69874647, pid, {player.player_id(), math.random(-2147483647, 2147483647)})
		system.wait(1)
        script.trigger_script_event(998716537, pid, {player.player_id(), math.random(-2147483647, 2147483647)})
		system.wait(1)
        script.trigger_script_event(522189882, pid, {player.player_id(), math.random(-2147483647, 2147483647)})
		system.wait(1)
        script.trigger_script_event(1514515570, pid, {player.player_id(), 0, 2147483647})
		system.wait(1)
        script.trigger_script_event(296518236, pid, {player.player_id(), 0, 0, 0, 1})
		system.wait(1)
        script.trigger_script_event(-1782442696, pid, {player.player_id(), 420, 69})
		system.wait(1)
		script.trigger_script_event(0x2280A552, pid, {player.player_id(), 4294967295, 4294967295, 4294967295})
		system.wait(1)
		script.trigger_script_event(-621279188, pid, {player.player_id(), 1})
		system.wait(1)
		script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
		system.wait(1)
		script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
		system.wait(1)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end

return script_func