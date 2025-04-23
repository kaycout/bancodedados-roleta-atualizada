-- criação do banco de dados
create database roletadb;

-- seleciona o banco de dados
use roletadb;

-- tabela de empresas
create table empresa (
    id_empresa int auto_increment primary key,
    nome varchar(255) not null,
    empreendimento varchar(255) not null,
    data_sorteio date not null,
    periodo enum('manhã', 'tarde', 'integral') not null
);

-- tabela de sorteios
create table sorteio (
    id_sorteio int auto_increment primary key,
    id_empresa int not null,
    nome_responsavel varchar(255) not null,
    email_responsavel varchar(255) unique not null,
    senha_responsavel varchar(255) not null,
    data_criacao datetime default current_timestamp,
    status enum('aberto', 'finalizado') default 'aberto',
    finalizado boolean default false
);

-- tabela de participantes
create table participante (
    id_participante int auto_increment primary key,
    nome varchar(255) not null,
    equipe varchar(255) not null,
    supervisao varchar(255),
    id_sorteio int not null,
    via_qr boolean default false,
    unique(id_sorteio, nome)
);

-- tabela de resultados
create table resultado (
    id_resultado int auto_increment primary key,
    id_sorteio int not null,
    id_participante int not null,
    posicao int not null
);

-- tabela de qrcodes
create table qrcode (
    id_qrcode int auto_increment primary key,
    id_sorteio int not null,
    codigo varchar(255) unique not null,
    data_geracao datetime default current_timestamp
);

-- tabela de publicidade
create table publicidade (
    id_publicidade int auto_increment primary key,
    titulo varchar(255) not null,
    imagem_url varchar(255) not null,
    link_destino varchar(255) not null,
    tipo enum('rodapé', 'qr_intermediário', 'qr-final') not null
);

-- tabela de arquivos gerados
create table arquivos (
    id_arquivos int auto_increment primary key,
    id_sorteio int not null,
    nome_arquivo varchar(255) not null,
    data_geracao timestamp default current_timestamp
);

-- tabela de configurações do sorteio
create table configuracoes_sorteio (
    id_configuracoes_sorteio int auto_increment primary key,
    id_sorteio int not null,
    chave varchar(255) not null,
    valor varchar(255) not null
);


-- adicionando chaves estrangeiras separadamente

alter table sorteio
    add foreign key (id_empresa) references empresa(id_empresa) on delete cascade;

alter table participante
    add foreign key (id_sorteio) references sorteio(id_sorteio) on delete cascade;

alter table resultado
    add foreign key (id_sorteio) references sorteio(id_sorteio) on delete cascade,
    add foreign key (id_participante) references participante(id_participante) on delete cascade;

alter table qrcode
    add foreign key (id_sorteio) references sorteio(id_sorteio) on delete cascade;

alter table arquivos
    add foreign key (id_sorteio) references sorteio(id_sorteio) on delete cascade;

alter table configuracoes_sorteio
    add foreign key (id_sorteio) references sorteio(id_sorteio) on delete cascade;

