function! text_tools#normalize_python_dict(line1, line2) abort
  let l:script = 'import ast,json,sys;obj=ast.literal_eval(sys.stdin.read());print(json.dumps(obj,sort_keys=True,indent=2,ensure_ascii=False))'
  execute a:line1 . ',' . a:line2 . '!python3 -c ' . shellescape(l:script)
endfunction

function! text_tools#normalize_json_string(line1, line2) abort
  let l:script = 'import ast,json,sys;s=ast.literal_eval(sys.stdin.read());obj=json.loads(s);print(json.dumps(obj,sort_keys=True,indent=2,ensure_ascii=False))'
  execute a:line1 . ',' . a:line2 . '!python3 -c ' . shellescape(l:script)
endfunction

function! s:NextFoldMarkerNumber() abort
  let s:fold_marker_counter += 1
  return s:fold_marker_counter
endfunction

function! text_tools#number_fold_markers() abort
  let l:total = str2nr(matchstr(execute('%s/{{{//gn'), '\d\+'))
  let s:fold_marker_counter = 0
  execute '%s#{{{#\="{{{ (" . s:NextFoldMarkerNumber() . "/" . l:total . ")"#g'
endfunction

function! text_tools#strip_fold_marker_numbers() abort
  %s/\({{{\) (\d\+\/\d\+)/\1/g
endfunction

function! s:WithPreservedCursor(Callback) abort
  if &readonly || !&modifiable
    return
  endif

  let save_cursor = getpos('.')
  try
    call call(a:Callback, [])
  finally
    call setpos('.', save_cursor)
  endtry
endfunction

function! s:StripTrailingWhitespace() abort
  silent! %s/\v\S\zs[ \t]+$//e
endfunction

function! s:StripTrailingCR() abort
  if search('\r$', 'nw')
    silent! %s/\r$//e
  endif
endfunction

function! text_tools#strip_trailing_whitespace() abort
  call s:WithPreservedCursor(function('s:StripTrailingWhitespace'))
endfunction

function! text_tools#strip_trailing_cr() abort
  call s:WithPreservedCursor(function('s:StripTrailingCR'))
endfunction

function! text_tools#strip_on_save() abort
  call text_tools#strip_trailing_cr()
  if get(b:, 'text_tools_strip_whitespace', 1)
    call text_tools#strip_trailing_whitespace()
  endif
endfunction
