# Original _script posting_ redone as a README

template file loader : Loads a template file and does customizable processing when editing a new file.

script karma	Rating 123/44, Downloaded by 4391	Comments, bugs, improvements	Vim wiki
created by
scott urban

script type
utility

description
This plugin is for loading template files when editing new files. A template file will be loaded if found, keywords in that template are expanded, and/or a customized function for that type of files is called.

For all new files, the script checks to see if you have a skeleton (template) file for the extension of that file. For example, ":new temp.c" would check for the existence of "skel.c". Files without extensions are handled also - if you did ":new makefile", the script checks for the existence of "skel.noext.makefile".

skel.* files are looked for in a directory specified with the environment variable $VIMTEMPLATE or in your ~/.vim directory if that env var doesn't exist. This allows you to use mutliple sets of template files - some for work files and some for personal files, for example.

This plugin is meant to be customized - add your own keywords for expansion or your own file specific template functions (example provided in script).

The script includes many example skel.* files - some are links to others.
