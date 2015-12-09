FROM tkelman/julia64-part1:centos7
MAINTAINER Tony Kelman <tony@kelman.net>

WORKDIR /home/julia-x86_64
RUN make -j4 testall test-pkg test-libgit2-online testall1 
