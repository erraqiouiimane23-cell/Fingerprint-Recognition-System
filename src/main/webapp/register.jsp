<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inscription</title>
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body class="bg-dark">

<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="card p-4 shadow" style="width:420px; background:#161b22; border:1px solid #30363d;">

        <!-- HEADER -->
        <div class="text-center mb-4">
            <i class="bi bi-fingerprint text-primary" style="font-size:3rem;"></i>
            <h4 class="mt-2 text-white">Créer un compte</h4>
            <p class="text-muted small">Système de Vérification d'Identité</p>
        </div>

        <!-- MESSAGE ERREUR -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger py-2">
                <i class="bi bi-exclamation-triangle me-2"></i>
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <!-- MESSAGE SUCCÈS -->
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success py-2">
                <i class="bi bi-check-circle me-2"></i>
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <!-- FORMULAIRE -->
        <form action="RegisterServlet" method="post">

            <div class="mb-3">
                <label class="form-label text-white">
                    <i class="bi bi-person me-1"></i> Nom d'utilisateur
                </label>
                <input type="text"
                       name="username"
                       class="form-control bg-dark text-white border-secondary"
                       placeholder="Choisissez un username"
                       required>
            </div>

            <div class="mb-3">
                <label class="form-label text-white">
                    <i class="bi bi-lock me-1"></i> Mot de passe
                </label>
                <input type="password"
                       name="password"
                       class="form-control bg-dark text-white border-secondary"
                       placeholder="Choisissez un mot de passe"
                       required>
            </div>

            <div class="mb-4">
                <label class="form-label text-white">
                    <i class="bi bi-lock-fill me-1"></i> Confirmer mot de passe
                </label>
                <input type="password"
                       name="confirm"
                       class="form-control bg-dark text-white border-secondary"
                       placeholder="Répétez le mot de passe"
                       required>
            </div>

            <button type="submit" class="btn btn-success w-100">
                <i class="bi bi-person-plus me-2"></i> S'inscrire
            </button>

        </form>

        <!-- LIEN LOGIN -->
        <div class="text-center mt-3">
            <small class="text-muted">Déjà un compte ?
                <a href="login.jsp" class="text-primary">Se connecter</a>
            </small>
        </div>

    </div>
</div>

</body>
</html>