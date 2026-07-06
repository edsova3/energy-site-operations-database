DROP DATABASE IF EXISTS SouthernOhioInfoWarehouse; 

  

CREATE DATABASE SouthernOhioInfoWarehouse; 

  

USE SouthernOhioInfoWarehouse; 

  

CREATE TABLE Facility( 

FacilityID INT AUTO_INCREMENT PRIMARY KEY, 

FacilityName VARCHAR(50), 

County VARCHAR (30), 

City VARCHAR (30), 

State CHAR (2), 

StreetAddress VARCHAR(50) 

); 

  

CREATE TABLE Equipment( 

EquipmentID INT AUTO_INCREMENT PRIMARY KEY, 

EquipmentName VARCHAR(40), 

EquipmentType VARCHAR(40), 

PurchaseDate DATE, 

EquipmentStatus VARCHAR(40), 

EquipmentSerialNumber VARCHAR(40), 

ModelNumber VARCHAR(40), 

FacilityID INT, 

CONSTRAINT FK_Equipment_Facility FOREIGN KEY (FacilityID) REFERENCES Facility (FacilityID)  

); 

  

CREATE TABLE InspectionRecord( 

InspectionID INT AUTO_INCREMENT PRIMARY KEY, 

InspectionDate DATE, 

InspectorFirstName VARCHAR(30), 

InspectorLastName VARCHAR(30), 

InspectionType VARCHAR(30), 

Result CHAR(1), 

EquipmentID INT, 

CONSTRAINT FK_InspectionRecord_Equipment FOREIGN KEY  (EquipmentID) REFERENCES Equipment (EquipmentID) 

); 

  

CREATE TABLE Employee( 

EmployeeID INT AUTO_INCREMENT PRIMARY KEY, 

EmployeeFirstName VARCHAR(30), 

EmployeeLastName VARCHAR(30), 

PhoneNumber VARCHAR(20), 

StreetAddress VARCHAR(50), 

EmailAddress VARCHAR(100), 

JobTitle VARCHAR(50), 

Department VARCHAR(50), 

HireDate DATE, 

FacilityID INT, 

CONSTRAINT FK_Employee_Facility FOREIGN KEY (FacilityID) REFERENCES Facility (FacilityID) 

); 

  

CREATE TABLE MaintenanceRecord( 

MaintenanceID INT AUTO_INCREMENT PRIMARY KEY, 

MaintenanceDate DATE, 

TechnicianFirstName VARCHAR(30), 

TechnicianLastName VARCHAR(30), 

Description VARCHAR(250), 

Cost DECIMAL(10, 2), 

WorkOrderNumber VARCHAR(30), 

EquipmentID INT, 

MaintenanceStatus VARCHAR(20), 

CONSTRAINT FK_MaintenanceRecord_Equipment FOREIGN KEY (EquipmentID) REFERENCES Equipment (EquipmentID) 

); 

  

INSERT INTO FACILITY 

(FacilityName, County, City, State, StreetAddress) 

VALUES 

('Piketon Operations Center', 'Pike', 'Piketon', 'OH', '100 Energy Drive'), 

('Scioto Maintenance Hub', 'Scioto', 'Portsmouth', 'OH', '250 Industrial Blvd'), 

('Ross Regional Service Center', 'Ross', 'Chillicothe', 'OH', '75 Commerce Way'); 

  

SELECT * FROM Facility; 

  

INSERT INTO EQUIPMENT 

(EquipmentID, FacilityID, EquipmentName) 

VALUES 

(1,	1,	'Transformer T-101'), 

(2,	1,	'Cooling Pump CP-12'), 

(3,	2,	'Conveyor Motor M-8'), 

(4,	3,	'Backup Generator'); 

  

SELECT * FROM EQUIPMENT; 

  

INSERT INTO EMPLOYEE 

(EmployeeID, FacilityID, EmployeeFirstName, EmployeeLastName, Department) 

VALUES 

(1, 1, 'Sarah', 'Jones', 'Maintenance'), 

(2, 1, 'Mike', 'Davis', 'Operations'), 

(3, 2, 'Emily', 'Brown', 'Safety'); 

  

