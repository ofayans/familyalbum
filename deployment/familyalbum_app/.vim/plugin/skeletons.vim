" Funkce se vykoná po každém otevření nového souboru
function! SKEL_on_new_file()
   " Jestliže je soubor jen ke čtení nebo nemá příponu,
     " konči.
    if (&modifiable == 0) || (expand("%:e") == "")
        return

    endif

" Into variable skels save the list of all tempalte files
    let skels = expand("~/.vim/skeletons/*." . expand("%:e"))

" Exit if the list is empty
    if skels == ""
        return
    endif

    let pom = skels . "\n"
    let s = "Choose the templateu:\n"

    let i = "A"

  " Create template menu
    while pom != ""
        let s = s . i . ": " . fnamemodify(substitute (pom, "\n.*$", "", ""), ":t:r") . "\n" 
        let pom = substitute(pom, "^[^\n]*\n", "", "")
        let i = nr2char(char2nr(i) + 1)
    endwhile

    if i == "B"
        " If i == "B", znamená to, že existuje
        " jenom jeden soubor s šablonou. Nebudeme se ted
        " na nic ptát a rovnou ho použijeme...
        exe "0r " . substitute(skels, "\n.*$", "", "")
        call SKEL_replace()
    else
        " ...jinak se zeptáme uživatele, kterou šablonu si vybral
        let in = toupper(input(s))
        "
        " Jestliže je výběr v pořádku, načteme patřičn"�ablonu.
        "
        if (char2nr(in) != 0) && (char2nr(in) >= nr2char("A")) && (char2nr(in) < char2nr(i))
            let pom = skels . "\n" 
            let i = "A"
            " Hledáme název souboru, který uživatel zvolil.
            while i != in[0]
                let pom = substitute(pom, "^[^\n]*\n", "", "")
            let i = nr2char(char2nr(i) + 1)
        endwhile

          exe "0r " . substitute(pom, "\n.*$", "", "")
          call SKEL_replace()
    endif

  endif
endfunction


function! SKEL_replace()
" Delete last empty line if present

    exe "$d"
"
" Go to the begining
    normal 1G
"
" Do substitution
"
    exe "%s/skeletonVIM_CREATION_DATETIME/" . strftime("%Y\\/%m\\/%d %H:%M") . "/ge"
"
    exe "%s/skeletonVIM_CREATION_DATE/" . strftime("%Y\\/%m\\/%d") . "/ge"

    exe "%s/skeletonVIM_CREATION_TIME/" . strftime("%H:%M") . "/ge"
    exe "%s/skeletonVIM_FILE_BASE/" . expand("%:t:r") . "/ge"

    exe "%s/skeletonVIM_FILE_NAME/" .  expand("%:t") . "/ge"
    exe "%s/skeletonVIM_FILE_EXT/" .  expand("%:e") . "/ge"

    exe "%s/skeletonVIM_FILE_MACRO/__" . toupper(expand("%:t:r") . "_" . expand("%:e")) . "__/ge"

    exe "%s/skeletonVIM_USER_NAME/" .  $USER_NAME . "/ge"

    exe "%s/skeletonVIM_EMAIL/" .  $EMAIL . "/ge"
endfunction

if has("autocmd")
" ...register function SKEL_on_new_file() on every opening new file.
    augroup skeletons
        au!  
        autocmd BufNewFile * call SKEL_on_new_file()
    augroup END
endif
