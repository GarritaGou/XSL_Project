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
	
	<xsl:template match="//textfile">
        <title><xsl:apply-templates select="node()" /></title>
    </xsl:template>		
	
	<xsl:template match="//paragraph">
        <p><xsl:apply-templates select="node()" /></p>
    </xsl:template>
	
    <xsl:template match="//segment[@pos='verb']">
        <font color="olive"><xsl:apply-templates select="node()" /></font>
    </xsl:template>
    
    <xsl:template match="//segment[@pos='noun']">
        <font color="Gold"><xsl:apply-templates select="node()" /></font>
    </xsl:template>
	
    <xsl:template match="//segment[@pos='preposition']">
        <font color="pink"><xsl:apply-templates select="node()" /></font>
    </xsl:template>	
</xsl:stylesheet>
