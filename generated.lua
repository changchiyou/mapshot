-- Automatically generated, do not modify
local data = {}
data.html = [==[
<html>

<head>
  <title>Mapshot</title>
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.6.0/dist/leaflet.css"
    integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6KEQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ=="
    crossorigin="" />
  <script src="https://unpkg.com/leaflet@1.6.0/dist/leaflet.js"
    integrity="sha512-gZwIG9x3wUXg2hdXF6+rVkLF/0Vi9U8D2Ntg4Ga5I5BZpVkVxlJWbSQtXPSiUTtC0TjtGOmxa1AJPuV0CPthew=="
    crossorigin=""></script>
</head>

<body>
  <div id="map" style="height: 100%;"></div>
  <script>
    'use strict';
    const params = new URLSearchParams(window.location.search);
    let path = params.get("path") ?? "";
    if (!!path && path[path.length - 1] != "/") {
      path = path + "/";
    }
    console.log("Path", path);

    fetch(path + 'mapshot.json')
      .then(resp => resp.json())
      .then(info => {
        console.log("Map info", info);



        const worldToLatLng = function (x, y) {
          const ratio = info.render_size / info.tile_size;
          return L.latLng(
            -y * ratio,
            x * ratio
          );
        };

        const mymap = L.map('map', {
          crs: L.CRS.Simple,
        });

        L.tileLayer(path + "zoom_{z}/tile_{x}_{y}.jpg", {
          tileSize: info.render_size,
          bounds: L.latLngBounds(
            worldToLatLng(info.world_min.x, info.world_min.y),
            worldToLatLng(info.world_max.x, info.world_max.y),
          ),
          noWrap: true,
          maxNativeZoom: info.zoom_max,
          minNativeZoom: info.zoom_min,
          minZoom: info.zoom_min - 4,
          maxZoom: info.zoom_max + 4,
        }).addTo(mymap);

        L.marker([0, 0], { title: "Start" }).addTo(mymap);
        L.marker(worldToLatLng(info.player.x, info.player.y), { title: "Player" }).addTo(mymap);

        mymap.setView([0, 0], 0);
      });
  </script>
</body>

</html>]==]
return data
