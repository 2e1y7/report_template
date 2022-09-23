TEXFILES:= $(wildcard *.tex)
BIBFILES:= $(wildcard *.bib)
PNGFILES:= $(wildcard fig/*.png)
OBJFILES:= $(wildcard fig/*.obj)
TARGET=report

pdf: $(addsuffix .pdf,$(TARGET))
dvi: $(addsuffix .dvi,$(TARGET))

$(addsuffix .dvi,$(TARGET)): $(TEXFILES) $(OBJFILES:.obj=.eps) \
	$(PNGFILES:.png=.eps) $(BIBFILES)

clean: 
	rm -fv *~ *.log *.bbl *.blg *.aux *.ps *.dvi *.toc *.lof *.lot
	rm -fv thesis.pdf

realclean: clean.eps clean

clean.eps:
	rm -f $(OBJFILES:.obj=.eps) $(PNGFILES:.png=.eps)
	rm -f fig/*.tps fig/*.dps fig/*.tps.ps fig/*.bb

.PHONY: data clean pdf
.SUFFIXES: .tex .ps .dvi .obj .eps .bib .png .ppm .pgm .pdf .tps.obj .tps .jpg .bb .rb

.dvi.ps:
	dvips $< -f > $@
.tex.dvi:
	platex  $<
	-pbibtex $*
	platex  $<
	platex  $<
.dvi.pdf:
	dvipdfmx -f fontmap.map $<

.obj.eps:
	tgif -print -eps -color $< 
.png.eps:
	convert $< eps2:$@
.jpg.eps:
	convert $< eps2:$@
.ps.pdf:
	ps2pdf $< 
.tps.obj.tps:
	tgif2tex $<
.png.bb:
	(cd `dirname $@` ; ebb `basename $<`)
.jpg.bb:
	(cd `dirname $@` ; ebb `basename $<`)
