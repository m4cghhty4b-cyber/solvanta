// flutter_bootstrap.js - Custom Flutter web bootstrap configuration
// This configures Flutter to use system fonts instead of downloading from Google Fonts
// to avoid network errors when fonts.gstatic.com is unreachable.

(function() {
  // Configure Flutter to use system fonts
  window.flutterConfiguration = {
    // Use system fonts instead of downloading from Google Fonts
    fontFamily: 'system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif',
    // Disable the default font manifest loading
    disableFontLoading: true,
  };

  // Load the actual Flutter loader
  var script = document.createElement('script');
  script.src = 'flutter.js';
  script.async = true;
  document.body.appendChild(script);
})();