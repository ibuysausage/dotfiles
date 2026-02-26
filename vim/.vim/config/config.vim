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
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
