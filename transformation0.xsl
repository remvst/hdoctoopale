<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:c="urn:utc.fr:ics:hdoc:container"
    >
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
	
    <xsl:template match="c:container">
        <project name="getContentFileAndTransformIt" basedir="." default="start">
            <property file="global.properties"/>

            <taskdef name="jing" classname="com.thaiopensource.relaxng.util.JingTask">
                <classpath>
                    <pathelement location="lib/jing.jar"/>
                </classpath>
            </taskdef>

            <xsl:apply-templates select="./c:rootfiles"/>
        </project>
    </xsl:template>
    
    <xsl:template match="c:rootfiles">
        <target name="start">
            <jing file="${{tmpdir}}/decompressedHdoc/{c:rootfile/@full-path}" rngfile="schema/hdoc1-xhtml.rng"></jing>

            <xslt
                in="${{tmpdir}}/decompressedHdoc/{c:rootfile/@full-path}"
                out="${{tmpdir}}/moveRessourceFiles.xml"
                style="moveRessourceFiles.xsl"
                processor="org.apache.tools.ant.taskdefs.optional.TraXLiaison"
            />
            <chmod file="${{tmpdir}}/moveRessourceFiles.xml" perm="777"/>
            <xslt
                in="${{tmpdir}}/decompressedHdoc/{c:rootfile/@full-path}"
                out="${{tmpdir}}/decompressedOpale/main.xml"
                style="transformation2.xsl"
                processor="org.apache.tools.ant.taskdefs.optional.TraXLiaison"
            />
            <chmod file="${{tmpdir}}/decompressedOpale/main.xml" perm="777"/>
        </target>
    </xsl:template>
</xsl:stylesheet>