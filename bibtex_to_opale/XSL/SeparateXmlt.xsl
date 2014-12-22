<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:bib="http://www.utc.fr/ics/hdoc/bibtexXm"
    xmlns:op="utc.fr:ics/opale3">
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    <xsl:param name="in"/>
    <xsl:param name="out"/>
    <xsl:template match="bib:file">
        <project basedir=".." name="ref"> 
            <xsl:apply-templates select="bib:entry"></xsl:apply-templates>
        </project>
    </xsl:template>
    <xsl:template match="bib:entry">
        <xslt xslresource="./XSL/OneBibXMLToOpaleXml.xsl">
            <xsl:attribute name="in"><xsl:value-of select="$in"/></xsl:attribute>
            <xsl:attribute name="out"><xsl:value-of select="$out"/>/<xsl:value-of select="./@id"/>.ref</xsl:attribute>
            <param name="Position">
                <xsl:attribute name="expression"><xsl:value-of select="count(preceding-sibling::bib:entry) + 1"/></xsl:attribute>
            </param>
        </xslt>
    </xsl:template>

    <xsl:template match="dc:metadata" xmlns:dc="http://purl.org/dc/elements/1.1/">
        
    </xsl:template>
</xsl:stylesheet>

