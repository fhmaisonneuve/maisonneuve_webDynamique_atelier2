-- -----------------------------------------------------------------------------
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- A) Requêtes assez simples ("faciles")
-- -----------------------------------------------------------------------------
-- *****************************************************************************
-- -----------------------------------------------------------------------------

-- A1) Retourner l'identifiant et le sku des produits qui ne sont pas en stock


-- A2) Retourner le nom et sku des produits dont le stock > 50


-- A3) Retourner les noms des catégories en français


-- A4) Retourner les types de produits en français dans la catégorie 
-- "Huiles d'olive extra vierges"


-- A5) Retourner le nombre de produits par catégorie


-- A6) Retourner le nombre de produits par type


-- A7) Retourner l'information complète des produits en français 
-- (info de base et détail) pour les produits de type "Accesooires"


-- A8) Retourner le chiffre d'affaire total (d'après les commandes)


-- A9) Retourner la date et le numéro de la commande la plus ancienne


-- A10) Retourner la date et le numéro de la commande la plus récente 


-- A11) Retourner le nombre de client par année


-- A12) Retourner le nom et prénom du client, le numéro de commande et 
-- le sous-total des commandes placées dans les 6 derniers mois

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


-- B2) Retourner les noms de catégorie en français et le prix du produit 
-- le plus cher dans chacune des catégories de produits disponibles.


-- B3) Retourner l'identifiant, nom en français, petite image, prix, 
-- prix de solde, et quantité en stock de tous les produits actifs de 
-- type 'vinaigres balsamiques'


-- B4) Retourner le id, le nom en français, et la petite image de produit, 
-- ainsi que la quantité, des produits dans le panier d'achat dont le id est 822310


-- B5) Même chose, mais cette fois-ci ajoutez le prix du produit 
-- (qui pourrait être en solde !)
-- Suggestion : COALESCE ou LEAST/IFNULL


-- B6) Retourner l'identifiant du panier et le sous-total des produits 
-- (avant taxes et frais de livraison) de tous les paniers d'achats non-vides 
-- (ignorez les "cours", seulement les "produits") triés par ordre descendant 
-- de sous-total
-- Suggestion : COALESCE


-- B7) Retourner les origines distinctes des produits, en français
-- Suggestion : SELECT DISTINCT


-- B8) Retourner dans une seule chaîne de caractères toutes les origines 
-- distinctes de produits en français (séparées par le symbole |)
-- Suggestion : GROUP_CONCAT


-- B9) Retourner le nombre de paniers vides
-- Suggestion : type de jointure ???


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


