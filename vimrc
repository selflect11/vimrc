"GENERAL settings{{{
" TODO: check if it's windows or not
set path=C:\Users\pvolpi\Google\\\ Drive\Concursos\**
set wildmenu
set wildmode=list:longest,full
" python config (cant believe this worked)
" TODO: I certainly should move it to the GDrive folder...
set pythonthreedll=C:\Users\pvolpi\AppData\Local\Programs\Python\Python37-32\python37.dll
set perldll=''
syntax on
let mapleader = ","
set t_Co=256
set number relativenumber
set listchars=tab:..,eol:$
set nohlsearch incsearch showmatch
set wrap
set showbreak=>>
set linebreak
set nobackup nowritebackup noundofile
set et tabstop=4 shiftwidth=4 softtabstop=4
set list
set vb noeb
set autoindent
set backspace=indent,eol,start
set list
set cm=blowfish2
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right scrollbar
set guioptions-=l  "remove left scrollbar
set splitbelow
set splitright
set lazyredraw      "only redraws screen at end of macro
set fillchars+=vert:\ " eliminates ulgyass '|' between splits
set guifont=DejaVu_Sans_Mono_for_Powerline:h14
set foldcolumn=0
" buffer settings
set hidden
" for dealing with this encoding BULLSHIT
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ff=unix
"viminfo motherfucker piece of shit
set viminfo+=n~/.viminfo
" all messages are abbreviations and truncated
set shortmess=at
set foldmethod=marker
set ignorecase
set smartcase
set foldlevelstart=0
set keymap=greek_utf-8
set iminsert=0  " this prevents the greek keyboard from being set on the fly
set textwidth=0
set shellslash
set iskeyword+=:
set smartindent
packadd! matchit

"}}}
" COLOR settings{{{
" color matching
" colorize the goddamned non-breaking spaces that some laws have
hi NonBreakingSpace guibg=#EEEEEE
" colorizing anki
hi ClozeOverlapper guibg=#39FF14 guifg=white
hi SimpleCloze guibg=#1E90FF guifg=white
hi AnkiClipboardHeader guibg=#FF2100 guifg=white
" colorizing right/wrong marks for exercises
hi RightMark guibg=green guifg=black
hi WrongMark guibg=red guifg=white

" praise the lord this worked...
" TODO: make the toggle function [low priority]
augroup custom_highlighting
    autocmd!
    autocmd BufWinEnter *  let w:m1 = matchadd("NonBreakingSpace", ' ', -1)
    autocmd BufWinEnter *  let w:m2 = matchadd("ClozeOverlapper", '\v\[\[oc\d+::\zs.{-}\ze\]\]', -1)
    autocmd BufWinEnter *  let w:m3 = matchadd("SimpleCloze", '\v\{\{c\d+::\zs.{-}\ze\}\}', -1)
    autocmd BufWinEnter *  let w:m4 = matchadd("AnkiClipboardHeader", '\v^\@anki-add.+$', -1)
augroup END

" pretty colors for gvim
hi LineNr guifg=#AAAAAA
hi CursorLineNr guifg=#0055FF
hi NonText guifg=gray
hi CursorLine guibg=MediumPurple1 guifg=white
hi Cursor guibg=magenta guifg=white
hi Search guibg=DeepPink1 guifg=white
hi IncSearch guibg=LightMagenta guifg=white gui=NONE
hi Visual guibg=red3 guifg=white
hi Folded guibg=gray guifg=white
"}}}

"KEYMAPS{{{

" tab literal
inoremap <Leader><TAB> <C-V><TAB>

" fixes umlaut
nnoremap <Leader>fu :%s/ü/u/g<CR>

" executes selected python code
vmap <C-P> :!py<CR>

" navigates paragraphs while keeping screen centered
nmap [[ {zz
nmap ]] }zz
" works
nmap <C-[> {zz
" doesnt work
nmap <C-]> }zz

" deletes whole WORD before cursor. works kinda bad
inoremap <C-E> <C-O>dB

