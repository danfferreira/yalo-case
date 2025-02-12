views:
  - name: products
    sql_table_name: `iowa_liquor_sales` ;;
    
    dimension: itemno {
      primary_key: yes
      type: string
      sql: ${TABLE}.itemno ;;
    }

    dimension: category_name {
      type: string
      sql: ${TABLE}.im_desc ;;
    }

  - name: orders
    sql_table_name: `iowa_liquor_sales` ;;
    
    dimension: invoice_line_no {
      primary_key: yes
      type: string
      sql: ${TABLE}.invoice_line_no ;;
    }

    dimension: itemno {
      type: string
      sql: ${TABLE}.itemno ;;
    }

    measure: total_sales {
      type: sum
      value_format_name: usd
      sql: ${sale_bottles} * ${sale_dollars} ;;
    }

    measure: average_sales_per_customer {
      type: average
      sql: ${total_sales} ;;
    }