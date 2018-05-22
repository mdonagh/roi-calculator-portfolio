# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

getBusinessQuarters =(profitAchieved, paybackQuarter) ->
  quarters = []
  today = new Date()
  year = today.getFullYear()
  quarter = Math.floor((today.getMonth() + 3) / 3)
  while(quarters.length < 16)
    quarter_string = "Q" + String(quarter) + " " + String(year)
    quarters.push(quarter_string)
    if quarter == 4 
      quarter = 1
      year = year + 1
    else 
      quarter = quarter + 1
  quarters[paybackQuarter] = quarters[paybackQuarter] + " - Payback Achieved!"
  return quarters

splitTruckRollProfitsOverTwoYears = (profits) ->
  quarterly_profit = Math.round(profits / 16)
  profits = []
  cumulative_profits = quarterly_profit
  while(profits.length < 16)
    profits.push(cumulative_profits)
    cumulative_profits = cumulative_profits + quarterly_profit
  return profits

paybackAchievedQuarter = (paybackAchieved) ->
  if paybackAchieved < 65
    return 0
  else if paybackAchieved < (65 * 2)
    return 1
  else if paybackAchieved < (65 * 3)
    return 2
  else if paybackAchieved < (65 * 4)
    return 3
  else if paybackAchieved < (65 * 5)
    return 4
  else if paybackAchieved < (65 * 6)
    return 5
  else if paybackAchieved < (65 * 7)
    return 6
  else
    return 7

getbackgroundColors = (paybackQuarter)->
  colors = [
          'rgba(255, 99, 132, 0.2)'
          'rgba(54, 162, 235, 0.2)'
          'rgba(255, 206, 86, 0.2)'
          'rgba(75, 192, 192, 0.2)'
          'rgba(153, 102, 255, 0.2)'
          'rgba(255, 159, 64, 0.2)'
          'rgba(255, 99, 132, 0.2)'
          'rgba(54, 162, 235, 0.2)'
          'rgba(255, 206, 86, 0.2)'
          'rgba(75, 192, 192, 0.2)'
          'rgba(153, 102, 255, 0.2)'
          'rgba(255, 159, 64, 0.2)'
          'rgba(255, 99, 132, 0.2)'
          'rgba(54, 162, 235, 0.2)'
          'rgba(255, 206, 86, 0.2)'
          'rgba(75, 192, 192, 0.2)'
          'rgba(153, 102, 255, 0.2)'
          'rgba(255, 159, 64, 0.2)'
          'rgba(255, 99, 132, 0.2)'
          'rgba(54, 162, 235, 0.2)'
          'rgba(255, 206, 86, 0.2)'
          'rgba(75, 192, 192, 0.2)'
          'rgba(153, 102, 255, 0.2)'
          'rgba(255, 159, 64, 0.2)'
        ]
  colors[paybackQuarter] = 'rgba(133, 187, 101, 0.2)'
  return colors

getborderColors = (paybackQuarter)->
  colors = [
          'rgba(255,99,132,1)'
          'rgba(54, 162, 235, 1)'
          'rgba(255, 206, 86, 1)'
          'rgba(75, 192, 192, 1)'
          'rgba(153, 102, 255, 1)'
          'rgba(255, 159, 64, 1)'
          'rgba(255,99,132,1)'
          'rgba(54, 162, 235, 1)'
          'rgba(255, 206, 86, 1)'
          'rgba(75, 192, 192, 1)'
          'rgba(153, 102, 255, 1)'
          'rgba(255, 159, 64, 1)'
          'rgba(255,99,132,1)'
          'rgba(54, 162, 235, 1)'
          'rgba(255, 206, 86, 1)'
          'rgba(75, 192, 192, 1)'
          'rgba(153, 102, 255, 1)'
          'rgba(255, 159, 64, 1)'
          'rgba(255,99,132,1)'
          'rgba(54, 162, 235, 1)'
          'rgba(255, 206, 86, 1)'
          'rgba(75, 192, 192, 1)'
          'rgba(153, 102, 255, 1)'
          'rgba(255, 159, 64, 1)'
        ]
  colors[paybackQuarter] = 'rgba(133, 187, 101,1)'
  return colors

drawChart = (data) ->
  paybackQuarter = paybackAchievedQuarter(data.payback_achieved)
  ctx = document.getElementById('myChart').getContext('2d')
  myChart = new Chart(ctx,
    type: 'bar'
    data:
      labels: getBusinessQuarters(paybackQuarter, paybackQuarter)
      datasets: [ {
        scaleLabel: [display: false]
        data: splitTruckRollProfitsOverTwoYears(data.profit_from_additional_truck_rolls)
        backgroundColor: getbackgroundColors(paybackQuarter)
        borderColor: getborderColors(paybackQuarter)
        borderWidth: 1
      } ]
    options: 
      legend: display: false 
      responsive: true
      scales: yAxes: [ { ticks:
                          beginAtZero: true
                          callback: (value, index, values) ->
                            '$' + value.toLocaleString()
                     } ]
      title: {
        display: true,
        text: 'Profit from Additional Truck Rolls by Quarter'
      }
    )


