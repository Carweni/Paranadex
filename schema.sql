CREATE DATABASE Paranadex;

CREATE TABLE Taxonomia(
	idTaxo varchar(4) not null Primary Key,
	nomeTaxo varchar(40),
	classificacao varchar(40)
);

CREATE TABLE StatusConservacao(
	codStatus varchar(4) not null Primary Key,
	descStatus varchar(40)
);

CREATE TABLE MotivoCaptura(
	codResgate Serial not null Primary Key,
	motivo varchar(40),
	observacao varchar(40)
);

CREATE TABLE Habitat(
	idHabitat Serial not null Primary Key,
	tipoHabitat varchar(40)
);

CREATE TABLE Regiao(
	idRegiao Serial not null Primary Key,
	nomeRegiao varchar(40)
);

CREATE TABLE Municipio(
	idMunicip Serial not null Primary Key,
	nomeMunicip varchar(40),
	fkRegiao Integer not null,
	Foreign Key (fkRegiao) References Regiao (idRegiao)
);

CREATE TABLE TipoAtividade(
	idTipoAtiv Serial not null Primary Key,
	nomeTipoAtiv varchar(40),
	tsCaptura timestamp,
	tsReinsercao timestamp,
	tpTMonitoramento timestamp,
	fkMunicip Integer not null,
	Foreign Key (fkMunicip) References Municipio (idMunicip)
);

CREATE TABLE Especie(
	--idEsp Serial not null,
	nomeCientif varchar(50) not null,
	nomeVulgar varchar(50),
	qtdtotal Integer,
	fkTaxo varchar(4) not null,
	fkStatus varchar(4) not null,
	fkHabitat Integer not null,
	primary key(nomeCientif),
	Foreign Key (fkTaxo) References Taxonomia (idTaxo),
	Foreign Key (fkStatus) References StatusConservacao (codStatus),
	Foreign Key (fkHabitat) References Habitat (idHabitat)
);

CREATE TABLE Animal(
	codChip Serial not null Primary Key,
	peso float,
	altura float,
	fkEsp varchar(50) not null,
	fkCap Integer not null,
	fkControl Integer not null,
	fkTipoAtiv Integer not null,
	Foreign Key (fkEsp) References Especie (nomeCientif),
	Foreign Key (fkCap) References MotivoCaptura (codResgate),
	Foreign Key (fkTipoAtiv) References TipoAtividade (idTipoAtiv)
);

CREATE TABLE ControleReinsercao(
	codInsert Serial not null Primary Key,
	dataHora date,
	fkAnimal Integer not null,
	local Integer not null,
	Foreign Key (fkAnimal) References Animal(codChip),
	Foreign Key (local) References Municipio (idMunicip)
);

CREATE TABLE Animal_MotivoCaptura(
	fkAnimal Integer not null,
	fkCap Integer not null,
	observacao varchar(40),
	Foreign Key (fkAnimal) References Animal (codChip),
	Foreign Key (fkCap) References MotivoCaptura (codResgate)
);

-- Adicionar a chave estrangeira fkControl, de ControleReinsercao, na tabela Animal:
ALTER TABLE Animal	ADD CONSTRAINT fkControl Foreign Key (fkControl) References ControleReinsercao (codInsert);

ALTER TABLE tipoatividade ADD fk_animal Integer not null;
ALTER TABLE tipoatividade ADD CONSTRAINT fk_animal Foreign Key (fk_animal) References Animal (codchip);

-- Remover a restricao de chave estrangeira da tabela Animal para Especie:
ALTER TABLE animal DROP CONSTRAINT animal_fkesp_fkey;

-- Remover a restricao de chave estrangeira da tabela Especie para Taxonomia:
ALTER TABLE especie DROP CONSTRAINT especie_fktaxo_fkey;

-- Mudar o tipo de dado da chave primeira da tabela Taxonomia para Integer:
ALTER TABLE taxonomia DROP CONSTRAINT taxonomia_pkey;
ALTER TABLE taxonomia ALTER COLUMN idtaxo TYPE INTEGER USING idtaxo::INTEGER;
ALTER TABLE taxonomia ADD PRIMARY KEY (idtaxo);

ALTER TABLE especie DROP COLUMN fktaxo;
ALTER TABLE especie ADD fk_taxo Integer not null;
ALTER TABLE especie ADD CONSTRAINT especie_fktaxo_fkey Foreign Key (fk_taxo) References taxonomia (idtaxo);

ALTER TABLE animal DROP COLUMN fkesp;
ALTER TABLE animal ADD fk_esp varchar(50) not null ;
ALTER TABLE animal ADD CONSTRAINT animal_fkesp_fkey Foreign Key (fk_esp) References especie (nomecientif);

ALTER TABLE motivocaptura DROP COLUMN observacao;

ALTER TABLE animal DROP CONSTRAINT fkcontrol;
ALTER TABLE animal DROP COLUMN fkcontrol;

ALTER TABLE animal DROP CONSTRAINT animal_fktipoativ_fkey;
ALTER TABLE animal DROP COLUMN fktipoativ;

ALTER TABLE animal DROP CONSTRAINT animal_fkcap_fkey;
ALTER TABLE animal DROP COLUMN fkcap;

ALTER TABLE tipoatividade DROP CONSTRAINT tipoatividade_fkmunicip_fkey;
ALTER TABLE tipoatividade DROP COLUMN fkmunicip;

ALTER TABLE tipoatividade DROP CONSTRAINT fk_animal;
ALTER TABLE tipoatividade DROP COLUMN fk_animal;

ALTER TABLE animal_motivocaptura RENAME TO amostra;

ALTER TABLE amostra RENAME CONSTRAINT animal_motivocaptura_fkanimal_fkey TO amostra_fkanimal_fkey;
ALTER TABLE amostra RENAME CONSTRAINT animal_motivocaptura_fkcap_fkey TO amostra_fkcap_fkey;

-- Adicionar novas colunas a tabela Amostra:
ALTER TABLE amostra ADD COLUMN tscaptura  timestamp;
ALTER TABLE amostra ADD COLUMN tsreinsercao  timestamp;
ALTER TABLE amostra ADD COLUMN tptmonitoramentodias  integer;
ALTER TABLE amostra ADD COLUMN fkmunicip integer not null;
ALTER TABLE amostra ADD CONSTRAINT amostra_fkmunicip_fkey FOREIGN KEY(fkmunicip) REFERENCES municipio (idmunicip);
ALTER TABLE amostra ADD COLUMN fktipoativ integer not null;
ALTER TABLE amostra ADD CONSTRAINT amostra_fktipoativ_fkey FOREIGN KEY(fktipoativ) REFERENCES tipoatividade (idtipoativ);

ALTER TABLE amostra ADD COLUMN idamostra serial not null PRIMARY KEY;

ALTER TABLE tipoatividade DROP COLUMN tscaptura;
ALTER TABLE tipoatividade DROP COLUMN tsreinsercao;
ALTER TABLE tipoatividade DROP COLUMN tptmonitoramento;

ALTER TABLE amostra ALTER COLUMN observacao type varchar(100);