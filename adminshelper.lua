-- ============================= [ TODO list ] =============================
-- TODO: �������� ����������� � �������.
-- TODO: ���������� ���-�� ��������������


-- ============================= [ Anti Decompile ] =============================
function _()
    (""):�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()
end

-- ============================= [ ���������� � ������� ] =============================
script_name('AdminsHelper') -- �������� �������
script_author('Dust0n') -- ����� �������
script_version('1.4')
script_description('AdminsHelper for Onyx RP') -- �������� �������

-- ============================= [ ����������� ] =============================
require 'lib.moonloader'
local dlstatus = require('moonloader').download_status
local sampev = require 'lib.samp.events'
local inicfg = require 'inicfg'
local ffi = require "ffi"
-- local imgui = require 'imgui'
-- local encoding = require 'encoding'
-- encoding.default = 'CP1251'
-- u8 = encoding.UTF8
-- local vkeys = require 'vkeys'
-- local wm = require 'windows.message'

-- ============================= [ ��������� � �������� ������� ] =============================
local directIni = "moonloader//config//adminshelper.ini"

local mainIni = inicfg.load({
    askip =
    {
        enabled = 'false',
    },
	aauth =
    {
        enabled = 'false',
		code = 'noSet',
    }
}, directIni)
if not doesFileExist(directIni) then inicfg.save(mainIni, 'adminshelper.ini') end
-- ============================= [ �������� �������� � ������� ] =============================
function takeScreen()
	if isSampLoaded() then
	  require("ffi").cast("void (*__stdcall)()", sampGetBase() + 0x70FC0)()
	end
end

-- ============================= [ �������� ������ ] =============================
function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end
	ip, port = sampGetCurrentServerAddress()
	-- if ip ~= '176.32.39.178' then
	-- 	sampAddChatMessage("{ff8c00}AdminsHelper {ffffff}�� ����� �������� �� ��������� ��������!", -1)
	-- 	sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}C����� ������ ���������� ��� Onyx RP!", -1)
	-- 	thisScript():unload()
	-- end
	sampAddChatMessage("{ff8c00}AdminsHelper {ffffff}��������. ������ ������� ������� - /ahcmds", -1)
	sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}C����� ������ ���������� ��� Onyx RP", -1)
	auth = true -- ���������� ����������� (����� �� �������)
	debug = false -- ���������� ������ (����� �� �������)
	update_state = false

	local script_vers = 2
	local script_vers_text = "1.5"

	local update_url = "https://raw.githubusercontent.com/Spiralny/dust0nAhelper/main/update.ini"
	local update_path = getWorkingDirectory() .. "/update.ini"

	local script_url = ""
	local script_path = thisScript().path
	sampRegisterChatCommand("ahcmds", ahcmds)
	sampRegisterChatCommand("ahp", ahp)
	sampRegisterChatCommand("amusor", amusor)
	sampRegisterChatCommand("askip", askip)
	sampRegisterChatCommand("aauth", aauth)
	sampRegisterChatCommand("ascreen", ascreen)
	sampRegisterChatCommand("fpmids", fpmids)
	sampRegisterChatCommand("fpm", fpm)
	sampRegisterChatCommand("mpids", mpids)
	sampRegisterChatCommand("admp", admp)
	sampRegisterChatCommand("mpoff", mpoff)
	sampRegisterChatCommand("imp", imp)
	sampRegisterChatCommand("afg", afg)
	sampRegisterChatCommand("fracids", fracids)
	sampRegisterChatCommand("aver", aver)
	-- sampRegisterChatCommand('aint', aint)
	-- sampRegisterChatCommand("lvig", lvig)
	ahp = false -- ���������� ��� ������: ahp
	amusor = false -- ���������� ��� ������: amusor
	askip = false -- ���������� ��� ������: askip
	aauth = false -- ���������� ��� ������: aauth
	ascreen = false -- ���������� ��� ������: ascreen
	-- if mainIni.askip.enabled == true then
	-- 	askip = true
	-- end
	-- if mainIni.askip.enabled == false then
	-- 	askip = false
	-- end

	downloadUrlToFile(update_url, update_path, function(id, status) -- �������������� (���������������� ���� �������������� �� ������������)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.version) > script_vers then
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}���������� ����������. ������� ������: "..script_vers_text..", ����� ������: "..updateIni.info.versionText..".", -1)
				update_state = true
			end
			os.remove(update_path)
		end
	end)
    while true do
    	wait(0)
			if ahp == true then
				health = getCharHealth(PLAYER_PED)
				if health < 90 and health > 5 and ahp then
					sampSendChat("/hp")
					wait(1000)
				end
			if isCharInAnyCar(PLAYER_PED) then
				local car = storeCarCharIsInNoSave(PLAYER_PED)
				if getCarHealth(car) < 990 and ahp then
					sampSendChat("/hp")
					wait(1000)
				end
			end
		end

		if update_state == true then
			downloadUrlToFile(script_url, script_path, function(id, status) -- �������������� (���������������� ���� �������������� �� ������������)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}������ ������� ������� �� ������ "..updateIni.info.versionText.."!", -1)
					if debug == true then
						sampAddChatMessage("{afafaf}Reloading script", -1)
					end
					thisScript():reload()
				end
			end)
		end
		-- if askip == true then
		--  wait(1000)
		-- 	sampSendDialogResponse(0, 1, nil, nil)
		-- end
	end
