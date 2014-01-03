inspect = require('eyes').inspector()
util = require 'util'

# Export Plugin
module.exports = (BasePlugin) ->
  # Define Plugin
  class SwiftypemetaPlugin extends BasePlugin
    # Plugin name
    name: 'swiftypemeta'

#    # Render
#    # Called per document, for each extension conversion. Used to render one extension to another.
#    render: (opts, next) ->
#      # Prepare
#      ##{templateData} = opts
#      {inExtension,outExtension,templateData,file,content} = opts
#      docpad = @docpad
#
#      # Skip if not a HTML document
#      return next() if outExtension != 'html'
#
#      return next()
#
#    renderDocument: (opts, next) ->
#      {extension,templateData,file,content} = opts
#
#      # Skip if not a HTML document
#      return next() if extension != 'html'
#
#      meta = ''
#
#      title = file.get 'title'
#      url = file.get 'url'
#      return next() if ! title
#
#      inspect content, url
#
#      meta = "\n\t<meta name=\"st:title\" content=\"#{ title }\">"
#
#      file.log 'warn', meta
#
#      opts.content = opts.content.replace '<!-- Swiftype-Meta-Tags-Here-Please -->', meta
#
#      #console.log Object.keys file
#      #inspect file.templateData, 'renderDocument -> templateData'
#
#      #inspect (Object.keys file.attributes), 'renderDocument: file.attributes (keys)'
#      #inspect file.get 'outPath'
#
#      #url = file.get 'url'
#
#      #@docpad.getBlock('meta').add "<meta name=\"st:title\" content=\"#{ title }\">";
#      #inspect title, 'title for ' + url
#
#      return next()

    extendTemplateData: (opts) ->
      {templateData} = opts

      templateData.swiftypeMeta = (document) ->
        return if !document
        meta = ''
        meta += "\n\t<meta name=\"st:title\" content=\"#{ document.title }\">" if document.title
        meta += "\n\t<meta name=\"st:type\" content=\"#{ document.type }\">" if document.type
        return meta

      # Chain extendTemplateData
      @

#    populateCollections: (opts) ->
#      @docpad.getBlock('meta').add '<!-- Swiftype-Meta-Tags-Here-Please -->';
#      @ # Chain populateCollections

