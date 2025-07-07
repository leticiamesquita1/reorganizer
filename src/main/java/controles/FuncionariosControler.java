package controles;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import daos.DaoFuncionarios;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelos.Funcionarios;
import utils.ConexaoDB;

@WebServlet("/funcionarios")
public class FuncionariosControler extends HttpServlet {

    private DaoFuncionarios dao = new DaoFuncionarios();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        if ("excluir".equalsIgnoreCase(acao)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    dao.delete(id);
                } catch (NumberFormatException ignored) {}
            }
            response.sendRedirect("consulta.jsp"); // ajuste para sua JSP de consulta de funcionários
            return;
        }

        // outras ações se precisar

        response.sendRedirect("consulta.jsp");
    }

    public Funcionarios buscarPorId(int id) {
        String sql = "SELECT * FROM tb_funcionario WHERE id = ?";
        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapearFuncionario(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Funcionarios mapearFuncionario(ResultSet rs) throws SQLException {
        Funcionarios f = new Funcionarios();
        f.setId(rs.getInt("id"));
        f.setNome(rs.getString("nome"));
        f.setCpf(rs.getString("cpf"));
        f.setCargo(rs.getString("cargo"));
      
        return f;
    }

    public boolean inserirFuncionario(Funcionarios f) {
        String sql = "INSERT INTO tb_funcionario (nome, cpf, cargo, senha) VALUES (?, ?, ?, ?)";
        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, f.getNome());
            stmt.setString(2, f.getCpf());
            stmt.setString(3, f.getCargo());
            stmt.setString(4, f.getSenha());
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean atualizarFuncionario(Funcionarios f) {
        if (f.getSenha() == null || f.getSenha().trim().isEmpty()) {
      
            String sql = "UPDATE tb_funcionario SET nome = ?, cpf = ?, cargo = ? WHERE id = ?";
            try (Connection conn = ConexaoDB.getConexao();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, f.getNome());
                stmt.setString(2, f.getCpf());
                stmt.setString(3, f.getCargo());
                stmt.setInt(4, f.getId());
                int rows = stmt.executeUpdate();
                return rows > 0;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        } else {
      
            String sql = "UPDATE tb_funcionario SET nome = ?, cpf = ?, cargo = ?, senha = ? WHERE id = ?";
            try (Connection conn = ConexaoDB.getConexao();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, f.getNome());
                stmt.setString(2, f.getCpf());
                stmt.setString(3, f.getCargo());
                stmt.setString(4, f.getSenha());
                stmt.setInt(5, f.getId());
                int rows = stmt.executeUpdate();
                return rows > 0;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        }
    }
    public List<Funcionarios> listarFuncionarios() {
        List<Funcionarios> lista = new ArrayList<>();
        String sql = "SELECT * FROM tb_funcionario";

        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Funcionarios f = new Funcionarios();
                f.setId(rs.getInt("id"));
                f.setNome(rs.getString("nome"));
                f.setCpf(rs.getString("cpf"));
                f.setCargo(rs.getString("cargo"));
                lista.add(f);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    
    public List<Funcionarios> listarPorNome(String nome) {
        List<Funcionarios> lista = new ArrayList<>();
        String sql = "SELECT * FROM funcionarios WHERE nome LIKE ?";

        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + nome + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Funcionarios f = new Funcionarios();
                    f.setId(rs.getInt("id"));
                    f.setNome(rs.getString("nome"));
                    f.setCpf(rs.getString("cpf"));
                    f.setCargo(rs.getString("cargo")); // assumindo coluna 'cargo'
                    lista.add(f);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // trate melhor em produção
        }

        return lista;
    }
    public Funcionarios autenticar(String cpf, String senha) {
        String sql = "SELECT * FROM tb_funcionario WHERE cpf = ? AND senha = ?";
        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cpf);
            stmt.setString(2, senha);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapearFuncionario(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
 