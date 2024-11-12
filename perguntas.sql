--1. Liste o nome de todos os esportes da casa de aposta;
SELECT DISTINCT nome_jogo FROM Esportes;


--2. Encontre o nome de todos os usuários que têm mais de 7000 reais em sua conta.
SELECT nome_usuário
FROM Usuário
WHERE banca > 7000;


--3. Qual foi o jogo mais recente de futebol que teve na BetDB?
SELECT nome_jogo, equipe1, equipe2, jogo_dia, jogo_mês, jogo_ano
FROM Esportes
WHERE nome_jogo = 'Futebol'
ORDER BY jogo_ano DESC, jogo_mês DESC, jogo_dia DESC
LIMIT 1;


--4. Liste todas as apostas feitas dentro do esporte 'futebol'.
SELECT A.id_aposta, A.id_usuário, A.odds_equipe1, A.odds_equipe2, A.odds_escolhida, A.valor_aposta, A.valor_retorno
FROM Aposta A
JOIN Esportes E ON A.id_esporte = E.id_esporte
WHERE E.nome_jogo = 'CS2';


--5. Qual é a média de lucro dos apostadores?
SELECT AVG(valor_retorno - valor_aposta) AS media_lucro
FROM Aposta;


--6. Liste todos os jogos de BlackJack da BetDB
SELECT id_cassino, valor_aposta, valor_retorno
FROM Cassino
WHERE nome_cassino = 'BlackJack';

--7. Qual é a maior aposta feita na BetDB?
SELECT id_aposta, id_usuário, id_esporte, valor_aposta, odds_equipe1, odds_equipe2, odds_escolhida, valor_retorno
FROM Aposta
WHERE valor_aposta = (SELECT MAX(valor_aposta) FROM Aposta);


--8. Qual é o método de depósito mais utilizado na BetDB?
SELECT
    CASE
        WHEN pix = TRUE THEN 'Pix'
        ELSE 'Banco'
    END AS metodo_deposito,
    COUNT(*) AS quantidade
FROM Depósito
GROUP BY metodo_deposito
ORDER BY quantidade DESC
LIMIT 1;


--9. Liste todos os usuários que utilizaram o PIX como um método de depósito de dinheiro.
SELECT DISTINCT U.nome_usuário
FROM Usuário U
JOIN Depósito D ON U.id_usuário = D.id_usuário
WHERE D.pix = TRUE;


--10. Qual foi o maior depósito da casa de apostas?
SELECT U.nome_usuário, D.id_pagamento, D.nome_banco, D.pix, D.número_cartão, D.CVV_cartão, D.quantidade
FROM Depósito D
JOIN Usuário U ON D.id_usuário = U.id_usuário
WHERE D.quantidade = (SELECT MAX(quantidade) FROM Depósito);

