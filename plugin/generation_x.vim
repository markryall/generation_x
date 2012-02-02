function! s:MakeDirP(path)
  let l:command = 'mkdir -p `dirname ' . a:path . '`'
  call system(l:command)
endfunction

function! s:RubyCreate(word,args)
  let l:list = split(a:args, ' ')
  let l:name = s:ClassifyPath(l:list)
  let l:lib_path = 'lib/' . join(l:list,'/') . '.rb'
  let l:spec_path = 'spec/' . join(l:list,'/') . '_spec.rb'
  call s:MakeDirP(l:lib_path)
  call s:MakeDirP(l:spec_path)
  execute 'edit ' . l:lib_path
  execute "normal! i" . a:word . " " . l:name . "\<cr>end\<esc>ggo  "
  execute 'edit ' . l:spec_path
  execute "normal! idescribe " . l:name . " do\<cr>end\<esc>ggo  "
endfunction

function! s:ClassifyPath(list)
  let l:elements = []
  for element in a:list
    let l:elements += [s:ClassifyModule(element)]
  endfor
  return join(l:elements, '::')
endfunction

function! s:ClassifyModule(name)
  let l:elements = []
  for element in split(a:name, '_')
    let l:elements += [s:ClassifyWord(element)]
  endfor
  return join(l:elements, '')
endfunction

function! s:ClassifyWord(word)
  return toupper(a:word[0]) . tolower(a:word[1:])
endfunction

command! -nargs=* RubyClass call s:RubyCreate('class', <q-args>)
command! -nargs=* RubyModule call s:RubyCreate('class', <q-args>)
