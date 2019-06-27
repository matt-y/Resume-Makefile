# Resume Makefile

This is a Makefile & associated scripts that I use for generating my resume. I
have an html resume that I use as a [mustache
template](https://mustache.github.io/). I do this to control whether or not I
show my full job history, my actual phone number or email address, or other
sections within the resume itself. 

This is a fairly specialized workflow! Not everyone has an html resume, and even
fewer people have one that does mustache template interpolation! 

The workflow in its entirity is: 
1. Run the html resume through a mustache template processor (the included
   `process-tempalte.py` script)
2. Run the interpolated template result through the `aspell` spellchecker (wow!)
3. Hand the interpolated template result to pandoc and have it spit out a plain
   text resume
   
That's it. It's a fairly small dependency graph, but make ties it all together
quite nice. Your workflow might not be the same as mine, but maybe this could be
helpful as a reference. 

Special shout out to [Software Carpentry's Automation and Make
tutorial](http://swcarpentry.github.io/make-novice/) for giving me the idea to
use make for this task.

## Prerequisites 

The following programs are required:
1. make
2. pandoc 
3. aspell

Additionally, the makefile requires a working python3 envronment including:

- pip3
- pipenv

Installation instructions for pipenv can be found [here](https://github.com/pypa/pipenv).

The Makefile assumes your python 3 binary is `python3`. If your python is
somewhere else the Makefule can be edited to use it simply enough.

## Configuration

The Makefile looks for a file called `config.mk` in the same directory that it
reside. An example config `config-example.mk` is provided for you to modify. The
existing configuration options are outlined in the following sections.

### `CONFIG_SOURCE`

This is a path to a json file with data that will be provided to the mustache
template at the top of the pipeline.

### `RESUME_SOURCE`

This is a path to the html resume / mustache template. 

### `RESUME_OUTPUT_NAME`

This is the name of your output file. This name will be used to create two (2)
files in the format:
1. `RESUME_OUTPUT_NAME.html`
2. `TESUME_OUTPUT_NAME.txt` 

## Generating Resumes 

The `Makefile` will generate a fresh resume based on changes in the following
files:
- `CONFIG_SOURCE`
- `RESUME_SOURCE`
- `process-template.py` - this is our mustache interpolation script 

After populating your config file, simply run 

``` sh
make
```

to generate your resulting resumes. 
