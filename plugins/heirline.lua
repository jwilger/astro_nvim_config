return {
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require("astronvim.utils.status")

        opts.statusline = { -- statusline
          hl = { fg = "fg", bg = "bg" },
          status.component.mode { mode_text = {padding = { left = 1, right = 1 }} },
          status.component.git_branch(),
          status.component.file_info { filetype = false, filename = {}, file_modified = {} },
          status.component.git_diff(),
          status.component.diagnostics(),
          status.component.fill(),
          status.component.cmd_info(),
          status.component.fill(),
          status.component.lsp(),
          status.component.treesitter(),
          status.component.nav(),
          status.component.mode { surround = { separator = "right" } },
        }

        opts.winbar = { -- winbar
          init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
          fallthrough = false,
          { -- inactive winbar
            condition = function() return not status.condition.is_active() end,
            status.component.separated_path(),
            status.component.file_info {
              file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
              file_modified = false,
              file_read_only = false,
              hl = status.hl.get_attributes("winbarnc", true),
              surround = false,
              update = "BufEnter",
            },
          },
          { -- active winbar
            status.component.breadcrumbs { hl = status.hl.get_attributes("winbar", true) },
          },
        }

        opts.tabline = { -- tabline
          { -- file tree padding
            condition = function(self)
              self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
              return status.condition.buffer_matches(
                { filetype = { "aerial", "dapui_.", "neo%-tree", "NvimTree" } },
                vim.api.nvim_win_get_buf(self.winid)
              )
            end,
            provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1) end,
            hl = { bg = "tabline_bg" },
          },
          status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
          status.component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
          { -- tab list
            condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
            status.heirline.make_tablist { -- component for each tab
              provider = status.provider.tabnr(),
              hl = function(self)
                return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true)
              end,
            },
            { -- close button for current tab
              provider = status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
              hl = status.hl.get_attributes("tab_close", true),
              on_click = { callback = function() require("astronvim.utils.buffer").close_tab() end, name = "heirline_tabline_close_tab_callback" },
            },
          },
        }

        opts.statuscolumn = { -- statuscolumn
          status.component.foldcolumn(),
          status.component.fill(),
          status.component.numbercolumn(),
          status.component.signcolumn(),
        }

        -- return the final configuration table
        return opts
      end,
    },
  }
