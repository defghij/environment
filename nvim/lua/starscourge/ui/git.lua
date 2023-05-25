------------------
-- Git Conflict --
------------------

require('git-conflict').setup {}

--------------
-- Gitsigns --
--------------

-- Display git changes.
require('gitsigns').setup {
    signs = {
        add = { text = '│' },
        change = { text = '╎' },
        delete = { text = '-' },
        topdelete = { text = '-' },
        changedelete = { text = '~' },
        untracked = { text = '⚬' },
    },
    signcolumn = true,
    numhl = false,
}

------------------
-- Git worktree --
------------------

require('git-worktree').setup {
    change_directory_command = 'cd',
    update_on_change = true,
    update_on_change_command = 'e .',
    clearjumps_on_change = true,
    autopush = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 50,
        ignore_whitespace = false,
      },
    current_line_blame_formatter = '<author> ⚬ <author_time:%Y-%m-%d>',
}

--------------
-- Diffview --
--------------

require('diffview').setup {
    enhanced_diff_hl = true,
}
