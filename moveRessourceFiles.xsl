<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:h="http://www.utc.fr/ics/hdoc/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    >

    <property file="global.properties"/>
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <!-- This template matches the root and create a ANT project, the root of any ANT buildfile. -->
    <xsl:template match="h:html">
        <project name="moveRessourceFiles" basedir="." default="moveRessourceFiles">
            <target name="moveRessourceFiles">
                <xsl:apply-templates select="./*"/>
            </target>
        </project>
    </xsl:template>

    <!-- These templates guides XSL's motor. -->
    <xsl:template match="h:body">
        <xsl:apply-templates select="./h:section"/>
    </xsl:template>
    <xsl:template match="h:section">
        <xsl:apply-templates select="./h:section | ./h:div"/>
    </xsl:template>
    <xsl:template match="h:div">
        <xsl:apply-templates select="./h:img | ./h:audio | ./h:video | ./h:object"/>
    </xsl:template>

    <!-- Targeted markups. -->
    <xsl:template match="h:img">
        <copy tofile="${{tmpdir}}/decompressedOpale/res/{./@src}" file="${{tmpdir}}/decompressedHdoc/{./@src}"/>
    </xsl:template>
    <xsl:template match="h:audio">
        <copy tofile="${{tmpdir}}/decompressedOpale/res/{./@src}" file="${{tmpdir}}/decompressedHdoc/{./@src}"/>
    </xsl:template>
    <xsl:template match="h:video">
        <copy tofile="${{tmpdir}}/decompressedOpale/res/{./@src}" file="${{tmpdir}}/decompressedHdoc/{./@src}"/>
    </xsl:template>
    <xsl:template match="h:object">
        <copy tofile="${{tmpdir}}/decompressedOpale/res/{./@data}" file="${{tmpdir}}/decompressedHdoc/{./@data}"/>
    </xsl:template>
    
    <!-- These markups are matched in order to minimize "apply-templates" side-effects (i.e. their contents are not relevant for this transformation). -->
    <xsl:template match="h:head"/>
    <xsl:template match="h:p"/>
    <xsl:template match="h:em"/>
    <xsl:template match="h:i"/>
    <xsl:template match="h:span"/>
    <xsl:template match="h:a"/>
    <xsl:template match="h:ul"/>
    <xsl:template match="h:ol"/>
    <xsl:template match="h:li"/>
    <xsl:template match="h:table"/>
</xsl:stylesheet>