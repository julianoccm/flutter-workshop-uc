# Guia de Prompts — Flutter com GitHub Copilot

> Referência rápida com prompts prontos para copiar e colar no Copilot Chat.  
> Use durante a aula ou como consulta futura.

---

## 1. Anatomia de um Bom Prompt

### A Fórmula

```
CONTEXTO  →  O que já existe, onde estou no projeto
TAREFA    →  O que quero que a IA faça
FORMATO   →  Como quero o resultado (layout, estrutura, estilo)
RESTRIÇÕES →  O que NÃO fazer, limitações técnicas
```

### Exemplo Aplicado

❌ **Prompt ruim:**
```
Faz uma tela de lista
```

✅ **Prompt bom:**
```
Crie uma tela Flutter que exiba uma lista de usuários vindos da API
https://jsonplaceholder.typicode.com/users. Use ListView.builder com
cards mostrando nome e email. Adicione um CircularProgressIndicator
enquanto carrega e uma mensagem de erro se a requisição falhar.
Use StatefulWidget com setState.
```

### Por que funciona?

| Elemento | No prompt bom |
|----------|---------------|
| Contexto | "tela Flutter", "API jsonplaceholder" |
| Tarefa | "exiba uma lista de usuários" |
| Formato | "ListView.builder com cards mostrando nome e email" |
| Restrições | "StatefulWidget com setState", loading e erro |

---

## 2. Prompts para Flutter — Copie e Use

### 🏗️ Criar o App do Zero

```
Crie o main.dart com MaterialApp usando Material Design 3, tema escuro
com cor primária deepPurple, e uma tela inicial chamada HomeScreen.
```

---

### 📊 Dashboard com Gráficos (fl_chart + JSON local)

**Gráfico de barras:**
```
Crie uma tela de dashboard que leia os dados de vendas_mensais do arquivo
assets/dados_dashboard.json e exiba um gráfico de barras usando fl_chart.
Cada barra deve representar um mês. Use cores vibrantes e mostre o título
"Vendas Mensais 2025" acima do gráfico. Coloque tudo dentro de um Card
com padding.
```

**Gráfico de pizza:**
```
Adicione ao dashboard um gráfico de pizza (PieChart do fl_chart) usando
os dados de categorias do arquivo assets/dados_dashboard.json. Cada fatia
deve usar a cor hex definida no JSON. Mostre uma legenda abaixo do gráfico
com o nome da categoria e o percentual.
```

**Gráfico de linhas:**
```
Adicione ao dashboard um gráfico de linhas (LineChart do fl_chart) usando
os dados de acessos do arquivo assets/dados_dashboard.json. A linha deve
ter um gradiente de cor e pontos marcados em cada semana. Mostre labels
no eixo X com os nomes das semanas.
```

---

### 🌐 Consumir API com HTTP

**Lista de uma API:**
```
Crie uma nova tela que faça GET em https://jsonplaceholder.typicode.com/posts
e exiba os posts em uma ListView. Cada item deve ser um Card com o título
em negrito e o body abaixo. Adicione loading e tratamento de erro.
Crie um model Post e um service separado.
```

**Lista de Pokémon:**
```
Crie uma tela que busque os primeiros 20 pokémon da PokeAPI
(https://pokeapi.co/api/v2/pokemon?limit=20) e exiba em um GridView
com 2 colunas. Cada card deve mostrar o nome do pokémon e sua imagem
sprite (URL: https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/{id}.png).
```

**Consulta de CEP:**
```
Crie uma tela com um TextField para digitar um CEP e um botão "Buscar".
Ao clicar, faça GET em https://viacep.com.br/ws/{cep}/json/ e exiba
os dados do endereço (logradouro, bairro, cidade, estado) em um Card
abaixo. Trate CEP inválido e erro de conexão.
```

---

### 🧭 Navegação entre Telas

```
Adicione um BottomNavigationBar ao app com 2 abas: "Dashboard" e "Usuários".
Cada aba deve exibir a tela correspondente. Use um IndexedStack para manter
o estado das telas ao alternar.
```

```
Adicione um Drawer lateral ao app com links para todas as telas.
Cada item do drawer deve navegar para a tela correspondente usando
Navigator.push.
```

---

### 🎨 Estilização e Layout

**Cards estilizados:**
```
Refatore os cards da lista de usuários: adicione um CircleAvatar com a
inicial do nome à esquerda, sombra no card (elevation: 4), e um ícone
de seta à direita indicando que é clicável.
```

**Tema personalizado:**
```
Atualize o ThemeData do app para usar um ColorScheme baseado na cor
#7C4DFF (deepPurple) com Material Design 3. Defina estilos padrão
para Card, AppBar e Text.
```

**Responsividade básica:**
```
Faça o dashboard usar um layout responsivo: em telas largas (>600px),
exiba os gráficos em um grid 2x2. Em telas estreitas, empilhe
verticalmente com scroll.
```

