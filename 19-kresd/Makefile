
slides.pdf: slides.tex pruhy.1 pruhy.2 ../slix/TeX/nicslix.tex ../slix/TeX/slix-common.tex
	xetex $<

pruhy.1 pruhy.2: ../slix/MetaPost/pruhy.mp
	mpost $<

clean:
	rm -f $(DOCUMENTS) *.log *.mpx *.[1-9]

.PHONY: all clean

