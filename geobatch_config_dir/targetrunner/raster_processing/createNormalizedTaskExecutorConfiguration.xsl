<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tsk="http://www.geo-solutions.it/tsk">
	<xsl:output method="text" omit-xml-declaration="yes" indent="no" />
		
	<xsl:template match="GdalRasterize">
		<xsl:value-of select="concat(
		//baseOutputPath,substring(//shapefilename,1,2),'/',//shapefilename,'_normalized.shp',
		' ',//shapefilepath,//shapefilename,'.shp')" />
	</xsl:template>

</xsl:stylesheet>