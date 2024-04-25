{{ config(materialized='table') }}

WITH order_header AS (
    SELECT
        SalesOrderID,
        CAST(OrderDate AS date) AS OrderDate,
        Status AS OrderStatus,
        CustomerID,
        ShipToAddressID
    FROM {{ source('base', 'SalesOrderHeader') }}
),
order_detail AS (
    SELECT
        SalesOrderID,
        SalesOrderDetailID,
        OrderQty,
        ProductID,
        SpecialOfferID,
        UnitPrice,
        UnitPriceDiscount,
        UnitPrice * OrderQty AS Revenue

    FROM {{ source('base', 'SalesOrderDetail') }}

)
SELECT
    {{ sqlserver__generate_surrogate_key(['de.SalesOrderID', 'de.SalesOrderDetailID']) }} AS SalesKey,
    {{ sqlserver__generate_surrogate_key(['h.OrderStatus']) }} AS OrderStatusKey,
    {{ sqlserver__generate_surrogate_key(['h.OrderDate']) }} AS OrderDateKey,
    {{ sqlserver__generate_surrogate_key(['h.CustomerID']) }} AS CustomerKey,
    {{ sqlserver__generate_surrogate_key(['h.ShipToAddressID']) }} AS ShipAddressKey,
    {{ sqlserver__generate_surrogate_key(['de.ProductID']) }} AS ProductKey,
    {{ sqlserver__generate_surrogate_key(['de.SpecialOfferID']) }} AS SpecialOffertKey,   
    
    de.SalesOrderID,
    de.SalesOrderDetailID,
    de.UnitPrice,
    de.OrderQty,    
    de.Revenue

FROM order_header h 
JOIN order_detail de 
ON h.SalesOrderID = de.SalesOrderID