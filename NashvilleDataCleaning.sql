-- Convert to date the standardized date format
SELECT SaleDate, STR_TO_DATE(SaleDate, '%M %d, %Y') as StandardDate
FROM Nashvillle_Housing.nashvillehousingdata;

UPDATE Nashvillle_Housing.nashvillehousingdata
SET SaleDate = STR_TO_DATE(SaleDate, '%M %d, %Y');

Select SaleDate 
from Nashvillle_Housing.nashvillehousingdata;



-- Populate property address

Update Nashvillle_Housing.nashvillehousingdata as a
join ( 
 select  b.ParcelID, b.PropertyAddress
 from Nashvillle_Housing.nashvillehousingdata as b 
 where PropertyAddress <> '' 
)
as b on a.ParcelID = b.ParcelID
set a.PropertyAddress = b.PropertyAddress
where a.PropertyAddress = '';

select *
from Nashvillle_Housing.nashvillehousingdata ;



-- Arranging out address format properly for property address

select 
substring(PropertyAddress,1, locate(',', PropertyAddress) -1) as Address,
substring(PropertyAddress, locate(',', PropertyAddress) +1) as City
from Nashvillle_Housing.nashvillehousingdata ;


Alter table Nashvillle_Housing.nashvillehousingdata 
add Address nvarchar(200);

update Nashvillle_Housing.nashvillehousingdata 
set Address = substring(PropertyAddress,1, locate(',', PropertyAddress) -1);

Alter table Nashvillle_Housing.nashvillehousingdata 
add City nvarchar(200);

update Nashvillle_Housing.nashvillehousingdata 
set City = substring(PropertyAddress, locate(',', PropertyAddress) +1);


-- Arranging out address format properly for owner address
select * from Nashvillle_Housing.nashvillehousingdata;


select 
OwnerAddress,
substring(OwnerAddress,1, locate(',', OwnerAddress) -1) as OwnerStreet,
substring(OwnerAddress, locate(',', OwnerAddress) + 1, locate(',', OwnerAddress, locate(',', OwnerAddress) +1) -locate(',', OwnerAddress) -1) as OwnerTown,
substring(OwnerAddress, locate(',', OwnerAddress, locate(',', OwnerAddress) +1) +1) as OwnerCity
from Nashvillle_Housing.nashvillehousingdata;

Alter table Nashvillle_Housing.nashvillehousingdata 
add OwnerStreet nvarchar(200);

update Nashvillle_Housing.nashvillehousingdata 
set OwnerStreet = substring(OwnerAddress,1, locate(',', OwnerAddress) -1);

Alter table Nashvillle_Housing.nashvillehousingdata 
add OwnerTown nvarchar(200);

update Nashvillle_Housing.nashvillehousingdata 
set OwnerTown = substring(OwnerAddress, locate(',', OwnerAddress) + 1, 
locate(',', OwnerAddress, locate(',', OwnerAddress) +1) -locate(',', OwnerAddress) -1);

Alter table Nashvillle_Housing.nashvillehousingdata 
add OwnerCity nvarchar(200);

update Nashvillle_Housing.nashvillehousingdata 
set OwnerCity = substring(OwnerAddress, locate(',', OwnerAddress, locate(',', OwnerAddress) +1) +1);

-- Chnage Y and N to Yes and No respectively from SoldAsVacant Column

select SoldAsVacant, 
case when SoldAsVacant = 'Y' then  'Yes'
	 when SoldAsVacant = 'N' then  'No'
     else SoldAsVacant
end as SoldasVacantCorrect
from Nashvillle_Housing.nashvillehousingdata;

update Nashvillle_Housing.nashvillehousingdata
Set SoldAsVacant = case when SoldAsVacant = 'Y' then  'Yes'
	               when SoldAsVacant = 'N' then  'No'
                   else SoldAsVacant
                   end ;
                   
select distinct(SoldAsVacant), count(SoldAsVacant)
from Nashvillle_Housing.nashvillehousingdata
group by SoldAsVacant;

 
 -- Remove unwanted columns
 alter table Nashvillle_Housing.nashvillehousingdata
 drop column PropertyAddress,
 drop column OwnerAddress;
 
 
 

  