WITH address AS (
    SELECT *        
    FROM {{ source('base', 'Address') }}
), 
state_province AS (
    SELECT *
    FROM {{ source('base', 'StateProvince') }}
),
country_region AS (
    SELECT *
    FROM {{ source('base','CountryRegion') }}
)

SELECT
    {{ sqlserver__generate_surrogate_key(['a.AddressID']) }} AS AddressKey,
    a.AddressID,
    a.City,
    a.SpatialLocation,
    s.Name AS StateProvinceName,
    c.Name AS CountryRegionName
FROM address a 
JOIN state_province s ON a.StateProvinceID = s.StateProvinceID
JOIN country_region c ON s.Countr7yRegionCode = c.CountryRegionCode
