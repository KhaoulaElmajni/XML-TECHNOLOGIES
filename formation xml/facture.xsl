<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:decimal-format decimal-separator="," grouping-separator=" " name="frm"/>
    <xsl:template match="/">
        <html>
            <head>
                <title></title>
                <style>
                    body{
                    font: italic 1.2em "Fira Sans", serif;
                    }
                    th{
                    background-color: #AABBCC;
                    }
                    tr{
                    background-color:#FFFFCC;
                    }
                </style>
            </head>
            <body>
                <table border="1" cellpadding="6" cellspacing="6" class="table table-striped" width="50%">
                    <thead>
                        <tr>
                            <th>Numéro</th>
                            <th>Designation</th>
                            <th>Prix</th>
                            <th>Quantite</th>
                            <th>Sous total</th>
                        </tr>
                    </thead>
                    <xsl:for-each select="//facture/produit">
                        <tr>
                            <td align="center"><xsl:value-of select="position()"></xsl:value-of></td>
                            <td><xsl:value-of select="designation"></xsl:value-of></td>
                            <td align="right"><xsl:value-of select="format-number(prix,'# ##0,00','frm')"></xsl:value-of></td>
                            <td align="right"><xsl:value-of select="format-number(quantite,'# ##0,00','frm')"></xsl:value-of></td>
                            <td align="right"><xsl:value-of select="format-number(prix * quantite,'# ##0,00','frm')"></xsl:value-of></td>
                        
                        </tr>
                    </xsl:for-each>
                    <tr>
                        <td colspan="3" align="right">Total</td>
                        <td colspan="2" align="center">
                            <xsl:call-template name="total">
                                <xsl:with-param name="produits" select="facture/produit"></xsl:with-param>
                                <xsl:with-param name="initial" select="0"></xsl:with-param>
                            </xsl:call-template>
                        </td>
                    </tr>
                </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="total">
        <xsl:param name="produits"/>
        <xsl:param name="initial"/>
        <xsl:variable name="produit" select="$produits[1]"></xsl:variable>
        
            <xsl:choose>
                <xsl:when test="count($produits) > 0">
                    <xsl:call-template name="total">
                        <xsl:with-param name="produits" select="$produits[position()!=1]"></xsl:with-param>
                        <xsl:with-param name="initial" select="$initial + $produit/prix * $produit/quantite"></xsl:with-param>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$initial"></xsl:value-of>
                </xsl:otherwise>
            </xsl:choose> 
        
    </xsl:template>
</xsl:stylesheet>