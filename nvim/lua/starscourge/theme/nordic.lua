
-- Initial setup.
require('nordic').setup {
    bright_border = false,
    telescope = {
        style = 'flat',
    },
    bold_keywords = false,
    italic_comments = true,
    cursorline = {
        theme = 'dark',
        bold = false,
    },
    noice = {
        style = 'classic',
    },
}

-- Overrides.
local p = require 'nordic.colors'
local override = {
    PopupNormal             = { bg = p.bg_dark                                                  },
    PopupBorder             = { bg = p.bg_dark,      fg = p.grey1                               },
    Pmenu                   = {                                            link = 'PopupNormal' },
    PmenuSel                = { bg = p.grey0                                                    },
    PmenuBorder             = {                                            link = 'PopupBorder' },
    PmenuDocBorder          = { bg = p.bg_dark,      fg = p.grey1                               },
    NormalFloat             = { bg = p.bg_dark                                                  },
    FloatBorder             = { bg = p.bg_dark                                                  },
    NoiceCmdlineIcon        = { bg = p.bg_dark                                                  },
    NoiceCmdlinePopupBorder = {                      fg = p.cyan.base                           },
    SagaBorder              = { bg = p.bg_dark,      fg = p.grey1                               },
    SagaNormal              = { bg = p.bg_dark                                                  },
    NoiceLspProgressTitle   = { bg = p.bg,           fg = p.yellow.base, bold = true            },
    NoiceLspProgressClient  = { bg = p.bg,           fg = p.gray4                               },
    NoiceLspProgressSpinner = { bg = p.bg,           fg = p.cyan.bright                         },
    NoiceFormatProgressDone = { bg = p.green.bright, fg = p.black                               },
    NoiceFormatProgressTodo = { bg = p.gray5,        fg = p.black                               },
    CmpItemKindTabNine      = {                      fg = p.red.base                            },
    CmpItemKindCopilot      = {                      fg = p.red.base                            },
    TelescopePreviewLine    = { bg = p.gray0                                                    },
    NvimTreeWinSeparator    = { bg = NONE,           fg = NONE                                  },
    WinSeparator            = {                      fg = NONE                               },
    WhichKeyBorder          = { bg = p.bg_dark,      fg = p.gray1                               },
    CursorLineNr            = { bg = NONE,           fg = p.blue.bright, bold = true            },
    CursorLine              = { bg = NONE,           fg = NONE                                  },
}
require('nordic').setup { 
    transparent_bg = true,
    override = override,
}

-- Load the scheme.
vim.cmd.colorscheme 'nordic'
