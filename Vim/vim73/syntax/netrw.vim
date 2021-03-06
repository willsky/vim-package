" Language   : Netrw Remote-Directory Listing Syntax
" Maintainer : Charles E. Campbell, Jr.
" Last change: Jan 14, 2009
" Version    : 16
" ---------------------------------------------------------------------

" Syntax Clearing: {{{1
if version < 600
 syntax clear
elseif exists("b:current_syntax")
 finish
endif

" ---------------------------------------------------------------------
" Directory List Syntax Highlighting: {{{1
syn cluster NetrwGroup		contains=netrwHide,netrwSortBy,netrwSortSeq,netrwQuickHelp,netrwVersion,netrwCopyTgt
syn cluster NetrwTreeGroup	contains=netrwDir,netrwSymLink,netrwExe

syn match  netrwPlain		"\(\S\+ \)*\S\+"					contains=@NoSpell
syn match  netrwSpecial		"\%(\S\+ \)*\S\+[*|=]\ze\%(\s\{2,}\|$\)"		contains=netrwClassify,@NoSpell
syn match  netrwDir		"\.\{1,2}/"						contains=netrwClassify,@NoSpell
syn match  netrwDir		"\%(\S\+ \)*\S\+/"					contains=netrwClassify,@NoSpell
syn match  netrwSizeDate	"\<\d\+\s\d\{1,2}/\d\{1,2}/\d\{4}\s"	skipwhite	contains=netrwDateSep,@NoSpell	nextgroup=netrwTime
syn match  netrwSymLink		"\%(\S\+ \)*\S\+@\ze\%(\s\{2,}\|$\)"  			contains=netrwClassify,@NoSpell
syn match  netrwExe		"\%(\S\+ \)*\S\+\*\ze\%(\s\{2,}\|$\)" 			contains=netrwClassify,@NoSpell
syn match  netrwTreeBar		"^\%([-+|] \)\+"					contains=netrwTreeBarSpace	nextgroup=@netrwTreeGroup
syn match  netrwTreeBarSpace	" "					contained

syn match  netrwClassify	"[*=|@/]\ze\%(\s\{2,}\|$\)"		contained
syn match  netrwDateSep		"/"					contained
syn match  netrwTime		"\d\{1,2}:\d\{2}:\d\{2}"		contained	contains=netrwTimeSep
syn match  netrwTimeSep		":"

syn match  netrwComment		'".*\%(\t\|$\)'						contains=@NetrwGroup,@NoSpell
syn match  netrwHide		'^"\s*\(Hid\|Show\)ing:'	skipwhite		contains=@NoSpell		nextgroup=netrwHidePat
syn match  netrwSlash		"/"				contained
syn match  netrwHidePat		"[^,]\+"			contained skipwhite	contains=@NoSpell		nextgroup=netrwHideSep
syn match  netrwHideSep		","				contained skipwhite					nextgroup=netrwHidePat
syn match  netrwSortBy		"Sorted by"			contained transparent skipwhite				nextgroup=netrwList
syn match  netrwSortSeq		"Sort sequence:"		contained transparent skipwhite			 	nextgroup=netrwList
syn match  netrwCopyTgt		"Copy/Move Tgt:"		contained transparent skipwhite				nextgroup=netrwList
syn match  netrwList		".*$"				contained		contains=netrwComma,@NoSpell
syn match  netrwComma		","				contained
syn region netrwQuickHelp	matchgroup=Comment start="Quick Help:\s\+" end="$"	contains=netrwHelpCmd,@NoSpell	keepend contained
syn match  netrwHelpCmd		"\S\ze:"			contained skipwhite	contains=@NoSpell		nextgroup=netrwCmdSep
syn match  netrwCmdSep		":"				contained nextgroup=netrwCmdNote
syn match  netrwCmdNote		".\{-}\ze  "			contained		contains=@NoSpell
syn match  netrwVersion		"(netrw.*)"			contained		contains=@NoSpell

" -----------------------------
" Special filetype highlighting {{{1
" -----------------------------
if exists("g:netrw_special_syntax") && netrw_special_syntax
 syn match netrwBak		"\(\S\+ \)*\S\+\.bak\>"				contains=netrwTreeBar,@NoSpell
 syn match netrwCompress	"\(\S\+ \)*\S\+\.\%(gz\|bz2\|Z\|zip\)\>"	contains=netrwTreeBar,@NoSpell
 if has("unix")
  syn match netrwCoreDump	"\<core\%(\.\d\+\)\=\>"				contains=netrwTreeBar,@NoSpell
 endif
 syn match netrwData		"\(\S\+ \)*\S\+\.dat\>"				contains=netrwTreeBar,@NoSpell
 syn match netrwHdr		"\(\S\+ \)*\S\+\.h\>"				contains=netrwTreeBar,@NoSpell
 syn match netrwLib		"\(\S\+ \)*\S*\.\%(a\|so\|lib\|dll\)\>"		contains=netrwTreeBar,@NoSpell
 syn match netrwMakeFile	"\<[mM]akefile\>\|\(\S\+ \)*\S\+\.mak\>"	contains=netrwTreeBar,@NoSpell
 syn match netrwObj		"\(\S\+ \)*\S*\.\%(o\|obj\)\>"			contains=netrwTreeBar,@NoSpell
 syn match netrwTags    	"\<tags\>"					contains=netrwTreeBar,@NoSpell
 syn match netrwTags		"\<\(ANmenu\|ANtags\)\>"			contains=netrwTreeBar,@NoSpell
 syn match netrwTilde		"\(\S\+ \)*\S\+\~\>"				contains=netrwTreeBar,@NoSpell
 syn match netrwTmp		"\<tmp\(\S\+ \)*\S\+\>\|\(\S\+ \)*\S*tmp\>"	contains=netrwTreeBar,@NoSpell
endif

" ---------------------------------------------------------------------
" Highlighting Links: {{{1
if !exists("did_drchip_netrwlist_syntax")
 let did_drchip_netrwlist_syntax= 1
 hi default link netrwClassify	Function
 hi default link netrwCmdSep	Delimiter
 hi default link netrwComment	Comment
 hi default link netrwDir	Directory
 hi default link netrwHelpCmd	Function
 hi default link netrwHidePat	Statement
 hi default link netrwHideSep	netrwComment
 hi default link netrwList	Statement
 hi default link netrwVersion	Identifier
 hi default link netrwSymLink	Question
 hi default link netrwExe	PreProc
 hi default link netrwDateSep	Delimiter

 hi default link netrwTreeBar	Special
 hi default link netrwTimeSep	netrwDateSep
 hi default link netrwComma	netrwComment
 hi default link netrwHide	netrwComment
 hi default link netrwMarkFile	Identifier

 " special syntax highlighting (see :he g:netrw_special_syntax)
 hi default link netrwBak	NonText
 hi default link netrwCompress	Folded
 hi default link netrwCoreDump	WarningMsg
 hi default link netrwData	DiffChange
 hi default link netrwLib	DiffChange
 hi default link netrwMakefile	DiffChange
 hi default link netrwObj	Folded
 hi default link netrwTilde	Folded
 hi default link netrwTmp	Folded
 hi default link netrwTags	Folded
endif

" Current Syntax: {{{1
let   b:current_syntax = "netrwlist"
" ---------------------------------------------------------------------
" vim: ts=8 fdm=marker
