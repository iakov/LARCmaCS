include(config.pri)

linux {
	MATLAB_DIR=/usr/local/MATLAB/R2018a
	!exists($$MATLAB_DIR):MATLAB_DIR=/usr/local/MATLAB/MATLAB_Runtime/v95
}

include(personal.pri)
#check personal info
msvc {
  isEmpty(VCPKG_DIR): error("To use MSVC you need to specify the path to VCPKG_DIR!")
}
mingw {
  isEmpty(MSYS_DIR): error("To use MINGW you need to specify the path to MSYS_DIR!")
}
isEmpty(MATLAB_DIR): error("You need to specify the path to MATLAB_DIR!")
!exists($$MATLAB_DIR): error("$$MATLAB_DIR does not exist!")


include(proto/proto.pri)

SHARED_DIR = macsCommon

include (LARCmaCS/LARCmaCS.pri)

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
	LARCMACS_RUNNER = LARCmaCS.cmd

	APPEND_PATH = $$fullSystemPath($${MATLAB_DIR}/../bin/win$$BIT)
	APPEND_PATH += $$fullSystemPath($$[QT_INSTALL_BINS])
	msvc: APPEND_PATH += $$fullSystemPath($${PROTO_DIR}/$${PREFIX_STR}bin/)
	APPEND_PATH = $$join(APPEND_PATH, ; , ;)

} else: linux {
	LARCMACS_RUNNER = LARCmaCS.sh
	LARCMACS_LD_LIBRARY_PATH=$$[QT_INSTALL_LIBS]:$$fullSystemPath($$MATLAB_LIB_DIR)
}

!isEmpty(LARCMACS_RUNNER) {
	$${LARCMACS_RUNNER}.in.input=$$fullSystemPath($$PWD/$${LARCMACS_RUNNER}.in)
	$${LARCMACS_RUNNER}.in.output=$$fullSystemPath($$OUT_PWD/$$DESTDIR/$${LARCMACS_RUNNER})
	#copy access/executable attributes from template .in file
	linux:QMAKE_POST_LINK += chmod --reference=$$shell_path($$eval($${LARCMACS_RUNNER}.in.input)) $$shell_path($$eval($${LARCMACS_RUNNER}.in.output))
	QMAKE_SUBSTITUTES += $${LARCMACS_RUNNER}.in
}