" navigates paragraphs decently. God yes
nnoremap <silent> } /\v^$\n+\zs<CR>
nnoremap <silent> { ?\v^$\n+\zs<CR>
vnoremap <silent> } /\v^$\n+\zs<CR>
vnoremap <silent> { ?\v^$\n+\zs<CR>
onoremap <silent> } /\v^$\n+\zs<CR>
onoremap <silent> { ?\v^$\n+\zs<CR>
" goes to the start or the end of the paragraph
nnoremap <silent> ) :set nohlsearch<CR> /\v(^.+\zs\n+^$\|^$\n+\zs)<CR>
nnoremap <silent> ( ?\v(^.+\zs\n+^$\|^$\n+\zs)<CR>
vnoremap <silent> ) /\v(^.+\zs\n+^$\|^$\n+\zs)<CR>
noremap <silent> ( ?\v(^.+\zs\n+^$\|^$\n+\zs)<CR>
onoremap <silent> ) /\v(^.+\zs\n+^$\|^$\n+\zs)<CR>
onoremap <silent> ( ?\v(^.+\zs\n+^$\|^$\n+\zs)<CR>

" inserts newlines on normal mode
nmap <silent> <Leader>o mxo<Esc>´x
nmap <silent> <Leader>O mxO<Esc>´x
" deletes line above/below in normal mode
nmap <silent> do mx:+d<CR>´x
nmap <silent> dO :-d<CR>

" substitutes article or paragraph for quicker searching
cnoremap <Leader>ar Art.<Space>
cnoremap <Leader>pa §<Space>

" for replace in line
nnoremap Q :s/\v/g<Left><Left>
" fixes the other mapping
nnoremap <C-Q> Q
" for replace in entire file
nnoremap S :%s/\v/g<Left><Left>
" starts replace but substitutes the last search on '@"' (yank register)
nnoremap <expr> <C-Q> ':%s/\v' . @" . '//g<LEFT><LEFT>'
" starts replace but substitutes the last search on '@/' (search register)
" TODO: find better mapping
nnoremap <expr> <C-A> ':%s/\v' . @/ . '//g<LEFT><LEFT>'

" LawFormatting() function mapping
vnoremap <Leader>af :call LawFormatting()<CR>

" Ankify() function mapping
vnoremap <Leader>an :call PyAnkify()<CR>

" sets the non greedy thingy
cnoremap <expr> +? getcmdtype() =~ '[?/:]' ? '{-}' : '+?'

" TODO
" adds space between words
" s/\v( +)/\1 /g
" removes space between words
" s/\v( +) /\1/g

" search until start of next word
" vmode has to be different from the other two for whatever reason
" TODO: not working properly...
vnoremap <Leader>/h /\v.\ze\s
nnoremap <Leader>/h /\v.\s\ze
onoremap <Leader>/h /\v.\s\ze
" search until end of word
" \v<cursor_here>.{-}\s\zs
nnoremap <Leader>/l /\v.{-}\s\zs<C-b><Right><Right>
vnoremap <Leader>/l /\v.{-}\zs.\ze\s<C-b><Right><Right>
onoremap <Leader>/l /\v.{-}\s\zs<C-b><Right><Right>

" can't use 'vnoremap' because it ignores the vimsurround plugin mapping for 'S'
" can't use 'vnoremap' because it ignores the vimsurround plugin mapping for 'S'
" surrounds with cloze (overlapper) tags until next punctuation
nmap <Leader>ce v<Leader>,<Leader>co
nmap <Leader>ve v<Leader>,<Leader>cl
" surrounds with cloze (overlapper) tags
vmap <Leader>co S]gvS]laoc1::<Esc>
" surrounds with cloze tags
vmap <Leader>cl S}gvS}lac1::<Esc>

" does the walking on teh same file for checking answers
let @g = '0yt.:let @/="k:windo normal n | zz'
" TODO: make it work
function! GotoSameLine()
    " get 'line number'
    let line_text = getline('.')
    let line_number = matchstr(line_text, '^\d\+\.')
    let @/ = line_number
    " goes 1 line up in order not to screw the search in the current window
    normal k
    " problem: does for all windows... not current one only
    windo normal n | zz
endfunction
" edit file
nnoremap <Leader>e<Space> :e<Space>
" translates 12o to 12º
nnoremap <Leader>dg :call Preserve(':%s/\v(\d+)o/\1º/ge')<CR>

" TODO: for dealing with current law in each buffer
vnoremap <Leader>cl :set b:current_law =0
   "*buffer-variable* *b:var* *b:*
   "A variable name that is preceded with "b:" is local to the current buffer.
   "Thus you can have several "b:foo" variables, one for each buffer.
   "This kind of variable is deleted when the buffer is wiped out or deleted with

