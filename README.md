# Multifilme - Aplicativo de Listagem e Detalhes de Filmes

## Sobre o Projeto
O **Multifilme** é um aplicativo mobile desenvolvido em **Flutter** que permite aos usuários explorar uma vasta lista de filmes populares, em cartaz e futuros lançamentos. O app se integra com a API do **[The Movie Database (TMDb)](https://developer.themoviedb.org/docs/getting-started)** para exibir detalhes dos filmes, trailers e avaliações.

### **Principais Funcionalidades**
- Lista de filmes populares, nos cinemas e lançamentos futuros
- Exibição dos melhores avaliados em um carrossel
- Tela de detalhes do filme com trailer e informações
- Suporte a múltiplos idiomas (Inglês e Português)
- Imagem de fundo personalizada
- Interface moderna com animações e UX aprimorada
- Gerenciamento de estado com Bloc
- Testes unitários e de widgets
- Workflow CI/CD para rodar testes automaticamente nos PRs

---

## Tecnologias Utilizadas
O projeto foi desenvolvido utilizando as seguintes tecnologias e padrões:

### **Frontend**
- Flutter 3.10+
- Dart
- Bloc (Gerenciamento de Estado)
- Retrofit + Dio (Consumo de API)
- YouTube Player (Reprodução de Trailers)
- Provider (Internacionalização)
- Carousel Slider
- UI/UX aprimorada com animações

### **Backend**
- The Movie Database API (TMDb) - **[Documentação Oficial](https://developer.themoviedb.org/docs/getting-started)**

### **DevOps**
- GitHub Actions (CI/CD) - Execução automática de testes unitários e de widget em cada Pull Request.

---

## Instalação e Configuração

### **1. Clonar o repositório**

git clone https://github.com/seu-usuario/multifilme.git
cd multifilme

### **2. Configurar as Dependências**
Antes de rodar o app, instale todas as dependências do projeto executando o comando abaixo:  

flutter pub get

### **3. Configurar a API TMDb.

Este aplicativo consome a API do [The Movie Database (TMDb)](https://www.themoviedb.org/). Para que ele funcione corretamente, siga os passos abaixo:

1. **Crie uma conta no TMDb**  
   Acesse o site [TMDb](https://www.themoviedb.org/) e crie uma conta, caso ainda não tenha uma.

2. **Obtenha sua Chave da API**
    - Após fazer login, vá até as configurações da conta.
    - Acesse a aba **API** e gere uma **Chave da API (v3 auth)**.

### Carregar variáveis de ambiente

Para garantir que o app carregue corretamente a **Chave da API** armazenada no arquivo `.env`, siga os passos abaixo:

1. **Instale o pacote `flutter_dotenv`** (caso ainda não tenha instalado):

   flutter pub add flutter_dotenv


### Testes Automatizados

Este projeto possui **testes automatizados** para garantir a qualidade e estabilidade do código. Os testes incluem:

- **Testes Unitários** → Validam o comportamento das classes e métodos individuais.
- **Testes de Widget**  → Garantem que os componentes da UI funcionem corretamente.
- **Testes de Integração** → Verificam o fluxo completo da aplicação.

#### Como executar os testes

Para rodar todos os testes, utilize o seguinte comando no terminal:

flutter test


###  Rodar Testes no CI/CD

Ao abrir um **Pull Request**, o **GitHub Actions** executará automaticamente os testes para garantir que nenhuma alteração quebre o funcionamento do aplicativo. 🚀  

   

