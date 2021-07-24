require 'general'
require 'plugins'
require 'statusline'

-- TODO: move this to lua
-- map j and k to gj and gk so that they move from visual line to visual line when j or k is
-- pressed but move from real line to real line when jumping some number of
-- lines across visually wrapped lines
-- nnoremap <expr> j v:count ? 'j' : 'gj'
-- nnoremap <expr> k v:count ? 'k' : 'gk'

