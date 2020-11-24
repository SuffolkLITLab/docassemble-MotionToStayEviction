// Limit upload size of file

// TODO: How to keep track of total size of all files since files can be added on different pages.

let dom_data = {};

let clear_error = function () {
  /* Removes error message, enables continue button. */
  let $error = $(`.da-field-container-datatype-files label.da-has-error`);
  // We can fiddle with this behavior if desired.
  $error.css( 'display', 'none' );
  $error.text( '' );
  
  // re-enable continue button
  let next = document.querySelector('.da-field-buttons button[type="submit"]');
  next.disabled = false;
  
  // Clear listeners so they don't pile up
  $('.fileinput-remove').off( 'click', clear_error );
};   // Ends clear_error()

let prevent_big_files = function ( var_data ) {
  /* Shows an error if a upload is too big and deletes the files */
  let max_mb = var_data.variables.max_mb_per_file;
  let max_bytes = max_mb * 1000 * 1000;
  let files = dom_data.upload_node.files
  console.log( var_data.variables.file_size_error_message );

  let total_size = 0;
  for ( let file of files ) { total_size += file.size; }
  let is_too_big = total_size > max_bytes;
  if ( total_size > max_bytes ) {
    let $error = $(`.da-field-container-datatype-files label.da-has-error`);
    $error.css( 'display', 'inline-block' );
    $error.text( `The size of all the files together needs to be less than ${ max_mb } mb` );
    // When the files are removed in here, the display
    // looks the same, which is very confusing. Instead
    // we're disabling the 'Next' button
    let next = document.querySelector('.da-field-buttons button[type="submit"]');
    next.disabled = true;
    
    // Listen for removal of file
    $('.fileinput-remove').on( 'click', clear_error );
    
  } else { clear_error(); }
};  // Ends prevent_big_files()

$( document ).ready(function () {
  
  $('.dafile').on( 'change', function (evnt) {
    dom_data.upload_node = evnt.target;
    get_interview_variables( prevent_big_files );
  });
  
  $(document.body).on('drop', function (event) {
    let files_input = document.querySelector('.dafile');
    dom_data.upload_node = document.querySelector('.dafile');
    get_interview_variables( prevent_big_files );
  });

});