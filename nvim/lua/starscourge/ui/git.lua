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
}

--------------
-- Diffview --
--------------

require('diffview').setup {
    enhanced_diff_hl = true,
}
