
<div align=center>

# Projeto Streaming

Esse é um projeto de banco de dados visando criar uma estrutura de dados para armazenar informações de serviço de conteúdos multimídia e demonstrar o conteúdo aprendido no curso de **DBA**. O projeto foi desenvolvido utilizando o sistema de gerenciamento MySQL para garantir a eficácia e confiabilidade na gestão dos dados.


## Modelo Conceitual
![Modelo conceitual](./4_img/conceitual.png)
</div>

<div align=center>

## Modelo Logico
![Modelo conceitual](./4_img/fisico.png)
</div>

<div align=center>

## Tabelas
</div>




- Tabela `país`:

    | id_pais | nome   | codigo |
    |---------|--------|--------|
    | 1       | Brasil | BR     |
    | 2       | EUA    | US     |
    | ...     | ...    | ...    |

- Tabela `classificacao`:

    | id_classificacao | idade | descricao |
    |------------------|-------|-----------|
    | 1                | 18    | Adulto    |
    | 2                | 8     | Infantil  |
    | ...              | ...   | ...       |

- Tabela `ator`:

    | id_ator | nome   | sobrenome | nascimento | foto |
    |---------|--------|-----------|------------|------|
    | 1       | João   | Silva     | 1980-01-01 | ...  |
    | 2       | Maria  | Santos    | 1995-05-10 | ...  |
    | ...     | ...    | ...       | ...        | ...  |

- Tabela `idioma`:

    | id_idioma | nome      |
    |-----------|-----------|
    | 1         | Português |
    | 2         | Inglês    |
    | ...       | ...       |

- Tabela `categoria`:

    | id_categoria | nome      |
    |--------------|-----------|
    | 1            | Ação      |
    | 2            | Comédia   |
    | ...          | ...       |

- Tabela `catalogo`:

    | id_catalogo | titulo     | sinopse | ano_lancamento | duracao | avaliacao | idioma_original | id_classificacao |
    |-------------|------------|---------|----------------|---------|-----------|-----------------|------------------|
    | 1           | Filme A    | ...     | 2022           | 02:30   | 4         | 1               | 1                |
    | 2           | Série B    | ...     | 2021           | 00:45   | 3         | 2               | 2                |
    | ...         | ...        | ...     | ...            | ...     | ...       | ...             | ...              |

- Tabela `pais_catalogo`:

    | id_pais | id_catalogo |
    |---------|-------------|
    | 1       | 1           |
    | 1       | 2           |
    | ...     | ...         |

- Tabela `idioma_catalogo`:

    | id_idioma | id_catalogo |
    |-----------|-------------|
    | 1         | 1           |
    | 2         | 2           |
    | ...       | ...         |

- Tabela `ator_catalogo`:

    | id_ator | id_catalogo |
    |---------|-------------|
    | 1       | 1           |
    | 2       | 1           |
    | ...     | ...         |

- Tabela `categoria_catalogo`:

    | id_categoria | id_catalogo |
    |--------------|-------------|
    | 1            | 1           |
    | 2            | 1           |
    | ...          | ...         |

- Tabela `filme`:

    | id_filme | osca | id_catalogo |
    |----------|------|-------------|
    | 1        | null | 1           |
    | 2        | null | 2           |
    | ...


- Tabela `serie`:

    | id_serie | id_catalogo |
    |----------|-------------|
    | 1        | 2           |
    | 2        | 3           |
    | ...      | ...         |

- Tabela `temporada`:

    | id_temporada | titulo | descricao | id_serie |
    |--------------|--------|-----------|----------|
    | 1            | Temporada 1 | ... | 1        |
    | 2            | Temporada 2 | ... | 1        |
    | ...          | ...    | ...       | ...      |

- Tabela `episodio`:

    | id_episodio | nome | duracao | id_temporada | id_serie |
    |-------------|------|---------|--------------|----------|
    | 1           | Episódio 1 | 00:30 | 1            | 1        |
    | 2           | Episódio 2 | 00:30 | 1            | 1        |
    | ...         | ...  | ...     | ...          | ...      |

- Tabela `endereco`:

    | id_endereco | numero | endereco | cep      | cidade  | id_pais |
    |-------------|--------|----------|----------|---------|---------|
    | 1           | 123    | Rua A    | 12345678 | CidadeA | 1       |
    | 2           | 456    | Rua B    | 87654321 | CidadeB | 2       |
    | ...         | ...    | ...      | ...      | ...     | ...     |

- Tabela `pessoa`:

    | id_pessoa | nome  | sobrenome | senha | email                 | status | avaliacao | dt_nascimento | dt_cadastro | id_endereco |
    |-----------|-------|-----------|-------|-----------------------|--------|-----------|---------------|-------------|-------------|
    | 1         | João  | Silva     | ...   | joao.silva@example.com | ...    | 4         | 1980-01-01    | ...         | 1           |
    | 2         | Maria | Santos    | ...   | maria.santos@example.com | ...  | 3         | 1995-05-10    | ...         | 2           |
    | ...       | ...   | ...       | ...   | ...                   | ...    | ...       | ...           | ...         | ...         |

- Tabela `funcionario`:

    | id_funcionario | foto | id_pessoa |
    |----------------|------|-----------|
    | 1              | ...  | 1         |
    | 2              | ...  | 2         |
    | ...            | ...  | ...       |

