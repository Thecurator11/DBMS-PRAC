# MongoDB - COMPLETE BEGINNER'S GUIDE FOR DBMS PRACTICAL EXAM

## **PART 1: MONGODB BASICS & INSTALLATION ON UBUNTU**

### What is MongoDB?
- **MongoDB** is a NoSQL (Not Only SQL) database management system.
- It stores data in **JSON-like documents** (called BSON - Binary JSON) instead of traditional tables with rows and columns.
- It's flexible, scalable, and perfect for handling unstructured data.
- Great for storing complex nested data structures.

### Key Differences: SQL vs MongoDB

| Feature | SQL (MySQL) | MongoDB |
|---------|-----------|---------|
| Data Structure | Tables with rows/columns | Collections with documents |
| Data Format | Structured rows | JSON-like documents (BSON) |
| Primary Key | PRIMARY KEY | _id (automatic) |
| Foreign Key | FOREIGN KEY | Manual references |
| Query Language | SQL | MongoDB Query Language |
| Flexibility | Fixed schema | Flexible schema |

---

## **PART 2: INSTALLATION ON UBUNTU**

### Step 1: Update System
```bash
sudo apt-get update
sudo apt-get upgrade
```

### Step 2: Install MongoDB Community Edition
```bash
# Import the GPG key
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

# Add MongoDB repository
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# Update and install MongoDB
sudo apt-get update
sudo apt-get install -y mongodb-org
```

### Step 3: Start MongoDB Service
```bash
# Start MongoDB
sudo systemctl start mongod

# Enable MongoDB to start on boot
sudo systemctl enable mongod

# Check status
sudo systemctl status mongod
```

### Step 4: Access MongoDB Shell
```bash
# Open MongoDB interactive shell
mongosh

# Or older version
mongo
```

---

## **PART 3: BASIC MONGODB COMMANDS**

### 1. View All Databases
```javascript
show dbs
```

### 2. Create/Use a Database
```javascript
use practice_db
// This creates the database if it doesn't exist
```

### 3. Check Current Database
```javascript
db
// Returns the currently active database
```

### 4. Create a Collection (like a table in SQL)
```javascript
db.createCollection("employees")
// Or it auto-creates when you insert data
```

### 5. View All Collections in Current Database
```javascript
show collections
```

### 6. Insert Documents (like inserting rows in SQL)
```javascript
// Single document insert
db.employees.insertOne({
    employee_id: 1,
    first_name: "John",
    last_name: "Doe",
    department: "IT",
    salary: 60000,
    hire_date: "2021-05-15",
    position: "Software Engineer"
})

// Multiple documents insert
db.employees.insertMany([
    {
        employee_id: 2,
        first_name: "Jane",
        last_name: "Smith",
        department: "HR",
        salary: 55000,
        hire_date: "2020-03-10",
        position: "HR Specialist"
    },
    {
        employee_id: 3,
        first_name: "Alex",
        last_name: "Johnson",
        department: "IT",
        salary: 70000,
        hire_date: "2019-09-22",
        position: "DevOps Engineer"
    }
])
```

### 7. Find/Read Documents (SELECT in SQL)
```javascript
// Find all documents
db.employees.find()

// Find with pretty formatting
db.employees.find().pretty()

// Find specific documents
db.employees.find({department: "IT"})

// Find with multiple conditions
db.employees.find({department: "IT", salary: {$gt: 50000}})
```

### 8. Update Documents (UPDATE in SQL)
```javascript
// Update single document
db.employees.updateOne(
    {employee_id: 1},
    {$set: {salary: 65000}}
)

// Update multiple documents
db.employees.updateMany(
    {department: "IT"},
    {$set: {salary: 75000}}
)
```

### 9. Delete Documents (DELETE in SQL)
```javascript
// Delete single document
db.employees.deleteOne({employee_id: 6})

// Delete multiple documents
db.employees.deleteMany({department: "Finance"})
```

### 10. Drop Collection (DROP TABLE in SQL)
```javascript
db.employees.drop()
```

### 11. Drop Database
```javascript
db.dropDatabase()
```

---

