package com.spc.chart;

import java.util.ArrayList;
import org.json.simple.JSONObject;
import com.spc.chart.dao.ChartDAO;


public class CommonAction {
	
	//product for combobox
	public ArrayList getData(JSONObject data) throws Exception{
		
		ArrayList aa = new ArrayList();
		
		try{
			
			ChartDAO dao = new ChartDAO();
			aa = dao.selectAList();
		
		} catch (Exception e){
			e.printStackTrace();
		}
		
		return aa;
	}
	
}
