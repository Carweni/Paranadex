-- Preenchimento do banco com dados pseudo-aleatórios retirados dos arquivos .csv.

COPY habitat
FROM 'C:\Users\path\habitat.csv' -- Substituir "path" pelo caminho do arquivo no proprio computador.
DELIMITER ',' 
CSV HEADER;

COPY statusconservacao
FROM 'C:\Users\path\statusconservacao.csv' -- Substituir "path" pelo caminho do arquivo no proprio computador.
DELIMITER ',' 
CSV HEADER;

COPY regiao
FROM 'C:\Users\path\regiao.csv' -- Substituir "path" pelo caminho do arquivo no proprio computador.
DELIMITER ',' 
CSV HEADER;

COPY municipio(idmunicip, fkregiao, nomemunicip) -- Fazer isso se na tabela a ordem das colunas estiver trocada em relacao ao banco.
FROM 'C:\Users\path\municipio.csv' -- Substituir "path" pelo caminho do arquivo no proprio computador.
DELIMITER ',' 
CSV HEADER;

COPY taxonomia
FROM 'C:\Users\path\taxo.csv' -- Substituir "path" pelo caminho do arquivo no proprio computador.
DELIMITER ',' 
CSV HEADER;

COPY especie
FROM 'C:\Users\path\especie2.csv' -- Substituir "path" pelo caminho do arquivo no proprio computador.
DELIMITER ',' 
CSV HEADER;

COPY motivocaptura
FROM 'C:\Users\path\motivocap.csv' -- Substituir "path" pelo caminho do arquivo no proprio computador.
DELIMITER ',' 
CSV HEADER;

COPY tipoatividade
FROM 'C:\Users\path\tipoatividade.csv' -- Substituir "path" pelo caminho do arquivo no proprio computador.
DELIMITER ',' 
CSV HEADER;

COPY animal
FROM 'C:\Users\path\animais.csv' -- Substituir "path" pelo caminho do arquivo no proprio computador.
DELIMITER ',' 
CSV HEADER;

COPY amostra
FROM 'C:\Users\path\amostras.csv' -- Substituir "path" pelo caminho do arquivo no proprio computador.
DELIMITER ',' 
CSV HEADER;

COPY controlereinsercao
FROM 'C:\Users\path\controlereinsercao.csv' -- Substituir "path" pelo caminho do arquivo no proprio computador.
DELIMITER ',' 
CSV HEADER;