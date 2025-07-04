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
            int id = Integer.parseInt(idStr);
            insumo = controller.buscarPorId(id);
            if (insumo == null) {
                msg = "Insumo não encontrado.";
            } else {
                editar = true;
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

            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                Insumos i = new Insumos();
                i.setId(id);
                i.setNome(nome);
                i.setDescricao(descricao);
                i.setQuantidade(quantidade);
                i.setValidade(validade);
                i.setIdFarmacia(idFarmacia);
                i.setIdAlmoxarifado(idAlmoxarifado);

                boolean sucesso = controller.atualizarInsumo(i);
                if (sucesso) {
                    response.sendRedirect("consulta.jsp");
                    return;
                } else {
                    msg = "Falha ao atualizar insumo.";
                    insumo = i;
                    editar = true;
                }
            } else {
                Insumos i = new Insumos();
                i.setNome(nome);
                i.setDescricao(descricao);
                i.setQuantidade(quantidade);
                i.setValidade(validade);
                i.setIdFarmacia(idFarmacia);
                i.setIdAlmoxarifado(idAlmoxarifado);

                boolean sucesso = controller.inserirInsumo(i);
                if (sucesso) {
                    response.sendRedirect("consulta.jsp");
                    return;
                } else {
                    msg = "Falha ao inserir insumo.";
                    insumo = i;
                }
            }
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
    <link rel="stylesheet" href="estilos/consulta.css" />
    <style>
        .btn-voltar {
            display: inline-block;
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .btn-voltar:hover {
            background-color: #0056b3;
        }
        .erro {
            color: red;
            font-weight: bold;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input, textarea {
            width: 100%;
            max-width: 400px;
            padding: 5px;
            box-sizing: border-box;
        }
        button {
            margin-top: 15px;
            padding: 10px 20px;
            font-weight: bold;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
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

        <button type="submit"><%= editar ? "Salvar Alterações" : "Adicionar Insumo" %></button>
    </form>
    <p>
        <a href="consulta.jsp" class="btn-voltar">Voltar para lista</a>
    </p>
</body>
</html>
