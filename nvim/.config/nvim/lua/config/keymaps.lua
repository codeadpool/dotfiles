local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Window navigation
keymap.set('n', '<C-h>', '<C-w>h', opts)
keymap.set('n', '<C-j>', '<C-w>j', opts)
keymap.set('n', '<C-k>', '<C-w>k', opts)
keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
-- keymap.set('n', '<S-l>', ':bnext<CR>', opts)
-- keymap.set('n', '<S-h>', ':bprevious<CR>', opts)

-- Clear highlights
keymap.set('n', '<leader>h', '<cmd>nohlsearch<CR>', opts)

-- Close buffers
keymap.set('n', '<leader>q', '<cmd>Bdelete!<CR>', opts)

-- Better paste
keymap.set('v', 'p', '"_dP', opts)

-- Insert mode shortcuts
keymap.set('i', 'jj', '<ESC>', opts)

-- Terminal
keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
