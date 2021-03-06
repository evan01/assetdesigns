/**
 * Created by luantran on 28/03/18.
 */
function initMap() {
    //Map styling
    var styledMapType = new google.maps.StyledMapType(
        [
            {elementType: 'geometry', stylers: [{color: '#E5E5E5'}]},
            {
                featureType: "administrative",
                elementType: "labels",
                stylers: [
                    {visibility: "off"}
                ]
            }, {
            featureType: "poi",
            elementType: "labels",
            stylers: [
                {visibility: "off"}
            ]
        },
            {
                featureType: 'land',
                elementType: 'geometry',
                stylers: [{color: '#190729'}]
            },
            {
                featureType: 'water',
                elementType: 'geometry',
                stylers: [{color: '#DDD1E7'}]
            },
            {
                featureType: 'water',
                elementType: 'labels.text.fill',
                stylers: [{color: '#000000'}]
            },
            {
                featureType: "road",
                elementType: "labels",
                stylers: [
                    {visibility: "off"}
                ]
            },
            {
                featureType: 'road',
                elementType: 'geometry',
                stylers: [
                    {visibility: "off"}
                ]
            }
        ],
        {name: 'Supply Map'}
    );

    /////////////////////////////MAP CREATION AND CENTERING //////////////////////////////////////
    //initialize the map
    var map = new google.maps.Map(document.getElementById('map'), {
        mapTypeControl: false, //disables switching of map topography
        center: new google.maps.LatLng(0, 0), //default centering, is changed later
        zoom: 2,
        minZoom: 1,
        mapTypeId: 'mystyle'
    });
    var control = document.getElementById('floating-panel');
    control.style.display = 'block';
    map.controls[google.maps.ControlPosition.LEFT].push(control);
    map.mapTypes.set('styled_map', styledMapType);
    map.setMapTypeId('styled_map');
    getData(map);
    ///////////////////////////// END MAP CREATION AND CENTERING //////////////////////////////////////
}
//GET Request and calling functions
function getData(map) {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange =
        function () {
            if (this.readyState == 4) {
                if (this.status == 200 || this.status == 304) {
                    var json = this.responseText;
                    var jsonData = JSON.parse(json);
                    var suppliers = jsonData.suppliers;
                    var connections = jsonData.supplierconnections;
                    var supplychains = jsonData.supplychains;
                    var products = jsonData.products;
                    addMarkers(suppliers, map);
                    displaySuppliersGrid(suppliers);
                    displaySupplyChains(suppliers, connections, supplychains, map);
                } else {
                    alert("Error retrieving locations from server!");
                }
            }
        }
    xhttp.open("GET", "https://6139e461.ngrok.io/all_data", true);
    xhttp.send();

}

function addMarkers(suppliers, map) {
    var marker, i;
    var infowindow = new google.maps.InfoWindow();

    for (i = 0; i < suppliers.length; i++) {
        marker = new google.maps.Marker({
            position: new google.maps.LatLng(suppliers[i].lattitude, suppliers[i].longitude),
            map: map
        });
        marker.setIcon('http://maps.google.com/mapfiles/ms/icons/green-dot.png');

        google.maps.event.addListener(marker, 'mouseover', (function (marker, i) {
            return function () {
                var contentString = '<div id="content">' +
                    '<div id="siteNotice">' +
                    '</div>' +
                    '<h1 id="firstHeading" class="firstHeading">' + suppliers[i].name + '</h1>' +
                    '<div id="bodyContent">' +
                    '<p>' + suppliers[i].description +
                    '</p>' +
                    '</div>' +
                    '</div>';
                infowindow.setContent(contentString);
                infowindow.open(map, marker);
            }
        })(marker, i));

        google.maps.event.addListener(marker, 'mouseout', (function (marker, i) {
            return function () {
                infowindow.close(map, marker);
            }
        })(marker, i));
    }
}

function displaySuppliersGrid(suppliers) {
    var grid = document.getElementById("grid_suppliers");
    var i;

    for (i = 0; i < suppliers.length; i++) {
        var newSupplierBox = document.createElement('div');
        newSupplierBox.className = 'col-3';
        var newHeading = document.createElement('h5');
        newHeading.innerHTML = suppliers[i].name;
        var newParagraph = document.createElement('p');
        newParagraph.innerHTML = suppliers[i].description;

        newSupplierBox.appendChild(newHeading);
        newSupplierBox.appendChild(newParagraph);
        grid.appendChild(newSupplierBox)
    }
}

