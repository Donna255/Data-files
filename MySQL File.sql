CREATE DATABASE Infrastructure;
USE Infrastructure;

CREATE TABLE IF NOT EXISTS Provinces (
ProvinceID VARCHAR(2) PRIMARY KEY,
ProvinceName VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Agencies (
AgencyID INT  PRIMARY KEY AUTO_INCREMENT,
AgencyName VARCHAR(100) NOT NULL,
Contact VARCHAR(50) NOT NULL,
HQ_City VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Projects (
ProjectID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(100) NOT NULL,
Project_Type VARCHAR(100) NOT NULL,
StartDate DATE NOT NULL,
Deadline DATE NOT NULL,
Budget DECIMAL(15,2),
Status ENUM('Planned','In-Progress','Completed') NOT NULL,
ProvinceID VARCHAR(2),
AgencyID INT,
FOREIGN KEY (ProvinceID) REFERENCES Provinces(ProvinceID),
FOREIGN KEY (AgencyID) REFERENCES Agencies(AgencyID)
);

CREATE TABLE IF NOT EXISTS Contractors (
ContractorID INT  PRIMARY KEY AUTO_INCREMENT,
CompanyName VARCHAR(100),
Contact VARCHAR(50) NOT NULL,
HQ_City VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Subcontractors (
SubcontractorID INT  PRIMARY KEY AUTO_INCREMENT,
SubcontractorName VARCHAR(100) NOT NULL,
Contact VARCHAR(50) NOT NULL,
Task VARCHAR(100) NOT NULL,
HQ_City VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Projects_Contractors (
Project_contractorID INT PRIMARY KEY AUTO_INCREMENT,
ProjectID INT NOT NULL,
ContractorID INT NOT NULL,
FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
FOREIGN KEY (ContractorID) REFERENCES Contractors(ContractorID)
);

CREATE TABLE IF NOT EXISTS Contractors_Subcontractors (
Contractor_SubcontractorID INT PRIMARY KEY AUTO_INCREMENT,
SubcontractorID INT NOT NULL,
ContractorID INT NOT NULL,
FOREIGN KEY (SubcontractorID) REFERENCES Subcontractors(SubcontractorID),
FOREIGN KEY (ContractorID) REFERENCES Contractors(ContractorID)
);

CREATE TABLE IF NOT EXISTS  Service_Providers(
Service_ProviderID INT PRIMARY KEY AUTO_INCREMENT,
ProjectID INT NOT NULL,
Contractor_SubcontractorID INT NOT NULL,
FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
FOREIGN KEY (Contractor_SubcontractorID) REFERENCES Contractors_Subcontractors(Contractor_SubcontractorID)
);

INSERT INTO Provinces (ProvinceID, ProvinceName) VALUES
('ON', 'Ontario'),
('QC', 'Quebec'),
('BC', 'British Columbia'),
('AB', 'Alberta');

INSERT INTO Agencies (AgencyName, HQ_city, Contact) VALUES
('Infrastructure Canada', 'Ottawa', 'info@infrastructure.gc.ca'),
('Infrastructure Ontario', 'Toronto', 'projects@infrastructureontario.ca'),
('BC Infrastructure', 'Victoria', 'contact@bcinfrastructure.ca'),
('Transport Quebec', 'Quebec City', 'info@transportquebec.qc.ca'),
('Alberta Transportation', 'Edmonton', 'info@transportation.alberta.ca');

INSERT INTO Projects (Name, Project_Type, StartDate, Deadline, Budget, Status, ProvinceID, AgencyID) VALUES
('Toronto-York Spadina Subway Extension', 'Transportation', '2011-03-01', '2017-12-31', 3200000000.00, 'Completed', 'ON', 1 ),
('Champlain Bridge Replacement', 'Bridge', '2015-06-01', '2019-06-30', 4200000000.00, 'Completed', 'QC', 4),
('Port Mann Bridge Replacement', 'Bridge', '2009-01-01', '2015-12-31', 3300000000.00, 'Completed', 'BC', 3),
('Ontario Line Subway', 'Transportation', '2021-10-01', '2030-12-31', 10900000000.00, 'In-Progress', 'ON', 2),
('Réseau express métropolitain (REM)', 'Transportation', '2018-04-01', '2024-12-31', 6900000000.00, 'In-Progress', 'QC', 1),
('Broadway Subway Project', 'Transportation', '2021-01-01', '2026-12-31', 2880000000.00, 'In-Progress', 'BC', 3),
('High Frequency Rail Corridor', 'Rail', '2025-01-01', '2032-12-31', 12000000000.00, 'Planned', 'ON', 2),
('Quebec City Tramway', 'Transportation', '2024-09-01', '2029-12-31', 3300000000.00, 'Planned', 'QC', 4),
('Surrey-Langley SkyTrain', 'Transportation', '2024-01-01', '2028-12-31', 3900000000.00, 'Planned', 'BC', 3);

INSERT INTO Contractors (CompanyName, Contact, HQ_city) VALUES
('EllisDon Corporation', 'contact@ellisdon.com', 'Toronto'),
('PCL Construction', 'info@pcl.com', 'Edmonton'),
('Aecon Group Inc.', 'projects@aecon.com', 'Toronto'),
('SNC-Lavalin', 'info@snclavalin.com', 'Montreal'),
('Graham Construction', 'contact@graham.ca', 'Calgary'),
('Ledcor Group', 'info@ledcor.com', 'Vancouver'),
('Bird Construction', 'projects@bird.ca', 'Toronto'),
('Maple Reinders', 'contact@maplereinders.com', 'Toronto'),
('Coco Paving Inc.', 'info@cocopaving.com', 'Toronto'),
('TESC Contracting', 'projects@tesc.ca', 'Vancouver');

INSERT INTO Subcontractors (SubcontractorName, HQ_city, Task, Contact) VALUES
('Toronto Electrical Services', 'Toronto', 'Electrical Work', 'tes@electrical.ca'),
('Montreal Plumbing Co.', 'Montreal', 'Plumbing Systems', 'mpc@plumbing.qc.ca'),
('Vancouver Concrete Ltd.', 'Vancouver', 'Concrete Work', 'vcl@concrete.bc.ca'),
('Calgary Steel Fabricators', 'Calgary', 'Steel Structures', 'csf@steel.ab.ca'),
('Ontario Earthworks', 'Toronto', 'Excavation & Grading', 'oe@earthworks.on.ca'),
('Quebec Mechanical Systems', 'Montreal', 'HVAC Systems', 'qms@mechanical.qc.ca'),
('BC Landscaping Co.', 'Vancouver', 'Site Landscaping', 'bcl@landscaping.bc.ca'),
('Alberta Paving Specialists', 'Edmonton', 'Road Paving', 'aps@paving.ab.ca'),
('Toronto Safety Consultants', 'Toronto', 'Safety Compliance', 'tsc@safety.on.ca'),
('Montreal Environmental Services', 'Montreal', 'Environmental Monitoring', 'mes@environment.qc.ca');

INSERT INTO Projects_Contractors (ProjectID, ContractorID) VALUES
(1, 1), (1, 3), 
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 1), (4, 3), (4, 7),
(5, 4), (5, 8),
(6, 6), (6, 10),
(7, 1), (7, 3),
(8, 4), (8, 8), 
(9, 6), (9, 10);

INSERT INTO Contractors_Subcontractors (ContractorID, SubcontractorID) VALUES
(1, 1), (1, 5), (1, 9),
(2, 4), (2, 8), (2, 9),
(3, 1), (3, 5), (3, 9),
(4, 2), (4, 6), (4, 10),
(5, 4), (5, 8), (5, 9),
(6, 3), (6, 7), (6, 9),
(7, 1), (7, 5), (7, 9),
(8, 2), (8, 6), (8, 10),
(9, 5), (9, 8), (9, 9),
(10, 3), (10, 7), (10, 9);

INSERT INTO Service_Providers (ProjectID, Contractor_SubcontractorID) VALUES
(1, 1), (1, 8),
(2, 10), (2, 14),
(3, 18), (3, 21),
(4, 3), (4, 7), (4, 20),
(5, 12), (8, 22),
(6, 16), (6, 29),
(7, 2), (7, 7),
(8, 10), (8, 23),
(9, 17), (9, 28);

-- DROP DATABASE Infrastructure;

SELECT Name FROM Projects JOIN Provinces ON Projects.ProvinceID = Provinces.ProvinceID WHERE ProvinceName = 'Ontario';

SELECT Name FROM Projects WHERE Status = 'In-Progress';

SELECT CompanyName, Count(*) AS NumberProject FROM Contractors JOIN Projects_Contractors ON Projects_Contractors.ContractorID = Contractors.ContractorID GROUP BY Projects_Contractors.ContractorID;

SET SQL_SAFE_UPDATES = 0;
UPDATE Projects SET Status = 'Completed' WHERE Name = 'Ontario Line Subway';
SET SQL_SAFE_UPDATES = 1;

SELECT ProvinceName, SUM(Budget) FROM Projects INNER JOIN Provinces ON Projects.ProvinceID = Provinces.ProvinceID GROUP BY ProvinceName;
