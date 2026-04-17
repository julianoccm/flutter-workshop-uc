# Instruções do Projeto — Workshop Flutter com IA

## Comportamento Obrigatório

**ANTES de gerar qualquer código**, SEMPRE pergunte ao usuário:

1. **Qual app/tela deseja construir?** (ex: dashboard, listagem, formulário, perfil, etc.)
2. **Quais dados vai exibir?** (ex: dados locais do JSON, dados de uma API, dados estáticos)
3. **Tem alguma preferência visual?** (ex: cores, layout em cards, tabs, etc.)

Só comece a gerar código DEPOIS de receber as respostas. Isso permite que cada execução produza um app diferente.

## Contexto do Projeto

- **Nome**: workshop_1
- **Tipo**: App Flutter para workshop educacional sobre IA generativa
- **Flutter SDK**: ^3.9.2
- **Público**: Alunos iniciantes em Flutter/Dart
- **Idioma dos comentários**: Português (BR)
- **Idioma do código** (variáveis, funções, classes): Inglês

### Dependências Disponíveis

| Pacote | Versão | Uso |
|--------|--------|-----|
| `fl_chart` | ^0.70.2 | Gráficos (BarChart, PieChart, LineChart) |
| `http` | ^1.2.0 | Requisições HTTP (GET, POST) |
| `flutter_lints` | ^5.0.0 | Regras de lint |

### Asset Disponível

Arquivo `assets/dados_dashboard.json` com três seções de dados:
- **vendas_mensais**: 6 meses de dados de vendas (Jan-Jun 2025)
- **categorias**: 5 categorias com percentual e cor hex (Eletrônicos, Roupas, Alimentos, Livros, Outros)
- **acessos**: 7 semanas de dados de acessos ao site

### APIs Públicas Sugeridas (para demos com HTTP)

- JSONPlaceholder: `https://jsonplaceholder.typicode.com/` (posts, users, todos, comments)
- PokeAPI: `https://pokeapi.co/api/v2/` (pokemon, abilities, types)
- Via CEP: `https://viacep.com.br/ws/{cep}/json/` (consulta de CEP brasileiro)

## Arquitetura e Organização

Manter tudo **simples** — este é um projeto didático para iniciantes.

### Estrutura de Pastas

```
lib/
├── main.dart              # Entry point com MaterialApp
├── models/                # Classes de modelo de dados
│   └── exemplo_model.dart
├── screens/               # Telas completas (Scaffold)
│   └── exemplo_screen.dart
├── widgets/               # Widgets reutilizáveis
│   └── exemplo_widget.dart
└── services/              # Lógica de dados (JSON local, HTTP)
    └── exemplo_service.dart
```

### Padrões Obrigatórios

- **Gerenciamento de estado**: Usar apenas `StatefulWidget` + `setState()` — NÃO usar BLoC, Riverpod, Provider, GetX ou qualquer outro gerenciador
- **Navegação**: `Navigator.push()` / `Navigator.pop()` simples — NÃO usar GoRouter ou Navigator 2.0
- **Tema**: Material Design 3 (`useMaterial3: true` no ThemeData)
- **Nomenclatura de arquivos**: `snake_case.dart`
- **Nomenclatura de classes**: `PascalCase`
- **Nomenclatura de variáveis/funções**: `camelCase`

### Padrões de Código

#### Carregar JSON Local
```dart
// Carregar dados do asset JSON
Future<Map<String, dynamic>> loadJsonData() async {
  final String jsonString = await rootBundle.loadString('assets/dados_dashboard.json');
  return json.decode(jsonString) as Map<String, dynamic>;
}
```

#### Requisição HTTP
```dart
// Buscar dados de uma API
Future<List<dynamic>> fetchData(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return json.decode(response.body) as List<dynamic>;
  } else {
    throw Exception('Erro ao carregar dados: ${response.statusCode}');
  }
}
```

#### Gráfico com fl_chart (BarChart)
```dart
BarChart(
  BarChartData(
    barGroups: dados.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value['valor'].toDouble(),
            color: Colors.deepPurple,
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList(),
  ),
)
```

## Estilo de Resposta

1. **Gerar código completo e funcional** — nunca usar "..." ou "// restante do código aqui"
2. **Comentar cada seção importante** em português do Brasil
3. **Explicar brevemente** o que cada widget/classe faz antes do bloco de código
4. **Um arquivo por vez** — indicar claramente o caminho do arquivo (ex: `lib/screens/home_screen.dart`)
5. **Incluir imports necessários** no topo de cada arquivo
6. **Se o main.dart não existir**, sempre criá-lo primeiro com MaterialApp configurado

## Restrições

- NÃO usar packages que não estejam no pubspec.yaml
- NÃO gerar código para plataformas nativas (Swift, Kotlin)
- NÃO adicionar funcionalidades além do que foi pedido
- NÃO criar testes unitários a menos que solicitado
- NÃO usar `late` desnecessariamente — preferir inicialização no `initState()`
- NÃO usar `dynamic` quando o tipo é conhecido
