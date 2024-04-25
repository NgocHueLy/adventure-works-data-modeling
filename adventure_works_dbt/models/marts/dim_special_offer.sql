SELECT
    {{ sqlserver__generate_surrogate_key(['SpecialOfferID']) }} AS SpecialOfferKey,
    SpecialOfferID,
    Description AS SpecialOfferDescription,
    DiscountPct,
    Type AS DiscountType,
    Category,
    CAST(StartDate AS date) AS StartDate,
    CAST (EndDate AS date) AS EndDate
FROM {{ source ('base', 'SpecialOffer') }}