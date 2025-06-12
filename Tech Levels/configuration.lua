local function ConfigurationWindow(configuration)
    local this = 
        {
            title = "Tech Levels - Configuration",
            open = false,
            changed = false,
        }

        local _configuration = configuration

        local _showWindowSettings = function()
            local success
            local anchorList =
                {
                    "Top Left", "Left", "Bottom Left",
                    "Top", "Center", "Bottom",
                    "Top Right", "Right", "Bottom Right",
                }

            if imgui.Checkbox("Enable", _configuration.EnableWindow) then
                _configuration.EnableWindow = not _configuration.EnableWindow
                this.changed = true
            end

            if imgui.Checkbox("Hide when menus are open", _configuration.HideWhenMenu) then
                _configuration.HideWhenMenu = not _configuration.HideWhenMenu
                this.changed = true
            end

            if imgui.Checkbox("Hide when symbol chat/word select is open", _configuration.HideWhenSymbolChat) then
                _configuration.HideWhenSymbolChat = not _configuration.HideWhenSymbolChat
                this.changed = true
            end

            if imgui.Checkbox("Hide when the menu is unavailable", _configuration.HideWhenMenuUnavailable) then
                _configuration.HideWhenMenuUnavailable = not _configuration.HideWhenMenuUnavailable
                this.changed = true
            end

            if imgui.Checkbox("No title bar", _configuration.NoTitleBar == "NoTitleBar") then
                if _configuration.NoTitleBar == "NoTitleBar" then
                    _configuration.NoTitleBar = ""
                else
                    _configuration.NoTitleBar = "NoTitleBar"
                end
                this.changed = true
            end

            if imgui.Checkbox("No move", _configuration.NoMove == "NoMove") then
                if _configuration.NoMove == "NoMove" then
                    _configuration.NoMove = ""
                else
                    _configuration.NoMove = "NoMove"
                end
                this.changed = true
            end

            if imgui.Checkbox("Transparent window", _configuration.TransparentWindow) then
                _configuration.TransparentWindow = not _configuration.TransparentWindow
                this.changed = true
            end

        imgui.Text("Position")
        imgui.PushItemWidth(115)
        success, _configuration.Anchor = imgui.Combo("Anchor", _configuration.Anchor, anchorList, table.getn(anchorList))
        imgui.PopItemWidth()
        if success then
            _configuration.changed = true
            this.changed = true
        end

        imgui.PushItemWidth(115)
        success, _configuration.X = imgui.InputInt("X", _configuration.X)
        imgui.PopItemWidth()
        if success then
            _configuration.changed = true
            this.changed = true
        end

        imgui.PushItemWidth(115)
        success, _configuration.Y = imgui.InputInt("Y", _configuration.Y)
        imgui.PopItemWidth()
        if success then
            _configuration.changed = true
            this.changed = true
        end

    end

    this.Update = function()
        if this.open == false then
            return
        end

        local success

        imgui.SetNextWindowSize(200, 200, 'FirstUseEver')
        success, this.open = imgui.Begin(this.title, this.open, "AlwaysAutoResize", "NoResize")

        _showWindowSettings()

        imgui.End()
    end

    return this

end

return
{
    ConfigurationWindow = ConfigurationWindow,
}