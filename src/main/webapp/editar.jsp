<%@page import="controles.InsumosControler"%>
<%@page import="modelos.Insumos"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%
    InsumosControler controller = new InsumosControler();
    String metodo = request.getMethod();
    String msg = "";
    Insumos insumo = null;
    boolean editar = false;

    if ("GET".equalsIgnoreCase(metodo)) {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                insumo = controller.buscarPorId(id);
                if (insumo == null) {
                    msg = "Insumo não encontrado.";
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
            String nome = request.getParameter("nome");
            String descricao = request.getParameter("descricao");
            int quantidade = Integer.parseInt(request.getParameter("quantidade"));
            java.sql.Date validade = java.sql.Date.valueOf(request.getParameter("validade"));
            int idFarmacia = Integer.parseInt(request.getParameter("idFarmacia"));
            int idAlmoxarifado = Integer.parseInt(request.getParameter("idAlmoxarifado"));

            Insumos i = new Insumos();
            i.setNome(nome);
            i.setDescricao(descricao);
            i.setQuantidade(quantidade);
            i.setValidade(validade);
            i.setIdFarmacia(idFarmacia);
            i.setIdAlmoxarifado(idAlmoxarifado);

            if (idStr != null && !idStr.isEmpty()) {
                i.setId(Integer.parseInt(idStr));
                boolean sucesso = controller.atualizarInsumo(i);
                if (sucesso) {
                    response.sendRedirect("consulta.jsp");
                    return;
                } else {
                    msg = "Falha ao atualizar insumo.";
                    editar = true;
                }
            } else {
                boolean sucesso = controller.inserirInsumo(i);
                if (sucesso) {
                    response.sendRedirect("consulta.jsp");
                    return;
                } else {
                    msg = "Falha ao inserir insumo.";
                }
            }
            insumo = i;
        } catch (Exception e) {
            msg = "Erro: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title><%= editar ? "Editar" : "Adicionar" %> Insumo</title>
    <link rel="stylesheet" href="estilos/editar.css" />
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
    <h2><%= editar ? "Editar" : "Adicionar" %> Insumo</h2>
    <% if (!msg.isEmpty()) { %>
        <p class="erro"><%= msg %></p>
    <% } %>

    <form method="post" action="editar.jsp">
        <% if (editar) { %>
            <input type="hidden" name="id" value="<%= insumo != null ? insumo.getId() : "" %>" />
        <% } %>

        <label>Nome:
            <input type="text" name="nome" required value="<%= insumo != null ? insumo.getNome() : "" %>" />
        </label>

        <label>Descrição:
            <textarea name="descricao" rows="3"><%= insumo != null ? insumo.getDescricao() : "" %></textarea>
        </label>

        <label>Quantidade:
            <input type="number" name="quantidade" min="0" required value="<%= insumo != null ? insumo.getQuantidade() : "0" %>" />
        </label>

        <label>Validade:
            <input type="date" name="validade" required value="<%= insumo != null && insumo.getValidade() != null ? insumo.getValidade().toString() : "" %>" />
        </label>

        <label>Id Farmácia:
            <input type="number" name="idFarmacia" min="0" required value="<%= insumo != null ? insumo.getIdFarmacia() : "0" %>" />
        </label>

        <label>Id Almoxarifado:
            <input type="number" name="idAlmoxarifado" min="0" required value="<%= insumo != null ? insumo.getIdAlmoxarifado() : "0" %>" />
        </label>

        <button type="submit" class="btn-salvar">
            <%= editar ? "Salvar Alterações" : "Adicionar Insumo" %>
        </button>
    </form>
</main>

<footer class="footer">
    <p>&copy; 2025 reOrganizer</p>
</footer>
</body>
</html>
