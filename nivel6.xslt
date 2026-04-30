<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
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
      </body>
    </html>
  </xsl:template>
  <xsl:template match="llibre">
    <li>
      <xsl:value-of select="titol"/>
    </li>
  </xsl:template>
</xsl:stylesheet>