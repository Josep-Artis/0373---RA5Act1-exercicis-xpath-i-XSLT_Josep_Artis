<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
    <head>
        <style>
          .disponible { 
            color: #2e7d32; 
            background-color: #e8f5e9; 
            padding: 2px 8px; 
            border-radius: 4px; 
            font-weight: bold; 
          }
          .prestat { 
            color: #c62828; 
            background-color: #ffebee; 
            padding: 2px 8px; 
            border-radius: 4px; 
            font-style: italic; 
          }
        </style>
      </head>
      <body>
        <h1>Biblioteca</h1>
        <p>Llista de documents disponibles</p>
        <h3>Dades del primer llibre:</h3>
        <p>
          <strong>Títol: </strong> <xsl:value-of select="/biblioteca/llibre[1]/titol"/>
          <br/>
          <strong>Autor: </strong> <xsl:value-of select="/biblioteca/llibre[1]/autor"/>
        </p>
        <h3>Revista:</h3> <!-- voy a poner algunos sub-titulos para ordenarlo un poco. -->
        <p>
          <strong>Codi: </strong> <xsl:value-of select="/biblioteca/revista[1]/@codi"/>
          <!-- Preguntar a edu: he leido que aqui podriamos prescindir del 1 porque el codigo de la revista es unico, pero no se si es correcto -->
        </p>

        <h3>Llista de títols (Tots):</h3>
        <ul>
          <xsl:for-each select="/biblioteca/llibre">
            <li>
              <xsl:value-of select="titol"/>
            </li>
          </xsl:for-each>
        </ul>

        <h3>Llista Títol - Autor:</h3>
        <ul>
          <xsl:for-each select="/biblioteca/llibre">
            <li>
              <xsl:value-of select="titol"/> - <xsl:value-of select="autor"/>
            </li>
          </xsl:for-each>
        </ul>

        <h3>Taula de Llibres (3 columnes):</h3>
        <table border="1">
          <tr bgcolor="#cccccc">
            <th>Títol</th>
            <th>Autor</th>
            <th>Any</th>
          </tr>
          <xsl:for-each select="/biblioteca/llibre">
            <tr>
              <td><xsl:value-of select="titol"/></td>
              <td><xsl:value-of select="autor"/></td>
              <td><xsl:value-of select="any"/></td>
              <td><xsl:value-of select="preu"/></td>
            </tr>
          </xsl:for-each>
        </table>
