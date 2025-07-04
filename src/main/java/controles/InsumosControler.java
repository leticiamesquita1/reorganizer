
package controles;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelos.Insumos;
import utils.ConexaoDB;

@WebServlet("/insumos")
public class InsumosControler extends HttpServlet {

    private Insumos mapearInsumo(ResultSet rs) throws SQLException {
        Insumos i = new Insumos();
        i.setId(rs.getInt("id"));
        i.setNome(rs.getString("nome"));
        i.setDescricao(rs.getString("descricao"));
        i.setQuantidade(rs.getInt("quantidade"));
        i.setValidade(rs.getDate("validade"));
        i.setIdFarmacia(rs.getInt("farmacia_id"));
        i.setIdAlmoxarifado(rs.getInt("almoxarifado_id"));
        return i;
    }
    
    public boolean inserirInsumo(Insumos i) {
        String sql = "INSERT INTO tb_insumos (nome, descricao, quantidade, validade, farmacia_id, almoxarifado_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, i.getNome());
            stmt.setString(2, i.getDescricao());
            stmt.setInt(3, i.getQuantidade());
            if (i.getValidade() != null)
                stmt.setDate(4, new java.sql.Date(i.getValidade().getTime()));
            else
                stmt.setNull(4, java.sql.Types.DATE);
            stmt.setInt(5, i.getIdFarmacia());
            stmt.setInt(6, i.getIdAlmoxarifado());
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Insumos> listarInsumos() {
        List<Insumos> lista = new ArrayList<>();
        String sql = "SELECT * FROM tb_insumos";
        try (Connection conn = ConexaoDB.getConexao();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) lista.add(mapearInsumo(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    public boolean atualizarInsumo(Insumos i) {
        String sql = "UPDATE tb_insumos SET nome = ?, descricao = ?, quantidade = ?, validade = ?, farmacia_id = ?, almoxarifado_id = ? WHERE id = ?";
        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, i.getNome());
            stmt.setString(2, i.getDescricao());
            stmt.setInt(3, i.getQuantidade());
            if (i.getValidade() != null)
                stmt.setDate(4, new java.sql.Date(i.getValidade().getTime()));
            else
                stmt.setNull(4, java.sql.Types.DATE);
            stmt.setInt(5, i.getIdFarmacia());
            stmt.setInt(6, i.getIdAlmoxarifado());
            stmt.setInt(7, i.getId());
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Insumos> listarInsumosPorNome(String nome) {
        List<Insumos> lista = new ArrayList<>();
        String sql = "SELECT * FROM tb_insumos WHERE nome LIKE ?";
        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + nome + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                lista.add(mapearInsumo(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }


    public Insumos buscarPorId(int id) {
        String sql = "SELECT * FROM tb_insumos WHERE id=?";
        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapearInsumo(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean excluirInsumo(int id) {
        String sql = "DELETE FROM tb_insumos WHERE id=?";
        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");
        String busca = request.getParameter("busca");

        if ("excluir".equalsIgnoreCase(acao)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    excluirInsumo(id);
                } catch (NumberFormatException ignored) {}
            }
            response.sendRedirect("consulta.jsp");
            return;
        }



   
        response.sendRedirect("consulta.jsp");
    }
}
