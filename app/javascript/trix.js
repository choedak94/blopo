// app/javascript/trix.js
import Trix from 'trix';

document.addEventListener('trix-file-accept', function(event) {
  event.preventDefault();
  alert('File attachment not allowed!');
});

// Customize Trix toolbar buttons, etc.
// See Trix documentation for more options
