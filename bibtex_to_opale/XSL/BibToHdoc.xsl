<?xml version="1.0" encoding="iso-8859-1"?>
<!-- This sheet replaces the url of a namespace where needed -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oldmods="http://bibtexml.sf.net/"
    xmlns:myns="http://www.utc.fr/ics/hdoc/bibtexXm">
    
    <xsl:template match="node()|@*" priority="3">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*">
            </xsl:apply-templates></xsl:copy>
    </xsl:template>
     
    <xsl:template match="
        oldmods:file | oldmods:entry | 
        oldmods:entry/oldmods:article | oldmods:entry/oldmods:book | oldmods:entry/oldmods:booklet | oldmods:entry/oldmods:conference |
        oldmods:entry/oldmods:manual | oldmods:entry/oldmods:techreport | oldmods:entry/oldmods:mastersthesis |
        oldmods:entry/oldmods:phdthesis | oldmods:entry/oldmods:inbook | oldmods:entry/oldmods:incollection |
        oldmods:entry/oldmods:proceedings | oldmods:entry/oldmods:unpublished | oldmods:entry/oldmods:misc |
        oldmods:article/oldmods:title | oldmods:article/oldmods:author | oldmods:article/oldmods:journal |
        oldmods:article/oldmods:volume | oldmods:article/oldmods:number | oldmods:article/oldmods:pages |
        oldmods:book/oldmods:author | oldmods:book/oldmods:editor | oldmods:book/oldmods:title |
        oldmods:book/oldmods:publisher | oldmods:book/oldmods:volume | oldmods:book/oldmods:number | 
        oldmods:book/oldmods:series | oldmods:book/oldmods:address | oldmods:book/oldmods:edition |
        oldmods:booklet/oldmods:title | oldmods:booklet/oldmods:author | oldmods:booklet/oldmods:howpublished |
        oldmods:booklet/oldmods:address | oldmods:booklet/oldmods:key | oldmods:booklet/oldmods:howpublished |
        oldmods:book/oldmods:adress | oldmods:book/oldmods:month | oldmods:book/oldmods:year |
        oldmods:inbook/oldmods:chapter | oldmods:inbook/oldmods:pages | oldmods:inbook/oldmods:publisher |
        oldmods:inbook/oldmods:series | oldmods:inbook/oldmods:type | oldmods:inbook/oldmods:address |
        oldmods:inbook/oldmods:edition |
        oldmods:manual/oldmods:title | oldmods:manual/oldmods:author | oldmods:manual/oldmods:editor | oldmods:manual/oldmods:volume |
        oldmods:manual/oldmods:number | oldmods:manual/oldmods:series | oldmods:manual/oldmods:pages | oldmods:manual/oldmods:organization |
        oldmods:manual/oldmods:address | oldmods:manual/oldmods:edition | oldmods:manual/oldmods:key |
        oldmods:techreport/oldmods:author | oldmods:techreport/oldmods:title | oldmods:techreport/oldmods:institution |
        oldmods:techreport/oldmods:type | oldmods:techreport/oldmods:number | oldmods:techreport/oldmods:address |
        oldmods:techreport/oldmods:key |
        oldmods:mastersthesis/oldmods:author | oldmods:mastersthesis/oldmods:title |
        oldmods:mastersthesis/oldmods:school | oldmods:mastersthesis/oldmods:year | oldmods:mastersthesis/oldmods:type |
        oldmods:mastersthesis/oldmods:address | oldmods:mastersthesis/oldmods:key |
        oldmods:phdthesis/oldmods:author | oldmods:phdthesis/oldmods:title |
        oldmods:phdthesis/oldmods:school | oldmods:phdthesis/oldmods:year | oldmods:phdthesis/oldmods:type |
        oldmods:phdthesis/oldmods:address | oldmods:phdthesis/oldmods:key |
        oldmods:inbook/oldmods:author | oldmods:inbook/oldmods:editor | oldmods:inbook/oldmods:title |
        oldmods:inbook/oldmods:chapter | oldmods:inbook/oldmods:pages | oldmods:inbook/oldmods:publisher |
        oldmods:inbook/oldmods:volume | oldmods:inbook/oldmods:number | oldmods:inbook/oldmods:series |
        oldmods:inbook/oldmods:type | oldmods:inbook/oldmods:address | oldmods:inbook/oldmods:edition | oldmods:inbook/oldmods:key |
        oldmods:incollection/oldmods:author | oldmods:incollection/oldmods:title | oldmods:incollection/oldmods:booktitle |
        oldmods:incollection/oldmods:publisher | oldmods:incollection/oldmods:editor | oldmods:incollection/oldmods:volume |
        oldmods:incollection/oldmods:number | oldmods:incollection/oldmods:series | oldmods:incollection/oldmods:type |
        oldmods:incollection/oldmods:chapter | oldmods:incollection/oldmods:pages | oldmods:incollection/oldmods:address |
        oldmods:incollection/oldmods:edition | oldmods:incollection/oldmods:key |
        oldmods:proceedings/oldmods:title | oldmods:proceedings/oldmods:year | oldmods:proceedings/oldmods:editor |
        oldmods:proceedings/oldmods:volume | oldmods:proceedings/oldmods:number | oldmods:proceedings/oldmods:series |
        oldmods:proceedings/oldmods:address | oldmods:proceedings/oldmods:publisher | oldmods:proceedings/oldmods:organization |
        oldmods:proceedings/oldmods:key |
        oldmods:unpublished/oldmods:author | oldmods:unpublished/oldmods:title | oldmods:unpublished/oldmods:howpublished |
        oldmods:unpublished/oldmods:key |
        oldmods:misc/oldmods:author | oldmods:misc/oldmods:title | oldmods:misc/oldmods:howpublished |
        oldmods:misc/oldmods:key |
        oldmods:conference/oldmods:author | oldmods:conference/oldmods:title | oldmods:conference/oldmods:booktitle |
        oldmods:conference/oldmods:editor | oldmods:conference/oldmods:volume | oldmods:conference/oldmods:number |
        oldmods:conference/oldmods:series | oldmods:conference/oldmods:pages | oldmods:conference/oldmods:address |
        oldmods:conference/oldmods:organization | oldmods:conference/oldmods:publisher | oldmods:conference/oldmods:key |
        oldmods:inproceedings/oldmods:author | oldmods:inproceedings/oldmods:title | oldmods:inproceedings/oldmods:booktitle |
        oldmods:inproceedings/oldmods:editor | oldmods:inproceedings/oldmods:volume | oldmods:inproceedings/oldmods:number |
        oldmods:inproceedings/oldmods:series | oldmods:inproceedings/oldmods:pages | oldmods:inproceedings/oldmods:address |
        oldmods:inproceedings/oldmods:organization | oldmods:inproceedings/oldmods:publisher | oldmods:inproceedings/oldmods:key |
        */oldmods:month | */oldmods:year | */oldmods:url" priority="5">
        <xsl:element name="myns:{local-name()}">
            <xsl:apply-templates select="node()|@*"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="*" priority="4">
        <xsl:element name="myns:note">
            <xsl:attribute name="type_of"><xsl:value-of select="local-name()"></xsl:value-of></xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="oldmods:metadata"></xsl:template>
    
</xsl:stylesheet>