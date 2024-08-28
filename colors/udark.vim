let g:colors_name = 'udark'
set background=dark
hi! clear

if exists('syntax_on')
  syntax reset
endif

let s:telescopeIntegration = v:true

let s:cForeground = '#d4d4d4'
let s:cBackground = '#1e1e1e'
let s:cFaded      = '#252525'

let s:cMidtone0 = '#3c3c3c'
let s:cMidtone1 = '#5a5a5a'
let s:cMidtone2 = '#787878'
let s:cMidtone3 = '#969696'

let s:cBlue        = '#569cd6'
let s:cPink        = '#c586c0'
let s:cGreen       = '#6a9955'
let s:cOrange      = '#ce9178'
let s:cRed         = '#f44747'
let s:cLightOrange = '#d7ba7d'
let s:cLightRed    = '#d16969'
let s:cLightGreen  = '#b5cea8'

" Group Assosications
let s:gKeyword    = s:cPink
let s:gType       = s:cBlue
let s:gFunction   = s:cForeground
let s:gIdentifier = s:cForeground
let s:gString     = s:cOrange
let s:gNumber     = s:cLightGreen
let s:gConstant   = s:cLightOrange
let s:gComment    = s:cGreen
let s:gPreProc    = s:cPink

function! s:hi(group, fg)
  execute 'hi! ' . a:group . ' guifg=' . a:fg . ' guibg=NONE'
endfunction

function! s:link(ga, gb)
  execute 'hi! link ' . a:ga . ' ' . a:gb
endfunction

function! s:hiEx(group, fg, bg, style = 'NONE')
  execute 'hi! ' . a:group . ' guifg=' . a:fg . ' guibg=' . a:bg . ' cterm=' a:style
endfunction

function! s:clear(group)
  execute 'hi! clear ' . a:group
endfunction

call s:hiEx('Normal', s:cForeground, s:cBackground)
call s:hiEx('Bold', 'NONE', 'NONE', 'bold')
call s:hiEx('Italic', 'NONE', 'NONE', 'italic')
call s:hiEx('Underlined', 'NONE', 'NONE', 'underline')

call s:hiEx('Visual', s:cForeground, s:cGreen)

call s:hiEx('SignColumn', s:cMidtone0, s:cBackground)
call s:hiEx('ColorColumn', 'NONE', s:cMidtone0)
call s:hi('LineNr', s:cMidtone1)

call s:clear('CursorLineNr')
call s:hiEx('CursorLine', 'NONE', 'NONE', 'NONE')
call s:hiEx('CursorLineNr', s:cMidtone3, 'NONE', 'NONE')
call s:hiEx('CursorLineSign', 'NONE', 'NONE')

call s:link('Directory', 'Type')

call s:hiEx('WinBar', 'NONE', s:cMidtone3)
call s:hiEx('WinSeparator', 'NONE', s:cFaded)
call s:hiEx('Todo', s:cForeground, 'NONE', 'bold')
call s:link('Title', 'Type')
call s:clear('Question')
call s:clear('NonText')

call s:hiEx('Pmenu', s:cForeground, s:cMidtone0)
call s:hiEx('PmenuSel', s:cForeground, s:cMidtone1)
call s:hiEx('PmenuSBar', 'NONE', s:cMidtone1)
call s:hiEx('PmenuThumb', s:cMidtone3, s:cMidtone2)
call s:link('NormalFloat', 'Pmenu')

call s:hiEx('SpellBad', s:cRed, 'NONE', 'underline')
call s:hiEx('SpellCap', s:cForeground, 'NONE')
call s:hiEx('SpellLocal', s:cForeground, 'NONE')
call s:hiEx('SpellRare', s:cForeground, 'NONE')

call s:link('VertSplit', 'WinSeparator')
call s:hi('EndOfBuffer', s:cMidtone1)

call s:hiEx('StatusLineNC', s:cMidtone3, s:cFaded)
call s:hiEx('StatusLine', s:cForeground, s:cMidtone0)

call s:hiEx('Tabline', s:cForeground, s:cFaded)
call s:hiEx('TablineSel', s:cForeground, s:cMidtone0)
call s:hiEx('TablineFill', s:cForeground, s:cBackground)

call s:hi('Folded', s:cBlue)
call s:hi('FoldColumn', s:cBlue)

call s:hiEx('Identifier', s:gIdentifier, 'NONE')

call s:clear('Delimiter')
call s:clear('Operator')
call s:clear('Special')
call s:hiEx('SpecialKey', s:cLightOrange, s:cMidtone0)

call s:hi('Function', s:gFunction)

call s:hi('Keyword', s:gKeyword)
call s:link('Conditional', 'Keyword')
call s:link('Statement', 'Keyword')
call s:link('Repeat', 'Keyword')
call s:link('Exception', 'Keyword')
call s:link('StorageClass', 'Keyword')

call s:hiEx('WildMenu', s:cForeground, s:cMidtone1)
call s:hiEx('Search', s:cBackground, s:cLightOrange)
call s:link('IncSearch', 'Search')

call s:hiEx('DiffAdd', s:cLightGreen, s:cMidtone0, 'NONE')
call s:hiEx('DiffChange', s:cLightOrange,s:cMidtone0, 'NONE')
call s:hiEx('DiffDelete', s:cLightRed, s:cMidtone0, 'NONE')
call s:hiEx('DiffText', s:gNumber, s:cMidtone0, 'NONE')
call s:link('Added', 'DiffAdd')
call s:link('Changed', 'DiffChange')
call s:link('Removed', 'DiffDelete')

call s:hi('MoreMsg', s:cMidtone3)
call s:hi('WarningMsg', s:cLightOrange)
call s:hi('ErrorMsg', s:cRed)
call s:hi('Error', s:cRed)

call s:hi('Number', s:gNumber)
call s:hi('Constant', s:gConstant)
call s:hi('Boolean', s:gType)
call s:hi('Type', s:gType)
call s:hi('String', s:gString)
call s:hi('Comment', s:gComment)
call s:hi('PreProc', s:gPreProc)
call s:hi('Label', s:gIdentifier)

" Neovim-only section
if has('nvim')
  call s:hi('DiagnosticError', s:cRed)
  call s:hi('DiagnosticWarn', s:cLightOrange)
  call s:hi('DiagnosticInfo', s:cMidtone3)
  call s:hi('DiagnosticHint', s:cMidtone3)
  call s:hi('DiagnosticOk', s:cLightGreen)

  call s:link('@type.builtin', 'Type')
  call s:link('@keyword.modifier.cpp', 'Type')
  call s:link('@keyword.type', 'Type')
  call s:link('@constant.builtin', 'Keyword')

  if s:telescopeIntegration
    call s:hiEx('TelescopeNormal', s:cForeground, s:cBackground, 'NONE')
    call s:hiEx('TelescopePromptBorder', s:cForeground, s:cBackground, 'NONE')
    call s:hiEx('TelescopeResultsBorder', s:cForeground, s:cBackground, 'NONE')
    call s:hiEx('TelescopePreviewBorder', s:cForeground, s:cBackground, 'NONE')
    call s:hiEx('TelescopeSelection', s:cForeground, s:cBackground, 'NONE')
    call s:hiEx('TelescopeMultiSelection', s:cForeground, s:cBackground, 'bold')
    call s:hiEx('TelescopeMatching', s:cLightOrange, s:cBackground, 'bold')
    call s:hiEx('TelescopePromptPrefix', s:cForeground, s:cBackground, 'NONE')
  endif
endif

