# Guia Rápido de Comandos - Neovim & Tmux

Este arquivo contém os atalhos e funcionalidades mais úteis configurados no seu ambiente.

## 🚀 Navegação Neovim <> Tmux
- `Ctrl + h`: Move para a janela/pane da **esquerda**.
- `Ctrl + j`: Move para a janela/pane de **baixo**.
- `Ctrl + k`: Move para a janela/pane de **cima**.
- `Ctrl + l`: Move para a janela/pane da **direita**.

---

## 📂 Arquivos e Busca (Exploradores & Telescope)
- `Espaço + pv`: Abre o explorador de arquivos editável (**Oil.nvim**).
- `nvim .`: Abre o diretório atual usando o **Oil.nvim**.
- `-` (dentro do Oil): Sobe para a pasta pai (equivalente ao `..`).
- `g.` (dentro do Oil): Alterna a visualização de arquivos ocultos (já configurado para mostrar por padrão).
- `Espaço + pf`: Busca arquivos por nome.
- `Ctrl + f`: Busca arquivos dentro do repositório Git.
- `Espaço + ps`: Busca por uma string específica em todos os arquivos (Grep).

---

## ⚓ Harpoon (Navegação Rápida entre Arquivos)
- `Espaço + a`: Adiciona o arquivo atual à lista do Harpoon.
- `Ctrl + e`: Abre o menu do Harpoon.
- `Ctrl + g`: Vai para o arquivo 1.
- `Ctrl + t`: Vai para o arquivo 2.
- `Ctrl + n`: Vai para o arquivo 3.
- `Ctrl + s`: Vai para o arquivo 4.

---

## 💻 LSP (Inteligência de Código)
*Abaixo estão os comandos padrão do `lsp-zero`:*
- `K`: Mostra a documentação/assinatura sob o cursor.
- `gd`: Vai para a definição.
- `gD`: Vai para a declaração.
- `gi`: Vai para a implementação.
- `gr`: Lista referências.
- `Espaço + f`: Formata o código atual.
- `Espaço + s`: Renomeia todas as ocorrências da palavra sob o cursor no arquivo atual.

---

## ✂️ Edição e Truques Úteis
- `Espaço + y`: Copia para a área de transferência do sistema (funciona no Neovim e Tmux).
- `Espaço + p`: Cola preservando o que você copiou (útil em modo Visual).
- `Espaço + d`: Deleta sem salvar no buffer (deleta "para sempre").
- `Espaço + x`: Torna o arquivo atual um executável (`chmod +x`).
- `Espaço + ee`: Insere um template de erro para Go (`if err != nil`).
- `Espaço + mr`: Faz "chover" no código (Cellular Automaton - diversão).

---

## ⚙️ Geral
- `Espaço + w`: Salva o arquivo.
- `Espaço + q`: Sai do arquivo/janela.
- `Ctrl + c`: Sai do modo de inserção (como se fosse Esc).
- `Espaço + Espaço`: Recarrega as configurações do arquivo atual (`so`).