" for dealing with goddamn splits
" TODO: fix all behaviours (though i think this works)
"   splitting with buffers
nnoremap <Leader>bkh :leftabove vert sb<Space>
nnoremap <Leader>bkl :rightbelow vert sb<Space>
nnoremap <Leader>bjh :rightbelow sb<Space>
nnoremap <Leader>bjl :rightbelow vert sb<Space>
nnoremap <Leader>bhh :topleft vert sb<Space>
nnoremap <Leader>bll :botright vert sb<Space>
nnoremap <Leader>bjj :botright sb<Space>
nnoremap <Leader>bkk :topleft sb<Space>
" TODO
"   create new ones

 " erases blank lines
vnoremap <Leader>l :call EraseBlankLines()<CR>
" selects/yanks/etc whole line without newline and tabs
nnoremap vi_ _vg_
nnoremap yi_ _yg_
" THIS wreaked havoc. makes operator wait after "dd" normal command sequence
"onoremap di_ _dg_
nnoremap ci_ _cg_ ← same as ':norm S'
" same thing but with space and newline
nnoremap va_ 0v$
nnoremap da_ 0d$
nnoremap ca_ 0c$
" what this does is give accents to vowels
" TODO: make it slimmer and work with upper-case
nnoremap ç :call AccentIt()<CR>
function! AccentIt()
    let curr_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    let accents = {'a':'á', 'e':'é', 'i':'í', 'o':'ó', 'u':'ú', 'á':'à', 'à':'ã', 'ã':'a', 'é':'è', 'è':'ê', 'ê':'e', 'í':'i', 'ó':'ô', 'ô':'õ', 'õ':'o', 'ú':'u', 'ù':'u', 'ì':'i', 'ò':'o', 'ü':'u'}
    let @1 =  get(accents, curr_char, curr_char)
    normal s1
endfunction

" removes goddamn 'incluído pela instrução normativa' from laws
vnoremap <Leader>ra :call Preserve('call RemoveAddendum()')<CR>
" for using the 'search backwards' that was the comma
nnoremap \ ,
vnoremap \ ,
" inserts non-breaking space (does it on command mode too)
nnoremap <Leader>nb i <Esc>
" WARNING: triggers the 'No mapping found' when the '<Leader>ta' macro is run
" correct: 'cnoremap <Leader>nb  '
cnoremap <Leader>nb  
" removes trailing (nonbreaking) whitespace and tabs on entire file
nnoremap <Leader>ta :call Preserve('%s/\v[  \t]+$//ge')<CR>
" for changing screen to top
noremap ZZ z<CR>
noremap zZ z<CR>
" sets up delete search for deleting just before the match
nnoremap <Leader>d/ d/\v.
nnoremap <Leader>c/ c/\v.
" really deletes stuff and doesn't save it on registers ← I don't use it very  much though...
nnoremap <Leader>d "_d

" for going back to the first selected character in a visual selection
vnoremap ii :<Esc>`<v

" Navigating buffers
" for going back to the original buffer. Works like a charm
nnoremap <C-F1> :b 1<CR>
" for going to the trash buffers
nnoremap <Leader>tr :badd trash.txt<CR>
nnoremap <Leader>th :badd trash.html<CR>
nnoremap <C-F2> :b trash.txt<CR>
nnoremap <C-F3> :b trash.html<CR>

" for toggling cursorline highlighting
nnoremap <C-c> :set cursorline!<CR>

" for substituting only in visual selection.. Maybe there's a better mapping
vnoremap <A-/> :s/\%V\v
" for running macros silently on selected lines
" TODO: ver qual o problem com o \%Vnorm @o
vnoremap <Leader>s :<Backspace><Backspace><Backspace><Backspace><Backspace>silent! '<,'>

" for getting to just before a punctuation mark
let punctuation = '[.,:;\(\)\[\]!?]'
nnoremap <silent> <Leader>, l/\v.<C-R>=punctuation<CR><CR>
vnoremap <silent> <Leader>, l/\v.<C-R>=punctuation<CR><CR>
onoremap <silent> <Leader>, /\v<C-R>=punctuation<CR><CR>
" a lookbehind one. fookin beautiful
nnoremap <silent> <Leader>m h?\v<C-R>=punctuation<CR>\zs<CR>
vnoremap <silent> <Leader>m h?\v<C-R>=punctuation<CR>\zs<CR>
onoremap <silent> <Leader>m ?\v<C-R>=punctuation<CR>\zs<CR>

"   not working! find a better map...
nnoremap <Leader>b ge

"   Toggle search highlight
nnoremap <silent> <C-S> :set hlsearch!<CR>

"   Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"   Useful arrows
nnoremap <Left> <<
nnoremap <Right> >>
vnoremap <Left> <gv
vnoremap <Right> >gv

" Fixing bitchass ctrl+[
nnoremap <S-CR> <Esc> " this isnt useful, is it?
inoremap <S-CR> <Esc>
vnoremap <S-CR> <Esc>

" Fucking google drive fucking shit up
command! W w!
command! Q q

" translating the 'search word under cursor' for easier use
noremap # *
noremap * #

" for smart text selection and yanking
vnoremap ! /\v.$<Esc>
" TODO: improve this. Polutes the 'x' mark
nnoremap <S-Y> mx0yg_`x