## **PART 4: MONGODB QUERY OPERATORS**

### Comparison Operators
```javascript
$eq     // Equal to
$ne     // Not equal to
$gt     // Greater than
$gte    // Greater than or equal
$lt     // Less than
$lte    // Less than or equal
$in     // In array
$nin    // Not in array
```

### Logical Operators
```javascript
$and    // AND condition
$or     // OR condition
$not    // NOT condition
$nor    // NOR condition
```

### Array Operators
```javascript
$push       // Add to array
$pull       // Remove from array
$addToSet   // Add to array if not exists
```

### Examples:
```javascript
// Find employees with salary > 50000
db.employees.find({salary: {$gt: 50000}})

// Find employees in IT or HR
db.employees.find({department: {$in: ["IT", "HR"]}})

// Find employees with salary > 50000 AND department = IT
db.employees.find({
    $and: [
        {salary: {$gt: 50000}},
        {department: "IT"}
    ]
})
```

---

## **PART 5: AGGREGATION (GROUP BY in SQL)**

### Basic Aggregation Framework
```javascript
// Count employees in each department
db.employees.aggregate([
    {$group: {_id: "$department", count: {$sum: 1}}}
])

// Calculate average salary by department
db.employees.aggregate([
    {$group: {_id: "$department", avgSalary: {$avg: "$salary"}}}
])

// Find highest salary in each department
db.employees.aggregate([
    {$group: {_id: "$department", maxSalary: {$max: "$salary"}}}
])

// Sort results
db.employees.aggregate([
    {$group: {_id: "$department", avgSalary: {$avg: "$salary"}}},
    {$sort: {avgSalary: -1}}  // -1 for descending, 1 for ascending
])
```

---

## **PART 6: PRACTICAL DBMS QUESTIONS WITH MONGODB**

### **Q19: MongoDB - Employee Questions**

**Sample Data - Employee Collection:**
```javascript
db.employees.insertMany([
    {employee_id: 1, first_name: "John", last_name: "Doe", department: "IT", salary: 60000, hire_date: "2021-05-15", position: "Software Engineer"},
    {employee_id: 2, first_name: "Jane", last_name: "Smith", department: "HR", salary: 55000, hire_date: "2020-03-10", position: "HR Specialist"},
    {employee_id: 3, first_name: "Alex", last_name: "Johnson", department: "IT", salary: 70000, hire_date: "2019-09-22", position: "DevOps Engineer"},
    {employee_id: 4, first_name: "Emily", last_name: "Davis", department: "Finance", salary: 80000, hire_date: "2021-02-18", position: "Analyst"},
    {employee_id: 5, first_name: "David", last_name: "Duck", department: "IT", salary: 40000, hire_date: "2020-06-05", position: "Software Engineer"},
    {employee_id: 6, first_name: "Don", last_name: "Dev", department: "Finance", salary: 90000, hire_date: "2019-08-03", position: "Developer"}
])
```

**Q19 Solutions:**

1. **Find All Employees**
   ```javascript
   db.employees.find().pretty()
   ```

2. **Find Employees in IT Department**
   ```javascript
   db.employees.find({department: "IT"})
   ```

3. **Find Employees in Finance Department with Salary Greater Than 85000**
   ```javascript
   db.employees.find({
       $and: [
           {department: "Finance"},
           {salary: {$gt: 85000}}
       ]
   })
   ```

4. **Count Number of Employees in Each Department**
   ```javascript
   db.employees.aggregate([
       {$group: {_id: "$department", count: {$sum: 1}}}
   ])
   ```

5. **Calculate Average Salary in Each Department**
   ```javascript
   db.employees.aggregate([
       {$group: {_id: "$department", avgSalary: {$avg: "$salary"}}}
   ])
   ```

6. **Find Employees Hired After 2020-06-01**
   ```javascript
   db.employees.find({hire_date: {$gt: "2020-06-01"}})
   ```

7. **Update Salary of All Employees in IT Department by Adding 5000**
   ```javascript
   db.employees.updateMany(
       {department: "IT"},
       {$inc: {salary: 5000}}
   )
   ```

