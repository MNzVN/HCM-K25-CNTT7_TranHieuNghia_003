create database if not exists final_db;
use final_db;

create table Guests(
	quest_id int primary key auto_increment,
    full_name varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(15) not null unique,
    loyalty_points int default 0 check (loyalty_points >= 0)
);

create table Guest_Profiles(
	profile_id int primary key auto_increment,
    quest_id int unique,
    address varchar(255) not null,
    birthday date not null,
    national_id int not null unique,
    constraint quest_id_fk_Guest_Profiles foreign key (quest_id) references Guests(quest_id)
);

create table Rooms(
	room_id int primary key auto_increment,
    room_name varchar(100) not null,
    room_type enum('Standard','Deluxe','Suite'),
    price_per_night decimal(10,0) not null check(price_per_night>0),
    room_status enum('Available','Occupied','Maintenance')
);

create table Bookings(
	booking_id int primary key auto_increment,
    guest_id int unique,
    check_in_date date not null,
    check_out_date date not null check (check_out_date > check_in_date),
    total_charge decimal(10,0) not null check (total_charge>0),
    booking_status enum('Pending','Completed','Cancelled'),
    room_id int unique,
    constraint quest_id_fk_Bookings foreign key (quest_id) references Guests(quest_id),
    constraint room_id_fk_Bookings foreign key (room_id) references Rooms(room_id)
);

create table Room_Log(
	log_id int primary key auto_increment,
    room_id int unique,
    action_type enum('Check-in','Check-out','Cancelled','Maintenance'),
    change_note text not null,
    logged_at datetime 
);

insert into Guests (full_name, email, phone, loyalty_points) values
('Nguyen Van A', 'anv@gmail.com', '901234567', 150),
('Tran Thi B', 'btt@gmail.com', '912345678', 500),
('Le Van C', 'cle@gmail.com', '922334455', 0),
('Nguyen Van A', 'anv@gmail.com', '901234567', 150),
('Nguyen Van A', 'anv@gmail.com', '901234567', 150);

