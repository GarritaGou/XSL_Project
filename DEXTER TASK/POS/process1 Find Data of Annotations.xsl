<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="iso-8859-1" indent="yes"/>
    
    <xsl:template match="/">
        <data>
            <xsl:for-each select="//data/type">
                <xsl:variable name="function" select="@name"/>
                <xsl:for-each select="token">
                    <sent>
                        <xsl:attribute name="id"><xsl:value-of select="start_id"/></xsl:attribute>
                        <xsl:attribute name="function"><xsl:value-of select="$function"/></xsl:attribute>
                        <xsl:attribute name="start"><xsl:value-of select="start_index"/></xsl:attribute>
                        <xsl:attribute name="end"><xsl:value-of select="end_index"/></xsl:attribute>
                    </sent>
                </xsl:for-each>
            </xsl:for-each>            
        </data>
    </xsl:template>    
</xsl:stylesheet>