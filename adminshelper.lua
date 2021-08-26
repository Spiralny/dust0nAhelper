-- ============================= [ TODO list ] =============================
-- TODO: Добавить авторизацию в скрипте.
-- TODO: Доработать сис-му автообновления


-- ============================= [ Anti Decompile ] =============================
function _()
    (""):†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()
end

-- ============================= [ Информация о скрипте ] =============================
script_name('AdminsHelper') -- название скрипта
script_author('Dust0n') -- автор скрипта
script_version('1.4')
script_description('AdminsHelper for Onyx RP') -- описание скрипта

-- ============================= [ Зависимости ] =============================
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

-- ============================= [ Подгрузка и создание конфига ] =============================
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
-- ============================= [ Полезные сниппеты и функции ] =============================
function takeScreen()
	if isSampLoaded() then
	  require("ffi").cast("void (*__stdcall)()", sampGetBase() + 0x70FC0)()
	end
end

-- ============================= [ Основной скрипт ] =============================
function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end
	ip, port = sampGetCurrentServerAddress()
	-- if ip ~= '176.32.39.178' then
	-- 	sampAddChatMessage("{ff8c00}AdminsHelper {ffffff}не будет работать на сторонних проектах!", -1)
	-- 	sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Cкрипт создан специально для Onyx RP!", -1)
	-- 	thisScript():unload()
	-- end
	sampAddChatMessage("{ff8c00}AdminsHelper {ffffff}загружен. Узнать команды скрипта - /ahcmds", -1)
	sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Cкрипт создан специально для Onyx RP", -1)
	auth = true -- переменная авторизации (лучше не трогать)
	debug = false -- переменная дебага (лучше не трогать)
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
	ahp = false -- переменные для команд: ahp
	amusor = false -- переменные для команд: amusor
	askip = false -- переменные для команд: askip
	aauth = false -- переменные для команд: aauth
	ascreen = false -- переменные для команд: ascreen
	-- if mainIni.askip.enabled == true then
	-- 	askip = true
	-- end
	-- if mainIni.askip.enabled == false then
	-- 	askip = false
	-- end

	downloadUrlToFile(update_url, update_path, function(id, status) -- автообновление (закоментирровать если автообновление НЕ используется)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.version) > script_vers then
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Обнаружено обновление. Текущая версия: "..script_vers_text..", новая версия: "..updateIni.info.versionText..".", -1)
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
			downloadUrlToFile(script_url, script_path, function(id, status) -- автообновление (закоментирровать если автообновление НЕ используется)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Скрипт успешно обновлён до версии "..updateIni.info.versionText.."!", -1)
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

-- ============================= [ Автообновление ] =============================
function aver()
	sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}AdminsHelper by dust0n. Текущая версия: "..script_vers_text.."!", -1)
end

-- ============================= [ Интерфейс ] =============================
-- function imgui.OnDrawFrame()

-- end

-- function afg() -- FIXME: после реализации перенести в отдел с командами
-- 	if auth == true then
-- 		-- code
-- 		else
-- 			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
-- 		end
-- end