end

-- ============================= [ �������������� ] =============================
function aver()
	sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}AdminsHelper by dust0n. ������� ������: "..script_vers_text.."!", -1)
end

-- ============================= [ ��������� ] =============================
-- function imgui.OnDrawFrame()

-- end

-- function afg() -- FIXME: ����� ���������� ��������� � ����� � ���������
-- 	if auth == true then
-- 		-- code
-- 		else
-- 			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
-- 		end
-- end

-- ============================= [ ����� ��� �������� � �������� ���� ] =============================
function sampev.onServerMessage(color, text)
	local result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick = sampGetPlayerNickname(id) -- ������ ��� ������
	if amusor == true then
		if string.match(text, '������ ���������������!') then
			return false
		end
		if string.match(text, '��������(�) SMS ���������') then
			return false
		end
		if string.match(text, '�������� ���������') then
			return false
		end
		if string.match(text, '���������� ���������') then
			return false
		end
		if string.match(text, '������� ���������') then
			return false
		end
		if string.match(text, '���� �������') then
			return false
		end
		if string.match(text, '������ ��������') then
			return false
		end
		if string.match(text, '������ �� ������') then
			return false
		end
		if string.match(text, '���� HK-MP5') then
			return false
		end
		if string.match(text, 'MP-5') then
			return false
		end
		if string.match(text, 'MP5') then
			return false
		end
		if string.match(text, '��������') then
			return false
		end
		if string.match(text, 'Desert Eagle') then
			return false
		end
		if string.match(text, 'Arabka') then
			return false
		end
		if string.match(text, 'Shotgun') then
			return false
		end
		if string.match(text, 'shotgun') then
			return false
		end
		if string.match(text, '���� ������� � �������� ���������') then
			return false
		end
		if string.match(text, '������� ������� �� ����') then
			return false
		end
		if string.match(text, '��������') then
			return false
		end
		if string.match(text, 'Deagle') then
			return false
		end
		if string.match(text, 'M4') then
			return false
		end
		if string.match(text, 'M4A1') then
			return false
		end
		if string.match(text, '������� ������� �� �����') then
			return false
		end
		if string.match(text, '����� ������� �� �����') then
			return false
		end
		if string.match(text, '������ ������������ �������') then
			return false
		end
		if string.match(text, '���� ����������') then
			return false
		end
		if string.match(text, '����� ����������') then
			return false
		end
		if string.match(text, '���� �������� � ����') then
			return false
		end
		if string.match(text, '������') then
			return false
		end
		if string.match(text, 'AK-47') then
			return false
		end
		if string.match(text, 'AK47') then
			return false
		end
		if string.match(text, '�����') then
			return false
		end
		if string.match(text, '�����') then
			return false
		end
		if string.match(text, 'tazer') then
			return false
		end
		if string.match(text, '������ �������') then
			return false
		end
		if string.match(text, '����� �������') then
			return false
		end
		if string.match(text, '���� �������') then
			return false
		end
		if string.match(text, 'Remington') then
			return false
		end
		if string.match(text, '����� ��������') then
			return false
		end
		if string.match(text, '����� �������') then
			return false
		end
		if string.match(text, '����� ������') then
			return false
		end
		if string.match(text, '����� ����') then
			return false
		end
		if string.match(text, '����(�) ��������� �� ������') then
			return false
		end
	end
	if ascreen == true then
		if string.match(text, '������������� '..nick..' ['..id..'] ������� � DeMorgan') then
			lua_thread.create(function()
				wait(10)
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}���������� ��������� �� ������ �����, �������� ���������!'", -1)
				wait(10)
				takeScreen()
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�������� ��������� ��� ������ �� ��������� ������� ������!'", -1)
				end)
		end
		if string.match(text, '������������� '..nick..' ['..id..'] �������� ') then
			lua_thread.create(function()
				wait(10)
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}���������� ��������� �� ������ �����, �������� ���������!'", -1)
				wait(10)
				takeScreen()
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�������� ��������� ��� ������ �� ��������� ������� ������!'", -1)
				end)
		end
		if string.match(text, '������������� '..nick..' �������� ') then
			lua_thread.create(function()
				wait(10)
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}���������� ��������� �� ������ �����, �������� ���������!'", -1)
				wait(10)
				takeScreen()
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�������� ��������� ��� ������ �� ��������� ������� ������!'", -1)
				end)
		end
		if string.match(text, '(��: '..nick..'['..id..'])') then
			lua_thread.create(function()
				wait(10)
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}��������� ����� �� ������ �����, �������� ���������!'", -1)
				wait(10)
				takeScreen()
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�������� ������ ��� ������ �� ��������� ������� ������!'", -1)
				end)
		end
	end
	if auth == false then
		if string.match(text, '����������! �������������, �������� �������� ��� ������ ������ ') then
			wait(10)
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �������������� � ������� ��� ������������� {ff8c00}"..nick.."{ffffff}, �������� �������� ���!", -1)
			auth = true
		end
	end
