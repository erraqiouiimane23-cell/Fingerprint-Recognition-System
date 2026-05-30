<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.User, java.sql.*,mini_projet.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Utilisateurs</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body class="bg-dark text-white">

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    // Seulement admin
    if (!"admin".equals(user.getRole())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<div class="d-flex">

    <!-- SIDEBAR -->
    <div class="p-3 d-flex flex-column"
         style="width:220px; min-height:100vh; background:#0d1117;">
        <div class="text-center mb-4">
            <i class="bi bi-fingerprint text-primary" style="font-size:2.5rem;"></i>
            <div class="small text-muted mt-1">Système d'Identification</div>
        </div>
        <nav class="nav flex-column gap-2">
            <a href="dashboard.jsp" class="nav-link text-white">
                <i class="bi bi-house me-2"></i> Accueil
            </a>
            <a href="upload.jsp" class="nav-link text-white">
                <i class="bi bi-fingerprint me-2"></i> Vérifier empreinte
            </a>
            <a href="users.jsp" class="nav-link text-white active">
                <i class="bi bi-people me-2"></i> Utilisateurs
            </a>
            <a href="historique.jsp" class="nav-link text-white">
                <i class="bi bi-clock-history me-2"></i> Historique
            </a>
            <a href="apropos.jsp" class="nav-link text-white">
                <i class="bi bi-info-circle me-2"></i> À propos
            </a>
        </nav>
        <div class="mt-auto">
            <a href="LogoutServlet" class="nav-link text-danger">
                <i class="bi bi-box-arrow-left me-2"></i> Déconnexion
            </a>
        </div>
    </div>

    <!-- CONTENU -->
    <div class="flex-grow-1 p-4">

        <h4 class="fw-bold mb-4">
            <i class="bi bi-people me-2 text-primary"></i>
            Gestion des utilisateurs
        </h4>

        <div class="card bg-secondary border-0">
            <div class="card-body p-0">
                <table class="table table-dark table-hover table-striped mb-0">
                    <thead>
                        <tr class="text-white-50">
                            <th class="p-3">#</th>
                            <th class="p-3">Username</th>
                            <th class="p-3">Rôle</th>
                            <th class="p-3">Date inscription</th>
                        </tr>
                    </thead>
                    <tbody>
<%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();
        ps = conn.prepareStatement(
            "SELECT * FROM users ORDER BY created_at DESC");
        rs = ps.executeQuery();
        int i = 1;

        while (rs.next()) {
            boolean isAdmin = "admin".equals(rs.getString("role"));
%>
                        <tr>
                            <td class="p-3 text-white-50"><%= i++ %></td>
                            <td class="p-3">
                                <i class="bi bi-person-circle me-2 text-primary"></i>
                                <%= rs.getString("username") %>
                            </td>
                            <td class="p-3">
                                <% if (isAdmin) { %>
                                    <span class="badge bg-warning text-dark">
                                        <i class="bi bi-shield-fill me-1"></i> Admin
                                    </span>
                                <% } else { %>
                                    <span class="badge bg-info text-dark">
                                        <i class="bi bi-person me-1"></i> User
                                    </span>
                                <% } %>
                            </td>
                            <td class="p-3 text-white-50 small">
                                <i class="bi bi-calendar me-1"></i>
                                <%= rs.getTimestamp("created_at") %>
                            </td>
                        </tr>
<%
        }
    } catch (Exception e) {
        out.println("<tr><td colspan='4' class='text-danger p-3'>Erreur : "
                    + e.getMessage() + "</td></tr>");
    } finally {
        DBConnection.close(conn, ps, rs);
    }
%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>