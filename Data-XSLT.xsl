<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- PART 1: Set the output format to HTML -->
    <xsl:output method="html" indent="yes"/>
    
    
    <!-- PART 2: Collect all XML files in the chapter_xml folder -->
    <xsl:variable name="chapters"
        select="collection('chapter_xml?select=*.xml')"/>
    
    
    <!-- PART 3: Collect characters whose unique element has ans="y" -->
    <!-- Retrieve the who attribute from their parent bubble -->
    <!-- Use distinct-values within each chapter to avoid double counting -->
    
    <xsl:variable name="speakers"
        select="for $chapter in $chapters
        return distinct-values(
        $chapter//unique[@ans = 'y']/parent::bubble/@who
        )"/>
    
    
    <!-- PART 4: Collect all distinct character names across 45 chapters -->
    <xsl:variable name="characters"
        select="distinct-values($speakers)"/>
    
    
    <!-- PART 5: Define the colors for the five bars -->
    <xsl:variable name="colors"
        select="('blue', 'green', 'red', 'orange', 'purple')"/>
    
    
    <!-- PART 6: Find the highest chapter appearance count -->
    <xsl:variable name="maxCount"
        select="max(
        for $c in $characters
        return count($speakers[. = $c])
        )"/>
    <!-- test for varibles-->
    
    <xsl:variable name="thoughtCounts"
        select="for $chapter in $chapters
        return count($chapter//bubble[@type = 'thought'])"/>
    
    <xsl:variable name="totalThoughts"
        select="sum($thoughtCounts)"/>
    
    <xsl:variable name="averageThoughts" select="ceiling($totalThoughts div 45)"/>
    
    <xsl:variable name="speechCounts"
        select="for $chapter in $chapters
        return count($chapter//bubble[@type = 'speech'])"/>
    
    <xsl:variable name="totalSpeechs"
        select="sum($speechCounts)"/>
    
    <xsl:variable name="averageSpeechs" select="ceiling($totalSpeechs div 45)"/>
    
    <xsl:variable name="pageCounts"
        select="for $chapter in $chapters
        return count($chapter//page)"/>
    
    <xsl:variable name="sumPages"
        select="sum($pageCounts)"/>
    
    <xsl:variable name="averagePages" select="ceiling($sumPages div 45)"/>
    
    <xsl:variable name="averageCharacters" select="ceiling(count($characters) div 45)"/>
    <!-- test -->
    <!-- PART 7: Generate the HTML document -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Data</title>
                <link rel="stylesheet" type="text/css" href="formatWebsite.css" />
                <link rel="icon" href="images/icon.jpg"/>
            </head>
            
            <body>
                <nav class="navbar">
                    <a href="index.html"><img src="images/SL_HomePic.jpg" alt="This is the image go to home page" width="100" height="50"/></a>
                    <ul class="menu">
                        <li><a href="index.html">Home</a></li>
                        <li><a href="method.html">Method</a></li>
                        <li><a href="chapters.html">Chapters</a></li>
                        <li><a href="data.html">Data</a></li>
                    </ul>
                </nav>
                <div class="container">
                    <h1 class="center large-text-body">Data</h1>
                    <p class="small-text-body indent-center">We have collect the basic data for text content which are: <span class="bold-text">Speech Bubble</span>, <span class="bold-text">Thought Bubbles</span>, <span class="bold-text">Information caption</span>, and <span class="bold-text">Narrative caption</span></p>
                    <div class="side-by-side">
                        <div class="table-w/-title">
                            <h3 class="center">Total Data in 45 Chapters</h3>
                            <table>
                                <tr>
                                    <th>text type</th>
                                    <th>totals</th>
                                </tr>
                                <tr>
                                    <td>Thought Bubbles</td>
                                    <td><xsl:value-of select="$totalThoughts"/></td>
                                </tr>
                                <tr>
                                    <td>Speech Bubbles</td>
                                    <td><xsl:value-of select="$totalSpeechs"/></td>
                                </tr>
                                <tr>
                                    <td>Pages</td>
                                    <td><xsl:value-of select="$sumPages"/></td>
                                </tr>
                                <tr>
                                    <td>Unique Characters</td>
                                    <td><xsl:value-of select="count($characters)"/></td>
                                </tr>
                            </table>
                        </div>
                        <div class="table-w/-title">
                            <h3 class="center">Average Data for 45 Chapters</h3>
                            <table>
                            <tr>
                                <th>text type</th>
                                <th>average</th>
                            </tr>
                            <tr>
                                <td>Thought Bubbles</td>
                                <td><xsl:value-of select="$averageThoughts"/></td>
                            </tr>
                            <tr>
                                <td>Speech Bubbles</td>
                                <td><xsl:value-of select="$averageSpeechs"/></td>
                            </tr>
                            <tr>
                                <td>Pages</td>
                                <td><xsl:value-of select="$averagePages"/></td>
                            </tr>
                            <tr>
                                <td>Unique Characters</td>
                                <td><xsl:value-of select="$averageCharacters"/></td>
                            </tr>
                        </table>
                        </div>
                    </div>
                
                
                <!-- PART 8: Create the SVG canvas -->
                <svg xmlns="http://www.w3.org/2000/svg"
                    width="900"
                    height="650"
                    viewBox="0 0 900 650">
                    
                    
                    <!-- PART 9: Display the graph title -->
                    <text x="450" y="30"
                        fill="black"
                        text-anchor="middle"
                        font-size="28">
                        
                        Top 5 Characters by Chapter Appearances
                        
                    </text>
                    
                    
                    <!-- PART 10: Draw the graph borders -->
                    
                    <!-- Left border -->
                    <line x1="5" y1="40"
                        x2="5" y2="540"
                        stroke="black" stroke-width="5"/>
                    
                    <!-- Top border -->
                    <line x1="5" y1="40"
                        x2="895" y2="40"
                        stroke="black" stroke-width="5"/>
                    
                    <!-- Right border -->
                    <line x1="895" y1="40"
                        x2="895" y2="540"
                        stroke="black" stroke-width="5"/>
                    
                    <!-- Bottom border -->
                    <line x1="5" y1="540"
                        x2="895" y2="540"
                        stroke="black" stroke-width="5"/>
                    
                    
                    <!-- PART 11: Loop through all distinct characters -->
                    <xsl:for-each select="$characters">
                        
                        <!-- Sort by number of chapter appearances -->
                        <xsl:sort
                            select="count($speakers[. = current()])"
                            data-type="number"
                            order="descending"/>
                        
                        <!-- Sort alphabetically if counts are equal -->
                        <xsl:sort select="." order="ascending"/>
                        
                        
                        <!-- PART 12: Only process the top five characters -->
                        <xsl:if test="position() le 5">
                            
                            <!-- Get the character's rank -->
                            <xsl:variable name="rank"
                                select="position()"/>
                            
                            <!-- Get the character's name -->
                            <xsl:variable name="character"
                                select="."/>
                            
                            <!-- Count how many chapters contain this character -->
                            <xsl:variable name="count"
                                select="count($speakers[. = $character])"/>
                            
                            
                            <!-- PART 13: Calculate SVG bar dimensions -->
                            
                            <!-- Calculate proportional bar height -->
                            <xsl:variable name="height"
                                select="$count div $maxCount * 450"/>
                            
                            <!-- Calculate horizontal position -->
                            <xsl:variable name="x"
                                select="40 + ($rank - 1) * 180"/>
                            
                            <!-- Calculate vertical position -->
                            <xsl:variable name="y"
                                select="540 - $height"/>
                            
                            
                            <!-- PART 14: Draw the SVG bar -->
                            <rect
                                x="{$x}"
                                y="{$y}"
                                width="100"
                                height="{$height}"
                                fill="{$colors[$rank]}"/>
                            
                            
                            <!-- PART 15: Display the character name -->
                            <text
                                x="{$x + 50}"
                                y="570"
                                fill="black"
                                text-anchor="middle"
                                font-size="16">
                                
                                <xsl:value-of select="$character"/>
                                
                            </text>
                            
                            
                            <!-- PART 16: Display the chapter appearance count -->
                            <text
                                x="{$x + 50}"
                                y="{$y - 10}"
                                fill="black"
                                text-anchor="middle"
                                font-size="20">
                                
                                <xsl:value-of select="$count"/>
                                
                            </text>
                            
                        </xsl:if>
                        
                    </xsl:for-each>
                    
                    
                    <!-- PART 17: Display the X-axis description -->
                    <text x="450" y="620"
                        text-anchor="middle"
                        font-size="20">
                        
                        Characters
                        
                    </text>
                    
                </svg>
                </div>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>

