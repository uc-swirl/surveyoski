
function extract_response_for_chart(data, number) {
  var stuff = extract_response_text(data, number);

  return stuff.reduce(function (hash, value) {
    if (! value) {
      return hash;
    }
    if (!hash[value.response]) {
      hash[value.response] = 0;
    }
    hash[value.response] += 1;
    return hash;
  }, {});
}


function extract_response_text(data, number) {
  return data.map(function (x) { return x[number]; })
}

function extract_question_name(data, number) {
  return data[0][number]['name'];
}


function calculate_number_fields (data) {
  return data.reduce(function (max, val) {
  return Math.max(max, val.length);
  }, 0);
}

jQuery(document).ready(function () {

  jQuery(".response_container").each(function (index, element) {
    var response_container = jQuery(element);

    jQuery.get(response_container.attr('data-route'), function( data ) {
      var number_fields = calculate_number_fields(data);
      for (var i = 0; i < number_fields; i++) {
        var num_responses = data.length;
        var freq = extract_response_for_chart(data, i);
        var question_name = extract_question_name(data, i);
        var histograms = Object.keys(freq).map (function (b) { return {response : b, frequency : (freq[b] / num_responses), total : freq[b]  }});

        var number_unique_responses = histograms.length;

        var string_values = Object.keys( freq )
        var all_responses_numeric = string_values.reduce(function (a, b) { return a && !isNaN(b) }, true);

        jQuery("<h3/>", {"class" : "response_question_title", text : question_name}).appendTo(response_container);

        if (number_unique_responses <= 16) {
          generate_chart(response_container[0], histograms);
        } 
        if (all_responses_numeric) {
         var float_values = string_values.map (function (x) { return parseFloat(x, 10); });
         generate_numeric_averages(response_container, float_values);
        } else {
          generate_text_response_display(response_container, extract_response_text(data, i));
        }

        if (i + 1 < number_fields) {
          jQuery("<hr/>").appendTo(response_container);
        }
      }

    });
  });

});


function generate_text_response_display(response_container, text_responses) {
  var container = jQuery("<div/>", {"class" : "text_response_display_container"}).appendTo(response_container);
  var title = jQuery("<h3/>", {"class" : "text_response_display_title", text : "Text Responses (Show)"}).appendTo(container);
  var title_alt_text = "Text Responses (hide)";

  var response_container = jQuery("<ul/>", {"class" : "text_response_display"}).appendTo(container);
  jQuery.each(text_responses, function(index, value) {
    if (value) {
     jQuery("<li/>", {text: value['response']}).appendTo(response_container);
    }
  });

  response_container.hide();

  title.click(function () {
    response_container.toggle();
    var temp = title.html();
    title.html(title_alt_text);
    title_alt_text = temp;
  });

}


function generate_numeric_averages(response_container, float_values) {
  var mean = d3.mean(float_values);
  var median = d3.median(float_values);
  var stats = jQuery("<div/>", {"class" : "response_stats_container"}).appendTo(response_container);

  jQuery("<p><strong>Mean</strong>: "+mean+" </p>").appendTo(stats);
  jQuery("<p><strong>Median</strong>: "+median+" </p>").appendTo(stats);
}

function generate_chart(response_container, data) {
  var margin = {top: 20, right: 20, bottom: 30, left: 40},
      width = 900 - margin.left - margin.right,
      height = 200 - margin.top - margin.bottom;

  var x = d3.scale.ordinal()
      .rangeRoundBands([0, width], .1);

  var y = d3.scale.linear()
      .range([height, 0]);

  var xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom");

  var yAxis = d3.svg.axis()
      .scale(y)
      .orient("left")
      .ticks(10, "%");

  var svg = d3.select(response_container).append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    x.domain(data.map(function(d) { return d.response; }));
    y.domain([0, d3.max(data, function(d) { return d.frequency; })]);

    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")


    svg.selectAll(".bar")
        .data(data)
      .enter().append("rect")
        .attr("class", "bar")
        .attr("x", function(d) { return x(d.response); })
        .attr("width", x.rangeBand())
        .attr("y", function(d) { return y(d.frequency); })
        .attr("height", function(d) { return height - y(d.frequency); });
    var color = d3.scale.category20();
    svg.selectAll(".bar").attr("fill",function(d,i){return color(i);});


    svg.selectAll(".bar").on("mouseover", function(d) {  
      makeToolTip(d['total'] + " ( " + Math.round(100 *d['frequency']) + "% )");
    }).on("mouseout", deletetooltip);


  function type(d) {
    d.frequency = +d.frequency;
    return d;
  }


}

var tooltipcontainer; 
function makeToolTip(msg) {
    deletetooltip();
    var style =  "z-index: 100000000; border-radius: 5px; position: absolute; min-width: 100px; border: 1px solid rgb(168, 184, 219);box-shadow: rgb(73, 73, 73) 0px 1px 4px 1px;text-align: center; padding: 5px;background: white;";
    tooltipcontainer = jQuery("<div/>", {"style" : style, "id" : "#tooltipbox"}).appendTo("body");
    tooltipcontainer.html(msg);
    jQuery( document ).mousemove(function( event ) {
      jQuery(tooltipcontainer).offset({ top: event.pageY -10, left: event.pageX + 20 });
    });
}

function deletetooltip() {
    if (tooltipcontainer)
        tooltipcontainer.detach();
}