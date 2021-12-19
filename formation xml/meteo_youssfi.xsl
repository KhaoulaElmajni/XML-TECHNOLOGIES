<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes"/>
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
           <polyline points="20,20,20,600,650,600" fill="none" stroke="blue" stroke-width="2"/>
           <text x="20" y="20" font-size="12" stroke="blue">(20,20)</text>
           <xsl:for-each select="meteo/mesure[@date='2006-1-1']">
                <xsl:for-each select="ville">
                    <text x="{position()*80}" y="615" font-size="15" stroke="black">
                        <xsl:value-of select="@nom"/>
                    </text>
                    <rect x="{position()*80}" y="{600-@temperature *10}" width="10" height="{@temperature*10}" fill="pink" stroke="blue" 
                        stroke-width="1">
                        <animate attributeName="height" dur="2s" from="0" to="{@temperature*10}"></animate>
                        <animate attributeName="y" dur="2s" from="600" to="{600-@temperature *10}" ></animate>
                    </rect>
                </xsl:for-each>
           </xsl:for-each>
        </svg>
    </xsl:template>
</xsl:stylesheet>