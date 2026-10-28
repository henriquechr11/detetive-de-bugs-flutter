# LAUDO — Operação Resgate: Detetives de Bugs

Projeto: central_achados | 12 bugs + 3 correções extras

---

### Bug 01 | lib/pages/central_page.dart:81
- **Sintoma:** app não compilava (erro de string).
- **Causa:** quebra de linha real dentro de `'...'`.
- **Correção:** trocado por `\n`.
- **Teste:** analyze sem erro; card exibe duas linhas.

### Bug 02 | lib/pages/central_page.dart:86
- **Sintoma:** erro de compilação ao abrir detalhe.
- **Causa:** `DetalhePage()` sem o parâmetro obrigatório `ocorrencia`.
- **Correção:** `DetalhePage(ocorrencia: o)`.
- **Teste:** tocar no card abre a ocorrência certa.

### Bug 03 | lib/models/ocorrencia.dart:21
- **Sintoma:** responsável errado; autorização de status falhava.
- **Causa:** `autorId` lia o campo `autorNome`.
- **Correção:** `autorId: d['autorId']`.
- **Teste:** dono consegue alterar o próprio status.

### Bug 04 | lib/models/ocorrencia.dart:22
- **Sintoma:** resolvidos apareciam como abertos (e vice-versa).
- **Causa:** valor `resolvido` era negado com `!`.
- **Correção:** removida a negação.
- **Teste:** rótulo bate com o estado gravado.

### Bug 05 | lib/pages/central_page.dart:26
- **Sintoma:** cadastrava sem título e/ou local.
- **Causa:** validação usava `&&` em vez de `||`.
- **Correção:** `isEmpty || isEmpty`.
- **Teste:** enviar incompleto mostra "Informe título e local".

### Bug 06 | lib/pages/central_page.dart:68
- **Sintoma:** switch "Somente não resolvidos" não funcionava.
- **Causa:** `somenteAbertos = !value` (invertido).
- **Correção:** `somenteAbertos = value`.
- **Teste:** ligar/desligar corresponde ao filtro.

### Bug 07 | lib/pages/central_page.dart:75
- **Sintoma:** filtro mostrava os resolvidos em vez dos abertos.
- **Causa:** `where((o) => o.resolvido)`.
- **Correção:** `where((o) => !o.resolvido)`.
- **Teste:** com filtro ativo, só aparecem não resolvidos.

### Bug 08 | lib/pages/detalhe_page.dart:21
- **Sintoma:** pista só "enviava" com campo vazio.
- **Causa:** guarda invertida `isNotEmpty`.
- **Correção:** `isEmpty`.
- **Teste:** texto no campo grava; vazio ignora.

### Bug 09 | lib/pages/detalhe_page.dart:23
- **Sintoma:** pista gravada era sempre vazia.
- **Causa:** enviava `''` em vez do texto digitado.
- **Correção:** `enviarPista(id, pista.text)`.
- **Teste:** mensagem completa aparece na ocorrência.

### Bug 10 | lib/services/central_service.dart:17
- **Sintoma:** só o "dono" errado alterava status; regra inútil.
- **Causa:** `autorId` gravava o e-mail, mas a checagem usa `uid`.
- **Correção:** `'autorId': u.uid`.
- **Teste:** Conta B é bloqueada; Conta A (dona) altera.

### Bug 11 | lib/services/central_service.dart:25
- **Sintoma:** "Marcar como resolvido" não mudava o status.
- **Causa:** `update` gravava o mesmo valor (`item.resolvido`).
- **Correção:** `!item.resolvido`.
- **Teste:** um clique alterna entre resolvido/aberto.

### Bug 12 | lib/services/central_service.dart:30
- **Sintoma:** pistas de ocorrências diferentes iam para o mesmo lugar.
- **Causa:** usava `doc('pistas')` fixo em vez do id recebido.
- **Correção:** `doc(ocorrenciaId)`.
- **Teste:** pista da Conta B aparece só na ocorrência certa.

---

## Extras

### Bug 13 | test/widget_test.dart
- **Causa:** importava `package:bugsresolver` e `MyApp` (não existem).
- **Correção:** reescrito com `central_achados` e `CentralApp`.

### Bug 14 | lib/services/central_service.dart:9
- **Causa:** lista em ordem crescente (mais antigo no topo).
- **Correção:** `descending: true` (mais recentes primeiro). Pistas mantêm ordem cronológica.

### Apoio | pubspec.yaml
- Incluídos `dev_dependencies`: `flutter_test` e `flutter_lints` (já no lock/analyzer, faltavam no yaml).

### Apoio | arquivos Firebase da aula
- Criados `firestore.rules` (leitura exige login; só o dono altera/apaga; pistas seguem o autor) e `.firebaserc` (projeto `escola-5f0b4`); `firebase.json` aponta para as regras. Deploy: `firebase deploy --only firestore:rules`.

---

**Nada foi apagado.** Login Google e regras de segurança intactos.
Teste multiusuário: duas janelas anônimas no Chrome, contas A e B (roteiro no fim do enunciado).
