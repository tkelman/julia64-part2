FROM tkelman/julia64-part1
MAINTAINER Tony Kelman <tony@kelman.net>

WORKDIR /home/julia-x86_64
RUN git pull && \
    DEPS="llvm libuv openlibm openspecfun utf8proc libgit2 pcre \
          dsfmt Rmath-julia unwind gmp mpfr patchelf virtualenv" && \
    for dep in $DEPS; do \
      make -j2 -C deps install-$dep; \
    done && \
    for dep in $DEPS; do \
      make -C deps distclean-$dep; \
    done && \
    echo "# the following line is a hack to avoid rebuilding deps after distclean'ed" >> Make.user && \
    echo 'override DEP_LIBS =' >> Make.user
# distclean should leave in place the installed libraries and headers
