function! s:normalize(line1, line2, script) abort
  let l:out = systemlist('python3 -c ' . shellescape(a:script), getline(a:line1, a:line2))
  if v:shell_error
    echoerr 'text-tools: cannot read the text: ' . l:out[-1]
  endif
  call append(a:line2, l:out)
  silent execute a:line1 . ',' . a:line2 . 'delete _'
endfunction

function! text_tools#normalize_python_dict(line1, line2) abort
  call s:normalize(a:line1, a:line2, 'import ast,json,sys;obj=ast.literal_eval(sys.stdin.read());print(json.dumps(obj,sort_keys=True,indent=2,ensure_ascii=False))')
endfunction

function! text_tools#normalize_json_string(line1, line2) abort
  call s:normalize(a:line1, a:line2, 'import ast,json,sys;s=ast.literal_eval(sys.stdin.read());obj=json.loads(s);print(json.dumps(obj,sort_keys=True,indent=2,ensure_ascii=False))')
endfunction

function! s:NextFoldMarkerNumber() abort
  let s:fold_marker_counter += 1
  return s:fold_marker_counter
endfunction

function! text_tools#number_fold_markers() abort
  call text_tools#strip_fold_marker_numbers()
  let l:total = str2nr(matchstr(execute('%s/{{{//gne'), '\d\+'))
  let s:fold_marker_counter = 0
  execute '%s#{{{#\="{{{ (" . s:NextFoldMarkerNumber() . "/" . l:total . ")"#ge'
endfunction

function! text_tools#strip_fold_marker_numbers() abort
  %s/\({{{\) (\d\+\/\d\+)/\1/ge
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
