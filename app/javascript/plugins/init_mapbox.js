import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';


const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10',
   
  });

  map.addControl(new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    mapboxgl: mapboxgl
  }));


  return map
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.info_window);
    
    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.backgroundColor = "rgba(255,0,0,0.3)";
    element.style.borderRadius = "50%";
    element.style.width = '50px';
    element.style.height = '50px';

    new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
  map.fitBounds(bounds, { padding: 50, maxZoom: 15 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    const map = buildMap(mapElement);
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);

  const clusters = document.querySelectorAll(".cluster")
  clusters.forEach((cluster)=>{
    if (cluster.dataset.lat != ""){
      cluster.addEventListener('click',(e)=>{
        map.flyTo({
          center: [
            cluster.dataset.lng,
            cluster.dataset.lat
          ],
          zoom: 13,
          essential: true // this animation is considered essential with respect to prefers-reduced-motion
          });
      });
    } 
  });
  
  
 

  }

  
};

export { initMapbox };