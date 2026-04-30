<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <body>
        <h1>Biblioteca</h1>
        <p>Lista de documentos disponibles</p>
        <strong>Titul del primer llibre:</strong> 
        <xsl:value-of select="/biblioteca/llibre[1]/titol"/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>