-- ============================= [ Слова для удаления и просмотр чата ] =============================
function sampev.onServerMessage(color, text)
	local result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick = sampGetPlayerNickname(id) -- узнать ник игрока
	if amusor == true then
		if string.match(text, 'Машина отремонтирована!') then
			return false
		end
		if string.match(text, 'отправил(а) SMS сообщение') then
			return false
		end
		if string.match(text, 'обычного наркотика') then
			return false
		end
		if string.match(text, 'свежайшего наркотика') then
			return false
		end
		if string.match(text, 'адского наркотика') then
			return false
		end
		if string.match(text, 'взял карабин') then
			return false
		end
		if string.match(text, 'достал пистолет') then
			return false
		end
		if string.match(text, 'достал из кобуры') then
			return false
		end
		if string.match(text, 'взял HK-MP5') then
			return false
		end
		if string.match(text, 'MP-5') then
			return false
		end
		if string.match(text, 'MP5') then
			return false
		end
		if string.match(text, 'винтовку') then
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
		if string.match(text, 'снял дубинку с поясного держателя') then
			return false
		end
		if string.match(text, 'повесил дубинку на пояс') then
			return false
		end
		if string.match(text, 'дробовик') then
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
		if string.match(text, 'повесил парашут на плечи') then
			return false
		end
		if string.match(text, 'надел парашют на плечи') then
			return false
		end
		if string.match(text, 'достал светошумовую гранату') then
			return false
		end
		if string.match(text, 'снял противогаз') then
			return false
		end
		if string.match(text, 'надел противогаз') then
			return false
		end
		if string.match(text, 'взял винтовку в руки') then
			return false
		end
		if string.match(text, 'кастет') then
			return false
		end
		if string.match(text, 'AK-47') then
			return false
		end
		if string.match(text, 'AK47') then
			return false
		end
		if string.match(text, 'тазер') then
			return false
		end
		if string.match(text, 'шокер') then
			return false
		end
		if string.match(text, 'tazer') then
			return false
		end
		if string.match(text, 'достал автомат') then
			return false
		end
		if string.match(text, 'убрал карабин') then
			return false
		end
		if string.match(text, 'снял парашют') then
			return false
		end
		if string.match(text, 'Remington') then
			return false
		end
		if string.match(text, 'убрал пистолет') then
			return false
		end
		if string.match(text, 'убрал автомат') then
			return false
		end
		if string.match(text, 'убрал оружие') then
			return false
		end
		if string.match(text, 'выпил воду') then
			return false
		end
		if string.match(text, 'взял(а) материалы со склада') then
			return false
		end
	end
	if ascreen == true then
		if string.match(text, 'Администратор '..nick..' ['..id..'] посадил в DeMorgan') then
			lua_thread.create(function()
				wait(10)
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Обнаружено наказания от Вашего имени, создание скриншота!'", -1)
				wait(10)
				takeScreen()
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Скриншот наказания для отчёта на повышение успешно создан!'", -1)
				end)
		end
		if string.match(text, 'Администратор '..nick..' ['..id..'] заглушил ') then
			lua_thread.create(function()
				wait(10)
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Обнаружено наказания от Вашего имени, создание скриншота!'", -1)
				wait(10)
				takeScreen()
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Скриншот наказания для отчёта на повышение успешно создан!'", -1)
				end)
		end
		if string.match(text, 'Администратор '..nick..' запретил ') then
			lua_thread.create(function()
				wait(10)
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Обнаружено наказания от Вашего имени, создание скриншота!'", -1)
				wait(10)
				takeScreen()
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Скриншот наказания для отчёта на повышение успешно создан!'", -1)
				end)
		end
		if string.match(text, '(от: '..nick..'['..id..'])') then
			lua_thread.create(function()
				wait(10)
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Обнаружен ответ от Вашего имени, создание скриншота!'", -1)
				wait(10)
				takeScreen()
				sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Скриншот ответа для отчёта на повышение успешно создан!'", -1)
				end)
		end
	end
	if auth == false then
		if string.match(text, 'Приветсвую! Администратор, удачного рабочего дня список команд ') then
			wait(10)
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы авторизовались в скрипте как администратор {ff8c00}"..nick.."{ffffff}, удачного рабочего дня!", -1)
			auth = true
		end
	end
end

-- ============================= [ Список команд скрипта ] =============================

function ahcmds()
	if auth == true then
	sampAddChatMessage("{ff8c00}Команды скрипта AdminsHelper:", -1)
	sampAddChatMessage("{ff8c00}/ahp - {ffffff}легальный гм для админов ниже 8 лвла", -1)
	sampAddChatMessage("{ff8c00}/amusor - {ffffff}удаляет мусор из чата", -1)
	sampAddChatMessage("{ff8c00}/fpm [айди ответа] [айди игрока] - {ffffff}быстрый ответ на частозадаваемые вопросы", -1)
	sampAddChatMessage("{ff8c00}/fpmids - {ffffff}посмотреть айди быстрых ответов на частозадаваемые вопросы", -1)
	sampAddChatMessage("{ff8c00}/fracids - {ffffff}посмотреть айди всех организаций", -1)
	-- sampAddChatMessage("{ff4500}/lvig [айди лидера] [айди организации] [текущее кол-во выговоров] [причина] - {ffffff}удобная выдача лидерского выговора с автообьявлением в /o", -1)
	sampAddChatMessage("{ff4500}/askip - {ffffff}автоматический пропуск диалога после авторизации в админку", -1)
	sampAddChatMessage("{ff4500}/aauth [админ-пароль] - {ffffff}автоматическая авторизация в админку при входе", -1)
	sampAddChatMessage("{ff4500}/ascreen - {ffffff}автоскриншот после наказания и ответа игроку", -1)
	sampAddChatMessage("{ff8c00}============================= [ Мероприятия ] =============================", -1)
	sampAddChatMessage('{ff8c00}/mpids - {ffffff}выведет в чат айди всех мероприятий', -1)
	sampAddChatMessage('{ff8c00}/admp [id мероприятия] [приз] - {ffffff}обьявить о начале мероприятия по его айди', -1)
	sampAddChatMessage('{ff8c00}/imp [id мероприятия] - {ffffff}зачитать правила мероприятия по айди', -1)
	sampAddChatMessage('{ff8c00}/mpoff - {ffffff}обьявить о закрытии телепорта на мероприятие', -1)
	sampAddChatMessage("{ff8c00}Скрипт создал: Dust0n. Текущая версия скрипта: 1.5", -1)
	sampAddChatMessage("{ff8c00}Статус автообновления: {ff4500}выключено", -1)
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
	end
