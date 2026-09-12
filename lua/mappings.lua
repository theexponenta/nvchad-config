require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

local resize = function(win, amt, dir)
    return function()
        require("winresize").resize(win, amt, dir)
    end
end

map("i", "jj", "<ESC>")

map({"n", "t"}, "<C-Up>", resize(0, 1, "up"), { desc = "resize up" })
map({"n", "t"}, "<C-Down>", resize(0, 1, "down"), { desc = "resize down" })
map({"n", "t"}, "<C-Right>", resize(0, 1, "right"), { desc = "resize right" })
map({"n", "t"}, "<C-Left>", resize(0, 1, "left"), { desc = "reisze left" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "K", function() vim.lsp.buf.hover { border = "rounded" } end, { desc = "LSP Hover" } );

local function stopinsert()
  vim.cmd('stopinsert')
end

map('t', "<Esc>", stopinsert, { noremap = true, silent = true })
map('t', "jj", stopinsert, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>a", function() vim.lsp.buf.code_action() end, { desc = "LSP Code Action" })

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