function displaySupplyChains(suppliers, connections, supplychains, map) {
    supplychains[0].connections = [1, 2, 6];
    supplychains[1].connections = [1, 6];
    supplychains[2].connections = [5, 6];
    supplychains[3].connections = [7, 8];

    var i;
    var newList = document.getElementById("list");
    for (i = 0; i < supplychains.length; i++) {
        (function (map, suppliers, connections, supplychains, newList) {

            var polylines = new Array();
            var newEntry = document.createElement('button');
            newEntry.innerHTML = "<h4>" + supplychains[i].name.bold() + "</h4>" + "<p>" + supplychains[i].description + "</p>";
            newEntry.type = "button";
            newEntry.className = "list-group-item list-group-item-action";
            newList.appendChild(newEntry);
            var j;
            //Looping through all connections
            for (j = 0; j < supplychains[i].connections.length; j++) {
                polylines.push(getConnectionsSuppliers(connections, suppliers, supplychains[i].connections[j], map));
            }
            // for(var l = 0; l < polylines.length ; l++){
            //   console.log(polylines[l].getPath().getArray().toString());
            // }


            newEntry.addEventListener("click", function () {
                if (newEntry.className == "list-group-item list-group-item-action active") {
                    newEntry.className = "list-group-item list-group-item-action";
                    for (var l = 0; l < polylines.length; l++) {
                        polylines[l].setMap(null)
                    }
                } else {
                    newEntry.className = "list-group-item list-group-item-action active";
                    for (var l = 0; l < polylines.length; l++) {
                        polylines[l].setMap(map)
                    }
                }
            });
        }(map, suppliers, connections, supplychains, newList));
    }

}

function getConnectionsSuppliers(connections, suppliers, supplychains_conn, map) {
    var found = false;
    var conn_index = 0;
    while (!found && conn_index < connections.length) {
        if (supplychains_conn == connections[conn_index].id) {
            found = true;
        } else {
            conn_index = conn_index + 1;
        }
    }
    var supplier_id_1 = connections[conn_index].supplier_a_id;
    var supplier_id_2 = connections[conn_index].supplier_b_id;
    // console.log("ID: "+supplychains[i].connections[j]+" supplierA: "+supplier_id_1+" supplierB: "+supplier_id_2);

    var found1 = false;
    var found2 = false;
    var supplier1, supplier2;
    var supp_index = 0;
    while ((!found1 || !found2) && supp_index < suppliers.length) {
        if (supplier_id_1 == suppliers[supp_index].id) {
            found1 = true;
            supplier1 = suppliers[supp_index];
        }
        if (supplier_id_2 == suppliers[supp_index].id) {
            found2 = true;
            supplier2 = suppliers[supp_index];
        }
        supp_index = supp_index + 1;
    }
    // console.log("SupplierA: "+supplier1.name+" "+supplier1.lattitude + " "+supplier1.longitude);
    // console.log("SupplierB: "+supplier2.name+" "+supplier2.lattitude + " "+supplier2.longitude);
    var poly = new google.maps.Polyline({
        geodesic: true,
        strokeColor: '#0C7718',
        strokeOpacity: 1.0,
        strokeWeight: 4
    });
    path = poly.getPath();

    //Add coordinates to polyline
    startLatlng = new google.maps.LatLng(supplier1.lattitude, supplier1.longitude);
    endLatlng = new google.maps.LatLng(supplier2.lattitude, supplier2.longitude);
    path.push(startLatlng);
    path.push(endLatlng);

    var infowindow = new google.maps.InfoWindow();
    var inBetween = google.maps.geometry.spherical.interpolate(startLatlng, endLatlng, 0.5);
    infowindow.setPosition(inBetween);


    google.maps.event.addListener(poly, 'mouseover', (function (poly) {
        return function () {
            var contentString = "<p><b>" + "Transport mode:" + "</b></p>" + "<p><b> CO2 emissions: </b>" + connections[conn_index].co2_emission + "</p>" + "<p><b>Distance: </b>" + connections[conn_index].distance + "</p>";
            infowindow.setContent(contentString);
            infowindow.open(map);
        }
    })(poly));
    google.maps.event.addListener(poly, 'mouseout', (function (poly) {
        return function () {
            infowindow.close(map);
        }
    })(poly));

    return poly;
}

function img_create(src, alt, title) {
    var img = IEWIN ? new Image() : document.createElement('img');
    img.src = src;
    if ( alt != null ) img.alt = alt;
    if ( title != null ) img.title = title;
    return img;
}