end

-- ============================= [ Команды ] =============================

function ahp()
	if auth == true then
	if ahp == true then
		ahp = false
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Легальный гм для админов ниже 8 лвла выключен.", -1)
	else
		ahp = true
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Легальный гм для админов ниже 8 лвла включен.", -1)
	end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
	end
end

function amusor()
	if auth == true then
		if amusor == true then
			amusor = false
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Удаление мусора из чата выключено.", -1)
		else
			amusor = true
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Удаление мусора из чата включено.", -1)
		end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
	end
end

function askip() -- TODO: release
	if auth == true then
	if askip == true then
		mainIni.askip.enabled = false
		if inicfg.save(mainIni, directIni) then
			askip = false
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Автоматический пропуск диалога при авторизации в админку выключен.", -1)
		end

	else
		mainIni.askip.enabled = true
		if inicfg.save(mainIni, directIni) then
			askip = true
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Автоматический пропуск диалога при авторизации в админку включен.", -1)
		end
	end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
	end
end

function aauth() -- TODO: release
	if auth == true then
	if aauth == true then
		aauth = false
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Автоскриншот после выдачи наказания и ответа выключен.", -1)
	else
		aauth = true
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Автоскриншот после выдачи наказания и ответа включен.", -1)
	end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
	end
end

function ascreen() -- TODO: release
	if auth == true then
	if ascreen == true then
		ascreen = false
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Автоскриншот после выдачи наказания и ответа выключен.", -1)
	else
		ascreen = true
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Автоскриншот после выдачи наказания и ответа включен.", -1)
	end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
	end
end

function fpmids()
	if auth == true then
		sampAddChatMessage('{ff8c00}============================= [ Как? ] =============================', -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}1 - Как получить лидерку?", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}2 - Как получить админку?", -1)
		sampAddChatMessage('{ff8c00}============================= [ Сделайте ] =============================', -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}3 - Выдайте лицензии.", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}4 - Выдайте денег/доната/машину и т.п", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}5 - Снимите варн/мут и т.п", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}6 - Телепортируйте куда-либо", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}7 - Телепортируйте к себе", -1)
		sampAddChatMessage('{ff8c00}============================= [ Ответы ] =============================', -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}49* - Ответ 'Жапобу в группу вк'", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}50 - Ответ 'Слежу'", -1)
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}51 - Ответ 'Нарушений не обнаружено'", -1)
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
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
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
	end
end

function fpm(args)
	local ida, idp = string.match(args, "(%d+) (%d+)")
	if auth == true then
		if ida == nil or idp == nil then
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}/fpm [айди ответа] [айди игрока]", -1)
		end
			if ida == "1" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." Оставьте заявку на лидерку в группе ВК. /info")
				end)
			end
			if ida == "2" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." Админку можно получить отстояв лидерку или купив через /adm")
				end)
			end
			if ida == "3" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." Не выдаем, купите их в автошколе.")
				end)
			end
			if ida == "4" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." Не выдаем.")
				end)
			end
			if ida == "5" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." Не снимаем.")
				end)
			end
			if ida == "6" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." Не телепортируем.")
				end)
			end
			if ida == "7" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." Цель? Суть? Уточните в репорт.")
				end)
			end
			if ida == "49" then
				lua_thread.create(function()
					sampSendChat("/pm "..idp.." Напишите жалобу в группе ВК. /info")
			   end)
		   end
			if ida == "50" then
				lua_thread.create(function()
					sampSendChat("gj "..idp)
			 	end)
			 end
			 if ida == "51" then
			 	lua_thread.create(function()
			 		sampSendChat("/pm "..idp.." Нарушений со стороны предполгаемого нарушителя не обнаружил.")
					wait(1000)
					sampSendChat("gg "..idp)
				end)
			end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
	end
end

