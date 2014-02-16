// wait for the DOM to be ready before binding
jQuery(document).ready(function($) {

  // bind to the left button
  $('.left-button').click(function(event) {
    $('.left-sidebar').toggle();
    $('.content').toggleClass('left-active');
    $('.small').toggleClass('left-active');
    $('.right-button').toggleClass('left-active');

  });

  $('.right-button').click(function(event) {
    $('.right-sidebar').toggle();
    $('.content').toggleClass('right-active');
    $('.small').toggleClass('right-active');
    $('.left-button').toggleClass('right-active');
  });

  $('.toggle-footer-menu').click(function(event) {
    $('.footer-menu .closed').slideToggle();
    $('.footer-menu .open').slideToggle();
  });

});
