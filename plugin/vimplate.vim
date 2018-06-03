" vim: ai sm noet ts=4 sw=4
"=============================================================================
" Vim global plugin for autoload template files
" Description:
"	Plugin load template file for new files
"	Vimplates for new files aren't loaded, if g:load_vimplates == "no"
"	if g:load_vimplates == "ask" you are asked before loading template
"	If exists enviroment variable $VIMPLATE, vimplates are loaded from
"	this directory.

augroup VimplateSystem
	autocmd!
	au BufNewFile * call VimplateLoadModel()
augroup END

command! -nargs=0 VimplateLoadModel call VimplateLoadModel()
command! -nargs=1 VimplateLoadFile  call VimplateLoadFile(<args>)

" template file loaded
fun! VimplateLoadModel()
	if exists("g:load_vimplates")
		if g:load_vimplates == "no"
			return
		endif
	endif
	let extension = expand ("%:e")
	if extension == ""
		let template_file = "vimplates/" . expand("%:t")
		let template_func = "VimplateFileFunc_noext_" . expand("%:t")
	else
		let template_file = "vimplates/skel." . extension
		let template_func = "VimplateFileFunc_" . extension
	endif
	if filereadable(expand($VIMPLATE . template_file))
		call VimplateLoadModelConfirm($VIMPLATE . template_file)
	elseif filereadable(expand($HOME . "/.vim/" . template_file))
		call VimplateLoadModelConfirm($HOME . "/.vim/" . template_file)
	elseif filereadable(expand($VIM . template_file))
		call VimplateLoadModelConfirm($VIM . template_file)
	elseif filereadable(expand($VIMRUNTIME . template_file))
		call VimplateLoadModelConfirm($VIMRUNTIME . template_file)
	else
		" Vimplate not found
	endif

	let date = strftime("%c")
	let year = strftime("%Y")
	let cwd = getcwd()
	let lastdir = substitute(cwd, ".*/", "", "g")
	let myfile = expand("%:t:r")
	let myfile_ext = expand("%")
	let inc_gaurd = substitute(myfile, "\\.", "_", "g")
	let inc_gaurd = toupper(inc_gaurd)
	silent! execute "%s/@DATE@/" .	date . "/g"
	silent! execute "%s/@YEAR@/" .	year . "/g"
	silent! execute "%s/@LASTDIR@/" .  lastdir . "/g"
	silent! execute "%s/@FILE@/" .	myfile . "/g"
	silent! execute "%s/@FILE_EXT@/" .	myfile_ext . "/g"
	silent! execute "%s/@INCLUDE_GAURD@/" . inc_gaurd . "/g"
	if exists ("*" . template_func)
		if exists("g:load_vimplates")
			if g:load_vimplates == "ask"
				let choice = confirm("Call function " . template_func . "() ?:",
							\ "&yes\n" .
							\ "&no\n")
				if choice == 1
					silent! execute ":call " . template_func . "()"
				endif
			elseif g:load_vimplates == "yes"
				silent! execute ":call " . template_func . "()"
			endif
		else
			silent! execute ":call " . template_func . "()"
		endif
	endif
endfun

fun! VimplateLoadModelConfirm(filename)
	if filereadable(expand(a:filename))
		if exists("g:load_vimplates")
			if g:load_vimplates == "ask"
				let choice = confirm("NEW FILE! Load template file " .
							\ expand(a:filename) . " ?:",
							\ "&yes\n" .
							\ "&no\n")
				if choice == 1
					execute "0r "  . a:filename
				endif
			elseif g:load_vimplates == "yes"
				execute "0r "  . a:filename
			endif
		else
			execute "0r "  . a:filename
		endif
	endif
endfun

fun! VimplateLoadFile(filename)
	if filereadable(expand(a:filename))
		if exists("g:load_vimplates")
			if g:load_vimplates == "ask"
				let choice = confirm("Load file " .
							\ expand(a:filename) . " ?:",
							\ "&yes\n" .
							\ "&no\n")
				if choice == 1
					execute "0r "  . a:filename
				endif
			elseif g:load_vimplates == "yes"
				execute "0r "  . a:filename
			endif
		else
			execute "0r "  . a:filename
		endif
	else
		echo "File not found!"
	endif
endfun

" example for no-extension file specific template processing
fun! VimplateFileFunc_noext_makefile()
	let save_r = @r
	let @r = "all:\n\techo your template files need work"
	normal G
	put r
	let @r = save_r
endfun

" Modeline {{{
" vim:set ts=4:
" vim600:fdm=marker fdl=0 fdc=3 vb t_vb=:
" }}}

