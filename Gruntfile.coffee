module.exports = (grunt) ->

#  var build = "asjhdk"

  grunt.initConfig
    
    clean:
      tests: ['public/style','public/script','test/unit/*.js']

    copy: 
      main: 
        files: [ "./lib/template.eco" : "./src/template.eco" ]

    less: {
      development: {
        options: {},
        files: {
          "./public/devBuild/application.css" : "./css/index.less"
        }
      },
    }

    appbot_scout: {
      dev: {
        options: {
        },
        build: "script",
        path: "",
        destination: "./public/scout.js",
        template: "./public/scoutTemplate.eco"
      },
    },

    grunt_appbot_compiler: {
      oneApp: {
        appPaths: ['./app/blue'],
        dependencyPaths: ["jqueryify","spine"],
        destination: "./public/devBuild/blueApp.js"
      },
      contentBox:{
        appPaths: ['./app/components/contentBox'],
        destination: "./public/devBuild/contentBox.js"
      }
    },

    coffee:
      testFiles:
        expand: true,
        flatten: true,
        cwd: './test/unit/src',
        src: ['*.coffee'],
        dest: './test/unit/',
        ext: '.js'        

    mochaTest:
      test:
        options:
          reporter: 'spec'
        src: ['test/unit/*.js']
        
    watch:
      css:
        files: ["./css/*.less","./css/**/*.less"]
        tasks: ["less"]
      apps:
        files: ["./app/**/*.coffee" ,"./app/**/*.eco","./app/**/*.jeco","./app/**/*.less"]
        tasks: ["grunt_appbot_compiler","appbot_scout"]
      views:
        files: ["./views/*.jade","./views/**/*.jade"]
        tasks: ["jade"]


    jade: 
      compile: 
        files:
          "./public/index.html": ["./views/index.jade"]
          "./public/gettingstarted.html": ["./views/gettingstarted.jade"]
          "./public/frontend.html": ["./views/frontend.jade"]
          "./public/standards.html": ["./views/standards.jade"]

        options: {
          data: {
            build: "devBuild"
            path: ""
          }
        }

    

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-appbot-scout');

  grunt.loadNpmTasks('grunt-appbot-compiler');
  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-contrib-jade');

  grunt.registerTask('test', ["clean",'coffee',"grunt_appbot_compiler","mochaTest"]);   

  grunt.registerTask('build', ["test",'coffee',"grunt_appbot_compiler","appbot_scout"]);   

  
  grunt.registerTask('default', ['clean','coffee', "copy" , 'mochaTest']);   
