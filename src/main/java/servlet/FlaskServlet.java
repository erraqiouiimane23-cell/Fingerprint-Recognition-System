package servlet;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dao.FingerprintDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;

@WebServlet("/FlaskServlet")
public class FlaskServlet extends HttpServlet {

    // URL de l'API Flask
    private static final String FLASK_URL = "http://localhost:5000/upload";
    private static final String BOUNDARY  = "----WebKitFormBoundary7MA4YWxkTrZu0gW";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Récupérer le chemin image depuis la session
        HttpSession session   = request.getSession();
        String imagePath      = (String) session.getAttribute("imagePath");
        String imageFileName  = (String) session.getAttribute("imageFileName");
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        // 2. Vérifier que l'image existe
        if (imagePath == null) {
            response.sendRedirect("upload.jsp");
            return;
        }

        File imageFile = new File(imagePath);
        if (!imageFile.exists()) {
            request.setAttribute("error", "Image introuvable !");
            request.getRequestDispatcher("upload.jsp").forward(request, response);
            return;
        }

        try {
            // 3. Ouvrir connexion HTTP vers Flask
            URL url = new URL(FLASK_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(10000);
            conn.setRequestProperty("Content-Type", 
                "multipart/form-data; boundary=" + BOUNDARY);

            // 4. Construire le corps multipart
            try (OutputStream os = conn.getOutputStream();
                 PrintWriter writer = new PrintWriter(
                     new OutputStreamWriter(os, "UTF-8"), true)) {

                // -- début fichier
                writer.println("--" + BOUNDARY);
                writer.println("Content-Disposition: form-data; name=\"image\"; "
                    + "filename=\"" + imageFileName + "\"");
                writer.println("Content-Type: image/jpeg");
                writer.println();
                writer.flush();

                // -- écrire les bytes de l'image
                Files.copy(imageFile.toPath(), os);
                os.flush();

                // -- fin
                writer.println();
                writer.println("--" + BOUNDARY + "--");
                writer.flush();
            }

            // 5. Lire la réponse de Flask
            int statusCode = conn.getResponseCode();

            if (statusCode == 200) {

                // Lire JSON retourné par Flask
                BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream()));
                StringBuilder jsonResponse = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    jsonResponse.append(line);
                }
                br.close();

                // 6. Parser le JSON
                // Flask retourne : {"status":"success","score":95}
                JsonObject json   = JsonParser.parseString(jsonResponse.toString())
                                              .getAsJsonObject();
                String status     = json.get("status").getAsString();
                float  score      = json.get("score").getAsFloat();

                // 7. Sauvegarder dans la base
                FingerprintDAO fpDAO = new FingerprintDAO();
                fpDAO.save(userId, imagePath, "", score);

                // 8. Envoyer résultat vers result.jsp
                request.setAttribute("status", status);
                request.setAttribute("score",  score);
                request.getRequestDispatcher("result.jsp")
                       .forward(request, response);

            } else {
                // Flask a retourné une erreur
                request.setAttribute("error", 
                    "Erreur Flask : code " + statusCode);
                request.getRequestDispatcher("upload.jsp")
                       .forward(request, response);
            }

            conn.disconnect();

        } catch (Exception e) {
            // Flask indisponible
            request.setAttribute("error", 
                "Serveur Flask indisponible ! Vérifiez que Python tourne.");
            request.getRequestDispatcher("upload.jsp")
                   .forward(request, response);
        }
    }
}