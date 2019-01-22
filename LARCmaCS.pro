include(config.pri)
include(personal.pri)
#check personal info
msvc {
  isEmpty(VCPKG_DIR): error("To use MSVC you need to specify the path to VCPKG_DIR!")
}
mingw {
  isEmpty(MSYS_DIR): error("To use MINGW you need to specify the path to MSYS_DIR!")
}
isEmpty(MATLAB_DIR): error("You need to specify the path to MATLAB_DIR!")
include(proto/proto.pri)

SHARED_DIR = macsCommon

include (LARCmaCS/LARCmaCS.pri)

#Need this???
#where to place built objects
OBJECTS_DIR = build/LARCmaCS/obj$${SUFFIX_STR}

#where to place temporary moc sources
MOC_DIR = build/LARCmaCS/moc

#where to place auto-generated UI files
UI_DIR = build/LARCmaCS/ui

#where to place intermediate resource files
RCC_DIR = build/LARCmaCS/resources

defineReplace(fullSystemPath) {
	return($$system_quote($$system_path($$clean_path($$absolute_path($$1)))))
}

defineTest(copyToDestdir) {
	files = $$1

	for(FILE, files) {
		DDIR = $$DESTDIR
		# Replace slashes in paths with backslashes for Windows
		QMAKE_POST_LINK += $$QMAKE_COPY $$shell_path($$FILE) $$shell_path($$DDIR) $$escape_expand(\\n\\t)
	}

	export(QMAKE_POST_LINK)
}

INIT_FILES = \
	$$PWD/resources/LARCmaCS.cnf \
	$$PWD/resources/LARCmaCS.exe.embed.manifest \
	$$PWD/resources/gamepads.txt \
	$$PWD/resources/help.png \
	$$PWD/resources/help.html

copyToDestdir($$INIT_FILES)

win32 {
	APPEND_PATH = ";$$fullSystemPath($${MATLAB_DIR}/../bin/win$$BIT);$$fullSystemPath($$[QT_INSTALL_BINS])"
	msvc: APPEND_PATH = "${APPEND_PATH};$$fullSystemPath($${PROTO_DIR}/$${PREFIX_STR}bin/)"

	LARCMACS_RUNNER = LARCmaCS.cmd
	QMAKE_SUBSTITUTES += $${LARCMACS_RUNNER}.in
} else: linux {
	LARCMACS_RUNNER = LARCmaCS.sh
	LARCMACS_LD_LIBRARY_PATH=$$[QT_INSTALL_LIBS]:$$fullSystemPath($$MATLAB_LIB_DIR)
	QMAKE_SUBSTITUTES += $${LARCMACS_RUNNER}.in
}

!isEmpty(LARCMACS_RUNNER):QMAKE_POST_LINK += $$QMAKE_MOVE $$shell_path($$OUT_PWD/$$LARCMACS_RUNNER) $$shell_path($$DESTDIR/)
