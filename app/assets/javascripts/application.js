// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks

//= require_tree .
//
//= require moment
//= require moment/ja
//= require bootstrap-datetimepicker


function showTab(selector) {
  $(".nav-tabs li").removeClass("active");
  $(".nav-tabs a[href='" + selector + "']").parent("li").addClass("active");
  $(".tab-content > div").hide();
  $(selector).show();
}



$(function(){
  $('.datepicker').datetimepicker({
    format: "YYYY/MM/DD HH:mm",
    showClear: true,
    showClose: true,
  });
  
  
  $(".nav-tabs li:nth-child(1)").addClass("active");
  $(".nav-tabs a").click(function() {
    var selector = $(this).attr("href");
    showTab(selector);
    return false;
  });
  
  
  $fileField = $('#file')
  
  $($fileField).on('change', $fileField, function(e) {
    file = e.target.files[0]
    reader = new FileReader(),
    $preview = $("#img_field");
    
    reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.append($('<img>').attr({
          src: e.target.result,
          width: "130px",
          height: "130px",
          class: "preview",
          title: file.name
        }));
      };
    })(file);
    reader.readAsDataURL(file);
  });
});