ARG DEBIAN_DIST=bookworm
FROM debian:$DEBIAN_DIST

ARG ZIG_VERSION
ARG ZLS_VERSION
ARG DEBIAN_DIST
ARG BUILD_VERSION
ARG FULL_VERSION

RUN apt update && apt install -y git curl gpg
RUN curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
RUN echo "deb https://debian.griffo.io/apt $DEBIAN_DIST main" | tee /etc/apt/sources.list.d/debian.griffo.io.list
    
RUN apt update && apt install -y zig-master
RUN git clone https://github.com/zigtools/zls
RUN mkdir -p /opt/zls/$ZIG_VERSION
RUN cd zls && git checkout $ZLS_VERSION && zig build --prefix /opt/zls/$ZIG_VERSION -Doptimize=ReleaseSafe

RUN mkdir -p /output/usr/lib/zls/master
RUN cp "/opt/zls/$ZIG_VERSION/bin/zls" /output/usr/lib/zls/master/

RUN mkdir -p /output/DEBIAN
RUN mkdir -p /output/usr/share/doc/zls/

COPY output/DEBIAN/control /output/DEBIAN/
COPY output/DEBIAN/postinst /output/DEBIAN/
COPY output/DEBIAN/prerm /output/DEBIAN/
COPY output/DEBIAN/postrm /output/DEBIAN/
RUN chmod 755 /output/DEBIAN/postinst
RUN chmod 755 /output/DEBIAN/prerm
RUN chmod 755 /output/DEBIAN/postrm

COPY output/changelog.Debian /output/usr/share/doc/zls/changelog.Debian
COPY output/copyright /output/usr/share/doc/zls/

RUN sed -i "s/DIST/$DEBIAN_DIST/" /output/usr/share/doc/zls/changelog.Debian
RUN sed -i "s/BUILD_VERSION/$BUILD_VERSION/" /output/usr/share/doc/zls/changelog.Debian
RUN sed -i "s/ZIG_VERSION/$ZIG_VERSION/" /output/usr/share/doc/zls/changelog.Debian

RUN sed -i "s/DIST/$DEBIAN_DIST/" /output/DEBIAN/control
RUN sed -i "s/BUILD_VERSION/$BUILD_VERSION/" /output/DEBIAN/control
RUN sed -i "s/ZIG_VERSION/$ZIG_VERSION/" /output/DEBIAN/control

RUN sed -i "s/DIST/$DEBIAN_DIST/" /output/DEBIAN/postinst
RUN sed -i "s/BUILD_VERSION/$BUILD_VERSION/" /output/DEBIAN/postinst
RUN sed -i "s/ZIG_VERSION/$ZIG_VERSION/" /output/DEBIAN/postinst

RUN sed -i "s/DIST/$DEBIAN_DIST/" /output/DEBIAN/prerm
RUN sed -i "s/BUILD_VERSION/$BUILD_VERSION/" /output/DEBIAN/prerm
RUN sed -i "s/ZIG_VERSION/$ZIG_VERSION/" /output/DEBIAN/prerm

RUN sed -i "s/DIST/$DEBIAN_DIST/" /output/DEBIAN/postrm
RUN sed -i "s/BUILD_VERSION/$BUILD_VERSION/" /output/DEBIAN/postrm
RUN sed -i "s/ZIG_VERSION/$ZIG_VERSION/" /output/DEBIAN/postrm

RUN dpkg-deb --build /output /zls-master_${FULL_VERSION}.deb
