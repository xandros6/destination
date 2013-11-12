<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tsk="http://www.geo-solutions.it/tsk">
	<xsl:output method="text" omit-xml-declaration="yes" indent="no" />
	
	<xsl:template match="/GdalRasterize">-a_srs "EPSG:32632" -co "TILED=YES" -co "BLOCKXSIZE=512" -co "BLOCKYSIZE=512" -a_nodata 0 -ot Float32 -a_nodata "-1.0" -tr 10 10 -a "NORM" -co "COMPRESS=DEFLATE"<xsl:apply-templates select="@*|node()" /></xsl:template>
	
	<xsl:template match="@*|node()">
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>

	<xsl:template match="shapefilename">
		<xsl:value-of select="concat(' -l ', .,'_normalized')" />
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>
	
	<xsl:template match="shapefilepath">
		<xsl:value-of select="concat(' ', //baseOutputPath,substring(//shapefilename,1,2),'/',//shapefilename,'_normalized.shp')" />
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>
	
	<xsl:template match="baseOutputPath">
		<xsl:value-of select="concat(' ', .,substring(//shapefilename,1,2),'/',//shapefilename,'.tif')" />
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>

</xsl:stylesheet>