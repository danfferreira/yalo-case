explores:
  - name: sales_explore
    label: "Iowa Liquor Analysis"
    
    join: products {
      sql_on: ${orders.itemno} = ${products.itemno} ;;
      relationship: many_to_one
      type: left_outer
    }
