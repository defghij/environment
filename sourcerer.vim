"  r  e  a  d     c  o  d  e     l  i  k  e     a     p u n k!
"
"  ├─ based on sourcerer by xero harrison (http://sourcerer.xero.nu)
"  ├─ based on sorcerer by Jeet Sukumaran (http://jeetworks.org)
"  └─ based on mustang by Henrique C. Alves (hcarvalhoalves@gmail.com)

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
  endif

  let colors_name = "netrunner"

  "  █▓▒░ 256 colors 
  hi Normal          cterm=NONE           ctermbg=NONE  ctermfg=145
  hi ColorColumn     cterm=NONE           ctermbg=60    ctermfg=NONE
  hi Cursor          cterm=NONE           ctermbg=NONE  ctermfg=NONE
  hi CursorColumn    cterm=NONE           ctermbg=16    ctermfg=fg
  hi CursorLine      cterm=NONE           ctermbg=236   ctermfg=fg
  hi CursorLineNr    cterm=bold           ctermbg=NONE  ctermfg=fg
  hi DiffAdd         cterm=NONE           ctermbg=NONE  ctermfg=16
  hi DiffDelete      cterm=NONE           ctermbg=NONE  ctermfg=16
  hi DiffChange      cterm=NONE           ctermbg=NONE  ctermfg=16
  hi DiffText        cterm=NONE           ctermbg=NONE  ctermfg=16
  hi Directory       cterm=NONE           ctermbg=234   ctermfg=33
  hi ErrorMsg        cterm=bold           ctermbg=NONE  ctermfg=203
  hi FoldColumn      cterm=bold           ctermbg=NONE  ctermfg=66
  hi Folded          cterm=NONE           ctermbg=NONE  ctermfg=60
  hi IncSearch       cterm=bold           ctermbg=75    ctermfg=231
  hi LineNr          cterm=NONE           ctermbg=NONE  ctermfg=102
  hi MatchParen      cterm=bold           ctermbg=NONE  ctermfg=red
  hi ModeMsg         cterm=bold           ctermbg=NONE  ctermfg=145
  hi MoreMsg         cterm=bold           ctermbg=234   ctermfg=29
  hi NonText         cterm=NONE           ctermbg=NONE  ctermfg=59
  hi Question        cterm=bold           ctermbg=NONE  ctermfg=46
  hi Search          cterm=bold           ctermbg=75    ctermfg=16
  hi SignColumn      cterm=NONE           ctermbg=NONE  ctermfg=231
  hi SpecialKey      cterm=NONE           ctermbg=NONE  ctermfg=59
  hi SpellBad        cterm=undercurl      ctermbg=NONE  ctermfg=196
  hi SpellCap        cterm=undercurl      ctermbg=NONE  ctermfg=21
  hi SpellLocal      cterm=undercurl      ctermbg=NONE  ctermfg=30
  hi SpellRare       cterm=undercurl      ctermbg=NONE  ctermfg=201
  hi StatusLine      cterm=bold           ctermbg=101   ctermfg=16
  hi StatusLineNC    cterm=NONE           ctermbg=102   ctermfg=16
  hi VertSplit       cterm=NONE           ctermbg=NONE  ctermfg=102
  hi TabLine         cterm=bold           ctermbg=102   ctermfg=16
  hi TabLineFill     cterm=NONE           ctermbg=102   ctermfg=16
  hi TabLineSel      cterm=bold           ctermbg=16    ctermfg=59
  hi Title           cterm=bold           ctermbg=NONE  ctermfg=66
  hi Visual          cterm=bold           ctermbg=16    ctermfg=NONE
  hi WarningMsg      cterm=NONE           ctermbg=234   ctermfg=208
  hi WildMenu        cterm=NONE           ctermbg=116   ctermfg=16
  hi ExtraWhitespace cterm=NONE           ctermbg=61    ctermfg=245

  hi Comment         cterm=NONE           ctermbg=NONE  ctermfg=59
  hi Boolean         cterm=NONE           ctermbg=NONE  ctermfg=208
  hi String          cterm=NONE           ctermbg=NONE  ctermfg=101
  hi Identifier      cterm=NONE           ctermbg=NONE  ctermfg=145
  hi Function        cterm=NONE           ctermbg=NONE  ctermfg=230
  hi Type            cterm=NONE           ctermbg=NONE  ctermfg=103
  hi Statement       cterm=NONE           ctermbg=NONE  ctermfg=110
  hi Keyword         cterm=NONE           ctermbg=NONE  ctermfg=110
  hi Constant        cterm=NONE           ctermbg=NONE  ctermfg=208
  hi Number          cterm=NONE           ctermbg=NONE  ctermfg=172
  hi Special         cterm=NONE           ctermbg=NONE  ctermfg=64
  hi PreProc         cterm=NONE           ctermbg=NONE  ctermfg=66
  hi Todo            cterm=bold,underline ctermbg=234   ctermfg=96

