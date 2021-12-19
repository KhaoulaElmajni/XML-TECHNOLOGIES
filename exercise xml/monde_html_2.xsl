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
                    background-color:#00AA00;
                    }
                    .th:hover,tr:hover{
                    background-color:#AABBEE;
                    }
                    .even{
                    background-color:#EEDD00;
                    }
                    .odd{
                    background-color : #AAFFCC;
                    }
                    
                    .container {
                    display: flex;
                    flex-flow: column wrap;
                    margin: 5%;
                    padding: 1%;
                    width: 100vw;
                    }
                    
                    .bar {
                    flex-grow: 1;
                    margin: 2%;
                    padding: 1%;
                    height: 4vh;
                    text-align: center;
                    }
                    
                    .b1 {
                    background-color: orange;
                    flex-grow: 0;
                    width: 100%;
                    }
                    
                    .b2 {
                    background-color: red;
                    flex-grow: 0;
                    width: 70%;
                    }
                    
                    .b3 {
                    background-color: green;
                    flex-grow: 0;
                    width: 80%;
                    }
                    
                    .b4 {
                    background-color: blue;
                    flex-grow: 0;
                    width: 30%;
                    }
                    
                </style>
                <!-- CSS only -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"/>
            </head>
            <body align="center">
                <h1 class="a" align="center">TP XML, DTD, XSL, DOM, SVG</h1>
                <div class="container">
                    
                    <table border="2" cellpadding="4" class="table table-bordered" width="100%">
                        <thead class="th">
                            <tr align="center">
                                <th >Numéro</th>
                                <th >Pays</th>
                                <th >Capitale</th>
                                <th >Villes</th>
                                <th>Poulation</th>
                            </tr>
                        </thead>
                        
                        <xsl:for-each select="*/pays"> 
                            
                            <xsl:sort select="population"  data-type="number" order="descending"/>
                            <xsl:variable name="cls" >
                                <xsl:choose>
                                    <xsl:when test="position() mod 2 = 0">even</xsl:when>
                                    <xsl:otherwise>odd</xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:variable name="capitale" select="@capital"/>
                            <tr class="{$cls}" align="center">
                                <!-- <xsl:attribute name="class" select="$cls"></xsl:attribute> -->
                                <td> 
                                    <xsl:value-of select="position()"/> 
                                </td>
                                <td>
                                    <xsl:value-of select="nom"/> 
                                    
                                </td>
                                <td>
                                    <xsl:value-of select="capitale"/>  
                                    
                                </td>
                                <td>
                                    <select>
                                        <xsl:for-each select=".//ville">
                                            <option>
                                                <xsl:value-of select="nom"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                    
                                </td>
                               <td>
                                   <xsl:variable name="muslim" select="religions/musulmans/@pourcentage"></xsl:variable>
                                   <xsl:variable name="cretien" select="religions/cretien/@pourcentage"></xsl:variable>
                                   <xsl:variable name="juif" select="religions/juif/@pourcentage"></xsl:variable>
                                   <xsl:variable name="autre" select="religions/autre/@pourcentage"></xsl:variable>
                                   <div class="container">
                                       <div class="bar b1" style="width={$muslim}%" >musulmans</div>
                                       <div class="bar b2">cretiens</div>
                                       <div class="bar b3">juifs</div>
                                       <div class="bar b4">autres</div>
                                   </div>
                               </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                    
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>