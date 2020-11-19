

clean:
	rm -rf _site
	
check:
	rm -f _site/index.html
	rm -f _site/archive.html
	jekyll serve --incremental --future

test: check



