<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tsk="http://www.geo-solutions.it/tsk">
	<xsl:output method="text" omit-xml-declaration="yes" indent="no" />
	
    <xsl:template match="/GdalRasterize">-r average --config COMPRESS_OVERVIEW DEFLATE --config GDAL_TIFF_OVR_BLOCKSIZE 512 <xsl:apply-templates select="@*|node()" /></xsl:template>
    
	<xsl:template match="@*|node()">
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>
	
	<xsl:template match="baseOutputPath">
		<xsl:value-of select="concat( .,substring(//shapefilename,1,2),'/',//shapefilename,'.tif',' 2 4 8 16 32')" />
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>

</xsl:stylesheet>