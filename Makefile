PORTNAME=	minetestmapper
DISTVERSION=	g20220619
CATEGORIES=     games graphics
PKGNAMESUFFIX=	-dev
DISTNAME=	${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

MAINTAINER=	nope@nothere
COMMENT=        Generate an overview image of a minetest map

LICENSE=	GPLv2+

LIB_DEPENDS=	libgd.so:graphics/gd libzstd.so:archivers/zstd 


#USES=		cmake compiler:c11 iconv:wchar_t pgsql		# complains missing sqlite
#USES=		cmake compiler:c11 iconv:wchar_t sqlite		# complains missing pgsql
#USES=		cmake compiler:c11 iconv:wchar_t pgsql sqlite
USES=           cmake compiler:c11 sqlite pgsql

#CONFLICTS=	minetestmapper

USE_GITHUB=     nodefault
GH_ACCOUNT=     minetest
GH_PROJECT=     minetestmapper
GH_TAGNAME=	7fb3b9edd6cbc610404b9d1685150caeedb3eeba

CMAKE_ARGS=	-DBUILD_UNITTESTS="FALSE" \
		-DCMAKE_BUILD_TYPE="MinSizeRel" \
		-DCUSTOM_EXAMPLE_CONF_DIR="${PREFIX}/etc" \
		-DCUSTOM_MANDIR="${PREFIX}/man" \
		-DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib"

WRKSRC=         ${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

#OPTIONS_DEFINE=	DOCS EXAMPLES FREETYPE NLS
OPTIONS_GROUP=	DATABASE

DATABASE_DESC=			Database support
OPTIONS_GROUP_DATABASE=		LEVELDB REDIS SPATIAL
#OPTIONS_GROUP_DATABASE=	LEVELDB PGSQL REDIS SPATIAL

#OPTIONS_DEFAULT=		DOCS
OPTIONS_SUB=			yes

FREETYPE_DESC=			Support for TrueType fonts with unicode
FREETYPE_CMAKE_BOOL=		ENABLE_FREETYPE
FREETYPE_LIB_DEPENDS=		libfreetype.so:print/freetype2

LEVELDB_DESC=			Enable LevelDB backend
LEVELDB_CMAKE_BOOL=		ENABLE_LEVELDB
LEVELDB_LIB_DEPENDS=		libleveldb.so:databases/leveldb
REDIS_DESC=			Enable Redis backend
REDIS_CMAKE_BOOL=		ENABLE_REDIS
REDIS_LIB_DEPENDS=		libhiredis.so:databases/hiredis
SPATIAL_DESC=			Enable SpatialIndex AreaStore backend
SPATIAL_LIB_DEPENDS=		libspatialindex.so:devel/spatialindex
SPATIAL_CMAKE_BOOL=		ENABLE_SPATIAL

NLS_DESC=			Native Language Support (ENABLE_GETTEXT)
NLS_CMAKE_BOOL=			ENABLE_GETTEXT
NLS_USES=			gettext
NLS_LDFLAGS=			-L${LOCALBASE}/lib

.include <bsd.port.options.mk>

.include <bsd.port.mk>
