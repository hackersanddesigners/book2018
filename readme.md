# H&D book 2018


## Installation

Make sure you have weasyprint installed as per instructions :
https://weasyprint.readthedocs.io/en/stable/install.html

### Mac
On mac you'll have to install some stuff with Homebrew, so read the guide.
We had a problem with a Cairo version, so we had to force a version with
```pip install cairocf==0.9.0```

Then:

``` pip install WeasyPrint ```

And install the other dependencies

``` pip install pathlib beautifulsoup4 ```

We had locale errors on some machines. Set locale with:
```
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
```
or add those to the shells .rc file

## Usage

Export the documents from Google docs and place in ./srcdocs

Run clean command

``` ./generate.sh -c ```

This will place the cleaned documents in ./srcdocs/clean. Adjust as needed.

Run build command

``` ./generate.sh -b ```

That will generate ./build/book.html & run Weasyprint to generate ./build/book.pdf

Set the output filename by adding
``` ./generate.sh -b --output hdbook.pdf ```
