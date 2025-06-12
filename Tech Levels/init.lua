local core_mainmenu = require("core_mainmenu")
local lib_helpers = require("solylib.helpers")
local lib_characters = require ("solylib.characters")
local lib_menu = require("solylib.menu")
local cfg = require("Tech Levels.configuration")

local optionsLoaded, options = pcall(require, "Tech Levels.options")
local optionsFileName = "addons/Tech Levels/options.lua"
local firstPresent = true
local ConfigurationWindow

if optionsLoaded then
    options.ConfigurationEnableWindow = lib_helpers.NotNilOrDefault(options.ConfigurationEnableWindow, true)
    options.changed                   = lib_helpers.NotNilOrDefault(options.changed, true)
    options.EnableWindow              = lib_helpers.NotNilOrDefault(options.EnableWindow, true)
    options.HideWhenMenu              = lib_helpers.NotNilOrDefault(options.HideWhenMenu, false)
    options.HideWhenSymbolChat        = lib_helpers.NotNilOrDefault(options.HideWhenSymbolChat, false)
    options.HideWhenMenuUnavailable   = lib_helpers.NotNilOrDefault(options.HideWhenMenuUnavailable, false)
    options.NoTitleBar                = lib_helpers.NotNilOrDefault(options.NoTitleBar, "")
    options.NoMove                    = lib_helpers.NotNilOrDefault(options.NoMove, "")
    options.TransparentWindow         = lib_helpers.NotNilOrDefault(options.TransparentWindow, false)
    options.Anchor                    = lib_helpers.NotNilOrDefault(options.Anchor, 1)
    options.X                         = lib_helpers.NotNilOrDefault(options.X, 0)
    options.Y                         = lib_helpers.NotNilOrDefault(options.Y, 0)
    options.updateThrottle            = lib_helpers.NotNilOrDefault(options.updateThrottle, 0)

else
    options =
    {
        ConfigurationEnableWindow = true,
        changed = true,
        EnableWindow = true,
        HideWhenMenu = true,
        HideWhenSymbolChat = true,
        HideWhenMenuUnavailable = true,
        NoTitleBar = "NoTitleBar",
        NoMove = "NoMove",
        TransparentWindow = false,
        Anchor = 1,
        X = 0,
        Y = 0,
        updateThrottle = 0,
    }
end

local function SaveOptions(options)
    local file = io.open(optionsFileName, "w")
    if file ~= nil then
        io.output(file)

        io.write("return\n")
        io.write("{\n")
        io.write(string.format("    ConfigurationEnableWindow = %s,\n", tostring(options.ConfigurationEnableWindow)))
        io.write(string.format("    changed = %s,\n", tostring(options.changed)))
        io.write(string.format("    EnableWindow = %s,\n", tostring(options.EnableWindow)))
        io.write(string.format("    HideWhenMenu = %s,\n", tostring(options.HideWhenMenu)))
        io.write(string.format("    HideWhenSymbolChat = %s,\n", tostring(options.HideWhenSymbolChat)))
        io.write(string.format("    HideWhenMenuUnavailable = %s,\n", tostring(options.HideWhenMenuUnavailable)))
        io.write(string.format("    NoTitleBar = \"%s\",\n", tostring(options.NoTitleBar)))
        io.write(string.format("    NoMove = \"%s\",\n", tostring(options.NoMove)))
        io.write(string.format("    TransparentWindow = %s,\n", tostring(options.TransparentWindow)))
        io.write(string.format("    Anchor = %i,\n", options.Anchor))
        io.write(string.format("    X = %i,\n", options.X))
        io.write(string.format("    Y = %i,\n", options.Y))
        io.write(string.format("    updateThrottle = %i,\n", options.updateThrottle))
        io.write("}\n")
        io.close(file)
    end
end


local _PlayerArray = 0x00A94254
local _PlayerIndex = 0x00A9C4F4