- Tabela `plano`:

    | id_plano | valor | descricao |
    |----------|-------|-----------|
    | 1        | 9.99  | Bronze    |
    | 2        | 14.99 | Prata     |
    | ...      | ...   | ...       |

- Tabela `cartao_credito`:

    | id_cartao | numero         | dt_vencimento | cod_seguranca | titulo |
    |-----------|----------------|---------------|---------------|--------|
    | 1         | 1111222233334444 | 2025-01-01    | 123           | Mastercard |
    | 2         | 5555666677778888 | 2024-03-01    | 456           | Visa       |
    | ...       | ...            | ...           | ...           | ...    |


- Tabela `tipo_pagamento`:

    | id_tipo_pagamento | nome          |
    |-------------------|---------------|
    | 1                 | Cartão de Crédito |
    | 2                 | Transferência Bancária |
    | ...               | ...           |

- Tabela `cliente`:

    | id_cliente | nickname | dt_vencimento | id_plano | id_pessoa |
    |------------|----------|---------------|----------|-----------|
    | 1          | user1    | 2023-01-01    | 1        | 1         |
    | 2          | user2    | 2024-02-01    | 2        | 2         |
    | ...        | ...      | ...           | ...      | ...       |

- Tabela `pagamento`:

    | id_pagamento | valor | dt_pagamento | forma_pagamento | id_cliente | id_cartao | id_tipo_pagamento |
    |--------------|-------|--------------|-----------------|------------|-----------|------------------|
    | 1            | 9.99  | 2022-01-01   | Cartão de Crédito | 1          | 1         | 1                |
    | 2            | 14.99 | 2023-02-01   | Cartão de Crédito | 2          | 2         | 1                |
    | ...          | ...   | ...          | ...             | ...        | ...       | ...              |


- Tabela `perfil`:

    | id_perfil | foto | nome | tipo            | id_cliente |
    |-----------|------|------|-----------------|------------|
    | 1         | ...  | John | perfil adulto   | 1          |
    | 2         | ...  | Jane | perfil infantil | 2          |
    | ...       | ...  | ...  | ...             | ...        |




<div align=center>

## Views
</div>

- **vw_usuario:** 
 Apresenta informações sobre os usuários do sistema, incluindo funcionários e clientes. Inclui dados como nome, tipo de usuário, data de nascimento, endereço e detalhes do plano.

- **vw_catalogo:** Exibe detalhes sobre os itens do catálogo, identificando se são filmes ou séries. Inclui informações como título, sinopse, ano de lançamento, duração e idiomas disponíveis.

- **vw_episodio:** Mostra os episódios das séries, juntamente com sua duração, título da temporada e título da série correspondente.

- **vw_temporada:** Apresenta informações sobre as temporadas das séries, incluindo título, descrição e quantidade de episódios. Também exibe o título da série associada.

- **vw_ator:** Exibe os atores envolvidos nos catálogos, juntamente com a quantidade de filmes e séries em que atuaram.

- **vw_pagamento:** Mostra os dados dos pagamentos realizados pelos clientes, incluindo nome do cliente, status do pagamento, descrição do plano, valor, tipo de pagamento e data de pagamento.

- **vw_perfil:** Apresenta informações sobre os perfis dos clientes, incluindo o número total de perfis e os tipos de perfil associados a cada cliente.









<div align=center>

## Funções
</div>

- **Function1:** Esta função daz isso e quilo outro ...
- **Function2:** Esta função daz isso e quilo outro ...
- **Function3:** Esta função daz isso e quilo outro ...
- **Function4:** Esta função daz isso e quilo outro ...
- **Function5:** Esta função daz isso e quilo outro ...

<div align=center>

## Procedures
</div>

- **Procedures1:** Esta procedures daz isso e quilo outro ...
- **Procedures2:** Esta procedures daz isso e quilo outro ...
- **Procedures3:** Esta procedures daz isso e quilo outro ...
- **Procedures4:** Esta procedures daz isso e quilo outro ...
- **Procedures5:** Esta procedures daz isso e quilo outro ...

<div align=center>

## Triggers
</div>

- **Trigger1:** Esta procedures daz isso e quilo outro ...
- **Trigger2:** Esta procedures daz isso e quilo outro ...
- **Trigger3:** Esta procedures daz isso e quilo outro ...
- **Trigger4:** Esta procedures daz isso e quilo outro ...
- **Trigger5:** Esta procedures daz isso e quilo outro ...


<div align=center>

## Scripts
</div>

|Scripts    |Clique aqui|
|-----------|-----------|
|DDL        |[Clique aqui](https://seulinkaqui.com)|
|Dados      |[Clique aqui](https://seulinkaqui.com)|
|Views      |[Clique aqui](https://seulinkaqui.com)|
|Funções    |[Clique aqui](https://seulinkaqui.com)|
|Procedures |[Clique aqui](https://seulinkaqui.com)|
|Triggers   |[Clique aqui](https://seulinkaqui.com)|
|Dumps      |[Clique aqui](https://seulinkaqui.com)|

<div align=center>

## Contatos

|  [![Linkedin](/img/icons8-linkedin-48.png)](https://seulinkaqui.com)| [![Instagram](/img/icons8-instagram-48.png)](https://seulinkaqui.com) |[![Email](/img/icons8-email-48.png)](https://seulinkaqui.com) | [![Portfolio](/img/icons8-portf%C3%B3lio-48.png)](https://seulinkaqui.com) |
|-----------|-----------|-----------|-----------|-----------|

</div>