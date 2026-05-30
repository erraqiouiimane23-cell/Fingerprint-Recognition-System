<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body class="bg-dark min-vh-100 d-flex align-items-center justify-content-center">

<div class="card bg-secondary-subtle border-secondary shadow-lg" style="width:420px;">
    <div class="card-body p-4">

        <!-- HEADER -->
        <div class="text-center mb-4">
            <i class="bi bi-fingerprint text-primary" style="font-size:3rem;"></i>
            <h4 class="mt-2 text-white fw-bold">Système de Vérification</h4>
            <p class="text-secondary small">Connexion à votre compte</p>
        </div>

        <!-- MESSAGE ERREUR -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger d-flex align-items-center py-2">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <!-- FORMULAIRE -->
        <form action="LoginServlet" method="post">

            <div class="mb-3">
                <label class="form-label text-white-50">
                    <i class="bi bi-person me-1"></i> Nom d'utilisateur
                </label>
                <input type="text"
                       name="username"
                       class="form-control form-control-lg bg-dark text-white border-secondary"
                       placeholder="Entrez votre username"
                       required>
            </div>

            <div class="mb-4">
                <label class="form-label text-white-50">
                    <i class="bi bi-lock me-1"></i> Mot de passe
                </label>
                <input type="password"
                       name="password"
                       class="form-control form-control-lg bg-dark text-white border-secondary"
                       placeholder="Entrez votre mot de passe"
                       required>
            </div>

            <button type="submit" class="btn btn-primary btn-lg w-100 fw-semibold">
                <i class="bi bi-box-arrow-in-right me-2"></i> Se connecter
            </button>

        </form>

        <!-- LIEN REGISTER -->
        <hr class="border-secondary mt-4">
        <div class="text-center">
            <small class="text-secondary">Pas de compte ?
                <a href="register.jsp" class="text-primary text-decoration-none fw-semibold">
                    S'inscrire
                </a>
            </small>
        </div>

    </div>
</div>

</body>
</html>