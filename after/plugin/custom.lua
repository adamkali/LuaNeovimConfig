local M = {
    UI = {}
}

M.UI.Greeting = function()
    local hour = tonumber(vim.fn.strftime("%H"))
    if hour < 12 then
        return "Good Morning"
    elseif hour < 18 then
        return "Good Afternoon"
    else
        return "Good Evening"
    end
end


