if exists("b:current_syntax")
	finish
endif

syn match fclKeyword  display "\v<[A-Z_]+>"
syn match fclFloat    display "\v<[0-9](_*[0-9])*[Ee][+-]?[0-9]+>"
syn match fclFloat    display "\v<[0-9](_*[0-9])*\.[0-9](_*[0-9])*([Ee][+-]?[0-9]+)?>"
syn match fclInt      display "\v<[0-9]+>"
syn region fclComment display start="\v//"    end="\v$"

hi def link fclKeyword Keyword
hi def link fclFloat   Number
hi def link fclInt     Number
hi def link fclComment Comment

let b:current_syntax="fcl"
