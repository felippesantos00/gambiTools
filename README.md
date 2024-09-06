# GambiTools

**GambiTools** é uma coleção de utilitários em shell script e AWK, projetada para resolver problemas comuns de forma rápida e eficiente. Inspirado na versatilidade do "canivete suíço", o GambiTools oferece uma série de funções que automatizam e facilitam operações cotidianas no desenvolvimento e administração de sistemas.

## Índice

- [Funcionalidades](#funcionalidades)
- [Requisitos](#requisitos)
- [Instalação](#instalação)
- [Uso](#uso)
  - [1. Verificar se um arquivo existe](#1-verificar-se-um-arquivo-existe)
  - [2. Verificar se um diretório existe](#2-verificar-se-um-diretório-existe)
  - [3. Registrar uma mensagem de log](#3-registrar-uma-mensagem-de-log)
  - [4. Rotacionar arquivos de log](#4-rotacionar-arquivos-de-log)
  - [5. Buscar uma palavra em arquivos de log](#5-buscar-uma-palavra-em-arquivos-de-log)
  - [6. Criar backup de arquivo](#6-criar-backup-de-arquivo)
  - [7. Identificar sistema operacional](#7-identificar-sistema-operacional)
  - [8. Formatar datas para ISO 8601](#8-formatar-datas-para-iso-8601)
  - [9. Gerar Linha do Tempo](#9-gerar-linha-do-tempo)
- [Contribuições](#contribuições)
- [Roadmap](#roadmap)
- [Licença](#licença)
- [Agradecimentos](#agradecimentos)

## Funcionalidades

- **Gerenciamento de Datas**: Converta, formate e manipule timestamps em diferentes formatos de log.
- **Automação de Tarefas**: Scripts otimizados para automação de processos repetitivos.
- **Manipulação de Arquivos**: Ferramentas para parseamento de grandes arquivos de log, filtragem de dados e muito mais.
- **Análise de Sistema**: Ferramentas de monitoramento de sistema em tempo real e geração de relatórios.

## Requisitos

- **Bash**: v4.0+
- **AWK**: gawk ou qualquer implementação compatível
- **Sed**: qualquer versão

## Instalação

Clone o repositório para o seu ambiente local:
```bash
git clone https://github.com/seu-usuario/gambiTools.git
cd gambiTools
```

Certifique-se de que os scripts possuem permissão de execução:
```bash
chmod +x *.sh
```

Adicione o diretório do projeto ao seu PATH para acesso global:
```bash
export PATH=$PATH:/caminho/para/gambiTools
```

## Uso

### 1. Verificar se um arquivo existe

**Função:** `verificar_arquivo_existe`

Verifica se um arquivo existe e registra o resultado no log.

**Exemplo:**
```bash
verificar_arquivo_existe "/caminho/para/arquivo.txt"
```
**Saída esperada:**
```
Arquivo existe: /caminho/para/arquivo.txt
```

### 2. Verificar se um diretório existe

**Função:** `verificar_diretorio_existe`

Verifica se um diretório existe e registra o resultado no log.

**Exemplo:**
```bash
verificar_diretorio_existe "/caminho/para/diretorio"
```
**Saída esperada:**
```
Diretório existe: /caminho/para/diretorio
```

### 3. Registrar uma mensagem de log

**Função:** `registrar_log`

Registra uma mensagem com data e hora em um arquivo de log e realiza a rotação dos logs se necessário.

**Exemplo:**
```bash
registrar_log "Iniciando processo de backup"
```
**Saída esperada:**
```
2024-09-01 10:00:00.000 - Iniciando processo de backup
```

### 4. Rotacionar arquivos de log

**Função:** `rotacionar_logs`

Rotaciona arquivos de log que excedem um tamanho específico. Cria o diretório de logs se ele não existir.

**Exemplo:**
```bash
rotacionar_logs "/caminho/para/diretorio/logs" "10k"
```
**Saída esperada:**
```
Diretório de logs existe: /caminho/para/diretorio/logs
```
Ou, se o diretório precisar ser criado:
```
Criando diretório de logs: /caminho/para/diretorio/logs
```

### 5. Buscar uma palavra em arquivos de log

**Função:** `buscar_palavra_em_log`

Busca uma palavra em arquivos de log e registra o resultado.

**Exemplo:**
```bash
buscar_palavra_em_log "/caminho/para/arquivo.log" "erro"
```
**Saída esperada:**
```
Buscando palavra: erro no arquivo: /caminho/para/arquivo.log
Palavra encontrada: erro
```

### 6. Criar backup de arquivo

**Função:** `criar_backup_arquivo`

Cria um backup de um arquivo e o compacta com base no sistema operacional detectado.

**Exemplo:**
```bash
criar_backup_arquivo "meuarquivo.txt"
```
**Saída esperada:**
```
Sistema operacional detectado: Linux
Compactando arquivo: meuarquivo.txt
```
Ou, para Windows:
```
Sistema operacional detectado: MINGW64_NT-10.0-19045
Compactando arquivo: meuarquivo.txt
```

### 7. Identificar sistema operacional

**Função:** `identificar_sistema_operacional`

Identifica o sistema operacional e registra o resultado.

**Exemplo:**
```bash
identificar_sistema_operacional
```
**Saída esperada:**
```
Identificando sistema operacional: Linux
```

### 8. Formatar datas para ISO 8601

**Função:** `formatar_datas_para_iso_8601`

Formata datas em um arquivo para o padrão ISO 8601.

**Exemplo:**
```bash
formatar_datas_para_iso_8601 "/caminho/para/arquivo.csv"
```
**Saída esperada:**
```
2024-09-01T10:00:00
2024-09-01T10:01:00
```
**Observação:** Certifique-se de que o arquivo contém datas no formato suportado.

### 9. Gerar Linha do Tempo

**Função:** `generate_timeline`

Gera uma sequência de timestamps a partir de uma data inicial e intervalos específicos.

**Exemplo:**
```bash
generate_timeline "2024-09-01 10:00:00" 60 10
```
**Saída esperada:**
```
2024-09-01 10:00:00
2024-09-01 10:01:00
2024-09-01 10:02:00
2024-09-01 10:03:00
2024-09-01 10:04:00
2024-09-01 10:05:00
2024-09-01 10:06:00
2024-09-01 10:07:00
2024-09-01 10:08:00
2024-09-01 10:09:00
```
**Parâmetros:**
- `start_date`: Data inicial no formato `YYYY-MM-DD HH:MM:SS`
- `interval`: Intervalo em segundos entre os timestamps (ex.: 1 para segundos, 60 para minutos, 86400 para dias)
- `qtd_lines`: Quantidade de timestamps a serem gerados

## Contribuições

Contribuições são muito bem-vindas! Se você deseja adicionar novas ferramentas, melhorar os scripts existentes, ou sugerir novas ideias, fique à vontade para abrir um [Pull Request](https://github.com/seu-usuario/gambiTools/pulls).

## Roadmap

- Adicionar suporte a outros formatos de log
- Adicionar parse de logs por meio de um dicionario
- Melhorar a compatibilidade com sistemas Unix-like e MacOS
- Adicionar mais ferramentas para automação de tarefas DevOps

## Agradecimentos

Gostaria de expressar minha profunda gratidão aos seguintes recursos que foram essenciais para o desenvolvimento do GambiTools:

- **[Aurelio.net - Canivete Suíço de Shell](https://aurelio.net/shell/canivete/)**: Este site inspirou a criação de uma coleção de utilitários versáteis e práticos para automação e administração de sistemas.
- **[GNU AWK Manual](https://www.gnu.org/software/gawk/manual/gawk.html)**: O manual do AWK foi fundamental para compreender e implementar funcionalidades de manipulação de dados e logs.
- **[Stack Overflow](https://stackoverflow.com)**: A comunidade do Stack Overflow forneceu soluções valiosas e insights que foram cruciais para resolver desafios técnicos durante o desenvolvimento.

Agradeço a todos os autores e contribuintes que compartilham seu conhecimento e experiências, tornando o desenvolvimento mais acessível e enriquecedor. Um agradecimento especial à comunidade brasileira de TI por sempre encontrar soluções criativas e práticas para resolver problemas. "Se não tem solução, a gente inventa!"
