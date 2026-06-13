# Checklist — adicionar um novo dataset ao EAPADados

> Analogia: pôr um ingrediente novo na **despensa**, com **etiqueta**.
> A "área de preparo" é `data-raw/` (não vai no pacote); a "despensa" é `data/`;
> a "etiqueta" é `R/data_<nome>.R`.

## 1. Preparar (na área de preparo: `data-raw/`)
Abra `data-raw/preparar_dados.R` e acrescente um bloco como este:

```r
nome <- readxl::read_excel("data-raw/arquivo.xlsx", sheet = N) |>
  janitor::clean_names() |>
  dplyr::mutate(dplyr::across(where(is.character), as.factor))

usethis::use_data(nome, overwrite = TRUE)   # -> cria data/nome.rda
```

Rode esse bloco no R. (Se o dado for simulado, gere o `data.frame` e chame `use_data`.)

## 2. Documentar (a etiqueta: `R/`)
- Copie `data-raw/MOLDE_documentar_dataset.R`.
- Crie `R/data_nome.R`, cole o molde e preencha os `<...>`.
- **Confira:** os nomes em `\item{}` batem EXATAMENTE com as colunas da `.rda`.
- A **última linha** é o nome entre aspas — `"nome"` — **sem** `@export`.

## 3. Gerar (os dois gatilhos em R)
```r
devtools::document()   # cria man/nome.Rd e atualiza o NAMESPACE
```
`LazyData: true` já deixa o dado acessível por `data(nome)` / `EAPADados::nome`.

## 4. Conferir
```r
devtools::check()      # alvo: zero erro/warning (NOTE de non-ASCII é aceitável)
data(nome); summary(nome)   # bate com o esperado?
```

## 5. Versionar
```bash
git add -A && git commit -m "data: adiciona dataset nome" && git push
```

---

### Regras de ouro (evitam 90% dos erros)
1. Documentar **dado** termina em `"nome"` entre aspas, **sem `@export`**
   (isso é só para funções).
2. O `@format` tem que casar **exatamente** com as colunas da `.rda`
   — foi exatamente aí que o `artemia` escorregou (`taxa_crescimento` vs
   `taxa_crescimento_mg_dia`).
3. Dado **simulado/reconstruído**: declare no `@source` e cite a referência.
   Nunca apresente dado simulado como real.
