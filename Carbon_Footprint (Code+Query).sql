create database Carbon_Footprint
GO
use Carbon_Footprint
GO
create table users (
    user_id int primary key,
    name varchar(100),
    email varchar(100) unique,
    location varchar(100),
    join_date date
)
GO
create table categories (
    category_id int primary key,
    category_name varchar(100) unique
)
GO
create table activities (
    activity_id int primary key, 

    activity_name varchar(100),
    category_id int,
    emission_factor decimal(10,2),
    unit varchar(100),
    constraint activities_fk foreign key (category_id)
    references categories(category_id)
)
GO
create table user_activities (
    log_id int primary key,
    user_id int,
    activity_id int,
    quantity decimal(10,2),
    activity_date date,
    constraint user_fk foreign key (user_id)
    references users(user_id),
    constraint activity_fk foreign key (activity_id)
    references activities(activity_id)
)
GO
create table emissions_log (
    log_id int primary key,
    co2_emission decimal(10,2),
    constraint log_fk foreign key (log_id)
    references user_activities(log_id)
)
GO
create table goals (
    goal_id int primary key,
    user_id int,
    goal_name varchar(100),
    target_value decimal(10,2),
    start_date date,
    end_date date,
    constraint goals_user_fk foreign key (user_id)
    references users(user_id)
)
GO
create table rewards (
    reward_id int primary key,
    reward_name varchar(100),
    points_required int
)
GO
create table user_rewards (
    user_reward_id int primary key,
    user_id int,
    reward_id int,
    claim_date date,
    constraint ur_user_fk foreign key (user_id)
    references users(user_id),
    constraint ur_reward_fk foreign key (reward_id)
    references rewards(reward_id)
)
GO
create table projects (
    project_id int primary key,
    project_name varchar(100),
    category_id int,
    description varchar(200),
    constraint project_category_fk foreign key (category_id)
    references categories(category_id)
)
GO
create table donations (
    donation_id int primary key,
    user_id int,
    project_id int,
    amount decimal(10,2),
    donation_date date,
    constraint donation_user_fk foreign key (user_id)
    references users(user_id),
    constraint donation_project_fk foreign key (project_id)
    references projects(project_id)
)
GO
create table reports (
    report_id int primary key,
    user_id int,
    report_month varchar(100),
    total_emissions decimal(10,2),
    constraint reports_user_fk foreign key (user_id)
    references users(user_id)
)
GO
create table project_impact (
    impact_id int primary key,
    project_id int,
    impact_description varchar(200),
    co2_saved decimal(10,2),
    recorded_date date,
    constraint impact_project_fk foreign key (project_id)
    references projects(project_id)
)
GO
create table category_statistics (
    stat_id int primary key,
    category_id int,
    average_emission decimal(10,2),
    total_activities_logged int,
    last_updated date,
    constraint stat_category_fk foreign key (category_id)
    references categories(category_id)
)
GO
create table report_goals (
    report_id int,
    goal_id int,
    constraint report_goals_pk primary key (report_id, goal_id),
    constraint rg_report_fk foreign key (report_id)
    references reports(report_id),
    constraint rg_goal_fk foreign key (goal_id)
    references goals(goal_id)
)
GO

insert into [dbo].[users] values
(1, 'Ayesha Rahman', 'ayesha@example.com', 'Dhaka', '2024-01-10'),
(2, 'Tanvir Ahmed', 'tanvir@example.com', 'Chittagong', '2024-02-12'),
(3, 'Nadia Karim', 'nadia@example.com', 'Khulna', '2024-03-05'),
(4, 'Hasibul Islam', 'hasib@example.com', 'Sylhet', '2024-03-22'),
(5, 'Mithila Chowdhury', 'mithila@example.com', 'Rajshahi', '2024-04-01'),
(6, 'Rafi Khan', 'rafi@example.com', 'Dhaka', '2024-05-08'),
(7, 'Sadia Noor', 'sadia@example.com', 'Barishal', '2024-06-15'),
(8, 'Imran Hossain', 'imran@example.com', 'Rangpur', '2024-07-10'),
(9, 'Farzana Alam', 'farzana@example.com', 'Mymensingh', '2024-08-02'),
(10, 'Kamrul Hasan', 'kamrul@example.com', 'Dhaka', '2024-09-01');
select * from users
GO

