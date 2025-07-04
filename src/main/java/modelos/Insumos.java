package modelos;

import java.sql.Date;

public class Insumos {
	
 
	    private int id;
	    private String nome;
	    private String descricao;
	    private int quantidade;
	    private Date validade;
	    private int idFarmacia;
	    private int idAlmoxarifado;
 
	    public Insumos() {}
 
	    public Insumos(int id, String nome, String descricao, int quantidade, Date validade, int idFarmacia, int idAlmoxarifado) {
	        this.setId(id);
	        this.setNome(nome);
	        this.setDescricao(descricao);
	        this.setQuantidade(quantidade);
	        this.setValidade(validade);
	        this.setIdFarmacia(idFarmacia);
	        this.setIdAlmoxarifado(idAlmoxarifado);
	    }
 
		public int getId() {
			return id;
		}
 
		public void setId(int id) {
			this.id = id;
		}
 
		public String getNome() {
			return nome;
		}
 
		public void setNome(String nome) {
			this.nome = nome;
		}
 
		public String getDescricao() {
			return descricao;
		}
 
		public void setDescricao(String descricao) {
			this.descricao = descricao;
		}
 
		public int getQuantidade() {
			return quantidade;
		}
 
		public void setQuantidade(int quantidade) {
			this.quantidade = quantidade;
		}
 
		public Date getValidade() {
			return validade;
		}
 
		public void setValidade(Date validade) {
			this.validade = validade;
		}
 
		public int getIdFarmacia() {
			return idFarmacia;
		}
 
		public void setIdFarmacia(int idFarmacia) {
			this.idFarmacia = idFarmacia;
		}
 
		public int getIdAlmoxarifado() {
			return idAlmoxarifado;
		}
 
		public void setIdAlmoxarifado(int idAlmoxarifado) {
			this.idAlmoxarifado = idAlmoxarifado;
		}
}