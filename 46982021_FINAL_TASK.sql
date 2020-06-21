/*
 TASK 2.2 ( CREATION OF TABLES FOR THE SENTINEL CORPORATION MANAGEMENT SYSTEM )
*/
CREATE DATABASE EOTK46982021;

USE EOTK46982021;

CREATE TABLE COUNCIL_HEAD( Head_ID int(3) NOT NULL,
First_Name varchar(50) NOT NULL, Last_Name varchar(50) NOT NULL,Gender enum('Male','Female'),
Nationality varchar(50) NOT NULL, Military_Rank varchar(50) NOT NULL,
Department_Type varchar(50) NOT NULL, PRIMARY KEY(Head_ID));

CREATE TABLE DEPARTMENT (
Department_ID int(3) NOT NULL,Head_ID int(3) NOT NULL,
Department_Name varchar(20) NOT NULL,
Department_Function varchar(50) NOT NULL,
PRIMARY KEY(Department_ID),
FOREIGN KEY(Head_ID) REFERENCES  COUNCIL_HEAD(Head_ID));

CREATE TABLE PERSONNEL(Personnel_ID int(3) NOT NULL,
Department_ID int(3) NOT NULL, First_Name varchar(50) NOT NULL,
Last_Name varchar(50) NOT NULL,Gender enum('Male','Female'),
Nationality varchar(50) NOT NULL, Contact int(10) NOT NULL,
E_Mail varchar(50) NOT NULL, Date_Of_Initiation datetime,
Department_Type varchar(50) NOT NULL, PRIMARY KEY(Personnel_ID),
FOREIGN KEY(Department_ID) REFERENCES DEPARTMENT(Department_ID));

CREATE TABLE AIR_FORCE(Personnel_ID int(3) NOT NULL,
First_Name varchar(50) NOT NULL, Last_Name varchar(50) NOT NULL,Gender enum('Male','Female'),
Pilot_Rank varchar(50) NOT NULL,Nationality varchar(50) NOT NULL,
PRIMARY KEY(Personnel_ID));

CREATE TABLE AIRCRAFT( Plane_ID int(3) NOT NULL,
Plane_Type varchar(50) NOT NULL,
Personnel_ID int(3) NOT NULL, Plane_Location enum('Aircraft_Carrier','Military_Base'),
PRIMARY KEY(Plane_ID),FOREIGN KEY(Personnel_ID) REFERENCES AIR_FORCE(Personnel_ID));

