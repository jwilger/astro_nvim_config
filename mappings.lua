local utils = require "astronvim.utils"
-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(
            bufnr)
        end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<leader>gg"] = { function()
      require('neogit').open({})
    end,
      desc = "Open NeoGit" },
    ["<C-w>z"] = { "<cmd>WindowsMaximize<cr>", desc = "Maximize Window" },
    ["<leader>bb"] = { "<cmd>b#<cr>", desc = "Last Buffer" },
    ["<leader>ti"] = { function() utils.toggle_term_cmd({cmd ="zsh ./integrate.sh", direction = "vertical", close_on_exit = false, start_in_insert = false, clear_env = false}) end, desc = "Integrate" }
  },
  t = {
    -- setting a mapping to false will disable it
    ["<esc>"] = false,
  },
  i = {
    ["fpp"] = {"|> ", desc = "Insert Pipe"}
  }
}

-- Terminal:new {
--   cmd = string -- command to execute when creating the terminal e.g. 'top'
--   direction = string -- the layout for the terminal, same as the main config options
--   dir = string -- the directory for the terminal
--   close_on_exit = bool -- close the terminal window when the process exits
--   highlights = table -- a table with highlights
--   env = table -- key:value table with environmental variables passed to jobstart()
--   clear_env = bool -- use only environmental variables from `env`, passed to jobstart()
--   on_open = fun(t: Terminal) -- function to run when the terminal opens
--   on_close = fun(t: Terminal) -- function to run when the terminal closes
--   auto_scroll = boolean -- automatically scroll to the bottom on terminal output
--   -- callbacks for processing the output
--   on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
--   on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
--   on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
-- }
