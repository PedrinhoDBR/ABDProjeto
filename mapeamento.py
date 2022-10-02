from sqlalchemy import Boolean, ForeignKey
from sqlalchemy.orm import declarative_base, sessionmaker,relationship
from sqlalchemy import Column, Integer, String, create_engine
# <dbms>[+<driver>]://<user>:<pass>@<host>[:<port>][/<database>]
URL="mysql+mysqlconnector://root:root@127.0.0.1:3306/pedroaugusto"
engine = create_engine(url=URL)
Base = declarative_base()

class cidade(Base):
    __tablename__ = "Cidade"
    id_cidade= Column(Integer,primary_key=True)
    cidade = Column(String(150),nullable=False)

class endereco(Base):
    __tablename__ = "Endereco"
    id_endereco = Column(Integer,primary_key=True)
    cep = Column(Integer,nullable=False)
    rua = Column(String(150),nullable=False)
    id_cidade = Column(Integer,ForeignKey("Cidade.id_cidade"))

class loja(Base):
    __tablename__ = "Loja"
    id_loja = Column(Integer,primary_key=True)
    Nome = Column(String(150),nullable=False)
    id_endereco = Column(Integer,ForeignKey("Endereco.id_endereco")) 

class pessoa(Base):
    __tablename__ = "Pessoa"
    id_pessoa = Column(Integer, primary_key=True)
    nome = Column(String(150), nullable=False)
    idade = Column(Integer, nullable=False)
    id_endereco = Column(Integer,ForeignKey("Endereco.id_endereco"))
    cliente = relationship("cliente",backref="Pessoa",uselist=False)
    vendedor = relationship("vendedor",backref="Pessoa",uselist=False)

class cliente(Base):
    __tablename__ = "Cliente"
    id_cliente = Column(Integer,primary_key=True)
    cpf= Column(String(150),nullable=False)
    id_pessoa = Column(Integer,ForeignKey("Pessoa.id_pessoa"))

class vendedor(Base):
    __tablename__ = "Vendedor"
    id_vendedor = Column(Integer,primary_key=True)
    cnpj = Column(String(150),nullable=False)
    id_pessoa = Column(Integer,ForeignKey("Pessoa.id_pessoa"))

class produto(Base):
    __tablename__="Produto"
    id_produto=Column(Integer,primary_key=True)
    produto=Column(String(150),nullable=False)
    estoque=Column(Integer,nullable=False)
    #data_validade=Column
    preco=Column(Integer,nullable=False)
    alcoolico=Column(Boolean,nullable=False)

class venda(Base):
    __tablename__ = "Venda"
    id_venda = Column(Integer,primary_key=True)
    id_vendedor = Column(Integer,ForeignKey("Vendedor.id_vendedor"))
    id_cliente = Column(Integer,ForeignKey("Cliente.id_cliente"))
    id_loja = Column(Integer,ForeignKey("Loja.id_loja"))
    vendedor = relationship("vendedor")
    cliente = relationship("cliente")
    loja = relationship("loja")

class vendaproduto(Base):
    __tablename__="VendaProduto"
    id_vendaproduto=Column(Integer,primary_key=True)
    id_venda = Column(Integer,ForeignKey("Venda.id_venda"))
    id_produto= Column(Integer,ForeignKey("Produto.id_produto"))
    quantidade = Column(Integer,nullable=False)
    venda = relationship("venda")
    produto = relationship("produto")

Base.metadata.drop_all(engine)
Base.metadata.create_all(engine)
Session = sessionmaker(engine)
