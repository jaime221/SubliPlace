<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        
        header {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 20px 0;
        }
        
        h1 {
            font-size: 28px;
        }
        
        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }
        
        .product {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin: 10px;
            padding: 20px;
            width: 300px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .product img {
            max-width: 100%;
            height: auto;
        }
        
        .product-title {
            font-size: 20px;
            margin: 10px 0;
        }
        
        .product-price {
            color: #f00;
            font-size: 18px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <header>
         <jsp:include page="Layout.jsp" />
    </header>
    <div class="product-container">
        <%-- Producto 1 --%>
        <div class="product">
            <img src="https://i.etsystatic.com/34182020/r/il/c41b48/4062051396/il_fullxfull.4062051396_49zs.jpg" alt="Producto 1">
            <div class="product-title">Producto 1</div>
            <div class="product-price">$19.99</div>
        </div>
        
        <%-- Producto 2 --%>
        <div class="product">
            <img src="https://reylobo.es/4742-large_default/taza-futbol-club-barcelona-personalizada.jpg" alt="Producto 2">
            <div class="product-title">Producto 2</div>
            <div class="product-price">$24.99</div>
        </div>
        
        
    </div>
</body>
</html>