package mini_projet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnection {
	private static final String URL =
		    "jdbc:mysql://localhost:3306/fingerprint_db";

		private static final String USER = "root";
		private static final String PASSWORD = "";
    // connexion
    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            return DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException e) {

            throw new RuntimeException("Driver MySQL introuvable", e);

        } catch (SQLException e) {

            throw new RuntimeException("Erreur connexion MySQL", e);
        }
    }

    // fermer Connection + PreparedStatement
    public static void close(Connection conn,
                             PreparedStatement ps) {

        try {

            if (ps != null)
                ps.close();

            if (conn != null)
                conn.close();

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }

    // fermer Connection + PreparedStatement + ResultSet
    public static void close(Connection conn,
                             PreparedStatement ps,
                             ResultSet rs) {

        try {

            if (rs != null)
                rs.close();

            if (ps != null)
                ps.close();

            if (conn != null)
                conn.close();

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }
}