package com.spc.chart.dao;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import org.apache.log4j.Logger;
import com.spc.common.db.PoolManager;
import com.spc.chart.vo.ChartVO;

public class ChartDAO {
	
	protected PoolManager poolm = new PoolManager();
	private Logger logger = Logger.getLogger(this.getClass());
	
	public ArrayList selectAList() throws Exception {
		
		Connection connect = null;
		Statement statement = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Properties prop = new Properties();
		ArrayList arr = new ArrayList();
		String str = "";
		
		try {
			
			connect = poolm.getConn();
			statement = connect.createStatement();
			str = "  select  sum(settleprice) price, date_format(orddt,'%Y%m') orddt ";
			str += " from    gd_order ";
			str += " where   1=1 ";
			str += " group by date_format(orddt,'%Y%m')";
			
			resultSet = statement.executeQuery(str);
			ChartVO vo = new ChartVO();
			
			while(resultSet.next()){
				vo = new ChartVO();
				vo.setOrddt(resultSet.getString("orddt"));
				vo.setPrice(resultSet.getString("price"));
				arr.add(vo);				
			}
			
	
			//preparedStatement.executeUpdate(); insert, update, delete
			//resultSet = preparedStatement.executeQuery(); select
	      		  
		} catch (Exception e) {
			logger.error(e);
		} finally {
			poolm.closeAll(resultSet, statement, connect);
		}
		
		return arr;

	}


} 