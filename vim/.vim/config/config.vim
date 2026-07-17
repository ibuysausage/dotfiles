" Basic vim configuration

filetype plugin indent on
syntax on
set number
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent
set backspace=indent,eol,start
set cursorcolumn
set encoding=UTF-8

if &term =~ '^xterm\|rxvt'
    " solid underscore
    let &t_SI .= "\<Esc>[4 q"
    " solid block
    let &t_EI .= "\<Esc>[2 q"
    " 1 or 0 -> blinking block
    " 3 -> blinking underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
endif
if &term =~ "xterm"
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
endif
