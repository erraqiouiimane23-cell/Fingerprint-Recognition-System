<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard</title>
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
            <a href="dashboard.jsp" class="nav-link text-white active">
                <i class="bi bi-house me-2"></i> Accueil
            </a>
            <a href="upload.jsp" class="nav-link text-white">
                <i class="bi bi-fingerprint me-2"></i> Vérifier empreinte
            </a>
            <% if ("admin".equals(user.getRole())) { %>
            <a href="users.jsp" class="nav-link text-white">
                <i class="bi bi-people me-2"></i> Utilisateurs
            </a>
            <% } %>
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

    <!-- CONTENU PRINCIPAL -->
    <div class="flex-grow-1 p-4">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="mb-0 fw-bold">Tableau d'accueil</h4>
            <div class="d-flex align-items-center gap-2">
                <span class="text-muted">Bienvenue,</span>
                <strong class="text-primary"><%= user.getUsername() %></strong>
                <i class="bi bi-person-circle fs-4"></i>
            </div>
        </div>

        <!-- STATS CARDS -->
        <div class="row g-3 mb-4">

            <div class="col-6 col-md-3">
                <div class="card bg-secondary border-0 text-white text-center p-3">
                    <i class="bi bi-people fs-2 text-primary mb-2"></i>
                    <div class="fs-3 fw-bold">3</div>
                    <div class="small text-white-50">Utilisateurs</div>
                </div>
            </div>

            <div class="col-6 col-md-3">
                <div class="card bg-secondary border-0 text-white text-center p-3">
                    <i class="bi bi-fingerprint fs-2 text-success mb-2"></i>
                    <div class="fs-3 fw-bold">15</div>
                    <div class="small text-white-50">Empreintes</div>
                </div>
            </div>

            <div class="col-6 col-md-3">
                <div class="card bg-secondary border-0 text-white text-center p-3">
                    <i class="bi bi-check-circle fs-2 text-warning mb-2"></i>
                    <div class="fs-3 fw-bold">12</div>
                    <div class="small text-white-50">Vérifications</div>
                </div>
            </div>

            <div class="col-6 col-md-3">
                <div class="card bg-secondary border-0 text-white text-center p-3">
                    <i class="bi bi-graph-up fs-2 text-info mb-2"></i>
                    <div class="fs-3 fw-bold">85%</div>
                    <div class="small text-white-50">Taux de succès</div>
                </div>
            </div>

        </div>

        <!-- VERIFICATION RAPIDE -->
        <div class="card bg-secondary border-0 p-4">
            <h5 class="mb-3 fw-bold">
                <i class="bi bi-fingerprint me-2 text-primary"></i>
                Vérification rapide
            </h5>
            <p class="text-white-50">Choisissez une image d'empreinte à vérifier</p>
            <a href="upload.jsp" class="btn btn-primary">
                <i class="bi bi-upload me-2"></i> Choisir une image
            </a>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>