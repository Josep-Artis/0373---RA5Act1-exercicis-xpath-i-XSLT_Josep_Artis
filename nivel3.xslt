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
        <h3>Revista:</h3> */ voy a poner algunos sub-titulos para ordenarlo un poco.
        <p>
          <strong>Codi: </strong> <xsl:value-of select="/biblioteca/revista/@codi"/>
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

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>