local function showTechniques()
local playerIndex = pso.read_u32(_PlayerIndex)
local playerAddr = pso.read_u32(_PlayerArray + 4 * playerIndex)
local playerClass = pso.read_u8(playerAddr + 0x961)

    lib_helpers.TextC(true, 0xFFFF7634, "Foie")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Foie) == 15 
        or playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Foie) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Foie) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Foie) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Foie) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Foie))
    end

    lib_helpers.TextC(true, 0xFFEFED04, "Zonde")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zonde) == 15
        or playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zonde) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zonde) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zonde) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zonde) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zonde))
    end

    lib_helpers.TextC(true, 0xFF31C9FF, "Barta")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Barta) == 15
        or playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Barta) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Barta) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Barta) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Barta) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Barta))
    end

    lib_helpers.TextC(true, 0xFFFF7634, "Gifoie")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gifoie) == 15
        or playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gifoie) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gifoie) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gifoie) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gifoie) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gifoie))
    end

    lib_helpers.TextC(true, 0xFFEFED04, "Gizonde")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gizonde) == 15
        or playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gizonde) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gizonde) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gizonde) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gizonde) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gizonde))
    end

    lib_helpers.TextC(true, 0xFF31C9FF, "Gibarta")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gibarta) == 15
        or playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gibarta) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gibarta) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gibarta) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gibarta) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gibarta))
    end


    lib_helpers.TextC(true, 0xFFFF7634, "Rafoie")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rafoie) == 15
        or playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rafoie) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rafoie) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rafoie) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rafoie) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rafoie))
    end

    lib_helpers.TextC(true, 0xFFEFED04, "Razonde")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Razonde) == 15
        or playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Razonde) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Razonde) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Razonde) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Razonde) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Razonde))
    end

    lib_helpers.TextC(true, 0xFF31C9FF, "Rabarta")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rabarta) == 15
        or playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rabarta) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rabarta) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rabarta) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rabarta) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rabarta))
    end

    lib_helpers.TextC(true, 0xFFFFEFAD, "Grants")
    lib_helpers.Text(false, ": ")
    if playerClass == 6 or playerClass == 7 or playerClass == 8 or playerClass == 10 then
        if lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Grants) == 30 then
            lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
        else
            lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Grants))
        end
    else
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    end

    lib_helpers.TextC(true, 0xFFCE10FF, "Megid")
    lib_helpers.Text(false, ": ")
    if playerClass == 6 or playerClass == 7 or playerClass == 8 or playerClass == 10 then
        if lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Megid) == 30 then
            lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
        else
            lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Megid))
        end
    else
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    end

    lib_helpers.TextC(true, 0xFF02FFBD, "Resta")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Resta) == 15
        or playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Resta) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Resta) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Resta) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Resta) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Resta))
    end

    lib_helpers.TextC(true, 0xFF02FFBD, "Anti")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Anti) == 5 
        or playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Anti) == 5 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv5")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Anti) == 7 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv7")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Anti))
    end

    lib_helpers.TextC(true, 0xFF02FFBD, "Reverser")
    lib_helpers.Text(false, ": ")
    if playerClass == 6 or playerClass == 7 or playerClass == 8 or playerClass == 10 then
        if lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Reverser) == 1 then
            lib_helpers.TextC(false, 0xFF00EDFF, "Lv1")
        else
            lib_helpers.Text(false, "Lv0")
        end
    else
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    end

    lib_helpers.TextC(true, 0xFFFF2031, "Shifta")
    lib_helpers.Text(false, ": ")
    if playerClass == 0 or playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Shifta) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Shifta) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Shifta) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Shifta) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Shifta))
    end

    lib_helpers.TextC(true, 0xFF0065FF, "Deband")
    lib_helpers.Text(false, ": ")
    if playerClass == 0 or playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 3 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Deband) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Deband) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Deband) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Deband) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Deband))
    end

    lib_helpers.TextC(true, 0xFFFF2031, "Jellen")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 3 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Jellen) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Jellen) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Jellen) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Jellen) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Jellen))
    end

    lib_helpers.TextC(true, 0xFF0065FF, "Zalure")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 3 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif playerClass == 0 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zalure) == 15 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv15")
    elseif playerClass == 1 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zalure) == 20
        or playerClass == 11 and lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zalure) == 20 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv20")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zalure) == 30 then
        lib_helpers.TextC(false, 0xFF00EDFF, "Lv30")
    else
        lib_helpers.Text(false, "Lv%i", lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zalure))
    end

    lib_helpers.TextC(true, 0xFF9455F7, "Ryuker")
    lib_helpers.Text(false, ": ")
    if playerClass == 2 or playerClass == 4 or playerClass == 5 or playerClass == 9 then
        lib_helpers.TextC(false, 0xFF00EDFF, "---")
    elseif lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Ryuker) == 1 then
            lib_helpers.TextC(false, 0xFF00EDFF, "Lv1")
    else
        lib_helpers.Text(false, "Lv0")
    end
end

local function present()
    --[[ If the addon has never been used, open the config window
         and disable the config window setting ]]--
    if options.ConfigurationEnableWindow then
        ConfigurationWindow.open = true
        options.ConfigurationEnableWindow = false
    end

    ConfigurationWindow.Update()

    if ConfigurationWindow.changed then
        ConfigurationWindow.changed = false
        SaveOptions(options)
        -- Update the delay too
        update_delay = (options.updateThrottle * 1000)
    end

    --- Update timer for update throttle
    current_time = pso.get_tick_count()

    -- Global enable here to let the configuration window work
    if options.enable == false then
        return
    end

    if options.EnableWindow == true
        and (options.HideWhenMenu == false or lib_menu.IsMenuOpen() == false)
        and (options.HideWhenSymbolChat == false or lib_menu.IsSymbolChatOpen() == false)
        and (options.HideWhenMenuUnavailable == false or lib_menu.IsMenuUnavailable() == false) then

        if options.changed then
            options.changed = false
            local ps = lib_helpers.GetPosBySizeAndAnchor(options.X, options.Y, 0, 0, options.Anchor)
            imgui.SetNextWindowPos(ps[1], ps[2], "Always");
        end

        if options.TransparentWindow == true then
            imgui.PushStyleColor("WindowBg", 0.0, 0.0, 0.0, 0.00)
        end

        if imgui.Begin("Tech Levels", nil, {"AlwaysAutoResize", "NoResize", options.NoTitleBar, options.NoMove}) then
        showTechniques()
        end

        imgui.End()

        if options.TransparentWindow == true then
            imgui.PopStyleColor()
        end
    end

    if firstPresent then
        firstPresent = false
    end

end

local function init()
    ConfigurationWindow = cfg.ConfigurationWindow(options)

    local function mainMenuButtonHandler()
        ConfigurationWindow.open = not ConfigurationWindow.open
    end

    core_mainmenu.add_button("Tech Levels", mainMenuButtonHandler)

    return
    {
        name = "Tech Levels",
        version = "1.0",
        author = "Zio Oxview",
        description = "Displays current technique levels",
        present = present,
    }
end

return {__addon = {init = init}}