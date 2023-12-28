" if exists("b:current_syntax")
" 	finish
" endif

syn match C3_Function    display "\zs\(\w*\)*\s*\ze("
syn match C3_Identifier  display "\v<_*[a-z][A-Za-z0-9_]*>"
syn match C3_Attribute   display "\v\@<_*[A-Z][A-Za-z0-9_]*>"
syn match C3_UserType    display "_*[A-Z][a-zA-Z0-9_]\+"
syn match C3_GlobalConst display "_*[A-Z][A-Z0-9_]\+"

syn match C3_Number display "\v<0[Xx][0-9A-Fa-f](_*[0-9A-Fa-f])*>"
syn match C3_Number display "\v<0[Oo][0-7](_*[0-7])*>"
syn match C3_Number display "\v<0[Bb][01](_*[01])*>"
syn match C3_Number display "\v<[0-9](_*[0-9])*([iu](8|16|32|64|128)|([Uu][Ll]?|[Ll]))?>"

syn match C3_Float display "\v<[0-9](_*[0-9])*[Ee][+-]?[0-9]+(f(8|16|32|64|128))?>"
syn match C3_Float display "\v<0[Xx][0-9A-Fa-f](_*[0-9A-Fa-f])*[Pp][+-]?[0-9]+(f(8|16|32|64|128))?>"
syn match C3_Float display "\v<[0-9](_*[0-9])*\.[0-9](_*[0-9])*([Ee][+-]?[0-9]+)?(f(8|16|32|64|128))?>"
syn match C3_Float display "\v<0[Xx][0-9A-Fa-f](_*[0-9A-Fa-f])*\.[0-9A-Fa-f](_*[0-9A-Fa-f])*([Pp][+-]?[0-9]+)?(f(8|16|32|64|128))?>"

syn match C3_Operator display "\v\.\.\.?"
syn match C3_Operator display "\v(\<\<|\>\>|[<>=!+*/%&~^|-])\=?"
syn match C3_Operator display "\v\+\+|--|\&\&|\|\||\?\?|::|\?:|\=>|[\[]<|>[\]]|\$\$"

syn match C3_Delimiter display "\v[;,:\{\}\(\)\[\].?]"

syn match C3_HexBytes "\v<x'([ \f\n\t\v]?[0-9A-Fa-f][ \f\n\t\v0-9A-Fa-f]+)+'"
syn match C3_HexBytes "\v<x\"([ \f\n\t\v]?[0-9A-Fa-f][ \f\n\t\v0-9A-Fa-f]+)+\""
syn match C3_HexBytes "\v<x`([ \f\n\t\v]?[0-9A-Fa-f][ \f\n\t\v0-9A-Fa-f]+)+`"

syn match C3_Base64 "\v<b64'([ \f\n\t\v]?[A-Za-z0-9+/][ \f\n\t\vA-Za-z0-9+/]+)+(\=|\=\=)?'"
syn match C3_Base64 "\v<b64\"([ \f\n\t\v]?[A-Za-z0-9+/][ \f\n\t\vA-Za-z0-9+/]+)+(\=|\=\=)?\""
syn match C3_Base64 "\v<b64`([ \f\n\t\v]?[A-Za-z0-9+/][ \f\n\t\vA-Za-z0-9+/]+)+(\=|\=\=)?`"

syn match C3_String "\v\"(\\.|[^\\\"])*\""
syn match C3_String "\v`(``|.)*`"

" TODO: Comment nesting
syntax match C3_Comment display "\v//.*"

syntax region C3_MultiComment matchgroup=C3_Comment
      \ start="\v/\*"
      \ end="\v\*/"

syn keyword C3_Keyword
      \ if else
      \ try catch
      \ defer return
      \ switch case nextcase default
      \ cast asm
      \ def fn enum macro fault struct bitstruct
      \ module import

syn keyword C3_Repeat
      \ do while while 
      \ for foreach foreach_r
      \ continue break


syn keyword C3_Specifier extern inline static tlocal
syn keyword C3_Specifier var const

syn keyword C3_BuiltinType typeid errtype void any anyfault
syn keyword C3_BuiltinType bool char short int long int128 isz
syn keyword C3_BuiltinType char short int long int128 usz isz
syn keyword C3_BuiltinType float16 float double float128

syn keyword C3_Null null
syn keyword C3_Boolean true false
" attribute
" generic
" assert

syn match C3_BuiltinAttr "\v\@align"
syn match C3_BuiltinAttr "\v\@benchmark"
syn match C3_BuiltinAttr "\v\@bigendian"
syn match C3_BuiltinAttr "\v\@builtin"
syn match C3_BuiltinAttr "\v\@callconv"
syn match C3_BuiltinAttr "\v\@deprecated"
syn match C3_BuiltinAttr "\v\@dynamic"
syn match C3_BuiltinAttr "\v\@export"
syn match C3_BuiltinAttr "\v\@extern"
syn match C3_BuiltinAttr "\v\@if"
syn match C3_BuiltinAttr "\v\@inline"
syn match C3_BuiltinAttr "\v\@interface"
syn match C3_BuiltinAttr "\v\@littleendian"
syn match C3_BuiltinAttr "\v\@local"
syn match C3_BuiltinAttr "\v\@maydiscard"
syn match C3_BuiltinAttr "\v\@naked"
syn match C3_BuiltinAttr "\v\@nodiscard"
syn match C3_BuiltinAttr "\v\@noinit"
syn match C3_BuiltinAttr "\v\@noreturn"
syn match C3_BuiltinAttr "\v\@nostrip"
syn match C3_BuiltinAttr "\v\@obfuscate"
syn match C3_BuiltinAttr "\v\@operator"
syn match C3_BuiltinAttr "\v\@overlap"
syn match C3_BuiltinAttr "\v\@priority"
syn match C3_BuiltinAttr "\v\@private"
syn match C3_BuiltinAttr "\v\@public"
syn match C3_BuiltinAttr "\v\@pure"
syn match C3_BuiltinAttr "\v\@reflect"
syn match C3_BuiltinAttr "\v\@section"
syn match C3_BuiltinAttr "\v\@test"
syn match C3_BuiltinAttr "\v\@used"
syn match C3_BuiltinAttr "\v\@unused"


hi def link C3_Number Number
hi def link C3_Float Number

hi def link C3_Identifier Identifier

hi def link C3_UserAttr Special
hi def link C3_BuiltinAttr Special

hi def link C3_Function Function

hi def link C3_BuiltinType Type
hi def link C3_UserType Type

hi def link C3_Keyword Keyword
hi def link C3_Repeat Repeat

hi def link C3_Boolean Boolean
hi def link C3_Null Boolean

hi def link C3_Specifier StorageClass " I believe `Type` would make more sense but this is more consistent with C
hi def link C3_GlobalConst Constant

hi def link C3_String   String
hi def link C3_HexBytes String
hi def link C3_Base64   String

hi def link C3_Operator Operator
hi def link C3_Delimiter Delimiter

hi def link C3_Comment      Comment
hi def link C3_MultiComment Comment

let b:current_syntax = "c3"

