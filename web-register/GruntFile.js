module.exports = function(grunt) {
    'use strict';
    require('load-grunt-tasks')(grunt, {
        scope: 'devDependencies'
    });
    var appConfig = {

        settings: {
            dir: {
                src: 'src',
                dest: 'dist'
            }
        },
        clean: {
            build: ['<%= settings.dir.dest %>']
        },
        copy: {
            target: {
                files: [{
                    expand: true,
                    cwd: '<%= settings.dir.src %>/',
                    src: ['index.html', 'pages/**/*.*', 'img/**/*.*', 'fonts/**/*.*'],
                    dest: '<%= settings.dir.dest %>'
                }]
            }
        },
        sass: {
            dist: {
                options: {
                    style: 'compressed'
                },
                files: [{
                    expand: true,
                    cwd: '<%= settings.dir.src %>/scss',
                    src: ['**/*.scss'],
                    dest: '<%= settings.dir.dest %>/css',
                    ext: '.css'
                }]
            }
        },
        uglify: {
            options: {
                beautify: true,
                mangle: false
            },
            target: {
                files: [{
                    expand: true,
                    cwd: '<%= settings.dir.src %>/js',
                    src: '**/*.js',
                    dest: '<%= settings.dir.dest %>/js'
                }]
            }
        },
        replace: {
            dist: {
                options: {
                    patterns: [{
                        match: 'replace_api_grunt',
                        replacement: process.env.API_URL ? process.env.API_URL : "http://\" + window.location.hostname + \":3000"
                    }]
                },
                files: [
                    { expand: false, flatten: true, src: ['src/js/app.js'], dest: 'dist/js/app.js' }
                ]
            }
        },
        watch: {
            scripts: {
                files: ['<%= settings.dir.src %>/js/**/*.js'],
                tasks: ['uglify','replace'],
                options: {
                    livereload: true,
                },
            },
            css: {
                files: ['<%= settings.dir.src %>/scss/**/*.scss'],
                tasks: ['sass'],
                options: {
                    livereload: true,
                },
            },
            html: {
                files: ['<%= settings.dir.src %>/**/*.html'],
                tasks: ['copy'],
                options: {
                    livereload: true,
                },
            },
        }
    };
    grunt.initConfig(appConfig);
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.registerTask('default', ['copy', 'sass', 'uglify','replace']);
};