CREATE TABLE MILITARY_MISSION(Mission_ID int(3) NOT NULL, Mission_Name varchar(50) NOT NULL,
Mission_Objective varchar(50) NOT NULL,Mission_Location varchar(50) NOT NULL,
High_Valued_Target varchar(50) NOT NULL,
Personnel_ID int(3) NOT NULL, PRIMARY KEY(Mission_ID),
FOREIGN KEY(Personnel_ID) REFERENCES AIR_FORCE(Personnel_ID));

 CREATE TABLE INFANTRY_FORCES(Personnel_ID int(3) NOT NULL,
 First_Name varchar(50) NOT NULL,Last_Name varchar(50) NOT NULL,Gender enum('Male','Female'),
 Date_Of_Initiation datetime, Status_Info enum('Active_On_Duty',
 'Killed_In_Action','Off_Duty','Retired'),
 Infantry_Type enum('Navy_Seal','Spetsnaz','Rangers','Marines',
 'Delta_Force'), Military_Rank varchar(50) NOT NULL,Mission_ID int(3) NOT NULL,
 PRIMARY KEY(Personnel_ID), FOREIGN KEY(Mission_ID) REFERENCES
 Military_Mission(Mission_ID));
 
 
 
 CREATE TABLE INTEL( Code_Name varchar(50) NOT NULL,First_Name varchar(50) NOT NULL,
 Last_Name varchar(50) NOT NULL,Terrorist_Location varchar(50) NOT NULL,
 Terrorist_Nationality varchar(50) NOT NULL,Gender enum('Male','Female'),
 Security_Type enum('Second_Division','First_Division','Third_Division'),
 Activity_Type enum('State_Terrorism','Bio_Terrorism','Cyber_Terrorism',
 'Eco_Terrorism','Nuclear_Terrorism','Narco_Terrorism'),
 Head_ID int(3) NOT NULL, Personnel_ID int(3) NOT NULL, PRIMARY KEY(Code_Name),
 FOREIGN KEY( Personnel_ID) REFERENCES INFANTRY_FORCES(Personnel_ID),
 FOREIGN KEY(Head_ID) REFERENCES COUNCIL_HEAD(Head_ID));
 
 CREATE TABLE NAVAL_CRUISERS(Cruiser_ID int(3) NOT NULL,
 Cruiser_Type enum('Frigate','Destroyer','Corvette',
 'Aircraft_Carrier','Attack_Submarine','Ballistic_Missile_Submarine'),
 Fleet_Category enum('Third_Fleet','Fourth_Fleet','Fifth_Fleet',
 'Sixth_Fleet','Seventh_Fleet','Tenth_Fleet'),PRIMARY KEY(Cruiser_ID));
 
 
 CREATE TABLE NAVAL_FORCE(Personnel_ID int(3) NOT NULL,First_Name varchar(50) NOT NULL,
 Last_Name varchar(50) NOT NULL,Gender enum('Male','Female'), Military_Rank varchar(50) NOT NULL,
 Nationality varchar(50) NOT NULL, CRUISER_ID int(3) NOT NULL, Objective_ID int(3) NOT NULL, PRIMARY KEY(Personnel_ID),
 FOREIGN KEY(Objective_ID) REFERENCES MILITARY_MISSION(Mission_ID));
 
 
 CREATE TABLE WEAPONS(Serial_Number int(3) NOT NULL,
 Weapon_Name varchar(50) NOT NULL,Manufacturer_Name varchar(50) NOT NULL,
 Number_Available int(5) NOT NULL,Objective_ID int(3) NOT NULL, PRIMARY KEY(Serial_Number),
 FOREIGN KEY(Objective_ID) REFERENCES MILITARY_MISSION(Mission_ID));
 
 
 /*
 TASK 2.3 ( CREATION OF INDEXES )
 */
 
 /*
The reason why I decided to create an index for Infantry personnels who have passed away is
that, as a military organization who have infantry personnels devoting their lives for a good 
course, there is the need for Sentinel Corporation to identify these fallen fallen soldiers and
 honor or aknowledge their heroism.
*/
CREATE INDEX FALLEN_SOLDIERS ON INFANTRY_FORCES(First_Name,Last_Name,Military_Rank,Status_Info);


/*
The reson behind the creation of this index, is to identify and help the Sentinel Organization keep
track of the prevalent countries, terrorists come from in other to help in their statistics 
perspective of the most dominated countries with most terrorists.
*/
CREATE INDEX TERRORIST_NATIONALS ON INTEL(First_Name,Last_Name,Terrorist_Nationality);


/*
The explanation behind my choice of this view is that just as Sun Tzu, a Military Strategist once said,"
“Know the enemy and know yourself; in a hundred battles you will never be defeated.”, if the Sentinel 
Special Forces do assess the strength of their enemy before an operation, they will be victorious becuase
knowing the Security type of your enemy helps them to know what they are up to.
*/
CREATE INDEX TERRORISTS_STRENGTH ON INTEL(First_Name,Last_Name, Terrorist_Location, Security_Type);


/*
The reson for the creation for this index, is becuase , since Sentinel's main priority
is to combat terrorism, an intel can be received at any point in time about a possible
threat across the globe, therefore just as Sun Tzu said,"The art of war is a subject
of inquiry which can on no account be neglected.”,therefore there should be
personnel’s currently present to conduct operations in case of an insurgency.
*/
CREATE INDEX ACTIVE_PERSONNELS ON INFANTRY_FORCES(First_Name,Last_Name,Military_Rank, Infantry_Type, Status_Info);


