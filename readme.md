# H&D book 2018

Make sure you have weasyprint installed as per instructions :
https://weasyprint.readthedocs.io/en/stable/install.html

``` pip install WeasyPrint ```

Export the documents from Google docs and place in ./srcdocs

Run clean command

``` ./generate.sh -c ```

This will place the cleaned documents in ./srcdocs/clean. Adjust as needed.

Run build command

``` ./generate.sh -b ```

That will generate ./build/book.html & run Weasyprint to generate ./build/book.pdf
