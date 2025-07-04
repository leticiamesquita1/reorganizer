package daos;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import modelos.Insumos;
import utils.ConexaoDB;

public class DaoInsumos {

    public static List<Insumos> getAll() {
        List<Insumos> insumos = new ArrayList<>();
        String sql = "SELECT id, nome, descricao, quantidade, validade, id_farmacia, id_almoxarifado FROM tb_insumos";
        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement stm = con.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                Insumos i = new Insumos();
                i.setId(rs.getInt("id"));
                i.setNome(rs.getString("nome"));
                i.setDescricao(rs.getString("descricao"));
                i.setQuantidade(rs.getInt("quantidade"));
                i.setValidade(rs.getDate("validade"));
                i.setIdFarmacia(rs.getInt("id_farmacia"));
                i.setIdAlmoxarifado(rs.getInt("id_almoxarifado"));
                insumos.add(i);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao listar insumos: " + e.getMessage());
        }
        return insumos;
    }

    public static Insumos getById(int id) {
        Insumos ins = null;
        String sql = "SELECT id, nome, descricao, quantidade, validade, id_farmacia, id_almoxarifado FROM tb_insumos WHERE id = ?";
        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {

            stm.setInt(1, id);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    ins = new Insumos();
                    ins.setId(rs.getInt("id"));
                    ins.setNome(rs.getString("nome"));
                    ins.setDescricao(rs.getString("descricao"));
                    ins.setQuantidade(rs.getInt("quantidade"));
                    ins.setValidade(rs.getDate("validade"));
                    ins.setIdFarmacia(rs.getInt("id_farmacia"));
                    ins.setIdAlmoxarifado(rs.getInt("id_almoxarifado"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao buscar insumo por ID: " + e.getMessage());
        }
        return ins;
    }

    public static boolean insert(Insumos insumos) {
        String sql = "INSERT INTO tb_insumos (nome, descricao, quantidade, validade, id_farmacia, id_almoxarifado) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {

            stm.setString(1, insumos.getNome());
            stm.setString(2, insumos.getDescricao());
            stm.setInt(3, insumos.getQuantidade());
            stm.setDate(4, insumos.getValidade());
            stm.setInt(5, insumos.getIdFarmacia());
            stm.setInt(6, insumos.getIdAlmoxarifado());

            int affected = stm.executeUpdate();
            return affected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean update(Insumos insumos) {
        String sql = "UPDATE tb_insumos SET nome=?, descricao=?, quantidade=?, validade=?, id_farmacia=?, id_almoxarifado=? WHERE id=?";
        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {

            stm.setString(1, insumos.getNome());
            stm.setString(2, insumos.getDescricao());
            stm.setInt(3, insumos.getQuantidade());
            stm.setDate(4, insumos.getValidade());
            stm.setInt(5, insumos.getIdFarmacia());
            stm.setInt(6, insumos.getIdAlmoxarifado());
            stm.setInt(7, insumos.getId());

            int affected = stm.executeUpdate();
            return affected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean delete(int id) {
        String sql = "DELETE FROM tb_insumos WHERE id=?";
        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {

            stm.setInt(1, id);
            int affected = stm.executeUpdate();
            return affected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Insumos> buscarPorNome(String nomeParcial) {
        List<Insumos> lista = new ArrayList<>();
        String sql = "SELECT id, nome, descricao, quantidade, validade, id_farmacia, id_almoxarifado FROM tb_insumos WHERE nome LIKE ?";
        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {

            stm.setString(1, "%" + nomeParcial + "%");
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Insumos i = new Insumos();
                    i.setId(rs.getInt("id"));
                    i.setNome(rs.getString("nome"));
                    i.setDescricao(rs.getString("descricao"));
                    i.setQuantidade(rs.getInt("quantidade"));
                    i.setValidade(rs.getDate("validade"));
                    i.setIdFarmacia(rs.getInt("id_farmacia"));
                    i.setIdAlmoxarifado(rs.getInt("id_almoxarifado"));
                    lista.add(i);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao buscar insumos por nome: " + e.getMessage());
        }
        return lista;
    }
}
