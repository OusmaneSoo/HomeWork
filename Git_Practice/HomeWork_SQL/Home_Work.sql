-- # Partie II : Questions SQL

-- ## Niveau 1 (SELECT)

-- ### Question 1

-- Afficher tous les employés.

select * from sql_hr.employees;

-- ### Question 2

-- Afficher uniquement le prénom et le salaire des employés.

select first_name as "Prénom", salary as "Salaire"
from sql_hr.employees;

-- ### Question 3

-- Afficher tous les produits disponibles.

select * from sql_inventory.products;

-- ### Question 4

-- Afficher tous les clients.

select * from invoicing.clients;

select * from store.customers;

-- ### Question 5

-- Afficher les factures.

select * from invoicing.invoices;

-- ## Niveau 2 (WHERE)

-- ### Question 6

-- Afficher les employés dont le salaire dépasse 90 000.

select * from sql_hr.employees where salary > 90000;

-- ### Question 7

-- Afficher les employés travaillant dans le bureau numéro 3.

select * from sql_hr.employees where office_id = 3;

-- ### Question 8

-- Afficher les produits dont le prix est supérieur à 3 dollars.

select * from sql_inventory.products where unit_price > 3;

-- ### Question 9

-- Afficher les clients habitant dans l'État **CA**.

select * from invoicing.clients where state = 'CA';

-- ### Question 10

-- Afficher les commandes passées après le 1 janvier 2018.

select * from store.orders where order_date > '2018-01-01';

-- ## Niveau 3 (ORDER BY)

-- ### Question 11

-- Afficher les employés du plus grand salaire au plus petit.

select * from sql_hr.employees order by salary desc;

-- ### Question 12

-- Afficher les produits classés par prix croissant.

select * from sql_inventory.products order by unit_price asc;
-- ### Question 13

-- Afficher les clients classés par nombre de points décroissant.

select * from store.customers c order by c.points desc;

-- ## Niveau 4 (LIMIT)

-- ### Question 14

-- Afficher les 5 employés les mieux payés.

select * from sql_hr.employees order by salary desc limit 5;

-- ### Question 15

-- Afficher les 3 produits les moins chers.

select * from sql_inventory.products order by unit_price asc limit 3;

-- ## Niveau 5 (Fonctions d'agrégation)

-- ### Question 16

-- Quel est le salaire moyen des employés ?

select avg(salary) as salaire_moyen from sql_hr.employees;

-- ### Question 17

-- Quel est le salaire maximal ?

select max(salary) as salaire_maximal from sql_hr.employees;

-- ### Question 18

-- Quel est le salaire minimal ?

select min(salary) as salaire_minimal from sql_hr.employees;

-- ### Question 19

-- Combien y a-t-il d'employés ?

select count(*) as nombre_employés from sql_hr.employees;

-- ### Question 20

-- Quelle est la valeur totale du stock ?

-- *(quantité × prix)*

select sum(
        quantity_in_stock * unit_price
    ) as valeur_totale_stock
from sql_inventory.products;

-- ## Niveau 6 (GROUP BY)

-- ### Question 21

-- Calculer le salaire moyen par bureau.

select
    office_id as Bureau,
    avg(salary) as salaire_moyen
from sql_hr.employees
group by
    office_id;

-- ### Question 22

-- Compter le nombre d'employés par bureau.

select
    office_id as Bureau,
    count(*) as nombre_employés
from sql_hr.employees
group by
    office_id;

-- ### Question 23

-- Compter le nombre de clients par État.

select state as État, count(*) as nombre_clients
from store.customers
group by
    state;

-- ### Question 24

-- Calculer le montant total facturé par client.

select
    i.client_id as client_id,
    sum(i.invoice_total) as montant_total_facturé
from invoicing.invoices i
group by
    i.client_id;

-- ### Question 25

-- Calculer le nombre de commandes par client.

select o.customer_id as client_id, count(*) as nombre_commandes
from store.orders o
group by
    o.customer_id;

-- ## Niveau 7 (HAVING)

-- ### Question 26

-- Afficher les bureaux possédant plus de deux employés.

select
    office_id as Bureau,
    count(*) as nombre_employés
from sql_hr.employees
group by
    office_id
having
    count(*) > 2;

-- ### Question 27

-- Afficher les clients ayant plus d'une facture.

select i.client_id as client_id, count(*) as nombre_factures
from invoicing.invoices i
group by
    i.client_id
having
    count(*) > 1;

-- ### Question 28

-- Afficher les États ayant au moins deux clients.

select state as État, count(*) as nombre_clients
from store.customers
group by
    state
having
    count(*) >= 2;

select state as Etat, count(*) as nombre_clients
from invoicing.clients
group by
    state
having
    count(*) >= 2;

-- ## Niveau 8 (Jointures)

-- ### Question 29

-- Afficher :

-- - prénom
-- - nom
-- - ville du bureau

select
    e.first_name as prénom,
    e.last_name as nom,
    o.city as ville_du_bureau
from sql_hr.employees e
    INNER join sql_hr.offices o on e.office_id = o.office_id;

-- ### Question 30

