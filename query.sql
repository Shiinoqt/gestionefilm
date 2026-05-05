-- 1. Selezionare il nome di tutte le sale situate nella città di Pisa.
select nome
from sala s
where s.citta = "Pisa";

-- 2. Selezionare il titolo dei film diretti dal regista F. Fellini prodotti dopo il 1960.
select titolo
from film f
where f.regista = "F. Fellini" and anno_produzione > 1960;

-- 3. Selezionare il titolo e la durata dei film di genere 'Fantascienza' di nazionalità giapponese o francese prodotti dopo il 1990.
select titolo, durata
from film f
where f.genere = "Fantascienza" and (f.nazionalita = "Giappone" or f.nazionalita = "Francia") and anno_produzione > 1990;

-- 4. Selezionare il titolo dei film di fantascienza giapponesi prodotti dopo il 1990 oppure di tutti i film francesi.
select titolo
from film f 
where (f.nazionalita = "Giappone" and anno_produzione > 1990) or f.nazionalita = "Francia";

-- 5. Selezionare il titolo dei film diretti dallo stesso regista del film “Casablanca”.
select titolo 
from film 
where regista = (
    select regista 
    from film 
    where titolo = 'Casablanca'
);

-- 6. Selezionare il titolo ed il genere dei film che sono stati proiettati il giorno di Natale (25/12) del 2004.
select f.titolo, f.genere
from film f 
join proiezione p on p.id_film = f.id_film
where p.data_proiezione = "2004-12-25";

-- 7. Selezionare il titolo ed il genere dei film proiettati a Napoli il giorno di Natale 2004.
select f.titolo, f.genere
from film f 
join proiezione p on p.id_film = f.id_film
join sala s on s.id_sala = p.id_sala
where p.data_proiezione = "2004-12-25" and s.citta = "Napoli";

-- 8. Selezionare i nomi delle sale di Napoli in cui il giorno di Natale 2004 è stato proiettato un film con l'attore R. Williams.
select distinct s.nome
from sala s
join proiezione p on p.id_sala = s.id_sala
join attore_film af on p.id_film = af.id_film
join attore a on af.id_attore = a.id_attore
where p.data_proiezione = "2004-12-25" and s.citta = "Napoli" and a.nome = "Robin Williams";

-- 9. Selezionare il titolo dei film in cui recita l'attore M. Mastroianni oppure l'attrice S. Loren.
select distinct f.titolo
from film f 
join attore_film af on f.id_film = af.id_film
join attore a on af.id_attore = a.id_attore
where a.nome = "Marcello Mastroianni" or a.nome = "Sophia Loren";

-- 10. Selezionare il titolo dei film in cui recitano contemporaneamente M. Mastroianni e S. Loren.
select f.titolo
from film f 
join attore_film af on f.id_film = af.id_film -- Join della prima tabella per M. Mastroianni
join attore a on af.id_attore = a.id_attore 
join attore_film af2 on f.id_film = af2.id_film -- Join della seconda tabella per S. Loren 
join attore a2 on af2.id_attore = a2.id_attore 
where a.nome = "Marcello Mastroianni" and a2.nome = "Sophia Loren"; -- Check condizione 

-- 11. Per ogni film in cui recita un attore di nazionalità francese, mostrare il titolo del film e il nome dell’attore.
select f.titolo, a.nome as nome_attore
from film f 
join attore_film af on f.id_film = af.id_film
join attore a on af.id_attore = a.id_attore
where a.nazionalita = "Francia";

-- 12. Per ogni film proiettato a Pisa nel gennaio 2005, mostrare il titolo del film e il nome della sala.
select f.titolo, s.nome
from film f 
join proiezione p on f.id_film = p.id_film
join sala s on p.id_sala = s.id_sala
where p.data_proiezione between "2005-01-01" and "2005-01-31" and s.citta = "Pisa";

-- 13. Contare il numero di sale di Pisa che hanno una capienza superiore a 60 posti.
select count(*) as numero_sale
from sala
where citta = "Pisa" and posti > 60;

-- 14. Calcolare il numero totale di posti disponibili in tutte le sale di Pisa.
select sum(posti) as posti_totali_pisa
from sala 
where citta = "Pisa";

-- 15. Per ogni città presente nel database, contare il numero di sale disponibili.
select citta, count(*) as sale_disponibili
from sala
group by citta;

-- 16. Per ogni città, contare il numero di sale che hanno più di 60 posti.
select citta, count(*) as numero_sale
from sala
where posti > 60
group by citta; 

