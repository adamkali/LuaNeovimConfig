local latextemplate = [[
\documentclass[a4paper,floatfix,nofootinbib]{revtex4-1}
\usepackage{amsmath,amssymb}
\usepackage[numbers]{natbib}
\usepackage{graphicx}

\begin{document}

\end{document}
]]

local function insert_template()
    local lines = vim.api.nvim_buf_line_count(0) 
    if lines == 0 then
        -- insert the template
        local template_lines = vim.split(latextemplate, '\n')
        vim.api.nvim_buf_set_lines(0, 0, -1, true, template_lines)
    end
end
