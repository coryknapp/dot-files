" This is a modification. Original found at https://github.com/jamak/dotvim
" generated by feeding the original into the script at
" github.com/coryknapp/vim-color-analyzer and then modifying the results.

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "television"

let s:c_normalfg = "guifg=#c2b790 "
let s:c_normalbg = "guibg=#1f2433 "

" the following highlighting is used by :
"	IncSearch
let s:cs_IncSearch =
			\ "ctermfg=17 ctermbg=143 cterm=NONE guifg=#1f2433 guibg=#bab972 gui=NONE"


" the following highlighting is used by :
"	Special
"		Special include, possibly among other things, keywords, the keywords within
"		comments (javadoc for example.)
"	rubyConstant
"	rubyRailsUserClass
let s:cs_Special = "ctermfg=144 ctermbg=NONE cterm=NONE guifg=#3399FF guibg=NONE gui=NONE"


" the following highlighting is used by :
"	cssPseudoClassId
let s:cs_cssPseudoClassId = "ctermfg=66 ctermbg=NONE cterm=NONE guifg=#60827e guibg=NONE gui=NONE"


" the following highlighting is used by :
"	DiffChange
let s:cs_DiffChange = "ctermfg=144 ctermbg=23 cterm=NONE ".s:c_normalfg."guibg=#20375d gui=NONE"


" the following highlighting is used by :
"	Visual
"	PmenuSel
let s:cs_Visual = "ctermfg=NONE ctermbg=23 cterm=NONE guifg=NONE guibg=#1b324a gui=NONE"

" the following highlighting is used by :
"	Type
let s:cs_Type = "ctermfg=67 ctermbg=NONE cterm=NONE guifg=#6b84a3 guibg=NONE gui=NONE"


" the following highlighting is used by :
"	ErrorMsg
"	WarningMsg
let s:cs_ErrorMsg = "ctermfg=15 ctermbg=88 cterm=NONE guifg=#ffffff guibg=#990000 gui=NONE"


" the following highlighting is used by :
"	Normal
let s:cs_Normal = "ctermfg=144 ctermbg=17 cterm=NONE ".s:c_normalfg.s:c_normalbg."gui=NONE"

" the following highlighting is used by :
"	CursorLine
"	CursorColumn
"	ColorColumn
let s:cs_CursorLine = "ctermfg=NONE ctermbg=23 cterm=NONE guifg=NONE guibg=#2f333c gui=NONE"


" the following highlighting is used by :
"	Pmenu
"	rubyInterpolationDelimiter
"	rubyClassVariable
"	erubyDelimiter
"	javaScriptBraces
"	cssBraces
let s:cs_Pmenu = "ctermfg=17 ctermbg=144 cterm=NONE guifg=#1f2433 guibg=#c2b790 gui=NONE"


" the following highlighting is used by :
"	Folded
let s:cs_Folded = "ctermfg=242 ctermbg=17 cterm=NONE guifg=#696969 ".s:c_normalbg."gui=NONE"


" the following highlighting is used by :
"	Title
let s:cs_Title = "ctermfg=144 ctermbg=NONE cterm=bold ".s:c_normalfg."guibg=NONE gui=bold"


" the following highlighting is used by :
"	Directory
"	Character
"	Conditional
"	Constant
"	Define
"	Float
"	Keyword
"	Number
"	Operator
"	PreProc
"	Statement
"	StorageClass
"	rubyClass
"	rubySymbol
"	rubyInclude
"	rubyControl
"	rubyOperator
"	rubyException
"	htmlSpecialChar
"	javaScriptFunction
"	cssColor
"	cssValueLength
let s:cs_Directory = "ctermfg=131 ctermbg=NONE cterm=NONE guifg=#cc0033 guibg=NONE gui=NONE"

" the following highlighting is used by :
"	Identifier
let s:cs_Identifier = "ctermfg=131 ctermbg=NONE cterm=NONE guifg=#66cc99 guibg=NONE gui=NONE"

" the following highlighting is used by :
"	LineNr
let s:cs_LineNr = "ctermfg=59 ctermbg=23 cterm=NONE guifg=#716e62 guibg=#2f333c gui=NONE"


" the following highlighting is used by :
"	Search
"	Underlined
let s:cs_Search = "ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline"


" the following highlighting is used by :
"	rubyEscape
let s:cs_rubyEscape = "ctermfg=179 ctermbg=NONE cterm=NONE guifg=#e8bf6a guibg=NONE gui=NONE"


" the following highlighting is used by :
"	Function
"	rubyFunction
let s:cs_Function = "ctermfg=179 ctermbg=NONE cterm=NONE guifg=#dea050 guibg=NONE gui=NONE"


" the following highlighting is used by :
"	StatusLine
let s:cs_StatusLine = "ctermfg=144 ctermbg=239 cterm=bold ".s:c_normalfg."guibg=#4e4f4e gui=bold"


" the following highlighting is used by :
"	Todo
let s:cs_Todo = "ctermfg=242 ctermbg=NONE cterm=inverse,bold guifg=#e600e5 guibg=NONE gui=inverse,bold"


