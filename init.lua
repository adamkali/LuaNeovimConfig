--[[
       d8888      888                       d8b          
      d88888      888                       88P          
     d88P888      888                       8P           
    d88P 888  .d88888  8888b.  88888b.d88b. "  .d8888b   
   d88P  888 d88" 888     "88b 888 "888 "88b   88K       
  d88P   888 888  888 .d888888 888  888  888   "Y8888b.  
 d8888888888 Y88b 888 888  888 888  888  888        X88  
d88P     888  "Y88888 "Y888888 888  888  888    88888P'  
                                                         
                                                         
                                                         
888b    888                            d8b               
8888b   888                            Y8P               
88888b  888                                              
888Y88b 888  .d88b.   .d88b.  888  888 888 88888b.d88b.  
888 Y88b888 d8P  Y8b d88""88b 888  888 888 888 "888 "88b 
888  Y88888 88888888 888  888 Y88  88P 888 888  888  888 
888   Y8888 Y8b.     Y88..88P  Y8bd8P  888 888  888  888 
888    Y888  "Y8888   "Y88P"    Y88P   888 888  888  888 
                                                         
                                                         
                                                         
d8b          d8b 888        888                          
Y8P          Y8P 888        888                          
                 888        888                          
888 88888b.  888 888888     888 888  888  8888b.         
888 888 "88b 888 888        888 888  888     "88b        
888 888  888 888 888        888 888  888 .d888888        
888 888  888 888 Y88b.  d8b 888 Y88b 888 888  888        
888 888  888 888  "Y888 Y8P 888  "Y88888 "Y888888   
-- ]]

require('autocomplete-config')
require('colors')
require('colorizer-config')
require('duckytype-config')
require('gitintegration-config')
require('keybindings')
require('lsp-config')
require('lualine-config')
require('nvim-tree-config')
require('packer-config')
require('telescope-config')
require('treesitter-config')
require('vim-config')
require('vaporlush-config')
require('code-templates-config')


-- BoilerPlate
vim.cmd [[autocmd BufNewFile *.tex lua require('code-templates-config').insert_template()]]
