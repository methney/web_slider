package com.spc.common.db;

import org.apache.log4j.Logger;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Hashtable;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;


public class PoolManager {

	private Logger logger = Logger.getLogger(this.getClass());

    public Connection getConn()throws Exception {
    	
    	Connection connect = null;
    	Properties prop = new Properties();
    	Context ctx = null;
    	
    	try {
	    	
	    	InputStream inputStream = getClass().getClassLoader().getResourceAsStream("/com/spc/properties/common.properties");
			if(inputStream!=null){
				prop.load(inputStream);
			}else{
				throw new FileNotFoundException("property file not found in the classpath");
			}
			
			String db_driver = prop.getProperty("db.driver");
			String db_url = prop.getProperty("db.url");
			String db_user = prop.getProperty("db.user");
			String db_pass = prop.getProperty("db.pass");
			
			Class.forName(db_driver);
			connect = DriverManager.getConnection(db_url, db_user, db_pass);
			
			
			
			
			
			
			
			
			//웹로직 풀설정
			/*
			String ds_provider=prop.getProperty("db.ds_provider"); //t3://localhost:7001
	        String ds_name=prop.getProperty("db.ds_source"); // java:comp/env/CPDS
	    	
			Hashtable ht = new Hashtable();
			ht.put(Context.INITIAL_CONTEXT_FACTORY,"weblogic.jndi.WLInitialContextFactory");
			ht.put(Context.PROVIDER_URL,ds_provider); 

			ctx = new InitialContext(ht);
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup (ds_name);
			connect = ds.getConnection();
			*/			
			
			
    	}catch(SQLException e){
    		throw e;
    	}catch(IOException e){
    		throw e;
    	}	
        return connect;
    }

    public void closeAll(Connection conn) {
        if(conn != null){
            try {
                conn.setAutoCommit(true);
                conn.close();
            } catch (Exception se) {
                logger.debug(se);
            }
        }
    }

    public void closeAll(ResultSet rss) {
        if (rss != null) {
            try {
                rss.close();
            } catch (SQLException se) {
                logger.debug(se);
            }
        }
    }

    public void closeAll(PreparedStatement pstmt) {
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException se) {
                logger.debug(se);
            }
        }
    }

    public void closeAll(CallableStatement cstmt) {
        if (cstmt != null) {
            try {
                cstmt.close();
            } catch (SQLException se) {
                logger.debug(se);
            }
        }
    }

    
    public void closeAll(Statement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException se) {
                logger.debug(se);
            }
        }
    }

    
    public void closeAll(ResultSet rss, Statement stmt, Connection conn) {
        closeAll(rss);
        closeAll(stmt);
        if(conn != null)
            closeAll(conn);
    }

    
    public void closeAll(ResultSet rss, PreparedStatement pstmt, Connection conn) {
        closeAll(rss);
        closeAll(pstmt);
        if(conn != null)
            closeAll(conn);
    }


    public void closeAll(ResultSet rss, PreparedStatement pstmt) {
        closeAll(rss);
        closeAll(pstmt);
    }


    public void rollBack(Connection conn) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException se) {
                logger.debug(se);
            }
        }
    }
    
    public void setAutoCommit(Connection conn, boolean isBool){
    	try{
    		if(conn != null){
    			if (conn.getAutoCommit() != isBool) {
    				conn.setAutoCommit(isBool);
    			}
    		}
    	} catch (SQLException se){
    		logger.error(se.toString());
    	}
    }
    
    

}
