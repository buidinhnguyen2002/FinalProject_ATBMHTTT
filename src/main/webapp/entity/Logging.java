package entity;

public class Logging {
	private static Logging install;

	public static Logging me() {
		if (install == null)
			install = new Logging();
		return install;
	}

	private Logging() {
	}

	/**
	 * level: 0 ..., 1... , 2... , 3....
	 * 
	 * @param level
	 */
	private void log(int level,String ip, int userID, String src, String content) {

	}
}