/*
 TASK 2.4 ( INSERTION OF INFORMATION INTO THE TABLES )
*/

/*
  INSERTING INFORMATION INTO THE COUNCIL_HEAD TABLE
*/
INSERT INTO COUNCIL_HEAD VALUES(001,"Alexando","Rodriguez",'Male',"Italian","Staff-Sergeant","Technology");
INSERT INTO COUNCIL_HEAD VALUES(002,"Emmanuel","Bane",'Male',"English","Staff-Sergeant","Weaponry");
INSERT INTO COUNCIL_HEAD VALUES(003,"Michael","Wayne",'Male',"American","Master-Sergeant","Sentinel_Space_Station");
INSERT INTO COUNCIL_HEAD VALUES(004,"Rejoice","Navas",'Female',"Russian","Captain","Poseidon");
INSERT INTO COUNCIL_HEAD VALUES(005,"Victoria","Lancaster",'Female',"Ghanaian","Master-Sergent","Kalidon");

/*
 INSERTING INFORMATION INTO THE DEPARTMENT_TABLE
*/
INSERT INTO DEPARTMENT VALUES(101, 001 ,"Technology","Application of technology in Military Operations");
INSERT INTO DEPARTMENT VALUES(102, 002 ,"Weaponry","Provision of Ammunitions for Military Operations");
INSERT INTO DEPARTMENT VALUES(103, 003 ,"Space_Station","Provision of Overwatch from above");
INSERT INTO DEPARTMENT VALUES(104, 004 ,"Poseidon","Monitoring of activites below sealevel");
INSERT INTO DEPARTMENT VALUES(105, 005 ,"Kalidon","Activation of Gunships and Project Skynet");

/*
INSERTING INFORMATION INTO PERSONNEL_TABLE
*/
INSERT INTO PERSONNEL VALUES(201,101,"Johnson","Price",'Male',"English",01234324567,"johnson.price@gmail.com","2001-09-12","Technology");
INSERT INTO PERSONNEL VALUES(202,102,"Peter","Vidic",'Male',"Serbian",0456765439,"peter.vidic@gmail.com","2003-03-03","Weaponry");
INSERT INTO PERSONNEL VALUES(203,103,"Mary","Winchester",'Female',"American",0345678543,"mary.winchester@gmail.com","2005-01-22","Sentinel_Space_Station");
INSERT INTO PERSONNEL VALUES(204,104,"Roland","Putin",'Male',"Russian",0890776545,"roland.putin@gmail.com","2002-10-12","Poseidon");
INSERT INTO PERSONNEL VALUES(205,105,"Claire","Robinson",'Female',"German",0765678543,"claire.robinson@gmail.com","2010-09-11","Kalidon");

/*
INSERTING INFORMATION INTO AIR_FORCE_TABLE
*/
INSERT INTO AIR_FORCE VALUES(2011,"Dean","Winchester",'Male',"Flight_Lieutenant","American");
INSERT INTO AIR_FORCE VALUES(2012,"James","Crowley",'Male',"Senior_Airman","Polish");
INSERT INTO AIR_FORCE VALUES(2021,"Castiel","Billy",'Male',"Airman_First_Class","Turkish");
INSERT INTO AIR_FORCE VALUES(2022,"Osman","Ibrahim",'Male',"Flight_Lieutenant","Syrian");
INSERT INTO AIR_FORCE VALUES(2031,"David","Blaine",'Male',"Staff_Sergeant","Indian");
INSERT INTO AIR_FORCE VALUES(2032,"Mavis","Winterfell",'Female',"Master_Sergeant","French");
INSERT INTO AIR_FORCE VALUES(2041,"Billy","Foster",'Male',"Senior_Master_Sergeant","Spanish");
INSERT INTO AIR_FORCE VALUES(2042,"Mary","Maicon",'Female',"Airman_First_Class","Brazilian");
INSERT INTO AIR_FORCE VALUES(2051,"Kelly","Frost",'Female',"Flight_Lieutenant","Columbian");
INSERT INTO AIR_FORCE VALUES(2052,"Tata","MacForest",'Male',"Senior_Airman","American");

