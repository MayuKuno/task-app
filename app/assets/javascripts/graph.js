document.addEventListener("DOMContentLoaded", function(){
var ctx = document.getElementById("myPieChart");
var myPieChart = new Chart(ctx, {
  type: 'doughnut',
  data: {
    labels: gon.data,
    datasets: [{
        backgroundColor: [
            "#BB5179",
            "#3C00FF",
            "#FAFF67",
            "#FFA500",
            "#58A27C"
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
    title: {
      display: true,
      text: '血液型 割合'
    }
  }
});
function getNumber(num){
    var count = gon.label.filter(function(x){return x === num}).length;
    return count;
}
}, false);
