
const String sharePreviewImageHeaderTemplate = '''<meta property="og:image" content="{og:image}"/>
  <meta property="twitter:image" content="{og:image}"/>
''';

const String sharePreviewTemplate = '''
<html prefix="og: https://ogp.me/ns#">
  <head>
    <title>{og:title}</title>
    <meta property="og:title" content="{og:title}" />
    <meta property="og:description" content="{og:description}" />
    <meta property="twitter:description" content="{twitter:description}" />
    <meta property="og:type" content="{og:type}" />
    <meta property="og:url" content="{og:url}" />
    <meta name="twitter:card" content="{twitter:card}" />
    {image_header}
  </head>
  <body>
    <p>Source: <a href="{source_url}">{source_url}</a></p>
    <p><img src="{og:image}"/></p>
    <p>{body}</p>
  </body>
</html>
''';