insert into [dbo].[categories] values
(1, 'Renewable Energy'),       
(2, 'Transportation'),         
(3, 'Waste Management'),       
(4, 'Food Consumption'),       
(5, 'Water Usage'),           
(6, 'Recycling'),              
(7, 'Energy Efficiency'),      
(8, 'Green Projects'),         
(9, 'Sustainable Living'),     
(10, 'Environmental Awareness');
select * from categories
GO
insert into [dbo].[activities] values
(1, 'Car Travel', 2, 2.31, 'km'),           
(2, 'Bus Travel', 2, 0.12, 'km'),           
(3, 'Electricity Usage', 1, 0.85, 'kWh'),   
(4, 'Meat Consumption', 4, 27.00, 'kg'),    
(5, 'Plastic Waste', 3, 6.00, 'kg'),        
(6, 'Water Usage', 5, 0.35, 'liter'),       
(7, 'Online Shopping', 9, 1.80, 'order'),   
(8, 'Flight Travel', 2, 90.00, 'hour'),     
(9, 'Paper Use', 6, 0.10, 'sheet'),         
(10, 'Solar Power Generation', 1, -0.50, 'kWh');
select * from activities
GO

insert into [dbo].[user_activities] values
(1, 1, 1, 15, '2025-10-01'),
(2, 1, 3, 120, '2025-10-02'),
(3, 2, 2, 30, '2025-10-01'),
(4, 2, 4, 2, '2025-10-03'),
(5, 3, 5, 5, '2025-10-04'),
(6, 3, 6, 100, '2025-10-05'),
(7, 4, 7, 3, '2025-10-06'),
(8, 4, 8, 2, '2025-10-07'),
(9, 5, 9, 50, '2025-10-08'),
(10, 5, 10, 100, '2025-10-09'),
(11, 6, 1, 20, '2025-10-10'),
(12, 6, 4, 3, '2025-10-11');
select * from user_activities

GO
insert into [dbo].[projects] values
(1, 'Solar Roof Initiative', 1, 'Install solar panels in schools'),
(2, 'Urban Bicycle Campaign', 2, 'Promote bicycle use in cities'),
(3, 'Waste Segregation Drive', 3, 'Community waste management project'),
(4, 'Plant-Based Meal Week', 4, 'Promote plant-based meals in offices'),
(5, 'Water Saving Campaign', 5, 'Awareness on water conservation'),
(6, 'Plastic Recycling Program', 6, 'Local plastic recycling centers'),
(7, 'Energy-Efficient Lighting', 7, 'Replace bulbs with energy-saving LEDs'),
(8, 'Tree Plantation Drive', 8, 'Plant trees in public parks'),
(9, 'Minimal Plastic Lifestyle', 9, 'Reduce single-use plastic usage'),
(10, 'Environmental Workshop', 10, 'Conduct environmental awareness workshops'),
(11, 'Solar Water Heaters', 1, 'Install solar water heating systems in homes'),
(12, 'Public Transport Awareness', 2, 'Promote bus and train usage to reduce car travel');
select * from projects
GO
insert into [dbo].[donations] values
(1, 1, 1, 8000, '2025-10-07'),   
(2, 1, 11, 5000, '2025-10-08'),  
(3, 2, 2, 6000, '2025-10-09'),   
(4, 2, 12, 4500, '2025-10-10'),  
(5, 1, 1, 3000, '2025-10-12'),   
(6, 3, 8, 5000, '2025-10-13'),
(7, 2, 2, 4000, '2025-10-14'),   
(8, 3, 3, 3500, '2025-10-15');
select * from donations
GO
insert into [dbo].[project_impact] values
(1, 1, 'Solar panels installed in schools', 1200.50, '2025-10-17'),  
(2, 11, 'Solar water heaters installed in homes', 800.75, '2025-10-18'),  
(3, 2, 'Promoted bicycle use in city', 950.00, '2025-10-09'),  
(4, 12, 'Public transport awareness campaigns', 700.25, '2025-10-10'),  
(5, 1, 'Additional solar panels in schools', 450.30, '2025-10-12'),  
(6, 8, 'Tree plantation drive impact', 600.00, '2025-10-13'),  
(7, 2, 'Extended bicycle campaign', 400.50, '2025-10-16'),  
(8, 3, 'Community waste management improvements', 550.80, '2025-10-15'),
(9, 4, 'Plant-based meals promoted in offices', 300.50, '2025-10-19'),
(10, 5, 'Water conservation awareness campaign', 150.00, '2025-10-20'),
(11, 6, 'Plastic recycling centers operational', 400.25, '2025-10-21'),
(12, 7, 'Energy-efficient lighting installed in offices', 250.75, '2025-10-22'),
(13, 9, 'Reduced single-use plastic in community', 180.00, '2025-10-23'),
(14, 10, 'Environmental workshops conducted', 220.50, '2025-10-24');
select *  from project_impact

