// wait for the DOM to be ready before binding
jQuery(document).ready(function($) {

  // bind to the left button
  $('.left-button').click(function(event) {
    // toggle the visibility of the left sidebar
    $('.left-sidebar').toggle();
    // toggle the class 'left-active' on the .content div
    $('.content').toggleClass('left-active');
  });

  $('.right-button').click(function(event) {
    $('.right-sidebar').toggle();
    $('.content').toggleClass('right-active');
  });

  $('.toggle-footer-menu').click(function(event) {
    // toggle the visibility of the closed list in the footer menu and slide it
    // into place
    $('.footer-menu .closed').slideToggle();
    $('.footer-menu .open').slideToggle();
  });

});
