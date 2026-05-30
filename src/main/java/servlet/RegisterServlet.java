package servlet;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Récupérer les données du formulaire
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirm");

        // 2. Vérifier que les chSamps ne sont pas vides
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Tous les champs sont obligatoires !");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3. Vérifier que les mots de passe correspondent
        if (!password.equals(confirm)) {
            request.setAttribute("error", "Les mots de passe ne correspondent pas !");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 4. Vérifier longueur mot de passe
        if (password.length() < 4) {
            request.setAttribute("error", "Mot de passe trop court (minimum 4 caractères) !");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 5. Enregistrer dans la base
        UserDAO userDAO = new UserDAO();

        // Vérifier si username déjà pris
        if (userDAO.usernameExists(username)) {
            request.setAttribute("error", "Ce username est déjà utilisé !");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Insérer le nouvel utilisateur
        boolean ok = userDAO.register(username, password, "user");

        if (ok) {
            request.setAttribute("success", "Compte créé avec succès ! Vous pouvez vous connecter.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Erreur lors de la création du compte. Réessayez !");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}