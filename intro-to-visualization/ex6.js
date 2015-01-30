var width = 300,
    height = 300;

var yAxisWidth = 50; 
var xAxisHeight = 50;

  
var x_name="sepalLength";
var y_name="sepalWidth";

var xMax=d3.max(dataset.values, function(d) { return d[x_name]; });
var yMax=d3.max(dataset.values, function(d) { return d[y_name]; });

var paddingX=Math.ceil(xMax);
var paddingY=Math.ceil(yMax)


var xScale=d3.scale.linear()
						.domain([0, paddingX])
						.range([xAxisHeight, width]);
						
var yScale=d3.scale.linear()
						.domain([0, paddingY])
						.range([height-xAxisHeight, 0]);
												    
var plot=d3.select('#scatterplot').append('svg')
					.attr({ 'width': width, 'height': height, })
					.style('background', 'white');

var xAxis = d3.svg.axis().scale(xScale).orient("bottom"); 
plot.append('g') 
			.attr({ 
							'class': 'x axis', 
							'transform': 'translate(0,' + (height - xAxisHeight) + ')', 
					}) 
			.call(xAxis); 

var yAxis = d3.svg.axis().scale(yScale).orient('left'); 
plot.append('g') 
			.attr({
						 'class': 'y axis', 
						 'transform': 'translate(' + yAxisWidth + ',0)', 
						}) 
			.call(yAxis); 

plot.append("text")
		.attr("class", "axisTitle")
    .attr("text-anchor", "middle")
    .attr("x", width/2)
    .attr("y", height-20)
    .text(x_name);

plot.append("text")
		.attr("class", "axisTitle")
    .attr("text-anchor", "middle")
    .attr("y", 10)
    .attr("x", 0-height/2)
    .attr("transform", "rotate(-90)")
    .text(y_name);

       				
var pointX=function(d) { return xScale(d[x_name]); };
var pointY=function(d) { return yScale(d[y_name]); };

var color=d3.scale.category10().domain(dataset.species);
var pointColor=function(d) {return color(d["species"]); };
	
plot.selectAll('.circle')
		.data(dataset.values).enter()
  .append('circle')
  	.attr({ 'cx': pointX, 
  					'cy': pointY, 
  					'r': 2, 
  					'fill': pointColor, 
  				});
	
