package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérifier session
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            // Pas connecté → retour login
            response.sendRedirect("login.jsp");
            return;
        }

        // Connecté → aller dashboard
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}