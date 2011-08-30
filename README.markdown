     _               _             
    | |__   __ _ ___| |__  _   _   
    | '_ \ / _` / __| '_ \| | | |  
    | |_) | (_| \__ \ | | | |_| |_ 
    |_.__/ \__,_|___/_| |_|\__, (_)
                           |___/   

# Bashy [![Build Status](https://secure.travis-ci.org/nathankleyn/bashy.png)](http://travis-ci.org/nathankleyn/bashy)

**This is a work in progress, and does not work just yet!**

A simple code snippet storage tool, making it easy to save, run, and manage your scripts from the Terminal.

You can add your scripts inline, from a file, or from a URL, and they'll be saved under a command name of your choice. Then, it's a simple as `bashy command_name` to run that command you saved at any time!

## Installation

    gem install bashy

## Usage

    bashy ([--help] | <command> [<args>])

## Commands

    add        Add a bashy snippet to your bashy library
    edit       Edit a bashy snippet
    help       Look at this help manual for bashy
    list/ls    List all your available bashy snippets
    remove/rm  Remove a bashy snippet by command name
    run/r      Run a bashy snippet by it's command name
    show       Show the contents of a bashy snippet

### add

    bashy add <name> (<code_string> | <file_path> | <url>)

Add a bashy snippet to your bashy library

### edit

    bashy edit <name>

Edit a bashy snippet

### help

    bashy (help | --help)

Look at this help manual for bashy

### list

    bashy (list | ls)

List all your available bashy snippets

### remove

    bashy (remove | rm) <name>

Remove a bashy snippet by command name

### run

    bashy (run | r) <name>

Run a bashy snippet by it's command name

### show

    bashy show <name>

Show the contents of a bashy snippet

## Planned features

* Native support for Gists as Git repositories.
* Native support for commandlinefu.com scripts.
* Cloud syncing of your bashy scripts.
* A bashy site for uploading and sharing snippets.
* A web interface for editing the scripts and having them sync across all shares.

## Licence

The MIT License

Copyright (c) 2011 Nathan Kleyn

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
