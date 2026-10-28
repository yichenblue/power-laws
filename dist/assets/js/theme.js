(function () {
  "use strict";
  var key = "power-laws-article-theme";
  var system = window.matchMedia("(prefers-color-scheme: dark)");
  var saved = null;
  try { saved = localStorage.getItem(key); } catch (_) {}
  function apply(theme) {
    document.documentElement.dataset.theme = theme;
    document.documentElement.style.colorScheme = theme;
    var button = document.querySelector(".theme-button");
    if (button) {
      var dark = theme === "dark";
      var zh = /^zh/.test(document.documentElement.lang);
      button.setAttribute("aria-pressed", String(dark));
      button.querySelector("span").textContent = zh ? "深色模式" : "Dark mode";
    }
  }
  apply(saved === "dark" || saved === "light" ? saved : system.matches ? "dark" : "light");
  document.addEventListener("DOMContentLoaded", function () {
    apply(document.documentElement.dataset.theme);
    document.querySelector(".theme-button").addEventListener("click", function () {
      saved = document.documentElement.dataset.theme === "dark" ? "light" : "dark";
      apply(saved);
      try { localStorage.setItem(key, saved); } catch (_) {}
    });
  });
  if (system.addEventListener) system.addEventListener("change", function () {
    if (!saved) apply(system.matches ? "dark" : "light");
  });
})();
