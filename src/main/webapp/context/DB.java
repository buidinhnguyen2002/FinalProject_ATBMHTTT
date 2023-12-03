package context;

import java.sql.SQLException;

import bean.AbBean;
import bean.Log;

public class DB {
	private static DB install;

	public static DB me() {
		if (install == null)
			install = new DB();
		return install;
	}

	private DB() {

	}

	public boolean insert(AbBean bean) {
		return bean.insert(DBContext.me());
	}

	public static void main(String[] args) {
		Log log= new Log(Log.INFO,"0:0:0:1",-1,"LOGIN FALSE","User ABC",0);
        DB.me().insert(log);
	}
}
