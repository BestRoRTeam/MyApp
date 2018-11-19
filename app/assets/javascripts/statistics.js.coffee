jQuery ->
  categoriesData = $('#categories').data('categories')
  chartData = $('#myChart').data('products')

  console.log(categoriesData)

  categories = {}
  day = -1
  dates = []

  for c in categoriesData
    categories[c.name] = []

  for i in [0...chartData.length]
    if i == 0 or chartData[i - 1].created_at.split("T")[0] != chartData[i].created_at.split("T")[0]
      dates.push(chartData[i].created_at.split("T")[0])
      day++
      for c in categoriesData
        categories[c.name].push(0)

    categories[chartData[i].category][day] += chartData[i].price * chartData[i].quantity

  chartDataSet = []
  colors = []
  categories_len = Object.keys(categories).length

  for i in [0...categories_len]
    curr = i%3
    r = if curr == 0 then i / categories_len * 255 else 255 - (i / categories_len * 255)*0.8
    g = if curr == 1 then i / categories_len * 255 else 255 - (i / categories_len * 255)*0.8
    b = if curr == 2 then i / categories_len * 255 else 255 - (i / categories_len * 255)*0.8
    colors.push("rgb("+r+", "+g+", "+b+")")

  color_index = 0
  for key, value of categories
    obj = new Object()
    obj.label = key
    obj.data = value
    obj.borderColor = colors[color_index]
    obj.backgroundColor = colors[color_index]
    obj.fill = false
    obj.borderWidth = 2
    chartDataSet.push(obj)
    color_index++

  ctx = document.getElementById('myChart').getContext('2d')
  myChart = new Chart(ctx,
    type: 'line'
    data:
      labels: dates
      datasets: chartDataSet
    options: scales: yAxes: [ { ticks: beginAtZero: true } ])
    