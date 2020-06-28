sec12=12_kubernetes.Rmd
sec13=13_security_tools.Rmd
sec14=14_Docker_19.03.Rmd
sec12:
	        R -e "library(rmarkdown); render('$(sec12)', 'html_document')"
sec13:
	        R -e "library(rmarkdown); render('$(sec13)', 'html_document')"
sec14:
	        R -e "library(rmarkdown); render('$(sec14)', 'html_document')"
clean:
	        \rm -rf *.log *.nav *.aux *.tex *.out *.snm *.toc *.vrb *.bbl