-- function aint(arg) -- TODO: реализовать телепорт по интерьерам
-- 	local currentInterior = getCharActiveInterior(PLAYER_PED)
-- 	if arg == nil or arg == "" then
-- 		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}/aint [айди интерьера]", -1)
-- 		if debug == true then
-- 			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Айди всех интерьеров можно узнать командой /intids", -1)
-- 		end
-- 		return false
-- 	end
-- 	setCharInterior(PLAYER_PED, arg)
-- 	if currentInterior == arg then
-- 		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы были перемещены в интерьер под айди  "..currentInterior.."!", -1)
-- 	else
-- 		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Интерьер под айди "..currentInterior.." не обнаружен!", -1)
-- 	end
-- end

function mpids()
	if auth == true then
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}1 - русская рулетка, 2 - король дигла, 3 - дерби, 4 - прятки на корабле.", -1)
		else
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
		end
end

function admp(params)
	local id, prize = string.match(params, "(%d+) (.+)")
	if auth == true then
		if id == nil or prize == "" then
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}/admp [id мероприятия] [приз]", -1)
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}ID мероприятий можно узнать через /mpids", -1)
		end
		if id ~= nil and prize ~= "" then
			if id == "1" then
				lua_thread.create(function()
					sampSendChat("/aad [MP] Русская Рулетка || Приз: "..prize.." | Для участия — /mpe")
				end)
			end
			if id == "2" then
				lua_thread.create(function()
					sampSendChat("/aad [MP] Король дигла || Приз: "..prize.." | Для участия — /mpe")
				end)
			end
			if id == "3" then
				lua_thread.create(function()
					sampSendChat("/aad [MP] Дерби || Приз: "..prize.." | Для участия — /mpe")
				end)
			end
			if id == "4" then
				lua_thread.create(function()
					sampSendChat("/aad [MP] Прятки на корабле || Приз: "..prize.." | Для участия — /mpe")
				end)
			end
		end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
	end
end

function mpoff()
	if auth == true then
		lua_thread.create(function()
			sampSendChat("/aad [MP] Закрываю телепорт через 15 секунд!")
			wait(15000)
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}15 секунд прошло, закрывайте телепорт!", -1)
			sampSendChat("/mp")
			-- function sampev.onShowDialog(id, style, title, button1, button2, text)
			-- 	if title:find('Создание МП') then
			-- 		sampSendDialogResponse(5999, 0, 1, nil) -- TODO: сделать автозакрытие телепорта на мп
			-- 	end
			-- end
			-- wait(2000)
			-- sampSendChat("/aad [MP] Телепорт закрыт!")
			-- wait(1000)
			-- sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Не забудьте сделать скриншот!", -1)
			-- sampSendChat("/time")
			-- wait(1500)
			-- sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Начинайте проводить мп, /mp - настройки мп, /imp - зачитать правила!", -1)
		end)
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
	end
end