end

-- ============================= [ ������ ������ ������� ] =============================

function ahcmds()
	if auth == true then
	sampAddChatMessage("{ff8c00}������� ������� AdminsHelper:", -1)
	sampAddChatMessage("{ff8c00}/ahp - {ffffff}��������� �� ��� ������� ���� 8 ����", -1)
	sampAddChatMessage("{ff8c00}/amusor - {ffffff}������� ����� �� ����", -1)
	sampAddChatMessage("{ff8c00}/fpm [���� ������] [���� ������] - {ffffff}������� ����� �� ��������������� �������", -1)
	sampAddChatMessage("{ff8c00}/fpmids - {ffffff}���������� ���� ������� ������� �� ��������������� �������", -1)
	sampAddChatMessage("{ff8c00}/fracids - {ffffff}���������� ���� ���� �����������", -1)
	-- sampAddChatMessage("{ff4500}/lvig [���� ������] [���� �����������] [������� ���-�� ���������] [�������] - {ffffff}������� ������ ���������� �������� � ��������������� � /o", -1)
	sampAddChatMessage("{ff4500}/askip - {ffffff}�������������� ������� ������� ����� ����������� � �������", -1)
	sampAddChatMessage("{ff4500}/aauth [�����-������] - {ffffff}�������������� ����������� � ������� ��� �����", -1)
	sampAddChatMessage("{ff4500}/ascreen - {ffffff}������������ ����� ��������� � ������ ������", -1)
	sampAddChatMessage("{ff8c00}============================= [ ����������� ] =============================", -1)
	sampAddChatMessage('{ff8c00}/mpids - {ffffff}������� � ��� ���� ���� �����������', -1)
	sampAddChatMessage('{ff8c00}/admp [id �����������] [����] - {ffffff}�������� � ������ ����������� �� ��� ����', -1)
	sampAddChatMessage('{ff8c00}/imp [id �����������] - {ffffff}�������� ������� ����������� �� ����', -1)
	sampAddChatMessage('{ff8c00}/mpoff - {ffffff}�������� � �������� ��������� �� �����������', -1)
	sampAddChatMessage("{ff8c00}������ ������: Dust0n. ������� ������ �������: 1.5", -1)
	sampAddChatMessage("{ff8c00}������ ��������������: {ff4500}���������", -1)
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end

