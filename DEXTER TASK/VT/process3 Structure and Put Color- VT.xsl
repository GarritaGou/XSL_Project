<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" version="4.0" encoding="iso-8859-1" indent="yes"/>

	<!-- identity template - copies all elements and its children and attributes --> 
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>	
    
	<xsl:template match="//document">
        <html><xsl:apply-templates select="node()" /></html>
    </xsl:template>		
	
	<xsl:template match="//paragraph">
        <p><xsl:apply-templates select="node()" /></p>
    </xsl:template>
    
    <xsl:template match="//segment[@function='simple present']">
        <font color="red"><xsl:apply-templates select="node()" /></font>
    </xsl:template>
    
    <xsl:template match="//segment[@function='present perfect']">
        <font color="green"><xsl:apply-templates select="node()" /></font>
    </xsl:template>
	
    <xsl:template match="//segment[@function='present continuous']">
        <font color="blue"><xsl:apply-templates select="node()" /></font>
    </xsl:template>	
	
	    <xsl:template match="//segment[@function='simple past']">
        <font color="orange"><xsl:apply-templates select="node()" /></font>
    </xsl:template>	
	

</xsl:stylesheet>