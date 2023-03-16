-- Active: 1678389334254@@127.0.0.1@3306@detaillant
-- -----------------------------------------------------------------------------
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- A) Requêtes assez simples ("faciles")
-- -----------------------------------------------------------------------------
-- *****************************************************************************
-- -----------------------------------------------------------------------------

-- A1) Retourner l'identifiant et le sku des produits qui ne sont pas en stock
SELECT prd_id, prd_sku 
from product
WHERE prd_stock = 0;

-- A2) Retourner le nom et sku des produits dont le stock > 50
SELECT pd.pdd_name, p.prd_sku
from product p
        inner join product_detail pd on pd.pdd_prd_id_fk = p.prd_id
WHERE prd_stock > 50;


-- A3) Retourner les noms des catégories en français
select cat_name_fr from category;



-- A4) Retourner les types de produits en français dans la catégorie 
-- "Huiles d'olive extra vierges"

SELECT t.typ_name_fr
from type t
    inner join category c on c.cat_id = t.typ_cat_id_fk
where c.cat_name_fr = "Huiles d'olive extra vierges";



-- A5) Retourner le nombre de produits par catégorie
SELECT p.prd_cat_id_fk,  c.cat_name_en, COUNT(p.prd_cat_id_fk)
from product p
    INNER JOIN category c on c.cat_id = p.prd_cat_id_fk
GROUP BY prd_cat_id_fk;


-- A6) Retourner le nombre de produits par type
SELECT p.prd_typ_id_fk,  t.typ_name_en, COUNT(p.prd_typ_id_fk)
from product p
    INNER JOIN type t on t.typ_id = p.prd_typ_id_fk
GROUP BY prd_typ_id_fk;



-- A7) Retourner l'information complète des produits en français 
-- (info de base et détail) pour les produits de type "Accesooires"

SELECT p.*, pd.*
from product p
    INNER JOIN product_detail pd on pd.pdd_prd_id_fk = p.prd_id
    INNER JOIN type t on t.typ_id = p.prd_typ_id_fk
WHERE t.typ_name_fr = "Accessoires" AND pd.pdd_lang='fr';


-- A8) Retourner le chiffre d'affaire total (d'après les commandes)
SELECT SUM(ord_total) as "Chiffre d'affaire total"
from `order` ;


-- A9) Retourner la date et le numéro de la commande la plus ancienne
SELECT ord_date, ord_id
from `order`
ORDER BY ord_date ASC
LIMIT 1;


-- A10) Retourner la date et le numéro de la commande la plus récente 
SELECT ord_date, ord_id
from `order`
ORDER BY ord_date DESC
LIMIT 1;

-- A11) Retourner le nombre de client par année (DANS LA TABLEDE CLIENT)



-- Note:  Votre question est imprécise, voici les clients ACTIF basé sur les commandes
SELECT YEAR(ord_date) as "Année", COUNT(ord_id) as "Nombre de client"
from `order`
GROUP BY YEAR(ord_date);


-- ... Et les nouveaux client, par année  :)
SELECT YEAR(client.cli_date) as "Année", COUNT(client.cli_id) as "Nombre de client"
from client
GROUP BY YEAR(cli_date);



-- A12) Retourner le nom et prénom du client, le numéro de commande et 
-- le sous-total des commandes placées dans les 6 derniers mois
-- note: https://stackoverflow.com/a/15634242
SELECT YEAR(ord_date) as "Année", COUNT(ord_id) as "Nombre de client"
from `order`
WHERE ord_date > DATE_SUB(NOW(), INTERVAL 6 MONTH);


-- -----------------------------------------------------------------------------
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- B) Requêtes nettement plus complexes ("difficiles") 
-- -----------------------------------------------------------------------------
-- Des captures d'écrans des jeux d'enregistrements résultants sont inclus 
-- dans le dossier "résultats-escomptés"
-- -----------------------------------------------------------------------------
-- Je tiendrais compte uniquement de vos 8 meilleures réponses sur les 
-- 14 requêtes de cette section (B)
-- -----------------------------------------------------------------------------
-- *****************************************************************************
-- -----------------------------------------------------------------------------

-- B1) Retourner l'identifiant, le nom en anglais, et le prix ordinaire 
-- du produit le plus cher du catalogue
-- Suggestion : ORDER BY et LIMIT

SELECT p.prd_id, pd.pdd_name, p.prd_price
FROM product p
    INNER JOIN product_detail pd on pd.pdd_prd_id_fk = p.prd_id
WHERE pd.pdd_lang="en"
ORDER BY p.prd_price DESC
limit 1;


-- B2) Retourner les noms de catégorie en français et le prix du produit 
-- le plus cher dans chacune des catégories de produits disponibles.
-- NOTE: https://www.mavaanalytics.com/post/how-to-list-the-most-expensive-price-of-items-by-category-in-ms-sql-server


SELECT c.cat_name_fr, MAX(p.prd_price) as plusCher
FROM product p
        INNER JOIN category c on c.cat_id = p.prd_cat_id_fk
group by p.prd_cat_id_fk
ORDER BY c.cat_name_fr ASC; -- Uniquement pour donner exactement le meme résultat que vous



