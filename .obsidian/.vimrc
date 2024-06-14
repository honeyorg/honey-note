" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
" I like using H and L for beginning/end of line
nmap H 5h
nmap L 5l
nmap J 5j
nmap K 5k
" Quickly remove search highlights
nmap <F9> :nohl

" Yank to system clipboard
set clipboard=unnamed
unmap <Space>
exmap back obcommand app:go-back
nmap <Space>- :back
exmap forward obcommand app:go-forward
nmap <Space>= :forward



exmap splithorizontal obcommand workspace:split-horizontal
nmap <Space>sj :splithorizontal
nmap <Space>sk :splithorizontal
exmap splitvertical obcommand workspace:split-vertical
nmap <Space>sl :splitvertical
nmap <Space>sh :splitvertical

exmap nexttab obcommand workspace:next-tab
nmap <Tab> :nexttab
exmap prevtab obcommand workspace:previous-tab
nmap <S-Tab> :prevtab

exmap focusleft obcommand editor:focus-left
exmap focusbottom obcommand editor:focus-bottom
exmap focustop obcommand editor:focus-top
exmap focusright obcommand editor:focus-right
nmap <Space>h :focusleft
nmap <Space>j :focusbottom
nmap <Space>k :focustop
nmap <Space>l :focusright