-- Afficher :

-- - nom du client
-- - numéro de commande
-- - date de commande

select
    concat(
        c.first_name,
        ' ',
        c.last_name
    ) as nom_du_client,
    o.order_id as numero_de_commande,
    o.order_date as date_de_commande
from store.customers c
    INNER join store.orders o on c.customer_id = o.customer_id;

-- ### Question 31

-- Afficher :

-- - numéro de commande
-- - nom du produit
-- - quantité

select
    o.order_id as numero_de_commande,
    p.name as nom_du_produit,
    oi.quantity as quantite
from store.orders o
    INNER join store.order_items oi on o.order_id = oi.order_id
    INNER join store.products p on oi.product_id = p.product_id;

select
    oi.order_id as numero_de_commande,
    p.name as nom_du_produit,
    oi.quantity as quantite
from store.order_items oi
    INNER join store.products p on oi.product_id = p.product_id;

-- ### Question 32

-- Afficher :

-- - numéro de facture
-- - nom du client
-- - montant de la facture

select
    invoices.invoice_id as Numero_de_facture,
    c.name as client_name,
    invoices.invoice_total as Montant_de_la_facture
from clients c
    inner join invoices on c.client_id = invoices.client_id

select *
from
    payment_methods pm
    left join payments p on pm.payment_method_id = p.payment_method;

-- Paiements
-- METHODE DE PAIEMENT
-- NOM DU CLIENT
select
    p.payment_id,
    pm.name as Méthode_de_paiement,
    c.name as nom_du_client
from invoicing.payments p
    inner join invoicing.payment_methods pm on p.payment_method = pm.payment_method_id
    inner join invoicing.clients c on p.client_id = c.client_id;
### Question 33

-- Afficher :

-- - paiement
-- - méthode de paiement
-- - nom du client
select
    p.payment_id,
    pm.name as Méthode_de_paiement,
    c.name as nom_du_client
from invoicing.payments p
    inner join invoicing.payment_methods pm on p.payment_method = pm.payment_method_id
    inner join invoicing.clients c on p.client_id = c.client_id;
## Afficher le nom du manager de chaque employé.
select e.first_name as employee_name, m.first_name as manager_name from sql_hr.employees e
inner join sql_hr.employees m on e.reports_to = m.employee_id ;

## Niveau 9 (LEFT JOIN)

### Question 35

-- Afficher tous les clients, même ceux qui n'ont jamais passé de commande.
## Afficher tous les clients, même ceux qui n'ont jamais passé de commande.
select c.first_name, c.last_name, o.order_date from store.customers c
left join store.orders o on c.customer_id = o.customer_id;

---

### Question 36

-- Afficher tous les produits, même ceux jamais commandés.

## Afficher tous les produits, même ceux jamais commandés.
select p.name, p.quantity_in_stock, p.unit_price, count(oi.order_id) as order_count from store.products p
left join store.order_items oi on p.product_id = oi.product_id
group by p.product_id;
---

### Question 37

Afficher tous les bureaux, même sans employé.

select o.office_id, o.city, count(e.employee_id) as nombre_employés
from sql_hr.offices o
    left join sql_hr.employees e on o.office_id = e.office_id
group by
    o.office_id,
    o.city;

## Niveau 10 (Sous-requêtes)

### Question 38

-- Afficher les employés gagnant plus que le salaire moyen.

select first_name, last_name, salary
from sql_hr.employees
where
    salary > (
        select avg(salary)
        from sql_hr.employees
    );
### Question 39

-- Afficher le produit le plus cher.

select name, unit_price
from sql_inventory.products
where
    unit_price = (
        select max(unit_price)
        from sql_inventory.products
    );

### Question 40

-- Afficher les clients ayant dépensé plus que la moyenne.

select c.name as Nom_client, sum(i.invoice_total) as Total_depense
from invoicing.clients c
    inner join invoicing.invoices i on c.client_id = i.client_id
group by
    c.client_id
having
    sum(i.invoice_total) > (
        select avg(invoice_total)
        from invoicing.invoices
    );

### Question 41

-- Afficher les employés travaillant dans le même bureau que l'employé **Yovonnda Magrannell**.
select e.first_name, e.last_name, e.office_id
from sql_hr.employees e
where
    e.office_id = (
        select office_id
        from sql_hr.employees
        where
            first_name = 'Yovonnda'
            and last_name = 'Magrannell'
    );

## Question 40: Afficher les clients ayant dépensé plus que la moyenne.
select c.name as Nom_client, sum(i.invoice_total) as Total_depense from invoicing.clients c inner join invoicing.invoices i on c.client_id = i.client_id
group by c.client_id
having sum(i.invoice_total) > (select avg(invoice_total) from invoicing.invoices);

## Niveau 11 (INSERT)

### Question 42

-- Ajouter un nouveau produit.

insert into
    sql_inventory.products
values (
        1001,
        'Nouveau Produit',
        100,
        19.99
    );

### Question 43

-- Ajouter un nouveau client.

insert into
    invoicing.clients
