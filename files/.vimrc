syntax enable
set termguicolors
hi Normal guibg=NONE ctermbg=NONE

nnoremap ,<space> :CHADopen<CR>
nnoremap <space>x :wq!<CR>

let g:indentLine_color_gui = '#ea4c88'
let g:indentLine_char = '⏽ '

set noshowmode

hi EndOfBuffer guifg=bg guibg=bg
hi LineNr guibg=bg
set foldcolumn=2
hi foldcolumn guibg=bg
hi VertSplit guibg=#302d38 guifg=#302d38
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg

colorscheme nord
syntax on
set number
set ruler
set showmatch
set sw=4
set tabstop=4
set copyindent
set ignorecase
set smartcase
