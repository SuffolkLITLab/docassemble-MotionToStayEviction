// Limit upload size of file

// TODO: Explore CustomDatatype js instead of the js in here
// TODO: Keep track of total size of all files since files can be added on different pages.

var dom_data = {};

var clear_error = function () {
  /* Removes error message, enables continue button. */
  var $error = $('.da-field-container-datatype-files label.da-has-error');
  // We can fiddle with this behavior if desired.
  $error.css( 'display', 'none' );
  $error.text( '' );
  
  // re-enable continue button (assumes continue button)
  var next = $('.da-field-buttons button[type="submit"]')[0];
  next.disabled = false;
  
  // Clear listeners so they don't pile up
  $('.fileinput-remove').off( 'click', clear_error );
};   // Ends clear_error()

var prevent_big_files = function ( var_data ) {
  /* If the size of uploaded files is too big, show an
  *    error and don't allow the user to continue. */
  var max_mb = var_data.variables.max_mb_per_file;
  var max_bytes = max_mb * 1000 * 1000;
  var files = dom_data.upload_node.files

  var total_size = 0;
  for ( var file_i = 0; file_i < files.length; file_i++ ) {
    total_size += files[ file_i ].size;
  }
  
  if ( total_size > max_bytes ) {
    var $error = $('.da-field-container-datatype-files label.da-has-error');
    $error.css( 'display', 'inline-block' );
    // WARNING: This message is not going to be translated currently
    // See notes in YAML about possibly translating: var_data.variables.file_size_error_message
    $error.text( 'The size of all the files together needs to be less than ' + max_mb + ' MB' );
    
    // Disable continuing to next page.
    // Assumes there's a continue button
    var next = $('.da-field-buttons button[type="submit"]')[0];
    next.disabled = true;
    
    // Listen for removal of file
    $('.fileinput-remove').on( 'click', clear_error );
 
  // Otherwise make sure the error state stuff is removed/not present
  } else { clear_error(); }
};  // Ends prevent_big_files()



$( document ).ready(function () {
  // When the document is ready, start listening for the relevant events
  
  // The file input field itself changing (getting a value)
  $('.dafile').on( 'change', function (evnt) {
    dom_data.upload_node = evnt.target;
    get_interview_variables( prevent_big_files );  // A da function
  });
  
  // The drag and drop area getting a file dropped
  $(document.body).on('drop', function (event) {
    var $dafiles = $('.dafile');
    if ( $dafiles ) {
      var $dafile = $dafiles[0];
      if ( $dafile ) {
        dom_data.upload_node = $dafile[0];
        get_interview_variables( prevent_big_files );  // A da function
      }
    }
  });
  
});  // ends on document ready