8. **Delete Employee Record by employee_id=6**
   ```javascript
   db.employees.deleteOne({employee_id: 6})
   ```

9. **Find Highest Salary in Each Department**
   ```javascript
   db.employees.aggregate([
       {$group: {_id: "$department", maxSalary: {$max: "$salary"}}}
   ])
   ```

10. **Count Employees in Each Department with More Than 1 Employee**
    ```javascript
    db.employees.aggregate([
        {$group: {_id: "$department", count: {$sum: 1}}},
        {$match: {count: {$gt: 1}}}
    ])
    ```

---

### **Q20: MongoDB - Student Questions**

**Sample Data - Student Collection:**
```javascript
db.students.insertMany([
    {student_id: 1, first_name: "John", last_name: "Doe", age: 20, grade: "A", major: "Computer Science"},
    {student_id: 2, first_name: "Jane", last_name: "Smith", age: 21, grade: "B", major: "Mathematics"},
    {student_id: 3, first_name: "Alex", last_name: "Johnson", age: 22, grade: "A", major: "Physics"},
    {student_id: 4, first_name: "Emily", last_name: "Davis", age: 23, grade: "C", major: "Biology"},
    {student_id: 5, first_name: "David", last_name: "Duck", age: 21, grade: "B", major: "Mathematics"},
    {student_id: 6, first_name: "Don", last_name: "Dev", age: 22, grade: "A", major: "Mathematics"}
])
```

**Q20 Solutions:**

1. **Find All Students**
   ```javascript
   db.students.find().pretty()
   ```

2. **Find Students in Computer Science Major**
   ```javascript
   db.students.find({major: "Computer Science"})
   ```

3. **Count Number of Students in Each Major**
   ```javascript
   db.students.aggregate([
       {$group: {_id: "$major", count: {$sum: 1}}}
   ])
   ```

4. **Find Students with Grade A**
   ```javascript
   db.students.find({grade: "A"})
   ```

5. **Count Students in Each Grade Having More Than 2 Students**
   ```javascript
   db.students.aggregate([
       {$group: {_id: "$grade", count: {$sum: 1}}},
       {$match: {count: {$gt: 2}}}
   ])
   ```

6. **List Students Ordered by Age**
   ```javascript
   db.students.find().sort({age: 1})  // 1 for ascending
   ```

7. **Update Student's Major (Emily to Geology)**
   ```javascript
   db.students.updateOne(
       {first_name: "Emily"},
       {$set: {major: "Geology"}}
   )
   ```

8. **Find Oldest Student**
   ```javascript
   db.students.find().sort({age: -1}).limit(1)  // -1 for descending
   ```

9. **Find Youngest Student**
   ```javascript
   db.students.find().sort({age: 1}).limit(1)
   ```

10. **Delete Student Record by student_id=6**
    ```javascript
    db.students.deleteOne({student_id: 6})
    ```

---

### **Q21: MongoDB - Employee Department Questions**

**Sample Data - Employee Collection:**
```javascript
db.employees_dept.insertMany([
    {emp_id: 1, emp_name: "Anuja", dept_name: "Comp", salary: 20000, gender: "F"},
    {emp_id: 2, emp_name: "Khushi", dept_name: "Comp", salary: 40000, gender: "M"},
    {emp_id: 3, emp_name: "Jayesh", dept_name: "IT", salary: 30000, gender: "F"},
    {emp_id: 4, emp_name: "Lokesh", dept_name: "IT", salary: 60000, gender: "M"},
    {emp_id: 5, emp_name: "Bhushan", dept_name: "ETC", salary: 50000, gender: "F"},
    {emp_id: 6, emp_name: "Manisha", dept_name: "ETC", salary: 90000, gender: "M"}
])
```

**Q21 Solutions:**

1. **Display All Records**
   ```javascript
   db.employees_dept.find().pretty()
   ```

2. **Display Different Department Names Through Aggregation**
   ```javascript
   db.employees_dept.aggregate([
       {$group: {_id: "$dept_name"}}
   ])
   ```

