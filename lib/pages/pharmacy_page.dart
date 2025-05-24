import 'package:flutter/material.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  final List<Map<String, dynamic>> produtos = const [
    {
      'nome': 'Paracetamol 500mg',
      'preco': 9.99,
      'imagem': 'assets/images/paracetamol500.webp',
      'categoria': 'Analgésicos',
    },
    {
      'nome': 'Dipirona 1g',
      'preco': 7.50,
      'imagem': 'assets/images/dipirone1g.webp',
      'categoria': 'Analgésicos',
    },
    {
      'nome': 'Vitamina D 1g',
      'preco': 12.00,
      'imagem': 'assets/images/vitaminad.webp',
      'categoria': 'Suplementos',
    },
    {
      'nome': 'Álcool em Gel 500ml',
      'preco': 15.00,
      'imagem': 'assets/images/alcoolgel500ml.webp',
      'categoria': 'Higiene',
    },
    {
      'nome': 'Termômetro Digital',
      'preco': 25.00,
      'imagem': 'assets/images/termometro.webp',
      'categoria': 'Equipamentos',
    },
    {
      'nome': 'Máscara Cirúrgica (50 un.)',
      'preco': 30.00,
      'imagem': 'assets/images/mascara.webp',
      'categoria': 'Higiene',
    },
  ];

  String selectedCategory = 'Todos';
  String searchQuery = '';

  List<Map<String, dynamic>> get filteredProdutos {
    return produtos.where((produto) {
      final matchesCategory = selectedCategory == 'Todos' || produto['categoria'] == selectedCategory;
      final matchesSearch = produto['nome'].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['Todos', ...produtos.map((p) => p['categoria']).toSet().toList()];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farmácia Online',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Carrinho ainda não implementado')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar produtos...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Category Filter
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      }
                    },
                    selectedColor: Colors.blue[600],
                    labelStyle: TextStyle(
                      color: selectedCategory == category ? Colors.white : Colors.black87,
                    ),
                    backgroundColor: Colors.grey[200],
                  ),
                );
              }).toList(),
            ),
          ),
          // Product Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: filteredProdutos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final produto = filteredProdutos[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Future: Navigate to product details
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Detalhes de ${produto['nome']}')),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.asset(
                                produto['imagem'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image_not_supported, size: 50),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  produto['nome'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  produto['categoria'],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'R\$ ${produto['preco'].toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${produto['nome']} adicionado ao carrinho')),
                                    );
                                  },
                                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                                  label: const Text('Adicionar'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: Colors.blue[600],
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}