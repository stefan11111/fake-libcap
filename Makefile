.POSIX:

XCFLAGS = ${CPPFLAGS} ${CFLAGS} -nostdlib -std=c99 -fPIC -pthread -D_XOPEN_SOURCE=700 \
		  -Wall -Wextra -Wpedantic \
		  -Wno-unused-parameter
XLDFLAGS = ${LDFLAGS} -shared -Wl,-soname,libcap.so.2

LIBDIR ?= /lib64

OBJ = libcap.o

all: libcap.so.2.0.0

libcap.so.2.0.0:
	touch libcap.c
	${CC} ${XCFLAGS} libcap.c -c ${OBJ}
	${CC} ${XCFLAGS} -o $@ ${OBJ} ${XLDFLAGS}

install: libcap.so.2.0.0
	mkdir -p ${DESTDIR}/usr${LIBDIR}
	cp -f libcap.so.2.0.0 ${DESTDIR}/usr${LIBDIR}/libcap.so.2.0.0
	ln -rsf ${DESTDIR}/usr${LIBDIR}/libcap.so.2.0.0 ${DESTDIR}/usr${LIBDIR}/libcap.so.2
	ln -rsf ${DESTDIR}/usr${LIBDIR}/libcap.so.2 ${DESTDIR}/usr${LIBDIR}/libcap.so

uninstall:
	rm -f ${DESTDIR}/usr${LIBDIR}/libcap.so.2.0.0 ${DESTDIR}/usr${LIBDIR}/libcap.so.2 ${DESTDIR}/usr${LIBDIR}/libcap.so
clean:
	rm -f libcap.so.2.0.0 ${OBJ} libcap.c

.PHONY: all clean install uninstall
