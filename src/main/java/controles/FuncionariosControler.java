package controles;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import daos.DaoFuncionarios;
import modelos.Funcionarios;
import utils.ConexaoDB;

public class FuncionariosControler {

    private DaoFuncionarios daoFuncionarios = new DaoFuncionarios();

    public Funcionarios autenticar(String cpf, String senha) {
        return daoFuncionarios.autenticar(cpf, senha);
    }
    
    public List<Funcionarios> listarFuncionarios() {
        List<Funcionarios> lista = new ArrayList<>();
        String sql = "SELECT * FROM funcionarios";

        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Funcionarios f = new Funcionarios();
                f.setId(rs.getInt("id"));
                f.setNome(rs.getString("nome"));
                f.setCargo(rs.getString("cargo"));
                lista.add(f);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
