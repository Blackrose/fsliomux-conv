INSTALL =		install
INSTALL_PROG =		${INSTALL} -p -m 0755
INSTALL_DATA =		${INSTALL} -p -m 0644
MKDIR_P =		${INSTALL} -d -m 0755

prefix = /usr/local
bindir = ${prefix}/bin
libdir = ${prefix}/lib
pkglibdir = ${libdir}/fsliomux-conv

bin_SCRIPTS =		fsliomux-conv.fixup
pkglib_SCRIPTS =	iomux-macrofy
pkglib_DATA =		iomux2c.xsl iomux2dt.xsl

all:		${bin_SCRIPTS} ${pkglib_SCRIPTS} ${pkglib_DATA}

install:	install-bin install-scripts install-data

clean:
	rm -f fsliomux-conv.fixup

${DESTDIR}${bindir} ${DESTDIR}${pkglibdir}:
	${MKDIR_P} $@

install-bin:		fsliomux-conv.fixup | ${DESTDIR}${bindir}
	${INSTALL_PROG} $^ ${DESTDIR}${bindir}/fsliomux-conv

install-scripts:	${pkglib_SCRIPTS} | ${DESTDIR}${pkglibdir}
	${INSTALL_PROG} $^ ${DESTDIR}${pkglibdir}/

install-data:		${pkglib_DATA} | ${DESTDIR}${pkglibdir}
	${INSTALL_DATA} $^ ${DESTDIR}${pkglibdir}/


fsliomux-conv.fixup:	fsliomux-conv Makefile
	rm -f $@
	sed -e 's!PKGLIBDIR=/usr/lib/fsliomux-conv!PKGLIBDIR=${pkglibdir}!g' \
		$< > $@
	-touch --reference $< $@
