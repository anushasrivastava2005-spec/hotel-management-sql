# 🏨 Hotel Management Database System

> A structured SQL-based solution to manage hotel operations — bookings, payments, staff, services, and guest analytics — using normalized relational database design.

---

## 📌 Problem Statement

Hotels generate large volumes of transactional data daily — guest check-ins, room assignments, service requests, payments, and staff records. Without a structured database system, this data is:

- Scattered across spreadsheets or isolated systems
- Difficult to query for business decisions (revenue trends, occupancy rates, guest behavior)
- Prone to redundancy and inconsistency
- Unable to support real-time reporting or performance tracking

**This project addresses these challenges by designing a fully normalized relational database that centralizes hotel data and enables efficient querying for operational and analytical use cases.**

---

## ✅ Solution

A **MySQL-based Hotel Management System** with:

- **9 normalized tables** covering all hotel operations
- **Complex SQL queries** for real-time reporting
- **CTEs, Subqueries, and Window Functions** for analytics
- **Stored Procedures & Views** for reusable logic and simplified access
- **Sample dataset** to demonstrate all query outputs

---

## 📁 Project Structure

```
hotel-management-sql/
│
├── schema/
│   └── create_tables.sql        # All table definitions with constraints & FKs
│
├── data/
│   └── sample_data.sql          # Realistic sample inserts (guests, rooms, bookings, payments)
│
├── queries/
│   ├── basic_reports.sql        # Core queries: availability, revenue, occupancy
│   ├── advanced_analytics.sql   # CTEs, subqueries, multi-table JOINs
│   ├── 
│
├── docs/
│   └── ER_diagram.png           # Entity-Relationship diagram (see below)
│
└── README.md
```

---

## 🗃️ Database Schema

### Tables Overview

| Table | Description |
|---|---|
| `guests` | Guest personal details and ID proof |
| `room_categories` | Room types (Standard, Deluxe, Suite, Presidential) with pricing |
| `rooms` | Individual room records with floor, status, and category |
| `staff` | Staff records with role and department |
| `bookings` | Core booking records linking guests, rooms, and staff |
| `payments` | Payment records for each booking |
| `services` | Hotel add-ons (food, spa, laundry, transport) |
| `guest_services` | Service requests made during a booking |
| `feedback` | Guest ratings and comments per booking |

### Entity-Relationship Diagram

```
guests ──────< bookings >────── rooms ──── room_categories
                  │
              payments
                  │
          guest_services >──── services
                  │
              feedback
              
staff ──────< bookings
```

---

## 🔑 Key SQL Concepts Demonstrated

### 1. Normalized Schema Design
- 3NF normalization across all 9 tables
- Foreign key constraints for referential integrity
- ENUM types for controlled categorical data

### 2. Basic Queries (`basic_reports.sql`)
- Available rooms with price and amenities
- Full booking details with multi-table JOINs
- Total revenue per booking (room + services)
- Occupancy rate summary
- Monthly revenue aggregation

### 3. Advanced Analytics (`advanced_analytics.sql`)
- **CTE** — Top 3 highest-spending guests
- **Subquery** — Guests with longer-than-average stays
- **LEFT JOIN** — Rooms never booked
- Revenue breakdown by booking source (Online, Walk-in, Agent)
- Repeat guest identification


---

## 📊 Sample Business Questions Answered

| Business Question | Query File |
|---|---|
| Which rooms are currently available and at what price? | `basic_reports.sql` |
| What is our total revenue this month? | `basic_reports.sql` |
| Who are our top 3 highest-spending guests? | `advanced_analytics.sql` |
| Which booking source brings in the most revenue? | `advanced_analytics.sql` |
|
| Which rooms have never been booked? | `advanced_analytics.sql` |
| What is the average rating per room category? | `advanced_analytics.sql` |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| MySQL 8.0 | Primary database |
| MySQL Workbench | Schema design & query execution |
| SQL | DDL, DML, Analytics |

---

## ▶️ How to Run

```bash
# Step 1: Log in to MySQL
mysql -u root -p

# Step 2: Create the database and tables
source schema/create_tables.sql

# Step 3: Insert sample data
source data/sample_data.sql

# Step 4: Run any query file
source queries/basic_reports.sql
source queries/advanced_analytics.sql

```

---

## 🎯 Skills Demonstrated (for Cognizant Application)

| Skill | Where Used |
|---|---|
| **Database/SQL** | All files |
| **Hands-on working knowledge** | Schema design, joins, aggregations |
| **Code programming** | Stored procedures, views, CTEs |
| **Data Analysis** | Window functions, revenue & occupancy analytics |
| **Normalization** | 9-table 3NF schema |
| **Business Reporting** | Monthly trends, guest segmentation, staff performance |

---

## 👤 Author

**Anusha Srivastava**  
B.Tech Computer Science — KIIT University, Bhubaneswar  
Data Science Intern — Megha AI, T-Hub Hyderabad  

---

## 📄 License

This project is for educational and portfolio purposes.