3. **Find Department Wise Total Employees**
   ```javascript
   db.employees_dept.aggregate([
       {$group: {_id: "$dept_name", total_employees: {$sum: 1}}}
   ])
   ```

4. **Find Department Wise Total Salary**
   ```javascript
   db.employees_dept.aggregate([
       {$group: {_id: "$dept_name", total_salary: {$sum: "$salary"}}}
   ])
   ```

5. **Find Department Wise Total Salary of Female Employees**
   ```javascript
   db.employees_dept.aggregate([
       {$match: {gender: "F"}},
       {$group: {_id: "$dept_name", total_salary: {$sum: "$salary"}}}
   ])
   ```

6. **Find Department Wise Count of Male Employees**
   ```javascript
   db.employees_dept.aggregate([
       {$match: {gender: "M"}},
       {$group: {_id: "$dept_name", male_count: {$sum: 1}}}
   ])
   ```

7. **Find Total Male Employees**
   ```javascript
   db.employees_dept.find({gender: "M"}).count()
   // Or
   db.employees_dept.aggregate([
       {$match: {gender: "M"}},
       {$group: {_id: null, total_male: {$sum: 1}}}
   ])
   ```

8. **Find Minimum Salary in the Institute**
   ```javascript
   db.employees_dept.aggregate([
       {$group: {_id: null, min_salary: {$min: "$salary"}}}
   ])
   ```

9. **Find Maximum Salary in Comp Department**
   ```javascript
   db.employees_dept.aggregate([
       {$match: {dept_name: "Comp"}},
       {$group: {_id: null, max_salary: {$max: "$salary"}}}
   ])
   ```

10. **Find All Male Employees Sorted in Ascending Order by Employee Name**
    ```javascript
    db.employees_dept.find({gender: "M"}).sort({emp_name: 1})
    ```

---

### **Q22: MongoDB - Map-Reduce (Advanced)**

**Map-Reduce for Total Salary, Max Salary, Min Salary:**

```javascript
// Total Salary using Map-Reduce
db.employees_dept.mapReduce(
    function() { emit(null, this.salary); },
    function(key, values) { return Array.sum(values); },
    {out: "salary_total"}
)

// Max Salary using Map-Reduce
db.employees_dept.mapReduce(
    function() { emit(null, this.salary); },
    function(key, values) { return Math.max(...values); },
    {out: "salary_max"}
)

// Min Salary using Map-Reduce
db.employees_dept.mapReduce(
    function() { emit(null, this.salary); },
    function(key, values) { return Math.min(...values); },
    {out: "salary_min"}
)

// View results
db.salary_total.find()
db.salary_max.find()
db.salary_min.find()
```

---

## **IMPORTANT TIPS FOR MONGODB PRACTICAL EXAM**

1. **Always use `.pretty()`** for readable output
2. **Remember `_id` is auto-generated** if not specified
3. **Use `$match` before `$group`** for better performance
4. **`$sum: 1`** counts documents (like COUNT(*) in SQL)
5. **`$avg`, `$max`, `$min`** work just like SQL aggregate functions
6. **`updateMany` vs `updateOne`** - use appropriate method
7. **Array operations** - use `$push`, `$pull`, `$addToSet`
8. **Always export/backup** your collections before deletion
9. **Use proper data types** - dates as strings or Date objects
10. **Index important fields** for performance - `db.collection.createIndex({field: 1})`

---

## **QUICK COMMAND REFERENCE**

| Task | SQL | MongoDB |
|------|-----|---------|
| Create Database | CREATE DATABASE | use db_name |
| Create Table | CREATE TABLE | db.createCollection() |
| Insert | INSERT INTO | db.collection.insertOne/Many |
| Select All | SELECT * | db.collection.find() |
| Select Where | SELECT WHERE | db.collection.find({condition}) |
| Update | UPDATE SET | db.collection.updateOne/Many |
| Delete | DELETE FROM | db.collection.deleteOne/Many |
| Count | COUNT(*) | find().count() or $sum: 1 |
| Average | AVG() | $avg in aggregation |
| Group By | GROUP BY | $group in aggregation |

**Good luck with your MongoDB practical exam!**