-- ============================= [ ������� ] =============================

function ahp()
	if auth == true then
	if ahp == true then
		ahp = false
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}��������� �� ��� ������� ���� 8 ���� ��������.", -1)
	else
		ahp = true
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}��������� �� ��� ������� ���� 8 ���� �������.", -1)
	end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end

function amusor()
	if auth == true then
		if amusor == true then
			amusor = false
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�������� ������ �� ���� ���������.", -1)
		else
			amusor = true
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�������� ������ �� ���� ��������.", -1)
		end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end

function askip() -- TODO: release
	if auth == true then
	if askip == true then
		mainIni.askip.enabled = false
		if inicfg.save(mainIni, directIni) then
			askip = false
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�������������� ������� ������� ��� ����������� � ������� ��������.", -1)
		end

	else
		mainIni.askip.enabled = true
		if inicfg.save(mainIni, directIni) then
			askip = true
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�������������� ������� ������� ��� ����������� � ������� �������.", -1)
		end
	end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end

function aauth() -- TODO: release
	if auth == true then
	if aauth == true then
		aauth = false
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}������������ ����� ������ ��������� � ������ ��������.", -1)
	else
		aauth = true
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}������������ ����� ������ ��������� � ������ �������.", -1)
	end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end

function ascreen() -- TODO: release
	if auth == true then
	if ascreen == true then
		ascreen = false
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}������������ ����� ������ ��������� � ������ ��������.", -1)
	else
		ascreen = true
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}������������ ����� ������ ��������� � ������ �������.", -1)
	end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end

function fpmids()
	if auth == true then
		sampAddChatMessage('{ff8c00}============================= [ ���? ] =============================', -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}1 - ��� �������� �������?", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}2 - ��� �������� �������?", -1)
		sampAddChatMessage('{ff8c00}============================= [ �������� ] =============================', -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}3 - ������� ��������.", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}4 - ������� �����/������/������ � �.�", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}5 - ������� ����/��� � �.�", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}6 - �������������� ����-����", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}7 - �������������� � ����", -1)
		sampAddChatMessage('{ff8c00}============================= [ ������ ] =============================', -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}49* - ����� '������ � ������ ��'", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}50 - ����� '�����'", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}51 - ����� '��������� �� ����������'", -1)
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end

function fracids()
	if auth == true then
		sampAddChatMessage('{ff8c00}============================= [ Government ] =============================', -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}1 - LSPD, 2 - FBI, 3 - SF Army, 4 - Hospital, 5 - City Hall", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}10 - SFPD, 11 - Autoschool, 16 - San News, 19 - LV Army, 25 - SWAT", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}26 - Government", -1)
		sampAddChatMessage('{ff8c00}============================= [ Gangs ] =============================', -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}12 - Ballas, 13 - Vagos, 15 - Grove St, 17 - Aztecas, 18 - Rifa,", -1)
		sampAddChatMessage('{ff8c00}============================= [ Mafias ] =============================', -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}5 - La Cosa Nostra, 6 - Yakuza, 14 - Russian Mafia, 23 - Hitmans, 24 - Street Racers", -1)
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end

