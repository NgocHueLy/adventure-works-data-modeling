{#
    This macro returns the description of the person type
#}


{% macro get_customer_type(person_type) %}
    
    case {{ person_type }}  
        when 'SC' then 'B2B'
        when 'IN' then 'B2C'
    end

{% endmacro %}