" for manipulating buffers
nnoremap <C-TAB> :bn<CR>
nnoremap <C-S-TAB> :bp<CR>
nnoremap <Leader>bd<Space> :bd!<CR>
nnoremap <Leader>ba<Space> :badd<Space>
nnoremap <Leader>b<Space> :b<Space>

" for manipulating registers
"    " cycling registers
"    nnoremap <Leader>s :let @1=@" \| let @"=@+ \| let @+=@1<CR>
"    nnoremap <Leader>r <S-r><C-r>"<Esc>
"    " for getting chunks of text together, just in case
"    nnoremap <Leader>a "A
"    vnoremap <Leader>a "A
"    nnoremap <Leader>b "B
"    vnoremap <Leader>b "B
"    nnoremap <Leader>c "C
"    vnoremap <Leader>c "C
"    " cleaning registers
"    nnoremap <Leader>aa :let @a=@_<CR>
"    nnoremap <Leader>bb :let @b=@_<CR>
"    nnoremap <Leader>cc :let @c=@_<CR>
"    " swaping registers
"    nnoremap <Leader>ab :let @1=@a \| let @a=@b \| let @b=@1<CR>
"    nnoremap <Leader>ba :let @1=@a \| let @a=@b \| let @b=@1<CR>
"    nnoremap <Leader>ac :let @1=@a \| let @a=@c \| let @c=@1<CR>
"    nnoremap <Leader>ca :let @1=@a \| let @a=@c \| let @c=@1<CR>
"    nnoremap <Leader>bc :let @1=@b \| let @b=@c \| let @c=@1<CR>
"    nnoremap <Leader>cb :let @1=@b \| let @b=@c \| let @c=@1<CR>
"    " copying what was the last search to clipboard
"    nnoremap <silent> <Leader>/ :let @1=@" \| let @"=@/ \| let @+=@1<CR>
"    " copying what was the last command to clipboard
"    nnoremap <silent> <Leader>: :let @1=@" \| let @"=@: \| let @+=@1<CR>