$(document).ready ->
  roi_data = undefined

  populateMobileTable = ->
    $('#profit_from_additional_truck_rolls_small').animateNumber(
      {
        number: roi_data.profit_from_additional_truck_rolls,
        numberStep: comma_separator_number_step
      }
    )
    $('#eliminated_costs_from_return_visits_small').animateNumber(
      {
        number: roi_data.eliminated_costs_from_return_visits,
        numberStep: comma_separator_number_step
      }
    )
    $('#total_annual_savings_small').animateNumber(
      {
        number: roi_data.total_annual_savings,
        numberStep: comma_separator_number_step
      }
    )
    $('#savings_per_service_tech_small').animateNumber(
      {
        number: roi_data.savings_per_service_tech,
        numberStep: comma_separator_number_step
      }
    )
    $('#monthly_pricing_per_service_tech_small').animateNumber(
      {
        number: roi_data.monthly_pricing_per_service_tech,
        numberStep: comma_separator_number_step
      }
    )
    $('#total_roi_small').animateNumber(
      {
        number: roi_data.total_roi,
        numberStep: comma_separator_number_step
      }
    )
    $('#payback_achieved_small').animateNumber(
      {
        number: roi_data.payback_achieved,
        numberStep: comma_separator_number_step
      }
    )


  populateSavings = ->
    $('#profit_from_additional_truck_rolls').animateNumber(
      {
        number: roi_data.profit_from_additional_truck_rolls,
        numberStep: comma_separator_number_step
      }
    )
    $('#eliminated_costs_from_return_visits').animateNumber(
      {
        number: roi_data.eliminated_costs_from_return_visits,
        numberStep: comma_separator_number_step
      }
    )
    $('#total_annual_savings').animateNumber(
      {
        number: roi_data.total_annual_savings,
        numberStep: comma_separator_number_step
      }
    )
    $('#savings_per_service_tech').animateNumber(
      {
        number: roi_data.savings_per_service_tech,
        numberStep: comma_separator_number_step
      }
    )

  populatePricing = ->
    $('#monthly_pricing_per_service_tech').animateNumber(
      {
        number: roi_data.monthly_pricing_per_service_tech,
        numberStep: comma_separator_number_step
      }
    )

  populateRequestMeeting = ->
    $('#roi_id').val(roi_data.id)
    $('#roi_name').val(roi_data.name)
    $('#roi_email').val(roi_data.email)
    $('#roi_telephone').val(roi_data.telephone)
    $('#roi_company').val(roi_data.company)

  populateRoi = ->
    $('#total_roi').animateNumber(
      {
        number: roi_data.total_roi,
        numberStep: comma_separator_number_step
      }
    )
    $('#payback_achieved').animateNumber(
      {
        number: roi_data.payback_achieved,
        numberStep: comma_separator_number_step
      }
    )

  comma_separator_number_step = $.animateNumber.numberStepFactories.separator(',')
  $('#assumptions-button').on 'click', ->

    $('#business-assumptions').toggle('show')
    if $('#assumptions-button').html() is 'Show Assumptions'
      $('#assumptions-button').html 'Hide Assumptions'
    else
      $('#assumptions-button').html 'Show Assumptions'

  $('#pricing-tab').on 'click', ->
    $( '#savings-tab' ).removeClass( "active" )
    $( '#roi-tab' ).removeClass( "active" )
    $( '#pricing-tab' ).addClass( "active" )
    $('.savings-info').hide()
    $('.roi-info').hide()
    $('.pricing-info').show()
    populatePricing()

  $('#savings-tab').on 'click', ->
    $( '#pricing-tab' ).removeClass( "active" )
    $( '#roi-tab' ).removeClass( "active" )
    $( '#savings-tab' ).addClass( "active" )
    $('.pricing-info').hide()
    $('.roi-info').hide()
    $('.savings-info').show()
    populateSavings()

  $('#roi-tab').on 'click', ->
    $( '#pricing-tab' ).removeClass( "active" )
    $( '#savings-tab' ).removeClass( "active" )
    $( '#roi-tab' ).addClass( "active" )
    $('.pricing-info').hide()
    $('.savings-info').hide()
    $('.roi-info').show()
    populateRoi()

  hide_spinner = ->
    $('#pdf_link').show()
    $('#spinner').hide()

  stop_all_timeouts = ->
    id = window.setTimeout(null, 0)
    while id--
      window.clearTimeout id
    return

  check_pdf_status = ->
    uuid = $("#pdf_link").attr("href").split('/').pop()
    url = "/rois/" + uuid + "/pdf_ready"
    $.get url, (data) ->
      if data == true
        hide_spinner()
        stop_all_timeouts()
        return
    setTimeout(check_pdf_status, 500)

  $('#pdf_link').on 'click', ->
    $('#pdf_link').hide()
    $('#spinner').show()
    check_pdf_status()

  $('#pdf_link').on 'touchstart click', ->
    $('#spinner').show()
    $('#pdf_link').hide()
    window.location.href =  $('#pdf_link').attr('href');
    check_pdf_status()

  $('#change_entries_link').on 'click', ->
    $('#second_page').hide()
    $('#first_page').show()

  $('#schedule_meeting_button').on 'click', ->
    $('#schedule_meeting_form').toggle('show')

  $("#form_page").on("ajax:success", (e, data, status, xhr) ->
    roi_data = data
    $('#first_page').hide()
    populateSavings()
    populateMobileTable()
    populateRequestMeeting()
    $("#pdf_link").attr("href", "/rois/" + data.uuid)
    $('#second_page').show()
    $("#chartContainer").html('<canvas id="myChart"></canvas>');
    drawChart(data)
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#second_page").append "<p>ERROR</p>"

  $("#schedule_meeting").on("ajax:success", (e, data, status, xhr) ->
    $('#thank_you').toggle('show')
    $('#inner_form').toggle('hide')

  ).on "ajax:error", (e, xhr, status, error) ->
    $("#second_page").append "<p>ERROR</p>"
