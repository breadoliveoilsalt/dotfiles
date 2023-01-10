nnoremap <Leader>ps :call PasteClipboardImageWithMarkdown()<CR>
nnoremap <Leader>om :call OpenMarkdownViewer()<CR>

" If current working file is vim/pasteScreenShot.vim', this will paste
" screen shot in vim/assets.pasteScreenShot/pasteScreenShot-image-2022-01-08-00-00-00.png
function PasteClipboardImageWithMarkdown()
  let current_file_name_without_ext = expand("%:t:r")
  let img_directory_name = current_file_name_without_ext . ".assets"
  let img_directory_absolute_path = expand("%:p:h") . "/" . img_directory_name

  if !isdirectory(img_directory_absolute_path)
    silent call mkdir(img_directory_absolute_path)
  endif

  let img_file_name = current_file_name_without_ext . "-image-" . strftime("%Y-%m-%d-%H-%M-%S") . ".png"

  let paste_command = "pngpaste " . img_directory_absolute_path . " " . img_file_name

  " Note below the dependency on `pngpaste`. This is defined here in the
  " `customCommands` directory.  Also note: To be recognized by `system` (or by
  " an Ex bang command), pngpaste must be a script available in /usr/local/bin.
  " It cannot be a function loaded up in .zshrc
  silent call system(paste_command)

  if v:shell_error == 1
    echo "Something went wrong saving image from clipboard. Maybe text was there."
  else
   execute "normal! i![](" . img_directory_name . "/" . img_file_name . ")"
  endif
endfunction

function OpenMarkdownViewer()
  let file_name_full_path = expand("%:p")
  let open_markdown_viewer_command = "open -a 'Google Chrome' file://" . file_name_full_path
  silent call system(open_markdown_viewer_command)
endfunction
