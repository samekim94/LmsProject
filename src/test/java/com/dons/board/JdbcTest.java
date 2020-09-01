package com.dons.board;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

//JUnit를 이용한 단위테스트 :JDBCTest 
@Log4j
public class JdbcTest {
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			System.out.println("driver loading fail");
			e.printStackTrace();
		}
	}

	@Test
	public void testConnection() {
		try {
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "dons", "0000");
			assertThat(con, is(notNullValue())); // nullValue()
			// assertThat(con,is(nullValue()));notNullValue와 반대
			log.info(con);
		} catch (SQLException e) {
			System.out.println("oracle connection fail");
			fail(e.getMessage()); // 문법 오류 메세지 출력
			e.printStackTrace();
		}

	}

}