/*
INSERTING INFORMATION INTO AIRCRAFT_TABLE
*/
INSERT INTO AIRCRAFT VALUES(1001,"F22-Raptor",2011,'Aircraft_Carrier');
INSERT INTO AIRCRAFT VALUES(1002,"A10-Thunderbolt",2012,'Military_Base');
INSERT INTO AIRCRAFT VALUES(1003,"F35_JSF",2021,'Military_Base');
INSERT INTO AIRCRAFT VALUES(1004,"Su-27_Flanker",2022,'Aircraft_Carrier');
INSERT INTO AIRCRAFT VALUES(1005,"MiG-29_Fulcrum",2031,'Aircraft_Carrier');

/*
INSERTING INFORMATION INTO MILITARY_MISSION_TABLE
*/
INSERT INTO MILITARY_MISSION VALUES(111,"Operation_Kingfish","Gathering of intel about Makarov","Plague,Czech Republic","Vladmir Makarov",2021);
INSERT INTO MILITARY_MISSION VALUES(112,"Operation_Mekong","Infiltrating a Columbian Cocaine Base","Leticia,Colombia","EL Chappo",2051);
INSERT INTO MILITARY_MISSION VALUES(113,"Operation_Hunter_Killer","Rescuing and Extraction of Russian President","Sursk,Russia","President Vorshevsky",2041);
INSERT INTO MILITARY_MISSION VALUES(114,"Operation_Hornet_Nest","Ground Assistance to the British SAS","London,England","Prime Minister Mileena",2031);
INSERT INTO MILITARY_MISSION VALUES(115,"Operation_Turbulence","Air Assistance to the French GIGN Forces","Marseille,France","Major Volk",2032);

/*
INSERTING INFORMATION INTO INFANTRY_FORCES_TABLE
*/
INSERT INTO INFANTRY_FORCES VALUES(2013,"Emmanuel","Kamarov",'Male',"2001-09-06",'Active_On_Duty','Spetsnaz',"Master_Sergeant",112);
INSERT INTO INFANTRY_FORCES VALUES(2014,"Bismark","Mikky",'Male',"2002-04-02",'Active_On_Duty','Navy_Seal',"Captain",112);
INSERT INTO INFANTRY_FORCES VALUES(2023,"Soap","Mactavish",'Male',"2000-09-06",'Active_On_Duty','Navy_Seal',"Captain",111);
INSERT INTO INFANTRY_FORCES VALUES(2024,"Joseph","Yuri",'Male',"2002-10-10",'Retired','Spetsnaz',"Master_Sergeant",111);
INSERT INTO INFANTRY_FORCES VALUES(2033,"Gerald","Michell",'Male',"2003-11-12",'Off_Duty','Marines',"Lieutenant",113);
INSERT INTO INFANTRY_FORCES VALUES(2034,"Michelle","Molotov",'Female',"2001-11-11",'Active_On_Duty','Delta_Force',"Corporal",113);
INSERT INTO INFANTRY_FORCES VALUES(2043,"Mary","Vendetta",'Female',"2004-12-12",'Retired','Rangers',"Senior_Master_Sergeant",114);
INSERT INTO INFANTRY_FORCES VALUES(2044,"Jason","Khan",'Male',"2005-09-21",'Active_On_Duty','Rangers',"Private",114);
INSERT INTO INFANTRY_FORCES VALUES(2053,"Ozone","Price",'Male',"2010-02-07",'Off_Duty','Delta_Force',"Sergeant",115);
INSERT INTO INFANTRY_FORCES VALUES(2054,"Michael","Corvinus",'Male',"2013-03-20",'Retired','Rangers',"Captain",115);
INSERT INTO INFANTRY_FORCES VALUES(2064,"Victor","Frankenstein",'Male',"2004-09-04",'Killed_In_Action',"Navy_Seal","Captain",115);
INSERT INTO INFANTRY_FORCES VALUES(2074,"Victoria","McCool",'Female',"2005-09-04",'Killed_In_Action',"Delta_Force","Corporal",114);
INSERT INTO INFANTRY_FORCES VALUES(2084,"Beatrice","Ricardo",'Female',"2007-02-08",'Killed_In_Action',"Rangers","Master_Sergeant",111);