"  hi diffOldFile     cterm=NONE           ctermbg=NONE  ctermfg=67
"  hi diffNewFile     cterm=NONE           ctermbg=NONE  ctermfg=67
  hi diffFile        cterm=NONE           ctermbg=NONE  ctermfg=NONE
  hi diffLine        cterm=NONE           ctermbg=NONE  ctermfg=NONE
  hi diffAdded       cterm=NONE           ctermfg=NONE  ctermfg=Green
  hi diffAdd         cterm=NONE           ctermfg=NONE  ctermfg=Green
  hi diffRemoved     cterm=NONE           ctermfg=NONE  ctermfg=Red
  hi diffDelete      cterm=NONE           ctermfg=NONE  ctermfg=Red
  hi diffChanged     cterm=NONE           ctermfg=NONE  ctermfg=LightBlue
  hi diffChange      cterm=NONE           ctermfg=NONE  ctermfg=LightBlue
  hi diffText        cterm=NONE           ctermfg=NONE  ctermfg=Green

  hi link             diffSubname     diffLine
  hi link             diffOnly        Constant
  hi link             diffIdentical   Constant
  hi link             diffDiffer      Constant
  hi link             diffBDiffer     Constant
  hi link             diffIsA         Constant
  hi link             diffNoEOL       Constant
  hi link             diffCommon      Constant
  hi link             diffComment     Constant

  hi pythonClass          cterm=NONE           ctermbg=NONE  ctermfg=fg
  hi pythonDecorator      cterm=NONE           ctermbg=NONE  ctermfg=101
  hi pythonExClass        cterm=NONE           ctermbg=NONE  ctermfg=95
  hi pythonException      cterm=NONE           ctermbg=NONE  ctermfg=110
  hi pythonFunc           cterm=NONE           ctermbg=NONE  ctermfg=fg
  hi pythonFuncParams     cterm=NONE           ctermbg=NONE  ctermfg=fg
  hi pythonKeyword        cterm=NONE           ctermbg=NONE  ctermfg=fg
  hi pythonParam          cterm=NONE           ctermbg=NONE  ctermfg=fg
  hi pythonRawEscape      cterm=NONE           ctermbg=NONE  ctermfg=fg
  hi pythonSuperclasses   cterm=NONE           ctermbg=NONE  ctermfg=fg
  hi pythonSync           cterm=NONE           ctermbg=NONE  ctermfg=fg

  hi Conceal              cterm=NONE           ctermbg=NONE  ctermfg=252
  hi Error                cterm=NONE           ctermbg=NONE  ctermfg=231
  hi Ignore               cterm=NONE           ctermbg=NONE  ctermfg=234
  hi InsertModeCursorLine cterm=NONE           ctermbg=16    ctermfg=fg
  hi NormalModeCursorLine cterm=NONE           ctermbg=235   ctermfg=fg
  hi PmenuThumb           cterm=reverse        ctermbg=NONE  ctermfg=fg
  hi StatusLineAlert      cterm=NONE           ctermbg=160   ctermfg=231
  hi StatusLineUnalert    cterm=NONE           ctermbg=238   ctermfg=144
  hi Test                 cterm=NONE           ctermbg=NONE  ctermfg=fg
  hi Underlined           cterm=underline      ctermbg=NONE  ctermfg=111
  hi VisualNOS            cterm=bold,underline ctermbg=NONE  ctermfg=fg
  hi cCursor              cterm=reverse        ctermbg=NONE  ctermfg=fg
  hi iCursor              cterm=NONE           ctermbg=210   ctermfg=16
  hi lCursor              cterm=NONE           ctermbg=145   ctermfg=234
  hi nCursor              cterm=NONE           ctermbg=NONE  ctermfg=145
  hi vCursor              cterm=NONE           ctermbg=201   ctermfg=16
  hi Pmenu                cterm=NONE           ctermfg=248   ctermbg=237
  hi PmenuSel             cterm=NONE           ctermfg=16    ctermbg=66
  hi PmenuSbar            cterm=NONE           ctermfg=16    ctermbg=66
  hi PmenuThumb           cterm=NONE           ctermfg=16    ctermbg=66
