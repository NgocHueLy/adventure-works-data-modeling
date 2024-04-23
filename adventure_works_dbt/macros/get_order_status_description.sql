{#
    This macro returns the description of the order_status_id
#}


{% macro get_order_status_description(order_status_id) %}
    
    case {{ order_status_id }}  
        when 1 then 'In process'
        when 2 then 'Approved'
        when 3 then 'Backordered'
        when 4 then 'Rejected'
        when 5 then 'Shipped'
        else 'Cancelled'
    end

{% endmacro %}