/*
INSERTING INFORMATION INTO INTEL_TABLE
*/
INSERT INTO INTEL VALUES("Black_Viking","Vladmir","EL Chappo","Leticia,Colombia","Colombian",'Male','Second_Division','Cyber_Terrorism',005,2014);
INSERT INTO INTEL VALUES("KingFish","Roman","Makarov","Plague,Czech Republic","Russian",'Male','First_Division','State_Terrorism',004,2023);
INSERT INTO INTEL VALUES("Objective_False_Prophet","Manuel","Noriega","La Chorrera,Panama","Mexican",'Male','Third_Division','Bio_Terrorism',001,2013);
INSERT INTO INTEL VALUES("Hades","Osman","Frost","Karachi,Pakistan","Pakistani",'Male','First_Division','Narco_Terrorism',002,2053);
INSERT INTO INTEL VALUES("Dayni_Moon","Jason","Gulag","Kandahar,Afghanistan","Afghan",'Male','Third_Division','Nuclear_Terrorism',003,2044);

/*
INSERTING INFORMATION INTO NAVAL_CRUISERS_TABLE
*/
INSERT INTO NAVAL_CRUISERS VALUES(3001,'Frigate','Third_Fleet');
INSERT INTO NAVAL_CRUISERS VALUES(3002,'Destroyer','Seventh_Fleet');
INSERT INTO NAVAL_CRUISERS VALUES(3003,'Ballistic_Missile_Submarine','Fourth_Fleet');
INSERT INTO NAVAL_CRUISERS VALUES(3004,'Aircraft_Carrier','Fifth_Fleet');
INSERT INTO NAVAL_CRUISERS VALUES(3005,'Corvette','Sixth_Fleet');

/*
INSERTING INFORMATION INTO NAVAL_FORCE_TABLE
*/
INSERT INTO NAVAL_FORCE VALUES(2015,"Alex","Mason",'Male',"Seaman_Recruit","American",3004,113);
INSERT INTO NAVAL_FORCE VALUES(2025,"Illona","Marilyn",'Female',"Lieutenant","Russian",3004,114);
INSERT INTO NAVAL_FORCE VALUES(2035,"Michael","Brook",'Male',"Commander","French",3005,112);
INSERT INTO NAVAL_FORCE VALUES(2045,"Arlen","Cena",'Male',"Vice_Admiral","English",3005,113);
INSERT INTO NAVAL_FORCE VALUES(2055,"Alfred","Berkoh",'Male',"Fleet_Admiral","Ghanaian",3002,111);
INSERT INTO NAVAL_FORCE VALUES(2065,"Teddy","Carter",'Male',"Lieutenant_Commander","South African",3002,114);
INSERT INTO NAVAL_FORCE VALUES(2075,"Rachel","Tiger",'Female',"Ensign","Spanish",3001,112);
INSERT INTO NAVAL_FORCE VALUES(2085,"Marcus","Fenniz",'Male',"Captain","American",3001,111);
INSERT INTO NAVAL_FORCE VALUES(2095,"Ben","Carson",'Male',"Seaman_Apprentice","German",3003,115);
INSERT INTO NAVAL_FORCE VALUES(2016,"Gideon","Merlin",'Male',"Captain","English",3003,115);

