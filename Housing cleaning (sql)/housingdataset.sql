/*
In this project i intend to clean the data regarding the housing and property 
using SQL query

*/

select * from dbo.housingdata

-----------------------------------------------------------------------------------------------------------------------------

--here original data had the saledate column as datetime datatype ,so I changed the datatype to date
--to change datetime into date for saledate column
alter table dbo.housingdata alter column SaleDate Date;


select  SaleDate from dbo.housingdata;
-----------------------------------------------------------------------------------------------------------------------------
--In our dataset, PropertyAddress column had nulls evenif it has a valid parcelID ,
--To fix this,I noticed that a parcelID is unique to the PropertyAddress, so if two rows have different uniqueID but it has same parcelID,
--then both must have the same Address too.
select* from dbo.housingdata
where PropertyAddress is null
order by ParcelID

--lets now select the rows with different uniqueID but same parcelID and if one of them has null propertyAddress,
--we'd change it into the corresponding address

select h1.ParcelID,h1.PropertyAddress , h2.ParcelID,h2.PropertyAddress,isnull(h1.PropertyAddress,h2.PropertyAddress)
from dbo.housingdata h1 join  
dbo.housingdata h2
on h1.ParcelID = h2.ParcelID
and h1.UniqueID <> h2.[UniqueID ]
where h1.PropertyAddress is null
order by h1.ParcelID

--here i have updated all the Property addresses where value is null but it has a valid parcelid
UPDATE h1
set h1.PropertyAddress = isnull(h1.PropertyAddress,h2.PropertyAddress)
from dbo.housingdata h1 join  
dbo.housingdata h2
on h1.ParcelID = h2.ParcelID
and h1.UniqueID <> h2.[UniqueID ]
where h1.PropertyAddress is null

select * from dbo.housingdata
where PropertyAddress is null

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Breaking out Address into Individual Columns (Address,City ,State)
select PropertyAddress from dbo.housingdata

--Here I have selected the 2 substrings of PropertyAddress separated by commas for address and city of property 
select substring(PropertyAddress,1,charindex(',',PropertyAddress)-1) as address
,substring(PropertyAddress,charindex(',',PropertyAddress)+1,len(PropertyAddress)) as city
from dbo.housingdata

--Now , lets add two new columns for splitted-address and splitted-city and update these columns with the substrings
alter table dbo.housingdata 
add PropertySplitAddress nvarchar(255)

update dbo.housingdata
set PropertySplitAddress = substring(PropertyAddress,1,charindex(',',PropertyAddress)-1)

alter table dbo.housingdata 
add PropertySplitCity nvarchar(255)

update dbo.housingdata
set PropertySplitCity = substring(PropertyAddress,charindex(',',PropertyAddress)+1,len(PropertyAddress))


select * from dbo.housingdata

--Here again,I created splitted address and city column from the OwnerAddress column,but using a simpler method i.e parsename.
select parsename(replace(OwnerAddress,',','.'),3) as owneraddress,
parsename(replace(OwnerAddress,',','.'),2) as ownercity,
parsename(replace(OwnerAddress,',','.'),1) as ownerstate
from dbo.housingdata


--Now , lets add three new columns for splitted-address , splitted-city and splitted-state & update these columns with the substrings
alter table dbo.housingdata
add OwnerSplitAddress nvarchar(255)

update dbo.housingdata
set OwnerSplitAddress = parsename(replace(OwnerAddress,',','.'),3)


alter table dbo.housingdata
add OwnerSplitCity nvarchar(255)

update dbo.housingdata 
set OwnerSplitCity = parsename(replace(OwnerAddress,',','.'),2)

alter table dbo.housingdata
add OwnerSplitState nvarchar(255)

update dbo.housingdata 
set OwnerSplitState = parsename(replace(OwnerAddress,',','.'),1)


select * from dbo.housingdata

-------------------------------------------------------------------------------------------------------------------------------
--In our data set, column SoldAsVacant had some mixed values ,So we updated all the Ys and Ns to Yes and No respectively.
select distinct(SoldAsVacant),count(SoldAsVacant) as Counts from dbo.housingdata
group by SoldAsVacant

select SoldAsVacant ,
case SoldAsVacant 
when 'Y' then 'Yes'
when 'N' then 'No'
else SoldAsVacant
end 
from dbo.housingdata


update dbo.housingdata 
set SoldAsVacant = 
case SoldAsVacant 
when 'Y' then 'Yes'
when 'N' then 'No'
else SoldAsVacant
end 

select distinct(SoldAsVacant),count(SoldAsVacant) as Counts from dbo.housingdata
group by SoldAsVacant

---------------------------------------------------------------------------------------------------------------------------------
