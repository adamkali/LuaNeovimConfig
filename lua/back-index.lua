local BackIndex = {}

BackIndex.create_index = function()
end

BackIndex.backlink_index = {}

BackIndex.backlink_index.index= function()
	-- get the current directory available
	-- check if there is an index.norg
	-- - if there is an index.norg
end

local backlink = [[
* Links
 {:./index.norg:}[back]
]]

local link = [[
** ++neorg_document_title++
  - {:./++neorg_filename++:}[++neorg_document_title++]
]]

BackIndex.backlink_index.backlink= function(norg_filename)
	-- add the links section if not already there 
	-- add the * Links section to the bottom of the current file
	-- and add the {:./index.norg:}[back]
	-- eg
	-- * Links
	-- {:./index.norg:}[back]
	local lines = vim.split(backlink, "\n")
	vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
	
end

BackIndex.backlink_index.link= function(norg_filename)
	--    add the link to the current file in the
	--    * Links
	--    ** Foo Bar
	--      - {:./foo.norg:}[Foo Bar]
	--    ** << Title of the current file from NEORG lib >>
	--      - {:./<< filename >>.norg:}[<< Title of the current file from NEORG lib >>]
	local is_metadat_present = require('neorg.modules.core.esupports.metagen.module').public.is_metadata_present(0)
	if not is_metadat_present then
		require('neorg.modules.core.esupports.metagen.module').public.inject_metadata()
	end

	local metadata = require('neorg.modules.core.esupports.metagen.module').public.get_metadata(0)
	local title = metadata.title
	if not title then
        title = vim.fn.expand("%:p:t:r")
	end
	-- get filename 
	local filename = vim.fn.expand("%:p:t")
	local dotslash_filename = "./" .. filename .. ".norg"

	link = link:gsub("++neorg_document_title++", title)
	link = link:gsub("++neorg_filename++", dotslash_filename)

	local lines = vim.split(link, "\n")
	vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
end


return BackIndex