---

### 🔄 Refatoração e Melhoria

**Extrair widget:**
```
Extraia o card de usuário para um widget separado chamado UserCard
no arquivo lib/widgets/user_card.dart. Ele deve receber um User model
como parâmetro.
```

**Adicionar funcionalidade:**
```
Adicione pull-to-refresh na lista de usuários usando RefreshIndicator.
Ao puxar para baixo, deve recarregar os dados da API.
```

**Corrigir erro:**
```
Estou recebendo este erro: [COLAR O ERRO AQUI]
Corrija o código mantendo a mesma funcionalidade.
```

---

### 📝 Criar Models

```
Crie um model Dart para representar um usuário da API JSONPlaceholder
(/users). Inclua campos: id, name, email, phone, website e um objeto
Address com street, city e zipcode. Adicione factory constructor
fromJson e método toJson.
```

---

### 🧪 Pedir Explicação

```
Explique o que esse widget faz, linha por linha, como se eu fosse
um iniciante em Flutter. Foque nos conceitos de StatefulWidget,
setState, e ciclo de vida.
```

---

## 3. Padrões Avançados

### Prompt Encadeado (Gerar em etapas)

Ao invés de pedir tudo de uma vez, quebre em passos:

```
Passo 1: "Crie o model User em lib/models/user_model.dart
          com campos id, name e email"

Passo 2: "Crie o service em lib/services/user_service.dart
          que faz GET em jsonplaceholder.typicode.com/users
          e retorna List<User>"

Passo 3: "Crie a tela em lib/screens/users_screen.dart
          que usa o UserService para exibir os usuários
          em uma ListView com cards"
```

**Por que funciona**: Cada passo é simples, revisável, e constrói sobre o anterior.

### Referenciar Arquivos com `#file`

No Copilot Chat, você pode arrastar arquivos ou usar `#file`:

```
Usando os dados do #file:assets/dados_dashboard.json, crie um
gráfico de barras para a seção vendas_mensais.
```

```
Baseado no model #file:lib/models/user_model.dart, crie um
widget de card para exibir os dados do usuário.
```

**Por que funciona**: Dá à IA o contexto exato dos dados e estruturas que você já tem.

### Pedir Alternativas

```
Me mostre 3 formas diferentes de fazer o layout desta tela:
1. Com ListView
2. Com CustomScrollView + Slivers
3. Com SingleChildScrollView + Column
Explique prós e contras de cada uma.
```

---

## 4. Anti-padrões — O Que NÃO Fazer

### ❌ Prompt Vago Demais

```
Faz um app bonito
```
**Problema**: "Bonito" é subjetivo. Sem contexto, a IA inventa qualquer coisa.

### ❌ Pedir Tudo de Uma Vez

```
Crie um app completo de e-commerce com login, catálogo, carrinho,
pagamento, perfil, notificações push, tema dark/light, e testes
unitários para tudo.
```
**Problema**: Resultado enorme, impossível de revisar, cheio de erros.

### ❌ Aceitar Sem Revisar

Copilot gerou 200 linhas → Aceitar tudo → Não funciona → Frustração  
**Correto**: Ler cada seção, testar incrementalmente, pedir explicações.

### ❌ Não Dar Contexto

```
Adicione um gráfico
```
**Problema**: Qual tipo? Quais dados? Qual biblioteca? Onde na tela?

### ❌ Ignorar Erros

Se o código gerado der erro, **NÃO tente consertar manualmente sem entender**.  
**Correto**: Cole o erro no Copilot Chat e peça para corrigir:
```
O código gerou este erro: [ERRO]. Corrija mantendo a mesma funcionalidade.
```

---

## 5. Checklist do Aluno

Antes de aceitar código gerado pela IA, verifique:

- [ ] **Funciona?** — Executou sem erros?
- [ ] **Entendo?** — Consigo explicar o que cada parte faz?
- [ ] **Está seguro?** — Não expõe dados sensíveis, não tem SQL injection, etc?
- [ ] **Segue o padrão?** — Usa os mesmos patterns do resto do projeto?
- [ ] **É necessário?** — Não adicionou coisas que não pedi?
- [ ] **Tem tratamento de erro?** — Loading, fallbacks, mensagens úteis?

---

## Referência Rápida — Atalhos do Copilot no VS Code

| Ação | Mac | Windows/Linux |
|------|-----|---------------|
| Abrir Copilot Chat | `Cmd+Shift+I` | `Ctrl+Shift+I` |
| Inline Chat | `Cmd+I` | `Ctrl+I` |
| Aceitar sugestão inline | `Tab` | `Tab` |
| Rejeitar sugestão inline | `Esc` | `Esc` |
| Próxima sugestão | `Option+]` | `Alt+]` |
| Sugestão anterior | `Option+[` | `Alt+[` |