GO
insert into [dbo].[category_statistics] values
(1, 1, 0.18, 2, '2025-10-17'),  
(2, 2, 30.14, 4, '2025-10-17'),  
(3, 3, 6.00, 1, '2025-10-17'),   
(4, 4, 27.00, 1, '2025-10-17'),  
(5, 5, 0.35, 1, '2025-10-17'),   
(6, 6, 0.10, 1, '2025-10-17'),   
(7, 7, 90.00, 1, '2025-10-17'),  
(8, 8, 0, 1, '2025-10-17'),      
(9, 9, 1.80, 1, '2025-10-17');   
select *  from category_statistics

GO
insert into [dbo].[goals] values
(1, 1, 'Reduce Car Travel CO2', 50.00, '2025-10-01', '2025-12-31'),
(2, 1, 'Install Solar Panels', 100.00, '2025-10-01', '2025-12-31'),
(3, 2, 'Use Public Transport', 200.00, '2025-10-01', '2025-12-31'),
(4, 3, 'Reduce Plastic Waste', 15.00, '2025-10-01', '2025-12-31'),
(5, 4, 'Adopt Plant-Based Meals', 20.00, '2025-10-01', '2025-12-31'),
(6, 5, 'Reduce Paper Use', 30.00, '2025-10-01', '2025-12-31'),
(7, 6, 'Reduce Electricity Usage', 100.00, '2025-10-01', '2025-12-31'),
(8, 7, 'Plant Trees', 50.00, '2025-10-01', '2025-12-31'),
(9, 8, 'Minimize Plastic Orders', 25.00, '2025-10-01', '2025-12-31'),
(10, 9, 'Promote Environmental Awareness', 0, '2025-10-01', '2025-12-31');
select *  from goals

GO
insert into [dbo].[rewards] values
(1, 'Tree Planter Badge', 500),
(2, 'Eco Warrior Badge', 1000),
(3, 'Water Saver Badge', 700),
(4, 'Carbon Reducer Badge', 1200),
(5, 'Public Transport Hero', 900),
(6, 'Solar Supporter', 1500),
(7, 'Recycling Champion', 800),
(8, 'Green Volunteer', 600),
(9, 'Sustainability Star', 2000),
(10, 'Planet Protector Medal', 2500);
select *  from rewards

GO
insert into [dbo].[user_rewards] values
(1, 1, 1, '2025-10-10'),   
(2, 1, 2, '2025-10-12'),   
(3, 2, 3, '2025-10-13'),   
(4, 3, 7, '2025-10-14'),  
(5, 3, 8, '2025-10-15'),   
(6, 4, 4, '2025-10-16'),   
(7, 5, 5, '2025-10-17'),   
(8, 6, 6, '2025-10-18'),   
(9, 7, 9, '2025-10-19'),   
(10, 8, 10, '2025-10-20'), 
(11, 2, 2, '2025-10-21'),  
(12, 5, 1, '2025-10-22');
select *  from user_rewards

GO
insert into [dbo].[reports] values
(1, 1, 'October 2025', 520.75),
(2, 2, 'October 2025', 610.50),
(3, 3, 'October 2025', 430.25),
(4, 4, 'October 2025', 480.60),
(5, 5, 'October 2025', 395.40),
(6, 6, 'October 2025', 505.80),
(7, 7, 'October 2025', 370.20),
(8, 8, 'October 2025', 440.35),
(9, 9, 'October 2025', 460.90),
(10, 10, 'October 2025', 415.00);
select *  from reports

GO
insert into [dbo].[report_goals] values
(1, 1),  
(1, 2),  
(2, 3),  
(3, 4),  
(4, 5),  
(5, 6),  
(6, 7), 
(7, 8),
(8, 9),
(9, 10), 
(10, 6), 
(10, 1);
select *  from report_goals

GO
insert into emissions_log (log_id, co2_emission)
select ua.log_id, ua.quantity * a.emission_factor
from user_activities ua
join activities a on ua.activity_id = a.activity_id;
select *  from emissions_log

--Shows all user names--
select name
from users;

--Displays each city only once (no duplicates)--
select distinct location 
from users;

--Displays every column and row in the activities table--
select * from activities

--Shows users who live in Dhaka--
select name, email 
from users 
where location = 'Dhaka';

--each user’s name along with the activity_id they performed--
select name, activity_id
from users, user_activities
where users.user_id = user_activities.user_id;

