<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>À propos</title>
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
            <a href="dashboard.jsp" class="nav-link text-white">
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
            <a href="apropos.jsp" class="nav-link text-white active">
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
            <i class="bi bi-info-circle me-2 text-primary"></i>
            À propos du projet
        </h4>

        <!-- DESCRIPTION -->
        <div class="card bg-secondary border-0 p-4 mb-3">
            <h5 class="fw-bold text-primary mb-3">
                <i class="bi bi-fingerprint me-2"></i>
                Système de Vérification d'Identité
            </h5>
            <p class="text-white-50">
                Application web intelligente combinant Java/Jakarta EE 
                et Machine Learning Python pour la vérification d'identité 
                par empreinte digitale.
            </p>
        </div>

        <!-- TECHNOLOGIES -->
        <div class="row g-3 mb-3">
            <div class="col-md-6">
                <div class="card bg-secondary border-0 p-4 h-100">
                    <h6 class="fw-bold text-warning mb-3">
                        <i class="bi bi-code-slash me-2"></i> Technologies Web
                    </h6>
                    <ul class="list-unstyled text-white-50">
                        <li class="mb-2">
                            <i class="bi bi-check-circle text-success me-2"></i>
                            Jakarta EE / Servlets
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check-circle text-success me-2"></i>
                            JSP + Bootstrap 5
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check-circle text-success me-2"></i>
                            JDBC + MySQL
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check-circle text-success me-2"></i>
                            Apache Tomcat 10
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card bg-secondary border-0 p-4 h-100">
                    <h6 class="fw-bold text-info mb-3">
                        <i class="bi bi-robot me-2"></i> Intelligence Artificielle
                    </h6>
                    <ul class="list-unstyled text-white-50">
                        <li class="mb-2">
                            <i class="bi bi-check-circle text-success me-2"></i>
                            Python + Flask API
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check-circle text-success me-2"></i>
                            Machine Learning
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check-circle text-success me-2"></i>
                            Analyse d'empreintes
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check-circle text-success me-2"></i>
                            REST API JSON
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- ARCHITECTURE -->
        <div class="card bg-secondary border-0 p-4">
            <h6 class="fw-bold text-success mb-3">
                <i class="bi bi-diagram-3 me-2"></i> Architecture
            </h6>
            <div class="d-flex align-items-center gap-3 flex-wrap">
                <span class="badge bg-primary p-2 fs-6">
                    <i class="bi bi-browser me-1"></i> JSP
                </span>
                <i class="bi bi-arrow-right text-white-50"></i>
                <span class="badge bg-warning text-dark p-2 fs-6">
                    <i class="bi bi-gear me-1"></i> Servlet
                </span>
                <i class="bi bi-arrow-right text-white-50"></i>
                <span class="badge bg-success p-2 fs-6">
                    <i class="bi bi-database me-1"></i> MySQL
                </span>
                <i class="bi bi-arrow-right text-white-50"></i>
                <span class="badge bg-info text-dark p-2 fs-6">
                    <i class="bi bi-robot me-1"></i> Flask ML
                </span>
            </div>
        </div>

    </div>
</div>

</body>
</html>