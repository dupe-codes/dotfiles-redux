Save this snippet as a bookmark in chrome/vivaldi/etc. to slurp current yt video:

```
javascript:(function() { var url = window.location.href; var xhr = new XMLHttpRequest(); xhr.open("GET", "http://localhost:8123?url=" + encodeURIComponent(url), true); xhr.send(); })();
```