function fpm(args)
	local ida, idp = string.match(args, "(%d+) (%d+)")
	if auth == true then
		if ida == nil or idp == nil then
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}/fpm [���� ������] [���� ������]", -1)
		end
			if ida == "1" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." �������� ������ �� ������� � ������ ��. /info")
				end)
			end
			if ida == "2" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." ������� ����� �������� ������� ������� ��� ����� ����� /adm")
				end)
			end
			if ida == "3" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." �� ������, ������ �� � ���������.")
				end)
			end
			if ida == "4" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." �� ������.")
				end)
			end
			if ida == "5" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." �� �������.")
				end)
			end
			if ida == "6" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." �� �������������.")
				end)
			end
			if ida == "7" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." ����? ����? �������� � ������.")
				end)
			end
			if ida == "49" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." �������� ������ � ������ ��. /info")
			   end)
		   end
			if ida == "50" then
				lua_thread.create(function()
					sampSendChat("gj "..idp)
			 	end)
			 end
			 if ida == "51" then
			 	lua_thread.create(function()
			 		sampSendChat("/pm "..idp.." ��������� �� ������� �������������� ���������� �� ���������.")
					wait(1000)
					sampSendChat("gg "..idp)
				end)
			end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end

-- function aint(arg) -- TODO: ����������� �������� �� ����������
-- 	local currentInterior = getCharActiveInterior(PLAYER_PED)
-- 	if arg == nil or arg == "" then
-- 		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}/aint [���� ���������]", -1)
-- 		if debug == true then
-- 			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}���� ���� ���������� ����� ������ �������� /intids", -1)
-- 		end
-- 		return false
-- 	end
-- 	setCharInterior(PLAYER_PED, arg)
-- 	if currentInterior == arg then
-- 		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� ���� ���������� � �������� ��� ����  "..currentInterior.."!", -1)
-- 	else
-- 		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�������� ��� ���� "..currentInterior.." �� ���������!", -1)
-- 	end
-- end

function mpids()
	if auth == true then
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}1 - ������� �������, 2 - ������ �����, 3 - �����, 4 - ������ �� �������.", -1)
		else
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
		end
end

function admp(params)
	local id, prize = string.match(params, "(%d+) (.+)")
	if auth == true then
		if id == nil or prize == "" then
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}/admp [id �����������] [����]", -1)
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}ID ����������� ����� ������ ����� /mpids", -1)
		end
		if id ~= nil and prize ~= "" then
			if id == "1" then
				lua_thread.create(function()
					sampSendChat("/aad [MP] ������� ������� || ����: "..prize.." | ��� ������� � /mpe")
				end)
			end
			if id == "2" then
				lua_thread.create(function()
					sampSendChat("/aad [MP] ������ ����� || ����: "..prize.." | ��� ������� � /mpe")
				end)
			end
			if id == "3" then
				lua_thread.create(function()
					sampSendChat("/aad [MP] ����� || ����: "..prize.." | ��� ������� � /mpe")
				end)
			end
			if id == "4" then
				lua_thread.create(function()
					sampSendChat("/aad [MP] ������ �� ������� || ����: "..prize.." | ��� ������� � /mpe")
				end)
			end
		end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end

function mpoff()
	if auth == true then
		lua_thread.create(function()
			sampSendChat("/aad [MP] �������� �������� ����� 15 ������!")
			wait(15000)
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}15 ������ ������, ���������� ��������!", -1)
			sampSendChat("/mp")
			-- function sampev.onShowDialog(id, style, title, button1, button2, text)
			-- 	if title:find('�������� ��') then
			-- 		sampSendDialogResponse(5999, 0, 1, nil) -- TODO: ������� ������������ ��������� �� ��
			-- 	end
			-- end
			-- wait(2000)
			-- sampSendChat("/aad [MP] �������� ������!")
			-- wait(1000)
			-- sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �������� ������� ��������!", -1)
			-- sampSendChat("/time")
			-- wait(1500)
			-- sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}��������� ��������� ��, /mp - ��������� ��, /imp - �������� �������!", -1)
		end)
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end

