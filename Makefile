

clean:
	rm -rf _site
	
check:
	jekyll serve --incremental --future

test: check



