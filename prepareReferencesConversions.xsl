<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:h="http://www.utc.fr/ics/hdoc/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
  xmlns:op="utc.fr:ics/opale3"
  xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
  >
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:template match="h:html">
    <project name="copy-references" default="main">
      <property file="global.properties"/>

      <target name="main">
        <mkdir dir="${{tmpdir}}/decompressedOpale/references" />

        <xsl:apply-templates select=".//h:a[@data-hdoc-type = 'bibtexml']"/>
      </target>
    </project>
  </xsl:template>


  <xsl:template match="h:a[@data-hdoc-type = 'bibtexml']">
    <!-- bibtex_to_opale needs the file to be in a specific folder, so let's copy it to the right place (it'd be better to modify bibtex_to_opale instead) -->
    <copy file="${{tmpdir}}/decompressedHdoc/{substring-before(@href,'#')}" tofile="${{basedir}}/bibtex_to_opale/tmp/tmpHdocBib.xml"/>

    <!-- Let's call bibtex_to_opale that will create a scar containing all references (*.ref) -->
    <ant antfile="${{basedir}}/bibtex_to_opale/Ant/bibtex_to_opale.ant" target="convertfrombibxml">
      <property name="basedir" value="${{basedir}}/bibtex_to_opale"/>
      <property name="OutputPath" value="refs.scar"/>
    </ant>

    <!-- Creating the directory to unzip to -->
    <mkdir dir="${{tmpdir}}/decompressedOpale/references/{substring-before(@href,'.')}"/>

    <!-- Unzipping that .scar -->
    <unzip src="${{basedir}}/bibtex_to_opale/refs.scar" dest="${{tmpdir}}/decompressedOpale"/>

    <!-- Moving the files to the right place (because bibtex_to_opale creates a ref/folder) -->
    <move file="${{tmpdir}}/decompressedOpale/ref" tofile="${{tmpdir}}/decompressedOpale/references/{substring-before(@href,'.')}"/>

    <!-- Now, we only have to make sure that the references made within transformation2.xsl will point towards the right files that were created by bibtex_to_opale -->
  </xsl:template>

  <xsl:template match="*"/>

</xsl:stylesheet>