SELECT *  FROM EMPLOYEE; 

  

INSERT INTO InspectionRecord 

(InspectionDate, InspectorFirstName, InspectorLastName, InspectionType, Result, EquipmentID) 

VALUES 

('2026-06-01', 'Emily', 'Brown', 'Safety', 'P', 2), 

('2026-06-05', 'Sarah', 'Jones', 'Mechanical', 'F', 3), 

('2026-06-08', 'Mike', 'Davis', 'Routine', 'P', 4); 

  

SELECT * FROM INSPECTIONRECORD; 

  

INSERT INTO MAINTENANCERECORD 

(MaintenanceDate, TechnicianFirstName, TechnicianLastName, Description, Cost, WorkOrderNumber, EquipmentID, MaintenanceStatus) 

VALUES 

('2026-06-10', 'Sarah', 'Jones', 'Oil Change', 125.00, 'WO-1001', 1, 'Completed'), 

('2026-06-12', 'Mike', 'Davis', 'Bearing replacement', 840.50, 'WO-1002', 3, 'Completed'), 

('2026-06-14', 'Emily', 'Brown', 'Routine Lubrication', 75.00, 'WO-1003',  2, 'Completed'); 

  
-- 1. Find all failed inspections

SELECT
    ir.EquipmentID,
    e.EquipmentName,
    ir.InspectionDate,
    ir.Result,
    ir.InspectionType
FROM inspectionrecord AS ir
JOIN equipment AS e
ON ir.EquipmentID = e.EquipmentID
WHERE ir.Result = 'F';


-- 2. Show all inspection records with equipment names

SELECT
    e.EquipmentID,
    e.EquipmentName,
    ir.InspectionID,
    ir.InspectionDate,
    ir.InspectorFirstName,
    ir.InspectorLastName,
    ir.InspectionType,
    ir.Result
FROM inspectionrecord AS ir
JOIN equipment AS e
ON ir.EquipmentID = e.EquipmentID;


-- 3. Which single maintenance job cost the most?

SELECT
    e.EquipmentName,
    mr.Description,
    mr.Cost
FROM maintenancerecord AS mr
JOIN equipment AS e
ON mr.EquipmentID = e.EquipmentID
ORDER BY mr.Cost DESC
LIMIT 1;


-- 4. How much has each facility spent on maintenance?

SELECT
    f.FacilityID,
    f.FacilityName,
    SUM(mr.Cost) AS TotalMaintenanceCost
FROM facility AS f
JOIN equipment AS e
ON f.FacilityID = e.FacilityID
JOIN maintenancerecord AS mr
ON e.EquipmentID = mr.EquipmentID
GROUP BY
    f.FacilityID,
    f.FacilityName
ORDER BY TotalMaintenanceCost DESC;


-- 5. Which equipment is located at each facility?

SELECT
    e.EquipmentID,
    e.EquipmentName,
    f.FacilityID,
    f.FacilityName
FROM equipment AS e
JOIN facility AS f
ON e.FacilityID = f.FacilityID
ORDER BY
    f.FacilityName,
    e.EquipmentName;


-- 6. Which employees work at each facility?

SELECT
    e.EmployeeID,
    e.EmployeeFirstName,
    e.EmployeeLastName,
    e.Department,
    f.FacilityID,
    f.FacilityName
FROM facility AS f
JOIN employee AS e
ON f.FacilityID = e.FacilityID
ORDER BY
    f.FacilityName,
    e.EmployeeLastName;


-- 7. Which equipment has never failed inspection?

SELECT
    e.EquipmentID,
    e.EquipmentName
FROM equipment AS e
WHERE e.EquipmentID NOT IN
(
    SELECT
        ir.EquipmentID
    FROM inspectionrecord AS ir
    WHERE ir.Result = 'F'
);


-- 8. Which inspections occurred in June?

SELECT
    ir.InspectionID,
    ir.InspectionDate,
    e.EquipmentID,
    e.EquipmentName
FROM inspectionrecord AS ir
JOIN equipment AS e
ON ir.EquipmentID = e.EquipmentID
WHERE ir.InspectionDate BETWEEN '2026-06-01' AND '2026-06-30';
