<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:h="http://www.utc.fr/ics/hdoc/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
  xmlns:op="utc.fr:ics/opale3"
  xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
  >
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  
  <!-- This template matches the root. One hdoc file = one Opale's "Module" -->
    <xsl:template match="h:html">
    <sc:item xmlns:sc="http://www.utc.fr/ics/scenari/v3/core">
      <op:ue xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive" xmlns:op="utc.fr:ics/opale3" xmlns:sc="http://www.utc.fr/ics/scenari/v3/core">
        <xsl:apply-templates select="./*"/>
      </op:ue>
    </sc:item>
  </xsl:template>

  <!-- Head related templates. -->
    <xsl:template match="h:head">
      <op:ueM xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive" xmlns:op="utc.fr:ics/opale3" xmlns:sc="http://www.utc.fr/ics/scenari/v3/core">
        <sp:title>
          <xsl:value-of select="./h:title"/>
        </sp:title>
        <sp:info>
          <op:info>
            <xsl:apply-templates select="./h:meta"/>

            <!-- Author: in case several authors are specified, we don't want to get an error for not respecting the schema -->
            <xsl:if test="./h:meta[@name='author']">
              <sp:cpyrgt>
                <op:sPara>
                  <sc:para>
                    <xsl:call-template name="join">
                        <xsl:with-param name="list" select="./h:meta[@name='author']/@content" />
                        <xsl:with-param name="separator" select="', '" />
                    </xsl:call-template>
                  </sc:para>
                </op:sPara>
              </sp:cpyrgt>
            </xsl:if>

          </op:info>
        </sp:info>
      </op:ueM>
    </xsl:template>

    <!-- Join template found at http://stackoverflow.com/questions/12585974/xslt-merging-concatinating-values-of-siblings-nodes-of-same-name-into-single-nod -->
    <xsl:template name="join">
        <xsl:param name="list" />
        <xsl:param name="separator"/>

        <xsl:for-each select="$list">
            <xsl:value-of select="." />
            <xsl:if test="position() != last()">
                <xsl:value-of select="$separator" />
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="h:meta[@name]">
    <xsl:choose>
      <xsl:when test="./@name = 'description'"/> <!-- Unsupported : Opale doesn't provide any description metadata. -->
      <xsl:when test="./@name = 'keywords'"> <!-- This is the least to do, since there's no specific format for keywords in hdoc. -->
        <sp:keywds>
          <op:keywds>
            <sp:keywd><xsl:value-of select="./@content"/></sp:keywd>
          </op:keywds>
        </sp:keywds>
      </xsl:when>
      <xsl:when test="./@name = 'author'"/> <!-- Done above -->
      <xsl:when test="./@name = 'rights'">
        <xsl:choose>
          <xsl:when test="./@content = 'http://creativecommons.org/publicdomain/zero/1.0/deed.en'"><sp:cc>zero</sp:cc></xsl:when>
          <xsl:when test="./@content = 'Public Domain'"><sp:cc>publicdomain</sp:cc></xsl:when>
          <xsl:when test="./@content = 'http://www.gnu.org/licenses/gpl.html'"><sp:cc>gnu-fdl</sp:cc></xsl:when>
          <xsl:when test="./@content = 'http://creativecommons.org/licenses/by/4.0/deed.en'"><sp:cc>by</sp:cc></xsl:when>
          <xsl:when test="./@content = 'http://creativecommons.org/licenses/by-sa/4.0/deed.en'"><sp:cc>by-sa</sp:cc></xsl:when>
          <xsl:when test="./@content = 'http://creativecommons.org/licenses/by-nd/4.0/deed.en'"><sp:cc>by-nd</sp:cc></xsl:when>
          <xsl:when test="./@content = 'http://creativecommons.org/licenses/by-nc/4.0/deed.en'"><sp:cc>by-nc</sp:cc></xsl:when>
          <xsl:when test="./@content = 'http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en'"><sp:cc>by-nc-sa</sp:cc></xsl:when>
          <xsl:when test="./@content = 'http://creativecommons.org/licenses/by-nc-nd/4.0/deed.en'"><sp:cc>by-nc-nd</sp:cc></xsl:when>
    		  <xsl:otherwise/> <!-- This previous list is supposed to support every possible case, any other value for "rights" are unsupported. -->
        </xsl:choose>
      </xsl:when>
      <xsl:when test="./@name = 'date'"/> <!-- Unsupported : Opale doesn't provide any date metadata. -->
      <xsl:otherwise/> <!-- There are no other values for ./@name right now. -->
    </xsl:choose>
  </xsl:template>

  <!-- Body related templates. -->
    <xsl:template match="h:body">
      <xsl:if test="./h:section[@data-hdoc-type = 'introduction']">
        <sp:intro>
          <op:res>
            <xsl:apply-templates select="./h:section[@data-hdoc-type = 'introduction']/h:div/*" />
          </op:res>
        </sp:intro>
      </xsl:if>

      <!-- Not selecting introductions or conclusions -->
      <xsl:apply-templates select="./h:section[not(@data-hdoc-type = 'introduction' or @data-hdoc-type = 'conclusion')]"/>

      <xsl:if test="./h:section[@data-hdoc-type = 'conclusion']">
        <sp:conclu>
          <op:res>
            <xsl:apply-templates select="./h:section[@data-hdoc-type = 'conclusion']/h:div/*" />
          </op:res>
        </sp:conclu>
      </xsl:if>
    </xsl:template>

    <!-- Introduction <section> -->
    <xsl:template match="h:div[@data-hdoc-type='introduction']">
      <sp:intro>
        <op:res>
          <xsl:apply-templates select="./h:p" />
        </op:res>
      </sp:intro>
    </xsl:template>

    <!-- Conclusion <section> -->
    <xsl:template match="h:div[@data-hdoc-type='conclusion']">
      <sp:conclu>
        <op:res>
          <!-- Going straight to the content -->
          <!-- For the conclusion, we ignore <header> and <footer> -->
          <xsl:apply-templates select="./h:p" />
        </op:res>
      </sp:conclu>
    </xsl:template>

    <!-- Grains <sections>. A grain is either a unit-of-content, or does not contain sub divisions (<section>'s) -->
    <xsl:template match="h:section[@data-hdoc-type='unit-of-content' or h:div or not(h:section)]">
      <sp:courseUc>
        <op:expUc>
          <op:uM>
            <sp:title>
              <!-- Adding a default value for titles (Opale requires a title to be specified) -->
              <xsl:if test="not(./h:header/h:h1/text())">
                Untitled
              </xsl:if>
              <xsl:value-of select="./h:header/h:h1"/>
            </sp:title>
          </op:uM>

          <!-- TODO test level of sub division (section/section/section) -->
          <xsl:if test="./h:div">
            <sp:pb>
              <op:pb>
                <xsl:apply-templates select="./h:div"/>
              </op:pb>
            </sp:pb>
          </xsl:if>

          <!-- Applying sub sections -->
          <xsl:apply-templates select="./h:section" mode="under-unit-of-content" />
        </op:expUc>
      </sp:courseUc>
    </xsl:template>

    <xsl:template match="h:section" mode="under-unit-of-content">
      <sp:div>
        <op:expUcDiv>
          <op:expUcDivM>
            <sp:title>
              <!-- Adding a default value for titles (Opale requires a title to be specified) -->
              <xsl:if test="not(./h:header/h:h1/text())">
                Untitled
              </xsl:if>

              <xsl:value-of select="./h:header/h:h1"/>
            </sp:title>
          </op:expUcDivM>

          <!-- TODO test level of sub division (section/section/section) -->
          <xsl:if test="./h:div">
            <sp:pb>
              <op:pb>
                <xsl:apply-templates select="./h:div"/>
              </op:pb>
            </sp:pb>
          </xsl:if>

          <xsl:apply-templates select="./h:section" mode="under-unit-of-content" />
        </op:expUcDiv>
      </sp:div>
    </xsl:template>

    <!-- Basic <section> (nothing was specified) -->
    <xsl:template match="h:section">
      <!-- Every section is converted into what Opale calls a "Division" -->
      <!-- For now there are no specific processes applied on sections with an "introduction" or "conclusion" value in their data-hdoc-type attribute.
      They are processed the same as standard sections.
      -->
      <sp:div>
        <op:ueDiv>
          <op:ueDivM>
            <sp:title>
              <xsl:value-of select="./h:header/h:h1"/>
            </sp:title>
          </op:ueDivM>

          <!-- Intro for a division -->
          <xsl:apply-templates select="./h:header/h:div[@data-hdoc-type='introduction']" />

          <!-- Taking care of the content. If content exists, we add it as a "grain" (we also add a title to it) -->
          <xsl:if test="./h:div">
            <sp:courseUc>
              <op:expUc>
                <op:uM>
                  <xsl:if test="./h:header/h:h1">
                    <sp:title>
                      <xsl:value-of select="./h:header/h:h1"/>
                    </sp:title>
                  </xsl:if>
                </op:uM>

                <xsl:if test="./h:div">
                  <sp:pb>
                    <op:pb>
                      <xsl:apply-templates select="./h:div"/>
                    </op:pb>
                  </sp:pb>
                </xsl:if>
              </op:expUc>
            </sp:courseUc>
          </xsl:if>

          <!-- Applying templates to section that are neither an introduction nor a conclusion -->
          <xsl:apply-templates select="./h:section[not(@data-hdoc-type = 'introduction' or @data-hdoc-type = 'conclusion')]"/>

          <!-- Conclusion for a division -->
          <xsl:apply-templates select="./h:header/h:div[@data-hdoc-type='conclusion']" />

        </op:ueDiv>
      </sp:div>
    </xsl:template>

    <!-- Formatting content based on @data-hdoc-type -->
    <xsl:template match="h:div">
    <xsl:choose>
      <xsl:when test="./@data-hdoc-type = 'emphasis'">
        <sp:basic>
          <op:pbTi>
            <xsl:if test="string-length(./h:h6/text()) > 0">
              <sp:title>
                <xsl:value-of select="./h:h6"/>
              </sp:title>
            </xsl:if>
          </op:pbTi>
          <op:res>
            <xsl:apply-templates select="./*"/>
          </op:res>
        </sp:basic>
      </xsl:when>
      <xsl:when test="./@data-hdoc-type = 'complement'">
        <sp:comp>
          <op:pbTi>
            <xsl:if test="string-length(./h:h6/text()) > 0">
              <sp:title>
                <xsl:value-of select="./h:h6"/>
              </sp:title>
            </xsl:if>
          </op:pbTi>
          <op:res>
            <xsl:apply-templates select="./*"/>
          </op:res>
        </sp:comp>
      </xsl:when>
      <xsl:when test="./@data-hdoc-type = 'definition'">
        <sp:def>
          <op:pbTi>
            <xsl:if test="string-length(./h:h6/text()) > 0">
              <sp:title>
                <xsl:value-of select="./h:h6"/>
              </sp:title>
            </xsl:if>
          </op:pbTi>
          <op:res>
            <xsl:apply-templates select="./*"/>
          </op:res>
        </sp:def>
      </xsl:when>
      <xsl:when test="./@data-hdoc-type = 'example'">
        <sp:ex>
          <op:pbTi>
            <xsl:if test="string-length(./h:h6/text()) > 0">
              <sp:title>
                <xsl:value-of select="./h:h6"/>
              </sp:title>
            </xsl:if>
          </op:pbTi>
          <op:res>
            <xsl:apply-templates select="./*"/>
          </op:res>
        </sp:ex>
      </xsl:when>
      <xsl:when test="./@data-hdoc-type = 'remark'">
        <sp:rem>
          <op:pbTi>
            <xsl:if test="string-length(./h:h6/text()) > 0">
              <sp:title>
                <xsl:value-of select="./h:h6"/>
              </sp:title>
            </xsl:if>
          </op:pbTi>
          <op:res>
            <xsl:apply-templates select="./*"/>
          </op:res>
        </sp:rem>
      </xsl:when>
      <xsl:when test="./@data-hdoc-type = 'warning'">
        <sp:warning>
          <op:pbTi>
            <xsl:if test="string-length(./h:h6/text()) > 0">
              <sp:title>
                <xsl:value-of select="./h:h6"/>
              </sp:title>
            </xsl:if>
          </op:pbTi>
          <op:res>
            <xsl:apply-templates select="./*"/>
          </op:res>
        </sp:warning>
      </xsl:when>
      <xsl:when test="./@data-hdoc-type = 'advice'">
        <sp:adv>
          <op:pbTi>
            <xsl:if test="string-length(./h:h6/text()) > 0">
              <sp:title>
                <xsl:value-of select="./h:h6"/>
              </sp:title>
            </xsl:if>
          </op:pbTi>
          <op:res>
            <xsl:apply-templates select="./*"/>
          </op:res>
        </sp:adv>
      </xsl:when>
      <xsl:otherwise>
        <sp:info>
          <op:pbTi>
            <xsl:if test="string-length(./h:h6/text()) > 0">
              <sp:title>
                <xsl:value-of select="./h:h6"/>
              </sp:title>
            </xsl:if>
          </op:pbTi>
          <op:res>
            <xsl:apply-templates select="./*"/>
          </op:res>
        </sp:info>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Section related templates. -->
  <xsl:template match="h:footer/h:div[@data-hdoc-type = 'tags']">
    <sp:keywd><xsl:value-of select="./h:span"/></sp:keywd>
  </xsl:template>
  
  <!-- Div related templates. -->
    <!-- Text related templates -->
      <xsl:template match="h:p[1]">
        <xsl:choose>
          <xsl:when test="parent::*[name() = 'div']">
            <sp:txt>
              <op:txt>
                <xsl:call-template name="psuperior"/>
              </op:txt>
            </sp:txt>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="psuperior"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:template>

      <xsl:template name="psuperior">
        <xsl:for-each select=". | ./following-sibling::*">
          <xsl:choose>
            <xsl:when test="name() = 'p'">
              <sc:para>
                <xsl:apply-templates select="./* | ./text()"/>
              </sc:para>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
      </xsl:template>

      <xsl:template match="h:p"/>

      <xsl:template match="h:i">
        <sc:inlineStyle role="spec">
          <xsl:apply-templates select="./* | ./text()"/>
        </sc:inlineStyle>
      </xsl:template>
      <xsl:template match="h:em">
        <sc:inlineStyle role="emp">
          <xsl:apply-templates select="./* | ./text()"/>
        </sc:inlineStyle>
      </xsl:template>
      <xsl:template match="h:q">
        <sc:inlineStyle role="quote">
          <xsl:apply-templates select="./* | ./text()"/>
        </sc:inlineStyle>
      </xsl:template>
      <xsl:template match="h:sub">
        <sc:textLeaf role="ind">
          <xsl:apply-templates select="./* | ./text()"/>
        </sc:textLeaf>
      </xsl:template>
      <xsl:template match="h:sup">
        <sc:textLeaf role="exp">
          <xsl:apply-templates select="./* | ./text()"/>
        </sc:textLeaf>
      </xsl:template>
      <xsl:template match="h:a">
        <sc:phrase role="url">
          <op:urlM>
            <sp:url>
              <xsl:value-of select="./@href"/>
            </sp:url>
          </op:urlM>
          <xsl:if test="./@title">
            <sp:title>
              <xsl:value-of select="./@title"/>
            </sp:title>
          </xsl:if>
          <xsl:value-of select="." />
        </sc:phrase>
      </xsl:template>
      <xsl:template match="h:ul">
        <xsl:choose>
          <xsl:when test="parent::*[name() = 'div']"> <!-- If this <ul> is a direct child of a <div> then it must be surrounded by Opale's text markups. -->
            <sp:txt>
              <op:txt>
                <sc:itemizedList>
                  <xsl:apply-templates select="./*"/>
                </sc:itemizedList>
              </op:txt>
            </sp:txt>
          </xsl:when>
          <xsl:otherwise>
              <sc:itemizedList>
                <xsl:apply-templates select="./*"/>
              </sc:itemizedList>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:template>
      <xsl:template match="h:ol">
        <xsl:choose>
          <xsl:when test="parent::*[name() = 'div']"> <!-- If this <ol> is direct child of a <div> then it must be surrounded by Opale's text markups. -->
            <sp:txt>
              <op:txt>
                <sc:orderedList>
                  <xsl:apply-templates select="./*"/>
                </sc:orderedList>
              </op:txt>
            </sp:txt>
          </xsl:when>
          <xsl:otherwise>
            <sc:orderedList>
              <xsl:apply-templates select="./*"/>
            </sc:orderedList>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:template>
      <xsl:template match="h:li">
        <sc:listItem>
          <xsl:apply-templates select="./* | ./text()"/>
        </sc:listItem>
      </xsl:template>
      <xsl:template match="h:span[@data-hdoc-type = 'syntax']">
        <sc:inlineStyle role="code">
          <xsl:apply-templates select="./* | ./text()"/>
        </sc:inlineStyle>
      </xsl:template>
      <xsl:template match="h:span[@data-hdoc-type = 'latex']">
        <sc:textLeaf role="mathtex">
          <xsl:apply-templates select="./* | ./text()"/>
        </sc:textLeaf>        
      </xsl:template>
      <xsl:template match="h:span">
       <xsl:apply-templates select="./* | ./text()"/>
      </xsl:template>
      
    <!-- Table related templates -->
      <xsl:template match="h:table">
        <xsl:choose>
          <xsl:when test="parent::*[name() = 'div']"> <!-- If this <table> is a direct child of a <div> then it must be surrounded by Opale's text markups. -->
            <sp:txt>
              <op:txt>
                <sc:table>
                  <xsl:if test="./h:caption">
                    <sc:caption><xsl:value-of select="./h:caption"/></sc:caption>
                  </xsl:if>
                  <xsl:apply-templates select="./h:tr"/>
                </sc:table>
              </op:txt>
            </sp:txt>
          </xsl:when>
          <xsl:otherwise>
            <sc:table>
              <xsl:if test="./h:caption">
                <sc:caption><xsl:value-of select="./h:caption"/></sc:caption>
              </xsl:if>
              <xsl:apply-templates select="./h:tr"/>
            </sc:table>            
          </xsl:otherwise>
        </xsl:choose>

      </xsl:template>
      <xsl:template match="h:tr">
        <sc:row>
          <xsl:apply-templates select="./h:td"/>
        </sc:row>
      </xsl:template>
      <xsl:template match="h:td">
        <sc:cell>
          <xsl:apply-templates select="./*"/>
        </sc:cell>
      </xsl:template>
  
    <!-- Ressource related templates -->
      <xsl:template match="h:img">
        <sp:res sc:refUri="res/{./@src}">
          <op:resInfoM/>
        </sp:res>
      </xsl:template>
      <xsl:template match="h:audio">
        <sp:res sc:refUri="res/{./@src}">
          <op:resInfoM/>
        </sp:res>
      </xsl:template>
      <xsl:template match="h:video">
        <sp:res sc:refUri="res/{./@src}">
          <op:resInfoM/>
        </sp:res>
      </xsl:template>
      <xsl:template match="h:object">
    <sp:int sc:refUri="res/{./@data}">
      <op:instructionM/>
    </sp:int>
  </xsl:template>

  <xsl:template match="h:section[h:div[@data-hdoc-type = 'question']]">
    <!-- Selecting the first question -->
    <sp:trainUcMcqMur>
      <op:mcqMur>
        <op:exeM>
          <sp:title>
            <xsl:value-of select="./h:header/h:h1"/>
          </sp:title>
        </op:exeM>

        <xsl:apply-templates select="./h:div[@data-hdoc-type = 'question']" />

        <sc:choices>
          <xsl:apply-templates select="./h:div[@data-hdoc-type = 'choice-correct' or @data-hdoc-type = 'choice-incorrect']"/>
        </sc:choices>

        <sc:globalExplanation>
          <op:res>
            <xsl:apply-templates select="./h:div[@data-hdoc-type = 'explanation']/h:p"/>
          </op:res>
        </sc:globalExplanation>
      </op:mcqMur>
    </sp:trainUcMcqMur>
  </xsl:template>

  <xsl:template match="h:div[@data-hdoc-type = 'question']"> 
    <sc:question>
      <op:res>
        <xsl:apply-templates select="./*" />
      </op:res>
    </sc:question>
  </xsl:template>

  <xsl:template match="h:div[@data-hdoc-type = 'choice-correct']"> 
    <sc:choice solution="checked">
      <xsl:call-template name="choice" />
    </sc:choice>
  </xsl:template>

  <xsl:template match="h:div[@data-hdoc-type = 'choice-incorrect']"> 
    <sc:choice solution="unchecked">
      <xsl:call-template name="choice" />
    </sc:choice>
  </xsl:template>

  <xsl:template name="choice">
    <sc:choiceLabel>
      <op:txt>
        <!-- TODO formating won't work -->
        <sc:para>
          <xsl:apply-templates select="./h:p/text()" />
        </sc:para>
      </op:txt>
    </sc:choiceLabel>
  </xsl:template>
  
  <!-- These markups are matched in order to minimize "apply-templates select="./*" side-effects (i.e. their content are already treated into another template or they are not (yet) supported). -->
    <!-- Unsupported. -->
      <xsl:template match="h:div[@data-hdoc-types = 'categories']"/> 
      <xsl:template match="h:meta[@charset]"/>
      <xsl:template match="h:meta[@generator]"/>
      <xsl:template match="h:footer/h:div[@data-hdoc-type = 'categories']"/>
    <!-- Other. -->
      <!--<xsl:template match="h:span"/>--> <!-- Its content is already used in several templates, according to its location and microdata. -->
      <xsl:template match="h:header"/> <!-- Its content is already used in <xsl:template match="h:section"> -->
      <xsl:template match="h:h6"/> <!-- Its content is already used in <xsl:template match="h:div"> -->
      <xsl:template match="h:h1"/> <!-- Its content is already used in <xsl:template match="h:section"> -->
</xsl:stylesheet>