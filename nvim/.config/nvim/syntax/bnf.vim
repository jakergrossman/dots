syn match bnfAssignOp /::=/
syn match bnfNonTerminal /<[a-zA-Z0-9_]\+>/
syn match bnfComment /\/\/.*/
syn match bnfEolWs /\s\+$/

hi! link bnfAssignOp Function
hi! link bnfNonTerminal Conditional
hi! link bnfComment Comment
hi! link bnfEolWs Error