" the following highlighting is used by :
"	DiffDelete
let s:cs_DiffDelete = "ctermfg=88 ctermbg=NONE cterm=NONE guifg=#89070a guibg=NONE gui=NONE"


" the following highlighting is used by :
"	cssCommonAttr
let s:cs_cssCommonAttr = "ctermfg=131 ctermbg=NONE cterm=NONE guifg=#a94d37 guibg=NONE gui=NONE"


" the following highlighting is used by :
"	rubyInstanceVariable
"	rubyGlobalVariable
"	rubyPseudoVariable
"	yamlAnchor
"	yamlAlias
let s:cs_rubyInstanceVariable = "ctermfg=168 ctermbg=NONE cterm=NONE guifg=#e64976 guibg=NONE gui=NONE"


" the following highlighting is used by :
"	cssClassName
let s:cs_cssClassName = "ctermfg=74 ctermbg=NONE cterm=NONE guifg=#38add8 guibg=NONE gui=NONE"


" the following highlighting is used by :
"	MatchParen
let s:cs_MatchParen = "ctermfg=131 ctermbg=NONE cterm=underline guifg=#c24d43 guibg=NONE gui=underline"


" the following highlighting is used by :
"	Boolean
let s:cs_Boolean = "ctermfg=166 ctermbg=NONE cterm=NONE guifg=#db592e guibg=NONE gui=NONE"


" the following highlighting is used by :
"	DiffAdd
let s:cs_DiffAdd = "ctermfg=144 ctermbg=64 cterm=bold ".s:c_normalfg."guibg=#45820f gui=bold"


" the following highlighting is used by :
"	Comment
"	erubyComment
let s:cs_Comment = "ctermfg=242 ctermbg=NONE cterm=NONE guifg=#696969 guibg=NONE gui=NONE"


" the following highlighting is used by :
"	rubyRailsARAssociationMethod
"	rubyRailsARMethod
"	rubyRailsRenderMethod
"	rubyRailsMethod
"	erubyRailsMethod
"	javaScriptRailsFunction
"	cssFunctionName
let s:cs_rubyRailsARAssociationMethod = "ctermfg=59 ctermbg=NONE cterm=NONE guifg=#5c644c guibg=NONE gui=NONE"


" the following highlighting is used by :
"	Tag
"	htmlTag
"	htmlEndTag
"	htmlTagName
"	htmlArg
"	yamlKey
let s:cs_Tag = "ctermfg=137 ctermbg=NONE cterm=NONE guifg=#a87b60 guibg=NONE gui=NONE"


" the following highlighting is used by :
"	SpecialKey
let s:cs_SpecialKey = "ctermfg=250 ctermbg=23 cterm=NONE guifg=#bfbfbf guibg=#2f333c gui=NONE"


" the following highlighting is used by :
"	VertSplit
let s:cs_VertSplit = "ctermfg=239 ctermbg=239 cterm=NONE guifg=#4e4f4e guibg=#4e4f4e gui=NONE"


" the following highlighting is used by :
"	Label
"	String
"	rubyStringDelimiter
"	rubyRegexp
"	rubyRegexpDelimiter
let s:cs_Label = "ctermfg=143 ctermbg=NONE cterm=NONE guifg=#FFCC33 guibg=NONE gui=NONE"


" the following highlighting is used by :
"	StatusLineNC
let s:cs_StatusLineNC = "ctermfg=144 ctermbg=239 cterm=NONE ".s:c_normalfg."guibg=#4e4f4e gui=NONE"


" the following highlighting is used by :
"	Cursor
let s:cs_Cursor = "ctermfg=17 ctermbg=137 cterm=NONE guifg=#1f2433 guibg=#a89770 gui=NONE"


" the following highlighting is used by :
"	DiffText
let s:cs_DiffText = "ctermfg=144 ctermbg=24 cterm=bold ".s:c_normalfg."guibg=#204a87 gui=bold"


" the following highlighting is used by :
"	yamlDocumentHeader
let s:cs_yamlDocumentHeader = "ctermfg=144 ctermbg=234 cterm=NONE guifg=#b9aa99 guibg=#1d1d1d gui=NONE"


" the following highlighting is used by :
"	rubyBlockParameter
"	cssURL
let s:cs_rubyBlockParameter = "ctermfg=66 ctermbg=NONE cterm=NONE guifg=#6d948d guibg=NONE gui=NONE"


" the following highlighting is used by :
"	NonText
let s:cs_NonText = "ctermfg=250 ctermbg=17 cterm=NONE guifg=#bfbfbf guibg=#272b38 gui=NONE"





" Start of highlight groups...



exec "hi Cursor ".s:cs_Cursor
exec "hi Visual ".s:cs_Visual
exec "hi CursorLine ".s:cs_CursorLine
exec "hi CursorColumn ".s:cs_CursorLine
exec "hi ColorColumn ".s:cs_CursorLine
exec "hi LineNr ".s:cs_LineNr
exec "hi VertSplit ".s:cs_VertSplit
exec "hi MatchParen ".s:cs_MatchParen
exec "hi StatusLine ".s:cs_StatusLine
exec "hi StatusLineNC ".s:cs_StatusLineNC
exec "hi Pmenu ".s:cs_Pmenu
exec "hi PmenuSel ".s:cs_Visual
exec "hi IncSearch ".s:cs_IncSearch
exec "hi Search ".s:cs_Search
exec "hi Directory ".s:cs_Directory
exec "hi Folded ".s:cs_Folded


