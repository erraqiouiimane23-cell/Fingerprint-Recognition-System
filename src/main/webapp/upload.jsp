<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Vérifier Empreinte</title>
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-dark text-white">

<%
    // Protection session
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="d-flex">

    <!-- SIDEBAR -->
    <div class="sidebar p-3 d-flex flex-column" 
         style="width:220px; min-height:100vh; background:#0d1117;">

        <div class="text-center mb-4">
            <i class="bi bi-fingerprint text-primary" style="font-size:2.5rem;"></i>
            <div class="small text-muted mt-1">Système d'Identification</div>
        </div>

        <nav class="nav flex-column gap-2">
            <a href="DashboardServlet" class="nav-link text-white">
                <i class="bi bi-house me-2"></i> Accueil
            </a>
            <a href="upload.jsp" class="nav-link text-white active">
                <i class="bi bi-fingerprint me-2"></i> Vérifier empreinte
            </a>
            <a href="LogoutServlet" class="nav-link text-danger mt-auto">
                <i class="bi bi-box-arrow-left me-2"></i> Déconnexion
            </a>
        </nav>

    </div>

    <!-- CONTENU -->
    <div class="flex-grow-1 p-4">

        <h4 class="mb-4">
            <i class="bi bi-fingerprint me-2 text-primary"></i>
            Vérifier une empreinte
        </h4>

        <!-- Message erreur -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <div class="card bg-secondary p-4" style="max-width:500px;">

            <p class="text-muted mb-3">
                <i class="bi bi-info-circle me-1"></i>
                Télécharger une image d'empreinte digitale pour vérifier l'identité.
            </p>

            <form action="UploadServlet" method="post" enctype="multipart/form-data">

                <div class="mb-3">
                    <label class="form-label">Image d'empreinte</label>
                    <input type="file" 
                           name="image" 
                           id="imageInput"
                           class="form-control" 
                           accept="image/*"
                           required>
                </div>

                <!-- Preview image -->
                <div class="mb-3 text-center" id="previewDiv" style="display:none;">
                    <img id="preview" 
                         src="#" 
                         alt="Preview" 
                         class="img-fluid rounded"
                         style="max-height:200px; border:2px solid #0d6efd;">
                </div>

                <button type="submit" class="btn btn-primary w-100">
                    <i class="bi bi-search me-2"></i> Vérifier
                </button>

            </form>

        </div>
    </div>
</div>

<!-- Script preview image -->
<script>
    document.getElementById('imageInput').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('preview').src = e.target.result;
                document.getElementById('previewDiv').style.display = 'block';
            };
            reader.readAsDataURL(file);
        }
    });
</script>

</body>
</html>