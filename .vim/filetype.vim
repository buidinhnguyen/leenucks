" nginx
au BufRead,BufNewFile /etc/nginx/* set ft=nginx 
" Pandoc 
au! Bufread,BufNewFile *.pdc    set ft=pdc
