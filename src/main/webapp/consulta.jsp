<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="modelos.Insumos" %>
<%@ page import="controles.InsumosControler" %>
<%@ page import="modelos.Funcionarios" %>
<%@ page import="controles.FuncionariosControler" %>

<%
    String tipo = request.getParameter("tipo");
    if (tipo == null || (!tipo.equals("insumos") && !tipo.equals("funcionarios"))) {
        tipo = "insumos";
    }

    String busca = request.getParameter("busca");
    InsumosControler controller = new InsumosControler();
    List<Insumos> lista = new ArrayList<>();
    controles.FuncionariosControler fc = new controles.FuncionariosControler();
    List<modelos.Funcionarios> listaFunc = new ArrayList<>();

    if ("insumos".equals(tipo)) {
        if (busca != null && !busca.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(busca.trim());
                Insumos ins = controller.buscarPorId(id);
                if (ins != null) lista.add(ins);
            } catch (NumberFormatException e) {
                lista = controller.listarInsumosPorNome(busca.trim());
            }
        } else {
            lista = controller.listarInsumos();
        }
    } else if ("funcionarios".equals(tipo)) {
        if (busca != null && !busca.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(busca.trim());
                modelos.Funcionarios f = fc.buscarPorId(id);
                if (f != null) listaFunc.add(f);
            } catch (NumberFormatException e) {
                listaFunc = fc.listarPorNome(busca.trim());
            }
        } else {
            listaFunc = fc.listarFuncionarios();
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title>Admin</title>
    <link rel="stylesheet" href="estilos/consulta.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
<header>
    <h1>Controle de Dados</h1>
</header>

<div class="filtros-container">
    <div class="botoes-tipo">
        <a href="consulta.jsp?tipo=insumos" class="<%= "insumos".equals(tipo) ? "ativo" : "" %>">Medicamentos</a>
        <a href="consulta.jsp?tipo=funcionarios" class="<%= "funcionarios".equals(tipo) ? "ativo" : "" %>">Funcionários</a>
    </div>
    <form action="consulta.jsp" method="get" class="form-busca">
        <input type="hidden" name="tipo" value="<%= tipo %>" />
        <input type="text" name="busca" placeholder="Pesquisar..." value="<%= busca != null ? busca : "" %>" autocomplete="off" />
       <a href="editar.jsp" class="btn-editar" title="Editar">
    <i class="bi bi-pencil-square"></i>
</a>

    </form>
</div>

<% if ("insumos".equals(tipo)) { %>
<table>
    <thead>
        <tr>
            <th>ID</th><th>Nome</th><th>Descrição</th><th>Quantidade</th><th>Validade</th><th>Farmácia</th><th>Almoxarifado</th><th>Ações</th>
        </tr>
    </thead>
    <tbody>
    <% if (lista.isEmpty()) { %>
        <tr><td colspan="8" class="center">Nenhum insumo encontrado.</td></tr>
    <% } else {
        for (Insumos ins : lista) { %>
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
    <% } } %>
    </tbody>
</table>
<% } else { %>
<table>
    <thead>
        <tr>
            <th>ID</th><th>Nome</th><th>CPF</th><th>Função</th><th>Ações</th>
        </tr>
    </thead>
    <tbody>
    <% if (listaFunc.isEmpty()) { %>
        <tr><td colspan="5" class="center">Nenhum funcionário encontrado. </td></tr>
    <% } else {
        for (modelos.Funcionarios f : listaFunc) { %>
        <tr>
            <td><%= f.getId() %></td>
            <td><%= f.getNome() %></td>
            <td><%= f.getCpf() %></td>
            <td>
                <a href="editarFuncionario.jsp?id=<%= f.getId() %>">Editar</a> |
                <a href="funcionarios?acao=excluir&id=<%= f.getId() %>" onclick="return confirm('Confirma exclusão?');">Excluir</a>
            </td>
        </tr>
    <% } } %>
    </tbody>
</table>
<% } %>

<div class="footer">
    <p>© 2025 reOrganizer</p>
</div>
</body>
</html>
