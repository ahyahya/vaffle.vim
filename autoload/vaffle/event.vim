let s:save_cpo = &cpoptions
set cpoptions&vim


function! s:newtralize_netrw() abort
  augroup FileExplorer
    autocmd!
  augroup END
endfunction


function! vaffle#event#on_bufenter() abort
  call s:newtralize_netrw()

  let bufnr = bufnr('%')
  let is_vaffle_buffer = vaffle#buffer#is_for_vaffle(bufnr)
  let path = expand('%:p')

  let should_init = is_vaffle_buffer
        \ || isdirectory(path)

  if !should_init
    " Store bufnr of non-directory buffer to back to initial buffer
    call vaffle#window#store_non_vaffle_buffer(bufnr)
    return
  endif

  let extracted_path = vaffle#buffer#extract_path_from_bufname(path)
  let path = !empty(extracted_path)
        \ ? extracted_path
        \ : path 

  call vaffle#init(path)
endfunction


let &cpoptions = s:save_cpo
