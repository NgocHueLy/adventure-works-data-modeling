WITH customer AS (
    SELECT *
    FROM {{ source('base', 'Customer') }}
),
store AS (
    SELECT *
    FROM {{ source('base', 'Store') }}
),
person AS (
    SELECT * 
    FROM {{ source('base', 'Person') }}
)

SELECT
    {{ sqlserver__generate_surrogate_key(['customer.CustomerID']) }} AS CustomerKey,
    customer.CustomerID,
    store.Name AS StoreName,
    CONCAT_WS(' ',person.FirstName, person.MiddleName, person.LastName) AS FullName
FROM customer
LEFT JOIN store ON customer.StoreID = store.BusinessEntityID
LEFT JOIN person ON customer.PersonID = person.BusinessEntityID

