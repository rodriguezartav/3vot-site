module.exports = (grunt) ->

  
  grunt.initConfig
    
    clean:
      tests: ['public/style','lib','test/unit']

    copy: 
      main: 
        files: [ "./lib/template.eco" : "./src/template.eco" ]

    less: {
      development: {
        options: {},
        files: {
          "./public/style/application.css" : "./css/index.less"
        }
      },
    }
    
    articles:
      createJson:
        options:
          src: "./views/articles"
          dest: "./articles.json"

    coffee:
      testFiles:
        expand: true,
        flatten: true,
        cwd: './test/unit-src',
        src: ['*.coffee'],
        dest: './test/unit/',
        ext: '.js'        

    mochaTest:
      test:
        options:
          reporter: 'spec'
        src: ['test/unit/*.js']
        
    watch:
      source:
        files: ["./css/*.less"]
        tasks: ["less"]

  grunt.loadTasks("./grunt-articles/tasks")
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-coffee');

  
  grunt.registerTask('default', ['clean','coffee', "copy" , 'mochaTest']);   
