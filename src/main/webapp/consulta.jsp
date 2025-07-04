<%
    String tipo = request.getParameter("tipo");
    if (tipo == null || (!tipo.equals("insumos") && !tipo.equals("funcionarios"))) {
        tipo = "insumos"; // padrão
    }
%>
<%@page import="controles.InsumosControler"%>
<%@page import="modelos.Insumos"%>
<%@page import="java.util.*" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String busca = request.getParameter("busca");
    InsumosControler controller = new InsumosControler();
    List<Insumos> lista = new ArrayList<>();

    if (busca != null && !busca.trim().isEmpty()) {
        try {
            int id = Integer.parseInt(busca.trim());
            Insumos ins = controller.buscarPorId(id);
            if (ins != null) lista.add(ins);
        } catch (NumberFormatException e) {
    
        }
    } else {
        lista = controller.listarInsumos();
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title>Consulta de Insumos</title>
    <link rel="stylesheet" href="estilos/consulta.css" />
    <style>
        .editar-estoque-fixo {
            position: fixed;
            bottom: 40px;
            right: 20px;
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .editar-estoque-fixo:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<header>
    <h1>Lista de Insumos</h1>
</header>
<div style="margin: 20px; text-align: center;">
    <a href="consulta.jsp?tipo=insumos" style="margin-right: 10px; padding: 8px 15px; background:#007bff; color:#fff; border-radius:5px; text-decoration:none;">
        Insumos
    </a>
    <a href="consulta.jsp?tipo=funcionarios" style="padding: 8px 15px; background:#28a745; color:#fff; border-radius:5px; text-decoration:none;">
        Funcionários
    </a>
</div>
<p style="display: flex; justify-content: center; gap: 10px; margin: 20px 0;">
    <form action="consulta.jsp" method="get" style="display: flex; gap: 10px;">
        <input type="text" name="busca" placeholder="Buscar por Nome..." value="<%= busca != null ? busca : "" %>" />
        <button type="submit">Buscar</button>
    </form>
</p>

<%
if ("insumos".equals(tipo)) {
    // Aqui entra o seu código atual para listar os insumos, que você já tem no JSP:
%>
<table>
    <thead>
        <tr>
            <th>ID</th><th>Nome</th><th>Descrição</th><th>Quantidade</th><th>Validade</th><th>Farmácia</th><th>Almoxarifado</th><th>Ações</th>
        </tr>
    </thead>
    <tbody>
    <%
        if (lista.isEmpty()) {
    %>
        <tr><td colspan="8" class="center">Nenhum insumo encontrado.</td></tr>
    <%
        } else {
            for (Insumos ins : lista) {
    %>
        <tr>
            <td><%= ins.getId() %></td>
            <td><%= ins.getNome() %></td>
            <td><%= ins.getDescricao() %></td>
            <td><%= ins.getQuantidade() %></td>
            <td><%= ins.getValidade() != null ? ins.getValidade().toString() : "" %></td>
            <td><%= ins.getIdFarmacia() %></td>
            <td><%= ins.getIdAlmoxarifado() %></td>
            <td>
                <a href="editar.jsp?id=<%= ins.getId() %>">Editar</a> |
                <a href="insumos?acao=excluir&id=<%= ins.getId() %>" onclick="return confirm('Confirma exclusão?');">Excluir</a>
            </td>
        </tr>
    <%
            }
        }
    %>
    </tbody>
</table>
<%
} else if ("funcionarios".equals(tipo)) {
    controles.FuncionariosControler fc = new controles.FuncionariosControler();
    List<modelos.Funcionarios> listaFunc = fc.listarFuncionarios();
    if (listaFunc == null) listaFunc = new ArrayList<>();
%>
<table>
    <thead>
        <tr>
            <th>ID</th><th>Nome</th><th>CPF</th><th>Função</th><th>Ações</th>
        </tr>
    </thead>
    <tbody>
    <%
        if (listaFunc.isEmpty()) {
    %>
        <tr><td colspan="5" class="center">Nenhum funcionário encontrado.</td></tr>
    <%
        } else {
            for (modelos.Funcionarios f : listaFunc) {
    %>
        <tr>
            <td><%= f.getId() %></td>
            <td><%= f.getNome() %></td>
            <td><%= f.getCpf() %></td>
            <td>
                <a href="editarFuncionario.jsp?id=<%= f.getId() %>">Editar</a> |
                <a href="funcionarios?acao=excluir&id=<%= f.getId() %>" onclick="return confirm('Confirma exclusão?');">Excluir</a>
            </td>
        </tr>
    <%
            }
        }
    %>
    </tbody>
</table>
<%
}
%>
<a href="<%= "funcionarios".equals(tipo) ? "editarFuncionario.jsp" : "editar.jsp" %>" class="editar-estoque-fixo">Editar</a>

<div class="footer">
    <p>reOrganizer 2025</p>
</div>
</body>
</html>