<h3>Llibres Disponibles (Filtre @estat='disponible'):</h3>
        <ul>
          <xsl:for-each select="/biblioteca/llibre[@estat='disponible']">
            <li>
              <xsl:value-of select="titol"/> (Estat: <xsl:value-of select="@estat"/>)
            </li>
          </xsl:for-each>
        </ul>
        <h3>Llibres amb preu superior a 12:</h3>
        <ul>
          <xsl:for-each select="/biblioteca/llibre[preu > 12]">
            <li>
              <xsl:value-of select="titol"/> — <strong><xsl:value-of select="preu"/>€</strong>
            </li>
          </xsl:for-each>
        </ul>
        <h3>Llistat de llibres (amb avís d'antiguitat):</h3>
        <ul>
          <xsl:for-each select="/biblioteca/llibre">
            <li>
              <xsl:value-of select="titol"/> (Any: <xsl:value-of select="any"/>)
              
              <!-- Si el año es menor a 1980, escribe el texto -->
              <xsl:if test="any &lt; 1980">
                <span style="color: orange;"> [Llibre antic]</span>
              </xsl:if>
            </li>
          </xsl:for-each>
        </ul>
        <h3>Estat de disponibilitat:</h3>
        <ul>
          <xsl:for-each select="/biblioteca/llibre">
            <li>
              <xsl:value-of select="titol"/> — 
              <xsl:choose>
                <!-- Primera opción: si el atributo de estado es 'disponible' -->
                <xsl:when test="@estat = 'disponible'">
                  <span style="color: green;">Disponible</span>
                </xsl:when>
                <!-- sino sera prestado -->
                <xsl:otherwise>
                  <span style="color: red;">En préstec</span>
                </xsl:otherwise>
              </xsl:choose>
            </li>
          </xsl:for-each>
        </ul>
        <h3>Llibres de Fantasia o Distopia:</h3>
        <ul>
          <!-- Filtramos: género debe ser 'fantasia' O 'distopia' -->
          <xsl:for-each select="/biblioteca/llibre[genere='fantasia' or genere='distopia']">
            <li>
              <xsl:value-of select="titol"/> 
              (Gènere: <xsl:value-of select="genere"/>)
            </li>
          </xsl:for-each>
        </ul>
        <h3>1. Llibres ordenats per any de publicació:</h3>
        <ul>
          <xsl:for-each select="/biblioteca/llibre">
            <xsl:sort select="any" data-type="number" order="ascending"/>
            <li>
              <xsl:value-of select="any"/> - <xsl:value-of select="titol"/>
            </li>
          </xsl:for-each>
        </ul>
        <h3>2. Llibres ordenats per títol alfabèticament:</h3>
        <ul>
          <xsl:for-each select="/biblioteca/llibre">
            <xsl:sort select="titol" data-type="text" order="ascending"/>
            <li>
              <xsl:value-of select="titol"/>
            </li>
          </xsl:for-each>
        </ul>
        <h3>Llibres de més car a més barat:</h3>
        <ul>
          <xsl:for-each select="/biblioteca/llibre">
            <xsl:sort select="preu" data-type="number" order="descending"/>
            <li>
              <xsl:value-of select="titol"/>: <strong><xsl:value-of select="preu"/>€</strong>
            </li>
          </xsl:for-each>
        </ul>
        <h3>Taula ordenada per Any:</h3>
        <table border="1">
          <tr bgcolor="#cccccc">
            <th>Any</th>
            <th>Títol</th>
          </tr>
          <xsl:for-each select="/biblioteca/llibre">
            <xsl:sort select="any" data-type="number" order="ascending"/>
            <tr>
              <td><xsl:value-of select="any"/></td>
              <td><xsl:value-of select="titol"/></td>
            </tr>
          </xsl:for-each>
        </table>
        <h3>Llibres disponibles ordenats per títol:</h3>
        <ul>
          <xsl:for-each select="/biblioteca/llibre[@estat='disponible']">
            <xsl:sort select="titol" data-type="text" order="ascending"/>
            <li>
              <xsl:value-of select="titol"/>
            </li>
          </xsl:for-each>
        </ul>
        <h3> Llista de llibres </h3>
        <ul>
          <xsl:apply-templates select="/biblioteca/llibre"/>
        </ul>
        <h2>6.4 Seccions Organitzades</h2>
        <section>
          <h3>Secció de Llibres</h3>
          <ul>
            <xsl:apply-templates select="/biblioteca/llibre"/>
          </ul>
        </section>
        <section>
          <h3>Secció de Revistes</h3>
          <ul>
            <xsl:apply-templates select="/biblioteca/revista"/>
          </ul>
        </section>
        <header style="background-color: #f0f0f0; padding: 10px; border-radius: 5px;">
          <h1>Informe de la Biblioteca Municipal</h1>
          <p>Resum general de l'inventari: Llibres i Revistes</p>
        </header>

        <h3>Llistat complet de Llibres:</h3>
        <ul>
          <xsl:apply-templates select="/biblioteca/llibre"/>
        </ul>

        <h3>Llistat complet de Revistes:</h3>
        <ul>
          <xsl:apply-templates select="/biblioteca/revista"/>
        </ul>
        <h2>Nivell 7. Transformacions més riques</h2>
        <h3>7.1 Transformació d'etiquetes (XML View):</h3>
        <div style="background-color: #1e1e1e; color: #d4d4d4; padding: 15px; font-family: 'Courier New', monospace; border-radius: 8px; line-height: 1.5;">
          <span style="color: #808080;">&lt;!-- Nova estructura XML --&gt;</span><br/>
          <span style="color: #569cd6;">&lt;obres&gt;</span>
          <xsl:for-each select="/biblioteca/llibre">
            <div style="margin-left: 20px;">
              <span style="color: #569cd6;">&lt;obra&gt;</span>
                <div style="margin-left: 20px;">
                  <span style="color: #569cd6;">&lt;nom&gt;</span>
                  <span style="color: #ce9178;"><xsl:value-of select="titol"/></span>
                  <span style="color: #569cd6;">&lt;/nom&gt;</span><br/>
                  <span style="color: #569cd6;">&lt;escriptor&gt;</span>
                  <span style="color: #ce9178;"><xsl:value-of select="autor"/></span>
                  <span style="color: #569cd6;">&lt;/escriptor&gt;</span>
                </div>
              <span style="color: #569cd6;">&lt;/obra&gt;</span>
            </div>
          </xsl:for-each>
          <span style="color: #569cd6;">&lt;/obres&gt;</span>
        </div>
        <h3>7.2 Generació de text pla (una línia per llibre):</h3>
        <div style="background-color: #f4f4f4; padding: 15px; border: 1px dashed #999; font-family: monospace; white-space: pre;">
          <xsl:for-each select="/biblioteca/llibre">
            <xsl:value-of select="titol"/> - <xsl:value-of select="autor"/> - <xsl:value-of select="any"/>
            <xsl:text>&#10;</xsl:text> <!-- Esto genera un salto de línea real -->
          </xsl:for-each>
        </div>
        <div style="background-color: #e3f2fd; padding: 15px; border-left: 5px solid #2196f3; margin-top: 20px;">
          <p style="font-size: 1.2em; margin: 0;">
            <strong>Nombre total de llibres al catàleg: </strong>
            <span style="color: #1976d2;">
              <xsl:value-of select="count(/biblioteca/llibre)"/>
            </span>
          </p>
        </div>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="llibre">
    <li>
      <xsl:value-of select="titol"/>
    </li>
  </xsl:template>
  <xsl:template match="revista">
    <li>
      <strong>Revista: </strong>
      <xsl:value-of select="titol"/> 
      (Codi: <xsl:value-of select="@codi"/>)
    </li>
  </xsl:template>
</xsl:stylesheet>