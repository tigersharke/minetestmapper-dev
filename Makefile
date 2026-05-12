PORTNAME=		minetestmapper
DISTVERSION=	g20251005
CATEGORIES=     games graphics
MASTER_SITES=   GH
PKGNAMESUFFIX=	-dev
DISTNAME=		${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

MAINTAINER=		nope@nothere
COMMENT=        Generate an overview image of a minetest map
WWW=			https://github.com/minetest/minetestmapper

LICENSE=		GPLv2+

LIB_DEPENDS=	libzstd.so:archivers/zstd \
				libz-ng.so:archivers/zlib-ng \
				libgd.so:graphics/gd

USES=			cmake sqlite

CONFLICTS=		minetestmapper

USE_GITHUB=		yes
GH_ACCOUNT=		luanti-org
GH_PROJECT=		minetestmapper
GH_TAGNAME=		b5d41a35c388db377edda60c01969fe0fa113ca4

CMAKE_ARGS=		-DCMAKE_BUILD_TYPE="Release"

#WRKSRC=         ${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

OPTIONS_GROUP=	DATABASE

DATABASE_DESC=			Database support
OPTIONS_GROUP_DATABASE=	LEVELDB POSTGRESQL REDIS

OPTIONS_SUB=			yes

LEVELDB_DESC=			Enable LevelDB backend --broken: leveldb port build fails--
LEVELDB_CMAKE_BOOL=		ENABLE_LEVELDB
LEVELDB_LIB_DEPENDS=	libleveldb.so:databases/leveldb

POSTGRESQL_DESC=		Enable postgresql backend
POSTGRESQL_CMAKE_BOOL=	ENABLE_POSTGRESQL
POSTGRESQL_USES=		pgsql

REDIS_DESC=				Enable Redis backend
REDIS_CMAKE_BOOL=		ENABLE_REDIS
REDIS_LIB_DEPENDS=		libhiredis.so:databases/hiredis

.include <bsd.port.options.mk>

.include <bsd.port.mk>
