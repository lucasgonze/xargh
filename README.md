# xargh
Shell command to build and execute command lines. Given a template command and a data file, merges each line of the file into the template and executes the combined string.

In comparison to xargs, you should find xargh easier. In comparison to "for" loops in the shell or hand-rolled one-liners, you should find xargh is faster.


## Usage
   > xargh [switches] command [file(s)]

Example
  > $ echo "Hello" | xargh "echo {} World"

  > Hello World

Switches
  * "-h" or "--help" show long help.

Command

A template of a shell command. Each line in the data file will be concatenated, and the combined string executed. If the template contains {}, the data will be inserted at that position instead of appended.

This allows you to merge a data line into a command somewhere other than at the end.

File argument(s)
* STDIN is assumed to be a data file.
* Any arguments after the command are assumed to be names of additional data files.
* A file named "-" is treated as standard input.
* Before passing a line to a command, whitespace at either end and DOS-fuxored carriage returns are trimmed.
* A line in the data file beginning with "#" is considered a comment and is skipped.

## Installation
> npm install -g xargh

If perl is not installed in /usr/bin/perl on your system, you will need to change the first line of the script from *#!/usr/bin/perl* to *#!/usr/local/bin/perl* or wherever your perl is installed.

## Security

xargh passes filenames contained within an m3u file as arguments to a shell command.  It is possible for attackers to use shell metacharacters in filenames to attack your system.  You can defend against this by inspecting the names of downloaded files before
   operating on them with xargh.

## Contact
* mailto lucas at gonze.com
* https://github.com/lucasgonze/xargh
* c. 2003-2015 Lucas Gonze
* MIT license
