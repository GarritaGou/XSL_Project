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
			<xsl:when test="@features='verbtenses'">
				<sentence>
					<xsl:apply-templates select="node()" />
				</sentence>					
			</xsl:when>
			<xsl:otherwise>
				<segment>
					<xsl:attribute name="verbtenses">
						<xsl:choose>
							<xsl:when test="@features='verbtenses;simple_present'">simple_present</xsl:when>
							<xsl:when test="@features='verbtenses;present_perfect'">present_perfect</xsl:when>
							<xsl:when test="@features='verbtenses;present_continuous'">present_continuous</xsl:when>
							<xsl:when test="@features='verbtenses;simple_past'">simple_past</xsl:when>							
						</xsl:choose>
					</xsl:attribute>
					<xsl:apply-templates select="node()" />
				</segment>		          
			</xsl:otherwise>	
		</xsl:choose>
    </xsl:template>	
	
	
	
</xsl:stylesheet>