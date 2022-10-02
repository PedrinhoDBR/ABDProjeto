CREATE DATABASE pedroaugusto;

use pedroaugusto;

CREATE TABLE cidade (
  "id_cidade" int NOT NULL AUTO_INCREMENT,
  "cidade" varchar(150) NOT NULL,
  PRIMARY KEY ("id_cidade")
);

CREATE TABLE cliente (
  "id_cliente" int NOT NULL AUTO_INCREMENT,
  "cpf" varchar(150) NOT NULL,
  "id_pessoa" int DEFAULT NULL,
  PRIMARY KEY ("id_cliente"),
  KEY "id_pessoa" ("id_pessoa"),
  CONSTRAINT "cliente_ibfk_1" FOREIGN KEY ("id_pessoa") REFERENCES "pessoa" ("id_pessoa")
);

CREATE TABLE endereco (
  "id_endereco" int NOT NULL AUTO_INCREMENT,
  "cep" int NOT NULL,
  "rua" varchar(150) NOT NULL,
  "id_cidade" int DEFAULT NULL,
  PRIMARY KEY ("id_endereco"),
  KEY "id_cidade" ("id_cidade"),
  CONSTRAINT "endereco_ibfk_1" FOREIGN KEY ("id_cidade") REFERENCES "cidade" ("id_cidade")
);

CREATE TABLE loja (
  "id_loja" int NOT NULL AUTO_INCREMENT,
  "Nome" varchar(150) NOT NULL,
  "id_endereco" int DEFAULT NULL,
  PRIMARY KEY ("id_loja"),
  KEY "id_endereco" ("id_endereco"),
  CONSTRAINT "loja_ibfk_1" FOREIGN KEY ("id_endereco") REFERENCES "endereco" ("id_endereco")
);

CREATE TABLE pessoa (
  "id_pessoa" int NOT NULL AUTO_INCREMENT,
  "nome" varchar(150) NOT NULL,
  "idade" int NOT NULL,
  "id_endereco" int DEFAULT NULL,
  PRIMARY KEY ("id_pessoa"),
  KEY "id_endereco" ("id_endereco"),
  CONSTRAINT "pessoa_ibfk_1" FOREIGN KEY ("id_endereco") REFERENCES "endereco" ("id_endereco")
);

CREATE TABLE produto (
  "id_produto" int NOT NULL AUTO_INCREMENT,
  "produto" varchar(150) NOT NULL,
  "estoque" int NOT NULL,
  "preco" int NOT NULL,
  "alcoolico" tinyint(1) NOT NULL,
  PRIMARY KEY ("id_produto")
);

CREATE TABLE venda (
  "id_venda" int NOT NULL AUTO_INCREMENT,
  "id_vendedor" int DEFAULT NULL,
  "id_cliente" int DEFAULT NULL,
  "id_loja" int DEFAULT NULL,
  PRIMARY KEY ("id_venda"),
  KEY "id_vendedor" ("id_vendedor"),
  KEY "id_cliente" ("id_cliente"),
  KEY "id_loja" ("id_loja"),
  CONSTRAINT "venda_ibfk_1" FOREIGN KEY ("id_vendedor") REFERENCES "vendedor" ("id_vendedor"),
  CONSTRAINT "venda_ibfk_2" FOREIGN KEY ("id_cliente") REFERENCES "cliente" ("id_cliente"),
  CONSTRAINT "venda_ibfk_3" FOREIGN KEY ("id_loja") REFERENCES "loja" ("id_loja")
);

CREATE TABLE vendaproduto (
  "id_vendaproduto" int NOT NULL AUTO_INCREMENT,
  "id_venda" int DEFAULT NULL,
  "id_produto" int DEFAULT NULL,
  "quantidade" int NOT NULL,
  PRIMARY KEY ("id_vendaproduto"),
  KEY "id_venda" ("id_venda"),
  KEY "id_produto" ("id_produto"),
  CONSTRAINT "vendaproduto_ibfk_1" FOREIGN KEY ("id_venda") REFERENCES "venda" ("id_venda"),
  CONSTRAINT "vendaproduto_ibfk_2" FOREIGN KEY ("id_produto") REFERENCES "produto" ("id_produto")
);

CREATE TABLE vendedor (
  "id_vendedor" int NOT NULL AUTO_INCREMENT,
  "cnpj" varchar(150) NOT NULL,
  "id_pessoa" int DEFAULT NULL,
  PRIMARY KEY ("id_vendedor"),
  KEY "id_pessoa" ("id_pessoa"),
  CONSTRAINT "vendedor_ibfk_1" FOREIGN KEY ("id_pessoa") REFERENCES "pessoa" ("id_pessoa")
);