" marks mapping
noremap ´ `

" for swapping tab styles
nnoremap <C-T> :set et! \| retab! <CR>

" fixing search regex
nnoremap / /\v
vnoremap / /\v

" for changing font size
nnoremap <C-Up> :silent! let &guifont = substitute(
" \ &guifont,
" \ ':h\zs\d\+',
" \ '\=eval(submatch(0)+1)',
" \ '')<CR><CR>
nnoremap <C-Down> :silent! let &guifont = substitute(
" \ &guifont,
" \ ':h\zs\d\+',
" \ '\=eval(submatch(0)-1)',
" \ '')<CR><CR>

" my digraph mappings
" for writing lists
digraph .. 8226     " • bullet point
digraph .b 9702     " ◦ white bullet point
digraph .t 9658     " ► triangular bullet point
digraph .q 9642     " ▪ square bullet point
digraph -- 8211     " – en dash

" for writing math
digraph +- 177      " ±
digraph -+ 2213     " ∓
digraph != 8800     " ≠
digraph >= 8805     " ≥
digraph <= 8804     " ≤
digraph 00 8734     " ∞
digraph in 8712     " ∈
digraph ni 8715     " ∋
digraph ** 215      " ×
digraph nl 8709     " ∅


" arrows
digraph sw 8593     " ↑
digraph ss 8595     " ↓
digraph sa 8592     " ←
digraph sd 8594     " →

" whatever
digraph ok 10003     "✓
digraph nk 10007     "✗

" fixes fucking pageup/pagedown in this fucking minuscule keyboard
map <PageUp> <Nop>
map! <PageUp> <Nop>
map <PageDown> <Nop>
map! <PageDown> <Nop>
"}}}
" augroups for file settings{{{
"augroup pdf_not_modifiable
"    autocmd!
"    autocmd BufWinEnter *.pdf setlocal nomodifiable
"augroup END

" TODO: find out why BufAdd doens't work but BufNewFile does
"augroup trash_settings
"    autocmd!
"    autocmd BufNewFile trash.* setlocal buftype=nofile bufhidden=hide noswapfile smartindent | filetype indent on
"augroup END"}}}

" FUCK YEAH!!
" when opening an empty vim file, don't open the [No Name]  buffer, rather the trash one
" TODO: figure out why the 'badd trash' command doesnt trigger the trash_settings autocmd
"autocmd VimEnter * if @%=='' | :badd trash.txt | bd! | setlocal buftype=nofile bufhidden=hide noswapfile

"PLUGINS settings{{{

" vimlatex {{{
" TODO: ver se nao rola de ligar só nos arquivos *.tex
let g:tex_flavor='latex'
nmap <C-M> <Plug>IMAP_JumpForward
imap <C-M> <Plug>IMAP_JumpForward
vmap <C-M> <Plug>IMAP_JumpForward
" que map burro do caralho ↓
unmap <CR>
unmap! <CR>
"}}}

" ultisnisps{{{
" ultisnips bug
if has('python3')
    silent! python3 1
endif
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" TODO: alguma coisa no caminho abaixo não funciona... já o segundo caminho
" (dentro do bundle) funciona. Investigar
let g:UltiSnipsSnippetsDir='C:/Users/pvolpi/Google Drive/vimfiles/mysnippets'
let g:UltiSnipsSnippetsDirectories=['C:/Users/pvolpi/Google Drive/vimfiles/mysnippets', 'C:/Users/pvolpi/Google Drive/vimfiles/.vim/bundle/vim-snippets/UltiSnips']
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"}}}

" vim autosave{{{
" AutoSave is disabled by default, run :AutoSaveToggle to enable/disable it.
let g:auto_save = 1
nnoremap <Leader>as :AutoSaveToggle<CR>
filetype plugin on
filetype indent on
"}}}

" Airline{{{
" airline theme
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1"}}}

" nerdtree{{{
map <C-n> :NERDTreeToggle %:p:h<CR>
let NERDTreeShowHidden = 1
let NERDTreeHijackNetrw = 0
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"}}}

" neovimhaskell{{{
let g:haskell_enable_quantification = 1   " to enable highlighting of 'forall'
let g:haskell_enable_recursivedo = 1      " to enable highlighting of 'mdo' and 'rec'
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of 'proc'
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of 'pattern'
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of 'static'
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords}}}

" pathogen{{{
execute pathogen#infect()
Helptags
"}}}
"}}}
" MACROS{{{
" TODO: translate to function
"   creates space until column nº 77
let @l = '100A  77|D:s/ / /g$'
" TODO: Maybe group these in a 'sort law' function?
"   removes things in parentheses
let @p = ':s/\v\s+\(.{-}\)//g'        " current line or selection only

" for typing numbers
let @m = ".000,00"
"}}}
" random crap{{{
" fixing bug with python files: vim doesn't recognize them
filetype on
autocmd BufRead,BufNewFile *.py setlocal filetype=python | syntax on | color IDLE | hi LineNr ctermfg=gray | hi CursorLineNr ctermfg=blue | hi Search ctermfg=black ctermbg=red | hi VertSplit ctermbg=NONE term=NONE cterm=NONE | hi IncSearch ctermbg=black ctermfg=green

" doesn't work
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

augroup fix_colors
    autocmd!
    autocmd ColorScheme * hi LineNr ctermfg=gray | hi CursorLineNr ctermfg=blue | hi Search ctermfg=black ctermbg=red | hi IncSearch ctermbg=black ctermfg=green | hi VertSplit ctermbg=NONE term=NONE cterm=NONE
augroup END"}}}
" My Functions{{{

function! ClearHTML()
python3 << endpython
import vim
import re
# TODO: make it work
def div_to_newline(linenr, line):
    # this doesnt insert newlines at all, so we cheat with vim.command()
    #newline_text = re.sub(div_pat, '\r', line)
    vim.command('.,{linenr}s/{pat}/{repl}/g'.format(linenr=linenr,pat='<div>',repl='\r'))
    return nodiv_text
def remove_HTML():
    # reselects the text block
    vim.command("normal vip")
    html_pat = re.compile(r'<.+?>')
    nbsp_pat = re.compile(r'\s?&nbsp;\s?')
    r = vim.current.range
    for i in range(r.start + 1, r.end + 1):
        r[i] = re.sub(html_pat, '', r[i])
        r[i] = re.sub(nbsp_pat, '  ', r[i])
    vim.command("normal \n")
endpython
    silent! execute a:firstline . "," . a:lastline . "py3do return div_to_newline(linenr, line)"
    %py3 remove_HTML()
endfunction
command! -range ClearHTML <line1>,<line2>call ClearHTML()
vnoremap <Leader>ch :ClearHTML<CR>

function! DaysUntilSefazBA()
python3 << endpython
import vim
from datetime import date
final_date = date(2019, 5, 26)
delta_days = (final_date - date.today()).days
vim.command("echo '########### {} DAYS UNTIL SEFAZ-BA ###########'".format(delta_days))
endpython
endfunction
" calls every time vim opens
call DaysUntilSefazBA()

function! LawFormatting() range
    " for 'incisos'
    silent! execute a:firstline . "," . a:lastline . "g/^[IVXM]/normal >>"
    " for 'alineas'
    silent! execute a:firstline . "," . a:lastline . "g/^[a-z])/normal >>>>"
endfunction

function! PyAnkify() range
python3 << endpython
import vim
import re
import functools
from itertools import tee

# doesnt work on bolden(). Why?
laws_pat = 'constituição|lei|decreto|instrução|portaria|convênio|PI nº|IN nº|NBC |resolução'

def colorize(line):
    regex_color_dict = {"(exceto|salvo|vedado|ressalvados?|suspensos?|nunca|não|^Falso|dispensad[oa])" : "#ff0000", "isent[oa]s?" : "#007bff", "(?!^)lei complementar" : "#00de00", "lei especial" : "deeppink"}
    for pat, col in regex_color_dict.items():
        line = re.sub(pat, '<span style="color:{color}">\g<0></span>'.format(color=col), line, re.IGNORECASE)
    return line

def link_anki(line):
    pat = re.compile(r'#(\d{5,})')
    fixed_html_text = re.sub(pat, r'<a href="https://www.tecconcursos.com.br/conteudo/questoes/\1">#\1</a>', line)
    return fixed_html_text

def bolden(line):
    # maybe later: "^({}).+$".format(laws_pat)
    regex_to_bold = ["Art\. [\d\.]+[\.º°]?, § [\d\.]+[\.º°]", "Art\. [\d\.]+, Parágrafo único\.", "\(Verdadeiro/Falso\)", "\((STF|STJ).+?\)$", "^(Constituição|Lei|Decreto|Convênio|PI nº|IN nº).+$", "Art\. [\d\.]+[\.º°](?!,)", "^(?<!, )§ [\d\.]+[\.º°](?!,)", "^Parágrafo único\.", "^\(.+\)$", "^NBC [TPG].+$", "^CAPÍTULO.+$", "^TÍTULO.+$", "^SEÇÃO.+$", "^CONVÊNIO.+$"]
    for pat in regex_to_bold:
        line = re.sub(pat, '<span style="font-weight:bold">\g<0></span>', line, re.IGNORECASE)
    return line

def space_to_nbsp(line):
    pat = '  '
    line = re.sub(pat, "&nbsp; ", line)
    return line

def div(line):
#carriage_line_pat = re.compile('\\r(.+?)\\r', re.UNICODE)
#carriage_to_div = re.sub(carriage_line_pat, r'<div>\g<1></div>', line)
    line_pat = re.compile(r"^.+$", re.UNICODE)
    fixed_text = re.sub(line_pat, r'<div>\g<0></div>', line)
    return fixed_text

def anki_header(line):
    # gets those empty lines before the paragraphs
    pat = re.compile(r'^$')
    fixed_text = re.sub(pat, '@anki-add	nameOfModel	nameOfDeck	tag1, tag2', line)
    return fixed_text

def fix_anki_html(line):
    def compose(*functions):
        return functools.reduce(lambda f, g: lambda x: f(g(x)), functions, lambda x: x)
    return compose(anki_header, div, space_to_nbsp, bolden, link_anki, colorize)(line)

def append_tab(linenr, line):
    # since tabs are the addon's field separators, append it to every line that is the line below the header
    # this only considers Basic type cards (i.e. has only two fields)
    header_pat = re.compile(r'^@anki-add')
    if not re.match(header_pat, line):
        # why linenr - 2? why not - 1?
        if linenr == 1 or re.match(header_pat, vim.current.buffer[linenr - 2]):
            return line + '	'
    return line

def pairwise(iterable):
    "s -> (s0,s1), (s1,s2), (s2, s3), ..."
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)

def grab_header_indexes():
    header_pat = re.compile(r'^@anki-add	nameOfModel	nameOfDeck	tag1, tag2')
    header_linenrs = []
    start, end = None, None
    for i, line in enumerate(vim.current.buffer):
        if re.match(header_pat, line):
            # +1 padding is for the vim linenr 1-based indexing
            header_linenrs.append(i + 1)
    return header_linenrs

def join_anki_fields():
    delimiters = grab_header_indexes()
    while any([end - start > 2 for start, end in pairwise(delimiters)]):
        for start, end in pairwise(delimiters):
            if end - start > 2:
                # joins lines after 'start' and before 'end'
                vim.command("{start},{end}join".format(start=start+1,end=end-1))
                break
        delimiters = grab_header_indexes()

def justify_law(linenr, line):
    # formats laws as left aligned text
    delimiters = grab_header_indexes()
    pat = re.compile(r'(?<!<div style="text-align:left">)<div><span style="font-weight:bold">(?:{}).+'.format(laws_pat), re.IGNORECASE)
    # line following the last delimiter isn't part of any card
    fixed_text = line
    for i in delimiters[:-1]:
        if i == linenr - 1:
            fixed_text = re.sub(pat, r""<div style='text-align:left'>\g<0></div>"", line)
    return fixed_text
endpython

    silent! execute a:firstline . "," . a:lastline . "py3do return fix_anki_html(line)"
    silent! execute a:firstline . "," . a:lastline . "py3do return append_tab(linenr, line)"
    py3 join_anki_fields()
    %py3do return justify_law(linenr, line)
endfunction

function! SwapWords()
    "
endfunction
" fixes punctuation like 'then , that happened .' → 'then, that happened.'
function! FixPunctuation() range
    let punctuation = '[.,:;!?]'
    execute a:firstline. "," . a:lastline . 's/\%V\v\ (' . punctuation . ')/\1/ge'
endfunction
command! -range FixPunctuation <line1>,<line2>call FixPunctuation()

function! ClozeoverlapperToCloze()
    " [[ocx:: ... ]] →{{c1:: ... }}
    %s/\v\[\[oc\d+(.{-})\]\]/\{\{c1\1\}\}/ge
endfunction

function! ClozeToClozeoverlapper()
    " {{c1:: ... }} →{{c1:: ... }}
    %s/\v\{\{c\d+(.{-})\}\}/\[\[oc1\1\]\]/ge
endfunction

function! StripCloze()
    " {{c1:: (...) }} → (...)
    %s/\v\{\{c1::(.{-})\}\}/\1/ge
    " [[ocx:: (...) ]] → (...)
    %s/\v\[\[oc\d+::(.{-})\]\]/\1/ge
endfunction

function! StripClozeFromRange() range
    " {{c1:: (...) }} → (...)
    execute a:firstline. "," . a:lastline . 's/\%V\v\{\{c1::(.{-})\}\}/\1/ge'
    " [[ocx:: (...) ]] → (...)
    execute a:firstline. "," . a:lastline . 's/\%V\v\[\[oc\d+::(.{-})\]\]/\1/ge'
endfunction
command! -range StripClozeFromRange <line1>,<line2>call StripClozeFromRange()

function! EaseCloze()
    " JESUS LAWD DAT CODE. So usefull. Such a pain in the ass to find
    " documentation to write it...
    " every x in [[ocx:: (...) ]] becomes the corresponding 'line' number
    let i=1 | g/\v\[\[oc1/s//\='[[oc'.i/g | let i=i+1
endfunction

function! ExtraSpaceDelete()
    " cleans double spaces inside lines
    "\S     non whitespace character
    "\zs    stops match backwards
    "\s\s+  two or more spaces
    "\ze    stops match forwards
    %s/\v\S\zs(\s\s+)\ze\S/ /ge
    " TODO: remove non-breaking whitespace
endfunction

function! MyDatePut()
    "   god, this is so mutch better than to save it on a register...
    "   gets time and date surrounded by brackets
    r! date /t
    r! time /t
    normal kJyss]
endfunction

function! ClozeDecrement()
    s/\%V\voc(\d+)/\='oc'.(submatch(1)-1)/ge
    normal gv
endfunction

function! ClozeIncrement()
    s/\%V\voc(\d+)/\='oc'.(submatch(1)+1)/ge
    normal gv
endfunction

" removes all strike tags from HTML
function! RemoveStrike()
    %s/\v\<strike\>\_.{-}\<\/strike\>//g
endfunction

" thank you lord for: [^\(]
" TODO: redo in python
function! RemoveAddendum() range
    " removes trailing spaces
    %s/\v[  \t]+$//ge
    " update as necessary to remove goddamn addenda from laws
    let laws = 'decreto|lei|medida|portaria|instruç|cpc|vide|renum|revis|redaç|incl|alterado|vigência|veto|regulamento|lc '
    " TODO: tentar fazer funcionar ↓
    let revoked = '(revogado)@!'
    execute a:firstline . "," . a:lastline . 's/\v[:;.]?(\se)?\zs\s*\([^\(]{-}(' . laws . ').+\)[:;.]?$//ge'
endfunction
command! -range RemoveAddendum <line1>,<line2>call RemoveAddendum()
" finnally getting this ↑

" some beautiful shit right there... TODO: study this
function! Redir(cmd)
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor
    if a:cmd =~ '^!'
        execute "let output = system('" . substitute(a:cmd, '^!', '', '') . "')"
    else
        redir => output
        execute a:cmd
        redir END
    endif
    vnew
    let w:scratch = 1
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    call setline(1, split(output, "\n"))
endfunction
command! -nargs=1 Redir silent call Redir(<f-args>)

" TODO: put it on all relevant functions
function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" can't believe this worked straight away
function! CleanStringForBrowserCMD(path)
    let clean_bars_path = substitute(a:path, '\\', '/', 'g')
    let clean_spaces_path = substitute(clean_bars_path, ' ', '\\%20', 'g')
    return clean_spaces_path
endfunction

" Finnaly!
function! OpenCurrentFileOnBrowser()
    let curr_file = CleanStringForBrowserCMD(expand('%:p'))
    call open_url#open('file:///' . curr_file)
endfunction

" TODO: make a way to erase the character class like a backspace
function! ToggleSmartSearch()
    if empty(maparg('a', 'c'))
        cnoremap <expr> a getcmdtype() =~ '[?/]' ? '[[=a=]]' : 'a'
        cnoremap <expr> e getcmdtype() =~ '[?/]' ? '[[=e=]]' : 'e'
        cnoremap <expr> i getcmdtype() =~ '[?/]' ? '[[=i=]]' : 'i'
        cnoremap <expr> o getcmdtype() =~ '[?/]' ? '[[=o=]]' : 'o'
        cnoremap <expr> u getcmdtype() =~ '[?/]' ? '[[=u=]]' : 'u'
    else
        cunmap a
        cunmap e
        cunmap i
        cunmap o
        cunmap u
    endif
endfunction

" TODO... saquito. Consegui o caso geral. Agora é fazer esse ↓
function! ToggleAnkiHighligh()
    if !hlexists("cloze")
        " colorize the cloze brackets
        hi cloze guibg=#39FF14
        let m = matchadd("cloze", "\[\[oc1::\\zs.{-}\\ze\]\]")
        "match cloze /\v\[\[oc1::\zs.{-}\ze\]\]/
    else
        " gets id
        for mtch in getmatches()
            if mtch['group'] == 'cloze'
                let id = mtch['id']
            endif
        endfor
        call matchdelete(id)
        "hi cloze guibg=bg
        "match cloze /\v\[\[oc1::\zs.{-}\ze\]\]/
    endif
endfunction

function! ParenthesesCorrect()
    silent! %s/“/"/ge | %s/”/"/ge
endfunction

function! DeleteCurrentFile()
    let choice = confirm("Delete file?", "&Yes\n%No", 1)
    if choice == 1
        call delete(expand('%')) | bd!
    endif
endfunction

" praise the lord for silent
function! EraseBlankLines() range
    silent! execute a:firstline . "," . a:lastline . 'g/\v^\s*$/d'
endfunction
command! -range EraseBlankLines <line1>,<line2>call EraseBlankLines()

" for html straightening
function! StraightenHTML()
    %s/\v\<div\>\zs/\r/g
endfunction


"}}}
" Function mappings{{{
nnoremap <F1> :call Preserve('call ClozeoverlapperToCloze()')<CR>
nnoremap <F2> :call Preserve('call ClozeToClozeoverlapper()')<CR>
nnoremap <F3> :call Preserve('call EaseCloze()')<CR>
nnoremap <F4> :call Preserve('call StripCloze()')<CR>
vnoremap <F4> :call Preserve('call StripClozeFromRange()')<CR>
vnoremap <F5> :call Preserve('call ClozeDecrement()')<CR>
vnoremap <F6> :call Preserve('call ClozeIncrement()')<CR>
nnoremap <F8> :call Preserve('call ExtraSpaceDelete()')<CR>
nnoremap <F9> :call ToggleSmartSearch()<CR>
nnoremap <F10> :call OpenCurrentFileOnBrowser()<CR>
nnoremap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
nnoremap <F12> :so $MYVIMRC<CR>
"}}}
