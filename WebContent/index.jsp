<%@page contentType="text/html;charset=UTF-8" session="true"%>

<script type='text/javascript' src="<%=request.getContextPath() %>/common/js/jquery.min.js"></script>
<script type='text/javascript' src="<%=request.getContextPath() %>/common/js/jquery-ui-1.9.1.custom.js" type="text/javascript"></script>

<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/interface/commonAction.js'></script>        
<script type='text/javascript' src="<%=request.getContextPath() %>/common/js/highcharts.js"></script>

<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/themes/base/jquery-ui.css" />

<script type="text/javascript" src="<%=request.getContextPath() %>/common/paramquery/pqgrid.min.js" ></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/common/paramquery/pqgrid.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/common/paramquery/themes/Office/pqgrid.css" />

<!--bootstrap -->
<link href="<%=request.getContextPath() %>/common/css/bootstrap.responsive.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/common/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/common/css/media.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/common/js/bootstrap.min.js"></script>

<script language="javascript">

(function($){

	$(function(){
	
		commonAction.getData({},function(indata){
			
			//console.log(indata); //담아온 데이터를 찍어본다.
			
			
			//차트별로 데이터셋이 생긴게 다르니깐, 디비에서 뽑아온 값을 차트별 데이터셋의 형태로 만들어주는게 관건.
			var param = {
				category :  ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
				                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],			
				data : [{
		            name: 'Tokyo',
		            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
		        }, {
		            name: 'New York',
		            data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
		        }, {
		            name: 'Berlin',
		            data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
		        }, {
		            name: 'London',
		            data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
		        }]
			};
			  
			
			/*  
			//차트에 넣어줄 데이터를 위의 형태로 담아준다.
			var paramArr = [];
			var priceJson = {};
			var priceByMon = [];
			var category = [];
						
			//database에서 가져온 데이터를 javascript 변수에 셋!
			for(var i=0; i<indata.length; i++){
				priceByMon.push(Number(indata[i].price));				
			}
			
			priceJson['name'] = '매출';
			priceJson['data'] = priceByMon;
			paramArr.push(priceJson);		
			 
			
			
			var param = {
					category : category,
					data: paramArr
				 };
			 */	
			
			//차트실행		 
			lineChart(param);
			
	
		});	
		
		
		
		
		//라인차트 선언
		var lineChart = function(param){
			
			//옵션
			Highcharts.setOptions({
				lang: {
					thousandsSep: ',' //금액 단위에 콤마
				}
			});
			
			
			
			//html에 선언된 container에 차트를 그린다.
			$('#container').highcharts({
		        title: {
		            text: '월매출',
		            x: -20 //center
		        },
		        subtitle: {
		            text: 'spc.com',
		            x: -20
		        },
		        xAxis: {
		            categories: param.category
		        },
		        yAxis: {
		            title: {
		                text: '금액(억원)'
		            },
		            plotLines: [{
		                value: 0,
		                width: 1,
		                color: '#808080'
		            }]
		        },
		        tooltip: {
		            valueSuffix: '억원'
		        },
		        legend: {
		            layout: 'vertical',
		            align: 'right',
		            verticalAlign: 'middle',
		            borderWidth: 0
		        },
		        series: param.data	//data셋!
		    });
		};
		
		
		
		
		//파이차트
		$('#container2').highcharts({
	        chart: {
	            plotBackgroundColor: null,
	            plotBorderWidth: 0,
	            plotShadow: false,
	            backgroundColor:''
	        },
	        title: {
	            text: 'Browser<br>shares',
	            align: 'center',
	            verticalAlign: 'middle',
	            y: 50
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                dataLabels: {
	                    enabled: true,
	                    distance: -50,
	                    style: {
	                        fontWeight: 'bold',
	                        color: 'white',
	                        textShadow: '0px 1px 2px black'
	                    }
	                },
	                startAngle: -90,
	                endAngle: 90,
	                center: ['50%', '75%']
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: 'Browser share',
	            innerSize: '50%',
	            data: [
	                ['Firefox',   45.0],
	                ['IE',       26.8],
	                ['Chrome', 12.8],
	                ['Safari',    8.5],
	                ['Opera',     6.2],
	                ['Others',   0.7]
	            ]
	        }]
	    });
		
		
		
		
		//바차트
		$('#container3').highcharts({
	        chart: {
	            type: 'column',
	            backgroundColor:''
	        },
	        title: {
	            text: 'Column chart with negative values'
	        },
	        xAxis: {
	            categories: ['2011', '2012']
	        },
	        credits: {
	            enabled: false
	        },
	        series: [{
	            name: 'John',
	            data: [5, 3]
	        }, {
	            name: 'Jane',
	            data: [2, -2]
	        }]
	    });
		
		
		
		//=========================================================
			
		//	pqgrid - paramquery.com	
		
		//=========================================================
		
		
		var data = [
            { rank: 1, company: 'Exxon Mobil', revenues: 339938.0, profits: 36130.0 },
            { rank: 2, company: 'Wal-Mart Stores', revenues: 315654.0, profits: 11231.0 },
            { rank: 3, company: 'Royal Dutch Shell', revenues: 306731.0, profits: 25311.0 },
            { rank: 4, company: 'BP', revenues: 267600.0, profits: 22341.0 },
            { rank: 5, company: 'General Motors', revenues: 192604.0, profits: -10567.0 },
            { rank: 6, company: 'Chevron', revenues: 189481.0, profits: 14099.0 },
            { rank: 7, company: 'DaimlerChrysler', revenues: 186106.3, profits: 3536.3 },
            { rank: 8, company: 'Toyota Motor', revenues: 185805.0, profits: 12119.6 },
            { rank: 9, company: 'Ford Motor', revenues: 177210.0, profits: 2024.0 },
            { rank: 10, company: 'ConocoPhillips', revenues: 166683.0, profits: 13529.0 },
            { rank: 11, company: 'General Electric', revenues: 157153.0, profits: 16353.0 },
            { rank: 12, company: 'Total', revenues: 152360.7, profits: 15250.0 },
            { rank: 13, company: 'ING Group', revenues: 138235.3, profits: 8958.9 }
            
            
        ];
                     
        //array of columns.
        var colModel = [
            { 
                title: "Rank", //title of column. 
                width: 100, //initial width of column
                dataType: "integer", //data type of column
                dataIndx: "rank" //should match one of the keys in row data.
            },
            { 
                title: "Company", 
                width: 200, 
                dataType: "string", 
                dataIndx: "company"
            },
            { 
                title: "Profits ($ millions)", 
                width: 200, 
                dataType: "float", 
                align: "right", 
                dataIndx: "profits"
            }
        ];
        
     
        //main object to be passed to pqGrid constructor.    
        var obj = {
            width: 500, //width of grid 
            height: 314, //height of grid 
            title: "Grid From Array",
        	showTop :false,
        	showBottom: false,
        	flexHeight: false, 
        	columnBorders: false,
        	rowBorders: false,
        	showToolbar: false,
            colModel: colModel,
            dataModel: {data: data},
            toolbar: {    		
                cls: 'pq-toolbar-export',
                items: [{
                        type: 'button',
                        label: "Export to Excel",
                        icon: 'ui-icon-document',
                        listeners: [{
                            "click": function (evt) {
                                $("#grid_parts").pqGrid("exportExcel", { url: "/pro/demos/excel", sheetName: "pqGrid sheet" });
                            }
                        }]
                }]            
   			},
   			numberCell:{show:false}
        };    
     
        $("#grid_parts").pqGrid( obj );                                
	           
		
	});
})(jQuery);
</script>

<div class="container clearfix">
     <div class="row-fluid" style="height:60px;"></div>
     <div class="row-fluid" style="height:450px;">
         <div class="eleven columns" style="padding-top:40px;">
            <div class="border topleft">
                <div class="row-fluid">
                 <div id="container3" class="span6 topleft1" style="height:360px;"></div>
                 <div id="container2" class="span6 topleft2" style="height:360px;"></div>
                </div>
            </div>
         </div>
         <div class="six columns">
            <div class="border topright">
                <div id="grid_parts" style="margin-top:20px;"></div>
            </div>
        </div>
    </div>
    <div class="row-fluid" style="height:360px;"> 
        <div class="twelve columns">
            <div class="border down">
                <div id="container" class="span12" style="height:350px;"></div>
            </div>
        </div>
    </div>
</div>

