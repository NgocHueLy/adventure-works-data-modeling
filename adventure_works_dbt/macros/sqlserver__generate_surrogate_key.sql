-- this macro is added because dbt_utils.generate_surrogate_key(['p.ProductID']) return error with only one field
--   ('42000', '[42000] [Microsoft][ODBC Driver 17 for SQL Server][SQL Server]The concat function requires 2 to 254 arguments. (189) (SQLMoreResults)')
-- link https://github.com/dbt-msft/tsql-utils/issues/97

{%- macro sqlserver__generate_surrogate_key(field_list) -%}

{%- if var('surrogate_key_treat_nulls_as_empty_strings', False) -%}
    {%- set default_null_value = "" -%}
{%- else -%}
    {%- set default_null_value = '_dbt_utils_surrogate_key_null_' -%}
{%- endif -%}

{%- set fields = [] -%}

{%- for field in field_list -%}

    {%- do fields.append(
        "coalesce(cast(" ~ field ~ " as " ~ dbt.type_string() ~ "), '" ~ default_null_value  ~"')"
    ) -%}

    {%- if not loop.last %}
        {%- do fields.append("'-'") -%}
    {%- endif -%}

{%- endfor -%}

{%- if fields|length > 1 %}
    {{ dbt.hash(dbt.concat(fields)) }}
{%- else -%}
    {{ dbt.hash(fields[0]) }}
{%- endif -%}

{%- endmacro -%}