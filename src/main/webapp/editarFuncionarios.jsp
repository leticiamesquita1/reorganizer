<%@page import="controles.FuncionariosControler"%>
<%@page import="modelos.Funcionarios"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%
    FuncionariosControler controller = new FuncionariosControler();
    String metodo = request.getMethod();
    String msg = "";
    Funcionarios funcionario = null;
    boolean editar = false;

    if ("GET".equalsIgnoreCase(metodo)) {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                funcionario = controller.buscarPorId(id);
                if (funcionario == null) {
                    msg = "Funcionário não encontrado.";
                } else {
                    editar = true;
                }
            } catch (Exception e) {
                msg = "ID inválido.";
            }
        }
    } else if ("POST".equalsIgnoreCase(metodo)) {
        try {
            String idStr = request.getParameter("id");
            String cpf = request.getParameter("cpf");
            String senha = request.getParameter("senha");
            String nome = request.getParameter("nome");
            String cargo = request.getParameter("cargo");

            Funcionarios f = new Funcionarios();
            f.setCpf(cpf);
            f.setSenha(senha);
            f.setNome(nome);
            f.setCargo(cargo);

            if (idStr != null && !idStr.isEmpty()) {
                f.setId(Integer.parseInt(idStr));
                boolean sucesso = controller.atualizarFuncionario(f);
                if (sucesso) {
                    response.sendRedirect("consulta.jsp");
                    return;
                } else {
                    msg = "Falha ao atualizar funcionário.";
                    editar = true;
                }
            } else {
                boolean sucesso = controller.inserirFuncionario(f);
                if (sucesso) {
                    response.sendRedirect("consulta.jsp");
                    return;
                } else {
                    msg = "Falha ao inserir funcionário.";
                }
            }
            funcionario = f;
        } catch (Exception e) {
            msg = "Erro: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title><%= editar ? "Editar" : "Adicionar" %> Funcionário</title>
    <link rel="stylesheet" href="estilos/editarFuncionarios.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
</head>
<body>
<header>
    <h1>reOrganizer</h1>
    <a href="consulta.jsp" class="btn-voltar-navbar">
        <i class="bi bi-arrow-left-circle"></i> Voltar
    </a>
</header>

<main class="container-form">
    <h2><%= editar ? "Editar" : "Adicionar" %> Funcionário</h2>
    <% if (!msg.isEmpty()) { %>
        <p class="erro"><%= msg %></p>
    <% } %>

    <form method="post" action="editarFuncionarios.jsp">
        <% if (editar) { %>
            <input type="hidden" name="id" value="<%= funcionario != null ? funcionario.getId() : "" %>" />
        <% } %>

        <label>CPF:
            <input type="text" name="cpf" required maxlength="14" value="<%= funcionario != null ? funcionario.getCpf() : "" %>" />
        </label>

        <label>Senha:
            <input type="password" name="senha" <%= editar ? "" : "required" %> />
            <%-- Se editar, senha é opcional --%>
        </label>

        <label>Nome:
            <input type="text" name="nome" required value="<%= funcionario != null ? funcionario.getNome() : "" %>" />
        </label>

        <label>Cargo:
            <select name="cargo" required>
                <option value="">--Selecione--</option>
                <option value="funcionario" <%= funcionario != null && "funcionario".equals(funcionario.getCargo()) ? "selected" : "" %>>Funcionário</option>
                <option value="gerente" <%= funcionario != null && "gerente".equals(funcionario.getCargo()) ? "selected" : "" %>>Gerente</option>
                <option value="farmaceutico" <%= funcionario != null && "farmaceutico".equals(funcionario.getCargo()) ? "selected" : "" %>>Farmacêutico</option>
            </select>
        </label>

        <button type="submit" class="btn-salvar">
            <%= editar ? "Salvar Alterações" : "Adicionar Funcionário" %>
        </button>
    </form>
</main>

<footer class="footer">
    <p>&copy; 2025 reOrganizer</p>
</footer>
</body>
</html>
