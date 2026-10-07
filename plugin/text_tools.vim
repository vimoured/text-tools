" text-tools: reformat Python dicts / JSON strings, number fold markers, and
" strip trailing whitespace and CR line endings (optionally on every write).
if exists('g:loaded_text_tools')
  finish
endif
let g:loaded_text_tools = 1

" {'foo': True, 'bar': None} -> sorted, indented JSON
command! -range=% NormalizePythonDict call text_tools#normalize_python_dict(<line1>, <line2>)
" '{"foo": true, "bar": null}' (a quoted JSON string) -> sorted, indented JSON
command! -range=% NormalizeJsonString call text_tools#normalize_json_string(<line1>, <line2>)

" Numbers {{{ fold markers as {{{ (1/3), {{{ (2/3), ... for easy navigation
command! NumberFoldMarkers call text_tools#number_fold_markers()
" Strips the (n/total) suffix added by NumberFoldMarkers back to plain {{{
command! StripFoldMarkerNumbers call text_tools#strip_fold_marker_numbers()

command! StripTrailingWhitespace call text_tools#strip_trailing_whitespace()
command! StripTrailingCR call text_tools#strip_trailing_cr()

" With g:text_tools_strip_on_save set, both are stripped before every write.
" b:text_tools_strip_whitespace = 0 keeps trailing whitespace in one buffer.
augroup text_tools
  autocmd!
  autocmd BufWritePre * if get(g:, 'text_tools_strip_on_save', 0)
        \ | call text_tools#strip_on_save() | endif
augroup END
