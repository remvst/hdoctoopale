<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:h="http://www.utc.fr/ics/hdoc/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
  xmlns:op="utc.fr:ics/opale3"
  xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
  >
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:template match="sc:item">
    <project name="copy-ucs" default="main">
      <taskdef name="jing" classname="com.thaiopensource.relaxng.util.JingTask">
        <classpath>
          <pathelement location="lib/jing.jar"/>
        </classpath>
      </taskdef>

      <property file="global.properties"/>

      <target name="main">
        <xsl:apply-templates select=".//sp:courseUc"/>
      </target>
    </project>
  </xsl:template>

  <xsl:template match="sp:courseUc">
    <xslt
        in="${{tmpdir}}/outputWithCourseUcIds.xml"
        out="${{tmpdir}}/decompressedOpaleDivided/{@data-export-file}"
        style="copyCourseUc.xsl"
        processor="org.apache.tools.ant.taskdefs.optional.TraXLiaison"
    >

      <param name="elementid" expression="{@data-export-id}"/>
    </xslt>

    <jing file="${{tmpdir}}/decompressedOpaleDivided/{@data-export-file}" rngfile="schema/op_expUc.rng"></jing>

  </xsl:template>
</xsl:stylesheet>