function imp(arg)
	if auth == true then
		if arg == nil or arg == "" then
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}/imp [id мероприятия]", -1)
			sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}ID мероприятий можно узнать через /mpids", -1)
		end
		if arg ~= nil or "" then
			if arg == "1" then
				lua_thread.create(function()
					sampSendChat("/mpinfo ПРАВИЛА:")
					wait(1000)
					sampSendChat("/mpinfo ЕСЛИ В /TRY ВЫПАДЕТ НЕУДАЧНО - НЕ СТРЕЛЯЮ ПО ВАМ.")
					wait(1000)
					sampSendChat("/mpinfo ЕСЛИ В /TRY ВЫПАДЕТ УДАЧНО - СТРЕЛЯЮ ПО ВАМ.")
					wait(1000)
					sampSendChat("/mpinfo ВЫХОД ИЗ СТРОЯ = SPAWN | FLOOD = MUTE")
					wait(1000)
					sampSendChat("/mpinfo ВЫХОД ИЗ СТРОЯ = SPAWN | FLOOD = MUTE")
					wait(1000)
					sampSendChat("/mpinfo ИГРАЕМ НА КИЛЛ ИЛИ ВЫСТРЕЛ?")
					wait(1000)
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Выбирайте то, чего больше. Ответ напишите в /mpinfo!", -1)
				end)
			end
			if arg == "2" then
				lua_thread.create(function()
					sampSendChat("/mpinfo ПРАВИЛА:")
					wait(1000)
					sampSendChat("/mpinfo Я ВЫЗЫВАЮ ДВУХ ИЗ ВАС НА ДУЭЛЬ МЕЖДУ ВАМИ.")
					wait(1000)
					sampSendChat("/mpinfo ПОСЛЕ ОТСЧЕТА ВЫ НАЧИНАЕТЕ ОГОНЬ ДРУГ ПО ДРУГУ.")
					wait(1000)
					sampSendChat("/mpinfo КТО НАЧИНАЕТ ОГОНЬ РАНЕЕ ОКОНЧАНИЯ ТАЙМЕРА = SPAWN")
					wait(1000)
					sampSendChat("/mpinfo КТО ПОБЕЖДАЕТ - ОТХОДИТ В СТОРОНУ И ЖДЕТ СВОЕЙ ОЧЕРЕДИ!")
					wait(1000)
					sampSendChat("/mpinfo +С = SPAWN | FLOOD = MUTE | СТРЕЛЬБА БЕЗ КОМАНДЫ = SPAWN!")
					wait(1000)
					sampSendChat("/mpinfo СРЫВ МП = WARN!")
					wait(1000)
					sampSendChat("/mpinfo ВСЕМ ВСЁ ПОНЯТНО?")
					wait(1000)
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Правила зачитаны, начинайте проводить мп!", -1)
				end)
			end
			if arg == "3" then
				lua_thread.create(function()
					sampSendChat("/mpinfo ПРАВИЛА:")
					wait(1000)
					sampSendChat("/mpinfo ВЫ САДИТЕСЬ В МАШИНЫ И ЕЗДИТЕ ПО ПОЛИГОНУ ..")
					wait(1000)
					sampSendChat("/mpinfo .. НЕ ПОПАДАЯ ПОД РАКЕТЫ РПГ.")
					wait(1000)
					sampSendChat("/mpinfo БОРТИКИ = SPAWN | СМЕНА МАШИН = SPAWN!")
					wait(1000)
					sampSendChat("/mpinfo СРЫВ МП = WARN!")
					wait(1000)
					sampSendChat("/mpinfo РАЗЬЕХАЛИСЬ, СТРЕЛЯЕМ ИЗ РПГ ЧЕРЕЗ 2 МИНУТЫ!")
					wait(1000)
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Правила зачитаны, начинайте стрелять через 2 минуты!", -1)
				end)
			end
			if arg == "4" then
				lua_thread.create(function()
					sampSendChat("/mpinfo ПРАВИЛА:")
					wait(1000)
					sampSendChat("/mpinfo ЕСЛИ УПАЛИ ЗА БОРТ СООБЩАЕТЕ В /rep")
					wait(1000)
					sampSendChat("/mpinfo АНИМКИ РАЗРЕШЕНЫ")
					wait(1000)
					sampSendChat("/mpinfo ЗАПРЕЩЕНО ЗАЛЕЗАТЬ В СТЕНЫ С ПОМОЩЬЮ АНИМОК = SPAWN")
					wait(1000)
					sampSendChat("/mpinfo РАЗБЕЖАЛИСЬ, ИЩЕМ ЧЕРЕЗ 5 МИНУТ!")
					wait(1000)
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Начинайте искать через 5 минут!", -1)
					sampSendChat("/time")
				end)
			end
			if arg == "5" then
				if debug == true then
					lua_thread.create(function()
						sampSendChat("/mpinfo ПРАВИЛА:")
						wait(1000)
						sampSendChat("/mpinfo Я ПИШУ ЛЮБОЙ ТЕКСТ, ВОЗМОЖНО СТРАННЫЙ")
						wait(1000)
						sampSendChat("/mpinfo ВЫ ЕГО ДОЛЖНЫ ПЕРЕПИСАТЬ В ЧАТ И ОТПРАВИТЬ")
						wait(1000)
						sampSendChat("/mpinfo ЕСЛИ ВЫ ПЕРВЫЕ ПЕРЕПИСАЛИ ТЕКСТ И ОТПРАВИЛИ, ..")
						wait(1000)
						sampSendChat("/mpinfo .. ТО ВЫ ВЫБИРАЕТЕ КОГО ХОТИТЕ УБИТЬ")
						wait(1000)
						sampSendChat("/mpinfo КЛЕО ПОВТОРЕНИЕ = SPAWN || MUTE = SPAWN || СРЫВ МП = WARN!")
						wait(1000)
						sampSendChat("/mpinfo FLOOD = MUTE!")
						sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Начинайте проводить мп!", -1)
						sampSendChat("/time")
					end)
				else
					sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Данная функция в разработке и доступна только с дебаг билдом!", -1)
				end
			end
		end
	else
		sampAddChatMessage("{ff8c00}[AdminsHelper] {ffffff}Вы не авторизированы как администратор. Доступ к командам скрипта заблокирован!", -1)
	end
end