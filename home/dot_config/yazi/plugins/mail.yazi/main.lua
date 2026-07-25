--- @since 26.5.6
local addresses = {"alice@example.com", "bob@example.com"}

local selected_or_hovered = ya.sync(function()
    local tab, urls = cx.active, {}
    for _, u in pairs(tab.selected) do
        -- Clone with Url(): cx values are borrowed and can't cross the sync boundary.
        urls[#urls + 1] = Url(u)
    end
    if #urls == 0 and tab.current.hovered then
        urls[1] = Url(tab.current.hovered.url)
    end
    return urls
end)

local function notify(level, s, ...)
    ya.notify {
        title = "Mail",
        content = string.format(s, ...),
        level = level,
        timeout = 5
    }
end

local function fail(s, ...)
    notify("error", s, ...)
end

local function ask_address()
    local permit = ui.hide()
    local child, err = Command("fzf"):arg({"--bind", "enter:accept-or-print-query", "--prompt", "Send to: "}):stdin(
        Command.PIPED):stdout(Command.PIPED):spawn()
    if not child then
        permit:drop()
        fail("Failed to run fzf: %s", err)
        return nil
    end

    child:write_all(table.concat(addresses, "\n"))
    child:flush()

    local output, err = child:wait_with_output()
    permit:drop()

    if not output then
        fail("Cannot read fzf output: %s", err)
        return nil
    end
    if output.status.code == 130 then -- Cancelled with Esc/Ctrl-C
        return nil
    end

    -- `enter:accept-or-print-query` prints the selection, or the query if nothing matched.
    local addr = output.stdout:gsub("\n$", "")
    return addr
end

return {
    entry = function()
        ya.emit("escape", {
            visual = true
        })

        local urls = selected_or_hovered()
        if #urls == 0 then
            return notify("warn", "No file selected")
        end

        local addr = ask_address()
        if addr == nil then
            return
        end
        if addr == "" then
            return notify("warn", "No recipient given")
        end

        local names = {}
        for _, u in ipairs(urls) do
            names[#names + 1] = u.name
        end

        local cmd = Command("neomutt"):arg({"-s", table.concat(names, ", ")})
        for _, u in ipairs(urls) do
            cmd:arg({"-a", tostring(u)})
        end
        cmd:arg({"--", addr})

        -- Piped stdin puts neomutt in batch mode (sends without opening its TUI);
        -- it needs a non-empty body or it aborts with "Cannot send an empty message".
        local child, err = cmd:stdin(Command.PIPED):stdout(Command.PIPED):stderr(Command.PIPED):spawn()
        if not child then
            return fail("Failed to run neomutt: %s", err)
        end
        child:write_all("Sent from Yazi.\n")
        child:flush()

        local output, err = child:wait_with_output()
        if not output then
            fail("Failed to run neomutt: %s", err)
        elseif not output.status.success then
            fail("Sending failed: %s", output.stderr)
        else
            notify("info", "Sent to %s", addr)
        end
    end
}