-- B3) Retourner l'identifiant, nom en français, petite image, prix, 
-- prix de solde, et quantité en stock de tous les produits actifs de 
-- type 'vinaigres balsamiques'

SELECT p.prd_id, pd.pdd_name, p.prd_img_small, p.prd_price, p.prd_saleprice,p.prd_stock
from product p
    INNER JOIN product_detail pd on pd.pdd_prd_id_fk = p.prd_id
    INNER JOIN type t on t.typ_id = p.prd_typ_id_fk
WHERE t.typ_name_fr = "vinaigres balsamiques" AND pd.pdd_lang='fr' AND p.prd_active=1;




-- B4) Retourner le id, le nom en français, et la petite image de produit, 
-- ainsi que la quantité, des produits dans le panier d'achat dont le id est 822310


select p.prd_id, pdd_name, p.prd_img_small, cd.crd_quantity
FROM cart_detail cd
        INNER JOIN product_detail pd on pd.pdd_prd_id_fk = cd.crd_prd_id_fk
        INNER JOIN product p on p.prd_id = cd.crd_prd_id_fk
WHERE cd.crd_crt_id_fk = 822310 and pd.pdd_lang='fr';


-- B5) Même chose, mais cette fois-ci ajoutez le prix du produit 
-- (qui pourrait être en solde !)
-- Suggestion : COALESCE ou LEAST/IFNULL
-- Note: https://stackoverflow.com/a/3215463

select p.prd_id, pdd_name, p.prd_img_small, cd.crd_quantity, COALESCE(p.prd_saleprice, p.prd_price) as prixProduit
FROM cart_detail cd
        INNER JOIN product_detail pd on pd.pdd_prd_id_fk = cd.crd_prd_id_fk
        INNER JOIN product p on p.prd_id = cd.crd_prd_id_fk
WHERE cd.crd_crt_id_fk = 822310 and pd.pdd_lang='fr';



-- B6) Retourner l'identifiant du panier et le sous-total des produits 
-- (avant taxes et frais de livraison) de tous les paniers d'achats non-vides 
-- (ignorez les "cours", seulement les "produits") triés par ordre descendant 
-- de sous-total
-- Suggestion : COALESCE

-- Note: désolé!!!
SELECT crd_crt_id_fk, SUM(COALESCE(p.prd_saleprice, p.prd_price) * cd.crd_quantity) as sousTotal
FROM cart_detail cd
        INNER JOIN product p on p.prd_id = cd.crd_prd_id_fk
WHERE ???ouhlala!
GROUP BY ?
ORDER BY sousTotal DESC;


-- Avec hints de johanna(très peu de mérite!)
SELECT crd_crt_id_fk AS panierNonVide,
SUM(COALESCE(prd_saleprice, prd_price)*crd_quantity) sousTotalPanierNonVide
FROM cart_detail
    JOIN cart ON crt_id = crd_crt_id_fk
    JOIN product ON prd_id = crd_prd_id_fk
 WHERE crd_prd_id_fk IS NOT NULL
 GROUP BY panierNonVide
 ORDER BY sousTotalPanierNonVide DESC;



-- B7) Retourner les origines distinctes des produits, en français
-- Suggestion : SELECT DISTINCT
select DISTINCT pd.pdd_origin
from product_detail pd
    INNER JOIN product p on p.prd_id = pd.pdd_prd_id_fk
WHERE pd.pdd_lang='fr';


-- B8) Retourner dans une seule chaîne de caractères toutes les origines 
-- distinctes de produits en français (séparées par le symbole |)
-- Suggestion : GROUP_CONCAT
-- Note: https://stackoverflow.com/questions/276927/can-i-concatenate-multiple-mysql-rows-into-one-field/276949#276949

SELECT GROUP_CONCAT(DISTINCT pd.pdd_origin SEPARATOR '|') as OriginesFr
from product_detail pd
    INNER JOIN product p on p.prd_id = pd.pdd_prd_id_fk
WHERE pd.pdd_lang='fr';


-- B9) Retourner le nombre de paniers vides
-- Suggestion : type de jointure ???


-- NOTE:  Fait, mais avec vos hints!!!!!. :)

SELECT COUNT(crt_id) as NombrePaniersVides
FROM cart
    LEFT JOIN cart_detail ON crt_id = crd_crt_id_fk
WHERE crd_crt_id_fk IS NULL;


---- NOTE:  Désolé! Je n'ai pu poursuivre le reste

-- B10) Retourner les numéros de série distincts (crt_serial) des paniers 
-- qui ne sont pas vides ordonnés par identifiant de panier
-- Suggestion : type de jointure ???



-- B11) Retourner le nombre de panier distincts non-vides
-- Suggestion : type de jointure ???


-- B12) Retourner l'identifiant, le SKU, et le nombre de fois commandé, 
-- des 10 produits les plus souvents commandés, ordonné par meilleur vendeur.


-- B13) Même question, mais au lieu du nombre de fois commandé, on 
-- demande le nombre d'articles commandés



-- B14) Supprimer les paniers vides.
-- [Difficile seulement car pas d'exemple à ce jour en classe : requiert 
-- une sous-requête, sinon assez facile] 
-- Important de faire cette requête à la toute fin quand vous avez terminé 
-- l'atelier seulement.


