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
    <xsl:param name="lcletters">abcdefghijklmnopqrstuvwxyzeeeeaaaa</xsl:param>
    <xsl:param name="ucletters">ABCDEFGHIJKLMNOPQRSTUVWXYZéèêëàâàá</xsl:param>
    <xsl:param name="text"/>
    <xsl:value-of select="translate($text,$ucletters,$lcletters)"/>
  </xsl:template>

  <xsl:template name="string-to-slug">
    <xsl:param name="text" select="''" />
    <xsl:variable name="dodgyChars" select="' ,.#_-!?*:;=+&#10;/(){}'" />
    <xsl:variable name="replacementChar" select="'------------------'" />

    <xsl:variable name="oneline">
      <xsl:value-of select="normalize-space(translate($text,'&#10;',''))"/>
    </xsl:variable>

    <xsl:variable name="lowercased"><xsl:call-template name="string-to-lowercase"><xsl:with-param name="text" select="$oneline" /></xsl:call-template></xsl:variable>
    <xsl:variable name="escaped"><xsl:value-of select="translate( $lowercased, $dodgyChars, $replacementChar )" /></xsl:variable>

    <xsl:variable name="cleaned">
      <xsl:call-template name="string-replace-caller">
        <xsl:with-param name="text" select="$escaped" />
        <xsl:with-param name="replace" select="'---'" />
        <xsl:with-param name="by" select="'-'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="$cleaned" />
  </xsl:template>

  <xsl:template name="string-replace-all">
   <xsl:param name="text"/>
   <xsl:param name="replace"/>
   <xsl:param name="by"/>
   <xsl:choose>
     <xsl:when test="contains($text,$replace)">
       <xsl:value-of select="substring-before($text,$replace)"/>
       <xsl:value-of select="$by"/>
       <xsl:call-template name="string-replace-all">
         <xsl:with-param name="text" select="substring-after($text,$replace)"/>
         <xsl:with-param name="replace" select="$replace"/>
         <xsl:with-param name="by" select="$by"/>
       </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
       <xsl:value-of select="$text"/>
     </xsl:otherwise>
   </xsl:choose>
  </xsl:template> 

  <xsl:template name="string-replace-caller">
   <xsl:param name="text"/>
   <xsl:param name="replace"/>
   <xsl:param name="by"/>

   <xsl:variable name="changed">
     <xsl:choose>
       <xsl:when test="contains($text,$replace)">
         <xsl:call-template name="string-replace-all">
           <xsl:with-param name="text" select="$text"/>
           <xsl:with-param name="replace" select="$replace"/>
           <xsl:with-param name="by" select="$by"/>
         </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
         <xsl:value-of select="$text"/>
       </xsl:otherwise>
     </xsl:choose>
    </xsl:variable>

    <xsl:choose>
       <xsl:when test="contains($changed,$replace)">
         <xsl:call-template name="string-replace-caller">
           <xsl:with-param name="text" select="$changed"/>
           <xsl:with-param name="replace" select="$replace"/>
           <xsl:with-param name="by" select="$by"/>
         </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
         <xsl:value-of select="$changed"/>
       </xsl:otherwise>
     </xsl:choose>
  </xsl:template> 



  <xsl:template match="sp:courseUc">
  	<sp:courseUc>
      <xsl:variable name="slug">
        <xsl:call-template name="string-to-slug">
          <xsl:with-param name="text" select="op:expUc/op:uM/sp:title"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="id">
        <xsl:value-of select="count(preceding::sp:courseUc)+1"/>
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