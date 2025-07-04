package modelos;

public class Funcionarios {

    private int id;
    private String cpf;
    private String senha;
    private String nome;
    private String cargo;
    private int farmaciaId;
    private int hospitalId;

    public Funcionarios() {}

    public Funcionarios(int id, String cpf, String senha, String nome, String cargo, int farmaciaId, int hospitalId) {
        this.id = id;
        this.cpf = cpf;
        this.senha = senha;
        this.nome = nome;
        this.cargo = cargo;
        this.farmaciaId = farmaciaId;
        this.hospitalId = hospitalId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCpf() { return cpf; }
    public void setCpf(String cpf) { this.cpf = cpf; }

    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getCargo() { return cargo; }
    public void setCargo(String cargo) { this.cargo = cargo; }

    public int getFarmaciaId() { return farmaciaId; }
    public void setFarmaciaId(int farmaciaId) { this.farmaciaId = farmaciaId; }

    public int getHospitalId() { return hospitalId; }
    public void setHospitalId(int hospitalId) { this.hospitalId = hospitalId; }
}