exec "hi Normal ".s:cs_Normal
exec "hi Boolean ".s:cs_Boolean
exec "hi Character ".s:cs_Directory
exec "hi Comment ".s:cs_Comment
exec "hi Conditional ".s:cs_Directory
exec "hi Constant ".s:cs_Directory
exec "hi Define ".s:cs_Directory
exec "hi DiffAdd ".s:cs_DiffAdd
exec "hi DiffDelete ".s:cs_DiffDelete
exec "hi DiffChange ".s:cs_DiffChange
exec "hi DiffText ".s:cs_DiffText
exec "hi ErrorMsg ".s:cs_ErrorMsg
exec "hi WarningMsg ".s:cs_ErrorMsg
exec "hi Float ".s:cs_Directory
exec "hi Function ".s:cs_Function
exec "hi Identifier ".s:cs_Identifier
exec "hi Keyword ".s:cs_Directory
exec "hi Label ".s:cs_Label
exec "hi NonText ".s:cs_NonText
exec "hi Number ".s:cs_Directory
exec "hi Operator ".s:cs_Directory
exec "hi PreProc ".s:cs_Directory
exec "hi Special ".s:cs_Special
exec "hi SpecialKey ".s:cs_SpecialKey

" Statement
" examples in c++: return,
exec "hi Statement ".s:cs_Directory
exec "hi StorageClass ".s:cs_Directory
exec "hi String ".s:cs_Label
exec "hi Tag ".s:cs_Tag
exec "hi Title ".s:cs_Title
exec "hi Todo ".s:cs_Todo
exec "hi Type ".s:cs_Type
exec "hi Underlined ".s:cs_Search
exec "hi rubyClass ".s:cs_Directory
exec "hi rubyFunction ".s:cs_Function
exec "hi rubyInterpolationDelimiter ".s:cs_Pmenu
exec "hi rubySymbol ".s:cs_Directory
exec "hi rubyConstant ".s:cs_Special
exec "hi rubyStringDelimiter ".s:cs_Label
exec "hi rubyBlockParameter ".s:cs_rubyBlockParameter
exec "hi rubyInstanceVariable ".s:cs_rubyInstanceVariable
exec "hi rubyInclude ".s:cs_Directory
exec "hi rubyGlobalVariable ".s:cs_rubyInstanceVariable
exec "hi rubyRegexp ".s:cs_Label
exec "hi rubyRegexpDelimiter ".s:cs_Label
exec "hi rubyEscape ".s:cs_rubyEscape
exec "hi rubyControl ".s:cs_Directory
exec "hi rubyClassVariable ".s:cs_Pmenu
exec "hi rubyOperator ".s:cs_Directory
exec "hi rubyException ".s:cs_Directory
exec "hi rubyPseudoVariable ".s:cs_rubyInstanceVariable
exec "hi rubyRailsUserClass ".s:cs_Special
exec "hi rubyRailsARAssociationMethod ".s:cs_rubyRailsARAssociationMethod
exec "hi rubyRailsARMethod ".s:cs_rubyRailsARAssociationMethod
exec "hi rubyRailsRenderMethod ".s:cs_rubyRailsARAssociationMethod
exec "hi rubyRailsMethod ".s:cs_rubyRailsARAssociationMethod
exec "hi erubyDelimiter ".s:cs_Pmenu
exec "hi erubyComment ".s:cs_Comment
exec "hi erubyRailsMethod ".s:cs_rubyRailsARAssociationMethod
exec "hi htmlTag ".s:cs_Tag
exec "hi htmlEndTag ".s:cs_Tag
exec "hi htmlTagName ".s:cs_Tag
exec "hi htmlArg ".s:cs_Tag
exec "hi htmlSpecialChar ".s:cs_Directory
exec "hi javaScriptFunction ".s:cs_Directory
exec "hi javaScriptRailsFunction ".s:cs_rubyRailsARAssociationMethod
exec "hi javaScriptBraces ".s:cs_Pmenu
exec "hi yamlKey ".s:cs_Tag
exec "hi yamlAnchor ".s:cs_rubyInstanceVariable
exec "hi yamlAlias ".s:cs_rubyInstanceVariable
exec "hi yamlDocumentHeader ".s:cs_yamlDocumentHeader
exec "hi cssURL ".s:cs_rubyBlockParameter
exec "hi cssFunctionName ".s:cs_rubyRailsARAssociationMethod
exec "hi cssColor ".s:cs_Directory
exec "hi cssPseudoClassId ".s:cs_cssPseudoClassId
exec "hi cssClassName ".s:cs_cssClassName
exec "hi cssValueLength ".s:cs_Directory
exec "hi cssCommonAttr ".s:cs_cssCommonAttr
exec "hi cssBraces ".s:cs_Pmenu