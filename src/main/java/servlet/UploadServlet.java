package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/UploadServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize       = 1024 * 1024 * 10, // 10 MB
    maxRequestSize    = 1024 * 1024 * 15  // 15 MB
)
public class UploadServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Dossier où sauvegarder les images
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Récupérer l'image envoyée
        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // 2. Vérifier que c'est bien une image
        if (!fileName.toLowerCase().matches(".*\\.(jpg|jpeg|png|bmp)$")) {            request.setAttribute("error", "Format invalide ! Utilisez JPG, PNG ou BMP.");
            request.getRequestDispatcher("upload.jsp").forward(request, response);
            return;
        }

        // 3. Créer le dossier uploads s'il n'existe pas
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // 4. Sauvegarder l'image
        String filePath = uploadPath + File.separator + fileName;
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
        }

        // 5. Mettre le chemin en session pour Flask
        request.getSession().setAttribute("imagePath", filePath);
        request.getSession().setAttribute("imageFileName", fileName);

        // 6. Rediriger vers Flask (Jour 6)
        request.setAttribute("success", "Image uploadée avec succès !");
        request.getRequestDispatcher("upload.jsp").forward(request, response);    }
}