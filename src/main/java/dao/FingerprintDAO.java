package dao;

import mini_projet.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FingerprintDAO {

    // sauvegarder une vérification
    public boolean save(int userId,
                        String imagePath,
                        String result,
                        float score) {

        Connection conn = null;
        PreparedStatement ps = null;

        try {

            conn = DBConnection.getConnection();

            String sql =
                "INSERT INTO fingerprints(user_id, image_path, result, score) "
              + "VALUES (?, ?, ?, ?)";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setString(2, imagePath);
            ps.setString(3, result);
            ps.setFloat(4, score);

            ps.executeUpdate();

            return true;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;

        } finally {

            DBConnection.close(conn, ps);
        }
    }
}