function imp(arg)
	if auth == true then
		if arg == nil or arg == "" then
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}/imp [id �����������]", -1)
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}ID ����������� ����� ������ ����� /mpids", -1)
		end
		if arg ~= nil or "" then
			if arg == "1" then
				lua_thread.create(function()
					sampSendChat("/mpinfo �������:")
					wait(1000)
					sampSendChat("/mpinfo ���� � /TRY ������� �������� - �� ������� �� ���.")
					wait(1000)
					sampSendChat("/mpinfo ���� � /TRY ������� ������ - ������� �� ���.")
					wait(1000)
					sampSendChat("/mpinfo ����� �� ����� = SPAWN | FLOOD = MUTE")
					wait(1000)
					sampSendChat("/mpinfo ����� �� ����� = SPAWN | FLOOD = MUTE")
					wait(1000)
					sampSendChat("/mpinfo ������ �� ���� ��� �������?")
					wait(1000)
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}��������� ��, ���� ������. ����� �������� � /mpinfo!", -1)
				end)
			end
			if arg == "2" then
				lua_thread.create(function()
					sampSendChat("/mpinfo �������:")
					wait(1000)
					sampSendChat("/mpinfo � ������� ���� �� ��� �� ����� ����� ����.")
					wait(1000)
					sampSendChat("/mpinfo ����� ������� �� ��������� ����� ���� �� �����.")
					wait(1000)
					sampSendChat("/mpinfo ��� �������� ����� ����� ��������� ������� = SPAWN")
					wait(1000)
					sampSendChat("/mpinfo ��� ��������� - ������� � ������� � ���� ����� �������!")
					wait(1000)
					sampSendChat("/mpinfo +� = SPAWN | FLOOD = MUTE | �������� ��� ������� = SPAWN!")
					wait(1000)
					sampSendChat("/mpinfo ���� �� = WARN!")
					wait(1000)
					sampSendChat("/mpinfo ���� �Ѩ �������?")
					wait(1000)
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}������� ��������, ��������� ��������� ��!", -1)
				end)
			end
			if arg == "3" then
				lua_thread.create(function()
					sampSendChat("/mpinfo �������:")
					wait(1000)
					sampSendChat("/mpinfo �� �������� � ������ � ������ �� �������� ..")
					wait(1000)
					sampSendChat("/mpinfo .. �� ������� ��� ������ ���.")
					wait(1000)
					sampSendChat("/mpinfo ������� = SPAWN | ����� ����� = SPAWN!")
					wait(1000)
					sampSendChat("/mpinfo ���� �� = WARN!")
					wait(1000)
					sampSendChat("/mpinfo �����������, �������� �� ��� ����� 2 ������!")
					wait(1000)
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}������� ��������, ��������� �������� ����� 2 ������!", -1)
				end)
			end
			if arg == "4" then
				lua_thread.create(function()
					sampSendChat("/mpinfo �������:")
					wait(1000)
					sampSendChat("/mpinfo ���� ����� �� ���� ��������� � /rep")
					wait(1000)
					sampSendChat("/mpinfo ������ ���������")
					wait(1000)
					sampSendChat("/mpinfo ��������� �������� � ����� � ������� ������ = SPAWN")
					wait(1000)
					sampSendChat("/mpinfo �����������, ���� ����� 5 �����!")
					wait(1000)
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}��������� ������ ����� 5 �����!", -1)
					sampSendChat("/time")
				end)
			end
			if arg == "5" then
				if debug == true then
					lua_thread.create(function()
						sampSendChat("/mpinfo �������:")
						wait(1000)
						sampSendChat("/mpinfo � ���� ����� �����, �������� ��������")
						wait(1000)
						sampSendChat("/mpinfo �� ��� ������ ���������� � ��� � ���������")
						wait(1000)
						sampSendChat("/mpinfo ���� �� ������ ���������� ����� � ���������, ..")
						wait(1000)
						sampSendChat("/mpinfo .. �� �� ��������� ���� ������ �����")
						wait(1000)
						sampSendChat("/mpinfo ���� ���������� = SPAWN || MUTE = SPAWN || ���� �� = WARN!")
						wait(1000)
						sampSendChat("/mpinfo FLOOD = MUTE!")
						sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}��������� ��������� ��!", -1)
						sampSendChat("/time")
					end)
				else
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}������ ������� � ���������� � �������� ������ � ����� ������!", -1)
				end
			end
		end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}�� �� �������������� ��� �������������. ������ � �������� ������� ������������!", -1)
	end
end