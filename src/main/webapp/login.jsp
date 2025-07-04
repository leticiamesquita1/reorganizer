<%@ page import="controles.FuncionariosControler" %>
<%@ page import="modelos.Funcionarios" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Login | ReOrganizer</title>
  <link rel="stylesheet" href="estilos/login.css" />
</head>
<body>
  <header>
    <nav>
      <div class="nav-left">
        <a href="home.html">Início</a>
      </div>
    </nav>
  </header>

  <main class="login-container">
    <div class="login-box">
      <h1>Bem-vindo de volta</h1>
      <p>Faça login para acessar o sistema</p>

      <form method="post" action="login.jsp">
        <input type="text" name="cpf" placeholder="CPF"
          value="<%= request.getParameter("cpf") != null ? request.getParameter("cpf") : "" %>" required />
        <input type="password" name="senha" placeholder="Senha" required />
        <button type="submit">Entrar</button>
      </form>

      <%
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senha");

        if ("POST".equalsIgnoreCase(request.getMethod())) {
          FuncionariosControler fc = new FuncionariosControler();
          Funcionarios f = fc.autenticar(cpf, senha);

          if (f == null) {
      %>
            <p style="color: red; margin-top: 10px;">CPF ou senha inválidos!</p>
      <%
          } else {
            session.setAttribute("usuarioLogado", f);
            response.sendRedirect("consulta.jsp");
            return;
          }
        }
      %>

      <p class="login-info">Esqueceu sua senha? Contate o administrador.</p>
    </div>
  </main>

  <footer>
    <p>© 2025 ReOrganizer | Soluções em Gestão de Estoque Hospitalar</p>
  </footer>

  <button class="toggle-dark-mode" onclick="toggleDarkMode()">🌓</button>

  <script>
    function toggleDarkMode() {
      document.body.classList.toggle('dark-mode');
    }
  </script>
</body>
</html>
