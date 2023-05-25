-- I want to keep all of the key bindings in one file so that it is easy to see
-- what is being used and ensure nothing being overwritten by accident.

local ex_t = { 'n', 'i', 'v' }
local n_v = { 'n', 'v' }
local n = 'n'
local i = 'i'

local map_key = vim.keymap.set
local default_settings = { noremap = true, silent = true }

-- Tree.
map_key(n_v, '<Leader>f', function() require('starscourge.keymaps.utils').toggle_tree() end, default_settings)

-- Telescope.
map_key(n_v, '<C-t>', '<Cmd>Telescope oldfiles<CR>', default_settings)
map_key(n_v, '<leader>ff', '<Cmd>Telescope find_files<CR>', default_settings)
map_key(n_v, '<leader>fF', '<Cmd>Telescope find_files cwd=~<CR>', default_settings)
map_key(n_v, '<leader>fs', '<Cmd>Telescope live_grep<CR>', default_settings)
map_key(n_v, '<leader>fS', '<Cmd>Telescope live_grep cwd=~<CR>', default_settings)
map_key(ex_t, '<F12>', '<Cmd>Cheatsheet<CR>', default_settings)

-- Windows.
map_key(ex_t, '<C-w><C-c>', '<Cmd>wincmd c<CR>', default_settings)
map_key(ex_t, '<C-h>', '<Cmd>wincmd h<CR>', default_settings)
map_key(ex_t, '<C-j>', '<Cmd>wincmd j<CR>', default_settings)
map_key(ex_t, '<C-k>', '<Cmd>wincmd k<CR>', default_settings)
map_key(ex_t, '<C-l>', '<Cmd>wincmd l<CR>', default_settings)
map_key(ex_t, '<C-Up>', ':resize -2<CR>', default_settings)
map_key(ex_t, '<C-Down>', ':resize +2<CR>', default_settings)
map_key(ex_t, '<C-Left>', ':vertical resize -2<CR>', default_settings)
map_key(ex_t, '<C-Right>', ':vertical resize +2<CR>', default_settings)

-- Editing.
map_key(ex_t, '<C-/>', '<Cmd>Commentary<CR>', default_settings)
map_key(ex_t, '<C-z>', '<Cmd>undo<CR>', default_settings)
map_key(ex_t, '<C-y>', '<Cmd>redo<CR>', default_settings)
map_key(i, '<Esc>', '<Esc>`^', default_settings)
map_key(ex_t, '<C-s>', function() require('starscourge.keymaps.utils').save_file() end, default_settings)

-- Buffers.
map_key(n, '<leader><leader>', '<Cmd>Telescope buffers<CR>', default_settings)

-- Barbar
map_key(n, '<C-q>', '<Cmd>BufferDelete<CR>', default_settings)
map_key(n, 'Q', '<Cmd>BufferDelete<CR>', default_settings)
map_key(n, 'db', '<Cmd>BufferPickDelete<CR>', default_settings)
map_key(n, 'bp', '<Cmd>BufferPick<CR>', default_settings)
map_key(n, 'gT', '<Cmd>BufferPrevious<CR>', default_settings)
map_key(n, 'gt', '<Cmd>BufferNext<CR>', default_settings)
map_key(n, 'bP', '<Cmd>BufferPin<CR>', default_settings)

-- LSP.
map_key(n, '<leader>d', '<Cmd>TroubleToggle document_diagnostics<CR>', default_settings)
map_key(n, '<leader>D', '<Cmd>TroubleToggle workspace_diagnostics<CR>', default_settings)
map_key(n, 'gr', '<cmd>Lspsaga lsp_finder<CR>', default_settings)
map_key(n_v, 'ca', '<cmd>Lspsaga code_action<CR>', default_settings)
map_key(n_v, 'RR', '<cmd>Lspsaga rename<CR>', default_settings)
map_key(n, 'gd', '<cmd>Lspsaga peek_definition<CR>', default_settings)
map_key(n, 'gf', '<cmd>Lspsaga goto_definition<CR>zz', default_settings)
map_key(n, 'gD', '<cmd>Lspsaga hover_doc<CR>', default_settings)
map_key(n, 'e', '<cmd>Lspsaga show_line_diagnostics ++unfocus<CR>', default_settings)
map_key(n, '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', default_settings)
map_key(n, ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', default_settings)
map_key(n, '<leader>o', '<cmd>Lspsaga outline<CR>', default_settings)
map_key(n, '[E', function() require('starscourge.keymaps.utils').next_error() end, default_settings)
map_key(n, ']E', function() require('starscourge.keymaps.utils').prev_error() end, default_settings)

-- Misc.
map_key(n, 'gl', '<Cmd>VimtexView<CR>', default_settings)
map_key(n_v, '<Esc>', '<Cmd>noh<CR>', { silent = true, noremap = false })

-- Debugger.
map_key(n, 'S', function() require('dapui').float_element 'scopes' end, default_settings)
map_key(n, '<C-b>', '<Cmd>DapToggleBreakpoint<CR>', default_settings)
map_key(n, '<F1>', function() require('dapui').toggle() end, default_settings)
map_key(n, '<F2>', '<Cmd>DapContinue<CR>', default_settings)
map_key(n, '<F3>', '<Cmd>DapStepInto<CR>', default_settings)
map_key(n, '<F4>', '<Cmd>DapStepOver<CR>', default_settings)
map_key(n, '<F5>', '<Cmd>DapStepOut<CR>', default_settings)
map_key(n, '<F6>', '<Cmd>DapRestartFrame<CR>', default_settings)
map_key(n, '<F7>', '<Cmd>DapTerminate<CR>', default_settings)

-- Completion.
local cmp = require 'cmp'
local luasnip = require 'luasnip'
cmp.setup {
    mapping = cmp.mapping.preset.insert {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm { select = false }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
}
