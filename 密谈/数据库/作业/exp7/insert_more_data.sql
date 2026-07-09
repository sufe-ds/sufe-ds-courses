INSERT INTO Payment 
VALUES('1','Cash');

INSERT INTO Payment 
VALUES('2','Check');

INSERT INTO Payment 
VALUES('3','Credit card');

INSERT INTO Payment 
VALUES('4','Telegraphic money');

INSERT INTO Ptype 
VALUES('1','Book');

INSERT INTO Ptype 
VALUES('2','CD');

INSERT INTO Ptype 
VALUES('3','Software');

INSERT INTO Product
VALUES ('1001', 'Advanced Marketing', 20.50, '1', 120);

INSERT INTO Product
VALUES ('1002', 'Visual Basic Programming', 28.00, '1', 200);

INSERT INTO Product
VALUES ('1003', 'Computer Application', 30.55, '1', 80);

INSERT INTO Product
VALUES ('1004', 'An Introduction to Database Systems', 20.00, '1', 12);

INSERT INTO Product
VALUES ('1005', 'Microecononics', 35.80, '1', 150);

INSERT INTO Product
VALUES ('2001', 'The Lion King', 35.00, '2', 150);

INSERT INTO Product
VALUES ('2002', 'Classic Disney', 25.00, '2', 20);

INSERT INTO Product
VALUES ('3001', 'Microsoft Money 2010', 70.50, '3', 300);

INSERT INTO Product
VALUES ('3002', 'Microsoft Student 2009 ', 80.00, '3', 150);

INSERT INTO Product
VALUES ('3003', 'Norton AntiVirus 2014', 40.90, '3', 250);

INSERT INTO Product
VALUES ('3004', 'Math Advantage 2007', 30.00, '3', 10);

INSERT INTO Customer
VALUES ('C0001', 'Zhang Chen', 'Citibank', 'Shanghai', '021-65903818');

INSERT INTO Customer
VALUES ('C0002', 'Wang Ling', 'Oracle', 'Beijing', '010-62754108');

INSERT INTO Customer
VALUES ('C0003', 'Li Li', 'Minsheng bank', 'Shanghai', '021-62438210');

INSERT INTO Customer
VALUES ('C0004', 'Liu Xin', 'Citibank', 'Shanghai', '021-55392225');

INSERT INTO Customer
VALUES ('C0005', 'Xu Ping', 'Microsoft', 'Beijing', '010-43712345');

INSERT INTO Customer
VALUES ('C0006', 'Zhang Qing', 'Freightliner LLC', 'Guangzhou', '020-84713425');

INSERT INTO Customer
VALUES ('C0007', 'Yang Jie', 'Freightliner LLC', 'Guangzhou', '020-76543657');

INSERT INTO Customer
VALUES ('C0008', 'Wang Peng', 'IBM', 'Beijing', '010-62751231');

INSERT INTO Customer
VALUES ('C0009', 'Du Wei', 'HoneyWell', 'Shanghai', '021-45326788');

INSERT INTO Customer
VALUES ('C0010', 'Shan Feng', 'Oracle', 'Beijing', '010-62751230');

INSERT INTO Orders
VALUES ('O0001', ' 10-3月-2014', 'C0001', 8, ' 11-3月-2014', 'Beijing', '1', 'Complete');

INSERT INTO Orders
VALUES ('O0002', ' 11-3月-2014', 'C0002', 8, '12-3月-2014', 'Shanghai', '2', 'Complete');

INSERT INTO Orders
VALUES ('O0003', ' 11-3月-2014', 'C0009', 5, '12-3月-2014', 'Shanghai', '2', 'Complete');

INSERT INTO Orders
VALUES ('O0004', ' 13-4月-2014', 'C0007', 5, '15-4月-2014', 'Beijing', '1', 'Complete');

INSERT INTO Orders
VALUES ('O0005', ' 14-4月-2014', 'C0010', 8, '16-4月-2014', 'Beijing', '1', 'Complete');

INSERT INTO Orders
VALUES ('O0006', ' 25-4月-2014', 'C0008', 5, '26-4月-2014', 'Shanghai', '3', 'Complete');

INSERT INTO Orders
VALUES ('O0007', ' 26-5月-2014', 'C0010', 8, '28-5月-2014', 'Shanghai', '3', 'Complete');

INSERT INTO Orders
VALUES ('O0008', ' 17-6月-2014', 'C0006', 5, '18-6月-2014', 'Beijing', '1', 'Complete');

INSERT INTO Orders
VALUES ('O0009', ' 21-7月-2014', 'C0008', 5, '22-7月-2014', 'Shanghai', '2', 'in process');

INSERT INTO Orders
VALUES ('O0010', ' 23-7月-2014', 'C0005', 5, '25-7月-2014', 'Beijing', '1', 'in process');

INSERT INTO Order_items (ONO, PNO, QTY)
VALUES ('O0001', '1001', 5);

INSERT INTO Order_items
VALUES ('O0001', '1002', 1, 0.2);

INSERT INTO Order_items
VALUES ('O0001', '1003', 3, 0.3);

INSERT INTO Order_items
VALUES ('O0001', '2001', 1, 0.2);

INSERT INTO Order_items
VALUES ('O0001', '2002', 1, 0.2);

INSERT INTO Order_items
VALUES ('O0002', '1001', 2, 0);

INSERT INTO Order_items
VALUES ('O0002', '1004', 5, 0.4);

INSERT INTO Order_items
VALUES ('O0002', '1005', 1, 0.05);

INSERT INTO Order_items
VALUES ('O0002', '3003', 3, 0.3);

INSERT INTO Order_items
VALUES ('O0006', '1004', 5, 0.4);

INSERT INTO Order_items (ONO, PNO, QTY)
VALUES ('O0006', '1005', 1);

INSERT INTO Order_items
VALUES ('O0006', '2001', 2, 0.3);

INSERT INTO Order_items
VALUES ('O0006', '2002', 1, 0.2);

INSERT INTO Order_items
VALUES ('O0006', '3003', 2, 0.3);

INSERT INTO Order_items
VALUES ('O0007', '1004', 1, 0.4);

INSERT INTO Order_items
VALUES ('O0007', '3004', 3, 0.2);

INSERT INTO Order_items
VALUES ('O0008', '1002', 1, 0.2);

INSERT INTO Order_items
VALUES ('O0008', '2001', 3, 0.3);

INSERT INTO Order_items
VALUES ('O0009', '3003', 2, 0.3);

INSERT INTO Order_items (ONO, PNO, QTY)
VALUES ('O0009', '1001', 1);

INSERT INTO Order_items
VALUES ('O0010', '1005', 1, 0.05);

INSERT INTO Order_items
VALUES ('O0003', '1005', 1, 0.05);

INSERT INTO Order_items
VALUES ('O0004', '1005', 1, 0.05);

INSERT INTO Order_items
VALUES ('O0005', '1005', 1, 0.05);