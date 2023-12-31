package context;

import com.zaxxer.hikari.HikariDataSource;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.SQLException;


public class DBContext {
	private static final String serverName = "34.143.132.36";
	private static final String dbName = "haloshop";
	private static final String portNumber = "3306";
	private static final String instance = "";
	private static final String userID = "root";
	private static final String password = "haloshop123";
	private static final HikariDataSource dataSource;
	static Jdbi jdbi;

	public static Jdbi me() {
	    if (jdbi == null) {
	        jdbi = Jdbi.create(dataSource);
	    }
	    return jdbi;
	}

	static {

		String url = "jdbc:mysql://" + serverName + ":" + portNumber + "\\" + instance + "/" + dbName;
		if (instance == null || instance.trim().isEmpty())
			url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + dbName;
		dataSource = new HikariDataSource();
		dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
		dataSource.setJdbcUrl(url);
		dataSource.setUsername(userID);
		dataSource.setPassword(password);
		dataSource.setMaximumPoolSize(200);
		dataSource.setMinimumIdle(30);
	}

	private DBContext() {
	}

	public static Connection getConnection() throws SQLException {
		return dataSource.getConnection();
	}

	public static void main(String[] args) throws SQLException {
		System.out.println(getConnection());
	}
}