SELECT *
FROM ordenamiento."PatrimonioLevantamiento"
WHERE "zona" = 'Santuario' AND "folio" != '148\P' AND "folio" != '27\P' AND "folio" != '760\P'
ORDER BY "folio"::int desc ;


SELECT *
FROM ordenamiento."PatrimonioLevantamiento"
WHERE "folio" = '148\P';

SELECT *
FROM ordenamiento."PatrimonioLevantamiento"
WHERE "folio" = '148\P';

SELECT *
FROM ordenamiento."PatrimonioLevantamiento"
WHERE "folio" not in (SELECT "folio" FROM ordenamiento."PatrimonioLevantamiento" WHERE "folio" ~ '^[0-9\.]+$');

select '12.41212' ~ '^[0-9\.]+$'