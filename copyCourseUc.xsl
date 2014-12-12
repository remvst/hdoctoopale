<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:h="http://www.utc.fr/ics/hdoc/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
  xmlns:op="utc.fr:ics/opale3"
  xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
  >
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <!-- The ID of the courseUc element that needs to be copied has to be passed here -->
  <xsl:param name="elementid" xsl:required="yes" xsl:as="xsl:string"/>

  <xsl:template match="sc:item">
    <xsl:apply-templates select=".//sp:courseUc"/>
  </xsl:template>

  <xsl:template match="sp:courseUc[@data-export-id = $elementid]">
    <sc:item>
      <!-- Once we are in the right courseUc, we can just copy everything -->
      <xsl:copy-of select="./*"/> 
    </sc:item>
  </xsl:template>

  <xsl:template match="*"/>
</xsl:stylesheet>