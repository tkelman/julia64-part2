FROM tkelman/julia64-part1:release-0.4
MAINTAINER Tony Kelman <tony@kelman.net>

WORKDIR /home/julia-x86_64
RUN git pull && \
    DEPS="llvm libuv openlibm openspecfun utf8proc libgit2 \
          fftw dsfmt Rmath-julia unwind patchelf virtualenv" && \
    INSTALL="" && DISTCLEAN="" && \
    for dep in $DEPS; do \
      INSTALL="$INSTALL install-$dep" && \
      DISTCLEAN="$DISTCLEAN distclean-$dep"; \
    done && \
    make -j2 -C deps $INSTALL && \
    make -C deps $DISTCLEAN && \
    echo "# the following line is a hack to avoid rebuilding deps after distclean'ed" >> Make.user && \
    echo 'override DEP_LIBS =' >> Make.user
# distclean should leave in place the installed libraries and headers
