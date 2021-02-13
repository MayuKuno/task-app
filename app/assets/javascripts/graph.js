document.addEventListener("DOMContentLoaded", function(){
var ctx = document.getElementById("chart1");

var chart1 = new Chart(ctx, {
  type: 'doughnut',
  data: {
    labels: gon.data,
    datasets: [{
        backgroundColor: [
            "#CB0000",
            "#4897D8",
            "#FFBB00",
            "#DE7A22",
            "#4B7447"
        ],
        data: [
          getNumber(gon.data[0]), //gon.labelという配列の中のredの数
          getNumber(gon.data[1]),
          getNumber(gon.data[2]),
          getNumber(gon.data[3]),
          getNumber(gon.data[4]),
        ]
    }]
  },
  options: {

  }
});

function getNumber(num){
    var count = gon.label.filter(function(x){return x === num}).length;
    return count;
}



var ctx2 = document.getElementById("chart2");

var chart2 = new Chart(ctx2, {
  type: 'doughnut',
  data: {
    labels: ["Waiting", "Working", "Completed"],
    datasets: [{
        backgroundColor: [
            "#f98866",
            "#375E97",
            "#6AB187",
        ],
        data: [
          getStatus("Waiting"),
          getStatus("Working"),
          getStatus("Completed")
        ]
    }]
  },
});

function getStatus(status){
    var count = gon.statu.filter(function(x){return x === status}).length;
    return count;
}



let result = chart1.data.datasets[0].data;
let total = result.reduce((sum, element) => sum + element, 0);
if (total == 0){
  var inside1 = document.getElementById("inside1");
  inside1.textContent = "No Data Found";
}



if(gon.statu.length === 0){
  var inside2 = document.getElementById("inside2");
  inside2.textContent = "No Data Found";
}


}, false);



