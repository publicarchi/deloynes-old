<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:svg="http://www.w3.org/2000/svg" version="2.0"
    xmlns:ledoux="http://www.ledoux-architecture.fr/namespace"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">

    <xsl:output encoding="UTF-8" indent="yes" method="html" />

    <xsl:strip-space elements="*" />
    
    <xsl:variable name="facsimile" select="/TEI/facsimile"/>
    <xsl:variable name="plates" select="/TEI/text/back/div[@type='plates']"/>
    
    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="TEI">
        <html>
            <head>
                <link href="../css/edition.css" rel="stylesheet" />
                <title>
                    <xsl:value-of select="teiHeader/fileDesc/titleStmt/title" />
                </title>
                <script src="https://hypothes.is/embed.js" async="async" />
            </head>
            <body>
                <header class="site-header" role="banner">

                    <div class="wrapper">
                        <a class="site-title" rel="author" href="/"
                            >Collection Deloynes</a>
                        <nav class="site-nav">
                            <input type="checkbox" id="nav-trigger"
                                class="nav-trigger" />
                            <label for="nav-trigger">
                                <span class="menu-icon">
                                    <svg viewBox="0 0 18 15" width="18px"
                                        height="15px">
                                        <path
                                        d="M18,1.484c0,0.82-0.665,1.484-1.484,1.484H1.484C0.665,2.969,0,2.304,0,1.484l0,0C0,0.665,0.665,0,1.484,0 h15.032C17.335,0,18,0.665,18,1.484L18,1.484z M18,7.516C18,8.335,17.335,9,16.516,9H1.484C0.665,9,0,8.335,0,7.516l0,0 c0-0.82,0.665-1.484,1.484-1.484h15.032C17.335,6.031,18,6.696,18,7.516L18,7.516z M18,13.516C18,14.335,17.335,15,16.516,15H1.484 C0.665,15,0,14.335,0,13.516l0,0c0-0.82,0.665-1.483,1.484-1.483h15.032C17.335,12.031,18,12.695,18,13.516L18,13.516z"
                                         />
                                    </svg>
                                </span>
                            </label>
                        </nav>
                    </div>
                </header>
                <main>
                    <section>
                        <xsl:apply-templates select="text/front" />
                    </section>
                    <section>
                        <xsl:apply-templates select="text/body" />
                    </section>
                </main>
                <footer class="site-footer h-card">
                    <data class="u-url" href="/" />
                    <div class="wrapper">
                        <h2 class="footer-heading">La Collection Deloynes</h2>
                        <div class="footer-col-wrapper">
                            <div class="footer-col footer-col-1">
                                <ul class="contact-list">
                                    <li class="p-name"
                                        >Un essai d’édition numérique</li>
                                    <li>Cours de Fabrice Moulin</li>
                                </ul>
                            </div>
                            <div class="footer-col footer-col-2">
                                <ul class="social-media-list">
                                    <li>
                                        
                                    </li>
                                    <li>
                                        
                                    </li>
                                </ul>
                            </div>
                            <div class="footer-col footer-col-3">
                                <p></p>
                            </div>
                        </div>
                    </div>
                </footer>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="titlePage">
        <header>
            <xsl:apply-templates />
        </header>
    </xsl:template>

    <xsl:template match="titlePart[1]">
        <h1>
            <xsl:apply-templates />
        </h1>
    </xsl:template>

    <xsl:template match="titlePart">
        <h2>
            <xsl:apply-templates />
        </h2>
    </xsl:template>

    <xsl:template match="lb">
        <br />
    </xsl:template>

    <xsl:template match="epigraph">
        <p class="epigraph"><xsl:apply-templates select="./*/node()" /></p>
    </xsl:template>
    

    <xsl:template match="docAuthor">
        <h2 class="docAuthor">
            <xsl:apply-templates />
        </h2>
    </xsl:template>

    <xsl:template match="docImprint">
        <h3 class="docImprint">
            <xsl:value-of select="placeName" />
        </h3>
        <h3 class="docImprint">
            <xsl:value-of select="publisher" />
        </h3>
    </xsl:template>

    <xsl:template match="docDate">
        <h3 class="docImprint">
            <xsl:apply-templates />
        </h3>
    </xsl:template>

    <xsl:template match="div">
        <section>
            <xsl:apply-templates />
        </section>
    </xsl:template>

    <xsl:template match="p">
        <p><xsl:apply-templates /></p>
    </xsl:template>
    
    <xsl:template match="q">
        <em class="quote"><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template match="lb">
        <br/>
    </xsl:template>

    <xsl:template match="fw[@type = 'runningHead']" />

    <xsl:template match="fw[@type = 'pageNum']">
        <xsl:variable name="facs" select="preceding-sibling::pb[1]/@facs"/>
        <span class="pageNum">
            <xsl:text> [p. </xsl:text>
            <a href="{$facsimile/surface[@xml:id=substring($facs, 2)]/graphic/@url}" target="_blank"><xsl:apply-templates />
                <xsl:text>]</xsl:text></a>
        </span>
    </xsl:template>

    <xsl:template match="head">
        <h1>
            <xsl:apply-templates />
        </h1>
    </xsl:template>
    <xsl:template match="head[@type='plate']">
        <xsl:variable name="corresp" select="@corresp"/>
        <xsl:variable name="facs" select="ledoux:getPlatesFacs($corresp)"/>
        <h4>
            <xsl:apply-templates />
            <xsl:text> </xsl:text>
            <!-- @todo remplacer par du XPath -->
            <xsl:for-each select="1 to count($facs)">
                <xsl:variable name="iter" select="position()" />
                <a href="{$facs[$iter]}" target="_blank">&#x1F517;</a>
            </xsl:for-each>
        </h4>
    </xsl:template>
    
    <xsl:function name="ledoux:getPlatesFacs" as="xs:string*">
        <xsl:param name="corresp"/>
        <xsl:variable name="refs" select="for $i in tokenize($corresp) return $plates//figure[@xml:id=substring($i, 2)]/preceding::pb[1]/@facs"/>
        <xsl:sequence select="distinct-values(for $i in $refs return $facsimile/surface[@xml:id=substring($i, 2)]/graphic/@url)"/>
    </xsl:function>

    <xsl:template match="persName | placeName | orgName">
        <span class="{local-name(.)}">
            <xsl:apply-templates />
        </span>
    </xsl:template>

    <xsl:template match="choice[abbr]">
        <xsl:apply-templates select="expan" />
    </xsl:template>

    <xsl:template match="foreign | *[@xml:lang = 'lat']">
        <em class="foreign">
            <xsl:apply-templates />
        </em>
    </xsl:template>

    <xsl:template match="lb">
        <br />
    </xsl:template>

    <xsl:template match="hi[@rend = 'superscript']">
        <sup>
            <xsl:apply-templates />
        </sup>
    </xsl:template>

    <xsl:template match="hi[@rend = 'capital']">
        <span class="capital">
            <xsl:apply-templates />
        </span>
    </xsl:template>

    <xsl:template match="hi[@rend = 'italic']">
        <em>
            <xsl:apply-templates />
        </em>
    </xsl:template>

    <xsl:template match="hi[@rend = 'smallCap']">
        <span class="smallCap">
            <xsl:apply-templates />
        </span>
    </xsl:template>

    <xsl:template match="soCalled">
        <em class="soCalled">
            <xsl:apply-templates />
        </em>
    </xsl:template>

    <xsl:template match="note[@type = 'nota']">
        <div class="nota">
            <xsl:apply-templates />
        </div>
    </xsl:template>

    <xsl:template match="note">
        <!-- Affiche les notes entre crochets dans le texte -->
        <span class="note"> [
            <span class="noteLabel">
                <xsl:choose>
                    <xsl:when test="matches(@n, '\d')">
                        <xsl:value-of select="@n" />
                        <xsl:text>. </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@n" />
                        <xsl:text> </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
            <xsl:apply-templates />]
        </span>
    </xsl:template>

    <xsl:template match="note/p">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="note[@type = 'nota']/label">
        <h6>
            <xsl:apply-templates />
            <xsl:text>.</xsl:text>
        </h6>
    </xsl:template>

    <!-- 
ID Système: /Users/emmanuelchateau/publicarchi/ledouxSources/ledoux1804.tei.xml
Description: emph

ID Système: /Users/emmanuelchateau/publicarchi/ledouxSources/ledoux1804.tei.xml
Description: title

ID Système: /Users/emmanuelchateau/publicarchi/ledouxSources/ledoux1804.tei.xml
Description: hi

ID Système: /Users/emmanuelchateau/publicarchi/ledouxSources/ledoux1804.tei.xml
Description: sic

ID Système: /Users/emmanuelchateau/publicarchi/ledouxSources/ledoux1804.tei.xml
Description: l

ID Système: /Users/emmanuelchateau/publicarchi/ledouxSources/ledoux1804.tei.xml
Description: label

ID Système: /Users/emmanuelchateau/publicarchi/ledouxSources/ledoux1804.tei.xml
Description: space
 -->

</xsl:stylesheet>
