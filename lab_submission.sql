-- (i) A Procedure called PROC_LAB5
DELIMITER $$

CREATE PROCEDURE PROC_LABS(IN customerID INT)
BEGIN
    SELECT orders.orderNumber, orders.orderDate, FUNC_LABS(orders.orderNumber) AS 'Total Order Value'
    FROM orders
    WHERE orders.customerNumber = customerID;
END$$

DELIMITER ;


-- (ii) A Function called FUNC_LAB5
DELIMITER $$

CREATE FUNCTION FUNC_LABS(orderID INT) RETURNS DECIMAL(10, 2)
    DETERMINISTIC
BEGIN
    DECLARE totalValue DECIMAL(10, 2);
    SET totalValue = 0.00;

    SELECT SUM(orderdetails.quantityOrdered * products.buyPrice) INTO totalValue
    FROM orderdetails
             JOIN products ON orderdetails.productCode = products.productCode
    WHERE orderdetails.orderNumber = orderID;

    RETURN totalValue;
END$$

DELIMITER ;


-- (iii) A View called VIEW_LAB5
CREATE VIEW VIEW_LABS AS
SELECT
    customers.customerNumber AS 'Customer ID',
    customers.customerName AS 'Customer Name',
    orders.orderNumber AS 'Order ID',
    orders.orderDate AS 'Order Date',
    products.productName AS 'Product Name',
    orderdetails.quantityOrdered AS 'Quantity Ordered',
    (orderdetails.quantityOrdered * products.buyPrice) AS 'Line Total',
    FUNC_LABS(orders.orderNumber) AS 'Total Order Value'
FROM customers
         JOIN orders ON customers.customerNumber = orders.customerNumber
         JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
         JOIN products ON orderdetails.productCode = products.productCode;
-- done
