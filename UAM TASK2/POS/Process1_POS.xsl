<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="iso-8859-1" indent="yes"/>
	
	<!-- copy everything -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
	<!-- matches some nodes and do nothing, i.e. delete them -->
	<xsl:template match="lang" />
	
	 <xsl:template match="body">
        <body><paragraph><xsl:apply-templates select="node()" /></paragraph></body>
    </xsl:template>		

    <xsl:template match="//sentence">
        <sentence><xsl:apply-templates select="node()" /></sentence>
    </xsl:template>		
	
    <xsl:template match="//segment">
		<xsl:choose>
			<xsl:when test="@features='pos'">
				<sentence>
					<xsl:apply-templates select="node()" />
				</sentence>					
			</xsl:when>
			<xsl:otherwise>
				<segment>
					<xsl:attribute name="pos">
						<xsl:choose>
							<xsl:when test="@features='pos;verb'">verb</xsl:when>
							<xsl:when test="@features='pos;noun'">noun</xsl:when>
							<xsl:when test="@features='pos;preposition'">preposition</xsl:when>						
						</xsl:choose>
					</xsl:attribute>
					<xsl:apply-templates select="node()" />
				</segment>		          
			</xsl:otherwise>	
		</xsl:choose>
    </xsl:template>		
</xsl:stylesheet>