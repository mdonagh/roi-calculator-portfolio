# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

drawChart = (data) ->
  ctx = document.getElementById('myChart').getContext('2d')
  myChart = new Chart(ctx,
    type: 'bar'
    data:
      labels: [
        'Additional Truck Roll Profits'
        'Eliminated Costs from Return Visits'
        'Total Annual Savings'
      ]
      datasets: [ {
        label: 'Dollars Saved'
        scaleLabel: [display: false]
        data: [
          data.profit_from_additional_truck_rolls
          data.eliminated_costs_from_return_visits
          data.total_annual_savings
        ]
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)'
          'rgba(54, 162, 235, 0.2)'
          'rgba(255, 206, 86, 0.2)'
          'rgba(75, 192, 192, 0.2)'
          'rgba(153, 102, 255, 0.2)'
          'rgba(255, 159, 64, 0.2)'
        ]
        borderColor: [
          'rgba(255,99,132,1)'
          'rgba(54, 162, 235, 1)'
          'rgba(255, 206, 86, 1)'
          'rgba(75, 192, 192, 1)'
          'rgba(153, 102, 255, 1)'
          'rgba(255, 159, 64, 1)'
        ]
        borderWidth: 1
      } ]
    options: 
      legend: display: false 
      responsive: false
      scales: yAxes: [ { ticks: beginAtZero: true } ]
    )
