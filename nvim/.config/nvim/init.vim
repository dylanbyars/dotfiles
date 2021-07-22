call plug#begin('~/.config/nvim/plugged')
" colorscheme
Plug 'Mofiqul/dracula.nvim'
" status line
Plug 'itchyny/lightline.vim'
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'f-person/git-blame.nvim'
" comments made easy
Plug 'tpope/vim-commentary'
" completion
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-compe'
Plug 'windwp/nvim-autopairs'
" prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" file explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua' 
" telescope stuff (order matter I think)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" writing
Plug 'junegunn/goyo.vim'
" linter
Plug 'dense-analysis/ale'
call plug#end()

set termguicolors

colorscheme dracula

" let g:lightline = { 'colorscheme': 'selenized_black' }
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]      
      \ },
      \   'right': [ 'lineinfo', 'percent', 'fileformat' ],
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" don't show the mode since it's shown in the statusline
set noshowmode

let mapleader=" "

" show the current line number on the current line and the relative line number on all other lines
set number relativenumber
" default to case insensitive search
set ignorecase 
" break lines between words at window's width
set linebreak
" tabs are 2 spaces wide (but still tabs)
set tabstop=2
set softtabstop=2 
set shiftwidth=2
set expandtab

" map j and k to gj and gk so that they move from visual line to visual line when j or k is
" pressed but move from real line to real line when jumping some number of
" lines across visually wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" map = to a command that searches for the word under the cursor
nmap = /<C-r><C-w>

" move down/up 10 lines with capital J/K
noremap <silent> J 10j
noremap <silent> K 10k

" keep 8 rows of text visible at the top and bottom of screen (if possible)
set scrolloff=8

" move between splits
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-l> :wincmd l<CR>
" make splits easier
nnoremap <silent> <leader>\| <C-w>v
nnoremap <silent> <leader>- <C-w>s

" git
" git gutter 
set updatetime=10
" git blame 
" off by default
let g:gitblame_enabled = 0
nmap <leader>b :GitBlameToggle<cr>

" nvim-tree config
nnoremap <leader>n :NvimTreeToggle <CR>
" show dot files/folders
let g:nvim_tree_hide_dotfiles = 0
let g:nvim_tree_width = '30%'

" telescope config
" Find files using Telescope command-line sugar.
" nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-b> <cmd>Telescope buffers<cr>
nnoremap <C-g> <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ALE config
" let g:ale_set_highlights = 1

" LSP config
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> <C-m> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" LSP Saga mappings
nnoremap <silent>; :Lspsaga hover_doc<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> gr :Lspsaga rename<CR>
" nnoremap <silent> gd :Lspsaga preview_definition<CR>
nnoremap <silent> <leader>cd :Lspsaga show_line_diagnostics<CR>
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>

set completeopt=menuone,noselect

lua << EOF
-- treesitter
require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "javascript", "bash", "css", "html", "jsdoc", "json", "lua", "regex", "scss", "tsx", "typescript", "yaml", "toml" }, 
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- telescope stuff
local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true}
-- https://github.com/skbolton/titan/blob/4d0d31cc6439a7565523b1018bec54e3e8bc502c/nvim/nvim/lua/mappings/filesystem.lua#L6
map('n', '<C-p>', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", default_opts)
-- end telescope stuff

-- LSP config
require'lspconfig'.tsserver.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.vimls.setup{}

-- LSP saga config
local saga = require 'lspsaga'
-- lsp provider to find the cursor word definition and reference

-- autopair config
require('nvim-autopairs').setup()

-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    -- spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true; 
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF
