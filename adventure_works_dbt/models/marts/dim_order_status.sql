SELECT DISTINCT
    {{ sqlserver__generate_surrogate_key(['Status']) }} AS OrderStatusKey,
    Status AS OrderStatusID,
    {{ get_order_status_description('Status') }} AS OrderStatus
FROM {{ source('base', 'SalesOrderHeader') }}