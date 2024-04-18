WITH product AS (
    SELECT *
    FROM {{ source('base','Product') }}
), product_subcategory AS (
    SELECT *
    FROM {{ source('base','ProductSubcategory') }}
), product_category AS (
    SELECT *
    FROM {{ source('base','ProductCategory') }}
)

SELECT
    {{ sqlserver__generate_surrogate_key(['p.ProductID']) }} AS ProductKey,
    p.ProductID,
    p.ProductNumber,    
    p.ProductModelID,
    p.name AS ProductName,
    p.Color,
    p.Class,
    p.Style,
    sub.Name AS SubcategoryName,
    cat.Name AS CategoryName
FROM product p
LEFT JOIN product_subcategory sub 
ON p.ProductSubcategoryID = sub.ProductSubcategoryID
LEFT JOIN product_category cat  
ON sub.ProductCategoryID = cat.ProductCategoryID

