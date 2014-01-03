# Required Modules
moment = require('moment')
eyes = require('eyes')
inspect = require('object-inspect')

# DocPad Configuration
docpadConfig = {

  # Collections
  # A hash of functions that create collections
  collections:

    blogPosts: ->
      @getCollection("html").findAllLive({relativeDirPath: "blog", skipCollection: $exists: false}, {date: -1}).on "add", (model) ->
        #debugger;
        basename = model.get('basename')
        associatedFilesPath = './' + basename if basename
        model.setMetaDefaults({
          layout: "blog-post",
          type: 'blog-post',
          menuIndex: 'blog',
          associatedFilesPath: associatedFilesPath,
          changfreq: 'monthly'
        })

    projects: ->
      @getCollection("html").findAllLive({relativeDirPath: "projects", skipCollection: $exists: false}, {date: -1}).on "add", (model) ->
        basename = model.get('basename')
        relBase = model.get('relativeBase')
        associatedFilesPath = './' + basename if basename
        backdrop = relBase.replace('\\', '/') + '/_backdrop.jpg'
        model.setMetaDefaults({
          layout: "project",
          type: 'project', menuIndex: 'projects',
          associatedFilesPath: associatedFilesPath,
          backdropImage: backdrop,
          changfreq: 'monthly'
        })

    testFiles: ->
      @getCollection("html").findAllLive({relativeDirPath: "test"}).on "add", (model) ->
        model.setMeta({ignored: true, write: false, render: false})# if 'static' in @getEnvironments()

  # Template Data
  # Use to define your own template data and helpers that will be accessible to your templates
  # Complete listing of default values can be found here: http://docpad.org/docs/template-data
  templateData:
    site:
      title: "ruudbijnen.nl"
      url: 'http://www.ruudbijnen.nl'
      # The website description (for SEO)
      description: """
                   ...
                   """
      # The website keywords (for SEO) separated by commas
      keywords: """
                Ruud Bijnen, Ruud, Bijnen, Creative, Developer, openFrameworks, OF, Cinder, LibCinder, Processing, VVVV, Web, Developer, Design, labbinaer, Studio Roosegaarde
                """
      menuItems:
        home:     {title: 'Home', url: '/'}
        blog:     {title: 'Blog', url: '/blog'}
        projects: {title: 'Projects', url: '/projects'}
        about:    {title: 'About', url: '/about'}
        # contact:  {title: 'Contact', url: '/contact'}
        #bsComponents:  {title: 'Compontents', url: '/test/bs-components'}
        #bsCss:  {title: 'CSS', url: '/test/bs-css'}
        #bsJs:  {title: 'Javascript', url: '/test/bs-js'}

    # format Date object http://momentjs.com/docs/#/displaying/format/
    formatDate: (date, format='DD-MM-YYYY') -> return moment(date).format(format)
    inspect: (object, label=undefined ) -> eyes.inspect(object, label)
    objInspect: (object, opts={}) -> inspect(object, opts)

  # Copy specific bower_components assets
  filesPaths: [
    'files'
    #'public'
    #'../bower_components/bootstrap/dist'
  ]

  # Plugin Configuration
  plugins:
    cleanurls:
      trailingSlashes: true
    marked:
      markedOptions:
        breaks: false
    navlinks:
      collections:
        blogPosts: -1
    thumbnails:
      presets: {
      }
      targets: {
        'backdrop': (img, args) ->
          args = w:1170, h:200, q:90
          return img
          .quality(args.q)
          .resize(args.w, args.h, '^')
          .blur(100)
          .crop(args.w, args.h)

        'carousel': (img, args) ->
          args = w:1170, h:200, q:90
          return img
            .quality(args.q)
            #.type('grayscale')
            .resize(args.w, args.h, '^')
            .crop(args.w, args.h)
      }

}
module.exports = docpadConfig