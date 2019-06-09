#! /usr/bin/env python

import os
import pathlib
from bs4 import BeautifulSoup
import sys, getopt
import random
import subprocess

pathlib.Path( pathlib.Path.cwd() / 'srcdocs' / 'clean' ).mkdir( exist_ok=True )
src_path = pathlib.Path.cwd() / 'srcdocs'
dest_path = src_path / 'clean'

def main(argv):
    inputfile = ''
    outputfile = ''
    try:
        opts, args = getopt.getopt( argv, "hcbo:", [ "clean", "build", "output" ] )
    except getopt.GetoptError:
        print ( 'generate.py -c/--clean | -b/--build' )
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print ( 'generate.py -c/--clean | -b/--build' )
            sys.exit()
        elif opt in ( "-c", "--clean "):
            cleanFiles()
        elif opt in ( "-b", "--build" ):
            build()


def cleanFiles():
	for file in sorted( src_path.rglob( '*.html' ) ):
		with open( file, 'r' ) as src_file:
			content = src_file.read()
			soup = BeautifulSoup( content, 'html.parser' )

			for style in soup.head.find_all( 'style' ):
				style.decompose()

			for class_el in soup.select( '[class]' ):
				del class_el[ 'class' ]

			for p_span in soup.select( 'p > span, h1 > span' ):
				p_span.unwrap()

			for empty_el in soup.select( ':empty' ):
				empty_el.decompose()

			clean = soup.prettify()

			with open( dest_path / file.name, 'w' ) as dest_file:
				dest_file.write( clean )

def build():
	template = pathlib.Path.cwd() / 'lib' / 'template.html'
	with open( template, 'r' ) as book:
		content = book.read()
	book_html = BeautifulSoup( content, 'html.parser' )
	container = book_html.body.div

	for file in sorted( dest_path.rglob( '*.html' ) ):
		with open( file, 'r' ) as src_file:
			content = src_file.read()
			body = formatDocument( content )
			container.append( body )

	dest_file = pathlib.Path.cwd() / 'build' / 'book.html'
	with open( dest_file, 'w' ) as output:
		output.write( str(book_html) )

	pdf_path = pathlib.Path.cwd() / 'build' / 'book.pdf'
	print( str( pdf_path ) )

	subprocess.Popen( [ 'weasyprint %s %s' % ( dest_file, pdf_path ) ], shell = True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL )

def formatDocument( content ):
	soup = BeautifulSoup( content, 'html.parser' )
	body = soup.body
	body.name = 'article'
	body[ 'class' ] = 'cols-' + str( random.randint( 2, 4 ) ) + ' bodyfont-' + str( random.randint( 1, 8 ) )
	for header in body.select( 'h1, h2' ):
		header[ 'class' ] = "headingfont-" + str( random.randint( 1, 18 ) )

	return body


if __name__ == "__main__":
   main( sys.argv[ 1: ] )
