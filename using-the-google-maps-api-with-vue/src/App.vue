<template>
  <div class="App"/>
</template>


<script>
import MarkerClusterer from '@google/markerclusterer';

import gmapsInit from './utils/gmaps';

const locations = [

  {
    position: {
      lat: 58.3792364,
      lng: 26.720529,
    },
  },  
  
  {
    position: {
      lat: 58.3823081,
      lng: 26.7348673,
    },
  },
];

export default {
  name: `App`,
  async mounted() {
    try {
      const google = await gmapsInit();
      const geocoder = new google.maps.Geocoder();
      const map = new google.maps.Map(this.$el);

      geocoder.geocode({ address: `Tartu, Estonia` }, (results, status) => {
        if (status !== `OK` || !results[0]) {
          throw new Error(status);
        }

        map.setCenter(results[0].geometry.location);
        map.fitBounds(results[0].geometry.viewport);
        map.setZoom(15);
      });

      var infoWindowContent = '<div class="info_content">' +
        '<h3>Parking Spot 1</h3>' +
        '<h4>Price: 1 EUR / 2 hour</h4>' +
        '<p>AS Ühisteenused, Magistri, 51005 Tartu, Estonia</p>' +
        '</div>';

      var infowindow = new google.maps.InfoWindow({
        content:infoWindowContent
      });

      const markerClickHandler = (marker) => {
        infowindow.open(map, marker)
        map.setZoom(18);
        map.setCenter(marker.getPosition());
      };

      const markers = locations
        .map((location) => {
          const marker = new google.maps.Marker({ ...location, map });
          marker.addListener(`click`, () => markerClickHandler(marker));

          return marker;
        });

      // eslint-disable-next-line no-new
      new MarkerClusterer(map, markers, {
        imagePath: `https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m`,
      });
    } catch (error) {
      // eslint-disable-next-line no-console
      console.error(error);
    }
  },
};
</script>

<style>
html,
body {
  margin: 0;
  padding: 0;
}

.App {
  width: 100vw;
  height: 100vh;
}
</style>
