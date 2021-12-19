<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:decimal-format name="pop" decimal-separator="," grouping-separator=" "/>
    <xsl:template match="/">
        <html>
            <head>
                <title>XSL TEST</title>
                <style>
                    body{
                    font: italic 1.1em "Fira Sans", serif;
                    }
                    .a{
                    color: red;
                    }
                    .th{
                    color: black;
                    background-color:#AAFFCC;
                    }
                    .th:hover,tr:hover{
                    background-color:#AABBEE;
                    }
                    .even{
                    background-color:#EEDDAA;
                    }
                    .odd{
                    background-color : #FFAAAA;
                    }
                    
                </style>
                <!-- CSS only -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"/>
            </head>
            <body align="center">
                <h1 class="a" align="center">Bonjour XSL</h1>
                <h1 class="a" align="center">TP XPATH XSLT</h1>
                <div class="container">
                
                <table border="2" cellpadding="4" class="table table-bordered" width="100%">
                    <thead class="th">
                        <tr align="center">
                            <th >Numéro</th>
                            <th >Pays</th>
                            <th >Capital</th>
                            <th>Population</th>
                            <th >Villes</th>
                            <th >Muslims</th>
                            <th >Jewish</th>
                            <th >Others</th>
                       </tr>
                    </thead>
                    
                    <xsl:for-each select="*/country"> 
                        
                        <xsl:sort select="population[last()]"  data-type="number" order="descending"/>
                        <xsl:variable name="cls" >
                            <xsl:choose>
                                <xsl:when test="position() mod 2 = 0">even</xsl:when>
                                <xsl:otherwise>odd</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="capital" select="@capital"/>
                        <tr class="{$cls}" align="center">
                            <!-- <xsl:attribute name="class" select="$cls"></xsl:attribute> -->
                            <td> 
                                <xsl:value-of select="position()"/> 
                            </td>
                            <td>
                                <xsl:value-of select="name"/> 
                                
                            </td>
                            <td>
                                <xsl:value-of select=".//city[@id=$capital]/name"/>  
                                
                            </td>
                            
                            <td align="right">
                                <span class="pop">
                                    <xsl:value-of select="format-number(population[last()],'# ##0,##','pop')"/>
                                </span>
                            </td>
                            <td>
                                <select>
                                    <xsl:for-each select=".//city">
                                        <option>
                                            <xsl:value-of select="name[1]"/>
                                        </option>
                                    </xsl:for-each>
                                </select>
                                
                            </td>
                            <td>
                                <xsl:variable name="muslim" select="religion[.='Muslim']/(@percentage div 100)*population[last()]"></xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="religion = 'Muslim'">
                                        <xsl:value-of select="format-number($muslim, '# ##0','pop')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        0
                                    </xsl:otherwise>
                                </xsl:choose>
                                
                            </td>
                            <td>
                                <xsl:variable name="jewish" select="xs:int(.//religion[text()='Jewish']/(@percentage div 100)*population[last()])"></xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="religion[.='Jewish']" >
                                        <xsl:value-of select="format-number($jewish, '# ##0','pop')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        0
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                            <td align="center">
                                <xsl:variable name="other" select="xs:int(sum(.//religion[.!= 'Jewish'][ .!='Muslim']/(@percentage div 100 * ../population[last()])))"></xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="religion[.!= 'Jewish'][ .!='Muslim']" >
                                            <xsl:value-of select="format-number($other, '# ##0','pop')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            0
                                        </xsl:otherwise>
                                    </xsl:choose>              
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
                    
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>