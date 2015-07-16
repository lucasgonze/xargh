# xargh

Shell command for Unix-like operating systems to build and execute command lines from a template command and a list of items to insert in the template. Substitutes each item in the list into the template, then executes the combined command.

In comparison to the xargs utility, you should find xargh easier.  In comparison to "for" loops in the bourne shell, you should find xargh involves less typing.  In comparison to hand-rolled scripts, you should find xargh less buggy and more secure.

## Usage
````
   xargh [switches] [command] [file(s)]
````

Example:
````
$ echo "a
b" | xargh "echo {} was the string" -
a was the string
b was the string
````

Switches: "-r" will cause any line in the data file ending in .m3u to be treated as a file name to be opened and processed recursively.

Command: a template of a shell command. Each line in the data file will be concatenated, and the combined string executed. If the template contains ````{}````, the data will be inserted at that position instead of appended.

This allows you to insert a file reference into a command somewhere other than at the end.

File argument(s):

* Any arguments after the command are assumed to be names of data files.
* A file named "-" is interpreted to mean standard input.
* Before passing a line to a command, whitespace at either end and DOS-fuxored carriage returns are trimmed.

A line in the data file beginning with "#" is considered a comment and is skipped.

xargh is not aware that M3U files traditionally contain lists of audio files.  In its view M3U is simply a standard format for batch
processing -- entries could just as well be any kind of data.

## Installation
````
  npm install -g xargh
````

If perl is not installed in /usr/bin/perl on your system, you will need to change the first line of the script from *#!/usr/bin/perl* to *#!/usr/local/bin/perl* or wherever your perl is installed.

## Examples

   ````xargh ls my.m3u````

will run the ls command on each file named in my.m3u.


 ````xargh wget my.m3u````

will fetch items that are HTTP urls.

 ````xargh "mv {} newdir/" my.m3u````

will move items to a new directory.

````xargh "wget {}; basename {} >> cache.m3u" my.m3u````

will fetch items that are HTTP urls and create a new playlist with local copies.

````xargh ls *.m3u````

will run the ls command on each item in all m3u files.

```` cat my.m3u | xargh ls -````

will run the ls command on each item in my.m3u.

````xargh -r ls my.m3u````

will run the ls command on each item in my.m3u, and on each item in any .m3u files contained in my.m3u, ad recursivitum.

## Security

xargh passes filenames contained within an m3u file as arguments to a shell command.  It is possible for attackers to use shell metacharacters in filenames to attack your system.  You can defend against this by inspecting the names of downloaded files before
   operating on them with xargh.

## More

Lucas Gonze

https://github.com/lucasgonze/xargh

lucas@gonze.com
