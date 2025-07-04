<%@ page import="modelos.Funcionarios" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title>Escolha de Edição</title>
    <link rel="stylesheet" href="estilos/escolha.css" />
</head>
<body>
    <header>
        <h1>Administrador</h1>
    </header>

    <main class="container">
        <%
            Funcionarios usuario = (Funcionarios) session.getAttribute("usuarioLogado");
            if (usuario != null) {
        %>
        <h2>Bem-vindo, <%= usuario.getNome() %>!</h2>
        <%
            } else {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="botoes">
            <a href="consulta.jsp">Ver Insumos</a>
            <a href="consultaFuncionarios.jsp">Ver Funcionários</a>
        </div>
    </main>

    <footer>
        <p>reOrganizer 2025</p>
    </footer>
</body>
</html>
