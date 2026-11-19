# Portal de treinamento Projeto Tododia — plano V1.0

## Decisão de implantação

Código solicitado para implantação pela TI na VM da equipe. Entrega portátil, sem inicialização, armazenamento, autenticação, banco de dados ou hospedagem gerenciados pelo Manus. Não acessar a VM, publicar, criar domínio ou alterar permissões. O pacote conterá fonte e arquivos estáticos prontos para servir, além dos vídeos e documentos locais.

## Escopo aprovado

Biblioteca interativa em português brasileiro: início, contexto do projeto, quatro módulos por função, consulta rápida, oito perguntas com respostas comentadas, biblioteca identificada por versão/data e espaço informativo para o aprofundamento posterior do Assistente. Não criar telas EWM/RF ou integração com estoque. Sem identificação de pessoas, armazenamento de resultados, progresso persistente ou certificação automática. O questionário é somente exercício na sessão atual.

## Implementação

HTML semântico, CSS responsivo e JavaScript nativo com módulos. Navegação por hash para funcionar na raiz ou em subdiretório, sem regras de SPA. Conteúdo editorial em JSON local; vídeo MP4 nativo com controles, poster, download e transcrição textual; imagens, fontes e documentos locais. Nenhuma dependência de execução CDN/API. A VM precisa somente de servidor de arquivos HTTP; Node 20+ é opcional para verificações e prévia local.

Estrutura: `site/index.html`; `site/assets/css` para identidade visual; `site/assets/js` para interface, roteador e helpers; `site/content/site.json` para conteúdo; `site/media` para vídeos e evidências; `site/documentos` para PDFs e pacote offline. `deploy/` guarda exemplos Nginx e Docker Compose opcionais. `docs/` guarda implantação, segurança e edição. `scripts/` e `tests/` guardam verificações sem dependências externas.

## Conteúdo e governança

Base dos quatro módulos T1/T1.1 aprovados, com Assistente revisado para Mesa do Abastecimento. Gatilho: última camada, aproximadamente oito caixas. Fluxo normal FAZER → requisição criada → EM ANDAMENTO → execução/retorno; sem saldo → ANÁLISE → solução → FAZER. Cores por coluna: até 16 verde, 17–32 amarelo, 33+ vermelho; não prioridade e não saldo de SKU. Drop → Mãe por transpaleteira de operador embarcado; Mãe → Filho por patinha manual, sem tráfego motorizado no Filho. Residual no topo do full, consumo primeiro. Perda/dano: Assistente, não duplicar; autorização de substituição Supervisor do Turno. Não inventar telas, campos impressos, capacidades ou mapa corrigido.

As páginas de documento mestre/POPs serão sínteses de consulta ao conteúdo aprovado, não novos documentos controlados com código, revisão ou assinatura inventados. Biblioteca incluirá guia T1.1, pacote offline e apresentação de aprovação R01 preservada como histórico; não distribuir o POP PDF antigo como vigente. Nomenclatura atual prevalece nos módulos e guia. Documentos formais controlados poderão ser adicionados pela equipe.

## Design

Reutilizar a marca Tododia fornecida e a paleta aprovada: laranja #EA580C, azul-grafite #0F172A e fundos claros/quentes. Estética editorial de manual de campo: navegação lateral discreta no desktop, topo compacto no celular, títulos grandes, capítulos sequenciais, rota ilustrada e evidências reais. Evitar aparência de dashboard com indicadores fictícios. Fonte Noto Sans local, preservando a substituição já adotada nos vídeos. A marca original não será redesenhada. Estados claros, contraste, foco visível, navegação por teclado, accordions nativos e redução de movimento. Textos curtos, diretos e operacionais.

## Segurança de entrega

Sem login fictício no cliente. Acesso restrito deve ser aplicado pela infraestrutura da TI, abrangendo vídeos, PDFs e JSON, não apenas a página. Exemplos escutam em loopback; Nginx de produção exige autenticação básica com arquivo de hashes criado pela equipe, ou integração corporativa equivalente. Healthcheck mínimo pode ser anônimo. HTTPS obrigatório quando credenciais trafegam; não incluir senhas, chaves, dados individuais ou arquivo real de usuários no pacote. Uso em rede corporativa/VPN ou proxy corporativo conforme política local.
