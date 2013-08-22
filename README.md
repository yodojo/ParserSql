ParserSql
=========

Problema trabalhando no yodojo s0302.


A ideia é criar um parser de sql que faça os filtros do sql de forma dinâmica em uma tabela de usuários.

o consulta principal é "SELECT * FROM user;"

O método pode receber ate 3 parâmetros "name", "email" ou "cpf"

Os parâmetros não são obrigatórios e podem ser informado os 3 ou nenhum deles, de modo que o parser criar os filtros com "WHERE" e "AND" utilizando cada um no momento necessário