-- 17. Per ogni regista, contare il numero di film diretti dopo l'anno 1990.
select regista, count(*) as numero_film
from film
where anno_produzione > 1990
group by regista;

-- 18. Per ogni regista, calcolare l’incasso totale derivante da tutte le proiezioni dei suoi film.
select f.regista, sum(p.incasso) as incasso_totale
from film f 
join proiezione p on f.id_film = p.id_film
group by f.regista;

-- 19. Per ogni film di S. Spielberg, mostrare il titolo, il numero totale di proiezioni effettuate a Pisa e l’incasso totale.
select f.titolo, count(*) as totale_proiezioni, sum(p.incasso) as incasso_totale
from film f 
join proiezione p on f.id_film = p.id_film
join sala s = on p.id_sala = s.id_sala
where f.regista = "S. Spielberg" and s.citta = "Pisa"
group by f.titolo;

-- 20. Per ogni coppia regista-attore, contare il numero di film del regista in cui compare quell'attore.
select f.regista, a.nome, count(*) as comparizioni
from film f
join attore_film af on f.id_film = af.id_film
join attore a on af.id_attore = a.id_attore
group by f.regista, a.nome;

-- 21. Selezionare il regista ed il titolo dei film che hanno nel cast meno di 6 attori registrati.
select f.regista, f.titolo
from film f 
join attore_film af on f.id_film = af.id_film
group by f.id_film -- per id_film (casi diversi film stesso nome)
having count(af.id_attore) < 6;

-- 22. Per ogni film prodotto dopo il 2000, mostrare il codice (ID), il titolo e l’incasso totale di tutte le sue proiezioni.
select f.id_film, f.titolo, sum(p.incasso) as incasso_totale
from film f 
join proiezione p on f.id_film = p.id_film
where f.anno_produzione > 2000
group by f.id_film;

-- 23. Contare il numero di attori che hanno recitato in film dove compaiono esclusivamente attori nati prima del 1970. ???
select count(distinct af.id_attore) as numero_attori  -- non includo duplicati degli attori (casi appare stesso attore in piu film)
from attore a 
join attore_film af on a.id_attore = af.id_attore
    -- filtro out film in cui attore nascita >= 1970
where af.id_film not in (   
    select id_film
    from attore a2
    join attore_film af2 on a2.id_attore = af2.id_attore
    where a2.anno_nascita >= 1970
);

-- 24. Per ogni film di fantascienza, mostrare il titolo e l’incasso totale di tutte le sue proiezioni.
select f.titolo, sum(p.incasso) as totale_incasso
from film f
join proiezione p on f.id_film = p.id_film
where f.genere = "Fantascienza"
group by f.id_film; 

-- 25. Per ogni film di fantascienza, mostrare il titolo e l’incasso totale delle sole proiezioni avvenute dopo il 01/01/2001.
select f.titolo, sum(p.incasso) as totale_incasso
from film f
join proiezione p on f.id_film = p.id_film
where f.genere = "Fantascienza" and p.data_proiezione > "2001-01-01"
group by f.id_film; 

-- 26. Per ogni film di fantascienza che NON è mai stato proiettato prima del 01/01/2001, mostrare il titolo e l’incasso totale. ???
select f.titolo, sum(p.incasso) as totale_incasso
from film f
join proiezione p on f.id_film = p.id_film
where f.genere = "Fantascienza" 
-- escludo id_film proiettati prima del 01-01-2001
and f.id_film not in (
    select id_film 
    from proiezione
    where data_proiezione < "2001-01-01"
    )
group by f.id_film; 

-- 27. Per ogni sala di Pisa che nel mese di gennaio 2005 ha incassato complessivamente più di 20.000 €, mostrare il nome e l’incasso totale del mese.
select s.nome, sum(p.incasso) incasso_mese
from sala s
join proiezione p on s.id_sala = p.id_sala
where p.data_proiezione between "2005-01-01" and "2005-01-31" -- proiezioni del mese di gennaio
group by s.id_sala  
having sum(p.incasso) > 20000; -- clausola di incasso > 20000

-- 28. Selezionare i titoli dei film che non sono mai stati proiettati nella città di Pisa.
select titolo
from film
where id_film not in (
    select p.id_film
    from proiezione p 
    join sala s on p.id_sala = s.id_sala
    where s.citta = "Pisa"
);

-- 29. Selezionare i titoli dei film che sono stati proiettati esclusivamente a Pisa (e in nessun'altra città). ???
select f.titolo
from film f 
join proiezione p on f.id_film = p.id_film
join sala s on p.id_sala = s.id_sala
where s.citta = "Pisa"
group by f.id_film
having count(distinct s.citta) = 1;