values (
        1001,
        'Nouveau Client',
        '123 Rue Exemple',
        'Exempleville',
        'CA',
        '12345',
        0
    );

### Question 44

-- Ajouter un nouvel employé.
insert into
    sql_hr.employees
values (
        1001,
        'Ousmane',
        'SOW',
        'Data scientist',
        79808,
        37270,
        10
    )

---

## Niveau 12 (UPDATE)

### Question 45

-- Augmenter de 10 % le salaire des employés du bureau 2.

update sql_hr.employees
set
    salary = salary * 1.10
where
    office_id = 2;

### Question 46

-- Ajouter 500 points aux clients de Californie.

update store.customers set points = points + 500 where state = 'CA';

### Question 47

-- Modifier le prix d'un produit.
update sql_inventory.products
set
    unit_price = 4.99
where
    product_id = 5;

## Niveau 13 (DELETE)

### Question 48

-- Supprimer un produit.
DELETE FROM SQL_INVENTORY.products WHERE product_id = 10;

---

### Question 49

-- Supprimer un client sans facture.
Delete from invoicing.clients
where
    client_id not in(
        select Distinct
            client_id
        from invoicing.invoices
    );
---

### Question 50

-- Supprimer un employé qui n'est le manager de personne.

DELETE FROM sql_hr.employees
WHERE
    employee_id NOT IN(
        SELECT DISTINCT
            reports_to
        FROM sql_hr.employees
        WHERE
            reports_to IS NOT NULL
    );

# Partie III : Défis (Bonus)

### Défi 1

## Calculer le chiffre d'affaires total ##réalisé par chaque client.
SELECT c.name as Nom_client, sum(i.invoice_total) as Total_revenu from invoicing.clients c inner join invoicing.invoices i on c.client_id = i.client_id
group by c.client_id;
---

### Défi 2

##Trouver le client ayant effectué le plus de commandes.
select c.first_name as Nom, c.last_name, count(o.order_id) as order_count from store.customers c
inner join store.orders o on c.customer_id = o.customer_id
group by c.customer_id
order by order_count desc
limit 1;
---

### Défi 3

-- Trouver les 5 produits les plus vendus.

select
    p.name as Nom_du_produit,
    sum(oi.quantity) as Quantité_totale_vendue
from store.products p
    inner join store.order_items oi on p.product_id = oi.product_id
group by
    p.product_id
order by Quantité_totale_vendue desc
limit 5;
---

### Défi 4

-- Trouver les employés ayant un salaire supérieur à celui de leur manager.

select
    e.first_name as Nom_employé,
    e.last_name,
    e.salary as Salaire_employé,
    m.first_name as Nom_manager,
    m.last_name,
    m.salary as Salaire_manager
from sql_hr.employees e
    left join sql_hr.employees m on e.reports_to = m.employee_id
where
    e.salary > m.salary;

### Défi 5

-- Afficher les commandes dont la valeur totale dépasse 100 $.

select
    o.order_id as Numero_de_commande,
    sum(oi.quantity * p.unit_price) as Valeur_totale
from store.orders o
    inner join store.order_items oi on o.order_id = oi.order_id
    inner join store.products p on oi.product_id = p.product_id
group by
    o.order_id
having
    sum(oi.quantity * p.unit_price) > 100;

### Défi 6

-- Afficher les bureaux classés selon leur masse salariale totale.

select
    o.office_id as Bureau,
    sum(e.salary) as Masse_salariale_totale
from sql_hr.offices o
    inner join sql_hr.employees e on o.office_id = e.office_id
group by
    o.office_id
order by Masse_salariale_totale desc;

### Défi 7

-- Calculer le panier moyen des commandes.

select
    o.order_id as Numero_de_commande,
    sum(oi.quantity * p.unit_price) / count(distinct o.order_id) as Panier_moyen
from store.orders o
    inner join store.order_items oi on o.order_id = oi.order_id
    inner join store.products p on oi.product_id = p.product_id
group by
    o.order_id;

### Défi 8

-- Trouver les clients qui n'ont jamais payé une facture.

select
    c.name as Nom_client,
    i.invoice_id as Numero_de_facture
from invoicing.clients c
    left join invoicing.invoices i on c.client_id = i.client_id
where
    i.invoice_id is null;

### Défi 9

-- Afficher le montant restant à payer pour chaque facture (`invoice_total - payment_total`).

select
    i.invoice_id as Numero_de_facture,
    i.invoice_total - i.payment_total as Montant_restant_a_payer
from invoicing.invoices i
    left join invoicing.payments p on i.invoice_id = p.invoice_id
group by
    i.invoice_id,
    i.invoice_total;

### Défi 10

-- Créer une vue SQL nommée `top_customers` qui affiche les clients dont les achats dépassent 500 $.
create view top_customers as
select c.customer_id, c.first_name, c.last_name, sum(oi.quantity * oi.unit_price) as total_achats
from store.customers c
    inner join store.orders o on c.customer_id = o.customer_id
    inner join store.order_items oi on o.order_id = oi.order_id
group by
    c.customer_id,
    c.first_name,
    c.last_name
having
    sum(oi.quantity * oi.unit_price) > 500;