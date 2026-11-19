# Projeto Tododia — portal de treinamento V1.0

Primeira versão portátil para implantação pela TI na VM da equipe. Conteúdo de treinamento **T1.1, atualizado em 15/11/2026**. Os quatro vídeos, imagens, fontes, documentos e textos estão incluídos no pacote; não há dependência de API, CDN ou serviço Manus em execução.

## O que está pronto

O portal reúne apresentação do projeto, trilhas de base comum/Mãe/Filho/Assistente, vídeos com controles e transcrição, consulta operacional, oito perguntas com respostas comentadas, biblioteca e sínteses do documento mestre/POPs. O aprofundamento do Assistente está sinalizado como capítulo posterior. O Assistente utiliza a nomenclatura Mesa do Abastecimento.

Os exercícios funcionam somente na memória da página: não existe identificação de participantes, armazenamento de notas, controle de conclusão, banco de dados, certificado ou integração EWM. Recarregar/fechar a página descarta as respostas. A reprodução do vídeo não representa capacitação formal.

## Entrega

| Pasta | Uso |
|---|---|
| `site/` | Site pronto para ser servido por HTTP, incluindo mídias e documentos |
| `site/content/site.json` | Conteúdo editorial, módulos, perguntas, POPs de consulta e biblioteca |
| `site/assets/` | Código JavaScript, CSS e fontes locais |
| `site/media/` | Vídeos, posters, marca e evidências reais |
| `site/documentos/` | Guia T1.1, pacote offline e apresentação R01 preservada como histórico |
| `deploy/` | Exemplos de implantação em Nginx ou Docker Compose |
| `scripts/` e `tests/` | Prévia, verificações e empacotamento sem dependências externas |
| `docs/` | Implantação, edição, segurança, licenças e manifesto de integridade |

**Não é necessário compilar nem instalar Node na VM para servir o portal.** Basta um servidor HTTP. Os arquivos já são a versão de execução. Node 20+ é opcional para prévia e testes; não há `npm install` nem dependências de pacote.

## Prévia local para a TI

Na pasta extraída:

```bash
npm run check
npm run preview
```

A prévia escuta em `http://127.0.0.1:8787`, somente na máquina em que foi iniciada. Ela é para desenvolvimento, não contém autenticação e não deve ser exposta na rede. Não abrir `site/index.html` por duplo clique: o navegador deve receber o conteúdo por HTTP para carregar o JSON.

Para outra porta local: `npm run preview -- --port 8790`.

## Implantação na VM

Para implantação restrita na infraestrutura corporativa, use [docs/IMPLANTACAO_VM.md](docs/IMPLANTACAO_VM.md). O caminho recomendado é copiar somente `site/` para o diretório servido pela VM e proteger esse diretório na infraestrutura corporativa. Os exemplos Nginx/Compose exigem um arquivo de hashes criado pela TI; o Nginx da VM escuta em loopback, enquanto o Compose publica a porta 8081 nas interfaces da máquina e encaminha para a porta 8080 do contêiner, permitindo acesso controlado na rede local sem conflitar com serviços já na porta 8080. Não há senha pronta no pacote.

O acesso restrito deve abranger **HTML, JavaScript, JSON, fontes, vídeos, imagens, PDFs, PPTX e ZIP**. Não proteger somente a página inicial. No exemplo básico, o healthcheck `/healthz` retorna apenas `ok` sem autenticação. HTTPS, proxy, VPN, firewall e método de autenticação definitivo precisam seguir a política Natura/TPC. O site não realiza autenticação no JavaScript.

## Execução na rede local (Windows)

Com Docker Desktop instalado e iniciado, crie `deploy/auth/tododia.htpasswd` conforme [docs/IMPLANTACAO_VM.md](docs/IMPLANTACAO_VM.md) e execute `INICIAR_PORTAL_REDE.bat`. O portal será servido na porta 8081 com autenticação; para acessá-lo de outro dispositivo, use `http://IP-DA-MAQUINA:8081/`. Libere TCP/8081 somente na rede privada e para dispositivos autorizados. Não exponha a porta diretamente à internet.

## Publicação no Netlify

O arquivo `netlify.toml` mantém a raiz do repositório como base, não exige etapa de compilação (o site já está pronto em HTML/CSS/JS) e publica a pasta `site/`, onde está o `index.html`. No painel do Netlify, mantenha o **Base directory** vazio (raiz do repositório); não mova o `index.html` nem configure `site/` como base. As rotas usam hash e não precisam de redirects de SPA.

Como em qualquer hospedagem estática, os arquivos publicados ficam acessíveis a quem tiver o endereço. Confirme que todo o conteúdo de `site/` pode ser divulgado ou habilite uma proteção de acesso apropriada antes de compartilhar o site.

## Publicação no Vercel

O projeto está configurado para o Vercel em `vercel.json`, sem alterar a estrutura de pastas:

- **Root Directory:** raiz do repositório (`./` ou campo vazio), onde estão `package.json`, `scripts/` e `tests/`. Não defina `site/` como Root Directory: os arquivos de verificação e testes ficam fora dessa pasta.
- **Framework Preset:** Other.
- **Build Command:** `npm run build`, que executa as verificações e os testes.
- **Output Directory:** `site`, que contém o `index.html` inicial e todos os recursos publicados.

O Vercel deve receber o repositório completo para executar o build e, em seguida, publicar somente `site/`. O `index.html` carrega a navegação e os módulos em `site/assets/js/`; as rotas usam hash (`#/...`), portanto não precisam de rewrites nem de páginas HTML separadas por módulo. A configuração também aplica cabeçalhos de segurança.

**Esta publicação é pública:** qualquer pessoa com o endereço poderá baixar HTML, JavaScript, JSON, vídeos e documentos. O `noindex` reduz indexação por mecanismos de busca, mas não restringe acesso. Publique somente se o responsável pelos materiais autorizou a divulgação de todo o conteúdo de `site/`. Para exigir login, configure proteção de acesso no projeto/domínio do Vercel antes de compartilhar o endereço, ou use a implantação restrita na VM acima; o portal não implementa autenticação.

## Atualização de conteúdo

Edite o JSON local e copie os novos arquivos para `site/media/` ou `site/documentos/`. Consulte [docs/EDICAO_CONTEUDO.md](docs/EDICAO_CONTEUDO.md). Mantenha versão, data e status do documento claros. As sínteses de POPs são apoio à consulta do conteúdo aprovado, não um novo documento controlado com código/assinatura inventados. A apresentação R01 é histórica; os módulos e guia T1.1 prevalecem quanto à nomenclatura atual.

```bash
npm run check
npm test
npm run package
```

O pacote gerado fica em `entregas/`. Credenciais, `.env`, `node_modules`, logs e arquivos reais de autenticação são excluídos.

## Navegação e disponibilidade

Rotas usam hash (`#/inicio`, `#/trilhas` etc.) e não exigem fallback de SPA. Servir a raiz do diretório `site/` é o formato testado. Em subdiretório, manter URL terminando com `/` ou `index.html` e preservar a árvore inteira; mídias e JSON usam caminhos relativos. Não é PWA e não guarda automaticamente o portal para funcionar sem servidor; o pacote de treinamento offline oferece os vídeos e o guia para uso local.

## Limites desta entrega

Não foi feita implantação/publicação no Vercel, criação de domínio ou integração com login corporativo. O Dockerfile/Compose são uma opção de implantação; a TI deve usar a imagem Nginx homologada e validar seu runtime. Documentos formais controlados e o mapa final poderão ser adicionados depois. Não foi presumida capacidade física de posições ou criada demonstração de telas RF.
# treinamento_kanban
