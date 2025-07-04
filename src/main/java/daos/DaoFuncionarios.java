package daos;

import java.sql.*;
import modelos.Funcionarios;
import utils.ConexaoDB;

public class DaoFuncionarios {

    public Funcionarios autenticar(String cpf, String senha) {
        String sql = "SELECT id, cpf, senha, nome, cargo, farmacia_id, hospital_id FROM tb_funcionario WHERE cpf = ? AND senha = ?";
        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, cpf);
            ps.setString(2, senha);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Funcionarios f = new Funcionarios();
                f.setId(rs.getInt("id"));
                f.setCpf(rs.getString("cpf"));
                f.setSenha(rs.getString("senha"));
                f.setNome(rs.getString("nome"));
                f.setCargo(rs.getString("cargo"));
                f.setFarmaciaId(rs.getInt("farmacia_id"));
                f.setHospitalId(rs.getInt("hospital_id"));
                return f;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao autenticar funcionário: " + e.getMessage());
        }
        return null;
    }
}