--NULL checking--
select name
from users
where location is null;

--Finds users whose name contains the letter i--
select name 
from users 
where name like '%i%';

--Ordering by join date--
select name, email, location, join_date
from users
order by join_date desc;

--between operation--
select user_id, activity_id, quantity, activity_date
from user_activities
where quantity between 10 and 50;

--Union operation--
(select project_name from projects where category_id = 1)
union
(select project_name from projects where category_id = 2);

--Intersect operation--
(select user_id from user_activities where quantity between 10 and 50)
intersect
(select user_id from user_activities where quantity between 30 and 100);

--Except operation--
(select user_id from user_activities where quantity > 20)
except
(select user_id from user_activities where quantity > 50);

GO
--count — number of activities per user--
select user_id, count(activity_id) as total_activities
from user_activities
group by user_id;

GO 
--kon user kon project e ki poriman donate kortese--
select u.name as donor_name, p.project_name, d.amount, d.donation_date
from donations d
join users u on d.user_id = u.user_id
join projects p on d.project_id = p.project_id
order by d.donation_date desc;

GO
--Maximum donation per user--
select u.name as donor_name, max(d.amount) as max_donation
from users u
join donations d on u.user_id = d.user_id
group by u.name;


GO
--avg — average donation amount--
select avg(amount) as average_donation
from donations;

GO
--Ranks users from highest to lowest donor.--
select user_id, sum(amount) as total_donated
from donations
group by user_id;

GO
--total CO2 saved per project--
select project_name, 
  (select sum(co2_saved) 
  from project_impact pi 
  where pi.project_id = p.project_id) as total_co2_saved
from projects p
order by total_co2_saved desc;

GO
--View each user’s goals and their target emissions--
select u.user_id, u.name, g.goal_name, g.target_value, g.start_date, g.end_date
from users u
join goals g on u.user_id = g.user_id;

GO
--SUM — Total CO2 emissions for all users--
select sum(total_emissions) as Total_CO2_Emissions
from reports;

GO
--Average CO₂ Emission for All Users--
select avg(e.co2_emission) as average_co2_emission
from emissions_log e;

GO
--Total Emission per User--
select u.name, sum(e.co2_emission) as total_emission
from users u
join user_activities ua on u.user_id = ua.user_id
join emissions_log e on ua.log_id = e.log_id
group by u.name
order by total_emission desc;

GO
--Maximum CO₂ Emission per User--
select u.name as user_name, max(e.co2_emission) as max_emission
from users u
join user_activities ua on u.user_id = ua.user_id
join emissions_log e on ua.log_id = e.log_id
group by u.name
order by max_emission desc;

GO
--Minimum CO₂ emission per user--
select u.name as user_name, min(e.co2_emission) as min_emission
from users u
join user_activities ua on u.user_id = ua.user_id
join emissions_log e on ua.log_id = e.log_id
group by u.name;

GO
--Users who participated in activities of more than one category--
select u.name,
count(distinct a.category_id) as categories_involved
from users u
join user_activities ua on u.user_id = ua.user_id
join activities a on ua.activity_id = a.activity_id
group by u.name
having count(distinct a.category_id) > 1;

--Update query--
update user_activities
set quantity = quantity * 1.10
where quantity < 50;
select * from user_activities

--Deletion query--
delete from emissions_log
where co2_emission < (select avg(co2_emission) from emissions_log);

GO
--Trigger: Auto-calculate CO₂ when new activity is added--
create trigger trg_addemission
on user_activities
after insert
as
begin
    insert into emissions_log(log_id, co2_emission)
    select 
        i.log_id,
        i.quantity * a.emission_factor
    from inserted i
    join activities a on i.activity_id = a.activity_id;
end;

insert into user_activities (log_id, user_id, activity_id, quantity, activity_date)
values (13, 2, 1, 10, '2025-10-22')

select * from user_activities
select * from emissions_log


GO
--View: Emissions by Activity--
CREATE VIEW vw_ActivityEmissions AS
SELECT 
    a.activity_name,
    SUM(e.co2_emission) AS total_emission
FROM activities a
JOIN user_activities ua ON a.activity_id = ua.activity_id
JOIN emissions_log e ON ua.log_id = e.log_id
GROUP BY a.activity_name;

SELECT * FROM vw_ActivityEmissions
order by total_emission asc;

insert into user_activities (log_id, user_id, activity_id, quantity, activity_date)
values (14, 3, 2, 20, '2025-10-22');







