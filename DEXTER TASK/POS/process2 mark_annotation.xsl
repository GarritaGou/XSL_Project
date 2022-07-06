<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="iso-8859-1" indent="yes"/>

	<xsl:key name="grammar" match="sent" use="@id"/> 	

	<xsl:template match="/">			
		<document>						
			<body>						
				<xsl:for-each select="//p"> 	>
					<paragraph>
						<sentence>
							<xsl:variable name="text" select="seg"/> 				
							<xsl:variable name="sentence_id" select="seg/@id"/>		
							<xsl:attribute name="id">								
								<xsl:value-of select="$sentence_id"/>
							</xsl:attribute>

							<xsl:variable name="count">								
								<xsl:call-template name="CountTags">				
									<xsl:with-param name="id" select="$sentence_id"/> 
								</xsl:call-template>
							</xsl:variable>
							


							<xsl:choose>
								<xsl:when test="$count > 0">														
									<xsl:variable name="constructions" select="key('grammar', $sentence_id)" />	 									
									<xsl:variable name="sorted_start" as="element()*"> 
										<xsl:for-each select="$constructions">				
											<xsl:sort select="@start" data-type="number"/>
											<index><xsl:value-of select="@start"/></index>  
										</xsl:for-each>
									</xsl:variable>									
											
									<xsl:call-template name="TagText">									
										<xsl:with-param name="text" select="$text"/> 			
										<xsl:with-param name="constructions" select="$constructions"/> 
										<xsl:with-param name="sorted_start" select="$sorted_start"/> 
										<xsl:with-param name="num" select="1"/>						
										<xsl:with-param name="count" select="$count"/>				
										<xsl:with-param name="new_start" select="0"/>			
									</xsl:call-template>										
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$text"/>		
								</xsl:otherwise>
							</xsl:choose>

						</sentence>
					</paragraph>
				</xsl:for-each>
			</body>
		</document>
	</xsl:template>

	<xsl:template name="CountTags">					
		<xsl:param name="id"/>						
		<xsl:value-of select="count(//data/sent[@id = $id])"/>	
	</xsl:template>
	
	<xsl:template name="TagText">											
		<xsl:param name="text" />	
		<xsl:param name="constructions" />
		<xsl:param name="sorted_start" />
		<xsl:param name="num" />
		<xsl:param name="count" />
		<xsl:param name="new_start" />		
		
		<xsl:variable name="pos" select="$sorted_start[$num]"/>																	
		<xsl:variable name="input" select="$constructions[@start=$pos]"/>	
		
		<xsl:variable name="function" select="$input/@function"/>			
		<xsl:variable name="start_index" select="$input/@start"/>			
		<xsl:variable name="end_index" select="$input/@end"/>				
		<xsl:variable name="length" select="$end_index - $start_index + 1"/>
		<xsl:variable name="target" select="substring($text, $start_index - $new_start, $length)"/>		
		
		<xsl:value-of select="substring-before($text, $target)"/>		
		<segment>
			<xsl:attribute name="function">
				<xsl:value-of select="$function"/>							
			</xsl:attribute>
			<xsl:value-of select="$target"/>
		</segment>
		
		<xsl:choose>
			<xsl:when test="$num=$count">											
				<xsl:value-of select="substring-after($text, $target)"/>			
			</xsl:when>	
			<xsl:otherwise>
				<xsl:call-template name="TagText">
					<xsl:with-param name="text" select="substring-after($text, $target)"/>
					<xsl:with-param name="constructions" select="$constructions"/>
					<xsl:with-param name="sorted_start" select="$sorted_start"/>
					<xsl:with-param name="num" select="$num + 1"/>
					<xsl:with-param name="count" select="$count"/>
					<xsl:with-param name="new_start" select="$end_index"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>				
	</xsl:template>	

</xsl:stylesheet>
