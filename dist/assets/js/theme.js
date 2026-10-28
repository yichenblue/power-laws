(function () {
  "use strict";
  var system = window.matchMedia("(prefers-color-scheme: dark)");
  function apply() {
    var theme = system.matches ? "dark" : "light";
    document.documentElement.dataset.theme = theme;
    document.documentElement.style.colorScheme = theme;
  }
  apply();
  if (system.addEventListener) system.addEventListener("change", apply);
  else if (system.addListener) system.addListener(apply);
})();
