<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Résultat</title>
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

    String status = (String)  request.getAttribute("status");
    Float  score  = (Float)   request.getAttribute("score");
    boolean isSuccess = "success".equals(status);
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
            <a href="DashboardServlet" class="nav-link text-white">
                <i class="bi bi-house me-2"></i> Accueil
            </a>
            <a href="upload.jsp" class="nav-link text-white">
                <i class="bi bi-fingerprint me-2"></i> Vérifier empreinte
            </a>
            <a href="LogoutServlet" class="nav-link text-danger">
                <i class="bi bi-box-arrow-left me-2"></i> Déconnexion
            </a>
        </nav>
    </div>

    <!-- CONTENU -->
    <div class="flex-grow-1 p-4 d-flex align-items-center justify-content-center">

        <div class="card bg-secondary p-5 text-center" style="max-width:450px; width:100%;">

            <% if (isSuccess) { %>

                <!-- ACCÈS AUTORISÉ -->
                <div class="mb-3">
                    <i class="bi bi-check-circle-fill text-success" 
                       style="font-size:5rem;"></i>
                </div>
                <h2 class="text-success fw-bold">ACCÈS AUTORISÉ</h2>
                <p class="text-muted mt-2">
                    Score de correspondance :
                    <strong class="text-success fs-4"><%= score %>%</strong>
                </p>

            <% } else { %>

                <!-- ACCÈS REFUSÉ -->
                <div class="mb-3">
                    <i class="bi bi-x-circle-fill text-danger" 
                       style="font-size:5rem;"></i>
                </div>
                <h2 class="text-danger fw-bold">ACCÈS REFUSÉ</h2>
                <p class="text-muted mt-2">
                    <% if (score != null && score > 0) { %>
                        Score : <strong class="text-danger fs-4"><%= score %>%</strong>
                    <% } else { %>
                        Pas de correspondance trouvée.
                    <% } %>
                </p>

            <% } %>

            <hr class="my-4">

            <div class="d-flex gap-3 justify-content-center">
                <a href="upload.jsp" class="btn btn-primary">
                    <i class="bi bi-arrow-repeat me-2"></i> Réessayer
                </a>
                <a href="DashboardServlet" class="btn btn-outline-light">
                    <i class="bi bi-house me-2"></i> Dashboard
                </a>
            </div>

        </div>
    </div>
</div>

</body>
</html>