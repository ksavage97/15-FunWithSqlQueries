--1. Write a query to return all category names with their descriptions from the Categories table.
select CategoryName, Description
from Categories


--2. Write a query to return the contact name, customer id, company name and city name of all Customers in London
select ContactName, CustomerID, CompanyName, City
from Customers
where City = 'London'


--3. Write a query to return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number
select ContactTitle, Fax
from Suppliers
where ContactTitle in ('Marketing Manager',	'Sales Representative') and Fax IS NOT null


--4. Write a query to return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Dec 31, 1997 and with freight under 100 units.
select CustomerID, RequiredDate, Freight
from Orders
where RequiredDate BETWEEN '1997-01-01' AND '1997-12-31' and Freight < 100 

--5. Write a query to return a list of company names and contact names of all customers from Mexico, Sweden and Germany.
select CompanyName, ContactName, Country
from Customers
where Country in ('Mexico', 'Sweden', 'Germany')


--6. Write a query to return a count of the number of discontinued products in the Products table.
select TotalDiscontinuedProducts = count(*)
from Products
where Discontinued = 'True'

--7. Write a query to return a list of category names and descriptions of all categories beginning with 'Co' from the Categories table.
select CategoryName, [Description]
from Categories
where CategoryName like 'Co%'

--8. Write a query to return all the company names, city, country and postal code from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.
select CompanyName, City, Country, PostalCode, [Address]
from Suppliers
where Address like '%rue%'

--9. Write a query to return the product id and the quantity ordered for each product labelled as 'Quantity Purchased' in the Order Details table ordered by the Quantity Purchased in descending order.
select ProductID, Quantity as 'Quantity Purchased'
from [Order Details]
order by Quantity DESC

--10. Write a query to return the company name, address, city, postal code and country of all customers with orders that shipped using Speedy Express, along with the date that the order was made.
select Customers.CompanyName, Customers.[Address], Customers.City, Customers.PostalCode, Customers.Country, Orders.ShipVia, Orders.OrderDate
from Customers
full join Orders
on Customers.CompanyName=Orders.ShipName
where ShipVia = 1

--11. Write a query to return a list of Suppliers containing company name, contact name, contact title and region description.
select CompanyName, ContactName, ContactTitle, Region
from Suppliers

--12. Write a query to return all product names from the Products table that are condiments.
select Products.ProductName, Categories.CategoryName
from Products
full join Categories
on Products.CategoryID = Categories.CategoryID
where Categories.CategoryName = 'Condiments'

--13. Write a query to return a list of customer names who have no orders in the Orders table.
select Customers.ContactName
from Customers
full join Orders
on Orders.CustomerID = Customers.CustomerID
where Orders.OrderDate is null

--14. Write a query to add a shipper named 'Amazon' to the Shippers table using SQL.
insert into Shippers (CompanyName) values ('Amazon')


--15. Write a query to change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL.
update Shippers
set CompanyName = 'Amazon Prime Shipping'
where CompanyName = 'Amazon'

--16. Write a query to return a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.
select convert(int, round(sum(case when CompanyName = 'Speedy Express' then Freight else 0 end), 0)) as 'Speedy Express',
       convert(int, round(sum(case when CompanyName = 'United Package' then Freight else 0 end), 0)) as 'United Package',
	   convert(int, round(sum(case when CompanyName = 'Federal Shipping' then Freight else 0 end), 0)) as 'Federal Shipping'	   
from Shippers
full join Orders
on Shippers.ShipperID = Orders.ShipVia


--17. Write a query to return all employee first and last names from the Employees table by combining the 2 columns aliased as 'DisplayName'. The combined format should be 'LastName, FirstName'.
select concat(LastName, FirstName) as 'DisplayName'
from Employees


--18. Write a query to add yourself to the Customers table with an order for 'Grandma's Boysenberry Spread'.
insert into Customers (ContactName, CustomerID, CompanyName) values ('Kassandra Savage', 'KSAV', 'IDK Inc')
insert into Orders (CustomerID) values ('KSAV')
insert into [Order Details] (OrderID, ProductID) values (11078, 6)
--I didn't fill out every field because I didn't think it was necessary

--19. Write a query to remove yourself and your order from the database.
delete from [Order Details]
where OrderID = '11078'
delete from Orders
where OrderID = '11078'
delete from Customers
where CustomerID = 'KSAV'

--20. Write a query to return a list of products from the Products table along with the total units in stock for each product. Include only products with TotalUnits greater than 100.
select ProductName, sum(UnitsInStock + UnitsOnOrder) as TotalUnits
from Products
where UnitsInStock + UnitsOnOrder > 100
group by ProductName