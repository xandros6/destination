<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tsk="http://www.geo-solutions.it/tsk">
	<xsl:output method="text" omit-xml-declaration="yes" indent="no" />
		
	<xsl:template match="GdalRasterize">
		<xsl:value-of select="concat(
		//baseOutputPath,substring(//shapefilename,1,2),'/',//shapefilename,'_normalized.shp',
		' ','-dialect SQLITE',
		' ','-sql &quot;UPDATE ')" />
		<xsl:value-of select='concat("&apos;",//shapefilename,"_normalized&apos;")' />
		<xsl:value-of select="concat(' SET NORM = CASE WHEN ST_Area(GEOMETRY) > 0 THEN (',//attributeToNormalize,'/ceiling(ST_Area(GEOMETRY)/100.0)) ELSE ',//attributeToNormalize,' END &quot;')" />
	</xsl:template>
	
</xsl:stylesheet>
