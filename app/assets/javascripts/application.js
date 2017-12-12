// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require materialize-sprockets
//= require filterrific/filterrific-jquery
//= require_tree .


document.addEventListener("turbolinks:load", function() {
    $('select').material_select();
    $(".button-collapse").sideNav();
    $('.alert').append('<button class="waves-effect btn-flat close"><i class="material-icons">close</i></button>');

    $('body').on('click', '.alert .close', function() {
        $(this).parent().fadeOut(300, function() {
            $(this).remove();
        });
    });

    tinymce.remove();
    tinymce.init({

        selector: 'textarea#job_description',
        height: 350,
        plugins: "lists advlist textpattern",
        advlist_bullet_styles: "square",
        toolbar: "undo redo | stylesheet | bold italic | numlist bullist | alignleft aligncenter alignright alignjustify",
        textpattern_patterns: [
            {start: '*', end: '*', format: 'italic'},
            {start: '**', end: '**', format: 'bold'},
            {start: '#', format: 'h1'},
            {start: '##', format: 'h2'},
            {start: '###', format: 'h3'},
            {start: '####', format: 'h4'},
            {start: '#####', format: 'h5'},
            {start: '######', format: 'h6'},
            {start: '1. ', cmd: 'InsertOrderedList'},
            {start: '* ', cmd: 'InsertUnorderedList'},
            {start: '- ', cmd: 'InsertUnorderedList'}
        ]


    });
});


