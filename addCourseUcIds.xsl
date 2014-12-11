<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:h="http://www.utc.fr/ics/hdoc/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
  xmlns:op="utc.fr:ics/opale3"
  xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
  >
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template name="string-to-lowercase">
    <xsl:param name="lcletters">abcdefghijklmnopqrstuvwxyz</xsl:param>
    <xsl:param name="ucletters">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:param>
    <xsl:param name="text"/>
    <xsl:value-of select="translate($text,$ucletters,$lcletters)"/>
  </xsl:template>

  <xsl:template name="string-to-slug">
    <xsl:param name="text" select="''" />
    <xsl:variable name="dodgyChars" select="' ,.#_-!?*:;=+'" />
    <xsl:variable name="replacementChar" select="'------------'" />
    <xsl:variable name="lowercased"><xsl:call-template name="string-to-lowercase"><xsl:with-param name="text" select="$text" /></xsl:call-template></xsl:variable>
    <xsl:variable name="escaped"><xsl:value-of select="translate( $lowercased, $dodgyChars, $replacementChar )" /></xsl:variable>
    <xsl:value-of select="$escaped" />
  </xsl:template>



  <xsl:template match="sp:courseUc">
  	<sp:courseUc>
      <xsl:variable name="slug">
        <xsl:call-template name="string-to-slug">
          <xsl:with-param name="text" select="op:expUc/op:uM/sp:title"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="id">
        <xsl:value-of select="count(preceding::sp:courseUc[not(preceding::sp:courseUc= .)])+1"/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="$slug"/>
      </xsl:variable>

      <xsl:attribute name="data-export-id">
        <xsl:text>uoc-</xsl:text>
        <xsl:value-of select="$id" />
      </xsl:attribute>

      <xsl:attribute name="data-export-file">unit-<xsl:value-of select="$id"/>.xml</xsl:attribute>

      <xsl:apply-templates select="@*|node()" />
    </sp:courseUc>
  </xsl:template>

</xsl:stylesheet>