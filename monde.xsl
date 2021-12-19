<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:decimal-format name="pop" decimal-separator="," grouping-separator=" "/>
    <xsl:template match="/">
        <monde >
            <xsl:for-each select="*/country"> 
                <xsl:variable name="continent" select="encompassed/@continent"></xsl:variable>
                <xsl:variable name="code" select="@car_code"></xsl:variable>
               
                <pays continent="{$continent}" code="{$code}">
                    <nom>
                        <xsl:value-of select="name"/> 
                    </nom>
                    <xsl:variable name="capital" select="@capital"></xsl:variable>
                    <capitale><xsl:value-of select=".//city[@id=$capital]/name"></xsl:value-of></capitale>
                    <xsl:variable name="annee" select="population[last()]/@year"></xsl:variable>
                    <xsl:variable name="population" select="population[last()]"></xsl:variable>
                    <population annnee="{$annee}">
                        <xsl:value-of select="population[last()]"/>
                    </population>
                    
                    <religions>
                        <xsl:variable name="pourcent" select="religion[.='Muslim']/@percentage"></xsl:variable>
                        <musulmans pourcentage="{$pourcent}">
                            <xsl:variable name="muslim" select="religion[.='Muslim']/(@percentage div 100)*population[last()]"></xsl:variable>
                            <xsl:choose>
                                <xsl:when test="religion = 'Muslim'">
                                    <xsl:value-of select="format-number($muslim, '# ##0','pop')"/>
                                </xsl:when>
                                <xsl:otherwise>0</xsl:otherwise>
                            </xsl:choose>
                        </musulmans>
                        
                        <xsl:variable name="pourcent" select="sum(religion[.='Christian Orthodox' or .='Catholic'or  .='Protestant']/@percentage)"></xsl:variable>
                        <cretien pourcentage="{$pourcent}">
                            <xsl:variable name="cretienOrtho" select="religion[.='Christian Orthodox']/(@percentage div 100)"></xsl:variable>
                            <xsl:variable name="catholic" select="religion[.='Catholic']/(@percentage div 100)"></xsl:variable>
                            <xsl:variable name="protestant" select="religion[.='Protestant']/(@percentage div 100)"></xsl:variable>
                            <xsl:variable name="population" select="population[last()]"></xsl:variable>
                            
                            
                            <xsl:variable name="cretien" select="round($cretienOrtho * $population)+round($catholic * $population)+round($protestant* $population)"></xsl:variable>
                            <xsl:choose>
                                <xsl:when test="religion[text()='Christian Orthodox' or text()='Catholic' or text()='Protestant']" >
                                    <xsl:value-of select="format-number($cretien, '# ##0','pop')"/>
                                </xsl:when>
                                <xsl:otherwise>0</xsl:otherwise>
                            </xsl:choose>
                        </cretien>
                        
                        <xsl:variable name="pourcent" select="religion[.='Jewish']/@percentage"></xsl:variable>
                        <juif pourcentage="{$pourcent}">
                            <xsl:variable name="jewish" select="religion[text()='Jewish']/(@percentage div 100)*population[last()]"></xsl:variable>
                            <xsl:choose>
                                <xsl:when test="religion[.='Jewish']" >
                                    <xsl:value-of select="format-number($jewish, '# ##0','pop')"/>
                                </xsl:when>
                                <xsl:otherwise>0</xsl:otherwise>
                            </xsl:choose>
                        </juif>
                        
                        <xsl:variable name="pourcent" select="sum(religion[.!= 'Jewish'][ .!='Muslim'][.!='Christian Orthodox'][.!='Catholic'][.!='Protestant']/@percentage)"></xsl:variable>
                        <autre pourcentage="{$pourcent}">
                            <xsl:variable name="autre" select="sum(.//religion[.!= 'Jewish'][ .!='Muslim'][.!='Christian Orthodox'][.!='Catholic'][.!='Protestant']/(@percentage div 100 * ../population[last()]))"></xsl:variable>
                            <xsl:choose>
                                <xsl:when test="religion[text()!='Jewish'][text()!='Muslim']" >
                                    <xsl:value-of select="format-number($autre, '# ##0','pop')"/>
                                </xsl:when>
                                <xsl:otherwise>0</xsl:otherwise>
                            </xsl:choose>
                            
                        </autre>
                    </religions>
                    
                    <xsl:for-each select="city">
                        <ville>
                            <nom>
                                <xsl:value-of select="name[1]"/>
                            </nom>
                            <logitude>
                                <xsl:value-of select="longitude"></xsl:value-of>
                            </logitude>
                            <latitude>
                                <xsl:value-of select="latitude"></xsl:value-of>
                            </latitude>
                        </ville>
                    </xsl:for-each>
                    
                    
                    <xsl:choose>
                        <xsl:when test="count(border)>0" >
                           <xsl:for-each select="border">
                               <xsl:variable name="pays" select="@country"></xsl:variable>
                               <xsl:variable name="longueur" select="@length"></xsl:variable>
                               <frontiere pays="{$pays}" longueur="{$longueur}"></frontiere>
                           </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            
                        </xsl:otherwise>
                    </xsl:choose>
                    
                </pays>
            </xsl:for-each>
        </monde>
    </xsl:template>
</xsl:stylesheet>