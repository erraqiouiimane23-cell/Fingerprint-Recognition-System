package servlet;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Récupérer les données du formulaire
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 2. Vérifier dans la base
        UserDAO userDAO = new UserDAO();
        User user = userDAO.findByUsernameAndPassword(username, password);

        // 3. Si utilisateur trouvé
        if (user != null) {

            // Créer la session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setAttribute("userId", user.getId());

            // ❌ LOGDAO (désactivé car pas encore créé)
            // import dao.LogDAO;  ← ne pas importer
            // LogDAO logDAO = new LogDAO();
            // logDAO.addLog(user.getId(), "login");

            // Rediriger vers dashboard
            response.sendRedirect("DashboardServlet");

        } else {
            // Mauvais username ou mot de passe
            request.setAttribute("error", "Username ou mot de passe incorrect !");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}