create database HOSPITAL
use HOSPITAL
go

create table Department
(
	Department_ID int identity(1,1) not null,
	Name varchar (50) not null,
	Phone varchar(11) not null,
	Location varchar(100) not null,
	PRIMARY KEY (Department_ID)
);

create table Nurse
(
	Nurse_ID int identity(1,1) not null,
	First_Name varchar(20) not null,
	Last_Name varchar(20) not null,
	Phone varchar(11) not null,
	Department_ID int not null,
	PRIMARY KEY (Nurse_ID),
	FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

create table Room
(
	Room_ID int identity(1,1) not null,
	Room_No int not null UNIQUE,
	Type varchar (15) not null,
	Nurse_ID int not null,
	PRIMARY KEY (Room_ID),
	FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID)
);

create table Patient
(
	Patient_ID int identity(1,1) not null,
	First_Name varchar(25) not null,
	Last_Name varchar(25) not null,
	Gender varchar(10) not null CHECK (Gender IN ('Male','Female')),
	Date_of_Birth date not null,
	Address varchar(100) not null,
	Room_ID int not null,
	PRIMARY KEY (Patient_ID),
	FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

create table Patient_Phone
(
	Phone varchar(11) not null,
	Patient_ID int not null,
	FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
	PRIMARY KEY(Phone, Patient_ID)
);

create table Care_For
(
	Patient_ID int not null,
	Nurse_ID int not null,
	FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
	FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID),
	PRIMARY KEY(Patient_ID, Nurse_ID)
);

create table Doctor
(
	Doctor_ID int identity(1,1) not null,
	First_Name varchar(25) not null,
	Last_Name varchar(25) not null,
	Specialization varchar(150)  not null,
	Phone varchar(11) not null,
	Address varchar(150) not null,
	Department_ID int not null,
	PRIMARY KEY (Doctor_ID),
	FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

create table Treat
(
	Patient_ID int not null,
	Doctor_ID int not null,
	FOREIGN KEY (Patient_ID) REFERENCES  Patient(Patient_ID),
	FOREIGN KEY (Doctor_ID) REFERENCES  Doctor(Doctor_ID),
	PRIMARY KEY (Patient_ID, Doctor_ID)
);

create table Bill
(
	Bill_ID int identity(1,1) not null,
	Total_Amount decimal(10,2) not null,
	Date DATE not null,
	Status varchar(10) not null CHECK (Status IN ('Paid','Unpaid','Pending')),
	Patient_ID int not null,
	PRIMARY KEY (Bill_ID),
	FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

create table Appointment
(
	Appointment_ID int identity(1,1) not null,
	Date date not null,
	Time time not null,
	Diagnosis varchar(250) not null,
	Patient_ID int not null,
	PRIMARY KEY (Appointment_ID),
	FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

create table Medicine
(
	Medicine_ID int identity(1,1) not null,
	Name varchar(50) not null,
	Quantity_in_Stock int not null,
	Price decimal(10,2) not null,
	Expiry_Date date not null,
	PRIMARY KEY (Medicine_ID)
);

create table Prescribed_To
(
	Patient_ID int not null,
	Medicine_ID int not null,
	Dosage varchar(50) not null,
	FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
	FOREIGN KEY (Medicine_ID) REFERENCES Medicine(Medicine_ID),
	PRIMARY KEY (Patient_ID, Medicine_ID)
);
