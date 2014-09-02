# make-config for medit
#.SILENT:

default:
	@echo "Type one of the following:"
	@echo "  make macosx       for Apple Mac OS X"
	@echo "  make macosx-x64   for Apple Mac OS X 64 bits"
	@echo "  make macosx-ub    for Apple Mac OS X Universal binary"
	@echo "  make linux        for Linux on Intel systems"
	@echo "  make linux-x64        for Linux on 64 systems"
	@echo "  make win32        for Windows XP"
	@echo "  make hpux10       for HP systems with HPUX 10.x w/OpenGL"

# If your linux supports shared libraries, you might want to build with the 
# the "linux-ppc-so" entry instead
macosx:
	$(MAKE) $(MFLAGS) -f Makefile.arch \
        "prog   = medit" \
	"CC     = gcc" \
	"CFLAGS = -O3 -Dppc -funroll-loops -ansi \
	          -fexpensive-optimizations \
	          -Wuninitialized -Wunused -Winline -Wshadow" \
    "LDFLAGS= " \
    "INCDIR = -Isources -I/usr/include -I$(HOME)/code/library.cur/sources" \
    "GL_LIB = " \
	"GLUT_LIB = -framework GLUT -framework OpenGL -framework Cocoa" \
    "EXEDIR = /Applications/medit.app/Contents/MacOS"

macosx-x64:
	$(MAKE) $(MFLAGS) -f Makefile.arch \
        "prog   = medit" \
	"CC     = gcc" \
	"CFLAGS = -O3 -arch x86_64 -Dppc -funroll-loops -ansi \
	          -fexpensive-optimizations \
	          -Wuninitialized -Wunused -Winline -Wshadow" \
    "LDFLAGS= -arch x86_64" \
    "INCDIR = -Isources -I/usr/include -I$(HOME)/code/library.cur/sources" \
    "GL_LIB = " \
	"GLUT_LIB = -framework GLUT -framework OpenGL -framework Cocoa" \
    "EXEDIR = /Applications/medit.app/Contents/MacOS"

macosx-ub:
	$(MAKE) $(MFLAGS) -f Makefile.arch \
	"prog   = medit" \
	"CC     = gcc" \
	"CFLAGS = -O3 -Dppc -fast -isysroot /Developer/SDKs/MacOSX10.5.sdk \
	         -arch i386 -arch ppc -mcpu=G4" \
	"LDFLAGS= $(HOME)/code/library.cur/objects/gccub/*.o\
	       -s -isysroot /Developer/SDKs/MacOSX10.5.sdk -arch i386 -arch ppc -mcpu=G4" \
	"INCDIR = -Isources -I/usr/include -I$(HOME)/code/library.cur/sources" \
	"GL_LIB = "\
	"GLUT_LIB = -framework GLUT \
			    -framework OpenGL -framework Cocoa" \
	"EXEDIR = /Applications/medit.app/Contents/MacOS"

linux:
	$(MAKE) $(MFLAGS) -f Makefile.arch \
        "prog   = mymedit"\
	"C      = gcc" \
	"CFLAGS = -O3 -march=pentiumpro -ansi -fexpensive-optimizations \
	          -Wuninitialized -Wunused -Winline -Wshadow" \
        "LDFLAGS= -s -static-libgcc" \
        "INCDIR = -I. -I$(HOME)/code/library.cur/sources" \
	"XLIBS  = -L/usr/X11R6/lib -lOSMesa" \
        "GL_LIB   = /usr/lib/libGL.so" \
	"GLU_LIB  = /usr/lib/libGLU.so" \
	"GLUT_LIB = /usr/lib/libglut.a" \
        "EXEDIR = $(HOME)/bin/i86"

linux-x64:
	$(MAKE) $(MFLAGS) -f Makefile.arch \
        "prog   = mymedit"\
	"C      = gcc" \
	"CFLAGS = -O3 -march=corei7 -ansi -fexpensive-optimizations \
	          -Wuninitialized -Wunused -Winline -Wshadow" \
        "LDFLAGS= -s -static-libgcc" \
        "INCDIR = -I. -I$(HOME)/code/library.cur/sources" \
	"XLIBS  = -L/usr/X11R6/lib -lOSMesa" \
        "GL_LIB   = /usr/lib/x86_64-linux-gnu/libGL.so" \
	"GLU_LIB  = /usr/lib/x86_64-linux-gnu/libGLU.so" \
	"GLUT_LIB = /usr/lib/x86_64-linux-gnu/libglut.a" \
        "EXEDIR = $(HOME)/bin/i86"

win32:
	$(MAKE) $(MFLAGS) -f Makefile.arch \
	"prog   = medit-2.3-win.exe"\
	"CC     = gcc" \
	"CFLAGS = -O3 -mno-cygwin -Wuninitialized -Wunused -Winline -Wshadow" \
	"LDFLAGS= -v -s -mno-cygwin ../library.cur/objects/$(ARCHI)/*.o" \
	"INCDIR = -Isources -I../library.cur/sources -Iglut-mingw " \
	"XLIBS  = " \
	"GL_LIB   = -lopengl32" \
	"GLU_LIB  = -lglu32" \
	"GLUT_LIB = -lglut32" \
	"EXEDIR = $(HOME)/bin/win32"

hpux10:
	$(MAKE) $(MFLAGS) -f Makefile.arch \
        "prog   = medit-2.3-hpux" \
        "CC     = c89" \
        "CFLAGS = +O3 +Olibcalls +Ofastaccess"  \
        "LDFLAGS= -s" \
        "INCDIR = -I. -I/opt/graphics/OpenGL/include/ \
                  -I/opt/graphics/OpenGL/contrib/libglut/" \
        "XLIBS  = -L/usr/X11R6/lib -lXmu -lXext -lX11" \
        "GL_LIB   = /opt/graphics/OpenGL/lib/libGL.sl" \
        "GLU_LIB  = /opt/graphics/OpenGL/lib/libGLU.sl" \
        "GLUT_LIB = /opt/graphics/OpenGL/contrib/libglut/libglut.a" \
        "EXEDIR = $(HOME)/bin/hppa"

# Remove .o files, emacs backup files, etc.
clean:
	-rm -f sources/*~ objects/$(ARCHI)/*.o

tar:
	tar czf archives/medit.`date +"%Y.%m.%d"`.tgz sources makefile Makefile.arch
