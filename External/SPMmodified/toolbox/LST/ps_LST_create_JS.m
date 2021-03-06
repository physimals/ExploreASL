function js_strout = ps_LST_create_JS(typ, jsid, r, strout, tlv)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

switch typ
    case 'long'
        js_strout = ['$(function () {\n', ...             
              '  var min_slice', jsid, ' = ', num2str(r(1)), ',\n', ...
              '  max_slice', jsid, ' = ', num2str(r(2)), ',\n', ...
              '  slice', jsid, ' = ', num2str(round(mean(r))), ';\n', ...
              '  $( \"#slider_', jsid, '\" ).slider({\n', ...
              '    min: min_slice', jsid, ',\n', ...
              '    max: max_slice', jsid, ',\n', ...
              '    value: slice', jsid, ',\n', ...
              '    slide: function( event, ui ) {\n', ...
              '      slice = ui.value;\n', ...
              '      $( \"#overlay', jsid, '\" ).attr(\"src\", \"overlay_1_2_\" + ui.value + \".png\");\n', ...
              '      $( \"#slice', jsid, '\" ).text(\"Slice \" + ui.value);\n', ...
              '    }\n', ...
              '  });\n', ...
              '  $( \"#button-left', jsid, '\" ).button({\n', ...
              '    icons: {\n', ...
              '      primary: \"ui-icon-carat-1-w\"\n', ...
              '    },\n', ...
              '    text: false,\n', ...
              '    }).click(function(event, ui){\n', ...
              '        if(slice', jsid, ' > min_slice', jsid, '){\n', ...
              '            slice', jsid, ' = slice', jsid, ' - 1;\n', ...
              '            $( \"#overlay', jsid, '\" ).attr(\"src\", \"overlay_1_2_\" + slice', jsid, ' + \".png\");\n', ...
              '            $( \"#slice', jsid, '\" ).text(\"Slice \" + slice', jsid, ');\n', ...
              '            $(\"#slider-1', jsid, '\").slider(\"option\", "value", slice);\n', ...
              '        }\n', ...
              '  });\n', ...
              '  $(\"#button-right', jsid, '\").button({\n', ...
              '    icons: {\n', ...
              '      primary: \"ui-icon-carat-1-e\"\n', ...
              '    },\n', ...
              '    text: false,\n', ...
              '    }).click(function(event, ui){\n', ...
              '        if(slice', jsid, ' < max_slice', jsid, '){\n', ...
              '            slice', jsid, ' = slice', jsid, ' + 1;\n', ...
              '            $( \"#overlay', jsid, '\").attr(\"src\", \"overlay_1_2_\" + slice', jsid, ' + \".png\");\n', ...
              '            $( \"#slice', jsid, '\").text(\"Slice \" + slice', jsid, ');\n', ...
              '            $(\"#slider-1', jsid, '\").slider(\"option\", \"value\", slice', jsid, ');\n', ...
              '        }\n', ...
              '  });\n', ...
              '  var paper_', jsid, ' = Raphael(\"canvas_', jsid, '\", 475, 325),\n', ...
              '       wframe = 475,\n', ...
              '       hframe = 325,\n', ...
              '       wbox1 = 275,\n', ...
              '       hbox1 = 275,\n', ...
              '       wbox2 = 85,\n', ...
              '       m_left = 60,\n', ...
              '       m_top = 5,\n', ...
              '       m_left2 = 20,\n', ...
              '       m_top2 = 20,\n', ...
              '       ', strout{5}, ...
              '       ', strout{6}, ...
              '       ', strout{1}, ...
              '       ', strout{4}, ...
              '       ', strout{3}, ...
              '       ', strout{2}, ...                    
              '       global_change = [', num2str(tlv_joint), ', ', num2str(tlv_decr), ', ',  num2str(tlv_unch), ', ',  num2str(tlv_incr), '],\n', ...
              '       tlv1_max = Math.max.apply(null, tlv1) * 1.05,\n', ...
              '       tlv2_max = Math.max.apply(null, tlv2) * 1.05,\n', ...
              '       tlv_max = Math.max(tlv1_max, tlv2_max),\n', ...
              '       tlv_min = 0,\n', ...
              '       xgrid = [', strgrid, '],\n', ...
              '       ygrid = xgrid,\n', ...
              '       joint_max = Math.max.apply(null, joint),\n', ...
              '       w_max = 40;\n\n', ...
              '  // ******************\n', ...
              '  // Lesion change plot\n', ...
              '  // ******************\n', ...           
              '  paper_', jsid, '.rect(m_left, m_top, wbox1, hbox1).attr({fill: \"#E1E1E1\", stroke: \"none\"});\n\n', ...                
              '  // x-axis\n', ...
              '  paper_', jsid, '.setStart();\n', ...
              '  for(var i = -1; i++ < (xgrid.length-1);){\n', ...
	          '     paper_', jsid, '.path(\"M\" + ((xgrid[i] / tlv_max) * (wbox1 - 2*m_left2) + m_left + m_left2) + \" \" + (m_top) + \"L\" + ((xgrid[i] / tlv_max) * (wbox1 - 2*m_left2) + m_left + m_left2) + \" \" + (hbox1 + m_top)).attr({stroke: \"#fff\", \"stroke-dasharray\": \"-\"});\n', ...
              '  }\n', ...
              '  var xgrid_code = paper_', jsid, '.setFinish();\n\n', ...                
              '  // ticks\n', ...
              '  paper_', jsid, '.setStart();\n', ...
              '  for(var i = -1; i++ < (xgrid.length-1);){\n', ...
	          '     paper_', jsid, '.text(((xgrid[i] / tlv_max) * (wbox1 - 2*m_left2) + m_left + m_left2), (m_top * 2 + hbox1), xgrid[i]).attr({\"font-family\": \"Courier New\", fill: \"#606060\"});\n', ...
              '  }\n', ...
              '  var xticks_code = paper_', jsid, '.setFinish();\n', ...
              '  paper_', jsid, '.text(m_left + (wbox1 / 2), hbox1+25, \"Lesion volume (ml) for t = 1\").attr({\"font-family\": \"Courier New\", fill: \"#606060\"});\n\n', ...                
              '  // y-axis\n', ...
              '  paper_', jsid, '.setStart();\n', ...
              '  for(var i = -1; i++ < (xgrid.length-1);){\n', ...
	          '     paper_', jsid, '.path(\"M\" + m_left + \" \" + ((hbox1 + m_top) - ((xgrid[i] / tlv_max) * (hbox1 - 2*m_top2) + m_top + m_top2)) + \"L\" + (m_left + wbox1) + \" \" +  ((hbox1 + m_top) - ((xgrid[i] / tlv_max) * (hbox1 - 2*m_top2) + m_top + m_top2))).attr({stroke: \"#fff\", \"stroke-dasharray\": \"-\"});\n', ...
              '  }\n', ...
              '  var ygrid_code = paper_', jsid, '.setFinish();\n\n', ...                
              '  // ticks\n', ...
              '  paper_', jsid, '.setStart();\n', ...
              '  for(var i = -1; i++ < (xgrid.length-1);){\n', ...
	          '     paper_', jsid, '.text(m_left * .75, (hbox1 + m_top) - ((xgrid[i] / tlv_max) * (hbox1 - 2*m_top2) + m_top + m_top2), xgrid[i]).attr({\"font-family\": \"Courier New\", fill: \"#606060\"});\n', ...
              '  }\n', ...
              '  var yticks_code = paper_', jsid, '.setFinish();\n', ...
              '  paper_', jsid, '.text(m_left * .4, hbox1/2, \"Lesion volume (ml) for t = 2\").transform(\"r270\").attr({\"font-family\": \"Courier New\", fill: \"#606060\"});\n', ...                
              '  // line\n', ...
              '  var diagonal = paper_', jsid, '.path(\"M\" + ((-0 / tlv_max) * (wbox1 - 2*m_left2) + m_left + m_left2 - m_left2) + \" \" + ((hbox1 + m_top) - ((0 / tlv_max) * (hbox1 - 2*m_top2) + m_top + m_top2) + m_left2) + \"L\" + ((tlv_max*1.05 / tlv_max) * (wbox1 - 2*m_left2) + m_left + m_left2) + \" \" + ((hbox1 + m_top) - ((tlv_max*1.05 / tlv_max) * (hbox1 - 2*m_top2) + m_top + m_top2))).attr({stroke: \"#A8A8A8\"});\n\n', ...
              '  // Rectangles\n', ...
              '  for(var i = -1; i++ < (tlv1.length-1);){\n', ...
              '      if((joint[i] / joint_max) * w_max < 5){\n', ...
              '          var w_tmp = 5;\n', ...
              '      } else {\n', ...
              '          var w_tmp = (joint[i] / joint_max) * w_max;\n', ...
              '      }\n', ...
              '      paper_', jsid, '.rect((tlv1[i] / tlv_max) * (wbox1 - 2*m_left2) + m_left + m_left2 - w_tmp / 2, \n', ...
              '                (hbox1 + m_top) - ((tlv2[i] / tlv_max) * (hbox1 - 2*m_top2) + m_top + m_top2) + w_tmp/2 - w_tmp * (decr[i] / joint[i]),\n', ...
              '                w_tmp, w_tmp * (decr[i] / joint[i])).attr({fill: \"#00FF66\", stroke: \"none\", opacity: .5});\n', ...
              '      paper_', jsid, '.rect((tlv1[i] / tlv_max) * (wbox1 - 2*m_left2) + m_left + m_left2 - w_tmp / 2, \n', ...
              '                (hbox1 + m_top) - ((tlv2[i] / tlv_max) * (hbox1 - 2*m_top2) + m_top + m_top2) + w_tmp/2 - w_tmp * (decr[i] / joint[i]) - w_tmp * (unch[i] / joint[i]),\n', ...
              '                w_tmp, w_tmp * (unch[i] / joint[i])).attr({fill: \"#909090\", stroke: \"none\", opacity: .5});\n', ...
              '      paper_', jsid, '.rect((tlv1[i] / tlv_max) * (wbox1 - 2*m_left2) + m_left + m_left2 - w_tmp / 2, \n', ...
              '                (hbox1 + m_top) - ((tlv2[i] / tlv_max) * (hbox1 - 2*m_top2) + m_top + m_top2) + w_tmp/2 - w_tmp * (decr[i] / joint[i]) - w_tmp * (unch[i] / joint[i]) - w_tmp * (incr[i] / joint[i]),\n', ...
              '                w_tmp, w_tmp * (incr[i] / joint[i])).attr({fill: \"#D00000\", stroke: \"none\", opacity: .5});\n', ...
              '  }\n\n', ...                
              '  // ********\n', ...
              '  // barchart\n', ...
              '  // ********\n\n', ...              
              '  // green\n', ...
              '  paper_', jsid, '.rect(m_left + wbox1 + 10 + m_left2/2, m_top + m_top2/2, wbox2 - m_left2, hbox1 - m_top2).attr({fill: \"#00FF66\", stroke: \"#none\"});\n', ...
              '  // grey\n', ...
              '  paper_', jsid, '.rect(m_left + wbox1 + 10 + m_left2/2, m_top + m_top2/2, wbox2 - m_left2, (hbox1 - m_top2) * (global_change[3]/global_change[0])).attr({fill: \"#D00000\", stroke: \"#none\"});\n', ...
              '  // red\n', ...
              '  paper_', jsid, '.rect(m_left + wbox1 + 10 + m_left2/2, m_top + m_top2/2 + (hbox1 - m_top2) * (global_change[3]/global_change[0]), wbox2 - m_left2, (hbox1 - m_top2) * (global_change[2]/global_change[0])).attr({fill: \"#909090\", stroke: \"#none\"});\n\n', ...                
              '  // text\n', ...
              '  paper_', jsid, '.text(m_left + wbox1 + 10 + .9*m_left2 + wbox2, m_top + m_top2/2 + (hbox1 - m_top2) * (global_change[3]/global_change[0])/2, Math.round(global_change[3]*100)/100 + \" ml\").attr({\"font-family\": \"Courier New\", fill: \"#606060\"});\n', ...
              '  paper_', jsid, '.text(m_left + wbox1 + 10 + .9*m_left2 + wbox2, m_top + m_top2/2 + (hbox1 - m_top2) * (global_change[3]/global_change[0]) + (hbox1 - m_top2) * (global_change[2]/global_change[0])/2, Math.round(global_change[2]*100)/100 + \" ml\").attr({\"font-family\": \"Courier New\", fill: \"#606060\"});\n', ...
              '  paper_', jsid, '.text(m_left + wbox1 + 10 + .9*m_left2 + wbox2, m_top + m_top2/2 + (hbox1 - m_top2) * (global_change[3]/global_change[0]) + (hbox1 - m_top2) * (global_change[2]/global_change[0]) + (hbox1 - m_top2) * (global_change[1]/global_change[0])/2, Math.round(global_change[1]*100)/100 + \" ml\").attr({\"font-family\": \"Courier New\", fill: \"#606060\"});\n', ...                
            '});'];
        %}
        
    case 'segment'
        js_strout = '$(function () {\n';
end

end

