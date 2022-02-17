-- create the database
drop database if exists ordergl_DB;
create database ordergl_DB;
use ordergl_DB;

-- create the tables
-- supplier table
drop table if exists Suppliers;
create table Suppliers(supplierID int primary key not null, supplierName varchar(20), supplierCity varchar(20), supplierPhone varchar(10));

-- customers table
drop table if exists Customers;
create table Customers(customerID int primary key not null, 
customerName varchar(20) null default null, customerCity varchar(20), customerPhone varchar(10), customerGender char(1));

-- category table
drop table if exists Category;
create table Category(categoryID int primary key not null, categoryName varchar(20) null default null);

-- products table
drop table if exists Products;
create table Products(productID int primary key not null, productName varchar(20) null default null, 
productDescription varchar(100) null default null,
categoryId int not null, foreign key(categoryId) references Category(categoryId));


-- product details table
drop table if exists ProductDetails;
create table ProductDetails(productDetailsID int primary key not null, price float,
productID int not null, foreign key(productID) references Products(productID),
supplierID int not null, foreign key(supplierID) references Suppliers(supplierID));


-- orders table
drop table if exists Orders;
create table Orders(orderID int primary key not null, orderAmount float not null, orderDate date, 
productDetailsID int not null, foreign key(productDetailsID) references ProductDetails(productDetailsID),
customerID int not null, foreign key(customerID) references Customers(customerID));


-- ratings table
drop table if exists Ratings;
create table Ratings(ratingID int primary key not null, ratingStars int not null, 
supplierID int not null, foreign key(supplierID) references Suppliers(supplierID),
customerID int not null, foreign key(customerID) references Customers(customerID));



-- Add data to suppliers table
insert into suppliers values(1, 'Rajesh Retails','Delhi','1234567890');
insert into suppliers values(2, 'Appario Ltd.','Mumbai','2589631470');
insert into suppliers values(3, 'Knome products','Bangalore','9785462315');
insert into suppliers values(4, 'Bansal Retails','Kochi','8975463285');
insert into suppliers values(5, 'Mittal Ltd.','Lucknow','7898456532');

					
				
-- Add data to customers table
insert into customers values(1, 'Aakash','Delhi','9999999999', 'M');
insert into customers values(2, 'Aman','Noida','9785463215', 'M');
insert into customers values(3, 'Neha','Mumbai','9999999999', 'F');
insert into customers values(4, 'Megha','Kolkata','9994562399', 'F');
insert into customers values(5, 'Pulkit','Lucknow','7895999999', 'M');		
	

-- Add data to category table
insert into category values(1, 'Books');
insert into category values(2, 'Games');
insert into category values(3, 'Groceries');
insert into category values(4, 'Electronics');
insert into category values(5, 'Clothes');	



-- Add data to Products table
insert into products values(1, 'GTA V', 'DFJDJFDJFDJFDJFJF', 2);
insert into products values(2, 'TSHIRT','DFDFJDFJDKFD', 5);
insert into products values(3, 'ROG LAPTOP','DFNTTNTNTERND', 4);
insert into products values(4, 'OATS','REURENTBTOTH',3);
insert into products values(5, 'HARRY POTTER','NBEMCTHTJTH',1);			


-- Add data to ProductDetails table
insert into ProductDetails values(1, 1500, 1, 2);
insert into ProductDetails values(2, 30000, 3, 5);
insert into ProductDetails values(3, 3000, 5, 1) ;
insert into ProductDetails values(4, 2500, 2, 3);
insert into ProductDetails values(5, 1000, 4, 1);	


-- Add data to orders table
insert into orders values(20, 1500, '2021-10-12', 5, 3);
insert into orders values(25, 30500, '2021-09-16', 2, 5);
insert into orders values(26, 2000, '2021-10-05', 1, 1) ;
insert into orders values(30, 3500, '2021-08-16', 3, 4);
insert into orders values(50, 2000, '2021-10-06', 1, 2);	



-- Add data to ratings table
insert into ratings values(1, 4, 2, 2);
insert into ratings values(2, 3, 4, 3);
insert into ratings values(3, 5, 1, 5) ;
insert into ratings values(4, 2, 3, 1);
insert into ratings values(5, 4, 5, 4);




-- Q3) Display the number of the customer group by their genders who have placed any order of amount greater than or equal to Rs.3000.

select customerGender, count(*)
from customers inner join orders 
			   on customers.customerId = orders.customerID 
               where orderAmount>= 3000 
               group by customerGender;
               
               
               
-- Q4) Display all the orders along with the product name ordered by a customer having Customer_Id=2.

select orderID, productName from orders 
	inner join productdetails on productdetails.productdetailsID = orders.productdetailsID
    inner join products on productdetails.productID = products.productID where orders.customerID=2;
    
    


-- Q5) Display the Supplier details who can supply more than one product.

select count(*) as NumProducts, suppliers.supplierID, suppliers.supplierName 
	from suppliers 
    inner join productdetails on productdetails.supplierID = suppliers.supplierID 
    group by suppliers.supplierID 
    having count(*)>1;
    
    
-- Another solution using inner join

select * from suppliers where supplierID 
	in (select supplierID from productdetails group by supplierID having count(*)>1);





-- Q6)	Find the category of the product whose order amount is minimum.
select category.* from orders
inner join productdetails on productdetails.productdetailsID = orders.productdetailsID
inner join products on productdetails.productID = products.productID 
inner join category on category.categoryID = products.categoryID order by orders.orderAmount limit 1;



-- Q7) Display the Id and Name of the Product ordered after “2021-10-05”.
select products.productID, products.productName, products.productDescription from orders 
	inner join productdetails on productdetails.productdetailsID = orders.productdetailsID 
    inner join products on productdetails.productID = products.productID where orderDate>'2021-10-05';
    
    
    
-- Q8) Display customer name and gender whose names start or end with character 'A'. 
select customerName, customerGender from customers where customerName like 'A%' 
	or customerName like '%A';
    
    
    
    
/* Q9) Create a stored procedure to display the Rating for a 
Supplier if any along with the Verdict on that rating if any like if rating >4 then “Genuine Supplier” 
if rating >2 “Average Supplier” else “Supplier should not be considered”. */


call categorizeSupplier;


        
 




		
					
                    




