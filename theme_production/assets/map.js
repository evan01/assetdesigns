//GET Request and calling functions
function getData(map) {
    $.get("/apps/map", function (data) {
          console.log("DATA");
          document.getElementById("map_container").innerHTML = data;
        //   $('#map').html = data;
        console.log("done"); 
    });
}

$(document).ready(function() {
    getData();
});