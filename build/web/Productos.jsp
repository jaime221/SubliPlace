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
            <div class="product">
                <img src="https://cdn.create.vista.com/api/media/small/499822206/stock-vector-women-sleeveless-tank-top-sports-shirt-jersey-design-concept-illustration" alt="Producto 2">
                <div class="product-title">Producto 2</div>
                <div class="product-price">$25.99</div>
            </div> <div class="product">
                <img src="https://sublimadoperu.com/wp-content/uploads/2018/04/camisetas-sublimadas.jpg" alt="Producto 2">
                <div class="product-title">Producto 2</div>
                <div class="product-price">$26.99</div>
            </div> <div class="product">
                <img src="https://marketinglogico.com/wp-content/uploads/2022/09/Camiseta-sublimada.png" alt="Producto 2">
                <div class="product-title">Producto 2</div>
                <div class="product-price">$33.99</div>
            </div> <div class="product">
                <img src="https://www.promostore.ec/wp-content/uploads/2021/03/12088a-camiseta-sublimada-full-color.webp" alt="Producto 2">
                <div class="product-title">Producto 2</div>
                <div class="product-price">$12.99</div>
            </div> <div class="product">
                <img src="https://ideaprint.pe/1257-home_default/tazas-sublimadas-15oz.jpg" alt="Producto 2">
                <div class="product-title">Producto 2</div>
                <div class="product-price">$43.99</div>
            </div> <div class="product">
                <img src="https://w-static-p.extuid.com/163-superlarge_default/camisetas-sublimadas-personalizadas-de-nino.jpg" alt="Producto 2">
                <div class="product-title">Producto 2</div>
                <div class="product-price">$16.99</div>
            </div> <div class="product">
                <img src="https://w-static-p.extuid.com/162-superlarge_default/camisetas-personalizadas-sublimadas-de-mujer.jpg" alt="Producto 2">
                <div class="product-title">Producto 2</div>
                <div class="product-price">$32.99</div>
            </div> <div class="product">
                <img src="https://marketinglogico.com/wp-content/uploads/2022/09/Camiseta-manga-larga-sublimada.png" alt="Producto 2">
                <div class="product-title">Producto 2</div>
                <div class="product-price">$22.99</div>
            </div>

        </div>
    </body>
</html>