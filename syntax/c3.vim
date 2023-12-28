" Decimal
syntax match C3_Dec display "\<\d\+"
" Hex
syntax match C3_Hex display "\<0x[0-9a-fA-F][0-9a-fA-F_]\+"
" Octal
syntax match C3_Oct display "\<0o[0-7][0-7_]\+"
" Bin
syntax match C3_Bin display "\<0b[0-1][0-1_]\+"
" Float (dot)
syntax match C3_Float display "\<\d\+\.\d\+"
" Float (dot, optional exponent)
syntax match C3_Float display "\<\d\+\.\d\+\%(e[+-]\?\d\+\)"
" Float (exponent)
syntax match C3_Float display "\<\d\+\%(e[+-]\?\d\+\)"

syntax keyword C3_Keyword module import def var
syntax keyword C3_Keyword defer return continue break
syntax keyword C3_Keyword if else for foreach while do
syntax keyword C3_Keyword switch case
syntax keyword C3_Keyword static distinct extern tlocal inline
syntax keyword C3_Keyword try catch assert
syntax keyword C3_Keyword fn
syntax keyword C3_Keyword macro
syntax keyword C3_Keyword struct enum union fault
syntax keyword C3_Boolean true false
syntax keyword C3_Null    null

syntax keyword C3_BuiltinType char short int long
syntax match C3_UserType display "_*[A-Z][a-zA-Z0-9_]\+"

syntax match C3_GlobalConst display "_*[A-Z][A-Z0-9_]\+"

syntax match C3_Comment  display "//.*"

" TODO: Comment nesting
syntax region C3_MultiComment matchgroup=C3_Comment
      \ start="/\*"
      \ end="\*/"

syntax match C3_Function display "\zs\(\w*\)*\s*\ze("

" TODO: multi-line string
syntax match C3_String    display "\".*\""
syntax match C3_String64  display "b64\".*\""
syntax match C3_String16  display "x\".*\""
syntax match C3_StringRaw display "`.*`"

syntax match C3_Module contained display "\w\+"

hi def link C3_Float Number
hi def link C3_Dec   Number
hi def link C3_Hex   Number
hi def link C3_Oct   Number
hi def link C3_Bin   Number

hi def link C3_Function Function

hi def link C3_Keyword Keyword
hi def link C3_Boolean Boolean
hi def link C3_Null    Boolean

hi def link C3_BuiltinType Type
hi def link C3_UserType    Type

hi def link C3_GlobalConst Constant

hi def link C3_String    String
hi def link C3_String64  String
hi def link C3_String16  String
hi def link C3_StringRaw String

hi def link C3_Comment Comment
hi def link C3_MultiComment Comment

