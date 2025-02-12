models:
  - name: iowa_sales
    label: "Iowa Liquor Sales Dashboard"
    connection: "bi"  
    includes: ["views/*.lkml", "explores/*.lkml"]
    
    explores:
      - name: sales_explorer
        description: "Iowa Dashboard"
        label: "Sales Overview"