/*
INSERTING INFORMATION INTO WEAPONS_TABLE
*/
INSERT INTO WEAPONS VALUES(123,"M4A1_Carbine","SpartanCorp,Ghana",5000,112);
INSERT INTO WEAPONS VALUES(124,"P90","UmbrellaCorp,Austria",6000,115);
INSERT INTO WEAPONS VALUES(125,"Barret50_Cal","LanternCorp,Israel",2000,114);
INSERT INTO WEAPONS VALUES(126,"Stinger","SpartanCorp,Ghana",1000,113);
INSERT INTO WEAPONS VALUES(127,"Dragnuv","Kalashnikova,Russia",3000,111);


/*
 TASK 2.5 ( CREATION OF QUEREIES WITH RESPECT TO THE OBJECTIVES )
*/

/*
QUERY ONE:
This query would be useful becuase in case of an emergency intel triggered as a result of terrorist
invasion across anywhere on the globe, Sentinel Organization needs to know the current number of 
personnels who are "Active on Duty" to carry out the military operations.
*/
SELECT Status_Info, COUNT(STATUS_INFO) FROM INFANTRY_FORCES WHERE STATUS_INFO like "A%" AND STATUS_INFO like "%Y";


/*
QUERY TWO:
As part of my objectives considered in the creation of this management system for the Sentinel Organization,
there is the need for the organization to know the status of its Special forces operators in order to help in 
terms of decisions as to what step to take with respect to a pending Military operation.
*/
SELECT First_Name,Last_Name,Status_Info,Infantry_Type,Military_Rank from INFANTRY_FORCES Order by Military_Rank;

/*
QUERY THREE:
As part of my objectives, this query would enable the Sentinel Organization to keep track
of the various Pilots and their respective Fighter jets they conducted military mission with for the 
purpose of future reference in case of a mission pilot or plane type so that the organization can trace 
their location.
*/
Select a.First_Name, a.Last_Name, a.Pilot_Rank, b.Plane_Type, b.Plane_Location from
 AIR_FORCE a , AIRCRAFT b WHERE a.Personnel_ID = b.Personnel_ID Order by Pilot_Rank;
 
 /*
 QUERY FOUR
 This query would help to achieve my objective for the Sentinel Organization
 which shows a visual representation of soldiers together with their respective
 missions they were being deployed to.
 */
 SELECT First_Name,Last_Name,Infantry_Type,Military_Rank,Mission_Name,Mission_Objective,
 Mission_Location,High_Valued_Target from INFANTRY_FORCES inner join MILITARY_MISSION ON
 INFANTRY_FORCES.Mission_ID = MILITARY_MISSION.Mission_ID order by First_Name;
 
 
 /*
 QUERY FIVE:
 This query would help to achieve the objective of recognising
 the respective fallen soldiers in order for their bravery and heroic attributes 
 to be remembered in the history of the corporation as heroes and legends.
 */
 SELECT a.First_Name, a.Last_Name, a.Infantry_Type,a.Status_Info, a.Military_Rank, b.Mission_Name, b.Mission_Objective,
 b.High_Valued_Target from INFANTRY_FORCES a , MILITARY_MISSION b where a.MISSION_ID = b.MISSION_ID AND
 a.Status_Info = 'Killed_In_Action' order by Infantry_Type;
 
 /*
 QUERY SIX:
 This query would help to achieve the objective of recognising
 the respective personnels working at the Sentinel Naval Force(Poseidon)
 in order to keep track of every personality and Naval Ship to avoid cases
 of destruction of Weapons of Mass Destruction(WMD).
 */
 Select Personnel_ID,First_Name,Last_Name,Gender,Military_Rank,Nationality,Cruiser_Type,Fleet_Category from
 NAVAL_FORCE inner join NAVAL_CRUISERS ON NAVAL_FORCE.Cruiser_ID = NAVAL_CRUISERS.Cruiser_ID order by Fleet_Category;
